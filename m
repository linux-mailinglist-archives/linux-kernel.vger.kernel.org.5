Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1835B7CB4D6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 22:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbjJPUjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 16:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233338AbjJPUjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 16:39:42 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5757DA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:39:37 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id d75a77b69052e-418201cb9e9so34746241cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 13:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697488776; x=1698093576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5gvhAK4y1mW18aa/4bI9UW2L7Ts1L6F0sYJiOtaB/J8=;
        b=vXCNVc/SukqOzM5nNI9J6zfaeH4leeH+XX9AR9Z7TuYek0d4kWrqMNMLnUYabppSeO
         1DEBvh7CZArAxTb9qso8SedOagH9AJyaz8+f6W0NCA5wfmWsoa8dcDJCchJvR4PnQUET
         ERHrZNPjnUs2RyL0E5if9sry7ZoKKcvkptL5lxJpIXbaRg2OSpDbScJiIm6A9baLqhK1
         jkTlws/DtdRwMot2vT0S6mEQGAoHyoe7nyv/eJWBpWG68bkFCBniWg+B/q0LYqAzGQUr
         ZAbp4uW55WbWy5PW3dMOIkDMQtJzaUa27sZCmAPEJBlYisjTySZ409bZkZiG/TaadNEM
         DeWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697488776; x=1698093576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5gvhAK4y1mW18aa/4bI9UW2L7Ts1L6F0sYJiOtaB/J8=;
        b=CrbL++r86isCdBSYb6soHtHIEJlajSc0DVg529nx9jRMk2sCp2cVuBUrCRAJsHVrW4
         JNLdkbFCrQ2cwPI5UEcD7jnhPPDnF35gPUBz+gJAquGpzRZUmHQSevd4xjl9dg7lyhqr
         l509kWBYmKV41a//M7fpWbLcG7y+NH/luUhe8XFTeOxnkfoQ/3oTn7NtJ9SkPk+IIUJl
         XP5ha2V4+V95s+mNhYd0fs+nLjiJAfmXFASbeGiVptP5Z75J3s5mnMg6JKUlOByBKLbi
         qrMG34WE072bqxvF5b6vfyxZLml6yqrGVAk/a9PsHNQV2BA16jInqU/niT5kkjDM3l5I
         pbVg==
X-Gm-Message-State: AOJu0YyMfl7wQf8clRT0ZDOYuZi4SRMYg9yqeMXO+XirlcC9ychO/1yf
        Pg+pomRNRNcqhXWjBnfx/AZxHw==
X-Google-Smtp-Source: AGHT+IFa+rOelSG40PYiJRIPR5GpI96EyYgFl6gHHNFjZnQauJ24jCGfD0dX9bRvSRZHSRCbCDJLtw==
X-Received: by 2002:ac8:5bd2:0:b0:412:2d6d:932a with SMTP id b18-20020ac85bd2000000b004122d6d932amr505562qtb.56.1697488776376;
        Mon, 16 Oct 2023 13:39:36 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id j13-20020ac8664d000000b004182037f655sm43221qtp.14.2023.10.16.13.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 13:39:35 -0700 (PDT)
Date:   Mon, 16 Oct 2023 16:39:35 -0400
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
Message-ID: <20231016203935.GB1042487@cmpxchg.org>
References: <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
 <20231016143717.GH470544@cmpxchg.org>
 <5B61B70F-E85D-4E6F-8856-17A90B899F98@nvidia.com>
 <20231016185113.GI470544@cmpxchg.org>
 <6F2C52B6-2031-4694-A124-0DFDE9F88E88@nvidia.com>
 <20231016202629.GA1042487@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016202629.GA1042487@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 04:26:30PM -0400, Johannes Weiner wrote:
> On Mon, Oct 16, 2023 at 03:49:49PM -0400, Zi Yan wrote:
> > On 16 Oct 2023, at 14:51, Johannes Weiner wrote:
> > 
> > > On Mon, Oct 16, 2023 at 11:00:33AM -0400, Zi Yan wrote:
> > >> On 16 Oct 2023, at 10:37, Johannes Weiner wrote:
> > >>
> > >>> On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
> > >>>>> The attached patch has all the suggested changes, let me know how it
> > >>>>> looks to you. Thanks.
> > >>>>
> > >>>> The one I sent has free page accounting issues. The attached one fixes them.
> > >>>
> > >>> Do you still have the warnings? I wonder what went wrong.
> > >>
> > >> No warnings. But something with the code:
> > >>
> > >> 1. in your version, split_free_page() is called without changing any pageblock
> > >> migratetypes, then split_free_page() is just a no-op, since the page is
> > >> just deleted from the free list, then freed via different orders. Buddy allocator
> > >> will merge them back.
> > >
> > > Hm not quite.
> > >
> > > If it's the tail block of a buddy, I update its type before
> > > splitting. The splitting loop looks up the type of each block for
> > > sorting it onto freelists.
> > >
> > > If it's the head block, yes I split it first according to its old
> > > type. But then I let it fall through to scanning the block, which will
> > > find that buddy, update its type and move it.
> > 
> > That is the issue, since split_free_page() assumes the pageblocks of
> > that free page have different types. It basically just free the page
> > with different small orders summed up to the original free page order.
> > If all pageblocks of the free page have the same migratetype, __free_one_page()
> > will merge these small order pages back to the original order free page.
> 
> duh, of course, you're right. Thanks for patiently explaining this.
> 
> > >> 2. in my version, I set pageblock migratetype to new_mt before split_free_page(),
> > >> but it causes free page accounting issues, since in the case of head, free pages
> > >> are deleted from new_mt when they are in old_mt free list and the accounting
> > >> decreases new_mt free page number instead of old_mt one.
> > >
> > > Right, that makes sense.
> > >
> > >> Basically, split_free_page() is awkward as it relies on preset migratetypes,
> > >> which changes migratetypes without deleting the free pages from the list first.
> > >> That is why I came up with the new split_free_page() below.
> > >
> > > Yeah, the in-between thing is bad. Either it fixes the migratetype
> > > before deletion, or it doesn't do the deletion. I'm thinking it would
> > > be simpler to move the deletion out instead.
> > 
> > Yes and no. After deletion, a free page no longer has PageBuddy set and
> > has buddy_order information cleared. Either we reset PageBuddy and order
> > to the deleted free page, or split_free_page() needs to be changed to
> > accept pages without the information (basically remove the PageBuddy
> > and order check code).
> 
> Good point, that requires extra care.
> 
> It's correct in the code now, but it deserves a comment, especially
> because of the "buddy" naming in the new split function.
> 
> > >> Hmm, if CONFIG_ARCH_FORCE_MAX_ORDER can make a buddy have more than one
> > >> pageblock and in turn makes an in-use page have more than one pageblock,
> > >> we will have problems. Since in isolate_single_pageblock(), an in-use page
> > >> can have part of its pageblock set to a different migratetype and be freed,
> > >> causing the free page with unmatched migratetypes. We might need to
> > >> free pages at pageblock_order if their orders are bigger than pageblock_order.
> > >
> > > Is this a practical issue? You mentioned that right now only gigantic
> > > pages can be larger than a pageblock, and those are freed in order-0
> > > chunks.
> > 
> > Only if the system allocates a page (non hugetlb pages) with >pageblock_order
> > and frees it with the same order. I just do not know if such pages exist on
> > other arch than x86. Maybe I just think too much.
> 
> Hm, I removed LRU pages from the handling (and added the warning) but
> I left in PageMovable(). The only users are z3fold, zsmalloc and
> memory ballooning. AFAICS none of them can be bigger than a pageblock.
> Let me remove that and add a warning for that case as well.
> 
> This way, we only attempt to migrate hugetlb, where we know the free
> path - and get warnings for anything else that's larger than expected.
> 
> This seems like the safest option. On the off chance that there is a
> regression, it won't jeopardize anybody's systems, while the warning
> provides all the information we need to debug what's going on.

This delta on top?

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b5292ad9860c..0da7c61af37e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1628,7 +1628,7 @@ static int move_freepages_block(struct zone *zone, struct page *page,
 }
 
 #ifdef CONFIG_MEMORY_ISOLATION
-/* Look for a multi-block buddy that straddles start_pfn */
+/* Look for a buddy that straddles start_pfn */
 static unsigned long find_large_buddy(unsigned long start_pfn)
 {
 	int order = 0;
@@ -1652,7 +1652,7 @@ static unsigned long find_large_buddy(unsigned long start_pfn)
 	return start_pfn;
 }
 
-/* Split a multi-block buddy into its individual pageblocks */
+/* Split a multi-block free page into its individual pageblocks */
 static void split_large_buddy(struct zone *zone, struct page *page,
 			      unsigned long pfn, int order)
 {
@@ -1661,6 +1661,9 @@ static void split_large_buddy(struct zone *zone, struct page *page,
 	VM_WARN_ON_ONCE(order < pageblock_order);
 	VM_WARN_ON_ONCE(pfn & (pageblock_nr_pages - 1));
 
+	/* Caller removed page from freelist, buddy info cleared! */
+	VM_WARN_ON_ONCE(PageBuddy(page));
+
 	while (pfn != end_pfn) {
 		int mt = get_pfnblock_migratetype(page, pfn);
 
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b4d53545496d..c8b3c0699683 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -399,14 +399,8 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 				continue;
 			}
 
-			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
-
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA
-			/*
-			 * hugetlb, and movable compound pages can be
-			 * migrated. Otherwise, fail the isolation.
-			 */
-			if (PageHuge(page) || __PageMovable(page)) {
+			if (PageHuge(page)) {
 				struct compact_control cc = {
 					.nr_migratepages = 0,
 					.order = -1,
@@ -426,9 +420,19 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
 
 				pfn = head_pfn + nr_pages;
 				continue;
-			} else
+			}
+
+			/*
+			 * These pages are movable too, but they're
+			 * not expected to exceed pageblock_order.
+			 *
+			 * Let us know when they do, so we can add
+			 * proper free and split handling for them.
+			 */
+			VM_WARN_ON_ONCE_PAGE(PageLRU(page), page);
+			VM_WARN_ON_ONCE_PAGE(__PageMovable(page), page);
 #endif
-				goto failed;
+			goto failed;
 		}
 
 		pfn++;
