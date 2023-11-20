Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC37F151D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjKTOCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233538AbjKTOCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:02:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E412139
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 06:02:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D425EC433C7;
        Mon, 20 Nov 2023 14:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700488937;
        bh=eA5hiWxnZdZiwyYdVdCKVpAIx6p6OeEAGEN2hFmuZSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dbM/KGjy2GiIlimMf/Xpe78B5FAB8II56cVsLGYDoc11P8pE9ihYzM/6NKuuT+ViB
         I8GTK7Dg8nkBMhvX0GchkehNasWogUYgHCXgE6T4xZWeVvSpDz7cLVRjxtyeVqmwz5
         ifYDO62v7fazAyosTZ8bysQdOr4rLn7i79X+ncwfWddvJ+895TEK6qGyLpDvywELpS
         x9c6hGVxXbe+/pMMHYFcxLGsWyhbFsc+cqjd5cizVTdlCmoTO88ue+HhsUbHBL+Ddu
         w5JsNCITl3G84gjS0S01my8nDa6ncOSld1enTexVswrLNnKlMgkmgGhaFff7+yhVP+
         BzqSyDUwKsXnQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     vladimir.oltean@nxp.com, s-vadapalli@ti.com, r-gunasekaran@ti.com,
        vigneshr@ti.com, srk@ti.com, horms@kernel.org, p-varis@ti.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 6/7] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
Date:   Mon, 20 Nov 2023 16:01:46 +0200
Message-Id: <20231120140147.78726-7-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120140147.78726-1-rogerq@kernel.org>
References: <20231120140147.78726-1-rogerq@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 155 +++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 200 ++++++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-qos.h     | 103 ++++++++++
 5 files changed, 465 insertions(+)

Changelog:

v6:
- get mutex around am65_cpsw_iet_commit_preemptible_tcs() in
  am65_cpsw_iet_change_preemptible_tcs()
- use "preemption" instead of "pre-emption"
- call am65_cpsw_setup_mqprio() from within am65_cpsw_setup_taprio()
- Now works with kselftest except the last test which fails

root@am62xx:~/kselftest# ./run_kselftest.sh -t net/forwarding:ethtool_mm.sh
# TEST: Manual configuration with verification: eth0 to eth1          [ OK ]
# TEST: Manual configuration with verification: eth1 to eth0          [ OK ]
# TEST: Manual configuration without verification: eth0 to eth1       [ OK ]
# TEST: Manual configuration without verification: eth1 to eth0       [ OK ]
# TEST: Manual configuration with failed verification: eth0 to eth1   [ OK ]
# TEST: Manual configuration with failed verification: eth1 to eth0   [ OK ]
# Warning: Stopping lldpad.service, but it can still be activated by:
#   lldpad.socket
# TEST: LLDP                                                          [FAIL]
#       eth0 pMAC TX is not active

v5:
- No change

v4:
- Rebase and include in the same series as mqprio support.

v3:
- Rebase on top of v6.6-rc1 and mqprio support [1]
- Support ethtool_ops :: get_mm_stats()
- drop unused variables cmn_ctrl and verify_cnt
- make am65_cpsw_iet_link_state_update() and
  am65_cpsw_iet_change_preemptible_tcs() static

[1] https://lore.kernel.org/all/20230918075358.5878-1-rogerq@kernel.org/

v2:
- Use proper control bits for PMAC enable (AM65_CPSW_PN_CTL_IET_PORT_EN)
  and TX enable (AM65_CPSW_PN_IET_MAC_PENABLE)
- Common IET Enable (AM65_CPSW_CTL_IET_EN) is set if any port has
  AM65_CPSW_PN_CTL_IET_PORT_EN set.
- Fix workaround for erratum i2208. i.e. Limit rx_min_frag_size to 124
- Fix am65_cpsw_iet_get_verify_timeout_ms() to default to timeout for
  1G link if link is inactive.
- resize the RX FIFO based on pmac_enabled, not tx_enabled.

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index b9e1d568604b..6af00640e99c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 
 #include "am65-cpsw-nuss.h"
