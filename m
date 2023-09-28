Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90A7B26A2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 22:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjI1Ua4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjI1Uax (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 16:30:53 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0C1A2;
        Thu, 28 Sep 2023 13:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695933052; x=1727469052;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=H/aRLMgJ+0o4ZU3Uqc3hhl5jnLuNWUSJWpDXLqwmub4=;
  b=auf+cU8wpt2EqlB2vNCTRcaztnVO8FXNit3y/Mupdpp98uzCBFxiFUEq
   IefKIfz8LEwrHKmIrq70xtdB5f9Ny+GJRQkz0U4Yxe2Tuo99+vNTQqoZh
   /qb2Izk1rR56rLnuvmvXSJ15jvw3RhLFEBuL2MThfN39SI7M1rw1X9BnD
   qFL5d/w9X68yDUn4ppoKTzpueJegoo8Z/XTZ7U5+DuM99EeCJSUcGxPf3
   eI8abCAR5h52xr4rbG49lJaZdk9v9sVP0xyysMNqXLqWy0x+xUlMXgpFz
   XSDYUHvlYOueYd2RDRgfCd9j2BIQU7ySasuibcxP9KVWLp+o6JrAYWR1G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="367229674"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="367229674"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:30:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="815374356"
X-IronPort-AV: E=Sophos;i="6.03,185,1694761200"; 
   d="scan'208";a="815374356"
Received: from bdsebast-mobl1.amr.corp.intel.com (HELO [192.168.1.200]) ([10.212.125.211])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 13:30:30 -0700
From:   Vishal Verma <vishal.l.verma@intel.com>
Date:   Thu, 28 Sep 2023 14:30:10 -0600
Subject: [PATCH v4 1/2] mm/memory_hotplug: split memmap_on_memory requests
 across memblocks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230928-vv-kmem_memmap-v4-1-6ff73fec519a@intel.com>
References: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
In-Reply-To: <20230928-vv-kmem_memmap-v4-0-6ff73fec519a@intel.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8303;
 i=vishal.l.verma@intel.com; h=from:subject:message-id;
 bh=H/aRLMgJ+0o4ZU3Uqc3hhl5jnLuNWUSJWpDXLqwmub4=;
 b=owGbwMvMwCXGf25diOft7jLG02pJDKmij9Jup70Lb+j7w8dyLPWqvxbHrJnR7GZ7nfZNfbRSW
 vN5w8FdHaUsDGJcDLJiiix/93xkPCa3PZ8nMMERZg4rE8gQBi5OAZjI7XUM/7SVem+UZJvd3HhF
 T+XoubrovyKsLgwWff1mdzin+G67+Izhn1V9725375+Rcx5en7lKKa6Q6W15cuPRRVO5lTtX+5w
 /wgcA
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
 mm/memory_hotplug.c | 165 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 100 insertions(+), 65 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index f8d3e7427e32..43dbd71a4910 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1380,6 +1380,44 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
@@ -1388,14 +1426,10 @@ static bool mhp_supports_memmap_on_memory(unsigned long size)
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
 
@@ -1436,28 +1470,21 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
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
@@ -1494,8 +1521,6 @@ int __ref add_memory_resource(int nid, struct resource *res, mhp_t mhp_flags)
 		walk_memory_blocks(start, size, NULL, online_memory_block);
 
 	return ret;
-error_free:
-	kfree(params.altmap);
 error:
 	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK))
 		memblock_remove(start, size);
@@ -2146,47 +2171,20 @@ void try_offline_node(int nid)
 }
 EXPORT_SYMBOL(try_offline_node);
 
-static int __ref try_remove_memory(u64 start, u64 size)
+static void __ref __try_remove_memory(int nid, u64 start, u64 size)
 {
+	int rc = 0;
 	struct memory_block *mem;
-	int rc = 0, nid = NUMA_NO_NODE;
 	struct vmem_altmap *altmap = NULL;
 
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
+	rc = walk_memory_blocks(start, size, &mem, test_has_altmap_cb);
+	if (rc) {
+		altmap = mem->altmap;
+		/*
+		 * Mark altmap NULL so that we can add a debug
+		 * check on memblock free.
+		 */
+		mem->altmap = NULL;
 	}
 
 	/* remove memmap entry */
@@ -2219,6 +2217,43 @@ static int __ref try_remove_memory(u64 start, u64 size)
 		try_offline_node(nid);
 
 	mem_hotplug_done();
+}
+
+static int __ref try_remove_memory(u64 start, u64 size)
+{
+	int rc, nid = NUMA_NO_NODE;
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
+	rc = walk_memory_blocks(start, size, &nid, check_memblock_offlined_cb);
+	if (rc)
+		return rc;
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

