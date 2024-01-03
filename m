Return-Path: <linux-kernel+bounces-15427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C33B6822BD3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 12:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2315E1F2400A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 11:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1E818E13;
	Wed,  3 Jan 2024 11:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojFX72Sr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B9518E08
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 11:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49CB0C433C7;
	Wed,  3 Jan 2024 11:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704280237;
	bh=vLoZYtFxzJ2+K06nFXKmnrlfGz1y0ecWX2UzGR9hwI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ojFX72Sr1iuIEWNfq3+EibKDiSiBnB0uCNBpToafuraSESQqXMB+/6mIiVmfCbYMJ
	 MXgdHSsj8YdOK7mgWpGy9zLQKvERKCKJYAmEsPlTzWR0ba/BKoy6zfQY44+Hp3n7mV
	 zWPJFNAPPrPuafzz/gevLPHy9sMqcJFPqmoQpFBI5ZOm4qXmwC2VO9+VHTdxlPY8v7
	 U0Qg1BTheOHUKbHAzHtTlYMau0be/H8DUIWofJ4txtePgtJDooJLY04zGDh7lpXaTo
	 EuRrbNBl4hadcG2hE4SX9IvGcXrc5NCQjfL8eJS8lEgNZAjolL3JWsL/Rp/QjXVTHr
	 t/Pt1u9GaJWAw==
Date: Wed, 3 Jan 2024 18:57:55 +0800
From: Jisheng Zhang <jszhang@kernel.org>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
Message-ID: <ZZU9s7iHDTBD39C0@xhacker>
References: <20240102141851.105144-1-alexghiti@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240102141851.105144-1-alexghiti@rivosinc.com>

On Tue, Jan 02, 2024 at 03:18:51PM +0100, Alexandre Ghiti wrote:
> Allow to defer the flushing of the TLB when unmapping pges, which allows
> to reduce the numbers of IPI and the number of sfence.vma.
> 
> The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> batched/deferred tlb shootdown during page reclamation/migration") shows
> good performance improvement and perf reports an important decrease in
> time spent flushing the tlb (results come from qemu):

Hi Alex,

I tried this micro benchmark with your patch on T-HEAD TH1520 platform, I
didn't see any performance improvement for the micro benchmark. Per
myunderstanding, the micro benchmark is special case for arm64 because
in a normal tlb flush flow, below sequence is necessary:

tlbi
dsb


while with BATCHED_UNMAP_TLB_FLUSH, the arm64 just does 'tlbi', leaving
the dsb to the arch_tlbbatch_flush(). So the final result is

several 'tlbi + dsb' sequence VS. several 'tlbi' instructions + only one dsb
The performance improvement comes from the unnecessary dsb eliminations.

Do you have suitable benchmark(s) for BATCHED_UNMAP_TLB_FLUSH on riscv?

Thanks

