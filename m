Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC58C7AA9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjIVHKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 03:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjIVHKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 03:10:18 -0400
Received: from out-213.mta0.migadu.com (out-213.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23006197
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 00:10:11 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695366609;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eNDRWQx4rNnkd5izfMYcW2fBhjnfX3xJn3/1FZ3VThE=;
        b=iSP4WnijIwKLq3l9vadWpYjfJoJm3g4DerOWhwM35ttFjdkUM6l19oJCA3gNFvh1Mphrj3
        HsqfWa/w9fO+8D4ekxGE+wh4qCZ9R7alts+HM2SsnLz/nxZodV+mCe9vbVcqanUTTx5BMC
        y/tcpUU+PnQQYCSvaVyj01COgaRrssQ=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, glider@google.com, elver@google.com,
        dvyukov@google.com, rppt@kernel.org, david@redhat.com,
        osalvador@suse.de
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH 2/4] mm: Introduce MEMINIT_LATE context
Date:   Fri, 22 Sep 2023 15:09:21 +0800
Message-Id: <20230922070923.355656-3-yajun.deng@linux.dev>
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

__free_pages_core() will always reset pages count and clear reserved flag.
It will consume a lot of time if there are a lot of pages.

Introduce MEMINIT_LATE context, if the context is MEMINIT_EARLY, we
don't need reset pages count and clear reserved flag.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
 include/linux/mmzone.h |  1 +
 mm/internal.h          |  7 ++++---
 mm/kmsan/init.c        |  2 +-
 mm/memblock.c          |  4 ++--
 mm/memory_hotplug.c    |  2 +-
 mm/mm_init.c           | 11 ++++++-----
 mm/page_alloc.c        | 14 ++++++++------
 7 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 1e9cf3aa1097..253e792d409f 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1442,6 +1442,7 @@ bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
  */
 enum meminit_context {
 	MEMINIT_EARLY,
+	MEMINIT_LATE,
 	MEMINIT_HOTPLUG,
 };
 
diff --git a/mm/internal.h b/mm/internal.h
index 8bded7f98493..31737196257c 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -394,9 +394,10 @@ static inline void clear_zone_contiguous(struct zone *zone)
 extern int __isolate_free_page(struct page *page, unsigned int order);
 extern void __putback_isolated_page(struct page *page, unsigned int order,
 				    int mt);
-extern void memblock_free_pages(struct page *page, unsigned long pfn,
-					unsigned int order);
-extern void __free_pages_core(struct page *page, unsigned int order);
+extern void memblock_free_pages(unsigned long pfn, unsigned int order,
+				enum meminit_context context);
+extern void __free_pages_core(struct page *page, unsigned int order,
+			      enum meminit_context context);
 
 /*
  * This will have no effect, other than possibly generating a warning, if the
diff --git a/mm/kmsan/init.c b/mm/kmsan/init.c
index ffedf4dbc49d..b7ed98b854a6 100644
--- a/mm/kmsan/init.c
+++ b/mm/kmsan/init.c
@@ -172,7 +172,7 @@ static void do_collection(void)
 		shadow = smallstack_pop(&collect);
 		origin = smallstack_pop(&collect);
 		kmsan_setup_meta(page, shadow, origin, collect.order);
-		__free_pages_core(page, collect.order);
+		__free_pages_core(page, collect.order, MEMINIT_LATE);
 	}
 }
 
diff --git a/mm/memblock.c b/mm/memblock.c
index 5a88d6d24d79..a32364366bb2 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1685,7 +1685,7 @@ void __init memblock_free_late(phys_addr_t base, phys_addr_t size)
 	end = PFN_DOWN(base + size);
 
 	for (; cursor < end; cursor++) {
-		memblock_free_pages(pfn_to_page(cursor), cursor, 0);
+		memblock_free_pages(cursor, 0, MEMINIT_LATE);
 		totalram_pages_inc();
 	}
 }
@@ -2089,7 +2089,7 @@ static void __init __free_pages_memory(unsigned long start, unsigned long end)
 		while (start + (1UL << order) > end)
 			order--;
 
-		memblock_free_pages(pfn_to_page(start), start, order);
+		memblock_free_pages(start, order, MEMINIT_LATE);
 
 		start += (1UL << order);
 	}
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 3b301c4023ff..d38548265f26 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -634,7 +634,7 @@ void generic_online_page(struct page *page, unsigned int order)
 	 * case in page freeing fast path.
 	 */
 	debug_pagealloc_map_pages(page, 1 << order);
-	__free_pages_core(page, order);
+	__free_pages_core(page, order, MEMINIT_HOTPLUG);
 	totalram_pages_add(1UL << order);
 }
 EXPORT_SYMBOL_GPL(generic_online_page);
diff --git a/mm/mm_init.c b/mm/mm_init.c
index c40042098a82..0a4437aae30d 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1976,7 +1976,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	if (nr_pages == MAX_ORDER_NR_PAGES && IS_MAX_ORDER_ALIGNED(pfn)) {
 		for (i = 0; i < nr_pages; i += pageblock_nr_pages)
 			set_pageblock_migratetype(page + i, MIGRATE_MOVABLE);
-		__free_pages_core(page, MAX_ORDER);
+		__free_pages_core(page, MAX_ORDER, MEMINIT_LATE);
 		return;
 	}
 
@@ -1986,7 +1986,7 @@ static void __init deferred_free_range(unsigned long pfn,
 	for (i = 0; i < nr_pages; i++, page++, pfn++) {
 		if (pageblock_aligned(pfn))
 			set_pageblock_migratetype(page, MIGRATE_MOVABLE);
-		__free_pages_core(page, 0);
+		__free_pages_core(page, 0, MEMINIT_LATE);
 	}
 }
 
@@ -2568,9 +2568,10 @@ void __init set_dma_reserve(unsigned long new_dma_reserve)
 	dma_reserve = new_dma_reserve;
 }
 
-void __init memblock_free_pages(struct page *page, unsigned long pfn,
-							unsigned int order)
+void __init memblock_free_pages(unsigned long pfn, unsigned int order,
+				enum meminit_context context)
 {
+	struct page *page = pfn_to_page(pfn);
 
 	if (IS_ENABLED(CONFIG_DEFERRED_STRUCT_PAGE_INIT)) {
 		int nid = early_pfn_to_nid(pfn);
@@ -2583,7 +2584,7 @@ void __init memblock_free_pages(struct page *page, unsigned long pfn,
 		/* KMSAN will take care of these pages. */
 		return;
 	}
-	__free_pages_core(page, order);
+	__free_pages_core(page, order, context);
 }
 
 DEFINE_STATIC_KEY_MAYBE(CONFIG_INIT_ON_ALLOC_DEFAULT_ON, init_on_alloc);
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 06be8821d833..6c4f4531bee0 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1278,7 +1278,7 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	__count_vm_events(PGFREE, 1 << order);
 }
 
-void __free_pages_core(struct page *page, unsigned int order)
+void __free_pages_core(struct page *page, unsigned int order, enum meminit_context context)
 {
 	unsigned int nr_pages = 1 << order;
 	struct page *p = page;
@@ -1289,14 +1289,16 @@ void __free_pages_core(struct page *page, unsigned int order)
 	 * of all pages to 1 ("allocated"/"not free"). We have to set the
 	 * refcount of all involved pages to 0.
 	 */
-	prefetchw(p);
-	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
-		prefetchw(p + 1);
+	if (context != MEMINIT_EARLY) {
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

