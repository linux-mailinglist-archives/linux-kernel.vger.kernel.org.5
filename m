Return-Path: <linux-kernel+bounces-63911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B1C853648
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3F3B1F27394
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA10160DCE;
	Tue, 13 Feb 2024 16:36:26 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4685FEF8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842186; cv=none; b=RSIbwOjobICQWEYUC+Mv4fySDi+Qdb9soWod8m/cIL69B68+nl4fgus4yRgU2nhxZxBeuGKJbcif3AIpagWZCDXG3XdVnWA84DugTNNCrt/FN18XN+kVP+ekwJidIUYiPa7h90S1tq04eEkYM1HFsbrwdGjRuVVnwJciLWQYeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842186; c=relaxed/simple;
	bh=1eCz4hgsVHurnxsOVBFVxoI7gJ8psqMdRg1J2mJF8Mo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eD47QdlqsJnOpkEuRe7jrxrVMBls2AwDxsesltSAGvKlNaZVOD0K9dk9CZbQq9Kj3zQMSOymj91b8FD6WjGdTM98XgvWkYdPLoF6P7dsFf8XPJk4uUavtSxTDLDrTZu68Pe92hT45MG4nGXpJiEOgPCqre2g6/lvi3cAdlHDdIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0454FDA7;
	Tue, 13 Feb 2024 08:37:04 -0800 (PST)
