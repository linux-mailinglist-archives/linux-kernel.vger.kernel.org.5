Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E487CABA4
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjJPOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 10:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJPOhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 10:37:21 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76C383
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:37:19 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77410032cedso328266485a.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 07:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1697467039; x=1698071839; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9086aHxk+q98ln5v/CxlAgOpEVSgUBB3h4FBEcrQxlE=;
        b=MsaBdOtbtrIV9/OcDf8If5tUSEsJ/05fCGXWjeHFHcCXM+AMxbTzOoIOb6HsjVAfHT
         gPHcvHlGayQWZoj2cCyIPOu6CxaRTLULNz6jFYHqQkGL3qzH0nqfN94yL4/zzZLLb7j7
         TDWXk2RE3qr5xFfyh3oWQRAy08azXKmUPohBqbm7MLB9nHzzHWkUniB+8V//ViA69gDt
         85CWNFVEW+P0rhKfyh9FxqKnCmTZLrB2HtL94AUmKcePk8bDIGAJ5MZXwC7508WI4jbu
         HQF7W/Bz+pA+z8D4bh2h5GZm5KnYRI47RXq9qkGh+nxukPCUId1JUcqhnqZQZSvC4tdc
         WVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697467039; x=1698071839;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9086aHxk+q98ln5v/CxlAgOpEVSgUBB3h4FBEcrQxlE=;
        b=Hxu2mADtAecS/Bj/lIQFzpYlWou8uOlb4av/EaGNNn7nRhU4PH6ND59FiJ2jY4n3Ge
         6aPyZnkRtPjkrzKjzaH2PeeDEo94j9UT8yLAGZ6zeW0DNgIo1EnJQG0JQY4J3ALPMzIM
         Dhz6Coe0ojAsZxxT1jSyVD7kAwHvYQqFJoVZRK61N4DqHPHh2nwLmUmZReGNMIaUGNnT
         ywSROSbKmNLZRlyHiwrfXqfSYaw7WLGK5Idqj8jf6eoQnws5OBmOPiMPF3fgCDPbq6v7
         WFz8XeB0vbwfR7He/M+dwFRi0+0OnaYFAOwov0uPpmMARJ2Re+MtbSIU0h6W/kkMYpe4
         iCbg==
X-Gm-Message-State: AOJu0Yy0N8Vyes0SCEADRFU0+Lh3oS2mub0PXH4k81wa8NH0WWt1kaYT
        p/t0ns4gwXnKqV++NlTzBwHPzA==
X-Google-Smtp-Source: AGHT+IHbLWIfMwgeRmDEoOofgQLlwb+6o9ppfCU8KzNHIeshlN8uIRlV34gZBFnnCM3GpWwilCEqYg==
X-Received: by 2002:a05:620a:d8a:b0:775:7f6e:1af7 with SMTP id q10-20020a05620a0d8a00b007757f6e1af7mr40917796qkl.24.1697467038804;
        Mon, 16 Oct 2023 07:37:18 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id 5-20020a05620a06c500b0076dacd14484sm3017046qky.83.2023.10.16.07.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 07:37:18 -0700 (PDT)
Date:   Mon, 16 Oct 2023 10:37:17 -0400
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
Message-ID: <20231016143717.GH470544@cmpxchg.org>
References: <505e7f55-f63a-b33d-aa10-44de16d2d3cc@redhat.com>
 <4466F447-43D3-43CD-8930-FBE9A49028BA@nvidia.com>
 <92AE29D4-E715-447C-AF99-ECF42383C74D@nvidia.com>
 <20230926173939.GA348484@cmpxchg.org>
 <0D2BD71D-5E65-4175-8872-5E70278C57DA@nvidia.com>
 <329AB331-DDC1-4074-A85E-AB5CF866CE84@nvidia.com>
 <20231010211200.GA129823@cmpxchg.org>
 <D6A142AB-08F6-4335-8D08-1743DFAAD10C@nvidia.com>
 <43350F6E-E56D-41C8-8441-A96D83B7D7C1@nvidia.com>
 <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ED43DACB-C77F-40D3-8806-D3F26AD95E8D@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:35:34AM -0400, Zi Yan wrote:
> > The attached patch has all the suggested changes, let me know how it
> > looks to you. Thanks.
> 
> The one I sent has free page accounting issues. The attached one fixes them.

