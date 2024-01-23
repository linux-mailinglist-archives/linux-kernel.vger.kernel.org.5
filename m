Return-Path: <linux-kernel+bounces-34737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFEDB8386F1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:48:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0B8728288C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:48:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04BA35251;
	Tue, 23 Jan 2024 05:46:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C9C1A27A;
	Tue, 23 Jan 2024 05:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988816; cv=none; b=hcBs7c2pi745i5mzCxmP5rsMnzFSV+ncxUNocBBmiDe1FD7rniy7if277GtBxokS8sZj/cK0+rOqcx5C0ksZxtgmMkdgETatahVTVWgwa5t+5jI4r+YIt4a7lLrMC4QmIJze2t8CDzBnI3pTDav1gEe8ST6s2froOk0Hwsewg14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988816; c=relaxed/simple;
	bh=0Hhc+t9nBPNylWMMR9JQzqMk2pzTX/NI6WYd3CwBQt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bxSgHKnzTlySjh0OtJBbuUp0BqKcXqvSD1vd3KrQJpYXacAYQNuQg9wqn14vTRwGE6C89wYjTzUARtM16VE0/6HRPm3pCkMtsLhT7FOc9d6qOufa8pDPxvE65A2Db8j7clbQfehckdYu7MuuLCEARoLYD6j7UKeKp+M6ntt4voo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E8D51FB;
	Mon, 22 Jan 2024 21:47:39 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7B9D73F762;
	Mon, 22 Jan 2024 21:46:49 -0800 (PST)
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
Subject: [PATCH V4 05/11] coresight: replicator: Move ACPI support from AMBA driver to platform driver
Date: Tue, 23 Jan 2024 11:16:02 +0530
Message-Id: <20240123054608.1790189-6-anshuman.khandual@arm.com>
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

Add support for the dynamic replicator device in the platform driver, which
can then be used on ACPI based platforms. This change would now allow
runtime power management for repliacator devices on ACPI based systems.

The driver would try to enable the APB clock if available. Also, rename the
code to reflect the fact that it now handles both static and dynamic
replicators.

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

- Added pm_runtime_disable() in replicator_platform_probe()
- Changed replicator_platform_remove() for platform_driver->remove_new()

 drivers/acpi/arm64/amba.c                     |  1 -
 .../coresight/coresight-replicator.c          | 81 ++++++++++---------
 2 files changed, 43 insertions(+), 39 deletions(-)

diff --git a/drivers/acpi/arm64/amba.c b/drivers/acpi/arm64/amba.c
index 171b5c2c7edd..270f4e3819a2 100644
--- a/drivers/acpi/arm64/amba.c
+++ b/drivers/acpi/arm64/amba.c
@@ -27,7 +27,6 @@ static const struct acpi_device_id amba_id_list[] = {
 	{"ARMHC503", 0}, /* ARM CoreSight Debug */
 	{"ARMHC979", 0}, /* ARM CoreSight TPIU */
 	{"ARMHC97C", 0}, /* ARM CoreSight SoC-400 TMC, SoC-600 ETF/ETB */
-	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
 	{"ARMHC9CA", 0}, /* ARM CoreSight CATU */
 	{"ARMHC9FF", 0}, /* ARM CoreSight Dynamic Funnel */
 	{"", 0},
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 91d93060dda5..9b5f52725f43 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -31,6 +31,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
  * @base:	memory mapped base address for this component. Also indicates
  *		whether this one is programmable or not.
  * @atclk:	optional clock for the core parts of the replicator.
+ * @pclk:	APB clock if present, otherwise NULL
  * @csdev:	component vitals needed by the framework
  * @spinlock:	serialize enable/disable operations.
  * @check_idfilter_val: check if the context is lost upon clock removal.
@@ -38,6 +39,7 @@ DEFINE_CORESIGHT_DEVLIST(replicator_devs, "replicator");
 struct replicator_drvdata {
 	void __iomem		*base;
 	struct clk		*atclk;
+	struct clk		*pclk;
 	struct coresight_device	*csdev;
 	spinlock_t		spinlock;
 	bool			check_idfilter_val;
@@ -243,6 +245,10 @@ static int replicator_probe(struct device *dev, struct resource *res)
 			return ret;
 	}
 
+	drvdata->pclk = coresight_get_enable_apb_pclk(dev);
+	if (IS_ERR(drvdata->pclk))
+		return -ENODEV;
+
 	/*
 	 * Map the device base for dynamic-replicator, which has been
 	 * validated by AMBA core
@@ -285,7 +291,6 @@ static int replicator_probe(struct device *dev, struct resource *res)
 	}
 
 	replicator_reset(drvdata);
-	pm_runtime_put(dev);
 
 out_disable_clk:
 	if (ret && !IS_ERR_OR_NULL(drvdata->atclk))
@@ -301,29 +306,33 @@ static int replicator_remove(struct device *dev)
 	return 0;
 }
 
-static int static_replicator_probe(struct platform_device *pdev)
+static int replicator_platform_probe(struct platform_device *pdev)
 {
+	struct resource *res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	int ret;
 
 	pm_runtime_get_noresume(&pdev->dev);
 	pm_runtime_set_active(&pdev->dev);
 	pm_runtime_enable(&pdev->dev);
 
-	/* Static replicators do not have programming base */
-	ret = replicator_probe(&pdev->dev, NULL);
-
-	if (ret) {
-		pm_runtime_put_noidle(&pdev->dev);
+	ret = replicator_probe(&pdev->dev, res);
+	pm_runtime_put(&pdev->dev);
+	if (ret)
 		pm_runtime_disable(&pdev->dev);
-	}
 
 	return ret;
 }
 
