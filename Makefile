# Run specific make target inside devcontainer, in case you don't want to
# install dependencies
container-%:
	docker build -f .devcontainer/Dockerfile -t isc-sdk-container .
	docker run --rm -v $(PWD):/src -w /src -u $$(id -u) isc-sdk-container make $* 

# Run lint on OpenAPI specification
spec-lint:
	vacuum lint -d ./api/spec.yml

go-gen:
	oapi-codegen --config=./go/client.cfg.yaml ./api/spec.yml
