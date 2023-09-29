Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1C27B2DD5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjI2IbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231774AbjI2IbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:31:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63EE61A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:31:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D03C433C7;
        Fri, 29 Sep 2023 08:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695976275;
        bh=KFYltfNMXJHEntrJupeguURYviSs9Hszmj5cJIerR6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Jw3M0Gcyy1R1Jeqr4D8XW2blUqxBUVDgrcNRH3+wBXk8F2GcYISbIZB3TO9G3b507
         AAoEHo1aFevCX9KlX5EQujLQo4O7EXYpzwMZIBIcZuQ563Lxz+vZAMNHgjT63DSJvU
         OhkYo5vDQuU2bGwarQcNlypnUOE3fN3gU7regX9LwbOmqQC3DMOKxw4yAfxRUyg9pM
         98PkO+oa5pWeq+8xzhoNyNdLb7pdMRXsphK6ShFas1okkmZbpNngOa5JWrj+S5yhws
         rh4LH9MQ7C1KslAQH7lJzBtKdoDbIzeSaWS7P7Z53THb34F6iz9rtwmzEmk3lwlY6Q
         EGLKFcsXjOjeg==
Date:   Fri, 29 Sep 2023 11:30:18 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] mm: Init page count in reserve_bootmem_region
 when MEMINIT_EARLY
Message-ID: <20230929083018.GU3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-3-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928083302.386202-3-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:33:02PM +0800, Yajun Deng wrote:
> memmap_init_range() would init page count of all pages, but the free
> pages count would be reset in __free_pages_core(). There are opposite
> operations. It's unnecessary and time-consuming when it's MEMINIT_EARLY
> context.
> 
> Init page count in reserve_bootmem_region when in MEMINIT_EARLY context,
> and check the page count before reset it.
> 
> At the same time, the INIT_LIST_HEAD in reserve_bootmem_region isn't
> need, as it already done in __init_single_page.
> 
> The following data was tested on an x86 machine with 190GB of RAM.
> 
> before:
> free_low_memory_core_early()    341ms
> 
> after:
> free_low_memory_core_early()    285ms
> 
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v4: same with v2.
> v3: same with v2.
> v2: check page count instead of check context before reset it.
> v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
> ---
>  mm/mm_init.c    | 18 +++++++++++++-----
>  mm/page_alloc.c | 20 ++++++++++++--------
>  2 files changed, 25 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 9716c8a7ade9..3ab8861e1ef3 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -718,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>  		if (zone_spans_pfn(zone, pfn))
>  			break;
>  	}
> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);
> +	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, 0);
>  }
>  #else
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
> @@ -756,8 +756,8 @@ void __meminit reserve_bootmem_region(phys_addr_t start,
>  
>  			init_reserved_page(start_pfn, nid);
>  
> -			/* Avoid false-positive PageTail() */
> -			INIT_LIST_HEAD(&page->lru);
> +			/* Init page count for reserved region */

Please add a comment that describes _why_ we initialize the page count here.

> +			init_page_count(page);
>  
>  			/*
>  			 * no need for atomic set_bit because the struct
> @@ -888,9 +888,17 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  		}
>  
>  		page = pfn_to_page(pfn);
> -		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
> -		if (context == MEMINIT_HOTPLUG)
> +
> +		/* If the context is MEMINIT_EARLY, we will init page count and
> +		 * mark page reserved in reserve_bootmem_region, the free region
> +		 * wouldn't have page count and we will check the pages count
> +		 * in __free_pages_core.
> +		 */
> +		__init_single_page(page, pfn, zone, nid, 0);
> +		if (context == MEMINIT_HOTPLUG) {
> +			init_page_count(page);
>  			__SetPageReserved(page);

Rather than calling init_page_count() and __SetPageReserved() for
MEMINIT_HOTPLUG you can set flags to INIT_PAGE_COUNT | INIT_PAGE_RESERVED
an call __init_single_page() after the check for MEMINIT_HOTPLUG.

But more generally, I wonder if we have to differentiate HOTPLUG here at all.
@David, can you comment please?

> +		}
>  
>  		/*
>  		 * Usually, we want to mark the pageblock MIGRATE_MOVABLE,
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 06be8821d833..b868caabe8dc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1285,18 +1285,22 @@ void __free_pages_core(struct page *page, unsigned int order)
>  	unsigned int loop;
>  
>  	/*
> -	 * When initializing the memmap, __init_single_page() sets the refcount
> -	 * of all pages to 1 ("allocated"/"not free"). We have to set the
> -	 * refcount of all involved pages to 0.
> +	 * When initializing the memmap, memmap_init_range sets the refcount
> +	 * of all pages to 1 ("reserved" and "free") in hotplug context. We
> +	 * have to set the refcount of all involved pages to 0. Otherwise,
> +	 * we don't do it, as reserve_bootmem_region only set the refcount on
> +	 * reserve region ("reserved") in early context.
>  	 */

Again, why hotplug and early init should be different?

> -	prefetchw(p);
> -	for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
> -		prefetchw(p + 1);
> +	if (page_count(page)) {
> +		prefetchw(p);
> +		for (loop = 0; loop < (nr_pages - 1); loop++, p++) {
> +			prefetchw(p + 1);
> +			__ClearPageReserved(p);
> +			set_page_count(p, 0);
> +		}
>  		__ClearPageReserved(p);
>  		set_page_count(p, 0);
>  	}
> -	__ClearPageReserved(p);
> -	set_page_count(p, 0);
>  
>  	atomic_long_add(nr_pages, &page_zone(page)->managed_pages);
>  
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