Do you still have the warnings? I wonder what went wrong.

> @@ -883,6 +886,10 @@ int split_free_page(struct page *free_page,
>  	mt = get_pfnblock_migratetype(free_page, free_page_pfn);
>  	del_page_from_free_list(free_page, zone, order, mt);
>  
> +	set_pageblock_migratetype(free_page, mt1);
> +	set_pageblock_migratetype(pfn_to_page(free_page_pfn + split_pfn_offset),
> +				  mt2);
> +
>  	for (pfn = free_page_pfn;
>  	     pfn < free_page_pfn + (1UL << order);) {
>  		int mt = get_pfnblock_migratetype(pfn_to_page(pfn), pfn);

I don't think this is quite right.

With CONFIG_ARCH_FORCE_MAX_ORDER it's possible that we're dealing with
a buddy that is more than two blocks:

[pageblock 0][pageblock 1][pageblock 2][pageblock 3]
[buddy                                             ]
                                       [isolate range ..

That for loop splits the buddy into 4 blocks. The code above would set
pageblock 0 to old_mt, and pageblock 1 to new_mt. But it should only
set pageblock 3 to new_mt.

My proposal had the mt update in the caller:

> @@ -139,6 +139,62 @@ static struct page *has_unmovable_pages(unsigned long start_pfn, unsigned long e
>  	return NULL;
>  }
>  
> +/*
> + * additional steps for moving free pages during page isolation
> + */
> +static int move_freepages_for_isolation(struct zone *zone, unsigned long start_pfn,
> +			  unsigned long end_pfn, int old_mt, int new_mt)
> +{
> +	struct page *start_page = pfn_to_page(start_pfn);
> +	unsigned long pfn;
> +
> +	VM_WARN_ON(start_pfn & (pageblock_nr_pages - 1));
> +	VM_WARN_ON(start_pfn + pageblock_nr_pages - 1 != end_pfn);
> +
> +	/*
> +	 * A free page may be comprised of 2^n blocks, which means our
> +	 * block of interest could be head or tail in such a page.
> +	 *
> +	 * If we're a tail, update the type of our block, then split
> +	 * the page into pageblocks. The splitting will do the leg
> +	 * work of sorting the blocks into the right freelists.
> +	 *
> +	 * If we're a head, split the page into pageblocks first. This
> +	 * ensures the migratetypes still match up during the freelist
> +	 * removal. Then do the regular scan for buddies in the block
> +	 * of interest, which will handle the rest.
> +	 *
> +	 * In theory, we could try to preserve 2^1 and larger blocks
> +	 * that lie outside our range. In practice, MAX_ORDER is
> +	 * usually one or two pageblocks anyway, so don't bother.
> +	 *
> +	 * Note that this only applies to page isolation, which calls
> +	 * this on random blocks in the pfn range! When we move stuff
> +	 * from inside the page allocator, the pages are coming off
> +	 * the freelist (can't be tail) and multi-block pages are
> +	 * handled directly in the stealing code (can't be a head).
> +	 */
> +
> +	/* We're a tail */
> +	pfn = find_straddling_buddy(start_pfn);
> +	if (pfn != start_pfn) {
> +		struct page *free_page = pfn_to_page(pfn);
> +
> +		split_free_page(free_page, buddy_order(free_page),
> +				pageblock_nr_pages, old_mt, new_mt);
> +		return pageblock_nr_pages;
> +	}
> +
> +	/* We're a head */
> +	if (PageBuddy(start_page) && buddy_order(start_page) > pageblock_order) {
> +		split_free_page(start_page, buddy_order(start_page),
> +				pageblock_nr_pages, new_mt, old_mt);
> +		return pageblock_nr_pages;
> +	}

i.e. here ^: set the mt of the block that's in isolation range, then
split the block.

I think I can guess the warning you were getting: in the head case, we
need to change the type of the head pageblock that's on the
freelist. If we do it before calling split, the
del_page_from_freelist() in there warns about the wrong type.

How about pulling the freelist removal out of split_free_page()?

	del_page_from_freelist(huge_buddy);
	set_pageblock_migratetype(start_page, MIGRATE_ISOLATE);
	split_free_page(huge_buddy, buddy_order(), pageblock_nr_pages);
	return pageblock_nr_pages;
