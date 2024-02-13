Return-Path: <linux-kernel+bounces-63937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5728F853695
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:50:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1A171F251E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DC05FB9D;
	Tue, 13 Feb 2024 16:48:58 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F173D5DF29
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842938; cv=none; b=m4zqc1BcpKXKPGnck6Lm5pW58ClQc4c2i3ZQbjQiJnMx8mQWWLZLGF7HD40JU6VUuzCh72396/NCPt1Zakgq0hW2rSZtLk6T8XrxO+N36olO4pQeUWZC5KVBXUqcr+YDZ5ZQoGI+m9w5GKF1h8e5ZfC8JodSHMCyJlzcYVzsrqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842938; c=relaxed/simple;
	bh=0zU1P0q/AiovSFg302dxcukywFAagconXoCXEO9D95M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sfW3MN7gN1Gll9cEzUQxU3FffqZyyof1f+DiOLIUMm/DWR2DYAFI9mCDjQr4GBOl0Q2ndGoeDdZNUXS14Rr9RZMumPjefT6aUgo3e0rDHzt6cj21H0egqeI0TK/4BE8kki/8zoQjdybvHq3bfAfuR+x1ZWSQFFIGAmnrBiHz8X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E6F9DA7;
	Tue, 13 Feb 2024 08:49:36 -0800 (PST)
Received: from [10.1.36.184] (XHFQ2J9959.cambridge.arm.com [10.1.36.184])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EA173F5A1;
	Tue, 13 Feb 2024 08:48:51 -0800 (PST)
Message-ID: <aaf2bc8e-3fe3-4d41-ab5b-fca99b33c8a4@arm.com>
Date: Tue, 13 Feb 2024 16:48:50 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/25] arm64/mm: Implement new
 [get_and_]clear_full_ptes() batch APIs
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
 <20240202080756.1453939-22-ryan.roberts@arm.com>
 <ZcucHyb1OBG677gx@FVFF77S0Q05N.cambridge.arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZcucHyb1OBG677gx@FVFF77S0Q05N.cambridge.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 16:43, Mark Rutland wrote:
> On Fri, Feb 02, 2024 at 08:07:52AM +0000, Ryan Roberts wrote:
>> Optimize the contpte implementation to fix some of the
>> exit/munmap/dontneed performance regression introduced by the initial
>> contpte commit. Subsequent patches will solve it entirely.
>>
>> During exit(), munmap() or madvise(MADV_DONTNEED), mappings must be
>> cleared. Previously this was done 1 PTE at a time. But the core-mm
>> supports batched clear via the new [get_and_]clear_full_ptes() APIs. So
>> let's implement those APIs and for fully covered contpte mappings, we no
>> longer need to unfold the contpte. This significantly reduces unfolding
>> operations, reducing the number of tlbis that must be issued.
>>
>> Tested-by: John Hubbard <jhubbard@nvidia.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable.h | 67 ++++++++++++++++++++++++++++++++
>>  arch/arm64/mm/contpte.c          | 17 ++++++++
>>  2 files changed, 84 insertions(+)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index c07f0d563733..ad04adb7b87f 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -965,6 +965,37 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
>>  	return pte;
>>  }
>>  
>> +static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr, int full)
>> +{
>> +	for (;;) {
>> +		__ptep_get_and_clear(mm, addr, ptep);
>> +		if (--nr == 0)
>> +			break;
>> +		ptep++;
>> +		addr += PAGE_SIZE;
>> +	}
>> +}
> 
> The loop construct is a bit odd; can't this be:

I found it a little odd at first, but its avoiding the ptep and addr increments
the last time through the loop. Its the preferred pattern for these functions in
core-mm. See default set_ptes(), wrprotect_ptes(), clear_full_ptes() in
include/linux/pgtable.h.

So I'd prefer to leave it as is so that we match them. What do you think?

> 
> 	while (nr--) {
> 		__ptep_get_and_clear(mm, addr, ptep);
> 		ptep++;
> 		addr += PAGE_SIZE;
> 	}
> 
> ... or:
> 
> 	do {
> 		__ptep_get_and_clear(mm, addr, ptep);
> 		ptep++;
> 		addr += PAGE_SIZE;
> 	} while (--nr);
> 
> ... ?
> 
> Otherwise, this looks good to me.
> 
> Mark.
> 
>> +
>> +static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep,
>> +				unsigned int nr, int full)
>> +{
>> +	pte_t pte, tmp_pte;
>> +
>> +	pte = __ptep_get_and_clear(mm, addr, ptep);
>> +	while (--nr) {
>> +		ptep++;
>> +		addr += PAGE_SIZE;
>> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
>> +		if (pte_dirty(tmp_pte))
>> +			pte = pte_mkdirty(pte);
>> +		if (pte_young(tmp_pte))
>> +			pte = pte_mkyoung(pte);
>> +	}
>> +	return pte;
>> +}
>> +
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
>>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>> @@ -1167,6 +1198,11 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>  				pte_t *ptep, pte_t pte, unsigned int nr);
>> +extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr, int full);
>> +extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep,
>> +				unsigned int nr, int full);
>>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  				unsigned long addr, pte_t *ptep);
>>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
>> @@ -1254,6 +1290,35 @@ static inline void pte_clear(struct mm_struct *mm,
>>  	__pte_clear(mm, addr, ptep);
>>  }
>>  
>> +#define clear_full_ptes clear_full_ptes
>> +static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr, int full)
>> +{
>> +	if (likely(nr == 1)) {
>> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +		__clear_full_ptes(mm, addr, ptep, nr, full);
>> +	} else {
>> +		contpte_clear_full_ptes(mm, addr, ptep, nr, full);
>> +	}
>> +}
>> +
>> +#define get_and_clear_full_ptes get_and_clear_full_ptes
>> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep,
>> +				unsigned int nr, int full)
>> +{
>> +	pte_t pte;
>> +
>> +	if (likely(nr == 1)) {
>> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>> +		pte = __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
>> +	} else {
>> +		pte = contpte_get_and_clear_full_ptes(mm, addr, ptep, nr, full);
>> +	}
>> +
>> +	return pte;
>> +}
>> +
>>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>  				unsigned long addr, pte_t *ptep)
>> @@ -1338,6 +1403,8 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>>  #define set_pte					__set_pte
>>  #define set_ptes				__set_ptes
>>  #define pte_clear				__pte_clear
>> +#define clear_full_ptes				__clear_full_ptes
>> +#define get_and_clear_full_ptes			__get_and_clear_full_ptes
>>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>  #define ptep_get_and_clear			__ptep_get_and_clear
>>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
>> index c85e64baf03b..80346108450b 100644
>> --- a/arch/arm64/mm/contpte.c
>> +++ b/arch/arm64/mm/contpte.c
>> @@ -207,6 +207,23 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>>  }
>>  EXPORT_SYMBOL(contpte_set_ptes);
>>  
>> +void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
>> +				pte_t *ptep, unsigned int nr, int full)
>> +{
>> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
>> +	__clear_full_ptes(mm, addr, ptep, nr, full);
>> +}
>> +EXPORT_SYMBOL(contpte_clear_full_ptes);
>> +
>> +pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
>> +				unsigned long addr, pte_t *ptep,
>> +				unsigned int nr, int full)
>> +{
>> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
>> +	return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
>> +}
>> +EXPORT_SYMBOL(contpte_get_and_clear_full_ptes);
>> +
>>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>>  					unsigned long addr, pte_t *ptep)
>>  {
>> -- 
>> 2.25.1
>>


