Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2060D7F256B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjKUFma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjKUFm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:42:28 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978D785;
        Mon, 20 Nov 2023 21:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700545344; x=1732081344;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8Pm9PeyjQ0qn290l1+2FIFFavqN8b90Q7cehe4YiRVw=;
  b=CwJR8N1phey7EWe+xT8a4xWDx9cEm+U6U2amTdndSD9OZIyk9XYPYAdG
   jVNvZBUtt2aTJYuIPJXkvTZg2zNdRUzK7eINMRGlM41S5koOp1ArNzCmn
   Mlwt9TXALU47hRhBpFRA36P3m7qG4RwzdP+hCiY+jqBt6rF30H/HBxD2+
   Y1t0y64NfSBgOJVj4hs1cqUKjMJTfw/urno7pKPDB3mbwZDW6A2lut8EZ
   FfU0p8N+w/qLVXvnJL5cv4jxiGixLNdLuhncFtRXYy3xN7NUg0xc6lSsD
   CtMDcisrLkcM8iriT1eEZQfVxrxUBw8ut3+L9fHMXPWyBRcANqq9gvMQ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="390624550"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="390624550"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 21:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="801418681"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="801418681"
Received: from ssid-ilbpg3-teeminta.png.intel.com ([10.88.227.74])
  by orsmga001.jf.intel.com with ESMTP; 20 Nov 2023 21:42:19 -0800
From:   Gan Yi Fang <yi.fang.gan@intel.com>
To:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Looi Hong Aun <hong.aun.looi@intel.com>,
        Voon Weifeng <weifeng.voon@intel.com>,
        Song Yoong Siang <yoong.siang.song@intel.com>,
        Gan Yi Fang <yi.fang.gan@intel.com>,
        Lai Peter Jun Ann <jun.ann.lai@intel.com>
Subject: [PATCH net-next v2 1/1] net: stmmac: Add support for HW-accelerated VLAN stripping
Date:   Tue, 21 Nov 2023 13:38:42 +0800
Message-Id: <20231121053842.719531-1-yi.fang.gan@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gan, Yi Fang" <yi.fang.gan@intel.com>

Current implementation supports driver level VLAN tag stripping only.
The features is always on if CONFIG_VLAN_8021Q is enabled in kernel
config and is not user configurable.

This patch add support to MAC level VLAN tag stripping and can be
configured through ethtool. If the rx-vlan-offload is off, the VLAN tag
will be stripped by driver. If the rx-vlan-offload is on, the VLAN tag
will be stripped by MAC.

Command: ethtool -K <interface> rx-vlan-offload off | on

