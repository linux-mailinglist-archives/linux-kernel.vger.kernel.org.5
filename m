Return-Path: <linux-kernel+bounces-56477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E96284CA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 13:22:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44C2928BE1A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28559B7A;
	Wed,  7 Feb 2024 12:22:01 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37ED659B67
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 12:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707308520; cv=none; b=LRYeNhilDVodKBZFsD+3J3bSEhIf/dIyKCJ7x316Kwi3rStD5lruVcxmr+PRUzUc5u5FPUYJctq57KiQIAhBJETXIWlfrnl3On2Sesj1T6wkEHTV3L5n0yoIEzFA7pa+bwNvAwQqxUPaw/9EbULMEWXqisbur8x/fL2rN2rE4Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707308520; c=relaxed/simple;
	bh=eMJutKtmerpdPbuovV6ZFxtOucjF2WaQzNswyU+ASvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mk/KJ/4895mMYepIhrUGAaPLkWIFYUfjI6cgMta1jYzCv0QJ9oA6HmXWeM4vrcUTN3jxVl6AAIMLWtTbfIF0ziQzq0AlNpCDAzThhTdcmgGSww7x8+WiR1c7bprKoLRRWsEywtmVGwYqZRzie828PrsY0EwK1YJJy6wK/U18nKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C27C1FB;
	Wed,  7 Feb 2024 04:22:40 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.26.150])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 13C873F5A1;
	Wed,  7 Feb 2024 04:21:55 -0800 (PST)
Date: Wed, 7 Feb 2024 12:21:49 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Nanyong Sun <sunnanyong@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, mike.kravetz@oracle.com,
	muchun.song@linux.dev, akpm@linux-foundation.org,
	anshuman.khandual@arm.com, willy@infradead.org,
	wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v3 2/3] arm64: mm: HVO: support BBM of vmemmap pgtable
 safely
Message-ID: <ZcN13R1L1CYu9gs1@FVFF77S0Q05N.cambridge.arm.com>
References: <20240113094436.2506396-1-sunnanyong@huawei.com>
 <20240113094436.2506396-3-sunnanyong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240113094436.2506396-3-sunnanyong@huawei.com>

On Sat, Jan 13, 2024 at 05:44:35PM +0800, Nanyong Sun wrote:
> Implement vmemmap_update_pmd and vmemmap_update_pte on arm64 to do
> BBM(break-before-make) logic when change the page table of vmemmap
> address, they will under the init_mm.page_table_lock.
> If a translation fault of vmemmap address concurrently happened after
> pte/pmd cleared, vmemmap page fault handler will acquire the
> init_mm.page_table_lock to wait for vmemmap update to complete,
> by then the virtual address is valid again, so PF can return and
> access can continue.

Is that wait bounded? ... and is it event guaranteed to make progress?

Under a hypervisor, the vCPU doing the BBM could be preempted between the break
and the make, so the thread waiting might be waiting a long time for that to
come back and finish the make step.

Further, under PREEMPT_RT regular spinlocks don't inhibit preemption, and I suspect
that means this can deadlock on RT -- the thread doing the BBM could be
preempted, the newly-scheduled thread could try to access the vmemmap, and then
get stuck in the fault handler (e.g. on a single CPU system). There's nothing
below describing how that's prevented.

I've concerned this may be subtly broken, and it feels like this is going to be
*very* painful to maintain and test. IMO this is trying to be overly clever and
I'd much rather that we avoided the transient broken step. On CPUs with
FEAT_BBM level 2 we can avoid that broken step, can we make this depend
dynamically on whether the CPU has FEAT_BBM?

