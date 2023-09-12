Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89E279C9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbjILIWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 04:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232568AbjILIVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 04:21:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E37D810E5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 01:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694506909; x=1726042909;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9suKmuHrRCqPZ954lWyRT88cx6w5DPJyIVkc7QOTcgM=;
  b=RXWUjgOf2lcUdMT6SFAE7m9CSY0ZsaP1uCpDdRnDkVU2hW2h743nJyVI
   vAWgOlKDWMbxJmdSjbAEE3/j7Xapbsw+mQ0gJxavEO0iK9EMCfpRqyv5c
   x3bdF0JesCvieYik2sdMyU1rMDT1ASDQSL5t8FsFlFNSw9JhxY01h2mcQ
   6b8OQNK1agqcFBb9ApsroydIdgMvziFrzFAvY/4uMIFQrbCWTcJiph6fI
   Dvig3IogDAWAhAURqlYR/qasoxI1EegVNqn7HF9IBqAop80m9mYDqPDDk
   OTN8oBzkggRwM54wO4n0RN53kTbs25lYYDC99N2UByGzW162i0z07Rf2K
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="442323074"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="442323074"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="746787712"
X-IronPort-AV: E=Sophos;i="6.02,245,1688454000"; 
   d="scan'208";a="746787712"
Received: from shicha9x-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.28.213])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 01:21:43 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Yang Shi <shy828301@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH -V3 4/4] dax, kmem: calculate abstract distance with general interface
Date:   Tue, 12 Sep 2023 16:21:01 +0800
Message-Id: <20230912082101.342002-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230912082101.342002-1-ying.huang@intel.com>
References: <20230912082101.342002-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previously, a fixed abstract distance MEMTIER_DEFAULT_DAX_ADISTANCE is
used for slow memory type in kmem driver.  This limits the usage of
kmem driver, for example, it cannot be used for HBM (high bandwidth
memory).

So, we use the general abstract distance calculation mechanism in kmem
drivers to get more accurate abstract distance on systems with proper
support.  The original MEMTIER_DEFAULT_DAX_ADISTANCE is used as
fallback only.

Now, multiple memory types may be managed by kmem.  These memory types
are put into the "kmem_memory_types" list and protected by
kmem_memory_type_lock.

Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
Tested-by: Bharata B Rao <bharata@amd.com>
Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Cc: Wei Xu <weixugc@google.com>
Cc: Alistair Popple <apopple@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Yang Shi <shy828301@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/dax/kmem.c           | 62 ++++++++++++++++++++++++++++--------
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            |  2 +-
 3 files changed, 52 insertions(+), 14 deletions(-)

diff --git a/drivers/dax/kmem.c b/drivers/dax/kmem.c
index c57acb73e3db..369c698b7706 100644
--- a/drivers/dax/kmem.c
+++ b/drivers/dax/kmem.c
@@ -49,14 +49,52 @@ struct dax_kmem_data {
 	struct resource *res[];
 };
 
