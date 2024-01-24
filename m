Return-Path: <linux-kernel+bounces-37626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAEE183B2CA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:04:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C06B1C2305C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539AE1339B4;
	Wed, 24 Jan 2024 20:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IqnnQdny"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA13E7C091;
	Wed, 24 Jan 2024 20:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126666; cv=none; b=iknnCXm8njK6Y0txn+JKK5LAAhesJBxFfFBa2KYXfBVWQdGOPtDFQeWpGqeN4wt6yHnn3v9iunTjTYYjiohgIkZAELXS8W8Xdq3Ajs3jLwqc/NeBhEWpT19F1z/6CDrFmQkPksUd2QWISodM/Ck85PQ/jrLLJ+V+I3r5NW7qO8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126666; c=relaxed/simple;
	bh=mYxIOVPok7zj5mr8tVu7SKhQQM/JT9jvpgs14KCdT/k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7UMchOmWEsdIoKL3Y/w3tRrJ4QRXleNlm69r7rOXnBSydCMQDtzP/p+0x9fqmGJV8B3TzeMTYWe4NR6eoEDTK1pxwUgmfFp80lckbGGQdh1JsCsaH+cCC7mIy39f7iFzcLQyiJXmALBj4LU9t8ssNzrbPJOQZxhc7mQMmAsV3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IqnnQdny; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706126665; x=1737662665;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mYxIOVPok7zj5mr8tVu7SKhQQM/JT9jvpgs14KCdT/k=;
  b=IqnnQdnyYth76mX8uj/d/jLxPZ+9WJSj5lDRgCFJGYLwQSmZCCWmU+xT
   OPdBpz3gwOEeW6loZNpbOVD9FCw4RzEbcwodZ05tARsCIwbsOibKL47Ks
   vzqUZppSXPDIB1DWyjr8q4/il3nRX+vYsyxCActpJ6j8VMR6yb2axnnTZ
   hh/qwi3BJq7jhVdQ2KkbneKUBSQJi5P5dUv2K86d/aVJY9FQmlJNp6ROi
   LV6J7fe7OhX6FVNvf+evOs3O8p5cRdg1OeDQxXPocehaqRh9gcJHz8I2l
   0yw6PsmnHhN+C6bO7J9HUMUOC1pnOE2E7DPW3nxFCoOAE4VFwRXU1M3Vh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1836101"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1836101"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="1117735125"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1117735125"
Received: from vverma7-mobl3.amr.corp.intel.com (HELO [10.0.0.223]) ([10.251.14.61])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 12:04:21 -0800
From: Vishal Verma <vishal.l.verma@intel.com>
Date: Wed, 24 Jan 2024 12:03:47 -0800
Subject: [PATCH v7 2/5] dax/bus.c: replace several sprintf() with
 sysfs_emit()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240124-vv-dax_abi-v7-2-20d16cb8d23d@intel.com>
References: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
In-Reply-To: <20240124-vv-dax_abi-v7-0-20d16cb8d23d@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Oscar Salvador <osalvador@suse.de>
Cc: linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, David Hildenbrand <david@redhat.com>, 
 Dave Hansen <dave.hansen@linux.intel.com>, 
 Huang Ying <ying.huang@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=5299;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=mYxIOVPok7zj5mr8tVu7SKhQQM/JT9jvpgs14KCdT/k=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKkbc51aNcyLd59M+vAnQJuv9cKWC28PyIbMOhQbrPNRb
 5Gwv/eUjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAExkWxfD/+qY2iizk+avOY5J
 8LJd2RK2fdbEB2ZbOKZFZ3Xsal646Bgjw5SvBW9Pvevi+zG/+cnxb//auSw3rG44w/3KtfNY85z
 J+XwA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF

There were several places where drivers/dax/bus.c uses 'sprintf' to
print sysfs data. Since a sysfs_emit() helper is available specifically
for this purpose, replace all the sprintf() usage for sysfs with
sysfs_emit() in this file.

