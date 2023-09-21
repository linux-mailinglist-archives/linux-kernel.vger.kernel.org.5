Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A381F7AA1AD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 23:06:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbjIUVF6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 17:05:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjIUVEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 17:04:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A9184F0B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:37:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 901B0C4AF5E;
        Thu, 21 Sep 2023 10:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695293136;
        bh=vunI/gBu+KLII+cUcUm4mhtQSOrFYHZioPlB0WNnxvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkkIQF41Jgc0/XNWtGw3GN/JTTHSMaz6pl7vNZ3WPQrkKvCX/EP9PK+1nDTOSMXR0
         1ASgPLO7MbOw35PxU6cFPswyMlMO3bxJ4Q6pHfttUFLcVt0/GAeqnOoQDTzcGfwGmQ
         LA+i9nFCgC2LpK9STR3XD2b5HF/+rPPcJ1VQjn0zkCg4STwcFkJw4H0iZkAkPAAy2H
         ZzI/HpaubxhIQpqcEfLJAige8BzZEVw8i+K6qVluyRtEvQICvDd9ts8r7JEsRz3p2a
         2f0G93OMmMo6Bpk6P8LVFg49ohlrM4AvmZCqMsFdq0FSPqWZL5NtpguwBVtJFanubr
         GyOkEfiCtPFYw==
Date:   Thu, 21 Sep 2023 11:45:29 +0100
From:   Simon Horman <horms@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com, s-vadapalli@ti.com,
        srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 2/3] net: ethernet: ti: am65-cpsw: add mqprio
 qdisc offload in channel mode
Message-ID: <20230921104529.GI224399@kernel.org>
References: <20230920121530.4710-1-rogerq@kernel.org>
 <20230920121530.4710-3-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920121530.4710-3-rogerq@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 03:15:29PM +0300, Roger Quadros wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> 
> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
> not only setting up pri:tc mapping, but also configuring TX shapers
> (rate-limiting) on external port FIFOs.
> 
> The MQPRIO Qdisc offload is expected to work with or without VLAN/priority
> tagged packets.
> 
> The CPSW external Port FIFO has 8 Priority queues. The rate-limit can be
> set for each of these priority queues. Which Priority queue a packet is
> assigned to depends on PN_REG_TX_PRI_MAP register which maps header
> priority to switch priority.
> 
> The header priority of a packet is assigned via the RX_PRI_MAP_REG which
> maps packet priority to header priority.
> 
> The packet priority is either the VLAN priority (for VLAN tagged packets)
> or the thread/channel offset.
> 
> For simplicity, we assign the same priority queue to all queues of a
> Traffic Class so it can be rate-limited correctly.
> 
> Configuration example:
>  ethtool -L eth1 tx 5
>  ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off
> 
>  tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
>  map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
>  queues 1@0 1@1 1@2 hw 1 mode channel \
>  shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit
> 
>  tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
>  map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1
> 
>  ip link add link eth1 name eth1.100 type vlan id 100
>  ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
> 
> In the above example two ports share the same TX CPPI queue 0 for low
> priority traffic. 3 traffic classes are defined for eth1 and mapped to:
> TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
> TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
> TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
> Signed-off-by: Roger Quadros <rogerq@kernel.org>

...

> +static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
> +					  struct tc_mqprio_qopt_offload *mqprio)
> +{
> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
> +	struct netlink_ext_ack *extack = mqprio->extack;
> +	u64 min_rate_total = 0, max_rate_total = 0;
> +	u32 min_rate_msk = 0, max_rate_msk = 0;
> +	bool has_min_rate, has_max_rate;
> +	int num_tc, i;
> +
> +	if (!(mqprio->flags & TC_MQPRIO_F_SHAPER))
> +		return 0;
> +
> +	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
> +		return 0;
> +
> +	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
> +	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
> +
> +	if (!has_min_rate && has_max_rate) {
> +		NL_SET_ERR_MSG_MOD(extack, "min_rate is required with max_rate");
> +		return -EOPNOTSUPP;
> +	}
> +
> +	if (!has_min_rate)
> +		return 0;
> +
> +	num_tc = mqprio->qopt.num_tc;
> +
> +	for (i = num_tc - 1; i >= 0; i--) {
> +		u32 ch_msk;
> +
> +		if (mqprio->min_rate[i])
> +			min_rate_msk |= BIT(i);
> +		min_rate_total +=  mqprio->min_rate[i];
> +
> +		if (has_max_rate) {
> +			if (mqprio->max_rate[i])
> +				max_rate_msk |= BIT(i);
> +			max_rate_total +=  mqprio->max_rate[i];
> +
> +			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate max>0 but min=0\n",
> +						       i);
> +				return -EINVAL;
> +			}
> +
> +			if (mqprio->max_rate[i] &&
> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
> +				NL_SET_ERR_MSG_FMT_MOD(extack,
> +						       "TX tc%d rate min(%llu)>max(%llu)\n",
> +						       i, mqprio->min_rate[i],
> +						       mqprio->max_rate[i]);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ch_msk = GENMASK(num_tc - 1, i);
> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "TX min rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
> +					       min_rate_msk);

Hi Grygorii and Roger,

An allmodconfig build with gcc-13 W=1 warns that:

 drivers/net/ethernet/ti/am65-cpsw-qos.c: In function 'am65_cpsw_mqprio_verify_shaper':
 ./include/linux/netlink.h:116:13: warning: 'am65_cpsw_qos: TX min rate l...' directive output truncated writing 85 bytes into a region of size 80 [-Wformat-truncation=]

> +			return -EINVAL;
> +		}
> +
> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
> +			NL_SET_ERR_MSG_FMT_MOD(extack,
> +					       "TX max rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
> +					       max_rate_msk);

Likewise, here too.

> +			return -EINVAL;
> +		}
> +	}
> +
> +	min_rate_total = TO_MBPS(min_rate_total);
> +	max_rate_total = TO_MBPS(max_rate_total);
> +
> +	p_mqprio->shaper_en = true;
> +	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
> +
> +	return 0;
> +}

,..
