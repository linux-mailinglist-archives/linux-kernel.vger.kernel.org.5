Return-Path: <linux-kernel+bounces-109275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C37D881718
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:05:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87BAAB2146D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F576BFB6;
	Wed, 20 Mar 2024 18:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="uDXEeRLM"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1C6A8BE
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 18:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710957897; cv=none; b=qVM0JYJ47cxV4uJhdoyONAzVoI6QFCT+B8pWaNNX1DVKrxeRZzIegwukCa9wrtmPxJZAEn0W6oJl/o+VZazS1VonsQFiTQs3TVOVpxkNZ9+IDW+dFjvvZEFSAFTwQdLzrnOeUJ8AKLarQAUDIyZP2qIhirrUyZzwRR+vxMnSATM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710957897; c=relaxed/simple;
	bh=pO/JtvcLMxJfojbsVdsgt328gPM9mnvYXOpFxQOM8OI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM537znFf6h4I8EZlKfQDa9fprORP7FE3NFM6b9/rp/5yUgV6YUF6d4ArBVJPF75MMNHXiIIxWJubKi5Yb9dQdK6qHOPJbUbAv9zf7Kxukexap/EUxMSibExFGFf7pF2qdCVJPChZa1b0fzJ4qJBhb/hZVYFh6GGr4W47f6kjLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=uDXEeRLM; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42e323a2e39so1642141cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 11:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1710957892; x=1711562692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FfocRRC1YB9gbTpQRA0qsUF6TQAVW4ud00P9WTspsIs=;
        b=uDXEeRLMur94tHeO2IlDNP0E6OJpA8zscwsE6yJvNgVa89LiHwnbCjSIPyaH/D2s3x
         HVRhd+SE1ky6ScXqmNL2SrRfVUjtwdxM4oPG1mnlU/8IPXCXLpBnNxfi6qOOcHvFacKU
         HG0HDiwb04GefuvqeJ8KaZGRm0CKiutBwGPED76496NvmYC6l8J3X8plsZuq3q6GB2Do
         lQLzwi6LZfwPAHL1G40B5z3fpwO0et4AWGSrVQflrMVPs0q5aEPfTZySIOK0VNs3TFEK
         zyaiZTCIvm67VKfDUCwbhFd4AYYd2E4L+egijeKFfUFAOyqZ+pJ4NeVRM9ceMjCihYyX
         cFqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710957892; x=1711562692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FfocRRC1YB9gbTpQRA0qsUF6TQAVW4ud00P9WTspsIs=;
        b=d/AT9J9oTRbjMGmbRgj5zuIJciDFGa45FOKH48T8Z/iLHkrSvbmqTKcdUFD9f4v6Uh
         9I+BQ1FSHTmhT09g2W/onTIYyXf9njl5E4MZRZZqBU0x2/3s/YTdyDyWOc8pB52rb4SY
         LfaBYmqIRpSuI+EEXMmc7UhWE3z4lJVCQpodBdBtXAf81lZwcIs0IxldmJ65oRWeASk6
         2T1hVnlrawp3NtS2Dlq5qZrrRIqZqDmFilQdBcv3XCnmNNswlXhz/4+vehalO6KN0g+6
         1V45Olz+97DPjjN/YeYfyGFy+TgIXxEA6L3vN0MaESggok1x6YNXOsMgtchnvOQ9WCWn
         B/1w==
X-Forwarded-Encrypted: i=1; AJvYcCX7HHJmFa6le0BTcyIRRNonD1RgQ+5hoBLORS4MTIT7gVFKxrtiEIxd5gtIbP/Gy0QRjRK3ciAmZ5LtIiwZ50hzr0kg864OrxPW0u9k
X-Gm-Message-State: AOJu0Yy2wA1ML9vz+b/g9hlvt1WXtyERuq2nN/FGLktT+iNvMcLcS6dV
	4aalnEtUBk8UxQZijYY3ua5rKHtfgtrqvgvJAQpy55lR73iuFNLNxcpZrgjf7uc=
X-Google-Smtp-Source: AGHT+IHoamNYVBdLmp9p84PZmX7dks/ROfSNPw4orYipVjbhoiZ9qdiu/sQyu3TIfPVvxmMBsK0o2g==
X-Received: by 2002:a05:622a:188a:b0:431:155e:7ef0 with SMTP id v10-20020a05622a188a00b00431155e7ef0mr750683qtc.6.1710957892574;
        Wed, 20 Mar 2024 11:04:52 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id ex9-20020a05622a518900b00430bcec5432sm5506623qtb.85.2024.03.20.11.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 11:04:52 -0700 (PDT)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] mm: page_alloc: remove pcppage migratetype caching