-static struct memory_dev_type *dax_slowmem_type;
+static DEFINE_MUTEX(kmem_memory_type_lock);
+static LIST_HEAD(kmem_memory_types);
+
+static struct memory_dev_type *kmem_find_alloc_memory_type(int adist)
+{
+	bool found = false;
+	struct memory_dev_type *mtype;
+
+	mutex_lock(&kmem_memory_type_lock);
+	list_for_each_entry(mtype, &kmem_memory_types, list) {
+		if (mtype->adistance == adist) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		mtype = alloc_memory_type(adist);
+		if (!IS_ERR(mtype))
+			list_add(&mtype->list, &kmem_memory_types);
+	}
+	mutex_unlock(&kmem_memory_type_lock);
+
+	return mtype;
+}
+
+static void kmem_put_memory_types(void)
+{
+	struct memory_dev_type *mtype, *mtn;
+
+	mutex_lock(&kmem_memory_type_lock);
+	list_for_each_entry_safe(mtype, mtn, &kmem_memory_types, list) {
+		list_del(&mtype->list);
+		put_memory_type(mtype);
+	}
+	mutex_unlock(&kmem_memory_type_lock);
+}
+
 static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 {
 	struct device *dev = &dev_dax->dev;
 	unsigned long total_len = 0;
 	struct dax_kmem_data *data;
+	struct memory_dev_type *mtype;
 	int i, rc, mapped = 0;
 	int numa_node;
+	int adist = MEMTIER_DEFAULT_DAX_ADISTANCE;
 
 	/*
 	 * Ensure good NUMA information for the persistent memory.
@@ -71,6 +109,11 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
+	mt_calc_adistance(numa_node, &adist);
+	mtype = kmem_find_alloc_memory_type(adist);
+	if (IS_ERR(mtype))
+		return PTR_ERR(mtype);
+
 	for (i = 0; i < dev_dax->nr_range; i++) {
 		struct range range;
 
@@ -88,7 +131,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 		return -EINVAL;
 	}
 
-	init_node_memory_type(numa_node, dax_slowmem_type);
+	init_node_memory_type(numa_node, mtype);
 
 	rc = -ENOMEM;
 	data = kzalloc(struct_size(data, res, dev_dax->nr_range), GFP_KERNEL);
@@ -167,7 +210,7 @@ static int dev_dax_kmem_probe(struct dev_dax *dev_dax)
 err_res_name:
 	kfree(data);
 err_dax_kmem_data:
-	clear_node_memory_type(numa_node, dax_slowmem_type);
+	clear_node_memory_type(numa_node, mtype);
 	return rc;
 }
 
@@ -219,7 +262,7 @@ static void dev_dax_kmem_remove(struct dev_dax *dev_dax)
 		 * for that. This implies this reference will be around
 		 * till next reboot.
 		 */
-		clear_node_memory_type(node, dax_slowmem_type);
+		clear_node_memory_type(node, NULL);
 	}
 }
 #else
@@ -251,12 +294,6 @@ static int __init dax_kmem_init(void)
 	if (!kmem_name)
 		return -ENOMEM;
 
-	dax_slowmem_type = alloc_memory_type(MEMTIER_DEFAULT_DAX_ADISTANCE);
-	if (IS_ERR(dax_slowmem_type)) {
-		rc = PTR_ERR(dax_slowmem_type);
-		goto err_dax_slowmem_type;
-	}
-
 	rc = dax_driver_register(&device_dax_kmem_driver);
 	if (rc)
 		goto error_dax_driver;
@@ -264,8 +301,7 @@ static int __init dax_kmem_init(void)
 	return rc;
 
 error_dax_driver:
-	put_memory_type(dax_slowmem_type);
-err_dax_slowmem_type:
+	kmem_put_memory_types();
 	kfree_const(kmem_name);
 	return rc;
 }
@@ -275,7 +311,7 @@ static void __exit dax_kmem_exit(void)
 	dax_driver_unregister(&device_dax_kmem_driver);
 	if (!any_hotremove_failed)
 		kfree_const(kmem_name);
-	put_memory_type(dax_slowmem_type);
+	kmem_put_memory_types();
 }
 
 MODULE_AUTHOR("Intel Corporation");
diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
index 9d27ca3b143e..ab6651402d7e 100644
--- a/include/linux/memory-tiers.h
+++ b/include/linux/memory-tiers.h
@@ -24,6 +24,8 @@ struct memory_tier;
 struct memory_dev_type {
 	/* list of memory types that are part of same tier as this type */
 	struct list_head tier_sibiling;
+	/* list of memory types that are managed by one driver */
+	struct list_head list;
 	/* abstract distance for this specific memory type */
 	int adistance;
 	/* Nodes of same abstract distance */
diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
index fa1a8b418f9a..ca68ef17554b 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -586,7 +586,7 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 {
 	mutex_lock(&memory_tier_lock);
-	if (node_memory_types[node].memtype == memtype)
+	if (node_memory_types[node].memtype == memtype || !memtype)
 		node_memory_types[node].map_count--;
 	/*
 	 * If we umapped all the attached devices to this node,
-- 
2.39.2

