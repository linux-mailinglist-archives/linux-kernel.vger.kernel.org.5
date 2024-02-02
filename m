Return-Path: <linux-kernel+bounces-49555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5031A846BD0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE02A2948E2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40F587995B;
	Fri,  2 Feb 2024 09:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bN+j0fVq"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E717992E;
	Fri,  2 Feb 2024 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865723; cv=none; b=SZ2SR74YsWbN5GYQtqPxic3Sfbf6XOFX9MkN3ZouoRABcQ0jdfs5P4qES/10vzyNm9uNTuouncy5LpQC9Ih/PyRgXkVxL5InklOWY9E7jV+Guyzg1986dD31KlvZ28ijJTdZPuSR2iQXGIc7i+SFcWhFnDc1cnKaviH+sJficQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865723; c=relaxed/simple;
	bh=75bHn3ApwS9Yr/xJ5rTI2RtddH16T0sqfaVRSuFSsD0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uif34HsLzteo7azbuH4JZ9ycVL3smOs201wqNUV62mXhpnmaBBksMlvITWe5uNGTA/3tEfBmNA+3D4QkqWK7Sba/BAQx7PFau98wRFBs1zQrz1UO2CDcQ8izjF5ypJEL0n1Mo1DumkDmOoXp4xCpw4TavFVCqfEDQtd4xJ4b+rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bN+j0fVq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865722; x=1738401722;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=75bHn3ApwS9Yr/xJ5rTI2RtddH16T0sqfaVRSuFSsD0=;
  b=bN+j0fVqbrKnxBxaN+7WZIcTCIlJsFaFr4FvoxJN00M2tkxyZAa1CtVy
   MhE8xBTpI1gPjPDMQBtvVaYNi52kvUs1g4VAWT+HhL7qSoutwMxmFldT3
   8CSNb9buYkmUk5Yz2Keix6YI12XNI98kq7cqUPk/CtUnEiMOMTKyi7Gqj
   uYNKF+gP/zatWpNBG4JD6ubZEN++0cmOGEuSig7yXVMYmaQ3k6X2ut3FF
   TR0RUBrC2/GCnq7sxok2pDjdf+wf8/0uV1BO9y/PXVco6tOHcVHINTCuy
   eagnVdDvfazN8HUM6noT++/ZrKABPtP/3LOGeSDtgHASywGSs2h6NsP68
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483048"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483048"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639688"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:21:58 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 02/11] hwmon: (coretemp) Fix bogus core_id to attr name mapping
Date: Fri,  2 Feb 2024 17:21:35 +0800
Message-Id: <20240202092144.71180-3-rui.zhang@intel.com>
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

Before commit 7108b80a542b ("hwmon/coretemp: Handle large core ID
value"), there is a fixed mapping between
1. cpu_core_id
2. the index in pdata->core_data[] array
3. the sysfs attr name, aka "tempX_"
The later two always equal cpu_core_id + 2.

After the commit, pdata->core_data[] index is got from ida so that it
can handle sparse core ids and support more cores within a package.

However, the commit erroneously maps the sysfs attr name to
pdata->core_data[] index instead of cpu_core_id + 2.

As a result, the code is not aligned with the comments, and brings user
visible changes in hwmon sysfs on systems with sparse core id.

For example, before commit 7108b80a542b ("hwmon/coretemp: Handle large
core ID value"),
/sys/class/hwmon/hwmon2/temp2_label:Core 0
/sys/class/hwmon/hwmon2/temp3_label:Core 1
/sys/class/hwmon/hwmon2/temp4_label:Core 2
/sys/class/hwmon/hwmon2/temp5_label:Core 3
/sys/class/hwmon/hwmon2/temp6_label:Core 4
/sys/class/hwmon/hwmon3/temp10_label:Core 8
/sys/class/hwmon/hwmon3/temp11_label:Core 9
after commit,
/sys/class/hwmon/hwmon2/temp2_label:Core 0
/sys/class/hwmon/hwmon2/temp3_label:Core 1
/sys/class/hwmon/hwmon2/temp4_label:Core 2
/sys/class/hwmon/hwmon2/temp5_label:Core 3
/sys/class/hwmon/hwmon2/temp6_label:Core 4
/sys/class/hwmon/hwmon2/temp7_label:Core 8
/sys/class/hwmon/hwmon2/temp8_label:Core 9

Restore the previous behavior and rework the code, comments and variable
names to avoid future confusions.

Fixes: 7108b80a542b ("hwmon/coretemp: Handle large core ID value")
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index e78c76919111..95f4c0b00b2d 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -419,7 +419,7 @@ static ssize_t show_temp(struct device *dev,
 }
 
 static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int attr_no)
+			     int index)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -431,13 +431,20 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 	};
 
 	for (i = 0; i < tdata->attr_size; i++) {
+		/*
+		 * We map the attr number to core id of the CPU
+		 * The attr number is always core id + 2
+		 * The Pkgtemp will always show up as temp1_*, if available
+		 */
+		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
 		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = attr_no;
+		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -495,26 +502,25 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	struct platform_data *pdata = platform_get_drvdata(pdev);
 	struct cpuinfo_x86 *c = &cpu_data(cpu);
 	u32 eax, edx;
-	int err, index, attr_no;
+	int err, index;
 
 	if (!housekeeping_cpu(cpu, HK_TYPE_MISC))
 		return 0;
 
 	/*
-	 * Find attr number for sysfs:
-	 * We map the attr number to core id of the CPU
-	 * The attr number is always core id + 2
-	 * The Pkgtemp will always show up as temp1_*, if available
+	 * Get the index of tdata in pdata->core_data[]
+	 * tdata for package: pdata->core_data[1]
+	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
 	 */
 	if (pkg_flag) {
-		attr_no = PKG_SYSFS_ATTR_NO;
+		index = PKG_SYSFS_ATTR_NO;
 	} else {
 		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (index < 0)
 			return index;
 
 		pdata->cpu_map[index] = topology_core_id(cpu);
-		attr_no = index + BASE_SYSFS_ATTR_NO;
+		index += BASE_SYSFS_ATTR_NO;
 	}
 
 	tdata = init_temp_data(cpu, pkg_flag);
@@ -540,20 +546,20 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 		if (get_ttarget(tdata, &pdev->dev) >= 0)
 			tdata->attr_size++;
 
-	pdata->core_data[attr_no] = tdata;
+	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, attr_no);
+	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
 	if (err)
 		goto exit_free;
 
 	return 0;
 exit_free:
-	pdata->core_data[attr_no] = NULL;
+	pdata->core_data[index] = NULL;
 	kfree(tdata);
 ida_free:
 	if (!pkg_flag)
-		ida_free(&pdata->ida, index);
+		ida_free(&pdata->ida, index - BASE_SYSFS_ATTR_NO);
 	return err;
 }
 
-- 
2.34.1


