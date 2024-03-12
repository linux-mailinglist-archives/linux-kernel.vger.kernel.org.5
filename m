Return-Path: <linux-kernel+bounces-100107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B84948791E5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBB8B1C212D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6DD79DAA;
	Tue, 12 Mar 2024 10:23:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558947829A;
	Tue, 12 Mar 2024 10:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710239038; cv=none; b=Fms2L3gfvbkEJpntskt9ArJmIcolAcfr9Cr5Os2Vt48603f+8lFeXqHFEVSWoSySwpY8F8Ijav7/wX92i6wjfIipx7mZzmvBChfvQgCBUDxWxVtZxt6Phto2TsF1bDJtAHWG3kBoH7d0VzZs4v8DT2Kmnho/+I1auEeAoeaih4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710239038; c=relaxed/simple;
	bh=OpLaZbtp+WBO3m+PzveXLptrfgHrJ/P+34zDvkbnGLY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nhFOM9AfVMCiOwMSwbDD7IgmnDoz6+GY3HnbUyz+ReLbSBcddeQ4S/MiiQLDpqHskxlvQSB1rE9MQ6KnSBFd2tk9VSgH8Swv7+ZzsCchnb4NaDSZ5VdG57aYEMS2WZNhxN/3uciMWqls9EIJ7PiqOoMHJS/CzclnwcN8SnrJmvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F29921007;
	Tue, 12 Mar 2024 03:24:32 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.52.80])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 32A743F73F;
	Tue, 12 Mar 2024 03:23:49 -0700 (PDT)
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
	linux-stm32@st-md-mailman.stormreply.com,
	Leo Yan <leo.yan@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [PATCH V6 04/11] coresight: Add helpers registering/removing both AMBA and platform drivers
Date: Tue, 12 Mar 2024 15:53:11 +0530
Message-Id: <20240312102318.2285165-5-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240312102318.2285165-1-anshuman.khandual@arm.com>
References: <20240312102318.2285165-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds two different helpers i.e coresight_init_driver()/remove_driver()
enabling coresight devices to register or remove AMBA and platform drivers.
This changes replicator and funnel devices to use above new helpers.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Reviewed-by: James Clark <james.clark@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c  | 29 +++++++++++++++++++
 .../hwtracing/coresight/coresight-funnel.c    | 19 ++----------
 .../coresight/coresight-replicator.c          | 20 ++-----------
 include/linux/coresight.h                     |  7 +++++
 4 files changed, 41 insertions(+), 34 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index b83613e34289..9fc6f6b863e0 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1398,6 +1398,35 @@ static void __exit coresight_exit(void)
 module_init(coresight_init);
 module_exit(coresight_exit);
 
+int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+			  struct platform_driver *pdev_drv)
+{
+	int ret;
+
+	ret = amba_driver_register(amba_drv);
+	if (ret) {
+		pr_err("%s: error registering AMBA driver\n", drv);
+		return ret;
+	}
+
+	ret = platform_driver_register(pdev_drv);
+	if (!ret)
+		return 0;
+
+	pr_err("%s: error registering platform driver\n", drv);
+	amba_driver_unregister(amba_drv);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(coresight_init_driver);
+
+void coresight_remove_driver(struct amba_driver *amba_drv,
+			     struct platform_driver *pdev_drv)
+{
+	amba_driver_unregister(amba_drv);
+	platform_driver_unregister(pdev_drv);
+}
+EXPORT_SYMBOL_GPL(coresight_remove_driver);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Pratik Patel <pratikp@codeaurora.org>");
 MODULE_AUTHOR("Mathieu Poirier <mathieu.poirier@linaro.org>");
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index ef1a0abfee4e..ff3ea0670a5b 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -410,27 +410,12 @@ static struct amba_driver dynamic_funnel_driver = {
 
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
+	return coresight_init_driver("funnel", &dynamic_funnel_driver, &static_funnel_driver);
 }
 
 static void __exit funnel_exit(void)
 {
-	platform_driver_unregister(&static_funnel_driver);
-	amba_driver_unregister(&dynamic_funnel_driver);
+	coresight_remove_driver(&dynamic_funnel_driver, &static_funnel_driver);
 }
 
 module_init(funnel_init);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 73452d9dc13b..ddb530a8436f 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -416,27 +416,13 @@ static struct amba_driver dynamic_replicator_driver = {
 
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
+	return coresight_init_driver("replicator", &dynamic_replicator_driver,
+				     &static_replicator_driver);
 }
 
 static void __exit replicator_exit(void)
 {
-	platform_driver_unregister(&static_replicator_driver);
-	amba_driver_unregister(&dynamic_replicator_driver);
+	coresight_remove_driver(&dynamic_replicator_driver, &static_replicator_driver);
 }
 
 module_init(replicator_init);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 5f288d475490..653f1712eb77 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -12,6 +12,8 @@
 #include <linux/io.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
+#include <linux/amba/bus.h>
+#include <linux/platform_device.h>
 
 /* Peripheral id registers (0xFD0-0xFEC) */
 #define CORESIGHT_PERIPHIDR4	0xfd0
@@ -658,4 +660,9 @@ coresight_find_output_type(struct coresight_platform_data *pdata,
 			   enum coresight_dev_type type,
 			   union coresight_dev_subtype subtype);
 
+int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+			  struct platform_driver *pdev_drv);
+
+void coresight_remove_driver(struct amba_driver *amba_drv,
+			     struct platform_driver *pdev_drv);
 #endif		/* _LINUX_COREISGHT_H */
-- 
2.25.1


