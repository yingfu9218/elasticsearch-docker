FROM openjdk:8-jre
ENV ELASTICSEARCH_VERSION 6.8.0 
ARG ELASTICSEARCH_VERSION=6.8.0 
RUN  wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-"$ELASTICSEARCH_VERSION".tar.gz  -O elasticsearch.tar.gz
RUN  tar -zxvf elasticsearch.tar.gz
RUN  rm -f elasticsearch.tar.gz
RUN useradd elasticsearch
RUN mv elasticsearch-$ELASTICSEARCH_VERSION elasticsearch
RUN mkdir -p /elasticsearch/plugins/ik
RUN wget https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v$ELASTICSEARCH_VERSION/elasticsearch-analysis-ik-$ELASTICSEARCH_VERSION.zip
RUN unzip -o elasticsearch-analysis-ik-$ELASTICSEARCH_VERSION.zip -d /elasticsearch/plugins/ik/
RUN rm -f elasticsearch-analysis-ik-$ELASTICSEARCH_VERSION.zip
RUN chown -R elasticsearch:elasticsearch elasticsearch
USER elasticsearch
EXPOSE 9200
EXPOSE 9300
CMD ["/elasticsearch/bin/elasticsearch"]
