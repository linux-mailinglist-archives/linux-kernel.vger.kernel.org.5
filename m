Return-Path: <linux-kernel+bounces-93313-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3042872DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 05:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC2D1C219B8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 04:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88E0F19BA2;
	Wed,  6 Mar 2024 04:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="blMx3XfN"
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D631759F
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 04:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709698584; cv=none; b=Jt7colZ4B6Eb+Hf4FKFsz4XQFiCjHSj3CwgTAWCh1l8FQlD4zjf52XnqlG2P0nHdQMIKeexxVwVn0Ml1kFA4ATOUzTg8D0Zs293TLMqarIgvZAco0lCp4F9vRzrku3Ftk45fCzFqPk0jrCaByRGNFJfWuhlrxYQDdIvADObNJs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709698584; c=relaxed/simple;
	bh=nPrPHsb9vkT3uB+yuZUXj1/eTKlADvppvxKsHbC5ao8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHFr/IfGbWevhp40e6K6+gRc1kgw/cQ47aQbexrkRVIJGc/aWzdMFekYUW4r8jEQNH96DcoUnGqnQ9UUKVALrhR9hJACPMXmWBxcFBekDLMxgnpB4s+BOzf5hnHd4yKHv/muNilPmJuVacD3iMl/AjoAqez2/YMUO4jXNRMVVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=blMx3XfN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7882e8f99eeso132015985a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 20:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1709698580; x=1710303380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TANN7sLLWedgpgoKB84Ck0djJTV8XiwLLoov3tglmKE=;
        b=blMx3XfNKJTEUJtcSYcyk23HnyfR/Otn92KTuRSwQPaTt/q9t3FRMfLnWoQsTakCZV
         njuTRXbb4DYaIiuo9cG08hbY0qJh5y3k8V7AopL1b1CdcC0LNVfPX665kPGZMIqT6nmV
         0Wxuo8D+iTkdjCUVfNmnlnXFiG9RceNs6M5W+LJE0wtkw8oLc9/qM/RUHcPz0htysRca
         EDiLCMqbCNErpn3g38hZ5LhrtA6c7myH4J2TUcFuqPp3M5I0EgBoasSgPVKm/qz2OHZp
         hlYHU9gaPJfXaYjm7fQv0oQL5vBZdmaFDXsL2FO9A1818g/E2ELRMGU5CinL3fVxvJKu
         heEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709698580; x=1710303380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TANN7sLLWedgpgoKB84Ck0djJTV8XiwLLoov3tglmKE=;
        b=JaTAuUkocgJk4sjTztbUqoNQAJ5o/C0EoToqH1s+g2VZOByA7pxVDJDoh6X6nQIGC3
         AdVUcZ9Do0E7AommvUBqAwfatlshp1vNbTQyamGzd944kILBk7XCvF4z/3o6QsvPBOyG
         koOlMAe+xkLxIGjsSYEW30k8Asj4vPaziX0WhsRYj3V+SOS7Bh4n8G2ehGIpbk5Pxeav
         kD2GJn+x2Pe5ddDRMhfR6ABjqIQTL2E6nUbEeBWzCu1lgK54UVsi6JuMmikDRCI4OrW9
         AJIWWaoo9ac02QFEBXQBV6v741zRPdXSYsckGSHNd6ckqS6L1JbdhP3sFJboUnMWmOmB
         VBJA==
X-Forwarded-Encrypted: i=1; AJvYcCU0GEAHJG/u6FDZjQOejQFsB7joLXnDXwbeX2vhASf7e9LDhL72oLcnJ1CNvqCfNAdjffYtHdX3A6YUGQjniunmTUrd2qXa5v6CIdRf
X-Gm-Message-State: AOJu0YxelYWD3XWloKf8yBuDqhKlUZ2oS/Jb29iyamaIe0WFvCqG1tn5
	8DXQxn7FM6E1yRzm8igOV34TgiI4duvI1gxPgSxDtkO94D8qSb6829JueDEsZyE=
X-Google-Smtp-Source: AGHT+IHwq/V0fU9mVZstG8iv3aIs4lRIY1sCdiOu2ll0CLJKWGqdfEQ3Aa7QbBpFir2jp2PM7CxgKg==
X-Received: by 2002:a05:620a:22b4:b0:787:effe:472 with SMTP id p20-20020a05620a22b400b00787effe0472mr3409431qkh.64.1709698579913;
        Tue, 05 Mar 2024 20:16:19 -0800 (PST)
Received: from localhost (2603-7000-0c01-2716-da5e-d3ff-fee7-26e7.res6.spectrum.com. [2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with ESMTPSA id az17-20020a05620a171100b007882b4cecf8sm2440014qkb.57.2024.03.05.20.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 20:16:19 -0800 (PST)
From: Johannes Weiner <hannes@cmpxchg.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Mel Gorman <mgorman@techsingularity.net>,
	Zi Yan <ziy@nvidia.com>,
	Mike Kravetz <mike.kravetz@oracle.com>,
	"Huang, Ying" <ying.huang@intel.com>,
	David Hildenbrand <david@redhat.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] mm: page_alloc: remove pcppage migratetype caching
Date: Tue,  5 Mar 2024 23:08:32 -0500
Message-ID: <20240306041526.892167-2-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240306041526.892167-1-hannes@cmpxchg.org>
References: <20240306041526.892167-1-hannes@cmpxchg.org>
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
index 16241906a368..9665a2db3b53 100644
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
@@ -2375,19 +2350,6 @@ void drain_all_pages(struct zone *zone)
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
@@ -2520,7 +2482,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	unsigned long pfn = page_to_pfn(page);
 	int migratetype, pcpmigratetype;
 
-	if (!free_unref_page_prepare(page, pfn, order))
+	if (!free_pages_prepare(page, order))
 		return;
 
 	/*
@@ -2530,7 +2492,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
@@ -2569,14 +2531,14 @@ void free_unref_folios(struct folio_batch *folios)
 
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
@@ -2593,10 +2555,11 @@ void free_unref_folios(struct folio_batch *folios)
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
@@ -2613,9 +2576,8 @@ void free_unref_folios(struct folio_batch *folios)
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
@@ -2784,7 +2746,7 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 			}
 		}
 		__mod_zone_freepage_state(zone, -(1 << order),
-					  get_pcppage_migratetype(page));
+					  get_pageblock_migratetype(page));
 		spin_unlock_irqrestore(&zone->lock, flags);
 	} while (check_new_pages(page, order));
 
-- 
2.44.0


