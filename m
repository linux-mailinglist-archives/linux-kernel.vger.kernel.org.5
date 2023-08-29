Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9471678BDCC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjH2FYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235664AbjH2FYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DAB198;
        Mon, 28 Aug 2023 22:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286649; x=1724822649;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=R+V131ndOPIZGxf8bri6fiUZIEtyiDv+wVzl0NXO138=;
  b=LvxDdpTg+TdxEXj83u4YzwP0ACYW507zvfW9hS9oy1L7EfQVawlN7iLT
   J2Y/DzsZrVKhT/pI8j7Hndw5zNTaWpfbdmrO4pjmLbysKHZk4OeSlvykM
   XvTksIjEe7v8KqyhFu2edLwQjBKmbroZWM+LeswM/APl3tcvMIrtxVaRX
   hRKDmKVDtG5Jy8mzGuWFVz2fuKoKqRqItT74XBTQshYgNYPY4fd0cdnkz
   80UHNbh6svPN3wuF9hutwHs2SS1WTWCOqu0uG5lK26MX43HwMILLncEWa
   6/nP70dbSLHnh0p9ViLUHe4Z2isDjY22CJYWGT/kkrvhdtiVhJVe2Y30z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625239"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556409"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556409"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:46 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:03 -0700
Subject: [PATCH RFC v2 12/18] cxl/region: Notify regions of DC changes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-12-f740c47e7916@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=18741;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=R+V131ndOPIZGxf8bri6fiUZIEtyiDv+wVzl0NXO138=;
 b=mnjz2FZBE42CM8m2cjFnKTyUsPCTL61X1w6U9V900FmgQaAivYw63dlCOFBEbuOAdlTpHFH7q
 lq4jkg7KrLNCkqQsdpK9BXFCPw+wCbSZlKwkvpeETup6pkQl4uJ0Tn6
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

In order for a user to use dynamic capacity effectively they need to
know when dynamic capacity is available.  Thus when Dynamic Capacity
(DC) extents are added or removed by a DC device the regions affected
need to be notified.  Ultimately the DAX region uses the memory
associated with DC extents.  However, remember that CXL DAX regions
maintain any interleave details between devices.

When a DCD event occurs, iterate all CXL endpoint decoders and notify
regions which contain the endpoints affected by the event.  In turn
notify the DAX regions of the changes to the DAX region extents.

For now interleave is handled by creating simple 1:1 mappings between
the CXL DAX region and DAX region layers.  Future implementations will
need to resolve when to actually surface a DAX region extent and pass
the notification along.

Remember that adding capacity is safe because there is no chance of the
memory being in use.  Also remember at this point releasing capacity is
straight forward because DAX devices do not yet have references to the
extents.  Future patches will handle that complication.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1:
[iweiny: Rewrite]
---
 drivers/cxl/core/mbox.c   |  39 +++++++++++++--
 drivers/cxl/core/region.c | 123 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/cxl/cxl.h         |  22 +++++++++
 drivers/cxl/mem.c         |  50 +++++++++++++++++++
 drivers/dax/cxl.c         |  99 ++++++++++++++++++++++++++++++-------
 drivers/dax/dax-private.h |   3 ++
 drivers/dax/extent.c      |  14 ++++++
 7 files changed, 317 insertions(+), 33 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5472ab1d0370..9d9c13e13ecf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -824,6 +824,35 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_enumerate_cmds, CXL);
 
