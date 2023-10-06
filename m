Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5238E7BC248
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 00:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjJFWoJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 18:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233726AbjJFWoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 18:44:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC9C3A2
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 15:44:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 840CEC433C8;
        Fri,  6 Oct 2023 22:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696632246;
        bh=dnirAMJtell24Xii/tGE5TPebFmYLUGZvNx2LSkG0CE=;
        h=From:To:Cc:Subject:Date:From;
        b=L1shalJmrPTSFqzG8WwKnc2FFJ5EbudW62Hyu9km14/lsK/LDkhVfPgd/iObyRi7C
         pcxIGgNp4xeJyeSC4SWg6Ii94FsPueKK5AStZqHXan4NuMWU3IOJFroY0kM9RpvLnL
         +VrYLSJskkPXsGq2HBEBvRkba9nRwWoCA5AAU3RKwhGzMTwWzWqk8UM+aruNjSO5zA
         hLV1orJTpKHq+IDn8DpZBSnZvb50hDG54NFnTgYMdvmkemMyk2f5bLmp42/WvZvzP8
         mW+G1oeZX6yK8QTNOPOspnLBuYNvbWx8E0H816749AwlJKTveATWaWqsKKQ46YINj5
         lr39oKS6BPTyw==
Received: (nullmailer pid 442177 invoked by uid 1000);
        Fri, 06 Oct 2023 22:44:04 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] memory: Use device_get_match_data()
Date:   Fri,  6 Oct 2023 17:44:01 -0500
Message-Id: <20231006224402.442078-1-robh@kernel.org>
X-Mailer: git-send-email 2.40.1
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
 drivers/memory/atmel-ebi.c      | 14 +++++++-------
 drivers/memory/brcmstb_memc.c   |  9 +++------
 drivers/memory/fsl-corenet-cf.c | 11 ++---------
 3 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/memory/atmel-ebi.c b/drivers/memory/atmel-ebi.c
index ec6100bc94c5..e8bb5f37f5cb 100644
--- a/drivers/memory/atmel-ebi.c
+++ b/drivers/memory/atmel-ebi.c
@@ -12,7 +12,10 @@
 #include <linux/mfd/syscon/atmel-matrix.h>
 #include <linux/mfd/syscon/atmel-smc.h>
 #include <linux/init.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <soc/at91/atmel-sfr.h>
 
@@ -515,16 +518,11 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct device_node *child, *np = dev->of_node, *smc_np;
-	const struct of_device_id *match;
 	struct atmel_ebi *ebi;
 	int ret, reg_cells;
 	struct clk *clk;
 	u32 val;
 
-	match = of_match_device(atmel_ebi_id_table, dev);
-	if (!match || !match->data)
-		return -EINVAL;
-
 	ebi = devm_kzalloc(dev, sizeof(*ebi), GFP_KERNEL);
 	if (!ebi)
 		return -ENOMEM;
@@ -532,7 +530,9 @@ static int atmel_ebi_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, ebi);
 
 	INIT_LIST_HEAD(&ebi->devs);
-	ebi->caps = match->data;
+	ebi->caps = device_get_match_data(dev);
+	if (!ebi->caps)
+		return -EINVAL;
 	ebi->dev = dev;
 
 	clk = devm_clk_get(dev, NULL);
diff --git a/drivers/memory/brcmstb_memc.c b/drivers/memory/brcmstb_memc.c
index 233a53f5bce1..a6ea51996522 100644
--- a/drivers/memory/brcmstb_memc.c
+++ b/drivers/memory/brcmstb_memc.c
@@ -8,8 +8,9 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 #define REG_MEMC_CNTRLR_CONFIG		0x00
 #define  CNTRLR_CONFIG_LPDDR4_SHIFT	5
@@ -121,12 +122,9 @@ static struct attribute_group dev_attr_group = {
 	.attrs = dev_attrs,
 };
 
-static const struct of_device_id brcmstb_memc_of_match[];
-
 static int brcmstb_memc_probe(struct platform_device *pdev)
 {
 	const struct brcmstb_memc_data *memc_data;
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct brcmstb_memc *memc;
 	int ret;
@@ -137,8 +135,7 @@ static int brcmstb_memc_probe(struct platform_device *pdev)
 
 	dev_set_drvdata(dev, memc);
 
-	of_id = of_match_device(brcmstb_memc_of_match, dev);
-	memc_data = of_id->data;
+	memc_data = device_get_match_data(dev);
 	memc->srpd_offset = memc_data->srpd_offset;
 
 	memc->ddr_ctrl = devm_platform_ioremap_resource(pdev, 0);
diff --git a/drivers/memory/fsl-corenet-cf.c b/drivers/memory/fsl-corenet-cf.c
index 7fc9f57ae278..8096c4f33303 100644
--- a/drivers/memory/fsl-corenet-cf.c
+++ b/drivers/memory/fsl-corenet-cf.c
@@ -10,10 +10,8 @@
 #include <linux/irq.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
-#include <linux/of_irq.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 
 enum ccf_version {
 	CCF1,
@@ -172,14 +170,9 @@ static irqreturn_t ccf_irq(int irq, void *dev_id)
 static int ccf_probe(struct platform_device *pdev)
 {
 	struct ccf_private *ccf;
-	const struct of_device_id *match;
 	u32 errinten;
 	int ret, irq;
 
-	match = of_match_device(ccf_matches, &pdev->dev);
-	if (WARN_ON(!match))
-		return -ENODEV;
-
 	ccf = devm_kzalloc(&pdev->dev, sizeof(*ccf), GFP_KERNEL);
 	if (!ccf)
 		return -ENOMEM;
@@ -189,7 +182,7 @@ static int ccf_probe(struct platform_device *pdev)
 		return PTR_ERR(ccf->regs);
 
 	ccf->dev = &pdev->dev;
-	ccf->info = match->data;
+	ccf->info = device_get_match_data(&pdev->dev);
 	ccf->err_regs = ccf->regs + ccf->info->err_reg_offs;
 
 	if (ccf->info->has_brr) {
-- 
2.40.1

