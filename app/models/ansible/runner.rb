module Ansible
  class Runner
    class << self
      def run(env_vars, extra_vars, playbook_path)
        run_via_cli(env_vars, extra_vars, playbook_path)
      end

      private

      def run_via_cli(env_vars, extra_vars, playbook_path)
        result = %x(#{format_env_vars(env_vars)} #{ansible_command} #{format_extra_vars(extra_vars)} #{playbook_path})
        JSON.parse(result)
      end

      def ansible_command
        # TODO add possibility to use custom path, e.g. from virtualenv
        "ansible-playbook"
      end

      def format_env_vars(env_vars)
        env_vars.map { |key, value| "#{key}='#{value}'" }.join(" ")
      end

      def format_extra_vars(extra_vars)
        "--extra-vars '#{JSON.dump(extra_vars)}'"
      end
    end
  end
end
