Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 412997FEE42
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 12:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345193AbjK3LtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 06:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345175AbjK3LtH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 06:49:07 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A205B10CE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 03:49:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091EAC433C8;
        Thu, 30 Nov 2023 11:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701344949;
        bh=SDuxsjNsfCb28aE/m4f1ywlUx4T7oeJtWKHQzMJTHd0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R9E6RdTOG9mchODYv0jZtwonSjwnO2RfHhnZ2GJPmka1dPj48iIYcF0/OANzQHTOL
         SFha1Fgs9+P0tCfpHuww5fMyWCZVVdn3HrMKdlZkMR+lvVVSvwLD7+OWqUWnpFOVRn
         lOqpPvsHxTQlsyjbJ3c1BkvKg4HL73pCn+Tzryaccbmd3lFdzB6nIkdNQcuzHtfiDX
         8eKReq4+QtggfaJHUgSJO2G+4zxQdTrbgACfIR6K5CDUE+R326RVjhivm/qs+2oET8
         hC7aK+z5I3OM50PsespcUtX0s3kQgj3tNgfkN832ueRP3ub6LcofEaJLHLh3IY/YKa
         h9wgEb+QETKeg==
Message-ID: <6def78e7-8264-4745-94f3-b32b854af0c2@kernel.org>
Date:   Thu, 30 Nov 2023 13:49:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-7-rogerq@kernel.org>
 <20231120232620.uciap4bazypzlg3g@skbuf>
 <eeea995b-a294-4a46-aa3e-93fc2b274504@kernel.org>
 <20231121115314.deuvdjk64rcwktl4@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231121115314.deuvdjk64rcwktl4@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 21/11/2023 13:53, Vladimir Oltean wrote:
> On Tue, Nov 21, 2023 at 01:02:50PM +0200, Roger Quadros wrote:
>> Yes I'm using openlldp master.
>>
>> So I just dumped the "ethtool --show-mm" right before the "lldptool -i $h1 -t -n -V addEthCaps"
>> and this is what I see
>>
>> # MAC Merge layer state for eth0:
>> # pMAC enabled: on
>> # TX enabled: off
>> # TX active: off
>> # TX minimum fragment size: 252
>> # RX minimum fragment size: 124
>> # Verify enabled: off
>> # Verify time: 10
>> # Max verify time: 134
>> # Verification status: DISABLED
>> # 
>> # MAC Merge layer state for eth1:
>> # pMAC enabled: on
>> # TX enabled: off
>> # TX active: off
>> # TX minimum fragment size: 124
>> # RX minimum fragment size: 124
>> # Verify enabled: off
>> # Verify time: 10
>> # Max verify time: 134
>> # Verification status: DISABLED
>> # 
>> # Additional Ethernet Capabilities TLV
>> #       Preemption capability supported
>> #       Preemption capability not enabled
>> #       Preemption capability not active
>> #       Additional fragment size: 3 (252 octets)
>> # Additional Ethernet Capabilities TLV
>> #       Preemption capability supported
>> #       Preemption capability not enabled
>> #       Preemption capability not active
>> #       Additional fragment size: 1 (124 octets)
>> # Warning: Stopping lldpad.service, but it can still be activated by:
>> #   lldpad.socket
>> # TEST: LLDP                                                          [FAIL]
>>
>>
>> If I add the following lines at the beginning of lldp() routine,
>> then it works.
>>
>> lldp()
>> {
>>         RET=0
>>
>> +        ethtool --set-mm $h1 tx-enabled on verify-enabled on
>> +        ethtool --set-mm $h2 tx-enabled on verify-enabled on
>> ...
>> }
>>
>> Is lldp supposed to turn on tx-enabled and verify-enabled for us
>> or it is test scritps responsibility?
> 
> lldpad should absolutely do that.
> https://github.com/intel/openlldp/blob/master/lldp_8023.c#L701
> 
> Try to see what goes on and if there isn't, in fact, an error during the
> netlink communication with the kernel.
> 
> Edit /usr/local/lib/systemd/system/lldpad.service:
> ExecStart=/usr/local/sbin/lldpad -t -V 7
>                                    ~~~~~
>                                    increases log level
> Then run:
> 
> $ systemctl daemon-reload
> $ journalctl -u lldpad.service -f &
> $ ./ethtool_mm.sh eno0 swp0
> 
> During the test you should see:
> 
> lldpad[4764]: eno0: Link partner preemption capability supported
> lldpad[4764]: eno0: Link partner preemption capability not enabled
> lldpad[4764]: eno0: Link partner preemption capability not active
> lldpad[4764]: eno0: Link partner minimum fragment size: 252 octets
> lldpad[4764]: eno0: initiating MM verification with a retry interval of 127 ms...
> lldpad[4764]: rxProcessFrame: allocated TLV 0 was not stored! 0xaaaafd7cfbe0
> lldpad[4764]: swp0: Link partner preemption capability supported
> lldpad[4764]: swp0: Link partner preemption capability not enabled
> lldpad[4764]: swp0: Link partner preemption capability not active
> lldpad[4764]: swp0: Link partner minimum fragment size: 60 octets
> lldpad[4764]: swp0: initiating MM verification with a retry interval of 128 ms...
> lldpad[4764]: rxProcessFrame: allocated TLV 0 was not stored! 0xaaaafd7cfd30
> 

