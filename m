Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A871C7AD99E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjIYNzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjIYNzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:55:06 -0400
Received: from out-207.mta1.migadu.com (out-207.mta1.migadu.com [IPv6:2001:41d0:203:375::cf])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98BFF
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:54:58 -0700 (PDT)
Message-ID: <b271ec48-cc64-6cf7-d8af-395d0f7fdd1d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695650096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7PeCfopp1dkpysdI50qY12ImGdLtXs+K8zy41OBDps=;
        b=Q9QYn9E9hF1Dc2EEyDGLwn+mHZefrtqxFuThGg2RsVaMr+5jdmGOeJMQcyXmqULAHOG2Ay
        ymYpHXVXz8QCdrf+kVEPTOEP4vV8ge0+MFhDXcRDoTb2XJd7lWCBkZy0DQtEJfBCF641ph
        kJZQ5VDbwnqTFquaQK5wsOsNN0OpR54=
Date:   Mon, 25 Sep 2023 21:54:49 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v5 4/8] hugetlb: perform vmemmap restoration on a list of
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
References: <20230925003953.142620-1-mike.kravetz@oracle.com>
 <20230925003953.142620-5-mike.kravetz@oracle.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230925003953.142620-5-mike.kravetz@oracle.com>
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



On 2023/9/25 08:39, Mike Kravetz wrote:
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
> Special care must be taken when encountering an error from
> hugetlb_vmemmap_restore_folios.  We want to continue making as much
> forward progress as possible.  A new routine bulk_vmemmap_restore_error
> handles this specific situation.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 98 +++++++++++++++++++++++++++++++-------------
>   mm/hugetlb_vmemmap.c | 38 +++++++++++++++++
>   mm/hugetlb_vmemmap.h | 10 +++++
>   3 files changed, 118 insertions(+), 28 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index da0ebd370b5f..53df35fbc3f2 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1834,50 +1834,92 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
>   		schedule_work(&free_hpage_work);
>   }
>   
> -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +static void bulk_vmemmap_restore_error(struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios)
>   {
>   	struct folio *folio, *t_folio;
> -	bool clear_dtor = false;
>   
> -	/*
> -	 * First allocate required vmemmmap (if necessary) for all folios on
> -	 * list.  If vmemmap can not be allocated, we can not free folio to
> -	 * lower level allocator, so add back as hugetlb surplus page.
> -	 * add_hugetlb_folio() removes the page from THIS list.
> -	 * Use clear_dtor to note if vmemmap was successfully allocated for
> -	 * ANY page on the list.
> -	 */
> -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> -		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> +	if (!list_empty(non_hvo_folios)) {
> +		/*
> +		 * Free any restored hugetlb pages so that restore of the
> +		 * entire list can be retried.
> +		 * The idea is that in the common case of ENOMEM errors freeing
> +		 * hugetlb pages with vmemmap we will free up memory so that we
> +		 * can allocate vmemmap for more hugetlb pages.
> +		 */
> +		list_for_each_entry_safe(folio, t_folio, non_hvo_folios, lru) {
> +			list_del(&folio->lru);
> +			spin_lock_irq(&hugetlb_lock);
> +			__clear_hugetlb_destructor(h, folio);
> +			spin_unlock_irq(&hugetlb_lock);
> +			update_and_free_hugetlb_folio(h, folio, false);
> +			cond_resched();
> +		}
> +	} else {
> +		/*
> +		 * In the case where there are no folios which can be
> +		 * immediately freed, we loop through the list trying to restore
> +		 * vmemmap individually in the hope that someone elsewhere may
> +		 * have done something to cause success (such as freeing some
> +		 * memory).  If unable to restore a hugetlb page, the hugetlb
> +		 * page is made a surplus page and removed from the list.
> +		 * If are able to restore vmemmap and free one hugetlb page, we
> +		 * quit processing the list to retry the bulk operation.
> +		 */
> +		list_for_each_entry_safe(folio, t_folio, folio_list, lru)
>   			if (hugetlb_vmemmap_restore(h, &folio->page)) {

IIUC, the folio should be deleted from the folio list since this
huge page will be added to the free list (the list is corrupted),
right?

>   				spin_lock_irq(&hugetlb_lock);
>   				add_hugetlb_folio(h, folio, true);
>   				spin_unlock_irq(&hugetlb_lock);
> -			} else
> -				clear_dtor = true;
> -		}
> +			} else {
> +				list_del(&folio->lru);
> +				spin_lock_irq(&hugetlb_lock);
> +				__clear_hugetlb_destructor(h, folio);
> +				spin_unlock_irq(&hugetlb_lock);
> +				update_and_free_hugetlb_folio(h, folio, false);
> +				cond_resched();
> +				break;
> +			}
>   	}
> +}
> +
> +static void update_and_free_pages_bulk(struct hstate *h,
> +						struct list_head *folio_list)
> +{
> +	long ret;
> +	struct folio *folio, *t_folio;
> +	LIST_HEAD(non_hvo_folios);
>   
>   	/*
> -	 * If vmemmmap allocation was performed on any folio above, take lock
> -	 * to clear destructor of all folios on list.  This avoids the need to
> -	 * lock/unlock for each individual folio.
> -	 * The assumption is vmemmap allocation was performed on all or none
> -	 * of the folios on the list.  This is true expect in VERY rare cases.
> +	 * First allocate required vmemmmap (if necessary) for all folios.
> +	 * Carefully handle errors and free up any available hugetlb pages
> +	 * in an effort to make forward progress.
>   	 */
> -	if (clear_dtor) {
> +retry:
> +	ret = hugetlb_vmemmap_restore_folios(h, folio_list, &non_hvo_folios);
> +	if (ret < 0) {
> +		bulk_vmemmap_restore_error(h, folio_list, &non_hvo_folios);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * At this point, list should be empty, ret should be >= 0 and there
> +	 * should only be pages on the non_hvo_folios list.
> +	 * Do note that the non_hvo_folios list could be empty.
> +	 * Without HVO enabled, ret will be 0 and there is no need to call
> +	 * __clear_hugetlb_destructor as this was done previously.
> +	 */
> +	VM_WARN_ON(!list_empty(folio_list));
> +	VM_WARN_ON(ret < 0);
> +	if (!list_empty(&non_hvo_folios) && ret) {
>   		spin_lock_irq(&hugetlb_lock);
> -		list_for_each_entry(folio, list, lru)
> +		list_for_each_entry(folio, &non_hvo_folios, lru)
>   			__clear_hugetlb_destructor(h, folio);
>   		spin_unlock_irq(&hugetlb_lock);
>   	}
>   
> -	/*
> -	 * Free folios back to low level allocators.  vmemmap and destructors
> -	 * were taken care of above, so update_and_free_hugetlb_folio will
> -	 * not need to take hugetlb lock.
> -	 */
> -	list_for_each_entry_safe(folio, t_folio, list, lru) {
> +	list_for_each_entry_safe(folio, t_folio, &non_hvo_folios, lru) {
>   		update_and_free_hugetlb_folio(h, folio, false);
>   		cond_resched();
>   	}
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4558b814ffab..77f44b81ff01 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -480,6 +480,44 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/**
> + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> + * @h:			hstate.
> + * @folio_list:		list of folios.
> + * @non_hvo_folios:	Output list of folios for which vmemmap exists.
> + *
> + * Return: number of folios for which vmemmap was restored, or an error code
> + *		if an error was encountered restoring vmemmap for a folio.
> + *		Folios that have vmemmap are moved to the non_hvo_folios
> + *		list.  Processing of entries stops when the first error is
> + *		encountered. The folio that experienced the error and all
> + *		non-processed folios will remain on folio_list.
> + */
> +long hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios)
> +{
> +	struct folio *folio, *t_folio;
> +	long restored = 0;
> +	long ret = 0;
> +
> +	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
> +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> +			ret = hugetlb_vmemmap_restore(h, &folio->page);
> +			if (ret)
> +				break;
> +			restored++;
> +		}
> +
> +		/* Add non-optimized folios to output list */
> +		list_move(&folio->lru, non_hvo_folios);
> +	}
> +
> +	if (!ret)
> +		ret = restored;
> +	return ret;
> +}
> +
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index c512e388dbb4..0b7710f90e38 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -19,6 +19,9 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +long hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios);
>   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>   
> @@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>   	return 0;
>   }
>   
> +static long hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_hvo_folios)
> +{
> +	return 0;
> +}
> +
>   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   }

