Return-Path: <linux-kernel+bounces-164014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FB78B7721
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:32:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CC1F2839CB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5D17333C;
	Tue, 30 Apr 2024 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RIDRN3ai"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03397172BB9
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483844; cv=none; b=CuTAQj1aBpflYRo9iwq8YENS8eOs9Wv3hVxmHL8vNdaUnr1EAFR/yzxsejbTzqvtgay3JQwevoZKm0MiI4ZuTwCVI7ysJ3TmpX7paEb4B19yp/R9Q4YqFj0+SEdGSIf4wp200xORgCg7tD846QEEVRZUay8gWLHqANJzI8kBUyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483844; c=relaxed/simple;
	bh=vXh/1L0F7Sd7YSxjtijsSac7grGEArw4UQGpY3herzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hh47ROQ7n1zeq4cMODS9TXpO2dkA41u5MpIyPXtlvYpf+dMi6KTskbLYitmuCCdqgr/JXAZv5QWb44gRP0Xe2TbYK75xSvds1V2gYbNb4I8uI4r5WfE/2y4neSj8t/R3ZI2j25ym1VxIi0amfJVK0urVIlDiNDRyvNsTWr4bJG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RIDRN3ai; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446EEC4AF19;
	Tue, 30 Apr 2024 13:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714483843;
	bh=vXh/1L0F7Sd7YSxjtijsSac7grGEArw4UQGpY3herzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RIDRN3aicIdXkE7mwrU5+VyjZiea5xnZ2ENED5ianSdCbfIPi3+vJSkzrrS130aJW
	 UHd+AYIl3feFWq5jd2AZRHS31UrSohR/U0ByMRvjDjlCPKDOK3zSKPowcI2tkc4HxH
	 hOP5G7MUF/OnMdU4DTPVRVABHJ+4jvIKxN4hHRwYy/2lQ7FMzRuLaUGNN4Q6/NjR/5
	 b4JWIxhTh1oGymVGowQaSGiHoT2Naj+5zWUoUkXntVTBDg2xo32QNzgwWbEwYs3WpV
	 L34yVZgW/b80BnIRPvFY5sc7FNVg5gWP4lLiuR8HLbpIJKedqZ9NiFek8pPQjwj307
	 eZNBLNCI2Nm0Q==
Date: Tue, 30 Apr 2024 14:30:37 +0100
From: Will Deacon <will@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Joey Gouly <joey.gouly@arm.com>, Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Message-ID: <20240430133037.GA13848@willie-the-truck>
References: <20240429140208.238056-1-ryan.roberts@arm.com>
 <20240429140208.238056-2-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429140208.238056-2-ryan.roberts@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hey Ryan,

Just a couple of comments on this:

On Mon, Apr 29, 2024 at 03:02:05PM +0100, Ryan Roberts wrote:
> diff --git a/arch/arm64/include/asm/pgtable-prot.h b/arch/arm64/include/asm/pgtable-prot.h
> index dd9ee67d1d87..de62e6881154 100644
> --- a/arch/arm64/include/asm/pgtable-prot.h
> +++ b/arch/arm64/include/asm/pgtable-prot.h
> @@ -18,14 +18,7 @@
>  #define PTE_DIRTY		(_AT(pteval_t, 1) << 55)
>  #define PTE_SPECIAL		(_AT(pteval_t, 1) << 56)
>  #define PTE_DEVMAP		(_AT(pteval_t, 1) << 57)
> -#define PTE_PROT_NONE		(_AT(pteval_t, 1) << 58) /* only when !PTE_VALID */
> -
> -/*
> - * This bit indicates that the entry is present i.e. pmd_page()
> - * still points to a valid huge page in memory even if the pmd
> - * has been invalidated.
> - */
> -#define PMD_PRESENT_INVALID	(_AT(pteval_t, 1) << 59) /* only when !PMD_SECT_VALID */
> +#define PTE_INVALID		(_AT(pteval_t, 1) << 59) /* only when !PTE_VALID */

So this now overlaps with AttrIndx[3] if FEAT_AIE is implemented. Although
this shouldn't matter on the face of things because it's only used for
invalid entries, we originally moved the PROT_NONE bit from 2 to 57 back
in 3676f9ef5481 ("arm64: Move PTE_PROT_NONE higher up") because it was
possible to change the memory type for PROT_NONE mappings via some
drivers.

Moving the field to the NS bit (as you do later in the series) resolves
this, but the architecture currently says that the NS bit is RES0. How
can we guarantee that it won't be repurposed by hardware in future?

>  #define _PROT_DEFAULT		(PTE_TYPE_PAGE | PTE_AF | PTE_SHARED)
>  #define _PROT_SECT_DEFAULT	(PMD_TYPE_SECT | PMD_SECT_AF | PMD_SECT_S)
> @@ -103,7 +96,7 @@ static inline bool __pure lpa2_is_enabled(void)
>  		__val;							\
>  	 })
>  
> -#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_PROT_NONE | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
> +#define PAGE_NONE		__pgprot(((_PAGE_DEFAULT) & ~PTE_VALID) | PTE_INVALID | PTE_RDONLY | PTE_NG | PTE_PXN | PTE_UXN)
>  /* shared+writable pages are clean by default, hence PTE_RDONLY|PTE_WRITE */
>  #define PAGE_SHARED		__pgprot(_PAGE_SHARED)
>  #define PAGE_SHARED_EXEC	__pgprot(_PAGE_SHARED_EXEC)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index afdd56d26ad7..8dd4637d6b56 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -105,7 +105,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  /*
>   * The following only work if pte_present(). Undefined behaviour otherwise.
>   */
> -#define pte_present(pte)	(!!(pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)))
> +#define pte_present(pte)	(pte_valid(pte) || pte_invalid(pte))
>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> @@ -132,6 +132,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  #define pte_dirty(pte)		(pte_sw_dirty(pte) || pte_hw_dirty(pte))
>  
>  #define pte_valid(pte)		(!!(pte_val(pte) & PTE_VALID))
> +#define pte_invalid(pte)	((pte_val(pte) & (PTE_VALID | PTE_INVALID)) == PTE_INVALID)
>  /*
>   * Execute-only user mappings do not have the PTE_USER bit set. All valid
>   * kernel mappings have the PTE_UXN bit set.
> @@ -261,6 +262,13 @@ static inline pte_t pte_mkpresent(pte_t pte)
>  	return set_pte_bit(pte, __pgprot(PTE_VALID));
>  }
>  
> +static inline pte_t pte_mkinvalid(pte_t pte)
> +{
> +	pte = set_pte_bit(pte, __pgprot(PTE_INVALID));
> +	pte = clear_pte_bit(pte, __pgprot(PTE_VALID));
> +	return pte;
> +}
> +
>  static inline pmd_t pmd_mkcont(pmd_t pmd)
>  {
>  	return __pmd(pmd_val(pmd) | PMD_SECT_CONT);
> @@ -469,7 +477,7 @@ static inline pte_t pte_swp_clear_exclusive(pte_t pte)
>   */
>  static inline int pte_protnone(pte_t pte)
>  {
> -	return (pte_val(pte) & (PTE_VALID | PTE_PROT_NONE)) == PTE_PROT_NONE;
> +	return pte_invalid(pte) && !pte_user(pte) && !pte_user_exec(pte);
>  }

Why do we need to check pte_user_*() here? Isn't PROT_NONE the only case
in which a pte will have PTE_INVALID set?

Will

