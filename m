Return-Path: <linux-kernel+bounces-102841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF47887B7AC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 07:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4039B1F25055
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 06:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F303512B93;
	Thu, 14 Mar 2024 05:59:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50501381D0;
	Thu, 14 Mar 2024 05:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710395989; cv=none; b=N4r075um2rPmJWhrmAE+fek5Yi8V7UCwpjKbuZyQBBs+Gx5amwpXDLhC4FEzajSWohjguZZXVBE0kIHFlI82o6S0M+8bS6rmgrMpQ8XlfnMV5TwK95hospqpJSmxNgXvdPQ7RnqElUTV5XkpV+C2hs28JHA1lhZZymtDJoS7jsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710395989; c=relaxed/simple;
	bh=nF1vib//JfS9VVM1KMJL7ziPCfj+3ZudKLaYfcABLc0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=innDWgAYmhiA3bEfmuhatmt+zb+Lotv+2AvBbyJtBWcPW6G7PE32cwVW//NlLFSGARMiXlB4y5ROtrSSeheJrYMZi0CLSEg+H8giWbd9kGUGTnWMzhhpLOid1jA26ycM/eI/omCfuPqAdFN1NPsBIlFOCqi2M3B7wsFE8zse4nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF30E1063;
	Wed, 13 Mar 2024 23:00:22 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.53.138])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 8EC683F73F;
	Wed, 13 Mar 2024 22:59:42 -0700 (PDT)
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
Subject: [PATCH V7 06/11] coresight: funnel: Move ACPI support from AMBA driver to platform driver
Date: Thu, 14 Mar 2024 11:28:38 +0530
Message-Id: <20240314055843.2625883-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240314055843.2625883-1-anshuman.khandual@arm.com>
References: <20240314055843.2625883-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the dynamic funnel device in the platform driver, which can
then be used on ACPI based platforms. This change would allow runtime power
management for ACPI based systems.

The driver would try to enable the APB clock if available. Also, rename the
code to reflect the fact that it now handles both static and dynamic
funnels. But first this refactors funnel_probe() making sure it can be used
both for platform and AMBA drivers, by moving the pm_runtime_put() to the
callers.

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
Changes in V7:

- Dropped reduntant drvdata check in funnel_platform_remove()

 drivers/acpi/arm64/amba.c                     |  1 -
 .../hwtracing/coresight/coresight-funnel.c    | 72 ++++++++++++-------
 2 files changed, 48 insertions(+), 25 deletions(-)

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
index ff3ea0670a5b..616735dc80a6 100644
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
@@ -272,12 +278,13 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		goto out_disable_clk;
 	}
 
-	pm_runtime_put(dev);
 	ret = 0;
 
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
+	if (ret && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return ret;
 }
 
@@ -298,6 +305,9 @@ static int funnel_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
+
 	return 0;
 }
 
@@ -308,6 +318,8 @@ static int funnel_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -316,55 +328,61 @@ static const struct dev_pm_ops funnel_dev_pm_ops = {
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
+	ret = funnel_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
 		pm_runtime_disable(&pdev->dev);
-	}
 
 	return ret;
 }
 
-static void static_funnel_remove(struct platform_device *pdev)
+static void funnel_platform_remove(struct platform_device *pdev)
 {
+	struct funnel_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (WARN_ON(!drvdata))
+		return;
+
 	funnel_remove(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
+	if (!IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
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
-	{"ARMHC9FE", 0, 0, 0},
+static const struct acpi_device_id funnel_acpi_ids[] = {
+	{"ARMHC9FE", 0, 0, 0}, /* ARM Coresight Static Funnel */
+	{"ARMHC9FF", 0, 0, 0}, /* ARM CoreSight Dynamic Funnel */
 	{},
 };
 
-MODULE_DEVICE_TABLE(acpi, static_funnel_ids);
+MODULE_DEVICE_TABLE(acpi, funnel_acpi_ids);
 #endif
 
-static struct platform_driver static_funnel_driver = {
-	.probe          = static_funnel_probe,
-	.remove_new      = static_funnel_remove,
-	.driver         = {
-		.name   = "coresight-static-funnel",
+static struct platform_driver funnel_driver = {
+	.probe		= funnel_platform_probe,
+	.remove_new	= funnel_platform_remove,
+	.driver		= {
+		.name   = "coresight-funnel",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
-		.of_match_table = static_funnel_match,
-		.acpi_match_table = ACPI_PTR(static_funnel_ids),
+		.of_match_table = funnel_match,
+		.acpi_match_table = ACPI_PTR(funnel_acpi_ids),
 		.pm	= &funnel_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
@@ -373,7 +391,13 @@ static struct platform_driver static_funnel_driver = {
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
@@ -410,12 +434,12 @@ static struct amba_driver dynamic_funnel_driver = {
 
 static int __init funnel_init(void)
 {
-	return coresight_init_driver("funnel", &dynamic_funnel_driver, &static_funnel_driver);
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &funnel_driver);
 }
 
 static void __exit funnel_exit(void)
 {
-	coresight_remove_driver(&dynamic_funnel_driver, &static_funnel_driver);
+	coresight_remove_driver(&dynamic_funnel_driver, &funnel_driver);
 }
 
 module_init(funnel_init);
-- 
2.25.1


