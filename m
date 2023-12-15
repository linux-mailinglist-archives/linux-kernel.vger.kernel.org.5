Return-Path: <linux-kernel+bounces-1084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCE12814A12
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:08:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72B1C285DB0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8083B3159C;
	Fri, 15 Dec 2023 14:05:36 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9606A3159D
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25C08C15;
	Fri, 15 Dec 2023 06:06:18 -0800 (PST)
Received: from [10.57.76.37] (unknown [10.57.76.37])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 68DE03F5A1;
	Fri, 15 Dec 2023 06:05:29 -0800 (PST)
Message-ID: <f2a3b1f0-0823-4c3a-b0e8-20ac83e855b2@arm.com>
Date: Fri, 15 Dec 2023 14:05:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/15] arm64/mm: Implement ptep_set_wrprotects() to
 optimize fork()
Content-Language: en-GB
To: Alistair Popple <apopple@nvidia.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
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
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Yang Shi <shy828301@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20231204105440.61448-1-ryan.roberts@arm.com>
 <20231204105440.61448-15-ryan.roberts@arm.com>
 <87cyvha2xd.fsf@nvdebian.thelocal>
 <ecf129dd-000f-45be-95dc-1e8dad5a8c12@arm.com>
 <87fs0413rx.fsf@nvdebian.thelocal>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <87fs0413rx.fsf@nvdebian.thelocal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/12/2023 04:32, Alistair Popple wrote:
