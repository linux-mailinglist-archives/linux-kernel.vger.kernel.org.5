Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 928997847A7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 18:32:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbjHVQcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 12:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233464AbjHVQcU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 12:32:20 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23AFACE6;
        Tue, 22 Aug 2023 09:32:18 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qYUIb-0000HY-2d;
        Tue, 22 Aug 2023 16:32:10 +0000
Date:   Tue, 22 Aug 2023 17:32:03 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 2/4] net: ethernet: mtk_eth_soc: add reset bits
 for MT7988
Message-ID: <89b6c38380e7a3800c1362aa7575600717bc7543.1692721443.git.daniel@makrotopia.org>
References: <cover.1692721443.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692721443.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bits needed to reset the frame engine on MT7988.

Fixes: 445eb6448ed3 ("net: ethernet: mtk_eth_soc: add basic support for MT7988 SoC")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 76 +++++++++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 16 +++--
 2 files changed, 68 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index fe05c90202699..2482f47313085 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3613,19 +3613,34 @@ static void mtk_hw_reset(struct mtk_eth *eth)
 {
 	u32 val;
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v2_or_greater(eth))
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN, 0);
+
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		val = RSTCTRL_PPE0_V3;
+
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			val |= RSTCTRL_PPE1_V3;
+
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
+			val |= RSTCTRL_PPE2;
+
+		val |= RSTCTRL_WDMA0 | RSTCTRL_WDMA1 | RSTCTRL_WDMA2;
+	} else if (mtk_is_netsys_v2_or_greater(eth)) {
 		val = RSTCTRL_PPE0_V2;
+
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			val |= RSTCTRL_PPE1;
 	} else {
 		val = RSTCTRL_PPE0;
 	}
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
-		val |= RSTCTRL_PPE1;
-
 	ethsys_reset(eth, RSTCTRL_ETH | RSTCTRL_FE | val);
 
-	if (mtk_is_netsys_v2_or_greater(eth))
+	if (mtk_is_netsys_v3_or_greater(eth))
+		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
+			     0x6f8ff);
+	else if (mtk_is_netsys_v2_or_greater(eth))
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
 			     0x3ffffff);
 }
@@ -3651,13 +3666,21 @@ static void mtk_hw_warm_reset(struct mtk_eth *eth)
 		return;
 	}
 
-	if (mtk_is_netsys_v2_or_greater(eth))
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0_V3;
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			rst_mask |= RSTCTRL_PPE1_V3;
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
+			rst_mask |= RSTCTRL_PPE2;
+
+		rst_mask |= RSTCTRL_WDMA0 | RSTCTRL_WDMA1 | RSTCTRL_WDMA2;
+	} else if (mtk_is_netsys_v2_or_greater(eth)) {
 		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0_V2;
-	else
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			rst_mask |= RSTCTRL_PPE1;
+	} else {
 		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0;
-
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
-		rst_mask |= RSTCTRL_PPE1;
+	}
 
 	regmap_update_bits(eth->ethsys, ETHSYS_RSTCTRL, rst_mask, rst_mask);
 
@@ -4009,11 +4032,17 @@ static void mtk_prepare_for_reset(struct mtk_eth *eth)
 	u32 val;
 	int i;
 
-	/* disabe FE P3 and P4 */
-	val = mtk_r32(eth, MTK_FE_GLO_CFG) | MTK_FE_LINK_DOWN_P3;
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
-		val |= MTK_FE_LINK_DOWN_P4;
-	mtk_w32(eth, val, MTK_FE_GLO_CFG);
+	/* set FE PPE ports link down */
+	for (i = MTK_GMAC1_ID;
+	     i <= (mtk_is_netsys_v3_or_greater(eth) ? MTK_GMAC3_ID : MTK_GMAC2_ID);
+	     i += 2) {
+		val = mtk_r32(eth, MTK_FE_GLO_CFG(i)) | MTK_FE_LINK_DOWN_P(PSE_PPE0_PORT);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			val |= MTK_FE_LINK_DOWN_P(PSE_PPE1_PORT);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
+			val |= MTK_FE_LINK_DOWN_P(PSE_PPE2_PORT);
+		mtk_w32(eth, val, MTK_FE_GLO_CFG(i));
+	}
 
 	/* adjust PPE configurations to prepare for reset */
 	for (i = 0; i < ARRAY_SIZE(eth->ppe); i++)
