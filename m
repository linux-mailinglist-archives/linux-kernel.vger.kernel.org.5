Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAAB7A9B84
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 21:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjIUTCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 15:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjIUTCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 15:02:02 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3794C7E7E4;
        Thu, 21 Sep 2023 10:35:20 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LB4EuF026736;
        Thu, 21 Sep 2023 17:06:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=HgdLqpCwv0ID+Ob78giBZKKYYOt0F9McKp/0y6gchIM=; b=mo
        hzVoDy8Tp13Fj7HEhBjgcLe6F//KVhTDHom7BOeyMqmbsnESfAYSXuWpNntmchJG
        3YNfWZEKbXXljiHPNZaRjDEeBN+tbjmc4g+klvc0qk8X+x4N4b1HnTbXEu5PQWo+
        nfgIoZaw+21ItOVMgJhOeun1UCzUOPPOYtbGEa1UsROrwA/7jZ3rhRR35LLvt0dJ
        1HQjMW2cVKDxhn/kGNP6EZ92NnkduGkmvJ91e1ayRG+9d7lML9/Os/ZA0khbdybA
        uowUfvPD6FbUd/zglxZkkKtZ5FKRT1zSvWJvRTbCTpIywvaGdOVxw2XcSrhWk8R0
        c6moW6cnZIoDtcF9T6Pg==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t53px4sqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 21 Sep 2023 17:06:51 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3146710005C;
        Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 26AB0252250;
        Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 17:06:50 +0200
From:   Christophe Roullier <christophe.roullier@foss.st.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Christophe Roullier <christophe.roullier@foss.st.com>
CC:     <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/7] net: ethernet: stmmac: rework glue to simplify management for next stm32
Date:   Thu, 21 Sep 2023 17:06:17 +0200
Message-ID: <20230921150622.599232-3-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230921150622.599232-1-christophe.roullier@foss.st.com>
References: <20230921150622.599232-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change glue to be more generic and manage easily next stm32 products.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 205 ++++++++++++------
 1 file changed, 139 insertions(+), 66 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index ab4324ed46da..762c5256398f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -14,6 +14,7 @@
 #include <linux/of_net.h>
 #include <linux/phy.h>
 #include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
@@ -23,10 +24,6 @@
 
 #define SYSCFG_MCU_ETH_MASK		BIT(23)
 #define SYSCFG_MP1_ETH_MASK		GENMASK(23, 16)
-#define SYSCFG_PMCCLRR_OFFSET		0x40
-
-#define SYSCFG_PMCR_ETH_CLK_SEL		BIT(16)
-#define SYSCFG_PMCR_ETH_REF_CLK_SEL	BIT(17)
 
 /* CLOCK feed to PHY*/
 #define ETH_CK_F_25M	25000000
@@ -46,9 +43,6 @@
  * RMII  |   1	 |   0	  |   0	   |  n/a  |
  *------------------------------------------
  */
-#define SYSCFG_PMCR_ETH_SEL_MII		BIT(20)
-#define SYSCFG_PMCR_ETH_SEL_RGMII	BIT(21)
-#define SYSCFG_PMCR_ETH_SEL_RMII	BIT(23)
 #define SYSCFG_PMCR_ETH_SEL_GMII	0
 #define SYSCFG_MCU_ETH_SEL_MII		0
 #define SYSCFG_MCU_ETH_SEL_RMII		1
@@ -62,17 +56,17 @@
  *|         |        |      25MHz    |        50MHz       |                  |
  * ---------------------------------------------------------------------------
  *|  MII    |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |	             |                    |		     |
  * ---------------------------------------------------------------------------
  *|  GMII   |	 -   |     eth-ck    |	      n/a	  |	  n/a        |
- *|         |        | st,ext-phyclk |                    |		     |
+ *|         |        |               |                    |		     |
  * ---------------------------------------------------------------------------
  *| RGMII   |	 -   |     eth-ck    |	      n/a	  |      eth-ck      |
- *|         |        | st,ext-phyclk |                    | st,eth-clk-sel or|
+ *|         |        |               |                    | st,eth-clk-sel or|
  *|         |        |               |                    | st,ext-phyclk    |
  * ---------------------------------------------------------------------------
  *| RMII    |	 -   |     eth-ck    |	    eth-ck        |	  n/a        |
