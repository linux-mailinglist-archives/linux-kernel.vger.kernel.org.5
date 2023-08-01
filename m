Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2B976A6B8
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 04:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjHACFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjHACFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 22:05:11 -0400
Received: from out-119.mta0.migadu.com (out-119.mta0.migadu.com [IPv6:2001:41d0:1004:224b::77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37DDB8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:05:09 -0700 (PDT)
Message-ID: <b6aaa304-e632-9f8f-ae60-63ae209ad152@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1690855508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XFcd0PWa/LzVN9FBDTHBRxRJ7bjV/Fi/yIQ9ks3BIBY=;
        b=NhjMmp6icNSl4jKc/Z6RCheyP/E+4k48FsyFZaFqx2akhX8K+31gwF3m0wbD1KmregczEs
        iYPzs+kMmRNV1mWktvvb8YcHFJ42IqsjmjNleBMnD32nvzIAKyHo2/LkXtIbE7h5+ayft6
        vKLrx7ddHvLSd6YWS1oEs28zwD9ZLZY=
Date:   Tue, 1 Aug 2023 10:04:59 +0800
MIME-Version: 1.0
Subject: Re: [v2 1/6] mm: hugetlb: Skip prep of tail pages when HVO is enabled
To:     Usama Arif <usama.arif@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, fam.zheng@bytedance.com,
        liangma@liangbit.com, simon.evans@bytedance.com,
        punit.agrawal@bytedance.com, linux-mm@kvack.org,
        mike.kravetz@oracle.com, rppt@kernel.org
References: <20230730151606.2871391-1-usama.arif@bytedance.com>
 <20230730151606.2871391-2-usama.arif@bytedance.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230730151606.2871391-2-usama.arif@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/7/30 23:16, Usama Arif wrote:
> When vmemmap is optimizable, it will free all the duplicated tail
> pages in hugetlb_vmemmap_optimize while preparing the new hugepage.
> Hence, there is no need to prepare them.
>
> For 1G x86 hugepages, it avoids preparing
> 262144 - 64 = 262080 struct pages per hugepage.
>
> The indirection of using __prep_compound_gigantic_folio is also removed,
> as it just creates extra functions to indicate demote which can be done
> with the argument.
>
> Signed-off-by: Usama Arif <usama.arif@bytedance.com>
> ---
>   mm/hugetlb.c         | 32 ++++++++++++++------------------
>   mm/hugetlb_vmemmap.c |  2 +-
>   mm/hugetlb_vmemmap.h | 15 +++++++++++----
>   3 files changed, 26 insertions(+), 23 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 64a3239b6407..541c07b6d60f 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1942,14 +1942,23 @@ static void prep_new_hugetlb_folio(struct hstate *h, struct folio *folio, int ni
>   	spin_unlock_irq(&hugetlb_lock);
>   }
>   
> -static bool __prep_compound_gigantic_folio(struct folio *folio,
> -					unsigned int order, bool demote)
> +static bool prep_compound_gigantic_folio(struct folio *folio, struct hstate *h, bool demote)
>   {
>   	int i, j;
> +	int order = huge_page_order(h);
>   	int nr_pages = 1 << order;
>   	struct page *p;
>   
>   	__folio_clear_reserved(folio);
> +
> +	/*
> +	 * No need to prep pages that will be freed later by hugetlb_vmemmap_optimize.
> +	 * Hence, reduce nr_pages to the pages that will be kept.
> +	 */
> +	if (IS_ENABLED(CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP) &&
> +			vmemmap_should_optimize(h, &folio->page))
> +		nr_pages = HUGETLB_VMEMMAP_RESERVE_SIZE / sizeof(struct page);

We need to initialize the refcount to zero of tail pages (see the big
comment below in this function), given a situation that someone (maybe
GUP) could get a ref on the tail pages when the vmemmap is optimizing,
what prevent this from happening?

Thanks.

> +
>   	for (i = 0; i < nr_pages; i++) {
>   		p = folio_page(folio, i);
>   
> @@ -2019,18 +2028,6 @@ static bool __prep_compound_gigantic_folio(struct folio *folio,
>   	return false;
>   }
>   
> -static bool prep_compound_gigantic_folio(struct folio *folio,
> -							unsigned int order)
> -{
> -	return __prep_compound_gigantic_folio(folio, order, false);
> -}
> -
> -static bool prep_compound_gigantic_folio_for_demote(struct folio *folio,
> -							unsigned int order)
> -{
> -	return __prep_compound_gigantic_folio(folio, order, true);
> -}
> -
>   /*
>    * PageHuge() only returns true for hugetlbfs pages, but not for normal or
>    * transparent huge pages.  See the PageTransHuge() documentation for more
> @@ -2185,7 +2182,7 @@ static struct folio *alloc_fresh_hugetlb_folio(struct hstate *h,
>   	if (!folio)
>   		return NULL;
>   	if (hstate_is_gigantic(h)) {
> -		if (!prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (!prep_compound_gigantic_folio(folio, h, false)) {
>   			/*
>   			 * Rare failure to convert pages to compound page.
>   			 * Free pages and try again - ONCE!
> @@ -3201,7 +3198,7 @@ static void __init gather_bootmem_prealloc(void)
>   
>   		VM_BUG_ON(!hstate_is_gigantic(h));
>   		WARN_ON(folio_ref_count(folio) != 1);
> -		if (prep_compound_gigantic_folio(folio, huge_page_order(h))) {
> +		if (prep_compound_gigantic_folio(folio, h, false)) {
>   			WARN_ON(folio_test_reserved(folio));
>   			prep_new_hugetlb_folio(h, folio, folio_nid(folio));
>   			free_huge_page(page); /* add to the hugepage allocator */
> @@ -3624,8 +3621,7 @@ static int demote_free_hugetlb_folio(struct hstate *h, struct folio *folio)
>   		subpage = folio_page(folio, i);
>   		inner_folio = page_folio(subpage);
>   		if (hstate_is_gigantic(target_hstate))
> -			prep_compound_gigantic_folio_for_demote(inner_folio,
> -							target_hstate->order);
> +			prep_compound_gigantic_folio(inner_folio, target_hstate, true);
>   		else
>   			prep_compound_page(subpage, target_hstate->order);
>   		folio_change_private(inner_folio, NULL);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index c2007ef5e9b0..b721e87de2b3 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -486,7 +486,7 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   }
>   
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
> -static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
>   	if (!READ_ONCE(vmemmap_optimize_enabled))
>   		return false;
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 25bd0e002431..3e7978a9af73 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -10,16 +10,17 @@
>   #define _LINUX_HUGETLB_VMEMMAP_H
>   #include <linux/hugetlb.h>
>   
> -#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> -int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> -void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> -
>   /*
>    * Reserve one vmemmap page, all vmemmap addresses are mapped to it. See
>    * Documentation/vm/vmemmap_dedup.rst.
>    */
>   #define HUGETLB_VMEMMAP_RESERVE_SIZE	PAGE_SIZE
>   
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> +bool vmemmap_should_optimize(const struct hstate *h, const struct page *head);
> +
>   static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
>   {
>   	return pages_per_huge_page(h) * sizeof(struct page);
> @@ -51,6 +52,12 @@ static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate
>   {
>   	return 0;
>   }
> +
> +static inline bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
> +{
> +	return false;
> +}
> +
>   #endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
>   
>   static inline bool hugetlb_vmemmap_optimizable(const struct hstate *h)

