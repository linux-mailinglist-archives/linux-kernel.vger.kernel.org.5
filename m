Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF797BE830
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 19:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378036AbjJIRco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 13:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378067AbjJIRck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 13:32:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D104310D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 10:32:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB33C433C7;
        Mon,  9 Oct 2023 17:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696872757;
        bh=A8WM7jgGtt3glq+HqYBadr3EppHcnVR5hi6lvtrs9G8=;
        h=From:To:Cc:Subject:Date:From;
        b=ddJPLzjwg59PGkgs87hBJgB8I/8jC39C77x85AqWBNgoeCdCwBtKqlzRQ0kib4jC/
         U8WMWx2G4eUusX9LR1neN+gIwf1nlgnsae//7lHX5b37x+963napX7xMZYg3p+GfKJ
         OnmNPN+TVLVu1l/Gp9ptPHCIBl5Nneah5GOJoUxE4pzJLJKmBsaZ/SLAwTXm1XIODc
         SffgcNunl7ih5nz9XW2qTFquErqnWIEC6+eOt6Iyzgqa/sbkVeMvs6Pa9xDqmjwRP+
         Y3VqzOZhUeoNATzomDUKK5KYxB7zO5A7htLD86d3Mk63fElJaZis+43JDNlkUJaWCn
         RDgLRQoa8t2yQ==
Received: (nullmailer pid 2528549 invoked by uid 1000);
        Mon, 09 Oct 2023 17:32:35 -0000
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH] phy: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 12:29:10 -0500
Message-ID: <20231009172923.2457844-15-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use preferred device_get_match_data() instead of of_match_device() to
get the driver match data. With this, adjust the includes to explicitly
include the correct headers.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/phy/broadcom/phy-bcm-ns-usb3.c   |  9 +++------
 drivers/phy/marvell/phy-berlin-usb.c     |  7 +++----
 drivers/phy/ralink/phy-ralink-usb.c      | 10 +++-------
 drivers/phy/rockchip/phy-rockchip-pcie.c | 11 ++++-------
 drivers/phy/rockchip/phy-rockchip-usb.c  | 10 +++-------
 drivers/phy/ti/phy-omap-control.c        |  9 ++-------
 drivers/phy/ti/phy-omap-usb2.c           | 11 ++++-------
 drivers/phy/ti/phy-ti-pipe3.c            | 14 ++++----------
 8 files changed, 26 insertions(+), 55 deletions(-)

diff --git a/drivers/phy/broadcom/phy-bcm-ns-usb3.c b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
index 69584b685edb..2c8b1b7dda5b 100644
--- a/drivers/phy/broadcom/phy-bcm-ns-usb3.c
+++ b/drivers/phy/broadcom/phy-bcm-ns-usb3.c
@@ -16,10 +16,11 @@
 #include <linux/iopoll.h>
 #include <linux/mdio.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/phy/phy.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #define BCM_NS_USB3_PHY_BASE_ADDR_REG	0x1f
@@ -189,7 +190,6 @@ static int bcm_ns_usb3_mdio_phy_write(struct bcm_ns_usb3 *usb3, u16 reg,
 static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 {
 	struct device *dev = &mdiodev->dev;
-	const struct of_device_id *of_id;
 	struct phy_provider *phy_provider;
 	struct device_node *syscon_np;
 	struct bcm_ns_usb3 *usb3;
@@ -203,10 +203,7 @@ static int bcm_ns_usb3_mdio_probe(struct mdio_device *mdiodev)
 	usb3->dev = dev;
 	usb3->mdiodev = mdiodev;
 
-	of_id = of_match_device(bcm_ns_usb3_id_table, dev);
-	if (!of_id)
-		return -EINVAL;
-	usb3->family = (uintptr_t)of_id->data;
+	usb3->family = (enum bcm_ns_family)device_get_match_data(dev);
 
 	syscon_np = of_parse_phandle(dev->of_node, "usb3-dmp-syscon", 0);
 	err = of_address_to_resource(syscon_np, 0, &res);
diff --git a/drivers/phy/marvell/phy-berlin-usb.c b/drivers/phy/marvell/phy-berlin-usb.c
index 78ef6ae72a9a..f26bf630da2c 100644
--- a/drivers/phy/marvell/phy-berlin-usb.c
+++ b/drivers/phy/marvell/phy-berlin-usb.c
@@ -8,9 +8,10 @@
 
 #include <linux/io.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/reset.h>
 
 #define USB_PHY_PLL		0x04
@@ -162,8 +163,6 @@ MODULE_DEVICE_TABLE(of, phy_berlin_usb_of_match);
 
 static int phy_berlin_usb_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match =
-		of_match_device(phy_berlin_usb_of_match, &pdev->dev);
 	struct phy_berlin_usb_priv *priv;
 	struct phy *phy;
 	struct phy_provider *phy_provider;
@@ -180,7 +179,7 @@ static int phy_berlin_usb_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->rst_ctrl))
 		return PTR_ERR(priv->rst_ctrl);
 