Received: from [10.1.36.184] (XHFQ2J9959.cambridge.arm.com [10.1.36.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 158103F5A1;
	Tue, 13 Feb 2024 08:36:18 -0800 (PST)
Message-ID: <4e748f14-647d-4ce5-a14a-464eefb01581@arm.com>
Date: Tue, 13 Feb 2024 16:36:17 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/25] arm64/mm: Implement new wrprotect_ptes() batch
 API
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
 James Morse <james.morse@arm.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@redhat.com>,
 Kefeng Wang <wangkefeng.wang@huawei.com>, John Hubbard
 <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Barry Song <21cnbao@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 Yang Shi <shy828301@gmail.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <20240202080756.1453939-1-ryan.roberts@arm.com>
 <20240202080756.1453939-21-ryan.roberts@arm.com>
 <ZcuZaO8pars3aFtu@FVFF77S0Q05N.cambridge.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZcuZaO8pars3aFtu@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 16:31, Mark Rutland wrote:
> On Fri, Feb 02, 2024 at 08:07:51AM +0000, Ryan Roberts wrote:
>> Optimize the contpte implementation to fix some of the fork performance
>> regression introduced by the initial contpte commit. Subsequent patches
>> will solve it entirely.
>>
>> During fork(), any private memory in the parent must be write-protected.
>> Previously this was done 1 PTE at a time. But the core-mm supports
>> batched wrprotect via the new wrprotect_ptes() API. So let's implement
>> that API and for fully covered contpte mappings, we no longer need to
>> unfold the contpte. This has 2 benefits:
>>
>>   - reduced unfolding, reduces the number of tlbis that must be issued.
>>   - The memory remains contpte-mapped ("folded") in the parent, so it
>>     continues to benefit from the more efficient use of the TLB after
>>     the fork.
>>
>> The optimization to wrprotect a whole contpte block without unfolding is
>> possible thanks to the tightening of the Arm ARM in respect to the
>> definition and behaviour when 'Misprogramming the Contiguous bit'. See
>> section D21194 at https://developer.arm.com/documentation/102105/latest/
> 
> Minor nit, but it'd be better to refer to a specific revision of the document,
> e.g.
> 
>   https://developer.arm.com/documentation/102105/ja-07/
> 
> That way people can see the specific version of the text you were referring to
> even if that changes later, and it means the link is still useful when D21194
> gets merged into the ARM ARM and dropped from the known issues doc.

ACK: will fix

> 
>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 61 ++++++++++++++++++++++++++------
>>  arch/arm64/mm/contpte.c          | 35 ++++++++++++++++++
>>  2 files changed, 86 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 34892a95403d..c07f0d563733 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -978,16 +978,12 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>  }
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>  
>> -/*
>> - * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
>> - * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
>> - */
>> -static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>> -					unsigned long address, pte_t *ptep)
>> +static inline void ___ptep_set_wrprotect(struct mm_struct *mm,
>> +					unsigned long address, pte_t *ptep,
>> +					pte_t pte)
>>  {
>> -	pte_t old_pte, pte;
>> +	pte_t old_pte;
>>  
>> -	pte = __ptep_get(ptep);
>>  	do {
>>  		old_pte = pte;
>>  		pte = pte_wrprotect(pte);
>> @@ -996,6 +992,25 @@ static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>>  	} while (pte_val(pte) != pte_val(old_pte));
>>  }
>>  
>> +/*
>> + * __ptep_set_wrprotect - mark read-only while trasferring potential hardware
>> + * dirty status (PTE_DBM && !PTE_RDONLY) to the software PTE_DIRTY bit.
>> + */
>> +static inline void __ptep_set_wrprotect(struct mm_struct *mm,
>> +					unsigned long address, pte_t *ptep)
>> +{
>> +	___ptep_set_wrprotect(mm, address, ptep, __ptep_get(ptep));
>> +}
>> +
>> +static inline void __wrprotect_ptes(struct mm_struct *mm, unsigned long address,
>> +				pte_t *ptep, unsigned int nr)
>> +{
>> +	unsigned int i;
>> +
>> +	for (i = 0; i < nr; i++, address += PAGE_SIZE, ptep++)
>> +		__ptep_set_wrprotect(mm, address, ptep);
>> +}
>> +
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>>  static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>> @@ -1156,6 +1171,8 @@ extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  				unsigned long addr, pte_t *ptep);
>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>  				unsigned long addr, pte_t *ptep);
>> +extern void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr);
>>  extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>  				unsigned long addr, pte_t *ptep,
>>  				pte_t entry, int dirty);
>> @@ -1269,12 +1286,35 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
>>  	return contpte_ptep_clear_flush_young(vma, addr, ptep);
>>  }
>>  
>> +#define wrprotect_ptes wrprotect_ptes
>> +static inline void wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr)
>> +{
>> +	if (likely(nr == 1)) {
>> +		/*
>> +		 * Optimization: wrprotect_ptes() can only be called for present
>> +		 * ptes so we only need to check contig bit as condition for
>> +		 * unfold, and we can remove the contig bit from the pte we read
>> +		 * to avoid re-reading. This speeds up fork() which is sensitive
>> +		 * for order-0 folios. Equivalent to contpte_try_unfold().
>> +		 */
>> +		pte_t orig_pte = __ptep_get(ptep);
>> +
>> +		if (unlikely(pte_cont(orig_pte))) {
>> +			__contpte_try_unfold(mm, addr, ptep, orig_pte);
>> +			orig_pte = pte_mknoncont(orig_pte);
>> +		}
>> +		___ptep_set_wrprotect(mm, addr, ptep, orig_pte);
>> +	} else {
>> +		contpte_wrprotect_ptes(mm, addr, ptep, nr);
>> +	}
>> +}
>> +
>>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>  				unsigned long addr, pte_t *ptep)
>>  {
>> -	contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> -	__ptep_set_wrprotect(mm, addr, ptep);
>> +	wrprotect_ptes(mm, addr, ptep, 1);
>>  }
>>  
>>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>> @@ -1306,6 +1346,7 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>>  #define ptep_clear_flush_young			__ptep_clear_flush_young
>>  #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>  #define ptep_set_wrprotect			__ptep_set_wrprotect
>> +#define wrprotect_ptes				__wrprotect_ptes
>>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>>  #define ptep_set_access_flags			__ptep_set_access_flags
>>  
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index bfb50e6b44c7..c85e64baf03b 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -23,6 +23,23 @@ static inline pte_t *contpte_align_down(pte_t *ptep)
>>  	return (pte_t *)(ALIGN_DOWN((unsigned long)ptep >> 3, CONT_PTES) << 3);
>>  }
>>  
>> +static void contpte_try_unfold_partial(struct mm_struct *mm, unsigned long addr,
>> +					pte_t *ptep, unsigned int nr)
>> +{
>> +	/*
>> +	 * Unfold any partially covered contpte block at the beginning and end
>> +	 * of the range.
>> +	 */
>> +
>> +	if (ptep != contpte_align_down(ptep) || nr < CONT_PTES)
>> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +
>> +	if (ptep + nr != contpte_align_down(ptep + nr))
>> +		contpte_try_unfold(mm, addr + PAGE_SIZE * (nr - 1),
>> +				ptep + nr - 1,
>> +				__ptep_get(ptep + nr - 1));
> 
> Nit: we should use braces for this 'if' block since it covers multiple lines
> (even though the function call is a single statement).
> 
> It *might* be worth using temporaries for the last ptep and addr, e.g.
> 
> 	if (ptep + nr != contpte_align_down(ptep + nr)) {
> 		unsigned long last_addr = addr + PAGE_SIZE * (nr - 1);
> 		pte_t *last_ptep = ptep + nr - 1;
> 		contpte_try_unfold(mm, last_addr, last_ptep,
> 				   __ptep_get(last_ptep));
> 	}
> 
> ... but I'm happy without the temporaries so long as we have braces.

ACK will fix and add temporaries.

> 
>> +}
>> +
>>  static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>>  			    pte_t *ptep, pte_t pte)
>>  {
>> @@ -236,6 +253,24 @@ int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>>  }
>>  EXPORT_SYMBOL(contpte_ptep_clear_flush_young);
>>  
>> +void contpte_wrprotect_ptes(struct mm_struct *mm, unsigned long addr,
>> +					pte_t *ptep, unsigned int nr)
>> +{
>> +	/*
>> +	 * If wrprotecting an entire contig range, we can avoid unfolding. Just
>> +	 * set wrprotect and wait for the later mmu_gather flush to invalidate
>> +	 * the tlb. Until the flush, the page may or may not be wrprotected.
>> +	 * After the flush, it is guarranteed wrprotected. If its a partial
> 
> Typo: s/guarranteed/guaranteed/
> Typo: s/its/it's/ (or s/its/it is/)

ACK: already fixed guaranteed after you pointed out the same typo in earlier
patch. Will fix it's.

> 
> Other than the above this looks good to me.

Great thanks!

> 
> Mark.
> 
>> +	 * range though, we must unfold, because we can't have a case where
>> +	 * CONT_PTE is set but wrprotect applies to a subset of the PTEs; this
>> +	 * would cause it to continue to be unpredictable after the flush.
>> +	 */
>> +
>> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
>> +	__wrprotect_ptes(mm, addr, ptep, nr);
>> +}
>> +EXPORT_SYMBOL(contpte_wrprotect_ptes);
>> +
>>  int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>>  					unsigned long addr, pte_t *ptep,
>>  					pte_t entry, int dirty)
>> -- 
>> 2.25.1
>>


