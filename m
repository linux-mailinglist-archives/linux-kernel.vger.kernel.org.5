Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE150777C1C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbjHJPZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHJPZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33B226B6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:25:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 828A565F6E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 15:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059E2C433C9;
        Thu, 10 Aug 2023 15:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691681145;
        bh=nuqG3dOuEm9kG4PjTgXCqOezCUXACKr9POWtMFKje+4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRKdDGMIvxbNPogZms7C+dsiVDRkbb4QOg3LgpBCmGhB2THKbpQb1tuzfRxil6uLZ
         0HUkpsz52NBZg6ukXHs68wYWtmYC65m4D2VWhHRPkaCaylPwtSNSaHDvv4CvFV8Jk4
         X9SF9j7Cz/s1k36zVuW2EbcxhBy/apEW5BpmWtyt5pgnnrKi3knIaQwyMcXna8PoIe
         Ewb2jp9SncN4hspJ9OIjwRA+sIbvRHYXIs9OgwLp6K/+JkGCKnmt12EVRvjry749G/
         iQ+DBlMPhLYhd6AJjuHizxJI5kYSSBpWJprEjfX43c/CxMX3adiaX5t1ZhkSpGx49S
         P5rqhWGpT7KOA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, srk@ti.com, vigneshr@ti.com, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v2] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
Date:   Thu, 10 Aug 2023 18:25:38 +0300
Message-Id: <20230810152538.138718-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver support for viewing / changing the MAC Merge sublayer
parameters and seeing the verification state machine's current state
via ethtool.

As hardware does not support interrupt notification for verification
events we resort to polling on link up. On link up we try a couple of
times for verification success and if unsuccessful then give up.

The Frame Preemption feature is described in the Technical Reference
Manual [1] in section:
	12.3.1.4.6.7 Intersperced Express Traffic (IET – P802.3br/D2.0)

Due to Silicon Errata i2208 [2] we set limit min IET fragment size to 124.

[1] AM62x TRM - https://www.ti.com/lit/ug/spruiv7a/spruiv7a.pdf
[2] AM62x Silicon Errata - https://www.ti.com/lit/er/sprz487c/sprz487c.pdf

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---

Hi,

Dropping the RFC tag as I now have MAC merge verification and frame
preemption working.

Changelog:
v2:
- Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
  and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
- Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
  AM65_CPSW_PN_CTL_IET_PORT_EN set.
- Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
- Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
  1G link if link is inactive.
- resize the RX FIFO based on pmac_enabled, not tx_enabled.

Test Procedure:

- 2 EVMs with AM65-CPSW network port connected to each other
- Run iet-setup.sh on both

#!/bin/sh
#iet-setup.sh

ifconfig eth0 down
ifconfig eth1 down
ethtool -L eth0 tx 2
ethtool --set-priv-flags eth0 p0-rx-ptype-rrobin off
ethtool --set-mm eth0 pmac-enabled on tx-enabled on verify-enabled on verify-time 10 tx-min-frag-size 124
ifconfig eth0 up
sleep 10

tc qdisc replace dev eth0 handle 8001: parent root stab overhead 24 taprio \
num_tc 2 \
map 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 \
queues 1@0 1@1 \
base-time 0 \
sched-entry S 01 1216 \
sched-entry S fe 12368 \
flags 0x2 \
fp P E E E E E E E

tc -g class show dev eth0
tc qdisc add dev eth0 clsact
tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5002 0xffff action skbedit priority 2
tc filter add dev eth0 egress protocol ip prio 1 u32 match ip dport 5003 0xffff action skbedit priority 3

- check that MAC merge verification has succeeded

ethtool --show-mm eth0

        MAC Merge layer state for eth0:
        pMAC enabled: on
        TX enabled: on
        TX active: on
        TX minimum fragment size: 124
        RX minimum fragment size: 124
        Verify enabled: on
        Verify time: 10
        Max verify time: 134
        Verification status: SUCCEEDED

- On receiver EVM run 2 iperf instances

iperf3 -s -i30 -p5002&
iperf3 -s -i30 -p5003&

- On sender EVM run 2 iperf instances

iperf3 -c 192.168.3.102 -u -b200M -l1472 -u -t5 -i30 -p5002&
iperf3 -c 192.168.3.102 -u -b50M -l1472 -u -t5 -i30 -p5003&

- Check IET stats on sender. Look for iet_tx_frag increments

ethtool -S eth0 | grep iet

     iet_rx_assembly_err: 0
     iet_rx_assembly_ok: 0
     iet_rx_smd_err: 0
     iet_rx_frag: 0
     iet_tx_hold: 0
     iet_tx_frag: 17307

