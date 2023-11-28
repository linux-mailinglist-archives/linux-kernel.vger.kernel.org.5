Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC04F7FB9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344569AbjK1L6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344263AbjK1L62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:58:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B900892
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:58:34 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59460C15;
        Tue, 28 Nov 2023 03:59:21 -0800 (PST)
Received: from [10.1.33.188] (XHFQ2J9959.cambridge.arm.com [10.1.33.188])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B28993F73F;
        Tue, 28 Nov 2023 03:58:27 -0800 (PST)
Message-ID: <15c68452-cc8e-45a5-bcaf-79b040afc746@arm.com>
Date:   Tue, 28 Nov 2023 11:58:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] Transparent Contiguous PTEs for User Mappings
Content-Language: en-GB
To:     Yang Shi <shy828301@gmail.com>
Cc:     Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
        andreyknvl@gmail.com, anshuman.khandual@arm.com, ardb@kernel.org,
        catalin.marinas@arm.com, david@redhat.com, dvyukov@google.com,
        glider@google.com, james.morse@arm.com, jhubbard@nvidia.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mark.rutland@arm.com, maz@kernel.org,
        oliver.upton@linux.dev, ryabinin.a.a@gmail.com,
        suzuki.poulose@arm.com, vincenzo.frascino@arm.com,
        wangkefeng.wang@huawei.com, will@kernel.org, willy@infradead.org,
        yuzenghui@huawei.com, yuzhao@google.com, ziy@nvidia.com
References: <20231115163018.1303287-1-ryan.roberts@arm.com>
 <20231127031813.5576-1-v-songbaohua@oppo.com>
 <234021ba-73c2-474a-82f9-91e1604d5bb5@arm.com>
 <CAHbLzkpbKwM9gjaeAnvEXwNCYsnMJO7JyjyFxxfnJOwMxDPBSw@mail.gmail.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <CAHbLzkpbKwM9gjaeAnvEXwNCYsnMJO7JyjyFxxfnJOwMxDPBSw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2023 03:13, Yang Shi wrote:
