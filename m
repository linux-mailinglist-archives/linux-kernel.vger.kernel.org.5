Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3B707CB2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 20:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjJPSvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 14:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjJPSvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 14:51:19 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2E2D95
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:51:15 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-66d0169cf43so32203276d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 11:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697482275; x=1698087075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7m6cAQ7o+71eMAVNRk1lwu4DVz2D8rg0lEAoo3BgK2s=;
        b=r9NFt9HcnnUb8aF9+HdW/ikkioRUaz82hJw1R/k7fKR8wSWmZp8KhdxOxg3eghOt7I
         QpnRX3mLqQ+dmFKIWuW3Fapx8CQLu0oBareESsCO5SNH02TeZZMqo0JpjZDdOv7O9G3B
         CdnyPCcemw/86e0+uy2NxChcLZfsYAPYVZ4aT8rOP8/vnoN4e3O+FRWQKK43zQH/Id2O
         WDirM8IeU5bV9RLwiNj/6D5aXljv8wig5xNuAm3lI33HeIxY1ZSkMU3pxWe+2zGTBOys
         X/hNbuWsmskstyTJ0XLwmwOGkHwwQLcnR/oZy2QH3T8lRu81xN3zaloFpA5WX5N6TnMw
         cWMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697482275; x=1698087075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7m6cAQ7o+71eMAVNRk1lwu4DVz2D8rg0lEAoo3BgK2s=;
        b=FkDWBMhf+mdbctDUpaFq1gWUy/zReC2eHkNkuLZpGflT6XAZ/LxEF4gTT3uQhvHvet
         Ve3jSuGONnPXXP8RO6zoQFraTAco8tBNuZxESKxNOIVyTe4l7PzNNs26w2yevuXQcayx
         CdLHkx5J06oQl0SOT5j0GHsp4LLUN0OZWio3bosuPAMTq2ts30ktTj08d0Hu3CymY5J6
         6yiXRjWKDOFCsEC6iZiZQYYGkoTDMBqtjtBU4fHiubyTvYpOMEnGeMixaHJnaM8a8wXN
         RF5SjoZAZZEBNrD0DzFiq14BIvwYj9dNDVoTbKJXjarBzmP3W325AURmSPRc3h0JKLSf
         GStA==
X-Gm-Message-State: AOJu0Yxrl8Nk5VCug8qGO7R4sH+1/wz4GV2EzQSIkRjSJ3ufRFo/QQeM
        4Q7rQnbWc+sity+uSTwiEPi2AQ==
X-Google-Smtp-Source: AGHT+IH55Z9rmycindbLC+/UFKfmSg38g9Eod14Xjnv+RnXKFL7t6EPA62H42x+FnZ9ksYtXytuCLg==
X-Received: by 2002:a05:6214:230c:b0:66d:775:d1af with SMTP id gc12-20020a056214230c00b0066d0775d1afmr353141qvb.59.1697482274807;
        Mon, 16 Oct 2023 11:51:14 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id g20-20020a05620a13d400b0076d6a08ac98sm3198778qkl.76.2023.10.16.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 11:51:14 -0700 (PDT)
Date:   Mon, 16 Oct 2023 14:51:13 -0400
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
Message-ID: <20231016185113.GI470544@cmpxchg.org>
References: <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
 <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 11:00:33AM -0400, Zi Yan wrote:
> On 16 Oct 2023, at 10:37, Johannes Weiner wrote:
> 
> > On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
> >>> The attached patch has all the suggested changes, let me know how it
> >>> looks to you. Thanks.
> >>
> >> The one I sent has free page accounting issues. The attached one fixes them.
> >
> > Do you still have the warnings? I wonder what went wrong.
> 
> No warnings. But something with the code:
> 
> 1. in your version, split_free_page() is called without changing any pageblock
> migratetypes, then split_free_page() is just a no-op, since the page is
> just deleted from the free list, then freed via different orders. Buddy allocator
> will merge them back.

Hm not quite.

If it's the tail block of a buddy, I update its type before
splitting. The splitting loop looks up the type of each block for
sorting it onto freelists.

If it's the head block, yes I split it first according to its old
type. But then I let it fall through to scanning the block, which will
find that buddy, update its type and move it.

> 2. in my version, I set pageblock migratetype to new_mt before split_free_page(),
> but it causes free page accounting issues, since in the case of head, free pages
> are deleted from new_mt when they are in old_mt free list and the accounting
> decreases new_mt free page number instead of old_mt one.

Right, that makes sense.

