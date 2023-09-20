Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0F427A83CF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjITNsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjITNsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:48:20 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9F5AC
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:48:13 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76ef80a503fso448086185a.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695217692; x=1695822492; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JzUq2Sj2mPHZh8yxCdJNM1Yfvc/PSx8ZmJQe+i0RUXs=;
        b=gALJqcBsQE1W30hJcH6srA+1N6KaQH0YLaD0YkPcmdGwtcUtVccFofL5d6uevU1cDV
         Tm+d2U0Gmhju1zmmaD6G224LIkt43BEBUCnKl+gLv+B8f28CJ8nC+Cndgone8mOl/O21
         rmwNE1+MHIuN7Rknu+Z9zNO4z6WDu/jb+6l6NYDA0mtwHKQVFVv7Ln0BTY4w8/LWX2PV
         kjs8TQ1LD3ExhSQwyNVaEFCST9RIe7rGYM+mjLqrZEqjWCmmxHAX7XX87EUC5mYUymwT
         HLyrfLPMKvurMsDezUyg2wk0MZ7Wyd/JsEpmGP0fcDfJu0FYyoqYgVzngbFpRJrJP9zy
         lUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695217692; x=1695822492;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JzUq2Sj2mPHZh8yxCdJNM1Yfvc/PSx8ZmJQe+i0RUXs=;
        b=p3mpyuY+I3cQf0MVvbZhrsKW6RbDBeZV1sf0EG7b1ItIfgROCdIafmXp0iGUsHNfFC
         KWMql0dKMpfC9ZqGdOkuLLfVYf1xsIkCnwOmHyZ/KWEfvf905rHyJ3UmkR+2B33fqLeC
         KECbgcdZP8s0gvyg0L1VqBrFOSFv/+365cTuSTxWRta1rfBcDaznxYgKMYmIT1msM0zO
         t2rMjyWQ6i8Bexqgu3HMGE/1o8dsbaFCH1emPzQ5Gjd6CsGFWeG56JmyH9S6y5y/r2Ax
         MAE6aKcDPE8DTuCXK+j2p9k2GT41mvU+ALZ7AZhkxQV0qkbxYaC+r1ITy4astg1UmSul
         rmNQ==
X-Gm-Message-State: AOJu0Yy1alFeByRA+mMzXqOM+x775xKz/EcLbMuuuUwIsFN4VPdbcg29
        viGb1Bpoz8ecBgWwed8ebKnIIw==
X-Google-Smtp-Source: AGHT+IGHRaFY7ecGtVqpabGSdlc7vKjScTdkY/6QFb0NUOsZQ60DU2v5LwrLd3sbWoOSPF0aAvz9Uw==
X-Received: by 2002:a0c:a9d2:0:b0:655:da3b:8c76 with SMTP id c18-20020a0ca9d2000000b00655da3b8c76mr2687047qvb.3.1695217692277;
        Wed, 20 Sep 2023 06:48:12 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d7e0])
        by smtp.gmail.com with ESMTPSA id q11-20020a0ce20b000000b00658793cda3esm868025qvl.72.2023.09.20.06.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:48:11 -0700 (PDT)
Date:   Wed, 20 Sep 2023 09:48:11 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Zi Yan <ziy@nvidia.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230920134811.GB124289@cmpxchg.org>
References: <20230916195739.GB618858@monkey>
 <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org>
 <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org>
 <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
> On 9/20/23 03:38, Zi Yan wrote:
> > On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
> > 
> >> On 09/19/23 16:57, Zi Yan wrote:
> >>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
> >>>
> >>>> 	--- a/mm/page_alloc.c
> >>>> 	+++ b/mm/page_alloc.c
> >>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> >>>>  		end = pageblock_end_pfn(pfn) - 1;
> >>>>
> >>>>  		/* Do not cross zone boundaries */
> >>>> 	+#if 0
> >>>>  		if (!zone_spans_pfn(zone, start))
> >>>> 			start = zone->zone_start_pfn;
> >>>> 	+#else
> >>>> 	+	if (!zone_spans_pfn(zone, start))
> >>>> 	+		start = pfn;
> >>>> 	+#endif
> >>>> 	 	if (!zone_spans_pfn(zone, end))
> >>>> 	 		return false;
> >>>> 	I can still trigger warnings.
> >>>
> >>> OK. One thing to note is that the page type in the warning changed from
> >>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
> >>>
> >>
> >> Just to be really clear,
> >> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
> >> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
> >>   path WITHOUT your change.
> >>
> >> I am guessing the difference here has more to do with the allocation path?
> >>
> >> I went back and reran focusing on the specific migrate type.
> >> Without your patch, and coming from the alloc_contig_range call path,
> >> I got two warnings of 'page type is 0, passed migratetype is 1' as above.
> >> With your patch I got one 'page type is 0, passed migratetype is 1'
> >> warning and one 'page type is 1, passed migratetype is 0' warning.
> >>
> >> I could be wrong, but I do not think your patch changes things.
> > 
> > Got it. Thanks for the clarification.
> >>
> >>>>
> >>>> One idea about recreating the issue is that it may have to do with size
> >>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tried
> >>>> to really stress the allocations by increasing the number of hugetlb
> >>>> pages requested and that did not help.  I also noticed that I only seem
> >>>> to get two warnings and then they stop, even if I continue to run the
> >>>> script.
> >>>>
> >>>> Zi asked about my config, so it is attached.
> >>>
> >>> With your config, I still have no luck reproducing the issue. I will keep
> >>> trying. Thanks.
> >>>
> >>
> >> Perhaps try running both scripts in parallel?
> > 
> > Yes. It seems to do the trick.
> > 
> >> Adjust the number of hugetlb pages allocated to equal 25% of memory?
> > 
> > I am able to reproduce it with the script below:
> > 
> > while true; do
> >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
> >  echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
> >  wait
> >  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >  echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > done
> > 
> > I will look into the issue.

