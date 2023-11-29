Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5127FD703
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbjK2Mnh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjK2Mnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:43:35 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF234D44
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:43:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 86DDF2F4;
        Wed, 29 Nov 2023 04:44:28 -0800 (PST)
Received: from [10.57.70.211] (unknown [10.57.70.211])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CD1843F5A1;
        Wed, 29 Nov 2023 04:43:37 -0800 (PST)
Message-ID: <34da1e06-74da-4e45-b0b5-9c93d64eb64e@arm.com>
Date:   Wed, 29 Nov 2023 12:43:35 +0000
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
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4wV-z7u5N3oLM-3kONHe0fmQwO7CSWQk9w0u0EhMroXAA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 20:23, Barry Song wrote:
> On Wed, Nov 29, 2023 at 12:49 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 28/11/2023 08:17, Barry Song wrote:
>>>> +pte_t contpte_ptep_get_and_clear_full(struct mm_struct *mm,
>>>> +                                    unsigned long addr, pte_t *ptep)
>>>> +{
>>>> +    /*
>>>> +     * When doing a full address space teardown, we can avoid unfolding the
>>>> +     * contiguous range, and therefore avoid the associated tlbi. Instead,
>>>> +     * just get and clear the pte. The caller is promising to call us for
>>>> +     * every pte, so every pte in the range will be cleared by the time the
>>>> +     * tlbi is issued.
>>>> +     *
>>>> +     * This approach is not perfect though, as for the duration between
>>>> +     * returning from the first call to ptep_get_and_clear_full() and making
>>>> +     * the final call, the contpte block in an intermediate state, where
>>>> +     * some ptes are cleared and others are still set with the PTE_CONT bit.
>>>> +     * If any other APIs are called for the ptes in the contpte block during
>>>> +     * that time, we have to be very careful. The core code currently
>>>> +     * interleaves calls to ptep_get_and_clear_full() with ptep_get() and so
>>>> +     * ptep_get() must be careful to ignore the cleared entries when
>>>> +     * accumulating the access and dirty bits - the same goes for
>>>> +     * ptep_get_lockless(). The only other calls we might resonably expect
>>>> +     * are to set markers in the previously cleared ptes. (We shouldn't see
>>>> +     * valid entries being set until after the tlbi, at which point we are
>>>> +     * no longer in the intermediate state). Since markers are not valid,
>>>> +     * this is safe; set_ptes() will see the old, invalid entry and will not
>>>> +     * attempt to unfold. And the new pte is also invalid so it won't
>>>> +     * attempt to fold. We shouldn't see this for the 'full' case anyway.
>>>> +     *
>>>> +     * The last remaining issue is returning the access/dirty bits. That
>>>> +     * info could be present in any of the ptes in the contpte block.
>>>> +     * ptep_get() will gather those bits from across the contpte block. We
>>>> +     * don't bother doing that here, because we know that the information is
>>>> +     * used by the core-mm to mark the underlying folio as accessed/dirty.
>>>> +     * And since the same folio must be underpinning the whole block (that
>>>> +     * was a requirement for folding in the first place), that information
>>>> +     * will make it to the folio eventually once all the ptes have been
>>>> +     * cleared. This approach means we don't have to play games with
>>>> +     * accumulating and storing the bits. It does mean that any interleaved
>>>> +     * calls to ptep_get() may lack correct access/dirty information if we
>>>> +     * have already cleared the pte that happened to store it. The core code
>>>> +     * does not rely on this though.
>>>
>>> even without any other threads running and touching those PTEs, this won't survive
>>> on some hardware. we expose inconsistent CONTPTEs to hardware, this might result
>>
>> No that's not the case; if you read the Arm ARM, the page table is only
>> considered "misgrogrammed" when *valid* entries within the same contpte block
>> have different values for the contiguous bit. We are clearing the ptes to zero
>> here, which is an *invalid* entry. So if the TLB entry somehow gets invalidated
>> (either due to explicit tlbi as you point out below, or due to a concurrent TLB
>> miss which selects our entry for removal to make space for the new incomming
>> entry), then it gets an access request for an address in our partially cleared
>> contpte block the address will either be:
>>
>> A) an address for a pte entry we have already cleared, so its invalid and it
>> will fault (and get serialized behind the PTL).
>>
>> or
>>
>> B) an address for a pte entry we haven't yet cleared, so it will reform a TLB
>> entry for the contpte block. But that's ok because the memory still exists
>> because we haven't yet finished clearing the page table and have not yet issued
>> the final tlbi.
>>
>>
>>> in crashed firmware even in trustzone, strange&unknown faults to trustzone we have
>>> seen on Qualcomm, but for MTK, it seems fine. when you do tlbi on a part of PTEs
>>> with dropped CONT but still some other PTEs have CONT, we make hardware totally
>>> confused.
>>
>> I suspect this is because in your case you are "misprogramming" the contpte
>> block; there are *valid* pte entries within the block that disagree about the
>> contiguous bit or about various other fields. In this case some HW TLB designs
>> can do weird things. I suspect in your case, that's resulting in accessing bad
>> memory space and causing an SError, which is trapped by EL3, and the FW is
>> probably just panicking at that point.
> 
> you are probably right. as we met the SError, we became very very
> cautious. so anytime
> when we flush tlb for a CONTPTE, we strictly do it by
> 1. set all 16 ptes to zero
> 2. flush the whole 16 ptes

But my point is that this sequence doesn't guarrantee that the TLB doesn't read
the page table half way through the SW clearing the 16 entries; a TLB entry can
be ejected for other reasons than just issuing a TLBI. So in that case these 2
flows can be equivalent. Its the fact that we are unsetting the valid bit when
clearing each pte that guarantees this to be safe.

> 
> in your case, it can be:
> 1. set pte0 to zero
> 2. flush pte0
> 
> TBH, i have never tried this. but it might be safe according to your
> description.
> 
>>
>>>
>>> zap_pte_range() has a force_flush when tlbbatch is full:
>>>
>>>                         if (unlikely(__tlb_remove_page(tlb, page, delay_rmap))) {
>>>                                 force_flush = 1;
>>>                                 addr += PAGE_SIZE;
>>>                                 break;
>>>                         }
>>>
>>> this means you can expose partial tlbi/flush directly to hardware while some
>>> other PTEs are still CONT.
>>
>> Yes, but that's also possible even if we have a tight loop that clears down the
>> contpte block; there could still be another core that issues a tlbi while you're
>> halfway through that loop, or the HW could happen to evict due to TLB pressure
>> at any time. The point is, it's safe if you are clearing the pte to an *invalid*
>> entry.
>>
>>>
>>> on the other hand, contpte_ptep_get_and_clear_full() doesn't need to depend
>>> on fullmm, as long as zap range covers a large folio, we can flush tlbi for
>>> those CONTPTEs all together in your contpte_ptep_get_and_clear_full() rather
>>> than clearing one PTE.
>>>
>>> Our approach in [1] is we do a flush for all CONTPTEs and go directly to the end
>>> of the large folio:
>>>
>>> #ifdef CONFIG_CONT_PTE_HUGEPAGE
>>>                       if (pte_cont(ptent)) {
>>>                               unsigned long next = pte_cont_addr_end(addr, end);
>>>
>>>                               if (next - addr != HPAGE_CONT_PTE_SIZE) {
>>>                                       __split_huge_cont_pte(vma, pte, addr, false, NULL, ptl);
>>>                                       /*
>>>                                        * After splitting cont-pte
>>>                                        * we need to process pte again.
>>>                                        */
>>>                                       goto again_pte;
>>>                               } else {
>>>                                       cont_pte_huge_ptep_get_and_clear(mm, addr, pte);
>>>
>>>                                       tlb_remove_cont_pte_tlb_entry(tlb, pte, addr);
>>>                                       if (unlikely(!page))
>>>                                               continue;
>>>
>>>                                       if (is_huge_zero_page(page)) {
>>>                                               tlb_remove_page_size(tlb, page, HPAGE_CONT_PTE_SIZE);
>>>                                               goto cont_next;
>>>                                       }
>>>
>>>                                       rss[mm_counter(page)] -= HPAGE_CONT_PTE_NR;
>>>                                       page_remove_rmap(page, true);
>>>                                       if (unlikely(page_mapcount(page) < 0))
>>>                                               print_bad_pte(vma, addr, ptent, page);
>>>
>>>                                       tlb_remove_page_size(tlb, page, HPAGE_CONT_PTE_SIZE);
>>>                               }
>>> cont_next:
>>>                               /* "do while()" will do "pte++" and "addr + PAGE_SIZE" */
>>>                               pte += (next - PAGE_SIZE - (addr & PAGE_MASK))/PAGE_SIZE;
>>>                               addr = next - PAGE_SIZE;
>>>                               continue;
>>>                       }
>>> #endif
>>>
>>> this is our "full" counterpart, which clear_flush CONT_PTES pages directly, and
>>> it never requires tlb->fullmm at all.
>>
>> Yes, but you are benefitting from the fact that contpte is exposed to core-mm
>> and it is special-casing them at this level. I'm trying to avoid that.
> 
> I am thinking we can even do this while we don't expose CONTPTE.
> if zap_pte_range meets a large folio and the zap_range covers the whole
> folio, we can flush all ptes in this folio and jump to the end of this folio?
> i mean
> 
> if (folio head && range_end > folio_end) {
>          nr = folio_nr_page(folio);
>          full_flush_nr_ptes()
>          pte += nr -1;
>          addr += (nr - 1) * basepage size
> }

