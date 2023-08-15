Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7379077C949
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 10:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjHOIVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 04:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235557AbjHOIVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 04:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE19B3
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 01:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F23B62091
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 08:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3E3C433C8;
        Tue, 15 Aug 2023 08:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692087673;
        bh=wE4YclzwVvLwa8qJlgiysjKu7qwY5+swicaaoAZtrD8=;
        h=From:To:Cc:Subject:Date:From;
        b=C1dJ49CM2kQHAmYFWwOTNjy5vbYLYqlKmTckWYd7B6UBsvzFUv2ZqwZ3wh7neBzjr
         6h7ARzha37PPqpe1rpDOzSImHUEYlrZMbu0JXcsTZ3arlYjEUu9WWIPxg4N0vWhtp2
         aR5UA5fKBQrdkAuBjjSeVYvUHjhDAev9DXAp5DZKS5NeVAR3a7//xD2CmR8TiH3qJ5
         gBqHsbF4y8FYz6GcRT9dXRtMAjCIvZxW+na8KDe9JysznNXPoS20X1ZP+xENMQ6Xih
         nzbqcIIo9rq4R6ApDBiaEVgMBXwGx3O3MgqJG9YuU6nCIqfXK5ibmvYYfJNRtadlaf
         8yE7R/lqvXUew==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
Date:   Tue, 15 Aug 2023 11:21:05 +0300
Message-Id: <20230815082105.24549-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
not only setting up pri:tc mapping, but also configuring TX shapers on
external port FIFOs. The K3 CPSW MQPRIO Qdisc offload is expected to work
with VLAN/priority tagged packets. Non-tagged packets have to be mapped
only to TC0.

- TX traffic classes must be rated starting from TC that has highest
priority and with no gaps
- Traffic classes are used starting from 0, that has highest priority
- min_rate defines Committed Information Rate (guaranteed)
- max_rate defines Excess Information Rate (non guaranteed) and offloaded
as (max_rate[i] - tcX_min_rate[i])
- VLAN/priority tagged packets mapped to TC0 will exit switch with VLAN tag
priority 0

The configuration example:
 ethtool -L eth1 tx 5
 ethtool --set-priv-flags eth1 p0-rx-ptype-rrobin off

 tc qdisc add dev eth1 parent root handle 100: mqprio num_tc 3 \
 map 0 0 1 2 0 0 0 0 0 0 0 0 0 0 0 0 \
 queues 1@0 1@1 1@2 hw 1 mode channel \
 shaper bw_rlimit min_rate 0 100mbit 200mbit max_rate 0 101mbit 202mbit

 tc qdisc replace dev eth2 handle 100: parent root mqprio num_tc 1 \
 map 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 queues 1@0 hw 1

 ip link add link eth1 name eth1.100 type vlan id 100
 ip link set eth1.100 type vlan egress 0:0 1:1 2:2 3:3 4:4 5:5 6:6 7:7

In the above example two ports share the same TX CPPI queue 0 for low
priority traffic. 3 traffic classes are defined for eth1 and mapped to:
TC0 - low priority, TX CPPI queue 0 -> ext Port 1 fifo0, no rate limit
TC1 - prio 2, TX CPPI queue 1 -> ext Port 1 fifo1, CIR=100Mbit/s, EIR=1Mbit/s
TC2 - prio 3, TX CPPI queue 2 -> ext Port 1 fifo2, CIR=200Mbit/s, EIR=2Mbit/s

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c  | 295 ++++++++++++++++++++++-
 drivers/net/ethernet/ti/am65-cpsw-qos.h  |  14 ++
 3 files changed, 311 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bebcfd5e6b57..fc5810ae803a 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -632,6 +632,9 @@ static int am65_cpsw_nuss_ndo_slave_open(struct net_device *ndev)
 	/* restore vlan configurations */
 	vlan_for_each(ndev, cpsw_restore_vlans, port);
 
+	/* Initialize QoS */
+	am65_cpsw_qos_mqprio_init(port);
+
 	phylink_start(port->slave.phylink);
 
 	return 0;
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index eced87fa261c..a82ca2e09561 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -17,9 +17,12 @@
 
 #define AM65_CPSW_REG_CTL			0x004
 #define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
 #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
 #define AM65_CPSW_PN_REG_EST_CTL		0x060
 #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
 
 /* AM65_CPSW_REG_CTL register fields */
 #define AM65_CPSW_CTL_EST_EN			BIT(18)
@@ -56,6 +59,12 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+/* number of traffic classes (FIFOs) per port */
+#define AM65_CPSW_PN_TC_NUM			8
+#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
+
+static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data);
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -541,7 +550,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -795,6 +803,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return am65_cpsw_tc_query_caps(ndev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return am65_cpsw_setup_mqprio(ndev, type_data);
 	case TC_SETUP_BLOCK:
 		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
 	default:
@@ -802,10 +812,15 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 	}
 }
 
+static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port);
+
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_tx_pn_shaper_link_up(port);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
@@ -937,3 +952,281 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
 	}
 }
