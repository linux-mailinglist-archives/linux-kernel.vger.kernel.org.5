Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462E7BEC78
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 23:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378667AbjJIVOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 17:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378652AbjJIVOO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 17:14:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DB6392;
        Mon,  9 Oct 2023 14:14:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57DD6C433C8;
        Mon,  9 Oct 2023 21:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696886052;
        bh=i4X/vNFkCjPk4yHPDzSDoFpjb66LQuRc1sygQ/O3xKM=;
        h=From:To:Cc:Subject:Date:From;
        b=CWIri7A6oxBeh3cQs4ZB5m0ts1YQvjE5P9iz31i0NipnWDBTs7+naZtGVs65xxfkl
         kgpZL2e0OX3vuBf17HFaK1XPJEjDnx3Ozn2ApWwGs/eeWs4azGMEuBBo4iWEN+BurE
         X9+/s974r6WMrtu+ckgRIGvIcofTS8g2B2aMC9+VnFTdZTsntHH1tVrNhBXgybZ0o7
         upVTLfCaAwkj3MMNcz8+yzCJfJEwgvYfERDgyTRU2LdKHjyIC9oD8yxMGJL4N52EZi
         fQWJH3ETj1Jlk0woqkHXUKsVGLnIifv3gQJV5MV3G3AevO2IWGp0IrZl5++rDEavUr
         fX7VpxSmKpxYw==
Received: (nullmailer pid 3245330 invoked by uid 1000);
        Mon, 09 Oct 2023 21:14:08 -0000
From:   Rob Herring <robh@kernel.org>
To:     Lee Jones <lee@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org
Subject: [PATCH] mfd: Use device_get_match_data()
Date:   Mon,  9 Oct 2023 16:13:33 -0500
Message-ID: <20231009211356.3242037-3-robh@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/mfd/axp20x.c           | 22 +++-------------------
 drivers/mfd/hi6421-pmic-core.c |  9 +++------
 drivers/mfd/mxs-lradc.c        |  9 ++-------
 drivers/mfd/qcom-spmi-pmic.c   |  6 ++++--
 drivers/mfd/qcom_rpm.c         |  8 ++++----
 drivers/mfd/tps65910.c         | 11 ++---------
 drivers/mfd/twl4030-power.c    |  9 +++------
 drivers/mfd/twl6030-irq.c      | 10 +++++-----
 8 files changed, 26 insertions(+), 58 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index d93189b0230d..deaa969bab4e 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -22,7 +22,8 @@
 #include <linux/mfd/axp20x.h>
 #include <linux/mfd/core.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/property.h>
 #include <linux/reboot.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
