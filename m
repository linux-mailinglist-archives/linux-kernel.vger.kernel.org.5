Return-Path: <linux-kernel+bounces-34740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF08386F7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:48:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19F7C1F23C42
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 856E91A290;
	Tue, 23 Jan 2024 05:47:11 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9705E2C1A7;
	Tue, 23 Jan 2024 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988830; cv=none; b=GUKX9R2yqukCFDXPvfMu7G7v1K9xIzQ0kPlBYtxkLqkJthd+KUpHesZ/PRxshfTdlmIoa2hZzuzQ1+5ob0mYWKkQ14anfkXQ5ctcMnQPhv1Q6ttCl15o9rZq3hwktBHccHAXI+I3p1SCpR4gYpDOZArxNQXTCPQMh8Vd+1s3CLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988830; c=relaxed/simple;
	bh=pWkhDJ8CvwjJMgAkMe6gFr3UBeGMgGeTt5M9JXGH1cQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yf0u4glrfEtmWtp27NL++4BLke/X7AxT0z6gBOiu66P9th+pprWpc3hU4bkmf6XEVtm/JzO5VcC4PfsgY74SITOq2mysuz2c2FzvXVDo6RTRgG0yJIhqJAUf+RNrjdCwNM/E9E4zfa7zTQjgVdpADfkGSHIvUeUgyn6VeOrOn/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80F401FB;
	Mon, 22 Jan 2024 21:47:53 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 9C3B03F762;
	Mon, 22 Jan 2024 21:47:03 -0800 (PST)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	coresight@lists.linaro.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH V4 08/11] coresight: tpiu: Move ACPI support from AMBA driver to platform driver
Date: Tue, 23 Jan 2024 11:16:05 +0530
Message-Id: <20240123054608.1790189-9-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123054608.1790189-1-anshuman.khandual@arm.com>
References: <20240123054608.1790189-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the tpiu device in the platform driver, which can then be
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
Changes in V4:

- Added pm_runtime_disable() in tpiu_platform_probe()

 drivers/acpi/arm64/amba.c                    |   1 -
 drivers/hwtracing/coresight/coresight-tpiu.c | 102 +++++++++++++++++--
 2 files changed, 92 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 587061b0fd2f..6d24a8f7914b 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -25,7 +25,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC501", 0}, /* ARM CoreSight ETR */
 	{"ARMHC502", 0}, /* ARM CoreSight STM */
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
-	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
 	{"", 0},
 };
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index 59eac93fd6bb..7a76bbd610bf 100644
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
@@ -52,11 +54,13 @@ DEFINE_CORESIGHT_DEVLIST(tpiu_devs, "tpiu");
 /*
  * @base:	memory mapped base address for this component.
  * @atclk:	optional clock for the core parts of the TPIU.
+ * @pclk:	APB clock if present, otherwise NULL
  * @csdev:	component vitals needed by the framework.
  */
 struct tpiu_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 };
 
@@ -114,14 +118,12 @@ static const struct coresight_ops tpiu_cs_ops = {
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
@@ -132,12 +134,16 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
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
@@ -163,21 +169,34 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 	desc.dev = dev;
 	drvdata->csdev = coresight_register(&desc);
 
-	if (!IS_ERR(drvdata->csdev)) {
-		pm_runtime_put(&adev->dev);
+	if (!IS_ERR(drvdata->csdev))
 		return 0;
-	}
 
 	return PTR_ERR(drvdata->csdev);
 }
 
-static void tpiu_remove(struct amba_device *adev)
+static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	struct tpiu_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	int ret;
+
+	ret = __tpiu_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+	return ret;
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
@@ -186,6 +205,8 @@ static int tpiu_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -196,6 +217,8 @@ static int tpiu_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -235,7 +258,66 @@ static struct amba_driver tpiu_driver = {
 	.id_table	= tpiu_ids,
 };
 
-module_amba_driver(tpiu_driver);
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
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int tpiu_platform_remove(struct platform_device *pdev)
+{
+	struct tpiu_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		__tpiu_remove(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
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
+
+static int __init tpiu_init(void)
+{
+	return coresight_init_driver("tpiu", &tpiu_driver, &tpiu_platform_driver);
+}
+
+static void __exit tpiu_exit(void)
+{
+	coresight_remove_driver(&tpiu_driver, &tpiu_platform_driver);
+}
+module_init(tpiu_init);
+module_exit(tpiu_exit);
 
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
-- 
2.25.1