Cc: Dan Williams <dan.j.williams@intel.com>
Reported-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index cb148f74ceda..0fd948a4443e 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -269,7 +269,7 @@ static ssize_t id_show(struct device *dev,
 {
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", dax_region->id);
+	return sysfs_emit(buf, "%d\n", dax_region->id);
 }
 static DEVICE_ATTR_RO(id);
 
@@ -278,8 +278,8 @@ static ssize_t region_size_show(struct device *dev,
 {
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%llu\n", (unsigned long long)
-			resource_size(&dax_region->res));
+	return sysfs_emit(buf, "%llu\n",
+			  (unsigned long long)resource_size(&dax_region->res));
 }
 static struct device_attribute dev_attr_region_size = __ATTR(size, 0444,
 		region_size_show, NULL);
@@ -289,7 +289,7 @@ static ssize_t region_align_show(struct device *dev,
 {
 	struct dax_region *dax_region = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%u\n", dax_region->align);
+	return sysfs_emit(buf, "%u\n", dax_region->align);
 }
 static struct device_attribute dev_attr_region_align =
 		__ATTR(align, 0400, region_align_show, NULL);
@@ -322,7 +322,7 @@ static ssize_t available_size_show(struct device *dev,
 	size = dax_region_avail_size(dax_region);
 	up_read(&dax_region_rwsem);
 
-	return sprintf(buf, "%llu\n", size);
+	return sysfs_emit(buf, "%llu\n", size);
 }
 static DEVICE_ATTR_RO(available_size);
 
@@ -340,7 +340,7 @@ static ssize_t seed_show(struct device *dev,
 	if (rc)
 		return rc;
 	seed = dax_region->seed;
-	rc = sprintf(buf, "%s\n", seed ? dev_name(seed) : "");
+	rc = sysfs_emit(buf, "%s\n", seed ? dev_name(seed) : "");
 	up_read(&dax_region_rwsem);
 
 	return rc;
@@ -361,7 +361,7 @@ static ssize_t create_show(struct device *dev,
 	if (rc)
 		return rc;
 	youngest = dax_region->youngest;
-	rc = sprintf(buf, "%s\n", youngest ? dev_name(youngest) : "");
+	rc = sysfs_emit(buf, "%s\n", youngest ? dev_name(youngest) : "");
 	up_read(&dax_region_rwsem);
 
 	return rc;
@@ -763,7 +763,7 @@ static ssize_t start_show(struct device *dev,
 	dax_range = get_dax_range(dev);
 	if (!dax_range)
 		return -ENXIO;
-	rc = sprintf(buf, "%#llx\n", dax_range->range.start);
+	rc = sysfs_emit(buf, "%#llx\n", dax_range->range.start);
 	put_dax_range();
 
 	return rc;
@@ -779,7 +779,7 @@ static ssize_t end_show(struct device *dev,
 	dax_range = get_dax_range(dev);
 	if (!dax_range)
 		return -ENXIO;
-	rc = sprintf(buf, "%#llx\n", dax_range->range.end);
+	rc = sysfs_emit(buf, "%#llx\n", dax_range->range.end);
 	put_dax_range();
 
 	return rc;
@@ -795,7 +795,7 @@ static ssize_t pgoff_show(struct device *dev,
 	dax_range = get_dax_range(dev);
 	if (!dax_range)
 		return -ENXIO;
-	rc = sprintf(buf, "%#lx\n", dax_range->pgoff);
+	rc = sysfs_emit(buf, "%#lx\n", dax_range->pgoff);
 	put_dax_range();
 
 	return rc;
@@ -969,7 +969,7 @@ static ssize_t size_show(struct device *dev,
 	size = dev_dax_size(dev_dax);
 	up_write(&dax_dev_rwsem);
 
-	return sprintf(buf, "%llu\n", size);
+	return sysfs_emit(buf, "%llu\n", size);
 }
 
 static bool alloc_is_aligned(struct dev_dax *dev_dax, resource_size_t size)
@@ -1233,7 +1233,7 @@ static ssize_t align_show(struct device *dev,
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
-	return sprintf(buf, "%d\n", dev_dax->align);
+	return sysfs_emit(buf, "%d\n", dev_dax->align);
 }
 
 static ssize_t dev_dax_validate_align(struct dev_dax *dev_dax)
@@ -1311,7 +1311,7 @@ static ssize_t target_node_show(struct device *dev,
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
 
-	return sprintf(buf, "%d\n", dev_dax_target_node(dev_dax));
+	return sysfs_emit(buf, "%d\n", dev_dax_target_node(dev_dax));
 }
 static DEVICE_ATTR_RO(target_node);
 
@@ -1327,7 +1327,7 @@ static ssize_t resource_show(struct device *dev,
 	else
 		start = dev_dax->ranges[0].range.start;
 
-	return sprintf(buf, "%#llx\n", start);
+	return sysfs_emit(buf, "%#llx\n", start);
 }
 static DEVICE_ATTR(resource, 0400, resource_show, NULL);
 
@@ -1338,14 +1338,14 @@ static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
 	 * We only ever expect to handle device-dax instances, i.e. the
 	 * @type argument to MODULE_ALIAS_DAX_DEVICE() is always zero
 	 */
-	return sprintf(buf, DAX_DEVICE_MODALIAS_FMT "\n", 0);
+	return sysfs_emit(buf, DAX_DEVICE_MODALIAS_FMT "\n", 0);
 }
 static DEVICE_ATTR_RO(modalias);
 
 static ssize_t numa_node_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
-	return sprintf(buf, "%d\n", dev_to_node(dev));
+	return sysfs_emit(buf, "%d\n", dev_to_node(dev));
 }
 static DEVICE_ATTR_RO(numa_node);
 

-- 
2.43.0


