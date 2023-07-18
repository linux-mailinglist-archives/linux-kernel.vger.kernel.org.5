Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2542A75873A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjGRVc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjGRVc1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:32:27 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5C419AD;
        Tue, 18 Jul 2023 14:32:16 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLsIb-0001MD-29;
        Tue, 18 Jul 2023 21:32:01 +0000
Date:   Tue, 18 Jul 2023 22:31:53 +0100
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
Subject: [PATCH net-next v3 6/9] net: ethernet: mtk_eth_soc: add NETSYS_V3
 version support
Message-ID: <121a8ac65c685a896c2b046e00cf490cd61e61b0.1689714291.git.daniel@makrotopia.org>
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

Introduce NETSYS_V3 chipset version support.
This is a preliminary patch to introduce support for MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 105 ++++++++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  48 +++++++--
 2 files changed, 116 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index ad8381be005f2..dd5a08c7ed41a 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -943,17 +943,32 @@ void mtk_stats_update_mac(struct mtk_mac *mac)
 			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x20 + offs);
 		hw_stats->rx_flow_control_packets +=
 			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x24 + offs);
-		hw_stats->tx_skip +=
-			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x28 + offs);
-		hw_stats->tx_collisions +=
-			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x2c + offs);
-		hw_stats->tx_bytes +=
-			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x30 + offs);
-		stats =  mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x34 + offs);
-		if (stats)
-			hw_stats->tx_bytes += (stats << 32);
-		hw_stats->tx_packets +=
-			mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x38 + offs);
+
+		if (mtk_is_netsys_v3_or_greater(eth)) {
+			hw_stats->tx_skip +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x50 + offs);
+			hw_stats->tx_collisions +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x54 + offs);
+			hw_stats->tx_bytes +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x40 + offs);
+			stats =  mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x44 + offs);
+			if (stats)
+				hw_stats->tx_bytes += (stats << 32);
+			hw_stats->tx_packets +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x48 + offs);
+		} else {
+			hw_stats->tx_skip +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x28 + offs);
+			hw_stats->tx_collisions +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x2c + offs);
+			hw_stats->tx_bytes +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x30 + offs);
+			stats =  mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x34 + offs);
+			if (stats)
+				hw_stats->tx_bytes += (stats << 32);
+			hw_stats->tx_packets +=
+				mtk_r32(mac->hw, reg_map->gdm1_cnt + 0x38 + offs);
+		}
 	}
 
 	u64_stats_update_end(&hw_stats->syncp);
@@ -1257,7 +1272,10 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
 		data |= TX_DMA_LS0;
 	WRITE_ONCE(desc->txd3, data);
 
-	data = (mac->id + 1) << TX_DMA_FPORT_SHIFT_V2; /* forward port */
+	if (mac->id == MTK_GMAC3_ID)
+		data = PSE_GDM3_PORT;
+	else
+		data = (mac->id + 1) << TX_DMA_FPORT_SHIFT_V2; /* forward port */
 	data |= TX_DMA_SWC_V2 | QID_BITS_V2(info->qid);
 	WRITE_ONCE(desc->txd4, data);
 
@@ -1268,6 +1286,8 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
 		/* tx checksum offload */
 		if (info->csum)
 			data |= TX_DMA_CHKSUM_V2;
+		if (mtk_is_netsys_v3_or_greater(eth) && netdev_uses_dsa(dev))
+			data |= TX_DMA_SPTAG_V3;
 	}
 	WRITE_ONCE(desc->txd5, data);
 
@@ -1333,8 +1353,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 	mtk_tx_set_dma_desc(dev, itxd, &txd_info);
 
 	itx_buf->flags |= MTK_TX_FLAGS_SINGLE0;
-	itx_buf->flags |= (!mac->id) ? MTK_TX_FLAGS_FPORT0 :
-			  MTK_TX_FLAGS_FPORT1;
+	itx_buf->mac_id = mac->id;
 	setup_tx_buf(eth, itx_buf, itxd_pdma, txd_info.addr, txd_info.size,
 		     k++);
 
