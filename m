Return-Path: <linux-kernel+bounces-49562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A0846BDD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:24:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A49531C27357
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67DB7D41B;
	Fri,  2 Feb 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjxjGqe3"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1227D3E6;
	Fri,  2 Feb 2024 09:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865741; cv=none; b=iG+g3n8xLCTG7TC0uFYOdKhglmsem9xXD70SrT2E9+oTOZbPwzqhPQ/ynX/hqx8jg+dHXM+zgnTgwUwR022cIy1AIM6VAo/wN4Ky+HWRxMLmfstWTrS2hLc81/ROdL5G6cNCD09kHbiM5UFVd6GejTCPD5VrXPd/W8iLEH1fELA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865741; c=relaxed/simple;
	bh=ga1g5JzpiWhZ7qkFsQ1GKbvCbtBl/zg26nkpBuYMJvs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iT0oVCQkBgX+fm+horKQ8+97CmeO7SpFeVjxurJz7RdKBFbVGnTeQb+PD9sfJxXcyS8bMCYDj93cFzoo42F50mqlNgFf7lWy47YOt5eIvu2ZFSYXpEE2we4gW91MsLB1sR7uKjw7QA/rFPTKWa3jqX84zQ+dupN+J0WmBrUqJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjxjGqe3; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865738; x=1738401738;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ga1g5JzpiWhZ7qkFsQ1GKbvCbtBl/zg26nkpBuYMJvs=;
  b=ZjxjGqe3BwGc8NgGR2RQc11V0zjisTBfPUr5PjP8TpHUZ1n2Mo0BPOer
   yEr/oyWlyMa2He8isJowryjo8rLEj7deSIVPHZxk5Z/rK7MypO7TGIv/v
   0b5Bq4pVqXNuFN29/PWkbCB79GIzxfNjaVSrgRmVDU/BcK626h/EQwYq2
   tEPh+XlNrTqbWfGGMdF5mke/KNDe7KUU5lAWJzCztKpdQPVj005drdwKA
   +ZaQ5N7E1csvS+9uFfUnJ3aY/vwxEyeu+yPMaxCgQzZt5d0oc3fz8nAkL
   9hI8qxuAcXj0EKjb4mVHZmqha3/KP3Zt59/Vhkc+sfzI9e/qB5XGyupoa
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483102"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483102"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639750"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:14 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 08/11] hwmon: (coretemp) Abstract core_temp helpers
Date: Fri,  2 Feb 2024 17:21:41 +0800
Message-Id: <20240202092144.71180-9-rui.zhang@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202092144.71180-1-rui.zhang@intel.com>
References: <20240202092144.71180-1-rui.zhang@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

coretemp driver has an obscure and fragile logic for handling package
and core temperature data.

Place the logic in newly introduced helpers for further optimizations.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 118 +++++++++++++++++++++------------------
 1 file changed, 64 insertions(+), 54 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 29ee8e0c0fe9..a19799a302a2 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -81,6 +81,7 @@ struct temp_data {
 	int tjmax;
 	unsigned long last_updated;
 	unsigned int cpu;
+	unsigned int index;
 	u32 cpu_core_id;
 	u32 status_reg;
 	int attr_size;
@@ -474,14 +475,36 @@ static struct platform_device *coretemp_get_pdev(unsigned int cpu)
 	return NULL;
 }
 
-static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
+static struct temp_data *
+init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 {
 	struct temp_data *tdata;
+	int index;
 
 	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
 	if (!tdata)
 		return NULL;
 
+	/*
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
+	 */
+	if (pkg_flag) {
+		index = PKG_SYSFS_ATTR_NO;
+	} else {
+		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
+		if (index < 0) {
+			kfree(tdata);
+			return NULL;
+		}
+		index += BASE_SYSFS_ATTR_NO;
+	}
+	/* Index in pdata->core_data[] */
+	tdata->index = index;
+
+	pdata->core_data[index] = tdata;
+
 	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
 							MSR_IA32_THERM_STATUS;
 	tdata->is_pkg_data = pkg_flag;
@@ -492,6 +515,30 @@ static struct temp_data *init_temp_data(unsigned int cpu, int pkg_flag)
 	return tdata;
 }
 