+static int cxl_notify_dc_extent(struct cxl_memdev_state *mds,
+				enum dc_event event,
+				struct cxl_dc_extent_data *extent)
+{
+	struct cxl_drv_nd nd = (struct cxl_drv_nd) {
+		.event = event,
+		.extent = extent
+	};
+	struct device *dev;
+	int rc = 0;
+
+	dev = &mds->cxlds.cxlmd->dev;
+	dev_dbg(dev, "Trying notify: type %d DPA:%llx LEN:%llx\n",
+		event, extent->dpa_start, extent->length);
+
+	device_lock(dev);
+	if (dev->driver) {
+		struct cxl_driver *mem_drv = to_cxl_drv(dev->driver);
+
+		if (mem_drv->notify) {
+			dev_dbg(dev, "Notify: type %d DPA:%llx LEN:%llx\n",
+				event, extent->dpa_start, extent->length);
+			rc = mem_drv->notify(dev, &nd);
+		}
+	}
+	device_unlock(dev);
+	return rc;
+}
+
 static int cxl_store_dc_extent(struct cxl_memdev_state *mds,
 			       struct cxl_dc_extent *dc_extent)
 {
@@ -852,9 +881,10 @@ static int cxl_store_dc_extent(struct cxl_memdev_state *mds,
 			dev_warn_once(dev, "Duplicate extent DPA:%llx LEN:%llx\n",
 				      extent->dpa_start, extent->length);
 		kfree(extent);
+		return rc;
 	}
 
-	return rc;
+	return cxl_notify_dc_extent(mds, DCD_ADD_CAPACITY, extent);
 }
 
 /*
@@ -1074,7 +1104,8 @@ void cxl_dc_extent_put(struct cxl_dc_extent_data *extent)
 EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_put, CXL);
 
 static int cxl_handle_dcd_release_event(struct cxl_memdev_state *mds,
-					struct cxl_dc_extent *rel_extent)
+					struct cxl_dc_extent *rel_extent,
+					enum dc_event event)
 {
 	struct device *dev = mds->cxlds.dev;
 	struct cxl_dc_extent_data *extent;
@@ -1090,6 +1121,7 @@ static int cxl_handle_dcd_release_event(struct cxl_memdev_state *mds,
 		dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
 		return -EINVAL;
 	}
+	cxl_notify_dc_extent(mds, event, extent);
 	cxl_dc_extent_put(extent);
 	return 0;
 }
@@ -1151,7 +1183,8 @@ static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
 		break;
 	case DCD_RELEASE_CAPACITY:
         case DCD_FORCED_CAPACITY_RELEASE:
-		rc = cxl_handle_dcd_release_event(mds, &record->data.extent);
+		rc = cxl_handle_dcd_release_event(mds, &record->data.extent,
+						  record->data.event_type);
 		break;
 	default:
 		return -EINVAL;
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0aeea50550f6..a0c1f2793dd7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1547,8 +1547,8 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 	return 0;
 }
 
-static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
-				struct cxl_dc_extent_data *extent)
+bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_dc_extent_data *extent)
 {
 	struct range dpa_range = (struct range){
 		.start = extent->dpa_start,
@@ -1567,14 +1567,66 @@ static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
 	return (cxled->dpa_res->start <= dpa_range.start &&
 		dpa_range.end <= cxled->dpa_res->end);
 }
+EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_in_ed, CXL);
+
+static int cxl_region_notify_extent(struct cxl_endpoint_decoder *cxled,
+				    enum dc_event event,
+				    struct cxl_dr_extent *cxl_dr_ext)
+{
+	struct cxl_dax_region *cxlr_dax;
+	struct device *dev;
+	int rc = 0;
+
+	cxlr_dax = cxled->cxld.region->cxlr_dax;
+	dev = &cxlr_dax->dev;
+	dev_dbg(dev, "Trying notify: type %d HPA:%llx LEN:%llx\n",
+		event, cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
+
+	device_lock(dev);
+	if (dev->driver) {
+		struct cxl_driver *reg_drv = to_cxl_drv(dev->driver);
+		struct cxl_drv_nd nd = (struct cxl_drv_nd) {
+			.event = event,
+			.cxl_dr_ext = cxl_dr_ext,
+		};
+
+		if (reg_drv->notify) {
+			dev_dbg(dev, "Notify: type %d HPA:%llx LEN:%llx\n",
+				event, cxl_dr_ext->hpa_offset,
+				cxl_dr_ext->hpa_length);
+			rc = reg_drv->notify(dev, &nd);
+		}
+	}
+	device_unlock(dev);
+	return rc;
+}
+
+static resource_size_t
+cxl_dc_extent_to_hpa_offset(struct cxl_endpoint_decoder *cxled,
+			    struct cxl_dc_extent_data *extent)
+{
+	struct cxl_dax_region *cxlr_dax;
+	resource_size_t dpa_offset, hpa;
+	struct range *ed_hpa_range;
+
+	cxlr_dax = cxled->cxld.region->cxlr_dax;
+
+	/*
+	 * Without interleave...
+	 * HPA offset == DPA offset
+	 * ... but do the math anyway
+	 */
+	dpa_offset = extent->dpa_start - cxled->dpa_res->start;
+	ed_hpa_range = &cxled->cxld.hpa_range;
+	hpa = ed_hpa_range->start + dpa_offset;
+	return hpa - cxlr_dax->hpa_range.start;
+}
 
 static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 				 struct cxl_dc_extent_data *extent)
 {
 	struct cxl_dr_extent *cxl_dr_ext;
 	struct cxl_dax_region *cxlr_dax;
-	resource_size_t dpa_offset, hpa;
-	struct range *ed_hpa_range;
 	struct device *dev;
 	int rc;
 
@@ -1601,15 +1653,7 @@ static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 	cxl_dr_ext->extent = extent;
 	kref_init(&cxl_dr_ext->region_ref);
 
-	/*
-	 * Without interleave...
-	 * HPA offset == DPA offset
-	 * ... but do the math anyway
-	 */
-	dpa_offset = extent->dpa_start - cxled->dpa_res->start;
-	ed_hpa_range = &cxled->cxld.hpa_range;
-	hpa = ed_hpa_range->start + dpa_offset;
-	cxl_dr_ext->hpa_offset = hpa - cxlr_dax->hpa_range.start;
+	cxl_dr_ext->hpa_offset = cxl_dc_extent_to_hpa_offset(cxled, extent);
 
 	/* Without interleave carry length and label through */
 	cxl_dr_ext->hpa_length = extent->length;
@@ -1626,6 +1670,7 @@ static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
 	}
 	/* Put in cxl_dr_release() */
 	cxl_dc_extent_get(cxl_dr_ext->extent);
