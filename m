Return-Path: <linux-kernel+bounces-124295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC3589152B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7BA1F211F8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 08:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6274F48CCD;
	Fri, 29 Mar 2024 08:27:40 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9692F4D11D
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 08:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711700859; cv=none; b=OsrR+ToRX7FXSa3kr9IiC/iRvLih/A8Xi2GRBuoMDNpjwvG4m1820I3JTSlstRaMRuXprF1fcUt64Ri/1f5OHM3wxjqG5/x368MyNjuN6PDOIcGowIyFgNhajW2HnpP8dmjZBV83x+BkD3yQQbcq8f3J/SssnEwk14s4fgWSqDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711700859; c=relaxed/simple;
	bh=IKMizryUl6nqPup2r0ZFVCX5Sgr1Snx4M9evGSCve9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Pk1gy0j1z3J9MXjY8ZDUhcEVV/jlnCcQHWYwPBikK00hydur4LjIy+fHi7YbL6BGxhe5cNuk+lf6pJ2dtHNH2vudsdwHVDnQIz3dDg4ALAH/Goha6inja7/UJcOz1QKTDRRpU7qMGlAXUWNo2PBd3KKt3/MWQ7y5cLlFqsFwcFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0BCB71C0004;
	Fri, 29 Mar 2024 08:27:25 +0000 (UTC)
Message-ID: <8293ea8b-0a41-4bbf-8737-6fa3414af8e9@ghiti.fr>
Date: Fri, 29 Mar 2024 09:27:25 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] riscv: Call secondary mmu notifier when flushing the
 tlb
Content-Language: en-US
To: Alexandre Ghiti <alexghiti@rivosinc.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240328073838.8776-1-alexghiti@rivosinc.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240328073838.8776-1-alexghiti@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alex@ghiti.fr

Hi Palmer,

