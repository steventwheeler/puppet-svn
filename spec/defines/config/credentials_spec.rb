require 'spec_helper'

describe 'svn::config::credentials' do
  uuid = 'd3c8a345b14f6a1b42251aef8027ab57'
  user = 'user'

  let(:pre_condition) { %Q[
    class { 'svn::config':
      user => '#{user}',
    }
  ] }
  let(:title) { uuid }
  let(:params) {{
    :realmstring => '<https://svn.example.com:443> Committers',
    :username => 'brett',
    :password => 'PaSsWoRd',
  }}
  it "should create the simple auth credentials" do
    file = "/home/user/.subversion/auth/svn.simple/#{uuid}"
    should contain_file(file).with_owner(user)
      .with_content(%r[V 40])
      .with_content(%r[<https://svn.example.com:443> Committers])
      .with_content(%r[V 5])
      .with_content(%r[brett])
      .with_content(%r[V 8])
      .with_content(%r[PaSsWoRd])
  end
end