@@ -4074,11 +4103,18 @@ static void mtk_pending_work(struct work_struct *work)
 		}
 	}
 
-	/* enabe FE P3 and P4 */
-	val = mtk_r32(eth, MTK_FE_GLO_CFG) & ~MTK_FE_LINK_DOWN_P3;
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
-		val &= ~MTK_FE_LINK_DOWN_P4;
-	mtk_w32(eth, val, MTK_FE_GLO_CFG);
+	/* set FE PPE ports link up */
+	for (i = MTK_GMAC1_ID;
+	     i <= (mtk_is_netsys_v3_or_greater(eth) ? MTK_GMAC3_ID : MTK_GMAC2_ID);
+	     i += 2) {
+		val = mtk_r32(eth, MTK_FE_GLO_CFG(i)) & ~MTK_FE_LINK_DOWN_P(PSE_PPE0_PORT);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE1))
+			val &= ~MTK_FE_LINK_DOWN_P(PSE_PPE1_PORT);
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_RSTCTRL_PPE2))
+			val &= ~MTK_FE_LINK_DOWN_P(PSE_PPE2_PORT);
+
+		mtk_w32(eth, val, MTK_FE_GLO_CFG(i));
+	}
 
 	clear_bit(MTK_RESETTING, &eth->state);
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 8d2d35b322351..cf9381a3d68b7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -76,9 +76,8 @@
 #define	MTK_HW_LRO_SDL_REMAIN_ROOM	1522
 
 /* Frame Engine Global Configuration */
-#define MTK_FE_GLO_CFG		0x00
-#define MTK_FE_LINK_DOWN_P3	BIT(11)
-#define MTK_FE_LINK_DOWN_P4	BIT(12)
+#define MTK_FE_GLO_CFG(x)	(((x) == MTK_GMAC3_ID) ? 0x24 : 0x00)
+#define MTK_FE_LINK_DOWN_P(x)	BIT(((x) + 8) % 16)
 
 /* Frame Engine Global Reset Register */
 #define MTK_RST_GL		0x04
@@ -522,9 +521,15 @@
 /* ethernet reset control register */
 #define ETHSYS_RSTCTRL			0x34
 #define RSTCTRL_FE			BIT(6)
+#define RSTCTRL_WDMA0			BIT(24)
+#define RSTCTRL_WDMA1			BIT(25)
+#define RSTCTRL_WDMA2			BIT(26)
 #define RSTCTRL_PPE0			BIT(31)
 #define RSTCTRL_PPE0_V2			BIT(30)
 #define RSTCTRL_PPE1			BIT(31)
+#define RSTCTRL_PPE0_V3			BIT(29)
+#define RSTCTRL_PPE1_V3			BIT(30)
+#define RSTCTRL_PPE2			BIT(31)
 #define RSTCTRL_ETH			BIT(23)
 
 /* ethernet reset check idle register */
@@ -931,6 +936,7 @@ enum mkt_eth_capabilities {
 	MTK_QDMA_BIT,
 	MTK_SOC_MT7628_BIT,
 	MTK_RSTCTRL_PPE1_BIT,
+	MTK_RSTCTRL_PPE2_BIT,
 	MTK_U3_COPHY_V2_BIT,
 
 	/* MUX BITS*/
@@ -965,6 +971,7 @@ enum mkt_eth_capabilities {
 #define MTK_QDMA		BIT_ULL(MTK_QDMA_BIT)
 #define MTK_SOC_MT7628		BIT_ULL(MTK_SOC_MT7628_BIT)
 #define MTK_RSTCTRL_PPE1	BIT_ULL(MTK_RSTCTRL_PPE1_BIT)
+#define MTK_RSTCTRL_PPE2	BIT_ULL(MTK_RSTCTRL_PPE2_BIT)
 #define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
 
 #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
@@ -1047,7 +1054,8 @@ enum mkt_eth_capabilities {
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_RSTCTRL_PPE1)
 
-#define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1)
+#define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
+		      MTK_RSTCTRL_PPE2)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
-- 
2.41.0
