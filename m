Return-Path: <linux-kernel+bounces-49558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 747EF846BD6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:23:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13A981F2519F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535447C0B0;
	Fri,  2 Feb 2024 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HgRJHwQm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1DD87C096;
	Fri,  2 Feb 2024 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706865730; cv=none; b=RajmWtHPOub5XOxi2PxTAeKM5J84Y6Zc3FeMwXNr1pafN/1qf/QXjp2BI5sCMJsCAmVIM5FMer4Q7O4yXu/L+dwpq+YwDjxU7Q8PQM53zE2DNAYd/kK1gemZzX1ffiEJjdtjLV/ezezafGCtf4ZoOD0gdvvAP2hpfQ6m9Nq/6iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706865730; c=relaxed/simple;
	bh=RleCYu67aFEcNUbHUt0P9qINaHPy/r38vowQxOiPOe0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=re01RmuSCd8Q3e2//osAU0J4S1eV61PXoa1STJ0u5G2CwEPM3kvQT5vctFjk8gboj/Ma3Ode+HAR0spO8OFUmqtWGJFHmRxBpgvK8jc1e//9mxYXzCqCHNYiuZWTXSGf1Ksm0l9DNZ9CsHKsGPXjjf5qfIjOeAuyhxGt3fkODgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HgRJHwQm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706865729; x=1738401729;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RleCYu67aFEcNUbHUt0P9qINaHPy/r38vowQxOiPOe0=;
  b=HgRJHwQm0PPZh9FENVP8E9mo8D9azNns9TwDlVdf961BsO+ep8FlH1Gb
   MT8n8//l/oJkMAL3HQ2u4QtysEahJ1DZjkZsZlRQf/GcbUPQxAs3TXmyl
   mTYqOq2t7rcT1xg7dtD8A8YMpk/Xg8vHi1in3xeL6d7PzxebHMwJY4muC
   6Q/OHuH0lzBDuyjRXmsyJyomA8GZugnRPnnnTCfQjYDlbc9AjKXrwlhg8
   QRW9dWK4JD0unXpS72+ClCEbCUj4u7/ANLtVSnAEhgntFTdYv6cTB0dk/
   YsiYVijSpYs8H/nZtrrETo+JrsHs8Hh8OpoDRNlI1YuVsqwqBEGAk8tJJ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10971"; a="11483063"
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="11483063"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,237,1701158400"; 
   d="scan'208";a="4639718"
Received: from wangnin3-mobl.ccr.corp.intel.com (HELO rzhang1-mobl7.ccr.corp.intel.com) ([10.254.214.177])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2024 01:22:06 -0800
From: Zhang Rui <rui.zhang@intel.com>
To: linux@roeck-us.net,
	jdelvare@suse.com
Cc: fenghua.yu@intel.com,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH V2 05/11] hwmon: (coretemp) Remove unnecessary dependency of array index
Date: Fri,  2 Feb 2024 17:21:38 +0800
Message-Id: <20240202092144.71180-6-rui.zhang@intel.com>
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

When sensor_device_attribute pointer is available, use container_of() to
get the temp_data address.

This removes the unnecessary dependency of cached index in
pdata->core_data[].

No functional change.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index 32f99cf6308b..9a7bfc046c72 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -342,7 +342,7 @@ static ssize_t show_label(struct device *dev,
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
 	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_LABEL]);
 
 	if (tdata->is_pkg_data)
 		return sprintf(buf, "Package id %u\n", pdata->pkg_id);
@@ -355,8 +355,7 @@ static ssize_t show_crit_alarm(struct device *dev,
 {
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_CRIT_ALARM]);
 
 	mutex_lock(&tdata->update_lock);
 	rdmsr_on_cpu(tdata->cpu, tdata->status_reg, &eax, &edx);
@@ -369,8 +368,7 @@ static ssize_t show_tjmax(struct device *dev,
 			struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TJMAX]);
 	int tjmax;
 
 	mutex_lock(&tdata->update_lock);
@@ -384,8 +382,7 @@ static ssize_t show_ttarget(struct device *dev,
 				struct device_attribute *devattr, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TTARGET]);
 	int ttarget;
 
 	mutex_lock(&tdata->update_lock);
@@ -402,8 +399,7 @@ static ssize_t show_temp(struct device *dev,
 {
 	u32 eax, edx;
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct platform_data *pdata = dev_get_drvdata(dev);
-	struct temp_data *tdata = pdata->core_data[attr->index];
+	struct temp_data *tdata = container_of(attr, struct temp_data, sd_attrs[ATTR_TEMP]);
 	int tjmax;
 
 	mutex_lock(&tdata->update_lock);
@@ -426,8 +422,7 @@ static ssize_t show_temp(struct device *dev,
 	return sprintf(buf, "%d\n", tdata->temp);
 }
 
-static int create_core_attrs(struct temp_data *tdata, struct device *dev,
-			     int index)
+static int create_core_attrs(struct temp_data *tdata, struct device *dev)
 {
 	int i;
 	static ssize_t (*const rd_ptr[TOTAL_ATTRS]) (struct device *dev,
@@ -452,7 +447,6 @@ static int create_core_attrs(struct temp_data *tdata, struct device *dev,
 		tdata->sd_attrs[i].dev_attr.attr.name = tdata->attr_name[i];
 		tdata->sd_attrs[i].dev_attr.attr.mode = 0444;
 		tdata->sd_attrs[i].dev_attr.show = rd_ptr[i];
-		tdata->sd_attrs[i].index = index;
 		tdata->attrs[i] = &tdata->sd_attrs[i].dev_attr.attr;
 	}
 	tdata->attr_group.attrs = tdata->attrs;
@@ -557,7 +551,7 @@ static int create_core_data(struct platform_device *pdev, unsigned int cpu,
 	pdata->core_data[index] = tdata;
 
 	/* Create sysfs interfaces */
-	err = create_core_attrs(tdata, pdata->hwmon_dev, index);
+	err = create_core_attrs(tdata, pdata->hwmon_dev);
 	if (err)
 		goto exit_free;
 
-- 
2.34.1


