Return-Path: <linux-kernel+bounces-144417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE268A462B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 01:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9231C20C3A
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 23:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC94613774A;
	Sun, 14 Apr 2024 23:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oEUkGyoP"
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A553FDB
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 23:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713137096; cv=none; b=e6vWpd9Ha1ez578QA331JJiru+VGmqGD007bT5WdWWWhQFs7FMCBrAegDR9WbJojTVCTg3DEJML9PZpLGMbZx/nRGkdZH735OBKZrQGzNYj/GUzreiUKiZ3CUuFNin24FzXyluXVs6dv+qDWtp4dPbKS1lRaoz0zInUnUBFvkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713137096; c=relaxed/simple;
	bh=PSXs+U8Yx7/k5qsxbHlntymAZYCjAFTGI7D7DAN9gxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ9KX5l6OmvvaBFZAg/GanxyusBFudPslkBWxi+L98cFpfMkhTvvcRmu9LpUJwQ4+DhGSHVj6enb8a547jjZJUCAfTdaTxyvPdf64DZgy4O2o7sKYNVhF2EcWC362avXlkK1t27rwzMWMT5sagtim8DqpCadZ+v/R/gWd0GJuLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oEUkGyoP; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 11 Apr 2024 23:03:47 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713137091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kPKj/T41SmjIhbsDiYtc1158xq+evUdUQS9S8ehmiTE=;
	b=oEUkGyoPo7WPHZVoow2FKmC2OkbJ459rmVATb2AvW0obDmr96lbEFRzG6Z3zAZG7ifdOks
	lhSXdkk16ohdWiDFHAP5P2RIv1vwwygkcippWLznji4bpnk4PXC7qYGsJnfh55S1/6kjfE
	2e2iCNQv4kYS8foJeJmEMWBE+HOdVr8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Donald Dutile <ddutile@redhat.com>,
	Eric Chanudet <echanude@redhat.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Itaru Kitayama <itaru.kitayama@fujitsu.com>
Subject: Re: [PATCH v3 1/3] arm64: mm: Don't remap pgtables per-cont(pte|pmd)
 block
Message-ID: <Zhftw8qYzPUKV7x6@vm3>
References: <20240412131908.433043-1-ryan.roberts@arm.com>
 <20240412131908.433043-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412131908.433043-2-ryan.roberts@arm.com>
X-Migadu-Flow: FLOW_OUT

Hi Ryan,

On Fri, Apr 12, 2024 at 02:19:06PM +0100, Ryan Roberts wrote:
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
> before         |  168   (0%) | 2198   (0%) | 8644   (0%) | 17447   (0%)
> after          |   78 (-53%) |  435 (-80%) | 1723 (-80%) |  3779 (-78%)
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>
> Tested-by: Eric Chanudet <echanude@redhat.com>
> ---
>  arch/arm64/mm/mmu.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 495b732d5af3..9f1d69b7b494 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -172,12 +172,9 @@ bool pgattr_change_is_safe(u64 old, u64 new)
>  	return ((old ^ new) & ~mask) == 0;
>  }
>  
> -static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
> +static void init_pte(pte_t *ptep, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot)
>  {
> -	pte_t *ptep;
> -
> -	ptep = pte_set_fixmap_offset(pmdp, addr);
>  	do {
>  		pte_t old_pte = __ptep_get(ptep);
>  
> @@ -192,8 +189,6 @@ static void init_pte(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  
>  		phys += PAGE_SIZE;
>  	} while (ptep++, addr += PAGE_SIZE, addr != end);
> -
> -	pte_clear_fixmap();
>  }
>  
>  static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
> @@ -204,6 +199,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  {
>  	unsigned long next;
>  	pmd_t pmd = READ_ONCE(*pmdp);
> +	pte_t *ptep;
>  
>  	BUG_ON(pmd_sect(pmd));
>  	if (pmd_none(pmd)) {
> @@ -219,6 +215,7 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  	}
>  	BUG_ON(pmd_bad(pmd));
>  
> +	ptep = pte_set_fixmap_offset(pmdp, addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -229,20 +226,21 @@ static void alloc_init_cont_pte(pmd_t *pmdp, unsigned long addr,
>  		    (flags & NO_CONT_MAPPINGS) == 0)
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> -		init_pte(pmdp, addr, next, phys, __prot);
> +		init_pte(ptep, addr, next, phys, __prot);
>  
> +		ptep += pte_index(next) - pte_index(addr);
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
> +
> +	pte_clear_fixmap();
>  }
>  
> -static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
> +static void init_pmd(pmd_t *pmdp, unsigned long addr, unsigned long end,
>  		     phys_addr_t phys, pgprot_t prot,
>  		     phys_addr_t (*pgtable_alloc)(int), int flags)
>  {
>  	unsigned long next;
> -	pmd_t *pmdp;
>  
> -	pmdp = pmd_set_fixmap_offset(pudp, addr);
>  	do {
>  		pmd_t old_pmd = READ_ONCE(*pmdp);
>  
> @@ -268,8 +266,6 @@ static void init_pmd(pud_t *pudp, unsigned long addr, unsigned long end,
>  		}
>  		phys += next - addr;
>  	} while (pmdp++, addr = next, addr != end);
> -
> -	pmd_clear_fixmap();
>  }
>  
>  static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
> @@ -279,6 +275,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  {
>  	unsigned long next;
>  	pud_t pud = READ_ONCE(*pudp);
> +	pmd_t *pmdp;
>  
>  	/*
>  	 * Check for initial section mappings in the pgd/pud.
> @@ -297,6 +294,7 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  	}
>  	BUG_ON(pud_bad(pud));
>  
> +	pmdp = pmd_set_fixmap_offset(pudp, addr);
>  	do {
>  		pgprot_t __prot = prot;
>  
> @@ -307,10 +305,13 @@ static void alloc_init_cont_pmd(pud_t *pudp, unsigned long addr,
>  		    (flags & NO_CONT_MAPPINGS) == 0)
>  			__prot = __pgprot(pgprot_val(prot) | PTE_CONT);
>  
> -		init_pmd(pudp, addr, next, phys, __prot, pgtable_alloc, flags);
> +		init_pmd(pmdp, addr, next, phys, __prot, pgtable_alloc, flags);
>  
> +		pmdp += pmd_index(next) - pmd_index(addr);
>  		phys += next - addr;
>  	} while (addr = next, addr != end);
> +
> +	pmd_clear_fixmap();
>  }
>  
>  static void alloc_init_pud(p4d_t *p4dp, unsigned long addr, unsigned long end,

I looked at this specific patch 1/3 for a while and now make sense the
code changes to reduce down the number of TLBIs respecting the contigous
bit where available at both PMD and PTE levels. I can not finish other 2/3 and 3/3 patches in a timely manner but I'd like to give my

Reviewied-by: Itaru Kitayama <itaru.kitayama@fujitsu.com>

on 1/3.

Thanks,
Itaru.

> -- 
> 2.25.1
> 

