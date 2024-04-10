Return-Path: <linux-kernel+bounces-138274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D450789EF14
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 11:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893261F220FE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 09:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B080155A33;
	Wed, 10 Apr 2024 09:46:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715FA13D288
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742395; cv=none; b=O29pma36qEoQoxlDc/esjkJM1hn3CcxJaNC82TJ6mvWEP0+u6wEbCDSB92v/5NyUNYBvwXYwzDxiraxspLrsg5/Nc/hqZUVa45JDwXlG6XnUXuWMw/y26xZk7p4ZKVSCZkHpM8Ly0HmE61lNb6WOoPtqRyk472GXr2VyGtUxwy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742395; c=relaxed/simple;
	bh=UNoP2XVBI7wf8bVP3cYd6NyBVQ0hNUiOERKtJo55hUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiElFaM7zwGx7gBUi20V0g0qjmW8IO3Mon8MG0KxvfXQ/ExLlBUJQQcRYtiuZBY1SkYC6XzYkWvv5GSUu2iUr4kFKtrHdwwsVEC5yMvzyd/z6psq5Ae/HrvAaU72r9XanHI1Bmsushiz4joWI7pjLnoLI/NZKH0hzA/9B+5QHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB0B8139F;
	Wed, 10 Apr 2024 02:47:01 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.17.100])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F38383F6C4;
	Wed, 10 Apr 2024 02:46:29 -0700 (PDT)
Date: Wed, 10 Apr 2024 10:46:24 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v2 1/4] arm64: mm: Don't remap pgtables per-cont(pte|pmd)
 block
Message-ID: <ZhZf8P_FedVSq6Wu@FVFF77S0Q05N>
References: <20240404143308.2224141-1-ryan.roberts@arm.com>
 <20240404143308.2224141-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240404143308.2224141-2-ryan.roberts@arm.com>

On Thu, Apr 04, 2024 at 03:33:05PM +0100, Ryan Roberts wrote:
> A large part of the kernel boot time is creating the kernel linear map
> page tables. When rodata=full, all memory is mapped by pte. And when
> there is lots of physical ram, there are lots of pte tables to populate.
> The primary cost associated with this is mapping and unmapping the pte
> table memory in the fixmap; at unmap time, the TLB entry must be
> invalidated and this is expensive.
> 
> Previously, each pmd and pte table was fixmapped/fixunmapped for each
> cont(pte|pmd) block of mappings (16 entries with 4K granule). This means
> we ended up issuing 32 TLBIs per (pmd|pte) table during the population
> phase.
> 
> Let's fix that, and fixmap/fixunmap each page once per population, for a
> saving of 31 TLBIs per (pmd|pte) table. This gives a significant boot
> speedup.
> 
> Execution time of map_mem(), which creates the kernel linear map page
> tables, was measured on different machines with different RAM configs:
> 
>                | Apple M2 VM | Ampere Altra| Ampere Altra| Ampere Altra
>                | VM, 16G     | VM, 64G     | VM, 256G    | Metal, 512G
> ---------------|-------------|-------------|-------------|-------------
>                |   ms    (%) |   ms    (%) |   ms    (%) |    ms    (%)
> ---------------|-------------|-------------|-------------|-------------
> before         |  153   (0%) | 2227   (0%) | 8798   (0%) | 17442   (0%)
> after          |   77 (-49%) |  431 (-81%) | 1727 (-80%) |  3796 (-78%)
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Tested-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/mm/mmu.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 495b732d5af3..fd91b5bdb514 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -172,12 +172,9 @@ bool pgattr_change_is_safe(u64 old, u64 new)
>  	return ((old ^ new) & ~mask) == 0;
>  }
>  
> -static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
> -		     phys_addr_t phys, pgprot_t prot)
> +static pte_t *init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
> +		       phys_addr_t phys, pgprot_t prot)
>  {
> -	pte_t *ptep;
> -
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
>  	do {
>  		pte_t old_pte = __ptep_get(ptep);
>  
> @@ -193,7 +190,7 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		phys += PAGE_SIZE;
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
>  
> -	pte_clear_fixmap();
> +	return ptep;
>  }
>  
>  static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> @@ -204,6 +201,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  {
>  	unsigned long next;
>  	pmd_t pmd = READ_ONCE(*pmdp);
> +	pte_t *ptep;
>  
>  	BUG_ON(pmd_sect(pmd));
>  	if (pmd_none(pmd)) {
> @@ -219,6 +217,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	}
>  	BUG_ON(pmd_bad(pmd));
>  
> +	ptep = pte_set_fixmap_offset(pmdp, addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -229,20 +228,20 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  		    (flags & NO_CONT_MAPPINGS) == 0)
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> -		init_pte(pmdp, addr, next, phys, __prot);
> +		ptep = init_pte(ptep, addr, next, phys, __prot);
>  
>  		phys += next - addr;
>  	} while (addr = next, addr != end);

I reckon it might be better to leave init_pte() returning void, and move the
ptep along here, e.g.

	ptep = pte_set_fixmap_offset(pmdp, addr);
	do {
		...

		init_pte(ptep, addr, next, phys, __prot);

		ptep += pte_index(next) - pte_index(addr);
		phys += next - addr;
	} while (addr = next, addr != end);


.. as that keeps the relationship between 'ptep' and 'phys' clear since
they're manipulated in the same way, adjacent to one another.

Regardless this looks good, so with that change or as-is:

Acked-by: Mark Rutland <mark.rutland@arm.com>

.. though I would prefer with that change. ;)

Mark.

