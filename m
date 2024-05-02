Return-Path: <linux-kernel+bounces-166090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE8B8B961B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BD841F215C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C622D047;
	Thu,  2 May 2024 08:05:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F61225AF
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 08:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714637151; cv=none; b=unFkfrIfkE6seURU5oMgM3XWoT00Bw/1J78iDCmWrJLBRprLCem2bfC85jpeeVETnM9IZnDEjtkfllQ7z6NqSv9+sdLYUztnoY4H3VeeCnrJSzH2yEMlWNTTNYe5OqTdvbZLeyz4JvpBWQIXaD0YJsEFZnXZVmWQbtkDnzbhh/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714637151; c=relaxed/simple;
	bh=NQ8HTzmP+GkLCBO8eFp7kYfPcpiW3lVt6a+jVQhYANg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dIgnLaPuWWrdTEbdykiT2yVOIOy+J9kuybu45cIk9Jp+O3W9E1tLgEDBAeMbBXLlH3OaAQb3xbbyX6Im5hmxKQ5VJShaQ3LuQ8L5NSwAyNb1Azq38XTH6CenUzL1n+TEEUh6iPwZhojiiriHeu11tAQ93nM9DT2/FcI4BN0Ej7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A92872F4;
	Thu,  2 May 2024 01:06:13 -0700 (PDT)
Received: from [10.57.65.146] (unknown [10.57.65.146])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 401B53F71E;
	Thu,  2 May 2024 01:05:46 -0700 (PDT)
Message-ID: <6d261c44-9e4b-4579-9ccf-56c3314e4602@arm.com>
Date: Thu, 2 May 2024 09:05:44 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Mike Rapoport <rppt@linux.ibm.com>,
 Shivansh Vij <shivanshvij@outlook.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240501145419.1390363-1-ryan.roberts@arm.com>
 <20240501145419.1390363-2-ryan.roberts@arm.com>
 <8b31de4c-24a2-4cca-a59e-8d2fb9de44d3@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <8b31de4c-24a2-4cca-a59e-8d2fb9de44d3@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/05/2024 06:26, Anshuman Khandual wrote:
> 
> 
> On 5/1/24 20:24, Ryan Roberts wrote:
>> Currently the PMD_PRESENT_INVALID and PTE_PROT_NONE functionality
>> explicitly occupy 2 bits in the PTE when PTE_VALID/PMD_SECT_VALID is
>> clear. This has 2 significant consequences:
>>
>>   - PTE_PROT_NONE consumes a precious SW PTE bit that could be used for
>>     other things.
>>   - The swap pte layout must reserve those same 2 bits and ensure they
>>     are both always zero for a swap pte. It would be nice to reclaim at
>>     least one of those bits.
> 
> What problem does that create for swap pte layout ? Nonetheless reclaiming
> at least one of the SW bits (58 or 59) would be desirable regardless.

Well its not really a problem for swap ptes today. But freeing up an uneccessary
swap pte bit gives us options for the future; extending the swap entry offset to
allow larger swap devices, or more swap pte bits to track (e.g.) soft-dirty in
future.

I also fell foul of the swap pte bit layout comment previously not explicitly
calling out PMD_PRESET_INVALID as needing to be reserved and always zero in a
swap pte; an earlier version of this change moved the swap entry to overlap it,
and mm selftests were then corrupting it and causing a panic. So if nothing
else, we are now explicitly documenting every bit in the swap pte.

aside: bit 59 isn't technically a SW bit in a present PTE. It's only ignored if
neither PBHA nor FEAT_AIE are in operation. :)

> 
>>
>> Note that while PMD_PRESENT_INVALID technically only applies to pmds,
>> the swap pte layout is common to ptes and pmds so we are currently
>> effectively reserving that bit at both levels.
> 
> Agreed.
> 
>>
>> Let's replace PMD_PRESENT_INVALID with a more generic
>> PTE_PRESENT_INVALID bit, which occupies the same position (bit 59) but
>> applies uniformly to page/block descriptors at any level. This bit is
>> only interpreted when PTE_VALID is clear. If it is set, then the pte is
>> still considered present; pte_present() returns true and all the fields
>> in the pte follow the HW interpretation (e.g. SW can safely call
>> pte_pfn(), etc). But crucially, the HW treats the pte as invalid and
>> will fault if it hits.
> 
> Agreed, and hence all pmd helpers could be derived from corresponding pte
> helper utilizing PTE_PRESENT_INVALID.

Yes it generalizes a bunch of things for both pte and pmd, which is a nice side
effect IMHO.