-	priv->pll_divider = *((u32 *)match->data);
+	priv->pll_divider = *((u32 *)device_get_match_data(&pdev->dev));
 
 	phy = devm_phy_create(&pdev->dev, NULL, &phy_berlin_usb_ops);
 	if (IS_ERR(phy)) {
diff --git a/drivers/phy/ralink/phy-ralink-usb.c b/drivers/phy/ralink/phy-ralink-usb.c
index 2bd8ad2e76ed..41bce5290e92 100644
--- a/drivers/phy/ralink/phy-ralink-usb.c
+++ b/drivers/phy/ralink/phy-ralink-usb.c
@@ -13,9 +13,10 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/of_platform.h>
+#include <linux/of.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/platform_device.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -171,18 +172,13 @@ static int ralink_usb_phy_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
 	struct ralink_usb_phy *phy;
 
-	match = of_match_device(ralink_usb_phy_of_match, &pdev->dev);
-	if (!match)
-		return -ENODEV;
-
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	phy->clk = (uintptr_t)match->data;
+	phy->clk = (uintptr_t)device_get_match_data(&pdev->dev);
 	phy->base = NULL;
 
 	phy->sysctl = syscon_regmap_lookup_by_phandle(dev->of_node, "ralink,sysctl");
diff --git a/drivers/phy/rockchip/phy-rockchip-pcie.c b/drivers/phy/rockchip/phy-rockchip-pcie.c
index 8234b83fdd88..1bbd6be2a584 100644
--- a/drivers/phy/rockchip/phy-rockchip-pcie.c
+++ b/drivers/phy/rockchip/phy-rockchip-pcie.c
@@ -12,10 +12,9 @@
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/reset.h>
 
@@ -63,7 +62,7 @@ struct rockchip_pcie_data {
 };
 
 struct rockchip_pcie_phy {
-	struct rockchip_pcie_data *phy_data;
+	const struct rockchip_pcie_data *phy_data;
 	struct regmap *reg_base;
 	struct phy_pcie_instance {
 		struct phy *phy;
@@ -350,7 +349,6 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	struct rockchip_pcie_phy *rk_phy;
 	struct phy_provider *phy_provider;
 	struct regmap *grf;
-	const struct of_device_id *of_id;
 	int i;
 	u32 phy_num;
 
@@ -364,11 +362,10 @@ static int rockchip_pcie_phy_probe(struct platform_device *pdev)
 	if (!rk_phy)
 		return -ENOMEM;
 
-	of_id = of_match_device(rockchip_pcie_phy_dt_ids, &pdev->dev);
-	if (!of_id)
+	rk_phy->phy_data = device_get_match_data(&pdev->dev);
+	if (!rk_phy->phy_data)
 		return -EINVAL;
 
-	rk_phy->phy_data = (struct rockchip_pcie_data *)of_id->data;
 	rk_phy->reg_base = grf;
 
 	mutex_init(&rk_phy->pcie_mutex);
diff --git a/drivers/phy/rockchip/phy-rockchip-usb.c b/drivers/phy/rockchip/phy-rockchip-usb.c
index 8454285977eb..666a896c8f0a 100644
--- a/drivers/phy/rockchip/phy-rockchip-usb.c
+++ b/drivers/phy/rockchip/phy-rockchip-usb.c
@@ -13,10 +13,9 @@
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_platform.h>
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/reset.h>
 #include <linux/regmap.h>
@@ -458,7 +457,6 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct rockchip_usb_phy_base *phy_base;
 	struct phy_provider *phy_provider;
-	const struct of_device_id *match;
 	struct device_node *child;
 	int err;
 
@@ -466,14 +464,12 @@ static int rockchip_usb_phy_probe(struct platform_device *pdev)
 	if (!phy_base)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	phy_base->pdata = device_get_match_data(dev);
+	if (!phy_base->pdata) {
 		dev_err(dev, "missing phy data\n");
 		return -EINVAL;
 	}
 
-	phy_base->pdata = match->data;
-
 	phy_base->dev = dev;
 	phy_base->reg_base = ERR_PTR(-ENODEV);
 	if (dev->parent && dev->parent->of_node)
diff --git a/drivers/phy/ti/phy-omap-control.c b/drivers/phy/ti/phy-omap-control.c
index 76c5595f0859..2fdb8f4241c7 100644
--- a/drivers/phy/ti/phy-omap-control.c
+++ b/drivers/phy/ti/phy-omap-control.c
@@ -8,9 +8,9 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/clk.h>
@@ -268,20 +268,15 @@ MODULE_DEVICE_TABLE(of, omap_control_phy_id_table);
 
 static int omap_control_phy_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct omap_control_phy *control_phy;
 
-	of_id = of_match_device(omap_control_phy_id_table, &pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
 	control_phy = devm_kzalloc(&pdev->dev, sizeof(*control_phy),
 		GFP_KERNEL);
 	if (!control_phy)
 		return -ENOMEM;
 
 	control_phy->dev = &pdev->dev;
-	control_phy->type = *(enum omap_control_phy_type *)of_id->data;
+	control_phy->type = *(enum omap_control_phy_type *)device_get_match_data(&pdev->dev);
 
 	if (control_phy->type == OMAP_CTRL_TYPE_OTGHS) {
 		control_phy->otghs_control =
diff --git a/drivers/phy/ti/phy-omap-usb2.c b/drivers/phy/ti/phy-omap-usb2.c
index 762d3de8b3c5..dd2913ac0fa2 100644
--- a/drivers/phy/ti/phy-omap-usb2.c
+++ b/drivers/phy/ti/phy-omap-usb2.c
@@ -19,6 +19,7 @@
 #include <linux/phy/phy.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/sys_soc.h>
@@ -371,16 +372,12 @@ static int omap_usb2_probe(struct platform_device *pdev)
 	struct device_node *node = pdev->dev.of_node;
 	struct device_node *control_node;
 	struct platform_device *control_pdev;
-	const struct of_device_id *of_id;
-	struct usb_phy_data *phy_data;
+	const struct usb_phy_data *phy_data;
 
-	of_id = of_match_device(omap_usb2_id_table, &pdev->dev);
-
-	if (!of_id)
+	phy_data = device_get_match_data(&pdev->dev);
+	if (!phy_data)
 		return -EINVAL;
 
-	phy_data = (struct usb_phy_data *)of_id->data;
-
 	phy = devm_kzalloc(&pdev->dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
diff --git a/drivers/phy/ti/phy-ti-pipe3.c b/drivers/phy/ti/phy-ti-pipe3.c
index 507e1552db5e..874c1a25ce36 100644
--- a/drivers/phy/ti/phy-ti-pipe3.c
+++ b/drivers/phy/ti/phy-ti-pipe3.c
@@ -8,6 +8,7 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/phy/phy.h>
 #include <linux/of.h>
@@ -778,23 +779,16 @@ static int ti_pipe3_probe(struct platform_device *pdev)
 	struct phy_provider *phy_provider;
 	struct device *dev = &pdev->dev;
 	int ret;
-	const struct of_device_id *match;
-	struct pipe3_data *data;
+	const struct pipe3_data *data;
 
 	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
 	if (!phy)
 		return -ENOMEM;
 
-	match = of_match_device(ti_pipe3_id_table, dev);
-	if (!match)
+	data = device_get_match_data(dev);
+	if (!data)
 		return -EINVAL;
 
-	data = (struct pipe3_data *)match->data;
-	if (!data) {
-		dev_err(dev, "no driver data\n");
-		return -EINVAL;
-	}
-
 	phy->dev = dev;
 	phy->mode = data->mode;
 	phy->dpll_map = data->dpll_map;
-- 
2.42.0