> On Mon, Nov 27, 2023 at 1:15 AM Ryan Roberts <ryan.roberts@arm.com> wrote:
>>
>> On 27/11/2023 03:18, Barry Song wrote:
>>>> Ryan Roberts (14):
>>>>   mm: Batch-copy PTE ranges during fork()
>>>>   arm64/mm: set_pte(): New layer to manage contig bit
>>>>   arm64/mm: set_ptes()/set_pte_at(): New layer to manage contig bit
>>>>   arm64/mm: pte_clear(): New layer to manage contig bit
>>>>   arm64/mm: ptep_get_and_clear(): New layer to manage contig bit
>>>>   arm64/mm: ptep_test_and_clear_young(): New layer to manage contig bit
>>>>   arm64/mm: ptep_clear_flush_young(): New layer to manage contig bit
>>>>   arm64/mm: ptep_set_wrprotect(): New layer to manage contig bit
>>>>   arm64/mm: ptep_set_access_flags(): New layer to manage contig bit
>>>>   arm64/mm: ptep_get(): New layer to manage contig bit
>>>>   arm64/mm: Split __flush_tlb_range() to elide trailing DSB
>>>>   arm64/mm: Wire up PTE_CONT for user mappings
>>>>   arm64/mm: Implement ptep_set_wrprotects() to optimize fork()
>>>>   arm64/mm: Add ptep_get_and_clear_full() to optimize process teardown
>>>
>>> Hi Ryan,
>>> Not quite sure if I missed something, are we splitting/unfolding CONTPTES
>>> in the below cases
>>
>> The general idea is that the core-mm sets the individual ptes (one at a time if
>> it likes with set_pte_at(), or in a block with set_ptes()), modifies its
>> permissions (ptep_set_wrprotect(), ptep_set_access_flags()) and clears them
>> (ptep_clear(), etc); This is exactly the same interface as previously.
>>
>> BUT, the arm64 implementation of those interfaces will now detect when a set of
>> adjacent PTEs (a contpte block - so 16 naturally aligned entries when using 4K
>> base pages) are all appropriate for having the CONT_PTE bit set; in this case
>> the block is "folded". And it will detect when the first PTE in the block
>> changes such that the CONT_PTE bit must now be unset ("unfolded"). One of the
>> requirements for folding a contpte block is that all the pages must belong to
>> the *same* folio (that means its safe to only track access/dirty for thecontpte
>> block as a whole rather than for each individual pte).
>>
>> (there are a couple of optimizations that make the reality slightly more
>> complicated than what I've just explained, but you get the idea).
>>
>> On that basis, I believe all the specific cases you describe below are all
>> covered and safe - please let me know if you think there is a hole here!
>>
>>>
>>> 1. madvise(MADV_DONTNEED) on a part of basepages on a CONTPTE large folio
>>
>> The page will first be unmapped (e.g. ptep_clear() or ptep_get_and_clear(), or
>> whatever). The implementation of that will cause an unfold and the CONT_PTE bit
>> is removed from the whole contpte block. If there is then a subsequent
>> set_pte_at() to set a swap entry, the implementation will see that its not
>> appropriate to re-fold, so the range will remain unfolded.
>>
>>>
>>> 2. vma split in a large folio due to various reasons such as mprotect,
>>> munmap, mlock etc.
>>
>> I'm not sure if PTEs are explicitly unmapped/remapped when splitting a VMA? I
>> suspect not, so if the VMA is split in the middle of a currently folded contpte
>> block, it will remain folded. But this is safe and continues to work correctly.
>> The VMA arrangement is not important; it is just important that a single folio
>> is mapped contiguously across the whole block.
> 
> Even with different permissions, for example, read-only vs read-write?
> The mprotect() may change the permission. It should be misprogramming
> per ARM ARM.

If the permissions are changed, then mprotect() must have called the pgtable
helpers to modify the page table (e.g. ptep_set_wrprotect(),
ptep_set_access_flags() or whatever). These functions will notice that the
contpte block is currently folded and unfold it before apply the permissions
change. The unfolding process is done in a way that intentionally avoids
misprogramming as defined by the Arm ARM. See contpte_fold() in contpte.c.

> 
>>
>>>
>>> 3. try_to_unmap_one() to reclaim a folio, ptes are scanned one by one
>>> rather than being as a whole.
>>
>> Yes, as per 1; the arm64 implementation will notice when the first entry is
>> cleared and unfold the contpte block.
>>
>>>
>>> In hardware, we need to make sure CONTPTE follow the rule - always 16
>>> contiguous physical address with CONTPTE set. if one of them run away
>>> from the 16 ptes group and PTEs become unconsistent, some terrible
>>> errors/faults can happen in HW. for example
>>
>> Yes, the implementation obeys all these rules; see contpte_try_fold() and
>> contpte_try_unfold(). the fold/unfold operation is only done when all
>> requirements are met, and we perform it in a manner that is conformant to the
>> architecture requirements (see contpte_fold() - being renamed to
>> contpte_convert() in the next version).
>>
>> Thanks for the review!
>>
>> Thanks,
>> Ryan
>>
>>>
>>> case0:
>>> addr0 PTE - has no CONTPE
>>> addr0+4kb PTE - has CONTPTE
>>> ....
>>> addr0+60kb PTE - has CONTPTE
>>>
>>> case 1:
>>> addr0 PTE - has no CONTPE
>>> addr0+4kb PTE - has CONTPTE
>>> ....
>>> addr0+60kb PTE - has swap
>>>
>>> Unconsistent 16 PTEs will lead to crash even in the firmware based on
>>> our observation.
>>>
>>> Thanks
>>> Barry
>>>
>>>
>>
>>

