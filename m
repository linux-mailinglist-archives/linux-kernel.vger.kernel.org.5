Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B85275BED8
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 08:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbjGUG1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjGUG1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 02:27:06 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D3BF1BF7;
        Thu, 20 Jul 2023 23:27:01 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="453327554"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="453327554"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 23:27:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="727990184"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="727990184"
Received: from pglmail07.png.intel.com ([10.221.193.207])
  by fmsmga007.fm.intel.com with ESMTP; 20 Jul 2023 23:26:55 -0700
Received: from localhost (pglc00300.png.intel.com [10.221.233.223])
        by pglmail07.png.intel.com (Postfix) with ESMTP id 3E6F118480;
        Fri, 21 Jul 2023 14:26:55 +0800 (+08)
Received: by localhost (Postfix, from userid 11742525)
        id 3D0CA80F8C4; Fri, 21 Jul 2023 14:26:55 +0800 (+08)
From:   Boon@ecsmtp.png.intel.com, Khai@ecsmtp.png.intel.com,
        "Ng <boon.khai.ng"@intel.com
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Boon Khai Ng <boon.khai.ng@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@intel.com>,
        Mun Yew Tham <mun.yew.tham@intel.com>,
        Leong Ching Swee <leong.ching.swee@intel.com>,
        G Thomas Rohan <rohan.g.thomas@intel.com>,
        Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
Subject: [Enable Designware XGMAC VLAN Stripping Feature 2/2] net: stmmac: dwxgmac2: Add support for HW-accelerated VLAN Stripping
Date:   Fri, 21 Jul 2023 14:26:17 +0800
Message-Id: <20230721062617.9810-3-boon.khai.ng@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230721062617.9810-1-boon.khai.ng@intel.com>
References: <20230721062617.9810-1-boon.khai.ng@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_UNBAL1,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Boon Khai Ng <boon.khai.ng@intel.com>

Currently, VLAN tag stripping is done by software driver in
stmmac_rx_vlan(). This patch is to Add support for VLAN tag
stripping by the MAC hardware and MAC drivers to support it.
This is done by adding rx_hw_vlan() and set_hw_vlan_mode()
callbacks at stmmac_ops struct which are called from upper
software layer.

The setting can be turn on and off at the dts by specifying
the dts node with "snps,rx-vlan-offload" The setting can be
turn on and off at ethool as well by running the command
below:
ethtool -k eth0 rx-vlan-offload on
ethtool -k eth0 rx-vlan-offload off

This implementation was ported from the dwmac4 driver.

Signed-off-by: Boon Khai Ng <boon.khai.ng@intel.com>
Reviewed-by: Shevchenko Andriy <andriy.shevchenko@linux.intel.com>
---
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 28 ++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   | 38 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_descs.c  | 18 +++++++++
 drivers/net/ethernet/stmicro/stmmac/hwif.h    | 16 ++++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 29 +++++++++++---
 .../ethernet/stmicro/stmmac/stmmac_platform.c |  6 +++
 include/linux/stmmac.h                        |  1 +
 7 files changed, 131 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 153321fe42c3..2a75faf8443b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -431,6 +431,7 @@
 #define XGMAC_TDES2_VTIR		GENMASK(15, 14)
 #define XGMAC_TDES2_VTIR_SHIFT		14
 #define XGMAC_TDES2_B1L			GENMASK(13, 0)
+#define XGMAC_TDES2_VLAN_TAG_MASK	GENMASK(15, 14)
 #define XGMAC_TDES3_OWN			BIT(31)
 #define XGMAC_TDES3_CTXT		BIT(30)
 #define XGMAC_TDES3_FD			BIT(29)
@@ -462,6 +463,8 @@
 #define XGMAC_RDES3_RSV			BIT(26)
 #define XGMAC_RDES3_L34T		GENMASK(23, 20)
 #define XGMAC_RDES3_L34T_SHIFT		20