> 
> Ryan Roberts <ryan.roberts@arm.com> writes:
> 
>> On 08/12/2023 01:37, Alistair Popple wrote:
>>>
>>> Ryan Roberts <ryan.roberts@arm.com> writes:
>>>
>>>> With the core-mm changes in place to batch-copy ptes during fork, we can
>>>> take advantage of this in arm64 to greatly reduce the number of tlbis we
>>>> have to issue, and recover the lost fork performance incured when adding
>>>> support for transparent contiguous ptes.
>>>>
>>>> If we are write-protecting a whole contig range, we can apply the
>>>> write-protection to the whole range and know that it won't change
>>>> whether the range should have the contiguous bit set or not. For ranges
>>>> smaller than the contig range, we will still have to unfold, apply the
>>>> write-protection, then fold if the change now means the range is
>>>> foldable.
>>>>
>>>> This optimization is possible thanks to the tightening of the Arm ARM in
>>>> respect to the definition and behaviour when 'Misprogramming the
>>>> Contiguous bit'. See section D21194 at
>>>> https://developer.arm.com/documentation/102105/latest/
>>>>
>>>> Performance tested with the following test written for the will-it-scale
>>>> framework:
>>>>
>>>> -------
>>>>
>>>> char *testcase_description = "fork and exit";
>>>>
>>>> void testcase(unsigned long long *iterations, unsigned long nr)
>>>> {
>>>> 	int pid;
>>>> 	char *mem;
>>>>
>>>> 	mem = malloc(SZ_128M);
>>>> 	assert(mem);
>>>> 	memset(mem, 1, SZ_128M);
>>>>
>>>> 	while (1) {
>>>> 		pid = fork();
>>>> 		assert(pid >= 0);
>>>>
>>>> 		if (!pid)
>>>> 			exit(0);
>>>>
>>>> 		waitpid(pid, NULL, 0);
>>>>
>>>> 		(*iterations)++;
>>>> 	}
>>>> }
>>>>
>>>> -------
>>>>
>>>> I see huge performance regression when PTE_CONT support was added, then
>>>> the regression is mostly fixed with the addition of this change. The
>>>> following shows regression relative to before PTE_CONT was enabled
>>>> (bigger negative value is bigger regression):
>>>>
>>>> |   cpus |   before opt |   after opt |
>>>> |-------:|-------------:|------------:|
>>>> |      1 |       -10.4% |       -5.2% |
>>>> |      8 |       -15.4% |       -3.5% |
>>>> |     16 |       -38.7% |       -3.7% |
>>>> |     24 |       -57.0% |       -4.4% |
>>>> |     32 |       -65.8% |       -5.4% |
>>>>
>>>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>>>> ---
>>>>  arch/arm64/include/asm/pgtable.h | 30 ++++++++++++++++++++---
>>>>  arch/arm64/mm/contpte.c          | 42 ++++++++++++++++++++++++++++++++
>>>>  2 files changed, 69 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index 15bc9cf1eef4..9bd2f57a9e11 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -984,6 +984,16 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>>>>  	} while (pte_val(pte) != pte_val(old_pte));
>>>>  }
>>>>  
>>>> +static inline void __ptep_set_wrprotects(struct mm_struct *mm,
>>>> +					unsigned long address, pte_t *ptep,
>>>> +					unsigned int nr)
>>>> +{
>>>> +	unsigned int i;
>>>> +
>>>> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>>>> +		__ptep_set_wrprotect(mm, address, ptep);
>>>> +}
>>>> +
>>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>>>>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>>>> @@ -1139,6 +1149,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>>>  				unsigned long addr, pte_t *ptep);
>>>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>  				unsigned long addr, pte_t *ptep);
>>>> +extern void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>>> +				pte_t *ptep, unsigned int nr);
>>>>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>>>  				unsigned long addr, pte_t *ptep,
>>>>  				pte_t entry, int dirty);
>>>> @@ -1290,13 +1302,25 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>  	return contpte_ptep_clear_flush_young(vma, addr, ptep);
>>>>  }
>>>>  
>>>> +#define ptep_set_wrprotects ptep_set_wrprotects
>>>> +static inline void ptep_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>>> +				pte_t *ptep, unsigned int nr)
>>>> +{
>>>> +	if (!contpte_is_enabled(mm))
>>>> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
>>>> +	else if (nr == 1) {
>>>
>>> Why do we need the special case here? Couldn't we just call
>>> contpte_set_wrprotects() with nr == 1?
>>
>> My intention is for this to be a fast path for ptep_set_wrprotect(). I'm having
>> to work hard to prevent regressing the order-0 folios case.
> 
> This ends up calling three functions anyway so I'm curious - does
> removing the one function call really make that much of difference?

Yes; big time. All the functions in the fast path are inlined. The version
regresses a fork() microbenchmark that David gave me by ~30%. I've had to work
quite hard to reduce that to 2%, even from this starting point. There is so
little in the inner loop that even the __ptep_get(ptep) (which is a READ_ONCE())
makes a measurable difference.

Anyway, I'll be posting v4 with these optimizations and all the supporting
benchmark data on Monday.

> 
> Either way I think a comment justifying the special case (ie. that this
> is simply a fast path for nr == 1) would be good.

I've added a comment here in v4.

> 
> Thanks.
> 
>>>
>>>> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>>> +		__ptep_set_wrprotects(mm, addr, ptep, 1);
>>>> +		contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
>>>> +	} else
>>>> +		contpte_set_wrprotects(mm, addr, ptep, nr);
>>>> +}
>>>> +
>>>>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>>>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>>>  				unsigned long addr, pte_t *ptep)
>>>>  {
>>>> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>>> -	__ptep_set_wrprotect(mm, addr, ptep);
>>>> -	contpte_try_fold(mm, addr, ptep, __ptep_get(ptep));
>>>> +	ptep_set_wrprotects(mm, addr, ptep, 1);
>>>>  }
>>>>  
>>>>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>>>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>>>> index e079ec61d7d1..2a57df16bf58 100644
>>>> --- a/arch/arm64/mm/contpte.c
>>>> +++ b/arch/arm64/mm/contpte.c
>>>> @@ -303,6 +303,48 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>>>  }
>>>>  EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
>>>>  
>>>> +void contpte_set_wrprotects(struct mm_struct *mm, unsigned long addr,
>>>> +					pte_t *ptep, unsigned int nr)
>>>> +{
>>>> +	unsigned long next;
>>>> +	unsigned long end = addr + (nr << PAGE_SHIFT);
>>>> +
>>>> +	do {
>>>> +		next = pte_cont_addr_end(addr, end);
>>>> +		nr = (next - addr) >> PAGE_SHIFT;
>>>> +
>>>> +		/*
>>>> +		 * If wrprotecting an entire contig range, we can avoid
>>>> +		 * unfolding. Just set wrprotect and wait for the later
>>>> +		 * mmu_gather flush to invalidate the tlb. Until the flush, the
>>>> +		 * page may or may not be wrprotected. After the flush, it is
>>>> +		 * guarranteed wrprotected. If its a partial range though, we
>>>> +		 * must unfold, because we can't have a case where CONT_PTE is
>>>> +		 * set but wrprotect applies to a subset of the PTEs; this would
>>>> +		 * cause it to continue to be unpredictable after the flush.
>>>> +		 */
>>>> +		if (nr != CONT_PTES)
>>>> +			contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>>>> +
>>>> +		__ptep_set_wrprotects(mm, addr, ptep, nr);
>>>> +
>>>> +		addr = next;
>>>> +		ptep += nr;
>>>> +
>>>> +		/*
>>>> +		 * If applying to a partial contig range, the change could have
>>>> +		 * made the range foldable. Use the last pte in the range we
>>>> +		 * just set for comparison, since contpte_try_fold() only
>>>> +		 * triggers when acting on the last pte in the contig range.
>>>> +		 */
>>>> +		if (nr != CONT_PTES)
>>>> +			contpte_try_fold(mm, addr - PAGE_SIZE, ptep - 1,
>>>> +					 __ptep_get(ptep - 1));
>>>> +
>>>> +	} while (addr != end);
>>>> +}
>>>> +EXPORT_SYMBOL(contpte_set_wrprotects);
>>>> +
>>>>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>>>  					unsigned long addr, pte_t *ptep,
>>>>  					pte_t entry, int dirty)
>>>
> 


