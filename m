Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4232A751630
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 04:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233429AbjGMCTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 22:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbjGMCS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 22:18:58 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1626C2127;
        Wed, 12 Jul 2023 19:18:38 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qJlue-0005Wn-06;
        Thu, 13 Jul 2023 02:18:36 +0000
Date:   Thu, 13 Jul 2023 03:18:23 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>
Subject: [PATCH v2 net-next 3/9] net: ethernet: mtk_eth_soc: add
 MTK_NETSYS_V1 capability bit
Message-ID: <a2022fd2db0f7ed54ab07bb93b04aa9fc59033b5.1689012506.git.daniel@makrotopia.org>
References: <cover.1689012506.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689012506.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce MTK_NETSYS_V1 bit in the device capabilities for
MT7621/MT7622/MT7623/MT7628/MT7629 SoCs.
Use !MTK_NETSYS_V1 instead of MTK_NETSYS_V2 in the driver codebase.
This is a preliminary patch to introduce support for MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 28 ++++++-------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 45 ++++++++++++---------
 2 files changed, 40 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 834c644b67db5..7014e0d108b27 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -659,7 +659,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 	      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_MAN, 1) |
 	      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_EXP, 4) |
 	      MTK_QTX_SCH_LEAKY_BUCKET_SIZE;
-	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 		val |= MTK_QTX_SCH_LEAKY_BUCKET_EN;
 
 	if (IS_ENABLED(CONFIG_SOC_MT7621)) {
@@ -1037,7 +1037,7 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
 	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 		rxd->rxd5 = READ_ONCE(dma_rxd->rxd5);
 		rxd->rxd6 = READ_ONCE(dma_rxd->rxd6);
 	}
@@ -1095,7 +1095,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 
 		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
 		txd->txd4 = 0;
-		if (MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V2)) {
+		if (!MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V1)) {
 			txd->txd5 = 0;
 			txd->txd6 = 0;
 			txd->txd7 = 0;
@@ -1286,7 +1286,7 @@ static void mtk_tx_set_dma_desc(struct net_device *dev, void *txd,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 		mtk_tx_set_dma_desc_v2(dev, txd, info);
 	else
 		mtk_tx_set_dma_desc_v1(dev, txd, info);
@@ -1935,7 +1935,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 			mac = RX_DMA_GET_SPORT_V2(trxd.rxd5) - 1;
 		else if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
 			 !(trxd.rxd4 & RX_DMA_SPECIAL_TAG))
@@ -2031,7 +2031,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		skb->dev = netdev;
 		bytes += skb->len;
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 			reason = FIELD_GET(MTK_RXD5_PPE_CPU_REASON, trxd.rxd5);
 			hash = trxd.rxd5 & MTK_RXD5_FOE_ENTRY;
 			if (hash != MTK_RXD5_FOE_ENTRY)
@@ -2367,7 +2367,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 		txd->txd2 = next_ptr;
 		txd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
 		txd->txd4 = 0;
-		if (MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V2)) {
+		if (!MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V1)) {
 			txd->txd5 = 0;
 			txd->txd6 = 0;
 			txd->txd7 = 0;
@@ -2420,7 +2420,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 			      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_MAN, 1) |
 			      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_EXP, 4) |
 			      MTK_QTX_SCH_LEAKY_BUCKET_SIZE;
-			if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+			if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 				val |= MTK_QTX_SCH_LEAKY_BUCKET_EN;
 			mtk_w32(eth, val, soc->reg_map->qdma.qtx_sch + ofs);
 			ofs += MTK_QTX_OFFSET;
@@ -2556,7 +2556,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 		rxd->rxd3 = 0;
 		rxd->rxd4 = 0;
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 			rxd->rxd5 = 0;
 			rxd->rxd6 = 0;
 			rxd->rxd7 = 0;
@@ -3104,7 +3104,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		       MTK_TX_BT_32DWORDS | MTK_NDP_CO_PRO |
 		       MTK_RX_2B_OFFSET | MTK_TX_WB_DDONE;
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 			val |= MTK_MUTLI_CNT | MTK_RESV_BUF |
 			       MTK_WCOMP_EN | MTK_DMAD_WR_WDONE |
 			       MTK_CHK_DDONE_EN | MTK_LEAKY_BUCKET_EN;
@@ -3516,7 +3516,7 @@ static void mtk_hw_reset(struct mtk_eth *eth)
 {
 	u32 val;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN, 0);
 		val = RSTCTRL_PPE0_V2;
 	} else {
@@ -3528,7 +3528,7 @@ static void mtk_hw_reset(struct mtk_eth *eth)
 
 	ethsys_reset(eth, RSTCTRL_ETH | RSTCTRL_FE | val);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1))
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
 			     0x3ffffff);
 }