+#define XGMAC_RDES3_ET_LT		GENMASK(19, 16)
+#define XGMAC_RDES3_ET_LT_SHIFT		16
 #define XGMAC_L34T_IP4TCP		0x1
 #define XGMAC_L34T_IP4UDP		0x2
 #define XGMAC_L34T_IP6TCP		0x9
@@ -471,4 +474,29 @@
 #define XGMAC_RDES3_TSD			BIT(6)
 #define XGMAC_RDES3_TSA			BIT(4)
 
+/* RDES0 (write back format) */
+#define XGMAC_RDES0_VLAN_TAG_MASK	GENMASK(15, 0)
+
+/* MAC VLAN Tag Control */
+#define XGMAC_VLAN_TAG_CTRL_OB		BIT(0)
+#define XGMAC_VLAN_TAG_CTRL_CT		BIT(1)
+#define XGMAC_VLAN_TAG_CTRL_OFS_MASK	GENMASK(6, 2)
+#define XGMAC_VLAN_TAG_CTRL_OFS_SHIFT	2
+#define XGMAC_VLAN_TAG_CTRL_EVLS_MASK	GENMASK(22, 21)
+#define XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT	21
+#define XGMAC_VLAN_TAG_CTRL_EVLRXS	BIT(24)
+
+#define XGMAC_VLAN_TAG_STRIP_NONE	(0x0 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_PASS	(0x1 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_FAIL	(0x2 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+#define XGMAC_VLAN_TAG_STRIP_ALL	(0x3 << XGMAC_VLAN_TAG_CTRL_EVLS_SHIFT)
+
+/* Error Type or L2 Type(ET/LT) Field Number */
+#define XGMAC_ET_LT_VLAN_STAG		8
+#define XGMAC_ET_LT_VLAN_CTAG		9
+#define XGMAC_ET_LT_DVLAN_CTAG_CTAG	10
+#define XGMAC_ET_LT_DVLAN_STAG_STAG	11
+#define XGMAC_ET_LT_DVLAN_CTAG_STAG	12
+#define XGMAC_ET_LT_DVLAN_STAG_CTAG	13
+
 #endif /* __STMMAC_DWXGMAC2_H__ */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index a0c2ef8bb0ac..0f8120427d5c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -6,6 +6,7 @@
 
 #include <linux/bitrev.h>
 #include <linux/crc32.h>
+#include <linux/if_vlan.h>
 #include <linux/iopoll.h>
 #include "stmmac.h"
 #include "stmmac_ptp.h"
@@ -1177,6 +1178,39 @@ static void dwxgmac2_sarc_configure(void __iomem *ioaddr, int val)
 	writel(value, ioaddr + XGMAC_TX_CONFIG);
 }
 
