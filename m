Return-Path: <linux-kernel+bounces-34743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BE38386FD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8BE51F238A7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B74348CDC;
	Tue, 23 Jan 2024 05:47:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899E54CB4C;
	Tue, 23 Jan 2024 05:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988844; cv=none; b=cuthdj9IZcOr5N+PQNXfmn4yZWevo7vjYRVUDRIlPyQozUSARR9FxikkcNQii07VYWBUG+hLB60yY2i63q2bui0xZHZ72N8bOpGB4Ar55v428Ism1Itny2ROnZglnhSEdqxs5TJBpRGchKBgt3+9HwKAjnToiNnFSL1HxJmIJhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988844; c=relaxed/simple;
	bh=wIfLUPwDZidVkIEAXcinCyC9SpqgjonsCqpMnrQVffM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSmChh2SZoWidSlTstoVME7+iY1OUqnHijn6kvTYbpe1Q95idRbNOFH4So907AhuJKc//aS5rPScQYGAYaTcRef4zp/K2vvOarWqwJxwW967cO2QWgSXfMFQ6mqj+TwCOjJeO/1JcY/B27+jh7yP4EXA7yWRNpFhIsdAB6wSSx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B261F1FB;
	Mon, 22 Jan 2024 21:48:07 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E6C6C3F762;
	Mon, 22 Jan 2024 21:47:17 -0800 (PST)
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
Subject: [PATCH V4 11/11] coresight: debug: Move ACPI support from AMBA driver to platform driver
Date: Tue, 23 Jan 2024 11:16:08 +0530
Message-Id: <20240123054608.1790189-12-anshuman.khandual@arm.com>
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

Add support for the cpu debug devices in a new platform driver, which can
then be used on ACPI based platforms. This change would now allow runtime
power management for ACPI based systems. The driver would try to enable
the APB clock if available.

Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Acked-by: Sudeep Holla <sudeep.holla@arm.com> # For ACPI related changes
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/acpi/arm64/amba.c                     |   1 -
 .../hwtracing/coresight/coresight-cpu-debug.c | 141 ++++++++++++++++--
 2 files changed, 127 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index bec0976541da..e1f0bbb8f393 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -22,7 +22,6 @@
 static const struct acpi_device_id amba_id_list[] = {
 	{"ARMH0061", 0}, /* PL061 GPIO Device */
 	{"ARMH0330", 0}, /* ARM DMA Controller DMA-330 */
-	{"ARMHC503", 0}, /* ARM CoreSight Debug */
 	{"", 0},
 };
 
diff --git a/drivers/hwtracing/coresight/coresight-cpu-debug.c b/drivers/hwtracing/coresight/coresight-cpu-debug.c
index 1874df7c6a73..9a0978f3c5b3 100644
--- a/drivers/hwtracing/coresight/coresight-cpu-debug.c
+++ b/drivers/hwtracing/coresight/coresight-cpu-debug.c
@@ -23,6 +23,8 @@
 #include <linux/smp.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 
@@ -84,6 +86,7 @@
 #define DEBUG_WAIT_TIMEOUT		32000
 
 struct debug_drvdata {
+	struct clk	*pclk;
 	void __iomem	*base;
 	struct device	*dev;
 	int		cpu;
@@ -557,18 +560,12 @@ static void debug_func_exit(void)
 	debugfs_remove_recursive(debug_debugfs_dir);
 }
 
-static int debug_probe(struct amba_device *adev, const struct amba_id *id)
+static int __debug_probe(struct device *dev, struct resource *res)
 {
+	struct debug_drvdata *drvdata = dev_get_drvdata(dev);
 	void __iomem *base;
-	struct device *dev = &adev->dev;
-	struct debug_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	int ret;
 
-	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
-	if (!drvdata)
-		return -ENOMEM;
-
 	drvdata->cpu = coresight_get_cpu(dev);
 	if (drvdata->cpu < 0)
 		return drvdata->cpu;
@@ -579,8 +576,7 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 		return -EBUSY;
 	}
 
