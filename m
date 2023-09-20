Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D689F7A8938
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235498AbjITQEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjITQEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:04:09 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1B83C2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:04:02 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 6a1803df08f44-6564515ec4eso25744816d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1695225842; x=1695830642; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CTf4+1qMO9RJAdxQkVKBmTQcbxilq1N2AJD6yiobRZU=;
        b=rGXYJOLOO+PJn9eR4SufydPJ0zpYTMBcm4hm5wgQX/pcowl4A4Pt9dVTwBmS5MJfUI
         hoNaVrQEKFQ8HEfg0t2rYl4891PowmGooNsXCgR6aqtHLf1RgW+SLPEH/csz6Ad7r6+s
         sFXpg851cojfG0yTtquxW9lIcaIka+thwyMUKINdyEYs0aplzQwqq18vsrkQb4BFv+jg
         IoBIybVwjQbmuCRZAc+9gS6al0VZwQ5PekYfOMZCPCq+uQR7TG33HlJQVDYmwNAbEnwp
         rUScz6KC+0+jRjJ8B1EpMZxpwsT2u4pFXgo8FRUKS3uR7lVX+rw3hm1X4S+ocA+ebzZZ
         tvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695225842; x=1695830642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CTf4+1qMO9RJAdxQkVKBmTQcbxilq1N2AJD6yiobRZU=;
        b=HO8KwNOYFXIDDjP6A59tCTRknHW0LPitvh5WIqOR/Q9k3wR3GOG3f+MZMs1UcZZcpC
         1b3m5iWAAwFxd6AIK7WJwM3prViTNLakMOIar8SVMHS39md/FWvyeHxk89crY1h786PZ
         ZFyMlFGgOFTuE3XAJq7jM4H9BorZYdEfWpfYyub7CKHi2eEaG0c9lq8XX8HKI97g2lG3
         /vmkOn+BMDxD9dpjOzvRB1erjxBlpqfO23vSpYUV8tywYENCsR0mCFbVscuLwneb7fHy
         t4nVq46xnq0RvnO4iowmDkw1sm16xhui7r4iruJszjD5rUpjGGupIaElDkYV+eB0mZqm
         rxtg==
X-Gm-Message-State: AOJu0YwFMoglX8Vbj6v2Q7IMH40S/N8IZR/Urzjh1uLDU94zXGC3R+cP
        jsC5sTko07sQc11Iermnrpnl4w==
X-Google-Smtp-Source: AGHT+IHHXbHgASQaS929AeKMlhY2inMZSrvpLyMfiPOrCVe6y/8IW4Jal46dUXMGYNyJabzlAN+kHQ==
X-Received: by 2002:a0c:e8ce:0:b0:655:88e9:1b09 with SMTP id m14-20020a0ce8ce000000b0065588e91b09mr2919676qvo.18.1695225841455;
        Wed, 20 Sep 2023 09:04:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:d7e0])
        by smtp.gmail.com with ESMTPSA id d8-20020a0cfe88000000b0064f4258184csm5306520qvs.53.2023.09.20.09.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 09:04:01 -0700 (PDT)
Date:   Wed, 20 Sep 2023 12:04:00 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Zi Yan <ziy@nvidia.com>, Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 0/6] mm: page_alloc: freelist migratetype hygiene
Message-ID: <20230920160400.GC124289@cmpxchg.org>
References: <a88b7339-beab-37c6-7d32-0292b325916d@suse.cz>
 <20230918145204.GB16104@cmpxchg.org>
 <20230918174037.GA112714@monkey>
 <20230919064914.GA124289@cmpxchg.org>
 <20230919184731.GC112714@monkey>
 <C416A861-44D3-46E7-B756-63DA3731FC1E@nvidia.com>
 <20230920003239.GD112714@monkey>
 <149ACAE8-D3E4-4009-828A-D3AC881FFB9C@nvidia.com>
 <bc4bd049-1e29-0f23-cca6-493abb5e774f@suse.cz>
 <20230920134811.GB124289@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230920134811.GB124289@cmpxchg.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 09:48:12AM -0400, Johannes Weiner wrote:
> On Wed, Sep 20, 2023 at 08:07:53AM +0200, Vlastimil Babka wrote:
> > On 9/20/23 03:38, Zi Yan wrote:
> > > On 19 Sep 2023, at 20:32, Mike Kravetz wrote:
> > > 
> > >> On 09/19/23 16:57, Zi Yan wrote:
> > >>> On 19 Sep 2023, at 14:47, Mike Kravetz wrote:
> > >>>
> > >>>> 	--- a/mm/page_alloc.c
> > >>>> 	+++ b/mm/page_alloc.c
> > >>>> 	@@ -1651,8 +1651,13 @@ static bool prep_move_freepages_block(struct zone *zone, struct page *page,
> > >>>>  		end = pageblock_end_pfn(pfn) - 1;
> > >>>>
> > >>>>  		/* Do not cross zone boundaries */
> > >>>> 	+#if 0
> > >>>>  		if (!zone_spans_pfn(zone, start))
> > >>>> 			start = zone->zone_start_pfn;
> > >>>> 	+#else
> > >>>> 	+	if (!zone_spans_pfn(zone, start))
> > >>>> 	+		start = pfn;
> > >>>> 	+#endif
> > >>>> 	 	if (!zone_spans_pfn(zone, end))
> > >>>> 	 		return false;
> > >>>> 	I can still trigger warnings.
> > >>>
> > >>> OK. One thing to note is that the page type in the warning changed from
> > >>> 5 (MIGRATE_ISOLATE) to 0 (MIGRATE_UNMOVABLE) with my suggested change.
> > >>>
> > >>
> > >> Just to be really clear,
> > >> - the 5 (MIGRATE_ISOLATE) warning was from the __alloc_pages call path.
> > >> - the 0 (MIGRATE_UNMOVABLE) as above was from the alloc_contig_range call
> > >>   path WITHOUT your change.
> > >>
> > >> I am guessing the difference here has more to do with the allocation path?
> > >>
> > >> I went back and reran focusing on the specific migrate type.
> > >> Without your patch, and coming from the alloc_contig_range call path,
> > >> I got two warnings of 'page type is 0, passed migratetype is 1' as above.
> > >> With your patch I got one 'page type is 0, passed migratetype is 1'
> > >> warning and one 'page type is 1, passed migratetype is 0' warning.
> > >>
> > >> I could be wrong, but I do not think your patch changes things.
> > > 
> > > Got it. Thanks for the clarification.
> > >>
> > >>>>
> > >>>> One idea about recreating the issue is that it may have to do with size
> > >>>> of my VM (16G) and the requested allocation sizes 4G.  However, I tried
> > >>>> to really stress the allocations by increasing the number of hugetlb
> > >>>> pages requested and that did not help.  I also noticed that I only seem
> > >>>> to get two warnings and then they stop, even if I continue to run the
> > >>>> script.
> > >>>>
> > >>>> Zi asked about my config, so it is attached.
> > >>>
> > >>> With your config, I still have no luck reproducing the issue. I will keep
> > >>> trying. Thanks.
> > >>>
> > >>
> > >> Perhaps try running both scripts in parallel?
> > > 
> > > Yes. It seems to do the trick.
> > > 
> > >> Adjust the number of hugetlb pages allocated to equal 25% of memory?
> > > 
> > > I am able to reproduce it with the script below:
> > > 
> > > while true; do
> > >  echo 4 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages&
> > >  echo 2048 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages&
> > >  wait
> > >  echo 0 > /sys/kernel/mm/hugepages/hugepages-2048kB/nr_hugepages
> > >  echo 0 > /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages
> > > done
> > > 
> > > I will look into the issue.
> 
> Nice!
> 
> I managed to reproduce it ONCE, triggering it not even a second after
> starting the script. But I can't seem to do it twice, even after
> several reboots and letting it run for minutes.

I managed to reproduce it reliably by cutting the nr_hugepages
parameters respectively in half.

The one that triggers for me is always MIGRATE_ISOLATE. With some
printk-tracing, the scenario seems to be this:

#0                                                   #1
start_isolate_page_range()
  isolate_single_pageblock()
    set_migratetype_isolate(tail)
      lock zone->lock
      move_freepages_block(tail) // nop
      set_pageblock_migratetype(tail)
      unlock zone->lock
                                                     del_page_from_freelist(head)
                                                     expand(head, head_mt)
                                                       WARN(head_mt != tail_mt)
    start_pfn = ALIGN_DOWN(MAX_ORDER_NR_PAGES)
    for (pfn = start_pfn, pfn < end_pfn)
      if (PageBuddy())
        split_free_page(head)

IOW, we update a pageblock that isn't MAX_ORDER aligned, then drop the
lock. The move_freepages_block() does nothing because the PageBuddy()
is set on the pageblock to the left. Once we drop the lock, the buddy
gets allocated and the expand() puts things on the wrong list. The
splitting code that handles MAX_ORDER blocks runs *after* the tail
type is set and the lock has been dropped, so it's too late.

I think this would work fine if we always set MIGRATE_ISOLATE in a
linear fashion, with start and end aligned to MAX_ORDER. Then we also
wouldn't have to split things.

There are two reasons this doesn't happen today:

1. The isolation range is rounded to pageblocks, not MAX_ORDER. In
   this test case they always seem aligned, but it's not
   guaranteed. However,

2. start_isolate_page_range() explicitly breaks ordering by doing the
   last block in the range before the center. It's that last block
   that triggers the race with __rmqueue_smallest -> expand() for me.

With the below patch I can no longer reproduce the issue:

---

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index b5c7a9d21257..b7c8730bf0e2 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -538,8 +538,8 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	unsigned long pfn;
 	struct page *page;
 	/* isolation is done at page block granularity */
-	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
-	unsigned long isolate_end = pageblock_align(end_pfn);
+	unsigned long isolate_start = ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES);
+	unsigned long isolate_end = ALIGN(end_pfn, MAX_ORDER_NR_PAGES);
 	int ret;
 	bool skip_isolation = false;
 
