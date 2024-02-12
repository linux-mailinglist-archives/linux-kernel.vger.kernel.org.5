Return-Path: <linux-kernel+bounces-62108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F28A4851B99
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21A191C22682
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4752F40BFE;
	Mon, 12 Feb 2024 17:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="D0A+cy/o"
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4793F8D4;
	Mon, 12 Feb 2024 17:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707759199; cv=none; b=J5Rmy+BolvXcdtt4WVey86QGzS7eT/Gk0VpfTRgPN4L0lVbDdINXdWKSMlgedqx8jYN3oe1Fyga9/5CFB+oyqtWg/1RPoHRGzcDbwHgp8TwbM4K3f0aagkZ7ExsgkcjIyM12z2cr9riBaGerS31fIYtQaofw/gHFmBkOfKjXqpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707759199; c=relaxed/simple;
	bh=5h8IWuTSESiWFfmI1p8CkNvQsUowk7KD++wOxjb+s7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z+PcmdXgESD7NbfnCTTa4UshbrbDapHns/GzJeW+JYZp0hg6Mni3RVgtaR7oE/ruUh7odoxK8jtFo1jFQx1VCOLfDX1Z1bM8RN+oow+WKGQ8pKIelpGrRU3aWEk1Gxkn+HKttvkC6gt0CJvoAtyPa2t4q1RvuGltILonLMKSHpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=D0A+cy/o; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 11E2824000A;
	Mon, 12 Feb 2024 17:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1707759192;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v+YUK4apRt2uyYbWF3+sTLg8L3Qd7WpAozV+6bwd8jg=;
	b=D0A+cy/occB8qnr/DDM3Z6zeemP0X4p2oaGhrfRjFl7A5s5HX4tR7PKiatFlKzeEsLFooZ
	KaNhMrozN8vt4PT0h8MbayvrILTf29KY4oLlUzSKgJMoegfKLtDX9yRrGBIh5Yn2AOqGgx
	GCnW7uoQ5maZQFA3lE5dEMk9uUv+E5eyH+nnVt5YxnHxZR6hRu4vCMX8zXq32vm7GTRhBZ
	9+xSkGx9rusIS4J7039aRw2ljN/P31jgd0UHzdI35nvCAnM/cRDJJdEknOkO3BQCf/o6tL
	mufNIow5mv/ukA5HG+9KuXHbGNK32ZxI/hPqrXGY+tpDPc5T2JeHkMVJ8VT35g==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	=?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>
Subject: [PATCH net-next 2/3] net: lan966x: Allow using PCH extension for PTP
Date: Mon, 12 Feb 2024 18:33:05 +0100
Message-ID: <20240212173307.1124120-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
References: <20240212173307.1124120-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

This commit adds the logic to use the PCH mode for timestamp passing in
ingress traffic for PTP. The tricky part is that we need to configure
both the PHY and the MAC, since the MAC will extract the timetsamp
reported by the PHY from the preamble and set it into the SKB.

Note that with the PCH mode, we only get the RX timestamp that way, the
TX timestamps are still reported OOB by the PHY.

Note that only the nanoseconds part is extracted from the PCH extension,
since there's not enough room in the 4 bytes extension to pass a full
80bits timestamp. The seconds part of the timestamp still needs to get
retrieved from the PHY using an out-of-band mechanism.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 .../ethernet/microchip/lan966x/lan966x_main.h |  1 +
 .../ethernet/microchip/lan966x/lan966x_port.c | 12 +++
 .../ethernet/microchip/lan966x/lan966x_ptp.c  | 94 +++++++++++++++++--
 .../ethernet/microchip/lan966x/lan966x_regs.h | 64 +++++++++++++
 4 files changed, 161 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
