Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A029E75E530
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 00:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjGWWAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 18:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjGWV74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 17:59:56 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DF10C4;
        Sun, 23 Jul 2023 14:59:39 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1qNh6u-0005Sy-0H;
        Sun, 23 Jul 2023 21:59:28 +0000
Date:   Sun, 23 Jul 2023 22:59:19 +0100
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
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
        Greg Ungerer <gerg@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v5 7/9] net: ethernet: mtk_eth_soc: convert caps in
 mtk_soc_data struct to u64
Message-ID: <09df4e8ec56bd3a91a3db6ac03aac49408f764dc.1690148927.git.daniel@makrotopia.org>
References: <cover.1690148927.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1690148927.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce support for MT7988 SoC.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_eth_path.c | 22 ++++----
 drivers/net/ethernet/mediatek/mtk_eth_soc.h  | 56 ++++++++++----------
 2 files changed, 39 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 317e447f49916..34ac492e047cb 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_path.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_path.c
@@ -15,10 +15,10 @@
 struct mtk_eth_muxc {
 	const char	*name;
 	int		cap_bit;
-	int		(*set_path)(struct mtk_eth *eth, int path);
+	int		(*set_path)(struct mtk_eth *eth, u64 path);
 };
 
-static const char *mtk_eth_path_name(int path)
+static const char *mtk_eth_path_name(u64 path)
 {
 	switch (path) {
 	case MTK_ETH_PATH_GMAC1_RGMII:
@@ -40,7 +40,7 @@ static const char *mtk_eth_path_name(int path)
 	}
 }
 
-static int set_mux_gdm1_to_gmac1_esw(struct mtk_eth *eth, int path)
+static int set_mux_gdm1_to_gmac1_esw(struct mtk_eth *eth, u64 path)
 {
 	bool updated = true;
 	u32 val, mask, set;
@@ -71,7 +71,7 @@ static int set_mux_gdm1_to_gmac1_esw(struct mtk_eth *eth, int path)
 	return 0;
 }
 
-static int set_mux_gmac2_gmac0_to_gephy(struct mtk_eth *eth, int path)
+static int set_mux_gmac2_gmac0_to_gephy(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
 	bool updated = true;
@@ -94,7 +94,7 @@ static int set_mux_gmac2_gmac0_to_gephy(struct mtk_eth *eth, int path)
 	return 0;
 }
 
-static int set_mux_u3_gmac2_to_qphy(struct mtk_eth *eth, int path)
+static int set_mux_u3_gmac2_to_qphy(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0, mask = 0, reg = 0;
 	bool updated = true;
@@ -125,7 +125,7 @@ static int set_mux_u3_gmac2_to_qphy(struct mtk_eth *eth, int path)
 	return 0;
 }
 
-static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, int path)
+static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
 	bool updated = true;
@@ -163,7 +163,7 @@ static int set_mux_gmac1_gmac2_to_sgmii_rgmii(struct mtk_eth *eth, int path)
 	return 0;
 }
 
-static int set_mux_gmac12_to_gephy_sgmii(struct mtk_eth *eth, int path)
+static int set_mux_gmac12_to_gephy_sgmii(struct mtk_eth *eth, u64 path)
 {
 	unsigned int val = 0;
 	bool updated = true;
@@ -218,7 +218,7 @@ static const struct mtk_eth_muxc mtk_eth_muxc[] = {
 	},
 };
 
