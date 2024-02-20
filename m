Return-Path: <linux-kernel+bounces-73638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404A85C55F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 21:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598401C21B05
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C699677656;
	Tue, 20 Feb 2024 20:03:34 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F0037142
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 20:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708459414; cv=none; b=B6kzEojBNxZfJddctX0pz6T4YNX7XcjLcljp7zFb75A7xgsCnmRAHaasWl8lmQxmg9S3FZbN5BlAGQuUSSAe7onVFl+pq9J8N9+7ZSklvwNT7Z/nMRi7Xipajt7juRqYUkYXUKu2b9qd2vr+KLSmn1PvbV0cEhM1sf63RHXc+/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708459414; c=relaxed/simple;
	bh=mIBBW5MTEwUSwvkf52s1+6LrKwiyQolUWvpKHDVhev0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OguUNIfPhHRHlSQ1lh/M8XQSpsLJ5JeQ/qY8XeBj1eztrffLtfhc/35yDNUUXpDBbZca1DxregFBHYLSyw+lsQU8u6MazyncH/9Ail7ZI+kbLN9GTr55HIWt/L3GLvOhkpGyogF7SGvR6ETyWiKdlT8b5IC3fHANT8Q8hN0lZwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EF6BDFEC;
	Tue, 20 Feb 2024 12:04:09 -0800 (PST)
Received: from [172.20.10.9] (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E11563F73F;
	Tue, 20 Feb 2024 12:03:27 -0800 (PST)
Message-ID: <0502bec8-d2a3-4c76-8414-0f65fd7ddc32@arm.com>
Date: Tue, 20 Feb 2024 21:03:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] mm: swap: Swap-out small-sized THP without
 splitting
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhocko@suse.com,
 shy828301@gmail.com, wangkefeng.wang@huawei.com, willy@infradead.org,
 xiang@kernel.org, ying.huang@intel.com, yuzhao@google.com,
 chrisl@kernel.org, surenb@google.com, hanchuanhua@oppo.com
References: <20231025144546.577640-5-ryan.roberts@arm.com>
 <20240205095155.7151-1-v-songbaohua@oppo.com>
 <d4f602db-403b-4b1f-a3de-affeb40bc499@arm.com>
 <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wo7BiJWSKb1K_WyAai30KmfckMQ3-mCJPXZ892CtXpyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/02/2024 23:40, Barry Song wrote:
