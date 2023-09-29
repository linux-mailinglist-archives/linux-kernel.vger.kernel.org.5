Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465AC7B2DB3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjI2IUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232839AbjI2IUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:20:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCD461AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:20:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3CAC433C8;
        Fri, 29 Sep 2023 08:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695975634;
        bh=STdWp6XZyS/VxSX9LqKQLcDyzvUbrM42UbPwYACPsvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THhCG9AvZ5uuDE5QlTcRq9tpKCLVMCNz6kcmHc0xFm5d50/xFaYwBDrFyvnYTGVo8
         Mk6Vrqwd9fvrur+uGNe6YebrbBQjDhszhiz7DUDa3Y5amMOs/KyE62JL1De03fl4BO
         kUefOLPYo/escFa7Q26dTEQZ4tLP+9dti/crevfqGjwvJlDVzs6Q6ROfOobGMKQys6
         LU4blgUt6qdPEM1VkONJMApgfxQnlNlf1C7PH6PLY1VDhl5nXspb0/zs63oNjqkxL1
         zvOI3CtKbDR/pDhFpJkZdB9yriY7j2h5SHN0u5TAY7b35RUAscPbLJQbv7cZxYwrFE
         jwWqhdrcPF65w==
Date:   Fri, 29 Sep 2023 11:19:38 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Yajun Deng <yajun.deng@linux.dev>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        muchun.song@linux.dev, willy@infradead.org, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] mm: pass page count and reserved to
 __init_single_page
Message-ID: <20230929081938.GT3303@kernel.org>
References: <20230928083302.386202-1-yajun.deng@linux.dev>
 <20230928083302.386202-2-yajun.deng@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230928083302.386202-2-yajun.deng@linux.dev>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 04:33:01PM +0800, Yajun Deng wrote:
> Subject: mm: pass page count and reserved to __init_single_page

We add pass flags that tell __init_single_page() how to initialize page
count and PG_Reserved, I think a better subject would be:

mm: allow optional initialization of page count and PG_reserved flag

> When we init a single page, we need to mark that page reserved when it
> is reserved. And some pages need to reset page count, such as compound
> pages.
>
> Introduce enum init_page_flags, the caller will init page count and mark
> page reserved by passing INIT_PAGE_COUNT and INIT_PAGE_RESERVED.

This does not really describe why the change is needed. How about

__init_single_page() unconditionally resets page count which is unnecessary
for reserved pages. 

To allow skipping page count initialization and marking a page reserved in
one go add flags parameter to __init_single_page().

No functional changes.

> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> ---
> v4: move the changes of __init_zone_device_page().
> v3: Introduce enum init_page_flags.
> v2: Introduce INIT_PAGE_COUNT and INIT_PAGE_RESERVED.
> v1: https://lore.kernel.org/all/20230922070923.355656-1-yajun.deng@linux.dev/
> ---
>  mm/hugetlb.c  |  2 +-
>  mm/internal.h |  8 +++++++-
>  mm/mm_init.c  | 24 +++++++++++++-----------
>  3 files changed, 21 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a82dc37669b0..bb9c334a8392 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -3196,7 +3196,7 @@ static void __init hugetlb_folio_init_tail_vmemmap(struct folio *folio,
>  	for (pfn = head_pfn + start_page_number; pfn < end_pfn; pfn++) {
>  		struct page *page = pfn_to_page(pfn);
>  
> -		__init_single_page(page, pfn, zone, nid);
> +		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>  		prep_compound_tail((struct page *)folio, pfn - head_pfn);
>  		ret = page_ref_freeze(page, 1);
>  		VM_BUG_ON(!ret);
> diff --git a/mm/internal.h b/mm/internal.h
> index d7916f1e9e98..449891ad7fdb 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1209,8 +1209,14 @@ struct vma_prepare {
>  	struct vm_area_struct *remove2;
>  };
>  
> +enum init_page_flags {

enum page_init_flags please

> +	INIT_PAGE_COUNT    = (1 << 0),
> +	INIT_PAGE_RESERVED = (1 << 1),
> +};
> +
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> -				unsigned long zone, int nid);
> +				  unsigned long zone, int nid,
> +				  enum init_page_flags flags);
>  
>  /* shrinker related functions */
>  unsigned long shrink_slab(gfp_t gfp_mask, int nid, struct mem_cgroup *memcg,
> diff --git a/mm/mm_init.c b/mm/mm_init.c
> index 06a72c223bce..9716c8a7ade9 100644
> --- a/mm/mm_init.c
> +++ b/mm/mm_init.c
> @@ -557,11 +557,11 @@ static void __init find_zone_movable_pfns_for_nodes(void)
>  }
>  
>  void __meminit __init_single_page(struct page *page, unsigned long pfn,
> -				unsigned long zone, int nid)
> +				  unsigned long zone, int nid,
> +				  enum init_page_flags flags)
>  {
>  	mm_zero_struct_page(page);
>  	set_page_links(page, zone, nid, pfn);
> -	init_page_count(page);
>  	page_mapcount_reset(page);
>  	page_cpupid_reset_last(page);
>  	page_kasan_tag_reset(page);
> @@ -572,6 +572,10 @@ void __meminit __init_single_page(struct page *page, unsigned long pfn,
>  	if (!is_highmem_idx(zone))
>  		set_page_address(page, __va(pfn << PAGE_SHIFT));
>  #endif
> +	if (flags & INIT_PAGE_COUNT)
> +		init_page_count(page);
> +	if (flags & INIT_PAGE_RESERVED)
> +		__SetPageReserved(page);
>  }
>  
>  #ifdef CONFIG_NUMA
> @@ -714,7 +718,7 @@ static void __meminit init_reserved_page(unsigned long pfn, int nid)
>  		if (zone_spans_pfn(zone, pfn))
>  			break;
>  	}
> -	__init_single_page(pfn_to_page(pfn), pfn, zid, nid);
> +	__init_single_page(pfn_to_page(pfn), pfn, zid, nid, INIT_PAGE_COUNT);

There is __SetPageReserved call a few lines below, it can be folded here.

>  }
>  #else
>  static inline void pgdat_set_deferred_range(pg_data_t *pgdat) {}
> @@ -821,8 +825,8 @@ static void __init init_unavailable_range(unsigned long spfn,
>  			pfn = pageblock_end_pfn(pfn) - 1;
>  			continue;
>  		}
> -		__init_single_page(pfn_to_page(pfn), pfn, zone, node);
> -		__SetPageReserved(pfn_to_page(pfn));
> +		__init_single_page(pfn_to_page(pfn), pfn, zone, node,
> +				   INIT_PAGE_COUNT | INIT_PAGE_RESERVED);
>  		pgcnt++;
>  	}
>  
> @@ -884,7 +888,7 @@ void __meminit memmap_init_range(unsigned long size, int nid, unsigned long zone
>  		}
>  
>  		page = pfn_to_page(pfn);
> -		__init_single_page(page, pfn, zone, nid);
> +		__init_single_page(page, pfn, zone, nid, INIT_PAGE_COUNT);
>  		if (context == MEMINIT_HOTPLUG)
>  			__SetPageReserved(page);
>  
> @@ -967,9 +971,6 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  					  unsigned long zone_idx, int nid,
>  					  struct dev_pagemap *pgmap)
>  {
> -
> -	__init_single_page(page, pfn, zone_idx, nid);
> -
>  	/*
>  	 * Mark page reserved as it will need to wait for onlining
>  	 * phase for it to be fully associated with a zone.
> @@ -977,7 +978,8 @@ static void __ref __init_zone_device_page(struct page *page, unsigned long pfn,
>  	 * We can use the non-atomic __set_bit operation for setting
>  	 * the flag as we are still initializing the pages.
>  	 */
> -	__SetPageReserved(page);
> +	__init_single_page(page, pfn, zone_idx, nid,
> +			   INIT_PAGE_COUNT | INIT_PAGE_RESERVED);
>  
>  	/*
>  	 * ZONE_DEVICE pages union ->lru with a ->pgmap back pointer
> @@ -2058,7 +2060,7 @@ static unsigned long  __init deferred_init_pages(struct zone *zone,
>  		} else {
>  			page++;
>  		}
> -		__init_single_page(page, pfn, zid, nid);
> +		__init_single_page(page, pfn, zid, nid, INIT_PAGE_COUNT);
>  		nr_pages++;
>  	}
>  	return (nr_pages);
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
