Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29EC758743
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 23:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjGRVdN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 17:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjGRVdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 17:33:05 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED771BC0;
        Tue, 18 Jul 2023 14:32:59 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qLsJN-0001NQ-05;
        Tue, 18 Jul 2023 21:32:49 +0000
Date:   Tue, 18 Jul 2023 22:32:40 +0100
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
Subject: [PATCH net-next v3 9/9] net: ethernet: mtk_eth_soc: add basic
 support for MT7988 SoC
Message-ID: <458355cd930c42d44dd44950f3bf628ad251cea2.1689714291.git.daniel@makrotopia.org>
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

Introduce support for ethernet chip available in MT7988 SoC to
mtk_eth_soc driver. As a first step support only the first GMAC which
is hard-wired to the internal DSA switch having 4 built-in gigabit
Ethernet PHYs.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_path.c |  14 +-
 drivers/net/ethernet/mediatek/mtk_eth_soc.c  | 201 +++++++++++++++++--
 drivers/net/ethernet/mediatek/mtk_eth_soc.h  |  86 +++++++-
 3 files changed, 273 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 34ac492e047cb..7c27a19c4d8f4 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_path.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_path.c
@@ -43,7 +43,7 @@ static const char *mtk_eth_path_name(u64 path)
 static int set_mux_gdm1_to_gmac1_esw(struct mtk_eth *eth, u64 path)
 {
 	bool updated = true;
-	u32 val, mask, set;
+	u32 mask, set, reg;
 
 	switch (path) {
 	case MTK_ETH_PATH_GMAC1_SGMII:
@@ -59,11 +59,13 @@ static int set_mux_gdm1_to_gmac1_esw(struct mtk_eth *eth, u64 path)
 		break;
 	}
 
-	if (updated) {
-		val = mtk_r32(eth, MTK_MAC_MISC);
-		val = (val & mask) | set;
-		mtk_w32(eth, val, MTK_MAC_MISC);
-	}
+	if (mtk_is_netsys_v3_or_greater(eth))
+		reg = MTK_MAC_MISC_V3;
+	else
+		reg = MTK_MAC_MISC;
+
+	if (updated)
+		mtk_m32(eth, mask, set, reg);
 
 	dev_dbg(eth->dev, "path %s in %s updated = %d\n",
 		mtk_eth_path_name(path), __func__, updated);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index dd5a08c7ed41a..242c566935968 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -152,6 +152,54 @@ static const struct mtk_reg_map mt7986_reg_map = {
 	.pse_oq_sta		= 0x01a0,
 };
 
+static const struct mtk_reg_map mt7988_reg_map = {
+	.tx_irq_mask		= 0x461c,
+	.tx_irq_status		= 0x4618,
+	.pdma = {
+		.rx_ptr		= 0x6900,
+		.rx_cnt_cfg	= 0x6904,
+		.pcrx_ptr	= 0x6908,
+		.glo_cfg	= 0x6a04,
+		.rst_idx	= 0x6a08,
+		.delay_irq	= 0x6a0c,
+		.irq_status	= 0x6a20,
+		.irq_mask	= 0x6a28,
+		.adma_rx_dbg0	= 0x6a38,
+		.int_grp	= 0x6a50,
+	},
+	.qdma = {
+		.qtx_cfg	= 0x4400,
+		.qtx_sch	= 0x4404,
+		.rx_ptr		= 0x4500,
+		.rx_cnt_cfg	= 0x4504,
+		.qcrx_ptr	= 0x4508,
+		.glo_cfg	= 0x4604,
+		.rst_idx	= 0x4608,
+		.delay_irq	= 0x460c,
+		.fc_th		= 0x4610,
+		.int_grp	= 0x4620,
+		.hred		= 0x4644,
+		.ctx_ptr	= 0x4700,
+		.dtx_ptr	= 0x4704,
+		.crx_ptr	= 0x4710,
+		.drx_ptr	= 0x4714,
+		.fq_head	= 0x4720,
+		.fq_tail	= 0x4724,
+		.fq_count	= 0x4728,
+		.fq_blen	= 0x472c,
+		.tx_sch_rate	= 0x4798,
+	},
+	.gdm1_cnt		= 0x1c00,
+	.gdma_to_ppe		= 0x3333,
+	.ppe_base		= 0x2000,
+	.wdma_base = {
+		[0]		= 0x4800,
+		[1]		= 0x4c00,
+	},
+	.pse_iq_sta		= 0x0180,
+	.pse_oq_sta		= 0x01a0,
+};
+
 /* strings used by ethtool */
 static const struct mtk_ethtool_stats {
 	char str[ETH_GSTRING_LEN];
@@ -179,10 +227,54 @@ static const struct mtk_ethtool_stats {
 };
 
 static const char * const mtk_clks_source_name[] = {
-	"ethif", "sgmiitop", "esw", "gp0", "gp1", "gp2", "fe", "trgpll",
-	"sgmii_tx250m", "sgmii_rx250m", "sgmii_cdr_ref", "sgmii_cdr_fb",
-	"sgmii2_tx250m", "sgmii2_rx250m", "sgmii2_cdr_ref", "sgmii2_cdr_fb",
-	"sgmii_ck", "eth2pll", "wocpu0", "wocpu1", "netsys0", "netsys1"
+	"ethif",
+	"sgmiitop",
+	"esw",
+	"gp0",
+	"gp1",
+	"gp2",
+	"gp3",
+	"xgp1",
+	"xgp2",
+	"xgp3",
+	"crypto",
+	"fe",
+	"trgpll",
+	"sgmii_tx250m",
+	"sgmii_rx250m",
+	"sgmii_cdr_ref",
+	"sgmii_cdr_fb",
+	"sgmii2_tx250m",
+	"sgmii2_rx250m",
+	"sgmii2_cdr_ref",
+	"sgmii2_cdr_fb",
+	"sgmii_ck",
+	"eth2pll",
+	"wocpu0",
+	"wocpu1",
+	"netsys0",
+	"netsys1",
+	"ethwarp_wocpu2",
+	"ethwarp_wocpu1",
+	"ethwarp_wocpu0",
+	"top_usxgmii0_sel",
+	"top_usxgmii1_sel",
+	"top_sgm0_sel",
+	"top_sgm1_sel",
+	"top_xfi_phy0_xtal_sel",
+	"top_xfi_phy1_xtal_sel",
+	"top_eth_gmii_sel",
+	"top_eth_refck_50m_sel",
+	"top_eth_sys_200m_sel",
+	"top_eth_sys_sel",
+	"top_eth_xgmii_sel",
+	"top_eth_mii_sel",
+	"top_netsys_sel",
+	"top_netsys_500m_sel",
+	"top_netsys_pao_2x_sel",
+	"top_netsys_sync_250m_sel",
+	"top_netsys_ppefb_250m_sel",
+	"top_netsys_warp_sel",
 };
 
 void mtk_w32(struct mtk_eth *eth, u32 val, unsigned reg)
@@ -195,7 +287,7 @@ u32 mtk_r32(struct mtk_eth *eth, unsigned reg)
 	return __raw_readl(eth->base + reg);
 }
 
-static u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned reg)
+u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned reg)
 {
 	u32 val;
 
@@ -425,6 +517,19 @@ static void mtk_gmac0_rgmii_adjust(struct mtk_eth *eth,
 	mtk_w32(eth, tck, TRGMII_TCK_CTRL);
 }
 
+static void mtk_setup_bridge_switch(struct mtk_eth *eth)
+{
+	/* Force Port1 XGMAC Link Up */
+	mtk_m32(eth, 0, MTK_XGMAC_FORCE_LINK(MTK_GMAC1_ID),
+		MTK_XGMAC_STS(MTK_GMAC1_ID));
+
+	/* Adjust GSW bridge IPG to 11 */
+	mtk_m32(eth, GSWTX_IPG_MASK | GSWRX_IPG_MASK,
+		(GSW_IPG_11 << GSWTX_IPG_SHIFT) |
+		(GSW_IPG_11 << GSWRX_IPG_SHIFT),
+		MTK_GSW_CFG);
+}
+
 static struct phylink_pcs *mtk_mac_select_pcs(struct phylink_config *config,
 					      phy_interface_t interface)
 {
@@ -484,6 +589,8 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 					goto init_err;
 			}
 			break;
+		case PHY_INTERFACE_MODE_INTERNAL:
+			break;
 		default:
 			goto err_phy;
 		}
