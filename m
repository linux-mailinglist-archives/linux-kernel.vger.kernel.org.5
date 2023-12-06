Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2FE80649D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235227AbjLFBof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235348AbjLFBoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:44:30 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA58CD47;
        Tue,  5 Dec 2023 17:44:34 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1rAgxY-0002gh-22;
        Wed, 06 Dec 2023 01:44:21 +0000
Date:   Wed, 6 Dec 2023 01:44:17 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Couzens <lynxis@fe80.eu>,
        Daniel Golle <daniel@makrotopia.org>,
        Qingfang Deng <dqfext@gmail.com>,
        SkyLake Huang <SkyLake.Huang@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org
Subject: [RFC PATCH v2 3/8] net: pcs: pcs-mtk-lynxi: add platform driver for
 MT7988
Message-ID: <68bb81ac6bf99393c8de256f42e5715626590af8.1701826319.git.daniel@makrotopia.org>
References: <cover.1701826319.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1701826319.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a proper platform MFD driver for the LynxI (H)SGMII PCS which
is going to initially be used for the MT7988 SoC.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/pcs/pcs-mtk-lynxi.c   | 170 ++++++++++++++++++++++++++++--
 include/linux/pcs/pcs-mtk-lynxi.h |   1 +
 2 files changed, 160 insertions(+), 11 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 8501dd365279b..558d6351399b5 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2018-2019 MediaTek Inc.
-/* A library for MediaTek SGMII circuit
+/* A library and platform driver for the MediaTek LynxI SGMII circuit
  *
  * Author: Sean Wang <sean.wang@mediatek.com>
  * Author: Alexander Couzens <lynxis@fe80.eu>
@@ -8,11 +8,16 @@
  *
  */
 
+#include <linux/clk.h>
 #include <linux/mdio.h>
+#include <linux/mfd/syscon.h>
 #include <linux/of.h>
+#include <linux/of_platform.h>
 #include <linux/pcs/pcs-mtk-lynxi.h>
 #include <linux/phylink.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/reset.h>
 
 /* SGMII subsystem config registers */
 /* BMCR (low 16) BMSR (high 16) */
@@ -65,6 +70,8 @@
 #define SGMII_PN_SWAP_MASK		GENMASK(1, 0)
 #define SGMII_PN_SWAP_TX_RX		(BIT(0) | BIT(1))
 
+#define MTK_NETSYS_V3_AMA_RGC3		0x128
+
 /* struct mtk_pcs_lynxi -  This structure holds each sgmii regmap andassociated
  *                         data
  * @regmap:                The register map pointing at the range used to setup
@@ -81,6 +88,10 @@ struct mtk_pcs_lynxi {
 	phy_interface_t		interface;
 	struct			phylink_pcs pcs;
 	u32			flags;
+	struct reset_control	*rstc;
+	struct clk		*sgmii_sel;
+	struct clk		*sgmii_rx;
+	struct clk		*sgmii_tx;
 };
 
 static struct mtk_pcs_lynxi *pcs_to_mtk_pcs_lynxi(struct phylink_pcs *pcs)
@@ -102,6 +113,17 @@ static void mtk_pcs_lynxi_get_state(struct phylink_pcs *pcs,
 					 FIELD_GET(SGMII_LPA, adv));
 }
 
+static void mtk_sgmii_reset(struct mtk_pcs_lynxi *mpcs)
+{
+	if (!mpcs->rstc)
+		return;
+
+	reset_control_assert(mpcs->rstc);
+	usleep_range(100, 500);
+	reset_control_deassert(mpcs->rstc);
+	mdelay(10);
+}
+
 static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				phy_interface_t interface,
 				const unsigned long *advertising,
@@ -147,6 +169,7 @@ static int mtk_pcs_lynxi_config(struct phylink_pcs *pcs, unsigned int neg_mode,
 				SGMII_PHYA_PWD);
 
 		/* Reset SGMII PCS state */
+		mtk_sgmii_reset(mpcs);
 		regmap_set_bits(mpcs->regmap, SGMSYS_RESERVED_0,
 				SGMII_SW_RESET);
 