> 
> Before this patch:
> 
> real	2m1.135s
> user	0m0.980s
> sys	2m0.096s
> 
> 4.83%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range
> 
> After this patch:
> 
> real	1m0.543s
> user	0m1.059s
> sys	0m59.489s
> 
> 0.14%  batch_tlb  [kernel.kallsyms]            [k] __flush_tlb_range
> 
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>  arch/riscv/Kconfig                |  1 +
>  arch/riscv/include/asm/tlbbatch.h | 15 +++++++
>  arch/riscv/include/asm/tlbflush.h | 10 +++++
>  arch/riscv/mm/tlbflush.c          | 71 ++++++++++++++++++++++---------
>  4 files changed, 77 insertions(+), 20 deletions(-)
>  create mode 100644 arch/riscv/include/asm/tlbbatch.h
> 
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 7603bd8ab333..aa07bd43b138 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -53,6 +53,7 @@ config RISCV
>  	select ARCH_USE_MEMTEST
>  	select ARCH_USE_QUEUED_RWLOCKS
>  	select ARCH_USES_CFI_TRAPS if CFI_CLANG
> +	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH if SMP && MMU
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
>  	select ARCH_WANT_GENERAL_HUGETLB if !RISCV_ISA_SVNAPOT
> diff --git a/arch/riscv/include/asm/tlbbatch.h b/arch/riscv/include/asm/tlbbatch.h
> new file mode 100644
> index 000000000000..46014f70b9da
> --- /dev/null
> +++ b/arch/riscv/include/asm/tlbbatch.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Rivos Inc.
> + */
> +
> +#ifndef _ASM_RISCV_TLBBATCH_H
> +#define _ASM_RISCV_TLBBATCH_H
> +
> +#include <linux/cpumask.h>
> +
> +struct arch_tlbflush_unmap_batch {
> +	struct cpumask cpumask;
> +};
> +
> +#endif /* _ASM_RISCV_TLBBATCH_H */
> diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> index 8f3418c5f172..f0b731ccc0c2 100644
> --- a/arch/riscv/include/asm/tlbflush.h
> +++ b/arch/riscv/include/asm/tlbflush.h
> @@ -46,6 +46,16 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end);
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end);
>  #endif
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +bool arch_tlbbatch_should_defer(struct mm_struct *mm);
> +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +			       struct mm_struct *mm,
> +			       unsigned long uaddr);
> +void arch_flush_tlb_batched_pending(struct mm_struct *mm);
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch);
> +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> +
>  #else /* CONFIG_SMP && CONFIG_MMU */
>  
>  #define flush_tlb_all() local_flush_tlb_all()
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index e6659d7368b3..bb623bca0a7d 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -93,29 +93,23 @@ static void __ipi_flush_tlb_range_asid(void *info)
>  	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>  }
>  
> -static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
> -			      unsigned long size, unsigned long stride)
> +static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +			      unsigned long start, unsigned long size,
> +			      unsigned long stride)
>  {
>  	struct flush_tlb_range_data ftd;
> -	const struct cpumask *cmask;
> -	unsigned long asid = FLUSH_TLB_NO_ASID;
>  	bool broadcast;
>  
> -	if (mm) {
> -		unsigned int cpuid;
> +	if (cpumask_empty(cmask))
> +		return;
>  
> -		cmask = mm_cpumask(mm);
> -		if (cpumask_empty(cmask))
> -			return;
> +	if (cmask != cpu_online_mask) {
> +		unsigned int cpuid;
>  
>  		cpuid = get_cpu();
>  		/* check if the tlbflush needs to be sent to other CPUs */
>  		broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> -
> -		if (static_branch_unlikely(&use_asid_allocator))
> -			asid = atomic_long_read(&mm->context.id) & asid_mask;
>  	} else {
> -		cmask = cpu_online_mask;
>  		broadcast = true;
>  	}
>  
> @@ -135,25 +129,34 @@ static void __flush_tlb_range(struct mm_struct *mm, unsigned long start,
>  		local_flush_tlb_range_asid(start, size, stride, asid);
>  	}
>  
> -	if (mm)
> +	if (cmask != cpu_online_mask)
>  		put_cpu();
>  }
>  
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +	return static_branch_unlikely(&use_asid_allocator) ?
> +			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +}
> +
>  void flush_tlb_mm(struct mm_struct *mm)
>  {
> -	__flush_tlb_range(mm, 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> +			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>  }
>  
>  void flush_tlb_mm_range(struct mm_struct *mm,
>  			unsigned long start, unsigned long end,
>  			unsigned int page_size)
>  {
> -	__flush_tlb_range(mm, start, end - start, page_size);
> +	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> +			  start, end - start, page_size);
>  }
>  
>  void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>  {
> -	__flush_tlb_range(vma->vm_mm, addr, PAGE_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  addr, PAGE_SIZE, PAGE_SIZE);
>  }
>  
>  void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
> @@ -185,18 +188,46 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  		}
>  	}
>  
> -	__flush_tlb_range(vma->vm_mm, start, end - start, stride_size);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  start, end - start, stride_size);
>  }
>  
>  void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>  {
> -	__flush_tlb_range(NULL, start, end - start, PAGE_SIZE);
> +	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +			  start, end - start, PAGE_SIZE);
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>  			unsigned long end)
>  {
> -	__flush_tlb_range(vma->vm_mm, start, end - start, PMD_SIZE);
> +	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +			  start, end - start, PMD_SIZE);
>  }
>  #endif
> +
> +#ifdef CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
> +bool arch_tlbbatch_should_defer(struct mm_struct *mm)
> +{
> +	return true;
> +}
> +
> +void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
> +			       struct mm_struct *mm,
> +			       unsigned long uaddr)
> +{
> +	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> +}
> +
> +void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> +{
> +	flush_tlb_mm(mm);
> +}
> +
> +void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
> +{
> +	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> +			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +}
> +#endif /* CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH */
> -- 
> 2.39.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

