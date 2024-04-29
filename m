Return-Path: <linux-kernel+bounces-162736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A9E8B5FDE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E219283138
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 17:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC6E8662B;
	Mon, 29 Apr 2024 17:15:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B870785C41
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 17:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714410953; cv=none; b=D3QMOvGVioZL4RKbKBfrOwUuFL/ZM8ZRNggyaOugdN52tuWVlMSRHT7mJWoLnfi74z/n9Tw35urZ5VEYqD+DUi7VlEUFiItRtNbY8MPSFR5dlhTDQgJQR7okOIvI+zO/nxDkvh8iwBrljfXb1WdlG77wg7Uq0XPSp/OC6Ld8L2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714410953; c=relaxed/simple;
	bh=E6AHtsgliK4hNSQuBddOZuWzNSAdOPlHLQZ/cw12K8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F3GiLdVKsX2lUmaPT32TtCOWLb6m1p3+6TMTL1+vnGzHrORAgTAbHX9ePZjXK2UDqGRYcWdSkeO575/prjW8kQoSt4U4ic1OY730kw6aAef7x9fCHh6TtweQ8UCob+plnBnj4g6S/1IZQOe4yOUt/fzLYfn7ldWEFUW9G2JfdKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C11E2F4;
	Mon, 29 Apr 2024 10:16:16 -0700 (PDT)
Received: from [10.57.65.53] (unknown [10.57.65.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD1283F762;
	Mon, 29 Apr 2024 10:15:46 -0700 (PDT)
Message-ID: <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com>
Date: Mon, 29 Apr 2024 18:15:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com> <Zi_IzrfIcqWxt7cE@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zi_IzrfIcqWxt7cE@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 17:20, Catalin Marinas wrote:
> On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>> index dd9ee67d1d87..de62e6881154 100644
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
>> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
> 
> Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
> it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
> looks like a negation only.

Meh, for me the pte can only be valid or invalid if it is present. So it's
implicit. And if you have PTE_PRESENT_INVALID you should also have
PTE_PRESENT_VALID.

We also have pte_mkinvalid(), which is core-mm-defined. In your scheme, surely
it should be pte_mkpresent_invalid()?

But you're the boss, I'll change this to PTE_PRESENT_INVALID. :-(

> 
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index afdd56d26ad7..8dd4637d6b56 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  /*
>>   * The following only work if pte_present(). Undefined behaviour otherwise.
>>   */
>> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
>> +#define pte_present(pte)	(pte_valid(pte) || pte_invalid(pte))
>>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>> @@ -132,6 +132,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>>  
>>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
>> +#define pte_invalid(pte)	((pte_val(pte) & (PTE_VALID | PTE_INVALID)) == PTE_INVALID)
> 
> Same argument as above, pte_invalid() looks confusing to me, better (to
> me) as pte_present_invalid().

OK. Consider it done.

> 
> I think it's sufficient to check PTE_PRESENT_INVALID only. We'd never
> have both bits set, so no need for mask and compare.

My rationale is that the INVALID bit may have some other HW meaning when
PTE_VALID is set, so its not correct to interpret it as INVALID unless VALID is
clear. Granted bit 59 is AttrIndex[3] or PBHA[0], neither of which we are using
currently so it will always be 0 when PTE_VALID=1 (and same argument when its
moved to NS in next patch). But it feels fragile to me. I'd rather leave it as
is unless you insist.

> 
>>  /*
>>   * Execute-only user mappings do not have the PTE_USER bit set. All valid
>>   * kernel mappings have the PTE_UXN bit set.
>> @@ -261,6 +262,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
>>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
>>  }
>>  
>> +static inline pte_t pte_mkinvalid(pte_t pte)
>> +{
>> +	pte = set_pte_bit(pte, __pgprot(PTE_INVALID));
>> +	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
>> +	return pte;
>> +}
> 
> I wonder whether we need to define this. I guess it makes sense than
> having the pmd_mkinvalid() use the PTE_* definitions directly, though it
> won't be something we need to do on a pte.

For me its much cleaner to do it as is because it makes it clear that the format
is the same across pte, pmd and pud. And we need pte_invalid() (or
pte_present_invalid()) for PROT_NONE so isn't it better to match it with a setter?

> 
>> +
>>  static inline pmd_t pmd_mkcont(pmd_t pmd)
>>  {
>>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
>> @@ -469,7 +477,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>>   */
>>  static inline int pte_protnone(pte_t pte)
>>  {
>> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
>> +	return pte_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
>>  }
>>  
>>  static inline int pmd_protnone(pmd_t pmd)
>> @@ -478,12 +486,7 @@ static inline int pmd_protnone(pmd_t pmd)
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
>> @@ -508,14 +511,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
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
>> @@ -1027,7 +1023,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>>  	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
>>  	 */
>>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
>> -			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
>> +			      PTE_INVALID | PTE_VALID | PTE_WRITE | PTE_GP |
>>  			      PTE_ATTRINDX_MASK;
>>  	/* preserve the hardware dirty information */
>>  	if (pte_hw_dirty(pte))
>> @@ -1076,17 +1072,17 @@ static inline int pgd_devmap(pgd_t pgd)
>>  #ifdef CONFIG_PAGE_TABLE_CHECK
>>  static inline bool pte_user_accessible_page(pte_t pte)
>>  {
>> -	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
>> +	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
>>  }
> 
> This looks fine, it doesn't change the semantics since PROT_NONE never
> had pte_user() or pte_user_exec().
> 
>>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>>  {
>> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>  }
> 
> Maybe our pmd_leaf() should actually check valid && !table instead of
> present and no need to change these.

I'm not sure that would be a great approach; pmd_leaf() is core-mm-defined. And
I can't imagine core-mm would want pmd_leaf() to start returning false after
calling pmd_mkinvalid(). You probably won't find anywhere where it actually
matters right now, but it would be subtly broken and could be exposed in future.

> 
>>  static inline bool pud_user_accessible_page(pud_t pud)
>>  {
>> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
>> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>>  }
>>  #endif
> 
> Same here.
> 
> Otherwise I'm happy with the patch. Feel free to add:
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> As for getting it into 6.10, I'd say it's pretty late. Are there other
> dependencies on core kernel fixes?

Yes one fix that this depends on - Andrew has just taken the fix into
mm-hotfixes-unstable. So I think that will get into v6.9 all being well? I'm
only pushing because I'd prefer to have it off my desk before the baby comes
(14th May). Realistically it can wait.


