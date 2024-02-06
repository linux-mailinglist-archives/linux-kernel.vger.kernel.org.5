Return-Path: <linux-kernel+bounces-54170-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4DD684ABCC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:54:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D895287364
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 01:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB10856768;
	Tue,  6 Feb 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LogcS3LB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EE556754;
	Tue,  6 Feb 2024 01:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707184462; cv=none; b=RSw86JvFDFwJlGKJtKlChsRGPsD9I12Pu16Gw52zXf9RE5xrq7ASb9VmUrOsFWfc8j2dzfHA4ayuQFU03dMAm9ahAn6eXgpL/xR49hx/+mTprJRSQknprEJ51bk4h8s+eKmlLgcV6KyfDa2qPxgFX6xdvRU20aN+DlC7hn0oRLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707184462; c=relaxed/simple;
	bh=3VD20WQL3xgexpVKiN8NcOlVno2MagYksB604ZIZyvU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ktkxejuQ8j4OKojek6DmYl8wdG7OIeJfa3tfsNicqA3wpUWkR8hsq4pUC8V7AgJWYfn6u22Ic5Z8uy1ykJWNIUnKJuuB6bEkv6WzuJ+fWUX5j6nuC8F+UCiKruvV6xemuhEA9VYnN3LtVcnHhTosvmd6BBjadbCX4MaJplz0JR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LogcS3LB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707184460; x=1738720460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3VD20WQL3xgexpVKiN8NcOlVno2MagYksB604ZIZyvU=;
  b=LogcS3LBTm/+GnOu6TUQQK0m+hqwk9/Iylmxw0DVbNMUPrJBdD0p8Rrn
   Uepxnur3o9ihhO4DovjTMmSI3kJePS+UwSPX6aGDe6HfZ8AQSgjk/UBCi
   6sDRR3eFovEFMr6JnT+yKA6jZdsocpXzjaQEeEXxZ+ByURdxJsFvzcB0c
   UfBgDZDIkhsMPFpPQyWURbL4Cw0jQKSS00GUh1cWwfbYKPfzn3Z/yuYlA
   Y/CmxShqxgB8S7Zl6T4kVGxw9kStP6FWj50invJrPkEAFPF8bor0dgmzR
   TefMyGYIG8rtt65+hvVNf/11kxJQ2hGY/bLE7ltt8PZiGD+X00K4XSStF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="12001711"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="12001711"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 17:54:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="1200612"
Received: from weizhihu-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.211.111])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 17:54:18 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: rafael.j.wysocki@intel.com
Cc: linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	srinivas.pandruvada@intel.com
Subject: [PATCH] thermal/intel: Fix intel_tcc_get_temp() to support negative CPU temperature
Date: Tue,  6 Feb 2024 09:54:09 +0800
Message-Id: <20240206015409.619127-1-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPU temperature can be negative in some cases. Thus the negative CPU
temperature should not be considered as a failure.

Fix intel_tcc_get_temp() and its users to support negative CPU
temperature.

Fixes: a3c1f066e1c5 ("thermal/intel: Introduce Intel TCC library")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 .../intel/int340x_thermal/processor_thermal_device.c |  8 ++++----
 drivers/thermal/intel/intel_tcc.c                    | 12 ++++++------
 drivers/thermal/intel/x86_pkg_temp_thermal.c         |  8 ++++----
 include/linux/intel_tcc.h                            |  2 +-
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
index 649f67fdf345..d75fae7b7ed2 100644
--- a/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
+++ b/drivers/thermal/intel/int340x_thermal/processor_thermal_device.c
@@ -176,14 +176,14 @@ static int proc_thermal_get_zone_temp(struct thermal_zone_device *zone,
 					 int *temp)
 {
 	int cpu;
-	int curr_temp;
+	int curr_temp, ret;
 
 	*temp = 0;
 
 	for_each_online_cpu(cpu) {
-		curr_temp = intel_tcc_get_temp(cpu, false);
-		if (curr_temp < 0)
-			return curr_temp;
+		ret = intel_tcc_get_temp(cpu, &curr_temp, false);
+		if (ret < 0)
+			return ret;
 		if (!*temp || curr_temp > *temp)
 			*temp = curr_temp;
 	}
diff --git a/drivers/thermal/intel/intel_tcc.c b/drivers/thermal/intel/intel_tcc.c
index 2e5c741c41ca..5e8b7f34b395 100644
--- a/drivers/thermal/intel/intel_tcc.c
+++ b/drivers/thermal/intel/intel_tcc.c
@@ -103,18 +103,19 @@ EXPORT_SYMBOL_NS_GPL(intel_tcc_set_offset, INTEL_TCC);
 /**
  * intel_tcc_get_temp() - returns the current temperature
  * @cpu: cpu that the MSR should be run on, nagative value means any cpu.
+ * @temp: pointer to the memory for saving cpu temperature.
  * @pkg: true: Package Thermal Sensor. false: Core Thermal Sensor.
  *
  * Get the current temperature returned by the CPU core/package level
  * thermal sensor, in degrees C.
  *
- * Return: Temperature in degrees C on success, negative error code otherwise.
+ * Return: 0 on success, negative error code otherwise.
  */
-int intel_tcc_get_temp(int cpu, bool pkg)
+int intel_tcc_get_temp(int cpu, int *temp, bool pkg)
 {
 	u32 low, high;
 	u32 msr = pkg ? MSR_IA32_PACKAGE_THERM_STATUS : MSR_IA32_THERM_STATUS;
-	int tjmax, temp, err;
+	int tjmax, err;
 
 	tjmax = intel_tcc_get_tjmax(cpu);
 	if (tjmax < 0)
@@ -131,9 +132,8 @@ int intel_tcc_get_temp(int cpu, bool pkg)
 	if (!(low & BIT(31)))
 		return -ENODATA;
 
-	temp = tjmax - ((low >> 16) & 0x7f);
+	*temp = tjmax - ((low >> 16) & 0x7f);
 
-	/* Do not allow negative CPU temperature */
-	return temp >= 0 ? temp : -ENODATA;
+	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(intel_tcc_get_temp, INTEL_TCC);
diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 11a7f8108bbb..61c3d450ee60 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -108,11 +108,11 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 static int sys_get_curr_temp(struct thermal_zone_device *tzd, int *temp)
 {
 	struct zone_device *zonedev = thermal_zone_device_priv(tzd);
-	int val;
+	int val, ret;
 
-	val = intel_tcc_get_temp(zonedev->cpu, true);
-	if (val < 0)
-		return val;
+	ret = intel_tcc_get_temp(zonedev->cpu, &val, true);
+	if (ret < 0)
+		return ret;
 
 	*temp = val * 1000;
 	pr_debug("sys_get_curr_temp %d\n", *temp);
diff --git a/include/linux/intel_tcc.h b/include/linux/intel_tcc.h
index f422612c28d6..8ff8eabb4a98 100644
--- a/include/linux/intel_tcc.h
+++ b/include/linux/intel_tcc.h
@@ -13,6 +13,6 @@
 int intel_tcc_get_tjmax(int cpu);
 int intel_tcc_get_offset(int cpu);
 int intel_tcc_set_offset(int cpu, int offset);
-int intel_tcc_get_temp(int cpu, bool pkg);
+int intel_tcc_get_temp(int cpu, int *temp, bool pkg);
 
 #endif /* __INTEL_TCC_H__ */
-- 
2.34.1