Date: Wed, 20 Mar 2024 14:02:06 -0400
Message-ID: <20240320180429.678181-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320180429.678181-1-hannes@cmpxchg.org>
References: <20240320180429.678181-1-hannes@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The idea behind the cache is to save get_pageblock_migratetype()
lookups during bulk freeing. A microbenchmark suggests this isn't
helping, though. The pcp migratetype can get stale, which means that
bulk freeing has an extra branch to check if the pageblock was
isolated while on the pcp.

While the variance overlaps, the cache write and the branch seem to
make this a net negative. The following test allocates and frees
batches of 10,000 pages (~3x the pcp high marks to trigger flushing):

Before:
          8,668.48 msec task-clock                       #   99.735 CPUs utilized               ( +-  2.90% )
                19      context-switches                 #    4.341 /sec                        ( +-  3.24% )
                 0      cpu-migrations                   #    0.000 /sec
            17,440      page-faults                      #    3.984 K/sec                       ( +-  2.90% )
    41,758,692,473      cycles                           #    9.541 GHz                         ( +-  2.90% )
   126,201,294,231      instructions                     #    5.98  insn per cycle              ( +-  2.90% )
    25,348,098,335      branches                         #    5.791 G/sec                       ( +-  2.90% )
        33,436,921      branch-misses                    #    0.26% of all branches             ( +-  2.90% )

         0.0869148 +- 0.0000302 seconds time elapsed  ( +-  0.03% )

After:
          8,444.81 msec task-clock                       #   99.726 CPUs utilized               ( +-  2.90% )
                22      context-switches                 #    5.160 /sec                        ( +-  3.23% )
                 0      cpu-migrations                   #    0.000 /sec
            17,443      page-faults                      #    4.091 K/sec                       ( +-  2.90% )
    40,616,738,355      cycles                           #    9.527 GHz                         ( +-  2.90% )
   126,383,351,792      instructions                     #    6.16  insn per cycle              ( +-  2.90% )
    25,224,985,153      branches                         #    5.917 G/sec                       ( +-  2.90% )
        32,236,793      branch-misses                    #    0.25% of all branches             ( +-  2.90% )

         0.0846799 +- 0.0000412 seconds time elapsed  ( +-  0.05% )

A side effect is that this also ensures that pages whose pageblock
gets stolen while on the pcplist end up on the right freelist and we
don't perform potentially type-incompatible buddy merges (or skip
merges when we shouldn't), which is likely beneficial to long-term
fragmentation management, although the effects would be harder to
measure. Settle for simpler and faster code as justification here.

v2:
- remove erroneous leftover VM_BUG_ON in pcp bulk freeing (Mike)

Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Tested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 66 +++++++++++--------------------------------------
 1 file changed, 14 insertions(+), 52 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 4491d0240bc6..60a632b7c9f6 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -206,24 +206,6 @@ EXPORT_SYMBOL(node_states);
 
 gfp_t gfp_allowed_mask __read_mostly = GFP_BOOT_MASK;
 
-/*
- * A cached value of the page's pageblock's migratetype, used when the page is
- * put on a pcplist. Used to avoid the pageblock migratetype lookup when
- * freeing from pcplists in most cases, at the cost of possibly becoming stale.
- * Also the migratetype set in the page does not necessarily match the pcplist
- * index, e.g. page might have MIGRATE_CMA set but be on a pcplist with any
- * other index - this ensures that it will be put on the correct CMA freelist.
- */
-static inline int get_pcppage_migratetype(struct page *page)
-{
-	return page->index;
-}
-
-static inline void set_pcppage_migratetype(struct page *page, int migratetype)
-{
-	page->index = migratetype;
-}
-
 #ifdef CONFIG_HUGETLB_PAGE_SIZE_VARIABLE
 unsigned int pageblock_order __read_mostly;
 #endif
