Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC3678BDCF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbjH2FYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235662AbjH2FYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F70199;
        Mon, 28 Aug 2023 22:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286650; x=1724822650;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jW5ttK5384oAyuCDjymBvEoWsT6lz5AHA/DU20rtvhA=;
  b=m/j3zsKvejYyvkzc1CO8pmyrL0T211r5U6eZY6UpqnIC0+dYGgcCRfgk
   rQ/tYZGkUzG8pWJIdBZZaCwkhQPpuEHuQbNnhn2MsKWbI3OwW9i7v1p2h
   6E2pUdDrEtFoKVJjfDGZUhmZNjs+WkJcGvj4bYMcHktoyqKu4e6Vsp65s
   wSiWMUnWrTXXmh/Kft/x+YrOP4BavD9NRumN7G29MJTluZznT7ZcRElqb
   RZ2UkquJhB99GHjx2RCmzEwxAWJkEaW03Yob4KOwIeKb1bDXLZws78EHS
   wbPIYPV5CdxmarveLJ5z1v2rMM/pCgihCsQ6/a6SLGdM279KrH14gG3F+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625246"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625246"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556421"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556421"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:48 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:05 -0700
Subject: [PATCH RFC v2 14/18] dax/region: Support DAX device creation on
 dynamic DAX regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-14-f740c47e7916@intel.com>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
        linux-kernel@vger.kernel.org
X-Mailer: b4 0.13-dev-c6835
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=15280;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=jW5ttK5384oAyuCDjymBvEoWsT6lz5AHA/DU20rtvhA=;
 b=Upm6KoRvNPk9sMyBoPBwy5uWJBkDrHViAzplqmE8KZQ4j/BBmZp/aOQi1+08GvVSSxqL1Fl+d
 mP/yf4X1CF1D4ekmb0WydhtDAPXLx3sC0zvGu75yAAgVRopFxVotl5d
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dynamic Capacity (DC) DAX regions have a list of extents which define
the memory of the region which is available.

Now that DAX region extents are fully realized support DAX device
creation on dynamic regions by adjusting the allocation algorithms
to account for the extents.  Remember also references must be held on
the extents until the DAX devices are done with the memory.

Redefine the region available size to include only extent space.  Reuse
the size allocation algorithm by defining sub-resources for each extent
and limiting range allocation to those extents which have space.  Do not
support direct mapping of DAX devices on dynamic devices.

Enhance DAX device range objects to hold references on the extents until
the DAX device is destroyed.

