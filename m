Return-Path: <linux-kernel+bounces-66795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 749E1856196
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3B841F295BC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72406129A98;
	Thu, 15 Feb 2024 11:31:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54BAD12A14D
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996665; cv=none; b=pbaoWioNv+VPRVI2y1199vj8LbueiEA6LJ3c47fJ0gxmrmNYgmA9vyUO+M+7Rk2rwmbzqvRHq1j3vwMtMKchQS5WZHSvDfH1jyOemUDOv1I/CA84mukiUhu0VcqsNrO80Qn8ajdi50szpAySUwrfuStMKl+B/llYDiXvHZG3/Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996665; c=relaxed/simple;
	bh=qvAl5OnU1O0lbaL8k1HoJPU//cbUg7t0L/QIvRlyb+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d/GXyWxwTtw+PXJBOHjGYMycnLe5z1cOtgcjwMeUoWVoJ4941157TT5HV9VxRL6irdCpYfIhTnI7AAvQOZCIya7Dak1Ee9MXNJ6HuqBWI/IUYb4MgbhijGD3if7uvTTeQ/6+dUhaEiV0WJhTTgYzrPoS+YqZ5WAG9GrIt1tpyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A5D23DA7;
	Thu, 15 Feb 2024 03:31:44 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2BCF13F7B4;
	Thu, 15 Feb 2024 03:31:00 -0800 (PST)
Date: Thu, 15 Feb 2024 11:30:56 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	David Hildenbrand <david@redhat.com>,
	Kefeng Wang <wangkefeng.wang@huawei.com>,
	John Hubbard <jhubbard@nvidia.com>, Zi Yan <ziy@nvidia.com>,
	Barry Song <21cnbao@gmail.com>,
	Alistair Popple <apopple@nvidia.com>,
	Yang Shi <shy828301@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/18] arm64/mm: Automatically fold contpte mappings
