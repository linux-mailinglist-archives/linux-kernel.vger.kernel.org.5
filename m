Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7613E78BDDF
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 07:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235758AbjH2FYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 01:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235661AbjH2FYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 01:24:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5052B1A2;
        Mon, 28 Aug 2023 22:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693286648; x=1724822648;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L9j5X0lgccdPeWN+ZQeF2UgiQMc67ZQrTXIG3FyDxu0=;
  b=nUVh8BiMHbglwfNwsSBHFf+fjOwpWvJXT3/tt8hDiRA2mTGqsKshExDX
   k5w1R1OuZcwikwF3ZWGWlmB4V+oTV/pLyZtbZKadSQXmYL7U3l8xyXqZp
   ngs8Rg60b6Z8o5q07+Zp4HNke5wu7KnFKtHP1eKSMDW89Z7QNaR06MyWi
   vqE8i3UbUOEvuIEpU0Evq7ol7eIsuyNYiJZTvl6iFfnF+sFFcVzXPeO3b
   8z6AeaexULud4wgoVlSC9FizAzBEQ5iMtPlIED+b8KFjk1fYeMac9rJ1S
   IWu5eaiddbEAxFdjF3aHmk6oEvjvyCATJqCsmqfirQgByiypniaYDXqGe
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="441625234"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="441625234"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10816"; a="738556405"
X-IronPort-AV: E=Sophos;i="6.02,208,1688454000"; 
   d="scan'208";a="738556405"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.37.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 22:23:44 -0700
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Mon, 28 Aug 2023 22:21:02 -0700
Subject: [PATCH RFC v2 11/18] cxl/region: Expose DC extents on region
 driver load
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230604-dcd-type2-upstream-v2-11-f740c47e7916@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1693286607; l=22228;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=L9j5X0lgccdPeWN+ZQeF2UgiQMc67ZQrTXIG3FyDxu0=;
 b=CMYAWsIpguIElaVdjBIZnW8pv+vIcI186e3PfVpVQjSKj3bleCle3Dl/SfMDqHu4Jiqx1S0jq
 14UN1ISesmMAYXbYpCuMZ6d81o3exc+Fw6pxhjuKHajdS6esOIbTduv
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

Ultimately user space must associate Dynamic Capacity (DC) extents with
DAX devices.  Remember also that DCD extents may have been accepted
previous to regions being created and must have references held until
all higher level regions and DAX devices are done with the memory.

On CXL region driver load scan existing device extents and create CXL
DAX region extents as needed.

Create abstractions for the extents to be used in DAX region.  This
includes a generic interface to take proper references on the lower
level CXL region extents.

Also maintain separate objects for the DAX region extent device vs the
DAX region extent.  The DAX region extent device has a shorter life span
which corresponds to the removal of an extent while a DAX device is
still using it.  In this case an extent continues to exist whilst the
ability to create new DAX devices on that extent is prevented.

NOTE: Without interleaving; the device, CXL region, and DAX region
extents have a 1:1:1 relationship.  Future support for interleaving will
maintain a 1:N relationship between CXL region extents and the hardware
extents.

While the ability to create DAX devices on an extent exists; expose the
necessary details of DAX region extents by creating a device with the
following sysfs entries.

/sys/bus/cxl/devices/dax_regionX/extentY
/sys/bus/cxl/devices/dax_regionX/extentY/length
/sys/bus/cxl/devices/dax_regionX/extentY/label

Label is a rough analogy to the DC extent tag.  As such the DC extent
tag is used to initially populate the label.  However, the label is made
writeable so that it can be adjusted in the future when forming a DAX
device.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from v1
[iweiny: move dax_region_extents to dax layer]
[iweiny: adjust for kreference of extents]
[iweiny: adjust naming to cxl_dr_extent]
[iweiny: Remove region_extent xarray; use child devices instead]
[iweiny: ensure dax region devices are destroyed on region destruction]
[iweiny: use xa_insert]
[iweiny: hpa_offset is a dr_extent parameter not an extent parameter]
[iweiny: Add dc_region_extents when the region driver is loaded]
---
 drivers/cxl/core/mbox.c   |  12 ++++
 drivers/cxl/core/region.c | 179 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/cxl.h         |  16 +++++
 drivers/cxl/cxlmem.h      |   2 +
 drivers/dax/Makefile      |   1 +
 drivers/dax/cxl.c         | 101 ++++++++++++++++++++++++--
 drivers/dax/dax-private.h |  53 ++++++++++++++
 drivers/dax/extent.c      | 119 ++++++++++++++++++++++++++++++
 8 files changed, 473 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 8474a28b16ca..5472ab1d0370 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1055,6 +1055,18 @@ static void dc_extent_release(struct kref *kref)
 	kfree(extent);
 }
 
