Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E30C809BD5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbjLHFkh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:40:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235701AbjLHFkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:40:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ED4E173A;
        Thu,  7 Dec 2023 21:40:17 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8DFAE1063;
        Thu,  7 Dec 2023 21:41:02 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.41.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 93B333F5A1;
        Thu,  7 Dec 2023 21:40:12 -0800 (PST)
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
Subject: [PATCH V3 05/10] coresight: funnel: Move ACPI support from AMBA driver to platform driver
Date:   Fri,  8 Dec 2023 11:09:34 +0530
Message-Id: <20231208053939.42901-6-anshuman.khandual@arm.com>
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

Add support for the dynamic funnel device in the platform driver, which can
then be used on ACPI based platforms. This change would allow runtime power
management for ACPI based systems.

The driver would try to enable the APB clock if available. Also, rename the
code to reflect the fact that it now handles both static and dynamic
funnels.

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
- Dropped pm_runtime_put() from funnel_probe()
- Added pm_runtime_put() on success path in dynamic_funnel_probe()
- Added pm_runtime_put() on success/error paths in
  funnel_platform_probe()

 drivers/acpi/arm64/amba.c                     |  1 -
 .../hwtracing/coresight/coresight-funnel.c    | 87 ++++++++++---------
 2 files changed, 46 insertions(+), 42 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 270f4e3819a2..afb6afb66967 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -28,7 +28,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
-	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b8e150e45b27..f92a96872a5e 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -36,6 +36,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
  * struct funnel_drvdata - specifics associated to a funnel component
  * @base:	memory mapped base address for this component.
  * @atclk:	optional clock for the core parts of the funnel.
+ * @pclk:	APB clock if present, otherwise NULL
  * @csdev:	component vitals needed by the framework.
  * @priority:	port selection order.
  * @spinlock:	serialize enable/disable operations.
@@ -43,6 +44,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
 struct funnel_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
 	spinlock_t		spinlock;
@@ -236,6 +238,10 @@ static int funnel_probe(struct device *dev, struct resource *res)
 			return ret;
 	}
 
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
 	/*
 	 * Map the device base for dynamic-funnel, which has been
 	 * validated by AMBA core.
@@ -272,7 +278,6 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		goto out_disable_clk;
 	}
 
-	pm_runtime_put(dev);
 	ret = 0;
 
 out_disable_clk:
@@ -298,6 +303,9 @@ static int funnel_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
@@ -308,6 +316,8 @@ static int funnel_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -316,56 +326,60 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
 	SET_RUNTIME_PM_OPS(funnel_runtime_suspend, funnel_runtime_resume, NULL)
 };
 
-static int static_funnel_probe(struct platform_device *pdev)
+static int funnel_platform_probe(struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	/* Static funnel do not have programming base */
-	ret = funnel_probe(&pdev->dev, NULL);
-
-	if (ret) {
-		pm_runtime_put_noidle(&pdev->dev);
-		pm_runtime_disable(&pdev->dev);
-	}
+	ret = funnel_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
 
 	return ret;
 }
 
-static int static_funnel_remove(struct platform_device *pdev)
+static int funnel_platform_remove(struct platform_device *pdev)
 {
-	funnel_remove(&pdev->dev);
+	struct funnel_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		funnel_remove(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
+
 	return 0;
 }
 
-static const struct of_device_id static_funnel_match[] = {
+static const struct of_device_id funnel_match[] = {
 	{.compatible = "arm,coresight-static-funnel"},
 	{}
 };
 
-MODULE_DEVICE_TABLE(of, static_funnel_match);
+MODULE_DEVICE_TABLE(of, funnel_match);
 
 #ifdef CONFIG_ACPI
-static const struct acpi_device_id static_funnel_ids[] = {
-	{"ARMHC9FE", 0},
+static const struct acpi_device_id funnel_acpi_ids[] = {
+	{"ARMHC9FE", 0}, /* ARM Coresight Static Funnel */
+	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{},
 };
 
-MODULE_DEVICE_TABLE(acpi, static_funnel_ids);
+MODULE_DEVICE_TABLE(acpi, funnel_acpi_ids);
 #endif
 
-static struct platform_driver static_funnel_driver = {
-	.probe          = static_funnel_probe,
-	.remove          = static_funnel_remove,
-	.driver         = {
-		.name   = "coresight-static-funnel",
+static struct platform_driver funnel_driver = {
+	.probe	= funnel_platform_probe,
+	.remove	= funnel_platform_remove,
+	.driver	= {
+		.name   = "coresight-funnel",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
-		.of_match_table = static_funnel_match,
-		.acpi_match_table = ACPI_PTR(static_funnel_ids),
+		.of_match_table = funnel_match,
+		.acpi_match_table = ACPI_PTR(funnel_acpi_ids),
 		.pm	= &funnel_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
@@ -374,7 +388,13 @@ static struct platform_driver static_funnel_driver = {
 static int dynamic_funnel_probe(struct amba_device *adev,
 				const struct amba_id *id)
 {
-	return funnel_probe(&adev->dev, &adev->res);
+	int ret;
+
+	ret = funnel_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
 }
 
 static void dynamic_funnel_remove(struct amba_device *adev)
@@ -411,27 +431,12 @@ static struct amba_driver dynamic_funnel_driver = {
 
 static int __init funnel_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&static_funnel_driver);
-	if (ret) {
-		pr_info("Error registering platform driver\n");
-		return ret;
-	}
-
-	ret = amba_driver_register(&dynamic_funnel_driver);
-	if (ret) {
-		pr_info("Error registering amba driver\n");
-		platform_driver_unregister(&static_funnel_driver);
-	}
-
-	return ret;
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver);
 }
 
 static void __exit funnel_exit(void)
 {
-	platform_driver_unregister(&static_funnel_driver);
-	amba_driver_unregister(&dynamic_funnel_driver);
+	coresight_remove_driver(&dynamic_funnel_driver, &funnel_driver);
 }
 
 module_init(funnel_init);
-- 
2.25.1