Message-ID: <Zc318I6LWPODE24n@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-19-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-19-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:05AM +0000, Ryan Roberts wrote:
> There are situations where a change to a single PTE could cause the
> contpte block in which it resides to become foldable (i.e. could be
> repainted with the contiguous bit). Such situations arise, for example,
> when user space temporarily changes protections, via mprotect, for
> individual pages, such can be the case for certain garbage collectors.
> 
> We would like to detect when such a PTE change occurs. However this can
> be expensive due to the amount of checking required. Therefore only
> perform the checks when an indiviual PTE is modified via mprotect
> (ptep_modify_prot_commit() -> set_pte_at() -> set_ptes(nr=1)) and only
> when we are setting the final PTE in a contpte-aligned block.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 26 +++++++++++++
>  arch/arm64/mm/contpte.c          | 64 ++++++++++++++++++++++++++++++++
>  2 files changed, 90 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 8310875133ff..401087e8a43d 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1185,6 +1185,8 @@ extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>   * where it is possible and makes sense to do so. The PTE_CONT bit is considered
>   * a private implementation detail of the public ptep API (see below).
>   */
> +extern void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte);
>  extern void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte);
>  extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
> @@ -1206,6 +1208,29 @@ extern int contpte_ptep_set_access_flags(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep,
>  				pte_t entry, int dirty);
>  
> +static __always_inline void contpte_try_fold(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep, pte_t pte)
> +{
> +	/*
> +	 * Only bother trying if both the virtual and physical addresses are
> +	 * aligned and correspond to the last entry in a contig range. The core
> +	 * code mostly modifies ranges from low to high, so this is the likely
> +	 * the last modification in the contig range, so a good time to fold.
> +	 * We can't fold special mappings, because there is no associated folio.
> +	 */
> +
> +	const unsigned long contmask = CONT_PTES - 1;
> +	bool valign = ((addr >> PAGE_SHIFT) & contmask) == contmask;
> +
> +	if (unlikely(valign)) {
> +		bool palign = (pte_pfn(pte) & contmask) == contmask;
> +
> +		if (unlikely(palign &&
> +		    pte_valid(pte) && !pte_cont(pte) && !pte_special(pte)))
> +			__contpte_try_fold(mm, addr, ptep, pte);
> +	}
> +}
> +
>  static __always_inline void contpte_try_unfold(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep, pte_t pte)
>  {
> @@ -1286,6 +1311,7 @@ static __always_inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>  	if (likely(nr == 1)) {
>  		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
>  		__set_ptes(mm, addr, ptep, pte, 1);
> +		contpte_try_fold(mm, addr, ptep, pte);
>  	} else {
>  		contpte_set_ptes(mm, addr, ptep, pte, nr);
>  	}
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index 50e0173dc5ee..16788f07716d 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -73,6 +73,70 @@ static void contpte_convert(struct mm_struct *mm, unsigned long addr,
>  	__set_ptes(mm, start_addr, start_ptep, pte, CONT_PTES);
>  }
>  
> +void __contpte_try_fold(struct mm_struct *mm, unsigned long addr,
> +			pte_t *ptep, pte_t pte)
> +{
> +	/*
> +	 * We have already checked that the virtual and pysical addresses are
> +	 * correctly aligned for a contpte mapping in contpte_try_fold() so the
> +	 * remaining checks are to ensure that the contpte range is fully
> +	 * covered by a single folio, and ensure that all the ptes are valid
> +	 * with contiguous PFNs and matching prots. We ignore the state of the
> +	 * access and dirty bits for the purpose of deciding if its a contiguous
> +	 * range; the folding process will generate a single contpte entry which
> +	 * has a single access and dirty bit. Those 2 bits are the logical OR of
> +	 * their respective bits in the constituent pte entries. In order to
> +	 * ensure the contpte range is covered by a single folio, we must
> +	 * recover the folio from the pfn, but special mappings don't have a
> +	 * folio backing them. Fortunately contpte_try_fold() already checked
> +	 * that the pte is not special - we never try to fold special mappings.
> +	 * Note we can't use vm_normal_page() for this since we don't have the
> +	 * vma.
> +	 */
> +
> +	unsigned long folio_start, folio_end;
> +	unsigned long cont_start, cont_end;
> +	pte_t expected_pte, subpte;
> +	struct folio *folio;
> +	struct page *page;
> +	unsigned long pfn;
> +	pte_t *orig_ptep;
> +	pgprot_t prot;
> +
> +	int i;
> +
> +	if (!mm_is_user(mm))
> +		return;
> +
> +	page = pte_page(pte);
> +	folio = page_folio(page);
> +	folio_start = addr - (page - &folio->page) * PAGE_SIZE;
> +	folio_end = folio_start + folio_nr_pages(folio) * PAGE_SIZE;
> +	cont_start = ALIGN_DOWN(addr, CONT_PTE_SIZE);
> +	cont_end = cont_start + CONT_PTE_SIZE;
> +
> +	if (folio_start > cont_start || folio_end < cont_end)
> +		return;
> +
> +	pfn = ALIGN_DOWN(pte_pfn(pte), CONT_PTES);
> +	prot = pte_pgprot(pte_mkold(pte_mkclean(pte)));
> +	expected_pte = pfn_pte(pfn, prot);
> +	orig_ptep = ptep;
> +	ptep = contpte_align_down(ptep);
> +
> +	for (i = 0; i < CONT_PTES; i++) {
> +		subpte = pte_mkold(pte_mkclean(__ptep_get(ptep)));
> +		if (!pte_same(subpte, expected_pte))
> +			return;
> +		expected_pte = pte_advance_pfn(expected_pte, 1);
> +		ptep++;
> +	}
> +
> +	pte = pte_mkcont(pte);
> +	contpte_convert(mm, addr, orig_ptep, pte);
> +}
> +EXPORT_SYMBOL(__contpte_try_fold);
> +
>  void __contpte_try_unfold(struct mm_struct *mm, unsigned long addr,
>  			pte_t *ptep, pte_t pte)
>  {
> -- 
> 2.25.1
> 