+int __must_check cxl_dc_extent_get_not_zero(struct cxl_dc_extent_data *extent)
+{
+	return kref_get_unless_zero(&extent->region_ref);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_get_not_zero, CXL);
+
+void cxl_dc_extent_get(struct cxl_dc_extent_data *extent)
+{
+	kref_get(&extent->region_ref);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dc_extent_get, CXL);
+
 void cxl_dc_extent_put(struct cxl_dc_extent_data *extent)
 {
 	kref_put(&extent->region_ref, dc_extent_release);
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index fc8dee469244..0aeea50550f6 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1547,6 +1547,122 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 	return 0;
 }
 
+static bool cxl_dc_extent_in_ed(struct cxl_endpoint_decoder *cxled,
+				struct cxl_dc_extent_data *extent)
+{
+	struct range dpa_range = (struct range){
+		.start = extent->dpa_start,
+		.end = extent->dpa_start + extent->length - 1,
+	};
+	struct device *dev = &cxled->cxld.dev;
+
+	dev_dbg(dev, "Checking extent DPA:%llx LEN:%llx\n",
+		extent->dpa_start, extent->length);
+
+	if (!cxled->cxld.region || !cxled->dpa_res)
+		return false;
+
+	dev_dbg(dev, "Cxled start:%llx end:%llx\n",
+		cxled->dpa_res->start, cxled->dpa_res->end);
+	return (cxled->dpa_res->start <= dpa_range.start &&
+		dpa_range.end <= cxled->dpa_res->end);
+}
+
+static int cxl_ed_add_one_extent(struct cxl_endpoint_decoder *cxled,
+				 struct cxl_dc_extent_data *extent)
+{
+	struct cxl_dr_extent *cxl_dr_ext;
+	struct cxl_dax_region *cxlr_dax;
+	resource_size_t dpa_offset, hpa;
+	struct range *ed_hpa_range;
+	struct device *dev;
+	int rc;
+
+	cxlr_dax = cxled->cxld.region->cxlr_dax;
+	dev = &cxlr_dax->dev;
+	dev_dbg(dev, "Adding DC extent DPA:%llx LEN:%llx\n",
+		extent->dpa_start, extent->length);
+
+	/*
+	 * Interleave ways == 1 means this coresponds to a 1:1 mapping between
+	 * device extents and DAX region extents.  Future implementations
+	 * should hold DC region extents here until the full dax region extent
+	 * can be realized.
+	 */
+	if (cxlr_dax->cxlr->params.interleave_ways != 1) {
+		dev_err(dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
+	cxl_dr_ext = kzalloc(sizeof(*cxl_dr_ext), GFP_KERNEL);
+	if (!cxl_dr_ext)
+		return -ENOMEM;
+
+	cxl_dr_ext->extent = extent;
+	kref_init(&cxl_dr_ext->region_ref);
+
+	/*
+	 * Without interleave...
+	 * HPA offset == DPA offset
+	 * ... but do the math anyway
+	 */
+	dpa_offset = extent->dpa_start - cxled->dpa_res->start;
+	ed_hpa_range = &cxled->cxld.hpa_range;
+	hpa = ed_hpa_range->start + dpa_offset;
+	cxl_dr_ext->hpa_offset = hpa - cxlr_dax->hpa_range.start;
+
+	/* Without interleave carry length and label through */
+	cxl_dr_ext->hpa_length = extent->length;
+	snprintf(cxl_dr_ext->label, CXL_EXTENT_LABEL_LEN, "%s",
+		 extent->tag);
+
+	dev_dbg(dev, "Inserting at HPA:%llx\n", cxl_dr_ext->hpa_offset);
+	rc = xa_insert(&cxlr_dax->extents, cxl_dr_ext->hpa_offset, cxl_dr_ext,
+		       GFP_KERNEL);
+	if (rc) {
+		dev_err(dev, "Failed to insert extent %d\n", rc);
+		kfree(cxl_dr_ext);
+		return rc;
+	}
+	/* Put in cxl_dr_release() */
+	cxl_dc_extent_get(cxl_dr_ext->extent);
+	return 0;
+}
+
+static int cxl_ed_add_extents(struct cxl_endpoint_decoder *cxled)
+{
+	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = container_of(cxlds,
+						    struct cxl_memdev_state,
+						    cxlds);
+	struct device *dev = &cxled->cxld.dev;
+	struct cxl_dc_extent_data *extent;
+	unsigned long index;
+
+	dev_dbg(dev, "Searching for DC extents\n");
+	xa_for_each(&mds->dc_extent_list, index, extent) {
+		/*
+		 * get not zero is important because this is racing with the
+		 * memory device which could be removing the extent at the same
+		 * time.
+		 */
+		if (cxl_dc_extent_get_not_zero(extent)) {
+			int rc = 0;
+
+			if (cxl_dc_extent_in_ed(cxled, extent)) {
+				dev_dbg(dev, "Found extent DPA:%llx LEN:%llx\n",
+					extent->dpa_start, extent->length);
+				rc = cxl_ed_add_one_extent(cxled, extent);
+			}
+			cxl_dc_extent_put(extent);
+			if (rc)
+				return rc;
+		}
+	}
+	return 0;
+}
+
 static int cxl_region_attach_position(struct cxl_region *cxlr,
 				      struct cxl_root_decoder *cxlrd,
 				      struct cxl_endpoint_decoder *cxled,
@@ -2702,10 +2818,44 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
 	return cxlr_pmem;
 }
 
+int __must_check cxl_dr_extent_get_not_zero(struct cxl_dr_extent *cxl_dr_ext)
+{
+	return kref_get_unless_zero(&cxl_dr_ext->region_ref);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_get_not_zero, CXL);
+
+void cxl_dr_extent_get(struct cxl_dr_extent *cxl_dr_ext)
+{
+	return kref_get(&cxl_dr_ext->region_ref);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_get, CXL);
+
+static void cxl_dr_release(struct kref *kref)
+{
+	struct cxl_dr_extent *cxl_dr_ext = container_of(kref,
+						struct cxl_dr_extent,
+						region_ref);
+
+	cxl_dc_extent_put(cxl_dr_ext->extent);
+	kfree(cxl_dr_ext);
+}
+
+void cxl_dr_extent_put(struct cxl_dr_extent *cxl_dr_ext)
+{
+	kref_put(&cxl_dr_ext->region_ref, cxl_dr_release);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_dr_extent_put, CXL);
+
 static void cxl_dax_region_release(struct device *dev)
 {
 	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
+	struct cxl_dr_extent *cxl_dr_ext;
+	unsigned long index;
 
+	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
+		xa_erase(&cxlr_dax->extents, index);
+		cxl_dr_extent_put(cxl_dr_ext);
+	}
 	kfree(cxlr_dax);
 }
 
@@ -2756,6 +2906,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
 
 	cxlr_dax->hpa_range.start = p->res->start;
 	cxlr_dax->hpa_range.end = p->res->end;
+	xa_init(&cxlr_dax->extents);
 
 	dev = &cxlr_dax->dev;
 	cxlr_dax->cxlr = cxlr;
@@ -2862,7 +3013,17 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
-static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
+static int cxl_region_add_dc_extents(struct cxl_region *cxlr)
+{
+	for (int i = 0; i < cxlr->params.nr_targets; i++) {
+		int rc = cxl_ed_add_extents(cxlr->params.targets[i]);
+		if (rc)
+			return rc;
+	}
+	return 0;
+}
+
+static int __devm_cxl_add_dax_region(struct cxl_region *cxlr, bool is_dc)
 {
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
@@ -2877,6 +3038,17 @@ static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	if (rc)
 		goto err;
 
+	cxlr->cxlr_dax = cxlr_dax;
+	if (is_dc) {
+		/*
+		 * Process device extents prior to surfacing the device to
+		 * ensure the cxl_dax_region driver has access to prior extents
+		 */
+		rc = cxl_region_add_dc_extents(cxlr);
+		if (rc)
+			goto err;
+	}
+
 	rc = device_add(dev);
 	if (rc)
 		goto err;
@@ -2893,7 +3065,7 @@ static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
 
 static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
-	return __devm_cxl_add_dax_region(cxlr);
+	return __devm_cxl_add_dax_region(cxlr, false);
 }
 
 static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
@@ -2902,8 +3074,7 @@ static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
 		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
 		return -EINVAL;
 	}
