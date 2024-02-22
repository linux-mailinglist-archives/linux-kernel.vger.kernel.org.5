Return-Path: <linux-kernel+bounces-76090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A6D85F2D1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D111F239A0
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1421C24B31;
	Thu, 22 Feb 2024 08:22:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4F0A250F1;
	Thu, 22 Feb 2024 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590168; cv=none; b=OO017PDrTTPzuzFApS7xBdnfrXjT2HHabbDIE/618Sox87Toe1NBdYAbq4b03qO+ziVCw8iAsN7PiT2gHIdAOy/5lm35G7OkbXlQzpjmI4FzirX7uBPm4bNuAtN8zgBhE6DrSSDAR94S9oFKdovllVrlHWBUnixbhxJ4vnV7zMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590168; c=relaxed/simple;
	bh=tbOKmiH/KQYQD72VFpBDXK/6gjtx3+lxx40ydh37ajc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pf1BGx5YVJLVGykZLcGDvNnYLuaxRuqr7Gt53FjFF52q/MNNRiG5EErpoOauk3Sh2LvckhYqlqYjW6/vrUOKkMZj3qoBaySlm519lLDdmRgdOX0L89c5fxiNWieCtO4Tu7shvLUGxbmi2tjwxjSWzsWMG4JcV71zC/TUCX0YnbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A03821007;
	Thu, 22 Feb 2024 00:23:24 -0800 (PST)
Received: from a077893.blr.arm.com (a077893.blr.arm.com [10.162.42.8])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B20243F762;
	Thu, 22 Feb 2024 00:22:41 -0800 (PST)
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
Subject: [PATCH V5 09/11] coresight: tmc: Move ACPI support from AMBA driver to platform driver
Date: Thu, 22 Feb 2024 13:51:40 +0530
Message-Id: <20240222082142.3663983-10-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240222082142.3663983-1-anshuman.khandual@arm.com>
References: <20240222082142.3663983-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the tmc devices in the platform driver, which can then be
used on ACPI based platforms. This change would now allow runtime power
management for ACPI based systems. The driver would try to enable the APB
clock if available. But first this renames and then refactors tmc_probe()
and tmc_remove(), making sure it can be used both for platform and AMBA
drivers. This also moves pm_runtime_put() from tmc_probe() to the callers.

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
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V5:

- Updated the commit message regarding tmc_probe/remove() refactoring and renaming

 drivers/acpi/arm64/amba.c                     |   2 -
 .../hwtracing/coresight/coresight-tmc-core.c  | 139 ++++++++++++++++--
 drivers/hwtracing/coresight/coresight-tmc.h   |   2 +
 3 files changed, 126 insertions(+), 17 deletions(-)

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
index 43874fa4def0..9711fdd74a15 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -24,6 +24,8 @@
 #include <linux/of.h>
 #include <linux/coresight.h>
 #include <linux/amba/bus.h>
+#include <linux/platform_device.h>
+#include <linux/acpi.h>
 
 #include "coresight-priv.h"
 #include "coresight-tmc.h"
@@ -444,24 +446,17 @@ static u32 tmc_etr_get_max_burst_size(struct device *dev)
 	return burst_size;
 }
 
-static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
+static int __tmc_probe(struct device *dev, struct resource *res)
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
@@ -536,7 +531,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto out;
 	}
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 	desc.pdata = pdata;
 
 	drvdata->csdev = coresight_register(&desc);
@@ -551,12 +546,27 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
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
+	ret = __tmc_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static void tmc_shutdown(struct amba_device *adev)
 {
 	unsigned long flags;
@@ -579,9 +589,9 @@ static void tmc_shutdown(struct amba_device *adev)
 	spin_unlock_irqrestore(&drvdata->spinlock, flags);
 }
 
-static void tmc_remove(struct amba_device *adev)
+static void __tmc_remove(struct device *dev)
 {
-	struct tmc_drvdata *drvdata = dev_get_drvdata(&adev->dev);
+	struct tmc_drvdata *drvdata = dev_get_drvdata(dev);
 
 	/*
 	 * Since misc_open() holds a refcount on the f_ops, which is
@@ -592,6 +602,11 @@ static void tmc_remove(struct amba_device *adev)
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
@@ -617,7 +632,101 @@ static struct amba_driver tmc_driver = {
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
+	ret = __tmc_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
+		pm_runtime_disable(&pdev->dev);
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
index 8dcb426ac3e7..cb5a0920c203 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.h
+++ b/drivers/hwtracing/coresight/coresight-tmc.h
@@ -166,6 +166,7 @@ struct etr_buf {
 
 /**
  * struct tmc_drvdata - specifics associated to an TMC component
+ * @pclk:	APB clock if present, otherwise NULL
  * @base:	memory mapped base address for this component.
  * @csdev:	component vitals needed by the framework.
  * @miscdev:	specifics to handle "/dev/xyz.tmc" entry.
@@ -190,6 +191,7 @@ struct etr_buf {
  * @perf_buf:	PERF buffer for ETR.
  */
 struct tmc_drvdata {
+	struct clk		*pclk;
 	void __iomem		*base;
 	struct coresight_device	*csdev;
 	struct miscdevice	miscdev;
-- 
2.25.1


