Return-Path: <linux-kernel+bounces-131033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FB2898235
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FBEC28A687
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2DC15A0FC;
	Thu,  4 Apr 2024 07:29:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014159B44
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712215792; cv=none; b=TqkiqE2bbhR1JUERkny1UFpGmQ6q76qOgBq1Pw2C+mCZ+y0JKDvzZBEpJrQBu2wuYNDWr4k5UIVmyUX3jLgr4OS9AeABHuPESei6uMPC+75/t3DMiW4S676Cd+9/TL9gTSv+cSBtfoqWnj63abgDpmNoHZaVhNoYODp5Iiv9Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712215792; c=relaxed/simple;
	bh=ravu8mrdCzxqzRX0YriwwOvQ67XWc5S6YbQtPVKsCVg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bRh3FPawkz6+ltYLaGONgMi96mpL4JW2SjXy8/YaTk+7UC12vX2+g9l2wslQMoJfkfcRnMAdGw6Cz6E85fGIzlCPj6wrtKLx7vATqCuaF0j0XRg8zB4D7M24xlXn3D99uYqqiUuZMuDK+au6f/P0ik2T50vqyhhBosUcwsAHF2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 543C41007;
	Thu,  4 Apr 2024 00:30:14 -0700 (PDT)
Received: from a077893.arm.com (unknown [10.163.56.72])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 221A63F64C;
	Thu,  4 Apr 2024 00:29:39 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-arm-kernel@lists.infradead.org,
	suzuki.poulose@arm.com
Cc: sudeep.holla@arm.com,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Mike Leach <mike.leach@linaro.org>,
	James Clark <james.clark@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	coresight@lists.linaro.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] coresight: tmc: Enable SG capability on ACPI based SoC-400 TMC ETR devices
Date: Thu,  4 Apr 2024 12:59:34 +0530
Message-Id: <20240404072934.940760-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This detects and enables the scatter gather capability (SG) on ACPI based
Soc-400 TMC ETR devices via a new property called 'arm-armhc97c-sg-enable'.
The updated ACPI spec can be found below, which contains this new property.

https://developer.arm.com/documentation/den0067/latest/

This preserves current handling for the property 'arm,scatter-gather' both
on ACPI and DT based platforms i.e the presence of the property is checked
instead of the value.

Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: James Clark <james.clark@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org 
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 .../hwtracing/coresight/coresight-tmc-core.c  | 28 ++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-core.c b/drivers/hwtracing/coresight/coresight-tmc-core.c
index 72005b0c633e..2b277499b59a 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-core.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-core.c
@@ -4,6 +4,7 @@
  * Description: CoreSight Trace Memory Controller driver
  */
 
+#include <linux/acpi.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/types.h>
@@ -360,7 +361,32 @@ static const struct attribute_group *coresight_etr_groups[] = {
 
 static inline bool tmc_etr_can_use_sg(struct device *dev)
 {
-	return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
+	int ret;
+	u8 val_u8;
+
+	/*
+	 * Presence of the property 'arm,scatter-gather' is checked
+	 * on the platform for the feature support, rather than its
+	 * value.
+	 */
+	if (is_of_node(dev->fwnode)) {
+		return fwnode_property_present(dev->fwnode, "arm,scatter-gather");
+	} else if (is_acpi_device_node(dev->fwnode)) {
+		/*
+		 * TMC_DEVID_NOSCAT test in tmc_etr_setup_caps(), has already ensured
+		 * this property is only checked for Coresight SoC 400 TMC configured
+		 * as ETR.
+		 */
+		ret = fwnode_property_read_u8(dev->fwnode, "arm-armhc97c-sg-enable", &val_u8);
+		if (!ret)
+			return !!val_u8;
+
+		if (fwnode_property_present(dev->fwnode, "arm,scatter-gather")) {
+			pr_warn_once("Deprecated ACPI property - arm,scatter-gather\n");
+			return true;
+		}
+	}
+	return false;
 }
 
 static inline bool tmc_etr_has_non_secure_access(struct tmc_drvdata *drvdata)
-- 
2.25.1


