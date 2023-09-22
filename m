Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DB157AAC73
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 10:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232173AbjIVIT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 04:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbjIVITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 04:19:37 -0400
Received: from out-211.mta0.migadu.com (out-211.mta0.migadu.com [IPv6:2001:41d0:1004:224b::d3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5237CBB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 01:19:29 -0700 (PDT)
Message-ID: <7f222dae-c256-a625-6846-dd22e16687fb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1695370767;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=imHpJXjN7oTKFJS9REtYSyqNmmkpWVduPz1WiGdeDhQ=;
        b=aaqU6sR2Ls4axHOb/Ybmaf9uLXm07hG4eJMU3sKyN+oEFzI61M9Yp4tWEae7xyLZYHQXjC
        Ts3Y7eEeCyCQFA0hv0IgmszkamVHxn2C0wdntuxz+AybAfs3Ellb6XmL6ILM+9N/rl2Ca4
        0BtKTuYV12xdb+Gu3qGbUFEdJ1rvYfw=
Date:   Fri, 22 Sep 2023 16:19:17 +0800
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
 <306da2a1-0dd4-e858-930f-211947a466d2@linux.dev>
 <20230921215810.GA21193@monkey>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20230921215810.GA21193@monkey>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/9/22 05:58, Mike Kravetz wrote:
> On 09/21/23 17:31, Muchun Song wrote:
>>
>> On 2023/9/21 09:12, Mike Kravetz wrote:
>>> On 09/20/23 11:03, Muchun Song wrote:
>>>>> On Sep 20, 2023, at 10:56, Muchun Song <muchun.song@linux.dev> wrote:
>>>>>> On Sep 20, 2023, at 04:57, Mike Kravetz <mike.kravetz@oracle.com> wrote:
>>>>>> On 09/19/23 17:52, Muchun Song wrote:
>>>>>>> On 2023/9/19 07:01, Mike Kravetz wrote:
>>> +/**
>>> + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
>>> + * @h:		struct hstate.
>>> + * @folio_list:	list of folios.
>>> + * @restored:	Set to number of folios for which vmemmap was restored
>>> + *		successfully if caller passes a non-NULL pointer.
>>> + *
>>> + * Return: %0 if vmemmap exists for all folios on the list.  If an error is
>>> + *		encountered restoring vmemmap for ANY folio, an error code
>>> + *		will be returned to the caller.  It is then the responsibility
>>> + *		of the caller to check the hugetlb vmemmap optimized flag of
>>> + *		each folio to determine if vmemmap was actually restored.
>>> + *		Note that processing is stopped when first error is encountered.
>>> + */
>>> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
>>> +					struct list_head *folio_list,
>>> +					unsigned long *restored)
>> How about changing parameter of @restored to a list_head type which
>> returns the non-optimized (previously) or vmemmap-restored-sucessful huge
>> pages?
>> In which case, the caller could traverse this returned list to free
>> them first like you have implemented in bulk_vmemmap_restore_enomem(),
>> it will be more efficient. The meaning of returned value should also
>> be changed accordingly since update_and_free_pages_bulk() wants to
>> whether there is a vmemmap-optimized huge page being restored sucessfully
>> to determine if it should clear hugetlb flag. So
>> hugetlb_vmemmap_restore_folios()
>> could return how many huge pages being restored successful, if a negative
>> number is returned meaning there is some error in the process of restoring
>> of vmemmap.
>>
> I had similar thoughts.  An updated patch based on this approach is below.
> When creating the patch, I discovered that using the function return code
> for both number of vmemmap restored pages as well as error code was
> unnecessary.  Just checking !list_empty() of non-optimized pages tells us
> if any were restored or could be freed.

I also thought about this. But there is a little different. If HVO
is disabled, we will always clear the hugetlb flag twice since the
list couldn't be empty, I thought it is an optimization for HVO-disabled
case.

>
>  From b79f6eeb7a11644830bddfc43d2219c149d26405 Mon Sep 17 00:00:00 2001
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
> Special care must be taken when encountering an error from
> hugetlb_vmemmap_restore_folios.  We want to continue making as much
> forward progress as possible.  A new routine bulk_vmemmap_restore_error
> handles this specific situation.
>
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
> ---
>   mm/hugetlb.c         | 94 +++++++++++++++++++++++++++++++-------------
>   mm/hugetlb_vmemmap.c | 36 +++++++++++++++++
>   mm/hugetlb_vmemmap.h | 10 +++++
>   3 files changed, 112 insertions(+), 28 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 70fedf8682c4..11de3f885065 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1834,50 +1834,88 @@ static void update_and_free_hugetlb_folio(struct hstate *h, struct folio *folio,
>   		schedule_work(&free_hpage_work);
>   }
>   
> -static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +static void bulk_vmemmap_restore_error(struct hstate *h,
> +					struct list_head *list,
> +					struct list_head *non_op_folios)
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
> +	if (!list_empty(non_op_folios)) {
> +		/*
> +		 * Free any restored hugetlb pages so that restore of the
> +		 * entire list can be retried.
> +		 * The idea is that in the common case of ENOMEM errors freeing
> +		 * hugetlb pages with vmemmap we will free up memory so that we
> +		 * can allocate vmemmap for more hugetlb pages.
> +		 */
> +		list_for_each_entry_safe(folio, t_folio, non_op_folios, lru) {
> +			list_del(&folio->lru);
> +			spin_lock_irq(&hugetlb_lock);
> +			__clear_hugetlb_destructor(h, folio);
> +			spin_unlock_irq(&hugetlb_lock);
> +			update_and_free_hugetlb_folio(h, folio, false);
> +			cond_resched();
> +		}
> +	} else {
> +		/*
> +		 * In the case where vmemmap was not restored for ANY folios,
> +		 * we loop through them trying to restore individually in the
> +		 * hope that someone elsewhere may have done something to cause
> +		 * success (such as freeing some memory).
> +		 * If unable to restore a hugetlb page, the hugetlb page is
> +		 * made a surplus page and removed from the list.
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
> +				cond_resched();
> +				break;
> +			}
>   	}
> +}
> +
> +static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> +{
> +	int ret;
> +	LIST_HEAD(non_op_folio);
> +	struct folio *folio, *t_folio;
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
> +	ret = hugetlb_vmemmap_restore_folios(h, list, &non_op_folio);
> +	if (ret < 0) {
> +		bulk_vmemmap_restore_error(h, list, &non_op_folio);
> +		goto retry;
> +	}
> +
> +	/*
> +	 * At this point, list should be empty, and there should only be
> +	 * pages on the non_op_folio list.  free those entries.  Do note
> +	 * that the non_op_folio list could be empty.
> +	 */
> +	VM_WARN_ON(!list_empty(list));
> +	if (!list_empty(&non_op_folio)) {
>   		spin_lock_irq(&hugetlb_lock);
> -		list_for_each_entry(folio, list, lru)
> +		list_for_each_entry(folio, &non_op_folio, lru)
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
> +	list_for_each_entry_safe(folio, t_folio, &non_op_folio, lru) {
>   		update_and_free_hugetlb_folio(h, folio, false);
>   		cond_resched();
>   	}
> diff --git a/mm/hugetlb_vmemmap.c b/mm/hugetlb_vmemmap.c
> index 4558b814ffab..f827d4efcf8e 100644
> --- a/mm/hugetlb_vmemmap.c
> +++ b/mm/hugetlb_vmemmap.c
> @@ -480,6 +480,42 @@ int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head)
>   	return ret;
>   }
>   
> +/**
> + * hugetlb_vmemmap_restore_folios - restore vmemmap for every folio on the list.
> + * @h:			hstate.
> + * @folio_list:		list of folios.
> + * @non_op_list:	Output list of folio for which vmemmap exists.
> + *
> + * Return: %0 if vmemmap exists for all folios on the list and all entries have
> + *		been moved to non_op_list.  If an error is encountered restoring
> + *		vmemmap for ANY folio, an error code will be returned to the
> + *		caller.  Processing en entries stops when the first error is
> + *		encountered.  folios processed before the error with vmemmap
> + *		will reside on the non_op_list.  The folio that experienced the
> + *		error and all non-processed folios will remain on folio_list.
> + */
> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_op_list)