-	drvdata->dev = &adev->dev;
-	amba_set_drvdata(adev, drvdata);
+	drvdata->dev = dev;
 
 	/* Validity for the resource is already checked by the AMBA core */
 	base = devm_ioremap_resource(dev, res);
@@ -629,10 +625,21 @@ static int debug_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
-static void debug_remove(struct amba_device *adev)
+static int debug_probe(struct amba_device *adev, const struct amba_id *id)
+{
+	struct debug_drvdata *drvdata;
+
+	drvdata = devm_kzalloc(&adev->dev, sizeof(*drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	amba_set_drvdata(adev, drvdata);
+	return __debug_probe(&adev->dev, &adev->res);
+}
+
+static void __debug_remove(struct device *dev)
 {
-	struct device *dev = &adev->dev;
-	struct debug_drvdata *drvdata = amba_get_drvdata(adev);
+	struct debug_drvdata *drvdata = dev_get_drvdata(dev);
 
 	per_cpu(debug_drvdata, drvdata->cpu) = NULL;
 
@@ -646,6 +653,11 @@ static void debug_remove(struct amba_device *adev)
 		debug_func_exit();
 }
 
+static void debug_remove(struct amba_device *adev)
+{
+	__debug_remove(&adev->dev);
+}
+
 static const struct amba_cs_uci_id uci_id_debug[] = {
 	{
 		/*  CPU Debug UCI data */
@@ -677,7 +689,108 @@ static struct amba_driver debug_driver = {
 	.id_table	= debug_ids,
 };
 
-module_amba_driver(debug_driver);
+static int debug_platform_probe(struct platform_device *pdev)
+{
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	struct debug_drvdata *drvdata;
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
+	dev_set_drvdata(&pdev->dev, drvdata);
+	pm_runtime_get_noresume(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+
+	ret = __debug_probe(&pdev->dev, res);
+	if (ret) {
+		pm_runtime_put_noidle(&pdev->dev);
+		pm_runtime_disable(&pdev->dev);
+	}
+	return ret;
+}
+
+static int debug_platform_remove(struct platform_device *pdev)
+{
+	struct debug_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		__debug_remove(&pdev->dev);
+
+	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
+	return 0;
+}
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id debug_platform_ids[] = {
+	{"ARMHC503", 0}, /* ARM CoreSight Debug */
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, debug_platform_ids);
+#endif
+
+#ifdef CONFIG_PM
+static int debug_runtime_suspend(struct device *dev)
+{
+	struct debug_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+	return 0;
+}
+
+static int debug_runtime_resume(struct device *dev)
+{
+	struct debug_drvdata *drvdata = dev_get_drvdata(dev);
+
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
+	return 0;
+}
+#endif
+
+static const struct dev_pm_ops debug_dev_pm_ops = {
+	SET_RUNTIME_PM_OPS(debug_runtime_suspend, debug_runtime_resume, NULL)
+};
+
+static struct platform_driver debug_platform_driver = {
+	.probe	= debug_platform_probe,
+	.remove	= debug_platform_remove,
+	.driver	= {
+		.name			= "coresight-debug-platform",
+		.acpi_match_table	= ACPI_PTR(debug_platform_ids),
+		.suppress_bind_attrs	= true,
+		.pm			= &debug_dev_pm_ops,
+	},
+};
+
+static int __init debug_init(void)
+{
+	return coresight_init_driver("tmc", &debug_driver, &debug_platform_driver);
+}
+
+static void __exit debug_exit(void)
+{
+	coresight_remove_driver(&debug_driver, &debug_platform_driver);
+}
+module_init(debug_init);
+module_exit(debug_exit);
 
 MODULE_AUTHOR("Leo Yan <leo.yan@linaro.org>");
 MODULE_DESCRIPTION("ARM Coresight CPU Debug Driver");
-- 
2.25.1


