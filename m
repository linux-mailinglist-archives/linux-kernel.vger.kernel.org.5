Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527CA7AE57B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 08:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjIZGH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 02:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233740AbjIZGHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 02:07:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E81EF2
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 23:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695708426; x=1727244426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=kfBl53G6+3W4hrsT7f5lhn9OvXRFwRRxK2VozpSoI5M=;
  b=VgdPw6QLQMqXwGtPPcXgzveZaqJMSsZBpYMYFsrXunrJFyQvzpILWg3l
   J759AoQw+9Ro2Nxs0qWvI0maFrn+K4d5xXiUHpX7Mn9c+fy7PLhSWDMhQ
   n+yUfAkHJLPdL+ajDj07RC+haIqf084THkyAtghlb5C0sIV/F8i3bUTvB
   c083m/yE29/mBU64fdS6cOau4qD2TQUgSz9RjlzBqA3mT1zpuryGZDs4k
   vAvnOD1Zqm+U5HPxL6lHLKoAxYlPN+2sXRll3ZGAdBDbxwlA/JYJUviGH
   8gJh8NCUaYBDnuaPexyT0Y26NhCecdRF1F42XuhErbn1t+OuKB9v1W+fG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="447990867"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="447990867"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:07:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="892074807"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="892074807"
Received: from aozhu-mobl.ccr.corp.intel.com (HELO yhuang6-mobl2.ccr.corp.intel.com) ([10.255.31.94])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 23:05:56 -0700
From:   Huang Ying <ying.huang@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Huang Ying <ying.huang@intel.com>,
        Bharata B Rao <bharata@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
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
        Rafael J Wysocki <rafael.j.wysocki@intel.com>
Subject: [PATCH -V4 4/4] dax, kmem: calculate abstract distance with general interface
Date:   Tue, 26 Sep 2023 14:06:28 +0800
Message-Id: <20230926060628.265989-5-ying.huang@intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230926060628.265989-1-ying.huang@intel.com>
References: <20230926060628.265989-1-ying.huang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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
Cc: Rafael J Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/dax/kmem.c           | 62 ++++++++++++++++++++++++++++--------
 include/linux/memory-tiers.h |  2 ++
 mm/memory-tiers.c            |  3 +-
 3 files changed, 53 insertions(+), 14 deletions(-)

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
index fa1a8b418f9a..a28606e65ef3 100644
--- a/mm/memory-tiers.c
+++ b/mm/memory-tiers.c
@@ -586,13 +586,14 @@ EXPORT_SYMBOL_GPL(init_node_memory_type);
 void clear_node_memory_type(int node, struct memory_dev_type *memtype)
 {
 	mutex_lock(&memory_tier_lock);
-	if (node_memory_types[node].memtype == memtype)
+	if (node_memory_types[node].memtype == memtype || !memtype)
 		node_memory_types[node].map_count--;
 	/*
 	 * If we umapped all the attached devices to this node,
 	 * clear the node memory type.
 	 */
 	if (!node_memory_types[node].map_count) {
+		memtype = node_memory_types[node].memtype;
 		node_memory_types[node].memtype = NULL;
 		put_memory_type(memtype);
 	}
-- 
2.39.2

