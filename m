Return-Path: <linux-kernel+bounces-95359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8B4C874CB3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:50:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9EF1F2350D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BD885644;
	Thu,  7 Mar 2024 10:50:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613FA85641
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 10:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709808645; cv=none; b=IYV5URDTJbYxxZliMWxCuhX+zNjC1e5vOtQe6nkfvDIeYYQG3Ce8DJ3L8KzjVw8hswIKBYxhv/q8693mo2JCGLs/H8SdKOX+ZENiuJeNhWsrjfCCnTJsP3u7In3h3PHumpNhXcRTgKXfUL7gka8ySoJFC0W/ccgDdko+bZ8+baI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709808645; c=relaxed/simple;
	bh=dLBWtzXmuxNb9Ha8327cbmKbIwdaV8Yc+gOYw2Ai4/0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gB/OgRJLG26bAT83ZY2K8L/tVIq4BLlkid0j75tqhcQ0pTq7fYun7t9A6zYQfunuUcmGL6t5aCyUxTbsRs9BaIMN09vSbfwnWhaI452L/FTBkaDgZ+4TPnLqb1Gp3uckIsOOidpPsuUHx4n1pSXq+sDFU40uVikfh7CZKZsV76k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6830C1FB;
	Thu,  7 Mar 2024 02:51:18 -0800 (PST)