> 
>>
>> With this in place, we can remove PTE_PROT_NONE entirely and instead
>> represent PROT_NONE as a present but invalid pte (PTE_VALID=0,
>> PTE_INVALID=1) with PTE_USER=0 and PTE_UXN=1. This is a unique
> 
> Did you mean PTE_PRESENT_INVALID instead ? PTE_INVALID flag is not present
> on arm64 platform, although your point is clear.

Yes, oops. the previous version of this change called it PTE_INVALID; Catalin
asked for it to be changed to PTE_PRESENT_INVALID. I obviously missed this when
updating the commit log. Will fix in the next version.

> 
>> combination that is not used anywhere else.
> But how did we arrive at the conclusion that the following combination for
> PROT_NONE replacement is optimum and would not create problem in any other
> core MM path ?

code review, thinking and discussion over previous versions of this change?

I'm not really sure what you are asking. Obviously it is less optimal from a
compute PoV than just unconditionally looking at a single bit. But it is more
optimal from a space PoV because it frees up a SW bit, which is the main aim here.

I don't see how it creates a problem for core-mm; PAGE_NONE was already setting
{PTE_VALID=0, PTE_USER=0, PTE_UXN=1} so there is no material change to the pte
and all helpers continue to return the same answers. Do you have a concrete concern?

> 
> PTE_PRESENT_INVALID = 1
> PTE_VALID = 0
> PTE_USER = 0
> PTE_UXN = 1
>  
>>
>> The net result is a clearer, simpler, more generic encoding scheme that
>> applies uniformly to all levels. Additionally we free up a PTE SW bit
>> and a swap pte bit (bit 58 in both cases).
>>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> ---
>>  arch/arm64/include/asm/pgtable-prot.h | 11 ++----
>>  arch/arm64/include/asm/pgtable.h      | 50 +++++++++++++++------------
>>  2 files changed, 30 insertions(+), 31 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index dd9ee67d1d87..cd8c06f5fb02 100644
>> --- a/arch/arm64/include/asm/pgtable-prot.h
>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>> @@ -18,14 +18,7 @@
>>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>> -
>> -/*
>> - * This bit indicates that the entry is present i.e. pmd_page()
>> - * still points to a valid huge page in memory even if the pmd
>> - * has been invalidated.
>> - */
> 
> This comment should be retained after making it bit generic so that
> it can be used for both pte and pmd.

OK I'll add it back in the next version. I thought the comment was stating the
obvious given the name of the macro. Perhaps this is slightly clearer?

/*
 * PTE_PRESENT_INVALID=1 & PTE_VALID=0 indicates that the pte's fields should be
 * interpreted according to the HW layout by SW but any attempted HW access to
 * the address will result in a fault. pte_present() returns true.
 */