@@ -562,6 +669,15 @@ static void mtk_mac_config(struct phylink_config *config, unsigned int mode,
 		return;
 	}
 
+	/* Setup gmac */
+	if (mtk_is_netsys_v3_or_greater(eth) &&
+	    mac->interface == PHY_INTERFACE_MODE_INTERNAL) {
+		mtk_w32(mac->hw, MTK_GDMA_XGDM_SEL, MTK_GDMA_EG_CTRL(mac->id));
+		mtk_w32(mac->hw, MAC_MCR_FORCE_LINK_DOWN, MTK_MAC_MCR(mac->id));
+
+		mtk_setup_bridge_switch(eth);
+	}
+
 	return;
 
 err_phy:
@@ -807,11 +923,15 @@ static int mtk_mdio_init(struct mtk_eth *eth)
 	}
 	divider = min_t(unsigned int, DIV_ROUND_UP(MDC_MAX_FREQ, max_clk), 63);
 
+	/* Configure MDC Turbo Mode */
+	if (mtk_is_netsys_v3_or_greater(eth))
+		mtk_m32(eth, 0, MISC_MDC_TURBO, MTK_MAC_MISC_V3);
+
 	/* Configure MDC Divider */
-	val = mtk_r32(eth, MTK_PPSC);
-	val &= ~PPSC_MDC_CFG;
-	val |= FIELD_PREP(PPSC_MDC_CFG, divider) | PPSC_MDC_TURBO;
-	mtk_w32(eth, val, MTK_PPSC);
+	val = FIELD_PREP(PPSC_MDC_CFG, divider);
+	if (!mtk_is_netsys_v3_or_greater(eth))
+		val |= PPSC_MDC_TURBO;
+	mtk_m32(eth, PPSC_MDC_CFG, val, MTK_PPSC);
 
 	dev_dbg(eth->dev, "MDC is running on %d Hz\n", MDC_MAX_FREQ / divider);
 
