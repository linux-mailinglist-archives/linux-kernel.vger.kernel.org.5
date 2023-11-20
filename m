Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92867F151A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233465AbjKTOC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:02:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233454AbjKTOCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1595419A
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:02:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFD69C433BA;
        Mon, 20 Nov 2023 14:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488933;
        bh=F+WZkIOq6gDCNQjYnBTbK9jjTTI4/56XYNLKv9w1qb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hEFQ8PElKuCA+A06z/flNNlA6UuK42qIylReyYipOsfiRV9oIgktehvCSkDL441T/
         dn/QEDo22lMCl8P6kEOSTKM4EVTFYYyxnig/1Ei9/fCzI1AqcWmHMXsVwwupzD0lED
         aEJlpFhGGp3QQt6z6dpYBaOmDxb2pE/i/Sa2izGdmbOniO0Yt9LvGn9Pd0G8AAcrqZ
         I2H9DBADGzeD2+sfzJrqVGDpcDwMkYEenJ0p5l05QPOVv0JJE+ypm6C+sFPRuNMIR6
         mTRIVJOMx+immdLrijlIig+fOMbLRhgkF2wCArpZyl6lkaMgqXc+5w2pp9u/1riHYk
         XYtWPHcpLq4oQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 5/7] net: ethernet: ti: am65-cpsw: add mqprio qdisc offload in channel mode
Date:   Mon, 20 Nov 2023 16:01:45 +0200
Message-Id: <20231120140147.78726-6-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120140147.78726-1-rogerq@kernel.org>
References: <20231120140147.78726-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/net/ethernet/ti/am65-cpsw-nuss.c |   3 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c  | 274 +++++++++++++++++++++--
 drivers/net/ethernet/ti/am65-cpsw-qos.h  |  20 ++
 3 files changed, 284 insertions(+), 13 deletions(-)

v6:
- fixed typo in comment "packet_priorit"->"packet_priority"
- don't call netif_set_real_num_tx_queues() from am65_cpsw_reset_tc_mqprio()
- reset TX queue priorities to zero at init. AM65_CPSW_PN_REG_TX_PRI_MAP = 0
- don't ignore return value in am65_cpsw_setup_mqprio()

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

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 7992a76ed4d8..38bcbe4b9b98 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2127,6 +2127,9 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 				dev_err(dev, "Use random MAC address\n");
 			}
 		}
+
+		/* Reset all Queue priorities to 0 */
+		writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
 	}
 	of_node_put(node);
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index f0fb11dd9c98..60f625e1350b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -15,12 +15,250 @@
 #include "am65-cpts.h"
 #include "cpsw_ale.h"
 
+#define TO_MBPS(x)	((x) * 8 / 1000000)
+
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static u32
+am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
+{
+	u32 ir;
+
+	bus_freq /= 1000000;
+	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
+	return ir;
+}
+
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
+
+	p_mqprio->shaper_en = false;
+	p_mqprio->max_rate_total = 0;
+
+	am65_cpsw_tx_pn_shaper_reset(port);
+	netdev_reset_tc(ndev);
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
+	int i, tc, offset, count, prio, ret;
+	u8 num_tc = qopt->num_tc;
+	u32 tx_prio_map = 0;
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
+		ret = -EINVAL;
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
+	 *	if VLAN tagged. VLAN priority is used as packet_priority
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
+	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+
+	am65_cpsw_tx_pn_shaper_apply(port);
+
+exit_put:
+	pm_runtime_put(common->dev);
+
+	return ret;
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -404,6 +642,8 @@ static void am65_cpsw_taprio_destroy(struct net_device *ndev)
 
 	port->qos.est_oper = NULL;
 	port->qos.est_admin = NULL;
+
+	am65_cpsw_reset_tc_mqprio(ndev);
 }
 
 static void am65_cpsw_cp_taprio(struct tc_taprio_qopt_offload *from,
@@ -452,6 +692,10 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	if (!est_new)
 		return -ENOMEM;
 
+	ret = am65_cpsw_setup_mqprio(ndev, &taprio->mqprio);
+	if (ret)
+		return ret;
+
 	am65_cpsw_cp_taprio(taprio, &est_new->taprio);
 
 	am65_cpsw_est_update_state(ndev);
@@ -495,6 +739,7 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 	return 0;
 
 fail:
+	am65_cpsw_reset_tc_mqprio(ndev);
 	devm_kfree(&ndev->dev, est_new);
 	return ret;
 }
@@ -505,7 +750,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -549,6 +793,14 @@ static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
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
 
@@ -737,16 +989,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
 					  port, port, true);
 }
 
-static u32
-am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
-{
-	u32 ir;
-
-	bus_freq /= 1000000;
-	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
-	return ir;
-}
-
 static void
 am65_cpsw_qos_tx_p0_rate_apply(struct am65_cpsw_common *common,
 			       int tx_ch, u32 rate_mbps)
@@ -857,6 +1099,8 @@ int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 		return am65_cpsw_tc_query_caps(ndev, type_data);
 	case TC_SETUP_QDISC_TAPRIO:
 		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_QDISC_MQPRIO:
+		return am65_cpsw_setup_mqprio(ndev, type_data);
 	case TC_SETUP_BLOCK:
 		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
 	default:
@@ -868,6 +1112,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
 }
@@ -876,8 +1123,9 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = SPEED_UNKNOWN;
+	am65_cpsw_tx_pn_shaper_apply(port);
+
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
 }
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index d8bccfd48532..a0f9fa2eb2aa 100644
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
@@ -36,6 +44,15 @@ struct am65_cpsw_qos {
 #define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
 #define AM65_CPSW_PN_REG_EST_CTL		0x060
 #define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_P0_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
+
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
 
 /* AM65_CPSW_REG_CTL register fields */
 #define AM65_CPSW_CTL_EST_EN			BIT(18)
@@ -66,6 +83,9 @@ struct am65_cpsw_qos {
 #define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
 #define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
 
+/* number of priority queues per port FIFO */
+#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
+
 #if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
-- 
2.34.1