index caa9e0533c96..0aca85be02ac 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_main.h
@@ -302,6 +302,7 @@ struct lan966x_phc {
 	struct kernel_hwtstamp_config hwtstamp_config;
 	struct lan966x *lan966x;
 	u8 index;
+	bool pch;
 };
 
 struct lan966x_skb_cb {
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
index 2e83bbb9477e..cf432d797ce6 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_port.c
@@ -363,6 +363,18 @@ int lan966x_port_pcs_set(struct lan966x_port *port,
 		DEV_PCS1G_MODE_CFG_SAVE_PREAMBLE_ENA,
 		lan966x, DEV_PCS1G_MODE_CFG(port->chip_port));
 
+	if (full_preamble) {
+		lan_rmw(DEV_ENABLE_CONFIG_MM_TX_ENA_SET(1) |
+			DEV_ENABLE_CONFIG_MM_RX_ENA_SET(1),
+			DEV_ENABLE_CONFIG_MM_TX_ENA |
+			DEV_ENABLE_CONFIG_MM_RX_ENA,
+			lan966x, DEV_ENABLE_CONFIG(port->chip_port));
+
+		lan_rmw(SYS_PTP_MODE_CFG_PTP_MODE_VAL_SET(1),
+			SYS_PTP_MODE_CFG_PTP_MODE_VAL,
+			lan966x, SYS_PTP_MODE_CFG(port->chip_port, 0));
+	}
+
 	/* Enable PCS */
 	lan_wr(DEV_PCS1G_CFG_PCS_ENA_SET(1),
 	       lan966x, DEV_PCS1G_CFG(port->chip_port));
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
index 63905bb5a63a..4d8c865eda90 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_ptp.c
@@ -257,11 +257,47 @@ int lan966x_ptp_setup_traps(struct lan966x_port *port,
 		return lan966x_ptp_add_traps(port);
 }
 
+/* Enable or disable PCH timestamp transmission. This uses the USGMII PCH
+ * extensions to transmit the timestamps in the frame preamble.
+ */
+static void lan966x_ptp_pch_configure(struct lan966x_port *port, bool *enable)
+{
+	struct phy_device *phydev = port->dev->phydev;
+	int ret;
+
+	if (!phydev)
+		*enable = false;
+
+	if (*enable) {
+		/* If we cannot enable inband PCH mode, we fallback to classic
+		 * timestamping
+		 */
+		if (phy_inband_ext_available(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP)) {
+			ret = phy_inband_ext_enable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
+			if (ret)
+				*enable = false;
+		} else {
+			*enable = false;
+		}
+	} else {
+		phy_inband_ext_disable(phydev, PHY_INBAND_EXT_PCH_TIMESTAMP);
+	}
+
+	lan_rmw(SYS_PCH_CFG_PCH_SUB_PORT_ID_SET(port->chip_port % 4) |
+		SYS_PCH_CFG_PCH_TX_MODE_SET(*enable) |
+		SYS_PCH_CFG_PCH_RX_MODE_SET(*enable),
+		SYS_PCH_CFG_PCH_SUB_PORT_ID |
+		SYS_PCH_CFG_PCH_TX_MODE |
+		SYS_PCH_CFG_PCH_RX_MODE,
+		port->lan966x, SYS_PCH_CFG(port->chip_port));
+}
+
 int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
 			     struct kernel_hwtstamp_config *cfg,
 			     struct netlink_ext_ack *extack)
 {
 	struct lan966x *lan966x = port->lan966x;
+	bool timestamp_in_pch = false;
 	struct lan966x_phc *phc;
 
 	switch (cfg->tx_type) {
@@ -303,10 +339,18 @@ int lan966x_ptp_hwtstamp_set(struct lan966x_port *port,
 		return -ERANGE;
 	}
 
+	if (cfg->source == HWTSTAMP_SOURCE_PHYLIB &&
+	    cfg->tx_type == HWTSTAMP_TX_ON &&
+	    port->config.portmode == PHY_INTERFACE_MODE_QUSGMII)
+		timestamp_in_pch = true;
+
+	lan966x_ptp_pch_configure(port, &timestamp_in_pch);
+
 	/* Commit back the result & save it */
 	mutex_lock(&lan966x->ptp_lock);
 	phc = &lan966x->phc[LAN966X_PHC_PORT];
 	phc->hwtstamp_config = *cfg;
+	phc->pch = timestamp_in_pch;
 	mutex_unlock(&lan966x->ptp_lock);
 
 	return 0;
@@ -397,6 +441,7 @@ int lan966x_ptp_txtstamp_request(struct lan966x_port *port,
 	LAN966X_SKB_CB(skb)->jiffies = jiffies;
 
 	lan966x->ptp_skbs++;
+
 	port->ts_id++;
 	if (port->ts_id == LAN966X_MAX_PTP_ID)
 		port->ts_id = 0;
@@ -500,6 +545,27 @@ irqreturn_t lan966x_ptp_irq_handler(int irq, void *args)
 		/* Read RX timestamping to get the ID */
 		id = lan_rd(lan966x, PTP_TWOSTEP_STAMP);
 
+		/* If PCH is enabled, there is a "feature" that also the MAC
+		 * will generate an interrupt for transmitted frames. This
+		 * interrupt should be ignored, so clear the allocated resources
+		 * and try to get the next timestamp. Maybe should clean the
+		 * resources on the TX side?
+		 */
+		if (phy_inband_ext_enabled(port->dev->phydev,
+					   PHY_INBAND_EXT_PCH_TIMESTAMP)) {
+			spin_lock(&lan966x->ptp_ts_id_lock);
+			lan966x->ptp_skbs--;
+			spin_unlock(&lan966x->ptp_ts_id_lock);
+
+			dev_kfree_skb_any(skb_match);
+
+			lan_rmw(PTP_TWOSTEP_CTRL_NXT_SET(1),
+				PTP_TWOSTEP_CTRL_NXT,
+				lan966x, PTP_TWOSTEP_CTRL);
+
+			continue;
+		}
+
 		spin_lock_irqsave(&port->tx_skbs.lock, flags);
 		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
 			if (LAN966X_SKB_CB(skb)->ts_id != id)
@@ -1088,19 +1154,27 @@ void lan966x_ptp_rxtstamp(struct lan966x *lan966x, struct sk_buff *skb,
 	struct timespec64 ts;
 	u64 full_ts_in_ns;
 
+	phc = &lan966x->phc[LAN966X_PHC_PORT];
+
 	if (!lan966x->ptp ||
-	    !lan966x->ports[src_port]->ptp_rx_cmd)
+	    !lan966x->ports[src_port]->ptp_rx_cmd ||
+	    !phc->pch)
 		return;
 
-	phc = &lan966x->phc[LAN966X_PHC_PORT];
-	lan966x_ptp_gettime64(&phc->info, &ts);
-
-	/* Drop the sub-ns precision */
-	timestamp = timestamp >> 2;
-	if (ts.tv_nsec < timestamp)
-		ts.tv_sec--;
-	ts.tv_nsec = timestamp;
-	full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
+	if (phc->pch) {
+		/* Drop the sub-ns precision */
+		timestamp = timestamp >> 2;
+		full_ts_in_ns = lower_32_bits(timestamp);
+	} else {
+		lan966x_ptp_gettime64(&phc->info, &ts);
+
+		/* Drop the sub-ns precision */
+		timestamp = timestamp >> 2;
+		if (ts.tv_nsec < timestamp)
+			ts.tv_sec--;
+		ts.tv_nsec = timestamp;
+		full_ts_in_ns = ktime_set(ts.tv_sec, ts.tv_nsec);
+	}
 
 	shhwtstamps = skb_hwtstamps(skb);
 	shhwtstamps->hwtstamp = full_ts_in_ns;
diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
index 4b553927d2e0..bf4df025925e 100644
--- a/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
+++ b/drivers/net/ethernet/microchip/lan966x/lan966x_regs.h
@@ -937,6 +937,27 @@ enum lan966x_target {
 #define DEV_PCS1G_STICKY_LINK_DOWN_STICKY_GET(x)\
 	FIELD_GET(DEV_PCS1G_STICKY_LINK_DOWN_STICKY, x)
 
+/*      DEV:MM_CONFIG:ENABLE_CONFIG */
+#define DEV_ENABLE_CONFIG(t)      __REG(TARGET_DEV, t, 8, 156, 0, 1, 8, 0, 0, 1, 4)
+
+#define DEV_ENABLE_CONFIG_KEEP_S_AFTER_D         BIT(8)
+#define DEV_ENABLE_CONFIG_KEEP_S_AFTER_D_SET(x)\
+	FIELD_PREP(DEV_ENABLE_CONFIG_KEEP_S_AFTER_D, x)
+#define DEV_ENABLE_CONFIG_KEEP_S_AFTER_D_GET(x)\
+	FIELD_GET(DEV_ENABLE_CONFIG_KEEP_S_AFTER_D, x)
+
+#define DEV_ENABLE_CONFIG_MM_TX_ENA              BIT(4)
+#define DEV_ENABLE_CONFIG_MM_TX_ENA_SET(x)\
+	FIELD_PREP(DEV_ENABLE_CONFIG_MM_TX_ENA, x)
+#define DEV_ENABLE_CONFIG_MM_TX_ENA_GET(x)\
+	FIELD_GET(DEV_ENABLE_CONFIG_MM_TX_ENA, x)
+
+#define DEV_ENABLE_CONFIG_MM_RX_ENA              BIT(0)
+#define DEV_ENABLE_CONFIG_MM_RX_ENA_SET(x)\
+	FIELD_PREP(DEV_ENABLE_CONFIG_MM_RX_ENA, x)
+#define DEV_ENABLE_CONFIG_MM_RX_ENA_GET(x)\
+	FIELD_GET(DEV_ENABLE_CONFIG_MM_RX_ENA, x)
+
 /*      FDMA:FDMA:FDMA_CH_ACTIVATE */
 #define FDMA_CH_ACTIVATE          __REG(TARGET_FDMA, 0, 1, 8, 0, 1, 428, 0, 0, 1, 4)
 
@@ -1184,6 +1205,15 @@ enum lan966x_target {
 #define PTP_TWOSTEP_STAMP_STAMP_NSEC_GET(x)\
 	FIELD_GET(PTP_TWOSTEP_STAMP_STAMP_NSEC, x)
 
+/*      SYS:PTPPORT:PTP_MODE_CFG */
+#define SYS_PTP_MODE_CFG(g, r)    __REG(TARGET_SYS, 0, 1, 4452, g, 10, 28, 20, r, 2, 4)
+
+#define SYS_PTP_MODE_CFG_PTP_MODE_VAL            GENMASK(1, 0)
+#define SYS_PTP_MODE_CFG_PTP_MODE_VAL_SET(x)\
+	FIELD_PREP(SYS_PTP_MODE_CFG_PTP_MODE_VAL, x)
+#define SYS_PTP_MODE_CFG_PTP_MODE_VAL_GET(x)\
+	FIELD_GET(SYS_PTP_MODE_CFG_PTP_MODE_VAL, x)
+
 /*      DEVCPU_QS:XTR:XTR_GRP_CFG */
 #define QS_XTR_GRP_CFG(r)         __REG(TARGET_QS, 0, 1, 0, 0, 1, 36, 0, r, 2, 4)
 
@@ -1623,6 +1653,20 @@ enum lan966x_target {
 	FIELD_PREP(REW_STAT_CFG_STAT_MODE, x)
 #define REW_STAT_CFG_STAT_MODE_GET(x)\
 	FIELD_GET(REW_STAT_CFG_STAT_MODE, x)
+/*      REW:PORT:PTP_MISC_CFG */
+#define REW_PTP_MISC_CFG(g)       __REG(TARGET_REW, 0, 1, 0, g, 10, 128, 80, 0, 1, 4)
+
+#define REW_PTP_MISC_CFG_PTP_RSRV_MOVEBACK       BIT(2)
+#define REW_PTP_MISC_CFG_PTP_RSRV_MOVEBACK_SET(x)\
+	FIELD_PREP(REW_PTP_MISC_CFG_PTP_RSRV_MOVEBACK, x)
+#define REW_PTP_MISC_CFG_PTP_RSRV_MOVEBACK_GET(x)\
+	FIELD_GET(REW_PTP_MISC_CFG_PTP_RSRV_MOVEBACK, x)
+
+#define REW_PTP_MISC_CFG_PTP_SIGNATURE_SEL       GENMASK(1, 0)
+#define REW_PTP_MISC_CFG_PTP_SIGNATURE_SEL_SET(x)\
+	FIELD_PREP(REW_PTP_MISC_CFG_PTP_SIGNATURE_SEL, x)
+#define REW_PTP_MISC_CFG_PTP_SIGNATURE_SEL_GET(x)\
+	FIELD_GET(REW_PTP_MISC_CFG_PTP_SIGNATURE_SEL, x)
 
 /*      SYS:SYSTEM:RESET_CFG */
 #define SYS_RESET_CFG             __REG(TARGET_SYS, 0, 1, 4128, 0, 1, 168, 0, 0, 1, 4)
@@ -1884,5 +1928,25 @@ enum lan966x_target {
 
 /*      VCAP:VCAP_CONST:IF_CNT */
 #define VCAP_IF_CNT(t)            __REG(TARGET_VCAP, t, 3, 924, 0, 1, 40, 36, 0, 1, 4)
+/*      SYS:PTPPORT:PCH_CFG */
+#define SYS_PCH_CFG(g)            __REG(TARGET_SYS, 0, 1, 4452, g, 10, 28, 0, 0, 1, 4)
+
+#define SYS_PCH_CFG_PCH_SUB_PORT_ID		GENMASK(10, 7)
+#define SYS_PCH_CFG_PCH_SUB_PORT_ID_SET(x)\
+	FIELD_PREP(SYS_PCH_CFG_PCH_SUB_PORT_ID, x)
+#define SYS_PCH_CFG_PCH_SUB_PORT_ID_GET(x)\
+	FIELD_GET(SYS_PCH_CFG_PCH_SUB_PORT_ID, x)
+
+#define SYS_PCH_CFG_PCH_TX_MODE			GENMASK(6, 5)
+#define SYS_PCH_CFG_PCH_TX_MODE_SET(x)\
+	FIELD_PREP(SYS_PCH_CFG_PCH_TX_MODE, x)
+#define SYS_PCH_CFG_PCH_TX_MODE_GET(x)\
+	FIELD_GET(SYS_MAC_FC_CFG_PAUSE_VAL_CFG, x)
+
+#define SYS_PCH_CFG_PCH_RX_MODE			GENMASK(4, 2)
+#define SYS_PCH_CFG_PCH_RX_MODE_SET(x)\
+	FIELD_PREP(SYS_PCH_CFG_PCH_RX_MODE, x)
+#define SYS_PCH_CFG_PCH_RX_MODE_GET(x)\
+	FIELD_GET(SYS_PCH_CFG_PCH_RX_MODE, x)
 
 #endif /* _LAN966X_REGS_H_ */
-- 
2.43.0


