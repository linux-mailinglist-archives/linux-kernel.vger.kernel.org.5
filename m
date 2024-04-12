Return-Path: <linux-kernel+bounces-142181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A428A2887
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2E01C22C03
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49D6E50279;
	Fri, 12 Apr 2024 07:53:25 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B23614F613
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 07:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908404; cv=none; b=Dz1oNYHrKR9B1vZEkjBCMmBuTpQ47+bkCJdfIkJ04i8y9xKmIDnjiatIBbBLLw1rP7U7eMHN1uZbMMYnLE65H4mmZDyX+wOId3fL5W7P2hcJQNSZGiDCDbpOuLjN1BT/k57bHu2iY/2J+xbU1/vCi/pzrSgxVYyuZRYMjAu4dUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908404; c=relaxed/simple;
	bh=cN8LZzqiF0iXw1IRK2mxtwca3ikor0Lzvme1Z/+UwxI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ryLVpoWoFSGpFeyC1c1qEDnP6ke8aYAl3/my2hBW4e7A/QWVMUd3BVA7UfBp6pDejLcbiM6ZV5qfx2FfmzNgC2FU9QpXGevydUhGxSodrKIqfDSO2DzjkE6ei985d0Oyl8oHKBQZrnsjw0pMg9Qg1l9CjjJb2hd1lU5+VupQ0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1962339;
	Fri, 12 Apr 2024 00:53:50 -0700 (PDT)
Received: from [10.57.73.208] (unknown [10.57.73.208])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5199F3F6C4;
	Fri, 12 Apr 2024 00:53:20 -0700 (PDT)
Message-ID: <37336367-f876-4429-a8a6-f887fc7f69ee@arm.com>
Date: Fri, 12 Apr 2024 08:53:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] arm64: mm: Don't remap pgtables for allocate vs
 populate
Content-Language: en-GB
To: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, David Hildenbrand <david@redhat.com>,
 Donald Dutile <ddutile@redhat.com>, Eric Chanudet <echanude@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Itaru Kitayama <itaru.kitayama@fujitsu.com>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-4-ryan.roberts@arm.com>
 <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZhffSyrqCQsMV2pG@FVFF77S0Q05N>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mark,

[...]

