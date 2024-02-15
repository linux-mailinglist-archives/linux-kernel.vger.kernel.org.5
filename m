Return-Path: <linux-kernel+bounces-66792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B15C85618D
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 300371C230E3
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 11:29:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E3112A158;
	Thu, 15 Feb 2024 11:29:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E037D129A8A
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 11:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707996546; cv=none; b=UldldeVPc5E5h1/2RTkfkdeGgr4FtoltjUwIO7j6Poab6a6htHJMaPO3jJ79Qr1lTZkeUIGSxFUjzPhSx9isFgxS4Hf1ezG1ZK78veNex3FCX/94kZ3szzNGWM5y1jU7SOlDuBO+/ngCdez0Pycl5Bjv1fuAP2NUv31KHL/+mxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707996546; c=relaxed/simple;
	bh=08dZSk3vv08S63hF2txkaw8uAM7KnMVs+f5LuHcEul4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nG9fu5ZtV+HGz0hhbxOLTjMeXuMC6rn0OFEyB6tvQBXgwO60oO4dGKqeSHu3A2TUrPyWBTP3ig/dpZoXQXYTSeRyztn8CpcVu+LI6CgMZyagHoEKDnSMEXvUP7tYPDWF1vKioa08RcpLphkrw7CRb8xiGBvP5PFkgw9lYYjOziY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44F6EDA7;
	Thu, 15 Feb 2024 03:29:45 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.68.11])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3FF3F7B4;
	Thu, 15 Feb 2024 03:29:00 -0800 (PST)
Date: Thu, 15 Feb 2024 11:28:58 +0000
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
Subject: Re: [PATCH v6 14/18] arm64/mm: Implement new
 [get_and_]clear_full_ptes() batch APIs
Message-ID: <Zc31esUwBD2jgYiX@FVFF77S0Q05N>
References: <20240215103205.2607016-1-ryan.roberts@arm.com>
 <20240215103205.2607016-15-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215103205.2607016-15-ryan.roberts@arm.com>

On Thu, Feb 15, 2024 at 10:32:01AM +0000, Ryan Roberts wrote:
> Optimize the contpte implementation to fix some of the
> exit/munmap/dontneed performance regression introduced by the initial
> contpte commit. Subsequent patches will solve it entirely.
> 
> During exit(), munmap() or madvise(MADV_DONTNEED), mappings must be
> cleared. Previously this was done 1 PTE at a time. But the core-mm
> supports batched clear via the new [get_and_]clear_full_ptes() APIs. So
> let's implement those APIs and for fully covered contpte mappings, we no
> longer need to unfold the contpte. This significantly reduces unfolding
> operations, reducing the number of tlbis that must be issued.
> 
> Tested-by: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> ---
>  arch/arm64/include/asm/pgtable.h | 67 ++++++++++++++++++++++++++++++++
>  arch/arm64/mm/contpte.c          | 17 ++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 8643227c318b..a8f1a35e3086 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -965,6 +965,37 @@ static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
>  	return pte;
>  }
>  
> +static inline void __clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr, int full)
> +{
> +	for (;;) {
> +		__ptep_get_and_clear(mm, addr, ptep);
> +		if (--nr == 0)
> +			break;
> +		ptep++;
> +		addr += PAGE_SIZE;
> +	}
> +}
> +
> +static inline pte_t __get_and_clear_full_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, int full)
> +{
> +	pte_t pte, tmp_pte;
> +
> +	pte = __ptep_get_and_clear(mm, addr, ptep);
> +	while (--nr) {
> +		ptep++;
> +		addr += PAGE_SIZE;
> +		tmp_pte = __ptep_get_and_clear(mm, addr, ptep);
> +		if (pte_dirty(tmp_pte))
> +			pte = pte_mkdirty(pte);
> +		if (pte_young(tmp_pte))
> +			pte = pte_mkyoung(pte);
> +	}
> +	return pte;
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR
>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
> @@ -1160,6 +1191,11 @@ extern pte_t contpte_ptep_get(pte_t *ptep, pte_t orig_pte);
>  extern pte_t contpte_ptep_get_lockless(pte_t *orig_ptep);
>  extern void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  				pte_t *ptep, pte_t pte, unsigned int nr);
> +extern void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr, int full);
> +extern pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, int full);
>  extern int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  				unsigned long addr, pte_t *ptep);
>  extern int contpte_ptep_clear_flush_young(struct vm_area_struct *vma,
> @@ -1253,6 +1289,35 @@ static inline void pte_clear(struct mm_struct *mm,
>  	__pte_clear(mm, addr, ptep);
>  }
>  
> +#define clear_full_ptes clear_full_ptes
> +static inline void clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr, int full)
> +{
> +	if (likely(nr == 1)) {
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		__clear_full_ptes(mm, addr, ptep, nr, full);
> +	} else {
> +		contpte_clear_full_ptes(mm, addr, ptep, nr, full);
> +	}
> +}
> +
> +#define get_and_clear_full_ptes get_and_clear_full_ptes
> +static inline pte_t get_and_clear_full_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, int full)
> +{
> +	pte_t pte;
> +
> +	if (likely(nr == 1)) {
> +		contpte_try_unfold(mm, addr, ptep, __ptep_get(ptep));
> +		pte = __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
> +	} else {
> +		pte = contpte_get_and_clear_full_ptes(mm, addr, ptep, nr, full);
> +	}
> +
> +	return pte;
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				unsigned long addr, pte_t *ptep)
> @@ -1337,6 +1402,8 @@ static inline int ptep_set_access_flags(struct vm_area_struct *vma,
>  #define set_pte					__set_pte
>  #define set_ptes				__set_ptes
>  #define pte_clear				__pte_clear
> +#define clear_full_ptes				__clear_full_ptes
> +#define get_and_clear_full_ptes			__get_and_clear_full_ptes
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  #define ptep_get_and_clear			__ptep_get_and_clear
>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
> diff --git a/arch/arm64/mm/contpte.c b/arch/arm64/mm/contpte.c
> index bedb58524535..50e0173dc5ee 100644
> --- a/arch/arm64/mm/contpte.c
> +++ b/arch/arm64/mm/contpte.c
> @@ -212,6 +212,23 @@ void contpte_set_ptes(struct mm_struct *mm, unsigned long addr,
>  }
>  EXPORT_SYMBOL(contpte_set_ptes);
>  
> +void contpte_clear_full_ptes(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, unsigned int nr, int full)
> +{
> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
> +	__clear_full_ptes(mm, addr, ptep, nr, full);
> +}
> +EXPORT_SYMBOL(contpte_clear_full_ptes);
> +
> +pte_t contpte_get_and_clear_full_ptes(struct mm_struct *mm,
> +				unsigned long addr, pte_t *ptep,
> +				unsigned int nr, int full)
> +{
> +	contpte_try_unfold_partial(mm, addr, ptep, nr);
> +	return __get_and_clear_full_ptes(mm, addr, ptep, nr, full);
> +}
> +EXPORT_SYMBOL(contpte_get_and_clear_full_ptes);
> +
>  int contpte_ptep_test_and_clear_young(struct vm_area_struct *vma,
>  					unsigned long addr, pte_t *ptep)
>  {
> -- 
> 2.25.1
> 