- Check IET stats on receiver. Look for iet_rx_frag and iet_rx_assembly_*

ethtool -S eth0 | grep iet

     iet_rx_assembly_err: 0
     iet_rx_assembly_ok: 17302
     iet_rx_smd_err: 0
     iet_rx_frag: 17307
     iet_tx_hold: 0
     iet_tx_frag: 0

cheers,
-roger

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 139 ++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 234 ++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-qos.h     |  90 ++++++++
 5 files changed, 433 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index c51e2af91f69..8eb622ffac8e 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 
 #include "am65-cpsw-nuss.h"
+#include "am65-cpsw-qos.h"
 #include "cpsw_ale.h"
 #include "am65-cpts.h"
 
@@ -715,6 +716,142 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
 	return 0;
 }
 
+static void am65_cpsw_port_iet_rx_enable(struct am65_cpsw_port *port, bool enable)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+	if (enable)
+		val |= AM65_CPSW_PN_CTL_IET_PORT_EN;
+	else
+		val &= ~AM65_CPSW_PN_CTL_IET_PORT_EN;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_CTL);
+	am65_cpsw_iet_common_enable(port->common);
+}
+
+static void am65_cpsw_port_iet_tx_enable(struct am65_cpsw_port *port, bool enable)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (enable)
+		val |= AM65_CPSW_PN_IET_MAC_PENABLE;
+	else
+		val &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+}
+
+static int am65_cpsw_get_mm(struct net_device *ndev, struct ethtool_mm_state *state)
+{
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	u32 add_frag_size;
+
+	mutex_lock(&priv->mm_lock);
+
+	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+
+	state->tx_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
+	state->pmac_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
+
+	iet_status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
+
+	if (iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_DISABLED;
+	else if (iet_status & AM65_CPSW_PN_MAC_VERIFIED)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED;
+	else if (iet_status & AM65_CPSW_PN_MAC_VERIFY_FAIL)
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_FAILED;
+	else
+		state->verify_status = ETHTOOL_MM_VERIFY_STATUS_UNKNOWN;
+
+	add_frag_size = AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(iet_ctrl);
+	state->tx_min_frag_size = ethtool_mm_frag_size_add_to_min(add_frag_size);
+
+	/* Errata i2208: RX min fragment size cannot be less than 124 */
+	state->rx_min_frag_size = 124;
+
+	/* FPE active if common tx_enabled and verification success or disabled (forced) */
+	state->tx_active = state->tx_enabled &&
+			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
+
+	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
+							   AM65_CPSW_PN_REG_IET_VERIFY));
+	state->verify_time = port->qos.iet.verify_time_ms;
+	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
+								     port);
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static int am65_cpsw_set_mm(struct net_device *ndev, struct ethtool_mm_cfg *cfg,
+			    struct netlink_ext_ack *extack)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	struct am65_cpsw_iet *iet = &port->qos.iet;
+	u32 val, add_frag_size;
+	int err;
+
+	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
+	if (err)
+		return err;
+
+	mutex_lock(&priv->mm_lock);
+
+	if (cfg->pmac_enabled) {
+		/* change TX & RX FIFO MAX_BLKS as per TRM recommendation */
+		if (!iet->original_max_blks)
+			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+
+		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
+		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+	} else {
+		/* restore RX & TX FIFO MAX_BLKS */
+		if (iet->original_max_blks) {
+			writel(iet->original_max_blks,
+			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+		}
+	}
+
+	am65_cpsw_port_iet_rx_enable(port, cfg->pmac_enabled);
+	am65_cpsw_port_iet_tx_enable(port, cfg->tx_enabled);
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (cfg->verify_enabled) {
+		val &= ~AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
+		/* Reset Verify state machine. Verification won't start here.
+		 * Verification will be done once link-up.
+		 */
+		val |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	} else {
+		val |= AM65_CPSW_PN_IET_MAC_DISABLEVERIFY;
+	}
+
+	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
+	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+	/* verify_timeout_count can only be set at valid link */
+	port->qos.iet.verify_time_ms = cfg->verify_time;
+
+	/* enable/disable pre-emption based on link status */
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
@@ -743,4 +880,6 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_eee		= am65_cpsw_get_eee,
 	.set_eee		= am65_cpsw_set_eee,
 	.nway_reset		= am65_cpsw_nway_reset,
+	.get_mm			= am65_cpsw_get_mm,
+	.set_mm			= am65_cpsw_set_mm,
 };
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index bebcfd5e6b57..b0e2d6773543 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2160,6 +2160,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	ndev_priv = netdev_priv(port->ndev);
 	ndev_priv->port = port;
 	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
