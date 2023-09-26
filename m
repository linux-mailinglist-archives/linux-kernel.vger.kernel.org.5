Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3FE7AF1D1
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 19:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234453AbjIZRjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 13:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjIZRju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 13:39:50 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8479E10A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:39:41 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id af79cd13be357-77411614b57so560409085a.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 10:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695749980; x=1696354780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M/HE/h/DLmW85zg+lLTNdWCWcTLFJzgmxCBm7pLD248=;
        b=bhh2R05WkP4IxuVd34Sb4GIfT9IjjguOlizXEiHYdh7IBPA/4s/n7uWASow+YNa9sf
         P3U3B923Et1din383GTpcnaNIX3ExK9hzrRpDwYntU/UXtgO7jfA9Vpa91DOp8k36n6E
         llksAf2JtzaGx/u5e+IM6wOGmd2l9OGF+GWurK0Q+FiaZJfT7TiYgyIW99OnfN2iesPT
         5Uv46wk7IggVCpTp+oeQiLmOKMDdrt71DcNwIzTI5uOcAqol9NMog15+qZqTbwXiFB4G
         hRW59nxDSxhwiL6KVQAxXartW8xbSiF84XjKG6ktGWPfhU3FiDnnefqNkAFPoCK1AKd8
         oKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695749980; x=1696354780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/HE/h/DLmW85zg+lLTNdWCWcTLFJzgmxCBm7pLD248=;
        b=jrhuQNZrGjFaaP5JlUICyOrzwW9bFPxnDEyp53jS37oGkTkCJ1US4U1OToySnY0cmB
         4CtdPt+RHOtAEEzIs48xMyLyDmzmkJ1ZgguV7rnAvXPnN/ZIslI0Bf+7cU4JrEhIZ7J5
         ONXewPRMg8L3WlIwN1kFzg1jC0zEsGAYrlRQ/xy9fGO7I6ACBwp6WpERxO3wrB+lBjIY
         9/IXi6UQGcrWG2bbmroaGYqUZjFtvGRN6UDnYmdMgr8vl/usOZ6QYUawV0uW8CD1azLI
         3kCkB8RKIqB1vLG+DfNrGFBgsZfzY6qObbMdkkObE2BvwF81IkR8/Q2ySfvOiEx+Y0FA
         Xs7w==
X-Gm-Message-State: AOJu0YxmS1SddgQUjwJN/8/ORlwQVHFDmRPQB8ZTBnCdNrmD0uD1/Stc
        hmrTQIhk6L8Co+8NdVVYitDMRqzjLHaOXdHDJ1c=
X-Google-Smtp-Source: AGHT+IEjtQuMo+SvbxAhL6hzbPhS4evoAbLs2UcxOjK2OsZTQFCMGr2GNZ3LqHTC7cY6O4nppT15iA==
X-Received: by 2002:a05:620a:389a:b0:774:1c60:4b16 with SMTP id qp26-20020a05620a389a00b007741c604b16mr8417121qkn.49.1695749980417;
        Tue, 26 Sep 2023 10:39:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:ba06])
        by smtp.gmail.com with ESMTPSA id v15-20020ae9e30f000000b0077263636a95sm272174qkf.93.2023.09.26.10.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Sep 2023 10:39:39 -0700 (PDT)
Date:   Tue, 26 Sep 2023 13:39:39 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Zi Yan <ziy@nvidia.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230926173939.GA348484@cmpxchg.org>
References: <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org>
 <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 05:12:38PM -0400, Zi Yan wrote:
