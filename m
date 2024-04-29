Return-Path: <linux-kernel+bounces-162673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1A98B5ECB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5451E1C2174E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5EC84A2B;
	Mon, 29 Apr 2024 16:20:35 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D7482D69
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 16:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407635; cv=none; b=raYr0mfphri2N5B0yP/nZ2TyDeZOo9JMFkdSYAImZhi1bzlHDqkdAAhVymvNAjrQHPpxZEuJTA3+Zs3kDcFR19CYekLOyeNNToC0mMS/OMZI5q88x3qon9lT5C8Sn7+JQqg02Ug1m/VJ45CKsx1c7q0tkMeAV+xjnziB4pNYIAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407635; c=relaxed/simple;
	bh=O5HgdgtYPHNaFX2XfXn4EJbjlbVt640PthKiQvrWP2w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYJWLY+kF/BqbYHzmfeKEJbImsvmWASyJ9nbzZftvoMekfMDC3s6fbkLxp4IjCmeiFoo7IfwNMOybruViKkIgJQ7sGJ/lt1S4Wn36Idt3q4bxtW1tzghP7S0HbUth+czNaK4cXz0QPBa4FK6G2XcUpn/Qfrz/fQfFgd4y+ptfTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BF9C4AF14;
	Mon, 29 Apr 2024 16:20:32 +0000 (UTC)
Date: Mon, 29 Apr 2024 17:20:30 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	David Hildenbrand <david@redhat.com>, Peter Xu <peterx@redhat.com>,
	Mike Rapoport <rppt@linux.ibm.com>,
	Shivansh Vij <shivanshvij@outlook.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] arm64/mm: Refactor PMD_PRESENT_INVALID and
 PTE_PROT_NONE bits
Message-ID: <Zi_IzrfIcqWxt7cE@arm.com>
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

Nitpick - I prefer the PTE_PRESENT_INVALID name as it makes it clearer
it's a present pte. We already have PTE_VALID, calling it PTE_INVALID
looks like a negation only.

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

Same argument as above, pte_invalid() looks confusing to me, better (to
me) as pte_present_invalid().

I think it's sufficient to check PTE_PRESENT_INVALID only. We'd never
have both bits set, so no need for mask and compare.

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

I wonder whether we need to define this. I guess it makes sense than
having the pmd_mkinvalid() use the PTE_* definitions directly, though it
won't be something we need to do on a pte.

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
>  
>  static inline int pmd_protnone(pmd_t pmd)
> @@ -478,12 +486,7 @@ static inline int pmd_protnone(pmd_t pmd)
>  }
>  #endif
>  
> -#define pmd_present_invalid(pmd)     (!!(pmd_val(pmd) & PMD_PRESENT_INVALID))
> -
> -static inline int pmd_present(pmd_t pmd)
> -{
> -	return pte_present(pmd_pte(pmd)) || pmd_present_invalid(pmd);
> -}
> +#define pmd_present(pmd)	pte_present(pmd_pte(pmd))
>  
>  /*
>   * THP definitions.
> @@ -508,14 +511,7 @@ static inline int pmd_trans_huge(pmd_t pmd)
>  #define pmd_mkclean(pmd)	pte_pmd(pte_mkclean(pmd_pte(pmd)))
>  #define pmd_mkdirty(pmd)	pte_pmd(pte_mkdirty(pmd_pte(pmd)))
>  #define pmd_mkyoung(pmd)	pte_pmd(pte_mkyoung(pmd_pte(pmd)))
> -
> -static inline pmd_t pmd_mkinvalid(pmd_t pmd)
> -{
> -	pmd = set_pmd_bit(pmd, __pgprot(PMD_PRESENT_INVALID));
> -	pmd = clear_pmd_bit(pmd, __pgprot(PMD_SECT_VALID));
> -
> -	return pmd;
> -}
> +#define pmd_mkinvalid(pmd)	pte_pmd(pte_mkinvalid(pmd_pte(pmd)))
>  
>  #define pmd_thp_or_huge(pmd)	(pmd_huge(pmd) || pmd_trans_huge(pmd))
>  
> @@ -1027,7 +1023,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	 * in MAIR_EL1. The mask below has to include PTE_ATTRINDX_MASK.
>  	 */
>  	const pteval_t mask = PTE_USER | PTE_PXN | PTE_UXN | PTE_RDONLY |
> -			      PTE_PROT_NONE | PTE_VALID | PTE_WRITE | PTE_GP |
> +			      PTE_INVALID | PTE_VALID | PTE_WRITE | PTE_GP |
>  			      PTE_ATTRINDX_MASK;
>  	/* preserve the hardware dirty information */
>  	if (pte_hw_dirty(pte))
> @@ -1076,17 +1072,17 @@ static inline int pgd_devmap(pgd_t pgd)
>  #ifdef CONFIG_PAGE_TABLE_CHECK
>  static inline bool pte_user_accessible_page(pte_t pte)
>  {
> -	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> +	return pte_valid(pte) && (pte_user(pte) || pte_user_exec(pte));
>  }

This looks fine, it doesn't change the semantics since PROT_NONE never
had pte_user() or pte_user_exec().

>  static inline bool pmd_user_accessible_page(pmd_t pmd)
>  {
> -	return pmd_leaf(pmd) && !pmd_present_invalid(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +	return pmd_valid(pmd) && !pmd_table(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>  }

Maybe our pmd_leaf() should actually check valid && !table instead of
present and no need to change these.

>  static inline bool pud_user_accessible_page(pud_t pud)
>  {
> -	return pud_leaf(pud) && (pud_user(pud) || pud_user_exec(pud));
> +	return pud_valid(pud) && !pud_table(pud) && (pud_user(pud) || pud_user_exec(pud));
>  }
>  #endif

Same here.

Otherwise I'm happy with the patch. Feel free to add:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

As for getting it into 6.10, I'd say it's pretty late. Are there other
dependencies on core kernel fixes?

-- 
Catalin

