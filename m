Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92AC77FA6D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 17:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352862AbjHQPK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 11:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352925AbjHQPKo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 11:10:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D8435A0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 08:10:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD286746B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 15:10:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6AF45C433C7;
        Thu, 17 Aug 2023 15:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285003;
        bh=OwN1cRFhNoO+oGXaDwINRvNu+FVmh0A7sStoXR/QRuc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m20KW6Btyw25V/YBAFbHyOaBN/TCySySDxNpbO3ERcoJC93AksPxpgYp2JwD5Og51
         JpdYynwTPzbjy2F0cLIxM1VFWV5apnyE8kiryonkaSUQAm4hBOXpPLRTj70irHYYPm
         C5c/88rQCuZ836kDjXTLpd5w3ZG0zgGUJZqdbRm8QSlRjWoRwtcPiGW2gHNknU7tlI
         bhTmHdTGGDIM14fGvvxH+4OLPzPBfaqdhy45Kq5u018XU0ta8ceQKHbS0+fetpWQ9S
         MqrCI2Klp9E8inPxyA0KM2i+UbK6Crzsxp3L+eEm3nQ/ONjzR3riITN90tDfSJ+AlR
         5i+nyVeLc2jvA==
Message-ID: <f9bd9c9a-e4d3-2bb8-b394-8092cc2956d9@kernel.org>
Date:   Thu, 17 Aug 2023 18:09:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in
 channel mode
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20230815082105.24549-1-rogerq@kernel.org>
 <20230815082105.24549-1-rogerq@kernel.org>
 <20230816121305.5dio5tk3chge2ndh@skbuf>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230816121305.5dio5tk3chge2ndh@skbuf>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladimir,

On 16/08/2023 15:13, Vladimir Oltean wrote:
> On Tue, Aug 15, 2023 at 11:21:05AM +0300, Roger Quadros wrote:
>> From: Grygorii Strashko <grygorii.strashko@ti.com>
>>
>> This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
>> not only setting up pri:tc mapping, but also configuring TX shapers on
>> external port FIFOs. The K3 CPSW MQPRIO Qdisc offload is expected to work
>> with VLAN/priority tagged packets. Non-tagged packets have to be mapped
>> only to TC0.
> 
> You are talking about the forwarding path (RX QoS classification) here?
> 

I don't think this patch has anything to do with RX QoS.
I'll clarify what's up with the rx_prio_map below.

> For the local termination path, TX queue selection should be independent
> of VLAN PCP, correct? I see am65_cpsw_nuss_ndo_slave_xmit() looks at
> skb_get_queue_mapping(), which should be set correctly by netdev_core_pick_tx(),

Right. But at the same time I do not see Transmit queue priority function
mentioned independently of VLAN PCP in Documentation [1]
I will check with the HW team and get back.

[1] Section 12.3.1.4.6.2 Packet Priority Handling and next 2 sections in
TRM https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf

> based on netdev_get_prio_tc_map(dev, skb->priority). Do the queues/channels
> selected by the xmit procedure have their own priority? I.e. if an
> application uses the SO_PRIORITY API but doesn't use VLAN PCP, the TX
> queue selection done by the driver will still prioritize its traffic as
> it should?

This I'm not sure of. At least this patch didn't work as expected
when mqprio was used with "hw 1". With "hw 0" it seems to work fine.
So either mqprio hw-offload is not supported without VLAN PCP or
this patch needs more work.

> 
> Side note: for customizing the RX QoS classification, my understanding
> is that you can use the dcbnl app priority table to modify the
> port-default QoS class to a value other than 0 (among other stuff).
> 
> I see some rx_prio_map handling in am65_cpsw_qos_mqprio_init(), and it's
> not clear at all to me that tc-mqprio should ever affect RX prioritization.

rx_prio_map has nothing to do with ingress (RX) packets. I will explain it below.

> 
>>
>> - TX traffic classes must be rated starting from TC that has highest
>> priority and with no gaps
>> - Traffic classes are used starting from 0, that has highest priority
> 
> TC0 has highest priority?

