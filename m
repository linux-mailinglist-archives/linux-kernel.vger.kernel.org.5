Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386157FB8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234870AbjK1LAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:00:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344463AbjK1LA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:00:27 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2056D10D4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:00:33 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3C0C15;
        Tue, 28 Nov 2023 03:01:20 -0800 (PST)
Received: from [10.1.33.188] (XHFQ2J9959.cambridge.arm.com [10.1.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A93FB3F73F;
        Tue, 28 Nov 2023 03:00:29 -0800 (PST)
Message-ID: <a43d8da8-d902-440c-aa64-df78fa4e185d@arm.com>
Date:   Tue, 28 Nov 2023 11:00:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/14] mm: Batch-copy PTE ranges during fork()
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
References: <20231115163018.1303287-2-ryan.roberts@arm.com>
 <20231127055414.9015-1-v-songbaohua@oppo.com>
 <755343a1-ce94-4d38-8317-0925e2dae3bc@arm.com>
 <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAGsJ_4z_ftxvG-EcTe=X+Te8fNSShhVHHPvbEgAa1rQXgO5XCA@mail.gmail.com>
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

On 28/11/2023 00:11, Barry Song wrote:
> On Mon, Nov 27, 2023 at 10:24 PM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/11/2023 05:54, Barry Song wrote:
>>>> +copy_present_ptes(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>>>> +              pte_t *dst_pte, pte_t *src_pte,
>>>> +              unsigned long addr, unsigned long end,
>>>> +              int *rss, struct folio **prealloc)
>>>>  {
>>>>      struct mm_struct *src_mm = src_vma->vm_mm;
>>>>      unsigned long vm_flags = src_vma->vm_flags;
>>>>      pte_t pte = ptep_get(src_pte);
>>>>      struct page *page;
>>>>      struct folio *folio;
>>>> +    int nr = 1;
>>>> +    bool anon;
>>>> +    bool any_dirty = pte_dirty(pte);
>>>> +    int i;
>>>>
>>>>      page = vm_normal_page(src_vma, addr, pte);
>>>> -    if (page)
>>>> +    if (page) {
>>>>              folio = page_folio(page);
>>>> -    if (page && folio_test_anon(folio)) {
>>>> -            /*
>>>> -             * If this page may have been pinned by the parent process,
>>>> -             * copy the page immediately for the child so that we'll always
>>>> -             * guarantee the pinned page won't be randomly replaced in the
>>>> -             * future.
>>>> -             */
>>>> -            folio_get(folio);
>>>> -            if (unlikely(page_try_dup_anon_rmap(page, false, src_vma))) {
>>>> -                    /* Page may be pinned, we have to copy. */
>>>> -                    folio_put(folio);
>>>> -                    return copy_present_page(dst_vma, src_vma, dst_pte, src_pte,
>>>> -                                             addr, rss, prealloc, page);
>>>> +            anon = folio_test_anon(folio);
>>>> +            nr = folio_nr_pages_cont_mapped(folio, page, src_pte, addr,
>>>> +                                            end, pte, &any_dirty);
>>>
>>> in case we have a large folio with 16 CONTPTE basepages, and userspace
>>> do madvise(addr + 4KB * 5, DONTNEED);
>>
>> nit: if you are offsetting by 5 pages from addr, then below I think you mean
>> page0~page4 and page6~15?
>>
>>>
>>> thus, the 4th basepage of PTE becomes PTE_NONE and folio_nr_pages_cont_mapped()
>>> will return 15. in this case, we should copy page0~page3 and page5~page15.
>>
>> No I don't think folio_nr_pages_cont_mapped() will return 15; that's certainly
>> not how its intended to work. The function is scanning forwards from the current
>> pte until it finds the first pte that does not fit in the batch - either because
>> it maps a PFN that is not contiguous, or because the permissions are different
>> (although this is being relaxed a bit; see conversation with DavidH against this
>> same patch).
>>
>> So the first time through this loop, folio_nr_pages_cont_mapped() will return 5,
>> (page0~page4) then the next time through the loop we will go through the
>> !present path and process the single swap marker. Then the 3rd time through the
>> loop folio_nr_pages_cont_mapped() will return 10.
> 
> one case we have met by running hundreds of real phones is as below,
> 
> 
> static int
> copy_pte_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma,
>                pmd_t *dst_pmd, pmd_t *src_pmd, unsigned long addr,
>                unsigned long end)
> {
>         ...
>         dst_pte = pte_alloc_map_lock(dst_mm, dst_pmd, addr, &dst_ptl);
>         if (!dst_pte) {
>                 ret = -ENOMEM;
>                 goto out;
>         }
>         src_pte = pte_offset_map_nolock(src_mm, src_pmd, addr, &src_ptl);
>         if (!src_pte) {
>                 pte_unmap_unlock(dst_pte, dst_ptl);
>                 /* ret == 0 */
>                 goto out;
>         }
>         spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>         orig_src_pte = src_pte;
>         orig_dst_pte = dst_pte;
>         arch_enter_lazy_mmu_mode();
> 
>         do {
>                 /*
>                  * We are holding two locks at this point - either of them
>                  * could generate latencies in another task on another CPU.
>                  */
>                 if (progress >= 32) {
>                         progress = 0;
>                         if (need_resched() ||
>                             spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
>                                 break;
>                 }
>                 ptent = ptep_get(src_pte);
>                 if (pte_none(ptent)) {
>                         progress++;
>                         continue;
>                 }
> 
> the above iteration can break when progress > =32. for example, at the
> beginning,
> if all PTEs are none, we break when progress >=32, and we break when we
> are in the 8th pte of 16PTEs which might become CONTPTE after we release
> PTL.
> 
> since we are releasing PTLs, next time when we get PTL, those pte_none() might
> become pte_cont(), then are you going to copy CONTPTE from 8th pte,
> thus, immediately
> break the consistent CONPTEs rule of hardware?
> 
> pte0 - pte_none
> pte1 - pte_none
> ...
> pte7 - pte_none
> 
> pte8 - pte_cont
> ...
> pte15 - pte_cont
> 
> so we did some modification to avoid a break in the middle of PTEs
> which can potentially
> become CONTPE.
> do {
>                 /*
>                 * We are holding two locks at this point - either of them
>                 * could generate latencies in another task on another CPU.
>                 */
>                 if (progress >= 32) {
>                                 progress = 0;
> #ifdef CONFIG_CONT_PTE_HUGEPAGE
>                 /*
>                 * XXX: don't release ptl at an unligned address as
> cont_pte might form while
>                 * ptl is released, this causes double-map
>                 */
>                 if (!vma_is_chp_anonymous(src_vma) ||
>                    (vma_is_chp_anonymous(src_vma) && IS_ALIGNED(addr,
> HPAGE_CONT_PTE_SIZE)))
> #endif
>                 if (need_resched() ||
>                    spin_needbreak(src_ptl) || spin_needbreak(dst_ptl))
>                                 break;
> }
> 
> We could only reproduce the above issue by running thousands of phones.
> 
> Does your code survive from this problem?

Yes I'm confident my code is safe against this; as I said before, the CONT_PTE
bit is not blindly "copied" from parent to child pte. As far as the core-mm is
concerned, there is no CONT_PTE bit; they are just regular PTEs. So the code
will see some pte_none() entries followed by some pte_present() entries. And
when calling set_ptes() on the child, the arch code will evaluate the current
state of the pgtable along with the new set_ptes() request and determine where
it should insert the CONT_PTE bit.

> 
>>
>> Thanks,
>> Ryan
>>
>>>
>>> but the current code is copying page0~page14, right? unless we are immediatly
>>> split_folio to basepages in zap_pte_range(), we will have problems?
>>>
>>>> +
>>>> +            for (i = 0; i < nr; i++, page++) {
>>>> +                    if (anon) {
>>>> +                            /*
>>>> +                             * If this page may have been pinned by the
>>>> +                             * parent process, copy the page immediately for
>>>> +                             * the child so that we'll always guarantee the
>>>> +                             * pinned page won't be randomly replaced in the
>>>> +                             * future.
>>>> +                             */
>>>> +                            if (unlikely(page_try_dup_anon_rmap(
>>>> +                                            page, false, src_vma))) {
>>>> +                                    if (i != 0)
>>>> +                                            break;
>>>> +                                    /* Page may be pinned, we have to copy. */
>>>> +                                    return copy_present_page(
>>>> +                                            dst_vma, src_vma, dst_pte,
>>>> +                                            src_pte, addr, rss, prealloc,
>>>> +                                            page);
>>>> +                            }
>>>> +                            rss[MM_ANONPAGES]++;
>>>> +                            VM_BUG_ON(PageAnonExclusive(page));
>>>> +                    } else {
>>>> +                            page_dup_file_rmap(page, false);
>>>> +                            rss[mm_counter_file(page)]++;
>>>> +                    }
>>>
> 
> Thanks
> Barry

