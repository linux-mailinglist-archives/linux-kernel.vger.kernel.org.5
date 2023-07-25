Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BFC760BBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbjGYH2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232498AbjGYH1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:27:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30AF1B3
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 00:24:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48E86611F2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 07:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D047C433C8;
        Tue, 25 Jul 2023 07:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690269894;
        bh=MfKIqyR49OGgJlgiyzGRDFQZ8PDG5vzBqsfL+u5EWRo=;
        h=From:To:Cc:Subject:Date:From;
        b=YPAZ3R1LGPO0a2BZjqgH2Jk+XQmAD9zA2ralgwjORqvvkVAEc3Wkk2fl9gyAUYUbm
         3sA53C8edEQTLghPxT6NtJlZ7D/CJ7fTpT8JohNXW2GfURJ6xYpwGSt+4fpM/mfxfu
         o14liXaHVFc0amF/H4Asxx/8rTTANmyWLDNNBhNi0RCoOkkl2BR+N/ipa+HiheSGW+
         HVvX2kO6xLVHa93y9+y0LAk1EKoBs96zzEGYDEx6Ur6XZLW2P+z4jickmHb0h87Lb8
         8yohjjLZp6cjD72lDhBlJwG+De0xOKp9qy9f4x7uBQlQZi+KH+zXRWanUf/XHVGL/k
         hRtFiS65bW3JA==
From:   Roger Quadros <rogerq@kernel.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, vladimir.oltean@nxp.com
Cc:     s-vadapalli@ti.com, srk@ti.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [RFC PATCH] net: ethernet: ti: am65-cpsw-qos: Add Frame Preemption MAC Merge support
Date:   Tue, 25 Jul 2023 10:23:38 +0300
Message-Id: <20230725072338.20789-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
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

Hi,

This is RFC because I've still not got Verification to work and I'm still
clueless on how to set the preemptible mask to set the preemtible
queues. The driver doesn't yet support MQPRIO offloading.

Please let me know if overall approach is OK. Thanks.

cheers,
-roger

 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 168 ++++++++++++++++
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |   2 +
 drivers/net/ethernet/ti/am65-cpsw-nuss.h    |   5 +
 drivers/net/ethernet/ti/am65-cpsw-qos.c     | 212 ++++++++++++++++----
 drivers/net/ethernet/ti/am65-cpsw-qos.h     |  90 +++++++++
 5 files changed, 440 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index c51e2af91f69..fd2ba29ebc0b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -11,6 +11,7 @@
 #include <linux/pm_runtime.h>
 
 #include "am65-cpsw-nuss.h"
+#include "am65-cpsw-qos.h"
 #include "cpsw_ale.h"
 #include "am65-cpts.h"
 
@@ -715,6 +716,171 @@ static int am65_cpsw_set_ethtool_priv_flags(struct net_device *ndev, u32 flags)
 	return 0;
 }
 
