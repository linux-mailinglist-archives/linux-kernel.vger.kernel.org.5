Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8170D7E46F2
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbjKGR2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:28:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343723AbjKGR2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:28:24 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407B09C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:28:22 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-45e777af839so1181685137.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 09:28:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1699378101; x=1699982901; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9JWYsxX7o9LoPZR+AYodFHECF/k1HsJ4BkaZR+67S10=;
        b=kJbF+x6fW8gQxO4AvxFwdpLy3ZlHnkruXMl4cnBbFMUVrfGNmi8X/JpScNF8SCXFxd
         x+gYgsp0Q0aIpUBYtFhEo09QvdwiLsLCCAdmt+BGxnKcS1uJmjw6FA85U7c0xOGC6/Yz
         XNdstREsDfnIheOeVMHx5UA565l991L9LWhAo1IDJKdi7Kd0jrKuQOCW30ZD+VsL516q
         /a2HbgVz8KFaHIzZ5+5aLAOAL+diJDUKU699QPkK/kOkLr9NiSC0fY9gKae8KzZsDpoc
         nbD5q/AxmFVOe9pKd+xO3Znc46DgL3OyDfFgvZx68mh1DoUYAKP1jP6AY6ZxkBSnNCTv
         9OvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699378101; x=1699982901;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9JWYsxX7o9LoPZR+AYodFHECF/k1HsJ4BkaZR+67S10=;
        b=vvEs9//n/LG2BxuyLPKFTyBanPsrrr9ujGaZvG3Rl1463UOpSTKo8Sdnizct1vt6eQ
         SSyf8sJMZ8f2xMg3StmVUuiJd3cA5WfP7N15aOT4DTFU7H/OjvdSJ8MEGdrEPVKBA2nt
         ppkdGAryH0kPeoI0DDY2NRHV3Uhld0bysXc/9sfxofA3Hi6ZF2wP4hR8cYNO5PneRZp2
         VJR2lHHEnX5sQHy5gW0DeZi2gsPW9dpEBxZw6zIsKQHgX7RL1choUcF9NCnojIZelM84
         BJ5w6sCjUxRmxj8YSmAgJeISkV22U0VmxL2k5WEstYFSB60mv9XH47ipXfz3pDcTkpFe
         3T2w==
X-Gm-Message-State: AOJu0YwDiPAQnwC4bMB19ovRi3mR52P64jYx0mSVAWd6reNhkIH9pVen
        zufNj2J/BGp4LD1/dXEOqrnPnw==
X-Google-Smtp-Source: AGHT+IEudbmue8M6yA0xYro+jpm67k3FqoYEVMiQJJJo3YDKtmhjQwvFlnib/BHQNSOPw13z4fvWdQ==
X-Received: by 2002:a05:6102:5493:b0:45f:3b30:9c93 with SMTP id bk19-20020a056102549300b0045f3b309c93mr5730588vsb.22.1699378101200;
        Tue, 07 Nov 2023 09:28:21 -0800 (PST)
Received: from localhost ([2620:10d:c091:400::5:86b7])
        by smtp.gmail.com with ESMTPSA id o11-20020a056214108b00b0067095b0c473sm98923qvr.11.2023.11.07.09.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 09:28:20 -0800 (PST)
Date:   Tue, 7 Nov 2023 12:28:20 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Zhaoyang Huang <huangzhaoyang@gmail.com>,
        steve.kang@unisoc.com, Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCHv6 1/1] mm: optimization on page allocation when CMA
 enabled
Message-ID: <20231107172820.GA3745089@cmpxchg.org>
References: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016071245.2865233-1-zhaoyang.huang@unisoc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 03:12:45PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> According to current CMA utilization policy, an alloc_pages(GFP_USER)
> could 'steal' UNMOVABLE & RECLAIMABLE page blocks via the help of
> CMA(pass zone_watermark_ok by counting CMA in but use U&R in rmqueue),
> which could lead to following alloc_pages(GFP_KERNEL) fail.
> Solving this by introducing second watermark checking for GFP_MOVABLE,
> which could have the allocation use CMA when proper.
> 
> -- Free_pages(30MB)
> |
> |
> -- WMARK_LOW(25MB)
> |
> -- Free_CMA(12MB)
> |
> |
> --

We're running into the same issue in production and had an incident
over the weekend because of it. The hosts have a raised
vm.min_free_kbytes for network rx reliability, which makes the
mismatch between free pages and what's actually allocatable by regular
kernel requests quite pronounced. It wasn't OOMing this time, but we
saw very high rates of thrashing while CMA had plenty of headroom.

I had raised the broader issue around poor CMA utilization before:
https://lore.kernel.org/lkml/20230726145304.1319046-1-hannes@cmpxchg.org/

For context, we're using hugetlb_cma at several gigabytes to allow
sharing hosts between jobs that use hugetlb and jobs that don't.