> On 21 Sep 2023, at 10:47, Zi Yan wrote:
> 
> > On 21 Sep 2023, at 6:19, David Hildenbrand wrote:
> >
> >> On 21.09.23 04:31, Zi Yan wrote:
> >>> On 20 Sep 2023, at 13:23, Zi Yan wrote:
> >>>
> >>>> On 20 Sep 2023, at 12:04, Johannes Weiner wrote:
> >>>>
> >>>>> On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
> >>>>>> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
> >>>>>>> On 9/20/23 03:38, Zi Yan wrote:
> >>>>>>>> On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
> >>>>>>>>
> >>>>>>>>> On 09/19/23 16:57, Zi Yan wrote:
> >>>>>>>>>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
> >>>>>>>>>>
> >>>>>>>>>>> 	--- a/mm/page_alloc.c
> >>>>>>>>>>> 	+++ b/mm/page_alloc.c
> >>>>>>>>>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> >>>>>>>>>>>   		end = pageblock_end_pfn(pfn) - 1;
> >>>>>>>>>>>
> >>>>>>>>>>>   		/* Do not cross zone boundaries */
> >>>>>>>>>>> 	+#if 0
> >>>>>>>>>>>   		if (!zone_spans_pfn(zone, start))
> >>>>>>>>>>> 			start = zone->zone_start_pfn;
> >>>>>>>>>>> 	+#else
> >>>>>>>>>>> 	+	if (!zone_spans_pfn(zone, start))
> >>>>>>>>>>> 	+		start = pfn;
> >>>>>>>>>>> 	+#endif
> >>>>>>>>>>> 	 	if (!zone_spans_pfn(zone, end))
> >>>>>>>>>>> 	 		return false;
> >>>>>>>>>>> 	I can still trigger warnings.
> >>>>>>>>>>
> >>>>>>>>>> OK. One thing to note is that the page type in the warning changed from
> >>>>>>>>>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Just to be really clear,
> >>>>>>>>> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
> >>>>>>>>> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
> >>>>>>>>>    path WITHOUT your change.
> >>>>>>>>>
> >>>>>>>>> I am guessing the difference here has more to do with the allocation path?
> >>>>>>>>>
> >>>>>>>>> I went back and reran focusing on the specific migrate type.
> >>>>>>>>> Without your patch, and coming from the alloc_contig_range call path,
> >>>>>>>>> I got two warnings of 'page type is 0, passed migratetype is 1' as above.
> >>>>>>>>> With your patch I got one 'page type is 0, passed migratetype is 1'
> >>>>>>>>> warning and one 'page type is 1, passed migratetype is 0' warning.
> >>>>>>>>>
> >>>>>>>>> I could be wrong, but I do not think your patch changes things.
> >>>>>>>>
> >>>>>>>> Got it. Thanks for the clarification.
> >>>>>>>>>
> >>>>>>>>>>>
> >>>>>>>>>>> One idea about recreating the issue is that it may have to do with size
> >>>>>>>>>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tried
> >>>>>>>>>>> to really stress the allocations by increasing the number of hugetlb
> >>>>>>>>>>> pages requested and that did not help.  I also noticed that I only seem
> >>>>>>>>>>> to get two warnings and then they stop, even if I continue to run the
> >>>>>>>>>>> script.
> >>>>>>>>>>>
> >>>>>>>>>>> Zi asked about my config, so it is attached.
> >>>>>>>>>>
> >>>>>>>>>> With your config, I still have no luck reproducing the issue. I will keep
> >>>>>>>>>> trying. Thanks.
> >>>>>>>>>>
> >>>>>>>>>
> >>>>>>>>> Perhaps try running both scripts in parallel?
> >>>>>>>>
> >>>>>>>> Yes. It seems to do the trick.
> >>>>>>>>
> >>>>>>>>> Adjust the number of hugetlb pages allocated to equal 25% of memory?
> >>>>>>>>
> >>>>>>>> I am able to reproduce it with the script below:
> >>>>>>>>
> >>>>>>>> while true; do
> >>>>>>>>   echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
> >>>>>>>>   echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
> >>>>>>>>   wait
> >>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> >>>>>>>>   echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> >>>>>>>> done
> >>>>>>>>
> >>>>>>>> I will look into the issue.
> >>>>>>
> >>>>>> Nice!
> >>>>>>
> >>>>>> I managed to reproduce it ONCE, triggering it not even a second after
> >>>>>> starting the script. But I can't seem to do it twice, even after
> >>>>>> several reboots and letting it run for minutes.
> >>>>>
> >>>>> I managed to reproduce it reliably by cutting the nr_hugepages
> >>>>> parameters respectively in half.
> >>>>>
> >>>>> The one that triggers for me is always MIGRATE_ISOLATE. With some
> >>>>> printk-tracing, the scenario seems to be this:
> >>>>>
> >>>>> #0                                                   #1
> >>>>> start_isolate_page_range()
> >>>>>    isolate_single_pageblock()
> >>>>>      set_migratetype_isolate(tail)
> >>>>>        lock zone->lock
> >>>>>        move_freepages_block(tail) // nop
> >>>>>        set_pageblock_migratetype(tail)
> >>>>>        unlock zone->lock
> >>>>>                                                       del_page_from_freelist(head)
> >>>>>                                                       expand(head, head_mt)
> >>>>>                                                         WARN(head_mt != tail_mt)
> >>>>>      start_pfn = ALIGN_DOWN(MAX_ORDER_NR_PAGES)
> >>>>>      for (pfn = start_pfn, pfn < end_pfn)
> >>>>>        if (PageBuddy())
> >>>>>          split_free_page(head)
> >>>>>
> >>>>> IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop the
> >>>>> lock. The move_freepages_block() does nothing because the PageBuddy()
> >>>>> is set on the pageblock to the left. Once we drop the lock, the buddy
> >>>>> gets allocated and the expand() puts things on the wrong list. The
> >>>>> splitting code that handles MAX_ORDER blocks runs *after* the tail
> >>>>> type is set and the lock has been dropped, so it's too late.
> >>>>
> >>>> Yes, this is the issue I can confirm as well. But it is intentional to enable
> >>>> allocating a contiguous range at pageblock granularity instead of MAX_ORDER
> >>>> granularity. With your changes below, it no longer works, because if there
> >>>> is an unmovable page in
> >>>> [ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES), pageblock_start_pfn(start_pfn)),
> >>>> the allocation fails but it would succeed in current implementation.
> >>>>
> >>>> I think a proper fix would be to make move_freepages_block() split the
> >>>> MAX_ORDER page and put the split pages in the right migratetype free lists.
> >>>>
> >>>> I am working on that.
> >>>
> >>> After spending half a day on this, I think it is much harder than I thought
> >>> to get alloc_contig_range() working with the freelist migratetype hygiene
> >>> patchset. Because alloc_contig_range() relies on racy migratetype changes:
> >>>
> >>> 1. pageblocks in the range are first marked as MIGRATE_ISOLATE to prevent
> >>> another parallel isolation, but they are not moved to the MIGRATE_ISOLATE
> >>> free list yet.
> >>>
> >>> 2. later in the process, isolate_freepages_range() is used to actually grab
> >>> the free pages.
> >>>
> >>> 3. there was no problem when alloc_contig_range() works on MAX_ORDER aligned
> >>> ranges, since MIGRATE_ISOLATE cannot be set in the middle of free pages or
> >>> in-use pages. But it is not the case when alloc_contig_range() work on
> >>> pageblock aligned ranges. Now during isolation phase, free or in-use pages
> >>> will need to be split to get their subpages into the right free lists.
> >>>
> >>> 4. the hardest case is when a in-use page sits across two pageblocks, currently,
> >>> the code just isolate one pageblock, migrate the page, and let split_free_page()
> >>> to correct the free list later. But to strictly enforce freelist migratetype
> >>> hygiene, extra work is needed at free page path to split the free page into
> >>> the right freelists.
> >>>
> >>> I need more time to think about how to get alloc_contig_range() properly.
> >>> Help is needed for the bullet point 4.
> >>
> >>
> >> I once raised that we should maybe try making MIGRATE_ISOLATE a flag that preserves the original migratetype. Not sure if that would help here in any way.
> >
> > I have that in my backlog since you asked and have been delaying it. ;) Hopefully
> > I can do it after I fix this. That change might or might not help only if we make
> > some redesign on how migratetype is managed. If MIGRATE_ISOLATE does not
> > overwrite existing migratetype, the code might not need to split a page and move
> > it to MIGRATE_ISOLATE freelist?
> >
> > The fundamental issue in alloc_contig_range() is that to work at
> > pageblock level, a page (>pageblock_order) can have one part is isolated and
> > the rest is a different migratetype. {add_to,move_to,del_page_from}_free_list()
> > now checks first pageblock migratetype, so such a page needs to be removed
> > from its free_list, set MIGRATE_ISOLATE on one of the pageblock, split, and
> > finally put back to multiple free lists. This needs to be done at isolation stage
> > before free pages are removed from their free lists (the stage after isolation).
> > If MIGRATE_ISOLATE is a separate flag and we are OK with leaving isolated pages
> > in their original migratetype and check migratetype before allocating a page,
> > that might help. But that might add extra work (e.g., splitting a partially
> > isolated free page before allocation) in the really hot code path, which is not
> > desirable.
> >
> >>
> >> The whole alloc_contig_range() implementation is quite complicated and hard to grasp. If we could find ways to clean all that up and make it easier to understand and play along, that would be nice.
> >
> > I will try my best to simplify it.
> 
> Hi Johannes,
> 
> I attached three patches to fix the issue and first two can be folded into
> your patchset:

Hi Zi, thanks for providing these patches! I'll pick them up into the
series.

> 1. __free_one_page() bug you and Vlastimil discussed on the other email.
> 2. move set_pageblock_migratetype() into move_freepages() to prepare for patch 3.
> 3. enable move_freepages() to split a free page that is partially covered by
>    [start_pfn, end_pfn] in the parameter and set migratetype correctly when
>    a >pageblock_order free page is moved. Before when a >pageblock_order
>    free page is moved, only first pageblock migratetype is changed. The added
>    WARN_ON_ONCE might be triggered by these pages.
> 
> I ran Mike's test with transhuge-stress together with my patches on top of your
> "close migratetype race" patch for more than an hour without any warning.
> It should unblock your patchset. I will keep working on alloc_contig_range()
> simplification.
> 
> 
> --
> Best Regards,
> Yan, Zi

> From a18de9a235dc97999fcabdac699f33da9138b0ba Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Fri, 22 Sep 2023 11:11:32 -0400
> Subject: [PATCH 1/3] mm: fix __free_one_page().
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/page_alloc.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7de022bc4c7d..72f27d14c8e7 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -787,8 +787,6 @@ static inline void __free_one_page(struct page *page,
>  	VM_BUG_ON_PAGE(bad_range(zone, page), page);
>  
>  	while (order < MAX_ORDER) {
> -		int buddy_mt;
> -
>  		if (compaction_capture(capc, page, order, migratetype))
>  			return;
>  
> @@ -796,8 +794,6 @@ static inline void __free_one_page(struct page *page,
>  		if (!buddy)
>  			goto done_merging;
>  
> -		buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
> -
>  		if (unlikely(order >= pageblock_order)) {
>  			/*
>  			 * We want to prevent merge between freepages on pageblock
> @@ -827,7 +823,7 @@ static inline void __free_one_page(struct page *page,
>  		if (page_is_guard(buddy))
>  			clear_page_guard(zone, buddy, order);
>  		else
> -			del_page_from_free_list(buddy, zone, order, buddy_mt);
> +			del_page_from_free_list(buddy, zone, order, migratetype);
>  		combined_pfn = buddy_pfn & pfn;
>  		page = page + (combined_pfn - pfn);
>  		pfn = combined_pfn;

I had a fix for this that's slightly different. The buddy's type can't
be changed while it's still on the freelist, so I moved that
around. The sequence now is:

	int buddy_mt = migratetype;

	if (unlikely(order >= pageblock_order)) {
		/* This is the only case where buddy_mt can differ */
		buddy_mt = get_pfnblock_migratetype(buddy, buddy_pfn);
		// compat checks...
	}

	del_page_from_free_list(buddy, buddy_mt);

	if (unlikely(buddy_mt != migratetype))
		set_pageblock_migratetype(buddy, migratetype);


> From b11a0e3d8f9d7d91a884c90dc9cebb185c3a2bbc Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Mon, 25 Sep 2023 16:27:14 -0400
> Subject: [PATCH 2/3] mm: set migratetype after free pages are moved between
>  free lists.
> 
> This avoids changing migratetype after move_freepages() or
> move_freepages_block(), which is error prone. It also prepares for upcoming
> changes to fix move_freepages() not moving free pages partially in the
> range.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

This makes the code much cleaner, thank you!

> From 75a4d327efd94230f3b9aab29ef6ec0badd488a6 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Mon, 25 Sep 2023 16:55:18 -0400
> Subject: [PATCH 3/3] mm: enable move_freepages() to properly move part of free
>  pages.
> 
> alloc_contig_range() uses set_migrateype_isolate(), which eventually calls
> move_freepages(), to isolate free pages. But move_freepages() was not able
> to move free pages partially covered by the specified range, leaving a race
> window open[1]. Fix it by teaching move_freepages() to split a free page
> when only part of it is going to be moved.
> 
> In addition, when a >pageblock_order free page is moved, only its first
> pageblock migratetype is changed. It can cause warnings later. Fix it by
> set all pageblocks in a free page to the same migratetype after move.
> 
> split_free_page() is changed to be used in move_freepages() and
> isolate_single_pageblock(). A common code to find the start pfn of a free
> page is refactored in get_freepage_start_pfn().
> 
> [1] https://lore.kernel.org/linux-mm/20230920160400.GC124289@cmpxchg.org/
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  mm/page_alloc.c     | 75 ++++++++++++++++++++++++++++++++++++---------
>  mm/page_isolation.c | 17 +++++++---
>  2 files changed, 73 insertions(+), 19 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7c41cb5d8a36..3fd5ab40b55c 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -866,15 +866,15 @@ int split_free_page(struct page *free_page,
>  	struct zone *zone = page_zone(free_page);
>  	unsigned long free_page_pfn = page_to_pfn(free_page);
>  	unsigned long pfn;
> -	unsigned long flags;
>  	int free_page_order;
>  	int mt;
>  	int ret = 0;
>  
> -	if (split_pfn_offset == 0)
> -		return ret;
> +	/* zone lock should be held when this function is called */
> +	lockdep_assert_held(&zone->lock);
>  
> -	spin_lock_irqsave(&zone->lock, flags);
> +	if (split_pfn_offset == 0 || split_pfn_offset >= (1 << order))
> +		return ret;
>  
>  	if (!PageBuddy(free_page) || buddy_order(free_page) != order) {
>  		ret = -ENOENT;
> @@ -900,7 +900,6 @@ int split_free_page(struct page *free_page,
>  			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
>  	}
>  out:
> -	spin_unlock_irqrestore(&zone->lock, flags);
>  	return ret;
>  }
>  /*
> @@ -1589,6 +1588,25 @@ static inline struct page *__rmqueue_cma_fallback(struct zone *zone,
>  					unsigned int order) { return NULL; }
>  #endif
>  
> +/*
> + * Get first pfn of the free page, where pfn is in. If this free page does
> + * not exist, return the given pfn.
> + */
> +static unsigned long get_freepage_start_pfn(unsigned long pfn)
> +{
> +	int order = 0;
> +	unsigned long start_pfn = pfn;
> +
> +	while (!PageBuddy(pfn_to_page(start_pfn))) {
> +		if (++order > MAX_ORDER) {
> +			start_pfn = pfn;
> +			break;
> +		}
> +		start_pfn &= ~0UL << order;
> +	}
> +	return start_pfn;
> +}
> +
>  /*
>   * Move the free pages in a range to the freelist tail of the requested type.
>   * Note that start_page and end_pages are not aligned on a pageblock
> @@ -1598,9 +1616,29 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
>  			  unsigned long end_pfn, int old_mt, int new_mt)
>  {
>  	struct page *page;
> -	unsigned long pfn;
> +	unsigned long pfn, pfn2;
>  	unsigned int order;
>  	int pages_moved = 0;
> +	unsigned long mt_change_pfn = start_pfn;
> +	unsigned long new_start_pfn = get_freepage_start_pfn(start_pfn);
> +
> +	/* split at start_pfn if it is in the middle of a free page */
> +	if (new_start_pfn != start_pfn && PageBuddy(pfn_to_page(new_start_pfn))) {
> +		struct page *new_page = pfn_to_page(new_start_pfn);
> +		int new_page_order = buddy_order(new_page);
> +
> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {
> +			/* change migratetype so that split_free_page can work */
> +			set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
> +			split_free_page(new_page, buddy_order(new_page),
> +					start_pfn - new_start_pfn);
> +
> +			mt_change_pfn = start_pfn;
> +			/* move to next page */
> +			start_pfn = new_start_pfn + (1 << new_page_order);
> +		}
> +	}

Ok, so if there is a straddle from the previous block into our block
of interest, it's split and the migratetype is set only on our block.

> @@ -1615,10 +1653,24 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
>  
>  		order = buddy_order(page);
>  		move_to_free_list(page, zone, order, old_mt, new_mt);
> +		/*
> +		 * set page migratetype for all pageblocks within the page and
> +		 * only after we move all free pages in one pageblock
> +		 */
> +		if (pfn + (1 << order) >= pageblock_end_pfn(pfn)) {
> +			for (pfn2 = pfn; pfn2 < pfn + (1 << order);
> +			     pfn2 += pageblock_nr_pages) {
> +				set_pageblock_migratetype(pfn_to_page(pfn2),
> +							  new_mt);
> +				mt_change_pfn = pfn2;
> +			}

But if we have the first block of a MAX_ORDER chunk, then we don't
split but rather move the whole chunk and make sure to update the
chunk's blocks that are outside the range of interest.

It looks like either way would work, but why not split here as well
and keep the move contained to the block? Wouldn't this be a bit more
predictable and easier to understand?

> +		}
>  		pfn += 1 << order;
>  		pages_moved += 1 << order;
>  	}
> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
> +	/* set migratetype for the remaining pageblocks */
> +	for (pfn2 = mt_change_pfn; pfn2 <= end_pfn; pfn2 += pageblock_nr_pages)
> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);

I think I'm missing something for this.

- If there was no straddle, there is only our block of interest to
  update.

- If there was a straddle from the previous block, it was split and
  the block of interest was already updated. Nothing to do here?

- If there was a straddle into the next block, both blocks are updated
  to the new type. Nothing to do here?

What's the case where there are multiple blocks to update in the end?

> @@ -380,8 +380,15 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  			int order = buddy_order(page);
>  
>  			if (pfn + (1UL << order) > boundary_pfn) {
> +				int res;
> +				unsigned long flags;
> +
> +				spin_lock_irqsave(&zone->lock, flags);
> +				res = split_free_page(page, order, boundary_pfn - pfn);
> +				spin_unlock_irqrestore(&zone->lock, flags);
> +
>  				/* free page changed before split, check it again */
> -				if (split_free_page(page, order, boundary_pfn - pfn))
> +				if (res)
>  					continue;

At this point, we've already set the migratetype, which has handled
straddling free pages. Is this split still needed?

> @@ -426,9 +433,11 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  				/*
>  				 * XXX: mark the page as MIGRATE_ISOLATE so that
>  				 * no one else can grab the freed page after migration.
> -				 * Ideally, the page should be freed as two separate
> -				 * pages to be added into separate migratetype free
> -				 * lists.
> +				 * The page should be freed into separate migratetype
> +				 * free lists, unless the free page order is greater
> +				 * than pageblock order. It is not the case now,
> +				 * since gigantic hugetlb is freed as order-0
> +				 * pages and LRU pages do not cross pageblocks.
>  				 */
>  				if (isolate_page) {
>  					ret = set_migratetype_isolate(page, page_mt,

I hadn't thought about LRU pages being constrained to single
pageblocks before. Does this mean we only ever migrate here in case
there is a movable gigantic page? And since those are already split
during the free, does that mean the "reset pfn to head of the free
page" part after the migration is actually unnecessary?