Signed-off-by: Lai Peter Jun Ann <jun.ann.lai@intel.com>
Signed-off-by: Gan, Yi Fang <yi.fang.gan@intel.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  |  1 +
 .../net/ethernet/stmicro/stmmac/dwmac4_core.c | 35 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac4_descs.c    | 13 +++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 15 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 28 +++++++++++++--
 5 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index e3f650e88f82..6b935922054d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -580,6 +580,7 @@ struct mac_device_info {
 	u32 vlan_filter[32];
 	bool vlan_fail_q_en;
 	u8 vlan_fail_q;
+	bool hw_vlan_en;
 };
 
 struct stmmac_rx_routing {
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
index c6ff1fa0e04d..5f35faf90963 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_core.c
@@ -1134,6 +1134,35 @@ static int dwmac4_config_l4_filter(struct mac_device_info *hw, u32 filter_no,
 	return 0;
 }
 
+static void dwmac4_rx_hw_vlan(struct mac_device_info *hw,
+			      struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+
+static void dwmac4_set_hw_vlan_mode(struct mac_device_info *hw)
+{
+	void __iomem *ioaddr = hw->pcsr;
+	u32 value = readl(ioaddr + GMAC_VLAN_TAG);
+
+	value &= ~GMAC_VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (hw->hw_vlan_en)
+		/* Always strip VLAN on Receive */
+		value |= GMAC_VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		value |= GMAC_VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptor */
+	value |= GMAC_VLAN_TAG_CTRL_EVLRXS;
+	writel(value, ioaddr + GMAC_VLAN_TAG);
+}
+
 const struct stmmac_ops dwmac4_ops = {
 	.core_init = dwmac4_core_init,
 	.phylink_get_caps = dwmac4_phylink_get_caps,
@@ -1175,6 +1204,8 @@ const struct stmmac_ops dwmac4_ops = {
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac410_ops = {
@@ -1224,6 +1255,8 @@ const struct stmmac_ops dwmac410_ops = {
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 const struct stmmac_ops dwmac510_ops = {
@@ -1277,6 +1310,8 @@ const struct stmmac_ops dwmac510_ops = {
 	.add_hw_vlan_rx_fltr = dwmac4_add_hw_vlan_rx_fltr,
 	.del_hw_vlan_rx_fltr = dwmac4_del_hw_vlan_rx_fltr,
 	.restore_hw_vlan_rx_fltr = dwmac4_restore_hw_vlan_rx_fltr,
+	.rx_hw_vlan = dwmac4_rx_hw_vlan,
+	.set_hw_vlan_mode = dwmac4_set_hw_vlan_mode,
 };
 
 static u32 dwmac4_get_num_vlan(void __iomem *ioaddr)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
index 89a14084c611..1c5802e0d7f4 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c
@@ -198,6 +198,17 @@ static int dwmac4_get_tx_ls(struct dma_desc *p)
 		>> TDES3_LAST_DESCRIPTOR_SHIFT;
 }
 
+static u16 dwmac4_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return (le32_to_cpu(p->des0) & RDES0_VLAN_TAG_MASK);
+}
+
+static bool dwmac4_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	return ((le32_to_cpu(p->des3) & RDES3_LAST_DESCRIPTOR) &&
+		(le32_to_cpu(p->des3) & RDES3_RDES0_VALID));
+}
+
 static int dwmac4_wrback_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & RDES3_PACKET_SIZE_MASK);
@@ -551,6 +562,8 @@ const struct stmmac_desc_ops dwmac4_desc_ops = {
 	.set_tx_owner = dwmac4_set_tx_owner,
 	.set_rx_owner = dwmac4_set_rx_owner,
 	.get_tx_ls = dwmac4_get_tx_ls,
+	.get_rx_vlan_tci = dwmac4_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwmac4_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwmac4_wrback_get_rx_frame_len,
 	.enable_tx_timestamp = dwmac4_rd_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwmac4_wrback_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index b95d3e137813..1d424c9bf037 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -56,6 +56,10 @@ struct stmmac_desc_ops {
 	void (*set_tx_ic)(struct dma_desc *p);
 	/* Last tx segment reports the transmit status */
 	int (*get_tx_ls)(struct dma_desc *p);
+	/* Get the tag of the descriptor */
+	u16 (*get_rx_vlan_tci)(struct dma_desc *p);
+	/* Get the valid status of descriptor */
+	bool (*get_rx_vlan_valid)(struct dma_desc *p);
 	/* Return the transmit status looking at the TDES1 */
 	int (*tx_status)(struct stmmac_extra_stats *x,
 			 struct dma_desc *p, void __iomem *ioaddr);
@@ -117,6 +121,10 @@ struct stmmac_desc_ops {
 	stmmac_do_void_callback(__priv, desc, set_tx_ic, __args)
 #define stmmac_get_tx_ls(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, get_tx_ls, __args)
+#define stmmac_get_rx_vlan_tci(__priv, __args...) \
+	stmmac_do_callback(__priv, desc, get_rx_vlan_tci, __args)
+#define stmmac_get_rx_vlan_valid(__priv, __args...) \
+	stmmac_do_callback(__priv, desc, get_rx_vlan_valid, __args)
 #define stmmac_tx_status(__priv, __args...) \
 	stmmac_do_callback(__priv, desc, tx_status, __args)
 #define stmmac_get_tx_len(__priv, __args...) \
@@ -388,6 +396,9 @@ struct stmmac_ops {
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
 				 __le16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
+	void (*rx_hw_vlan)(struct mac_device_info *hw, struct dma_desc *rx_desc,
+			   struct sk_buff *skb);
+	void (*set_hw_vlan_mode)(struct mac_device_info *hw);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
 				   __be16 proto, u16 vid);
@@ -497,6 +508,10 @@ struct stmmac_ops {
 	stmmac_do_void_callback(__priv, mac, update_vlan_hash, __args)
 #define stmmac_enable_vlan(__priv, __args...) \
 	stmmac_do_void_callback(__priv, mac, enable_vlan, __args)
+#define stmmac_rx_hw_vlan(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, rx_hw_vlan, __args)
+#define stmmac_set_hw_vlan_mode(__priv, __args...) \
+	stmmac_do_void_callback(__priv, mac, set_hw_vlan_mode, __args)
 #define stmmac_add_hw_vlan_rx_fltr(__priv, __args...) \
 	stmmac_do_callback(__priv, mac, add_hw_vlan_rx_fltr, __args)
 #define stmmac_del_hw_vlan_rx_fltr(__priv, __args...) \
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2afb2bd25977..0323d5ac20f5 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3469,6 +3469,8 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 	/* Start the ball rolling... */
 	stmmac_start_all_dma(priv);
 
+	stmmac_set_hw_vlan_mode(priv, priv->hw);
+
 	if (priv->dma_cap.fpesel) {
 		stmmac_fpe_start_wq(priv);
 
@@ -4993,7 +4995,12 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
 	}
 
 	stmmac_get_rx_hwtstamp(priv, p, np, skb);
-	stmmac_rx_vlan(priv->dev, skb);
+	if (priv->hw->hw_vlan_en)
+		/* MAC level stripping. */
+		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
+	else
+		/* Driver level stripping. */
+		stmmac_rx_vlan(priv->dev, skb);
 	skb->protocol = eth_type_trans(skb, priv->dev);
 
 	if (unlikely(!coe))
@@ -5509,7 +5516,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Got entire packet into SKB. Finish it. */
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
-		stmmac_rx_vlan(priv->dev, skb);
+
+		if (priv->hw->hw_vlan_en)
+			/* MAC level stripping. */
+			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
+		else
+			/* Driver level stripping. */
+			stmmac_rx_vlan(priv->dev, skb);
+
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
 		if (unlikely(!coe))
@@ -5818,6 +5832,13 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		priv->hw->hw_vlan_en = true;
+	else
+		priv->hw->hw_vlan_en = false;
+
+	stmmac_set_hw_vlan_mode(priv, priv->hw);
+
 	return 0;
 }
 
@@ -7516,6 +7537,9 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
+	priv->hw->hw_vlan_en = true;
+
 	if (priv->dma_cap.vlhash) {
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
-- 
2.34.1