@@ -1131,27 +1132,10 @@ static int axp20x_power_off(struct sys_off_data *data)
 int axp20x_match_device(struct axp20x_dev *axp20x)
 {
 	struct device *dev = axp20x->dev;
-	const struct acpi_device_id *acpi_id;
-	const struct of_device_id *of_id;
 	const struct mfd_cell *cells_no_irq = NULL;
 	int nr_cells_no_irq = 0;
 
-	if (dev->of_node) {
-		of_id = of_match_device(dev->driver->of_match_table, dev);
-		if (!of_id) {
-			dev_err(dev, "Unable to match OF ID\n");
-			return -ENODEV;
-		}
-		axp20x->variant = (long)of_id->data;
-	} else {
-		acpi_id = acpi_match_device(dev->driver->acpi_match_table, dev);
-		if (!acpi_id || !acpi_id->driver_data) {
-			dev_err(dev, "Unable to match ACPI ID and data\n");
-			return -ENODEV;
-		}
-		axp20x->variant = (long)acpi_id->driver_data;
-	}
-
+	axp20x->variant = (long)device_get_match_data(dev);
 	switch (axp20x->variant) {
 	case AXP152_ID:
 		axp20x->nr_cells = ARRAY_SIZE(axp152_cells);
diff --git a/drivers/mfd/hi6421-pmic-core.c b/drivers/mfd/hi6421-pmic-core.c
index a6a890537a1e..5af24a438329 100644
--- a/drivers/mfd/hi6421-pmic-core.c
+++ b/drivers/mfd/hi6421-pmic-core.c
@@ -15,8 +15,9 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/hi6421-pmic.h>
 #include <linux/module.h>
-#include <linux/of_device.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 
 static const struct mfd_cell hi6421_devs[] = {
@@ -50,16 +51,12 @@ MODULE_DEVICE_TABLE(of, of_hi6421_pmic_match);
 static int hi6421_pmic_probe(struct platform_device *pdev)
 {
 	struct hi6421_pmic *pmic;
-	const struct of_device_id *id;
 	const struct mfd_cell *subdevs;
 	enum hi6421_type type;
 	void __iomem *base;
 	int n_subdevs, ret;
 
-	id = of_match_device(of_hi6421_pmic_match, &pdev->dev);
-	if (!id)
-		return -EINVAL;
-	type = (uintptr_t)id->data;
+	type = (uintptr_t)device_get_match_data(&pdev->dev);
 
 	pmic = devm_kzalloc(&pdev->dev, sizeof(*pmic), GFP_KERNEL);
 	if (!pmic)
diff --git a/drivers/mfd/mxs-lradc.c b/drivers/mfd/mxs-lradc.c
index 21f3033d6eb5..ec1b356562b9 100644
--- a/drivers/mfd/mxs-lradc.c
+++ b/drivers/mfd/mxs-lradc.c
@@ -16,8 +16,8 @@
 #include <linux/mfd/mxs-lradc.h>
 #include <linux/module.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/slab.h>
 
 #define ADC_CELL		0
@@ -125,7 +125,6 @@ MODULE_DEVICE_TABLE(of, mxs_lradc_dt_ids);
 
 static int mxs_lradc_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *of_id;
 	struct device *dev = &pdev->dev;
 	struct device_node *node = dev->of_node;
 	struct mxs_lradc *lradc;
@@ -138,11 +137,7 @@ static int mxs_lradc_probe(struct platform_device *pdev)
 	if (!lradc)
 		return -ENOMEM;
 
-	of_id = of_match_device(mxs_lradc_dt_ids, &pdev->dev);
-	if (!of_id)
-		return -EINVAL;
-
-	lradc->soc = (uintptr_t)of_id->data;
+	lradc->soc = (enum mxs_lradc_id)device_get_match_data(&pdev->dev);
 
 	lradc->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(lradc->clk)) {
diff --git a/drivers/mfd/qcom-spmi-pmic.c b/drivers/mfd/qcom-spmi-pmic.c
index 7e2cd79d17eb..4899af64bf10 100644
--- a/drivers/mfd/qcom-spmi-pmic.c
+++ b/drivers/mfd/qcom-spmi-pmic.c
@@ -8,10 +8,12 @@
 #include <linux/gfp.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/spmi.h>
 #include <linux/types.h>
 #include <linux/regmap.h>
-#include <linux/of_platform.h>
 #include <soc/qcom/qcom-spmi-pmic.h>
 
 #define PMIC_REV2		0x101
@@ -236,7 +238,7 @@ static int pmic_spmi_probe(struct spmi_device *sdev)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->num_usids = (uintptr_t)of_device_get_match_data(&sdev->dev);
+	ctx->num_usids = (uintptr_t)device_get_match_data(&sdev->dev);
 
 	/* Only the first slave id for a PMIC contains this information */
 	if (sdev->usid % ctx->num_usids == 0) {
diff --git a/drivers/mfd/qcom_rpm.c b/drivers/mfd/qcom_rpm.c
index 086611322874..27446f43e3f3 100644
--- a/drivers/mfd/qcom_rpm.c
+++ b/drivers/mfd/qcom_rpm.c
@@ -7,6 +7,8 @@
 
 #include <linux/module.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/io.h>
 #include <linux/interrupt.h>
@@ -528,7 +530,6 @@ static irqreturn_t qcom_rpm_wakeup_interrupt(int irq, void *dev)
 
 static int qcom_rpm_probe(struct platform_device *pdev)
 {
-	const struct of_device_id *match;
 	struct device_node *syscon_np;
 	struct qcom_rpm *rpm;
 	u32 fw_version[3];
@@ -570,10 +571,9 @@ static int qcom_rpm_probe(struct platform_device *pdev)
 	if (irq_wakeup < 0)
 		return irq_wakeup;
 
-	match = of_match_device(qcom_rpm_of_match, &pdev->dev);
-	if (!match)
+	rpm->data = device_get_match_data(&pdev->dev);
+	if (!rpm->data)
 		return -ENODEV;
-	rpm->data = match->data;
 
 	rpm->status_regs = devm_platform_get_and_ioremap_resource(pdev, 0, NULL);
 	if (IS_ERR(rpm->status_regs))
diff --git a/drivers/mfd/tps65910.c b/drivers/mfd/tps65910.c
index 41408df1712f..dce6ad668dbf 100644
--- a/drivers/mfd/tps65910.c
+++ b/drivers/mfd/tps65910.c
@@ -19,7 +19,7 @@
 #include <linux/regmap.h>
 #include <linux/mfd/tps65910.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
+#include <linux/property.h>
 
 static const struct resource rtc_resources[] = {
 	{
@@ -374,16 +374,9 @@ static struct tps65910_board *tps65910_parse_dt(struct i2c_client *client,
 	struct device_node *np = client->dev.of_node;
 	struct tps65910_board *board_info;
 	unsigned int prop;
-	const struct of_device_id *match;
 	int ret;
 
-	match = of_match_device(tps65910_of_match, &client->dev);
-	if (!match) {
-		dev_err(&client->dev, "Failed to find matching dt id\n");
-		return NULL;
-	}
-
-	*chip_id  = (unsigned long)match->data;
+	*chip_id  = (unsigned long)device_get_match_data(&client->dev);
 
 	board_info = devm_kzalloc(&client->dev, sizeof(*board_info),
 			GFP_KERNEL);
diff --git a/drivers/mfd/twl4030-power.c b/drivers/mfd/twl4030-power.c
index e35b0f788c50..1595e9c76132 100644
--- a/drivers/mfd/twl4030-power.c
+++ b/drivers/mfd/twl4030-power.c
@@ -27,8 +27,8 @@
 #include <linux/pm.h>
 #include <linux/mfd/twl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/of.h>
-#include <linux/of_device.h>
 
 #include <asm/mach-types.h>
 
@@ -883,7 +883,6 @@ static int twl4030_power_probe(struct platform_device *pdev)
 {
 	const struct twl4030_power_data *pdata = dev_get_platdata(&pdev->dev);
 	struct device_node *node = pdev->dev.of_node;
-	const struct of_device_id *match;
 	int err = 0;
 	int err2 = 0;
 	u8 val;
@@ -904,10 +903,8 @@ static int twl4030_power_probe(struct platform_device *pdev)
 		return err;
 	}
 
-	match = of_match_device(of_match_ptr(twl4030_power_of_match),
-				&pdev->dev);
-	if (match && match->data)
-		pdata = match->data;
+	if (node)
+		pdata = device_get_match_data(&pdev->dev);
 
 	if (pdata) {
 		err = twl4030_power_configure_scripts(pdata);
diff --git a/drivers/mfd/twl6030-irq.c b/drivers/mfd/twl6030-irq.c
index 3c03681c124c..f9fce8408c2c 100644
--- a/drivers/mfd/twl6030-irq.c
+++ b/drivers/mfd/twl6030-irq.c
@@ -24,10 +24,10 @@
 #include <linux/kthread.h>
 #include <linux/mfd/twl.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/suspend.h>
 #include <linux/of.h>
 #include <linux/irqdomain.h>
-#include <linux/of_device.h>
 
 #include "twl-core.h"
 
@@ -368,10 +368,10 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 	int			nr_irqs;
 	int			status;
 	u8			mask[3];
-	const struct of_device_id *of_id;
+	const int		*irq_tbl;
 
-	of_id = of_match_device(twl6030_of_match, dev);
-	if (!of_id || !of_id->data) {
+	irq_tbl = device_get_match_data(dev);
+	if (!irq_tbl) {
 		dev_err(dev, "Unknown TWL device model\n");
 		return -EINVAL;
 	}
@@ -409,7 +409,7 @@ int twl6030_init_irq(struct device *dev, int irq_num)
 
 	twl6030_irq->pm_nb.notifier_call = twl6030_irq_pm_notifier;
 	atomic_set(&twl6030_irq->wakeirqs, 0);
-	twl6030_irq->irq_mapping_tbl = of_id->data;
+	twl6030_irq->irq_mapping_tbl = irq_tbl;
 
 	twl6030_irq->irq_domain =
 		irq_domain_add_linear(node, nr_irqs,
-- 
2.42.0

