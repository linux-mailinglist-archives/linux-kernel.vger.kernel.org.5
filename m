Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91FEF7BB7B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjJFMcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjJFMct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:32:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA1FB
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:32:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04511C433C8;
        Fri,  6 Oct 2023 12:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696595566;
        bh=61DYdc53aKk3vt7BSVcWpMssttdDG8L65eoi6rh4zxQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=JNGJGeeh/xb2lnmH/Z5KJ4/LKFvtvGVMmz/tk/DHO8sgDP4P5/642radicsHW28GK
         SfU6fOY5HV7BaSCwxg7wRnh1YiYbtbCmSx/uk0npL9lU/Tb0+6zbM/rnUmFHWDiLPk
         vo2Jw5CgOTzCPZP9HDg2kQvB9do7YCLuP48Ejn2MEk62Z0ObMVT47tDnBYtHXS1tCm
         t/xnJ44noa8fu1Ti5Id/9FsVSzZm7a7cSbaNHCfbjgj7sopoEf0ZLTWkBZyOtSVrN2
         eVoB7yl698z2RNrLSYesekc3QhWgycdwOVAkbVADcds5o+EtqmP9VScES/vswhkzOB
         C8O8hg/HRI3Dg==
Message-ID: <7b001e41-47b2-467e-b63c-b654b856c2e3@kernel.org>
Date:   Fri, 6 Oct 2023 15:32:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 3/4] net: ethernet: ti: am65-cpsw-qos: Add
 Frame Preemption MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-1-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
 <20230927072741.21221-4-rogerq@kernel.org>
 <20231005092943.q7no33k32thyo6y4@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231005092943.q7no33k32thyo6y4@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/10/2023 12:29, Vladimir Oltean wrote:
> On Wed, Sep 27, 2023 at 10:27:40AM +0300, Roger Quadros wrote:
>> Add driver support for viewing / changing the MAC Merge sublayer
>> parameters and seeing the verification state machine's current state
>> via ethtool.
>>
>> As hardware does not support interrupt notification for verification
>> events we resort to polling on link up. On link up we try a couple of
>> times for verification success and if unsuccessful then give up.
>>
>> The Frame Preemption feature is described in the Technical Reference
>> Manual [1] in section:
>> 	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)
>>
>> Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.
>>
>> [1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
>> [2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf
>>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 150 ++++++++++++
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c     | 240 ++++++++++++++++----
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h     | 104 +++++++++
>>  5 files changed, 454 insertions(+), 47 deletions(-)
>>
>> Changelog:
>> v5:
>> - No change
>>
>> v4:
>> - Rebase and include in the same series as mqprio support.
>>
>> v3:
>> - Rebase on top of v6.6-rc1 and mqprio support [1]
>> - Support ethtool_ops :: get_mm_stats()
>> - drop unused variables cmn_ctrl and verify_cnt
>> - make am65_cpsw_iet_link_state_update() and
>>   am65_cpsw_iet_change_preemptible_tcs() static
>>
>> [1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/
>>
>> v2:
>> - Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
>>   and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
>> - Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
>>   AM65_CPSW_PN_CTL_IET_PORT_EN set.
>> - Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
>> - Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
>>   1G link if link is inactive.
>> - resize the RX FIFO based on pmac_enabled, not tx_enabled.
>>
>> Test Procedure:
>>
>> - 2 EVMs with AM65-CPSW network port connected to each other
>> - Run iet-setup-mqprio.sh on both
>>
>> #!/bin/sh
>> #iet-setup-mqprio.sh
>>
>> ifconfig eth0 down
>> ifconfig eth1 down
>> ethtool -L eth0 tx 4
>> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
>> ifconfig eth0 up
>> sleep 10
>>
>> tc qdisc add dev eth0 handle 100: root mqprio \
>> num_tc 4 \
>> map 0 1 2 3 \
>> queues 1@0 1@1 1@2 1@3 \
>> hw 1 \
>> mode dcb \
>> fp P P P E
>>
>> tc -g class show dev eth0
>> tc qdisc add dev eth0 clsact
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3
>> ip addr add 192.168.3.102/24 dev eth0 
>>
>> - check that MAC merge verification has succeeded
>>
>> ethtool --show-mm eth0
>>
>>         MAC Merge layer state for eth0:
>>         pMAC enabled: on
>>         TX enabled: on
>>         TX active: on
>>         TX minimum fragment size: 124
>>         RX minimum fragment size: 124
>>         Verify enabled: on
>>         Verify time: 10
>>         Max verify time: 134
>>         Verification status: SUCCEEDED
>>
>> - On receiver EVM run 2 iperf instances
>>
>> iperf3 -s -i30 -p5002&
>> iperf3 -s -i30 -p5003&
>>
>> - On sender EVM run 2 iperf instances
>>
>> iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
>> iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&
>>
>> - Check IET stats on sender. Look for MACMergeFragCountTx: increments
>>
>> ethtool -I --show-mm eth0
>> MAC Merge layer state for eth0:
>> pMAC enabled: on
>> TX enabled: on
>> TX active: on
>> TX minimum fragment size: 124
>> RX minimum fragment size: 124
>> Verify enabled: on
>> Verify time: 10
>> Max verify time: 134
>> Verification status: SUCCEEDED
>> Statistics:
>>   MACMergeFrameAssErrorCount: 0
>>   MACMergeFrameSmdErrorCount: 0
>>   MACMergeFrameAssOkCount: 0
>>   MACMergeFragCountRx: 0
>>   MACMergeFragCountTx: 57824
>>   MACMergeHoldCount: 0
>>
>> - Check IET stats on receiver. Look for MACMergeFragCountRx: and
>>   MACMergeFrameAssOkCount:
>>
>> ethtool -I --show-mm eth0
>> MAC Merge layer state for eth0:
>> pMAC enabled: on
>> TX enabled: on
>> TX active: on
>> TX minimum fragment size: 124
>> RX minimum fragment size: 124
>> Verify enabled: on
>> Verify time: 10
>> Max verify time: 134
>> Verification status: SUCCEEDED
>> Statistics:
>>   MACMergeFrameAssErrorCount: 0
>>   MACMergeFrameSmdErrorCount: 0
>>   MACMergeFrameAssOkCount: 57018
>>   MACMergeFragCountRx: 57824
>>   MACMergeFragCountTx: 0
>>   MACMergeHoldCount: 0
> 
> Nice of you to post commands, but could you also please clearly state
> whether the implementation passes tools/testing/selftests/net/forwarding/ethtool_mm.sh?

Honestly, I didn't spend much time with it. I will try to run
those tests and get back.

> 
>> +	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
>> +	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
>> +	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
>> +
>> +	/* verify_timeout_count can only be set at valid link */
>> +	port->qos.iet.verify_time_ms = cfg->verify_time;
>> +
>> +	/* enable/disable pre-emption based on link status */
> 
> For the benefit of grep, I would appreciate if it was spelled
> "preemption" everywhere.

OK.

> 
>> +	am65_cpsw_iet_commit_preemptible_tcs(port);
>> +
>> +	mutex_unlock(&priv->mm_lock);
>> +
>> +	return 0;
>> +}
>> +
>>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>>  {
>>  	return port->qos.est_oper || port->qos.est_admin;
>> @@ -602,6 +743,8 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
>>  	if (port->qos.link_speed == SPEED_UNKNOWN)
>>  		return -ENOLINK;
>>  
>> +	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
>> +
> 
> Hmm, why just look at the preemptible traffic classes and not at
> taprio's entire mqprio configuration? This bypasses the mapping between
> Linux traffic classes and switch priorities that you've established in
> am65_cpsw_setup_mqprio().
> 
> With the addition of the "mqprio" structure in tc_taprio_qopt_offload,
> my intention was to facilitate calling am65_cpsw_setup_mqprio() from
> am65_cpsw_setup_taprio().

OK. I will take a look at this. Thanks!

> 
>>  	return am65_cpsw_set_taprio(ndev, type_data);
>>  }

-- 
cheers,
-roger