@@ -1191,7 +1173,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 {
 	unsigned long flags;
 	unsigned int order;
-	bool isolated_pageblocks;
 	struct page *page;
 
 	/*
@@ -1204,7 +1185,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	pindex = pindex - 1;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	isolated_pageblocks = has_isolate_pageblock(zone);
 
 	while (count > 0) {
 		struct list_head *list;
@@ -1220,23 +1200,19 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		order = pindex_to_order(pindex);
 		nr_pages = 1 << order;
 		do {
+			unsigned long pfn;
 			int mt;
 
 			page = list_last_entry(list, struct page, pcp_list);
-			mt = get_pcppage_migratetype(page);
+			pfn = page_to_pfn(page);
+			mt = get_pfnblock_migratetype(page, pfn);
 
 			/* must delete to avoid corrupting pcp list */
 			list_del(&page->pcp_list);
 			count -= nr_pages;
 			pcp->count -= nr_pages;
 
-			/* MIGRATE_ISOLATE page should not go to pcplists */
-			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
-			/* Pageblock could have been isolated meanwhile */
-			if (unlikely(isolated_pageblocks))
-				mt = get_pageblock_migratetype(page);
-
-			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
+			__free_one_page(page, pfn, zone, order, mt, FPI_NONE);
 			trace_mm_page_pcpu_drain(page, order, mt);
 		} while (count > 0 && !list_empty(list));
 	}
@@ -1575,7 +1551,6 @@ struct page *__rmqueue_smallest(struct zone *zone, unsigned int order,
 			continue;
 		del_page_from_free_list(page, zone, current_order);
 		expand(zone, page, order, current_order, migratetype);
-		set_pcppage_migratetype(page, migratetype);
 		trace_mm_page_alloc_zone_locked(page, order, migratetype,
 				pcp_allowed_order(order) &&
 				migratetype < MIGRATE_PCPTYPES);
@@ -2182,7 +2157,7 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 		 * pages are ordered properly.
 		 */
 		list_add_tail(&page->pcp_list, list);
-		if (is_migrate_cma(get_pcppage_migratetype(page)))
+		if (is_migrate_cma(get_pageblock_migratetype(page)))
 			__mod_zone_page_state(zone, NR_FREE_CMA_PAGES,
 					      -(1 << order));
 	}
@@ -2378,19 +2353,6 @@ void drain_all_pages(struct zone *zone)
 	__drain_all_pages(zone, false);
 }
 
-static bool free_unref_page_prepare(struct page *page, unsigned long pfn,
-							unsigned int order)
-{
-	int migratetype;
-
-	if (!free_pages_prepare(page, order))
-		return false;
-
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	set_pcppage_migratetype(page, migratetype);
-	return true;
-}
-
 static int nr_pcp_free(struct per_cpu_pages *pcp, int batch, int high, bool free_high)
 {
 	int min_nr_free, max_nr_free;
@@ -2523,7 +2485,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype, pcpmigratetype;
 
-	if (!free_unref_page_prepare(page, pfn, order))
+	if (!free_pages_prepare(page, order))
 		return;
 
 	/*
@@ -2533,7 +2495,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
@@ -2572,14 +2534,14 @@ void free_unref_folios(struct folio_batch *folios)
 
 		if (order > 0 && folio_test_large_rmappable(folio))
 			folio_undo_large_rmappable(folio);
-		if (!free_unref_page_prepare(&folio->page, pfn, order))
+		if (!free_pages_prepare(&folio->page, order))
 			continue;
 
 		/*
 		 * Free isolated folios and orders not handled on the PCP
 		 * directly to the allocator, see comment in free_unref_page.
 		 */
-		migratetype = get_pcppage_migratetype(&folio->page);
+		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
 		if (!pcp_allowed_order(order) ||
 		    is_migrate_isolate(migratetype)) {
 			free_one_page(folio_zone(folio), &folio->page, pfn,
@@ -2596,10 +2558,11 @@ void free_unref_folios(struct folio_batch *folios)
 	for (i = 0; i < folios->nr; i++) {
 		struct folio *folio = folios->folios[i];
 		struct zone *zone = folio_zone(folio);
+		unsigned long pfn = folio_pfn(folio);
 		unsigned int order = (unsigned long)folio->private;
 
 		folio->private = NULL;
-		migratetype = get_pcppage_migratetype(&folio->page);
+		migratetype = get_pfnblock_migratetype(&folio->page, pfn);
 
 		/* Different zone requires a different pcp lock */
 		if (zone != locked_zone) {
@@ -2616,9 +2579,8 @@ void free_unref_folios(struct folio_batch *folios)
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, &folio->page,
-						folio_pfn(folio), order,
-						migratetype, FPI_NONE);
+				free_one_page(zone, &folio->page, pfn,
+					      order, migratetype, FPI_NONE);
 				locked_zone = NULL;
 				continue;
 			}
@@ -2787,7 +2749,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			}
 		}
 		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
+					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-- 
2.44.0


