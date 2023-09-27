Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7497AFC11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjI0H2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjI0H17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:27:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9310E
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 00:27:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0471C433C8;
        Wed, 27 Sep 2023 07:27:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695799674;
        bh=y70kAzpeUZVNbMTMcWvLXBJ34tZ5Sma5WnnOHaG/S4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pm/ADGDvqNWlyQOXmh9B0OYuzKQiDS1tLt1NETaG1HX1PWgnTXZuWeuNBjrvyfYAI
         Yx63/bod28TjlP7mRJ5t+M+A5sZ6cnSxgjtVx6qjdh1b+r2PyJZcZpoxrV5vddb1Ih
         zGE5qJlP3sYVoF5s0TF7qbCiwrwz8J9SoLej+jcBcw71Ztm2j13YJCmcX0ioOHk/bJ
         LZdKBO6M1d0X1bF2pFHRFd6GYFs9dgF03J2iFG1uOuwE6JrVqeJHBQfedL8Sx/yJzd
         5SMECU/n+gEmckmcYqzLPI6jhHd5gSENgTWKpCX9Y9eXQsvecRtC0klgOcOCsLa7dS
         GAS1z9HFZH/aA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     horms@kernel.org, s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com,
        p-varis@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, rogerq@kernel.org
Subject: [PATCH v5 net-next 2/4] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
Date:   Wed, 27 Sep 2023 10:27:39 +0300
Message-Id: <20230927072741.21221-3-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927072741.21221-1-rogerq@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

This patch adds MQPRIO Qdisc offload in full 'channel' mode which allows
not only setting up pri:tc mapping, but also configuring TX shapers
(rate-limiting) on external port FIFOs.

The MQPRIO Qdisc offload is expected to work with or without VLAN/priority
tagged packets.

The CPSW external Port FIFO has 8 Priority queues. The rate-limit can be
set for each of these priority queues. Which Priority queue a packet is
assigned to depends on PN_REG_TX_PRI_MAP register which maps header
priority to switch priority.

The header priority of a packet is assigned via the RX_PRI_MAP_REG which
maps packet priority to header priority.

The packet priority is either the VLAN priority (for VLAN tagged packets)
or the thread/channel offset.

For simplicity, we assign the same priority queue to all queues of a
Traffic Class so it can be rate-limited correctly.

Configuration example:
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
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 262 +++++++++++++++++++++++-
 drivers/net/ethernet/ti/am65-cpsw-qos.h |   8 +
 2 files changed, 267 insertions(+), 3 deletions(-)

Changelog:
v5:
- fix warning at NL_SET_ERR_MSG_FMT_MOD()

v4:
- use macro TO_MBPS()
- use bool for 'shaper_en'
- split code movement into separate patch
- drop rate vs link speed check as mqprio can be set at link down
- call am65_cpsw_reset_tc_mqprio() after pm_runtime_get_sync()

v2:
- clean up commit message
- avoid forward declarations
- use tc_mqprio_qopt_offload :: extack for error message reporting
- avoid unnecessary mqprio->qopt.hw == 0 checks
- set struct tc_mqprio_caps :: validate_queue_counts = true and get rid of
  am65_cpsw_mqprio_verify()
- do not modify AM65_CPSW_P0_REG_RX_PRI_MAP register.

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index f91137d8e73b..991221d8f148 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -16,10 +16,19 @@
 #include "cpsw_ale.h"
 
 #define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_P0_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_P0_REG_RX_PRI_MAP		0x020
+#define AM65_CPSW_P0_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_P0_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
+
 #define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
 #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
 #define AM65_CPSW_PN_REG_EST_CTL		0x060
 #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
 
 /* AM65_CPSW_REG_CTL register fields */
 #define AM65_CPSW_CTL_EST_EN			BIT(18)
@@ -50,12 +59,18 @@
 #define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
 #define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
 
+#define TO_MBPS(x)	((x) * 8 / 1000000)
+
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+/* number of priority queues per port FIFO */
+#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
+#define AM65_CPSW_PN_TX_PRI_MAP_DEFAULT		0x76543210
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -541,7 +556,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -596,6 +610,14 @@ static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
 	struct tc_query_caps_base *base = type_data;
 
 	switch (base->type) {
+	case TC_SETUP_QDISC_MQPRIO: {
+		struct tc_mqprio_caps *caps = base->caps;
+
+		caps->validate_queue_counts = true;
+
+		return 0;
+	}
+
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
@@ -899,6 +921,234 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 	}
 }
 