Nice!

I managed to reproduce it ONCE, triggering it not even a second after
starting the script. But I can't seem to do it twice, even after
several reboots and letting it run for minutes.

> With migratetypes 0 and 1 and somewhat harder to reproduce scenario (= less
> deterministic, more racy) it's possible we now see what I suspected can
> happen here:
> https://lore.kernel.org/all/37dbd4d0-c125-6694-dec4-6322ae5b6dee@suse.cz/
> In that there are places reading the migratetype outside of zone lock.

Good point!

I had already written up a fix for this issue. Still trying to get the
reproducer to work, but attaching the fix below in case somebody with
a working environment beats me to it.

---

From 94f67bfa29a602a66014d079431b224cacbf79e9 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 15 Sep 2023 16:23:38 -0400
Subject: [PATCH] mm: page_alloc: close migratetype race between freeing and
 stealing

There are three freeing paths that read the page's migratetype
optimistically before grabbing the zone lock. When this races with
block stealing, those pages go on the wrong freelist.

The paths in question are:
- when freeing >costly orders that aren't THP
- when freeing pages to the buddy upon pcp lock contention
- when freeing pages that are isolated
- when freeing pages initially during boot
- when freeing the remainder in alloc_pages_exact()
- when "accepting" unaccepted VM host memory before first use
- when freeing pages during unpoisoning

None of these are so hot that they would need this optimization at the
cost of hampering defrag efforts. Especially when contrasted with the
fact that the most common buddy freeing path - free_pcppages_bulk - is
checking the migratetype under the zone->lock just fine.

In addition, isolated pages need to look up the migratetype under the
lock anyway, which adds branches to the locked section, and results in
a double lookup when the pages are in fact isolated.

Move the lookups into the lock.

Reported-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 47 +++++++++++++++++------------------------------
 1 file changed, 17 insertions(+), 30 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0ca999d24a00..d902a8aaa3fd 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1222,18 +1222,15 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
 
-static void free_one_page(struct zone *zone,
-				struct page *page, unsigned long pfn,
-				unsigned int order,
-				int migratetype, fpi_t fpi_flags)
+static void free_one_page(struct zone *zone, struct page *page,
+			  unsigned long pfn, unsigned int order,
+			  fpi_t fpi_flags)
 {
 	unsigned long flags;
+	int migratetype;
 
 	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 }
@@ -1249,18 +1246,8 @@ static void __free_pages_ok(struct page *page, unsigned int order,
 	if (!free_pages_prepare(page, order, fpi_flags))
 		return;
 
-	/*
-	 * Calling get_pfnblock_migratetype() without spin_lock_irqsave() here
-	 * is used to avoid calling get_pfnblock_migratetype() under the lock.
-	 * This will reduce the lock holding time.
-	 */
-	migratetype = get_pfnblock_migratetype(page, pfn);
-
 	spin_lock_irqsave(&zone->lock, flags);
-	if (unlikely(has_isolate_pageblock(zone) ||
-		is_migrate_isolate(migratetype))) {
-		migratetype = get_pfnblock_migratetype(page, pfn);
-	}
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	__free_one_page(page, pfn, zone, order, migratetype, fpi_flags);
 	spin_unlock_irqrestore(&zone->lock, flags);
 
@@ -2404,7 +2391,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype, pcpmigratetype;
+	int migratetype;
 
 	if (!free_pages_prepare(page, order, FPI_NONE))
 		return;
@@ -2416,23 +2403,23 @@ void free_unref_page(struct page *page, unsigned int order)
 	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = pcpmigratetype = get_pfnblock_migratetype(page, pfn);
+	migratetype = get_pfnblock_migratetype(page, pfn);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
-			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, order, FPI_NONE);
 			return;
 		}
-		pcpmigratetype = MIGRATE_MOVABLE;
+		migratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
+		free_unref_page_commit(zone, pcp, page, migratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
-		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
+		free_one_page(zone, page, pfn, order, FPI_NONE);
 	}
 	pcp_trylock_finish(UP_flags);
 }
@@ -2465,7 +2452,7 @@ void free_unref_page_list(struct list_head *list)
 		migratetype = get_pfnblock_migratetype(page, pfn);
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			list_del(&page->lru);
-			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
+			free_one_page(page_zone(page), page, pfn, 0, FPI_NONE);
 			continue;
 		}
 	}
@@ -2498,8 +2485,7 @@ void free_unref_page_list(struct list_head *list)
 			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 			if (unlikely(!pcp)) {
 				pcp_trylock_finish(UP_flags);
-				free_one_page(zone, page, pfn,
-					      0, migratetype, FPI_NONE);
+				free_one_page(zone, page, pfn, 0, FPI_NONE);
 				locked_zone = NULL;
 				continue;
 			}
@@ -6537,13 +6523,14 @@ bool take_page_off_buddy(struct page *page)
 bool put_page_back_buddy(struct page *page)
 {
 	struct zone *zone = page_zone(page);
-	unsigned long pfn = page_to_pfn(page);
 	unsigned long flags;
-	int migratetype = get_pfnblock_migratetype(page, pfn);
 	bool ret = false;
 
 	spin_lock_irqsave(&zone->lock, flags);
 	if (put_page_testzero(page)) {
+		unsigned long pfn = page_to_pfn(page);
+		int migratetype = get_pfnblock_migratetype(page, pfn);
+
 		ClearPageHWPoisonTakenOff(page);
 		__free_one_page(page, pfn, zone, 0, migratetype, FPI_NONE);
 		if (TestClearPageHWPoison(page)) {
-- 
2.42.0