On 28/03/2024 08:38, Alexandre Ghiti wrote:
> This is required to allow the IOMMU driver to correctly flush its own
> TLB.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
>
> Changes in v2:
> - Rebase on top of 6.9-rc1
>
>   arch/riscv/mm/tlbflush.c | 39 +++++++++++++++++++++++----------------
>   1 file changed, 23 insertions(+), 16 deletions(-)
>
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 893566e004b7..854d984deb07 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -4,6 +4,7 @@
>   #include <linux/smp.h>
>   #include <linux/sched.h>
>   #include <linux/hugetlb.h>
> +#include <linux/mmu_notifier.h>
>   #include <asm/sbi.h>
>   #include <asm/mmu_context.h>
>   
> @@ -99,11 +100,19 @@ static void __ipi_flush_tlb_range_asid(void *info)
>   	local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
>   }
>   
> -static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
> +static inline unsigned long get_mm_asid(struct mm_struct *mm)
> +{
> +	return (mm && static_branch_unlikely(&use_asid_allocator)) ?
> +			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +}
> +
> +static void __flush_tlb_range(struct mm_struct *mm,
> +			      struct cpumask *cmask,
>   			      unsigned long start, unsigned long size,
>   			      unsigned long stride)
>   {
>   	struct flush_tlb_range_data ftd;
> +	unsigned long asid = get_mm_asid(mm);
>   	bool broadcast;
>   
>   	if (cpumask_empty(cmask))
> @@ -137,31 +146,26 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
>   
>   	if (cmask != cpu_online_mask)
>   		put_cpu();
> -}
>   
> -static inline unsigned long get_mm_asid(struct mm_struct *mm)
> -{
> -	return static_branch_unlikely(&use_asid_allocator) ?
> -			atomic_long_read(&mm->context.id) & asid_mask : FLUSH_TLB_NO_ASID;
> +	if (mm)
> +		mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + size);
>   }
>   
>   void flush_tlb_mm(struct mm_struct *mm)
>   {
> -	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> -			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(mm, mm_cpumask(mm), 0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>   }
>   
>   void flush_tlb_mm_range(struct mm_struct *mm,
>   			unsigned long start, unsigned long end,
>   			unsigned int page_size)
>   {
> -	__flush_tlb_range(mm_cpumask(mm), get_mm_asid(mm),
> -			  start, end - start, page_size);
> +	__flush_tlb_range(mm, mm_cpumask(mm), start, end - start, page_size);
>   }
>   
>   void flush_tlb_page(struct vm_area_struct *vma, unsigned long addr)
>   {
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>   			  addr, PAGE_SIZE, PAGE_SIZE);
>   }
>   
> @@ -194,13 +198,13 @@ void flush_tlb_range(struct vm_area_struct *vma, unsigned long start,
>   		}
>   	}
>   
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>   			  start, end - start, stride_size);
>   }
>   
>   void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   {
> -	__flush_tlb_range((struct cpumask *)cpu_online_mask, FLUSH_TLB_NO_ASID,
> +	__flush_tlb_range(NULL, (struct cpumask *)cpu_online_mask,
>   			  start, end - start, PAGE_SIZE);
>   }
>   
> @@ -208,7 +212,7 @@ void flush_tlb_kernel_range(unsigned long start, unsigned long end)
>   void flush_pmd_tlb_range(struct vm_area_struct *vma, unsigned long start,
>   			unsigned long end)
>   {
> -	__flush_tlb_range(mm_cpumask(vma->vm_mm), get_mm_asid(vma->vm_mm),
> +	__flush_tlb_range(vma->vm_mm, mm_cpumask(vma->vm_mm),
>   			  start, end - start, PMD_SIZE);
>   }
>   #endif
> @@ -222,7 +226,10 @@ void arch_tlbbatch_add_pending(struct arch_tlbflush_unmap_batch *batch,
>   			       struct mm_struct *mm,
>   			       unsigned long uaddr)
>   {
> +	unsigned long start = uaddr & PAGE_MASK;
> +
>   	cpumask_or(&batch->cpumask, &batch->cpumask, mm_cpumask(mm));
> +	mmu_notifier_arch_invalidate_secondary_tlbs(mm, start, start + PAGE_SIZE);
>   }
>   
>   void arch_flush_tlb_batched_pending(struct mm_struct *mm)
> @@ -232,7 +239,7 @@ void arch_flush_tlb_batched_pending(struct mm_struct *mm)
>   
>   void arch_tlbbatch_flush(struct arch_tlbflush_unmap_batch *batch)
>   {
> -	__flush_tlb_range(&batch->cpumask, FLUSH_TLB_NO_ASID, 0,
> -			  FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
> +	__flush_tlb_range(NULL, &batch->cpumask,
> +			  0, FLUSH_TLB_MAX_SIZE, PAGE_SIZE);
>   	cpumask_clear(&batch->cpumask);
>   }


This will conflict with Samuel's patch 
https://lore.kernel.org/all/20240301201837.2826172-1-samuel.holland@sifive.com/ 
<https://lore.kernel.org/all/20240301201837.2826172-1-samuel.holland@sifive.com/>

Here is the resolution conflict if you pull this patch as-is, otherwise 
I'll send a v3:

diff --cc arch/riscv/mm/tlbflush.c
index 07d743f87b3f,854d984deb07..000000000000
--- a/arch/riscv/mm/tlbflush.c
+++ b/arch/riscv/mm/tlbflush.c
@@@ -99,7 -100,14 +100,14 @@@ static void __ipi_flush_tlb_range_asid(
         local_flush_tlb_range_asid(d->start, d->size, d->stride, d->asid);
   }

- static void __flush_tlb_range(const struct cpumask *cmask, unsigned 
long asid,
+ static inline unsigned long get_mm_asid(struct mm_struct *mm)
+ {
+       return (mm && static_branch_unlikely(&use_asid_allocator)) ?
+                       atomic_long_read(&mm->context.id) & asid_mask : 
FLUSH_TLB_NO_ASID;
+ }
+
+ static void __flush_tlb_range(struct mm_struct *mm,
  -                            struct cpumask *cmask,
++                            const struct cpumask *cmask,
                               unsigned long start, unsigned long size,
                               unsigned long stride)
   {
@@@ -200,7 -204,7 +204,7 @@@ void flush_tlb_range(struct vm_area_str

   void flush_tlb_kernel_range(unsigned long start, unsigned long end)
   {
-       __flush_tlb_range(cpu_online_mask, FLUSH_TLB_NO_ASID,
  -      __flush_tlb_range(NULL, (struct cpumask *)cpu_online_mask,
++      __flush_tlb_range(NULL, cpu_online_mask,
                           start, end - start, PAGE_SIZE);
   }

Thanks,

Alex


