Return-Path: <linux-kernel+bounces-42319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9851783FF8B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F509282CB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 08:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC614F1EA;
	Mon, 29 Jan 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSum0+lm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BA24F1EB
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706515342; cv=none; b=ZjjoRWV6G5EYkXOqAsL6/FDErL81tFcEbg4LTSyoqC3tJFm/zIuGntcOLkI5oMt1aIC1PbrWIzLRRLJp5tFztsbRH5lgGQ94r/PyvoF3E0n6hmh2ogmHeCS03JBI14eDRrrQFWjngZmwrjnluaV0aYnkhhlfSDBY8zEu+8+4z5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706515342; c=relaxed/simple;
	bh=sZsG7QH1rlDO0WNxsYn3wAlIDwJT/YYn7MykAKKXVOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bU01wLF4rjGrv5dhdagkLTWykVAOO9EEeZ2/wDjBIHAhA0hnxTKGUhB2sZ+MHIt0I3WxkDrKoMWsoj5+oqhKsHpGlmn7fIe9H+gh24UgahTBB4dW+vXMtlejL/YMpO55V1c9VdZ2/4JBLIcXlIItoqYGBHtqNYsLy6kCjKT/BfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bSum0+lm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE37C433F1;
	Mon, 29 Jan 2024 08:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706515342;
	bh=sZsG7QH1rlDO0WNxsYn3wAlIDwJT/YYn7MykAKKXVOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bSum0+lmKUkVLL2tswoS64p8dfcOhCh3MlgHdL0sxFEqZnHTqgiTGSTVx9z7VYZx3
	 V4zwoFm22wrQyo+sXPrUff684wlAUFVwG/7SxDDZ07hLSIXqxmqTn9ZorC/AbGRzht
	 uFPy/Bpt4vDo/z1NLkymMSICp5dA3HYP4IJj5HLvpFabB7MEAx2DsDieZjwkZDVT/V
	 LAPsPRcB7XZTpvypnLvuh2dJsNE+SL6V1it5+Y3y413fNCE5F6JWt0iVrBKeTPL1ZQ
	 ziXGWoCPyHhQzViv+/beNCWfmAGjuNCmmh1s0Up5qLj6mXjpEc3kTdW/QGqdxNIKPR
	 t4YVHm/ym2NTA==
Date: Mon, 29 Jan 2024 15:49:30 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Yunhui Cui <cuiyunhui@bytedance.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	alexghiti@rivosinc.com, samuel.holland@sifive.com,
	ajones@ventanamicro.com, mchitale@ventanamicro.com,
	dylan@andestech.com, sergey.matyukevich@syntacore.com,
	prabhakar.mahadev-lad.rj@bp.renesas.com, apatel@ventanamicro.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RISC-V: add uniprocessor flush_tlb_range() support
Message-ID: <ZbdYijWK1PnHXn47@xhacker>
References: <20240125062044.63344-1-cuiyunhui@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240125062044.63344-1-cuiyunhui@bytedance.com>

On Thu, Jan 25, 2024 at 02:20:44PM +0800, Yunhui Cui wrote:
> Add support for flush_tlb_range() to improve TLB performance for
> UP systems. In order to avoid the mutual inclusion of tlbflush.h
> and hugetlb.h, the UP part is also implemented in tlbflush.c.

Hi Yunhui,

IIRC, Samuel sent similar patch series a few weeks ago.

https://lore.kernel.org/linux-riscv/20240102220134.3229156-1-samuel.holland@sifive.com/

After that series, do you still need this patch?