+/* enable common IET only if at least 1 port has pre-emptible queues. disable otherwise */
+static void am65_cpsw_iet_enable(struct am65_cpsw_common *common)
+{
+	u32 common_enable = 0;
+	u32 val;
+	int i;
+
+	for (i = 0; i < common->port_num; i++)
+		common_enable |= common->ports[i].qos.iet.preemptible_tcs;
+
+	val = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+
+	if (common_enable)
+		val |= AM65_CPSW_CTL_IET_EN;
+	else
+		val &= ~AM65_CPSW_CTL_IET_EN;
+
+	writel(val, common->cpsw_base + AM65_CPSW_REG_CTL);
+	common->iet_enabled = common_enable;
+}
+
+static void am65_cpsw_iet_port_enable(struct am65_cpsw_port *port, bool enable)
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
+}
+
+static void am65_cpsw_iet_mac_penable(struct am65_cpsw_port *port, bool enable)
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
+	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
+	struct am65_cpsw_ndev_priv *priv = netdev_priv(ndev);
+	u32 port_ctrl, cmn_ctrl, iet_ctrl, iet_status, verify_cnt;
+	u32 add_frag_size;
+
+	mutex_lock(&priv->mm_lock);
+
+	iet_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	cmn_ctrl = readl(common->cpsw_base + AM65_CPSW_REG_CTL);
+	port_ctrl = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+
+	state->pmac_enabled = !!(iet_ctrl & AM65_CPSW_PN_IET_MAC_PENABLE);
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
+	state->rx_min_frag_size = state->tx_min_frag_size;
+
+	state->tx_enabled = !!(port_ctrl & AM65_CPSW_PN_CTL_IET_PORT_EN);
+
+	/* FPE active if common IET enabled and verification success or disabled (forced) */
+	state->tx_active = state->tx_enabled && !!(cmn_ctrl & AM65_CPSW_CTL_IET_EN) &&
+			   (state->verify_status == ETHTOOL_MM_VERIFY_STATUS_SUCCEEDED ||
+			    state->verify_status == ETHTOOL_MM_VERIFY_STATUS_DISABLED);
+	state->verify_enabled = !(iet_ctrl & AM65_CPSW_PN_IET_MAC_DISABLEVERIFY);
+
+	verify_cnt = AM65_CPSW_PN_MAC_GET_VERIFY_CNT(readl(port->port_base +
+							   AM65_CPSW_PN_REG_IET_VERIFY));
+	state->verify_time = port->qos.iet.verify_time_ms;
+	state->max_verify_time = am65_cpsw_iet_get_verify_timeout_ms(AM65_CPSW_PN_MAC_VERIFY_CNT_MASK,
+								     SPEED_1000);
+
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
+	/* Errata i2208: min fragment size cannot be less than 124 */
+	if (cfg->tx_min_frag_size < 124) {
+		netdev_err(ndev, "tx_min_fragment_size cannot be less than 124\n");
+		return -EINVAL;
+	}
+
+	err = ethtool_mm_frag_size_min_to_add(cfg->tx_min_frag_size, &add_frag_size, extack);
+	if (err)
+		return err;
+
+	mutex_lock(&priv->mm_lock);
+
+	if (cfg->tx_enabled) {
+		/* For IET, Change MAX_BLKS */
+		if (!iet->original_max_blks)
+			iet->original_max_blks = readl(port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+
+		writel(AM65_CPSW_PN_TX_RX_MAX_BLKS_IET,
+		       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+	} else {
+		/* restore MAX_BLKS to default */
+		if (iet->original_max_blks) {
+			writel(iet->original_max_blks,
+			       port->port_base + AM65_CPSW_PN_REG_MAX_BLKS);
+		}
+	}
+
+	am65_cpsw_iet_port_enable(port, cfg->tx_enabled);
+	am65_cpsw_iet_mac_penable(port, cfg->tx_enabled);
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
+	/* iet common enable/disable */
+	am65_cpsw_iet_enable(port->common);
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
@@ -743,4 +909,6 @@ const struct ethtool_ops am65_cpsw_ethtool_ops_slave = {
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
index bf40c88fbd9b..ede3a7457e9c 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.h
@@ -145,6 +145,7 @@ struct am65_cpsw_common {
 	bool			pf_p0_rx_ptype_rrobin;
 	struct am65_cpts	*cpts;
 	int			est_enabled;
+	int			iet_enabled;
 
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
index 3a908db6e5b2..ae30d5c79be8 100644
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
 
@@ -15,47 +17,176 @@
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
+	int link_speed = port->qos.link_speed;
+	int verify_time_ms = port->qos.iet.verify_time_ms;
+	u32 val;
+
+	if (link_speed == SPEED_UNKNOWN) {
+		netdev_err(port->ndev, "%s called without active link\n", __func__);
+		return -ENODEV;
+	}
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
+unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, int link_speed)
+{
+	unsigned int timeout_ms;
+	u32 val = 125 * HZ_PER_MHZ;	/* assuming 125MHz wireside clock */
+
+	if (link_speed == SPEED_UNKNOWN)
+		return -EINVAL;
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
+	ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+	/* Clear MAC_PENABLE */
+	ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
+	writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+
+	try = 20;
+	do {
+		/* Set MAC_PENABLE and Clear MAC_LINKFAIL bit to start Verify. */
+		ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+		ctrl &= ~AM65_CPSW_PN_IET_MAC_LINKFAIL;
+		ctrl |= AM65_CPSW_PN_IET_MAC_PENABLE;
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
+				   "MM MAC verify failed, trying again");
+			/* Reset the verify state machine by writing 1
+			 * to LINKFAIL and 0 to MAC_PENABLE
+			 */
+			ctrl = readl(port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+			ctrl &= ~AM65_CPSW_PN_IET_MAC_PENABLE;
+			ctrl |= AM65_CPSW_PN_IET_MAC_LINKFAIL;
+			writel(ctrl, port->port_base + AM65_CPSW_PN_REG_IET_CTRL);
+			continue;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_RESPOND_ERR) {
+			netdev_err(port->ndev, "MM MAC respond error");
+			return -ENODEV;
+		}
+
+		if (status & AM65_CPSW_PN_MAC_VERIFY_ERR) {
+			netdev_err(port->ndev, "MM MAC verify error");
+			return -ENODEV;
+		}
+	} while (try-- > 0);
+
+	netdev_info(port->ndev, "MM MAC verify timeout");
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
+/* CPSW does not have an IRQ to notify changes to the MAC Merge TX status
+ * (active/inactive), but the preemptible traffic classes should only be
+ * committed to hardware once TX is active. Resort to polling.
+ */
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port)
+{
+	u8 preemptible_tcs = 0;
+	u32 val;
+	int err;
+
+	if (port->qos.link_speed == SPEED_UNKNOWN)
+		goto out;
+
+	val = readl(port->port_base + AM65_CPSW_PN_REG_CTL);
+	if (!(val & AM65_CPSW_PN_CTL_IET_PORT_EN))
+		goto out;
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
+			goto out;
+	}
+
+	preemptible_tcs = port->qos.iet.preemptible_tcs;
+out:
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
@@ -541,7 +672,6 @@ static void am65_cpsw_est_link_up(struct net_device *ndev, int link_speed)
 	ktime_t cur_time;
 	s64 delta;
 
-	port->qos.link_speed = link_speed;
 	if (!am65_cpsw_port_est_enabled(port))
 		return;
 
@@ -565,10 +695,13 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 	struct am65_cpsw_common *common = port->common;
+	struct tc_taprio_qopt_offload *taprio = type_data;
 
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return -ENODEV;
 
+	am65_cpsw_iet_change_preemptible_tcs(port, taprio->mqprio.preemptible_tcs);
+
 	if (!netif_running(ndev)) {
 		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
 		return -ENETDOWN;
@@ -801,6 +934,9 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
+	port->qos.link_speed = link_speed;
+	am65_cpsw_iet_link_state_update(ndev);
+
 	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
 		return;
 
@@ -812,13 +948,15 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
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
index 0cc2a3b3d7f9..2cfb18e6587d 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -9,6 +9,7 @@
 #include <net/pkt_sched.h>
 
 struct am65_cpsw_common;
+struct am65_cpsw_port;
 
 struct am65_cpsw_est {
 	int buf;
@@ -16,6 +17,13 @@ struct am65_cpsw_est {
 	struct tc_taprio_qopt_offload taprio;
 };
 
+struct am65_cpsw_iet {
+	struct ethtool_mm_cfg *cfg;
+	u8 preemptible_tcs;
+	u32 original_max_blks;
+	int verify_time_ms;
+};
+
 struct am65_cpsw_ale_ratelimit {
 	unsigned long cookie;
 	u64 rate_packet_ps;
@@ -26,6 +34,7 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_est *est_oper;
 	ktime_t link_down_time;
 	int link_speed;
+	struct am65_cpsw_iet iet;
 
 	struct am65_cpsw_ale_ratelimit ale_bc_ratelimit;
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
@@ -38,4 +47,85 @@ void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
 
+void am65_cpsw_iet_commit_preemptible_tcs(struct am65_cpsw_port *port);
+unsigned int am65_cpsw_iet_get_verify_timeout_ms(u32 count, int link_speed);
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