Just because you found a pte that maps a page from a large folio, that doesn't
mean that all pages from the folio are mapped, and it doesn't mean they are
mapped contiguously. We have to deal with partial munmap(), partial mremap()
etc. We could split in these cases (and in future it might be sensible to try),
but that can fail (due to GUP). So we still have to handle the corner case.

But I can imagine doing a batched version of ptep_get_and_clear(), like I did
for ptep_set_wrprotects(). And I think this would be an improvement.

The reason I haven't done that so far, is because ptep_get_and_clear() returns
the pte value when it was cleared and that's hard to do if batching due to the
storage requirement. But perhaps you could just return the logical OR of the
dirty and young bits across all ptes in the batch. The caller should be able to
reconstitute the rest if it needs it?

What do you think?

> 
> zap_pte_range is the most frequent behaviour from userspace libc heap
> as i explained
> before. libc can call madvise(DONTNEED) the most often. It is crucial
> to performance.
> 
> and this way can also help drop your full version by moving to full
> flushing the whole
> large folios? and we don't need to depend on fullmm any more?
> 
>>
>> I don't think there is any correctness issue here. But there is a problem with
>> fragility, as raised by Alistair. I have some ideas on potentially how to solve
>> that. I'm going to try to work on it this afternoon and will post if I get some
>> confidence that it is a real solution.
>>
>> Thanks,
>> Ryan
>>
>>>
>>> static inline pte_t __cont_pte_huge_ptep_get_and_clear_flush(struct mm_struct *mm,
>>>                                      unsigned long addr,
>>>                                      pte_t *ptep,
>>>                                      bool flush)
>>> {
>>>       pte_t orig_pte = ptep_get(ptep);
>>>
>>>       CHP_BUG_ON(!pte_cont(orig_pte));
>>>       CHP_BUG_ON(!IS_ALIGNED(addr, HPAGE_CONT_PTE_SIZE));
>>>       CHP_BUG_ON(!IS_ALIGNED(pte_pfn(orig_pte), HPAGE_CONT_PTE_NR));
>>>
>>>       return get_clear_flush(mm, addr, ptep, PAGE_SIZE, CONT_PTES, flush);
>>> }
>>>
>>> [1] https://github.com/OnePlusOSS/android_kernel_oneplus_sm8550/blob/oneplus/sm8550_u_14.0.0_oneplus11/mm/memory.c#L1539
>>>
>>>> +     */
>>>> +
>>>> +    return __ptep_get_and_clear(mm, addr, ptep);
>>>> +}
>>>> +EXPORT_SYMBOL(contpte_ptep_get_and_clear_full);
>>>> +
>>>
> 
> Thanks
> Barry
> 
>>