> @@ -2078,6 +2078,43 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
>  
>  }
>  
> +#ifdef CONFIG_CMA
> +/*
> + * GFP_MOVABLE allocation could drain UNMOVABLE & RECLAIMABLE page blocks via
> + * the help of CMA which makes GFP_KERNEL failed. Checking if zone_watermark_ok
> + * again without ALLOC_CMA to see if to use CMA first.
> + */
> +static bool use_cma_first(struct zone *zone, unsigned int order, unsigned int alloc_flags)
> +{
> +	unsigned long watermark;
> +	bool cma_first = false;
> +
> +	watermark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
> +	/* check if GFP_MOVABLE pass previous zone_watermark_ok via the help of CMA */
> +	if (zone_watermark_ok(zone, order, watermark, 0, alloc_flags & (~ALLOC_CMA))) {
> +		/*
> +		 * Balance movable allocations between regular and CMA areas by
> +		 * allocating from CMA when over half of the zone's free memory
> +		 * is in the CMA area.
> +		 */
> +		cma_first = (zone_page_state(zone, NR_FREE_CMA_PAGES) >
> +				zone_page_state(zone, NR_FREE_PAGES) / 2);
> +	} else {
> +		/*
> +		 * watermark failed means UNMOVABLE & RECLAIMBLE is not enough
> +		 * now, we should use cma first to keep them stay around the
> +		 * corresponding watermark
> +		 */
> +		cma_first = true;
> +	}
> +	return cma_first;

I think it's a step in the right direction. However, it doesn't take
the lowmem reserves into account. With DMA32 that can be an additional
multiple gigabytes of "free" memory not available to GFP_KERNEL. It
also has a knee in the balancing curve because it doesn't take
reserves into account *until* non-CMA is depleted - at which point it
would already be below the use-CMA threshold by the full reserves and
watermarks.

A more complete solution would have to plumb the highest_zoneidx
information through the rmqueue family of functions somehow, and
always take unavailable free memory into account:

---
Subject: [PATCH] mm: page_alloc: use CMA when kernel allocations are beginning
 to fail

We can get into a situation where kernel allocations are starting to
fail on watermarks, but movable allocations still don't use CMA
because they make up more than half of the free memory. This can
happen in particular with elevated vm.min_free_kbytes settings, where
the remaining free pages aren't available to non-atomic requests.

Example scenario:

      Free: 3.0G
Watermarks: 2.0G
       CMA: 1.4G
-> non-CMA: 1.6G

CMA isn't used because CMA <= free/2. Kernel allocations fail due to
non-CMA < watermarks. If memory is mostly unreclaimable (e.g. anon
without swap), the kernel is more likely to OOM prematurely.

Reduce the probability of that happening by taking reserves and
watermarks into account when deciding whether to start using CMA.

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/page_alloc.c | 93 +++++++++++++++++++++++++++++++------------------
 1 file changed, 59 insertions(+), 34 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 733732e7e0ba..b9273d7f23b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2079,30 +2079,52 @@ __rmqueue_fallback(struct zone *zone, int order, int start_migratetype,
 
 }
 
+static bool should_try_cma(struct zone *zone, unsigned int order,
+			   gfp_t gfp_flags, unsigned int alloc_flags)
+{
+	long free_pages;
+
+	if (!IS_ENABLED(CONFIG_CMA) || !(alloc_flags & ALLOC_CMA))
+		return false;
+
+	/*
+	 * CMA regions can be used by movable allocations while
+	 * they're not otherwise in use. This is a delicate balance:
+	 * Filling CMA too soon poses a latency risk for actual CMA
+	 * allocations (think camera app startup). Filling CMA too
+	 * late risks premature OOMs from non-movable allocations.
+	 *
+	 * Start using CMA once it dominates the remaining free
+	 * memory. Be sure to take watermarks and reserves into
+	 * account when considering what's truly "free".
+	 *
+	 * free_pages can go negative, but that's okay because
+	 * NR_FREE_CMA_PAGES should not.
+	 */
+
+	free_pages = zone_page_state(zone, NR_FREE_PAGES);
+	free_pages -= zone->lowmem_reserve[gfp_zone(gfp_flags)];
+	free_pages -= wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+
+	return zone_page_state(zone, NR_FREE_CMA_PAGES) > free_pages / 2;
+}
+
 /*
  * Do the hard work of removing an element from the buddy allocator.
  * Call me with the zone->lock already held.
  */
 static __always_inline struct page *
-__rmqueue(struct zone *zone, unsigned int order, int migratetype,
-						unsigned int alloc_flags)
+__rmqueue(struct zone *zone, unsigned int order, gfp_t gfp_flags,
+	  int migratetype, unsigned int alloc_flags)
 {
 	struct page *page;
 
-	if (IS_ENABLED(CONFIG_CMA)) {
-		/*
-		 * Balance movable allocations between regular and CMA areas by
-		 * allocating from CMA when over half of the zone's free memory
-		 * is in the CMA area.
-		 */
-		if (alloc_flags & ALLOC_CMA &&
-		    zone_page_state(zone, NR_FREE_CMA_PAGES) >
-		    zone_page_state(zone, NR_FREE_PAGES) / 2) {
-			page = __rmqueue_cma_fallback(zone, order);
-			if (page)
-				return page;
-		}
+	if (should_try_cma(zone, order, gfp_flags, alloc_flags)) {
+		page = __rmqueue_cma_fallback(zone, order);
+		if (page)
+			return page;
 	}
+
 retry:
 	page = __rmqueue_smallest(zone, order, migratetype);
 	if (unlikely(!page)) {
@@ -2121,7 +2143,7 @@ __rmqueue(struct zone *zone, unsigned int order, int migratetype,
  * a single hold of the lock, for efficiency.  Add them to the supplied list.
  * Returns the number of new pages which were placed at *list.
  */
-static int rmqueue_bulk(struct zone *zone, unsigned int order,
+static int rmqueue_bulk(struct zone *zone, unsigned int order, gfp_t gfp_flags,
 			unsigned long count, struct list_head *list,
 			int migratetype, unsigned int alloc_flags)
 {
@@ -2130,8 +2152,8 @@ static int rmqueue_bulk(struct zone *zone, unsigned int order,
 
 	spin_lock_irqsave(&zone->lock, flags);
 	for (i = 0; i < count; ++i) {
-		struct page *page = __rmqueue(zone, order, migratetype,
-								alloc_flags);
+		struct page *page = __rmqueue(zone, order, gfp_flags,
+					      migratetype, alloc_flags);
 		if (unlikely(page == NULL))
 			break;
 
@@ -2714,8 +2736,8 @@ static inline void zone_statistics(struct zone *preferred_zone, struct zone *z,
 
 static __always_inline
 struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
-			   unsigned int order, unsigned int alloc_flags,
-			   int migratetype)
+			   unsigned int order, gfp_t gfp_flags,
+			   unsigned int alloc_flags, int migratetype)
 {
 	struct page *page;
 	unsigned long flags;
@@ -2726,7 +2748,8 @@ struct page *rmqueue_buddy(struct zone *preferred_zone, struct zone *zone,
 		if (alloc_flags & ALLOC_HIGHATOMIC)
 			page = __rmqueue_smallest(zone, order, MIGRATE_HIGHATOMIC);
 		if (!page) {
-			page = __rmqueue(zone, order, migratetype, alloc_flags);
+			page = __rmqueue(zone, order, migratetype,
+					 gfp_flags, alloc_flags);
 
 			/*
 			 * If the allocation fails, allow OOM handling access
@@ -2806,10 +2829,10 @@ static int nr_pcp_alloc(struct per_cpu_pages *pcp, struct zone *zone, int order)
 /* Remove page from the per-cpu list, caller must protect the list */
 static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
-			int migratetype,
-			unsigned int alloc_flags,
-			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			       gfp_t gfp_flags, int migratetype,
+			       unsigned int alloc_flags,
+			       struct per_cpu_pages *pcp,
+			       struct list_head *list)
 {
 	struct page *page;
 
@@ -2818,7 +2841,7 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int batch = nr_pcp_alloc(pcp, zone, order);
 			int alloced;
 
-			alloced = rmqueue_bulk(zone, order,
+			alloced = rmqueue_bulk(zone, order, gfp_flags,
 					batch, list,
 					migratetype, alloc_flags);
 
@@ -2837,8 +2860,9 @@ struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 
 /* Lock and remove page from the per-cpu list */
 static struct page *rmqueue_pcplist(struct zone *preferred_zone,
-			struct zone *zone, unsigned int order,
-			int migratetype, unsigned int alloc_flags)
+				    struct zone *zone, unsigned int order,
+				    gfp_t gfp_flags, int migratetype,
+				    unsigned int alloc_flags)
 {
 	struct per_cpu_pages *pcp;
 	struct list_head *list;
@@ -2860,7 +2884,8 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp->free_count >>= 1;
 	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, gfp_flags, migratetype,
+				 alloc_flags, pcp, list);
 	pcp_spin_unlock(pcp);
 	pcp_trylock_finish(UP_flags);
 	if (page) {
@@ -2898,13 +2923,13 @@ struct page *rmqueue(struct zone *preferred_zone,
 
 	if (likely(pcp_allowed_order(order))) {
 		page = rmqueue_pcplist(preferred_zone, zone, order,
-				       migratetype, alloc_flags);
+				       gfp_flags, migratetype, alloc_flags);
 		if (likely(page))
 			goto out;
 	}
 
-	page = rmqueue_buddy(preferred_zone, zone, order, alloc_flags,
-							migratetype);
+	page = rmqueue_buddy(preferred_zone, zone, order, gfp_flags,
+			     alloc_flags, migratetype);
 
 out:
 	/* Separate test+clear to avoid unnecessary atomics */
@@ -4480,8 +4505,8 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+		page = __rmqueue_pcplist(zone, 0, gfp, ac.migratetype,
+					 alloc_flags, pcp, pcp_list);
 		if (unlikely(!page)) {
 			/* Try and allocate at least one page */
 			if (!nr_account) {
-- 
2.42.0

