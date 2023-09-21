Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952577A971B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjIURLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjIURKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:08 -0400
Received: from out-214.mta0.migadu.com (out-214.mta0.migadu.com [91.218.175.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1859986B9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:32 -0700 (PDT)
Message-ID: <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695288716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pKhMatc/zWl01dwnOp27ljqTW92ejv5Ec290/gJM4Oc=;
        b=m0Jnoa2kFHdll+Nw+8YnTmeEIwb1Qj3RIrdsl47EiO7ljvbjft3oKzBWTirdSVRjMUHAU/
        K2XmHtNKpOqv0nt4wZZPC5TjLH2zn+oTFkXU06GdO711LpFzbh+H14uFT817248Qak9shi
        juAQiSFgXk8L27noIldHR/Y+88UFCm0=
Date:   Thu, 21 Sep 2023 17:31:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 4/8] hugetlb: perform vmemmap restoration on a list of
 pages
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
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
 <b9d03e01-7582-8ec9-d219-941184166835@linux.dev>
 <20230919205756.GB425719@monkey>
 <CED64A95-00E8-4B52-A77A-8B13D2795507@linux.dev>
 <2FDB2018-74AE-4514-9B43-01664A8E5DBF@linux.dev>
 <20230921011223.GC4065@monkey>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230921011223.GC4065@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/21 09:12, Mike Kravetz wrote:
> On 09/20/23 11:03, Muchun Song wrote:
>>> On Sep 20, 2023, at 10:56, Muchun Song <muchun.song@linux.dev> wrote:
>>>> On Sep 20, 2023, at 04:57, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>> On 09/19/23 17:52, Muchun Song wrote:
>>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>>>>
>>>>> I still think we should free a non-optimized HugeTLB page if we
>>>>> encounter an OOM situation instead of continue to restore
>>>>> vemmmap pages. Restoring vmemmmap pages will only aggravate
>>>>> the OOM situation. The suitable appraoch is to free a non-optimized
>>>>> HugeTLB page to satisfy our allocation of vmemmap pages, what's
>>>>> your opinion, Mike?
>>>> I agree.
>>>>
>>>> As you mentioned previously, this may complicate this code path a bit.
>>>> I will rewrite to make this happen.
>>> Maybe we could introduced two list passed to update_and_free_pages_bulk (this
>>> will be easy for the callers of it), one is for non-optimized huge page,
>>> another is optimized one. In update_and_free_pages_bulk, we could first
>>> free those non-optimized huge page, and then restore vemmmap pages for
>>> those optimized ones, in which case, the code could be simple.
>>> hugetlb_vmemmap_restore_folios() dose not need to add complexity, which
>>> still continue to restore vmemmap pages and will stop once we encounter
>>> an OOM situation.
> I am not sure if passing in optimized and non-optimized lists to
> update_and_free_pages_bulk will help much.  IIUC, it will almost always
> be the case where only one list has entries.  Is that mostly accurate?

I think you are right. It will be less helpful since most of
pages will be not optimized when HVO is enabled.

>> BTW, maybe we should try again iff there are some non-optimized huge page
>> whose vmemmap pages are restored successfully previously and could be freed
>> first, then continue to restore the vmemmap pages of the remaining huge pages.
>> I think the retry code could be done in update_and_free_pages_bulk() as well.
> I came up with a new routine to handle these ENOMEM returns from
> hugetlb_vmemmap_restore_folios.  I 'think' it handles these situations.
> Here is an updated version of this patch.  Sorry, diff makes it a bit
> hard to read.
>
>  From b13bdccb01730f995191944769f87d0725c289ad Mon Sep 17 00:00:00 2001
> From: Mike Kravetz <mike.kravetz@oracle.com>
> Date: Sun, 10 Sep 2023 16:14:50 -0700
> Subject: [PATCH] hugetlb: perform vmemmap restoration on a list of pages
>
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
> Special care must be taken when encountering a ENOMEM error from
> hugetlb_vmemmap_restore_folios.  We want to continue making as much
> forward progress as possible.  A new routine bulk_vmemmap_restore_enomem
> handles this specific situation.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 83 ++++++++++++++++++++++++++++++++++----------
>   mm/hugetlb_vmemmap.c | 39 +++++++++++++++++++++
>   mm/hugetlb_vmemmap.h | 11 ++++++
>   3 files changed, 115 insertions(+), 18 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 70fedf8682c4..52abe56cf38a 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1834,38 +1834,85 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
>   		schedule_work(&free_hpage_work);
>   }
>   
> -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +static void bulk_vmemmap_restore_enomem(struct hstate *h,
> +						struct list_head *list,
> +						unsigned long restored)
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
> +	if (restored) {
> +		/*
> +		 * On ENOMEM error, free any restored hugetlb pages so that
> +		 * restore of the entire list can be retried.
> +		 * The idea is that by freeing hugetlb pages with vmemmap
> +		 * (those previously restored) we will free up memory so that
> +		 * we can allocate vmemmap for more hugetlb pages.
> +		 * We must examine and possibly free EVERY hugetlb page on list
> +		 * in order to call hugetlb_vmemmap_restore_folios again.
> +		 * This is not optimal, but is an error case that should not
> +		 * happen frequently.
> +		 */
> +		list_for_each_entry_safe(folio, t_folio, list, lru)
> +			if (!folio_test_hugetlb_vmemmap_optimized(folio)) {
> +				list_del(&folio->lru);
> +				spin_lock_irq(&hugetlb_lock);
> +				__clear_hugetlb_destructor(h, folio);
> +				spin_unlock_irq(&hugetlb_lock);
> +				update_and_free_hugetlb_folio(h, folio, false);
> +				cond_resched();
> +			}
> +	} else {
> +		/*
> +		 * In the case where vmemmap was not restored for ANY folios,
> +		 * we loop through them trying to restore individually in the
> +		 * hope that someone elsewhere may free enough memory.
> +		 * If unable to restore a page, the hugetlb page is made a
> +		 * surplus page and removed from the list.
> +		 * If are able to restore vmemmap for one hugetlb page, we free
> +		 * it and quit processing the list to retry the bulk operation.
> +		 */
> +		list_for_each_entry_safe(folio, t_folio, list, lru)
>   			if (hugetlb_vmemmap_restore(h, &folio->page)) {
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
> +				break;
> +			}
>   	}
> +}
> +
> +static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +{
> +	int ret;
> +	unsigned long restored;
> +	struct folio *folio, *t_folio;
>   
>   	/*
> -	 * If vmemmmap allocation was performed on any folio above, take lock
> -	 * to clear destructor of all folios on list.  This avoids the need to
> +	 * First allocate required vmemmmap (if necessary) for all folios.
> +	 * Carefully handle ENOMEM errors and free up any available hugetlb
> +	 * pages in order to make forward progress.
> +	 */
> +retry:
> +	ret = hugetlb_vmemmap_restore_folios(h, list, &restored);
> +	if (ret == -ENOMEM) {
> +		bulk_vmemmap_restore_enomem(h, list, restored);
> +		goto retry;
> +	}
> +
> +	/*
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
> index 4558b814ffab..cc91edbfb68b 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -480,6 +480,45 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
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
> + *		Note that processing is stopped when first error is encountered.
> + */
> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					unsigned long *restored)

How about changing parameter of @restored to a list_head type which
returns the non-optimized (previously) or vmemmap-restored-sucessful 
huge pages?
In which case, the caller could traverse this returned list to free
them first like you have implemented in bulk_vmemmap_restore_enomem(),
it will be more efficient. The meaning of returned value should also
be changed accordingly since update_and_free_pages_bulk() wants to
whether there is a vmemmap-optimized huge page being restored sucessfully
to determine if it should clear hugetlb flag. So 
hugetlb_vmemmap_restore_folios()
could return how many huge pages being restored successful, if a negative
number is returned meaning there is some error in the process of restoring
of vmemmap.

Thanks.

> +{
> +	unsigned long num_restored;
> +	struct folio *folio;
> +	int ret = 0;
> +
> +	num_restored = 0;
> +	list_for_each_entry(folio, folio_list, lru) {
> +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {
> +			ret = hugetlb_vmemmap_restore(h, &folio->page);
> +			if (ret)
> +				goto out;
> +			else
> +				num_restored++;
> +		}
> +	}
> +
> +out:
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

