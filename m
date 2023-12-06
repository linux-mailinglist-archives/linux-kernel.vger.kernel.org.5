Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA52807C3C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 00:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbjLFXRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 18:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379621AbjLFXRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 18:17:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 621D3B9
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 15:17:36 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62D5C433CC;
        Wed,  6 Dec 2023 23:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701904656;
        bh=ez5Rw+bekRSdPyYItpCuQMs/kNPSCZ2/f2QC2C+vegs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rpzfC/K6dhFTjJlt/mON4wKyI6v+Xpwv4qUmGPFRTzsvD4c4GQpyTN6d2voIu2i7b
         LGJ6YLVxTMAkGnXQ9DtQnWR7ea5jke4CIOMu99xS12c8OH0kQhvmWxI0d0PGXxy+aG
         eLr+i2/oxqYPsN7uRGNtvrev3y+0V0clIzkucA65r66c9Nd4Pdv2PciX3syjLBSIju
         fnUSj4+5/55nvtwp9nu6fHsfF/pX33U28F8aQG2hEP7r7oXAyGg/PbnCjkufv+FbPD
         4M2RvuowvPBbkYkHyICsmVQ83zd6y/l5LYfgx+3G2jN2tQolqxiwKnKpmsuWGOHLWY
         byCRsWieNnF9w==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Fei Shao <fshao@chromium.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/8] spmi: Use devm_spmi_controller_alloc()
Date:   Wed,  6 Dec 2023 15:17:27 -0800
Message-ID: <20231206231733.4031901-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
In-Reply-To: <20231206231733.4031901-1-sboyd@kernel.org>
References: <20231206231733.4031901-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fei Shao <fshao@chromium.org>

Convert to the device-managed version of spmi_controller_alloc() and
simplify the excess error handling code.

Signed-off-by: Fei Shao <fshao@chromium.org>
Link: https://lore.kernel.org/r/20230824104101.4083400-3-fshao@chromium.org
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/hisi-spmi-controller.c | 22 +++-----
 drivers/spmi/spmi-mtk-pmif.c        | 26 +++------
 drivers/spmi/spmi-pmic-arb.c        | 87 ++++++++++-------------------
 3 files changed, 46 insertions(+), 89 deletions(-)

diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-spmi-controller.c
index 9cbd473487cb..a5525902656a 100644
--- a/drivers/spmi/hisi-spmi-controller.c
+++ b/drivers/spmi/hisi-spmi-controller.c
@@ -267,10 +267,10 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	struct resource *iores;
 	int ret;
 
-	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*spmi_controller));
-	if (!ctrl) {
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*spmi_controller));
+	if (IS_ERR(ctrl)) {
 		dev_err(&pdev->dev, "can not allocate spmi_controller data\n");
-		return -ENOMEM;
+		return PTR_ERR(ctrl);
 	}
 	spmi_controller = spmi_controller_get_drvdata(ctrl);
 	spmi_controller->controller = ctrl;
@@ -278,24 +278,21 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	iores = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (!iores) {
 		dev_err(&pdev->dev, "can not get resource!\n");
-		ret = -EINVAL;
-		goto err_put_controller;
+		return -EINVAL;
 	}
 
 	spmi_controller->base = devm_ioremap(&pdev->dev, iores->start,
 					     resource_size(iores));
 	if (!spmi_controller->base) {
 		dev_err(&pdev->dev, "can not remap base addr!\n");
-		ret = -EADDRNOTAVAIL;
-		goto err_put_controller;
+		return -EADDRNOTAVAIL;
 	}
 
 	ret = of_property_read_u32(pdev->dev.of_node, "hisilicon,spmi-channel",
 				   &spmi_controller->channel);
 	if (ret) {
 		dev_err(&pdev->dev, "can not get channel\n");
-		ret = -ENODEV;
-		goto err_put_controller;
+		return -ENODEV;
 	}
 
 	platform_set_drvdata(pdev, spmi_controller);
@@ -314,14 +311,10 @@ static int spmi_controller_probe(struct platform_device *pdev)
 	ret = spmi_controller_add(ctrl);
 	if (ret) {
 		dev_err(&pdev->dev, "spmi_controller_add failed with error %d!\n", ret);
-		goto err_put_controller;
+		return ret;
 	}
 
 	return 0;
-
-err_put_controller:
-	spmi_controller_put(ctrl);
-	return ret;
 }
 
 static void spmi_del_controller(struct platform_device *pdev)
@@ -329,7 +322,6 @@ static void spmi_del_controller(struct platform_device *pdev)
 	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
 
 	spmi_controller_remove(ctrl);