Thanks
> 
> Signed-off-by: Yunhui Cui <cuiyunhui@bytedance.com>
> ---
>  arch/riscv/include/asm/tlbflush.h |  61 ++++++----
>  arch/riscv/mm/Makefile            |   2 +-
>  arch/riscv/mm/tlbflush.c          | 195 ++++++++++++++++++------------
>  3 files changed, 156 insertions(+), 102 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 928f096dca21..426f043fb450 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -10,12 +10,21 @@
>  #include <linux/mm_types.h>
>  #include <asm/smp.h>
>  #include <asm/errata_list.h>
> +#include <asm/tlbbatch.h>
>  
>  #define FLUSH_TLB_MAX_SIZE      ((unsigned long)-1)
>  #define FLUSH_TLB_NO_ASID       ((unsigned long)-1)
>  
>  #ifdef CONFIG_MMU
>  extern unsigned long asid_mask;
> +DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
> +
> +struct flush_tlb_range_data {
> +	unsigned long asid;
> +	unsigned long start;
> +	unsigned long size;
> +	unsigned long stride;
> +};
>  
>  static inline void local_flush_tlb_all(void)
>  {
> @@ -27,12 +36,40 @@ static inline void local_flush_tlb_page(unsigned long addr)
>  {
>  	ALT_FLUSH_TLB_PAGE(__asm__ __volatile__ ("sfence.vma %0" : : "r" (addr) : "memory"));
>  }
> +
> +static inline void local_flush_tlb_all_asid(unsigned long asid)
> +{
> +	if (asid != FLUSH_TLB_NO_ASID)
> +		__asm__ __volatile__ ("sfence.vma x0, %0"
> +				:
> +				: "r" (asid)
> +				: "memory");
> +	else
> +		local_flush_tlb_all();
> +}
> +
> +static inline void local_flush_tlb_page_asid(unsigned long addr,
> +		unsigned long asid)
> +{
> +	if (asid != FLUSH_TLB_NO_ASID)
> +		__asm__ __volatile__ ("sfence.vma %0, %1"
> +				:
> +				: "r" (addr), "r" (asid)
> +				: "memory");
> +	else
> +		local_flush_tlb_page(addr);
> +}
> +
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +	return static_branch_unlikely(&use_asid_allocator) ?
> +			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +}
>  #else /* CONFIG_MMU */
>  #define local_flush_tlb_all()			do { } while (0)
>  #define local_flush_tlb_page(addr)		do { } while (0)
>  #endif /* CONFIG_MMU */
>  
> -#if defined(CONFIG_SMP) && defined(CONFIG_MMU)
>  void flush_tlb_all(void);
>  void flush_tlb_mm(struct mm_struct *mm);
>  void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
> @@ -55,26 +92,4 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
>  void arch_flush_tlb_batched_pending(struct mm_struct *mm);
>  void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
>  
> -#else /* CONFIG_SMP && CONFIG_MMU */
> -
> -#define flush_tlb_all() local_flush_tlb_all()
> -#define flush_tlb_page(vma, addr) local_flush_tlb_page(addr)
> -
> -static inline void flush_tlb_range(struct vm_area_struct *vma,
> -		unsigned long start, unsigned long end)
> -{
> -	local_flush_tlb_all();
> -}
> -
> -/* Flush a range of kernel pages */
> -static inline void flush_tlb_kernel_range(unsigned long start,
> -	unsigned long end)
> -{
> -	local_flush_tlb_all();
> -}
> -
> -#define flush_tlb_mm(mm) flush_tlb_all()
> -#define flush_tlb_mm_range(mm, start, end, page_size) flush_tlb_all()
> -#endif /* !CONFIG_SMP || !CONFIG_MMU */
> -
>  #endif /* _ASM_RISCV_TLBFLUSH_H */
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 2c869f8026a8..7c6c4c858a6b 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -19,7 +19,7 @@ obj-y += context.o
>  obj-y += pmem.o
>  
>  ifeq ($(CONFIG_MMU),y)
> -obj-$(CONFIG_SMP) += tlbflush.o
> +obj-y += tlbflush.o
>  endif
>  obj-$(CONFIG_HUGETLB_PAGE) += hugetlbpage.o
>  obj-$(CONFIG_PTDUMP_CORE) += ptdump.o
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 8d12b26f5ac3..4765603fa08a 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -6,28 +6,36 @@
>  #include <linux/hugetlb.h>
>  #include <asm/sbi.h>
>  #include <asm/mmu_context.h>
> +#include <asm/tlbflush.h>
>  
> -static inline void local_flush_tlb_all_asid(unsigned long asid)
> +static unsigned long get_stride_size(struct vm_area_struct *vma)
>  {
> -	if (asid != FLUSH_TLB_NO_ASID)
> -		__asm__ __volatile__ ("sfence.vma x0, %0"
> -				:
> -				: "r" (asid)
> -				: "memory");
> -	else
> -		local_flush_tlb_all();
> -}
> +	unsigned long stride_size;
>  
> -static inline void local_flush_tlb_page_asid(unsigned long addr,
> -		unsigned long asid)
> -{
> -	if (asid != FLUSH_TLB_NO_ASID)
> -		__asm__ __volatile__ ("sfence.vma %0, %1"
> -				:
> -				: "r" (addr), "r" (asid)
> -				: "memory");
> -	else
> -		local_flush_tlb_page(addr);
> +	if (!is_vm_hugetlb_page(vma))
> +		return PAGE_SIZE;
> +
> +	stride_size = huge_page_size(hstate_vma(vma));
> +
> +	/*
> +	 * As stated in the privileged specification, every PTE in a
> +	 * NAPOT region must be invalidated, so reset the stride in that
> +	 * case.
> +	 */
> +	if (has_svnapot()) {
> +		if (stride_size >= PGDIR_SIZE)
> +			stride_size = PGDIR_SIZE;
> +		else if (stride_size >= P4D_SIZE)
> +			stride_size = P4D_SIZE;
> +		else if (stride_size >= PUD_SIZE)
> +			stride_size = PUD_SIZE;
> +		else if (stride_size >= PMD_SIZE)
> +			stride_size = PMD_SIZE;
> +		else
> +			stride_size = PAGE_SIZE;
> +	}
> +
> +	return stride_size;
>  }
>  
>  /*
> @@ -66,31 +74,12 @@ static inline void local_flush_tlb_range_asid(unsigned long start,
>  		local_flush_tlb_range_threshold_asid(start, size, stride, asid);
>  }
>  
> -void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> -{
> -	local_flush_tlb_range_asid(start, end, PAGE_SIZE, FLUSH_TLB_NO_ASID);
> -}
> -
> +#ifdef CONFIG_SMP
>  static void __ipi_flush_tlb_all(void *info)
>  {
>  	local_flush_tlb_all();
>  }
>  
> -void flush_tlb_all(void)
> -{
> -	if (riscv_use_ipi_for_rfence())
> -		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -	else
> -		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
> -}
> -
> -struct flush_tlb_range_data {
> -	unsigned long asid;
> -	unsigned long start;
> -	unsigned long size;
> -	unsigned long stride;
> -};
> -
>  static void __ipi_flush_tlb_range_asid(void *info)
>  {
>  	struct flush_tlb_range_data *d = info;
> @@ -138,10 +127,18 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
>  		put_cpu();
>  }
>  
> -static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	return static_branch_unlikely(&use_asid_allocator) ?
> -			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  addr, PAGE_SIZE, PAGE_SIZE);
> +}
> +
> +void flush_tlb_all(void)
> +{
> +	if (riscv_use_ipi_for_rfence())
> +		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> +	else
> +		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
>  }
>  
>  void flush_tlb_mm(struct mm_struct *mm)
> @@ -158,41 +155,12 @@ void flush_tlb_mm_range(struct mm_struct *mm,
>  			  start, end - start, page_size);
>  }
>  
> -void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> -{
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> -			  addr, PAGE_SIZE, PAGE_SIZE);
> -}
> -
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		     unsigned long end)
>  {
>  	unsigned long stride_size;
>  
> -	if (!is_vm_hugetlb_page(vma)) {
> -		stride_size = PAGE_SIZE;
> -	} else {
> -		stride_size = huge_page_size(hstate_vma(vma));
> -
> -		/*
> -		 * As stated in the privileged specification, every PTE in a
> -		 * NAPOT region must be invalidated, so reset the stride in that
> -		 * case.
> -		 */
> -		if (has_svnapot()) {
> -			if (stride_size >= PGDIR_SIZE)
> -				stride_size = PGDIR_SIZE;
> -			else if (stride_size >= P4D_SIZE)
> -				stride_size = P4D_SIZE;
> -			else if (stride_size >= PUD_SIZE)
> -				stride_size = PUD_SIZE;
> -			else if (stride_size >= PMD_SIZE)
> -				stride_size = PMD_SIZE;
> -			else
> -				stride_size = PAGE_SIZE;
> -		}
> -	}
> -
> +	stride_size = get_stride_size(vma);
>  	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
>  			  start, end - start, stride_size);
>  }
> @@ -203,6 +171,12 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  			  start, end - start, PAGE_SIZE);
>  }
>  
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> +			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)
> @@ -212,6 +186,77 @@ void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  }
>  #endif
>  
> +#else
> +static void __flush_tlb_range_up(struct mm_struct *mm, unsigned long start,
> +				 unsigned long size, unsigned long stride)
> +{
> +	unsigned long asid = FLUSH_TLB_NO_ASID;
> +
> +	if (mm)
> +		asid = get_mm_asid(mm);
> +
> +	local_flush_tlb_range_asid(start, size, stride, asid);
> +}
> +
> +void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
> +{
> +	local_flush_tlb_page(addr);
> +}
> +
> +void flush_tlb_all(void)
> +{
> +	local_flush_tlb_all();
> +}
> +
> +void flush_tlb_mm(struct mm_struct *mm)
> +{
> +	__flush_tlb_range_up(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
> +void flush_tlb_mm_range(struct mm_struct *mm,
> +			unsigned long start, unsigned long end,
> +			unsigned int page_size)
> +{
> +	__flush_tlb_range_up(mm, start, end - start, page_size);
> +}
> +
> +void flush_tlb_range(struct vm_area_struct *vma,
> +		unsigned long start, unsigned long end)
> +{
> +	unsigned long stride_size;
> +
> +	stride_size = get_stride_size(vma);
> +	__flush_tlb_range_up(vma->vm_mm, start, end - start, stride_size);
> +}
> +
> +/* Flush a range of kernel pages */
> +void flush_tlb_kernel_range(unsigned long start,
> +	unsigned long end)
> +{
> +	__flush_tlb_range_up(NULL, start, end - start, PAGE_SIZE);
> +}
> +
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	__flush_tlb_range_up(NULL, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
> +			unsigned long end)
> +{
> +	__flush_tlb_range_up(vma->vm_mm, start, end - start, PMD_SIZE);
> +}
> +#endif
> +
> +#endif
> +
> +void local_flush_tlb_kernel_range(unsigned long start, unsigned long end)
> +{
> +	local_flush_tlb_range_asid(start, end - start, PAGE_SIZE,
> +				   FLUSH_TLB_NO_ASID);
> +}
> +
>  bool arch_tlbbatch_should_defer(struct mm_struct *mm)
>  {
>  	return true;
> @@ -228,9 +273,3 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
>  {
>  	flush_tlb_mm(mm);
>  }
> -
> -void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> -{
> -	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> -			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> -}
> -- 
> 2.20.1
> 

