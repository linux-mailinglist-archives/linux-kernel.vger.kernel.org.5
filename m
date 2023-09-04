Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AECD87912F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352102AbjIDIJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351473AbjIDIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:09:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B336FA
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:09:10 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EB812165C;
        Mon,  4 Sep 2023 01:09:47 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9D8703F8A4;
        Mon,  4 Sep 2023 01:09:07 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/7] coresight: funnel: Move ACPI support from AMBA driver to platform driver
Date:   Mon,  4 Sep 2023 13:38:51 +0530
Message-Id: <20230904080856.2183421-3-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230904080856.2183421-1-anshuman.khandual@arm.com>
References: <20230904080856.2183421-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/acpi_amba.c                      |  1 -
 .../hwtracing/coresight/coresight-funnel.c    | 49 ++++++++++++-------
 2 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index fee7e35fa99e..6f37b4ffb025 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -28,7 +28,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
-	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index b8e150e45b27..b4984596738c 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -43,6 +43,7 @@ DEFINE_CORESIGHT_DEVLIST(funnel_devs, "funnel");
 struct funnel_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	unsigned long		priority;
 	spinlock_t		spinlock;
@@ -236,6 +237,10 @@ static int funnel_probe(struct device *dev, struct resource *res)
 			return ret;
 	}
 
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
 	/*
 	 * Map the device base for dynamic-funnel, which has been
 	 * validated by AMBA core.
@@ -298,6 +303,9 @@ static int funnel_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
@@ -308,6 +316,8 @@ static int funnel_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -316,16 +326,16 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
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
+	ret = funnel_probe(&pdev->dev, res);
 
 	if (ret) {
 		pm_runtime_put_noidle(&pdev->dev);
@@ -335,37 +345,38 @@ static int static_funnel_probe(struct platform_device *pdev)
 	return ret;
 }
 
-static int static_funnel_remove(struct platform_device *pdev)
+static int funnel_platform_remove(struct platform_device *pdev)
 {
 	funnel_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
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
@@ -413,7 +424,7 @@ static int __init funnel_init(void)
 {
 	int ret;
 
-	ret = platform_driver_register(&static_funnel_driver);
+	ret = platform_driver_register(&funnel_driver);
 	if (ret) {
 		pr_info("Error registering platform driver\n");
 		return ret;
@@ -422,7 +433,7 @@ static int __init funnel_init(void)
 	ret = amba_driver_register(&dynamic_funnel_driver);
 	if (ret) {
 		pr_info("Error registering amba driver\n");
-		platform_driver_unregister(&static_funnel_driver);
+		platform_driver_unregister(&funnel_driver);
 	}
 
 	return ret;
@@ -430,7 +441,7 @@ static int __init funnel_init(void)
 
 static void __exit funnel_exit(void)
 {
-	platform_driver_unregister(&static_funnel_driver);
+	platform_driver_unregister(&funnel_driver);
 	amba_driver_unregister(&dynamic_funnel_driver);
 }
 
-- 
2.25.1

