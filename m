Return-Path: <linux-kernel+bounces-163850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B25B8B749A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:36:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5075EB20A2F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0BA912DD87;
	Tue, 30 Apr 2024 11:35:57 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A37C12D1E9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714476957; cv=none; b=S5iyMMYL8aDCjVPjYa4k3W/D5PxNFt0qgaW0V7vvEhxCcGhWZphOkHxZ6A0Bd3QgUUo20Jpuu60doL0fKFPqrSGAn17chkFgrj1jjBiwH7eJAvOKUXlzFPIpatXISFATuDra4optaom/QwCAUNSGHywmhBlxGAu+xY9qSzD1H0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714476957; c=relaxed/simple;
	bh=uV7kZqk1j5xdNTX2C+l3S9HY3wVA6ZH7oZxO5/Adk/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx1iELhDetYxbQGvsn/1wk1CrWpOU9tC/1SJOKKAaX2gP8DHfMck4f7+yT3xi1EB9FpEkeFtTGMz303JVXTX75iZ9pPw3aZImqXt0CxL3xCKXXgHYniktsBdajasWFjLpxyurFQgASXKtBRDNbuHZsPZySYykx26qtAdAy62BAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB783339;
	Tue, 30 Apr 2024 04:36:18 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7D9D3F86F;
	Tue, 30 Apr 2024 04:35:50 -0700 (PDT)
Message-ID: <8cf74e5f-e6a5-465e-83b4-205233c78005@arm.com>
Date: Tue, 30 Apr 2024 12:35:49 +0100
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
 <839d6975-ce12-4fc9-aa3b-8ec5787bf577@arm.com> <ZjDR0EIjLr9F2dWn@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZjDR0EIjLr9F2dWn@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 12:11, Catalin Marinas wrote:
> On Mon, Apr 29, 2024 at 06:15:45PM +0100, Ryan Roberts wrote:
>> On 29/04/2024 17:20, Catalin Marinas wrote:
>>> On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
>>>> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
>>>> index dd9ee67d1d87..de62e6881154 100644
>>>> --- a/arch/arm64/include/asm/pgtable-prot.h
>>>> +++ b/arch/arm64/include/asm/pgtable-prot.h
>>>> @@ -18,14 +18,7 @@
>>>>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>>>>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>>>>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
>>>> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
>>>> -
>>>> -/*
>>>> - * This bit indicates that the entry is present i.e. pmd_page()
>>>> - * still points to a valid huge page in memory even if the pmd
>>>> - * has been invalidated.
>>>> - */
>>>> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
>>>> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */
>>>
>>> Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
>>> it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
>>> looks like a negation only.
>>
>> Meh, for me the pte can only be valid or invalid if it is present. So it's
>> implicit. And if you have PTE_PRESENT_INVALID you should also have
>> PTE_PRESENT_VALID.
>>
>> We also have pte_mkinvalid(), which is core-mm-defined. In your scheme, surely
>> it should be pte_mkpresent_invalid()?
>>
>> But you're the boss, I'll change this to PTE_PRESENT_INVALID. :-(
> 
> TBH, I don't have a strong opinion but best to avoid the bikeshedding.
> I'll leave the decision to you ;). It would match the pmd_mkinvalid()
> core code. But if you drop 'present' make sure you add a comment above
> that it's meant for present ptes.

OK, thanks - I'll add a comment and leave it as pte_invalid().

> 
>>>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>>>> index afdd56d26ad7..8dd4637d6b56 100644
>>>> --- a/arch/arm64/include/asm/pgtable.h
>>>> +++ b/arch/arm64/include/asm/pgtable.h
>>>> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>>>  /*
>>>>   * The following only work if pte_present(). Undefined behaviour otherwise.
>>>>   */
>>>> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
>>>> +#define pte_present(pte)	(pte_valid(pte) || pte_invalid(pte))
>>>>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>>>>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>>>>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>>>> @@ -132,6 +132,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>>>  #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>>>>  
>>>>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
>>>> +#define pte_invalid(pte)	((pte_val(pte) & (PTE_VALID | PTE_INVALID)) == PTE_INVALID)
> [...]
>>> I think it's sufficient to check PTE_PRESENT_INVALID only. We'd never
>>> have both bits set, so no need for mask and compare.
>>
>> My rationale is that the INVALID bit may have some other HW meaning when
>> PTE_VALID is set, so its not correct to interpret it as INVALID unless VALID is
>> clear. Granted bit 59 is AttrIndex[3] or PBHA[0], neither of which we are using
>> currently so it will always be 0 when PTE_VALID=1 (and same argument when its
>> moved to NS in next patch). But it feels fragile to me. I'd rather leave it as
>> is unless you insist.
> 
> You are right. It currently works but it may overlap with some hardware
> bit on valid ptes.

OK, I'll leave it as is.

> 
>>>>  /*
>>>>   * Execute-only user mappings do not have the PTE_USER bit set. All valid
>>>>   * kernel mappings have the PTE_UXN bit set.
>>>> @@ -261,6 +262,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
>>>>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
>>>>  }
>>>>  
>>>> +static inline pte_t pte_mkinvalid(pte_t pte)
>>>> +{
>>>> +	pte = set_pte_bit(pte, __pgprot(PTE_INVALID));
>>>> +	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
>>>> +	return pte;
>>>> +}
>>>
>>> I wonder whether we need to define this. I guess it makes sense than
>>> having the pmd_mkinvalid() use the PTE_* definitions directly, though it
>>> won't be something we need to do on a pte.
>>
>> For me its much cleaner to do it as is because it makes it clear that the format
>> is the same across pte, pmd and pud. And we need pte_invalid() (or
>> pte_present_invalid()) for PROT_NONE so isn't it better to match it with a setter?
> 
> I agree. It was just a remark above.

ACK.

> 
>>>>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>>>>  {
>>>> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>>> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>>>>  }
>>>
>>> Maybe our pmd_leaf() should actually check valid && !table instead of
>>> present and no need to change these.
>>
>> I'm not sure that would be a great approach; pmd_leaf() is core-mm-defined. And
>> I can't imagine core-mm would want pmd_leaf() to start returning false after
>> calling pmd_mkinvalid(). You probably won't find anywhere where it actually
>> matters right now, but it would be subtly broken and could be exposed in future.
> 
> True, I think it's fine currently but you never know. So after
> pmd_mkinvalid() on a leaf pmd, pmd_leaf() should still return true. It
> might be worth adding a test to pmd_thp_tests() in debug_vm_pgtable.c.

Good idea; I'll add tests for this.

> 
>>>>  static inline bool pud_user_accessible_page(pud_t pud)
>>>>  {
>>>> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
>>>> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>>>>  }
>>>>  #endif
>>>
>>> Same here.
>>>
>>> Otherwise I'm happy with the patch. Feel free to add:
>>>
>>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
> 
> My reviewed-by tag still stands even if you leave the patch as is.

Thanks.

There is still one problem I need to resolve; During this work I discovered that
core-mm can call pmd_mkinvalid() for swap pmds. On arm64 this will turn the swap
pmd into a present pmd, and BadThings can happen in GUP-fast (and any other
lockless SW table walkers). My original fix modified core-mm to only call
pmd_mkinvalid() for present pmds. But discussion over there has shown that arm64
is the only arch that cannot handle this. So I've been convinced that it's
probably more robust to make arm64 handle it gracefully and add tests to
debug_vm_pgtable.c to check for this. Patch incoming shortly, but it will cause
a conflict with this series. So I'll send a v2 of this once that fix is accepted.

> 
> Thanks.
> 


