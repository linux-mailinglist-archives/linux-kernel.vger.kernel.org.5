Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDC77D8FD4
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345502AbjJ0HaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345500AbjJ0HaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:30:15 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8788D1B9;
        Fri, 27 Oct 2023 00:30:11 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C93F143D;
        Fri, 27 Oct 2023 00:30:52 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.32.209])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 977643F762;
        Fri, 27 Oct 2023 00:30:06 -0700 (PDT)
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
Subject: [PATCH 3/7] coresight: catu: Move ACPI support from AMBA driver to platform driver
Date:   Fri, 27 Oct 2023 12:59:39 +0530
Message-Id: <20231027072943.3418997-4-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231027072943.3418997-1-anshuman.khandual@arm.com>
References: <20231027072943.3418997-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the catu devices in a new platform driver, which can then
be used on ACPI based platforms. This change would now allow runtime power
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
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/arm64/amba.c                    |   1 -
 drivers/hwtracing/coresight/coresight-catu.c | 136 +++++++++++++++++--
 drivers/hwtracing/coresight/coresight-catu.h |   1 +
 3 files changed, 122 insertions(+), 16 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 18aa41d91729..56a7e020555b 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
 	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
-	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 3949ded0d4fa..edac43f769ae 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -7,6 +7,8 @@
  * Author: Suzuki K Poulose <suzuki.poulose@arm.com>
  */
 
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/amba/bus.h>
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
@@ -502,28 +504,20 @@ static const struct coresight_ops catu_ops = {
 	.helper_ops = &catu_helper_ops,
 };
 
-static int catu_probe(struct amba_device *adev, const struct amba_id *id)
+static int __catu_probe(struct device *dev, struct resource *res)
 {
 	int ret = 0;
 	u32 dma_mask;
-	struct catu_drvdata *drvdata;
+	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
 	struct coresight_desc catu_desc;
 	struct coresight_platform_data *pdata = NULL;
-	struct device *dev = &adev->dev;
 	void __iomem *base;
 
 	catu_desc.name = coresight_alloc_device_name(&catu_devs, dev);
 	if (!catu_desc.name)
 		return -ENOMEM;
 
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata) {
-		ret = -ENOMEM;
-		goto out;
-	}
-
-	dev_set_drvdata(dev, drvdata);
-	base = devm_ioremap_resource(dev, &adev->res);
+	base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(base)) {
 		ret = PTR_ERR(base);
 		goto out;
@@ -568,18 +562,35 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(drvdata->csdev))
 		ret = PTR_ERR(drvdata->csdev);
 	else
-		pm_runtime_put(&adev->dev);
+		pm_runtime_put(dev);
 out:
 	return ret;
 }
 
-static void catu_remove(struct amba_device *adev)
+static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct catu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct catu_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	amba_set_drvdata(adev, drvdata);
+	return __catu_probe(&adev->dev, &adev->res);
+}
+
+static void __catu_remove(struct device *dev)
+{
+	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_unregister(drvdata->csdev);
 }
 
+static void catu_remove(struct amba_device *adev)
+{
+	__catu_remove(&adev->dev);
+}
+
 static struct amba_id catu_ids[] = {
 	CS_AMBA_ID(0x000bb9ee),
 	{},
@@ -598,13 +609,107 @@ static struct amba_driver catu_driver = {
 	.id_table			= catu_ids,
 };
 
+static int catu_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct catu_drvdata *drvdata;
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
+	if (res) {
+		drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(drvdata->base)) {
+			clk_put(drvdata->pclk);
+			return PTR_ERR(drvdata->base);
+		}
+	}
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	dev_set_drvdata(&pdev->dev, drvdata);
+	ret = __catu_probe(&pdev->dev, res);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+	return ret;
+}
+
+static int catu_platform_remove(struct platform_device *pdev)
+{
+	__catu_remove(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int catu_runtime_suspend(struct device *dev)
+{
+	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata->pclk && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+	return 0;
+}
+
+static int catu_runtime_resume(struct device *dev)
+{
+	struct catu_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata->pclk && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops catu_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(catu_runtime_suspend, catu_runtime_resume, NULL)
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id catu_acpi_ids[] = {
+	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
+	{},
+};
+
+MODULE_DEVICE_TABLE(acpi, catu_platform_acpi_ids);
+#endif
+
+static struct platform_driver catu_platform_driver = {
+	.probe	= catu_platform_probe,
+	.remove	= catu_platform_remove,
+	.driver	= {
+		.name			= "coresight-catu-platform",
+		.acpi_match_table	= ACPI_PTR(catu_acpi_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &catu_dev_pm_ops,
+	},
+};
+
 static int __init catu_init(void)
 {
 	int ret;
 
+	ret = platform_driver_register(&catu_platform_driver);
+	if (ret) {
+		pr_info("Error registering platform driver\n");
+		return ret;
+	}
+
 	ret = amba_driver_register(&catu_driver);
-	if (ret)
+	if (ret) {
 		pr_info("Error registering catu driver\n");
+		platform_driver_unregister(&catu_platform_driver);
+	}
+
 	tmc_etr_set_catu_ops(&etr_catu_buf_ops);
 	return ret;
 }
@@ -613,6 +718,7 @@ static void __exit catu_exit(void)
 {
 	tmc_etr_remove_catu_ops();
 	amba_driver_unregister(&catu_driver);
+	platform_driver_unregister(&catu_platform_driver);
 }
 
 module_init(catu_init);
diff --git a/drivers/hwtracing/coresight/coresight-catu.h b/drivers/hwtracing/coresight/coresight-catu.h
index 442e034bbfba..141feac1c14b 100644
--- a/drivers/hwtracing/coresight/coresight-catu.h
+++ b/drivers/hwtracing/coresight/coresight-catu.h
@@ -61,6 +61,7 @@
 #define CATU_IRQEN_OFF		0x0
 
 struct catu_drvdata {
+	struct clk *pclk;
 	void __iomem *base;
 	struct coresight_device *csdev;
 	int irq;
-- 
2.25.1

