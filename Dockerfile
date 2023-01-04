# start by pulling the python image
FROM python:3.8-alpine
EXPOSE 5000

# copy the requirements file into the image
COPY ./requirements.txt /app/requirements.txt

# switch working directory
WORKDIR /app

# install the dependencies and packages in the requirements file
RUN pip install -r requirements.txt

# copy every content from the local file to the image
COPY . /app

# configure the container to run in an executed manner
ENTRYPOINT [ "python" ]

RUN pip install opentelemetry-distro
RUN pip install opentelemetry-exporter-otlp
RUN opentelemetry-bootstrap --action=install
#CMD OTEL_RESOURCE_ATTRIBUTES=service.name=sig-test-signoz OTEL_EXPORTER_OTLP_ENDPOINT="http://otelcollector-signoz-dev.pntrzz.com:80"  opentelemetry-instrument --traces_exporter otlp_proto_http view.py
CMD OTEL_RESOURCE_ATTRIBUTES=service.name=sig-test-signoz OTEL_EXPORTER_OTLP_ENDPOINT="http://otelcollector-signoz-dev.pntrzz.com:80"  opentelemetry-instrument --traces_exporter otlp_proto_http view.py

CMD ["view.py" ]
