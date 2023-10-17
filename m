Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CABA7CBA48
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjJQFpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbjJQFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:45:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950FBF1;
        Mon, 16 Oct 2023 22:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697521508; x=1729057508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=mEPqGi0w6uK1G2oMRp9GXgOlOlinp7OhMTBnsnQmtwo=;
  b=UK98nJdBbbrgH0DT6Gk1VC3o8rrh7FwHbAwKUndOQ+JFb/LSD6z4Wpqv
   5kQ3pUO6tyJTqqG6WvRKaDfIE1o4FXR30NJpzztFtCwCSiuG6fxT50gMJ
   CnfZdTmynmP+tgdM165FWNsQA0B4R6yEaqMPpPF0HAf4vlMrBhUpYcpJ4
   D9IFA6TZ8ARMqTqNPdLsiTvf5czPr9VSDDp4sWwxUSUdSU53xzCCNEJtz
   qUo+j3g3bBVYVEOak2PWp+HYe9z8pU2JIVTu3YLKr/tmrHs9m0+2qGi8R
   M0eXjfDVminr5hSokRdZpYJSA8JYgu10ue0o06ktCQVIhIvyIRWegDyz4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384580770"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384580770"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879694030"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="879694030"
Received: from mjwirth-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.151.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:04 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 16 Oct 2023 23:44:57 -0600
Subject: [PATCH v6 3/3] dax/kmem: allow kmem to add memory with
 memmap_on_memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-vv-kmem_memmap-v6-3-078f0d3c0371@intel.com>
References: <20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com>
In-Reply-To: <20231016-vv-kmem_memmap-v6-0-078f0d3c0371@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Michal Hocko <mhocko@suse.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jeff Moyer <jmoyer@redhat.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4972;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=mEPqGi0w6uK1G2oMRp9GXgOlOlinp7OhMTBnsnQmtwo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKl68jEzt8d3qO3/2R3M0dv+gfv651PmOwQzOZilr5kzn
 l/89seZjlIWBjEuBlkxRZa/ez4yHpPbns8TmOAIM4eVCWQIAxenAEwkbgkjw7E7Lm+Z2b88qLgv
 Enox7OdGbbO9nLmXTvo+nsDxxX1WbCDD/7RVxdElk1n/SNmXxwW82D9HtfDNb3vGQlunA9vfr31
 +mQcA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Large amounts of memory managed by the kmem driver may come in via CXL,
and it is often desirable to have the memmap for this memory on the new
memory itself.

Enroll kmem-managed memory for memmap_on_memory semantics if the dax
region originates via CXL. For non-CXL dax regions, retain the existing
default behavior of hot adding without memmap_on_memory semantics.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 drivers/dax/bus.h         | 1 +
 drivers/dax/dax-private.h | 1 +
 drivers/dax/bus.c         | 3 +++
 drivers/dax/cxl.c         | 1 +
 drivers/dax/hmem/hmem.c   | 1 +
 drivers/dax/kmem.c        | 8 +++++++-
 drivers/dax/pmem.c        | 1 +
 7 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 1ccd23360124..cbbf64443098 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -23,6 +23,7 @@ struct dev_dax_data {
 	struct dev_pagemap *pgmap;
 	resource_size_t size;
 	int id;
+	bool memmap_on_memory;
 };
 
 struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data);
diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index 27cf2daaaa79..446617b73aea 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -70,6 +70,7 @@ struct dev_dax {
 	struct ida ida;
 	struct device dev;
 	struct dev_pagemap *pgmap;
+	bool memmap_on_memory;
 	int nr_range;
 	struct dev_dax_range {
 		unsigned long pgoff;
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0ee96e6fc426..ad9f821b8c78 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -367,6 +367,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
 			.dax_region = dax_region,
 			.size = 0,
 			.id = -1,
+			.memmap_on_memory = false,
 		};
 		struct dev_dax *dev_dax = devm_create_dev_dax(&data);
 
@@ -1400,6 +1401,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
 	dev_dax->align = dax_region->align;
 	ida_init(&dev_dax->ida);
 
+	dev_dax->memmap_on_memory = data->memmap_on_memory;
+
 	inode = dax_inode(dax_dev);
 	dev->devt = inode->i_rdev;
 	dev->bus = &dax_bus_type;
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 8bc9d04034d6..c696837ab23c 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -26,6 +26,7 @@ static int cxl_dax_region_probe(struct device *dev)
 		.dax_region = dax_region,
 		.id = -1,
 		.size = range_len(&cxlr_dax->hpa_range),
+		.memmap_on_memory = true,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
index 5d2ddef0f8f5..b9da69f92697 100644
--- a/drivers/dax/hmem/hmem.c
+++ b/drivers/dax/hmem/hmem.c
@@ -36,6 +36,7 @@ static int dax_hmem_probe(struct platform_device *pdev)
 		.dax_region = dax_region,
 		.id = -1,
 		.size = region_idle ? 0 : range_len(&mri->range),
+		.memmap_on_memory = false,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));
diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c57acb73e3db..0aa6c45a4e5a 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -12,6 +12,7 @@
 #include <linux/mm.h>
 #include <linux/mman.h>
 #include <linux/memory-tiers.h>
+#include <linux/memory_hotplug.h>
 #include "dax-private.h"
 #include "bus.h"
 
@@ -56,6 +57,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 	unsigned long total_len = 0;
 	struct dax_kmem_data *data;
 	int i, rc, mapped = 0;
+	mhp_t mhp_flags;
 	int numa_node;
 
 	/*
@@ -136,12 +138,16 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		 */
 		res->flags = IORESOURCE_SYSTEM_RAM;
 
+		mhp_flags = MHP_NID_IS_MGID;
+		if (dev_dax->memmap_on_memory)
+			mhp_flags |= MHP_MEMMAP_ON_MEMORY;
+
 		/*
 		 * Ensure that future kexec'd kernels will not treat
 		 * this as RAM automatically.
 		 */
 		rc = add_memory_driver_managed(data->mgid, range.start,
-				range_len(&range), kmem_name, MHP_NID_IS_MGID);
+				range_len(&range), kmem_name, mhp_flags);
 
 		if (rc) {
 			dev_warn(dev, "mapping%d: %#llx-%#llx memory add failed\n",
diff --git a/drivers/dax/pmem.c b/drivers/dax/pmem.c
index ae0cb113a5d3..f3c6c67b8412 100644
--- a/drivers/dax/pmem.c
+++ b/drivers/dax/pmem.c
@@ -63,6 +63,7 @@ static struct dev_dax *__dax_pmem_probe(struct device *dev)
 		.id = id,
 		.pgmap = &pgmap,
 		.size = range_len(&range),
+		.memmap_on_memory = false,
 	};
 
 	return devm_create_dev_dax(&data);

-- 
2.41.0