NOTE: At this time all extents within a region are created equally.
However, labels are associated with extents which can be used with
future DAX device labels to group which extents are used.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c         | 157 +++++++++++++++++++++++++++++++++++++++-------
 drivers/dax/cxl.c         |  44 +++++++++++++
 drivers/dax/dax-private.h |   5 ++
 3 files changed, 182 insertions(+), 24 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index ea7ae82b4687..a9ea6a706702 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -280,6 +280,36 @@ static ssize_t region_align_show(struct device *dev,
 static struct device_attribute dev_attr_region_align =
 		__ATTR(align, 0400, region_align_show, NULL);
 
+#define for_each_extent_resource(extent, res) \
+	for (res = (extent)->child; res; res = res->sibling)
+
+static unsigned long long
+dr_extent_avail_size(struct dax_region_extent *dr_extent)
+{
+	unsigned long long rc;
+	struct resource *res;
+
+	rc = resource_size(dr_extent->res);
+	for_each_extent_resource(dr_extent->res, res)
+		rc -= resource_size(res);
+	return rc;
+}
+
+static int dax_region_add_dynamic_size(struct device *dev, void *data)
+{
+	unsigned long long *size = data, ext_size;
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+
+	if (!is_dr_ext_dev(dev))
+		return 0;
+
+	dr_reg_ext_dev = to_dr_ext_dev(dev);
+	ext_size = dr_extent_avail_size(dr_reg_ext_dev->dr_extent);
+	dev_dbg(dev, "size %llx\n", ext_size);
+	*size += ext_size;
+	return 0;
+}
+
 #define for_each_dax_region_resource(dax_region, res) \
 	for (res = (dax_region)->res.child; res; res = res->sibling)
 
@@ -290,8 +320,12 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 
 	device_lock_assert(dax_region->dev);
 
-	if (is_dynamic(dax_region))
-		return 0;
+	if (is_dynamic(dax_region)) {
+		size = 0;
+		device_for_each_child(dax_region->dev, &size,
+				      dax_region_add_dynamic_size);
+		return size;
+	}
 
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
@@ -421,15 +455,24 @@ EXPORT_SYMBOL_GPL(kill_dev_dax);
 static void trim_dev_dax_range(struct dev_dax *dev_dax)
 {
 	int i = dev_dax->nr_range - 1;
-	struct range *range = &dev_dax->ranges[i].range;
+	struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+	struct range *range = &dev_range->range;
 	struct dax_region *dax_region = dev_dax->region;
+	struct resource *res = &dax_region->res;
 
 	device_lock_assert(dax_region->dev);
 	dev_dbg(&dev_dax->dev, "delete range[%d]: %#llx:%#llx\n", i,
 		(unsigned long long)range->start,
 		(unsigned long long)range->end);
 
-	__release_region(&dax_region->res, range->start, range_len(range));
+	if (dev_range->dr_extent)
+		res = dev_range->dr_extent->res;
+
+	__release_region(res, range->start, range_len(range));
+
+	if (dev_range->dr_extent)
+		dr_extent_put(dev_range->dr_extent);
+
 	if (--dev_dax->nr_range == 0) {
 		kfree(dev_dax->ranges);
 		dev_dax->ranges = NULL;
@@ -818,7 +861,8 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 }
 
 static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
-			       u64 start, resource_size_t size)
+			       u64 start, resource_size_t size,
+			       struct dax_region_extent *dr_extent)
 {
 	struct dax_region *dax_region = dev_dax->region;
 	struct device *dev = &dev_dax->dev;
@@ -852,12 +896,15 @@ static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
 	for (i = 0; i < dev_dax->nr_range; i++)
 		pgoff += PHYS_PFN(range_len(&ranges[i].range));
 	dev_dax->ranges = ranges;
+	if (dr_extent)
+		dr_extent_get(dr_extent);
 	ranges[dev_dax->nr_range++] = (struct dev_dax_range) {
 		.pgoff = pgoff,
 		.range = {
 			.start = alloc->start,
 			.end = alloc->end,
 		},
+		.dr_extent = dr_extent,
 	};
 
 	dev_dbg(dev, "alloc range[%d]: %pa:%pa\n", dev_dax->nr_range - 1,
@@ -938,7 +985,8 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 	int i;
 
 	for (i = dev_dax->nr_range - 1; i >= 0; i--) {
-		struct range *range = &dev_dax->ranges[i].range;
+		struct dev_dax_range *dev_range = &dev_dax->ranges[i];
+		struct range *range = &dev_range->range;
 		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
 		struct resource *adjust = NULL, *res;
 		resource_size_t shrink;
@@ -954,12 +1002,16 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 			continue;
 		}
 
-		for_each_dax_region_resource(dax_region, res)
-			if (strcmp(res->name, dev_name(dev)) == 0
-					&& res->start == range->start) {
-				adjust = res;
-				break;
-			}
+		if (dev_range->dr_extent) {
+			adjust = dev_range->dr_extent->res;
+		} else {
+			for_each_dax_region_resource(dax_region, res)
+				if (strcmp(res->name, dev_name(dev)) == 0
+						&& res->start == range->start) {
+					adjust = res;
+					break;
+				}
+		}
 
 		if (dev_WARN_ONCE(dev, !adjust || i != dev_dax->nr_range - 1,
 					"failed to find matching resource\n"))
@@ -973,12 +1025,15 @@ static int dev_dax_shrink(struct dev_dax *dev_dax, resource_size_t size)
 /*
  * Only allow adjustments that preserve the relative pgoff of existing
  * allocations. I.e. the dev_dax->ranges array is ordered by increasing pgoff.
+ * Dissallow adjustments on dynamic regions as they can come from all over.
  */
 static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 {
 	struct dev_dax_range *last;
 	int i;
 
+	if (is_dynamic(dev_dax->region))
+		return false;
 	if (dev_dax->nr_range == 0)
 		return false;
 	if (strcmp(res->name, dev_name(&dev_dax->dev)) != 0)
@@ -997,19 +1052,21 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 }
 
 /*
- * dev_dax_resize_static - Expand the device into the unused portion of the
- * region. This may involve adjusting the end of an existing resource, or
- * allocating a new resource.
+ * __dev_dax_resize - Expand the device into the unused portion of the region.
+ * This may involve adjusting the end of an existing resource, or allocating a
+ * new resource.
  *
  * @parent: parent resource to allocate this range in.
  * @dev_dax: DAX device we are creating this range for
  * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ * @dr_extent: if dynamic; the extent containing parent
  *
  * Return the amount of space allocated or -ERRNO on failure
  */
-static ssize_t dev_dax_resize_static(struct resource *parent,
-				     struct dev_dax *dev_dax,
-				     resource_size_t to_alloc)
+static ssize_t __dev_dax_resize(struct resource *parent,
+				struct dev_dax *dev_dax,
+				resource_size_t to_alloc,
+				struct dax_region_extent *dr_extent)
 {
 	struct resource *res, *first;
 	int rc;
@@ -1017,7 +1074,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	first = parent->child;
 	if (!first) {
 		rc = alloc_dev_dax_range(parent, dev_dax,
-					   parent->start, to_alloc);
+					   parent->start, to_alloc,
+					   dr_extent);
 		if (rc)
 			return rc;
 		return to_alloc;
@@ -1031,7 +1089,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 		if (res == first && res->start > parent->start) {
 			alloc = min(res->start - parent->start, to_alloc);
 			rc = alloc_dev_dax_range(parent, dev_dax,
-						 parent->start, alloc);
+						 parent->start, alloc,
+						 dr_extent);
 			if (rc)
 				return rc;
 			return alloc;
@@ -1055,7 +1114,8 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 				return rc;
 			return alloc;
 		}
-		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc,
+					 dr_extent);
 		if (rc)
 			return rc;
 		return alloc;
@@ -1066,6 +1126,47 @@ static ssize_t dev_dax_resize_static(struct resource *parent,
 	return 0;
 }
 
+static ssize_t dev_dax_resize_static(struct dax_region *dax_region,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
+{
+	return __dev_dax_resize(&dax_region->res, dev_dax, to_alloc, NULL);
+}
+
+static int dax_region_find_space(struct device *dev, void *data)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+
+	if (!is_dr_ext_dev(dev))
+		return 0;
+
+	dr_reg_ext_dev = to_dr_ext_dev(dev);
+	return dr_extent_avail_size(dr_reg_ext_dev->dr_extent);
+}
+
+static ssize_t dev_dax_resize_dynamic(struct dax_region *dax_region,
+				      struct dev_dax *dev_dax,
+				      resource_size_t to_alloc)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+	struct dax_region_extent *dr_extent;
+	resource_size_t alloc;
+	resource_size_t extent_max;
+	struct device *dev;
+
+	dev = device_find_child(dax_region->dev, NULL, dax_region_find_space);
+	if (dev_WARN_ONCE(dax_region->dev, !dev, "Space should be available!"))
+		return -ENOSPC;
+	dr_reg_ext_dev = to_dr_ext_dev(dev);
+	dr_extent = dr_reg_ext_dev->dr_extent;
+	extent_max = dr_extent_avail_size(dr_extent);
+	to_alloc = min(extent_max, to_alloc);
+	alloc = __dev_dax_resize(dr_extent->res, dev_dax, to_alloc, dr_extent);
+	put_device(dev);
+
+	return alloc;
+}
+
 static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		struct dev_dax *dev_dax, resource_size_t size)
 {
@@ -1089,7 +1190,10 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 		return -ENXIO;
 
 retry:
-	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	if (is_dynamic(dax_region))
+		alloc = dev_dax_resize_dynamic(dax_region, dev_dax, to_alloc);
+	else
+		alloc = dev_dax_resize_static(dax_region, dev_dax, to_alloc);
 	if (alloc <= 0)
 		return alloc;
 	to_alloc -= alloc;
@@ -1168,6 +1272,9 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	struct range r;
 	ssize_t rc;
 
+	if (is_dynamic(dax_region))
+		return -EINVAL;
+
 	rc = range_parse(buf, len, &r);
 	if (rc)
 		return rc;
@@ -1183,7 +1290,7 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
 		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
-					 to_alloc);
+					 to_alloc, NULL);
 	device_unlock(dev);
 	device_unlock(dax_region->dev);
 
