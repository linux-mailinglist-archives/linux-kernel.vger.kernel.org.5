Return-Path: <linux-kernel+bounces-135203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1335689BCAB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 365C11C219B7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C752F6F;
	Mon,  8 Apr 2024 10:07:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 362434EB30
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 10:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570866; cv=none; b=MgkKDQyRGDGg6W9TCHYmNvEVNTeRt/cpzZC+3rC5dh7Vxo54qrjxd48hrzLP0btoAUtnNIBGSp8q9QzqQrKH6gMZ1kEvQTuuO51wTPO0dYi04lXhxt/9t8jGjIYqkmF4P4oF5+XBW6CTa6COEToN1o8AjhoRAecLVlMJT1VssX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570866; c=relaxed/simple;
	bh=T/FlP17y6iM7IwlfCUE7CRiYmNj4+5IHKNZm7yMI0Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WFDe4oVEdejYoUheSFupA6+B+R3jnEShIVruRAZS9U8sy24QRagfD4IBkW8ZaAdntXNRGuL55ukTzOS3TKgrB3m1KztQ95TT0tDWDSD8kymWr6fLhkoIYXu97vWR/IGHspF7/8IYiJskjGKjFR5zQx0qK8jph8eeM8488PSFK3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8FFD1007;
	Mon,  8 Apr 2024 03:08:13 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 88A3A3F766;
	Mon,  8 Apr 2024 03:07:41 -0700 (PDT)
Message-ID: <e8dfe18d-d3fe-47a8-88b6-d0145895d7af@arm.com>
Date: Mon, 8 Apr 2024 11:07:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/6] mm: swap: free_swap_and_cache_nr() as batched
 free_swap_and_cache()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, Huang Ying <ying.huang@intel.com>,
 Gao Xiang <xiang@kernel.org>, Yu Zhao <yuzhao@google.com>,
 Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, Barry Song <21cnbao@gmail.com>,
 Chris Li <chrisl@kernel.org>, Lance Yang <ioworker0@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20240403114032.1162100-1-ryan.roberts@arm.com>
 <20240403114032.1162100-3-ryan.roberts@arm.com>
 <051052af-3b56-4290-98d3-fd5a1eb11ce1@redhat.com>
 <73adae65-4429-41d7-bbb6-4c58156060d3@arm.com>
 <7d3d3c58-1bb1-4d70-9ae3-fa96f6d624d8@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <7d3d3c58-1bb1-4d70-9ae3-fa96f6d624d8@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 10:43, David Hildenbrand wrote:
> 
>>>> +
>>>> +/**
>>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>>> + * @start_ptep: Page table pointer for the first entry.
>>>> + * @max_nr: The maximum number of table entries to consider.
>>>> + * @entry: Swap entry recovered from the first table entry.
>>>> + *
>>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>>> + * containing swap entries all with consecutive offsets and targeting the same
>>>> + * swap type.
>>>> + *
>>>
>>> Likely you should document that any swp pte bits are ignored? ()
>>
>> Sorry I don't understand this comment. I thought any non-none, non-present PTE
>> was always considered to contain only a "swap entry" and a swap entry consists
>> of a "type" and an "offset" only. (and its a special "non-swap" swap entry if
>> type > SOME_CONSTANT) Are you saying there are additional fields in the PTE that
>> are not part of the swap entry?
> 
> 
> pte_swp_soft_dirty()
> pte_swp_clear_exclusive()
> pte_swp_uffd_wp()
> 
> Are PTE bits used for swp PTE.

Ahh wow. mind blown. Looks like a massive hack... why not store them in the
arch-independent swap entry, rather than have them squat independently in the PTE?

OK, my implementation is buggy. I'll re-spin to fix this.


> 
> There is also dirty/young for migration entries, but that's not of a concern
> here, because we stop for non_swap_entry().

Looks like these are part of the offset field in the arch-independent swap entry
- much cleaner ;-).

> 
>>
>>
>>>
>>>> + * max_nr must be at least one and must be limited by the caller so scanning
>>>> + * cannot exceed a single page table.
>>>> + *
>>>> + * Return: the number of table entries in the batch.
>>>> + */
>>>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
>>>> +                 swp_entry_t entry)
>>>> +{
>>>> +    const pte_t *end_ptep = start_ptep + max_nr;
>>>> +    unsigned long expected_offset = swp_offset(entry) + 1;
>>>> +    unsigned int expected_type = swp_type(entry);
>>>> +    pte_t *ptep = start_ptep + 1;
>>>> +
>>>> +    VM_WARN_ON(max_nr < 1);
>>>> +    VM_WARN_ON(non_swap_entry(entry));
>>>> +
>>>> +    while (ptep < end_ptep) {
>>>> +        pte_t pte = ptep_get(ptep);
>>>> +
>>>> +        if (pte_none(pte) || pte_present(pte))
>>>> +            break;
>>>> +
>>>> +        entry = pte_to_swp_entry(pte);
>>>> +
>>>> +        if (non_swap_entry(entry) ||
>>>> +            swp_type(entry) != expected_type ||
>>>> +            swp_offset(entry) != expected_offset)
>>>> +            break;
>>>> +
>>>> +        expected_offset++;
>>>> +        ptep++;
>>>> +    }
>>>> +
>>>> +    return ptep - start_ptep;
>>>> +}
>>>
>>> Looks very clean :)
>>>
>>> I was wondering whether we could similarly construct the expected swp PTE and
>>> only check pte_same.
>>>
>>> expected_pte = __swp_entry_to_pte(__swp_entry(expected_type, expected_offset));
>>>
>>> ... or have a variant to increase only the swp offset for an existing pte. But
>>> non-trivial due to the arch-dependent format.
>>>
>>> But then, we'd fail on mismatch of other swp pte bits.
>>
>> Hmm, perhaps I have a misunderstanding regarding "swp pte bits"...
>>
>>>
>>>
>>> On swapin, when reusing this function (likely!), we'll might to make sure that
>>> the PTE bits match as well.
>>>
>>> See below regarding uffd-wp.
>>>
>>>
>>>>    #endif /* CONFIG_MMU */
>>>>      void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>>> index 1f77a51baaac..070bedb4996e 100644
>>>> --- a/mm/madvise.c
>>>> +++ b/mm/madvise.c
>>>> @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>>> long addr,
>>>>        struct folio *folio;
>>>>        int nr_swap = 0;
>>>>        unsigned long next;
>>>> +    int nr, max_nr;
>>>>          next = pmd_addr_end(addr, end);
>>>>        if (pmd_trans_huge(*pmd))
>>>> @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>>> long addr,
>>>>            return 0;
>>>>        flush_tlb_batched_pending(mm);
>>>>        arch_enter_lazy_mmu_mode();
>>>> -    for (; addr != end; pte++, addr += PAGE_SIZE) {
>>>> +    for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
>>>> +        nr = 1;
>>>>            ptent = ptep_get(pte);
>>>>              if (pte_none(ptent))
>>>> @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>>> long addr,
>>>>                  entry = pte_to_swp_entry(ptent);
>>>>                if (!non_swap_entry(entry)) {
>>>> -                nr_swap--;
>>>> -                free_swap_and_cache(entry);
>>>> -                pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>>> +                max_nr = (end - addr) / PAGE_SIZE;
>>>> +                nr = swap_pte_batch(pte, max_nr, entry);
>>>> +                nr_swap -= nr;
>>>> +                free_swap_and_cache_nr(entry, nr);
>>>> +                clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>>>                } else if (is_hwpoison_entry(entry) ||
>>>>                       is_poisoned_swp_entry(entry)) {
>>>>                    pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>>> diff --git a/mm/memory.c b/mm/memory.c
>>>> index 7dc6c3d9fa83..ef2968894718 100644
>>>> --- a/mm/memory.c
>>>> +++ b/mm/memory.c
>>>> @@ -1637,12 +1637,13 @@ static unsigned long zap_pte_range(struct mmu_gather
>>>> *tlb,
>>>>                    folio_remove_rmap_pte(folio, page, vma);
>>>>                folio_put(folio);
>>>>            } else if (!non_swap_entry(entry)) {
>>>> -            /* Genuine swap entry, hence a private anon page */
>>>> +            max_nr = (end - addr) / PAGE_SIZE;
>>>> +            nr = swap_pte_batch(pte, max_nr, entry);
>>>> +            /* Genuine swap entries, hence a private anon pages */
>>>>                if (!should_zap_cows(details))
>>>>                    continue;
>>>> -            rss[MM_SWAPENTS]--;
>>>> -            if (unlikely(!free_swap_and_cache(entry)))
>>>> -                print_bad_pte(vma, addr, ptent, NULL);
>>>> +            rss[MM_SWAPENTS] -= nr;
>>>> +            free_swap_and_cache_nr(entry, nr);
>>>>            } else if (is_migration_entry(entry)) {
>>>>                folio = pfn_swap_entry_folio(entry);
>>>>                if (!should_zap_folio(details, folio))
>>>> @@ -1665,8 +1666,8 @@ static unsigned long zap_pte_range(struct mmu_gather
>>>> *tlb,
>>>>                pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>>>>                WARN_ON_ONCE(1);
>>>>            }
>>>> -        pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>>> -        zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
>>>> +        clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>>
>>> For zap_install_uffd_wp_if_needed(), the uffd-wp bit has to match.
>>>
>>> zap_install_uffd_wp_if_needed() will use the uffd-wp information in
>>> ptent->pteval to make a decision whether to place PTE_MARKER_UFFD_WP markers.
>>>
>>> On mixture, you either lose some or place too many markers.
>>
>> What path are you concerned about here? I don't get how what you describe can
>> happen? swap_pte_batch() will only give me a batch of actual swap entries and
>> actual swap entries don't contain uffd-wp info, IIUC. If the function gets to a
>> "non-swap" swap entry, it bails. I thought the uffd-wp info was populated based
>> on the VMA state at swap-in? I think you are telling me that it's persisted
>> across the swap per-pte?
> 
> Please see zap_install_uffd_wp_if_needed():
> 
> if (unlikely(pte_swp_uffd_wp_any(pteval)))
>     arm_uffd_pte = true;
> 
> The PTEs (swp PTEs to be precise) contain uffd-wp informtation.
> 
> [...]
> 
>>>> +    /*
>>>> +     * Short-circuit the below loop if none of the entries had their
>>>> +     * reference drop to zero.
>>>> +     */
>>>> +    if (!any_only_cache)
>>>> +        goto out;
>>>>    -        count = __swap_entry_free(p, entry);
>>>> -        if (count == SWAP_HAS_CACHE)
>>>> -            __try_to_reclaim_swap(p, swp_offset(entry),
>>>> +    /*
>>>> +     * Now go back over the range trying to reclaim the swap cache. This is
>>>> +     * more efficient for large folios because we will only try to reclaim
>>>> +     * the swap once per folio in the common case. If we do
>>>> +     * __swap_entry_free() and __try_to_reclaim_swap() in the same loop, the
>>>> +     * latter will get a reference and lock the folio for every individual
>>>> +     * page but will only succeed once the swap slot for every subpage is
>>>> +     * zero.
>>>> +     */
>>>> +    for (offset = swp_offset(entry); offset < end; offset += nr) {
>>>> +        nr = 1;
>>>> +        if (READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
>>>
>>> Here we use READ_ONCE() only, above data_race(). Hmmm.
>>
>> Yes. I think this is correct.
>>
>> READ_ONCE() is a "marked access" which KCSAN understands, so it won't complain
>> about it. So data_race() isn't required when READ_ONCE() (or WRITE_ONCE()) is
>> used. I believe READ_ONCE() is required here because we don't have a lock and we
>> want to make sure we read it in a non-tearing manner.
>>
>> We don't need the READ_ONCE() above since we don't care about the exact value -
>> only that it's not 0 (because we should be holding a ref). So do a plain access
>> to give the compiler a bit more freedom. But we need to mark that with
>> data_race() to stop KCSAN from complaining.
> 
> Okay.
> 


