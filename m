Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1B97F28E3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjKUJ0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbjKUJ00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:26:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C47610DC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 01:25:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2FFC433C8;
        Tue, 21 Nov 2023 09:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700558709;
        bh=38sr1Q2BPM9IpVdNqVNgjqzJqHLOllAYY6K3NqpVO3E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NLGW+Mk/Or2bYvH0kKqT1Qcmu46Al1JIkvPTX8vEqdlBem2Qr7inde0CNBIsh2XU7
         Ef4ScvGW2GA/IC6AukfqcmzHYxzUS4tvvRyzChtH8iVPvjkcyIwAhd0swbmikbAeSG
         xqkMQHunUADfbfnLtGJTZBa/zgV6y0Nl5jrcTjCBBGvzy69Ld7zUlkqHlw+dAXMzYd
         dSGcrQ7JN4t567zY0/ZLuUJZqCiTlm1bE5x25JAB08+EYqU6bYS9UIAyhKYMhS8FF/
         z2A37s6Dg076rG1rw3hm2vG0yazyVPjfeB3Y19FIVVhEU1XLk8lV5W9srpLOj6nxhd
         gTgbUmp/s11uw==
Message-ID: <73c9030e-28dc-447d-8888-2504a01e549d@kernel.org>
Date:   Tue, 21 Nov 2023 11:25:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 net-next 5/7] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20231120140147.78726-1-rogerq@kernel.org>
 <20231120140147.78726-6-rogerq@kernel.org>
 <20231120230314.tqozomqbd6jiqbf7@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20231120230314.tqozomqbd6jiqbf7@skbuf>
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



On 21/11/2023 01:03, Vladimir Oltean wrote:
> On Mon, Nov 20, 2023 at 04:01:45PM +0200, Roger Quadros wrote:
>> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct am65_cpsw_common *common = port->common;
>> +	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
>> +	int i, tc, offset, count, prio, ret;
>> +	u8 num_tc = qopt->num_tc;
>> +	u32 tx_prio_map = 0;
>> +
>> +	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
>> +
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}
>> +
>> +	if (!num_tc) {
>> +		am65_cpsw_reset_tc_mqprio(ndev);
>> +		ret = -EINVAL;
> 
> num_tc == 0 is what signals the deletion of the mqprio qdisc.
> Why return -EINVAL?

Right. I'll drop the -EINVAL.
> 
>> +		goto exit_put;
>> +	}
>> +
>> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
>> +	if (ret)
>> +		goto exit_put;
>> +
>> +	netdev_set_num_tc(ndev, num_tc);
>> +
>> +	/* Multiple Linux priorities can map to a Traffic Class
>> +	 * A Traffic Class can have multiple contiguous Queues,
>> +	 * Queues get mapped to Channels (thread_id),
>> +	 *	if not VLAN tagged, thread_id is used as packet_priority
>> +	 *	if VLAN tagged. VLAN priority is used as packet_priority
>> +	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
>> +	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
>> +	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
>> +	 * assume that Queue_n gets mapped to header_priority_n. We can then
>> +	 * set the switch priority in pn_tx_pri_map.
>> +	 */
>> +
>> +	for (tc = 0; tc < num_tc; tc++) {
>> +		prio = tc;
>> +
>> +		/* For simplicity we assign the same priority (TCn) to
>> +		 * all queues of a Traffic Class.
>> +		 */
>> +		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
>> +			tx_prio_map |= prio << (4 * i);
>> +
>> +		count = qopt->count[tc];
>> +		offset = qopt->offset[tc];
>> +		netdev_set_tc_queue(ndev, tc, count, offset);
>> +	}
>> +
>> +	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
>> +
>> +	am65_cpsw_tx_pn_shaper_apply(port);
>> +
>> +exit_put:
>> +	pm_runtime_put(common->dev);
>> +
>> +	return ret;
>> +}
>> +
>>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>>  {
>>  	return port->qos.est_oper || port->qos.est_admin;
>> @@ -737,16 +989,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
>>  					  port, port, true);
>>  }
>>  
>> -static u32
>> -am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
>> -{
>> -	u32 ir;
>> -
>> -	bus_freq /= 1000000;
>> -	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
>> -	return ir;
>> -}
>> -
> 
> Insufficient code movement in the previous patch?

Let me move it to patch 3.

-- 
cheers,
-roger
