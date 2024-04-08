Return-Path: <linux-kernel+bounces-135352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ABD489BF5D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F6A01C215B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12F166D1C7;
	Mon,  8 Apr 2024 12:47:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 516C32D057
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580452; cv=none; b=bsDtE8fO6aMuH/vo2wZ6DzBoFtVpu0n2BpGP4bHxAAiR0e5xOGg7kgVEIa1EVCDU7A/0c0uS8YfqA8W2XO8P9RNweNrxCLdk2I/H1Ep9HZzHGWcJG+A+PaCSo91aWxmuDiBQhMWY3IS3rHHJqMAjX4lQZxNCbn2ZL6DE5K4D6Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580452; c=relaxed/simple;
	bh=fsMY0OVX++jA3VyuUlzyJln1lLArqvSTAaBLWoH/BPw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jmRpFid96Wc107+2T1qdEQupr/sBLhUD6fKMM+o7MoYJxYh+Wjl8+Ll9+yyFeM0GG2NUg41ssaLH+k9/b3RuBSQ8b3tX2BRCS2OSyw9gpcOZCUIvoaFUvalFj+Kho8j4pQBW1aoHRWgwpVEabJYMGkbJl1bQJf5oPS9uS1qSjhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E7D8DA7;
	Mon,  8 Apr 2024 05:48:00 -0700 (PDT)
Received: from [10.57.73.169] (unknown [10.57.73.169])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD26E3F64C;
	Mon,  8 Apr 2024 05:47:27 -0700 (PDT)
Message-ID: <be096120-4dd1-4a10-b283-779d23c2811b@arm.com>
Date: Mon, 8 Apr 2024 13:47:26 +0100
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
From: Ryan Roberts <ryan.roberts@arm.com>
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
 <4110bb1d-65e5-4cf0-91ad-62749975829d@arm.com>
In-Reply-To: <4110bb1d-65e5-4cf0-91ad-62749975829d@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 08/04/2024 13:07, Ryan Roberts wrote:
> [...]
>>
>> [...]
>>
>>> +
>>> +/**
>>> + * swap_pte_batch - detect a PTE batch for a set of contiguous swap entries
>>> + * @start_ptep: Page table pointer for the first entry.
>>> + * @max_nr: The maximum number of table entries to consider.
>>> + * @entry: Swap entry recovered from the first table entry.
>>> + *
>>> + * Detect a batch of contiguous swap entries: consecutive (non-present) PTEs
>>> + * containing swap entries all with consecutive offsets and targeting the same
>>> + * swap type.
>>> + *
>>
>> Likely you should document that any swp pte bits are ignored? ()
> 
> Now that I understand what swp pte bits are, I think the simplest thing is to
> just make this function always consider the pte bits by using pte_same() as you
> suggest below? I don't think there is ever a case for ignoring the swp pte bits?
> And then I don't need to do anything special for uffd-wp either (below you
> suggested not doing batching when the VMA has uffd enabled).
> 
> Any concerns?
> 
>>
>>> + * max_nr must be at least one and must be limited by the caller so scanning
>>> + * cannot exceed a single page table.
>>> + *
>>> + * Return: the number of table entries in the batch.
>>> + */
>>> +static inline int swap_pte_batch(pte_t *start_ptep, int max_nr,
>>> +                 swp_entry_t entry)
>>> +{
>>> +    const pte_t *end_ptep = start_ptep + max_nr;
>>> +    unsigned long expected_offset = swp_offset(entry) + 1;
>>> +    unsigned int expected_type = swp_type(entry);
>>> +    pte_t *ptep = start_ptep + 1;
>>> +
>>> +    VM_WARN_ON(max_nr < 1);
>>> +    VM_WARN_ON(non_swap_entry(entry));
>>> +
>>> +    while (ptep < end_ptep) {
>>> +        pte_t pte = ptep_get(ptep);
>>> +
>>> +        if (pte_none(pte) || pte_present(pte))
>>> +            break;
>>> +
>>> +        entry = pte_to_swp_entry(pte);
>>> +
>>> +        if (non_swap_entry(entry) ||
>>> +            swp_type(entry) != expected_type ||
>>> +            swp_offset(entry) != expected_offset)
>>> +            break;
>>> +
>>> +        expected_offset++;
>>> +        ptep++;
>>> +    }
>>> +
>>> +    return ptep - start_ptep;
>>> +}
>>
>> Looks very clean :)
>>
>> I was wondering whether we could similarly construct the expected swp PTE and
>> only check pte_same.
>>
>> expected_pte = __swp_entry_to_pte(__swp_entry(expected_type, expected_offset));
> 
> So planning to do this.

Of course this clears all the swp pte bits in expected_pte. So need to do something a bit more complex.

If we can safely assume all offset bits are contiguous in every per-arch representation then we can do:

static inline pte_t pte_next_swp_offset(pte_t pte)
{
	pte_t offset_inc = __swp_entry_to_pte(__swp_entry(0, 1));

	return __pte(pte_val(pte) + pte_val(offset_inc));
}

Or if not:

static inline pte_t pte_next_swp_offset(pte_t pte)
{
	swp_entry_t entry = pte_to_swp_entry(pte);
	pte_t new = __swp_entry_to_pte(__swp_entry(swp_type(entry), swp_offset(entry) + 1));

	if (pte_swp_soft_dirty(pte))
		new = pte_swp_mksoft_dirty(new);
	if (pte_swp_exclusive(pte))
		new = pte_swp_mkexclusive(new);
	if (pte_swp_uffd_wp(pte))
		new = pte_swp_mkuffd_wp(new);

	return new;
}

Then swap_pte_batch() becomes:

