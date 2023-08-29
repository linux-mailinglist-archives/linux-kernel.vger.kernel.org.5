Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F078BDCB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbjH2FYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbjH2FYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98BE198;
        Mon, 28 Aug 2023 22:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286652; x=1724822652;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zQkGdDHYCbC/ziYaa0AFs4TNsDCAF/BwwDD+JF1yBcU=;
  b=fildFUE6oAaTk1pnQqDIwx2obRmkDdsUBBg7rXjjTAP60BRxk9EGL8U9
   HREktQEYctl5k6H4gWQITFw5S+jOy5MOqiYKZk3PbBtIoSjBbb4LtVahu
   VwhfCGBl3ax9Olml5o9mLqVUDNgkqAA4HmqjjcrA4OSYNAJnmTplUe/rY
   LGdq+I7y9dRvNlp55NMVUOZEIVFUKFQ/YPDmAzJn1M9VvtG3rJ6pATMTA
   s+NHuxulSJVVJF2IEsMWVeXUMvxmDJg5HU5BIkocm6Xp04VAioBhQYBVo
   KrxxccXWGfPc+l0d9P0I+dXrZmXhaOQISRmDz4UlhVy9lFYCI5DqQyXAL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625243"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556415"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556415"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:47 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:04 -0700
Subject: [PATCH RFC v2 13/18] dax/bus: Factor out dev dax resize logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-13-f740c47e7916@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=8374;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=zQkGdDHYCbC/ziYaa0AFs4TNsDCAF/BwwDD+JF1yBcU=;
 b=SJ6URvjXJ/bWBKBHjdjLJr0jCvokK+k9hzrEC88hLUmjD3Wb76Bd8DSSOCSXchPZEmUlbiw4z
 pNq7DQSeQ2PDTv8yW+I1JRAvOztwDbYQl5CZNGlTZ8GjEhroE8Sp6BV
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

Dynamic Capacity regions must limit dev dax resources to those areas
which have extents backing real memory.  Four alternatives were
considered to manage the intersection of region space and extents:

1) Create a single region resource child on region creation which
   reserves the entire region.  Then as extents are added punch holes in
   this reservation.  This requires new resource manipulation to punch
   the holes and still requires an additional iteration over the extent
   areas which may already have existing dev dax resources used.

2) Maintain an ordered xarray of extents which can be queried while
   processing the resize logic.  The issue is that existing region->res
   children may artificially limit the allocation size sent to
   alloc_dev_dax_range().  IE the resource children can't be directly
   used in the resize logic to find where space in the region is.

3) Maintain a separate resource tree with extents.  This option is the
   same as 2) but with a different data structure.  Most ideally we have
   some unified representation of the resource tree.

4) Create region resource children for each extent.  Manage the dax dev
   resize logic in the same way as before but use a region child
   (extent) resource as the parents to find space within each extent.

Option 4 can leverage the existing resize algorithm to find space within
the extents.

In preparation for this change, factor out the dev_dax_resize logic.
For static regions use dax_region->res as the parent to find space for
the dax ranges.  Future patches will use the same algorithm with
individual extent resources as the parent.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 drivers/dax/bus.c | 128 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 79 insertions(+), 49 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index b76e49813a39..ea7ae82b4687 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -817,11 +817,10 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
 	return 0;
 }
 
-static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
-		resource_size_t size)
+static int alloc_dev_dax_range(struct resource *parent, struct dev_dax *dev_dax,
+			       u64 start, resource_size_t size)
 {
 	struct dax_region *dax_region = dev_dax->region;
-	struct resource *res = &dax_region->res;
 	struct device *dev = &dev_dax->dev;
 	struct dev_dax_range *ranges;
 	unsigned long pgoff = 0;
@@ -839,14 +838,14 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
 		return 0;
 	}
 
-	alloc = __request_region(res, start, size, dev_name(dev), 0);
+	alloc = __request_region(parent, start, size, dev_name(dev), 0);
 	if (!alloc)
 		return -ENOMEM;
 
 	ranges = krealloc(dev_dax->ranges, sizeof(*ranges)
 			* (dev_dax->nr_range + 1), GFP_KERNEL);
 	if (!ranges) {
-		__release_region(res, alloc->start, resource_size(alloc));
+		__release_region(parent, alloc->start, resource_size(alloc));
 		return -ENOMEM;
 	}
 
@@ -997,50 +996,45 @@ static bool adjust_ok(struct dev_dax *dev_dax, struct resource *res)
 	return true;
 }
 