- *|         |        | st,ext-phyclk | st,eth-ref-clk-sel |		     |
+ *|         |        |               | st,eth-ref-clk-sel |		     |
  *|         |        |               | or st,ext-phyclk   |		     |
  * ---------------------------------------------------------------------------
  *
@@ -88,14 +82,27 @@ struct stm32_dwmac {
 	int enable_eth_ck;
 	int eth_clk_sel_reg;
 	int eth_ref_clk_sel_reg;
-	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
+	u32 mode_mask;
 	struct regmap *regmap;
+	struct regulator *regulator;
 	u32 speed;
 	const struct stm32_ops *ops;
 	struct device *dev;
 };
 
+struct stm32_syscfg_pmcsetr {
+	u32 eth1_clk_sel;
+	u32 eth1_ref_clk_sel;
+	u32 eth1_selmii;
+	u32 eth1_sel_rgmii;
+	u32 eth1_sel_rmii;
+	u32 eth2_clk_sel;
+	u32 eth2_ref_clk_sel;
+	u32 eth2_sel_rgmii;
+	u32 eth2_sel_rmii;
+};
+
 struct stm32_ops {
 	int (*set_mode)(struct plat_stmmacenet_data *plat_dat);
 	int (*clk_prepare)(struct stm32_dwmac *dwmac, bool prepare);
@@ -103,7 +110,8 @@ struct stm32_ops {
 	void (*resume)(struct stm32_dwmac *dwmac);
 	int (*parse_data)(struct stm32_dwmac *dwmac,
 			  struct device *dev);
-	u32 syscfg_eth_mask;
+	u32 syscfg_clr_off;
+	struct stm32_syscfg_pmcsetr pmcsetr;
 };
 
 static int stm32_dwmac_init(struct plat_stmmacenet_data *plat_dat)
@@ -173,26 +181,26 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	dwmac->enable_eth_ck = false;
 	switch (plat_dat->mac_interface) {
 	case PHY_INTERFACE_MODE_MII:
-		if (clk_rate == ETH_CK_F_25M && dwmac->ext_phyclk)
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
-		val = SYSCFG_PMCR_ETH_SEL_MII;
+		val = dwmac->ops->pmcsetr.eth1_selmii;
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_MII\n");
 		break;
 	case PHY_INTERFACE_MODE_GMII:
 		val = SYSCFG_PMCR_ETH_SEL_GMII;
-		if (clk_rate == ETH_CK_F_25M &&
-		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
+		if (clk_rate == ETH_CK_F_25M)
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
-		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_GMII\n");
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		val = SYSCFG_PMCR_ETH_SEL_RMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_50M) &&
+		val = dwmac->ops->pmcsetr.eth1_sel_rmii | dwmac->ops->pmcsetr.eth2_sel_rmii;
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if ((clk_rate == ETH_CK_F_50M) &&
 		    (dwmac->eth_ref_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_REF_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_ref_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_ref_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RMII\n");
 		break;
@@ -200,11 +208,14 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII_RXID:
 	case PHY_INTERFACE_MODE_RGMII_TXID:
-		val = SYSCFG_PMCR_ETH_SEL_RGMII;
-		if ((clk_rate == ETH_CK_F_25M || clk_rate == ETH_CK_F_125M) &&
+		val = dwmac->ops->pmcsetr.eth1_sel_rgmii | dwmac->ops->pmcsetr.eth2_sel_rgmii;
+		if (clk_rate == ETH_CK_F_25M)
+			dwmac->enable_eth_ck = true;
+		if ((clk_rate == ETH_CK_F_125M) &&
 		    (dwmac->eth_clk_sel_reg || dwmac->ext_phyclk)) {
 			dwmac->enable_eth_ck = true;
-			val |= SYSCFG_PMCR_ETH_CLK_SEL;
+			val |= dwmac->ops->pmcsetr.eth1_clk_sel;
+			val |= dwmac->ops->pmcsetr.eth2_clk_sel;
 		}
 		pr_debug("SYSCFG init : PHY_INTERFACE_MODE_RGMII\n");
 		break;
@@ -216,12 +227,12 @@ static int stm32mp1_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	/* Need to update PMCCLRR (clear register) */
-	regmap_write(dwmac->regmap, reg + SYSCFG_PMCCLRR_OFFSET,
-		     dwmac->ops->syscfg_eth_mask);
+	regmap_write(dwmac->regmap, dwmac->ops->syscfg_clr_off,
+		     dwmac->mode_mask);
 
 	/* Update PMCSETR (set register) */
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val);
+				 dwmac->mode_mask, val);
 }
 
 static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
@@ -247,7 +258,7 @@ static int stm32mcu_set_mode(struct plat_stmmacenet_data *plat_dat)
 	}
 
 	return regmap_update_bits(dwmac->regmap, reg,
-				 dwmac->ops->syscfg_eth_mask, val << 23);
+				 SYSCFG_MCU_ETH_MASK, val << 23);
 }
 
 static void stm32_dwmac_clk_disable(struct stm32_dwmac *dwmac)
