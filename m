Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB75B7BA92B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjJEScJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjJEScE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:32:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF4C6;
        Thu,  5 Oct 2023 11:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696530722; x=1728066722;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=6MPyfJ9TCOOWqIqYtO0O+rswGranA361S3pLp//iGZE=;
  b=e6HsyKKs7QsDIvxEwMh96G9DJzSwTIXhZKvfyhzJtLDMA69DKUGGqo6E
   fRnw2bxWj4vpeHZy2gWNdcKhKZpHaYMS35y6QcLf2lStIV/jFHZulDsXQ
   mhk/KHbEUVUuYDeumqhh79AIsChWcRQbFV1uy7yugOPEi8jhLXXw50uTg
   vV4h+ikzG9YPYDmBfgtoZhBGxn/6CMbZrD6IibaIaM3XrnVX519mDPCnu
   N3vBM4vzbfUEO7P6SPfRWRFkcmDiTWYGBz6hDBRPRHvdtOLVW4vjrSqU7
   V16yvqdSpoExjFIUZVDAY3JU3Et0UJRVn63CSbCeqeeXEOrVOXj4ugj1F
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363860742"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363860742"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:31:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="781342843"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="781342843"
Received: from amykuo-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.12.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:31:54 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 05 Oct 2023 12:31:40 -0600
Subject: [PATCH v5 2/2] dax/kmem: allow kmem to add memory with
 memmap_on_memory
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231005-vv-kmem_memmap-v5-2-a54d1981f0a3@intel.com>
References: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
In-Reply-To: <20231005-vv-kmem_memmap-v5-0-a54d1981f0a3@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6429;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=6MPyfJ9TCOOWqIqYtO0O+rswGranA361S3pLp//iGZE=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKnyjBJZMtvzxY/rnZRnS5B6+WzZG5k0I03eqFmzWPlE1
 cIS7t/oKGVhEONikBVTZPm75yPjMbnt+TyBCY4wc1iZQIYwcHEKwEQ4fzL8sxL8VRjvf69bNlib
 57zYhYK3GvWrD3OvLEkq+ro53MRJl+F/8UOVGYFydm9mF+84vt5AfMbKXSJ/HtWz9LQ/7dnsEP6
 YCwA=
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Add a sysfs override under the dax device to control this behavior and
override either default.

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
 drivers/dax/bus.h         |  1 +
 drivers/dax/dax-private.h |  1 +
 drivers/dax/bus.c         | 38 ++++++++++++++++++++++++++++++++++++++
 drivers/dax/cxl.c         |  1 +
 drivers/dax/hmem/hmem.c   |  1 +
 drivers/dax/kmem.c        |  8 +++++++-
 drivers/dax/pmem.c        |  1 +
 7 files changed, 50 insertions(+), 1 deletion(-)

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
index 0ee96e6fc426..43be95a231c9 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -367,6 +367,7 @@ static ssize_t create_store(struct device *dev, struct device_attribute *attr,
 			.dax_region = dax_region,
 			.size = 0,
 			.id = -1,
+			.memmap_on_memory = false,
 		};
 		struct dev_dax *dev_dax = devm_create_dev_dax(&data);
 
@@ -1269,6 +1270,40 @@ static ssize_t numa_node_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t memmap_on_memory_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+
+	return sprintf(buf, "%d\n", dev_dax->memmap_on_memory);
+}
+
+static ssize_t memmap_on_memory_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct dev_dax *dev_dax = to_dev_dax(dev);
+	struct dax_region *dax_region = dev_dax->region;
+	ssize_t rc;
+	bool val;
+
+	rc = kstrtobool(buf, &val);
+	if (rc)
+		return rc;
+
+	device_lock(dax_region->dev);
+	if (!dax_region->dev->driver) {
+		device_unlock(dax_region->dev);
+		return -ENXIO;
+	}
+
+	dev_dax->memmap_on_memory = val;
+
+	device_unlock(dax_region->dev);
+	return len;
+}
+static DEVICE_ATTR_RW(memmap_on_memory);
+
 static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1295,6 +1330,7 @@ static struct attribute *dev_dax_attributes[] = {
 	&dev_attr_align.attr,
 	&dev_attr_resource.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_memmap_on_memory.attr,
 	NULL,
 };
 
@@ -1400,6 +1436,8 @@ struct dev_dax *devm_create_dev_dax(struct dev_dax_data *data)
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

