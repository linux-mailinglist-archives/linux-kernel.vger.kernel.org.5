Return-Path: <linux-kernel+bounces-95184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC28874A59
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D187C286044
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 09:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8651082D67;
	Thu,  7 Mar 2024 09:07:31 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFA82D9A
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709802450; cv=none; b=RL9QDnlzNX2pzu2weQt/L4X5a435y3KxiOoxTXDMdZo2Vs1sO/To/ijslFVOOssa5MMyoz1+zOpq+ZSBYiJK6qM9H3TUgjk5XG7b4BEQXLyZPQ05ArLwytCNc8aDCKN8mMTZijA98xsFkqXyY/Q41/+WO39UolJ3D1ZdmuOKPMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709802450; c=relaxed/simple;
	bh=AgkkfzG87LppxT5Q6LyQ+aMtDy/BNdQl+oPCFnZzVgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rq756MCe3wjSnj1SEuMCfrI0vmIl6RVjSndjtOrhmQ4W1HCvrPFOXJ5r/CVacnBkWsPpd2acksvtyRz5+xxr6jK6ZbFLt1gEh6sWZ7Z8NScT8x3cCVzf+GifLjV8Kosh2jOF+rC0lxpYY643TA++BvfcuH+Gg8yCeSlhpBo+xtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AFA11FB;
	Thu,  7 Mar 2024 01:08:04 -0800 (PST)
Received: from [10.57.68.241] (unknown [10.57.68.241])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3BB813F762;
	Thu,  7 Mar 2024 01:07:24 -0800 (PST)
Message-ID: <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
Date: Thu, 7 Mar 2024 09:07:22 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] mm/madvise: enhance lazyfreeing with mTHP in
 madvise_free
Content-Language: en-GB
To: Barry Song <21cnbao@gmail.com>, Lance Yang <ioworker0@gmail.com>,
 david@redhat.com, Vishal Moola <vishal.moola@gmail.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, shy828301@gmail.com,
 mhocko@suse.com, fengwei.yin@intel.com, xiehuan09@gmail.com,
 wangkefeng.wang@huawei.com, songmuchun@bytedance.com, peterx@redhat.com,
 minchan@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2024 08:10, Barry Song wrote:
> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>
>> Hey Barry,
>>
>> Thanks for taking time to review!
>>
>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>
>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>
>> [...]
>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>> +                                                struct folio *folio, pte_t *start_pte)
>>>> +{
>>>> +       int nr_pages = folio_nr_pages(folio);
>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>> +
>>>> +       for (int i = 0; i < nr_pages; i++)
>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)
>>>> +                       return false;
>>>
>>> we have moved to folio_estimated_sharers though it is not precise, so
>>> we don't do
>>> this check with lots of loops and depending on the subpage's mapcount.
>>
>> If we don't check the subpage’s mapcount, and there is a cow folio associated
>> with this folio and the cow folio has smaller size than this folio,
>> should we still
>> mark this folio as lazyfree?
> 
> I agree, this is true. However, we've somehow accepted the fact that
> folio_likely_mapped_shared
> can result in false negatives or false positives to balance the
> overhead.  So I really don't know :-)
> 
> Maybe David and Vishal can give some comments here.
> 
>>
>>> BTW, do we need to rebase our work against David's changes[1]?
>>> [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.com/
>>
>> Yes, we should rebase our work against David’s changes.
>>
>>>
>>>> +
>>>> +       return nr_pages == folio_pte_batch(folio, addr, start_pte,
>>>> +                                        ptep_get(start_pte), nr_pages, flags, NULL);
>>>> +}
>>>> +
>>>>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>                                 unsigned long end, struct mm_walk *walk)
>>>>
>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>                  */
>>>>                 if (folio_test_large(folio)) {
>>>>                         int err;
>>>> +                       unsigned long next_addr, align;
>>>>
>>>> -                       if (folio_estimated_sharers(folio) != 1)
>>>> -                               break;
>>>> -                       if (!folio_trylock(folio))
>>>> -                               break;
>>>> +                       if (folio_estimated_sharers(folio) != 1 ||
>>>> +                           !folio_trylock(folio))
>>>> +                               goto skip_large_folio;
>>>
>>>
>>> I don't think we can skip all the PTEs for nr_pages, as some of them might be
>>> pointing to other folios.
>>>
>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
>>> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
>>> and PTE16 will point to two different small folios. We can only skip when we
>>> are sure nr_pages == folio_pte_batch() is sure.
>>
>> Agreed. Thanks for pointing that out.
>>
>>>
>>>> +
>>>> +                       align = folio_nr_pages(folio) * PAGE_SIZE;
>>>> +                       next_addr = ALIGN_DOWN(addr + align, align);
>>>> +
>>>> +                       /*
>>>> +                        * If we mark only the subpages as lazyfree, or
>>>> +                        * cannot mark the entire large folio as lazyfree,
>>>> +                        * then just split it.
>>>> +                        */
>>>> +                       if (next_addr > end || next_addr - addr != align ||
>>>> +                           !can_mark_large_folio_lazyfree(addr, folio, pte))
>>>> +                               goto split_large_folio;
>>>> +
>>>> +                       /*
>>>> +                        * Avoid unnecessary folio splitting if the large
>>>> +                        * folio is entirely within the given range.
>>>> +                        */
>>>> +                       folio_clear_dirty(folio);
>>>> +                       folio_unlock(folio);
>>>> +                       for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
>>>> +                               ptent = ptep_get(pte);
>>>> +                               if (pte_young(ptent) || pte_dirty(ptent)) {
>>>> +                                       ptent = ptep_get_and_clear_full(
>>>> +                                               mm, addr, pte, tlb->fullmm);
>>>> +                                       ptent = pte_mkold(ptent);
>>>> +                                       ptent = pte_mkclean(ptent);
>>>> +                                       set_pte_at(mm, addr, pte, ptent);
>>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>> +                               }
>>>
>>> Can we do this in batches? for a CONT-PTE mapped large folio, you are unfolding
>>> and folding again. It seems quite expensive.

I'm not convinced we should be doing this in batches. We want the initial
folio_pte_batch() to be as loose as possible regarding permissions so that we
reduce our chances of splitting folios to the min. (e.g. ignore SW bits like
soft dirty, etc). I think it might be possible that some PTEs are RO and other
RW too (e.g. due to cow - although with the current cow impl, probably not. But
its fragile to assume that). Anyway, if we do an initial batch that ignores all
that then do this bit as a batch, you will end up smeering all the ptes with
whatever properties were set on the first pte, which probably isn't right.

I've done a similar conversion for madvise_cold_or_pageout_pte_range() as part
of my swap-out series v4 (hoping to post imminently, but still working out a
latent bug that it triggers). I use ptep_test_and_clear_young() in that, which
arm64 can apply per-pte but avoid doing a contpte unfold/fold. I know you have
to clear dirty here too, but I think this pattern is preferable.

FYI, my swap-out series also halfway-batches madvise_free_pte_range() so that I
can batch free_swap_and_cache() for the swap entry case. Ideally the work you
are doing here would be rebased on top of that and plug-in to the approach
implemented there. (subject to others' views of course).

I'll cc you when I post it.

>>
>> Thanks for your suggestion. I'll do this in batches in v3.
>>
>> Thanks again for your time!
>>
>> Best,
>> Lance
>>
>>>
>>>> +                       }
>>>> +                       folio_mark_lazyfree(folio);
>>>> +                       goto next_folio;
>>>> +
>>>> +split_large_folio:
>>>>                         folio_get(folio);
>>>>                         arch_leave_lazy_mmu_mode();
>>>>                         pte_unmap_unlock(start_pte, ptl);
>>>> @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>                         err = split_folio(folio);
>>>>                         folio_unlock(folio);
>>>>                         folio_put(folio);
>>>> -                       if (err)
>>>> -                               break;
>>>> -                       start_pte = pte =
>>>> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
>>>> -                       if (!start_pte)
>>>> -                               break;
>>>> -                       arch_enter_lazy_mmu_mode();
>>>> +
>>>> +                       /*
>>>> +                        * If the large folio is locked or cannot be split,
>>>> +                        * we just skip it.
>>>> +                        */
>>>> +                       if (err) {
>>>> +skip_large_folio:
>>>> +                               if (next_addr >= end)
>>>> +                                       break;
>>>> +                               pte += (next_addr - addr) / PAGE_SIZE;
>>>> +                               addr = next_addr;
>>>> +                       }
>>>> +
>>>> +                       if (!start_pte) {
>>>> +                               start_pte = pte = pte_offset_map_lock(
>>>> +                                       mm, pmd, addr, &ptl);
>>>> +                               if (!start_pte)
>>>> +                                       break;
>>>> +                               arch_enter_lazy_mmu_mode();
>>>> +                       }
>>>> +
>>>> +next_folio:
>>>>                         pte--;
>>>>                         addr -= PAGE_SIZE;
>>>>                         continue;
>>>> --
>>>> 2.33.1
>>>>
> 
> Thanks
> Barry


