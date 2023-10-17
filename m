Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0BE47CBA49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 07:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjJQFpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 01:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjJQFpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 01:45:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA33EB;
        Mon, 16 Oct 2023 22:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697521508; x=1729057508;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Lq39RP77AGx79p/R4lwUeEqGvV0zLaTcEMTevTVFlkc=;
  b=CsdSQOCNQR+GlY1vecncX5FoVqlzZsdCkxoVmDa7b45lArJkz0c39vVn
   3BN0t11/cih9Bkci/WsiXfNZhbKjJgppZuVmYNK2XZvBbZr2Bms+4CyfY
   75VmyqEwlD794I4mMmu+OxcdLT7XM4eH6UwGIgCED7tbk+8qh3r7+zBu2
   QW0Fy0pipN4VYnUWfgma3nl3AG/wi5EArWhT3H0RZZX1/SJHGTVZl18yK
   +CPCsls6WJk0RSI8lAqJGckXPJbrbewuxvT9vEam0WEOT7TYz8Mw2PU1Q
   HZ9pn0lI/LRry3kGTy5Q5+YufLKv984uUnjZ6PaYJihtUgGrYQF0l5LwA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="384580760"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="384580760"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879694028"
X-IronPort-AV: E=Sophos;i="6.03,231,1694761200"; 
   d="scan'208";a="879694028"
Received: from mjwirth-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.151.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2023 22:45:03 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Mon, 16 Oct 2023 23:44:56 -0600
Subject: [PATCH v6 2/3] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231016-vv-kmem_memmap-v6-2-078f0d3c0371@intel.com>
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
        Vishal Verma <vishal.l.verma@intel.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9952;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=Lq39RP77AGx79p/R4lwUeEqGvV0zLaTcEMTevTVFlkc=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKl68jFqF6OYWHfL2patP9zwmjXKN3l1vZSNN8f1DX/85
 5ke2r+1o5SFQYyLQVZMkeXvno+Mx+S25/MEJjjCzGFlAhnCwMUpABPJUmP4K9m0/j+T8YVPvx6o
 3Xrq5PXw2RLm51K+3Vt3rXvI0HfmpSlQRaXxla1ltxb+USp/ynjofJbxrCX8J+NPXXPXXrdILsi
 ACQA=
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

The MHP_MEMMAP_ON_MEMORY flag for hotplugged memory is restricted to
'memblock_size' chunks of memory being added. Adding a larger span of
memory precludes memmap_on_memory semantics.

For users of hotplug such as kmem, large amounts of memory might get
added from the CXL subsystem. In some cases, this amount may exceed the
available 'main memory' to store the memmap for the memory being added.
In this case, it is useful to have a way to place the memmap on the
memory being added, even if it means splitting the addition into
memblock-sized chunks.

Change add_memory_resource() to loop over memblock-sized chunks of
memory if caller requested memmap_on_memory, and if other conditions for
it are met. Teach try_remove_memory() to also expect that a memory
range being removed might have been split up into memblock sized chunks,
and to loop through those as needed.

This does preclude being able to use PUD mappings in the direct map; a
proposal to how this could be optimized in the future is laid out
here[1].

[1]: https://lore.kernel.org/linux-mm/b6753402-2de9-25b2-36e9-eacd49752b19@redhat.com/

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 214 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 148 insertions(+), 66 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 6be7de9efa55..83e5ec377aad 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1380,6 +1380,43 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
 	return arch_supports_memmap_on_memory(vmemmap_size);
 }
 