-static int mtk_eth_mux_setup(struct mtk_eth *eth, int path)
+static int mtk_eth_mux_setup(struct mtk_eth *eth, u64 path)
 {
 	int i, err = 0;
 
@@ -249,7 +249,7 @@ static int mtk_eth_mux_setup(struct mtk_eth *eth, int path)
 
 int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id)
 {
-	int path;
+	u64 path;
 
 	path = (mac_id == 0) ?  MTK_ETH_PATH_GMAC1_SGMII :
 				MTK_ETH_PATH_GMAC2_SGMII;
@@ -260,7 +260,7 @@ int mtk_gmac_sgmii_path_setup(struct mtk_eth *eth, int mac_id)
 
 int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id)
 {
-	int path = 0;
+	u64 path = 0;
 
 	if (mac_id == 1)
 		path = MTK_ETH_PATH_GMAC2_GEPHY;
@@ -274,7 +274,7 @@ int mtk_gmac_gephy_path_setup(struct mtk_eth *eth, int mac_id)
 
 int mtk_gmac_rgmii_path_setup(struct mtk_eth *eth, int mac_id)
 {
-	int path;
+	u64 path;
 
 	path = (mac_id == 0) ?  MTK_ETH_PATH_GMAC1_RGMII :
 				MTK_ETH_PATH_GMAC2_RGMII;
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index 3959bb39995fc..9fe6e44f5e327 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -866,41 +866,41 @@ enum mkt_eth_capabilities {
 };
 
 /* Supported hardware group on SoCs */
-#define MTK_RGMII		BIT(MTK_RGMII_BIT)
-#define MTK_TRGMII		BIT(MTK_TRGMII_BIT)
-#define MTK_SGMII		BIT(MTK_SGMII_BIT)
-#define MTK_ESW			BIT(MTK_ESW_BIT)
-#define MTK_GEPHY		BIT(MTK_GEPHY_BIT)
-#define MTK_MUX			BIT(MTK_MUX_BIT)
-#define MTK_INFRA		BIT(MTK_INFRA_BIT)
-#define MTK_SHARED_SGMII	BIT(MTK_SHARED_SGMII_BIT)
-#define MTK_HWLRO		BIT(MTK_HWLRO_BIT)
-#define MTK_SHARED_INT		BIT(MTK_SHARED_INT_BIT)
-#define MTK_TRGMII_MT7621_CLK	BIT(MTK_TRGMII_MT7621_CLK_BIT)
-#define MTK_QDMA		BIT(MTK_QDMA_BIT)
-#define MTK_SOC_MT7628		BIT(MTK_SOC_MT7628_BIT)
-#define MTK_RSTCTRL_PPE1	BIT(MTK_RSTCTRL_PPE1_BIT)
-#define MTK_U3_COPHY_V2		BIT(MTK_U3_COPHY_V2_BIT)
+#define MTK_RGMII		BIT_ULL(MTK_RGMII_BIT)
+#define MTK_TRGMII		BIT_ULL(MTK_TRGMII_BIT)
+#define MTK_SGMII		BIT_ULL(MTK_SGMII_BIT)
+#define MTK_ESW			BIT_ULL(MTK_ESW_BIT)
+#define MTK_GEPHY		BIT_ULL(MTK_GEPHY_BIT)
+#define MTK_MUX			BIT_ULL(MTK_MUX_BIT)
+#define MTK_INFRA		BIT_ULL(MTK_INFRA_BIT)
+#define MTK_SHARED_SGMII	BIT_ULL(MTK_SHARED_SGMII_BIT)
+#define MTK_HWLRO		BIT_ULL(MTK_HWLRO_BIT)
+#define MTK_SHARED_INT		BIT_ULL(MTK_SHARED_INT_BIT)
+#define MTK_TRGMII_MT7621_CLK	BIT_ULL(MTK_TRGMII_MT7621_CLK_BIT)
+#define MTK_QDMA		BIT_ULL(MTK_QDMA_BIT)
+#define MTK_SOC_MT7628		BIT_ULL(MTK_SOC_MT7628_BIT)
+#define MTK_RSTCTRL_PPE1	BIT_ULL(MTK_RSTCTRL_PPE1_BIT)
+#define MTK_U3_COPHY_V2		BIT_ULL(MTK_U3_COPHY_V2_BIT)
 
 #define MTK_ETH_MUX_GDM1_TO_GMAC1_ESW		\
-	BIT(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
+	BIT_ULL(MTK_ETH_MUX_GDM1_TO_GMAC1_ESW_BIT)
 #define MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY	\
-	BIT(MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT)
+	BIT_ULL(MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY_BIT)
 #define MTK_ETH_MUX_U3_GMAC2_TO_QPHY		\
-	BIT(MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT)
+	BIT_ULL(MTK_ETH_MUX_U3_GMAC2_TO_QPHY_BIT)
 #define MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII	\
-	BIT(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT)
+	BIT_ULL(MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII_BIT)
 #define MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII	\
-	BIT(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT)
+	BIT_ULL(MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII_BIT)
 
 /* Supported path present on SoCs */
-#define MTK_ETH_PATH_GMAC1_RGMII	BIT(MTK_ETH_PATH_GMAC1_RGMII_BIT)
-#define MTK_ETH_PATH_GMAC1_TRGMII	BIT(MTK_ETH_PATH_GMAC1_TRGMII_BIT)
-#define MTK_ETH_PATH_GMAC1_SGMII	BIT(MTK_ETH_PATH_GMAC1_SGMII_BIT)
-#define MTK_ETH_PATH_GMAC2_RGMII	BIT(MTK_ETH_PATH_GMAC2_RGMII_BIT)
-#define MTK_ETH_PATH_GMAC2_SGMII	BIT(MTK_ETH_PATH_GMAC2_SGMII_BIT)
-#define MTK_ETH_PATH_GMAC2_GEPHY	BIT(MTK_ETH_PATH_GMAC2_GEPHY_BIT)
-#define MTK_ETH_PATH_GDM1_ESW		BIT(MTK_ETH_PATH_GDM1_ESW_BIT)
+#define MTK_ETH_PATH_GMAC1_RGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_RGMII_BIT)
+#define MTK_ETH_PATH_GMAC1_TRGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_TRGMII_BIT)
+#define MTK_ETH_PATH_GMAC1_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC1_SGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_RGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_RGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_SGMII	BIT_ULL(MTK_ETH_PATH_GMAC2_SGMII_BIT)
+#define MTK_ETH_PATH_GMAC2_GEPHY	BIT_ULL(MTK_ETH_PATH_GMAC2_GEPHY_BIT)
+#define MTK_ETH_PATH_GDM1_ESW		BIT_ULL(MTK_ETH_PATH_GDM1_ESW_BIT)
 
 #define MTK_GMAC1_RGMII		(MTK_ETH_PATH_GMAC1_RGMII | MTK_RGMII)
 #define MTK_GMAC1_TRGMII	(MTK_ETH_PATH_GMAC1_TRGMII | MTK_TRGMII)
@@ -1045,7 +1045,7 @@ struct mtk_reg_map {
 struct mtk_soc_data {
 	const struct mtk_reg_map *reg_map;
 	u32             ana_rgc3;
-	u32		caps;
+	u64		caps;
 	u32		required_clks;
 	bool		required_pctl;
 	u8		offload_version;
-- 
2.41.0