+#include "am65-cpsw-qos.h"
 #include "cpsw_ale.h"
 #include "am65-cpts.h"
 
@@ -740,6 +741,157 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
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
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	u32 port_ctrl, iet_ctrl, iet_status;
+	u32 add_frag_size;
+
+	mutex_lock(&priv->mm_lock);
+
+	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
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
+		/* Clear LINKFAIL to allow verify/response packets */
+		val &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+	}
+
+	val &= ~AM65_CPSW_PN_IET_MAC_MAC_ADDFRAGSIZE_MASK;
+	val |= AM65_CPSW_PN_IET_MAC_SET_ADDFRAGSIZE(add_frag_size);
+	writel(val, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+	/* verify_timeout_count can only be set at valid link */
+	if (cfg->verify_time > 0)
+		port->qos.iet.verify_time_ms = cfg->verify_time;
+	else
+		port->qos.iet.verify_time_ms = 10;
+
+	/* enable/disable preemption based on link status */
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+
+	mutex_unlock(&priv->mm_lock);
+
+	return 0;
+}
+
+static void am65_cpsw_get_mm_stats(struct net_device *ndev,
+				   struct ethtool_mm_stats *s)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+	void __iomem *base = port->stat_base;
+
+	s->MACMergeFrameAssOkCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_OK);
+	s->MACMergeFrameAssErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_ASSEMBLY_ERROR);
+	s->MACMergeFrameSmdErrorCount = readl(base + AM65_CPSW_STATN_IET_RX_SMD_ERROR);
+	s->MACMergeFragCountRx = readl(base + AM65_CPSW_STATN_IET_RX_FRAG);
+	s->MACMergeFragCountTx = readl(base + AM65_CPSW_STATN_IET_TX_FRAG);
+	s->MACMergeHoldCount = readl(base + AM65_CPSW_STATN_IET_TX_HOLD);
+}
+
 const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.begin			= am65_cpsw_ethtool_op_begin,
 	.complete		= am65_cpsw_ethtool_op_complete,
@@ -769,4 +921,7 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
 	.get_eee		= am65_cpsw_get_eee,
 	.set_eee		= am65_cpsw_set_eee,
 	.nway_reset		= am65_cpsw_nway_reset,
+	.get_mm			= am65_cpsw_get_mm,
+	.set_mm			= am65_cpsw_set_mm,
+	.get_mm_stats		= am65_cpsw_get_mm_stats,
 };
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 38bcbe4b9b98..594f95c9415c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2194,6 +2194,8 @@ am65_cpsw_nuss_init_port_ndev(struct am65_cpsw_common *common, u32 port_idx)
 	ndev_priv = netdev_priv(port->ndev);
 	ndev_priv->port = port;
 	ndev_priv->msg_enable = AM65_CPSW_DEBUG;
+	mutex_init(&ndev_priv->mm_lock);
+	port->qos.link_speed = SPEED_UNKNOWN;
 	SET_NETDEV_DEV(port->ndev, dev);
 
 	eth_hw_addr_set(port->ndev, port->slave.mac_addr);
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.h b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
index f3dad2ab9828..1e4a045057fc 100644
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
index 60f625e1350b..8443c13c9ff6 100644
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
 
