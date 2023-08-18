Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D368E7815B8
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242314AbjHRXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242587AbjHRXQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:16:32 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 630B530D8;
        Fri, 18 Aug 2023 16:16:30 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qX8hX-000175-1L;
        Fri, 18 Aug 2023 23:16:20 +0000
Date:   Sat, 19 Aug 2023 00:16:06 +0100
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
Subject: [PATCH net-next 3/4] net: ethernet: mtk_eth_soc: add support for
 in-SoC SRAM
Message-ID: <f24cefa3f0f1ead90ab8552099d6ceeeb12ba997.1692400170.git.daniel@makrotopia.org>
References: <cover.1692400170.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1692400170.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MT7981, MT7986 and MT7988 come with in-SoC SRAM dedicated for Ethernet
DMA rings. Support using the SRAM without breaking existing device tree
bindings, ie. only new SoC starting from MT7988 will have the SRAM
declared as additional resource in device tree. For MT7981 and MT7986
an offset on top of the main I/O base is used.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 84 ++++++++++++++++-----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h | 12 ++-
 2 files changed, 74 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 2482f47313085..eea3a7e578831 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1135,10 +1135,13 @@ static int mtk_init_fq_dma(struct mtk_eth *eth)
 	dma_addr_t dma_addr;
 	int i;
 
-	eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
-					       cnt * soc->txrx.txd_size,
-					       &eth->phy_scratch_ring,
-					       GFP_KERNEL);
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM))
+		eth->scratch_ring = eth->sram_base;
+	else
+		eth->scratch_ring = dma_alloc_coherent(eth->dma_dev,
+						       cnt * soc->txrx.txd_size,
+						       &eth->phy_scratch_ring,
+						       GFP_KERNEL);
 	if (unlikely(!eth->scratch_ring))
 		return -ENOMEM;
 
@@ -2446,8 +2449,14 @@ static int mtk_tx_alloc(struct mtk_eth *eth)
 	if (!ring->buf)
 		goto no_tx_mem;
 
-	ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
-				       &ring->phys, GFP_KERNEL);
+	if (MTK_HAS_CAPS(soc->caps, MTK_SRAM)) {
+		ring->dma = eth->sram_base + ring_size * sz;
+		ring->phys = eth->phy_scratch_ring + ring_size * (dma_addr_t)sz;
+	} else {
+		ring->dma = dma_alloc_coherent(eth->dma_dev, ring_size * sz,
+					       &ring->phys, GFP_KERNEL);
+	}
+
 	if (!ring->dma)
 		goto no_tx_mem;
 
@@ -2546,8 +2555,7 @@ static void mtk_tx_clean(struct mtk_eth *eth)
 		kfree(ring->buf);
 		ring->buf = NULL;
 	}
-
-	if (ring->dma) {
+	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
 				  ring->dma_size * soc->txrx.txd_size,
 				  ring->dma, ring->phys);
@@ -2566,9 +2574,14 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 {
 	const struct mtk_reg_map *reg_map = eth->soc->reg_map;
 	struct mtk_rx_ring *ring;
-	int rx_data_len, rx_dma_size;
+	int rx_data_len, rx_dma_size, tx_ring_size;
 	int i;
 
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_QDMA))
+		tx_ring_size = MTK_QDMA_RING_SIZE;
+	else
+		tx_ring_size = MTK_DMA_SIZE;
+
 	if (rx_flag == MTK_RX_FLAGS_QDMA) {
 		if (ring_no)
 			return -EINVAL;
@@ -2603,9 +2616,20 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 		ring->page_pool = pp;
 	}
 
-	ring->dma = dma_alloc_coherent(eth->dma_dev,
-				       rx_dma_size * eth->soc->txrx.rxd_size,
-				       &ring->phys, GFP_KERNEL);
+	if (!MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM) ||
+	    rx_flag != MTK_RX_FLAGS_NORMAL) {
+		ring->dma = dma_alloc_coherent(eth->dma_dev,
+					       rx_dma_size * eth->soc->txrx.rxd_size,
+					       &ring->phys, GFP_KERNEL);
+	} else {
+		struct mtk_tx_ring *tx_ring = &eth->tx_ring;
+
+		ring->dma = tx_ring->dma + tx_ring_size *
+			    eth->soc->txrx.txd_size * (ring_no + 1);
+		ring->phys = tx_ring->phys + tx_ring_size *
+			     eth->soc->txrx.txd_size * (ring_no + 1);
+	}
+
 	if (!ring->dma)
 		return -ENOMEM;
 
@@ -2690,7 +2714,7 @@ static int mtk_rx_alloc(struct mtk_eth *eth, int ring_no, int rx_flag)
 	return 0;
 }
 
-static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring)
+static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring, bool in_sram)
 {
 	int i;
 
@@ -2713,7 +2737,7 @@ static void mtk_rx_clean(struct mtk_eth *eth, struct mtk_rx_ring *ring)
 		ring->data = NULL;
 	}
 
