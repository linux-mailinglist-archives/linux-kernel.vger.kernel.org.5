Return-Path: <linux-kernel+bounces-138323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302889EFCD
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:27:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AA1E2819E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:27:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ED7158D97;
	Wed, 10 Apr 2024 10:27:15 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9133F154BEE
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712744835; cv=none; b=T4HfcH6kg5nIP2W/YZjGDKW2ryvJOCWj0XVuYWymoqV55zQl5+BFPsPxUhbzJH76Gdwb52Dq7d6JuZ3Tb2HxKhivm7zpqUHleAFlBPOsnP1R7mCd69W0wXoNfptQe0CsXI4MD7PS/O7McbWiQ12m6JAiKdzqf1QkfcRBbyRW0AE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712744835; c=relaxed/simple;
	bh=z5ORWHBSOXf1D4RVnsiXgg9eJSsn6oMJux2sVQXompM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dgVfEblanH7lTCunLcAt23eGf/hZ/KBXtATeXTIypiC0OcEkmTsNngyjo5gsPYN9DcBUW01HkrXPfFK/qEi6LugHxprQatId9mdaYgaq8YlSQglFAN5mbxtTVuKXQOnjMbI1R77Lgkh3igcD/d1/m0q3zEE4fcARKOS+aMHqt5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AD9FF139F;
	Wed, 10 Apr 2024 03:27:42 -0700 (PDT)
Received: from [10.57.73.247] (unknown [10.57.73.247])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 694763F6C4;
	Wed, 10 Apr 2024 03:27:11 -0700 (PDT)
Message-ID: <c5cc958d-7945-43e5-b9af-c2d8e34d369f@arm.com>
Date: Wed, 10 Apr 2024 11:27:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] arm64: mm: Don't remap pgtables per-cont(pte|pmd)
 block
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-2-ryan.roberts@arm.com>
 <ZhZf8P_FedVSq6Wu@FVFF77S0Q05N>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZhZf8P_FedVSq6Wu@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/04/2024 10:46, Mark Rutland wrote:
> On Thu, Apr 04, 2024 at 03:33:05PM +0100, Ryan Roberts wrote:
>> A large part of the kernel boot time is creating the kernel linear map
>> page tables. When rodata=full, all memory is mapped by pte. And when
>> there is lots of physical ram, there are lots of pte tables to populate.
>> The primary cost associated with this is mapping and unmapping the pte
>> table memory in the fixmap; at unmap time, the TLB entry must be
>> invalidated and this is expensive.
>>
>> Previously, each pmd and pte table was fixmapped/fixunmapped for each
>> cont(pte|pmd) block of mappings (16 entries with 4K granule). This means
>> we ended up issuing 32 TLBIs per (pmd|pte) table during the population
>> phase.
>>
>> Let's fix that, and fixmap/fixunmap each page once per population, for a
>> saving of 31 TLBIs per (pmd|pte) table. This gives a significant boot
>> speedup.
>>
>> Execution time of map_mem(), which creates the kernel linear map page
>> tables, was measured on different machines with different RAM configs:
>>
>>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
>> ---------------|-------------|-------------|-------------|-------------
>>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
>> ---------------|-------------|-------------|-------------|-------------
>> before         |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
>> after          |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
>>
>> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
>> Tested-by: Eric Chanudet <echanude@redhat.com>
>> ---
>>  arch/arm64/mm/mmu.c | 32 ++++++++++++++++++--------------
>>  1 file changed, 18 insertions(+), 14 deletions(-)
>>
>> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> index 495b732d5af3..fd91b5bdb514 100644
>> --- a/arch/arm64/mm/mmu.c
>> +++ b/arch/arm64/mm/mmu.c
>> @@ -172,12 +172,9 @@ bool pgattr_change_is_safe(u64 old, u64 new)
>>  	return ((old ^ new) & ~mask) == 0;
>>  }
>>  
>> -static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>> -		     phys_addr_t phys, pgprot_t prot)
>> +static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>> +		       phys_addr_t phys, pgprot_t prot)
>>  {
>> -	pte_t *ptep;
>> -
>> -	ptep = pte_set_fixmap_offset(pmdp, addr);
>>  	do {
>>  		pte_t old_pte = __ptep_get(ptep);
>>  
>> @@ -193,7 +190,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>>  		phys += PAGE_SIZE;
>>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>>  
>> -	pte_clear_fixmap();
>> +	return ptep;
>>  }
>>  
>>  static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>> @@ -204,6 +201,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>  {
>>  	unsigned long next;
>>  	pmd_t pmd = READ_ONCE(*pmdp);
>> +	pte_t *ptep;
>>  
>>  	BUG_ON(pmd_sect(pmd));
>>  	if (pmd_none(pmd)) {
>> @@ -219,6 +217,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>  	}
>>  	BUG_ON(pmd_bad(pmd));
>>  
>> +	ptep = pte_set_fixmap_offset(pmdp, addr);
>>  	do {
>>  		pgprot_t __prot = prot;
>>  
>> @@ -229,20 +228,20 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>>  		    (flags & NO_CONT_MAPPINGS) == 0)
>>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>>  
>> -		init_pte(pmdp, addr, next, phys, __prot);
>> +		ptep = init_pte(ptep, addr, next, phys, __prot);
>>  
>>  		phys += next - addr;
>>  	} while (addr = next, addr != end);
> 
> I reckon it might be better to leave init_pte() returning void, and move the
> ptep along here, e.g.
> 
> 	ptep = pte_set_fixmap_offset(pmdp, addr);
> 	do {
> 		...
> 
> 		init_pte(ptep, addr, next, phys, __prot);
> 
> 		ptep += pte_index(next) - pte_index(addr);
> 		phys += next - addr;
> 	} while (addr = next, addr != end);
> 
> 
> ... as that keeps the relationship between 'ptep' and 'phys' clear since
> they're manipulated in the same way, adjacent to one another.
> 
> Regardless this looks good, so with that change or as-is:
> 
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> 
> ... though I would prefer with that change. ;)

Yep, will change. And I'll do the same for pmd_init() too.

> 
> Mark.


