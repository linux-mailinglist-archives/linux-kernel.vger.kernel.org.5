Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FD37912F7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbjIDIJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352511AbjIDIJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:09:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4CEF109
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 01:09:15 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91C181474;
        Mon,  4 Sep 2023 01:09:53 -0700 (PDT)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.40.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4D0443F8A4;
        Mon,  4 Sep 2023 01:09:13 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 4/7] coresight: tpiu: Move ACPI support from AMBA driver to platform driver
Date:   Mon,  4 Sep 2023 13:38:53 +0530
Message-Id: <20230904080856.2183421-5-anshuman.khandual@arm.com>
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

Add support for the tpiu device in the platform driver, which can then be
used on ACPI based platforms. This change would now allow runtime power
management for ACPI based systems. The driver would try to enable the APB
clock if available.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/acpi_amba.c                     |  1 -
 drivers/hwtracing/coresight/coresight-tpiu.c | 76 ++++++++++++++++++--
 2 files changed, 69 insertions(+), 8 deletions(-)

diff --git a/drivers/acpi/acpi_amba.c b/drivers/acpi/acpi_amba.c
index 2c1fb1210561..3100f84503fb 100644
--- a/drivers/acpi/acpi_amba.c
+++ b/drivers/acpi/acpi_amba.c
@@ -25,7 +25,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
-	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"", 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..9835a79c036e 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -5,6 +5,8 @@
  * Description: CoreSight Trace Port Interface Unit driver
  */
 
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 #include <linux/atomic.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -57,6 +59,7 @@ DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
 struct tpiu_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 };
 
@@ -114,14 +117,12 @@ static const struct coresight_ops tpiu_cs_ops = {
 	.sink_ops	= &tpiu_sink_ops,
 };
 
-static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
+static int __tpiu_probe(struct device *dev, struct resource *res)
 {
 	int ret;
 	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct tpiu_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
 	desc.name = coresight_alloc_device_name(&tpiu_devs, dev);
@@ -132,12 +133,16 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	if (!drvdata)
 		return -ENOMEM;
 
-	drvdata->atclk = devm_clk_get(&adev->dev, "atclk"); /* optional */
+	drvdata->atclk = devm_clk_get(dev, "atclk"); /* optional */
 	if (!IS_ERR(drvdata->atclk)) {
 		ret = clk_prepare_enable(drvdata->atclk);
 		if (ret)
 			return ret;
 	}
+
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
 	dev_set_drvdata(dev, drvdata);
 
 	/* Validity for the resource is already checked by the AMBA core */
@@ -164,20 +169,30 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	drvdata->csdev = coresight_register(&desc);
 
 	if (!IS_ERR(drvdata->csdev)) {
-		pm_runtime_put(&adev->dev);
+		pm_runtime_put(dev);
 		return 0;
 	}
 
 	return PTR_ERR(drvdata->csdev);
 }
 
-static void tpiu_remove(struct amba_device *adev)
+static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	return __tpiu_probe(&adev->dev, &adev->res);
+}
+
+static void __tpiu_remove(struct device *dev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(dev);
 
 	coresight_unregister(drvdata->csdev);
 }
 
+static void tpiu_remove(struct amba_device *adev)
+{
+	__tpiu_remove(&adev->dev);
+}
+
 #ifdef CONFIG_PM
 static int tpiu_runtime_suspend(struct device *dev)
 {
@@ -186,6 +201,8 @@ static int tpiu_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -196,6 +213,8 @@ static int tpiu_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -237,6 +256,49 @@ static struct amba_driver tpiu_driver = {
 
 module_amba_driver(tpiu_driver);
 
+static int tpiu_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	int ret;
+
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = __tpiu_probe(&pdev->dev, res);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+	return ret;
+}
+
+static int tpiu_platform_remove(struct platform_device *pdev)
+{
+	__tpiu_remove(&pdev->dev);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id tpiu_acpi_ids[] = {
+	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
+	{}
+};
+MODULE_DEVICE_TABLE(acpi, tpiu_acpi_ids);
+#endif
+
+static struct platform_driver tpiu_platform_driver = {
+	.probe	= tpiu_platform_probe,
+	.remove	= tpiu_platform_remove,
+	.driver = {
+		.name			= "coresight-tpiu-platform",
+		.acpi_match_table	= ACPI_PTR(tpiu_acpi_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &tpiu_dev_pm_ops,
+	},
+};
+module_platform_driver(tpiu_platform_driver);
+
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
 MODULE_DESCRIPTION("Arm CoreSight TPIU (Trace Port Interface Unit) driver");
-- 
2.25.1

