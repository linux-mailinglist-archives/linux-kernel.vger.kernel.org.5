Return-Path: <linux-kernel+bounces-4890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E202981835F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 23664B2235B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EA2125C2;
	Tue, 19 Dec 2023 08:30:20 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B373179C6
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 334421FB;
	Tue, 19 Dec 2023 00:31:01 -0800 (PST)
Received: from [10.57.75.230] (unknown [10.57.75.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 121813F738;
	Tue, 19 Dec 2023 00:30:12 -0800 (PST)
Message-ID: <db1be625-33e4-4d07-8500-3f7d3c8f9937@arm.com>
Date: Tue, 19 Dec 2023 08:30:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/16] mm: Batch-copy PTE ranges during fork()
Content-Language: en-GB
To: David Hildenbrand <david@redhat.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu
 <yuzenghui@huawei.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Alexander Potapenko <glider@google.com>,
 Andrey Konovalov <andreyknvl@gmail.com>, Dmitry Vyukov <dvyukov@google.com>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Matthew Wilcox <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Kefeng Wang
 <wangkefeng.wang@huawei.com>, John Hubbard <jhubbard@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Barry Song <21cnbao@gmail.com>,
 Alistair Popple <apopple@nvidia.com>, Yang Shi <shy828301@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231218105100.172635-1-ryan.roberts@arm.com>
 <20231218105100.172635-3-ryan.roberts@arm.com>
 <0bef5423-6eea-446b-8854-980e9c23a948@redhat.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <0bef5423-6eea-446b-8854-980e9c23a948@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 18/12/2023 17:47, David Hildenbrand wrote:
> On 18.12.23 11:50, Ryan Roberts wrote:
>> Convert copy_pte_range() to copy a batch of ptes in one go. A given
>> batch is determined by the architecture with the new helper,
>> pte_batch_remaining(), and maps a physically contiguous block of memory,
>> all belonging to the same folio. A pte batch is then write-protected in
>> one go in the parent using the new helper, ptep_set_wrprotects() and is
>> set in one go in the child using the new helper, set_ptes_full().
>>
>> The primary motivation for this change is to reduce the number of tlb
>> maintenance operations that the arm64 backend has to perform during
>> fork, as it is about to add transparent support for the "contiguous bit"
>> in its ptes. By write-protecting the parent using the new
>> ptep_set_wrprotects() (note the 's' at the end) function, the backend
>> can avoid having to unfold contig ranges of PTEs, which is expensive,
>> when all ptes in the range are being write-protected. Similarly, by
>> using set_ptes_full() rather than set_pte_at() to set up ptes in the
>> child, the backend does not need to fold a contiguous range once they
>> are all populated - they can be initially populated as a contiguous
>> range in the first place.
>>
>> This code is very performance sensitive, and a significant amount of
>> effort has been put into not regressing performance for the order-0
>> folio case. By default, pte_batch_remaining() is compile constant 1,
>> which enables the compiler to simplify the extra loops that are added
>> for batching and produce code that is equivalent (and equally
>> performant) as the previous implementation.
>>
>> This change addresses the core-mm refactoring only and a separate change
>> will implement pte_batch_remaining(), ptep_set_wrprotects() and
>> set_ptes_full() in the arm64 backend to realize the performance
>> improvement as part of the work to enable contpte mappings.
>>
>> To ensure the arm64 is performant once implemented, this change is very
>> careful to only call ptep_get() once per pte batch.
>>
>> The following microbenchmark results demonstate that there is no
>> significant performance change after this patch. Fork is called in a
>> tight loop in a process with 1G of populated memory and the time for the
>> function to execute is measured. 100 iterations per run, 8 runs
>> performed on both Apple M2 (VM) and Ampere Altra (bare metal). Tests
>> performed for case where 1G memory is comprised of order-0 folios and
>> case where comprised of pte-mapped order-9 folios. Negative is faster,
>> positive is slower, compared to baseline upon which the series is based:
>>
>> | Apple M2 VM   | order-0 (pte-map) | order-9 (pte-map) |
>> | fork          |-------------------|-------------------|
>> | microbench    |    mean |   stdev |    mean |   stdev |
>> |---------------|---------|---------|---------|---------|
>> | baseline      |    0.0% |    1.1% |    0.0% |    1.2% |
>> | after-change  |   -1.0% |    2.0% |   -0.1% |    1.1% |
>>
>> | Ampere Altra  | order-0 (pte-map) | order-9 (pte-map) |
>> | fork          |-------------------|-------------------|
>> | microbench    |    mean |   stdev |    mean |   stdev |
>> |---------------|---------|---------|---------|---------|
>> | baseline      |    0.0% |    1.0% |    0.0% |    0.1% |
>> | after-change  |   -0.1% |    1.2% |   -0.1% |    0.1% |
>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Reviewed-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>   include/linux/pgtable.h | 80 +++++++++++++++++++++++++++++++++++
>>   mm/memory.c             | 92 ++++++++++++++++++++++++++---------------
>>   2 files changed, 139 insertions(+), 33 deletions(-)
>>
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index af7639c3b0a3..db93fb81465a 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -205,6 +205,27 @@ static inline int pmd_young(pmd_t pmd)
>>   #define arch_flush_lazy_mmu_mode()    do {} while (0)
>>   #endif
>>   +#ifndef pte_batch_remaining
>> +/**
>> + * pte_batch_remaining - Number of pages from addr to next batch boundary.
>> + * @pte: Page table entry for the first page.
>> + * @addr: Address of the first page.
>> + * @end: Batch ceiling (e.g. end of vma).
>> + *
>> + * Some architectures (arm64) can efficiently modify a contiguous batch of ptes.
>> + * In such cases, this function returns the remaining number of pages to the end
>> + * of the current batch, as defined by addr. This can be useful when iterating
>> + * over ptes.
>> + *
>> + * May be overridden by the architecture, else batch size is always 1.
>> + */
>> +static inline unsigned int pte_batch_remaining(pte_t pte, unsigned long addr,
>> +                        unsigned long end)
>> +{
>> +    return 1;
>> +}
>> +#endif
> 
> It's a shame we now lose the optimization for all other archtiectures.
> 
> Was there no way to have some basic batching mechanism that doesn't require arch
> specifics?

I tried a bunch of things but ultimately the way I've done it was the only way
to reduce the order-0 fork regression to 0.

My original v3 posting was costing 5% extra and even my first attempt at an
arch-specific version that didn't resolve to a compile-time constant 1 still
cost an extra 3%.


> 
> I'd have thought that something very basic would have worked like:
> 
> * Check if PTE is the same when setting the PFN to 0.
> * Check that PFN is consecutive
> * Check that all PFNs belong to the same folio

I haven't tried this exact approach, but I'd be surprised if I can get the
regression under 4% with this. Further along the series I spent a lot of time
having to fiddle with the arm64 implementation; every conditional and every
memory read (even when in cache) was a problem. There is just so little in the
inner loop that every instruction matters. (At least on Ampere Altra and Apple M2).

Of course if you're willing to pay that 4-5% for order-0 then the benefit to
order-9 is around 10% in my measurements. Personally though, I'd prefer to play
safe and ensure the common order-0 case doesn't regress, as you previously
suggested.