@@ -1272,10 +1392,19 @@ static void mtk_tx_set_dma_desc_v2(struct net_device *dev, void *txd,
 		data |= TX_DMA_LS0;
 	WRITE_ONCE(desc->txd3, data);
 
-	if (mac->id == MTK_GMAC3_ID)
-		data = PSE_GDM3_PORT;
-	else
-		data = (mac->id + 1) << TX_DMA_FPORT_SHIFT_V2; /* forward port */
+	 /* set forward port */
+	switch (mac->id) {
+	case MTK_GMAC1_ID:
+		data = PSE_GDM1_PORT << TX_DMA_FPORT_SHIFT_V2;
+		break;
+	case MTK_GMAC2_ID:
+		data = PSE_GDM2_PORT << TX_DMA_FPORT_SHIFT_V2;
+		break;
+	case MTK_GMAC3_ID:
+		data = PSE_GDM3_PORT << TX_DMA_FPORT_SHIFT_V2;
+		break;
+	}
+
 	data |= TX_DMA_SWC_V2 | QID_BITS_V2(info->qid);
 	WRITE_ONCE(desc->txd4, data);
 
@@ -4457,6 +4586,17 @@ static int mtk_add_mac(struct mtk_eth *eth, struct device_node *np)
 			  mac->phylink_config.supported_interfaces);
 	}
 
+	if (mtk_is_netsys_v3_or_greater(mac->hw) &&
+	    MTK_HAS_CAPS(mac->hw->soc->caps, MTK_ESW_BIT) &&
+	    id == MTK_GMAC1_ID) {
+		mac->phylink_config.mac_capabilities = MAC_ASYM_PAUSE |
+						       MAC_SYM_PAUSE |
+						       MAC_10000FD;
+		phy_interface_zero(mac->phylink_config.supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  mac->phylink_config.supported_interfaces);
+	}
+
 	phylink = phylink_create(&mac->phylink_config,
 				 of_fwnode_handle(mac->of_node),
 				 phy_mode, &mtk_phylink_ops);
@@ -4982,6 +5122,24 @@ static const struct mtk_soc_data mt7986_data = {
 	},
 };
 