-	if (ring->dma) {
+	if (!in_sram && ring->dma) {
 		dma_free_coherent(eth->dma_dev,
 				  ring->dma_size * eth->soc->txrx.rxd_size,
 				  ring->dma, ring->phys);
@@ -3073,7 +3097,7 @@ static void mtk_dma_free(struct mtk_eth *eth)
 	for (i = 0; i < MTK_MAX_DEVS; i++)
 		if (eth->netdev[i])
 			netdev_reset_queue(eth->netdev[i]);
-	if (eth->scratch_ring) {
+	if (!MTK_HAS_CAPS(soc->caps, MTK_SRAM) && eth->scratch_ring) {
 		dma_free_coherent(eth->dma_dev,
 				  MTK_QDMA_RING_SIZE * soc->txrx.txd_size,
 				  eth->scratch_ring, eth->phy_scratch_ring);
@@ -3081,13 +3105,13 @@ static void mtk_dma_free(struct mtk_eth *eth)
 		eth->phy_scratch_ring = 0;
 	}
 	mtk_tx_clean(eth);
-	mtk_rx_clean(eth, &eth->rx_ring[0]);
-	mtk_rx_clean(eth, &eth->rx_ring_qdma);
+	mtk_rx_clean(eth, &eth->rx_ring[0], MTK_HAS_CAPS(soc->caps, MTK_SRAM));
+	mtk_rx_clean(eth, &eth->rx_ring_qdma, false);
 
 	if (eth->hwlro) {
 		mtk_hwlro_rx_uninit(eth);
 		for (i = 1; i < MTK_MAX_RX_RING_NUM; i++)
-			mtk_rx_clean(eth, &eth->rx_ring[i]);
+			mtk_rx_clean(eth, &eth->rx_ring[i], false);
 	}
 
 	kfree(eth->scratch_head);
@@ -4676,7 +4700,7 @@ static int mtk_sgmii_init(struct mtk_eth *eth)
 
 static int mtk_probe(struct platform_device *pdev)
 {
-	struct resource *res = NULL;
+	struct resource *res = NULL, *res_sram;
 	struct device_node *mac_np;
 	struct mtk_eth *eth;
 	int err, i;
@@ -4696,6 +4720,16 @@ static int mtk_probe(struct platform_device *pdev)
 	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628))
 		eth->ip_align = NET_IP_ALIGN;
 
+	if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
+		if (mtk_is_netsys_v3_or_greater(eth)) {
+			eth->sram_base = devm_platform_ioremap_resource(pdev, 1);
+			if (IS_ERR(eth->sram_base))
+				return PTR_ERR(eth->sram_base);
+		} else {
+			eth->sram_base = eth->base + MTK_ETH_SRAM_OFFSET;
+		}
+	}
+
 	spin_lock_init(&eth->page_lock);
 	spin_lock_init(&eth->tx_irq_lock);
 	spin_lock_init(&eth->rx_irq_lock);
@@ -4759,6 +4793,18 @@ static int mtk_probe(struct platform_device *pdev)
 			err = -EINVAL;
 			goto err_destroy_sgmii;
 		}
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SRAM)) {
+			if (mtk_is_netsys_v3_or_greater(eth)) {
+				res_sram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+				if (!res_sram) {
+					err = -EINVAL;
+					goto err_destroy_sgmii;
+				}
+				eth->phy_scratch_ring = res_sram->start;
+			} else {
+				eth->phy_scratch_ring = res->start + MTK_ETH_SRAM_OFFSET;
+			}
+		}
 	}
 
 	if (eth->soc->offload_version) {
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index cf9381a3d68b7..0e513f41ad477 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -139,6 +139,9 @@
 #define MTK_GDMA_MAC_ADRH(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
 				   0x54C : 0x50C + (_x * 0x1000); })
 
+/* Internal SRAM offset */
+#define MTK_ETH_SRAM_OFFSET	0x40000
+
 /* FE global misc reg*/
 #define MTK_FE_GLO_MISC         0x124
 
@@ -938,6 +941,7 @@ enum mkt_eth_capabilities {
 	MTK_RSTCTRL_PPE1_BIT,
 	MTK_RSTCTRL_PPE2_BIT,
 	MTK_U3_COPHY_V2_BIT,
+	MTK_SRAM_BIT,
 
 	/* MUX BITS*/
 	MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT,
@@ -973,6 +977,7 @@ enum mkt_eth_capabilities {
 #define MTK_RSTCTRL_PPE1	BIT_ULL(MTK_RSTCTRL_PPE1_BIT)
 #define MTK_RSTCTRL_PPE2	BIT_ULL(MTK_RSTCTRL_PPE2_BIT)
 #define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
+#define MTK_SRAM		BIT_ULL(MTK_SRAM_BIT)
 
 #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
 	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
@@ -1048,14 +1053,14 @@ enum mkt_eth_capabilities {
 #define MT7981_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | MTK_GMAC2_GEPHY | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_MUX_U3_GMAC2_TO_QPHY | MTK_U3_COPHY_V2 | \
-		      MTK_RSTCTRL_PPE1)
+		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
 
 #define MT7986_CAPS  (MTK_GMAC1_SGMII | MTK_GMAC2_SGMII | \
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
-		      MTK_RSTCTRL_PPE1)
+		      MTK_RSTCTRL_PPE1 | MTK_SRAM)
 
 #define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1 | \
-		      MTK_RSTCTRL_PPE2)
+		      MTK_RSTCTRL_PPE2 | MTK_SRAM)
 
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
@@ -1215,6 +1220,7 @@ struct mtk_eth {
 	struct device			*dev;
 	struct device			*dma_dev;
 	void __iomem			*base;
+	void __iomem			*sram_base;
 	spinlock_t			page_lock;
 	spinlock_t			tx_irq_lock;
 	spinlock_t			rx_irq_lock;
-- 
2.41.0
