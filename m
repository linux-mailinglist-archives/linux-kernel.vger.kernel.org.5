Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25ABA7B3841
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 19:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233639AbjI2RBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 13:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjI2RBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 13:01:03 -0400
Received: from out-190.mta0.migadu.com (out-190.mta0.migadu.com [91.218.175.190])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B001BC
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 10:01:01 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1696006860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vyPpy7V4wE2Fq1thEJrKI/yAvrKJAgrKyO5PTWzt+c0=;
        b=Xdo4RtH8KjUa1J1VtAZiBKj4mG+gMXTwbn84kOhAg/0zDdgYY8vacCk7XCm8fqr3VtGmH3
        3ScYBlcAxQgNIIjSOtCgvV8cxL11kK6HGaRziMOdcpa9DwjFr1bRsjKRgzVo5wjy+jtE+/
        /jvBjjLJse3UA9CW7O2465ciDuSfD2I=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v5 2/2] mm: Init page count in reserve_bootmem_region when MEMINIT_EARLY
Date:   Sat, 30 Sep 2023 01:00:26 +0800
Message-Id: <20230929170026.2520216-3-yajun.deng@linux.dev>
In-Reply-To: <20230929170026.2520216-1-yajun.deng@linux.dev>
References: <20230929170026.2520216-1-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

memmap_init_range() would init page count of all pages, but the free
pages count would be reset in __free_pages_core(). There are opposite
operations. It's unnecessary and time-consuming when it's MEMINIT_EARLY
context.

Init page count in reserve_bootmem_region when in MEMINIT_EARLY context,
and check the page count before reset it.

At the same time, the INIT_LIST_HEAD in reserve_bootmem_region isn't
need, as it already done in __init_single_page.

The following data was tested on an x86 machine with 190GB of RAM.

before:
free_low_memory_core_early()    341ms

after:
free_low_memory_core_early()    285ms

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v5: add flags in memmap_init_range.
v4: same with v2.
v3: same with v2.
v2: check page count instead of check context before reset it.
v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
---
 mm/mm_init.c    | 20 +++++++++++++++-----
 mm/page_alloc.c | 20 ++++++++++++--------
 2 files changed, 27 insertions(+), 13 deletions(-)

diff --git a/mm/mm_init.c b/mm/mm_init.c
index 0549e7c3d588..f84f1ede57c6 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -718,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, 0);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
@@ -756,8 +756,11 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
 
 			init_reserved_page(start_pfn, nid);
 
-			/* Avoid false-positive PageTail() */
-			INIT_LIST_HEAD(&page->lru);
+			/*
+			 * We didn't init page count in memmap_init_range when
+			 * MEMINIT_EARLY, so it must init page count here.
+			 */
+			init_page_count(page);
 
 			/*
 			 * no need for atomic set_bit because the struct
@@ -850,6 +853,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		struct vmem_altmap *altmap, int migratetype)
 {
 	unsigned long pfn, end_pfn = start_pfn + size;
+	enum page_init_flags flags = 0;
 	struct page *page;
 
 	if (highest_memmap_pfn < end_pfn - 1)
@@ -888,9 +892,15 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		}
 
 		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
+
+		/* If the context is MEMINIT_EARLY, we will init page count and
+		 * mark page reserved in reserve_bootmem_region, the free region
+		 * wouldn't have page count and we will check the pages count
+		 * in __free_pages_core.
+		 */
 		if (context == MEMINIT_HOTPLUG)
-			__SetPageReserved(page);
+			flags = INIT_PAGE_COUNT | INIT_PAGE_RESERVED;
+		__init_single_page(page, pfn, zone, nid, flags);
 
 		/*
 		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7df77b58a961..bc68b5452d01 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1289,18 +1289,22 @@ void __free_pages_core(struct page *page, unsigned int order)
 	unsigned int loop;
 
 	/*
-	 * When initializing the memmap, __init_single_page() sets the refcount
-	 * of all pages to 1 ("allocated"/"not free"). We have to set the
-	 * refcount of all involved pages to 0.
+	 * When initializing the memmap, memmap_init_range sets the refcount
+	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
+	 * have to set the refcount of all involved pages to 0. Otherwise,
+	 * we don't do it, as reserve_bootmem_region only set the refcount on
+	 * reserve region ("reserved") in early context.
 	 */
-	prefetchw(p);
-	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
-		prefetchw(p + 1);
+	if (page_count(page)) {
+		prefetchw(p);
+		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
+			prefetchw(p + 1);
+			__ClearPageReserved(p);
+			set_page_count(p, 0);
+		}
 		__ClearPageReserved(p);
 		set_page_count(p, 0);
 	}
-	__ClearPageReserved(p);
-	set_page_count(p, 0);
 
 	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
 
-- 
2.25.1