+	mutex_init(&ndev_priv->mm_lock);
+	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index bf40c88fbd9b..a7751e2b5b6c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -145,6 +145,7 @@ struct am65_cpsw_common {
 	bool			pf_p0_rx_ptype_rrobin;
 	struct am65_cpts	*cpts;
 	int			est_enabled;
+	bool			iet_enabled;
 
 	bool		is_emac_mode;
 	u16			br_members;
@@ -170,6 +171,10 @@ struct am65_cpsw_ndev_priv {
 	struct am65_cpsw_port	*port;
 	struct am65_cpsw_ndev_stats __percpu *stats;
 	bool offload_fwd_mark;
+	/* Serialize access to MAC Merge state between ethtool requests
+	 * and link state updates
+	 */
+	struct mutex		mm_lock;
 };
 
 #define am65_ndev_to_priv(ndev) \
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index eced87fa261c..29d6cb4bbecb 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -4,9 +4,11 @@
  *
  * quality of service module includes:
  * Enhanced Scheduler Traffic (EST - P802.1Qbv/D2.2)
+ * Interspersed Express Traffic (IET - P802.3br/D2.0)
  */
 
 #include <linux/pm_runtime.h>
+#include <linux/units.h>
 #include <linux/time.h>
 #include <net/pkt_cls.h>
 
@@ -15,47 +17,199 @@
 #include "am65-cpts.h"
 #include "cpsw_ale.h"
 
-#define AM65_CPSW_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_CTL			0x004
-#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
-#define AM65_CPSW_PN_REG_EST_CTL		0x060
-#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
-
-/* AM65_CPSW_REG_CTL register fields */
-#define AM65_CPSW_CTL_EST_EN			BIT(18)
-
-/* AM65_CPSW_PN_REG_CTL register fields */
-#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
-
-/* AM65_CPSW_PN_REG_EST_CTL register fields */
-#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
-#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
-#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
-#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
-#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
-#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
-
-/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
-#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
-#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
-#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
-#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
-#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
-
-/* EST FETCH COMMAND RAM */
-#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
-#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
-#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
-#define AM65_CPSW_FETCH_CNT_OFFSET		8
-#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
-#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
-
 enum timer_act {
 	TACT_PROG,		/* need program timer */
 	TACT_NEED_STOP,		/* need stop first */
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+/* IET */
+static int am65_cpsw_iet_set_verify_timeout_count(struct am65_cpsw_port *port)
+{
+	int verify_time_ms = port->qos.iet.verify_time_ms;
+	int link_speed = port->qos.link_speed;
+	u32 val;
+
+	if (WARN_ON(link_speed == SPEED_UNKNOWN))
+		return -ENODEV;
+
+	/* The number of wireside clocks contained in the verify
+	 * timeout counter. The default is 0x1312d0
+	 * (10ms at 125Mhz in 1G mode).
+	 */
+	val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
+
+	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
+	val *= verify_time_ms;		/* count for timeout ms */
+	if (link_speed < SPEED_1000)
+		val <<= 1;	/* FIXME: Is this correct? */
+
+	if (val > AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
+		return -EINVAL;
+
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_VERIFY);
+
+	return 0;
+}
+
+unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, struct am65_cpsw_port *port)
+{
+	int link_speed = port->qos.link_speed;
+	u32 val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
+	unsigned int timeout_ms;
+
+	if (link_speed == SPEED_UNKNOWN)
+		link_speed = SPEED_1000;
+
+	val /= MILLIHZ_PER_HZ;		/* count per ms timeout */
+
+	timeout_ms = count / val;
+
+	if (link_speed < SPEED_1000)
+		timeout_ms >>= 1;	/* FIXME: Is this correct? */
+
+	return timeout_ms;
+}
+
+static int am65_cpsw_iet_verify_wait(struct am65_cpsw_port *port)
+{
+	u32 ctrl, status;
+	int try;
+
+	try = 20;
+	do {
+		/* Clear MAC_LINKFAIL bit to start Verify. */
+		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+		msleep(port->qos.iet.verify_time_ms);
+
+		status = readl(port->port_base + AM65_CPSW_PN_REG_IET_STATUS);
+		if (status & AM65_CPSW_PN_MAC_VERIFIED)
+			return 0;
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_FAIL) {
+			netdev_dbg(port->ndev,
+				   "MAC Merge verify failed, trying again");
+			/* Reset the verify state machine by writing 1
+			 * to LINKFAIL
+			 */
+			ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+			ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+			continue;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge respond error");
+			return -ENODEV;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge verify error");
+			return -ENODEV;
+		}
+	} while (try-- > 0);
+
+	netdev_dbg(port->ndev, "MAC Merge verify timeout");
+	return -ETIMEDOUT;
+}
+
+static void am65_cpsw_iet_set_preempt_mask(struct am65_cpsw_port *port, u8 preemptible_tcs)
+{
+	u32 val;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	val &= ~AM65_CPSW_PN_IET_MAC_PREMPT_MASK;
+	val |= AM65_CPSW_PN_IET_MAC_SET_PREEMPT(preemptible_tcs);
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+}
+
+/* enable common IET_ENABLE only if at least 1 port has rx IET enabled.
+ * UAPI doesn't allow tx enable without rx enable.
+ */
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common)
+{
+	struct am65_cpsw_port *port;
+	bool rx_enable = false;
+	u32 val;
+	int i;
+
+	for (i = 0; i < common->port_num; i++) {
+		port = &common->ports[i];
+		val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+		rx_enable = !!(val & AM65_CPSW_PN_CTL_IET_PORT_EN);
+		if (rx_enable)
+			break;
+	}
+
+	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+
+	if (rx_enable)
+		val |= AM65_CPSW_CTL_IET_EN;
+	else
+		val &= ~AM65_CPSW_CTL_IET_EN;
+
+	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
+	common->iet_enabled = rx_enable;
+}
+
+/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
+ * (active/inactive), but the preemptible traffic classes should only be
+ * committed to hardware once TX is active. Resort to polling.
+ */
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
+{
+	u8 preemptible_tcs = 0;
+	int err;
+	u32 val;
+
+	if (port->qos.link_speed == SPEED_UNKNOWN)
+		return;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
+		return;
+
+	/* update common IET enable */
+	am65_cpsw_iet_common_enable(port->common);
+
+	/* update verify count */
+	err = am65_cpsw_iet_set_verify_timeout_count(port);
+	if (err) {
+		netdev_err(port->ndev, "couldn't set verify count: %d\n", err);
+		return;
+	}
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	if (!(val & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY)) {
+		err = am65_cpsw_iet_verify_wait(port);
+		if (err)
+			return;
+	}
+
+	preemptible_tcs = port->qos.iet.preemptible_tcs;
+	am65_cpsw_iet_set_preempt_mask(port, preemptible_tcs);
+}
+
+void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
+{
+	port->qos.iet.preemptible_tcs = preemptible_tcs;
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+}
+
+void am65_cpsw_iet_link_state_update(struct net_device *ndev)
+{
+	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(ndev);
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	mutex_lock(&priv->mm_lock);
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+	mutex_unlock(&priv->mm_lock);
+}
+
+/* EST */
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -541,7 +695,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -588,6 +741,8 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 	if (port->qos.link_speed == SPEED_UNKNOWN)
 		return -ENOLINK;
 