non_optimized_list or vmemmap_intact_list? The abbreviation is not 
straightforward.

> +{
> +	struct folio *folio, *t_folio;
> +	int ret = 0;
> +
> +	list_for_each_entry_safe(folio, t_folio, folio_list, lru) {
> +		if (folio_test_hugetlb_vmemmap_optimized(folio)) {

hugetlb_vmemmap_restore() has this check as well, so it is unnecessary here.

> +			ret = hugetlb_vmemmap_restore(h, &folio->page);
> +			if (ret)
> +				goto out;

Maybe we could drop the label ("out") and just breaking or returning from
here is enough.

> +		}
> +
> +		/* Add non-optimized folios to output list */
> +		list_move(&folio->lru, non_op_list);
> +	}
> +
> +out:
> +	return ret;
> +}
> +
>   /* Return true iff a HugeTLB whose vmemmap should and can be optimized. */
>   static bool vmemmap_should_optimize(const struct hstate *h, const struct page *head)
>   {
> diff --git a/mm/hugetlb_vmemmap.h b/mm/hugetlb_vmemmap.h
> index c512e388dbb4..e6378ae5c5b6 100644
> --- a/mm/hugetlb_vmemmap.h
> +++ b/mm/hugetlb_vmemmap.h
> @@ -19,6 +19,9 @@
>   
>   #ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
>   int hugetlb_vmemmap_restore(const struct hstate *h, struct page *head);
> +int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_op_folios);

It is better to keep 3rd name (non_op_folios) consistent with where it is
defined (it is non_op_list).

>   void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head);
>   void hugetlb_vmemmap_optimize_folios(struct hstate *h, struct list_head *folio_list);
>   
> @@ -45,6 +48,13 @@ static inline int hugetlb_vmemmap_restore(const struct hstate *h, struct page *h
>   	return 0;
>   }
>   
> +static int hugetlb_vmemmap_restore_folios(const struct hstate *h,
> +					struct list_head *folio_list,
> +					struct list_head *non_op_folios)
> +{
> +	return 0;
> +}
> +
>   static inline void hugetlb_vmemmap_optimize(const struct hstate *h, struct page *head)
>   {
>   }

