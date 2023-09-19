Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F997A5EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 11:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjISJx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 05:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231748AbjISJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 05:53:15 -0400
Received: from out-221.mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE7818E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 02:53:06 -0700 (PDT)
Message-ID: <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695117181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=P53viX11QuF1Pmhi29hnQ9FK4klbDYMkSngdnTDu+Tw=;
        b=KCbYo8yW7rQfrMIVGjHNLoAMbeikhCoKvfH6WFDib/cGpedYn2+QE0dQNm7A3aEmRjm1I/
        7e6wYP0p2h2wnq5IrqTv3tXiYmK9TYqQQQGU88ZKzctr8FGPP4Rl3l4MjxhP33EbrlKi0O
        ze9+aNwwKYZ22my5QZEGUCfIw5dc28E=
Date:   Tue, 19 Sep 2023 17:52:51 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
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
 <20230918230202.254631-5-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230918230202.254631-5-mike.kravetz@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/19 07:01, Mike Kravetz wrote:
> The routine update_and_free_pages_bulk already performs vmemmap
> restoration on the list of hugetlb pages in a separate step.  In
> preparation for more functionality to be added in this step, create a
> new routine hugetlb_vmemmap_restore_folios() that will restore
> vmemmap for a list of folios.
>
> This new routine must provide sufficient feedback about errors and
> actual restoration performed so that update_and_free_pages_bulk can
> perform optimally.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 36 ++++++++++++++++++------------------
>   mm/hugetlb_vmemmap.c | 37 +++++++++++++++++++++++++++++++++++++
>   mm/hugetlb_vmemmap.h | 11 +++++++++++
>   3 files changed, 66 insertions(+), 18 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index d6f3db3c1313..814bb1982274 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1836,36 +1836,36 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
>   
>   static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
>   {
> +	int ret;
> +	unsigned long restored;
>   	struct folio *folio, *t_folio;
> -	bool clear_dtor = false;
>   
>   	/*
> -	 * First allocate required vmemmmap (if necessary) for all folios on
> -	 * list.  If vmemmap can not be allocated, we can not free folio to
> -	 * lower level allocator, so add back as hugetlb surplus page.
> -	 * add_hugetlb_folio() removes the page from THIS list.
> -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> -	 * ANY page on the list.
> +	 * First allocate required vmemmmap (if necessary) for all folios.
>   	 */
> -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> -			if (hugetlb_vmemmap_restore(h, &folio->page)) {
> -				spin_lock_irq(&hugetlb_lock);
> +	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
> +
> +	/*
> +	 * If there was an error restoring vmemmap for ANY folios on the list,
> +	 * add them back as surplus hugetlb pages.  add_hugetlb_folio() removes
> +	 * the folio from THIS list.
> +	 */
> +	if (ret < 0) {
> +		spin_lock_irq(&hugetlb_lock);
> +		list_for_each_entry_safe(folio, t_folio, list, lru)
> +			if (folio_test_hugetlb_vmemmap_optimized(folio))
>   				add_hugetlb_folio(h, folio, true);
> -				spin_unlock_irq(&hugetlb_lock);
> -			} else
> -				clear_dtor = true;
> -		}
> +		spin_unlock_irq(&hugetlb_lock);
>   	}
>   
>   	/*
> -	 * If vmemmmap allocation was performed on any folio above, take lock
> -	 * to clear destructor of all folios on list.  This avoids the need to
> +	 * If vmemmmap allocation was performed on ANY folio , take lock to
> +	 * clear destructor of all folios on list.  This avoids the need to
>   	 * lock/unlock for each individual folio.
>   	 * The assumption is vmemmap allocation was performed on all or none
>   	 * of the folios on the list.  This is true expect in VERY rare cases.
>   	 */
> -	if (clear_dtor) {
> +	if (restored) {
>   		spin_lock_irq(&hugetlb_lock);
>   		list_for_each_entry(folio, list, lru)
>   			__clear_hugetlb_destructor(h, folio);
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4558b814ffab..463a4037ec6e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -480,6 +480,43 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/**
> + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> + * @h:		struct hstate.
> + * @folio_list:	list of folios.
> + * @restored:	Set to number of folios for which vmemmap was restored
> + *		successfully if caller passes a non-NULL pointer.
> + *
> + * Return: %0 if vmemmap exists for all folios on the list.  If an error is
> + *		encountered restoring vmemmap for ANY folio, an error code
> + *		will be returned to the caller.  It is then the responsibility
> + *		of the caller to check the hugetlb vmemmap optimized flag of
> + *		each folio to determine if vmemmap was actually restored.
> + */
> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					unsigned long *restored)
> +{
> +	unsigned long num_restored;
> +	struct folio *folio;
> +	int ret = 0, t_ret;
> +
> +	num_restored = 0;
> +	list_for_each_entry(folio, folio_list, lru) {
> +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> +			t_ret = hugetlb_vmemmap_restore(h, &folio->page);

I still think we should free a non-optimized HugeTLB page if we
encounter an OOM situation instead of continue to restore
vemmmap pages. Restoring vmemmmap pages will only aggravate
the OOM situation. The suitable appraoch is to free a non-optimized
HugeTLB page to satisfy our allocation of vmemmap pages, what's
your opinion, Mike?

Thanks.

> +			if (t_ret)
> +				ret = t_ret;
> +			else
> +				num_restored++;
> +		}
> +	}
> +
> +	if (*restored)
> +		*restored = num_restored;
> +	return ret;
> +}
> +
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index c512e388dbb4..bb58453c3cc0 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -19,6 +19,8 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +			struct list_head *folio_list, unsigned long *restored);
>   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>   
> @@ -45,6 +47,15 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>   	return 0;
>   }
>   
> +static inline int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					unsigned long *restored)
> +{
> +	if (restored)
> +		*restored = 0;
> +	return 0;
> +}
> +
>   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   }