-static void static_replicator_remove(struct platform_device *pdev)
+static void replicator_platform_remove(struct platform_device *pdev)
 {
-	replicator_remove(&pdev->dev);
+	struct replicator_drvdata *drvdata = dev_get_drvdata(&pdev->dev);
+
+	if (drvdata)
+		replicator_remove(&pdev->dev);
+
 	pm_runtime_disable(&pdev->dev);
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_put(drvdata->pclk);
 }
 
 #ifdef CONFIG_PM
@@ -334,6 +343,8 @@ static int replicator_runtime_suspend(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_disable_unprepare(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_disable_unprepare(drvdata->pclk);
 	return 0;
 }
 
@@ -344,6 +355,8 @@ static int replicator_runtime_resume(struct device *dev)
 	if (drvdata && !IS_ERR(drvdata->atclk))
 		clk_prepare_enable(drvdata->atclk);
 
+	if (drvdata && !IS_ERR_OR_NULL(drvdata->pclk))
+		clk_prepare_enable(drvdata->pclk);
 	return 0;
 }
 #endif
@@ -353,31 +366,32 @@ static const struct dev_pm_ops replicator_dev_pm_ops = {
 			   replicator_runtime_resume, NULL)
 };
 
-static const struct of_device_id static_replicator_match[] = {
+static const struct of_device_id replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
 	{.compatible = "arm,coresight-static-replicator"},
 	{}
 };
 
-MODULE_DEVICE_TABLE(of, static_replicator_match);
+MODULE_DEVICE_TABLE(of, replicator_match);
 
 #ifdef CONFIG_ACPI
-static const struct acpi_device_id static_replicator_acpi_ids[] = {
+static const struct acpi_device_id replicator_acpi_ids[] = {
 	{"ARMHC985", 0}, /* ARM CoreSight Static Replicator */
+	{"ARMHC98D", 0}, /* ARM CoreSight Dynamic Replicator */
 	{}
 };
 
-MODULE_DEVICE_TABLE(acpi, static_replicator_acpi_ids);
+MODULE_DEVICE_TABLE(acpi, replicator_acpi_ids);
 #endif
 
-static struct platform_driver static_replicator_driver = {
-	.probe          = static_replicator_probe,
-	.remove_new     = static_replicator_remove,
+static struct platform_driver replicator_driver = {
+	.probe          = replicator_platform_probe,
+	.remove_new     = replicator_platform_remove,
 	.driver         = {
-		.name   = "coresight-static-replicator",
+		.name   = "coresight-replicator",
 		/* THIS_MODULE is taken care of by platform_driver_register() */
-		.of_match_table = of_match_ptr(static_replicator_match),
-		.acpi_match_table = ACPI_PTR(static_replicator_acpi_ids),
+		.of_match_table = of_match_ptr(replicator_match),
+		.acpi_match_table = ACPI_PTR(replicator_acpi_ids),
 		.pm	= &replicator_dev_pm_ops,
 		.suppress_bind_attrs = true,
 	},
@@ -386,7 +400,13 @@ static struct platform_driver static_replicator_driver = {
 static int dynamic_replicator_probe(struct amba_device *adev,
 				    const struct amba_id *id)
 {
-	return replicator_probe(&adev->dev, &adev->res);
+	int ret;
+
+	ret = replicator_probe(&adev->dev, &adev->res);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
 }
 
 static void dynamic_replicator_remove(struct amba_device *adev)
@@ -416,27 +436,12 @@ static struct amba_driver dynamic_replicator_driver = {
 
 static int __init replicator_init(void)
 {
-	int ret;
-
-	ret = platform_driver_register(&static_replicator_driver);
-	if (ret) {
-		pr_info("Error registering platform driver\n");
-		return ret;
-	}
-
-	ret = amba_driver_register(&dynamic_replicator_driver);
-	if (ret) {
-		pr_info("Error registering amba driver\n");
-		platform_driver_unregister(&static_replicator_driver);
-	}
-
-	return ret;
+	return coresight_init_driver("replicator", &dynamic_replicator_driver, &replicator_driver);
 }
 
 static void __exit replicator_exit(void)
 {
-	platform_driver_unregister(&static_replicator_driver);
-	amba_driver_unregister(&dynamic_replicator_driver);
+	coresight_remove_driver(&dynamic_replicator_driver, &replicator_driver);
 }
 
 module_init(replicator_init);
-- 
2.25.1