> In other case, do the traditional kernel fault.
> 
> Implement vmemmap_flush_tlb_all/range on arm64 with nothing
> to do because tlb already flushed in every single BBM.
> 
> Signed-off-by: Nanyong Sun <sunnanyong@huawei.com>
> ---
>  arch/arm64/include/asm/esr.h      |  4 ++
>  arch/arm64/include/asm/pgtable.h  |  8 ++++
>  arch/arm64/include/asm/tlbflush.h | 16 +++++++
>  arch/arm64/mm/fault.c             | 78 +++++++++++++++++++++++++++++--
>  arch/arm64/mm/mmu.c               | 28 +++++++++++
>  5 files changed, 131 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index ae35939f395b..1c63256efd25 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -116,6 +116,10 @@
>  #define ESR_ELx_FSC_SERROR	(0x11)
>  #define ESR_ELx_FSC_ACCESS	(0x08)
>  #define ESR_ELx_FSC_FAULT	(0x04)
> +#define ESR_ELx_FSC_FAULT_L0    (0x04)
> +#define ESR_ELx_FSC_FAULT_L1    (0x05)
> +#define ESR_ELx_FSC_FAULT_L2    (0x06)
> +#define ESR_ELx_FSC_FAULT_L3    (0x07)
>  #define ESR_ELx_FSC_PERM	(0x0C)
>  #define ESR_ELx_FSC_SEA_TTW0	(0x14)
>  #define ESR_ELx_FSC_SEA_TTW1	(0x15)
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 79ce70fbb751..b50270107e2f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1124,6 +1124,14 @@ extern pte_t ptep_modify_prot_start(struct vm_area_struct *vma,
>  extern void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  				    unsigned long addr, pte_t *ptep,
>  				    pte_t old_pte, pte_t new_pte);
> +
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep);
> +#define vmemmap_update_pmd vmemmap_update_pmd
> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte);
> +#define vmemmap_update_pte vmemmap_update_pte
> +#endif
> +
>  #endif /* !__ASSEMBLY__ */
>  
>  #endif /* __ASM_PGTABLE_H */
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index 1deb5d789c2e..79e932a1bdf8 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -504,6 +504,22 @@ static inline void __flush_tlb_kernel_pgtable(unsigned long kaddr)
>  	dsb(ish);
>  	isb();
>  }
> +
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +static inline void vmemmap_flush_tlb_all(void)
> +{
> +	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define vmemmap_flush_tlb_all vmemmap_flush_tlb_all
> +
> +static inline void vmemmap_flush_tlb_range(unsigned long start,
> +					   unsigned long end)
> +{
> +	/* do nothing, already flushed tlb in every single BBM */
> +}
> +#define vmemmap_flush_tlb_range vmemmap_flush_tlb_range
> +#endif
> +
>  #endif
>  
>  #endif
> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> index 55f6455a8284..13189322a38f 100644
> --- a/arch/arm64/mm/fault.c
> +++ b/arch/arm64/mm/fault.c
> @@ -368,6 +368,75 @@ static bool is_el1_mte_sync_tag_check_fault(unsigned long esr)
>  	return false;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +static inline bool vmemmap_fault_may_fixup(unsigned long addr,
> +					   unsigned long esr)
> +{
> +	if (addr < VMEMMAP_START || addr >= VMEMMAP_END)
> +		return false;
> +
> +	/*
> +	 * Only try to handle translation fault level 2 or level 3,
> +	 * because hugetlb vmemmap optimize only clear pmd or pte.
> +	 */
> +	switch (esr & ESR_ELx_FSC) {
> +	case ESR_ELx_FSC_FAULT_L2:
> +	case ESR_ELx_FSC_FAULT_L3:
> +		return true;
> +	default:
> +		return false;
> +	}
> +}
> +
> +/*
> + * PMD mapped vmemmap should has been split as PTE mapped
> + * by HVO now, here we only check this case, other cases
> + * should fail.

Sorry, I can't parse what this is trying to say.

> + * Also should check the addr is healthy enough that will not cause
> + * a level2 or level3 translation fault again after page fault
> + * handled with success, so we need check both bits[1:0] of PMD and
> + * PTE as ARM Spec mentioned below:

Which spec? Iassume you mean the ARM ARM? Are you referring to a specific part
within that?

> + * A Translation fault is generated if bits[1:0] of a translation
> + * table descriptor identify the descriptor as either a Fault
> + * encoding or a reserved encoding.
> + */
> +static inline bool vmemmap_addr_healthy(unsigned long addr)
> +{
> +	pmd_t *pmdp, pmd;
> +	pte_t *ptep, pte;
> +
> +	pmdp = pmd_off_k(addr);
> +	pmd = pmdp_get(pmdp);
> +	if (!pmd_table(pmd))
> +		return false;

Is a block (i.e. hugetlb) entry not considered healthy? I thought the whole
point of this optimization was that you'd use a block PMD entry?

> +
> +	ptep = pte_offset_kernel(pmdp, addr);
> +	pte = ptep_get(ptep);
> +	return (pte_val(pte) & PTE_TYPE_MASK) == PTE_TYPE_PAGE;
> +}
> +
> +static bool vmemmap_handle_page_fault(unsigned long addr,
> +				      unsigned long esr)
> +{
> +	bool ret;
> +
> +	if (likely(!vmemmap_fault_may_fixup(addr, esr)))
> +		return false;
> +
> +	spin_lock(&init_mm.page_table_lock);
> +	ret = vmemmap_addr_healthy(addr);
> +	spin_unlock(&init_mm.page_table_lock);

As above, I'm pretty sure this is only safe is the code doing the BBM has IRQs
disabled, otherwise the thread can be preempted, and we can get stuck in here
while the entry is broken.

So at minimum this needs some explanation of why that doesn't happen in a
comment.

> +
> +	return ret;
> +}
> +#else
> +static inline bool vmemmap_handle_page_fault(unsigned long addr,
> +					     unsigned long esr)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP */
> +
>  static bool is_translation_fault(unsigned long esr)
>  {
>  	return (esr & ESR_ELx_FSC_TYPE) == ESR_ELx_FSC_FAULT;
> @@ -405,9 +474,12 @@ static void __do_kernel_fault(unsigned long addr, unsigned long esr,
>  	} else if (addr < PAGE_SIZE) {
>  		msg = "NULL pointer dereference";
>  	} else {
> -		if (is_translation_fault(esr) &&
> -		    kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
> -			return;
> +		if (is_translation_fault(esr)) {
> +			if (kfence_handle_page_fault(addr, esr & ESR_ELx_WNR, regs))
> +				return;
> +			if (vmemmap_handle_page_fault(addr, esr))
> +				return;
> +		}
>  
>  		msg = "paging request";
>  	}
> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> index 1ac7467d34c9..d794b2f4b5a3 100644
> --- a/arch/arm64/mm/mmu.c
> +++ b/arch/arm64/mm/mmu.c
> @@ -1146,6 +1146,34 @@ int __meminit vmemmap_check_pmd(pmd_t *pmdp, int node,
>  	return 1;
>  }
>  
> +#ifdef CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
> +/*
> + * In the window between the page table entry is cleared and filled
> + * with a new value, other threads have the opportunity to concurrently
> + * access the vmemmap area then page translation fault occur.
> + * Therefore, we need to ensure that the init_mm.page_table_lock is held
> + * to synchronize the vmemmap page fault handling which will wait for
> + * this lock to be released to ensure that the page table entry has been
> + * refreshed with a new valid value.
> + */
> +void vmemmap_update_pmd(unsigned long addr, pmd_t *pmdp, pte_t *ptep)
> +{
> +	lockdep_assert_held(&init_mm.page_table_lock);
> +	pmd_clear(pmdp);
> +	flush_tlb_kernel_range(addr, addr + PMD_SIZE);
> +	pmd_populate_kernel(&init_mm, pmdp, ptep);
> +}
> +
> +void vmemmap_update_pte(unsigned long addr, pte_t *ptep, pte_t pte)
> +{
> +	spin_lock(&init_mm.page_table_lock);
> +	pte_clear(&init_mm, addr, ptep);
> +	flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> +	set_pte_at(&init_mm, addr, ptep, pte);
> +	spin_unlock(&init_mm.page_table_lock);
> +}

As above, if this happens with IRQs unmasked, the thread can potentially be
preempted and we can get stuck in the fault handler (at least on RT).

I can't tell whether this is safe, and I think that at minimum this needs
comments and/or lockdep assertions, but I'd much rather we didn't try to play
this sort of game.

Mark.