+	cxl_region_notify_extent(cxled, DCD_ADD_CAPACITY, cxl_dr_ext);
 	return 0;
 }
 
@@ -1663,6 +1708,58 @@ static int cxl_ed_add_extents(struct cxl_endpoint_decoder *cxled)
 	return 0;
 }
 
+static int cxl_ed_rm_dc_extent(struct cxl_endpoint_decoder *cxled,
+			       enum dc_event event,
+			       struct cxl_dc_extent_data *extent)
+{
+	struct cxl_region *cxlr = cxled->cxld.region;
+	struct cxl_dax_region *cxlr_dax = cxlr->cxlr_dax;
+	struct cxl_dr_extent *cxl_dr_ext;
+	resource_size_t hpa_offset;
+
+	hpa_offset = cxl_dc_extent_to_hpa_offset(cxled, extent);
+
+	/*
+	 * NOTE on Interleaving: There is no need to 'break up' the cxl_dr_ext.
+	 * If one of the extents comprising it is gone it should be removed
+	 * from the region to prevent future use.  Later code may save other
+	 * extents for future processing.  But for now the corelation is 1:1:1
+	 * so just erase the extent.
+	 */
+	cxl_dr_ext = xa_erase(&cxlr_dax->extents, hpa_offset);
+
+	dev_dbg(&cxlr_dax->dev, "Remove DAX region ext HPA:%llx\n",
+		cxl_dr_ext->hpa_offset);
+	cxl_region_notify_extent(cxled, event, cxl_dr_ext);
+	cxl_dr_extent_put(cxl_dr_ext);
+	return 0;
+}
+
+int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_drv_nd *nd)
+{
+	int rc = 0;
+
+	switch (nd->event) {
+	case DCD_ADD_CAPACITY:
+		if (cxl_dc_extent_get_not_zero(nd->extent)) {
+			rc = cxl_ed_add_one_extent(cxled, nd->extent);
+			if (rc)
+				cxl_dc_extent_put(nd->extent);
+		}
+		break;
+	case DCD_RELEASE_CAPACITY:
+	case DCD_FORCED_CAPACITY_RELEASE:
+		rc = cxl_ed_rm_dc_extent(cxled, nd->event, nd->extent);
+		break;
+	default:
+		dev_err(&cxled->cxld.dev, "Unknown DC event %d\n", nd->event);
+		break;
+	}
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_ed_notify_extent, CXL);
+
 static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 177b892ac53f..2c73a30980b6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -838,10 +838,18 @@ bool is_cxl_region(struct device *dev);
 
 extern struct bus_type cxl_bus_type;
 
+/* Driver Notifier Data */
+struct cxl_drv_nd {
+	enum dc_event event;
+	struct cxl_dc_extent_data *extent;
+	struct cxl_dr_extent *cxl_dr_ext;
+};
+
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
 	void (*remove)(struct device *dev);
+	int (*notify)(struct device *dev, struct cxl_drv_nd *nd);
 	struct device_driver drv;
 	int id;
 };
@@ -887,6 +895,10 @@ struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev);
 int cxl_add_to_region(struct cxl_port *root,
 		      struct cxl_endpoint_decoder *cxled);
 struct cxl_dax_region *to_cxl_dax_region(struct device *dev);
+bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_dc_extent_data *extent);
+int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+			 struct cxl_drv_nd *nd);
 #else
 static inline bool is_cxl_pmem_region(struct device *dev)
 {
@@ -905,6 +917,16 @@ static inline struct cxl_dax_region *to_cxl_dax_region(struct device *dev)
 {
 	return NULL;
 }
+static inline bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+				       struct cxl_dc_extent_data *extent)
+{
+	return false;
+}
+static inline int cxl_ed_notify_extent(struct cxl_endpoint_decoder *cxled,
+				       struct cxl_drv_nd *nd)
+{
+	return 0;
+}
 #endif
 
 /*
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 80cffa40e91a..d3c4c9c87392 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -104,6 +104,55 @@ static int cxl_debugfs_poison_clear(void *data, u64 dpa)
 DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
 			 cxl_debugfs_poison_clear, "%llx\n");
 
+static int match_ep_decoder_by_range(struct device *dev, void *data)
+{
+	struct cxl_dc_extent_data *extent = data;
+	struct cxl_endpoint_decoder *cxled;
+
+	if (!is_endpoint_decoder(dev))
+		return 0;
+	cxled = to_cxl_endpoint_decoder(dev);
+	return cxl_dc_extent_in_ed(cxled, extent);
+}
+
+static struct cxl_endpoint_decoder *cxl_find_ed(struct cxl_memdev_state *mds,
+						struct cxl_dc_extent_data *extent)
+{
+	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
+	struct cxl_port *endpoint = cxlmd->endpoint;
+	struct device *dev;
+
+	dev = device_find_child(&endpoint->dev, extent,
+				match_ep_decoder_by_range);
+	if (!dev) {
+		dev_dbg(mds->cxlds.dev, "Extent DPA:%llx LEN:%llx not mapped\n",
+			extent->dpa_start, extent->length);
+		return NULL;
+	}
+
+	return to_cxl_endpoint_decoder(dev);
+}
+
+static int cxl_mem_notify(struct device *dev, struct cxl_drv_nd *nd)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	struct cxl_endpoint_decoder *cxled;
+	struct cxl_dc_extent_data *extent;
+	int rc = 0;
+
+	extent = nd->extent;
+	dev_dbg(dev, "notify DC action %d DPA:%llx LEN:%llx\n",
+		nd->event, extent->dpa_start, extent->length);
+
+	cxled = cxl_find_ed(mds, extent);
+	if (!cxled)
+		return 0;
+	rc = cxl_ed_notify_extent(cxled, nd);
+	put_device(&cxled->cxld.dev);
+	return rc;
+}
+
 static int cxl_mem_probe(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -247,6 +296,7 @@ __ATTRIBUTE_GROUPS(cxl_mem);
 static struct cxl_driver cxl_mem_driver = {
 	.name = "cxl_mem",
 	.probe = cxl_mem_probe,
+	.notify = cxl_mem_notify,
 	.id = CXL_DEVICE_MEMORY_EXPANDER,
 	.drv = {
 		.dev_groups = cxl_mem_groups,
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 057b00b1d914..44cbd28668f1 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -59,6 +59,29 @@ static int cxl_dax_region_create_extent(struct dax_region *dax_region,
 	return 0;
 }
 
+static int cxl_dax_region_add_extent(struct cxl_dax_region *cxlr_dax,
+				     struct cxl_dr_extent *cxl_dr_ext)
+{
+	/*
+	 * get not zero is important because this is racing with the
+	 * region driver which is racing with the memory device which
+	 * could be removing the extent at the same time.
+	 */
+	if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
+		struct dax_region *dax_region;
+		int rc;
+
+		dax_region = dev_get_drvdata(&cxlr_dax->dev);
+		dev_dbg(&cxlr_dax->dev, "Creating HPA:%llx LEN:%llx\n",
+			cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
+		rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
+		cxl_dr_extent_put(cxl_dr_ext);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
 static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
 {
 	struct cxl_dr_extent *cxl_dr_ext;
@@ -66,27 +89,68 @@ static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
 
 	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
 	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
-		/*
-		 * get not zero is important because this is racing with the
-		 * region driver which is racing with the memory device which
-		 * could be removing the extent at the same time.
-		 */
-		if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
-			struct dax_region *dax_region;
-			int rc;
-
-			dax_region = dev_get_drvdata(&cxlr_dax->dev);
-			dev_dbg(&cxlr_dax->dev, "Found OFF:%llx LEN:%llx\n",
-				cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
-			rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
-			cxl_dr_extent_put(cxl_dr_ext);
-			if (rc)
-				return rc;
-		}
+		int rc;
+
+		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
+		if (rc)
+			return rc;
 	}
 	return 0;
 }
 
