Return-Path: <linux-kernel+bounces-49559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5277846BD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C10B28AA82
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2327CF06;
	Fri,  2 Feb 2024 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dzgEi2K7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7432D7C095;
	Fri,  2 Feb 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865733; cv=none; b=LA4E6+vuoPTtQbYaOZD5z647BUEzlL/4ykwh65N8ln5Q5qMytQtBL994P4Pij+DBTv/mwCBnWRHy+tXxo1eRZLgWf7iYIKKXJXT2ffcoMvwQKGQ2oMoexuXAgOsN+IJEdyU5vfMq/iNXLDsyt9+/WXriCQ2amwQkw6hLCsW473g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865733; c=relaxed/simple;
	bh=4lJwtT7W+z56piJEq1ajtdOi8X1weo4iQkqGFadRV9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Dkuff1g/kreI1oBsZJeEmvbKt177xmU2hd5ipmYw5UgKn1gpKRcO6Nhg23AYVt4rz129/OPCK9okWmA0uoh7fg9Lr+JF2C0zq3M4L7ZOctjddvuCoHZbe0sMdukFkgEOzYreCCu7n2A66oGA3GxlXtD3M2BQRRFXtjRwTIqen1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dzgEi2K7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865732; x=1738401732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4lJwtT7W+z56piJEq1ajtdOi8X1weo4iQkqGFadRV9Y=;
  b=dzgEi2K7+w8cvhDM8O4XH79L9vy2yxr6dSRIgYjqE9rwD7XTPHcz47Lx
   eQiYC96gOteeWrTWoC/TqjZ9qebTvx4JE/qrDkCqzimeDox8dDjNIszGN
   N6qnNcTnYlL/emmxcnFtqr59KqC2o8pKmJ2sgnQISuCyt1SdpN0b313pZ
   V4EvLrTo6mIvmmlE/+MIeZhdSd0TdIQ6Z4CeJF5OGHjSe+4+ouv2LHcRk
   PTJo8IQRjs+3XgjKFTw2aevkDAty/4yBjgmVjw5Bk16e2ftt+90S/yFmr
   oSgxPM4YXvzRoDXDKLUTRhJHwMc9GGSEjQBzmb7ylLiqF/vGhvs+8LeEY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483068"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483068"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639731"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:09 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 06/11] hwmon: (coretemp) Replace sensor_device_attribute with device_attribute
Date: Fri,  2 Feb 2024 17:21:39 +0800
Message-Id: <20240202092144.71180-7-rui.zhang@intel.com>
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

Replace sensor_device_attribute with device_attribute because
sensor_device_attribute->index is no longer used.

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 9a7bfc046c72..cdd1e069d5c1 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -85,7 +85,7 @@ struct temp_data {
 	u32 status_reg;
 	int attr_size;
 	bool is_pkg_data;
-	struct sensor_device_attribute sd_attrs[TOTAL_ATTRS];
+	struct device_attribute sd_attrs[TOTAL_ATTRS];
 	char attr_name[TOTAL_ATTRS][CORETEMP_NAME_LENGTH];
 	struct attribute *attrs[TOTAL_ATTRS + 1];
 	struct attribute_group attr_group;
@@ -340,9 +340,8 @@ static struct platform_device **zone_devices;
 static ssize_t show_label(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_LABEL]);
+	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_LABEL]);
 
 	if (tdata->is_pkg_data)
 		return sprintf(buf, "Package id %u\n", pdata->pkg_id);
@@ -354,8 +353,8 @@ static ssize_t show_crit_alarm(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
 	u32 eax, edx;
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_CRIT_ALARM]);
+	struct temp_data *tdata = container_of(devattr, struct temp_data,
+						sd_attrs[ATTR_CRIT_ALARM]);
 
 	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
@@ -367,8 +366,7 @@ static ssize_t show_crit_alarm(struct device *dev,
 static ssize_t show_tjmax(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TJMAX]);
+	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TJMAX]);
 	int tjmax;
 
 	mutex_lock(&tdata->update_lock);
@@ -381,8 +379,7 @@ static ssize_t show_tjmax(struct device *dev,
 static ssize_t show_ttarget(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TTARGET]);
+	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TTARGET]);
 	int ttarget;
 
 	mutex_lock(&tdata->update_lock);
@@ -398,8 +395,7 @@ static ssize_t show_temp(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
 	u32 eax, edx;
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TEMP]);
+	struct temp_data *tdata = container_of(devattr, struct temp_data, sd_attrs[ATTR_TEMP]);
 	int tjmax;
 
 	mutex_lock(&tdata->update_lock);
@@ -443,11 +439,11 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev)
 
 		snprintf(tdata->attr_name[i], CORETEMP_NAME_LENGTH,
 			 "temp%d_%s", attr_no, suffixes[i]);
-		sysfs_attr_init(&tdata->sd_attrs[i].dev_attr.attr);
-		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
-		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
-		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
+		sysfs_attr_init(&tdata->sd_attrs[i].attr);
+		tdata->sd_attrs[i].attr.name = tdata->attr_name[i];
+		tdata->sd_attrs[i].attr.mode = 0444;
+		tdata->sd_attrs[i].show = rd_ptr[i];
+		tdata->attrs[i] = &tdata->sd_attrs[i].attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
 	return sysfs_create_group(&dev->kobj, &tdata->attr_group);
-- 
2.34.1


