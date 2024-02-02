Return-Path: <linux-kernel+bounces-49563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B04846BDF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CA1F298F3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5887E570;
	Fri,  2 Feb 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNt2R9Kg"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1704677656;
	Fri,  2 Feb 2024 09:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865742; cv=none; b=k91K90IZrsYSX01tQG16Bt9IhaCc4759AHaWayAbiT6hJLcjUc+g+bHFaK3kl2Qmo7JCvFLQR5BcdXAJM1XhZAo2XEyCI7RuK/blnHayT+5fPQ4cN3uE3ZMuWW18/fiZeK2597HkU7XtXAROZ9kmBB9oQm82tzS5K/7rmxdNzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865742; c=relaxed/simple;
	bh=csZ3KHduA/9OB+PJyC6HR1VDQadqpILw6QFQkvTj3wY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pTVNYFVc/T9FIT6CHOlrrHTSnAbsrUIwfLFsWV2XbS41H1cub+1h3+9joKCvE6yOG6Lx5LqEUjGp5l/bo0EoR9SJge3Hx1nmg/dXou+YiiNrx8ywkSeJauhiMcmSRnq6N+5OiErx+nid7cXWBHmKd3UToyBEV7Ztmhcg0qPajZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNt2R9Kg; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865742; x=1738401742;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=csZ3KHduA/9OB+PJyC6HR1VDQadqpILw6QFQkvTj3wY=;
  b=BNt2R9Kg+BKEvduWJ5vUAGTnrd7S0ZDw3jBAj9vFy0RUeprsdeRL+oE4
   TOgFfLLEhOclT8+fHUMScH/dQ95tQvmbCvCYaYoPkWbNXW7zrHjxT/7lu
   kM6R7oYtHS2J6XfATRYgYkfXMPr5HgRS7+XDKWXRXFWdWHOOdDKqbhiVt
   MYibqx7BTHTz9lRXxAyFrZC9eJAcNnSV8wbQId0h73BOv4bMOCT8NPZYK
   hYNxXLN5Jj5GKro6LKyXpo5nqQbvbwms3UIykihdoMs6a+L8AkXfi7JZm
   /8LPNhG8DmnftC9W2tTw2SOQad9RRHdNs+cWAXAtE0y3oaWNdfSE4Mj1b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483126"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483126"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639776"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:19 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 10/11] hwmon: (coretemp) Remove redundant temp_data->is_pkg_data
Date: Fri,  2 Feb 2024 17:21:43 +0800
Message-Id: <20240202092144.71180-11-rui.zhang@intel.com>
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

temp_data->index saves the index in pdata->core_data[]. It is not used
by package temp_data.

Use temp_data->index as the indicator of package temp_data and remove
redundant temp_data->is_pkg_data.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 1a3b5ae0baca..e548f2145449 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -70,19 +70,16 @@ enum coretemp_attr_index {
  * @status_reg: One of IA32_THERM_STATUS or IA32_PACKAGE_THERM_STATUS,
  *		from where the temperature values should be read.
  * @attr_size:  Total number of pre-core attrs displayed in the sysfs.
- * @is_pkg_data: If this is 1, the temp_data holds pkgtemp data.
- *		Otherwise, temp_data holds coretemp data.
  */
 struct temp_data {
 	int temp;
 	int tjmax;
 	unsigned long last_updated;
 	unsigned int cpu;
-	unsigned int index;
+	int index;
 	u32 cpu_core_id;
 	u32 status_reg;
 	int attr_size;
-	bool is_pkg_data;
 	struct device_attribute sd_attrs[TOTAL_ATTRS];
 	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
 	struct attribute *attrs[TOTAL_ATTRS + 1];
@@ -149,6 +146,11 @@ static const struct tjmax_model tjmax_model_table[] = {
 				 */
 };
 
+static bool is_pkg_temp_data(struct temp_data *tdata)
+{
+	return tdata->index < 0;
+}
+
 static int adjust_tjmax(struct cpuinfo_x86 *c, u32 id, struct device *dev)
 {
 	/* The 100C is default for both mobile and non mobile CPUs */
@@ -341,7 +343,7 @@ static ssize_t show_label(struct device *dev,
 	struct platform_data *pdata = dev_get_drvdata(dev);
 	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_LABEL]);
 
-	if (tdata->is_pkg_data)
+	if (is_pkg_temp_data(tdata))
 		return sprintf(buf, "Package id %u\n", pdata->pkg_id);
 
 	return sprintf(buf, "Core %u\n", tdata->cpu_core_id);
@@ -433,7 +435,7 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev)
 		 * The attr number is always core id + 2
 		 * The Pkgtemp will always show up as temp1_*, if available
 		 */
-		int attr_no = tdata->is_pkg_data ? 1 : tdata->cpu_core_id + 2;
+		int attr_no = is_pkg_temp_data(tdata) ? 1 : tdata->cpu_core_id + 2;
 
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
@@ -484,6 +486,8 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 
 	if (pkg_flag) {
 		pdata->pkg_data = tdata;
+		/* Use tdata->index as indicator of package temp data */
+		tdata->index = -1;
 	} else {
 		tdata->index = ida_alloc_max(&pdata->ida, NUM_REAL_CORES - 1, GFP_KERNEL);
 		if (tdata->index < 0) {
@@ -495,7 +499,6 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 
 	tdata->status_reg = pkg_flag ? MSR_IA32_PACKAGE_THERM_STATUS :
 							MSR_IA32_THERM_STATUS;
-	tdata->is_pkg_data = pkg_flag;
 	tdata->cpu = cpu;
 	tdata->cpu_core_id = topology_core_id(cpu);
 	tdata->attr_size = MAX_CORE_ATTRS;
@@ -505,7 +508,7 @@ init_temp_data(struct platform_data *pdata, unsigned int cpu, int pkg_flag)
 
 static void destroy_temp_data(struct platform_data *pdata, struct temp_data *tdata)
 {
-	if (tdata->is_pkg_data) {
+	if (is_pkg_temp_data(tdata)) {
 		pdata->pkg_data = NULL;
 	} else {
 		pdata->core_data[tdata->index] = NULL;
-- 
2.34.1