> Basically, split_free_page() is awkward as it relies on preset migratetypes,
> which changes migratetypes without deleting the free pages from the list first.
> That is why I came up with the new split_free_page() below.

Yeah, the in-between thing is bad. Either it fixes the migratetype
before deletion, or it doesn't do the deletion. I'm thinking it would
be simpler to move the deletion out instead.

> >> @@ -883,6 +886,10 @@ int split_free_page(struct page *free_page,
> >>  	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
> >>  	del_page_from_free_list(free_page, zone, order, mt);
> >>
> >> +	set_pageblock_migratetype(free_page, mt1);
> >> +	set_pageblock_migratetype(pfn_to_page(free_page_pfn + split_pfn_offset),
> >> +				  mt2);
> >> +
> >>  	for (pfn = free_page_pfn;
> >>  	     pfn < free_page_pfn + (1UL << order);) {
> >>  		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> >
> > I don't think this is quite right.
> >
> > With CONFIG_ARCH_FORCE_MAX_ORDER it's possible that we're dealing with
> > a buddy that is more than two blocks:
> >
> > [pageblock 0][pageblock 1][pageblock 2][pageblock 3]
> > [buddy                                             ]
> >                                        [isolate range ..
> >
> > That for loop splits the buddy into 4 blocks. The code above would set
> > pageblock 0 to old_mt, and pageblock 1 to new_mt. But it should only
> > set pageblock 3 to new_mt.
> 
> OK. I think I need to fix split_free_page().
> 
> Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than one
> pageblock and in turn makes an in-use page have more than one pageblock,
> we will have problems. Since in isolate_single_pageblock(), an in-use page
> can have part of its pageblock set to a different migratetype and be freed,
> causing the free page with unmatched migratetypes. We might need to
> free pages at pageblock_order if their orders are bigger than pageblock_order.

Is this a practical issue? You mentioned that right now only gigantic
pages can be larger than a pageblock, and those are freed in order-0
chunks.

> > How about pulling the freelist removal out of split_free_page()?
> >
> > 	del_page_from_freelist(huge_buddy);
> > 	set_pageblock_migratetype(start_page, MIGRATE_ISOLATE);
> > 	split_free_page(huge_buddy, buddy_order(), pageblock_nr_pages);
> > 	return pageblock_nr_pages;
> 
> Yes, this is better. Let me change to this implementation.
> 
> But I would like to test it on an environment where a buddy contains more than
> one pageblocks first. I probably can change MAX_ORDER of x86_64 to do it locally.
> I will report back.

I tweaked my version some more based on our discussion. Would you mind
taking a look? It survived an hour of stressing with a kernel build
and Mike's reproducer that allocates gigantics and demotes them.

Note that it applies *before* consolidating of the free counts, as
isolation needs to be fixed before the warnings are added, to avoid
bisectability issues. The consolidation patch doesn't change it much,
except removing freepage accounting in move_freepages_block_isolate().

---

From a0460ad30a24cf73816ac40b262af0ba3723a242 Mon Sep 17 00:00:00 2001
From: Johannes Weiner <hannes@cmpxchg.org>
Date: Mon, 16 Oct 2023 12:32:21 -0400
Subject: [PATCH] mm: page_isolation: prepare for hygienic freelists

Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   4 -
 mm/page_alloc.c                | 198 +++++++++++++++++++--------------
 mm/page_isolation.c            |  96 +++++-----------
 4 files changed, 142 insertions(+), 160 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolation.h
index 8550b3c91480..c16db0067090 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -34,7 +34,9 @@ static inline bool is_migrate_isolate(int migratetype)
 #define REPORT_FAILURE	0x2
 
 void set_pageblock_migratetype(struct page *page, int migratetype);
-int move_freepages_block(struct zone *zone, struct page *page, int migratetype);
+
+bool move_freepages_block_isolate(struct zone *zone, struct page *page,
+				  int migratetype);
 
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 			     int migratetype, int flags, gfp_t gfp_flags);
diff --git a/mm/internal.h b/mm/internal.h
index 3a72975425bb..0681094ad260 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -464,10 +464,6 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr_t align,
 void memmap_init_range(unsigned long, int, unsigned long, unsigned long,
 		unsigned long, enum meminit_context, struct vmem_altmap *, int);
 
-
-int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset);
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 
 /*
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6185b076cf90..17e9a06027c8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -834,64 +834,6 @@ static inline void __free_one_page(struct page *page,
 		page_reporting_notify_free(order);
 }
 
-/**
- * split_free_page() -- split a free page at split_pfn_offset
- * @free_page:		the original free page
- * @order:		the order of the page
- * @split_pfn_offset:	split offset within the page
- *
- * Return -ENOENT if the free page is changed, otherwise 0
- *
- * It is used when the free page crosses two pageblocks with different migratetypes
- * at split_pfn_offset within the page. The split free page will be put into
- * separate migratetype lists afterwards. Otherwise, the function achieves
- * nothing.
- */
-int split_free_page(struct page *free_page,
-			unsigned int order, unsigned long split_pfn_offset)
-{
-	struct zone *zone = page_zone(free_page);
-	unsigned long free_page_pfn = page_to_pfn(free_page);
-	unsigned long pfn;
-	unsigned long flags;
-	int free_page_order;
-	int mt;
-	int ret = 0;
-
-	if (split_pfn_offset == 0)
-		return ret;
-
-	spin_lock_irqsave(&zone->lock, flags);
-
-	if (!PageBuddy(free_page) || buddy_order(free_page) != order) {
-		ret = -ENOENT;
-		goto out;
-	}
-
-	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
-	if (likely(!is_migrate_isolate(mt)))
-		__mod_zone_freepage_state(zone, -(1UL << order), mt);
-
-	del_page_from_free_list(free_page, zone, order);
-	for (pfn = free_page_pfn;
-	     pfn < free_page_pfn + (1UL << order);) {
-		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
-
-		free_page_order = min_t(unsigned int,
-					pfn ? __ffs(pfn) : order,
-					__fls(split_pfn_offset));
-		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
-				mt, FPI_NONE);
-		pfn += 1UL << free_page_order;
-		split_pfn_offset -= (1UL << free_page_order);
-		/* we have done the first part, now switch to second part */
-		if (split_pfn_offset == 0)
-			split_pfn_offset = (1UL << order) - (pfn - free_page_pfn);
-	}
-out:
-	spin_unlock_irqrestore(&zone->lock, flags);
-	return ret;
-}
 /*
  * A bad page could be due to a number of fields. Instead of multiple branches,
  * try and check multiple fields with one check. The caller must do a detailed
@@ -1673,8 +1615,8 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
 	return true;
 }
 
-int move_freepages_block(struct zone *zone, struct page *page,
-			 int migratetype)
+static int move_freepages_block(struct zone *zone, struct page *page,
+				int migratetype)
 {
 	unsigned long start_pfn, end_pfn;
 
@@ -1685,6 +1627,117 @@ int move_freepages_block(struct zone *zone, struct page *page,
 	return move_freepages(zone, start_pfn, end_pfn, migratetype);
 }
 
+#ifdef CONFIG_MEMORY_ISOLATION
+/* Look for a multi-block buddy that straddles start_pfn */
+static unsigned long find_large_buddy(unsigned long start_pfn)
+{
+	int order = 0;
+	struct page *page;
+	unsigned long pfn = start_pfn;
+
+	while (!PageBuddy(page = pfn_to_page(pfn))) {
+		/* Nothing found */
+		if (++order > MAX_ORDER)
+			return start_pfn;
+		pfn &= ~0UL << order;
+	}
+
+	/*
+	 * Found a preceding buddy, but does it straddle?
+	 */
+	if (pfn + (1 << buddy_order(page)) > start_pfn)
+		return pfn;
+
+	/* Nothing found */
+	return start_pfn;
+}
+
+/* Split a multi-block buddy into its individual pageblocks */
+static void split_large_buddy(struct page *buddy, int order)
+{
+	unsigned long pfn = page_to_pfn(buddy);
+	unsigned long end = pfn + (1 << order);
+	struct zone *zone = page_zone(buddy);
+
+	lockdep_assert_held(&zone->lock);
+	VM_WARN_ON_ONCE(PageBuddy(buddy));
+
+	while (pfn < end) {
+		int mt = get_pfnblock_migratetype(buddy, pfn);
+
+		__free_one_page(buddy, pfn, zone, pageblock_order, mt, FPI_NONE);
+		pfn += pageblock_nr_pages;
+		buddy = pfn_to_page(pfn);
+	}
+}
+
+/**
+ * move_freepages_block_isolate - move free pages in block for page isolation
+ * @zone: the zone
+ * @page: the pageblock page
+ * @migratetype: migratetype to set on the pageblock
+ *
+ * This is similar to move_freepages_block(), but handles the special
+ * case encountered in page isolation, where the block of interest
+ * might be part of a larger buddy spanning multiple pageblocks.
+ *
+ * Unlike the regular page allocator path, which moves pages while
+ * stealing buddies off the freelist, page isolation is interested in
+ * arbitrary pfn ranges that may have overlapping buddies on both ends.
+ *
+ * This function handles that. Straddling buddies are split into
+ * individual pageblocks. Only the block of interest is moved.
+ *
+ * Returns %true if pages could be moved, %false otherwise.
+ */
+bool move_freepages_block_isolate(struct zone *zone, struct page *page,
+				  int migratetype)
+{
+	unsigned long start_pfn, end_pfn, pfn;
+	int nr_moved, mt;
+
+	if (!prep_move_freepages_block(zone, page, &start_pfn, &end_pfn,
+				       NULL, NULL))
+		return false;
+
+	/* We're a tail block in a larger buddy */
+	pfn = find_large_buddy(start_pfn);
+	if (pfn != start_pfn) {
+		struct page *buddy = pfn_to_page(pfn);
+		int order = buddy_order(buddy);
+		int mt = get_pfnblock_migratetype(buddy, pfn);
+
+		if (!is_migrate_isolate(mt))
+			__mod_zone_freepage_state(zone, -(1UL << order), mt);
+		del_page_from_free_list(buddy, zone, order);
+		set_pageblock_migratetype(pfn_to_page(start_pfn), migratetype);
+		split_large_buddy(buddy, order);
+		return true;
+	}
+
+	/* We're the starting block of a larger buddy */
+	if (PageBuddy(page) && buddy_order(page) > pageblock_order) {
+		int mt = get_pfnblock_migratetype(page, pfn);
+		int order = buddy_order(page);
+
+		if (!is_migrate_isolate(mt))
+			__mod_zone_freepage_state(zone, -(1UL << order), mt);
+		del_page_from_free_list(page, zone, order);
+		set_pageblock_migratetype(page, migratetype);
+		split_large_buddy(page, order);
+		return true;
+	}
+
+	mt = get_pfnblock_migratetype(page, start_pfn);
+	nr_moved = move_freepages(zone, start_pfn, end_pfn, migratetype);
+	if (!is_migrate_isolate(mt))
+		__mod_zone_freepage_state(zone, -nr_moved, mt);
+	else if (!is_migrate_isolate(migratetype))
+		__mod_zone_freepage_state(zone, nr_moved, migratetype);
+	return true;
+}
+#endif /* CONFIG_MEMORY_ISOLATION */
+
 static void change_pageblock_range(struct page *pageblock_page,
 					int start_order, int migratetype)
 {
@@ -6318,7 +6371,6 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	int order;
 	int ret = 0;
 
 	struct compact_control cc = {
@@ -6391,29 +6443,7 @@ int alloc_contig_range(unsigned long start, unsigned long end,
 	 * We don't have to hold zone->lock here because the pages are
 	 * isolated thus they won't get removed from buddy.
 	 */
-
-	order = 0;
-	outer_start = start;
-	while (!PageBuddy(pfn_to_page(outer_start))) {
-		if (++order > MAX_ORDER) {
-			outer_start = start;
-			break;
-		}
-		outer_start &= ~0UL << order;
-	}
-
-	if (outer_start != start) {
-		order = buddy_order(pfn_to_page(outer_start));
-
-		/*
-		 * outer_start page could be small order buddy page and
-		 * it doesn't include start page. Adjust outer_start
-		 * in this case to report failed page properly
-		 * on tracepoint in test_pages_isolated()
-		 */
-		if (outer_start + (1UL << order) <= start)
-			outer_start = start;
-	}
+	outer_start = find_large_buddy(start);
 
 	/* Make sure the range is really isolated. */
 	if (test_pages_isolated(outer_start, end, 0)) {
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 27ee994a57d3..b4d53545496d 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -178,16 +178,10 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	unmovable = has_unmovable_pages(check_unmovable_start, check_unmovable_end,
 			migratetype, isol_flags);
 	if (!unmovable) {
-		int nr_pages;
-		int mt = get_pageblock_migratetype(page);
-
-		nr_pages = move_freepages_block(zone, page, MIGRATE_ISOLATE);
-		/* Block spans zone boundaries? */
-		if (nr_pages == -1) {
+		if (!move_freepages_block_isolate(zone, page, MIGRATE_ISOLATE)) {
 			spin_unlock_irqrestore(&zone->lock, flags);
 			return -EBUSY;
 		}
-		__mod_zone_freepage_state(zone, -nr_pages, mt);
 		zone->nr_isolate_pageblock++;
 		spin_unlock_irqrestore(&zone->lock, flags);
 		return 0;
@@ -254,13 +248,11 @@ static void unset_migratetype_isolate(struct page *page, int migratetype)
 	 * allocation.
 	 */
 	if (!isolated_page) {
-		int nr_pages = move_freepages_block(zone, page, migratetype);
 		/*
 		 * Isolating this block already succeeded, so this
 		 * should not fail on zone boundaries.
 		 */
-		WARN_ON_ONCE(nr_pages == -1);
-		__mod_zone_freepage_state(zone, nr_pages, migratetype);
+		WARN_ON_ONCE(!move_freepages_block_isolate(zone, page, migratetype));
 	} else {
 		set_pageblock_migratetype(page, migratetype);
 		__putback_isolated_page(page, order, migratetype);
@@ -373,26 +365,29 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 
 		VM_BUG_ON(!page);
 		pfn = page_to_pfn(page);
-		/*
-		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
-		 * free pages in [start_pfn, boundary_pfn), its head page will
-		 * always be in the range.
-		 */
+
 		if (PageBuddy(page)) {
 			int order = buddy_order(page);
 
-			if (pfn + (1UL << order) > boundary_pfn) {
-				/* free page changed before split, check it again */
-				if (split_free_page(page, order, boundary_pfn - pfn))
-					continue;
-			}
+			/* move_freepages_block_isolate() handled this */
+			VM_WARN_ON_ONCE(pfn + (1 << order) > boundary_pfn);
 
 			pfn += 1UL << order;
 			continue;
 		}
+
 		/*
-		 * migrate compound pages then let the free page handling code
-		 * above do the rest. If migration is not possible, just fail.
+		 * If a compound page is straddling our block, attempt
+		 * to migrate it out of the way.
+		 *
+		 * We don't have to worry about this creating a large
+		 * free page that straddles into our block: gigantic
+		 * pages are freed as order-0 chunks, and LRU pages
+		 * (currently) do not exceed pageblock_order.
+		 *
+		 * The block of interest has already been marked
+		 * MIGRATE_ISOLATE above, so when migration is done it
+		 * will free its pages onto the correct freelists.
 		 */
 		if (PageCompound(page)) {
 			struct page *head = compound_head(page);
@@ -403,16 +398,15 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				pfn = head_pfn + nr_pages;
 				continue;
 			}
+
+			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
 			/*
-			 * hugetlb, lru compound (THP), and movable compound pages
-			 * can be migrated. Otherwise, fail the isolation.
+			 * hugetlb, and movable compound pages can be
+			 * migrated. Otherwise, fail the isolation.
 			 */
-			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
-				int order;
-				unsigned long outer_pfn;
-				int page_mt = get_pageblock_migratetype(page);
-				bool isolate_page = !is_migrate_isolate_page(page);
+			if (PageHuge(page) || __PageMovable(page)) {
 				struct compact_control cc = {
 					.nr_migratepages = 0,
 					.order = -1,
@@ -425,52 +419,12 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				};
 				INIT_LIST_HEAD(&cc.migratepages);
 
-				/*
-				 * XXX: mark the page as MIGRATE_ISOLATE so that
-				 * no one else can grab the freed page after migration.
-				 * Ideally, the page should be freed as two separate
-				 * pages to be added into separate migratetype free
-				 * lists.
-				 */
-				if (isolate_page) {
-					ret = set_migratetype_isolate(page, page_mt,
-						flags, head_pfn, head_pfn + nr_pages);
-					if (ret)
-						goto failed;
-				}
-
 				ret = __alloc_contig_migrate_range(&cc, head_pfn,
 							head_pfn + nr_pages);
-
-				/*
-				 * restore the page's migratetype so that it can
-				 * be split into separate migratetype free lists
-				 * later.
-				 */
-				if (isolate_page)
-					unset_migratetype_isolate(page, page_mt);
-
 				if (ret)
 					goto failed;
-				/*
-				 * reset pfn to the head of the free page, so
-				 * that the free page handling code above can split
-				 * the free page to the right migratetype list.
-				 *
-				 * head_pfn is not used here as a hugetlb page order
-				 * can be bigger than MAX_ORDER, but after it is
-				 * freed, the free page order is not. Use pfn within
-				 * the range to find the head of the free page.
-				 */
-				order = 0;
-				outer_pfn = pfn;
-				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					/* stop if we cannot find the free page */
-					if (++order > MAX_ORDER)
-						goto failed;
-					outer_pfn &= ~0UL << order;
-				}
-				pfn = outer_pfn;
+
+				pfn = head_pfn + nr_pages;
 				continue;
 			} else
 #endif
-- 
2.42.0