> On Tue, Feb 6, 2024 at 1:14 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 05/02/2024 09:51, Barry Song wrote:
>>> +Chris, Suren and Chuanhua
>>>
>>> Hi Ryan,
>>>
>>>> +    /*
>>>> +     * __scan_swap_map_try_ssd_cluster() may drop si->lock during discard,
>>>> +     * so indicate that we are scanning to synchronise with swapoff.
>>>> +     */
>>>> +    si->flags += SWP_SCANNING;
>>>> +    ret = __scan_swap_map_try_ssd_cluster(si, &offset, &scan_base, order);
>>>> +    si->flags -= SWP_SCANNING;
>>>
>>> nobody is using this scan_base afterwards. it seems a bit weird to
>>> pass a pointer.
>>>
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -1212,11 +1212,13 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
>>>>                                      if (!can_split_folio(folio, NULL))
>>>>                                              goto activate_locked;
>>>>                                      /*
>>>> -                                     * Split folios without a PMD map right
>>>> -                                     * away. Chances are some or all of the
>>>> -                                     * tail pages can be freed without IO.
>>>> +                                     * Split PMD-mappable folios without a
>>>> +                                     * PMD map right away. Chances are some
>>>> +                                     * or all of the tail pages can be freed
>>>> +                                     * without IO.
>>>>                                       */
>>>> -                                    if (!folio_entire_mapcount(folio) &&
>>>> +                                    if (folio_test_pmd_mappable(folio) &&
>>>> +                                        !folio_entire_mapcount(folio) &&
>>>>                                          split_folio_to_list(folio,
>>>>                                                              folio_list))
>>>>                                              goto activate_locked;
>>>> --
>>>
>>> Chuanhua and I ran this patchset for a couple of days and found a race
>>> between reclamation and split_folio. this might cause applications get
>>> wrong data 0 while swapping-in.
>>>
>>> in case one thread(T1) is reclaiming a large folio by some means, still
>>> another thread is calling madvise MADV_PGOUT(T2). and at the same time,
>>> we have two threads T3 and T4 to swap-in in parallel. T1 doesn't split
>>> and T2 does split as below,
>>>
>>> static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>                                 unsigned long addr, unsigned long end,
>>>                                 struct mm_walk *walk)
>>> {
>>>
>>>                 /*
>>>                  * Creating a THP page is expensive so split it only if we
>>>                  * are sure it's worth. Split it if we are only owner.
>>>                  */
>>>                 if (folio_test_large(folio)) {
>>>                         int err;
>>>
>>>                         if (folio_estimated_sharers(folio) != 1)
>>>                                 break;
>>>                         if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>                                 break;
>>>                         if (!folio_trylock(folio))
>>>                                 break;
>>>                         folio_get(folio);
>>>                         arch_leave_lazy_mmu_mode();
>>>                         pte_unmap_unlock(start_pte, ptl);
>>>                         start_pte = NULL;
>>>                         err = split_folio(folio);
>>>                         folio_unlock(folio);
>>>                         folio_put(folio);
>>>                         if (err)
>>>                                 break;
>>>                         start_pte = pte =
>>>                                 pte_offset_map_lock(mm, pmd, addr, &ptl);
>>>                         if (!start_pte)
>>>                                 break;
>>>                         arch_enter_lazy_mmu_mode();
>>>                         pte--;
>>>                         addr -= PAGE_SIZE;
>>>                         continue;
>>>                 }
>>>
>>>         return 0;
>>> }
>>>
>>>
>>>
>>> if T3 and T4 swap-in same page, and they both do swap_read_folio(). the
>>> first one of T3 and T4 who gets PTL will set pte, and the 2nd one will
>>> check pte_same() and find pte has been changed by another thread, thus
>>> goto out_nomap in do_swap_page.
>>> vm_fault_t do_swap_page(struct vm_fault *vmf)
>>> {
>>>         if (!folio) {
>>>                 if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
>>>                     __swap_count(entry) == 1) {
>>>                         /* skip swapcache */
>>>                         folio = vma_alloc_folio(GFP_HIGHUSER_MOVABLE, 0,
>>>                                                 vma, vmf->address, false);
>>>                         page = &folio->page;
>>>                         if (folio) {
>>>                                 __folio_set_locked(folio);
>>>                                 __folio_set_swapbacked(folio);
>>>
>>>                                 /* To provide entry to swap_read_folio() */
>>>                                 folio->swap = entry;
>>>                                 swap_read_folio(folio, true, NULL);
>>>                                 folio->private = NULL;
>>>                         }
>>>                 } else {
>>>                 }
>>>
>>>
>>>         /*
>>>          * Back out if somebody else already faulted in this pte.
>>>          */
>>>         vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
>>>                         &vmf->ptl);
>>>         if (unlikely(!vmf->pte || !pte_same(ptep_get(vmf->pte), vmf->orig_pte)))
>>>                 goto out_nomap;
>>>
>>>         swap_free(entry);
>>>         pte = mk_pte(page, vma->vm_page_prot);
>>>
>>>         set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
>>>         return ret;
>>> }
>>>
>>>
>>> while T1 and T2 is working in parallel, T2 will split folio. this can
>>> run into race with T1's reclamation without splitting. T2 will split
>>> a large folio into a couple of normal pages and reclaim them.
>>>
>>> If T3 finishes swap_read_folio and gets PTL earlier than T4, it calls
>>> set_pte and swap_free. this will cause zRAM to free the slot. then
>>> t4 will get zero data in swap_read_folio() as the below zRAM code
>>> will fill zero for freed slots,
>>>
>>> static int zram_read_from_zspool(struct zram *zram, struct page *page,
>>>                                  u32 index)
>>> {
>>>         ...
>>>
>>>         handle = zram_get_handle(zram, index);
>>>         if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
>>>                 unsigned long value;
>>>                 void *mem;
>>>
>>>                 value = handle ? zram_get_element(zram, index) : 0;
>>>                 mem = kmap_local_page(page);
>>>                 zram_fill_page(mem, PAGE_SIZE, value);
>>>                 kunmap_local(mem);
>>>                 return 0;
>>>         }
>>> }
>>>
>>> usually, after t3 frees swap and does set_pte, t4's pte_same becomes
>>> false, it won't set pte again. So filling zero data into freed slot
>>> by zRAM driver is not a problem at all. but the race is that T1 and
>>> T2 might do set swap to ptes twice as t1 doesn't split but t2 splits
>>> (splitted normal folios are also added into reclaim_list), thus, the
>>> corrupted zero data will get a chance to be set into PTE by t4 as t4
>>> reads the new PTE which is set secondly and has the same swap entry
>>> as its orig_pte after T3 has swapped-in and free the swap entry.
>>>
>>> we have worked around this problem by preventing T4 from splitting
>>> large folios and letting it goto skip the large folios entirely in
>>> MADV PAGEOUT once we detect a concurrent reclamation for this large
>>> folio.
>>>
>>> so my understanding is changing vmscan isn't sufficient to support
>>> large folio swap-out without splitting. we have to adjust madvise
>>> as well. we will have a fix for this problem in
>>> [PATCH RFC 6/6] mm: madvise: don't split mTHP for MADV_PAGEOUT
>>> https://lore.kernel.org/linux-mm/20240118111036.72641-7-21cnbao@gmail.com/
>>>
>>> But i feel this patch should be a part of your swap-out patchset rather
>>> than the swap-in series of Chuanhua and me :-)
>>
>> Hi Barry, Chuanhua,
>>
>> Thanks for the very detailed bug report! I'm going to have to take some time to
>> get my head around the details. But yes, I agree the fix needs to be part of the
>> swap-out series.
>>
> 
> Hi Ryan,
> I am running into some races especially while enabling large folio swap-out and
> swap-in both. some of them, i am still struggling with the detailed
> timing how they
> are happening.
> but the below change can help remove those bugs which cause corrupted data.