@@ -233,10 +256,29 @@ static void mtk_pcs_lynxi_link_up(struct phylink_pcs *pcs,
 	}
 }
 
+static int mtk_pcs_lynxi_enable(struct phylink_pcs *pcs)
+{
+	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
+
+	if (mpcs->sgmii_tx && mpcs->sgmii_rx) {
+		clk_prepare_enable(mpcs->sgmii_rx);
+		clk_prepare_enable(mpcs->sgmii_tx);
+	}
+
+	return 0;
+}
+
 static void mtk_pcs_lynxi_disable(struct phylink_pcs *pcs)
 {
 	struct mtk_pcs_lynxi *mpcs = pcs_to_mtk_pcs_lynxi(pcs);
 
+	regmap_set_bits(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, SGMII_PHYA_PWD);
+
+	if (mpcs->sgmii_tx && mpcs->sgmii_rx) {
+		clk_disable_unprepare(mpcs->sgmii_tx);
+		clk_disable_unprepare(mpcs->sgmii_rx);
+	}
+
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
 }
 
@@ -246,11 +288,12 @@ static const struct phylink_pcs_ops mtk_pcs_lynxi_ops = {
 	.pcs_an_restart = mtk_pcs_lynxi_restart_an,
 	.pcs_link_up = mtk_pcs_lynxi_link_up,
 	.pcs_disable = mtk_pcs_lynxi_disable,
+	.pcs_enable = mtk_pcs_lynxi_enable,
 };
 
-struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
-					 struct regmap *regmap, u32 ana_rgc3,
-					 u32 flags)
+static struct phylink_pcs *mtk_pcs_lynxi_init(struct device *dev, struct regmap *regmap,
+					      u32 ana_rgc3, u32 flags,
+					      struct mtk_pcs_lynxi *prealloc)
 {
 	struct mtk_pcs_lynxi *mpcs;
 	u32 id, ver;
@@ -258,29 +301,33 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 
 	ret = regmap_read(regmap, SGMSYS_PCS_DEVICE_ID, &id);
 	if (ret < 0)
-		return NULL;
+		return ERR_PTR(ret);
 
 	if (id != SGMII_LYNXI_DEV_ID) {
 		dev_err(dev, "unknown PCS device id %08x\n", id);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	ret = regmap_read(regmap, SGMSYS_PCS_SCRATCH, &ver);
 	if (ret < 0)
-		return NULL;
+		return ERR_PTR(ret);
 
 	ver = FIELD_GET(SGMII_DEV_VERSION, ver);
 	if (ver != 0x1) {
 		dev_err(dev, "unknown PCS device version %04x\n", ver);
-		return NULL;
+		return ERR_PTR(-ENODEV);
 	}
 
 	dev_dbg(dev, "MediaTek LynxI SGMII PCS (id 0x%08x, ver 0x%04x)\n", id,
 		ver);
 
-	mpcs = kzalloc(sizeof(*mpcs), GFP_KERNEL);
-	if (!mpcs)
-		return NULL;
+	if (prealloc) {
+		mpcs = prealloc;
+	} else {
+		mpcs = kzalloc(sizeof(*mpcs), GFP_KERNEL);
+		if (!mpcs)
+			return ERR_PTR(-ENOMEM);
+	};
 
 	mpcs->ana_rgc3 = ana_rgc3;
 	mpcs->regmap = regmap;
@@ -291,6 +338,13 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 	mpcs->interface = PHY_INTERFACE_MODE_NA;
 
 	return &mpcs->pcs;
+};
+
+struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
+					 struct regmap *regmap, u32 ana_rgc3,
+					 u32 flags)
+{
+	return mtk_pcs_lynxi_init(dev, regmap, ana_rgc3, flags, NULL);
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_create);
 
@@ -303,4 +357,98 @@ void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs)
 }
 EXPORT_SYMBOL(mtk_pcs_lynxi_destroy);
 