@@ -3724,7 +3724,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
 		mtk_w32(eth,  val | BIT(4), MTK_FE_GLO_MISC);
@@ -3761,7 +3761,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	 */
 	val = mtk_r32(eth, MTK_CDMQ_IG_CTRL);
 	mtk_w32(eth, val | MTK_CDMQ_STAG_EN, MTK_CDMQ_IG_CTRL);
-	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V1)) {
 		val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
 		mtk_w32(eth, val | MTK_CDMP_STAG_EN, MTK_CDMP_IG_CTRL);
 
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 707445f6bcb1b..c74c3918113a5 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -820,6 +820,7 @@ enum mkt_eth_capabilities {
 	MTK_SHARED_INT_BIT,
 	MTK_TRGMII_MT7621_CLK_BIT,
 	MTK_QDMA_BIT,
+	MTK_NETSYS_V1_BIT,
 	MTK_NETSYS_V2_BIT,
 	MTK_SOC_MT7628_BIT,
 	MTK_RSTCTRL_PPE1_BIT,
@@ -855,6 +856,7 @@ enum mkt_eth_capabilities {
 #define MTK_SHARED_INT		BIT(MTK_SHARED_INT_BIT)
 #define MTK_TRGMII_MT7621_CLK	BIT(MTK_TRGMII_MT7621_CLK_BIT)
 #define MTK_QDMA		BIT(MTK_QDMA_BIT)
+#define MTK_NETSYS_V1		BIT(MTK_NETSYS_V1_BIT)
 #define MTK_NETSYS_V2		BIT(MTK_NETSYS_V2_BIT)
 #define MTK_SOC_MT7628		BIT(MTK_SOC_MT7628_BIT)
 #define MTK_RSTCTRL_PPE1	BIT(MTK_RSTCTRL_PPE1_BIT)
@@ -911,25 +913,30 @@ enum mkt_eth_capabilities {
 
 #define MTK_HAS_CAPS(caps, _x)		(((caps) & (_x)) == (_x))
 
-#define MT7621_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_TRGMII | \
-		      MTK_GMAC2_RGMII | MTK_SHARED_INT | \
-		      MTK_TRGMII_MT7621_CLK | MTK_QDMA)
-
-#define MT7622_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_SGMII | MTK_GMAC2_RGMII | \
-		      MTK_GMAC2_SGMII | MTK_GDM1_ESW | \
-		      MTK_MUX_GDM1_TO_GMAC1_ESW | \
-		      MTK_MUX_GMAC1_GMAC2_TO_SGMII_RGMII | MTK_QDMA)
-
-#define MT7623_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_TRGMII | MTK_GMAC2_RGMII | \
-		      MTK_QDMA)
-
-#define MT7628_CAPS  (MTK_SHARED_INT | MTK_SOC_MT7628)
-
-#define MT7629_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPHY | \
-		      MTK_GDM1_ESW | MTK_MUX_GDM1_TO_GMAC1_ESW | \
-		      MTK_MUX_GMAC2_GMAC0_TO_GEPHY | \
-		      MTK_MUX_U3_GMAC2_TO_QPHY | \
-		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA)
+#define MT7621_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_TRGMII |	\
+		      MTK_GMAC2_RGMII | MTK_SHARED_INT |	\
+		      MTK_TRGMII_MT7621_CLK | MTK_QDMA |	\
+		      MTK_NETSYS_V1)
+
+#define MT7622_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_SGMII |	\
+		      MTK_GMAC2_RGMII | MTK_GMAC2_SGMII |	\
+		      MTK_GDM1_ESW | MTK_MUX_GDM1_TO_GMAC1_ESW |\
+		      MTK_MUX_GMAC1_GMAC2_TO_SGMII_RGMII |	\
+		      MTK_QDMA | MTK_NETSYS_V1)
+
+#define MT7623_CAPS  (MTK_GMAC1_RGMII | MTK_GMAC1_TRGMII |	\
+		      MTK_GMAC2_RGMII | MTK_QDMA |		\
+		      MTK_NETSYS_V1)
+
+#define MT7628_CAPS  (MTK_SHARED_INT | MTK_SOC_MT7628 |		\
+		      MTK_NETSYS_V1)
+
+#define MT7629_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII |	\
+		      MTK_GMAC2_GEPHY | MTK_GDM1_ESW |		\
+		      MTK_MUX_GMAC2_GMAC0_TO_GEPHY | MTK_QDMA |	\
+		      MTK_MUX_U3_GMAC2_TO_QPHY | MTK_NETSYS_V1 |\
+		      MTK_MUX_GDM1_TO_GMAC1_ESW |		\
+		      MTK_MUX_GMAC12_TO_GEPHY_SGMII)
 
 #define MT7981_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPHY | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
-- 
2.41.0
