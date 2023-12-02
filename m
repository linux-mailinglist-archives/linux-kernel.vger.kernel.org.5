Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56771801BAA
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 10:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231851AbjLBJX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 04:23:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbjLBJX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 04:23:27 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 02 Dec 2023 01:23:31 PST
Received: from mail-m92244.xmail.ntesmail.com (mail-m92244.xmail.ntesmail.com [103.126.92.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D689E;
        Sat,  2 Dec 2023 01:23:31 -0800 (PST)
DKIM-Signature: a=rsa-sha256;
        b=Th2v5iV/l2L1wbN87SyMQIQyavtk6yH9CCgzrnj4JP6zyjT9Cr47YT2H0osyJzpzE+e2EQcy66wJfupbGmX62VqJxLyQscUwiG9SfnU9mp9YYYoZXw3NHuTTuJxsm/C6V5OQutvvdavOljHCIh0q2UowQNyqNd20SkvEugytRB8=;
        s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
        bh=vyX/lxSXq2Q5RNwAmsKFUuXJAonqdZmX1UmuleUYFkE=;
        h=date:mime-version:subject:message-id:from;
Received: from localhost.localdomain (unknown [58.22.7.114])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id EE86B3C030D;
        Sat,  2 Dec 2023 17:18:07 +0800 (CST)
From:   David Wu <david.wu@rock-chips.com>
To:     netdev@vger.kernel.org, sebastian.reichel@collabora.com
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        David Wu <david.wu@rock-chips.com>
Subject: [PATCH] net: ethernet: stmmac: dwmac-rk: Repair the clock handling
Date:   Sat,  2 Dec 2023 17:18:06 +0800
Message-Id: <20231202091806.179512-1-david.wu@rock-chips.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ00aHlZMTkJDT09IHh4YShpVEwETFh
        oSFyQUDg9ZV1kYEgtZQVlOQ1VJSVVMVUpKT1lXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQk
        tLWQY+
X-HM-Tid: 0a8c29d228ce2eb2kusnee86b3c030d
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PjY6FRw6Ojw4NAsdQxpPMhIZ
        N0MKCjJVSlVKTEtKTktDTUNDQ09IVTMWGhIXVR8aDRIfVQwOOwkUGBBWGBMSCwhVGBQWRVlXWRIL
        WUFZTkNVSUlVTFVKSk9ZV1kIAVlBTE5CSTcG
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's clarier and simpler to replace devm_clk_bulk_get_optional
via devm_clk_bulk_get_all. And it may be a different clocks
combination for different Socs, so for the clk_mac_speed, it is
more correct to obtain the clock directly by its name.

Fixes: ea449f7fa0bf ("net: ethernet: stmmac: dwmac-rk: rework optional clock handling")
Signed-off-by: David Wu <david.wu@rock-chips.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-rk.c    | 83 ++++++++-----------
 1 file changed, 33 insertions(+), 50 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 382e8de1255d..fff18037e68c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -39,24 +39,6 @@ struct rk_gmac_ops {
 	u32 regs[];
 };
 
-static const char * const rk_clocks[] = {
-	"aclk_mac", "pclk_mac", "mac_clk_tx", "clk_mac_speed",
-};
-
-static const char * const rk_rmii_clocks[] = {
-	"mac_clk_rx", "clk_mac_ref", "clk_mac_refout",
-};
-
-enum rk_clocks_index {
-	RK_ACLK_MAC = 0,
-	RK_PCLK_MAC,
-	RK_MAC_CLK_TX,
-	RK_CLK_MAC_SPEED,
-	RK_MAC_CLK_RX,
-	RK_CLK_MAC_REF,
-	RK_CLK_MAC_REFOUT,
-};
-
 struct rk_priv_data {
 	struct platform_device *pdev;
 	phy_interface_t phy_iface;
@@ -73,6 +55,7 @@ struct rk_priv_data {
 	int num_clks;
 	struct clk *clk_mac;
 	struct clk *clk_phy;
+	struct clk *clk_mac_speed;
 
 	struct reset_control *phy_reset;
 
@@ -116,12 +99,11 @@ static void px30_set_to_rmii(struct rk_priv_data *bsp_priv)
 
 static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
 	int ret;
 
-	if (!clk_mac_speed) {
-		dev_err(dev, "%s: Missing clk_mac_speed clock\n", __func__);
+	if (!bsp_priv->clk_mac_speed) {
+		dev_err(dev, "Missing clk_mac_speed clock\n");
 		return;
 	}
 
@@ -129,7 +111,7 @@ static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
 			     PX30_GMAC_SPEED_10M);
 
-		ret = clk_set_rate(clk_mac_speed, 2500000);
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 2500000);
 		if (ret)
 			dev_err(dev, "%s: set clk_mac_speed rate 2500000 failed: %d\n",
 				__func__, ret);
@@ -137,7 +119,7 @@ static void px30_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		regmap_write(bsp_priv->grf, PX30_GRF_GMAC_CON1,
 			     PX30_GMAC_SPEED_100M);
 
-		ret = clk_set_rate(clk_mac_speed, 25000000);
+		ret = clk_set_rate(bsp_priv->clk_mac_speed, 25000000);
 		if (ret)
 			dev_err(dev, "%s: set clk_mac_speed rate 25000000 failed: %d\n",
 				__func__, ret);
@@ -1079,11 +1061,15 @@ static void rk3568_set_to_rmii(struct rk_priv_data *bsp_priv)
 
 static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 {
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned long rate;
 	int ret;
 
+	if (!bsp_priv->clk_mac_speed) {
+		dev_err(dev, "Missing clk_mac_speed clock\n");
+		return;
+	}
+
 	switch (speed) {
 	case 10:
 		rate = 2500000;
@@ -1099,7 +1085,7 @@ static void rk3568_set_gmac_speed(struct rk_priv_data *bsp_priv, int speed)
 		return;
 	}
 
-	ret = clk_set_rate(clk_mac_speed, rate);
+	ret = clk_set_rate(bsp_priv->clk_mac_speed, rate);
 	if (ret)
 		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
 			__func__, rate, ret);
@@ -1385,11 +1371,15 @@ static void rv1126_set_to_rmii(struct rk_priv_data *bsp_priv)
 
 static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned long rate;
 	int ret;
 
+	if (!bsp_priv->clk_mac_speed) {
+		dev_err(dev, "Missing clk_mac_speed clock\n");
+		return;
+	}
+
 	switch (speed) {
 	case 10:
 		rate = 2500000;
@@ -1405,7 +1395,7 @@ static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		return;
 	}
 
-	ret = clk_set_rate(clk_mac_speed, rate);
+	ret = clk_set_rate(bsp_priv->clk_mac_speed, rate);
 	if (ret)
 		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
 			__func__, rate, ret);
@@ -1413,11 +1403,15 @@ static void rv1126_set_rgmii_speed(struct rk_priv_data *bsp_priv, int speed)
 
 static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 {
-	struct clk *clk_mac_speed = bsp_priv->clks[RK_CLK_MAC_SPEED].clk;
 	struct device *dev = &bsp_priv->pdev->dev;
 	unsigned long rate;
 	int ret;
 
+	if (!bsp_priv->clk_mac_speed) {
+		dev_err(dev, "Missing clk_mac_speed clock\n");
+		return;
+	}
+
 	switch (speed) {
 	case 10:
 		rate = 2500000;
@@ -1430,7 +1424,7 @@ static void rv1126_set_rmii_speed(struct rk_priv_data *bsp_priv, int speed)
 		return;
 	}
 
-	ret = clk_set_rate(clk_mac_speed, rate);
+	ret = clk_set_rate(bsp_priv->clk_mac_speed, rate);
 	if (ret)
 		dev_err(dev, "%s: set clk_mac_speed rate %ld failed %d\n",
 			__func__, rate, ret);
@@ -1492,31 +1486,14 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 	struct rk_priv_data *bsp_priv = plat->bsp_priv;
 	struct device *dev = &bsp_priv->pdev->dev;
 	int phy_iface = bsp_priv->phy_iface;
-	int i, j, ret;
+	int ret;
 
 	bsp_priv->clk_enabled = false;
 
-	bsp_priv->num_clks = ARRAY_SIZE(rk_clocks);
-	if (phy_iface == PHY_INTERFACE_MODE_RMII)
-		bsp_priv->num_clks += ARRAY_SIZE(rk_rmii_clocks);
-
-	bsp_priv->clks = devm_kcalloc(dev, bsp_priv->num_clks,
-				      sizeof(*bsp_priv->clks), GFP_KERNEL);
-	if (!bsp_priv->clks)
-		return -ENOMEM;
-
-	for (i = 0; i < ARRAY_SIZE(rk_clocks); i++)
-		bsp_priv->clks[i].id = rk_clocks[i];
-
-	if (phy_iface == PHY_INTERFACE_MODE_RMII) {
-		for (j = 0; j < ARRAY_SIZE(rk_rmii_clocks); j++)
-			bsp_priv->clks[i++].id = rk_rmii_clocks[j];
-	}
-
-	ret = devm_clk_bulk_get_optional(dev, bsp_priv->num_clks,
-					 bsp_priv->clks);
-	if (ret)
+	ret = devm_clk_bulk_get_all(dev, &bsp_priv->clks);
+	if (ret <= 0)
 		return dev_err_probe(dev, ret, "Failed to get clocks\n");
+	bsp_priv->num_clks = ret;
 
 	/* "stmmaceth" will be enabled by the core */
 	bsp_priv->clk_mac = devm_clk_get(dev, "stmmaceth");
@@ -1538,6 +1515,12 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		clk_set_rate(bsp_priv->clk_phy, 50000000);
 	}
 
+	/* get option clock */
+	bsp_priv->clk_mac_speed = devm_clk_get(dev, "clk_mac_speed");
+	ret = PTR_ERR_OR_ZERO(bsp_priv->clk_mac_speed);
+	if (ret)
+		bsp_priv->clk_mac_speed = NULL;
+
 	return 0;
 }
 
-- 
2.25.1

