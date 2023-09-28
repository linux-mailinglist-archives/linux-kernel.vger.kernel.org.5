Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5E7B20E6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 17:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbjI1PRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 11:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjI1PRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 11:17:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF481B3;
        Thu, 28 Sep 2023 08:17:11 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38SEMuPt015718;
        Thu, 28 Sep 2023 17:16:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        selector1; bh=YH09b5A6p7d6RqxQi7VNy0tTydxbVqJd3xWAAQdyLhA=; b=Ix
        GxWdkA8Oq9YyQg5i9Y3329Ehs4+AADQesmFQmI93cD8Wy5n4TMXVf+O3KdBgqlSC
        r2vS1DYWqBoz0DgYOxoolXjvwEX0V5ERJeWhcLkfXq7ZNz11g0BefsMvbZhBIH9z
        rg1vq3omPgcZHrLqDBC/BzlX9xdDObJggiZblE64A7gH5fOGfrAJdPfFnTM40EAP
        exB8+v1zWEWCuqV3NtP4dOqU4fIzEoH9Mtvvbg+AIZhsaQ4VS9tSK3gHEfuV5aIt
        7T2I/OS78patlSUadkSKdol9WgTfN36wXjqYAdD805epoTXvbX9ml9tk/O4ixOff
        PF7M8JqXB/RT5lEnJPCQ==
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t9qbx73hn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Sep 2023 17:16:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4006A100057;
        Thu, 28 Sep 2023 17:16:34 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3518124553E;
        Thu, 28 Sep 2023 17:16:34 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 28 Sep
 2023 17:16:31 +0200
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
Subject: [PATCH v3 07/12] net: ethernet: stm32: clean the way to manage wol irqwake
Date:   Thu, 28 Sep 2023 17:15:07 +0200
Message-ID: <20230928151512.322016-8-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230928151512.322016-1-christophe.roullier@foss.st.com>
References: <20230928151512.322016-1-christophe.roullier@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-28_14,2023-09-28_02,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe Roullier <christophe.roullier@st.com>

On STM32 platforms it is no longer needed to use a dedicated wakeup to
wake up system from CStop. This patch removes the dedicated wake up usage
and clean the way to register the wake up irq.

Signed-off-by: Christophe Roullier <christophe.roullier@foss.st.com>
---
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 64 +++++++++----------
 1 file changed, 31 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
index 1210062f0832a..72dda71850d75 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-stm32.c
@@ -81,7 +81,6 @@ struct stm32_dwmac {
 	int enable_eth_ck;
 	int eth_clk_sel_reg;
 	int eth_ref_clk_sel_reg;
-	int irq_pwr_wakeup;
 	u32 mode_reg;		 /* MAC glue-logic mode register */
 	u32 mode_mask;
 	struct regmap *regmap;
@@ -316,9 +315,7 @@ static int stm32_dwmac_parse_data(struct stm32_dwmac *dwmac,
 static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
 			       struct device *dev)
 {
-	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	int err = 0;
 
 	/* Ethernet PHY have no crystal */
 	dwmac->ext_phyclk = of_property_read_bool(np, "st,ext-phyclk");
@@ -350,29 +347,24 @@ static int stm32mp1_parse_data(struct stm32_dwmac *dwmac,
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
 	}
-	return err;
+
+	return 0;
 }
 
 static int stm32_dwmac_probe(struct platform_device *pdev)
@@ -410,11 +402,17 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
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
 
 	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
 	if (ret)
@@ -424,7 +422,11 @@ static int stm32_dwmac_probe(struct platform_device *pdev)
 
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
 
@@ -432,16 +434,12 @@ static void stm32_dwmac_remove(struct platform_device *pdev)
 {
 	struct net_device *ndev = platform_get_drvdata(pdev);
 	struct stmmac_priv *priv = netdev_priv(ndev);
-	struct stm32_dwmac *dwmac = priv->plat->bsp_priv;
 
 	stmmac_dvr_remove(&pdev->dev);
-
 	stm32_dwmac_clk_disable(priv->plat->bsp_priv);
 
-	if (dwmac->irq_pwr_wakeup >= 0) {
-		dev_pm_clear_wake_irq(&pdev->dev);
-		device_init_wakeup(&pdev->dev, false);
-	}
+	dev_pm_clear_wake_irq(&pdev->dev);
+	device_init_wakeup(&pdev->dev, false);
 }
 
 static int stm32mp1_suspend(struct stm32_dwmac *dwmac)
-- 
2.25.1