static inline int swap_pte_batch(pte_t *start_ptep, int max_nr, pte_t pte)
{
	pte_t expected_pte = pte_next_swp_offset(pte);
	const pte_t *end_ptep = start_ptep + max_nr;
	pte_t *ptep = start_ptep + 1;

	VM_WARN_ON(max_nr < 1);
	VM_WARN_ON(!is_swap_pte(pte));
	VM_WARN_ON(non_swap_entry(pte_to_swp_entry(pte)));

	while (ptep < end_ptep) {
		pte = ptep_get(ptep);

		if (!pte_same(pte, expected_pte))
			break;

		expected_pte = pte_next_swp_offset(expected_pte);
		ptep++;
	}

	return ptep - start_ptep;
}

Would you be happy with either of these? I'll go look if we can assume the offset bits are always contiguous.


> 
>>
>> ... or have a variant to increase only the swp offset for an existing pte. But
>> non-trivial due to the arch-dependent format.
> 
> not this - I agree this will be difficult due to per-arch changes. I'd rather
> just do the generic version and leave the compiler to do the best it can to
> simplify and optimize.
> 
>>
>> But then, we'd fail on mismatch of other swp pte bits.
>>
>>
>> On swapin, when reusing this function (likely!), we'll might to make sure that
>> the PTE bits match as well.
>>
>> See below regarding uffd-wp.
>>
>>
>>>   #endif /* CONFIG_MMU */
>>>     void __acct_reclaim_writeback(pg_data_t *pgdat, struct folio *folio,
>>> diff --git a/mm/madvise.c b/mm/madvise.c
>>> index 1f77a51baaac..070bedb4996e 100644
>>> --- a/mm/madvise.c
>>> +++ b/mm/madvise.c
>>> @@ -628,6 +628,7 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>       struct folio *folio;
>>>       int nr_swap = 0;
>>>       unsigned long next;
>>> +    int nr, max_nr;
>>>         next = pmd_addr_end(addr, end);
>>>       if (pmd_trans_huge(*pmd))
>>> @@ -640,7 +641,8 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>           return 0;
>>>       flush_tlb_batched_pending(mm);
>>>       arch_enter_lazy_mmu_mode();
>>> -    for (; addr != end; pte++, addr += PAGE_SIZE) {
>>> +    for (; addr != end; pte += nr, addr += PAGE_SIZE * nr) {
>>> +        nr = 1;
>>>           ptent = ptep_get(pte);
>>>             if (pte_none(ptent))
>>> @@ -655,9 +657,11 @@ static int madvise_free_pte_range(pmd_t *pmd, unsigned
>>> long addr,
>>>                 entry = pte_to_swp_entry(ptent);
>>>               if (!non_swap_entry(entry)) {
>>> -                nr_swap--;
>>> -                free_swap_and_cache(entry);
>>> -                pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> +                max_nr = (end - addr) / PAGE_SIZE;
>>> +                nr = swap_pte_batch(pte, max_nr, entry);
>>> +                nr_swap -= nr;
>>> +                free_swap_and_cache_nr(entry, nr);
>>> +                clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>>               } else if (is_hwpoison_entry(entry) ||
>>>                      is_poisoned_swp_entry(entry)) {
>>>                   pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> diff --git a/mm/memory.c b/mm/memory.c
>>> index 7dc6c3d9fa83..ef2968894718 100644
>>> --- a/mm/memory.c
>>> +++ b/mm/memory.c
>>> @@ -1637,12 +1637,13 @@ static unsigned long zap_pte_range(struct mmu_gather
>>> *tlb,
>>>                   folio_remove_rmap_pte(folio, page, vma);
>>>               folio_put(folio);
>>>           } else if (!non_swap_entry(entry)) {
>>> -            /* Genuine swap entry, hence a private anon page */
>>> +            max_nr = (end - addr) / PAGE_SIZE;
>>> +            nr = swap_pte_batch(pte, max_nr, entry);
>>> +            /* Genuine swap entries, hence a private anon pages */
>>>               if (!should_zap_cows(details))
>>>                   continue;
>>> -            rss[MM_SWAPENTS]--;
>>> -            if (unlikely(!free_swap_and_cache(entry)))
>>> -                print_bad_pte(vma, addr, ptent, NULL);
>>> +            rss[MM_SWAPENTS] -= nr;
>>> +            free_swap_and_cache_nr(entry, nr);
>>>           } else if (is_migration_entry(entry)) {
>>>               folio = pfn_swap_entry_folio(entry);
>>>               if (!should_zap_folio(details, folio))
>>> @@ -1665,8 +1666,8 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>>>               pr_alert("unrecognized swap entry 0x%lx\n", entry.val);
>>>               WARN_ON_ONCE(1);
>>>           }
>>> -        pte_clear_not_present_full(mm, addr, pte, tlb->fullmm);
>>> -        zap_install_uffd_wp_if_needed(vma, addr, pte, 1, details, ptent);
>>> +        clear_not_present_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>>
>> For zap_install_uffd_wp_if_needed(), the uffd-wp bit has to match.
>>
>> zap_install_uffd_wp_if_needed() will use the uffd-wp information in
>> ptent->pteval to make a decision whether to place PTE_MARKER_UFFD_WP markers.
>>
>> On mixture, you either lose some or place too many markers.
>>
>> A simple workaround would be to disable any such batching if the VMA does have
>> uffd-wp enabled.
> 
> Rather than this, I'll just consider all the swp pte bits when batching.
> 
>>
>>> +        zap_install_uffd_wp_if_needed(vma, addr, pte, nr, details, ptent);
>>>       } while (pte += nr, addr += PAGE_SIZE * nr, addr != end);
> 
> [...]
> 


