Return-Path: <linux-kernel+bounces-49561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FD3846C43
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63606B2E401
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF97D40B;
	Fri,  2 Feb 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QBxRwzWb"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6807460BBD;
	Fri,  2 Feb 2024 09:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865740; cv=none; b=SKvKzmcwy2ao8SH3eRFZ4jykBZ8MFmcYZqE4PRp8NiGeH3Rh+F7W/Ibvn/s+sRC89jX0HUmd2zRBvHfkaghUS3/9FdjFOi5u7NoYZsnaP9/qhLPn88+ZQ9cpRLiuf5uXBfWFSFKc/OzHHjvtU/cv5rE4R7qeYEaVywP8nwl/1NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865740; c=relaxed/simple;
	bh=+0SD87OA9HiAYQsvVbd0Jkh4AKAqYERvx5zrzAeIyD4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LKegYpozOUMZrLK8rVwkVrmX98eywF7Jzcpe4hE9MOFNcy2cOKOQ/oGxUBle1/if1Tho7Dkpw719h5i/watm+cSVmVYah8ax+IIZRhfn7h3Aivh6agegtEllqTwzcKWb70xiTh64bfNwjMaDV8X2vL4uGfZ5byQKQgmn3Cm3RIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QBxRwzWb; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865740; x=1738401740;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+0SD87OA9HiAYQsvVbd0Jkh4AKAqYERvx5zrzAeIyD4=;
  b=QBxRwzWbvALcwlW4iTwKIs1GggEwUu3CLYumX9OtxF9mbAz7SW8r9udL
   SRu9ElfFFmGicVqIsKP7DjEeNV7XU8lWfeyGcGP2nvlwqZclPS9xGxH7K
   qJ6Q/NF8DGpFmOgJtokd8Ny/8LomVPhdxiZujQMgeiQRmPo0H+Mx1NByr
   fRYLiwxh1Sj1V+9htYY/rMO1fuyWD5KRZvMSPmsdXhzYwhY8RXdevAQG3
   evOWMPC6wmt4nI8o/nTeFII5CWISzieKJt9W0okBbm4aNQnP9QAB+QWWD
   jSeruAmgHCBo3+kBTvSNfEUFC0EpGAbWUwnK35sl/KrlDX0PP1MzGltEo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483114"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483114"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639763"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:17 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 09/11] hwmon: (coretemp) Split package temp_data and core temp_data
Date: Fri,  2 Feb 2024 17:21:42 +0800
Message-Id: <20240202092144.71180-10-rui.zhang@intel.com>
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

Saving package temp_data and core temp_data in one array with different
offsets is fragile.

Split them and clean up crabbed maths and macros. This also fixes a
problem that pdata->core_data[0] was never used.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index a19799a302a2..1a3b5ae0baca 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -39,11 +39,8 @@ static int force_tjmax;
 module_param_named(tjmax, force_tjmax, int, 0444);
 MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
 
-#define PKG_SYSFS_ATTR_NO	1	/* Sysfs attribute for package temp */
-#define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
 #define NUM_REAL_CORES		512	/* Number of Real cores per cpu */
 #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
-#define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
 
 enum coretemp_attr_index {
 	ATTR_LABEL,
@@ -99,7 +96,8 @@ struct platform_data {
 	u16			pkg_id;
 	struct ida		ida;
 	struct cpumask		cpumask;
-	struct temp_data	*core_data[MAX_CORE_DATA];
+	struct temp_data	*pkg_data;
+	struct temp_data	*core_data[NUM_REAL_CORES];
 	struct device_attribute name_attr;
 };
 
@@ -479,31 +477,21 @@ static struct temp_data *
 init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 {
 	struct temp_data *tdata;
-	int index;
 
 	tdata = kzalloc(sizeof(struct temp_data), GFP_KERNEL);
 	if (!tdata)
 		return NULL;
 
-	/*
-	 * Get the index of tdata in pdata->core_data[]
-	 * tdata for package: pdata->core_data[1]
-	 * tdata for core: pdata->core_data[2] .. pdata->core_data[NUM_REAL_CORES + 1]
-	 */
 	if (pkg_flag) {
-		index = PKG_SYSFS_ATTR_NO;
+		pdata->pkg_data = tdata;
 	} else {
-		index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
-		if (index < 0) {
+		tdata->index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
+		if (tdata->index < 0) {
 			kfree(tdata);
 			return NULL;
 		}
-		index += BASE_SYSFS_ATTR_NO;
+		pdata->core_data[tdata->index] = tdata;
 	}
-	/* Index in pdata->core_data[] */
-	tdata->index = index;
-
-	pdata->core_data[index] = tdata;
 
 	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
 							MSR_IA32_THERM_STATUS;
@@ -517,9 +505,12 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 
 static void destroy_temp_data(struct platform_data *pdata, struct temp_data *tdata)
 {
-	pdata->core_data[tdata->index] = NULL;
-	if (!tdata->is_pkg_data)
-		ida_free(&pdata->ida, tdata->index - BASE_SYSFS_ATTR_NO);
+	if (tdata->is_pkg_data) {
+		pdata->pkg_data = NULL;
+	} else {
+		pdata->core_data[tdata->index] = NULL;
+		ida_free(&pdata->ida, tdata->index);
+	}
 	kfree(tdata);
 }
 
@@ -529,9 +520,9 @@ static struct temp_data *get_temp_data(struct platform_data *pdata, int cpu)
 
 	/* cpu < 0 means get pkg temp_data */
 	if (cpu < 0)
-		return pdata->core_data[PKG_SYSFS_ATTR_NO];
+		return pdata->pkg_data;
 
-	for (i = BASE_SYSFS_ATTR_NO; i < MAX_CORE_DATA; i++) {
+	for (i = 0; i < NUM_REAL_CORES; i++) {
 		if (pdata->core_data[i] &&
 		    pdata->core_data[i]->cpu_core_id == topology_core_id(cpu))
 			return pdata->core_data[i];
-- 
2.34.1


