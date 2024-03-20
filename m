Return-Path: <linux-kernel+bounces-109243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 578B78816AA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:39:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3F11C21EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 764116A8D0;
	Wed, 20 Mar 2024 17:38:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19AD96A356
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710956326; cv=none; b=DR96znRht+jQjsxni7L2QUYmoOrfvcXB9UhCa/aVC4T1podaxQ9G4Bl5IKIfGEoDZsu563/hI/Tvgsiq0W7Caycotrh+lkI/5Sh73Zu7Dfuk2Q6B0/97YZbYc4DpbB2zCMgIQ54irNb9OqJqZD49P94uWrMO1B5wcSSr9TpWArA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710956326; c=relaxed/simple;
	bh=ePy62vu0kSRlAahnvRvjpqeJSzN19MRAOAXe1teby0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NGagjWxu7qmzrFsY7HydHK5Dbr6oGfLx3qsqqCVfr9Mx5PVyzkEfELOBTayD7vopiIDYvNHRlSdriTksaer4Us+41eCctae4Aw1O3XOoiuc4Dk8LGuYLqSdlGIc1TbxqT9qcegtBMKM63341qelar0X+lg9pqi1Lp3FkNME0Xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BC3B11007;
	Wed, 20 Mar 2024 10:39:17 -0700 (PDT)
Received: from [10.57.72.78] (unknown [10.57.72.78])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD8513F762;
	Wed, 20 Mar 2024 10:38:40 -0700 (PDT)
Message-ID: <add3b9fc-f08a-4bd4-b01e-4409e81d5a2d@arm.com>
Date: Wed, 20 Mar 2024 17:38:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] mm: madvise: Avoid split during MADV_PAGEOUT and
 MADV_COLD
Content-Language: en-GB
To: Lance Yang <ioworker0@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, Andrew Morton
 <akpm@linux-foundation.org>, David Hildenbrand <david@redhat.com>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Chris Li <chrisl@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240311150058.1122862-1-ryan.roberts@arm.com>
 <20240311150058.1122862-7-ryan.roberts@arm.com>
 <CAGsJ_4wpjqRsn7ouO=Ut9oMBLSh803=XuSPX6gJ5nQ3jyqh3hQ@mail.gmail.com>
 <a75ec640-d025-45ee-b74d-305aaa3cc1ce@arm.com>
 <CAK1f24k1AuHDdrLFNLvwdoOy=xJTVkVdfY4+SN+KW5-EiMSa9Q@mail.gmail.com>
 <7ba06704-2090-4eb2-9534-c4d467cc085a@arm.com>
 <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAK1f24=yDVwOC31sNMaoZ6K2q1X8vA7p4CtS7nW5WXCm19iEdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 20/03/2024 14:35, Lance Yang wrote:
> On Wed, Mar 20, 2024 at 9:49 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> Hi Lance, Barry,
>>
>> Sorry - I totally missed this when you originally sent it!
> 
> No worries at all :)
> 
>>
>>
>> On 13/03/2024 14:02, Lance Yang wrote:
>>> On Wed, Mar 13, 2024 at 5:03 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>
>>>> On 13/03/2024 07:19, Barry Song wrote:
>>>>> On Tue, Mar 12, 2024 at 4:01 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>
>>>>>> Rework madvise_cold_or_pageout_pte_range() to avoid splitting any large
>>>>>> folio that is fully and contiguously mapped in the pageout/cold vm
>>>>>> range. This change means that large folios will be maintained all the
>>>>>> way to swap storage. This both improves performance during swap-out, by
>>>>>> eliding the cost of splitting the folio, and sets us up nicely for
>>>>>> maintaining the large folio when it is swapped back in (to be covered in
>>>>>> a separate series).
>>>>>>
>>>>>> Folios that are not fully mapped in the target range are still split,
>>>>>> but note that behavior is changed so that if the split fails for any
>>>>>> reason (folio locked, shared, etc) we now leave it as is and move to the
>>>>>> next pte in the range and continue work on the proceeding folios.
>>>>>> Previously any failure of this sort would cause the entire operation to
>>>>>> give up and no folios mapped at higher addresses were paged out or made
>>>>>> cold. Given large folios are becoming more common, this old behavior
>>>>>> would have likely lead to wasted opportunities.
>>>>>>
>>>>>> While we are at it, change the code that clears young from the ptes to
>>>>>> use ptep_test_and_clear_young(), which is more efficent than
>>>>>> get_and_clear/modify/set, especially for contpte mappings on arm64,
>>>>>> where the old approach would require unfolding/refolding and the new
>>>>>> approach can be done in place.
>>>>>>
>>>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>>>
>>>>> This looks so much better than our initial RFC.
>>>>> Thank you for your excellent work!
>>>>
>>>> Thanks - its a team effort - I had your PoC and David's previous batching work
>>>> to use as a template.
>>>>
>>>>>
>>>>>> ---
>>>>>>  mm/madvise.c | 89 ++++++++++++++++++++++++++++++----------------------
>>>>>>  1 file changed, 51 insertions(+), 38 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>>>> index 547dcd1f7a39..56c7ba7bd558 100644
>>>>>> --- a/mm/madvise.c
>>>>>> +++ b/mm/madvise.c
>>>>>> @@ -336,6 +336,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>         LIST_HEAD(folio_list);
>>>>>>         bool pageout_anon_only_filter;
>>>>>>         unsigned int batch_count = 0;
>>>>>> +       int nr;
>>>>>>
>>>>>>         if (fatal_signal_pending(current))
>>>>>>                 return -EINTR;
>>>>>> @@ -423,7 +424,8 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>                 return 0;
>>>>>>         flush_tlb_batched_pending(mm);
>>>>>>         arch_enter_lazy_mmu_mode();
>>>>>> -       for (; addr < end; pte++, addr += PAGE_SIZE) {
>>>>>> +       for (; addr < end; pte += nr, addr += nr * PAGE_SIZE) {
>>>>>> +               nr = 1;
>>>>>>                 ptent = ptep_get(pte);
>>>>>>
>>>>>>                 if (++batch_count == SWAP_CLUSTER_MAX) {
>>>>>> @@ -447,55 +449,66 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
>>>>>>                         continue;
>>>>>>
>>>>>>                 /*
>>>>>> -                * Creating a THP page is expensive so split it only if we
>>>>>> -                * are sure it's worth. Split it if we are only owner.
>>>>>> +                * If we encounter a large folio, only split it if it is not
>>>>>> +                * fully mapped within the range we are operating on. Otherwise
>>>>>> +                * leave it as is so that it can be swapped out whole. If we
>>>>>> +                * fail to split a folio, leave it in place and advance to the
>>>>>> +                * next pte in the range.
>>>>>>                  */
>>>>>>                 if (folio_test_large(folio)) {
>>>>>> -                       int err;
>>>>>> -
>>>>>> -                       if (folio_estimated_sharers(folio) > 1)
>>>>>> -                               break;
>>>>>> -                       if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>>>> -                               break;
>>>>>> -                       if (!folio_trylock(folio))
>>>>>> -                               break;
>>>>>> -                       folio_get(folio);
>>>>>> -                       arch_leave_lazy_mmu_mode();
>>>>>> -                       pte_unmap_unlock(start_pte, ptl);
>>>>>> -                       start_pte = NULL;
>>>>>> -                       err = split_folio(folio);
>>>>>> -                       folio_unlock(folio);
>>>>>> -                       folio_put(folio);
>>>>>> -                       if (err)
>>>>>> -                               break;
>>>>>> -                       start_pte = pte =
>>>>>> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
>>>>>> -                       if (!start_pte)
>>>>>> -                               break;
>>>>>> -                       arch_enter_lazy_mmu_mode();
>>>>>> -                       pte--;
>>>>>> -                       addr -= PAGE_SIZE;
>>>>>> -                       continue;
>>>>>> +                       const fpb_t fpb_flags = FPB_IGNORE_DIRTY |
>>>>>> +                                               FPB_IGNORE_SOFT_DIRTY;
>>>>>> +                       int max_nr = (end - addr) / PAGE_SIZE;
>>>>>> +
>>>>>> +                       nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>>>>>> +                                            fpb_flags, NULL);
>>>>>
>>>>> I wonder if we have a quick way to avoid folio_pte_batch() if users
>>>>> are doing madvise() on a portion of a large folio.
>>>>
>>>> Good idea. Something like this?:
>>>>
>>>>         if (pte_pfn(pte) == folio_pfn(folio)
>>>>                 nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>>>>                                      fpb_flags, NULL);
>>>>
>>>> If we are not mapping the first page of the folio, then it can't be a full
>>>> mapping, so no need to call folio_pte_batch(). Just split it.
>>>
>>>                  if (folio_test_large(folio)) {
>>> [...]
>>>                        nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>>>                                             fpb_flags, NULL);
>>> +                       if (folio_estimated_sharers(folio) > 1)
>>> +                               continue;
>>>
>>> Could we use folio_estimated_sharers as an early exit point here?
>>
>> I'm not sure what this is saving where you have it? Did you mean to put it
>> before folio_pte_batch()? Currently it is just saving a single conditional.
> 
> Apologies for the confusion. I made a diff to provide clarity.
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 56c7ba7bd558..c3458fdea82a 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -462,12 +462,11 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
> 
>                         nr = folio_pte_batch(folio, addr, pte, ptent, max_nr,
>                                              fpb_flags, NULL);
> -
> // Could we use folio_estimated_sharers as an early exit point here?
> +                       if (folio_estimated_sharers(folio) > 1)
> +                               continue;
>                         if (nr < folio_nr_pages(folio)) {
>                                 int err;
> 
> -                               if (folio_estimated_sharers(folio) > 1)
> -                                       continue;
>                                 if (pageout_anon_only_filter &&
> !folio_test_anon(folio))
>                                         continue;
>                                 if (!folio_trylock(folio))


I'm still not really getting it; with my code, if nr < the folio size, we will
try to split and if we estimate that the folio is not exclusive we will avoid
locking the folio, etc. If nr == folio size, we will proceed to the precise
exclusivity check (which is cheap once we know the folio is fully mapped by this
process).

With your change, we will always do the estimated exclusive check then proceed
to the precise check; seems like duplication to me?

> 
>>
>> But now that I think about it a bit more, I remember why I was originally
>> unconditionally calling folio_pte_batch(). Given its a large folio, if the split
>> fails, we can move the cursor to the pte where the next folio begins so we don't
>> have to iterate through one pte at a time which would cause us to keep calling
>> folio_estimated_sharers(), folio_test_anon(), etc on the same folio until we get
>> to the next boundary.
>>
>> Of course the common case at this point will be for the split to succeed, but
>> then we are going to iterate over ever single PTE anyway - one way or another
>> they are all fetched into cache. So I feel like its neater not to add the
>> conditionals for calling folio_pte_batch(), and just leave this as I have it here.
>>
>>>
>>>                        if (nr < folio_nr_pages(folio)) {
>>>                                int err;
>>>
>>> -                               if (folio_estimated_sharers(folio) > 1)
>>> -                                       continue;
>>> [...]
>>>
>>>>
>>>>>
>>>>>> +
>>>>>> +                       if (nr < folio_nr_pages(folio)) {
>>>>>> +                               int err;
>>>>>> +
>>>>>> +                               if (folio_estimated_sharers(folio) > 1)
>>>>>> +                                       continue;
>>>>>> +                               if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>>>> +                                       continue;
>>>>>> +                               if (!folio_trylock(folio))
>>>>>> +                                       continue;
>>>>>> +                               folio_get(folio);
>>>>>> +                               arch_leave_lazy_mmu_mode();
>>>>>> +                               pte_unmap_unlock(start_pte, ptl);
>>>>>> +                               start_pte = NULL;
>>>>>> +                               err = split_folio(folio);
>>>>>> +                               folio_unlock(folio);
>>>>>> +                               folio_put(folio);
>>>>>> +                               if (err)
>>>>>> +                                       continue;
>>>>>> +                               start_pte = pte =
>>>>>> +                                       pte_offset_map_lock(mm, pmd, addr, &ptl);
>>>>>> +                               if (!start_pte)
>>>>>> +                                       break;
>>>>>> +                               arch_enter_lazy_mmu_mode();
>>>>>> +                               nr = 0;
>>>>>> +                               continue;
>>>>>> +                       }
>>>>>>                 }
>>>>>>
>>>>>>                 /*
>>>>>>                  * Do not interfere with other mappings of this folio and
>>>>>> -                * non-LRU folio.
>>>>>> +                * non-LRU folio. If we have a large folio at this point, we
>>>>>> +                * know it is fully mapped so if its mapcount is the same as its
>>>>>> +                * number of pages, it must be exclusive.
>>>>>>                  */
>>>>>> -               if (!folio_test_lru(folio) || folio_mapcount(folio) != 1)
>>>>>> +               if (!folio_test_lru(folio) ||
>>>>>> +                   folio_mapcount(folio) != folio_nr_pages(folio))
>>>>>>                         continue;
>>>>>
>>>>> This looks so perfect and is exactly what I wanted to achieve.
>>>>>
>>>>>>
>>>>>>                 if (pageout_anon_only_filter && !folio_test_anon(folio))
>>>>>>                         continue;
>>>>>>
>>>>>> -               VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
>>>>>> -
>>>>>> -               if (!pageout && pte_young(ptent)) {
>>>>>> -                       ptent = ptep_get_and_clear_full(mm, addr, pte,
>>>>>> -                                                       tlb->fullmm);
>>>>>> -                       ptent = pte_mkold(ptent);
>>>>>> -                       set_pte_at(mm, addr, pte, ptent);
>>>>>> -                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>> +               if (!pageout) {
>>>>>> +                       for (; nr != 0; nr--, pte++, addr += PAGE_SIZE) {
>>>>>> +                               if (ptep_test_and_clear_young(vma, addr, pte))
>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>
>>> IIRC, some of the architecture(ex, PPC) don't update TLB with set_pte_at and
>>> tlb_remove_tlb_entry. So, didn't we consider remapping the PTE with old after
>>> pte clearing?
>>
>> Sorry Lance, I don't understand this question, can you rephrase? Are you saying
>> there is a good reason to do the original clear-mkold-set for some arches?
> 
> IIRC, some of the architecture(ex, PPC)  don't update TLB with
> ptep_test_and_clear_young()
> and tlb_remove_tlb_entry().

Err, I assumed tlb_remove_tlb_entry() meant "invalidate the TLB entry for this
address please" - albeit its deferred and batched. I'll look into this.

> 
> In my new patch[1], I use refresh_full_ptes() and
> tlb_remove_tlb_entries() to batch-update the
> access and dirty bits.

I want to avoid the per-pte clear-modify-set approach, because this doesn't
perform well on arm64 when using contpte mappings; it will cause the contpe
mapping to be unfolded by the first clear that touches the contpte block, then
refolded by the last set to touch the block. That's expensive.
ptep_test_and_clear_young() doesn't suffer that problem.

> 
> [1] https://lore.kernel.org/linux-mm/20240316102952.39233-1-ioworker0@gmail.com
> 
> Thanks,
> Lance
> 
>>
>>>
>>> Thanks,
>>> Lance
>>>
>>>
>>>
>>>>>> +                       }
>>>>>
>>>>> This looks so smart. if it is not pageout, we have increased pte
>>>>> and addr here; so nr is 0 and we don't need to increase again in
>>>>> for (; addr < end; pte += nr, addr += nr * PAGE_SIZE)
>>>>>
>>>>> otherwise, nr won't be 0. so we will increase addr and
>>>>> pte by nr.
>>>>
>>>> Indeed. I'm hoping that Lance is able to follow a similar pattern for
>>>> madvise_free_pte_range().
>>>>
>>>>
>>>>>
>>>>>
>>>>>>                 }
>>>>>>
>>>>>>                 /*
>>>>>> --
>>>>>> 2.25.1
>>>>>>
>>>>>
>>>>> Overall, LGTM,
>>>>>
>>>>> Reviewed-by: Barry Song <v-songbaohua@oppo.com>
>>>>
>>>> Thanks!
>>>>
>>>>
>>