@@ -23,6 +25,8 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs);
+
 static u32
 am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
 {
@@ -190,6 +194,8 @@ static void am65_cpsw_reset_tc_mqprio(struct net_device *ndev)
 
 	/* Reset all Queue priorities to 0 */
 	writel(0, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
+
+	am65_cpsw_iet_change_preemptible_tcs(port, 0);
 }
 
 static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
@@ -252,6 +258,7 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
 	writel(tx_prio_map, port->port_base + AM65_CPSW_PN_REG_TX_PRI_MAP);
 
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_change_preemptible_tcs(port, mqprio->preemptible_tcs);
 
 exit_put:
 	pm_runtime_put(common->dev);
@@ -259,6 +266,196 @@ static int am65_cpsw_setup_mqprio(struct net_device *ndev, void *type_data)
 	return ret;
 }
 
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
+		/* Reset the verify state machine by writing 1
+		 * to LINKFAIL
+		 */
+		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+		ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+		writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
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
+				   "MAC Merge verify failed, trying again\n");
+			continue;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge respond error\n");
+			return -ENODEV;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
+			netdev_dbg(port->ndev, "MAC Merge verify error\n");
+			return -ENODEV;
+		}
+	} while (try-- > 0);
+
+	netdev_dbg(port->ndev, "MAC Merge verify timeout\n");
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
+static void am65_cpsw_iet_change_preemptible_tcs(struct am65_cpsw_port *port, u8 preemptible_tcs)
+{
+	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(port->ndev);
+
+	port->qos.iet.preemptible_tcs = preemptible_tcs;
+	mutex_lock(&priv->mm_lock);
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+	mutex_unlock(&priv->mm_lock);
+}
+
+static void am65_cpsw_iet_link_state_update(struct net_device *ndev)
+{
+	struct am65_cpsw_ndev_priv *priv = am65_ndev_to_priv(ndev);
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	mutex_lock(&priv->mm_lock);
+	am65_cpsw_iet_commit_preemptible_tcs(port);
+	mutex_unlock(&priv->mm_lock);
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -735,6 +932,7 @@ static int am65_cpsw_taprio_replace(struct net_device *ndev,
 
 	devm_kfree(&ndev->dev, port->qos.est_admin);
 	port->qos.est_admin = est_new;
+	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
 
 	return 0;
 
@@ -1114,6 +1312,7 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 
 	port->qos.link_speed = link_speed;
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_link_state_update(ndev);
 
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
@@ -1125,6 +1324,7 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 
 	port->qos.link_speed = SPEED_UNKNOWN;
 	am65_cpsw_tx_pn_shaper_apply(port);
+	am65_cpsw_iet_link_state_update(ndev);
 
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index a0f9fa2eb2aa..349f7030fc27 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -23,6 +23,12 @@ struct am65_cpsw_mqprio {
 	bool shaper_en;
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
@@ -34,6 +40,7 @@ struct am65_cpsw_qos {
 	ktime_t link_down_time;
 	int link_speed;
 	struct am65_cpsw_mqprio mqprio;
+	struct am65_cpsw_iet iet;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -119,4 +126,100 @@ static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common
 { }
 #endif
 
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
+unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, struct am65_cpsw_port *port);
+void am65_cpsw_iet_common_enable(struct am65_cpsw_common *common);
+
+#define AM65_CPSW_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_CTL			0x004
+#define AM65_CPSW_PN_REG_MAX_BLKS		0x008
+#define AM65_CPSW_PN_REG_TX_PRI_MAP		0x018
+#define AM65_CPSW_PN_REG_RX_PRI_MAP		0x020
+#define AM65_CPSW_PN_REG_IET_CTRL		0x040
+#define AM65_CPSW_PN_REG_IET_STATUS		0x044
+#define AM65_CPSW_PN_REG_IET_VERIFY		0x048
+#define AM65_CPSW_PN_REG_FIFO_STATUS		0x050
+#define AM65_CPSW_PN_REG_EST_CTL		0x060
+#define AM65_CPSW_PN_REG_PRI_CIR(pri)		(0x140 + 4 * (pri))
+#define AM65_CPSW_PN_REG_PRI_EIR(pri)		(0x160 + 4 * (pri))
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
+/* Slave IET Stats. register offsets */
+#define AM65_CPSW_STATN_IET_RX_ASSEMBLY_ERROR	0x140
+#define AM65_CPSW_STATN_IET_RX_ASSEMBLY_OK	0x144
+#define AM65_CPSW_STATN_IET_RX_SMD_ERROR	0x148
+#define AM65_CPSW_STATN_IET_RX_FRAG		0x14c
+#define AM65_CPSW_STATN_IET_TX_HOLD		0x150
+#define AM65_CPSW_STATN_IET_TX_FRAG		0x154
+
+/* number of priority queues per port FIFO */
+#define AM65_CPSW_PN_FIFO_PRIO_NUM		8
+
 #endif /* AM65_CPSW_QOS_H_ */
-- 
2.34.1