@@ -290,18 +301,33 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 		return PTR_ERR(dwmac->regmap);
 
 	err = of_property_read_u32_index(np, "st,syscon", 1, &dwmac->mode_reg);
+	if (err) {
+		dev_err(dev, "Can't get sysconfig register offset (%d)\n", err);
+		return err;
+	}
+
+	dwmac->mode_mask = SYSCFG_MP1_ETH_MASK;
+	err = of_property_read_u32_index(np, "st,syscon", 2, &dwmac->mode_mask);
 	if (err)
-		dev_err(dev, "Can't get sysconfig mode offset (%d)\n", err);
+		pr_debug("Warning sysconfig register mask not set\n");
 
-	return err;
+	dwmac->regulator = devm_regulator_get_optional(dev, "phy");
+	if (IS_ERR(dwmac->regulator)) {
+		if (PTR_ERR(dwmac->regulator) == -EPROBE_DEFER) {
+			dev_dbg(dev, "phy regulator is not available yet, deferred probing\n");
+			return -EPROBE_DEFER;
+		}
+		dev_dbg(dev, "no regulator found\n");
+		dwmac->regulator = NULL;
+	}
+
+	return 0;
 }
 
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 			       struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	int err = 0;
 
 	/* Ethernet PHY have no crystal */
 	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
@@ -316,7 +342,7 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	/*  Get ETH_CLK clocks */
 	dwmac->clk_eth_ck = devm_clk_get(dev, "eth-ck");
 	if (IS_ERR(dwmac->clk_eth_ck)) {
-		dev_info(dev, "No phy clock provided...\n");
+		dev_dbg(dev, "No phy clock provided...\n");
 		dwmac->clk_eth_ck = NULL;
 	}
 
@@ -333,29 +359,45 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 	if (IS_ERR(dwmac->syscfg_clk))
 		dwmac->syscfg_clk = NULL;
 
-	/* Get IRQ information early to have an ability to ask for deferred
-	 * probe if needed before we went too far with resource allocation.
-	 */
-	dwmac->irq_pwr_wakeup = platform_get_irq_byname_optional(pdev,
-							"stm32_pwr_wakeup");
-	if (dwmac->irq_pwr_wakeup == -EPROBE_DEFER)
-		return -EPROBE_DEFER;
-
-	if (!dwmac->clk_eth_ck && dwmac->irq_pwr_wakeup >= 0) {
-		err = device_init_wakeup(&pdev->dev, true);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to init wake up irq\n");
-			return err;
-		}
-		err = dev_pm_set_dedicated_wake_irq(&pdev->dev,
-						    dwmac->irq_pwr_wakeup);
-		if (err) {
-			dev_err(&pdev->dev, "Failed to set wake up irq\n");
-			device_init_wakeup(&pdev->dev, false);
-		}
-		device_set_wakeup_enable(&pdev->dev, false);
+	return 0;
+}
+
+static int stm32_dwmac_wake_init(struct device *dev,
+				 struct stmmac_resources *stmmac_res)
+{
+	int err;
+
+	device_set_wakeup_capable(dev, true);
+
+	err = dev_pm_set_wake_irq(dev, stmmac_res->wol_irq);
+	if (err) {
+		dev_err(dev, "Failed to set wake up irq\n");
+		device_set_wakeup_capable(dev, false);
+		return err;
+	}
+
+	return 0;
+}
+
+static int phy_power_on(struct stm32_dwmac *bsp_priv, bool enable)
+{
+	int ret;
+	struct device *dev = bsp_priv->dev;
+
+	if (!bsp_priv->regulator)
+		return 0;
+
+	if (enable) {
+		ret = regulator_enable(bsp_priv->regulator);
+		if (ret)
+			dev_err(dev, "fail to enable phy-supply\n");
+	} else {
+		ret = regulator_disable(bsp_priv->regulator);
+		if (ret)
+			dev_err(dev, "fail to disable phy-supply\n");
 	}
-	return err;
+
+	return 0;
 }
 
 static int stm32_dwmac_probe(struct platform_device *pdev)
