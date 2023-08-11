Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1502A779306
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbjHKP0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 11:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjHKP0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 11:26:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F9930D8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 08:26:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BA6867486
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:26:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18745C433C7;
        Fri, 11 Aug 2023 15:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691767594;
        bh=8LXyzi9tvgdg/Pt2fdxEW4wGcEQOw91QGZ21a4I/e4w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cvZP4I+bsBDIGK4WsAPL+Bb5UUmNb7iVuvIfagSWS/sAp831+bUMfPaS+ZoTFtrsC
         psChQEYansyXexDJqNiT/liRlZ1DMW2KprtT+LIKOKgYZeFzMUrhdw7Pk5NHU6QQXR
         9tX8JqgefFaI62JUNJa1YmX4gCyNlvJNYn8NFirfFJHiCRutPqDTyY5K5usMUWUOkS
         aHL+DQHN3TTYtsH+Nut3XmtMvykQhAJph0vdiax6qhTX/hq+FgCI0sJHjJm5cglfJK
         wa8ZqErohcznOUjY+zYTbmVE7rkMgXJYztWygBmezaROcEWbXVWjTBZ/bOCE/bvxdS
         yfNUCt07FOj8w==
Message-ID: <3fc59b72-65fb-66e3-e291-ec20d1f468d4@kernel.org>
Date:   Fri, 11 Aug 2023 18:26:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption
 MAC Merge support
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230810152538.138718-1-rogerq@kernel.org>
 <20230810152538.138718-1-rogerq@kernel.org>
 <20230810154703.cyyivcxlppdqr45q@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230810154703.cyyivcxlppdqr45q@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 10/08/2023 18:47, Vladimir Oltean wrote:
> Hi Roger,
> 
> On Thu, Aug 10, 2023 at 06:25:38PM +0300, Roger Quadros wrote:
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
>>
>> Hi,
>>
>> Dropping the RFC tag as I now have MAC merge verification and frame
>> preemption working.
>>
>> Changelog:
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
>> - Run iet-setup.sh on both
>>
>> #!/bin/sh
>> #iet-setup.sh
>>
>> ifconfig eth0 down
>> ifconfig eth1 down
>> ethtool -L eth0 tx 2
>> ethtool --set-priv-flags eth0 p0-rx-ptype-rrobin off
>> ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
>> ifconfig eth0 up
>> sleep 10
>>
>> tc qdisc replace dev eth0 handle 8001: parent root stab overhead 24 taprio \
>> num_tc 2 \
>> map 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 \
>> queues 1@0 1@1 \
>> base-time 0 \
>> sched-entry S 01 1216 \
>> sched-entry S fe 12368 \
>> flags 0x2 \
>> fp P E E E E E E E
>>
>> tc -g class show dev eth0
>> tc qdisc add dev eth0 clsact
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
>> tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3
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
> 
> Do you also plan to add support for mqprio, to present the same feature
> set as everyone, and permit IET to be used without EST?

Yes. I'll try to include it in next spin.

> 
> What else would need to change in order for the am65 cpsw to
> successfully run the existing tools/testing/selftests/net/forwarding/ethtool_mm.sh?
> Just the extra driver-specific ethtool --set-priv-flags? If so, maybe
> you could create a wrapper over the generic selftest, and put it in
> tools/testing/selftests/drivers/net/. For DSA we also symlink a lot of
> bridge selftests, for example.

OK. I'll give it a try.

> 
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
>> - Check IET stats on sender. Look for iet_tx_frag increments
>>
>> ethtool -S eth0 | grep iet
>>
>>      iet_rx_assembly_err: 0
>>      iet_rx_assembly_ok: 0
>>      iet_rx_smd_err: 0
>>      iet_rx_frag: 0
>>      iet_tx_hold: 0
>>      iet_tx_frag: 17307
> 
> Can you please also implement the standardized ethtool_ops :: get_mm_stats()?
> You can see these with ethtool -I --show-mm eth0.

Yes.

> 
>>
>> - Check IET stats on receiver. Look for iet_rx_frag and iet_rx_assembly_*
>>
>> ethtool -S eth0 | grep iet
>>
>>      iet_rx_assembly_err: 0
> 
> This would be struct ethtool_mm_stats :: MACMergeFrameAssErrorCount
> 
>>      iet_rx_assembly_ok: 17302
> 
> This would be struct ethtool_mm_stats :: MACMergeFrameAssOkCount
> 
>>      iet_rx_smd_err: 0
> 
> This would be struct ethtool_mm_stats :: MACMergeFrameSmdErrorCount
> 
>>      iet_rx_frag: 17307
> 
> This would be struct ethtool_mm_stats :: MACMergeFragCountRx
> 
>>      iet_tx_hold: 0
> 
> This would be struct ethtool_mm_stats :: MACMergeHoldCount
> 
>>      iet_tx_frag: 0
> 
> This would be struct ethtool_mm_stats :: MACMergeFragCountTx
> 

Thanks for the hints :)

> Also, I opened the AM62x datasheet again and I didn't find this, but I
> still need to ask. The CPSW doesn't show the Ethernet counters broken
> down by eMAC/pMAC, no? If it does, you should also add support for the
> following:

I don't think it does.

> 
> ethtool -I --show-pause eth0 --src pmac
> ethtool -S eth0 --groups eth-mac eth-phy eth-ctrl rmon -- --src pmac

-- 
cheers,
-roger
