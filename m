Return-Path: <linux-kernel+bounces-97036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4224E8764B4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 656891C21B73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3661D545;
	Fri,  8 Mar 2024 13:05:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9126D17551
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709903109; cv=none; b=k4MIpSUQiA/L6k0Q2ZK++J9jCsMirX61LLL8v39LJsEcnSxR5T3qkPEWbw3afdBTfHnbQtTxqjcQrDBKskpW8A39LsgJoXSAIg9AjZuIK+K1h+taR8NF5wGMv19WVtk2iv0sabPcgxZhouhETpP3AYCsQljgxBjbhAenl1hq+Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709903109; c=relaxed/simple;
	bh=c5ZBgFk2lxlht9LflS5ALAop/xuWMX6Rmc/HzSvUu0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GbBNbobgmIjyDzMXvRK/Z9tF5+Ki21wqVLFtnU41+2rkI0g3tNCK/uNEZIX5HW/zMpEXjua64yaQsbWk29qhf3CDhiXz7hhb1rF8OVJ2bAGvLngciftccRfjwRlY0441vT1dbMtYgXkQ2RknU+LcCXdAwn1SgnQmw2Yn4A3N2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A00EAC15;
	Fri,  8 Mar 2024 05:05:43 -0800 (PST)
Received: from [10.57.70.163] (unknown [10.57.70.163])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F0593F762;
	Fri,  8 Mar 2024 05:05:02 -0800 (PST)
Message-ID: <60dc7309-cb38-45e3-b2c0-ff0119202a12@arm.com>
Date: Fri, 8 Mar 2024 13:05:00 +0000
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
Cc: David Hildenbrand <david@redhat.com>, Lance Yang <ioworker0@gmail.com>,
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
 <501c9f77-1459-467a-8619-78e86b46d300@arm.com>
 <8f84c7d6-982a-4933-a7a7-3f640df64991@redhat.com>
 <e6bc142e-113d-4034-b92c-746b951a27ed@redhat.com>
 <d24f8553-33f2-4ae7-a06d-badaf9462d84@arm.com>
 <CAGsJ_4za-2xpg21phWi2WWLF1iPXhoc1xM__FDTwYYBBKsTPgw@mail.gmail.com>
 <a07deb2c-49e1-4324-8e70-e897605faa9d@redhat.com>
 <b1bf4b62-8e9b-470f-a300-d13c24177688@arm.com>
 <b174d4e1-e1ef-4766-91bc-de822eee30fb@redhat.com>
 <CAGsJ_4xXS0MsxRVTbf74DY_boQVUE2oP=AP6JmdXZSqsAOZzRQ@mail.gmail.com>
 <f3b1cb43-cb33-4db4-a3dd-0c787e30b113@arm.com>
 <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wGe9SdMvojw_2XchEttrbww3RttoOENoF-O4bLWUd_rw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 07/03/2024 18:54, Barry Song wrote:
> On Fri, Mar 8, 2024 at 12:31 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 07/03/2024 12:01, Barry Song wrote:
>>> On Thu, Mar 7, 2024 at 7:45 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 07.03.24 12:42, Ryan Roberts wrote:
>>>>> On 07/03/2024 11:31, David Hildenbrand wrote:
>>>>>> On 07.03.24 12:26, Barry Song wrote:
>>>>>>> On Thu, Mar 7, 2024 at 7:13 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>
>>>>>>>> On 07/03/2024 10:54, David Hildenbrand wrote:
>>>>>>>>> On 07.03.24 11:54, David Hildenbrand wrote:
>>>>>>>>>> On 07.03.24 11:50, Ryan Roberts wrote:
>>>>>>>>>>> On 07/03/2024 09:33, Barry Song wrote:
>>>>>>>>>>>> On Thu, Mar 7, 2024 at 10:07 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>>>>>>>>>>>>
>>>>>>>>>>>>> On 07/03/2024 08:10, Barry Song wrote:
>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 9:00 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Hey Barry,
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Thanks for taking time to review!
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 3:00 PM Barry Song <21cnbao@gmail.com> wrote:
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Thu, Mar 7, 2024 at 7:15 PM Lance Yang <ioworker0@gmail.com> wrote:
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> [...]
>>>>>>>>>>>>>>>>> +static inline bool can_mark_large_folio_lazyfree(unsigned long addr,
>>>>>>>>>>>>>>>>> +                                                struct folio *folio,
>>>>>>>>>>>>>>>>> pte_t *start_pte)
>>>>>>>>>>>>>>>>> +{
>>>>>>>>>>>>>>>>> +       int nr_pages = folio_nr_pages(folio);
>>>>>>>>>>>>>>>>> +       fpb_t flags = FPB_IGNORE_DIRTY | FPB_IGNORE_SOFT_DIRTY;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +       for (int i = 0; i < nr_pages; i++)
>>>>>>>>>>>>>>>>> +               if (page_mapcount(folio_page(folio, i)) != 1)
>>>>>>>>>>>>>>>>> +                       return false;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> we have moved to folio_estimated_sharers though it is not precise, so
>>>>>>>>>>>>>>>> we don't do
>>>>>>>>>>>>>>>> this check with lots of loops and depending on the subpage's mapcount.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> If we don't check the subpage’s mapcount, and there is a cow folio
>>>>>>>>>>>>>>> associated
>>>>>>>>>>>>>>> with this folio and the cow folio has smaller size than this folio,
>>>>>>>>>>>>>>> should we still
>>>>>>>>>>>>>>> mark this folio as lazyfree?
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> I agree, this is true. However, we've somehow accepted the fact that
>>>>>>>>>>>>>> folio_likely_mapped_shared
>>>>>>>>>>>>>> can result in false negatives or false positives to balance the
>>>>>>>>>>>>>> overhead.  So I really don't know :-)
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Maybe David and Vishal can give some comments here.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> BTW, do we need to rebase our work against David's changes[1]?
>>>>>>>>>>>>>>>> [1]
>>>>>>>>>>>>>>>> https://lore.kernel.org/linux-mm/20240227201548.857831-1-david@redhat.com/
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Yes, we should rebase our work against David’s changes.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +       return nr_pages == folio_pte_batch(folio, addr, start_pte,
>>>>>>>>>>>>>>>>> +                                        ptep_get(start_pte), nr_pages,
>>>>>>>>>>>>>>>>> flags, NULL);
>>>>>>>>>>>>>>>>> +}
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>>      static int madvise_free_pte_range(pmd_t *pmd, unsigned long addr,
>>>>>>>>>>>>>>>>>                                     unsigned long end, struct mm_walk
>>>>>>>>>>>>>>>>> *walk)
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> @@ -676,11 +690,45 @@ static int madvise_free_pte_range(pmd_t *pmd,
>>>>>>>>>>>>>>>>> unsigned long addr,
>>>>>>>>>>>>>>>>>                      */
>>>>>>>>>>>>>>>>>                     if (folio_test_large(folio)) {
>>>>>>>>>>>>>>>>>                             int err;
>>>>>>>>>>>>>>>>> +                       unsigned long next_addr, align;
>>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> -                       if (folio_estimated_sharers(folio) != 1)
>>>>>>>>>>>>>>>>> -                               break;
>>>>>>>>>>>>>>>>> -                       if (!folio_trylock(folio))
>>>>>>>>>>>>>>>>> -                               break;
>>>>>>>>>>>>>>>>> +                       if (folio_estimated_sharers(folio) != 1 ||
>>>>>>>>>>>>>>>>> +                           !folio_trylock(folio))
>>>>>>>>>>>>>>>>> +                               goto skip_large_folio;
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> I don't think we can skip all the PTEs for nr_pages, as some of them
>>>>>>>>>>>>>>>> might be
>>>>>>>>>>>>>>>> pointing to other folios.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> for example, for a large folio with 16PTEs, you do MADV_DONTNEED(15-16),
>>>>>>>>>>>>>>>> and write the memory of PTE15 and PTE16, you get page faults, thus PTE15
>>>>>>>>>>>>>>>> and PTE16 will point to two different small folios. We can only skip
>>>>>>>>>>>>>>>> when we
>>>>>>>>>>>>>>>> are sure nr_pages == folio_pte_batch() is sure.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> Agreed. Thanks for pointing that out.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       align = folio_nr_pages(folio) * PAGE_SIZE;
>>>>>>>>>>>>>>>>> +                       next_addr = ALIGN_DOWN(addr + align, align);
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       /*
>>>>>>>>>>>>>>>>> +                        * If we mark only the subpages as lazyfree, or
>>>>>>>>>>>>>>>>> +                        * cannot mark the entire large folio as
>>>>>>>>>>>>>>>>> lazyfree,
>>>>>>>>>>>>>>>>> +                        * then just split it.
>>>>>>>>>>>>>>>>> +                        */
>>>>>>>>>>>>>>>>> +                       if (next_addr > end || next_addr - addr !=
>>>>>>>>>>>>>>>>> align ||
>>>>>>>>>>>>>>>>> +                           !can_mark_large_folio_lazyfree(addr, folio,
>>>>>>>>>>>>>>>>> pte))
>>>>>>>>>>>>>>>>> +                               goto split_large_folio;
>>>>>>>>>>>>>>>>> +
>>>>>>>>>>>>>>>>> +                       /*
>>>>>>>>>>>>>>>>> +                        * Avoid unnecessary folio splitting if the
>>>>>>>>>>>>>>>>> large
>>>>>>>>>>>>>>>>> +                        * folio is entirely within the given range.
>>>>>>>>>>>>>>>>> +                        */
>>>>>>>>>>>>>>>>> +                       folio_clear_dirty(folio);
>>>>>>>>>>>>>>>>> +                       folio_unlock(folio);
>>>>>>>>>>>>>>>>> +                       for (; addr != next_addr; pte++, addr +=
>>>>>>>>>>>>>>>>> PAGE_SIZE) {
>>>>>>>>>>>>>>>>> +                               ptent = ptep_get(pte);
>>>>>>>>>>>>>>>>> +                               if (pte_young(ptent) ||
>>>>>>>>>>>>>>>>> pte_dirty(ptent)) {
>>>>>>>>>>>>>>>>> +                                       ptent =
>>>>>>>>>>>>>>>>> ptep_get_and_clear_full(
>>>>>>>>>>>>>>>>> +                                               mm, addr, pte,
>>>>>>>>>>>>>>>>> tlb->fullmm);
>>>>>>>>>>>>>>>>> +                                       ptent = pte_mkold(ptent);
>>>>>>>>>>>>>>>>> +                                       ptent = pte_mkclean(ptent);
>>>>>>>>>>>>>>>>> +                                       set_pte_at(mm, addr, pte,
>>>>>>>>>>>>>>>>> ptent);
>>>>>>>>>>>>>>>>> +                                       tlb_remove_tlb_entry(tlb, pte,
>>>>>>>>>>>>>>>>> addr);
>>>>>>>>>>>>>>>>> +                               }
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> Can we do this in batches? for a CONT-PTE mapped large folio, you are
>>>>>>>>>>>>>>>> unfolding
>>>>>>>>>>>>>>>> and folding again. It seems quite expensive.
>>>>>>>>>>>>>
>>>>>>>>>>>>> I'm not convinced we should be doing this in batches. We want the initial
>>>>>>>>>>>>> folio_pte_batch() to be as loose as possible regarding permissions so
>>>>>>>>>>>>> that we
>>>>>>>>>>>>> reduce our chances of splitting folios to the min. (e.g. ignore SW bits
>>>>>>>>>>>>> like
>>>>>>>>>>>>> soft dirty, etc). I think it might be possible that some PTEs are RO and
>>>>>>>>>>>>> other
>>>>>>>>>>>>> RW too (e.g. due to cow - although with the current cow impl, probably not.
>>>>>>>>>>>>> But
>>>>>>>>>>>>> its fragile to assume that). Anyway, if we do an initial batch that ignores
>>>>>>>>>>>>> all
>>>>>>>>>>>>
>>>>>>>>>>>> You are correct. I believe this scenario could indeed occur. For instance,
>>>>>>>>>>>> if process A forks process B and then unmaps itself, leaving B as the
>>>>>>>>>>>> sole process owning the large folio.  The current wp_page_reuse() function
>>>>>>>>>>>> will reuse PTE one by one while the specific subpage is written.
>>>>>>>>>>>
>>>>>>>>>>> Hmm - I thought it would only reuse if the total mapcount for the folio
>>>>>>>>>>> was 1.
>>>>>>>>>>> And since it is a large folio with each page mapped once in proc B, I thought
>>>>>>>>>>> every subpage write would cause a copy except the last one? I haven't
>>>>>>>>>>> looked at
>>>>>>>>>>> the code for a while. But I had it in my head that this is an area we need to
>>>>>>>>>>> improve for mTHP.
>>>>>>>
>>>>>>> So sad I am wrong again 😢
>>>>>>>
>>>>>>>>>>
>>>>>>>>>> wp_page_reuse() will currently reuse a PTE part of a large folio only if
>>>>>>>>>> a single PTE remains mapped (refcount == 0).
>>>>>>>>>
>>>>>>>>> ^ == 1
>>>>>>>
>>>>>>> seems this needs improvement. it is a waste the last subpage can
>>>>>>
>>>>>> My take that is WIP:
>>>>>>
>>>>>> https://lore.kernel.org/all/20231124132626.235350-1-david@redhat.com/T/#u
>>>>>>
>>>>>>> reuse the whole large folio. i was doing it in a quite different way,
>>>>>>> if the large folio had only one subpage left, i would do copy and
>>>>>>> released the large folio[1]. and if i could reuse the whole large folio
>>>>>>> with CONT-PTE, i would reuse the whole large folio[2]. in mainline,
>>>>>>> we don't have this cont-pte luxury exposed to mm, so i guess we can
>>>>>>> not do [2] easily, but [1] seems to be an optimization.
>>>>>>
>>>>>> Yeah, I had essentially the same idea: just free up the large folio if most of
>>>>>> the stuff is unmapped. But that's rather a corner-case optimization, so I did
>>>>>> not proceed with that.
>>>>>>
>>>>>
>>>>> I'm not sure it's a corner case, really? - process forks, then both parent and
>>>>> child and write to all pages in what was previously a fully & contiguously
>>>>> mapped large folio?
>>>>
>>>> Well, with 2 MiB my assumption was that while it can happen, it's rather
>>>> rare. With smaller THP it might get more likely, agreed.
>>>>
>>>>>
>>>>> Reggardless, why is it an optimization to do the copy for the last subpage and
>>>>> syncrhonously free the large folio? It's already partially mapped so is on the
>>>>> deferred split list and can be split if memory is tight.
>>>
>>> we don't want reclamation overhead later. and we want memories immediately
>>> available to others.
>>
>> But by that logic, you also don't want to leave the large folio partially mapped
>> all the way until the last subpage is CoWed. Surely you would want to reclaim it
>> when you reach partial map status?
> 
> To some extent, I agree. But then we will have two many copies. The last
> subpage is small, and a safe place to copy instead.
> 
> We actually had to tune userspace to decrease partial map as too much
> partial map both unfolded CONT-PTE and wasted too much memory. if a
> vma had too much partial map, we disabled mTHP on this VMA.

I actually had a whacky idea around introducing selectable page size ABI
per-process that might help here. I know Android is doing work to make the
system 16K page compatible. You could run most of the system processes with 16K
ABI on top of 4K kernel. Then those processes don't even have the ability to
madvise/munmap/mprotect/mremap anything less than 16K alignment so that acts as
an anti-fragmentation mechanism while allowing non-16K capable processes to run
side-by-side. Just a passing thought...

> 
>>
>>> reclamation will always cause latency and affect User
>>> experience. split_folio is not cheap :-)
>>
>> But neither is memcpy(4K) I'd imagine. But I get your point.
> 
> In a real product scenario, we need to consider the success rate of
> allocating large folios.
> Currently, it's only 7%, as reported here[1], with no method to keep
> large folios intact in a
> buddy system.

Yes I saw that email - interesting. Is that 7% number for the Oppo
implementation or upstream implementation? (I think Oppo?). Do you know how the
other one compares (my guess is that upstream isn't complete enough yet to give
viable numbers)? And I'm guessing you are running on a kernel/fs that doesn't
support large folios in the page cache? What about large folio swap? My feeling
is that once we have all these features, that number should significantly
increase because you can create a system that essentially uses large quantities
of a couple of sizes of page (e.g. 4K & (16K | 64K)) and fragmentation will be
less of a problem. Perhaps that's wishful thinking though.

> 
> Yu's TAO[2] chose to release the large folio entirely after copying
> the mapped parts
> onto smaller folios in vmscan,

Yes, TAO looks very interesting! It essentially partitions the memory IIUC?

> 
> [1] https://lore.kernel.org/linux-mm/20240305083743.24950-1-21cnbao@gmail.com/
> [2] https://lore.kernel.org/linux-mm/20240229183436.4110845-1-yuzhao@google.com/
> 
>>
>>> if the number of this kind of
>>> large folios
>>> is huge, the waste can be huge for some while.
>>>
>>> it is not a corner case for large folio swap-in. while someone writes
>>> one subpage, I swap-in a large folio, wp_reuse will immediately
>>> be called. This can cause waste quite often. One outcome of this
>>> discussion is that I realize I should investigate this issue immediately
>>> in the swap-in series as my off-tree code has optimized reuse but
>>> mainline hasn't.
>>>
>>>>
>>>> At least for 2 MiB THP, it might make sense to make that large folio
>>>> available immediately again, even without memory pressure. Even
>>>> compaction would not compact it.
>>>
>>> It is also true for 64KiB. as we want other processes to allocate
>>> 64KiB successfully as much as possible, and reduce the rate of
>>> falling back to small folios. by releasing 64KiB directly to buddy
>>> rather than splitting and returning 15*4KiB in shrinker, we reduce
>>> buddy fragmentation too.
>>>
>>>>
>>>> --
>>>> Cheers,
>>>>
>>>> David / dhildenb
> 
> Thanks
> Barry