+static const struct mtk_soc_data mt7988_data = {
+	.reg_map = &mt7988_reg_map,
+	.ana_rgc3 = 0x128,
+	.caps = MT7988_CAPS,
+	.hw_features = MTK_HW_FEATURES,
+	.required_clks = MT7988_CLKS_BITMAP,
+	.required_pctl = false,
+	.version = 3,
+	.txrx = {
+		.txd_size = sizeof(struct mtk_tx_dma_v2),
+		.rxd_size = sizeof(struct mtk_rx_dma_v2),
+		.rx_irq_done_mask = MTK_RX_DONE_INT_V2,
+		.rx_dma_l4_valid = RX_DMA_L4_VALID_V2,
+		.dma_max_len = MTK_TX_DMA_BUF_LEN_V2,
+		.dma_len_offset = 8,
+	},
+};
+
 static const struct mtk_soc_data rt5350_data = {
 	.reg_map = &mt7628_reg_map,
 	.caps = MT7628_CAPS,
@@ -5000,14 +5158,15 @@ static const struct mtk_soc_data rt5350_data = {
 };
 
 const struct of_device_id of_mtk_match[] = {
-	{ .compatible = "mediatek,mt2701-eth", .data = &mt2701_data},
-	{ .compatible = "mediatek,mt7621-eth", .data = &mt7621_data},
-	{ .compatible = "mediatek,mt7622-eth", .data = &mt7622_data},
-	{ .compatible = "mediatek,mt7623-eth", .data = &mt7623_data},
-	{ .compatible = "mediatek,mt7629-eth", .data = &mt7629_data},
-	{ .compatible = "mediatek,mt7981-eth", .data = &mt7981_data},
-	{ .compatible = "mediatek,mt7986-eth", .data = &mt7986_data},
-	{ .compatible = "ralink,rt5350-eth", .data = &rt5350_data},
+	{ .compatible = "mediatek,mt2701-eth", .data = &mt2701_data },
+	{ .compatible = "mediatek,mt7621-eth", .data = &mt7621_data },
+	{ .compatible = "mediatek,mt7622-eth", .data = &mt7622_data },
+	{ .compatible = "mediatek,mt7623-eth", .data = &mt7623_data },
+	{ .compatible = "mediatek,mt7629-eth", .data = &mt7629_data },
+	{ .compatible = "mediatek,mt7981-eth", .data = &mt7981_data },
+	{ .compatible = "mediatek,mt7986-eth", .data = &mt7986_data },
+	{ .compatible = "mediatek,mt7988-eth", .data = &mt7988_data },
+	{ .compatible = "ralink,rt5350-eth", .data = &rt5350_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, of_mtk_match);
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 38c212b50f776..41c84030017eb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -117,7 +117,8 @@
 #define MTK_CDMP_EG_CTRL	0x404
 
 /* GDM Exgress Control Register */
-#define MTK_GDMA_FWD_CFG(x)	(0x500 + (x * 0x1000))
+#define MTK_GDMA_FWD_CFG(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x540 : 0x500 + (_x * 0x1000); })
 #define MTK_GDMA_SPECIAL_TAG	BIT(24)
 #define MTK_GDMA_ICS_EN		BIT(22)
 #define MTK_GDMA_TCS_EN		BIT(21)
@@ -126,6 +127,11 @@
 #define MTK_GDMA_TO_PDMA	0x0
 #define MTK_GDMA_DROP_ALL       0x7777
 
+/* GDM Egress Control Register */
+#define MTK_GDMA_EG_CTRL(x)	({ typeof(x) _x = (x); (_x == MTK_GMAC3_ID) ?	\
+				   0x544 : 0x504 + (_x * 0x1000); })
+#define MTK_GDMA_XGDM_SEL	BIT(31)
+
 /* Unicast Filter MAC Address Register - Low */
 #define MTK_GDMA_MAC_ADRL(x)	(0x508 + (x * 0x1000))
 
@@ -389,7 +395,26 @@
 #define PHY_IAC_TIMEOUT		HZ
 
 #define MTK_MAC_MISC		0x1000c
+#define MTK_MAC_MISC_V3		0x10010
 #define MTK_MUX_TO_ESW		BIT(0)
+#define MISC_MDC_TURBO		BIT(4)
+
+/* XMAC status registers */
+#define MTK_XGMAC_STS(x)	(((x) == MTK_GMAC3_ID) ? 0x1001C : 0x1000C)
+#define MTK_XGMAC_FORCE_LINK(x)	(((x) == MTK_GMAC2_ID) ? BIT(31) : BIT(15))
+#define MTK_USXGMII_PCS_LINK	BIT(8)
+#define MTK_XGMAC_RX_FC		BIT(5)
+#define MTK_XGMAC_TX_FC		BIT(4)
+#define MTK_USXGMII_PCS_MODE	GENMASK(3, 1)
+#define MTK_XGMAC_LINK_STS	BIT(0)
+
+/* GSW bridge registers */
+#define MTK_GSW_CFG		(0x10080)
+#define GSWTX_IPG_MASK		GENMASK(19, 16)
+#define GSWTX_IPG_SHIFT		16
+#define GSWRX_IPG_MASK		GENMASK(3, 0)
+#define GSWRX_IPG_SHIFT		0
+#define GSW_IPG_11		11
 
 /* Mac control registers */
 #define MTK_MAC_MCR(x)		(0x10100 + (x * 0x100))
