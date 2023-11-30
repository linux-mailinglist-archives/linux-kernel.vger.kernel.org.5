Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC487FEE76
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 13:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjK3MAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 07:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345305AbjK3MAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 07:00:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B2F910FA
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 04:00:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9B5551042;
        Thu, 30 Nov 2023 04:01:32 -0800 (PST)
Received: from [10.1.34.169] (XHFQ2J9959.cambridge.arm.com [10.1.34.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 008BB3F5A1;
        Thu, 30 Nov 2023 04:00:42 -0800 (PST)
Message-ID: <1d2f8e43-447e-4af4-96ac-1eefea7d6747@arm.com>
Date:   Thu, 30 Nov 2023 12:00:41 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] arm64/mm: Add ptep_get_and_clear_full() to
 optimize process teardown
Content-Language: en-GB
To:     Barry Song <21cnbao@gmail.com>
Cc:     akpm@linux-foundation.org, andreyknvl@gmail.com,
        anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <20231115163018.1303287-15-ryan.roberts@arm.com>
 <20231128081742.39204-1-v-songbaohua@oppo.com>
 <207de995-6d48-41ea-8373-2f9caad9b9c3@arm.com>
 <CAGsJ_4wV-z7u5N3oLM-3kONHe0fmQwO7CSWQk9w0u0EhMroXAA@mail.gmail.com>
 <34da1e06-74da-4e45-b0b5-9c93d64eb64e@arm.com>
 <CAGsJ_4x78VhazGu3cA=W7Nc7yshwHTJjtFYHrCY1SOjC4__qfA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4x78VhazGu3cA=W7Nc7yshwHTJjtFYHrCY1SOjC4__qfA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> Just because you found a pte that maps a page from a large folio, that doesn't
>> mean that all pages from the folio are mapped, and it doesn't mean they are
>> mapped contiguously. We have to deal with partial munmap(), partial mremap()
>> etc. We could split in these cases (and in future it might be sensible to try),
>> but that can fail (due to GUP). So we still have to handle the corner case.
>>
>> But I can imagine doing a batched version of ptep_get_and_clear(), like I did
>> for ptep_set_wrprotects(). And I think this would be an improvement.
>>
>> The reason I haven't done that so far, is because ptep_get_and_clear() returns
>> the pte value when it was cleared and that's hard to do if batching due to the
>> storage requirement. But perhaps you could just return the logical OR of the
>> dirty and young bits across all ptes in the batch. The caller should be able to
>> reconstitute the rest if it needs it?
>>
>> What do you think?
> 
> I really don't know why we care about the return value of ptep_get_and_clear()
> as zap_pte_range() doesn't ask for any ret value at all. so why not totally give
> up this kind of complex logical OR of dirty and young as they are useless in
> this case?

That's not the case in v6.7-rc1:


static unsigned long zap_pte_range(struct mmu_gather *tlb,
				struct vm_area_struct *vma, pmd_t *pmd,
				unsigned long addr, unsigned long end,
				struct zap_details *details)
{
	...

	do {
		pte_t ptent = ptep_get(pte);

		...

		if (pte_present(ptent)) {
			...

			ptent = ptep_get_and_clear_full(mm, addr, pte,
							tlb->fullmm);
			arch_check_zapped_pte(vma, ptent);
			tlb_remove_tlb_entry(tlb, pte, addr);
			zap_install_uffd_wp_if_needed(vma, addr, pte, details,
						      ptent);
			if (unlikely(!page)) {
				ksm_might_unmap_zero_page(mm, ptent);
				continue;
			}

			delay_rmap = 0;
			if (!PageAnon(page)) {
				if (pte_dirty(ptent)) {
					set_page_dirty(page);
					if (tlb_delay_rmap(tlb)) {
						delay_rmap = 1;
						force_flush = 1;
					}
				}
				if (pte_young(ptent) && likely(vma_has_recency(vma)))
					mark_page_accessed(page);
			}

			...
		}

		...
	} while (pte++, addr += PAGE_SIZE, addr != end);

	...
}

Most importantly, file-backed mappings need the access/dirty bits to propagate that information back to the folio, so it will be written back to disk. x86 is also looking at the dirty bit in arch_check_zapped_pte(), and ksm is using it in ksm_might_unmap_zero_page().

Probably for your use case of anon memory on arm64 on a phone, you don't need the return value. But my solution is also setting cotnpte for file-backed memory, and there are performance wins to be had there, especially for executable mappings where contpte reduces iTLB pressure. (I have other work which ensures these file-backed mappings are in correctly-sized large folios).

So I don't think we can just do a clear without the get part. But I think I have a solution in the shape of clear_ptes(), as described in the other thread, which gives the characteristics you suggest.


> 
> Is it possible for us to introduce a new api like?
> 
> bool clear_folio_ptes(folio, ptep)
> {
>     if(ptes are contiguous mapped) {
>            clear all ptes all together    // this also clears all CONTPTE
>            return true;
>     }
>     return false;
> }
> 
> in zap_pte_range():
> 
> if (large_folio(folio) && clear_folio_ptes(folio, ptep)) {
>          addr += nr - 1
>          pte += nr  -1
> } else
>          old path.
> 
> 
>>
>>>
>>> zap_pte_range is the most frequent behaviour from userspace libc heap
>>> as i explained
>>> before. libc can call madvise(DONTNEED) the most often. It is crucial
>>> to performance.
>>>
>>> and this way can also help drop your full version by moving to full
>>> flushing the whole
>>> large folios? and we don't need to depend on fullmm any more?
>>>
>>>>
>>>> I don't think there is any correctness issue here. But there is a problem with
>>>> fragility, as raised by Alistair. I have some ideas on potentially how to solve
>>>> that. I'm going to try to work on it this afternoon and will post if I get some
>>>> confidence that it is a real solution.
>>>>
>>>> Thanks,
>>>> Ryan
>>>>
>>>>>
>>>>> static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct mm_struct *mm,
>>>>>                                      unsigned long addr,
>>>>>                                      pte_t *ptep,
>>>>>                                      bool flush)
>>>>> {
>>>>>       pte_t orig_pte = ptep_get(ptep);
>>>>>
>>>>>       CHP_BUG_ON(!pte_cont(orig_pte));
>>>>>       CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
>>>>>       CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR));
>>>>>
>>>>>       return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, flush);
>>>>> }
>>>>>
>>>>> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1539
>>>>>
>>>>>> +     */
>>>>>> +
>>>>>> +    return __ptep_get_and_clear(mm, addr, ptep);
>>>>>> +}
>>>>>> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
>>>>>> +
>>>>>
>>>
>  Thanks
>  Barry

