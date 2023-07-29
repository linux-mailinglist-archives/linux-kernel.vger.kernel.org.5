Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E9A767C90
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 08:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235898AbjG2GiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 02:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG2GiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 02:38:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851AC3C33
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 23:38:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19AFE602FB
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jul 2023 06:38:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61CCBC433C7;
        Sat, 29 Jul 2023 06:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690612680;
        bh=iusrxNKSk2oyUHVoBertANw633DmyTvL1U04sE+xDBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TMIOZzfCFi7pQOv5BFBEe61MgYy7v7C3JVeKz+7PQGRb7aOPUztE4uEytcAZZ2NZu
         jeUwqjvLtCLInQ2R8G4bNQbY+yFGwN+XNoK+eOHUl5LzoZx55jLOcCigZUy9aRnb3V
         xEJgIZvkxUKUhJ43LEOLUAgJxjjFfYcYVmbS0FmF8yqnDL5QqZ4j+6oP6e7MJON24y
         HlNxtjlH94i38/e2lsiQGw4+M+VkCH4X+FOT5jaoZu0HM6lg7m2+cQ7SSxIFR55v1b
         TmasMtH5P0TDO2egPSyF9fmfMSYo+cyoM8hKEgd6CIdkNTuS5S0Ha2O8+IYLUU39wj
         xkQVmlnBdXRCA==
Date:   Sat, 29 Jul 2023 09:37:21 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com
Subject: Re: [v1 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
Message-ID: <20230729063721.GD1901145@kernel.org>
References: <20230727204624.1942372-1-usama.arif@bytedance.com>
 <20230727204624.1942372-2-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727204624.1942372-2-usama.arif@bytedance.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:46:19PM +0100, Usama Arif wrote:
> When vmemmap is optimizable, it will free all the
> duplicated tail pages in hugetlb_vmemmap_optimize while
> preparing the new hugepage. Hence, there is no need to
> prepare them.
> 
> For 1G x86 hugepages, it avoids preparing
> 262144 - 64 = 262080 struct pages per hugepage.
> 
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>  mm/hugetlb.c         | 32 +++++++++++++++++++++++---------
>  mm/hugetlb_vmemmap.c |  2 +-
>  mm/hugetlb_vmemmap.h |  7 +++++++
>  3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..58cf5978bee1 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1943,13 +1943,24 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
>  }
>  
>  static bool __prep_compound_gigantic_folio(struct folio *folio,
> -					unsigned int order, bool demote)
> +					unsigned int order, bool demote,
> +					bool hvo)

I think it would be cleaner to pass struct hstate * instead of order here
so that order and hvo can be computed locally.

>  {
>  	int i, j;
>  	int nr_pages = 1 << order;
>  	struct page *p;
>  
>  	__folio_clear_reserved(folio);
> +
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +	/*
> +	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize
> +	 * in prep_new_huge_page. Hence, reduce nr_pages to the pages that will be kept.
> +	 */
> +	if (hvo)

	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) && hvo)

is better than ifdef IMO.

> +		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);
> +#endif
> +
>  	for (i = 0; i < nr_pages; i++) {
>  		p = folio_page(folio, i);
>  
> @@ -2020,15 +2031,15 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>  }
>  
>  static bool prep_compound_gigantic_folio(struct folio *folio,
> -							unsigned int order)
> +							unsigned int order, bool hvo)
>  {
> -	return __prep_compound_gigantic_folio(folio, order, false);
> +	return __prep_compound_gigantic_folio(folio, order, false, hvo);
>  }
>  
>  static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
> -							unsigned int order)
> +							unsigned int order, bool hvo)
>  {
> -	return __prep_compound_gigantic_folio(folio, order, true);
> +	return __prep_compound_gigantic_folio(folio, order, true, hvo);
>  }
>  
>  /*
> @@ -2185,7 +2196,8 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
>  	if (!folio)
>  		return NULL;
>  	if (hstate_is_gigantic(h)) {
> -		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (!prep_compound_gigantic_folio(folio, huge_page_order(h),
> +						  vmemmap_should_optimize(h, &folio->page))) {
>  			/*
>  			 * Rare failure to convert pages to compound page.
>  			 * Free pages and try again - ONCE!
> @@ -3201,7 +3213,8 @@ static void __init gather_bootmem_prealloc(void)
>  
>  		VM_BUG_ON(!hstate_is_gigantic(h));
>  		WARN_ON(folio_ref_count(folio) != 1);
> -		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (prep_compound_gigantic_folio(folio, huge_page_order(h),
> +						vmemmap_should_optimize(h, page))) {
>  			WARN_ON(folio_test_reserved(folio));
>  			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
>  			free_huge_page(page); /* add to the hugepage allocator */
> @@ -3624,8 +3637,9 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>  		subpage = folio_page(folio, i);
>  		inner_folio = page_folio(subpage);
>  		if (hstate_is_gigantic(target_hstate))
> -			prep_compound_gigantic_folio_for_demote(inner_folio,
> -							target_hstate->order);
> +			prep_compound_gigantic_folio_for_demote(folio,
> +						target_hstate->order,
> +						vmemmap_should_optimize(target_hstate, subpage));
>  		else
>  			prep_compound_page(subpage, target_hstate->order);
>  		folio_change_private(inner_folio, NULL);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c2007ef5e9b0..b721e87de2b3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -486,7 +486,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>  }
>  
>  /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
> -static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>  {
>  	if (!READ_ONCE(vmemmap_optimize_enabled))
>  		return false;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..07555d2dc0cb 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -13,6 +13,7 @@
>  #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>  int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
>  void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
>  
>  /*
>   * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
> @@ -51,6 +52,12 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
>  {
>  	return 0;
>  }
> +
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +{
> +	return false;
> +}
> +
>  #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
>  
>  static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)
> -- 
> 2.25.1
> 

-- 
Sincerely yours,
Mike.
