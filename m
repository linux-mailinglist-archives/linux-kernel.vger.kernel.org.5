Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B493758731
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGRVbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjGRVbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:31:12 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C81A1992;
        Tue, 18 Jul 2023 14:31:09 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLsHa-0001Kl-0J;
        Tue, 18 Jul 2023 21:30:58 +0000
Date:   Tue, 18 Jul 2023 22:30:49 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
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
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Ungerer <gerg@kernel.org>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3 3/9] net: ethernet: mtk_eth_soc: add version in
 mtk_soc_data
Message-ID: <740b8468a4824488fb32fe0e26657f38820e5f32.1689714291.git.daniel@makrotopia.org>
References: <cover.1689714290.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689714290.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Introduce version field in mtk_soc_data data structure in order to
make mtk_eth driver easier to maintain for chipset configuration
codebase. Get rid of MTK_NETSYS_V2 bit in chip capabilities.
This is a preliminary patch to introduce support for MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c   | 55 +++++++++++--------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h   | 36 +++++++-----
 drivers/net/ethernet/mediatek/mtk_ppe.c       | 18 +++---
 .../net/ethernet/mediatek/mtk_ppe_offload.c   |  2 +-
 drivers/net/ethernet/mediatek/mtk_wed.c       |  4 +-
 5 files changed, 66 insertions(+), 49 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 834c644b67db5..01b1449e1b2f3 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -659,7 +659,7 @@ static void mtk_set_queue_speed(struct mtk_eth *eth, unsigned int idx,
 	      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_MAN, 1) |
 	      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_EXP, 4) |
 	      MTK_QTX_SCH_LEAKY_BUCKET_SIZE;