@@ -393,21 +435,37 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	if (stmmac_res.wol_irq && !dwmac->clk_eth_ck) {
+		ret = stm32_dwmac_wake_init(&pdev->dev, &stmmac_res);
+		if (ret)
+			goto err_wake_init_disable;
+	}
+
 	plat_dat->bsp_priv = dwmac;
 
 	ret = stm32_dwmac_init(plat_dat);
 	if (ret)
-		return ret;
+		goto err_wake_init_disable;
 
-	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	ret = phy_power_on(plat_dat->bsp_priv, true);
 	if (ret)
 		goto err_clk_disable;
 
+	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
+	if (ret)
+		goto err_gmac_powerdown;
+
 	return 0;
 
+err_gmac_powerdown:
+	phy_power_on(plat_dat->bsp_priv, false);
 err_clk_disable:
 	stm32_dwmac_clk_disable(dwmac);
-
+err_wake_init_disable:
+	if (stmmac_res.wol_irq && !dwmac->clk_eth_ck) {
+		dev_pm_clear_wake_irq(&pdev->dev);
+		device_set_wakeup_capable(&pdev->dev, false);
+	}
 	return ret;
 }
 
@@ -415,16 +473,13 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 
 	stmmac_dvr_remove(&pdev->dev);
 
 	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
 
-	if (dwmac->irq_pwr_wakeup >= 0) {
-		dev_pm_clear_wake_irq(&pdev->dev);
-		device_init_wakeup(&pdev->dev, false);
-	}
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
@@ -440,12 +495,20 @@ static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
 	if (dwmac->enable_eth_ck)
 		clk_disable_unprepare(dwmac->clk_eth_ck);
 
+	/* Keep the PHY up if we use Wake-on-Lan. */
+	if (!device_may_wakeup(dwmac->dev))
+		phy_power_on(dwmac, false);
+
 	return ret;
 }
 
 static void stm32mp1_resume(struct stm32_dwmac *dwmac)
 {
 	clk_disable_unprepare(dwmac->clk_ethstp);
+
+	/* The PHY was up for Wake-on-Lan. */
+	if (!device_may_wakeup(dwmac->dev))
+		phy_power_on(dwmac, true);
 }
 
 static int stm32mcu_suspend(struct stm32_dwmac *dwmac)
@@ -499,7 +562,6 @@ static SIMPLE_DEV_PM_OPS(stm32_dwmac_pm_ops,
 static struct stm32_ops stm32mcu_dwmac_data = {
 	.set_mode = stm32mcu_set_mode,
 	.suspend = stm32mcu_suspend,
-	.syscfg_eth_mask = SYSCFG_MCU_ETH_MASK
 };
 
 static struct stm32_ops stm32mp1_dwmac_data = {
@@ -508,7 +570,18 @@ static struct stm32_ops stm32mp1_dwmac_data = {
 	.suspend = stm32mp1_suspend,
 	.resume = stm32mp1_resume,
 	.parse_data = stm32mp1_parse_data,
-	.syscfg_eth_mask = SYSCFG_MP1_ETH_MASK
+	.syscfg_clr_off = 0x44,
+	.pmcsetr = {
+		.eth1_clk_sel		= BIT(16),
+		.eth1_ref_clk_sel	= BIT(17),
+		.eth1_selmii		= BIT(20),
+		.eth1_sel_rgmii		= BIT(21),
+		.eth1_sel_rmii		= BIT(23),
+		.eth2_clk_sel		= 0,
+		.eth2_ref_clk_sel	= 0,
+		.eth2_sel_rgmii		= 0,
+		.eth2_sel_rmii		= 0
+	}
 };
 
 static const struct of_device_id stm32_dwmac_match[] = {
-- 
2.25.1