+static int add_memory_create_devices(int nid, struct memory_group *group,
+				     u64 start, u64 size, mhp_t mhp_flags)
+{
+	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	struct vmem_altmap mhp_altmap = {
+		.base_pfn =  PHYS_PFN(start),
+		.end_pfn  =  PHYS_PFN(start + size - 1),
+	};
+	int ret;
+
+	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY)) {
+		mhp_altmap.free = memory_block_memmap_on_memory_pages();
+		params.altmap = kmemdup(&mhp_altmap, sizeof(struct vmem_altmap),
+					GFP_KERNEL);
+		if (!params.altmap)
+			return -ENOMEM;
+	}
+
+	/* call arch's memory hotadd */
+	ret = arch_add_memory(nid, start, size, &params);
+	if (ret < 0)
+		goto error;
+
+	/* create memory block devices after memory was added */
+	ret = create_memory_block_devices(start, size, params.altmap, group);
+	if (ret)
+		goto err_bdev;
+
+	return 0;
+
+err_bdev:
+	arch_remove_memory(start, size, NULL);
+error:
+	kfree(params.altmap);
+	return ret;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1388,14 +1425,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
  */
 int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 {
-	struct mhp_params params = { .pgprot = pgprot_mhp(PAGE_KERNEL) };
+	unsigned long memblock_size = memory_block_size_bytes();
 	enum memblock_flags memblock_flags = MEMBLOCK_NONE;
-	struct vmem_altmap mhp_altmap = {
-		.base_pfn =  PHYS_PFN(res->start),
-		.end_pfn  =  PHYS_PFN(res->end),
-	};
 	struct memory_group *group = NULL;
-	u64 start, size;
+	u64 start, size, cur_start;
 	bool new_node = false;
 	int ret;
 
@@ -1436,28 +1469,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/*
 	 * Self hosted memmap array
 	 */
-	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
-		if (mhp_supports_memmap_on_memory(size)) {
-			mhp_altmap.free = memory_block_memmap_on_memory_pages();
-			params.altmap = kmemdup(&mhp_altmap,
-						sizeof(struct vmem_altmap),
-						GFP_KERNEL);
-			if (!params.altmap)
+	if ((mhp_flags & MHP_MEMMAP_ON_MEMORY) &&
+	    mhp_supports_memmap_on_memory(memblock_size)) {
+		for (cur_start = start; cur_start < start + size;
+		     cur_start += memblock_size) {
+			ret = add_memory_create_devices(nid, group, cur_start,
+							memblock_size,
+							mhp_flags);
+			if (ret)
 				goto error;
 		}
-		/* fallback to not using altmap  */
-	}
-
-	/* call arch's memory hotadd */
-	ret = arch_add_memory(nid, start, size, &params);
-	if (ret < 0)
-		goto error_free;
-
-	/* create memory block devices after memory was added */
-	ret = create_memory_block_devices(start, size, params.altmap, group);
-	if (ret) {
-		arch_remove_memory(start, size, NULL);
-		goto error_free;
+	} else {
+		ret = add_memory_create_devices(nid, group, start, size,
+						mhp_flags);
+		if (ret)
+			goto error;
 	}
 
 	if (new_node) {
@@ -1494,8 +1520,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
 
 	return ret;
-error_free:
-	kfree(params.altmap);
 error:
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
@@ -2076,6 +2100,23 @@ static int test_has_altmap_cb(struct memory_block *mem, void *arg)
 	return 0;
 }
 
+struct memory_range_altmap_info {
+	u64 num_memblocks;
+	u64 num_altmaps;
+};
+
+static int count_memory_range_altmaps_cb(struct memory_block *mem, void *arg)
+{
+	struct memory_range_altmap_info *altmap_info =
+		(struct memory_range_altmap_info *)arg;
+
+	altmap_info->num_memblocks += 1;
+	if (mem->altmap)
+		altmap_info->num_altmaps += 1;
+
+	return 0;
+}
+
 static int check_cpu_on_node(int nid)
 {
 	int cpu;
@@ -2146,11 +2187,75 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-static int __ref try_remove_memory(u64 start, u64 size)
+static void __ref remove_memory_blocks_and_altmaps(u64 start, u64 size)
 {
-	struct memory_block *mem;
-	int rc = 0, nid = NUMA_NO_NODE;
+	unsigned long memblock_size = memory_block_size_bytes();
 	struct vmem_altmap *altmap = NULL;
+	struct memory_block *mem;
+	u64 cur_start;
+	int rc;
+
+	/*
+	 * For memmap_on_memory, the altmaps could have been added on
+	 * a per-memblock basis. Loop through the entire range if so,
+	 * and remove each memblock and its altmap.
+	 */
+	for (cur_start = start; cur_start < start + size;
+	     cur_start += memblock_size) {
+		rc = walk_memory_blocks(cur_start, memblock_size, &mem,
+					test_has_altmap_cb);
+		if (rc) {
+			altmap = mem->altmap;
+			/*
+			 * Mark altmap NULL so that we can add a debug
+			 * check on memblock free.
+			 */
+			mem->altmap = NULL;
+		}
+
+		/*
+		 * Memory block device removal under the device_hotplug_lock is
+		 * a barrier against racing online attempts.
+		 */
+		remove_memory_block_devices(cur_start, memblock_size);
+
+		arch_remove_memory(cur_start, memblock_size, altmap);
+
+		/* Verify that all vmemmap pages have actually been freed. */
+		if (altmap) {
+			WARN(altmap->alloc, "Altmap not fully unmapped");
+			kfree(altmap);
+		}
+	}
+}
+
+static int memblocks_have_altmaps(u64 start, u64 size)
+{
+	struct memory_range_altmap_info altmap_info = {
+		.num_memblocks = 0,
+		.num_altmaps = 0
+	};
+
+	if (!mhp_memmap_on_memory())
+		return 0;
+
+	walk_memory_blocks(start, size, &altmap_info,
+			   count_memory_range_altmaps_cb);
+
+	if (!altmap_info.num_altmaps)
+		return 0;
+
+	if (altmap_info.num_memblocks != altmap_info.num_altmaps) {
+		WARN_ONCE(1, "Not all memblocks in range have altmaps");
+		return -EINVAL;
+	}
+
+	return 1;
+}
+
+static int __ref try_remove_memory(u64 start, u64 size)
+{
+	int rc, nid = NUMA_NO_NODE;
 
 	BUG_ON(check_hotplug_memory_range(start, size));
 
@@ -2167,45 +2272,21 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	if (rc)
 		return rc;
 
-	/*
-	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
-	 * the same granularity it was added - a single memory block.
-	 */
-	if (mhp_memmap_on_memory()) {
-		rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
-		if (rc) {
-			if (size != memory_block_size_bytes()) {
-				pr_warn("Refuse to remove %#llx - %#llx,"
-					"wrong granularity\n",
-					start, start + size);
-				return -EINVAL;
-			}
-			altmap = mem->altmap;
-			/*
-			 * Mark altmap NULL so that we can add a debug
-			 * check on memblock free.
-			 */
-			mem->altmap = NULL;
-		}
-	}
-
 	/* remove memmap entry */
 	firmware_map_remove(start, start + size, "System RAM");
 
-	/*
-	 * Memory block device removal under the device_hotplug_lock is
-	 * a barrier against racing online attempts.
-	 */
-	remove_memory_block_devices(start, size);
-
 	mem_hotplug_begin();
 
-	arch_remove_memory(start, size, altmap);
-
-	/* Verify that all vmemmap pages have actually been freed. */
-	if (altmap) {
-		WARN(altmap->alloc, "Altmap not fully unmapped");
-		kfree(altmap);
+	rc = memblocks_have_altmaps(start, size);
+	if (rc < 0) {
+		goto err;
+	} else if (rc == 0) {
+		/* no altmaps, do the removal directly */
+		remove_memory_block_devices(start, size);
+		arch_remove_memory(start, size, NULL);
+	} else {
+		/* all memblocks in the range have altmaps */
+		remove_memory_blocks_and_altmaps(start, size);
 	}
 
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
@@ -2218,8 +2299,9 @@ static int __ref try_remove_memory(u64 start, u64 size)
 	if (nid != NUMA_NO_NODE)
 		try_offline_node(nid);
 
+err:
 	mem_hotplug_done();
-	return 0;
+	return (rc < 0 ? rc : 0);
 }
 
 /**

-- 
2.41.0