> 
>> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>> +#define PTE_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
>>  
>>  #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>>  #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>> @@ -103,7 +96,7 @@ static inline bool __pure lpa2_is_enabled(void)
>>  		__val;							\
>>  	 })
>>  
>> -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PRESENT_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>>  /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
>>  #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
>>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index afdd56d26ad7..c0f4471423db 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  /*
>>   * The following only work if pte_present(). Undefined behaviour otherwise.
>>   */
>> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
>> +#define pte_present(pte)	(pte_valid(pte) || pte_present_invalid(pte))
>>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>> @@ -132,6 +132,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>>  
>>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
>> +#define pte_present_invalid(pte) \
>> +	((pte_val(pte) & (PTE_VALID | PTE_PRESENT_INVALID)) == PTE_PRESENT_INVALID)
>>  /*
>>   * Execute-only user mappings do not have the PTE_USER bit set. All valid
>>   * kernel mappings have the PTE_UXN bit set.
>> @@ -261,6 +263,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
>>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
>>  }
>>  
>> +static inline pte_t pte_mkinvalid(pte_t pte)
>> +{
>> +	pte = set_pte_bit(pte, __pgprot(PTE_PRESENT_INVALID));
>> +	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
>> +	return pte;
>> +}
>> +
>>  static inline pmd_t pmd_mkcont(pmd_t pmd)
>>  {
>>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>> @@ -469,7 +478,16 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>   */
>>  static inline int pte_protnone(pte_t pte)
>>  {
>> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
>> +	/*
>> +	 * pte_present_invalid() tells us that the pte is invalid from HW
>> +	 * perspective but present from SW perspective, so the fields are to be
>> +	 * interpretted as per the HW layout. The second 2 checks are the unique
>> +	 * encoding that we use for PROT_NONE. It is insufficient to only use
>> +	 * the first check because we share the same encoding scheme with pmds
>> +	 * which support pmd_mkinvalid(), so can be present-invalid without
>> +	 * being PROT_NONE.
>> +	 */
>> +	return pte_present_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
>>  }
>>  
>>  static inline int pmd_protnone(pmd_t pmd)
>> @@ -478,12 +496,7 @@ static inline int pmd_protnone(pmd_t pmd)
>>  }
>>  #endif
>>  
>> -#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
>> -
>> -static inline int pmd_present(pmd_t pmd)
>> -{
>> -	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
>> -}
>> +#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
>>  
>>  /*
>>   * THP definitions.
>> @@ -508,14 +521,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
>>  #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
>>  #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
>>  #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
>> -
>> -static inline pmd_t pmd_mkinvalid(pmd_t pmd)
>> -{
>> -	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
>> -	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
>> -
>> -	return pmd;
>> -}
>> +#define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
>>  
>>  #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
>>  
>> @@ -1027,8 +1033,8 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
>>  	 */
>>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
>> -			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
>> -			      PTE_ATTRINDX_MASK;
>> +			      PTE_PRESENT_INVALID | PTE_VALID | PTE_WRITE |
>> +			      PTE_GP | PTE_ATTRINDX_MASK;
>>  	/* preserve the hardware dirty information */
>>  	if (pte_hw_dirty(pte))
>>  		pte = set_pte_bit(pte, __pgprot(PTE_DIRTY));
>> @@ -1076,17 +1082,17 @@ static inline int pgd_devmap(pgd_t pgd)
>>  #ifdef CONFIG_PAGE_TABLE_CHECK
>>  static inline bool pte_user_accessible_page(pte_t pte)
>>  {
>> -	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
>> +	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
> 
> Previously pte_present() checked against both PTE_VALID and PTE_PROT_NONE
> but now it only compares against PTE_VALID instead. But how would it detect
> erstwhile PTE_PROT_NONE marked entries ?

PROT_NONE entries have PTE_USER=0 and PTE_UXN=1, so both pte_user() and
pte_user_exec() return false and therefore pte_user_accessible_page() returns false.

I haven't changed the function's behaviour, I've just tidied it up; checking the
PROT_NONE case in pte_present() is pointless, using pte_valid() is more
intuitive (how can a page be accessible if the pte is invalid?) and this aligns
it much more closely with pmd_user_accessible_page() and
pud_user_accessible_page(); the those do the same checks except for the
additional check they are not table entries.

Note that a pmd can also be PROT_NONE so if you think this function is wrong,
then pmd_user_accessible_page() is also wrong.

> 
>>  }
>>  
>>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>>  {
>> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>  }
>>  
>>  static inline bool pud_user_accessible_page(pud_t pud)
>>  {
>> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
>> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>>  }
> 
> These make sense.
> 
>>  #endif
>>  
>> @@ -1250,7 +1256,7 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>   *	bits 2:		remember PG_anon_exclusive
>>   *	bits 3-7:	swap type
>>   *	bits 8-57:	swap offset
>> - *	bit  58:	PTE_PROT_NONE (must be zero)
>> + *	bit  59:	PTE_PRESENT_INVALID (must be zero)
>>   */
>>  #define __SWP_TYPE_SHIFT	3
>>  #define __SWP_TYPE_BITS		5
> 
> Too many changes are happening simultaneously in a single patch, making
> some what difficult to review, and it would be helpful to refactor them
> possibly something like the following -
> 
> Derive pmd_present_invalid() from pte level with PTE_PRESENT_INVALID
> 
> - Renaming PMD_PRESENT_INVALID as PTE_PRESENT_INVALID
> - Add pte_mkinvalid()
> - Add pte_present_invalid()
> - Derive pmd_mkinvalid() from pte_mkinvalid()
> - Derive pmd_present_invalid() from pte_present() and pte_present_invalid()
> - But just don't change pte_present() yet
> 
> Drop PTE_PROT_NONE
> 
> - Replace PTE_PROT_NONE with PTE_PRESENT_INVALID in PAGE_NONE
> - Change pte_present() - derive from pte_valid() and pte_present_invalid()
> - Derive pmd_present() - derive from pte_present()
> - Change pte_protnone() - derive from pte_present_invalid(), pte_user() and pte_user_exec()
> - Changes to pte_user_accessible_page(), pmd_user_accessible_page(), pud_user_accessible_page()
> - Changes to pte_modify() - replace PTE_PROT_NONE with PTE_PRESENT_INVALID

Yes, I like this, will split it out for the next version. My rationale for
keeping it in one patch was that once PTE_PRESENT_INVALID was generalized, it
seemed odd if a PROT_NONE pte was not setting it, which would be the case for
the intermediate state between the 2 patches. But I thin think the benefits of
splitting it outweigh that concern.

Thanks for taking a look at this!




