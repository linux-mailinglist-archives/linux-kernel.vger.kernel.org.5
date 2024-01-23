Return-Path: <linux-kernel+bounces-34736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D228386EF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 06:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70EF0B23A72
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 05:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B07C8DD;
	Tue, 23 Jan 2024 05:46:51 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C787107B6;
	Tue, 23 Jan 2024 05:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705988811; cv=none; b=oPQDOVWeTR2YJhoxnP7bMKUmMddInWDhnQf2dt8o5RJEorfzvsSg+1cwKFvIHDnM6pIGA4jD8tZ7x0/hW01TYAcUzcSo1h9d9f2Hgcn+lEOitNlBwQSHELufJ6uqPrJM6fTYROUqRWybBartZOSg/P9piZiqVUL61XGgQAOy2A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705988811; c=relaxed/simple;
	bh=qupRBqwpHsyoUgPYtpJJmnv5z1ZGXy9lZftnWpjUnAY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qn8M3JsPTs1sN/+MR+/aoY/xhnb+pLW5ZRWs9JRpZuJxEM8TTWgIZJ2riZtyQNgpYl65+EjNNTlwA6AK7oLVcJ1WrKRTVE2ErApaVoF2lDDQQy288MEhjhwehfnH2qjHxFfPSkuKo8GPFkCj7qxac12AAuYQ64hpdNNloFntYMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 572691FB;
	Mon, 22 Jan 2024 21:47:34 -0800 (PST)
Received: from a077893.arm.com (unknown [10.163.40.228])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2D3203F762;
	Mon, 22 Jan 2024 21:46:43 -0800 (PST)
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
Subject: [PATCH V4 04/11] coresight: Add helpers registering/removing both AMBA and platform drivers
Date: Tue, 23 Jan 2024 11:16:01 +0530
Message-Id: <20240123054608.1790189-5-anshuman.khandual@arm.com>
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

This adds two different helpers i.e coresight_init_driver()/remove_driver()
enabling coresight devices to register or remove AMBA and platform drivers.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-core.c | 29 ++++++++++++++++++++
 include/linux/coresight.h                    |  7 +++++
 2 files changed, 36 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index d7f0e231feb9..4e897cc5da81 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -1836,6 +1836,35 @@ static void __exit coresight_exit(void)
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
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index a4cb7dd6ca23..7e1646d4863c 100644
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
@@ -598,6 +600,11 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
+int coresight_init_driver(const char *drv, struct amba_driver *amba_drv,
+			  struct platform_driver *pdev_drv);
+
+void coresight_remove_driver(struct amba_driver *amba_drv,
+			     struct platform_driver *pdev_drv);
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
-- 
2.25.1