+static int match_cxl_dr_extent(struct device *dev, void *data)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+	struct dax_region_extent *dr_extent;
+
+	if (!is_dr_ext_dev(dev))
+		return 0;
+
+	dr_reg_ext_dev = to_dr_ext_dev(dev);
+	dr_extent = dr_reg_ext_dev->dr_extent;
+	return data == dr_extent->private_data;
+}
+
+static int cxl_dax_region_rm_extent(struct cxl_dax_region *cxlr_dax,
+				    struct cxl_dr_extent *cxl_dr_ext)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+	struct dax_region *dax_region;
+	struct device *dev;
+
+	dev = device_find_child(&cxlr_dax->dev, cxl_dr_ext,
+				match_cxl_dr_extent);
+	if (!dev)
+		return -EINVAL;
+	dr_reg_ext_dev = to_dr_ext_dev(dev);
+	put_device(dev);
+	dax_region = dev_get_drvdata(&cxlr_dax->dev);
+	dax_region_ext_del_dev(dax_region, dr_reg_ext_dev);
+	return 0;
+}
+
+static int cxl_dax_region_notify(struct device *dev,
+				 struct cxl_drv_nd *nd)
+{
+	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	struct cxl_dr_extent *cxl_dr_ext = nd->cxl_dr_ext;
+	int rc = 0;
+
+	switch (nd->event) {
+	case DCD_ADD_CAPACITY:
+		rc = cxl_dax_region_add_extent(cxlr_dax, cxl_dr_ext);
+		break;
+	case DCD_RELEASE_CAPACITY:
+	case DCD_FORCED_CAPACITY_RELEASE:
+		rc = cxl_dax_region_rm_extent(cxlr_dax, cxl_dr_ext);
+		break;
+	default:
+		dev_err(&cxlr_dax->dev, "Unknown DC event %d\n", nd->event);
+		break;
+	}
+	return rc;
+}
+
 static int cxl_dax_region_probe(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
@@ -134,6 +198,7 @@ static int cxl_dax_region_probe(struct device *dev)
 static struct cxl_driver cxl_dax_region_driver = {
 	.name = "cxl_dax_region",
 	.probe = cxl_dax_region_probe,
+	.notify = cxl_dax_region_notify,
 	.id = CXL_DEVICE_DAX_REGION,
 	.drv = {
 		.suppress_bind_attrs = true,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 4dab52496c3f..250babd6e470 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -90,8 +90,11 @@ int dax_region_ext_create_dev(struct dax_region *dax_region,
 			      resource_size_t offset,
 			      resource_size_t length,
 			      const char *label);
+void dax_region_ext_del_dev(struct dax_region *dax_region,
+			    struct dax_reg_ext_dev *dr_reg_ext_dev);
 #define to_dr_ext_dev(dev)	\
 	container_of(dev, struct dax_reg_ext_dev, dev)
+bool is_dr_ext_dev(struct device *dev);
 
 struct dax_mapping {
 	struct device dev;
diff --git a/drivers/dax/extent.c b/drivers/dax/extent.c
index 2075ccfb21cb..dea6d408d2c8 100644
--- a/drivers/dax/extent.c
+++ b/drivers/dax/extent.c
@@ -60,6 +60,12 @@ const struct device_type dr_extent_type = {
 	.groups = dr_extent_attribute_groups,
 };
 
+bool is_dr_ext_dev(struct device *dev)
+{
+	return dev->type == &dr_extent_type;
+}
+EXPORT_SYMBOL_GPL(is_dr_ext_dev);
+
 static void unregister_dr_extent(void *ext)
 {
 	struct dax_reg_ext_dev *dr_reg_ext_dev = ext;
@@ -117,3 +123,11 @@ int dax_region_ext_create_dev(struct dax_region *dax_region,
 	return rc;
 }
 EXPORT_SYMBOL_GPL(dax_region_ext_create_dev);
+
+void dax_region_ext_del_dev(struct dax_region *dax_region,
+			    struct dax_reg_ext_dev *dr_reg_ext_dev)
+{
+	devm_remove_action(dax_region->dev, unregister_dr_extent, dr_reg_ext_dev);
+	unregister_dr_extent(dr_reg_ext_dev);
+}
+EXPORT_SYMBOL_GPL(dax_region_ext_del_dev);

-- 
2.41.0