-	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v1(eth))
 		val |= MTK_QTX_SCH_LEAKY_BUCKET_EN;
 
 	if (IS_ENABLED(CONFIG_SOC_MT7621)) {
@@ -1037,7 +1037,7 @@ static bool mtk_rx_get_desc(struct mtk_eth *eth, struct mtk_rx_dma_v2 *rxd,
 	rxd->rxd1 = READ_ONCE(dma_rxd->rxd1);
 	rxd->rxd3 = READ_ONCE(dma_rxd->rxd3);
 	rxd->rxd4 = READ_ONCE(dma_rxd->rxd4);
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		rxd->rxd5 = READ_ONCE(dma_rxd->rxd5);
 		rxd->rxd6 = READ_ONCE(dma_rxd->rxd6);
 	}
@@ -1095,7 +1095,7 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 
 		txd->txd3 = TX_DMA_PLEN0(MTK_QDMA_PAGE_SIZE);
 		txd->txd4 = 0;
-		if (MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V2)) {
+		if (mtk_is_netsys_v2_or_greater(eth)) {
 			txd->txd5 = 0;
 			txd->txd6 = 0;
 			txd->txd7 = 0;
@@ -1286,7 +1286,7 @@ static void mtk_tx_set_dma_desc(struct net_device *dev, void *txd,
 	struct mtk_mac *mac = netdev_priv(dev);
 	struct mtk_eth *eth = mac->hw;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		mtk_tx_set_dma_desc_v2(dev, txd, info);
 	else
 		mtk_tx_set_dma_desc_v1(dev, txd, info);
@@ -1593,7 +1593,7 @@ static void mtk_update_rx_cpu_idx(struct mtk_eth *eth)
 
 static bool mtk_page_pool_enabled(struct mtk_eth *eth)
 {
-	return MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2);
+	return eth->soc->version == 2;
 }
 
 static struct page_pool *mtk_create_page_pool(struct mtk_eth *eth,
@@ -1935,7 +1935,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (mtk_is_netsys_v2_or_greater(eth))
 			mac = RX_DMA_GET_SPORT_V2(trxd.rxd5) - 1;
 		else if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
 			 !(trxd.rxd4 & RX_DMA_SPECIAL_TAG))
@@ -2031,7 +2031,7 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		skb->dev = netdev;
 		bytes += skb->len;
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+		if (mtk_is_netsys_v2_or_greater(eth)) {
 			reason = FIELD_GET(MTK_RXD5_PPE_CPU_REASON, trxd.rxd5);
 			hash = trxd.rxd5 & MTK_RXD5_FOE_ENTRY;
 			if (hash != MTK_RXD5_FOE_ENTRY)
@@ -2056,8 +2056,8 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 		/* When using VLAN untagging in combination with DSA, the
 		 * hardware treats the MTK special tag as a VLAN and untags it.
 		 */
-		if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2) &&
-		    (trxd.rxd2 & RX_DMA_VTAG) && netdev_uses_dsa(netdev)) {
+		if (mtk_is_netsys_v1(eth) && (trxd.rxd2 & RX_DMA_VTAG) &&
+		    netdev_uses_dsa(netdev)) {
 			unsigned int port = RX_DMA_VPID(trxd.rxd3) & GENMASK(2, 0);
 
 			if (port < ARRAY_SIZE(eth->dsa_meta) &&
@@ -2367,7 +2367,7 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 		txd->txd2 = next_ptr;
 		txd->txd3 = TX_DMA_LS0 | TX_DMA_OWNER_CPU;
 		txd->txd4 = 0;
-		if (MTK_HAS_CAPS(soc->caps, MTK_NETSYS_V2)) {
+		if (mtk_is_netsys_v2_or_greater(eth)) {
 			txd->txd5 = 0;
 			txd->txd6 = 0;
 			txd->txd7 = 0;
@@ -2420,14 +2420,14 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 			      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_MAN, 1) |
 			      FIELD_PREP(MTK_QTX_SCH_MIN_RATE_EXP, 4) |
 			      MTK_QTX_SCH_LEAKY_BUCKET_SIZE;
-			if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+			if (mtk_is_netsys_v1(eth))
 				val |= MTK_QTX_SCH_LEAKY_BUCKET_EN;
 			mtk_w32(eth, val, soc->reg_map->qdma.qtx_sch + ofs);
 			ofs += MTK_QTX_OFFSET;
 		}
 		val = MTK_QDMA_TX_SCH_MAX_WFQ | (MTK_QDMA_TX_SCH_MAX_WFQ << 16);
 		mtk_w32(eth, val, soc->reg_map->qdma.tx_sch_rate);
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (mtk_is_netsys_v2_or_greater(eth))
 			mtk_w32(eth, val, soc->reg_map->qdma.tx_sch_rate + 4);
 	} else {
 		mtk_w32(eth, ring->phys_pdma, MT7628_TX_BASE_PTR0);
@@ -2556,7 +2556,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 
 		rxd->rxd3 = 0;
 		rxd->rxd4 = 0;
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+		if (mtk_is_netsys_v2_or_greater(eth)) {
 			rxd->rxd5 = 0;
 			rxd->rxd6 = 0;
 			rxd->rxd7 = 0;
@@ -3104,7 +3104,7 @@ static int mtk_start_dma(struct mtk_eth *eth)
 		       MTK_TX_BT_32DWORDS | MTK_NDP_CO_PRO |
 		       MTK_RX_2B_OFFSET | MTK_TX_WB_DDONE;
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (mtk_is_netsys_v2_or_greater(eth))
 			val |= MTK_MUTLI_CNT | MTK_RESV_BUF |
 			       MTK_WCOMP_EN | MTK_DMAD_WR_WDONE |
 			       MTK_CHK_DDONE_EN | MTK_LEAKY_BUCKET_EN;
@@ -3250,7 +3250,7 @@ static int mtk_open(struct net_device *dev)
 	phylink_start(mac->phylink);
 	netif_tx_start_all_queues(dev);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return 0;
 
 	if (mtk_uses_dsa(dev) && !eth->prog) {
@@ -3516,7 +3516,7 @@ static void mtk_hw_reset(struct mtk_eth *eth)
 {
 	u32 val;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN, 0);
 		val = RSTCTRL_PPE0_V2;
 	} else {
@@ -3528,7 +3528,7 @@ static void mtk_hw_reset(struct mtk_eth *eth)
 
 	ethsys_reset(eth, RSTCTRL_ETH | RSTCTRL_FE | val);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		regmap_write(eth->ethsys, ETHSYS_FE_RST_CHK_IDLE_EN,
 			     0x3ffffff);
 }
@@ -3554,7 +3554,7 @@ static void mtk_hw_warm_reset(struct mtk_eth *eth)
 		return;
 	}
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0_V2;
 	else
 		rst_mask = RSTCTRL_ETH | RSTCTRL_PPE0;
@@ -3724,7 +3724,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	else
 		mtk_hw_reset(eth);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		/* Set FE to PDMAv2 if necessary */
 		val = mtk_r32(eth, MTK_FE_GLO_MISC);
 		mtk_w32(eth,  val | BIT(4), MTK_FE_GLO_MISC);
@@ -3761,7 +3761,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	 */
 	val = mtk_r32(eth, MTK_CDMQ_IG_CTRL);
 	mtk_w32(eth, val | MTK_CDMQ_STAG_EN, MTK_CDMQ_IG_CTRL);
-	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v1(eth)) {
 		val = mtk_r32(eth, MTK_CDMP_IG_CTRL);
 		mtk_w32(eth, val | MTK_CDMP_STAG_EN, MTK_CDMP_IG_CTRL);
 
@@ -3783,7 +3783,7 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->qdma.int_grp + 4);
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		/* PSE should not drop port8 and port9 packets from WDMA Tx */
 		mtk_w32(eth, 0x00000300, PSE_DROP_CFG);
 
@@ -4591,7 +4591,7 @@ static int mtk_probe(struct platform_device *pdev)
 		}
 	}
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 		if (!res) {
 			err = -EINVAL;
@@ -4699,9 +4699,8 @@ static int mtk_probe(struct platform_device *pdev)
 	}
 
 	if (eth->soc->offload_version) {
-		u32 num_ppe;
+		u32 num_ppe = mtk_is_netsys_v2_or_greater(eth) ? 2 : 1;
 
-		num_ppe = MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2) ? 2 : 1;
 		num_ppe = min_t(u32, ARRAY_SIZE(eth->ppe), num_ppe);
 		for (i = 0; i < num_ppe; i++) {
 			u32 ppe_addr = eth->soc->reg_map->ppe_base + i * 0x400;
@@ -4793,6 +4792,7 @@ static const struct mtk_soc_data mt2701_data = {
 	.hw_features = MTK_HW_FEATURES,
 	.required_clks = MT7623_CLKS_BITMAP,
 	.required_pctl = true,
+	.version = 1,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
@@ -4811,6 +4811,7 @@ static const struct mtk_soc_data mt7621_data = {
 	.required_pctl = false,
 	.offload_version = 1,
 	.hash_offset = 2,
+	.version = 1,
 	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
@@ -4831,6 +4832,7 @@ static const struct mtk_soc_data mt7622_data = {
 	.required_pctl = false,
 	.offload_version = 2,
 	.hash_offset = 2,
+	.version = 1,
 	.has_accounting = true,
 	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
 	.txrx = {
@@ -4851,6 +4853,7 @@ static const struct mtk_soc_data mt7623_data = {
 	.required_pctl = true,
 	.offload_version = 1,
 	.hash_offset = 2,
+	.version = 1,
 	.foe_entry_size = sizeof(struct mtk_foe_entry) - 16,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
@@ -4870,6 +4873,7 @@ static const struct mtk_soc_data mt7629_data = {
 	.required_clks = MT7629_CLKS_BITMAP,
 	.required_pctl = false,
 	.has_accounting = true,
+	.version = 1,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
@@ -4889,6 +4893,7 @@ static const struct mtk_soc_data mt7981_data = {
 	.required_pctl = false,
 	.offload_version = 2,
 	.hash_offset = 4,
+	.version = 2,
 	.foe_entry_size = sizeof(struct mtk_foe_entry),
 	.has_accounting = true,
 	.txrx = {
@@ -4910,6 +4915,7 @@ static const struct mtk_soc_data mt7986_data = {
 	.required_pctl = false,
 	.offload_version = 2,
 	.hash_offset = 4,
+	.version = 2,
 	.foe_entry_size = sizeof(struct mtk_foe_entry),
 	.has_accounting = true,
 	.txrx = {
@@ -4928,6 +4934,7 @@ static const struct mtk_soc_data rt5350_data = {
 	.hw_features = MTK_HW_FEATURES_MT7628,
 	.required_clks = MT7628_CLKS_BITMAP,
 	.required_pctl = false,
+	.version = 1,
 	.txrx = {
 		.txd_size = sizeof(struct mtk_tx_dma),
 		.rxd_size = sizeof(struct mtk_rx_dma),
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 707445f6bcb1b..1c28bf3731831 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -820,7 +820,6 @@ enum mkt_eth_capabilities {
 	MTK_SHARED_INT_BIT,
 	MTK_TRGMII_MT7621_CLK_BIT,
 	MTK_QDMA_BIT,
-	MTK_NETSYS_V2_BIT,
 	MTK_SOC_MT7628_BIT,
 	MTK_RSTCTRL_PPE1_BIT,
 	MTK_U3_COPHY_V2_BIT,
@@ -855,7 +854,6 @@ enum mkt_eth_capabilities {
 #define MTK_SHARED_INT		BIT(MTK_SHARED_INT_BIT)
 #define MTK_TRGMII_MT7621_CLK	BIT(MTK_TRGMII_MT7621_CLK_BIT)
 #define MTK_QDMA		BIT(MTK_QDMA_BIT)
-#define MTK_NETSYS_V2		BIT(MTK_NETSYS_V2_BIT)
 #define MTK_SOC_MT7628		BIT(MTK_SOC_MT7628_BIT)
 #define MTK_RSTCTRL_PPE1	BIT(MTK_RSTCTRL_PPE1_BIT)
 #define MTK_U3_COPHY_V2		BIT(MTK_U3_COPHY_V2_BIT)
@@ -934,11 +932,11 @@ enum mkt_eth_capabilities {
 #define MT7981_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPHY | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_MUX_U3_GMAC2_TO_QPHY | MTK_U3_COPHY_V2 | \
-		      MTK_NETSYS_V2 | MTK_RSTCTRL_PPE1)
+		      MTK_RSTCTRL_PPE1)
 
 #define MT7986_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
-		      MTK_NETSYS_V2 | MTK_RSTCTRL_PPE1)
+		      MTK_RSTCTRL_PPE1)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1009,6 +1007,7 @@ struct mtk_reg_map {
  * @required_pctl		A bool value to show whether the SoC requires
  *				the extra setup for those pins used by GMAC.
  * @hash_offset			Flow table hash offset.
+ * @version			SoC version.
  * @foe_entry_size		Foe table entry size.
  * @has_accounting		Bool indicating support for accounting of
  *				offloaded flows.
@@ -1027,6 +1026,7 @@ struct mtk_soc_data {
 	bool		required_pctl;
 	u8		offload_version;
 	u8		hash_offset;
+	u8		version;
 	u16		foe_entry_size;
 	netdev_features_t hw_features;
 	bool		has_accounting;
@@ -1182,6 +1182,16 @@ struct mtk_mac {
 /* the struct describing the SoC. these are declared in the soc_xyz.c files */
 extern const struct of_device_id of_mtk_match[];
 
+static inline bool mtk_is_netsys_v1(struct mtk_eth *eth)
+{
+	return eth->soc->version == 1;
+}
+
+static inline bool mtk_is_netsys_v2_or_greater(struct mtk_eth *eth)
+{
+	return eth->soc->version > 1;
+}
+
 static inline struct mtk_foe_entry *
 mtk_foe_get_entry(struct mtk_ppe *ppe, u16 hash)
 {
@@ -1192,7 +1202,7 @@ mtk_foe_get_entry(struct mtk_ppe *ppe, u16 hash)
 
 static inline u32 mtk_get_ib1_ts_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB1_BIND_TIMESTAMP_V2;
 
 	return MTK_FOE_IB1_BIND_TIMESTAMP;
@@ -1200,7 +1210,7 @@ static inline u32 mtk_get_ib1_ts_mask(struct mtk_eth *eth)
 
 static inline u32 mtk_get_ib1_ppoe_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB1_BIND_PPPOE_V2;
 
 	return MTK_FOE_IB1_BIND_PPPOE;
@@ -1208,7 +1218,7 @@ static inline u32 mtk_get_ib1_ppoe_mask(struct mtk_eth *eth)
 
 static inline u32 mtk_get_ib1_vlan_tag_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB1_BIND_VLAN_TAG_V2;
 
 	return MTK_FOE_IB1_BIND_VLAN_TAG;
@@ -1216,7 +1226,7 @@ static inline u32 mtk_get_ib1_vlan_tag_mask(struct mtk_eth *eth)
 
 static inline u32 mtk_get_ib1_vlan_layer_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB1_BIND_VLAN_LAYER_V2;
 
 	return MTK_FOE_IB1_BIND_VLAN_LAYER;
@@ -1224,7 +1234,7 @@ static inline u32 mtk_get_ib1_vlan_layer_mask(struct mtk_eth *eth)
 
 static inline u32 mtk_prep_ib1_vlan_layer(struct mtk_eth *eth, u32 val)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return FIELD_PREP(MTK_FOE_IB1_BIND_VLAN_LAYER_V2, val);
 
 	return FIELD_PREP(MTK_FOE_IB1_BIND_VLAN_LAYER, val);
@@ -1232,7 +1242,7 @@ static inline u32 mtk_prep_ib1_vlan_layer(struct mtk_eth *eth, u32 val)
 
 static inline u32 mtk_get_ib1_vlan_layer(struct mtk_eth *eth, u32 val)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return FIELD_GET(MTK_FOE_IB1_BIND_VLAN_LAYER_V2, val);
 
 	return FIELD_GET(MTK_FOE_IB1_BIND_VLAN_LAYER, val);
@@ -1240,7 +1250,7 @@ static inline u32 mtk_get_ib1_vlan_layer(struct mtk_eth *eth, u32 val)
 
 static inline u32 mtk_get_ib1_pkt_type_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB1_PACKET_TYPE_V2;
 
 	return MTK_FOE_IB1_PACKET_TYPE;
@@ -1248,7 +1258,7 @@ static inline u32 mtk_get_ib1_pkt_type_mask(struct mtk_eth *eth)
 
 static inline u32 mtk_get_ib1_pkt_type(struct mtk_eth *eth, u32 val)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return FIELD_GET(MTK_FOE_IB1_PACKET_TYPE_V2, val);
 
 	return FIELD_GET(MTK_FOE_IB1_PACKET_TYPE, val);
@@ -1256,7 +1266,7 @@ static inline u32 mtk_get_ib1_pkt_type(struct mtk_eth *eth, u32 val)
 
 static inline u32 mtk_get_ib2_multicast_mask(struct mtk_eth *eth)
 {
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(eth))
 		return MTK_FOE_IB2_MULTICAST_V2;
 
 	return MTK_FOE_IB2_MULTICAST;
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe.c b/drivers/net/ethernet/mediatek/mtk_ppe.c
index 9129821f3ab8f..2f0e682449ef6 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe.c
@@ -208,7 +208,7 @@ int mtk_foe_entry_prepare(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 
 	memset(entry, 0, sizeof(*entry));
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		val = FIELD_PREP(MTK_FOE_IB1_STATE, MTK_FOE_STATE_BIND) |
 		      FIELD_PREP(MTK_FOE_IB1_PACKET_TYPE_V2, type) |
 		      FIELD_PREP(MTK_FOE_IB1_UDP, l4proto == IPPROTO_UDP) |
@@ -272,7 +272,7 @@ int mtk_foe_entry_set_pse_port(struct mtk_eth *eth,
 	u32 *ib2 = mtk_foe_entry_ib2(eth, entry);
 	u32 val = *ib2;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		val &= ~MTK_FOE_IB2_DEST_PORT_V2;
 		val |= FIELD_PREP(MTK_FOE_IB2_DEST_PORT_V2, port);
 	} else {
@@ -423,7 +423,7 @@ int mtk_foe_entry_set_wdma(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 	struct mtk_foe_mac_info *l2 = mtk_foe_entry_l2(eth, entry);
 	u32 *ib2 = mtk_foe_entry_ib2(eth, entry);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		*ib2 &= ~MTK_FOE_IB2_PORT_MG_V2;
 		*ib2 |=  FIELD_PREP(MTK_FOE_IB2_RX_IDX, txq) |
 			 MTK_FOE_IB2_WDMA_WINFO_V2;
@@ -447,7 +447,7 @@ int mtk_foe_entry_set_queue(struct mtk_eth *eth, struct mtk_foe_entry *entry,
 {
 	u32 *ib2 = mtk_foe_entry_ib2(eth, entry);
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		*ib2 &= ~MTK_FOE_IB2_QID_V2;
 		*ib2 |= FIELD_PREP(MTK_FOE_IB2_QID_V2, queue);
 		*ib2 |= MTK_FOE_IB2_PSE_QOS_V2;
@@ -603,7 +603,7 @@ __mtk_foe_entry_commit(struct mtk_ppe *ppe, struct mtk_foe_entry *entry,
 	struct mtk_foe_entry *hwe;
 	u32 val;
 
-	if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(eth)) {
 		entry->ib1 &= ~MTK_FOE_IB1_BIND_TIMESTAMP_V2;
 		entry->ib1 |= FIELD_PREP(MTK_FOE_IB1_BIND_TIMESTAMP_V2,
 					 timestamp);
@@ -619,7 +619,7 @@ __mtk_foe_entry_commit(struct mtk_ppe *ppe, struct mtk_foe_entry *entry,
 	hwe->ib1 = entry->ib1;
 
 	if (ppe->accounting) {
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (mtk_is_netsys_v2_or_greater(eth))
 			val = MTK_FOE_IB2_MIB_CNT_V2;
 		else
 			val = MTK_FOE_IB2_MIB_CNT;
@@ -979,7 +979,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 			 MTK_PPE_SCAN_MODE_KEEPALIVE_AGE) |
 	      FIELD_PREP(MTK_PPE_TB_CFG_ENTRY_NUM,
 			 MTK_PPE_ENTRIES_SHIFT);
-	if (MTK_HAS_CAPS(ppe->eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(ppe->eth))
 		val |= MTK_PPE_TB_CFG_INFO_SEL;
 	ppe_w32(ppe, MTK_PPE_TB_CFG, val);
 
@@ -995,7 +995,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 	      MTK_PPE_FLOW_CFG_IP4_NAPT |
 	      MTK_PPE_FLOW_CFG_IP4_DSLITE |
 	      MTK_PPE_FLOW_CFG_IP4_NAT_FRAG;
-	if (MTK_HAS_CAPS(ppe->eth->soc->caps, MTK_NETSYS_V2))
+	if (mtk_is_netsys_v2_or_greater(ppe->eth))
 		val |= MTK_PPE_MD_TOAP_BYP_CRSN0 |
 		       MTK_PPE_MD_TOAP_BYP_CRSN1 |
 		       MTK_PPE_MD_TOAP_BYP_CRSN2 |
@@ -1037,7 +1037,7 @@ void mtk_ppe_start(struct mtk_ppe *ppe)
 
 	ppe_w32(ppe, MTK_PPE_DEFAULT_CPU_PORT, 0);
 
-	if (MTK_HAS_CAPS(ppe->eth->soc->caps, MTK_NETSYS_V2)) {
+	if (mtk_is_netsys_v2_or_greater(ppe->eth)) {
 		ppe_w32(ppe, MTK_PPE_DEFAULT_CPU_PORT1, 0xcb777);
 		ppe_w32(ppe, MTK_PPE_SBW_CTRL, 0x7f);
 	}
diff --git a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
index 02eebff02d457..a70a5417c1734 100644
--- a/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
+++ b/drivers/net/ethernet/mediatek/mtk_ppe_offload.c
@@ -193,7 +193,7 @@ mtk_flow_set_output_device(struct mtk_eth *eth, struct mtk_foe_entry *foe,
 	if (mtk_flow_get_wdma_info(dev, dest_mac, &info) == 0) {
 		mtk_foe_entry_set_wdma(eth, foe, info.wdma_idx, info.queue,
 				       info.bss, info.wcid);
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2)) {
+		if (mtk_is_netsys_v2_or_greater(eth)) {
 			switch (info.wdma_idx) {
 			case 0:
 				pse_port = 8;
diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 985cff910f30c..5f062ecb402cc 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1091,7 +1091,7 @@ mtk_wed_rx_reset(struct mtk_wed_device *dev)
 	} else {
 		struct mtk_eth *eth = dev->hw->eth;
 
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2))
+		if (mtk_is_netsys_v2_or_greater(eth))
 			wed_set(dev, MTK_WED_RESET_IDX,
 				MTK_WED_RESET_IDX_RX_V2);
 		else
@@ -1907,7 +1907,7 @@ void mtk_wed_add_hw(struct device_node *np, struct mtk_eth *eth,
 	hw->wdma = wdma;
 	hw->index = index;
 	hw->irq = irq;
-	hw->version = MTK_HAS_CAPS(eth->soc->caps, MTK_NETSYS_V2) ? 2 : 1;
+	hw->version = mtk_is_netsys_v1(eth) ? 1 : 2;
 
 	if (hw->version == 1) {
 		hw->mirror = syscon_regmap_lookup_by_phandle(eth_np,
-- 
2.41.0