@@ -1400,8 +1507,10 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
+	dev_WARN_ONCE(parent, is_dynamic(dax_region) && data->size,
+		      "Dynamic DAX devices are created initially with 0 size");
 	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
-				 data->size);
+				 data->size, NULL);
 	if (rc)
 		goto err_range;
 
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 44cbd28668f1..6394a3531e25 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -12,6 +12,17 @@ static void dax_reg_ext_get(struct dax_region_extent *dr_extent)
 	kref_get(&dr_extent->ref);
 }
 
+
+static void dax_region_rm_resource(struct dax_region_extent *dr_extent)
+{
+	struct dax_region *dax_region = dr_extent->region;
+	struct resource *res = dr_extent->res;
+	
+	dev_dbg(dax_region->dev, "Extent release resource %pR\n",
+		dr_extent->res);
+	__release_region(&dax_region->res, res->start, resource_size(res));
+}
+
 static void dr_release(struct kref *kref)
 {
 	struct dax_region_extent *dr_extent;
@@ -19,6 +30,7 @@ static void dr_release(struct kref *kref)
 
 	dr_extent = container_of(kref, struct dax_region_extent, ref);
 	cxl_dr_ext = dr_extent->private_data;
+	dax_region_rm_resource(dr_extent);
 	cxl_dr_extent_put(cxl_dr_ext);
 	kfree(dr_extent);
 }