Received: from [10.1.25.184] (XHFQ2J9959.cambridge.arm.com [10.1.25.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 245413F762;
	Thu,  7 Mar 2024 02:50:39 -0800 (PST)
Message-ID: <501c9f77-1459-467a-8619-78e86b46d300@arm.com>
Date: Thu, 7 Mar 2024 10:50:37 +0000
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
To: Barry Song <21cnbao@gmail.com>
Cc: Lance Yang <ioworker0@gmail.com>, david@redhat.com,
 Vishal Moola <vishal.moola@gmail.com>, akpm@linux-foundation.org,
 zokeefe@google.com, shy828301@gmail.com, mhocko@suse.com,
 fengwei.yin@intel.com, xiehuan09@gmail.com, wangkefeng.wang@huawei.com,
 songmuchun@bytedance.com, peterx@redhat.com, minchan@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240307061425.21013-1-ioworker0@gmail.com>
 <CAGsJ_4xcRvZGdpPh1qcFTnTnDUbwz6WreQ=L_UO+oU2iFm9EPg@mail.gmail.com>
 <CAK1f24k2G_DSEjuqqqPyY0f7+btpYbjfoyMH7btLfP8nkasCTQ@mail.gmail.com>
 <CAGsJ_4xREM-P1mFqeM-s3-cJ9czb6PXwizb-3hOhwaF6+QM5QA@mail.gmail.com>
 <03458c20-5544-411b-9b8d-b4600a9b802f@arm.com>
 <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4zp1MXTjG=4gBO+J3owg7sHDgDJ8Ut51i1RBSnKnK0BfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2024 09:33, Barry Song wrote:
> On Thu, Mar 7, 2024 at 10:07 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 07/03/2024 08:10, Barry Song wrote:
>>> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>
>>>> Hey Barry,
>>>>
>>>> Thanks for taking time to review!
>>>>
>>>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>
>>>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>
>>>> [...]
>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>>>> +                                                struct folio *folio, pte_t *start_pte)
>>>>>> +{
>>>>>> +       int nr_pages = folio_nr_pages(folio);
>>>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>>> +
>>>>>> +       for (int i = 0; i < nr_pages; i++)
>>>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)
>>>>>> +                       return false;
>>>>>
>>>>> we have moved to folio_estimated_sharers though it is not precise, so
>>>>> we don't do
>>>>> this check with lots of loops and depending on the subpage's mapcount.
>>>>
>>>> If we don't check the subpage’s mapcount, and there is a cow folio associated
>>>> with this folio and the cow folio has smaller size than this folio,
>>>> should we still
>>>> mark this folio as lazyfree?
>>>
>>> I agree, this is true. However, we've somehow accepted the fact that
>>> folio_likely_mapped_shared
>>> can result in false negatives or false positives to balance the
>>> overhead.  So I really don't know :-)
>>>
>>> Maybe David and Vishal can give some comments here.
>>>
>>>>
>>>>> BTW, do we need to rebase our work against David's changes[1]?
>>>>> [1] https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.com/
>>>>
>>>> Yes, we should rebase our work against David’s changes.
>>>>
>>>>>
>>>>>> +
>>>>>> +       return nr_pages == folio_pte_batch(folio, addr, start_pte,
>>>>>> +                                        ptep_get(start_pte), nr_pages, flags, NULL);
>>>>>> +}
>>>>>> +
>>>>>>  static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>                                 unsigned long end, struct mm_walk *walk)
>>>>>>
>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>                  */
>>>>>>                 if (folio_test_large(folio)) {
>>>>>>                         int err;
>>>>>> +                       unsigned long next_addr, align;
>>>>>>
>>>>>> -                       if (folio_estimated_sharers(folio) != 1)
>>>>>> -                               break;
>>>>>> -                       if (!folio_trylock(folio))
>>>>>> -                               break;
>>>>>> +                       if (folio_estimated_sharers(folio) != 1 ||
>>>>>> +                           !folio_trylock(folio))
>>>>>> +                               goto skip_large_folio;
>>>>>
>>>>>
>>>>> I don't think we can skip all the PTEs for nr_pages, as some of them might be
>>>>> pointing to other folios.
>>>>>
>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
>>>>> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
>>>>> and PTE16 will point to two different small folios. We can only skip when we
>>>>> are sure nr_pages == folio_pte_batch() is sure.
>>>>
>>>> Agreed. Thanks for pointing that out.
>>>>
>>>>>
>>>>>> +
>>>>>> +                       align = folio_nr_pages(folio) * PAGE_SIZE;
>>>>>> +                       next_addr = ALIGN_DOWN(addr + align, align);
>>>>>> +
>>>>>> +                       /*
>>>>>> +                        * If we mark only the subpages as lazyfree, or
>>>>>> +                        * cannot mark the entire large folio as lazyfree,
>>>>>> +                        * then just split it.
>>>>>> +                        */
>>>>>> +                       if (next_addr > end || next_addr - addr != align ||
>>>>>> +                           !can_mark_large_folio_lazyfree(addr, folio, pte))
>>>>>> +                               goto split_large_folio;
>>>>>> +
>>>>>> +                       /*
>>>>>> +                        * Avoid unnecessary folio splitting if the large
>>>>>> +                        * folio is entirely within the given range.
>>>>>> +                        */
>>>>>> +                       folio_clear_dirty(folio);
>>>>>> +                       folio_unlock(folio);
>>>>>> +                       for (; addr != next_addr; pte++, addr += PAGE_SIZE) {
>>>>>> +                               ptent = ptep_get(pte);
>>>>>> +                               if (pte_young(ptent) || pte_dirty(ptent)) {
>>>>>> +                                       ptent = ptep_get_and_clear_full(
>>>>>> +                                               mm, addr, pte, tlb->fullmm);
>>>>>> +                                       ptent = pte_mkold(ptent);
>>>>>> +                                       ptent = pte_mkclean(ptent);
>>>>>> +                                       set_pte_at(mm, addr, pte, ptent);
>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte, addr);
>>>>>> +                               }
>>>>>
>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, you are unfolding
>>>>> and folding again. It seems quite expensive.
>>
>> I'm not convinced we should be doing this in batches. We want the initial
>> folio_pte_batch() to be as loose as possible regarding permissions so that we
>> reduce our chances of splitting folios to the min. (e.g. ignore SW bits like
>> soft dirty, etc). I think it might be possible that some PTEs are RO and other
>> RW too (e.g. due to cow - although with the current cow impl, probably not. But
>> its fragile to assume that). Anyway, if we do an initial batch that ignores all
> 
> You are correct. I believe this scenario could indeed occur. For instance,
> if process A forks process B and then unmaps itself, leaving B as the
> sole process owning the large folio.  The current wp_page_reuse() function
> will reuse PTE one by one while the specific subpage is written. 

Hmm - I thought it would only reuse if the total mapcount for the folio was 1.
And since it is a large folio with each page mapped once in proc B, I thought
every subpage write would cause a copy except the last one? I haven't looked at
the code for a while. But I had it in my head that this is an area we need to
improve for mTHP.

> This can
> make a part of PTE writable while the others are read-only.
> 
>> that then do this bit as a batch, you will end up smeering all the ptes with
>> whatever properties were set on the first pte, which probably isn't right.
>>
>> I've done a similar conversion for madvise_cold_or_pageout_pte_range() as part
>> of my swap-out series v4 (hoping to post imminently, but still working out a
>> latent bug that it triggers). I use ptep_test_and_clear_young() in that, which
>> arm64 can apply per-pte but avoid doing a contpte unfold/fold. I know you have
>> to clear dirty here too, but I think this pattern is preferable.
> 
> nice to know ptep_test_and_clear_young() won't unfold and fold CONT-PTE.
> I probably have missed this part of your CONT-PTE series as I was quite busy
> with others :-)
> 
>>
>> FYI, my swap-out series also halfway-batches madvise_free_pte_range() so that I
>> can batch free_swap_and_cache() for the swap entry case. Ideally the work you
>> are doing here would be rebased on top of that and plug-in to the approach
>> implemented there. (subject to others' views of course).
>>
>> I'll cc you when I post it.
>>
>>>>
>>>> Thanks for your suggestion. I'll do this in batches in v3.
>>>>
>>>> Thanks again for your time!
>>>>
>>>> Best,
>>>> Lance
>>>>
>>>>>
>>>>>> +                       }
>>>>>> +                       folio_mark_lazyfree(folio);
>>>>>> +                       goto next_folio;
>>>>>> +
>>>>>> +split_large_folio:
>>>>>>                         folio_get(folio);
>>>>>>                         arch_leave_lazy_mmu_mode();
>>>>>>                         pte_unmap_unlock(start_pte, ptl);
>>>>>> @@ -688,13 +736,28 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>                         err = split_folio(folio);
>>>>>>                         folio_unlock(folio);
>>>>>>                         folio_put(folio);
>>>>>> -                       if (err)
>>>>>> -                               break;
>>>>>> -                       start_pte = pte =
>>>>>> -                               pte_offset_map_lock(mm, pmd, addr, &ptl);
>>>>>> -                       if (!start_pte)
>>>>>> -                               break;
>>>>>> -                       arch_enter_lazy_mmu_mode();
>>>>>> +
>>>>>> +                       /*
>>>>>> +                        * If the large folio is locked or cannot be split,
>>>>>> +                        * we just skip it.
>>>>>> +                        */
>>>>>> +                       if (err) {
>>>>>> +skip_large_folio:
>>>>>> +                               if (next_addr >= end)
>>>>>> +                                       break;
>>>>>> +                               pte += (next_addr - addr) / PAGE_SIZE;
>>>>>> +                               addr = next_addr;
>>>>>> +                       }
>>>>>> +
>>>>>> +                       if (!start_pte) {
>>>>>> +                               start_pte = pte = pte_offset_map_lock(
>>>>>> +                                       mm, pmd, addr, &ptl);
>>>>>> +                               if (!start_pte)
>>>>>> +                                       break;
>>>>>> +                               arch_enter_lazy_mmu_mode();
>>>>>> +                       }
>>>>>> +
>>>>>> +next_folio:
>>>>>>                         pte--;
>>>>>>                         addr -= PAGE_SIZE;
>>>>>>                         continue;
>>>>>> --
>>>>>> 2.33.1
>>>>>>
>>>
> 
> Thanks
>  Barry