+	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
+
 	return am65_cpsw_set_taprio(ndev, type_data);
 }
 
@@ -806,6 +961,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_iet_link_state_update(ndev);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
@@ -817,13 +975,15 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = SPEED_UNKNOWN;
+	am65_cpsw_iet_link_state_update(ndev);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
 
-	port->qos.link_speed = SPEED_UNKNOWN;
 }
 
 static u32
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 0cc2a3b3d7f9..8045ca1519eb 100644
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
 
+struct am65_cpsw_iet {
+	u8 preemptible_tcs;
+	u32 original_max_blks;
+	int verify_time_ms;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -26,6 +33,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_est *est_oper;
 	ktime_t link_down_time;
 	int link_speed;
+	struct am65_cpsw_iet iet;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -38,4 +46,86 @@ void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
 
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
+unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, struct am65_cpsw_port *port);
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
+
+#define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_MAX_BLKS		0x008
+#define AM65_CPSW_PN_REG_IET_CTRL		0x040
+#define AM65_CPSW_PN_REG_IET_STATUS		0x044
+#define AM65_CPSW_PN_REG_IET_VERIFY		0x048
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+
+/* AM65_CPSW_REG_CTL register fields */
+#define AM65_CPSW_CTL_IET_EN			BIT(17)
+#define AM65_CPSW_CTL_EST_EN			BIT(18)
+
+/* AM65_CPSW_PN_REG_CTL register fields */
+#define AM65_CPSW_PN_CTL_IET_PORT_EN		BIT(16)
+#define AM65_CPSW_PN_CTL_EST_PORT_EN		BIT(17)
+
+/* AM65_CPSW_PN_REG_EST_CTL register fields */
+#define AM65_CPSW_PN_EST_ONEBUF			BIT(0)
+#define AM65_CPSW_PN_EST_BUFSEL			BIT(1)
+#define AM65_CPSW_PN_EST_TS_EN			BIT(2)
+#define AM65_CPSW_PN_EST_TS_FIRST		BIT(3)
+#define AM65_CPSW_PN_EST_ONEPRI			BIT(4)
+#define AM65_CPSW_PN_EST_TS_PRI_MSK		GENMASK(7, 5)
+
+/* AM65_CPSW_PN_REG_IET_CTRL register fields */
+#define AM65_CPSW_PN_IET_MAC_PENABLE		BIT(0)
+#define AM65_CPSW_PN_IET_MAC_DISABLEVERIFY	BIT(2)
+#define AM65_CPSW_PN_IET_MAC_LINKFAIL		BIT(3)
+#define AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK	GENMASK(10, 8)
+#define AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET	8
+#define AM65_CPSW_PN_IET_MAC_PREMPT_MASK		GENMASK(23, 16)
+#define AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET		16
+
+#define AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(n)	(((n) << AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET) & \
+						  AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK)
+#define AM65_CPSW_PN_IET_MAC_GET_ADDFRAGSIZE(n)	(((n) & AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK) >> \
+						  AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_OFFSET)
+#define AM65_CPSW_PN_IET_MAC_SET_PREEMPT(n)	(((n) << AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET) & \
+						 AM65_CPSW_PN_IET_MAC_PREMPT_MASK)
+#define AM65_CPSW_PN_IET_MAC_GET_PREEMPT(n)	(((n) & AM65_CPSW_PN_IET_MAC_PREMPT_MASK) >> \
+						 AM65_CPSW_PN_IET_MAC_PREMPT_OFFSET)
+
+/* AM65_CPSW_PN_REG_IET_STATUS register fields */
+#define AM65_CPSW_PN_MAC_STATUS			GENMASK(3, 0)
+#define AM65_CPSW_PN_MAC_VERIFIED		BIT(0)
+#define AM65_CPSW_PN_MAC_VERIFY_FAIL		BIT(1)
+#define AM65_CPSW_PN_MAC_RESPOND_ERR		BIT(2)
+#define AM65_CPSW_PN_MAC_VERIFY_ERR		BIT(3)
+
+/* AM65_CPSW_PN_REG_IET_VERIFY register fields */
+#define AM65_CPSW_PN_MAC_VERIFY_CNT_MASK	GENMASK(23, 0)
+#define AM65_CPSW_PN_MAC_GET_VERIFY_CNT(n)	((n) & AM65_CPSW_PN_MAC_VERIFY_CNT_MASK)
+/* 10 msec converted to NSEC */
+#define AM65_CPSW_IET_VERIFY_CNT_MS		(10)
+#define AM65_CPSW_IET_VERIFY_CNT_NS		(AM65_CPSW_IET_VERIFY_CNT_MS * \
+						 NSEC_PER_MSEC)
+
+/* AM65_CPSW_PN_REG_FIFO_STATUS register fields */
+#define AM65_CPSW_PN_FST_TX_PRI_ACTIVE_MSK	GENMASK(7, 0)
+#define AM65_CPSW_PN_FST_TX_E_MAC_ALLOW_MSK	GENMASK(15, 8)
+#define AM65_CPSW_PN_FST_EST_CNT_ERR		BIT(16)
+#define AM65_CPSW_PN_FST_EST_ADD_ERR		BIT(17)
+#define AM65_CPSW_PN_FST_EST_BUFACT		BIT(18)
+
+/* EST FETCH COMMAND RAM */
+#define AM65_CPSW_FETCH_RAM_CMD_NUM		0x80
+#define AM65_CPSW_FETCH_CNT_MSK			GENMASK(21, 8)
+#define AM65_CPSW_FETCH_CNT_MAX			(AM65_CPSW_FETCH_CNT_MSK >> 8)
+#define AM65_CPSW_FETCH_CNT_OFFSET		8
+#define AM65_CPSW_FETCH_ALLOW_MSK		GENMASK(7, 0)
+#define AM65_CPSW_FETCH_ALLOW_MAX		AM65_CPSW_FETCH_ALLOW_MSK
+
+/* AM65_CPSW_PN_REG_MAX_BLKS fields for IET and No IET cases */
+/* 7 blocks for pn_rx_max_blks, 13 for pn_tx_max_blks*/
+#define AM65_CPSW_PN_TX_RX_MAX_BLKS_IET		0xD07
+
 #endif /* AM65_CPSW_QOS_H_ */
-- 
2.34.1

