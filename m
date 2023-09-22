Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694B97AA9C4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjIVHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIVHK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:10:27 -0400
Received: from out-210.mta0.migadu.com (out-210.mta0.migadu.com [91.218.175.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68167198
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:10:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695366617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YklfUpteE5FTVxoZIVXyNtzYnXnzzLxI2l0gg0fMR4U=;
        b=AFYpk1uq44SipDFiOBO/r4CBpTdJf11xLhKC3MBb7kaBEY5+vQeckQrlIU+3y3vfuW33xS
        T2mK50ZEPqJJLFI3vGfPNpey/+U8/pdmze2yWsY1x79c7yi/xA5LllfZ122JnR+CSx0glc
        RY5VQg6TmowLlVqe3uOL2GyJOGwdJA4=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, david@redhat.com,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 3/4] mm: Set page count and mark page reserved in reserve_bootmem_region
Date:   Fri, 22 Sep 2023 15:09:22 +0800
Message-Id: <20230922070923.355656-4-yajun.deng@linux.dev>
In-Reply-To: <20230922070923.355656-1-yajun.deng@linux.dev>
References: <20230922070923.355656-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init_range() would set page count of all pages, but the free
pages count would be reset in __free_pages_core(). These two are
opposite operations. It's unnecessary and time-consuming when it's
in MEMINIT_EARLY context.

Set page count and mark page reserved in reserve_bootmem_region when
in MEMINIT_EARLY context, and change the context from MEMINIT_LATE
to MEMINIT_EARLY in __free_pages_memory.

At the same time, the init list head in reserve_bootmem_region isn't
need. As it already done in __init_single_page.

The following data was tested on an x86 machine with 190GB of RAM.

before:
free_low_memory_core_early()	342ms

after:
free_low_memory_core_early()	286ms

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 mm/memblock.c   |  2 +-
 mm/mm_init.c    | 20 ++++++++++++++------
 mm/page_alloc.c |  8 +++++---
 3 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/mm/memblock.c b/mm/memblock.c
index a32364366bb2..9276f1819982 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2089,7 +2089,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
 
-		memblock_free_pages(start, order, MEMINIT_LATE);
+		memblock_free_pages(start, order, MEMINIT_EARLY);
 
 		start += (1UL << order);
 	}
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0a4437aae30d..1cc310f706a9 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -718,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, true, false);
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, false, false);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
@@ -756,8 +756,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 
 			init_reserved_page(start_pfn, nid);
 
-			/* Avoid false-positive PageTail() */
-			INIT_LIST_HEAD(&page->lru);
+			/* Set page count for the reserve region */
+			init_page_count(page);
 
 			/*
 			 * no need for atomic set_bit because the struct
@@ -888,9 +888,17 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		}
 
 		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid, true, false);
-		if (context == MEMINIT_HOTPLUG)
-			__SetPageReserved(page);
+
+		/* If the context is MEMINIT_EARLY, we will set page count and
+		 * mark page reserved in reserve_bootmem_region, the free region
+		 * wouldn't have page count and reserved flag and we don't
+		 * need to reset pages count and clear reserved flag in
+		 * __free_pages_core.
+		 */
+		if (context == MEMINIT_EARLY)
+			__init_single_page(page, pfn, zone, nid, false, false);
+		else
+			__init_single_page(page, pfn, zone, nid, true, true);
 
 		/*
 		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6c4f4531bee0..6ac58c5f3b00 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1285,9 +1285,11 @@ void __free_pages_core(struct page *page, unsigned int order, enum meminit_conte
 	unsigned int loop;
 
 	/*
-	 * When initializing the memmap, __init_single_page() sets the refcount
-	 * of all pages to 1 ("allocated"/"not free"). We have to set the
-	 * refcount of all involved pages to 0.
+	 * When initializing the memmap, memmap_init_range sets the refcount
+	 * of all pages to 1 ("allocated"/"not free") in hotplug context. We
+	 * have to set the refcount of all involved pages to 0. Otherwise,
+	 * we don't do it, as reserve_bootmem_region only set the refcount on
+	 * reserve region ("allocated") in early context.
 	 */
 	if (context != MEMINIT_EARLY) {
 		prefetchw(p);
-- 
2.25.1