+
+static void am65_cpsw_tx_pn_shaper_apply(struct am65_cpsw_port *port)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct am65_cpsw_common *common = port->common;
+	struct tc_mqprio_qopt_offload *mqprio;
+	bool shaper_en;
+	u32 rate_mbps;
+	int i;
+
+	mqprio = &p_mqprio->mqprio_hw;
+	shaper_en = p_mqprio->shaper_en && !p_mqprio->shaper_susp;
+
+	for (i = 0; i < mqprio->qopt.num_tc; i++) {
+		rate_mbps = 0;
+		if (shaper_en) {
+			rate_mbps = mqprio->min_rate[i] * 8 / 1000000;
+			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+							       common->bus_freq);
+		}
+
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_CIR(i));
+	}
+
+	for (i = 0; i < mqprio->qopt.num_tc; i++) {
+		rate_mbps = 0;
+		if (shaper_en && mqprio->max_rate[i]) {
+			rate_mbps = mqprio->max_rate[i] - mqprio->min_rate[i];
+			rate_mbps = rate_mbps * 8 / 1000000;
+			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+							       common->bus_freq);
+		}
+
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_EIR(i));
+	}
+}
+
+static void am65_cpsw_tx_pn_shaper_link_up(struct am65_cpsw_port *port)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct am65_cpsw_common *common = port->common;
+	bool shaper_susp = false;
+
+	if (!p_mqprio->enable || !p_mqprio->shaper_en)
+		return;
+
+	if (p_mqprio->max_rate_total > port->qos.link_speed)
+		shaper_susp = true;
+
+	if (p_mqprio->shaper_susp == shaper_susp)
+		return;
+
+	if (shaper_susp)
+		dev_info(common->dev,
+			 "Port%u: total shaper tx rate > link speed - suspend shaper\n",
+			 port->port_id);
+	else
+		dev_info(common->dev,
+			 "Port%u: link recover - resume shaper\n",
+			 port->port_id);
+
+	p_mqprio->shaper_susp = shaper_susp;
+	am65_cpsw_tx_pn_shaper_apply(port);
+}
+
+void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port)
+{
+	struct am65_cpsw_host *host = am65_common_get_host(port->common);
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio;
+	u32 tx_prio_map = 0, rx_prio_map;
+	int i, fifo;
+
+	mqprio = &p_mqprio->mqprio_hw;
+	rx_prio_map = readl(host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);
+
+	if (p_mqprio->enable) {
+		for (i = 0; i < AM65_CPSW_PN_TC_NUM; i++) {
+			fifo = mqprio->qopt.prio_tc_map[i];
+			tx_prio_map |= fifo << (4 * i);
+		}
+
+		netdev_set_num_tc(port->ndev, mqprio->qopt.num_tc);
+		for (i = 0; i < mqprio->qopt.num_tc; i++) {
+			netdev_set_tc_queue(port->ndev, i,
+					    mqprio->qopt.count[i],
+					    mqprio->qopt.offset[i]);
+			if (!i) {
+				p_mqprio->tc0_q = mqprio->qopt.offset[i];
+				rx_prio_map &= ~(0x7 << (4 * p_mqprio->tc0_q));
+			}
+		}
+	} else {
+		/* restore default configuration */
+		netdev_reset_tc(port->ndev);
+		tx_prio_map = AM65_CPSW_PN_TX_PRI_MAP_DEFAULT;
+		rx_prio_map |= p_mqprio->tc0_q << (4 * p_mqprio->tc0_q);
+		p_mqprio->tc0_q = 0;
+	}
+
+	writel(tx_prio_map,
+	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+	writel(rx_prio_map,
+	       host->port_base + AM65_CPSW_PN_REG_RX_PRI_MAP);
+
+	am65_cpsw_tx_pn_shaper_apply(port);
+}
+
+static int am65_cpsw_mqprio_verify(struct am65_cpsw_port *port,
+				   struct tc_mqprio_qopt_offload *mqprio)
+{
+	int i;
+
+	for (i = 0; i < mqprio->qopt.num_tc; i++) {
+		unsigned int last = mqprio->qopt.offset[i] +
+				    mqprio->qopt.count[i];
+
+		if (mqprio->qopt.offset[i] >= port->ndev->real_num_tx_queues ||
+		    !mqprio->qopt.count[i] ||
+		    last >  port->ndev->real_num_tx_queues)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
+					  struct tc_mqprio_qopt_offload *mqprio,
+					  u64 *max_rate)
+{
+	struct am65_cpsw_common *common = port->common;
+	u64 min_rate_total = 0, max_rate_total = 0;
+	u32 min_rate_msk = 0, max_rate_msk = 0;
+	bool has_min_rate, has_max_rate;
+	int num_tc, i;
+
+	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
+	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
+
+	if (!has_min_rate && has_max_rate)
+		return -EOPNOTSUPP;
+
+	if (!has_min_rate)
+		return 0;
+
+	num_tc = mqprio->qopt.num_tc;
+
+	for (i = num_tc - 1; i >= 0; i--) {
+		u32 ch_msk;
+
+		if (mqprio->min_rate[i])
+			min_rate_msk |= BIT(i);
+		min_rate_total +=  mqprio->min_rate[i];
+
+		if (has_max_rate) {
+			if (mqprio->max_rate[i])
+				max_rate_msk |= BIT(i);
+			max_rate_total +=  mqprio->max_rate[i];
+
+			if (!mqprio->min_rate[i] && mqprio->max_rate[i]) {
+				dev_err(common->dev, "TX tc%d rate max>0 but min=0\n",
+					i);
+				return -EINVAL;
+			}
+
+			if (mqprio->max_rate[i] &&
+			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
+				dev_err(common->dev, "TX tc%d rate min(%llu)>max(%llu)\n",
+					i, mqprio->min_rate[i],
+					mqprio->max_rate[i]);
+				return -EINVAL;
+			}
+		}
+
+		ch_msk = GENMASK(num_tc - 1, i);
+		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
+			dev_err(common->dev, "TX Min rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
+				min_rate_msk);
+			return -EINVAL;
+		}
+
+		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
+			dev_err(common->dev, "TX max rate limiting has to be enabled sequentially hi->lo tx_rate_msk%x\n",
+				max_rate_msk);
+			return -EINVAL;
+		}
+	}
+	min_rate_total *= 8;
+	min_rate_total /= 1000 * 1000;
+	max_rate_total *= 8;
+	max_rate_total /= 1000 * 1000;
+
+	if (port->qos.link_speed != SPEED_UNKNOWN) {
+		if (min_rate_total > port->qos.link_speed) {
+			dev_err(common->dev, "TX rate min exceed %llu link speed %d\n",
+				min_rate_total, port->qos.link_speed);
+			return -EINVAL;
+		}
+
+		if (max_rate_total > port->qos.link_speed) {
+			dev_err(common->dev, "TX rate max exceed %llu link speed %d\n",
+				max_rate_total, port->qos.link_speed);
+			return -EINVAL;
+		}
+	}
+
+	*max_rate = max_t(u64, min_rate_total, max_rate_total);
+
+	return 0;
+}
+
+static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct am65_cpsw_common *common = port->common;
+	struct am65_cpsw_mqprio *p_mqprio;
+	bool has_min_rate;
+	int num_tc, ret;
+	u64 max_rate;
+
+	p_mqprio = &port->qos.mqprio;
+
+	if (!mqprio->qopt.hw)
+		goto skip_check;
+
+	if (mqprio->mode != TC_MQPRIO_MODE_CHANNEL)
+		return -EOPNOTSUPP;
+
+	num_tc = mqprio->qopt.num_tc;
+	if (num_tc > AM65_CPSW_PN_TC_NUM)
+		return -ERANGE;
+
+	if ((mqprio->flags & TC_MQPRIO_F_SHAPER) &&
+	    mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
+		return -EOPNOTSUPP;
+
+	ret = am65_cpsw_mqprio_verify(port, mqprio);
+	if (ret)
+		return ret;
+
+	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio, &max_rate);
+	if (ret)
+		return ret;
+
+skip_check:
+	ret = pm_runtime_get_sync(common->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(common->dev);
+		return ret;
+	}
+
+	if (mqprio->qopt.hw) {
+		memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
+		has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
+		p_mqprio->enable = 1;
+		p_mqprio->shaper_en = has_min_rate;
+		p_mqprio->shaper_susp = !has_min_rate;
+		p_mqprio->max_rate_total = max_rate;
+	} else {
+		unsigned int tc0_q = p_mqprio->tc0_q;
+
+		memset(p_mqprio, 0, sizeof(*p_mqprio));
+		p_mqprio->mqprio_hw.qopt.num_tc = AM65_CPSW_PN_TC_NUM;
+		p_mqprio->tc0_q = tc0_q;
+	}
+
+	if (!netif_running(ndev))
+		goto exit_put;
+
+	am65_cpsw_qos_mqprio_init(port);
+
+exit_put:
+	pm_runtime_put(common->dev);
+	return 0;
+}
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 0cc2a3b3d7f9..247a42788687 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -7,8 +7,10 @@
 
 #include <linux/netdevice.h>
 #include <net/pkt_sched.h>
+#include <net/pkt_cls.h>
 
 struct am65_cpsw_common;
+struct am65_cpsw_port;
 
 struct am65_cpsw_est {
 	int buf;
@@ -16,6 +18,16 @@ struct am65_cpsw_est {
 	struct tc_taprio_qopt_offload taprio;
 };
 
+struct am65_cpsw_mqprio {
+	struct tc_mqprio_qopt_offload mqprio_hw;
+	u64 max_rate_total;
+
+	unsigned enable:1;
+	unsigned shaper_en:1;
+	unsigned shaper_susp:1;
+	unsigned tc0_q:3;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -26,6 +38,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_est *est_oper;
 	ktime_t link_down_time;
 	int link_speed;
+	struct am65_cpsw_mqprio mqprio;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -35,6 +48,7 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
 void am65_cpsw_qos_link_down(struct net_device *ndev);
+void am65_cpsw_qos_mqprio_init(struct am65_cpsw_port *port);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
 

base-commit: 52a93d39b17dc7eb98b6aa3edb93943248e03b2f
-- 
2.34.1