-
-	return __devm_cxl_add_dax_region(cxlr);
+	return __devm_cxl_add_dax_region(cxlr, true);
 }
 
 static int match_decoder_by_range(struct device *dev, void *data)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 81ca76ae1d02..177b892ac53f 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -555,6 +555,7 @@ struct cxl_region_params {
  * @type: Endpoint decoder target type
  * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
  * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
+ * @cxlr_dax: (for DC regions) cached copy of CXL DAX bridge
  * @flags: Region state flags
  * @params: active + config params for the region
  */
@@ -565,6 +566,7 @@ struct cxl_region {
 	enum cxl_decoder_type type;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_pmem_region *cxlr_pmem;
+	struct cxl_dax_region *cxlr_dax;
 	unsigned long flags;
 	struct cxl_region_params params;
 };
@@ -614,8 +616,22 @@ struct cxl_dax_region {
 	struct device dev;
 	struct cxl_region *cxlr;
 	struct range hpa_range;
+	struct xarray extents;
 };
 
+/* Interleave will manage multiple cxl_dc_extent_data objects */
+#define CXL_EXTENT_LABEL_LEN 64
+struct cxl_dr_extent {
+	struct kref region_ref;
+	u64 hpa_offset;
+	u64 hpa_length;
+	char label[CXL_EXTENT_LABEL_LEN];
+	struct cxl_dc_extent_data *extent;
+};
+int cxl_dr_extent_get_not_zero(struct cxl_dr_extent *cxl_dr_ext);
+void cxl_dr_extent_get(struct cxl_dr_extent *cxl_dr_ext);
+void cxl_dr_extent_put(struct cxl_dr_extent *cxl_dr_ext);
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 118392229174..8ca81fd067c2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -1002,6 +1002,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
 int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
 int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
 
+int cxl_dc_extent_get_not_zero(struct cxl_dc_extent_data *extent);
+void cxl_dc_extent_get(struct cxl_dc_extent_data *extent);
 void cxl_dc_extent_put(struct cxl_dc_extent_data *extent);
 
 #ifdef CONFIG_CXL_SUSPEND
diff --git a/drivers/dax/Makefile b/drivers/dax/Makefile
index 5ed5c39857c8..38cd3c4c0898 100644
--- a/drivers/dax/Makefile
+++ b/drivers/dax/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_DEV_DAX_CXL) += dax_cxl.o
 
 dax-y := super.o
 dax-y += bus.o