@@ -1382,8 +1401,7 @@ static int mtk_tx_map(struct sk_buff *skb, struct net_device *dev,
 				memset(tx_buf, 0, sizeof(*tx_buf));
 			tx_buf->data = (void *)MTK_DMA_DUMMY_DESC;
 			tx_buf->flags |= MTK_TX_FLAGS_PAGE0;
-			tx_buf->flags |= (!mac->id) ? MTK_TX_FLAGS_FPORT0 :
-					 MTK_TX_FLAGS_FPORT1;
+			tx_buf->mac_id = mac->id;
 
 			setup_tx_buf(eth, tx_buf, txd_pdma, txd_info.addr,
 				     txd_info.size, k++);
@@ -1685,7 +1703,7 @@ static int mtk_xdp_frame_map(struct mtk_eth *eth, struct net_device *dev,
 	}
 	mtk_tx_set_dma_desc(dev, txd, txd_info);
 
-	tx_buf->flags |= !mac->id ? MTK_TX_FLAGS_FPORT0 : MTK_TX_FLAGS_FPORT1;
+	tx_buf->mac_id = mac->id;
 	tx_buf->type = dma_map ? MTK_TYPE_XDP_NDO : MTK_TYPE_XDP_TX;
 	tx_buf->data = (void *)MTK_DMA_DUMMY_DESC;
 
@@ -1935,11 +1953,24 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (mtk_is_netsys_v2_or_greater(eth))
-			mac = RX_DMA_GET_SPORT_V2(trxd.rxd5) - 1;
-		else if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
-			 !(trxd.rxd4 & RX_DMA_SPECIAL_TAG))
+		if (mtk_is_netsys_v2_or_greater(eth)) {
+			u32 val = RX_DMA_GET_SPORT_V2(trxd.rxd5);
+
+			switch (val) {
+			case PSE_GDM1_PORT:
+			case PSE_GDM2_PORT:
+				mac = val - 1;
+				break;
+			case PSE_GDM3_PORT:
+				mac = MTK_GMAC3_ID;
+				break;
+			default:
+				break;
+			}
+		} else if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) &&
+			   !(trxd.rxd4 & RX_DMA_SPECIAL_TAG)) {
 			mac = RX_DMA_GET_SPORT(trxd.rxd4) - 1;
+		}
 
 		if (unlikely(mac < 0 || mac >= MTK_MAX_DEVS ||
 			     !eth->netdev[mac]))