@@ -549,17 +549,6 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 	if (ret)
 		return ret;
 
-	if (isolate_start == isolate_end - pageblock_nr_pages)
-		skip_isolation = true;
-
-	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
-	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
-			skip_isolation, migratetype);
-	if (ret) {
-		unset_migratetype_isolate(pfn_to_page(isolate_start), migratetype);
-		return ret;
-	}
-
 	/* skip isolated pageblocks at the beginning and end */
 	for (pfn = isolate_start + pageblock_nr_pages;
 	     pfn < isolate_end - pageblock_nr_pages;
@@ -568,12 +557,21 @@ int start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(isolate_start, pfn, migratetype);
-			unset_migratetype_isolate(
-				pfn_to_page(isolate_end - pageblock_nr_pages),
-				migratetype);
 			return -EBUSY;
 		}
 	}
+
+	if (isolate_start == isolate_end - pageblock_nr_pages)
+		skip_isolation = true;
+
+	/* isolate [isolate_end - pageblock_nr_pages, isolate_end) pageblock */
+	ret = isolate_single_pageblock(isolate_end, flags, gfp_flags, true,
+			skip_isolation, migratetype);
+	if (ret) {
+		undo_isolate_page_range(isolate_start, pfn, migratetype);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -591,8 +589,8 @@ void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
 {
 	unsigned long pfn;
 	struct page *page;
-	unsigned long isolate_start = pageblock_start_pfn(start_pfn);
-	unsigned long isolate_end = pageblock_align(end_pfn);
+	unsigned long isolate_start = ALIGN_DOWN(start_pfn, MAX_ORDER_NR_PAGES);
+	unsigned long isolate_end = ALIGN(end_pfn, MAX_ORDER_NR_PAGES);
 
 	for (pfn = isolate_start;
 	     pfn < isolate_end;