> Does something like the below look ok to you? The trade-off performance-wise is
> that late uses will still use the fixmap, and will redundantly zero the tables,
> but the logic remains fairly simple, and I suspect the overhead for late
> allocations might not matter since the bulk of late changes are non-allocating.
> 
> Mark
> 
> ---->8-----
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 105a95a8845c5..1eecf87021bd0 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1010,6 +1010,8 @@ static inline p4d_t *p4d_offset_kimg(pgd_t *pgdp, u64 addr)
>  
>  static inline bool pgtable_l5_enabled(void) { return false; }
>  
> +#define p4d_index(addr)              (((addr) >> P4D_SHIFT) & (PTRS_PER_P4D - 1)
> +
>  /* Match p4d_offset folding in <asm/generic/pgtable-nop4d.h> */
>  #define p4d_set_fixmap(addr)		NULL
>  #define p4d_set_fixmap_offset(p4dp, addr)	((p4d_t *)p4dp)
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index dc86dceb0efe6..4b944ef8f618c 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -109,28 +109,12 @@ EXPORT_SYMBOL(phys_mem_access_prot);
>  static phys_addr_t __init early_pgtable_alloc(int shift)
>  {
>  	phys_addr_t phys;
> -	void *ptr;
>  
>  	phys = memblock_phys_alloc_range(PAGE_SIZE, PAGE_SIZE, 0,
>  					 MEMBLOCK_ALLOC_NOLEAKTRACE);
>  	if (!phys)
>  		panic("Failed to allocate page table page\n");
>  
> -	/*
> -	 * The FIX_{PGD,PUD,PMD} slots may be in active use, but the FIX_PTE
> -	 * slot will be free, so we can (ab)use the FIX_PTE slot to initialise
> -	 * any level of table.
> -	 */
> -	ptr = pte_set_fixmap(phys);
> -
> -	memset(ptr, 0, PAGE_SIZE);
> -
> -	/*
> -	 * Implicit barriers also ensure the zeroed page is visible to the page
> -	 * table walker
> -	 */
> -	pte_clear_fixmap();
> -
>  	return phys;
>  }
>  
> @@ -172,6 +156,14 @@ bool pgattr_change_is_safe(u64 old, u64 new)
>  	return ((old ^ new) & ~mask) == 0;
>  }
>  
> +static void init_clear_pgtable(void *table)
> +{
> +	clear_page(table);
> +
> +	/* Ensure the zeroing is observed by page table walks. */
> +	dsb(ishst);
> +}
> +
>  static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		       phys_addr_t phys, pgprot_t prot)
>  {
> @@ -216,12 +208,18 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  			pmdval |= PMD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pte_phys = pgtable_alloc(PAGE_SHIFT);
> +
> +		ptep = pte_set_fixmap(pte_phys);
> +		init_clear_pgtable(ptep);
> +
>  		__pmd_populate(pmdp, pte_phys, pmdval);
>  		pmd = READ_ONCE(*pmdp);
> +	} else {
> +		ptep = pte_set_fixmap(pmd_page_paddr(pmd));
>  	}
>  	BUG_ON(pmd_bad(pmd));
>  
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
> +	ptep += pte_index(addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -303,12 +301,18 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  			pudval |= PUD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pmd_phys = pgtable_alloc(PMD_SHIFT);
> +
> +		pmdp = pmd_set_fixmap(pmd_phys);
> +		init_clear_pgtable(pmdp);
> +
>  		__pud_populate(pudp, pmd_phys, pudval);
>  		pud = READ_ONCE(*pudp);
> +	} else {
> +		pmdp = pmd_set_fixmap(pud_page_paddr(pud));
>  	}
>  	BUG_ON(pud_bad(pud));
>  
> -	pmdp = pmd_set_fixmap_offset(pudp, addr);
> +	pmdp += pmd_index(addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -345,12 +349,18 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,
>  			p4dval |= P4D_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		pud_phys = pgtable_alloc(PUD_SHIFT);
> +
> +		pudp = pud_set_fixmap(pud_phys);
> +		init_clear_pgtable(pudp);
> +
>  		__p4d_populate(p4dp, pud_phys, p4dval);
>  		p4d = READ_ONCE(*p4dp);
> +	} else {
> +		pudp = pud_set_fixmap(p4d_page_paddr(p4d));

With this change I end up in pgtable folding hell. pXX_set_fixmap() is defined
as NULL when the level is folded (and pXX_page_paddr() is not defined at all).
So it all compiles, but doesn't boot.

I think the simplest approach is to follow this pattern:

----8<----
@@ -340,12 +338,15 @@ static void alloc_init_pud(p4d_t *p4dp, unsigned long
addr, unsigned long end,
                        p4dval |= P4D_TABLE_PXN;
                BUG_ON(!pgtable_alloc);
                pud_phys = pgtable_alloc(PUD_SHIFT);
+               pudp = pud_set_fixmap(pud_phys);
+               init_clear_pgtable(pudp);
+               pudp += pud_index(addr);
                __p4d_populate(p4dp, pud_phys, p4dval);
-               p4d = READ_ONCE(*p4dp);
+       } else {
+               BUG_ON(p4d_bad(p4d));
+               pudp = pud_set_fixmap_offset(p4dp, addr);
        }
-       BUG_ON(p4d_bad(p4d));

-       pudp = pud_set_fixmap_offset(p4dp, addr);
        do {
                pud_t old_pud = READ_ONCE(*pudp);
----8<----

For the map case, we continue to use pud_set_fixmap_offset() which is always
defined (and always works correctly).

Note also that the previously unconditional BUG_ON needs to be prior to the
fixmap call to be useful, and its really only valuable in the map case because
for the alloc case we are the ones setting the p4d so we already know its not
bad. This means we don't need the READ_ONCE() in the alloc case.

Shout if you disagree.

Thanks,
Ryan

>  	}
>  	BUG_ON(p4d_bad(p4d));
>  
> -	pudp = pud_set_fixmap_offset(p4dp, addr);
> +	pudp += pud_index(addr);
>  	do {
>  		pud_t old_pud = READ_ONCE(*pudp);
>  
> @@ -400,12 +410,18 @@ static void alloc_init_p4d(pgd_t *pgdp, unsigned long addr, unsigned long end,
>  			pgdval |= PGD_TABLE_PXN;
>  		BUG_ON(!pgtable_alloc);
>  		p4d_phys = pgtable_alloc(P4D_SHIFT);
> +
> +		p4dp = p4d_set_fixmap(p4d_phys);
> +		init_clear_pgtable(p4dp);
> +
>  		__pgd_populate(pgdp, p4d_phys, pgdval);
>  		pgd = READ_ONCE(*pgdp);
> +	} else {
> +		p4dp = p4d_set_fixmap(pgd_page_paddr(pgd));
>  	}
>  	BUG_ON(pgd_bad(pgd));
>  
> -	p4dp = p4d_set_fixmap_offset(pgdp, addr);
> +	p4dp += p4d_index(addr);
>  	do {
>  		p4d_t old_p4d = READ_ONCE(*p4dp);
>  
> @@ -475,8 +491,6 @@ static phys_addr_t __pgd_pgtable_alloc(int shift)
>  	void *ptr = (void *)__get_free_page(GFP_PGTABLE_KERNEL);
>  	BUG_ON(!ptr);
>  
> -	/* Ensure the zeroed page is visible to the page table walker */
> -	dsb(ishst);
>  	return __pa(ptr);
>  }
>  