@@ -2161,7 +2192,6 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, int budget,
 
 	while ((cpu != dma) && budget) {
 		u32 next_cpu = desc->txd2;
-		int mac = 0;
 
 		desc = mtk_qdma_phys_to_virt(ring, desc->txd2);
 		if ((desc->txd3 & TX_DMA_OWNER_CPU) == 0)
@@ -2169,15 +2199,13 @@ static int mtk_poll_tx_qdma(struct mtk_eth *eth, int budget,
 
 		tx_buf = mtk_desc_to_tx_buf(ring, desc,
 					    eth->soc->txrx.txd_size);
-		if (tx_buf->flags & MTK_TX_FLAGS_FPORT1)
-			mac = 1;
-
 		if (!tx_buf->data)
 			break;
 
 		if (tx_buf->data != (void *)MTK_DMA_DUMMY_DESC) {
 			if (tx_buf->type == MTK_TYPE_SKB)
-				mtk_poll_tx_done(eth, state, mac, tx_buf->data);
+				mtk_poll_tx_done(eth, state, tx_buf->mac_id,
+						 tx_buf->data);
 
 			budget--;
 		}
@@ -3788,7 +3816,24 @@ static int mtk_hw_init(struct mtk_eth *eth, bool reset)
 	mtk_w32(eth, eth->soc->txrx.rx_irq_done_mask, reg_map->qdma.int_grp + 4);
 	mtk_w32(eth, 0x21021000, MTK_FE_INT_GRP);
 
-	if (mtk_is_netsys_v2_or_greater(eth)) {
+	if (mtk_is_netsys_v3_or_greater(eth)) {
+		/* PSE should not drop port1, port8 and port9 packets */
+		mtk_w32(eth, 0x00000302, PSE_DROP_CFG);
+
+		/* GDM and CDM Threshold */
+		mtk_w32(eth, 0x00000707, MTK_CDMW0_THRES);
+		mtk_w32(eth, 0x00000077, MTK_CDMW1_THRES);
+
+		/* Disable GDM1 RX CRC stripping */
+		mtk_m32(eth, MTK_GDMA_STRP_CRC, 0, MTK_GDMA_FWD_CFG(0));
+
+		/* PSE GDM3 MIB counter has incorrect hw default values,
+		 * so the driver ought to read clear the values beforehand
+		 * in case ethtool retrieve wrong mib values.
+		 */
+		for (i = 0; i < 0x80; i += 0x4)
+			mtk_r32(eth, reg_map->gdm1_cnt + 0x100 + i);
+	} else if (!mtk_is_netsys_v1(eth)) {
 		/* PSE should not drop port8 and port9 packets from WDMA Tx */
 		mtk_w32(eth, 0x00000300, PSE_DROP_CFG);
 
@@ -4358,7 +4403,11 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 	}
 	spin_lock_init(&mac->hw_stats->stats_lock);
 	u64_stats_init(&mac->hw_stats->syncp);
-	mac->hw_stats->reg_offset = id * MTK_STAT_OFFSET;
+
+	if (mtk_is_netsys_v3_or_greater(eth))
+		mac->hw_stats->reg_offset = id * 0x80;
+	else
+		mac->hw_stats->reg_offset = id * 0x40;
 
 	/* phylink create */
 	err = of_get_phy_mode(np, &phy_mode);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index e33be61acc047..2810c250ae9a6 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -122,6 +122,7 @@
 #define MTK_GDMA_ICS_EN		BIT(22)
 #define MTK_GDMA_TCS_EN		BIT(21)
 #define MTK_GDMA_UCS_EN		BIT(20)
+#define MTK_GDMA_STRP_CRC	BIT(16)
 #define MTK_GDMA_TO_PDMA	0x0
 #define MTK_GDMA_DROP_ALL       0x7777
 
@@ -287,8 +288,6 @@
 /* QDMA Interrupt grouping registers */
 #define MTK_RLS_DONE_INT	BIT(0)
 
-#define MTK_STAT_OFFSET		0x40
-
 /* QDMA TX NUM */
 #define QID_BITS_V2(x)		(((x) & 0x3f) << 16)
 #define MTK_QDMA_GMAC2_QID	8
@@ -301,6 +300,8 @@
 #define TX_DMA_CHKSUM_V2	(0x7 << 28)
 #define TX_DMA_TSO_V2		BIT(31)
 
+#define TX_DMA_SPTAG_V3         BIT(27)
+
 /* QDMA V2 descriptor txd4 */
 #define TX_DMA_FPORT_SHIFT_V2	8
 #define TX_DMA_FPORT_MASK_V2	0xf
@@ -634,12 +635,6 @@ enum mtk_tx_flags {
 	 */
 	MTK_TX_FLAGS_SINGLE0	= 0x01,
 	MTK_TX_FLAGS_PAGE0	= 0x02,
-
-	/* MTK_TX_FLAGS_FPORTx allows tracking which port the transmitted
-	 * SKB out instead of looking up through hardware TX descriptor.
-	 */
-	MTK_TX_FLAGS_FPORT0	= 0x04,
-	MTK_TX_FLAGS_FPORT1	= 0x08,
 };
 
 /* This enum allows us to identify how the clock is defined on the array of the
@@ -725,6 +720,35 @@ enum mtk_dev_state {
 	MTK_RESETTING
 };
 
+/* PSE Port Definition */
+enum mtk_pse_port {
+	PSE_ADMA_PORT = 0,
+	PSE_GDM1_PORT,
+	PSE_GDM2_PORT,
+	PSE_PPE0_PORT,
+	PSE_PPE1_PORT,
+	PSE_QDMA_TX_PORT,
+	PSE_QDMA_RX_PORT,
+	PSE_DROP_PORT,
+	PSE_WDMA0_PORT,
+	PSE_WDMA1_PORT,
+	PSE_TDMA_PORT,
+	PSE_NONE_PORT,
+	PSE_PPE2_PORT,
+	PSE_WDMA2_PORT,
+	PSE_EIP197_PORT,
+	PSE_GDM3_PORT,
+	PSE_PORT_MAX
+};
+
+/* GMAC Identifier */
+enum mtk_gmac_id {
+	MTK_GMAC1_ID = 0,
+	MTK_GMAC2_ID,
+	MTK_GMAC3_ID,
+	MTK_GMAC_ID_MAX
+};
+
 enum mtk_tx_buf_type {
 	MTK_TYPE_SKB,
 	MTK_TYPE_XDP_TX,
@@ -743,7 +767,8 @@ struct mtk_tx_buf {
 	enum mtk_tx_buf_type type;
 	void *data;
 
-	u32 flags;
+	u16 mac_id;
+	u16 flags;
 	DEFINE_DMA_UNMAP_ADDR(dma_addr0);
 	DEFINE_DMA_UNMAP_LEN(dma_len0);
 	DEFINE_DMA_UNMAP_ADDR(dma_addr1);
@@ -1191,6 +1216,11 @@ static inline bool mtk_is_netsys_v2_or_greater(struct mtk_eth *eth)
 	return eth->soc->version > 1;
 }
 
+static inline bool mtk_is_netsys_v3_or_greater(struct mtk_eth *eth)
+{
+	return eth->soc->version > 2;
+}
+
 static inline struct mtk_foe_entry *
 mtk_foe_get_entry(struct mtk_ppe *ppe, u16 hash)
 {
-- 
2.41.0