+static void destroy_temp_data(struct platform_data *pdata, struct temp_data *tdata)
+{
+	pdata->core_data[tdata->index] = NULL;
+	if (!tdata->is_pkg_data)
+		ida_free(&pdata->ida, tdata->index - BASE_SYSFS_ATTR_NO);
+	kfree(tdata);
+}
+
+static struct temp_data *get_temp_data(struct platform_data *pdata, int cpu)
+{
+	int i;
+
+	/* cpu < 0 means get pkg temp_data */
+	if (cpu < 0)
+		return pdata->core_data[PKG_SYSFS_ATTR_NO];
+
+	for (i = BASE_SYSFS_ATTR_NO; i < MAX_CORE_DATA; i++) {
+		if (pdata->core_data[i] &&
+		    pdata->core_data[i]->cpu_core_id == topology_core_id(cpu))
+			return pdata->core_data[i];
+	}
+	return NULL;
+}
+
 static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 			    int pkg_flag)
 {
@@ -499,36 +546,19 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index;
+	int err;
 
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
-	/*
-	 * Get the index of tdata in pdata->core_data[]
-	 * tdata for package: pdata->core_data[1]
-	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
-	 */
-	if (pkg_flag) {
-		index = PKG_SYSFS_ATTR_NO;
-	} else {
-		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
-		if (index < 0)
-			return index;
-
-		index += BASE_SYSFS_ATTR_NO;
-	}
-
-	tdata = init_temp_data(cpu, pkg_flag);
-	if (!tdata) {
-		err = -ENOMEM;
-		goto ida_free;
-	}
+	tdata = init_temp_data(pdata, cpu, pkg_flag);
+	if (!tdata)
+		return -ENOMEM;
 
 	/* Test if we can access the status register */
 	err = rdmsr_safe_on_cpu(cpu, tdata->status_reg, &eax, &edx);
 	if (err)
-		goto exit_free;
+		goto err;
 
 	/* Make sure tdata->tjmax is a valid indicator for dynamic/static tjmax */
 	get_tjmax(tdata, &pdev->dev);
@@ -542,20 +572,15 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
-	pdata->core_data[index] = tdata;
-
 	/* Create sysfs interfaces */
 	err = create_core_attrs(tdata, pdata->hwmon_dev);
 	if (err)
-		goto exit_free;
+		goto err;
 
 	return 0;
-exit_free:
-	pdata->core_data[index] = NULL;
-	kfree(tdata);
-ida_free:
-	if (!pkg_flag)
-		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
+
+err:
+	destroy_temp_data(pdata, tdata);
 	return err;
 }
 
@@ -566,10 +591,8 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
 		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
 }
 
-static void coretemp_remove_core(struct platform_data *pdata, int indx)
+static void coretemp_remove_core(struct platform_data *pdata, struct temp_data *tdata)
 {
-	struct temp_data *tdata = pdata->core_data[indx];
-
 	/* if we errored on add then this is already gone */
 	if (!tdata)
 		return;
@@ -577,11 +600,7 @@ static void coretemp_remove_core(struct platform_data *pdata, int indx)
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-	kfree(pdata->core_data[indx]);
-	pdata->core_data[indx] = NULL;
-
-	if (indx >= BASE_SYSFS_ATTR_NO)
-		ida_free(&pdata->ida, indx - BASE_SYSFS_ATTR_NO);
+	destroy_temp_data(pdata, tdata);
 }
 
 static int coretemp_device_add(int zoneid)
@@ -694,7 +713,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int i, target;
+	int target;
 
 	/* No need to tear down any interfaces for suspend */
 	if (cpuhp_tasks_frozen)
@@ -705,16 +724,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	if (!pd->hwmon_dev)
 		return 0;
 
-	for (i = BASE_SYSFS_ATTR_NO; i < MAX_CORE_DATA; i++) {
-		if (pd->core_data[i] && pd->core_data[i]->cpu_core_id == topology_core_id(cpu))
-			break;
-	}
-
-	/* Too many cores and this core is not populated, just return */
-	if (i == MAX_CORE_DATA)
-		return 0;
-
-	tdata = pd->core_data[i];
+	tdata = get_temp_data(pd, cpu);
 
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
@@ -725,7 +735,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
-		coretemp_remove_core(pd, i);
+		coretemp_remove_core(pd, tdata);
 	} else if (tdata && tdata->cpu == cpu) {
 		mutex_lock(&tdata->update_lock);
 		tdata->cpu = target;
@@ -735,10 +745,10 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	/*
 	 * If all cores in this pkg are offline, remove the interface.
 	 */
-	tdata = pd->core_data[PKG_SYSFS_ATTR_NO];
+	tdata = get_temp_data(pd, -1);
 	if (cpumask_empty(&pd->cpumask)) {
 		if (tdata)
-			coretemp_remove_core(pd, PKG_SYSFS_ATTR_NO);
+			coretemp_remove_core(pd, tdata);
 		hwmon_device_unregister(pd->hwmon_dev);
 		pd->hwmon_dev = NULL;
 		return 0;
-- 
2.34.1


