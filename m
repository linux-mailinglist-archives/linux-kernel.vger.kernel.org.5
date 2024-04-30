Return-Path: <linux-kernel+bounces-164067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC778B7864
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:09:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 700E0B24574
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:09:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CB3172BD1;
	Tue, 30 Apr 2024 14:02:27 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE960175552
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 14:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485746; cv=none; b=RZEjDxkkI5+5xUAVRa1qiqzLxr/5vnUGfrM0YVMGwa4DZ1nZ2wIlYQRdq7rDVshuSzg6kLfMikmyTXviqVRAcXaqBxwGwUaHApQS0beavOClQQKAABIDDdvQHtQth+SkMvccojxOKZcy2R2v6tBV3gYZOTAjaNy1H05LkokRpo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485746; c=relaxed/simple;
	bh=Mt++4EgrW5QL/1p0a/K7dTkVzqMG5gPOaKUqb1NXBPY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JErKDbGqNWsa3ArIHyBUq4qVblasJfk1WzjSdtzALHHT77JxSd+7xTXO0Kg6PAHxvLhOVL8Sb5wHYwYmjQspxGwwpllRfFtY0OEq0ClP5oylKFZvB/8MDuLncX7i+U8Y9NM5ZSQpjn6/fVxWXXIDO+0J4DjnP2gxpDCO7Ahf8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59D322F4;
	Tue, 30 Apr 2024 07:02:50 -0700 (PDT)
Received: from [10.1.38.140] (XHFQ2J9959.cambridge.arm.com [10.1.38.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 566923F793;
	Tue, 30 Apr 2024 07:02:22 -0700 (PDT)
Message-ID: <96fc0d1a-0c5f-4ca3-ad99-a64346990536@arm.com>
Date: Tue, 30 Apr 2024 15:02:21 +0100
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
To: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly
 <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
 Mike Rapoport <rppt@linux.ibm.com>, Shivansh Vij <shivanshvij@outlook.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
 <20240430133037.GA13848@willie-the-truck>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20240430133037.GA13848@willie-the-truck>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 14:30, Will Deacon wrote:
> Hey Ryan,
> 
> Just a couple of comments on this:
> 
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
> So this now overlaps with AttrIndx[3] if FEAT_AIE is implemented. Although
> this shouldn't matter on the face of things because it's only used for
> invalid entries, we originally moved the PROT_NONE bit from 2 to 57 back
> in 3676f9ef5481 ("arm64: Move PTE_PROT_NONE higher up") because it was
> possible to change the memory type for PROT_NONE mappings via some
> drivers.

I'm not sure I follow your argument.

 1. We don't support FEAT_AIE (currently) so AttrIndx[3] is always going to be 0
for valid ptes. Drivers are only calling our helpers (e.g.
pgprot_writecombine(), right?) and those only know how to set AttrIndx[2:0].

 2. PMD_PRESENT_INVALID was already occupying bit 59. So wouldn't the same shape
of concern apply there too for PMDs that have been invalidated, where the driver
then comes along and changes the memory type? (Perhaps because
PMD_PRESENT_INVALID is only set while the PTL is held this can't happen).

 3. I had this same vague concern about confusion due to overlapping bit 59,
which is why in the next patch, I'm moving it to the NS bit.

Experience tells me that when I'm arguing confidently with someone who is much
more expert than me, then I'm using wrong... so what have I missed? :)

> 
> Moving the field to the NS bit (as you do later in the series) resolves
> this, but the architecture currently says that the NS bit is RES0. How
> can we guarantee that it won't be repurposed by hardware in future?

Well it remains free for use in valid entries of course. So I guess you are
asking how to guarantee we won't also need to be able to modify it on the fly
for PROT_NONE entries? I don't have a definite answer, but I've been working on
the assumption that the architecture introducing a feature that is only needed
in states where NS is not needed is unlikely (so using that bit for the feature
is also unlikely). And then needing to manipulate that feature dyanically for
PROT_NONE mappings is even less likely.

If all else fails we could move it to nG (bit 11) to free up bit 5. But that
requires a bit more fiddling with the swap pte format.

> 
>>  #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>>  #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
>> @@ -103,7 +96,7 @@ static inline bool __pure lpa2_is_enabled(void)
>>  		__val;							\
>>  	 })
>>  
>> -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>>  /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
>>  #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
>>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
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
> 
> Why do we need to check pte_user_*() here? Isn't PROT_NONE the only case
> in which a pte will have PTE_INVALID set?

I guess for *ptes* this is technically correct. But I was trying to make the
format generic and reusable for *pmds* too. (pmd_protnone() wraps
pte_protnone()). For pmds, PTE_INVALID also represents invalid-but-present PMDs
(i.e. pmds on which pmd_mkinvalid() has been called).

The intention is that PTE_INVALID indicates "present but not valid in HW". And
(!pte_user(pte) && !pte_user_exec(pte)) indicates the PROT_NONE permission.

> 
> Will


