Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C521575C57A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 13:09:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjGULJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 07:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbjGULIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DEC449D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 04:04:33 -0700 (PDT)
Received: from dude02.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::28])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <m.felsch@pengutronix.de>)
        id 1qMnvM-0000Ly-0H; Fri, 21 Jul 2023 13:03:52 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, mcoquelin.stm32@gmail.com
Cc:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH net-next v4 3/3] net: stmmac: add support for phy-supply
Date:   Fri, 21 Jul 2023 13:03:45 +0200
Message-Id: <20230721110345.3925719-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721110345.3925719-1-m.felsch@pengutronix.de>
References: <20230721110345.3925719-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:1101:1d::28
X-SA-Exim-Mail-From: m.felsch@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add generic phy-supply handling support to control the phy regulator to
avoid handling it within the glue code. Use the generic stmmac_platform
code to register a possible phy-supply and the stmmac_main code to
handle the power on/off.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
---
Changelog
v4:
- fix use_phy_wol
- v3-link: https://lore.kernel.org/lkml/20230720072304.3358701-1-m.felsch@pengutronix.de

v3:
- rebased onto net-next/main
- fixed changelog style
- v2-link: https://lore.kernel.org/lkml/20230718132049.3028341-1-m.felsch@pengutronix.de

v2:
- adapt stmmac_phy_power
- move power-on/off into stmmac_main to handle WOL
- adapt commit message
- v1-link: https://lore.kernel.org/lkml/20230717164307.2868264-1-m.felsch@pengutronix.de

 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 58 ++++++++++++++++++-
 .../ethernet/stmicro/stmmac/stmmac_platform.c | 10 ++++
 include/linux/stmmac.h                        |  1 +
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index add271ec8d801..9ec8964ab3582 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -31,6 +31,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 #include <linux/pinctrl/consumer.h>
+#include <linux/regulator/consumer.h>
 #ifdef CONFIG_DEBUG_FS
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
@@ -1128,6 +1129,55 @@ static void stmmac_check_pcs_mode(struct stmmac_priv *priv)
 	}
 }
 
+/**
+ * stmmac_phy_power - PHY regulator on/off
+ * @priv: driver private structure
+ * @enable: turn on the regulator if true else turn it off
+ * Enable or disable the regulator powering the PHY.
+ */
+static int stmmac_phy_power(struct stmmac_priv *priv, bool enable)
+{
+	struct regulator *regulator = priv->plat->phy_regulator;
+	struct device *dev = priv->device;
+
+	if (!regulator)
+		return 0;
+
+	if (enable) {
+		int ret;
+
+		ret = regulator_enable(regulator);
+		if (ret)
+			dev_err(dev, "Fail to enable regulator\n");
+
+		return ret;
+	}
+
+	regulator_disable(regulator);
+
+	return 0;
+}
+
+/**
+ * stmmac_phy_power_on - PHY regulator on
+ * @priv: driver private structure
+ * Enable the PHY regulator
+ */
+static int stmmac_phy_power_on(struct stmmac_priv *priv)
+{
+	return stmmac_phy_power(priv, true);
+}
+
+/**
+ * stmmac_phy_power_off - PHY regulator off
+ * @priv: driver private structure
+ * Disable the PHY regulator
+ */
+static void stmmac_phy_power_off(struct stmmac_priv *priv)
+{
+	stmmac_phy_power(priv, false);
+}
+
 /**
  * stmmac_init_phy - PHY initialization
  * @dev: net device structure
@@ -1253,7 +1303,8 @@ static int stmmac_phy_setup(struct stmmac_priv *priv)
 		return PTR_ERR(phylink);
 
 	priv->phylink = phylink;
-	return 0;
+
+	return stmmac_phy_power_on(priv);
 }
 
 static void stmmac_display_rx_rings(struct stmmac_priv *priv,
@@ -7593,6 +7644,7 @@ void stmmac_dvr_remove(struct device *dev)
 	if (priv->hw->pcs != STMMAC_PCS_TBI &&
 	    priv->hw->pcs != STMMAC_PCS_RTBI)
 		stmmac_mdio_unregister(ndev);
+	stmmac_phy_power_off(priv);
 	destroy_workqueue(priv->wq);
 	mutex_destroy(&priv->lock);
 	bitmap_free(priv->af_xdp_zc_qps);
@@ -7656,6 +7708,8 @@ int stmmac_suspend(struct device *dev)
 		if (device_may_wakeup(priv->device))
 			phylink_speed_down(priv->phylink, false);
 		phylink_suspend(priv->phylink, false);
+		if (!stmmac_use_phy_wol(priv))
+			stmmac_phy_power_off(priv);
 	}
 	rtnl_unlock();
 
@@ -7738,6 +7792,8 @@ int stmmac_resume(struct device *dev)
 		priv->irq_wake = 0;
 	} else {
 		pinctrl_pm_select_default_state(priv->device);
+		if (!stmmac_use_phy_wol(priv))
+			stmmac_phy_power_on(priv);
 		/* reset the phy so that it's ready */
 		if (priv->mii)
 			stmmac_mdio_reset(priv->mii);
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
index 23d53ea04b24d..18988da4614cd 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
@@ -11,6 +11,7 @@
 #include <linux/device.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/regulator/consumer.h>
 #include <linux/module.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -424,6 +425,15 @@ stmmac_probe_config_dt(struct platform_device *pdev, u8 *mac)
 	if (plat->interface < 0)
 		plat->interface = plat->phy_interface;
 
+	/* Optional regulator for PHY */
+	plat->phy_regulator = devm_regulator_get_optional(&pdev->dev, "phy");
+	if (IS_ERR(plat->phy_regulator)) {
+		if (PTR_ERR(plat->phy_regulator) == -EPROBE_DEFER)
+			return ERR_CAST(plat->phy_regulator);
+		dev_info(&pdev->dev, "No regulator found\n");
+		plat->phy_regulator = NULL;
+	}
+
 	/* Some wrapper drivers still rely on phy_node. Let's save it while
 	 * they are not converted to phylink. */
 	plat->phy_node = of_parse_phandle(np, "phy-handle", 0);
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index ef67dba775d04..b5d2d75de2759 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -222,6 +222,7 @@ struct plat_stmmacenet_data {
 	int phy_addr;
 	int interface;
 	phy_interface_t phy_interface;
+	struct regulator *phy_regulator;
 	struct stmmac_mdio_bus_data *mdio_bus_data;
 	struct device_node *phy_node;
 	struct device_node *phylink_node;
-- 
2.39.2