@@ -28,6 +40,29 @@ static void dax_reg_ext_put(struct dax_region_extent *dr_extent)
 	kref_put(&dr_extent->ref, dr_release);
 }
 
+static int dax_region_add_resource(struct dax_region *dax_region,
+				   struct dax_region_extent *dr_extent,
+				   resource_size_t offset,
+				   resource_size_t length)
+{
+	resource_size_t start = dax_region->res.start + offset;
+	struct resource *ext_res;
+
+	dev_dbg(dax_region->dev, "DAX region resource %pR\n", &dax_region->res);
+	ext_res = __request_region(&dax_region->res, start, length, "extent", 0);
+	if (!ext_res) {
+		dev_err(dax_region->dev, "Failed to add extent s:%llx l:%llx\n",
+			start, length);
+		return -ENOSPC;
+	}
+
+	dr_extent->region = dax_region;
+	dr_extent->res = ext_res;
+	dev_dbg(dax_region->dev, "Extent add resource %pR\n", ext_res);
+
+	return 0;
+}
+
 static int cxl_dax_region_create_extent(struct dax_region *dax_region,
 					struct cxl_dr_extent *cxl_dr_ext)
 {
@@ -45,11 +80,20 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
 	/* device manages the dr_extent on success */
 	kref_init(&dr_extent->ref);
 
+	rc = dax_region_add_resource(dax_region, dr_extent,
+				     cxl_dr_ext->hpa_offset,
+				     cxl_dr_ext->hpa_length);
+	if (rc) {
+		kfree(dr_extent);
+		return rc;
+	}
+
 	rc = dax_region_ext_create_dev(dax_region, dr_extent,
 				       cxl_dr_ext->hpa_offset,
 				       cxl_dr_ext->hpa_length,
 				       cxl_dr_ext->label);
 	if (rc) {
+		dax_region_rm_resource(dr_extent);
 		kfree(dr_extent);
 		return rc;
 	}
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 250babd6e470..ad73b53aa802 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -44,12 +44,16 @@ struct dax_region {
 /*
  * struct dax_region_extent - extent data defined by the low level region
  * driver.
+ * @region: cache of dax_region
+ * @res: cache of resource tree for this extent
  * @private_data: lower level region driver data
  * @ref: track number of dax devices which are using this extent
  * @get: get reference to low level data
  * @put: put reference to low level data
  */
 struct dax_region_extent {
+	struct dax_region *region;
+	struct resource *res;
 	void *private_data;
 	struct kref ref;
 	void (*get)(struct dax_region_extent *dr_extent);
@@ -131,6 +135,7 @@ struct dev_dax {
 		unsigned long pgoff;
 		struct range range;
 		struct dax_mapping *mapping;
+		struct dax_region_extent *dr_extent;
 	} *ranges;
 };
 

-- 
2.41.0