Thanks for the debug instructions. Indeed lldpad tries to enable MM TX and the
network drivers set_mm() hook gets called and returns success but still
lldpad sees some error.

I've also confirmed that ethnl_set_mm() runs successfully and returns 1.
I suppose something is going wrong in user-space with libnl?

Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability supported
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not enabled
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not active
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner minimum fragment size: 124 octets
Nov 21 11:50:02 am62xx lldpad[708]: eth0: initiating MM verification with a retry interval of 134 ms...
Nov 21 11:50:02 am62xx lldpad[708]: ethtool: kernel reports: integer out of range


full debug log is below.

-- 
cheers,
-roger


root@am62xx:~/kselftest# ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh
[  207.146038] kselftest: Running tests in net/forwarding
TAP version 13
1..1
# timeout set to 0
# selftests: net/forwarding: ethtool_mm.sh
# Error: Exclusivity flag on, cannot modify.
Nov 21 11:49:54 am62xx systemd[1]: Started lldpad.service - Link Layer Discovery Protocol Agent Daemon..
Nov 21 11:49:54 am62xx lldpad[708]: setsockopt nearest_bridge: Invalid argument
Nov 21 11:49:54 am62xx lldpad[708]: setsockopt nearest_bridge: Invalid argument
Nov 21 11:49:54 am62xx lldpad[708]: setsockopt nearest_bridge: Invalid argument
Nov 21 11:49:54 am62xx lldpad[708]: setsockopt nearest_bridge: Invalid argument
Nov 21 11:49:54 am62xx lldpad[708]: using fd 3 from systemd
Nov 21 11:49:54 am62xx lldpad[708]: event_iface_init_user_space(484): socket 4.
Nov 21 11:49:54 am62xx lldpad[708]: mand_register:done
Nov 21 11:49:54 am62xx lldpad[708]: basman_register:done
Nov 21 11:49:54 am62xx lldpad[708]: dcbx_register: dcbx register done
Nov 21 11:49:54 am62xx lldpad[708]: med_register:done
Nov 21 11:49:54 am62xx lldpad[708]: ieee8023_register:done
Nov 21 11:49:54 am62xx lldpad[708]: evb_register:done
Nov 21 11:49:54 am62xx lldpad[708]: evb22_register:done
Nov 21 11:49:54 am62xx lldpad[708]: vdp_register: done
Nov 21 11:49:54 am62xx lldpad[708]: vdp22_register:done
Nov 21 11:49:54 am62xx lldpad[708]: ecp22_register: done
Nov 21 11:49:54 am62xx lldpad[708]: ieee8021qaz_register: ieee8021qaz_register SUCCESS
Nov 21 11:49:54 am62xx lldpad[708]: can0 mac:00:00:00:00:00:00 perm:00:00:00:00:00:00 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: Failed to open register layer 2 access to ETH_P_LLDP
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: Error adding device can0
Nov 21 11:49:54 am62xx lldpad[708]: can1 mac:00:00:00:00:00:00 perm:00:00:00:00:00:00 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: Failed to open register layer 2 access to ETH_P_LLDP
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: Error adding device can1
Nov 21 11:49:54 am62xx lldpad[708]: can2 mac:00:00:00:00:00:00 perm:00:00:00:00:00:00 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: Failed to open register layer 2 access to ETH_P_LLDP
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: Error adding device can2
Nov 21 11:49:54 am62xx lldpad[708]: can3 mac:00:00:00:00:00:00 perm:00:00:00:00:00:00 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: Failed to open register layer 2 access to ETH_P_LLDP
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: Error adding device can3
Nov 21 11:49:54 am62xx lldpad[708]: eth0 mac:78:db:2f:e5:74:d3 perm:78:db:2f:e5:74:d3 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: eth0 MAC address is 78:db:2f:e5:74:d3
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth0.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth0 (01:80:C2:00:00:0E).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 0 agents on if eth0.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth0.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth0 (01:80:C2:00:00:03).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: agent->adminStatus = disabled.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 1 agents on if eth0.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth0.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth0 (01:80:C2:00:00:00).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: agent->adminStatus = disabled.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 2 agents on if eth0.
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade68e3f0.
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:49:54 am62xx lldpad[708]: mand_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:49:54 am62xx lldpad[708]: med_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: ieee8023_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: evb_ifup:eth0 agent 2 called
Nov 21 11:49:54 am62xx lldpad[708]: evb_init_tlv:eth0 agent 2 EVB tx is currently disabled
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth0 agent 2 loading EVB policy for fmode failed, using default (128)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth0 agent 2 loading EVB policy for capabilities failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth0 agent 2 loading EVB policy for rte failed, using default (15)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth0 agent 2 loading EVB policy for vsis failed, using default (3295)
Nov 21 11:49:54 am62xx lldpad[708]: evb_ifup:eth0 agent 2 added
Nov 21 11:49:54 am62xx lldpad[708]: evb22_ifup:eth0 agent 2 called
Nov 21 11:49:54 am62xx lldpad[708]: evb22_init_tlv:eth0 agent 2 EVB tx is currently disabled
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_string:eth0 agent 2 loading EVB policy for evbmode failed, using default (2)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_evbmode:eth0 agent 2 policy evbmode station(0x2)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for vdprwd failed, using default (20)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth0 agent 2 policy vdprwd 20
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for evbrrreq failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_rrreq:eth0 agent 2 policy evbrrreq false
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for evbgpid failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_gid:eth0 agent 2 policy evbgpid false
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for ecpretries failed, using default (3)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_retries:eth0 agent 2 policy ecpretries 3
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for ecprte failed, using default (8)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth0 agent 2 policy ecprte 8
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth0 agent 2 loading EVB policy for vdprka failed, using default (20)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth0 agent 2 policy vdprka 20
Nov 21 11:49:54 am62xx lldpad[708]: evb22_ifup:eth0 agent 2 added
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade68e320.
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:49:54 am62xx lldpad[708]: mand_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:49:54 am62xx lldpad[708]: med_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: ieee8023_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade68e250.
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:49:54 am62xx lldpad[708]: mand_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:49:54 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:49:54 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:49:54 am62xx lldpad[708]: med_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: ieee8023_ifup:port eth0 added
Nov 21 11:49:54 am62xx lldpad[708]: get_dcbx_hw: eth0: nlmsg_find_attr failed, no GDCBX support
Nov 21 11:49:54 am62xx lldpad[708]: eth1 mac:70:ff:76:1d:8d:c4 perm:70:ff:76:1d:8d:c4 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:54 am62xx lldpad[708]: eth1 MAC address is 70:ff:76:1d:8d:c4
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth1.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth1 (01:80:C2:00:00:0E).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 0 agents on if eth1.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth1.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth1 (01:80:C2:00:00:03).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: agent->adminStatus = disabled.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 1 agents on if eth1.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: creating new agent for port eth1.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: creating new agent for eth1 (01:80:C2:00:00:00).
Nov 21 11:49:54 am62xx lldpad[708]: lldp_init_agent: agent->adminStatus = disabled.
Nov 21 11:49:54 am62xx lldpad[708]: lldp_add_agent: 2 agents on if eth1.
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade6943b0.
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: mand_bld_ttl_tlv:eth1:done:type=3 length=2 ttl=120
Nov 21 11:49:54 am62xx lldpad[708]: mand_ifup:port eth1 added
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth1:Port Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysname_tlv:eth1:System Name disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth1:System Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth1:System Capabilities disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth1:Management Address disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_ifup:port eth1 added
Nov 21 11:49:54 am62xx lldpad[708]: med_bld_tlv:eth1:LLDP-MED is not enabled
Nov 21 11:49:54 am62xx lldpad[708]: med_ifup:port eth1 added
Nov 21 11:49:54 am62xx lldpad[708]: ieee8023_ifup:port eth1 added
Nov 21 11:49:54 am62xx lldpad[708]: evb_ifup:eth1 agent 2 called
Nov 21 11:49:54 am62xx lldpad[708]: evb_init_tlv:eth1 agent 2 EVB tx is currently disabled
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth1 agent 2 loading EVB policy for fmode failed, using default (128)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth1 agent 2 loading EVB policy for capabilities failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth1 agent 2 loading EVB policy for rte failed, using default (15)
Nov 21 11:49:54 am62xx lldpad[708]: evb_conf_string:eth1 agent 2 loading EVB policy for vsis failed, using default (3295)
Nov 21 11:49:54 am62xx lldpad[708]: evb_ifup:eth1 agent 2 added
Nov 21 11:49:54 am62xx lldpad[708]: evb22_ifup:eth1 agent 2 called
Nov 21 11:49:54 am62xx lldpad[708]: evb22_init_tlv:eth1 agent 2 EVB tx is currently disabled
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_string:eth1 agent 2 loading EVB policy for evbmode failed, using default (2)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_evbmode:eth1 agent 2 policy evbmode station(0x2)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for vdprwd failed, using default (20)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth1 agent 2 policy vdprwd 20
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for evbrrreq failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_rrreq:eth1 agent 2 policy evbrrreq false
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for evbgpid failed, using default (0)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_gid:eth1 agent 2 policy evbgpid false
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for ecpretries failed, using default (3)
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_retries:eth1 agent 2 policy ecpretries 3
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for ecprte failed, using default (8)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth1 agent 2 policy ecprte 8
Nov 21 11:49:54 am62xx lldpad[708]: evb22_conf_int:eth1 agent 2 loading EVB policy for vdprka failed, using default (20)
Nov 21 11:49:54 am62xx lldpad[708]: exponent:eth1 agent 2 policy vdprka 20
Nov 21 11:49:54 am62xx lldpad[708]: evb22_ifup:eth1 agent 2 added
Nov 21 11:49:54 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade6942e0.
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:54 am62xx lldpad[708]: mand_bld_ttl_tlv:eth1:done:type=3 length=2 ttl=120
Nov 21 11:49:54 am62xx lldpad[708]: mand_ifup:port eth1 added
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth1:Port Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysname_tlv:eth1:System Name disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth1:System Description disabled
Nov 21 11:49:54 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth1:System Capabilities disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth1:Management Address disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: med_bld_tlv:eth1:LLDP-MED is not enabled
Nov 21 11:49:55 am62xx lldpad[708]: med_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: ieee8023_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: init_ports: calling ifup for agent 0xaaaade694210.
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: mand_bld_ttl_tlv:eth1:done:type=3 length=2 ttl=120
Nov 21 11:49:55 am62xx lldpad[708]: mand_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth1:Port Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysname_tlv:eth1:System Name disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth1:System Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth1:System Capabilities disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth1:Management Address disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:49:55 am62xx lldpad[708]: Adapter eth1 does not support DCB.
Nov 21 11:49:55 am62xx lldpad[708]: med_bld_tlv:eth1:LLDP-MED is not enabled
Nov 21 11:49:55 am62xx lldpad[708]: med_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: ieee8023_ifup:port eth1 added
Nov 21 11:49:55 am62xx lldpad[708]: get_dcbx_hw: eth1: nlmsg_find_attr failed, no GDCBX support
Nov 21 11:49:55 am62xx lldpad[708]: eth2 mac:70:ff:76:1d:8d:c5 perm:70:ff:76:1d:8d:c5 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:55 am62xx lldpad[708]: eth2 MAC address is 70:ff:76:1d:8d:c5
Nov 21 11:49:55 am62xx lldpad[708]: eth3 mac:70:ff:76:1d:8d:c6 perm:70:ff:76:1d:8d:c6 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:55 am62xx lldpad[708]: eth3 MAC address is 70:ff:76:1d:8d:c6
Nov 21 11:49:55 am62xx lldpad[708]: eth4 mac:70:ff:76:1d:8d:c7 perm:70:ff:76:1d:8d:c7 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:55 am62xx lldpad[708]: eth4 MAC address is 70:ff:76:1d:8d:c7
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:49:55 am62xx lldpad[708]: evb22_start_modules:eth1 START role:2
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_start:eth1 start ecp
Nov 21 11:49:55 am62xx lldpad[708]: eth1 mac:70:ff:76:1d:8d:c4 perm:70:ff:76:1d:8d:c4 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:55 am62xx lldpad[708]: eth1 MAC address is 70:ff:76:1d:8d:c4
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_create:eth1 create ecp data
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_set_rx_state:eth1 state ECP22_RX_BEGIN
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_rx_change_state:eth1 state change ECP22_RX_BEGIN -> ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_es_wait:eth1 state ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_set_rx_state:eth1 state ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth1 state change ECP22_TX_BEGIN -> ECP22_TX_INIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth1 state ECP22_TX_INIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth1 state change ECP22_TX_INIT -> ECP22_TX_WAIT_FORREQ
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth1 state ECP22_TX_WAIT_FORREQ
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_es_waitforreq:eth1 seqno 0x1
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth1 state change ECP22_TX_WAIT_FORREQ -> ECP22_TX_WAIT_ONDATA
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth1 state ECP22_TX_WAIT_ONDATA
Nov 21 11:49:55 am62xx lldpad[708]: vdp22_start:eth1 start vdp
Nov 21 11:49:55 am62xx lldpad[708]: vdp22_create:eth1 role:2
Nov 21 11:49:55 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth1 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:49:55 am62xx lldpad[708]: mand_bld_ttl_tlv:eth1:done:type=3 length=2 ttl=120
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth1:Port Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysname_tlv:eth1:System Name disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth1:System Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth1:System Capabilities disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth1:Management Address disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_gettlv:eth1: failed
Nov 21 11:49:55 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:49:55 am62xx lldpad[708]: Adapter eth1 does not support DCB.
Nov 21 11:49:55 am62xx lldpad[708]: config.c: eth1 dcb mode is OFF.
Nov 21 11:49:55 am62xx lldpad[708]: med_bld_tlv:eth1:LLDP-MED is not enabled
Nov 21 11:49:55 am62xx lldpad[708]: med_gettlv:eth1: failed
Nov 21 11:49:55 am62xx lldpad[708]: evb22_start_modules:eth0 START role:2
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_start:eth0 start ecp
Nov 21 11:49:55 am62xx lldpad[708]: eth0 mac:78:db:2f:e5:74:d3 perm:78:db:2f:e5:74:d3 san:ff:ff:ff:ff:ff:ff
Nov 21 11:49:55 am62xx lldpad[708]: eth0 MAC address is 78:db:2f:e5:74:d3
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_create:eth0 create ecp data
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_set_rx_state:eth0 state ECP22_RX_BEGIN
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_rx_change_state:eth0 state change ECP22_RX_BEGIN -> ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_es_wait:eth0 state ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_set_rx_state:eth0 state ECP22_RX_WAIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth0 state change ECP22_TX_BEGIN -> ECP22_TX_INIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth0 state ECP22_TX_INIT
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth0 state change ECP22_TX_INIT -> ECP22_TX_WAIT_FORREQ
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth0 state ECP22_TX_WAIT_FORREQ
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_es_waitforreq:eth0 seqno 0x1
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_change_state:eth0 state change ECP22_TX_WAIT_FORREQ -> ECP22_TX_WAIT_ONDATA
Nov 21 11:49:55 am62xx lldpad[708]: ecp22_tx_run_sm:eth0 state ECP22_TX_WAIT_ONDATA
Nov 21 11:49:55 am62xx lldpad[708]: vdp22_start:eth0 start vdp
Nov 21 11:49:55 am62xx lldpad[708]: vdp22_create:eth0 role:2
Nov 21 11:49:55 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:49:55 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:49:55 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:49:55 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:49:55 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:49:55 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability supported
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not enabled
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner preemption capability not active
Nov 21 11:50:02 am62xx lldpad[708]: eth0: Link partner minimum fragment size: 124 octets
Nov 21 11:50:02 am62xx lldpad[708]: eth0: initiating MM verification with a retry interval of 134 ms...
Nov 21 11:50:02 am62xx lldpad[708]: ethtool: kernel reports: integer out of range
Nov 21 11:50:02 am62xx lldpad[708]: rxProcessFrame: allocated TLV 0 was not stored! 0xaaaade698510
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:50:02 am62xx lldpad[708]: arg_path "tlvid00120f07.addFragSize"
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:50:02 am62xx lldpad[708]: arg_path "tlvid00120f07.addFragSize"
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:50:02 am62xx lldpad[708]: arg_path "tlvid00120f07.addFragSize"
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:02 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:02 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:02 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:02 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:02 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:02 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:02 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
# Warning: Stopping lldpad.service, but it can still be activated by:
#   lldpad.socket
# TEST: LLDP                                                          [FAIL]
#       eth0 pMAC TX is not active
[  223.838009] am65-cpsw-nuss 46000000.ethernet eth0: Link is Down
# Error: Cannot delete qdisc with handle of zero.
not ok 1 selftests: net/forwarding: ethtool_mm.sh # exit=1
root@am62xx:~/kselftest# Nov 21 11:50:05 am62xx systemd[1]: Stopping lldpad.service - Link Layer Discovery Protocol Agent Daemon....
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:05 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: set_config_setting(577):
Nov 21 11:50:05 am62xx lldpad[708]: arg_path "tlvid00120f07.addFragSize"
Nov 21 11:50:05 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:05 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: eth0: Configured addFragSize (0) smaller than the minimum value requested by kernel (1). Using the latter
Nov 21 11:50:05 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:05 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: eth0: Configured addFragSize (0) smaller than the minimum value requested by kernel (1). Using the latter
Nov 21 11:50:05 am62xx lldpad[708]: mibConstrInfoLLDPDU: port eth0 mac 01:80:C2:00:00:0E type 0.
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_portdesc_tlv:eth0:Port Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysname_tlv:eth0:System Name disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_sysdesc_tlv:eth0:System Description disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_syscaps_tlv:eth0:System Capabilities disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_bld_manaddr_tlv:eth0:Management Address disabled
Nov 21 11:50:05 am62xx lldpad[708]: basman_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: med_bld_tlv:eth0:LLDP-MED is not enabled
Nov 21 11:50:05 am62xx lldpad[708]: med_gettlv:eth0: failed
Nov 21 11:50:05 am62xx lldpad[708]: eth0: Configured addFragSize (0) smaller than the minimum value requested by kernel (1). Using the latter
Nov 21 11:50:05 am62xx lldpad[708]: Signal 15 received - terminating
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth4 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth4 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: Send shutdown frame on port eth4
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth3 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth3 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: Send shutdown frame on port eth3
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth2 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth2 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: Send shutdown frame on port eth2
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth1 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth1 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: Send shutdown frame on port eth1
Nov 21 11:50:05 am62xx lldpad[708]: mibConstrShutdownLLDPDU: mac 01:80:C2:00:00:0E.
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth1:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: send_msg: sendto = 32
Nov 21 11:50:05 am62xx lldpad[708]: Adapter eth0 does not support DCB.
Nov 21 11:50:05 am62xx lldpad[708]: config.c: eth0 dcb mode is OFF.
Nov 21 11:50:05 am62xx lldpad[708]: Send shutdown frame on port eth0
Nov 21 11:50:05 am62xx lldpad[708]: mibConstrShutdownLLDPDU: mac 01:80:C2:00:00:0E.
Nov 21 11:50:05 am62xx lldpad[708]: mand_bld_ttl_tlv:eth0:done:type=3 length=2 ttl=120
Nov 21 11:50:05 am62xx lldpad[708]: mand_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: basman_unregister:done
Nov 21 1[  224.608232] am65-cpsw-nuss c000000.ethernet eth1: Link is Down
1:50:05 am62xx lldpad[708]: dcbx_unregister: unregister dcbx complete.
Nov 21 11:50:05 am62xx lldpad[708]: med_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: ieee8023_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: evb_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: evb22_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: vdp_unregister: done
Nov 21 11:50:05 am62xx lldpad[708]: vdp22_unregister:done
Nov 21 11:50:05 am62xx lldpad[708]: ecp22_remove:eth0 remove ecp
Nov 21 11:50:05 am62xx lldpad[708]: ecp22_remove:eth1 remove ecp
Nov 21 11:50:05 am62xx lldpad[708]: ecp22_unregister: done
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth4
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth4
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth3
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth3
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth2
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth2
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth1
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth1
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth0
Nov 21 11:50:05 am62xx lldpad[708]: In remove_port: Found port eth0
Nov 21 11:50:05 am62xx systemd[1]: lldpad.service: Deactivated successfully.
Nov 21 11:50:05 am62xx systemd[1]: Stopped lldpad.service - Link Layer Discovery Protocol Agent Daemon..

