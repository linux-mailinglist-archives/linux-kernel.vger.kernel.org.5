Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31EC7AE3AD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 04:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233524AbjIZCeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 22:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjIZCeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 22:34:18 -0400
Received: from out-209.mta0.migadu.com (out-209.mta0.migadu.com [91.218.175.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B1C103
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 19:34:10 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695695649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mbaQjpBujw9FQ7lVsONZ8zG8x5WSfMi70JpOWR62DEA=;
        b=lSQW+083sAYjXW0rFYgELsoroKpHPC3apsKS0WEq7AlaS3MjgN96HZKIHnoMCC/hjtqp4Q
        aIRfnT0bcCCVA6kpYLGiiTenr6umkTKdly4pSF/bWaL5X+CXopmYgGAMfExwzIXSXeE7p0
        96DVrrj2fy4IEKt67/8SbYK+Bj7ngAU=
From:   Yajun Deng <yajun.deng@linux.dev>
To:     akpm@linux-foundation.org, rppt@kernel.org
Cc:     mike.kravetz@oracle.com, muchun.song@linux.dev,
        willy@infradead.org, david@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>
Subject: [PATCH v3 1/2] mm: pass page count and reserved to __init_single_page
Date:   Tue, 26 Sep 2023 10:33:40 +0800
Message-Id: <20230926023341.991124-2-yajun.deng@linux.dev>
In-Reply-To: <20230926023341.991124-1-yajun.deng@linux.dev>
References: <20230926023341.991124-1-yajun.deng@linux.dev>
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

When we init a single page, we need to mark this page reserved if it
does. And some pages may not need to set page count, such as compound
pages.

Introduce enum init_page_flags, the caller init page count and mark page
reserved by passing INIT_PAGE_COUNT and INIT_PAGE_RESERVED.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
---
v3: Introduce enum init_page_flags.
v2: Introduce INIT_PAGE_COUNT and INIT_PAGE_RESERVED.
v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
---
 mm/hugetlb.c  |  2 +-
 mm/internal.h |  8 +++++++-
 mm/mm_init.c  | 31 +++++++++++++++++--------------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index de220e3ff8be..cb282eadc729 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3196,7 +3196,7 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
 	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_single_page(page, pfn, zone, nid);
+		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
 		prep_compound_tail((struct page *)folio, pfn - head_pfn);
 		ret = page_ref_freeze(page, 1);
 		VM_BUG_ON(!ret);
diff --git a/mm/internal.h b/mm/internal.h
index d7916f1e9e98..449891ad7fdb 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -1209,8 +1209,14 @@ struct vma_prepare {
 	struct vm_area_struct *remove2;
 };
 
+enum init_page_flags {
+	INIT_PAGE_COUNT    = (1 << 0),
+	INIT_PAGE_RESERVED = (1 << 1),
+};
+
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid);
+				  unsigned long zone, int nid,
+				  enum init_page_flags flags);
 
 /* shrinker related functions */
 unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 06a72c223bce..07fe7e489769 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -557,11 +557,11 @@ static void __init find_zone_movable_pfns_for_nodes(void)
 }
 
 void __meminit __init_single_page(struct page *page, unsigned long pfn,
-				unsigned long zone, int nid)
+				  unsigned long zone, int nid,
+				  enum init_page_flags flags)
 {
 	mm_zero_struct_page(page);
 	set_page_links(page, zone, nid, pfn);
-	init_page_count(page);
 	page_mapcount_reset(page);
 	page_cpupid_reset_last(page);
 	page_kasan_tag_reset(page);
@@ -572,6 +572,10 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
 	if (!is_highmem_idx(zone))
 		set_page_address(page, __va(pfn << PAGE_SHIFT));
 #endif
+	if (flags & INIT_PAGE_COUNT)
+		init_page_count(page);
+	if (flags & INIT_PAGE_RESERVED)
+		__SetPageReserved(page);
 }
 
 #ifdef CONFIG_NUMA
@@ -714,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
 		if (zone_spans_pfn(zone, pfn))
 			break;
 	}
-	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
+	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);
 }
 #else
 static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
@@ -821,8 +825,8 @@ static void __init init_unavailable_range(unsigned long spfn,
 			pfn = pageblock_end_pfn(pfn) - 1;
 			continue;
 		}
-		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
-		__SetPageReserved(pfn_to_page(pfn));
+		__init_single_page(pfn_to_page(pfn), pfn, zone, node,
+				   INIT_PAGE_COUNT | INIT_PAGE_RESERVED);
 		pgcnt++;
 	}
 
@@ -884,7 +888,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
 		}
 
 		page = pfn_to_page(pfn);
-		__init_single_page(page, pfn, zone, nid);
+		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
 		if (context == MEMINIT_HOTPLUG)
 			__SetPageReserved(page);
 
@@ -965,11 +969,9 @@ static void __init memmap_init(void)
 #ifdef CONFIG_ZONE_DEVICE
 static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 					  unsigned long zone_idx, int nid,
-					  struct dev_pagemap *pgmap)
+					  struct dev_pagemap *pgmap,
+					  unsigned int flags)
 {
-
-	__init_single_page(page, pfn, zone_idx, nid);
-
 	/*
 	 * Mark page reserved as it will need to wait for onlining
 	 * phase for it to be fully associated with a zone.
@@ -977,7 +979,7 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
 	 * We can use the non-atomic __set_bit operation for setting
 	 * the flag as we are still initializing the pages.
 	 */
-	__SetPageReserved(page);
+	__init_single_page(page, pfn, zone_idx, nid, flags | INIT_PAGE_RESERVED);
 
 	/*
 	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
@@ -1041,7 +1043,7 @@ static void __ref memmap_init_compound(struct page *head,
 	for (pfn = head_pfn + 1; pfn < end_pfn; pfn++) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap, 0);
 		prep_compound_tail(head, pfn - head_pfn);
 		set_page_count(page, 0);
 
@@ -1084,7 +1086,8 @@ void __ref memmap_init_zone_device(struct zone *zone,
 	for (pfn = start_pfn; pfn < end_pfn; pfn += pfns_per_compound) {
 		struct page *page = pfn_to_page(pfn);
 
-		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap);
+		__init_zone_device_page(page, pfn, zone_idx, nid, pgmap,
+					INIT_PAGE_COUNT);
 
 		if (pfns_per_compound == 1)
 			continue;
@@ -2058,7 +2061,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
 		} else {
 			page++;
 		}
-		__init_single_page(page, pfn, zid, nid);
+		__init_single_page(page, pfn, zid, nid, INIT_PAGE_COUNT);
 		nr_pages++;
 	}
 	return (nr_pages);
-- 
2.25.1