I'm not sure what the author meant and why the below constraint
"TX traffic classes must be rated starting from TC that has highest
priority and with no gaps"

> 
>> - min_rate defines Committed Information Rate (guaranteed)
>> - max_rate defines Excess Information Rate (non guaranteed) and offloaded
>> as (max_rate[i] - tcX_min_rate[i])
>> - VLAN/priority tagged packets mapped to TC0 will exit switch with VLAN tag
>> priority 0
>>
>> The configuration example:
>>  ethtool -L eth1 tx 5
>>  ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off
>>
>>  tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
>>  map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
>>  queues 1@0 1@1 1@2 hw 1 mode channel \
>>  shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit
>>
>>  tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
>>  map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1
>>
>>  ip link add link eth1 name eth1.100 type vlan id 100
>>  ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7
>>
>> In the above example two ports share the same TX CPPI queue 0 for low
>> priority traffic. 3 traffic classes are defined for eth1 and mapped to:
>> TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
>> TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
>> TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s
>>
>> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> ---
>>  drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
>>  drivers/net/ethernet/ti/am65-cpsw-qos.c  | 295 ++++++++++++++++++++++-
>>  drivers/net/ethernet/ti/am65-cpsw-qos.h  |  14 ++
>>  3 files changed, 311 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> index bebcfd5e6b57..fc5810ae803a 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
>> @@ -632,6 +632,9 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
>>  	/* restore vlan configurations */
>>  	vlan_for_each(ndev, cpsw_restore_vlans, port);
>>  
>> +	/* Initialize QoS */
>> +	am65_cpsw_qos_mqprio_init(port);
>> +
>>  	phylink_start(port->slave.phylink);
>>  
>>  	return 0;
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> index eced87fa261c..a82ca2e09561 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
>> @@ -17,9 +17,12 @@
>>  
>>  #define AM65_CPSW_REG_CTL			0x004
>>  #define AM65_CPSW_PN_REG_CTL			0x004
>> +#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
>> +#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
>>  #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
>>  #define AM65_CPSW_PN_REG_EST_CTL		0x060
>>  #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
>> +#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
>>  
>>  /* AM65_CPSW_REG_CTL register fields */
>>  #define AM65_CPSW_CTL_EST_EN			BIT(18)
>> @@ -56,6 +59,12 @@ enum timer_act {
>>  	TACT_SKIP_PROG,		/* just buffer can be updated */
>>  };
>>  
>> +/* number of traffic classes (FIFOs) per port */
>> +#define AM65_CPSW_PN_TC_NUM			8
>> +#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
>> +
>> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data);
> 
> Can you avoid forward declarations?

OK.

> 
>> +
>>  static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
>>  {
>>  	return port->qos.est_oper || port->qos.est_admin;
>> @@ -541,7 +550,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
>>  	ktime_t cur_time;
>>  	s64 delta;
>>  
>> -	port->qos.link_speed = link_speed;
>>  	if (!am65_cpsw_port_est_enabled(port))
>>  		return;
>>  
>> @@ -795,6 +803,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>  		return am65_cpsw_tc_query_caps(ndev, type_data);
>>  	case TC_SETUP_QDISC_TAPRIO:
>>  		return am65_cpsw_setup_taprio(ndev, type_data);
>> +	case TC_SETUP_QDISC_MQPRIO:
>> +		return am65_cpsw_setup_mqprio(ndev, type_data);
>>  	case TC_SETUP_BLOCK:
>>  		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
>>  	default:
>> @@ -802,10 +812,15 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>  	}
>>  }
>>  
>> +static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port);
>> +
>>  void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
>>  {
>>  	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>>  
>> +	port->qos.link_speed = link_speed;
>> +	am65_cpsw_tx_pn_shaper_link_up(port);
>> +
>>  	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
>>  		return;
>>  
>> @@ -937,3 +952,281 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
>>  		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
>>  	}
>>  }
>> +
>> +static void am65_cpsw_tx_pn_shaper_apply(struct am65_cpsw_port *port)
>> +{
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct am65_cpsw_common *common = port->common;
>> +	struct tc_mqprio_qopt_offload *mqprio;
>> +	bool shaper_en;
>> +	u32 rate_mbps;
>> +	int i;
>> +
>> +	mqprio = &p_mqprio->mqprio_hw;
>> +	shaper_en = p_mqprio->shaper_en && !p_mqprio->shaper_susp;
>> +
>> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
>> +		rate_mbps = 0;
>> +		if (shaper_en) {
>> +			rate_mbps = mqprio->min_rate[i] * 8 / 1000000;
>> +			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
>> +							       common->bus_freq);
>> +		}
>> +
>> +		writel(rate_mbps,
>> +		       port->port_base + AM65_CPSW_PN_REG_PRI_CIR(i));
>> +	}
>> +
>> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
> 
> No need for 2 loops?
> 
OK.