@@ -647,6 +672,11 @@ enum mtk_clks_map {
 	MTK_CLK_GP0,
 	MTK_CLK_GP1,
 	MTK_CLK_GP2,
+	MTK_CLK_GP3,
+	MTK_CLK_XGP1,
+	MTK_CLK_XGP2,
+	MTK_CLK_XGP3,
+	MTK_CLK_CRYPTO,
 	MTK_CLK_FE,
 	MTK_CLK_TRGPLL,
 	MTK_CLK_SGMII_TX_250M,
@@ -663,6 +693,27 @@ enum mtk_clks_map {
 	MTK_CLK_WOCPU1,
 	MTK_CLK_NETSYS0,
 	MTK_CLK_NETSYS1,
+	MTK_CLK_ETHWARP_WOCPU2,
+	MTK_CLK_ETHWARP_WOCPU1,
+	MTK_CLK_ETHWARP_WOCPU0,
+	MTK_CLK_TOP_USXGMII_SBUS_0_SEL,
+	MTK_CLK_TOP_USXGMII_SBUS_1_SEL,
+	MTK_CLK_TOP_SGM_0_SEL,
+	MTK_CLK_TOP_SGM_1_SEL,
+	MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL,
+	MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL,
+	MTK_CLK_TOP_ETH_GMII_SEL,
+	MTK_CLK_TOP_ETH_REFCK_50M_SEL,
+	MTK_CLK_TOP_ETH_SYS_200M_SEL,
+	MTK_CLK_TOP_ETH_SYS_SEL,
+	MTK_CLK_TOP_ETH_XGMII_SEL,
+	MTK_CLK_TOP_ETH_MII_SEL,
+	MTK_CLK_TOP_NETSYS_SEL,
+	MTK_CLK_TOP_NETSYS_500M_SEL,
+	MTK_CLK_TOP_NETSYS_PAO_2X_SEL,
+	MTK_CLK_TOP_NETSYS_SYNC_250M_SEL,
+	MTK_CLK_TOP_NETSYS_PPEFB_250M_SEL,
+	MTK_CLK_TOP_NETSYS_WARP_SEL,
 	MTK_CLK_MAX
 };
 
@@ -716,6 +767,36 @@ enum mtk_clks_map {
 				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
 				 BIT_ULL(MTK_CLK_SGMII2_CDR_REF) | \
 				 BIT_ULL(MTK_CLK_SGMII2_CDR_FB))
+#define MT7988_CLKS_BITMAP	(BIT_ULL(MTK_CLK_FE) | BIT_ULL(MTK_CLK_ESW) | \
+				 BIT_ULL(MTK_CLK_GP1) | BIT_ULL(MTK_CLK_GP2) | \
+				 BIT_ULL(MTK_CLK_GP3) | BIT_ULL(MTK_CLK_XGP1) | \
+				 BIT_ULL(MTK_CLK_XGP2) | BIT_ULL(MTK_CLK_XGP3) | \
+				 BIT_ULL(MTK_CLK_CRYPTO) | \
+				 BIT_ULL(MTK_CLK_SGMII_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII_RX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_TX_250M) | \
+				 BIT_ULL(MTK_CLK_SGMII2_RX_250M) | \
+				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU2) | \
+				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU1) | \
+				 BIT_ULL(MTK_CLK_ETHWARP_WOCPU0) | \
+				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_0_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_USXGMII_SBUS_1_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_SGM_0_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_SGM_1_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_0_XTAL_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_XFI_PHY_1_XTAL_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_GMII_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_REFCK_50M_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_SYS_200M_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_SYS_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_XGMII_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_ETH_MII_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_500M_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_PAO_2X_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_SYNC_250M_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_PPEFB_250M_SEL) | \
+				 BIT_ULL(MTK_CLK_TOP_NETSYS_WARP_SEL))
 
 enum mtk_dev_state {
 	MTK_HW_INIT,
@@ -964,6 +1045,8 @@ enum mkt_eth_capabilities {
 		      MTK_MUX_GMAC12_TO_GEPHY_SGMII | MTK_QDMA | \
 		      MTK_RSTCTRL_PPE1)
 
+#define MT7988_CAPS  (MTK_GDM1_ESW | MTK_QDMA | MTK_RSTCTRL_PPE1)
+
 struct mtk_tx_dma_desc_info {
 	dma_addr_t	addr;
 	u32		size;
@@ -1308,6 +1391,7 @@ void mtk_stats_update_mac(struct mtk_mac *mac);
 
 void mtk_w32(struct mtk_eth *eth, u32 val, unsigned reg);
 u32 mtk_r32(struct mtk_eth *eth, unsigned reg);
+u32 mtk_m32(struct mtk_eth *eth, u32 mask, u32 set, unsigned reg);
 
 int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id);
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id);
-- 
2.41.0