-	spmi_controller_put(ctrl);
 }
 
 static const struct of_device_id spmi_controller_match_table[] = {
diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
index 1261f381cae6..6ebc6901490a 100644
--- a/drivers/spmi/spmi-mtk-pmif.c
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -447,29 +447,24 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	int err, i;
 	u32 chan_offset;
 
-	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*arb));
-	if (!ctrl)
-		return -ENOMEM;
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*arb));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
 	arb = spmi_controller_get_drvdata(ctrl);
 	arb->data = device_get_match_data(&pdev->dev);
 	if (!arb->data) {
-		err = -EINVAL;
 		dev_err(&pdev->dev, "Cannot get drv_data\n");
-		goto err_put_ctrl;
+		return -EINVAL;
 	}
 
 	arb->base = devm_platform_ioremap_resource_byname(pdev, "pmif");
-	if (IS_ERR(arb->base)) {
-		err = PTR_ERR(arb->base);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(arb->base))
+		return PTR_ERR(arb->base);
 
 	arb->spmimst_base = devm_platform_ioremap_resource_byname(pdev, "spmimst");
-	if (IS_ERR(arb->spmimst_base)) {
-		err = PTR_ERR(arb->spmimst_base);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(arb->spmimst_base))
+		return PTR_ERR(arb->spmimst_base);
 
 	arb->nclks = ARRAY_SIZE(pmif_clock_names);
 	for (i = 0; i < arb->nclks; i++)
@@ -478,7 +473,7 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	err = clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
-		goto err_put_ctrl;
+		return err;
 	}
 
 	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
@@ -512,8 +507,6 @@ static int mtk_spmi_probe(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
 err_put_clks:
 	clk_bulk_put(arb->nclks, arb->clks);
-err_put_ctrl:
-	spmi_controller_put(ctrl);
 	return err;
 }
 
@@ -525,7 +518,6 @@ static void mtk_spmi_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
 	clk_bulk_put(arb->nclks, arb->clks);
 	spmi_controller_remove(ctrl);
-	spmi_controller_put(ctrl);
 }
 
 static const struct of_device_id mtk_spmi_match_table[] = {
diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
index dcb675d980d4..9ed1180fe31f 100644
--- a/drivers/spmi/spmi-pmic-arb.c
+++ b/drivers/spmi/spmi-pmic-arb.c
@@ -1443,9 +1443,9 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	u32 channel, ee, hw_ver;
 	int err;
 
-	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*pmic_arb));
-	if (!ctrl)
-		return -ENOMEM;
+	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*pmic_arb));
+	if (IS_ERR(ctrl))
+		return PTR_ERR(ctrl);
 
 	pmic_arb = spmi_controller_get_drvdata(ctrl);
 	pmic_arb->spmic = ctrl;
@@ -1462,20 +1462,16 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	 */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
 	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
-	if (IS_ERR(core)) {
-		err = PTR_ERR(core);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(core))
+		return PTR_ERR(core);
 
 	pmic_arb->core_size = resource_size(res);
 
 	pmic_arb->ppid_to_apid = devm_kcalloc(&ctrl->dev, PMIC_ARB_MAX_PPID,
 					      sizeof(*pmic_arb->ppid_to_apid),
 					      GFP_KERNEL);
-	if (!pmic_arb->ppid_to_apid) {
-		err = -ENOMEM;
-		goto err_put_ctrl;
-	}
+	if (!pmic_arb->ppid_to_apid)
+		return -ENOMEM;
 
 	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
 
@@ -1499,19 +1495,15 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 						   "obsrvr");
 		pmic_arb->rd_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->rd_base)) {
-			err = PTR_ERR(pmic_arb->rd_base);
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(pmic_arb->rd_base))
+			return PTR_ERR(pmic_arb->rd_base);
 
 		res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
 						   "chnls");
 		pmic_arb->wr_base = devm_ioremap(&ctrl->dev, res->start,
 						 resource_size(res));
-		if (IS_ERR(pmic_arb->wr_base)) {
-			err = PTR_ERR(pmic_arb->wr_base);
-			goto err_put_ctrl;
-		}
+		if (IS_ERR(pmic_arb->wr_base))
+			return PTR_ERR(pmic_arb->wr_base);
 	}
 
 	pmic_arb->max_periphs = PMIC_ARB_MAX_PERIPHS;
@@ -1522,10 +1514,9 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		of_property_read_u32(pdev->dev.of_node, "qcom,bus-id",
 					&pmic_arb->bus_instance);
 		if (pmic_arb->bus_instance > 1) {
-			err = -EINVAL;
 			dev_err(&pdev->dev, "invalid bus instance (%u) specified\n",
 				pmic_arb->bus_instance);
-			goto err_put_ctrl;
+			return -EINVAL;
 		}
 
 		if (pmic_arb->bus_instance == 0) {
@@ -1543,10 +1534,9 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		}
 
 		if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