-static ssize_t dev_dax_resize(struct dax_region *dax_region,
-		struct dev_dax *dev_dax, resource_size_t size)
+/*
+ * dev_dax_resize_static - Expand the device into the unused portion of the
+ * region. This may involve adjusting the end of an existing resource, or
+ * allocating a new resource.
+ *
+ * @parent: parent resource to allocate this range in.
+ * @dev_dax: DAX device we are creating this range for
+ * @to_alloc: amount of space to alloc; must be <= space available in @parent
+ *
+ * Return the amount of space allocated or -ERRNO on failure
+ */
+static ssize_t dev_dax_resize_static(struct resource *parent,
+				     struct dev_dax *dev_dax,
+				     resource_size_t to_alloc)
 {
-	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
-	resource_size_t dev_size = dev_dax_size(dev_dax);
-	struct resource *region_res = &dax_region->res;
-	struct device *dev = &dev_dax->dev;
 	struct resource *res, *first;
-	resource_size_t alloc = 0;
 	int rc;
 
-	if (dev->driver)
-		return -EBUSY;
-	if (size == dev_size)
-		return 0;
-	if (size > dev_size && size - dev_size > avail)
-		return -ENOSPC;
-	if (size < dev_size)
-		return dev_dax_shrink(dev_dax, size);
-
-	to_alloc = size - dev_size;
-	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
-			"resize of %pa misaligned\n", &to_alloc))
-		return -ENXIO;
-
-	/*
-	 * Expand the device into the unused portion of the region. This
-	 * may involve adjusting the end of an existing resource, or
-	 * allocating a new resource.
-	 */
-retry:
-	first = region_res->child;
-	if (!first)
-		return alloc_dev_dax_range(dev_dax, dax_region->res.start, to_alloc);
+	first = parent->child;
+	if (!first) {
+		rc = alloc_dev_dax_range(parent, dev_dax,
+					   parent->start, to_alloc);
+		if (rc)
+			return rc;
+		return to_alloc;
+	}
 
-	rc = -ENOSPC;
 	for (res = first; res; res = res->sibling) {
 		struct resource *next = res->sibling;
+		resource_size_t alloc;
 
 		/* space at the beginning of the region */
-		if (res == first && res->start > dax_region->res.start) {
-			alloc = min(res->start - dax_region->res.start, to_alloc);
-			rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, alloc);
-			break;
+		if (res == first && res->start > parent->start) {
+			alloc = min(res->start - parent->start, to_alloc);
+			rc = alloc_dev_dax_range(parent, dev_dax,
+						 parent->start, alloc);
+			if (rc)
+				return rc;
+			return alloc;
 		}
 
 		alloc = 0;
@@ -1049,21 +1043,55 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
 			alloc = min(next->start - (res->end + 1), to_alloc);
 
 		/* space at the end of the region */
-		if (!alloc && !next && res->end < region_res->end)
-			alloc = min(region_res->end - res->end, to_alloc);
+		if (!alloc && !next && res->end < parent->end)
+			alloc = min(parent->end - res->end, to_alloc);
 
 		if (!alloc)
 			continue;
 
 		if (adjust_ok(dev_dax, res)) {
 			rc = adjust_dev_dax_range(dev_dax, res, resource_size(res) + alloc);
-			break;
+			if (rc)
+				return rc;
+			return alloc;
 		}
-		rc = alloc_dev_dax_range(dev_dax, res->end + 1, alloc);
-		break;
+		rc = alloc_dev_dax_range(parent, dev_dax, res->end + 1, alloc);
+		if (rc)
+			return rc;
+		return alloc;
 	}
-	if (rc)
-		return rc;
+
+	/* available was already calculated and should never be an issue */
+	dev_WARN_ONCE(&dev_dax->dev, 1, "space not found?");
+	return 0;
+}
+
+static ssize_t dev_dax_resize(struct dax_region *dax_region,
+		struct dev_dax *dev_dax, resource_size_t size)
+{
+	resource_size_t avail = dax_region_avail_size(dax_region), to_alloc;
+	resource_size_t dev_size = dev_dax_size(dev_dax);
+	struct device *dev = &dev_dax->dev;
+	resource_size_t alloc = 0;
+
+	if (dev->driver)
+		return -EBUSY;
+	if (size == dev_size)
+		return 0;
+	if (size > dev_size && size - dev_size > avail)
+		return -ENOSPC;
+	if (size < dev_size)
+		return dev_dax_shrink(dev_dax, size);
+
+	to_alloc = size - dev_size;
+	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
+			"resize of %pa misaligned\n", &to_alloc))
+		return -ENXIO;
+
+retry:
+	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
+	if (alloc <= 0)
+		return alloc;
 	to_alloc -= alloc;
 	if (to_alloc)
 		goto retry;
@@ -1154,7 +1182,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
 
 	to_alloc = range_len(&r);
 	if (alloc_is_aligned(dev_dax, to_alloc))
-		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc);
+		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
+					 to_alloc);
 	device_unlock(dev);
 	device_unlock(dax_region->dev);
 
@@ -1371,7 +1400,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	device_initialize(dev);
 	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
 
-	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size);
+	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
+				 data->size);
 	if (rc)
 		goto err_range;
 

-- 
2.41.0

