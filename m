Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76207C421A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 23:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343946AbjJJVMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 17:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbjJJVMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 17:12:05 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C7F98
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:02 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-77386822cfbso412911885a.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 14:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696972321; x=1697577121; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HC+Qu78EEjL4KMzF8E1/E4mWpZo9bo+hSG7Ou0hFeX8=;
        b=12Q/oczpdbWVu6GpaxF1hyuTXi/x5Ekq53LXboztAfZc+MDh3uou/XURTG3KAQ+9nt
         gUazC3stGMCNB3OPQRnJYrPGy8V7CaSox/QLdmsqaESOsmbSEEcv19oa7Iz8GgMugGE+
         pM2xFOer4zLCNzLBpOeI/0+owaiTgN5oQAsb7aO9YaI8VjyOhlEBEJaBy8J2Xv8oZrql
         yE1fh7HxceRs5UykNtTGyLwOrQlKkKl1Xqy6x335vEvrDVmJhKAuhaJae3JXvmOY0qkO
         azAX4OLp0xamvckGLNCVONf6FETcmCWJ0//moXCOlI309Ey7nqY+YWCTUKRZ75Q0OzsA
         lJ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696972321; x=1697577121;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC+Qu78EEjL4KMzF8E1/E4mWpZo9bo+hSG7Ou0hFeX8=;
        b=mTCMjdu+wRWHk5wsuUsM2OGZ/umXyMydE6PxCkCM3SrHLwhcAFPd97tqTwMg19JxnX
         xeGAfz0gI2jSgkooFJRf4NOkZS4D+dxURa0iMj+10sbSYphuSnGVqMMuyccLFC7xI7mE
         ZeXPD7XijPBR1c7rgyLaezT9JTrNW515GCf3uz/t8e8enOQMVfhF6qcfAitT7P4ixQx1
         Y53fFMN16o5eqwTTEuFkQwKpWJV6KctrjvVcQI00UCSLp3bhvihP1v+SdtH2Z930MsiX
         +VkjP6SGzV0D180glyymmvlciOgzSZ7ftTbh863WT3HcjYdOAtlve4gWAedODxAZXeSA
         V2xA==
X-Gm-Message-State: AOJu0YzzVon+W/BA1srn2h7PseMq5uOLEcvMWjGZBVh51h3bz6LCiYrb
        yLqQ+d6goWozVuZq7AoN0o0oXQ==
X-Google-Smtp-Source: AGHT+IExnLFXiLD1bsUeG9yYjXMxJ0iw/TVc3aNNBZALtevcf2FAZXGtfGrOEOjHIJ+VIeYIlTL/mg==
X-Received: by 2002:a05:620a:7f9:b0:76e:e619:1f95 with SMTP id k25-20020a05620a07f900b0076ee6191f95mr15298836qkk.78.1696972321554;
        Tue, 10 Oct 2023 14:12:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:66a6])
        by smtp.gmail.com with ESMTPSA id b14-20020a05620a118e00b00773f008da40sm4633646qkk.125.2023.10.10.14.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 14:12:01 -0700 (PDT)
Date:   Tue, 10 Oct 2023 17:12:00 -0400
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
Message-ID: <20231010211200.GA129823@cmpxchg.org>
References: <20230920134811.GB124289@cmpxchg.org>
 <20230920160400.GC124289@cmpxchg.org>
 <762CA634-053A-41DD-8ED7-895374640858@nvidia.com>
 <D4F59724-61EB-4DA5-94DF-59E79F0F1FB3@nvidia.com>
 <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Mon, Oct 02, 2023 at 10:26:44PM -0400, Zi Yan wrote:
> On 27 Sep 2023, at 22:51, Zi Yan wrote:
> I attached my revised patch 2 and 3 (with all the suggestions above).

Thanks! It took me a bit to read through them. It's a tricky codebase!

Some comments below.