-			err = -EINVAL;
 			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
 				pmic_arb->base_apid + pmic_arb->apid_count);
-			goto err_put_ctrl;
+			return -EINVAL;
 		}
 	} else if (hw_ver >= PMIC_ARB_VERSION_V5_MIN) {
 		pmic_arb->base_apid = 0;
@@ -1554,55 +1544,45 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 					PMIC_ARB_FEATURES_PERIPH_MASK;
 
 		if (pmic_arb->apid_count > pmic_arb->max_periphs) {
-			err = -EINVAL;
 			dev_err(&pdev->dev, "Unsupported APID count %d detected\n",
 				pmic_arb->apid_count);
-			goto err_put_ctrl;
+			return -EINVAL;
 		}
 	}
 
 	pmic_arb->apid_data = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
 					   sizeof(*pmic_arb->apid_data),
 					   GFP_KERNEL);
-	if (!pmic_arb->apid_data) {
-		err = -ENOMEM;
-		goto err_put_ctrl;
-	}
+	if (!pmic_arb->apid_data)
+		return -ENOMEM;
 
 	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
 		 pmic_arb->ver_ops->ver_str, hw_ver);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
 	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->intr)) {
-		err = PTR_ERR(pmic_arb->intr);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(pmic_arb->intr))
+		return PTR_ERR(pmic_arb->intr);
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cnfg");
 	pmic_arb->cnfg = devm_ioremap_resource(&ctrl->dev, res);
-	if (IS_ERR(pmic_arb->cnfg)) {
-		err = PTR_ERR(pmic_arb->cnfg);
-		goto err_put_ctrl;
-	}
+	if (IS_ERR(pmic_arb->cnfg))
+		return PTR_ERR(pmic_arb->cnfg);
 
 	pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
-	if (pmic_arb->irq < 0) {
-		err = pmic_arb->irq;
-		goto err_put_ctrl;
-	}
+	if (pmic_arb->irq < 0)
+		return pmic_arb->irq;
 
 	err = of_property_read_u32(pdev->dev.of_node, "qcom,channel", &channel);
 	if (err) {
 		dev_err(&pdev->dev, "channel unspecified.\n");
-		goto err_put_ctrl;
+		return err;
 	}
 
 	if (channel > 5) {
 		dev_err(&pdev->dev, "invalid channel (%u) specified.\n",
 			channel);
-		err = -EINVAL;
-		goto err_put_ctrl;
+		return -EINVAL;
 	}
 
 	pmic_arb->channel = channel;
@@ -1610,22 +1590,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 	err = of_property_read_u32(pdev->dev.of_node, "qcom,ee", &ee);
 	if (err) {
 		dev_err(&pdev->dev, "EE unspecified.\n");
-		goto err_put_ctrl;
+		return err;
 	}
 
 	if (ee > 5) {
 		dev_err(&pdev->dev, "invalid EE (%u) specified\n", ee);
-		err = -EINVAL;
-		goto err_put_ctrl;
+		return -EINVAL;
 	}
 
 	pmic_arb->ee = ee;
 	mapping_table = devm_kcalloc(&ctrl->dev, pmic_arb->max_periphs,
 					sizeof(*mapping_table), GFP_KERNEL);
-	if (!mapping_table) {
-		err = -ENOMEM;
-		goto err_put_ctrl;
-	}
+	if (!mapping_table)
+		return -ENOMEM;
 
 	pmic_arb->mapping_table = mapping_table;
 	/* Initialize max_apid/min_apid to the opposite bounds, during
@@ -1645,7 +1622,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 		if (err) {
 			dev_err(&pdev->dev, "could not read APID->PPID mapping table, rc= %d\n",
 				err);
-			goto err_put_ctrl;
+			return err;
 		}
 	}
 
@@ -1654,8 +1631,7 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 					 &pmic_arb_irq_domain_ops, pmic_arb);
 	if (!pmic_arb->domain) {
 		dev_err(&pdev->dev, "unable to create irq_domain\n");
-		err = -ENOMEM;
-		goto err_put_ctrl;
+		return -ENOMEM;
 	}
 
 	irq_set_chained_handler_and_data(pmic_arb->irq, pmic_arb_chained_irq,
@@ -1669,8 +1645,6 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
 err_domain_remove:
 	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
 	irq_domain_remove(pmic_arb->domain);
-err_put_ctrl:
-	spmi_controller_put(ctrl);
 	return err;
 }
 
@@ -1681,7 +1655,6 @@ static void spmi_pmic_arb_remove(struct platform_device *pdev)
 	spmi_controller_remove(ctrl);
 	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
 	irq_domain_remove(pmic_arb->domain);
-	spmi_controller_put(ctrl);
 }
 
 static const struct of_device_id spmi_pmic_arb_match_table[] = {
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