+static void dwxgmac2_rx_hw_vlan(struct net_device *dev,
+				struct mac_device_info *hw,
+				struct dma_desc *rx_desc, struct sk_buff *skb)
+{
+	if ((dev->features & NETIF_F_HW_VLAN_CTAG_RX) &&
+	    hw->desc->get_rx_vlan_valid(rx_desc)) {
+		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);
+
+		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
+	}
+}
+
+static void dwxgmac2_set_hw_vlan_mode(void __iomem *ioaddr,
+				      netdev_features_t features)
+{
+	u32 val;
+
+	val = readl(ioaddr + XGMAC_VLAN_TAG);
+	val &= ~XGMAC_VLAN_TAG_CTRL_EVLS_MASK;
+
+	if (features & NETIF_F_HW_VLAN_CTAG_RX)
+		/* Always strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_ALL;
+	else
+		/* Do not strip VLAN on Receive */
+		val |= XGMAC_VLAN_TAG_STRIP_NONE;
+
+	/* Enable outer VLAN Tag in Rx DMA descriptro */
+	val |= XGMAC_VLAN_TAG_CTRL_EVLRXS;
+
+	writel(val, ioaddr + XGMAC_VLAN_TAG);
+}
+
 static void dwxgmac2_enable_vlan(struct mac_device_info *hw, u32 type)
 {
 	void __iomem *ioaddr = hw->pcsr;
@@ -1501,6 +1535,8 @@ const struct stmmac_ops dwxgmac210_ops = {
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 static void dwxlgmac2_rx_queue_enable(struct mac_device_info *hw, u8 mode,
@@ -1562,6 +1598,8 @@ const struct stmmac_ops dwxlgmac2_ops = {
 	.set_arp_offload = dwxgmac2_set_arp_offload,
 	.est_configure = dwxgmac3_est_configure,
 	.fpe_configure = dwxgmac3_fpe_configure,
+	.rx_hw_vlan = dwxgmac2_rx_hw_vlan,
+	.set_hw_vlan_mode = dwxgmac2_set_hw_vlan_mode,
 };
 
 int dwxgmac2_setup(struct stmmac_priv *priv)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
index fc82862a612c..b8cc17c9c0db 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_descs.c
@@ -67,6 +67,22 @@ static int dwxgmac2_get_tx_ls(struct dma_desc *p)
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_LD) > 0;
 }
 
+static inline int dwxgmac2_wrback_get_rx_vlan_tci(struct dma_desc *p)
+{
+	return le32_to_cpu(p->des0) & XGMAC_RDES0_VLAN_TAG_MASK;
+}
+
+static inline bool dwxgmac2_wrback_get_rx_vlan_valid(struct dma_desc *p)
+{
+	u32 et_lt;
+
+	et_lt = (le32_to_cpu(p->des3) & XGMAC_RDES3_ET_LT) >>
+		XGMAC_RDES3_ET_LT_SHIFT;
+
+	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
+		et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;
+}
+
 static int dwxgmac2_get_rx_frame_len(struct dma_desc *p, int rx_coe)
 {
 	return (le32_to_cpu(p->des3) & XGMAC_RDES3_PL);
@@ -349,6 +365,8 @@ const struct stmmac_desc_ops dwxgmac210_desc_ops = {
 	.set_tx_owner = dwxgmac2_set_tx_owner,
 	.set_rx_owner = dwxgmac2_set_rx_owner,
 	.get_tx_ls = dwxgmac2_get_tx_ls,
+	.get_rx_vlan_tci = dwxgmac2_wrback_get_rx_vlan_tci,
+	.get_rx_vlan_valid = dwxgmac2_wrback_get_rx_vlan_valid,
 	.get_rx_frame_len = dwxgmac2_get_rx_frame_len,
 	.enable_tx_timestamp = dwxgmac2_enable_tx_timestamp,
 	.get_tx_timestamp_status = dwxgmac2_get_tx_timestamp_status,
diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
index 652af8f6e75f..d37fa2400f62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@ -97,6 +97,10 @@ struct stmmac_desc_ops {
 			     u32 inner_type);
 	void (*set_vlan)(struct dma_desc *p, u32 type);
 	void (*set_tbs)(struct dma_edesc *p, u32 sec, u32 nsec);
+	/* get rx vlan id */
+	int (*get_rx_vlan_tci)(struct dma_desc *p);
+	/* get rx vlan valid status */
+	bool (*get_rx_vlan_valid)(struct dma_desc *p);
 };
 
 #define stmmac_init_rx_desc(__priv, __args...) \
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
@@ -386,6 +394,10 @@ struct stmmac_ops {
 	void (*update_vlan_hash)(struct mac_device_info *hw, u32 hash,
 				 __le16 perfect_match, bool is_double);
 	void (*enable_vlan)(struct mac_device_info *hw, u32 type);
+	void (*rx_hw_vlan)(struct net_device *dev, struct mac_device_info *hw,
+			   struct dma_desc *rx_desc, struct sk_buff *skb);
+	void (*set_hw_vlan_mode)(void __iomem *ioaddr,
+				 netdev_features_t features);
 	int (*add_hw_vlan_rx_fltr)(struct net_device *dev,
 				   struct mac_device_info *hw,
 				   __be16 proto, u16 vid);
@@ -493,6 +505,10 @@ struct stmmac_ops {
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
index e7ca52f0d2f2..2fe58bf3d936 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -3451,6 +3451,10 @@ static int stmmac_hw_setup(struct net_device *dev, bool ptp_register)
 			stmmac_fpe_handshake(priv, true);
 	}
 
+	/* Set HW VLAN Stripping mode */
+	if (priv->plat->use_hw_vlan)
+		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, dev->features);
+
 	return 0;
 }
 
@@ -4596,10 +4600,8 @@ static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
 	__be16 vlan_proto = veth->h_vlan_proto;
 	u16 vlanid;
 
-	if ((vlan_proto == htons(ETH_P_8021Q) &&
-	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
-	    (vlan_proto == htons(ETH_P_8021AD) &&
-	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
+	if (vlan_proto == htons(ETH_P_8021Q) ||
+	    vlan_proto == htons(ETH_P_8021AD)) {
 		/* pop the vlan tag */
 		vlanid = ntohs(veth->h_vlan_TCI);
 		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
@@ -5466,7 +5468,14 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
 		/* Got entire packet into SKB. Finish it. */
 
 		stmmac_get_rx_hwtstamp(priv, p, np, skb);
-		stmmac_rx_vlan(priv->dev, skb);
+
+		/* Switch between rx_hw_vlan or rx_vlan */
+		if (priv->plat->use_hw_vlan)
+			stmmac_rx_hw_vlan(priv, priv->dev,
+					  priv->hw, p, skb);
+		else
+			stmmac_rx_vlan(priv->dev, skb);
+
 		skb->protocol = eth_type_trans(skb, priv->dev);
 
 		if (unlikely(!coe))
@@ -5746,6 +5755,9 @@ static int stmmac_set_features(struct net_device *netdev,
 			       netdev_features_t features)
 {
 	struct stmmac_priv *priv = netdev_priv(netdev);
+	netdev_features_t changed;
+
+	changed = netdev->features ^ features;
 
 	/* Keep the COE Type in case of csum is supporting */
 	if (features & NETIF_F_RXCSUM)
@@ -5765,6 +5777,11 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
+	if (changed & NETIF_F_HW_VLAN_CTAG_RX) {
+		stmmac_set_hw_vlan_mode(priv, priv->ioaddr, features);
+		priv->plat->use_hw_vlan = features & NETIF_F_HW_VLAN_CTAG_RX;
+	}
+
 	return 0;
 }
 
@@ -7418,6 +7435,8 @@ int stmmac_dvr_probe(struct device *device,
 #ifdef STMMAC_VLAN_TAG_USED
 	/* Both mac100 and gmac support receive VLAN tag detection */
 	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+	ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
+
 	if (priv->dma_cap.vlhash) {
 		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
 		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24..bd7f3326a44c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -543,6 +543,12 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 			plat->flags |= STMMAC_FLAG_TSO_EN;
 	}
 
+	/* Rx VLAN HW Stripping */
+	if (of_property_read_bool(np, "snps,rx-vlan-offload")) {
+		dev_info(&pdev->dev, "RX VLAN HW Stripping\n");
+		plat->use_hw_vlan = true;
+	}
+
 	dma_cfg = devm_kzalloc(&pdev->dev, sizeof(*dma_cfg),
 			       GFP_KERNEL);
 	if (!dma_cfg) {
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d0..a989c5d82482 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -282,6 +282,7 @@ struct plat_stmmacenet_data {
 	int rss_en;
 	int mac_port_sel_speed;
 	int has_xgmac;
+	bool use_hw_vlan;
 	u8 vlan_fail_q;
 	unsigned int eee_usecs_rate;
 	struct pci_dev *pdev;
-- 
2.25.1