> From 1c8f99cff5f469ee89adc33e9c9499254cad13f2 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Mon, 25 Sep 2023 16:27:14 -0400
> Subject: [PATCH v2 1/2] mm: set migratetype after free pages are moved between
>  free lists.
> 
> This avoids changing migratetype after move_freepages() or
> move_freepages_block(), which is error prone. It also prepares for upcoming
> changes to fix move_freepages() not moving free pages partially in the
> range.
> 
> Signed-off-by: Zi Yan <ziy@nvidia.com>

This is great and indeed makes the callsites much simpler. Thanks,
I'll fold this into the series.

> @@ -1597,9 +1615,29 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
>  			  unsigned long end_pfn, int old_mt, int new_mt)
>  {
>  	struct page *page;
> -	unsigned long pfn;
> +	unsigned long pfn, pfn2;
>  	unsigned int order;
>  	int pages_moved = 0;
> +	unsigned long mt_changed_pfn = start_pfn - pageblock_nr_pages;
> +	unsigned long new_start_pfn = get_freepage_start_pfn(start_pfn);
> +
> +	/* split at start_pfn if it is in the middle of a free page */
> +	if (new_start_pfn != start_pfn && PageBuddy(pfn_to_page(new_start_pfn))) {
> +		struct page *new_page = pfn_to_page(new_start_pfn);
> +		int new_page_order = buddy_order(new_page);

get_freepage_start_pfn() returns start_pfn if it didn't find a large
buddy, so the buddy check shouldn't be necessary, right?

> +		if (new_start_pfn + (1 << new_page_order) > start_pfn) {

This *should* be implied according to the comments on
get_freepage_start_pfn(), but it currently isn't. Doing so would help
here, and seemingly also in alloc_contig_range().

How about this version of get_freepage_start_pfn()?

/*
 * Scan the range before this pfn for a buddy that straddles it
 */
static unsigned long find_straddling_buddy(unsigned long start_pfn)
{
	int order = 0;
	struct page *page;
	unsigned long pfn = start_pfn;

	while (!PageBuddy(page = pfn_to_page(pfn))) {
		/* Nothing found */
		if (++order > MAX_ORDER)
			return start_pfn;
		pfn &= ~0UL << order;
	}

	/*
	 * Found a preceding buddy, but does it straddle?
	 */
	if (pfn + (1 << buddy_order(page)) > start_pfn)
		return pfn;

	/* Nothing found */
	return start_pfn;
}

> @@ -1614,10 +1652,43 @@ static int move_freepages(struct zone *zone, unsigned long start_pfn,
>  
>  		order = buddy_order(page);
>  		move_to_free_list(page, zone, order, old_mt, new_mt);
> +		/*
> +		 * set page migratetype 1) only after we move all free pages in
> +		 * one pageblock and 2) for all pageblocks within the page.
> +		 *
> +		 * for 1), since move_to_free_list() checks page migratetype with
> +		 * old_mt and changing one page migratetype affects all pages
> +		 * within the same pageblock, if we are moving more than
> +		 * one free pages in the same pageblock, setting migratetype
> +		 * right after first move_to_free_list() triggers the warning
> +		 * in the following move_to_free_list().
> +		 *
> +		 * for 2), when a free page order is greater than pageblock_order,
> +		 * all pageblocks within the free page need to be changed after
> +		 * move_to_free_list().

I think this can be somewhat simplified.

There are two assumptions we can make. Buddies always consist of 2^n
pages. And buddies and pageblocks are naturally aligned. This means
that if this pageblock has the start of a buddy that straddles into
the next pageblock(s), it must be the first page in the block. That in
turn means we can move the handling before the loop.

If we split first, it also makes the loop a little simpler because we
know that any buddies that start inside this block cannot extend
beyond it (due to the alignment). The loop how it was originally
written can remain untouched.

> +		 */
> +		if (pfn + (1 << order) > pageblock_end_pfn(pfn)) {
> +			for (pfn2 = pfn;
> +			     pfn2 < min_t(unsigned long,
> +					  pfn + (1 << order),
> +					  end_pfn + 1);
> +			     pfn2 += pageblock_nr_pages) {
> +				set_pageblock_migratetype(pfn_to_page(pfn2),
> +							  new_mt);
> +				mt_changed_pfn = pfn2;

Hm, this seems to assume that start_pfn to end_pfn can be more than
one block. Why is that? This function is only used on single blocks.

> +			}
> +			/* split the free page if it goes beyond the specified range */
> +			if (pfn + (1 << order) > (end_pfn + 1))
> +				split_free_page(page, order, end_pfn + 1 - pfn);
> +		}
>  		pfn += 1 << order;
>  		pages_moved += 1 << order;
>  	}
> -	set_pageblock_migratetype(pfn_to_page(start_pfn), new_mt);
> +	/* set migratetype for the remaining pageblocks */
> +	for (pfn2 = mt_changed_pfn + pageblock_nr_pages;
> +	     pfn2 <= end_pfn;
> +	     pfn2 += pageblock_nr_pages)
> +		set_pageblock_migratetype(pfn_to_page(pfn2), new_mt);

If I rework the code on the above, I'm arriving at the following:

static int move_freepages(struct zone *zone, unsigned long start_pfn,
			  unsigned long end_pfn, int old_mt, int new_mt)
{
	struct page *start_page = pfn_to_page(start_pfn);
	int pages_moved = 0;
	unsigned long pfn;

	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 != end_pfn);

	/*
	 * A free page may be comprised of 2^n blocks, which means our
	 * block of interest could be head or tail in such a page.
	 *
	 * If we're a tail, update the type of our block, then split
	 * the page into pageblocks. The splitting will do the leg
	 * work of sorting the blocks into the right freelists.
	 *
	 * If we're a head, split the page into pageblocks first. This
	 * ensures the migratetypes still match up during the freelist
	 * removal. Then do the regular scan for buddies in the block
	 * of interest, which will handle the rest.
	 *
	 * In theory, we could try to preserve 2^1 and larger blocks
	 * that lie outside our range. In practice, MAX_ORDER is
	 * usually one or two pageblocks anyway, so don't bother.
	 *
	 * Note that this only applies to page isolation, which calls
	 * this on random blocks in the pfn range! When we move stuff
	 * from inside the page allocator, the pages are coming off
	 * the freelist (can't be tail) and multi-block pages are
	 * handled directly in the stealing code (can't be a head).
	 */

	/* We're a tail */
	pfn = find_straddling_buddy(start_pfn);
	if (pfn != start_pfn) {
		struct page *free_page = pfn_to_page(pfn);

		set_pageblock_migratetype(start_page, new_mt);
		split_free_page(free_page, buddy_order(free_page),
				pageblock_nr_pages);
		return pageblock_nr_pages;
	}

	/* We're a head */
	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order)
		split_free_page(start_page, buddy_order(start_page),
				pageblock_nr_pages);

	/* Move buddies within the block */
	while (pfn <= end_pfn) {
		struct page *page = pfn_to_page(pfn);
		int order, nr_pages;

		if (!PageBuddy(page)) {
			pfn++;
			continue;
		}

		/* Make sure we are not inadvertently changing nodes */
		VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
		VM_BUG_ON_PAGE(page_zone(page) != zone, page);

		order = buddy_order(page);
		nr_pages = 1 << order;

		move_to_free_list(page, zone, order, old_mt, new_mt);

		pfn += nr_pages;
		pages_moved += nr_pages;
	}

	set_pageblock_migratetype(start_page, new_mt);

	return pages_moved;
}

Does this look reasonable to you?

Note that the page isolation specific stuff comes first. If this code
holds up, we should be able to move it to page-isolation.c and keep it
out of the regular allocator path.

Thanks!
