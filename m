Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062BC809BD7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235761AbjLHFlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:41:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLHFkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:40:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 422BB19A2;
        Thu,  7 Dec 2023 21:40:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C54C41063;
        Thu,  7 Dec 2023 21:41:16 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CE43B3F5A1;
        Thu,  7 Dec 2023 21:40:26 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V3 08/10] coresight: tmc: Move ACPI support from AMBA driver to platform driver
Date:   Fri,  8 Dec 2023 11:09:37 +0530
Message-Id: <20231208053939.42901-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231208053939.42901-1-anshuman.khandual@arm.com>
References: <20231208053939.42901-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the tmc devices in the platform driver, which can then be
used on ACPI based platforms. This change would now allow runtime power
management for ACPI based systems. The driver would try to enable the APB
clock if available.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Tested-by: Sudeep Holla <sudeep.holla@arm.com> # Boot and driver probe only
Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V3:

- Added commnets for 'drvdata->pclk'
- Used coresight_init_driver()/coresight_remove_driver() helpers instead
- Dropped pm_runtime_put() from __tmc_probe()
- Added pm_runtime_put() on success path in tmc_probe()
- Added pm_runtime_put() on success/error paths in tmc_platform_probe()
- Check for drvdata instead of drvdata->pclk in suspend and resume paths

 drivers/acpi/arm64/amba.c                     |   2 -
 .../hwtracing/coresight/coresight-tmc-core.c  | 137 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 3 files changed, 124 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 6d24a8f7914b..d3c1defa7bc8 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -22,10 +22,8 @@
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
 	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
-	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
-	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index ad61d02f5f75..8482830d73ef 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -23,6 +23,8 @@
 #include <linux/of.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
@@ -437,24 +439,17 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
 	return burst_size;
 }
 
-static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
+static int __tmc_probe(struct device *dev, struct resource *res, void *dev_caps)
 {
 	int ret = 0;
 	u32 devid;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
-	struct tmc_drvdata *drvdata;
-	struct resource *res = &adev->res;
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 	struct coresight_desc desc = { 0 };
 	struct coresight_dev_list *dev_list = NULL;
 
 	ret = -ENOMEM;
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		goto out;
-
-	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
@@ -523,7 +518,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto out;
 	}
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 	desc.pdata = pdata;
 
 	drvdata->csdev = coresight_register(&desc);
@@ -541,12 +536,27 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	ret = misc_register(&drvdata->miscdev);
 	if (ret)
 		coresight_unregister(drvdata->csdev);
-	else
-		pm_runtime_put(&adev->dev);
 out:
 	return ret;
 }
 
+static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct tmc_drvdata *drvdata;
+	int ret;
+
+	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	amba_set_drvdata(adev, drvdata);
+	ret = __tmc_probe(&adev->dev, &adev->res, coresight_get_uci_data(id));
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static void tmc_shutdown(struct amba_device *adev)
 {
 	unsigned long flags;
@@ -569,9 +579,9 @@ static void tmc_shutdown(struct amba_device *adev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
-static void tmc_remove(struct amba_device *adev)
+static void __tmc_remove(struct device *dev)
 {
-	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
 	/*
 	 * Since misc_open() holds a refcount on the f_ops, which is
@@ -582,6 +592,11 @@ static void tmc_remove(struct amba_device *adev)
 	coresight_unregister(drvdata->csdev);
 }
 
+static void tmc_remove(struct amba_device *adev)
+{
+	__tmc_remove(&adev->dev);
+}
+
 static const struct amba_id tmc_ids[] = {
 	CS_AMBA_ID(0x000bb961),
 	/* Coresight SoC 600 TMC-ETR/ETS */
@@ -607,7 +622,99 @@ static struct amba_driver tmc_driver = {
 	.id_table	= tmc_ids,
 };
 
-module_amba_driver(tmc_driver);
+static int tmc_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct tmc_drvdata *drvdata;
+	int ret = 0;
+
+	drvdata = devm_kzalloc(&pdev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	drvdata->pclk = coresight_get_enable_apb_pclk(&pdev->dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
+	dev_set_drvdata(&pdev->dev, drvdata);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = __tmc_probe(&pdev->dev, res, NULL);
+	pm_runtime_put(&pdev->dev);
+
+	return ret;
+}
+
+static int tmc_platform_remove(struct platform_device *pdev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		__tmc_remove(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tmc_runtime_suspend(struct device *dev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+	return 0;
+}
+
+static int tmc_runtime_resume(struct device *dev)
+{
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops tmc_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(tmc_runtime_suspend, tmc_runtime_resume, NULL)
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tmc_acpi_ids[] = {
+	{"ARMHC501", 0}, /* ARM CoreSight ETR */
+	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, tmc_acpi_ids);
+#endif
+
+static struct platform_driver tmc_platform_driver = {
+	.probe	= tmc_platform_probe,
+	.remove	= tmc_platform_remove,
+	.driver	= {
+		.name			= "coresight-tmc-platform",
+		.acpi_match_table	= ACPI_PTR(tmc_acpi_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &tmc_dev_pm_ops,
+	},
+};
+
+static int __init tmc_init(void)
+{
+	return coresight_init_driver("tmc", &tmc_driver, &tmc_platform_driver);
+}
+
+static void __exit tmc_exit(void)
+{
+	coresight_remove_driver(&tmc_driver, &tmc_platform_driver);
+}
+module_init(tmc_init);
+module_exit(tmc_exit);
 
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_DESCRIPTION("Arm CoreSight Trace Memory Controller driver");
diff --git a/drivers/hwtracing/coresight/coresight-tmc.h b/drivers/hwtracing/coresight/coresight-tmc.h
index 0ee48c5ba764..072befcf21cf 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -165,6 +165,7 @@ struct etr_buf {
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
+ * @pclk:	APB clock if present, otherwise NULL
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
@@ -189,6 +190,7 @@ struct etr_buf {
  * @perf_buf:	PERF buffer for ETR.
  */
 struct tmc_drvdata {
+	struct clk		*pclk;
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
-- 
2.25.1