>> +		rate_mbps = 0;
>> +		if (shaper_en && mqprio->max_rate[i]) {
>> +			rate_mbps = mqprio->max_rate[i] - mqprio->min_rate[i];
>> +			rate_mbps = rate_mbps * 8 / 1000000;
>> +			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
>> +							       common->bus_freq);
>> +		}
>> +
>> +		writel(rate_mbps,
>> +		       port->port_base + AM65_CPSW_PN_REG_PRI_EIR(i));
>> +	}
>> +}
>> +
>> +static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port)
>> +{
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct am65_cpsw_common *common = port->common;
>> +	bool shaper_susp = false;
>> +
>> +	if (!p_mqprio->enable || !p_mqprio->shaper_en)
>> +		return;
>> +
>> +	if (p_mqprio->max_rate_total > port->qos.link_speed)
>> +		shaper_susp = true;
>> +
>> +	if (p_mqprio->shaper_susp == shaper_susp)
>> +		return;
>> +
>> +	if (shaper_susp)
>> +		dev_info(common->dev,
>> +			 "Port%u: total shaper tx rate > link speed - suspend shaper\n",
>> +			 port->port_id);
>> +	else
>> +		dev_info(common->dev,
>> +			 "Port%u: link recover - resume shaper\n",
>> +			 port->port_id);
>> +
>> +	p_mqprio->shaper_susp = shaper_susp;
>> +	am65_cpsw_tx_pn_shaper_apply(port);
>> +}
>> +
>> +void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port)
>> +{
>> +	struct am65_cpsw_host *host = am65_common_get_host(port->common);
>> +	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
>> +	struct tc_mqprio_qopt_offload *mqprio;
>> +	u32 tx_prio_map = 0, rx_prio_map;
>> +	int i, fifo;
>> +
>> +	mqprio = &p_mqprio->mqprio_hw;
>> +	rx_prio_map = readl(host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);
>> +
>> +	if (p_mqprio->enable) {
>> +		for (i = 0; i < AM65_CPSW_PN_TC_NUM; i++) {
>> +			fifo = mqprio->qopt.prio_tc_map[i];
>> +			tx_prio_map |= fifo << (4 * i);
>> +		}
>> +
>> +		netdev_set_num_tc(port->ndev, mqprio->qopt.num_tc);
>> +		for (i = 0; i < mqprio->qopt.num_tc; i++) {
>> +			netdev_set_tc_queue(port->ndev, i,
>> +					    mqprio->qopt.count[i],
>> +					    mqprio->qopt.offset[i]);
> 
> How else do you use the TX queue counts and offsets given by mqprio?
> Don't you need to somehow tell the hardware that these TX queues are
> configured for traffic class i? I'm not seeing that.

And that's why testing mqprio with "hw 1" and no VLAN PCP didn't work.
I will check with HW team what needs to be done for hw offload to work
without VLAN PCP.

> 
>> +			if (!i) {
>> +				p_mqprio->tc0_q = mqprio->qopt.offset[i];
>> +				rx_prio_map &= ~(0x7 << (4 * p_mqprio->tc0_q));
>> +			}
>> +		}
>> +	} else {
>> +		/* restore default configuration */
>> +		netdev_reset_tc(port->ndev);
>> +		tx_prio_map = AM65_CPSW_PN_TX_PRI_MAP_DEFAULT;
> 
> I'm not sure how the default (no mqprio) tx_prio_map works. Local
> termination (xmit from Linux) will use a single queue, but forwarding

did you want to say something more here?

> 
>> +		rx_prio_map |= p_mqprio->tc0_q << (4 * p_mqprio->tc0_q);
>> +		p_mqprio->tc0_q = 0;
>> +	}
>> +
>> +	writel(tx_prio_map,
>> +	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
>> +	writel(rx_prio_map,
>> +	       host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);

For better understanding this should have been
		(host->port_base + AM65_CPSW_P0_REG_TX_PRI_MAP);
>> +

Both tx_prio_map and rx_prio_map are for egress.
tx_prio_map is for TX port 1. (header_priority to switch_priority mapping)
rx_prio_map is for Host port 0. (packet_priority to header_priority mapping)

To understand this please refer to section 12.3.1.4.6.2.1 Priority Mapping and Transmit VLAN Priority
And figure Figure 12-347. Gigabit Ethernet Switch Priority Mapping and Transmit VLAN Processing
in the TRM.

When driver sends a packet in start_xmit() it goes like so
"(5) is the ingress process that occurs at Host Port 0
– The incoming packet is assigned a packet priority based on either its VLAN priority, IPv4 or IPv6 DSCP
value, or the host port’s priority. This packet priority is then mapped to a header packet priority using the
register. (i.e. rx_prio_map)

(3) is the process by which it is decided which priority TX queue to place the packet on in the Port N TX FIFO
during egress
– Each Port’s TX FIFO has 8 queues that each correspond to a priority that is used when determining which
packet will egress from the switch next at that port. The header packet priority (Ethernet port ingress,
process (1)) or the receive packet thread (host port 0 ingress, process (5)) gets mapped through the
register (where N is the egress port number) to determine the switch priority of the packet. (i.e. tx_prio_map)
The switch priority determines which TX FIFO queue to place the packet in. 

(2) is the egress process that occurs at the external Ethernet ports
– If the switch is in VLAN Aware mode then the VLAN header may be added, replaced, or removed during
the egress process. If the VLAN header is to be added or replaced, the VLAN priority will come from the
header packet priority that was determined in process (1) or (5)."

Now I'm clueless as to why this patch is only dealing with TC0 qopt.offset
and doesn't deal with count or other TCs with respect to rx_prio_map
i.e. packet_priority to header_priority mapping.

>> +	am65_cpsw_tx_pn_shaper_apply(port);
>> +}
>> +
>> +static int am65_cpsw_mqprio_verify(struct am65_cpsw_port *port,
>> +				   struct tc_mqprio_qopt_offload *mqprio)
>> +{
>> +	int i;
>> +
>> +	for (i = 0; i < mqprio->qopt.num_tc; i++) {
>> +		unsigned int last = mqprio->qopt.offset[i] +
>> +				    mqprio->qopt.count[i];
>> +
>> +		if (mqprio->qopt.offset[i] >= port->ndev->real_num_tx_queues ||
>> +		    !mqprio->qopt.count[i] ||
>> +		    last >  port->ndev->real_num_tx_queues)
>> +			return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Set struct tc_mqprio_caps :: validate_queue_counts = true and you don't
> need to do this.

OK.

> 
>> +
>> +static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
>> +					  struct tc_mqprio_qopt_offload *mqprio,
>> +					  u64 *max_rate)
>> +{
>> +	struct am65_cpsw_common *common = port->common;
>> +	u64 min_rate_total = 0, max_rate_total = 0;
>> +	u32 min_rate_msk = 0, max_rate_msk = 0;
>> +	bool has_min_rate, has_max_rate;
>> +	int num_tc, i;
>> +
>> +	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
>> +	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
>> +
>> +	if (!has_min_rate && has_max_rate)
>> +		return -EOPNOTSUPP;
> 
> Please use tc_mqprio_qopt_offload :: extack for error message reporting
> (everywhere).

Got it.
> 
>> +
>> +	if (!has_min_rate)
>> +		return 0;
>> +
>> +	num_tc = mqprio->qopt.num_tc;
>> +
>> +	for (i = num_tc - 1; i >= 0; i--) {
>> +		u32 ch_msk;
>> +
>> +		if (mqprio->min_rate[i])
>> +			min_rate_msk |= BIT(i);
>> +		min_rate_total +=  mqprio->min_rate[i];
>> +
>> +		if (has_max_rate) {
>> +			if (mqprio->max_rate[i])
>> +				max_rate_msk |= BIT(i);
>> +			max_rate_total +=  mqprio->max_rate[i];
>> +
>> +			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
>> +				dev_err(common->dev, "TX tc%d rate max>0 but min=0\n",
>> +					i);
> 
> Recently, NL_SET_ERR_MSG_FMT was introduced which allows you to keep the
> %d formatting.

OK.
> 
>> +				return -EINVAL;
>> +			}
>> +
>> +			if (mqprio->max_rate[i] &&
>> +			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
>> +				dev_err(common->dev, "TX tc%d rate min(%llu)>max(%llu)\n",
>> +					i, mqprio->min_rate[i],
>> +					mqprio->max_rate[i]);
>> +				return -EINVAL;
>> +			}
>> +		}
>> +
>> +		ch_msk = GENMASK(num_tc - 1, i);
>> +		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
>> +			dev_err(common->dev, "TX Min rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
>> +				min_rate_msk);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
>> +			dev_err(common->dev, "TX max rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
>> +				max_rate_msk);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	min_rate_total *= 8;
>> +	min_rate_total /= 1000 * 1000;
>> +	max_rate_total *= 8;
>> +	max_rate_total /= 1000 * 1000;
>> +
>> +	if (port->qos.link_speed != SPEED_UNKNOWN) {
>> +		if (min_rate_total > port->qos.link_speed) {
>> +			dev_err(common->dev, "TX rate min exceed %llu link speed %d\n",
>> +				min_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +
>> +		if (max_rate_total > port->qos.link_speed) {
>> +			dev_err(common->dev, "TX rate max exceed %llu link speed %d\n",
>> +				max_rate_total, port->qos.link_speed);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +
>> +	*max_rate = max_t(u64, min_rate_total, max_rate_total);
>> +
>> +	return 0;
>> +}
>> +
>> +static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
>> +{
>> +	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
>> +	struct tc_mqprio_qopt_offload *mqprio = type_data;
>> +	struct am65_cpsw_common *common = port->common;
>> +	struct am65_cpsw_mqprio *p_mqprio;
>> +	bool has_min_rate;
>> +	int num_tc, ret;
>> +	u64 max_rate;
>> +
>> +	p_mqprio = &port->qos.mqprio;
>> +
>> +	if (!mqprio->qopt.hw)
>> +		goto skip_check;
> 
> Will ndo_setup_tc(TC_SETUP_QDISC_MQPRIO) ever get called if mqprio->qopt.hw is 0?
> I don't think so:
> 
> mqprio_init():
> 
> 	/* If the mqprio options indicate that hardware should own
> 	 * the queue mapping then run ndo_setup_tc otherwise use the
> 	 * supplied and verified mapping
> 	 */
> 	if (qopt->hw) {
> 		err = mqprio_enable_offload(sch, qopt, extack);
> 		if (err)
> 			return err;
> 	} else {
> 		netdev_set_num_tc(dev, qopt->num_tc);
> 		for (i = 0; i < qopt->num_tc; i++)
> 			netdev_set_tc_queue(dev, i,
> 					    qopt->count[i], qopt->offset[i]);
> 	}
> 

Thanks. I'll get rid of the dead code.

>> +
>> +	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL)
>> +		return -EOPNOTSUPP;
>> +
>> +	num_tc = mqprio->qopt.num_tc;
>> +	if (num_tc > AM65_CPSW_PN_TC_NUM)
>> +		return -ERANGE;
>> +
>> +	if ((mqprio->flags & TC_MQPRIO_F_SHAPER) &&
>> +	    mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
>> +		return -EOPNOTSUPP;
>> +
>> +	ret = am65_cpsw_mqprio_verify(port, mqprio);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio, &max_rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +skip_check:
>> +	ret = pm_runtime_get_sync(common->dev);
>> +	if (ret < 0) {
>> +		pm_runtime_put_noidle(common->dev);
>> +		return ret;
>> +	}
>> +
>> +	if (mqprio->qopt.hw) {
>> +		memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
>> +		has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
>> +		p_mqprio->enable = 1;
>> +		p_mqprio->shaper_en = has_min_rate;
>> +		p_mqprio->shaper_susp = !has_min_rate;
>> +		p_mqprio->max_rate_total = max_rate;
>> +	} else {
>> +		unsigned int tc0_q = p_mqprio->tc0_q;
> 
> Same comment about qopt.hw: isn't this dead code?
> 

Right.

>> +
>> +		memset(p_mqprio, 0, sizeof(*p_mqprio));
>> +		p_mqprio->mqprio_hw.qopt.num_tc = AM65_CPSW_PN_TC_NUM;
>> +		p_mqprio->tc0_q = tc0_q;
>> +	}
>> +
>> +	if (!netif_running(ndev))
>> +		goto exit_put;
>> +
>> +	am65_cpsw_qos_mqprio_init(port);
>> +
>> +exit_put:
>> +	pm_runtime_put(common->dev);
>> +	return 0;
>> +}
>> diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> index 0cc2a3b3d7f9..247a42788687 100644
>> --- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> +++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
>> @@ -7,8 +7,10 @@
>>  
>>  #include <linux/netdevice.h>
>>  #include <net/pkt_sched.h>
>> +#include <net/pkt_cls.h>
> 
> mqprio was moved from pkt_cls.h to pkt_sched.h in commit 9adafe2b8546
> ("net/sched: move struct tc_mqprio_qopt_offload from pkt_cls.h to pkt_sched.h").
> I don't think you need pkt_cls.h.
> 

OK.

>>  
>>  struct am65_cpsw_common;
>> +struct am65_cpsw_port;
>>  
>>  struct am65_cpsw_est {
>>  	int buf;
>> @@ -16,6 +18,16 @@ struct am65_cpsw_est {
>>  	struct tc_taprio_qopt_offload taprio;
>>  };
>>  
>> +struct am65_cpsw_mqprio {
>> +	struct tc_mqprio_qopt_offload mqprio_hw;
>> +	u64 max_rate_total;
>> +
>> +	unsigned enable:1;
>> +	unsigned shaper_en:1;
>> +	unsigned shaper_susp:1;
>> +	unsigned tc0_q:3;
> 
> Sorry, I don't really understand what's the deal with this tc0_q.
> Could you explain? It seems to persist in the port's rx_prio_map when
> p_mqprio->enable transitions from true to false. But I don't understand
> why. Also, part of its handling is dead code, I think.
> 
>> +};
>> +
>>  struct am65_cpsw_ale_ratelimit {
>>  	unsigned long cookie;
>>  	u64 rate_packet_ps;
>> @@ -26,6 +38,7 @@ struct am65_cpsw_qos {
>>  	struct am65_cpsw_est *est_oper;
>>  	ktime_t link_down_time;
>>  	int link_speed;
>> +	struct am65_cpsw_mqprio mqprio;
>>  
>>  	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
>>  	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
>> @@ -35,6 +48,7 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
>>  			       void *type_data);
>>  void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
>>  void am65_cpsw_qos_link_down(struct net_device *ndev);
>> +void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port);
>>  int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
>>  void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
>>  
>>
>> base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
>> -- 
>> 2.34.1
>>

-- 
cheers,
-roger