Thanks for the report! I'm out of office this week, but this is top of my todo
list starting next week, so hopefully will knock these into shape and repost
very soon.

Thanks,
Ryan

> 
> index da2aab219c40..ef9cfbc84760 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -1953,6 +1953,16 @@ static unsigned int shrink_folio_list(struct
> list_head *folio_list,
> 
>                         if (folio_test_pmd_mappable(folio))
>                                 flags |= TTU_SPLIT_HUGE_PMD;
> +                       /*
> +                        * make try_to_unmap_one hold ptl from the very first
> +                        * beginning if we are reclaiming a folio with multi-
> +                        * ptes. otherwise, we may only reclaim a part of the
> +                        * folio from the middle.
> +                        * for example, a parallel thread might temporarily
> +                        * set pte to none for various purposes.
> +                        */
> +                       else if (folio_test_large(folio))
> +                               flags |= TTU_SYNC;
> 
>                         try_to_unmap(folio, flags);
>                         if (folio_mapped(folio)) {
> 
> 
> While we are swapping-out a large folio, it has many ptes, we change those ptes
> to swap entries in try_to_unmap_one(). "while (page_vma_mapped_walk(&pvmw))"
> will iterate all ptes within the large folio. but it will only begin
> to acquire ptl when
> it meets a valid pte as below /* xxxxxxx */
> 
> static bool map_pte(struct page_vma_mapped_walk *pvmw, spinlock_t **ptlp)
> {
>         pte_t ptent;
> 
>         if (pvmw->flags & PVMW_SYNC) {
>                 /* Use the stricter lookup */
>                 pvmw->pte = pte_offset_map_lock(pvmw->vma->vm_mm, pvmw->pmd,
>                                                 pvmw->address, &pvmw->ptl);
>                 *ptlp = pvmw->ptl;
>                 return !!pvmw->pte;
>         }
> 
>        ...
>         pvmw->pte = pte_offset_map_nolock(pvmw->vma->vm_mm, pvmw->pmd,
>                                           pvmw->address, ptlp);
>         if (!pvmw->pte)
>                 return false;
> 
>         ptent = ptep_get(pvmw->pte);
> 
>         if (pvmw->flags & PVMW_MIGRATION) {
>                 if (!is_swap_pte(ptent))
>                         return false;
>         } else if (is_swap_pte(ptent)) {
>                 swp_entry_t entry;
>                 ...
>                 entry = pte_to_swp_entry(ptent);
>                 if (!is_device_private_entry(entry) &&
>                     !is_device_exclusive_entry(entry))
>                         return false;
>         } else if (!pte_present(ptent)) {
>                 return false;
>         }
>         pvmw->ptl = *ptlp;
>         spin_lock(pvmw->ptl);   /* xxxxxxx */
>         return true;
> }
> 
> 
> for various reasons,  for example, break-before-make for clearing access flags
> etc. pte can be set to none. since page_vma_mapped_walk() doesn't hold ptl
> from the beginning,  it might only begin to set swap entries from the middle of
> a large folio.
> 
> For example, in case a large folio has 16 ptes, and 0,1,2 are somehow zero
> in the intermediate stage of a break-before-make, ptl will be held
> from the 3rd pte,
> and swap entries will be set from 3rd pte as well. it seems not good as we are
> trying to swap out a large folio, but we are swapping out a part of them.
> 
> I am still struggling with all the timing of races, but using PVMW_SYNC to
> explicitly ask for ptl from the first pte seems a good thing for large folio
> regardless of those races. it can avoid try_to_unmap_one reading intermediate
> pte and further make the wrong decision since reclaiming pte-mapped large
> folios is atomic with just one pte.
> 
>> Sorry I haven't progressed this series as I had hoped. I've been concentrating
>> on getting the contpte series upstream. I'm hoping I will find some time to move
>> this series along by the tail end of Feb (hoping to get it in shape for v6.10).
>> Hopefully that doesn't cause you any big problems?
> 
> no worries. Anyway, we are already using your code to run various tests.
> 
>>
>> Thanks,
>> Ryan
> 
> Thanks
> Barry


