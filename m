Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7417A57C1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjISDLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 23:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjISDLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 23:11:16 -0400
Received: from out-212.mta1.migadu.com (out-212.mta1.migadu.com [IPv6:2001:41d0:203:375::d4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D454C95
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 20:11:09 -0700 (PDT)
Message-ID: <e284396d-c32d-b69d-21c6-7025db93b873@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695093068;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MSeWBe58gmrwW7zPrpTo80TQ0Mc9s3DAzN/0nh5B+zU=;
        b=e8NCzfFbUN0plzAl9ZK2ewM9AztMX7+9E9OUdgT4b2V/gp9Tvv+/HzlVD+soR8h5gOjUVx
        3gm//IP95oZYZm2srHjLOuHrJ/wG0RMzh767zBYYqsyTozUgEqgvukqovE/lWvP5DiNCkG
        8FVXnQiQ0gAPhITqDtSSp5IQ0Pqwcds=
Date:   Tue, 19 Sep 2023 11:10:59 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/8] hugetlb: perform vmemmap optimization on a list of
 pages
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Oscar Salvador <osalvador@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Rientjes <rientjes@google.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Barry Song <21cnbao@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Xiongchun Duan <duanxiongchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20230918230202.254631-1-mike.kravetz@oracle.com>
 <20230918230202.254631-4-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230918230202.254631-4-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/19 07:01, Mike Kravetz wrote:
> When adding hugetlb pages to the pool, we first create a list of the
> allocated pages before adding to the pool.  Pass this list of pages to a
> new routine hugetlb_vmemmap_optimize_folios() for vmemmap optimization.
>
> Due to significant differences in vmemmmap initialization for bootmem
> allocated hugetlb pages, a new routine prep_and_add_bootmem_folios
> is created.
>
> We also modify the routine vmemmap_should_optimize() to check for pages
> that are already optimized.  There are code paths that might request
> vmemmap optimization twice and we want to make sure this is not
> attempted.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 50 +++++++++++++++++++++++++++++++++++++-------
>   mm/hugetlb_vmemmap.c | 11 ++++++++++
>   mm/hugetlb_vmemmap.h |  5 +++++
>   3 files changed, 58 insertions(+), 8 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 8624286be273..d6f3db3c1313 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -2269,6 +2269,11 @@ static void prep_and_add_allocated_folios(struct hstate *h,
>   {
>   	struct folio *folio, *tmp_f;
>   
> +	/*
> +	 * Send list for bulk vmemmap optimization processing
> +	 */

 From the kernel development document, one-line comment format is "/**/".

> +	hugetlb_vmemmap_optimize_folios(h, folio_list);
> +
>   	/*
>   	 * Add all new pool pages to free lists in one lock cycle
>   	 */
> @@ -3309,6 +3314,40 @@ static void __init hugetlb_folio_init_vmemmap(struct folio *folio,
>   	prep_compound_head((struct page *)folio, huge_page_order(h));
>   }
>   
> +static void __init prep_and_add_bootmem_folios(struct hstate *h,
> +					struct list_head *folio_list)
> +{
> +	struct folio *folio, *tmp_f;
> +
> +	/*
> +	 * Send list for bulk vmemmap optimization processing
> +	 */
> +	hugetlb_vmemmap_optimize_folios(h, folio_list);
> +
> +	/*
> +	 * Add all new pool pages to free lists in one lock cycle
> +	 */
> +	spin_lock_irq(&hugetlb_lock);
> +	list_for_each_entry_safe(folio, tmp_f, folio_list, lru) {
> +		if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
> +			/*
> +			 * If HVO fails, initialize all tail struct pages
> +			 * We do not worry about potential long lock hold
> +			 * time as this is early in boot and there should
> +			 * be no contention.
> +			 */
> +			hugetlb_folio_init_tail_vmemmap(folio,
> +					HUGETLB_VMEMMAP_RESERVE_PAGES,
> +					pages_per_huge_page(h));
> +		}
> +		__prep_account_new_huge_page(h, folio_nid(folio));
> +		enqueue_hugetlb_folio(h, folio);
> +	}
> +	spin_unlock_irq(&hugetlb_lock);
> +
> +	INIT_LIST_HEAD(folio_list);

I'm not sure what is the purpose of the reinitialization to list head?

> +}
> +
>   /*
>    * Put bootmem huge pages into the standard lists after mem_map is up.
>    * Note: This only applies to gigantic (order > MAX_ORDER) pages.
> @@ -3329,7 +3368,7 @@ static void __init gather_bootmem_prealloc(void)
>   		 * in this list.  If so, process each size separately.
>   		 */
>   		if (h != prev_h && prev_h != NULL)
> -			prep_and_add_allocated_folios(prev_h, &folio_list);
> +			prep_and_add_bootmem_folios(prev_h, &folio_list);
>   		prev_h = h;
>   
>   		VM_BUG_ON(!hstate_is_gigantic(h));
> @@ -3337,12 +3376,7 @@ static void __init gather_bootmem_prealloc(void)
>   
>   		hugetlb_folio_init_vmemmap(folio, h,
>   					   HUGETLB_VMEMMAP_RESERVE_PAGES);
> -		__prep_new_hugetlb_folio(h, folio);
> -		/* If HVO fails, initialize all tail struct pages */
> -		if (!HPageVmemmapOptimized(&folio->page))
> -			hugetlb_folio_init_tail_vmemmap(folio,
> -						HUGETLB_VMEMMAP_RESERVE_PAGES,
> -						pages_per_huge_page(h));
> +		init_new_hugetlb_folio(h, folio);
>   		list_add(&folio->lru, &folio_list);
>   
>   		/*
> @@ -3354,7 +3388,7 @@ static void __init gather_bootmem_prealloc(void)
>   		cond_resched();
>   	}
>   
> -	prep_and_add_allocated_folios(h, &folio_list);
> +	prep_and_add_bootmem_folios(h, &folio_list);
>   }
>   
>   static void __init hugetlb_hstate_alloc_pages_onenode(struct hstate *h, int nid)
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 76682d1d79a7..4558b814ffab 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -483,6 +483,9 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> +	if (HPageVmemmapOptimized((struct page *)head))
> +		return false;
> +
>   	if (!READ_ONCE(vmemmap_optimize_enabled))
>   		return false;
>   
> @@ -572,6 +575,14 @@ void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   		SetHPageVmemmapOptimized(head);
>   }
>   
> +void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
> +{
> +	struct folio *folio;
> +
> +	list_for_each_entry(folio, folio_list, lru)
> +		hugetlb_vmemmap_optimize(h, &folio->page);
> +}
> +
>   static struct ctl_table hugetlb_vmemmap_sysctls[] = {
>   	{
>   		.procname	= "hugetlb_optimize_vmemmap",
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index 4573899855d7..c512e388dbb4 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -20,6 +20,7 @@
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
>   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
> +void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>   
>   static inline unsigned int hugetlb_vmemmap_size(const struct hstate *h)
>   {
> @@ -48,6 +49,10 @@ static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page
>   {
>   }
>   
> +static inline void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list)
> +{
> +}
> +
>   static inline unsigned int hugetlb_vmemmap_optimizable_size(const struct hstate *h)
>   {
>   	return 0;

