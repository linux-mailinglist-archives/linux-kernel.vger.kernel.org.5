Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE4179AEB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbjIKVDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:03:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243894AbjIKSLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 14:11:17 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC5BE6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:11:10 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-64f4ac604c2so25660376d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 11:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694455869; x=1695060669; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BZVUCQtETrJ9r0Nkfa1IVxgH2ja2C3QVluo3MwRYloc=;
        b=iGKTzgBRFieQ3PHfhBY0f6gU94cxlpDPlhdn15DrbE+I1LwZpEnZtsKG+XghcL0KP6
         NjqkX8MPCeScc9DHt5MZaIJMS2XnM8vHbmeb7j1BH0tAIPlfOmMc3SXeZexTXUV1NiUH
         JbPCZuymLABjBIuuuUTP1OmHoMXk3BvFfh6yuE/0kYat9LBG8MRj2FOU46PNkkKD0RZx
         SxTOCz/WErFo9ZQpNMxuqq+B+VHQBlJ6mljnnTvycgOWLAHAfuWFCsZa7CPpmi5waD8N
         fONK0LPu4yxXr004bkvsjGBP1BULAP8/mmsQyz8RJqK0Uaa9NI5WCvW6QHmda1rXI0YT
         rshA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694455869; x=1695060669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BZVUCQtETrJ9r0Nkfa1IVxgH2ja2C3QVluo3MwRYloc=;
        b=wjZB2KldSaxxf3/HHAlaYNZvYnPdpXVzDjnT86Q2aEBvZqChKIvzeLPMT+axiuGq1G
         xd5EN08Ugt84H2t3FaZJo+eFM44oAdUkt0bdio7gZH9KsCp+WobPZY7GI2BFRuIG2vGt
         CvkooOxs9J2GQ1jtpjdNA1v7rmcCrDUvVjsF0937YX7D+DKS4IIBEAAdOgg24BiPYx88
         iaujwuQjHssTBguLXptOeurB//I4BZ8/Fo7YOekVhAf+qPw1LPwuIfiptGAUYPQSLbpf
         /ShisowxGx6tDKRcg2iOiKnLLBHG506m8rez/iYG0dNe0G3ZBOQ63ruC+jbFnOWRVRHv
         hvLg==
X-Gm-Message-State: AOJu0Yyj+xCe7znkslHkVuSufyVgrUITWIEB26e8weo2Uykmvu2VzDv3
        s8WqbWnUa5qlqB9fI6xCWYsDQQ==
X-Google-Smtp-Source: AGHT+IFMpN65uhnlV0i2kTVp87cTtvt2OrtOJ5Z2OC+m7wSbr5rXwfLXh0yLBClSwJhc4Foxz6py0w==
X-Received: by 2002:a0c:8e83:0:b0:635:e4ed:b6c9 with SMTP id x3-20020a0c8e83000000b00635e4edb6c9mr7944759qvb.24.1694455869210;
        Mon, 11 Sep 2023 11:11:09 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id f21-20020a0caa95000000b0063f7a2847bcsm3138363qvb.51.2023.09.11.11.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 11:11:08 -0700 (PDT)
Date:   Mon, 11 Sep 2023 14:11:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, nsaenzju@redhat.com, yj.chiang@mediatek.com,
        Mark-pk Tsai <mark-pk.tsai@mediatek.com>,
        Joe Liu <joe.liu@mediatek.com>
Subject: Re: [PATCH] mm: page_alloc: fix cma pageblock was stolen in rmqueue
 fallback
Message-ID: <20230911181108.GA104295@cmpxchg.org>
References: <20230830111332.7599-1-lecopzer.chen@mediatek.com>
 <20230905090922.zy7srh33rg5c3zao@techsingularity.net>
 <20230911155727.GA102237@cmpxchg.org>
 <e8d5cb3d-2588-4e72-b42d-c10fd47fcbdf@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e8d5cb3d-2588-4e72-b42d-c10fd47fcbdf@suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 06:13:59PM +0200, Vlastimil Babka wrote:
> On 9/11/23 17:57, Johannes Weiner wrote:
> > On Tue, Sep 05, 2023 at 10:09:22AM +0100, Mel Gorman wrote:
> >> mm: page_alloc: Free pages to correct buddy list after PCP lock contention
> >> 
> >> Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> >> returns pages to the buddy list on PCP lock contention. However, for
> >> migratetypes that are not MIGRATE_PCPTYPES, the migratetype may have
> >> been clobbered already for pages that are not being isolated. In
> >> practice, this means that CMA pages may be returned to the wrong
> >> buddy list. While this might be harmless in some cases as it is
> >> MIGRATE_MOVABLE, the pageblock could be reassigned in rmqueue_fallback
> >> and prevent a future CMA allocation. Lookup the PCP migratetype
> >> against unconditionally if the PCP lock is contended.
> >> 
> >> [lecopzer.chen@mediatek.com: CMA-specific fix]
> >> Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
> >> Reported-by: Joe Liu <joe.liu@mediatek.com>
> >> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> >> ---
> >>  mm/page_alloc.c | 8 +++++++-
> >>  1 file changed, 7 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> >> index 452459836b71..4053c377fee8 100644
> >> --- a/mm/page_alloc.c
> >> +++ b/mm/page_alloc.c
> >> @@ -2428,7 +2428,13 @@ void free_unref_page(struct page *page, unsigned int order)
> >>  		free_unref_page_commit(zone, pcp, page, migratetype, order);
> >>  		pcp_spin_unlock(pcp);
> >>  	} else {
> >> -		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
> >> +		/*
> >> +		 * The page migratetype may have been clobbered for types
> >> +		 * (type >= MIGRATE_PCPTYPES && !is_migrate_isolate) so
> >> +		 * must be rechecked.
> >> +		 */
> >> +		free_one_page(zone, page, pfn, order,
> >> +			      get_pcppage_migratetype(page), FPI_NONE);
> >>  	}
> >>  	pcp_trylock_finish(UP_flags);
> >>  }
> >> 
> > 
> > I had sent a (similar) fix for this here:
> > 
> > https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/
> > 
> > The context wasn't CMA, but HIGHATOMIC pages going to the movable
> > freelist. But the class of bug is the same: the migratetype tweaking
> > really only applies to the pcplist, not the buddy slowpath; I added a
> > local pcpmigratetype to make it more clear, and hopefully prevent bugs
> > of this nature down the line.
> 
> Seems to be the cleanest solution to me, indeed.
> 
> > I'm just preparing v2 of the above series. Do you want me to break
> > this change out and send it separately?
> 
> Works for me, if you combine the it with the information about what commit
> that fixes, the CMA implications reported, and Cc stable.

How about this? Based on v6.6-rc1.

---

From 84e4490095ed3d1f2991e7f0e58e2968e56cc7c0 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Fri, 28 Jul 2023 14:29:41 -0400
Subject: [PATCH] mm: page_alloc: fix CMA and HIGHATOMIC landing on the wrong
 buddy list

Commit 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a
spinlock") bypasses the pcplist on lock contention and returns the
page directly to the buddy list of the page's migratetype.

For pages that don't have their own pcplist, such as CMA and
HIGHATOMIC, the migratetype is temporarily updated such that the page
can hitch a ride on the MOVABLE pcplist. Their true type is later
reassessed when flushing in free_pcppages_bulk(). However, when lock
contention is detected after the type was already overriden, the
bypass will then put the page on the wrong buddy list.

Once on the MOVABLE buddy list, the page becomes eligible for
fallbacks and even stealing. In the case of HIGHATOMIC, otherwise
ineligible allocations can dip into the highatomic reserves. In the
case of CMA, the page can be lost from the CMA region permanently.

Use a separate pcpmigratetype variable for the pcplist override. Use
the original migratetype when going directly to the buddy. This fixes
the bug and should make the intentions more obvious in the code.

Originally sent here to address the HIGHATOMIC case:
https://lore.kernel.org/lkml/20230821183733.106619-4-hannes@cmpxchg.org/

Changelog updated in response to the CMA-specific bug report.

[mgorman@techsingularity.net: updated changelog]
Reported-by: Joe Liu <joe.liu@mediatek.com>
Fixes: 4b23a68f9536 ("mm/page_alloc: protect PCP lists with a spinlock")
Cc: stable@vger.kernel.org
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c5be12f9336..95546f376302 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2400,7 +2400,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	struct per_cpu_pages *pcp;
 	struct zone *zone;
 	unsigned long pfn = page_to_pfn(page);
-	int migratetype;
+	int migratetype, pcpmigratetype;
 
 	if (!free_unref_page_prepare(page, pfn, order))
 		return;
@@ -2408,24 +2408,24 @@ void free_unref_page(struct page *page, unsigned int order)
 	/*
 	 * We only track unmovable, reclaimable and movable on pcp lists.
 	 * Place ISOLATE pages on the isolated list because they are being
-	 * offlined but treat HIGHATOMIC as movable pages so we can get those
-	 * areas back if necessary. Otherwise, we may have to free
+	 * offlined but treat HIGHATOMIC and CMA as movable pages so we can
+	 * get those areas back if necessary. Otherwise, we may have to free
 	 * excessively into the page allocator
 	 */
-	migratetype = get_pcppage_migratetype(page);
+	migratetype = pcpmigratetype = get_pcppage_migratetype(page);
 	if (unlikely(migratetype >= MIGRATE_PCPTYPES)) {
 		if (unlikely(is_migrate_isolate(migratetype))) {
 			free_one_page(page_zone(page), page, pfn, order, migratetype, FPI_NONE);
 			return;
 		}
-		migratetype = MIGRATE_MOVABLE;
+		pcpmigratetype = MIGRATE_MOVABLE;
 	}
 
 	zone = page_zone(page);
 	pcp_trylock_prepare(UP_flags);
 	pcp = pcp_spin_trylock(zone->per_cpu_pageset);
 	if (pcp) {
-		free_unref_page_commit(zone, pcp, page, migratetype, order);
+		free_unref_page_commit(zone, pcp, page, pcpmigratetype, order);
 		pcp_spin_unlock(pcp);
 	} else {
 		free_one_page(zone, page, pfn, order, migratetype, FPI_NONE);
-- 
2.42.0