+static int mtk_pcs_lynxi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct mtk_pcs_lynxi *mpcs;
+	struct phylink_pcs *pcs;
+	struct regmap *regmap;
+	u32 flags = 0;
+
+	mpcs = devm_kzalloc(dev, sizeof(*mpcs), GFP_KERNEL);
+	if (!mpcs)
+		return -ENOMEM;
+
+	regmap = syscon_node_to_regmap(np->parent);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	if (of_property_read_bool(np->parent, "mediatek,pnswap"))
+		flags |= MTK_SGMII_FLAG_PN_SWAP;
+
+	mpcs->rstc = of_reset_control_get_shared(np->parent, NULL);
+	if (IS_ERR(mpcs->rstc))
+		return PTR_ERR(mpcs->rstc);
+
+	reset_control_deassert(mpcs->rstc);
+	mpcs->sgmii_sel = devm_clk_get_enabled(dev, "sgmii_sel");
+	if (IS_ERR(mpcs->sgmii_sel))
+		return PTR_ERR(mpcs->sgmii_sel);
+
+	mpcs->sgmii_rx = devm_clk_get(dev, "sgmii_rx");
+	if (IS_ERR(mpcs->sgmii_rx))
+		return PTR_ERR(mpcs->sgmii_rx);
+
+	mpcs->sgmii_tx = devm_clk_get(dev, "sgmii_tx");
+	if (IS_ERR(mpcs->sgmii_tx))
+		return PTR_ERR(mpcs->sgmii_tx);
+
+	pcs = mtk_pcs_lynxi_init(dev, regmap, (uintptr_t)of_device_get_match_data(dev),
+				 flags, mpcs);
+	if (IS_ERR(pcs))
+		return PTR_ERR(pcs);
+
+	regmap_set_bits(mpcs->regmap, SGMSYS_QPHY_PWR_STATE_CTRL, SGMII_PHYA_PWD);
+
+	platform_set_drvdata(pdev, mpcs);
+
+	return 0;
+}
+
+static const struct of_device_id mtk_pcs_lynxi_of_match[] = {
+	{ .compatible = "mediatek,mt7988-sgmii", .data = (void *)MTK_NETSYS_V3_AMA_RGC3 },
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(of, mtk_pcs_lynxi_of_match);
+
+struct phylink_pcs *mtk_pcs_lynxi_select_pcs(struct device_node *np, phy_interface_t mode)
+{
+	struct platform_device *pdev;
+	struct mtk_pcs_lynxi *mpcs;
+
+	if (!np)
+		return NULL;
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	if (!of_match_node(mtk_pcs_lynxi_of_match, np))
+		return ERR_PTR(-EINVAL);
+
+	pdev = of_find_device_by_node(np);
+	if (!pdev || !platform_get_drvdata(pdev)) {
+		if (pdev)
+			put_device(&pdev->dev);
+		return ERR_PTR(-EPROBE_DEFER);
+	}
+
+	mpcs = platform_get_drvdata(pdev);
+	put_device(&pdev->dev);
+
+	return &mpcs->pcs;
+}
+EXPORT_SYMBOL(mtk_pcs_lynxi_select_pcs);
+
+static struct platform_driver mtk_pcs_lynxi_driver = {
+	.driver = {
+		.name = "mtk-pcs-lynxi",
+		.of_match_table = mtk_pcs_lynxi_of_match,
+	},
+	.probe = mtk_pcs_lynxi_probe,
+};
+module_platform_driver(mtk_pcs_lynxi_driver);
+
+MODULE_AUTHOR("Daniel Golle <daniel@makrotopia.org>");
+MODULE_DESCRIPTION("MediaTek LynxI HSGMII PCS");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/pcs/pcs-mtk-lynxi.h b/include/linux/pcs/pcs-mtk-lynxi.h
index be3b4ab32f4a7..5db19d6a7261f 100644
--- a/include/linux/pcs/pcs-mtk-lynxi.h
+++ b/include/linux/pcs/pcs-mtk-lynxi.h
@@ -10,4 +10,5 @@ struct phylink_pcs *mtk_pcs_lynxi_create(struct device *dev,
 					 struct regmap *regmap,
 					 u32 ana_rgc3, u32 flags);
 void mtk_pcs_lynxi_destroy(struct phylink_pcs *pcs);
+struct phylink_pcs *mtk_pcs_lynxi_select_pcs(struct device_node *np, phy_interface_t mode);
 #endif
-- 
2.43.0
