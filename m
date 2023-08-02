Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2A176C50E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 07:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjHBF4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 01:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbjHBF4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 01:56:02 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACCE2122;
        Tue,  1 Aug 2023 22:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690955761; x=1722491761;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=E5mEEIt6gjKxiTw4Ms0ez32FP/kFUb2pffv4TH9UhUo=;
  b=JdRf1nQrsDXgG0oPhb9X4U3ETnJ7CRQPcov7vjlogORfWwNLeJhD589P
   58dH5ShwyA0qv3COjejf8Wftq+Uls0dKa8T99SYsQnfmktJdJPaQSu9FQ
   1rHSAFJKXk5qln2lm7AGrDH1EJKNnLT2lyJKsnF8LFNhP2STdu6ZDXvSo
   2IU17X8plxlL9F21qF/J/YVgILEvOluP1hrv6+ZW5o+MffdNrGdHFyJ/B
   f9kDuCKHLzkTYP2+i9GpcmnaGJjHvNp396Pw2h69o0LkoI47VPsa94BXF
   6F2kWhn29j9W+92/8og5gzHoR8jARNNXOYYAyLWuKM9xHxx3YjA4jXTxj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="455857443"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="455857443"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10789"; a="852746659"
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="scan'208";a="852746659"
Received: from hongrudi-mobl.amr.corp.intel.com (HELO [192.168.1.200]) ([10.209.173.200])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2023 22:55:45 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Tue, 01 Aug 2023 23:55:37 -0600
Subject: [PATCH v3 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230801-vv-kmem_memmap-v3-1-406e9aaf5689@intel.com>
References: <20230801-vv-kmem_memmap-v3-0-406e9aaf5689@intel.com>
In-Reply-To: <20230801-vv-kmem_memmap-v3-0-406e9aaf5689@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7959;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=E5mEEIt6gjKxiTw4Ms0ez32FP/kFUb2pffv4TH9UhUo=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDCkn3z/QY5R+6++V517+ueOljdOXma7Rh56v7l68/K/yv
 /WHP6xp6yhlYRDjYpAVU2T5u+cj4zG57fk8gQmOMHNYmUCGMHBxCsBE+LgYGS7V9LMo1x2d++mW
 1OIvpYrh50pEghW2iNr1GqjfnFj/N52RYbJA1K7qfWnMCUf0l/5+NHvppBCuO1Gmn3VZj95TvlC
 5hxMA
X-Developer-Key: i=vishal.l.verma@intel.com; a=openpgp;
 fpr=F8682BE134C67A12332A2ED07AFA61BEA3B84DFF
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Huang Ying <ying.huang@intel.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 mm/memory_hotplug.c | 150 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 57 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index d282664f558e..cae03c8d4bbf 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1383,6 +1383,44 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
+		params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
+		if (!params.altmap)
+			return -ENOMEM;
+
+		memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
+	}
+
+	/* call arch's memory hotadd */
+	ret = arch_add_memory(nid, start, size, &params);
+	if (ret < 0)
+		goto error;
+
+	/* create memory block devices after memory was added */
+	ret = create_memory_block_devices(start, size, params.altmap, group);
+	if (ret) {
+		arch_remove_memory(start, size, NULL);
+		goto error;
+	}
+
+	return 0;
+
+error:
+	kfree(params.altmap);
+	return ret;
+}
+
 /*
  * NOTE: The caller must call lock_device_hotplug() to serialize hotplug
  * and online/offline operations (triggered e.g. by sysfs).
@@ -1391,14 +1429,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
 
@@ -1439,28 +1473,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 	/*
 	 * Self hosted memmap array
 	 */
-	if (mhp_flags & MHP_MEMMAP_ON_MEMORY) {
-		if (mhp_supports_memmap_on_memory(size)) {
-			mhp_altmap.free = memory_block_memmap_on_memory_pages();
-			params.altmap = kmalloc(sizeof(struct vmem_altmap), GFP_KERNEL);
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
-
-			memcpy(params.altmap, &mhp_altmap, sizeof(mhp_altmap));
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
@@ -1497,8 +1524,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
 
 	return ret;
-error_free:
-	kfree(params.altmap);
 error:
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
@@ -2149,40 +2174,14 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-static int __ref try_remove_memory(u64 start, u64 size)
+static void __ref __try_remove_memory(int nid, u64 start, u64 size)
 {
-	int ret;
-	struct memory_block *mem;
-	int rc = 0, nid = NUMA_NO_NODE;
 	struct vmem_altmap *altmap = NULL;
+	struct memory_block *mem;
+	int ret;
 
-	BUG_ON(check_hotplug_memory_range(start, size));
-
-	/*
-	 * All memory blocks must be offlined before removing memory.  Check
-	 * whether all memory blocks in question are offline and return error
-	 * if this is not the case.
-	 *
-	 * While at it, determine the nid. Note that if we'd have mixed nodes,
-	 * we'd only try to offline the last determined one -- which is good
-	 * enough for the cases we care about.
-	 */
-	rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
-	if (rc)
-		return rc;
-
-	/*
-	 * We only support removing memory added with MHP_MEMMAP_ON_MEMORY in
-	 * the same granularity it was added - a single memory block.
-	 */
 	ret = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
 	if (ret) {
-		if (size != memory_block_size_bytes()) {
-			pr_warn("Refuse to remove %#llx - %#llx,"
-				"wrong granularity\n",
-				start, start + size);
-			return -EINVAL;
-		}
 		altmap = mem->altmap;
 		/*
 		 * Mark altmap NULL so that we can add a debug
@@ -2221,6 +2220,43 @@ static int __ref try_remove_memory(u64 start, u64 size)
 		try_offline_node(nid);
 
 	mem_hotplug_done();
+}
+
+static int __ref try_remove_memory(u64 start, u64 size)
+{
+	int ret, nid = NUMA_NO_NODE;
+
+	BUG_ON(check_hotplug_memory_range(start, size));
+
+	/*
+	 * All memory blocks must be offlined before removing memory.  Check
+	 * whether all memory blocks in question are offline and return error
+	 * if this is not the case.
+	 *
+	 * While at it, determine the nid. Note that if we'd have mixed nodes,
+	 * we'd only try to offline the last determined one -- which is good
+	 * enough for the cases we care about.
+	 */
+	ret = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
+	if (ret)
+		return ret;
+
+	/*
+	 * For memmap_on_memory, the altmaps could have been added on
+	 * a per-memblock basis. Loop through the entire range if so,
+	 * and remove each memblock and its altmap.
+	 */
+	if (mhp_memmap_on_memory()) {
+		unsigned long memblock_size = memory_block_size_bytes();
+		u64 cur_start;
+
+		for (cur_start = start; cur_start < start + size;
+		     cur_start += memblock_size)
+			__try_remove_memory(nid, cur_start, memblock_size);
+	} else {
+		__try_remove_memory(nid, start, size);
+	}
+
 	return 0;
 }
 

-- 
2.41.0