+dax-y += extent.o
 device_dax-y := device.o
 dax_pmem-y := pmem.o
 dax_cxl-y := cxl.o
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 147c8c69782b..057b00b1d914 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -5,6 +5,87 @@
 
 #include "../cxl/cxl.h"
 #include "bus.h"
+#include "dax-private.h"
+
+static void dax_reg_ext_get(struct dax_region_extent *dr_extent)
+{
+	kref_get(&dr_extent->ref);
+}
+
+static void dr_release(struct kref *kref)
+{
+	struct dax_region_extent *dr_extent;
+	struct cxl_dr_extent *cxl_dr_ext;
+
+	dr_extent = container_of(kref, struct dax_region_extent, ref);
+	cxl_dr_ext = dr_extent->private_data;
+	cxl_dr_extent_put(cxl_dr_ext);
+	kfree(dr_extent);
+}
+
+static void dax_reg_ext_put(struct dax_region_extent *dr_extent)
+{
+	kref_put(&dr_extent->ref, dr_release);
+}
+
+static int cxl_dax_region_create_extent(struct dax_region *dax_region,
+					struct cxl_dr_extent *cxl_dr_ext)
+{
+	struct dax_region_extent *dr_extent;
+	int rc;
+
+	dr_extent = kzalloc(sizeof(*dr_extent), GFP_KERNEL);
+	if (!dr_extent)
+		return -ENOMEM;
+
+	dr_extent->private_data = cxl_dr_ext;
+	dr_extent->get = dax_reg_ext_get;
+	dr_extent->put = dax_reg_ext_put;
+
+	/* device manages the dr_extent on success */
+	kref_init(&dr_extent->ref);
+
+	rc = dax_region_ext_create_dev(dax_region, dr_extent,
+				       cxl_dr_ext->hpa_offset,
+				       cxl_dr_ext->hpa_length,
+				       cxl_dr_ext->label);
+	if (rc) {
+		kfree(dr_extent);
+		return rc;
+	}
+
+	/* extent accepted */
+	cxl_dr_extent_get(cxl_dr_ext);
+	return 0;
+}
+
+static int cxl_dax_region_create_extents(struct cxl_dax_region *cxlr_dax)
+{
+	struct cxl_dr_extent *cxl_dr_ext;
+	unsigned long index;
+
+	dev_dbg(&cxlr_dax->dev, "Adding extents\n");
+	xa_for_each(&cxlr_dax->extents, index, cxl_dr_ext) {
+		/*
+		 * get not zero is important because this is racing with the
+		 * region driver which is racing with the memory device which
+		 * could be removing the extent at the same time.
+		 */
+		if (cxl_dr_extent_get_not_zero(cxl_dr_ext)) {
+			struct dax_region *dax_region;
+			int rc;
+
+			dax_region = dev_get_drvdata(&cxlr_dax->dev);
+			dev_dbg(&cxlr_dax->dev, "Found OFF:%llx LEN:%llx\n",
+				cxl_dr_ext->hpa_offset, cxl_dr_ext->hpa_length);
+			rc = cxl_dax_region_create_extent(dax_region, cxl_dr_ext);
+			cxl_dr_extent_put(cxl_dr_ext);
+			if (rc)
+				return rc;
+		}
+	}
+	return 0;
+}
 
 static int cxl_dax_region_probe(struct device *dev)
 {
@@ -19,20 +100,28 @@ static int cxl_dax_region_probe(struct device *dev)
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
-	dev_size = range_len(&cxlr_dax->hpa_range);
-
 	flags = IORESOURCE_DAX_KMEM;
-	if (cxlr->mode == CXL_REGION_DC) {
-		/* Add empty seed dax device */
-		dev_size = 0;
+	if (cxlr->mode == CXL_REGION_DC)
 		flags |= IORESOURCE_DAX_DYNAMIC_CAP;
-	}
 
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
 				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
+	dev_size = range_len(&cxlr_dax->hpa_range);
+	if (cxlr->mode == CXL_REGION_DC) {
+		int rc;
+
+		/* NOTE: Depends on dax_region being set in driver data */
+		rc = cxl_dax_region_create_extents(cxlr_dax);
+		if (rc)
+			return rc;
+
+		/* Add empty seed dax device */
+		dev_size = 0;
+	}
+
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 27cf2daaaa79..4dab52496c3f 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -5,6 +5,7 @@
 #ifndef __DAX_PRIVATE_H__
 #define __DAX_PRIVATE_H__
 
+#include <linux/pgtable.h>
 #include <linux/device.h>
 #include <linux/cdev.h>
 #include <linux/idr.h>
@@ -40,6 +41,58 @@ struct dax_region {
 	struct device *youngest;
 };
 
+/*
+ * struct dax_region_extent - extent data defined by the low level region
+ * driver.
+ * @private_data: lower level region driver data
+ * @ref: track number of dax devices which are using this extent
+ * @get: get reference to low level data
+ * @put: put reference to low level data
+ */
+struct dax_region_extent {
+	void *private_data;
+	struct kref ref;
+	void (*get)(struct dax_region_extent *dr_extent);
+	void (*put)(struct dax_region_extent *dr_extent);
+};
+
+static inline void dr_extent_get(struct dax_region_extent *dr_extent)
+{
+	if (dr_extent->get)
+		dr_extent->get(dr_extent);
+}
+
+static inline void dr_extent_put(struct dax_region_extent *dr_extent)
+{
+	if (dr_extent->put)
+		dr_extent->put(dr_extent);
+}
+
+#define DAX_EXTENT_LABEL_LEN 64
+/**
+ * struct dax_reg_ext_dev - Device object to expose extent information
+ * @dev: device representing this extent
+ * @dr_extent: reference back to private extent data
+ * @offset: offset of this extent
+ * @length: size of this extent
+ * @label: identifier to group extents
+ */
+struct dax_reg_ext_dev {
+	struct device dev;
+	struct dax_region_extent *dr_extent;
+	resource_size_t offset;
+	resource_size_t length;
+	char label[DAX_EXTENT_LABEL_LEN];
+};
+
+int dax_region_ext_create_dev(struct dax_region *dax_region,
+			      struct dax_region_extent *dr_extent,
+			      resource_size_t offset,
+			      resource_size_t length,
+			      const char *label);
+#define to_dr_ext_dev(dev)	\
+	container_of(dev, struct dax_reg_ext_dev, dev)
+
 struct dax_mapping {
 	struct device dev;
 	int range_id;
diff --git a/drivers/dax/extent.c b/drivers/dax/extent.c
new file mode 100644
index 000000000000..2075ccfb21cb
--- /dev/null
+++ b/drivers/dax/extent.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include "dax-private.h"
+
+static ssize_t length_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
+
+	return sysfs_emit(buf, "%#llx\n", dr_reg_ext_dev->length);
+}
+static DEVICE_ATTR_RO(length);
+
+static ssize_t label_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
+
+	return sysfs_emit(buf, "%s\n", dr_reg_ext_dev->label);
+}
+
+static ssize_t label_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t len)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
+
+	snprintf(dr_reg_ext_dev->label, DAX_EXTENT_LABEL_LEN, "%s", buf);
+	return len;
+}
+static DEVICE_ATTR_RW(label);
+
+static struct attribute *dr_extent_attrs[] = {
+	&dev_attr_length.attr,
+	&dev_attr_label.attr,
+	NULL,
+};
+
+static const struct attribute_group dr_extent_attribute_group = {
+	.attrs = dr_extent_attrs,
+};
+
+static void dr_extent_release(struct device *dev)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev = to_dr_ext_dev(dev);
+
+	kfree(dr_reg_ext_dev);
+}
+
+static const struct attribute_group *dr_extent_attribute_groups[] = {
+	&dr_extent_attribute_group,
+	NULL,
+};
+
+const struct device_type dr_extent_type = {
+	.name = "extent",
+	.release = dr_extent_release,
+	.groups = dr_extent_attribute_groups,
+};
+
+static void unregister_dr_extent(void *ext)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev = ext;
+	struct dax_region_extent *dr_extent;
+
+	dr_extent = dr_reg_ext_dev->dr_extent;
+	dev_dbg(&dr_reg_ext_dev->dev, "Unregister DAX region ext OFF:%llx L:%s\n",
+		dr_reg_ext_dev->offset, dr_reg_ext_dev->label);
+	dr_extent_put(dr_extent);
+	device_unregister(&dr_reg_ext_dev->dev);
+}
+
+int dax_region_ext_create_dev(struct dax_region *dax_region,
+			      struct dax_region_extent *dr_extent,
+			      resource_size_t offset,
+			      resource_size_t length,
+			      const char *label)
+{
+	struct dax_reg_ext_dev *dr_reg_ext_dev;
+	struct device *dev;
+	int rc;
+
+	dr_reg_ext_dev = kzalloc(sizeof(*dr_reg_ext_dev), GFP_KERNEL);
+	if (!dr_reg_ext_dev)
+		return -ENOMEM;
+
+	dr_reg_ext_dev->dr_extent = dr_extent;
+	dr_reg_ext_dev->offset = offset;
+	dr_reg_ext_dev->length = length;
+	snprintf(dr_reg_ext_dev->label, DAX_EXTENT_LABEL_LEN, "%s", label);
+
+	dev = &dr_reg_ext_dev->dev;
+	device_initialize(dev);
+	dev->id = offset / PMD_SIZE ;
+	device_set_pm_not_required(dev);
+	dev->parent = dax_region->dev;
+	dev->type = &dr_extent_type;
+	rc = dev_set_name(dev, "extent%d", dev->id);
+	if (rc)
+		goto err;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	dev_dbg(dev, "DAX region extent OFF:%llx LEN:%llx\n",
+		dr_reg_ext_dev->offset, dr_reg_ext_dev->length);
+	return devm_add_action_or_reset(dax_region->dev, unregister_dr_extent,
+					dr_reg_ext_dev);
+
+err:
+	dev_err(dev, "Failed to initialize DAX extent dev OFF:%llx LEN:%llx\n",
+		dr_reg_ext_dev->offset, dr_reg_ext_dev->length);
+	put_device(dev);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(dax_region_ext_create_dev);

-- 
2.41.0