+static void am65_cpsw_tx_pn_shaper_reset(struct am65_cpsw_port *port)
+{
+	int prio;
+
+	for (prio = 0; prio < AM65_CPSW_PN_FIFO_PRIO_NUM; prio++) {
+		writel(0, port->port_base + AM65_CPSW_PN_REG_PRI_CIR(prio));
+		writel(0, port->port_base + AM65_CPSW_PN_REG_PRI_EIR(prio));
+	}
+}
+
+static void am65_cpsw_tx_pn_shaper_apply(struct am65_cpsw_port *port)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct am65_cpsw_common *common = port->common;
+	struct tc_mqprio_qopt_offload *mqprio;
+	bool enable, shaper_susp = false;
+	u32 rate_mbps;
+	int tc, prio;
+
+	mqprio = &p_mqprio->mqprio_hw;
+	/* takes care of no link case as well */
+	if (p_mqprio->max_rate_total > port->qos.link_speed)
+		shaper_susp = true;
+
+	am65_cpsw_tx_pn_shaper_reset(port);
+
+	enable = p_mqprio->shaper_en && !shaper_susp;
+	if (!enable)
+		return;
+
+	/* Rate limit is specified per Traffic Class but
+	 * for CPSW, rate limit can be applied per priority
+	 * at port FIFO.
+	 *
+	 * We have assigned the same priority (TCn) to all queues
+	 * of a Traffic Class so they share the same shaper
+	 * bandwidth.
+	 */
+	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
+		prio = tc;
+
+		rate_mbps = TO_MBPS(mqprio->min_rate[tc]);
+		rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+						       common->bus_freq);
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_CIR(prio));
+
+		rate_mbps = 0;
+
+		if (mqprio->max_rate[tc]) {
+			rate_mbps = mqprio->max_rate[tc] - mqprio->min_rate[tc];
+			rate_mbps = TO_MBPS(rate_mbps);
+			rate_mbps = am65_cpsw_qos_tx_rate_calc(rate_mbps,
+							       common->bus_freq);
+		}
+
+		writel(rate_mbps,
+		       port->port_base + AM65_CPSW_PN_REG_PRI_EIR(prio));
+	}
+}
+
+static int am65_cpsw_mqprio_verify_shaper(struct am65_cpsw_port *port,
+					  struct tc_mqprio_qopt_offload *mqprio)
+{
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct netlink_ext_ack *extack = mqprio->extack;
+	u64 min_rate_total = 0, max_rate_total = 0;
+	u32 min_rate_msk = 0, max_rate_msk = 0;
+	bool has_min_rate, has_max_rate;
+	int num_tc, i;
+
+	if (!(mqprio->flags & TC_MQPRIO_F_SHAPER))
+		return 0;
+
+	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE)
+		return 0;
+
+	has_min_rate = !!(mqprio->flags & TC_MQPRIO_F_MIN_RATE);
+	has_max_rate = !!(mqprio->flags & TC_MQPRIO_F_MAX_RATE);
+
+	if (!has_min_rate && has_max_rate) {
+		NL_SET_ERR_MSG_MOD(extack, "min_rate is required with max_rate");
+		return -EOPNOTSUPP;
+	}
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
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "TX tc%d rate max>0 but min=0\n",
+						       i);
+				return -EINVAL;
+			}
+
+			if (mqprio->max_rate[i] &&
+			    mqprio->max_rate[i] < mqprio->min_rate[i]) {
+				NL_SET_ERR_MSG_FMT_MOD(extack,
+						       "TX tc%d rate min(%llu)>max(%llu)\n",
+						       i, mqprio->min_rate[i],
+						       mqprio->max_rate[i]);
+				return -EINVAL;
+			}
+		}
+
+		ch_msk = GENMASK(num_tc - 1, i);
+		if ((min_rate_msk & BIT(i)) && (min_rate_msk ^ ch_msk)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Min rate must be set sequentially hi->lo tx_rate_msk%x\n",
+					       min_rate_msk);
+			return -EINVAL;
+		}
+
+		if ((max_rate_msk & BIT(i)) && (max_rate_msk ^ ch_msk)) {
+			NL_SET_ERR_MSG_FMT_MOD(extack,
+					       "Max rate must be set sequentially hi->lo tx_rate_msk%x\n",
+					       max_rate_msk);
+			return -EINVAL;
+		}
+	}
+
+	min_rate_total = TO_MBPS(min_rate_total);
+	max_rate_total = TO_MBPS(max_rate_total);
+
+	p_mqprio->shaper_en = true;
+	p_mqprio->max_rate_total = max_t(u64, min_rate_total, max_rate_total);
+
+	return 0;
+}
+
+static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct am65_cpsw_common *common = port->common;
+
+	p_mqprio->shaper_en = false;
+	p_mqprio->max_rate_total = 0;
+
+	am65_cpsw_tx_pn_shaper_reset(port);
+	netdev_reset_tc(ndev);
+	netif_set_real_num_tx_queues(ndev, common->tx_ch_num);
+
+	/* Reset all Queue priorities to 0 */
+	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+}
+
+static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_mqprio *p_mqprio = &port->qos.mqprio;
+	struct tc_mqprio_qopt_offload *mqprio = type_data;
+	struct am65_cpsw_common *common = port->common;
+	struct tc_mqprio_qopt *qopt = &mqprio->qopt;
+	int tc, offset, count, ret, prio;
+	u8 num_tc = qopt->num_tc;
+	u32 tx_prio_map = 0;
+	int i;
+
+	memcpy(&p_mqprio->mqprio_hw, mqprio, sizeof(*mqprio));
+
+	ret = pm_runtime_get_sync(common->dev);
+	if (ret < 0) {
+		pm_runtime_put_noidle(common->dev);
+		return ret;
+	}
+
+	if (!num_tc) {
+		am65_cpsw_reset_tc_mqprio(ndev);
+		goto exit_put;
+	}
+
+	ret = am65_cpsw_mqprio_verify_shaper(port, mqprio);
+	if (ret)
+		goto exit_put;
+
+	netdev_set_num_tc(ndev, num_tc);
+
+	/* Multiple Linux priorities can map to a Traffic Class
+	 * A Traffic Class can have multiple contiguous Queues,
+	 * Queues get mapped to Channels (thread_id),
+	 *	if not VLAN tagged, thread_id is used as packet_priority
+	 *	if VLAN tagged. VLAN priority is used as packet_priorit
+	 * packet_priority gets mapped to header_priority in p0_rx_pri_map,
+	 * header_priority gets mapped to switch_priority in pn_tx_pri_map.
+	 * As p0_rx_pri_map is left at defaults (0x76543210), we can
+	 * assume that Queue_n gets mapped to header_priority_n. We can then
+	 * set the switch priority in pn_tx_pri_map.
+	 */
+
+	for (tc = 0; tc < num_tc; tc++) {
+		prio = tc;
+
+		/* For simplicity we assign the same priority (TCn) to
+		 * all queues of a Traffic Class.
+		 */
+		for (i = qopt->offset[tc]; i < qopt->offset[tc] + qopt->count[tc]; i++)
+			tx_prio_map |= prio << (4 * i);
+
+		count = qopt->count[tc];
+		offset = qopt->offset[tc];
+		netdev_set_tc_queue(ndev, tc, count, offset);
+	}
+
+	writel(tx_prio_map,
+	       port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+
+	am65_cpsw_tx_pn_shaper_apply(port);
+
+exit_put:
+	pm_runtime_put(common->dev);
+	return 0;
+}
+
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data)
 {
@@ -907,6 +1157,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return am65_cpsw_tc_query_caps(ndev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return am65_cpsw_setup_mqprio(ndev, type_data);
 	case TC_SETUP_BLOCK:
 		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
 	default:
@@ -918,6 +1170,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
@@ -929,11 +1184,12 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = SPEED_UNKNOWN;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 0cc2a3b3d7f9..e4508fe5c2c8 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -9,6 +9,7 @@
 #include <net/pkt_sched.h>
 
 struct am65_cpsw_common;
+struct am65_cpsw_port;
 
 struct am65_cpsw_est {
 	int buf;
@@ -16,6 +17,12 @@ struct am65_cpsw_est {
 	struct tc_taprio_qopt_offload taprio;
 };
 
+struct am65_cpsw_mqprio {
+	struct tc_mqprio_qopt_offload mqprio_hw;
+	u64 max_rate_total;
+	bool shaper_en;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -26,6 +33,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_est *est_oper;
 	ktime_t link_down_time;
 	int link_speed;
+	struct am65_cpsw_mqprio mqprio;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
-- 
2.34.1

