Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8461B80EB0D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjLLL5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:57:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjLLL5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:57:43 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3010FC3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:57:49 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 494A5143D;
        Tue, 12 Dec 2023 03:58:35 -0800 (PST)
Received: from [10.1.39.183] (XHFQ2J9959.cambridge.arm.com [10.1.39.183])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9B5AE3F762;
        Tue, 12 Dec 2023 03:57:45 -0800 (PST)
Message-ID: <97489e94-ea4e-40a3-9e56-d5f7d1219e81@arm.com>
Date:   Tue, 12 Dec 2023 11:57:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/15] mm: Batch-clear PTE ranges during
 zap_pte_range()
Content-Language: en-GB
To:     Alistair Popple <apopple@nvidia.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Yu Zhao <yuzhao@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
        Barry Song <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-3-ryan.roberts@arm.com>
 <87h6kta3ap.fsf@nvdebian.thelocal>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87h6kta3ap.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2023 01:30, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> Convert zap_pte_range() to clear a set of ptes in a batch. A given batch
>> maps a physically contiguous block of memory, all belonging to the same
>> folio. This will likely improve performance by a tiny amount due to
>> removing duplicate calls to mark the folio dirty and accessed. And also
>> provides us with a future opportunity to batch the rmap removal.
>>
>> However, the primary motivation for this change is to reduce the number
>> of tlb maintenance operations that the arm64 backend has to perform
>> during exit and other syscalls that cause zap_pte_range() (e.g. munmap,
>> madvise(DONTNEED), etc.), as it is about to add transparent support for
>> the "contiguous bit" in its ptes. By clearing ptes using the new
>> clear_ptes() API, the backend doesn't have to perform an expensive
>> unfold operation when a PTE being cleared is part of a contpte block.
>> Instead it can just clear the whole block immediately.
>>
>> This change addresses the core-mm refactoring only, and introduces
>> clear_ptes() with a default implementation that calls
>> ptep_get_and_clear_full() for each pte in the range. Note that this API
>> returns the pte at the beginning of the batch, but with the dirty and
>> young bits set if ANY of the ptes in the cleared batch had those bits
>> set; this information is applied to the folio by the core-mm. Given the
>> batch is garranteed to cover only a single folio, collapsing this state
> 
> Nit: s/garranteed/guaranteed/
> 
>> does not lose any useful information.
>>
>> A separate change will implement clear_ptes() in the arm64 backend to
>> realize the performance improvement as part of the work to enable
>> contpte mappings.
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  include/asm-generic/tlb.h |  9 ++++++
>>  include/linux/pgtable.h   | 26 ++++++++++++++++
>>  mm/memory.c               | 63 ++++++++++++++++++++++++++-------------
>>  mm/mmu_gather.c           | 14 +++++++++
>>  4 files changed, 92 insertions(+), 20 deletions(-)
> 
> <snip>
> 
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 4f559f4ddd21..57b4d5f0dfa4 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -47,6 +47,20 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>>  	return true;
>>  }
>>  
>> +unsigned int tlb_get_guaranteed_space(struct mmu_gather *tlb)
>> +{
>> +	struct mmu_gather_batch *batch = tlb->active;
>> +	unsigned int nr_next = 0;
>> +
>> +	/* Allocate next batch so we can guarrantee at least one batch. */
>> +	if (tlb_next_batch(tlb)) {
>> +		tlb->active = batch;
> 
> Rather than calling tlb_next_batch(tlb) and then undoing some of what it
> does I think it would be clearer to factor out the allocation part of
> tlb_next_batch(tlb) into a separate function (eg. tlb_alloc_batch) that
> you can call from both here and tlb_next_batch().

As per my email against patch 1, I have some perf regressions to iron out for
microbenchmarks; one issue is that this code forces the allocation of a page for
a batch even when we are only modifying a single pte (which would previously fit
in the embedded batch). So I've renamed this function to tlb_reserve_space(int
nr). If it already has enough room, it will jsut return immediately. Else it
will keep calling tlb_next_batch() in a loop until space has been allocated.
Then after the loop we set tlb->active back to the original batch.

Given the new potential need to loop a couple of times, and the need to build up
that linked list, I think it works nicely without refactoring tlb_next_batch().

> 
> Otherwise I think this overall direction looks better than trying to
> play funny games in the arch layer as it's much clearer what's going on
> to core-mm code.
> 
>  - Alistair
> 
>> +		nr_next = batch->next->max;
>> +	}
>> +
>> +	return batch->max - batch->nr + nr_next;
>> +}
>> +
>>  #ifdef CONFIG_SMP
>>  static void tlb_flush_rmap_batch(struct mmu_gather_batch *batch, struct vm_area_struct *vma)
>>  {
> 

