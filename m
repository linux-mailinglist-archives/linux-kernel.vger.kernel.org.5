Return-Path: <linux-kernel+bounces-131058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05B5898293
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 09:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8E73B2207D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 07:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F595D461;
	Thu,  4 Apr 2024 07:56:26 +0000 (UTC)
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09145970
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712217385; cv=none; b=jDEV74+yveFnrK8do6Tn+O/tBNxvVY21uEdXY0Fjvbv8mVpKyifVV8ucih/hZsuj2Zqgby24GZI39VwjR4BYyncqN/kce22EulcJitH7AKz06YRXFHcWd5otg0SHBUG67MaL6xr/A4RS8sbTcAOmUSk+KhzXnKXU6t4j845aopM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712217385; c=relaxed/simple;
	bh=1OEOur1SKjxHVLPsT6hyA70/hJ0Mb20v/LbXlbCP4qQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cVQYFAk47+3AwFTgcEELKQlVCOr6QOE2VkuLcxrRV1wxmFPLaMfJRziFTfK9AQF+QGfimiur3evQEZZFcPzmz//7Leo81BFrQpcLTf7rUEJvN/KUi42ZyRGqgQMObAe1MwGElXkVHSHPYERzy1P1A9oZPCfyxu1xRxc2HsOytP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr; spf=pass smtp.mailfrom=ghiti.fr; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id 35CCF40005;
	Thu,  4 Apr 2024 07:56:18 +0000 (UTC)
Message-ID: <fb25f8bb-2f79-49ea-a06d-aecb11df0573@ghiti.fr>
Date: Thu, 4 Apr 2024 09:56:17 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 03/13] riscv: Use IPIs for remote cache/TLB flushes by
 default
Content-Language: en-US
To: Samuel Holland <samuel.holland@sifive.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, linux-riscv@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang
 <jszhang@kernel.org>, Yunhui Cui <cuiyunhui@bytedance.com>,
 Anup Patel <anup@brainfault.org>
References: <20240327045035.368512-1-samuel.holland@sifive.com>
 <20240327045035.368512-4-samuel.holland@sifive.com>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20240327045035.368512-4-samuel.holland@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr


On 27/03/2024 05:49, Samuel Holland wrote:
> An IPI backend is always required in an SMP configuration, but an SBI
> implementation is not. For example, SBI will be unavailable when the
> kernel runs in M mode. For this reason, consider IPI delivery of cache
> and TLB flushes to be the base case, and any other implementation (such
> as the SBI remote fence extension) to be an optimization.
>
> Generally, if IPIs can be delivered without firmware assistance, they
> are assumed to be faster than SBI calls due to the SBI context switch
> overhead. However, when SBI is used as the IPI backend, then the context
> switch cost must be paid anyway, and performing the cache/TLB flush
> directly in the SBI implementation is more efficient than injecting an
> interrupt to S-mode. This is the only existing scenario where
> riscv_ipi_set_virq_range() is called with use_for_rfence set to false.
>
> sbi_ipi_init() already checks riscv_ipi_have_virq_range(), so it only
> calls riscv_ipi_set_virq_range() when no other IPI device is available.
> This allows moving the static key and dropping the use_for_rfence
> parameter. This decouples the static key from the irqchip driver probe
> order.
>
> Furthermore, the static branch only makes sense when CONFIG_RISCV_SBI is
> enabled. Optherwise, IPIs must be used. Add a fallback definition of
> riscv_use_sbi_for_rfence() which handles this case and removes the need
> to check CONFIG_RISCV_SBI elsewhere, such as in cacheflush.c.
>
> Reviewed-by: Anup Patel <anup@brainfault.org>
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>
> Changes in v6:
>   - Clarify the commit message for patch 3 based on ML discussion
>
> Changes in v5:
>   - Also switch to riscv_use_sbi_for_rfence() in asm/pgalloc.h
>
> Changes in v4:
>   - New patch for v4
>
>   arch/riscv/include/asm/pgalloc.h  |  7 ++++---
>   arch/riscv/include/asm/sbi.h      |  4 ++++
>   arch/riscv/include/asm/smp.h      | 15 ++-------------
>   arch/riscv/kernel/sbi-ipi.c       | 11 ++++++++++-
>   arch/riscv/kernel/smp.c           | 11 +----------
>   arch/riscv/mm/cacheflush.c        |  5 ++---
>   arch/riscv/mm/tlbflush.c          | 31 ++++++++++++++-----------------
>   drivers/clocksource/timer-clint.c |  2 +-
>   8 files changed, 38 insertions(+), 48 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index b34587da8882..f52264304f77 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -8,6 +8,7 @@
>   #define _ASM_RISCV_PGALLOC_H
>   
>   #include <linux/mm.h>
> +#include <asm/sbi.h>
>   #include <asm/tlb.h>
>   
>   #ifdef CONFIG_MMU
> @@ -17,10 +18,10 @@
>   
>   static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
>   {
> -	if (riscv_use_ipi_for_rfence())
> -		tlb_remove_page_ptdesc(tlb, pt);
> -	else
> +	if (riscv_use_sbi_for_rfence())
>   		tlb_remove_ptdesc(tlb, pt);
> +	else
> +		tlb_remove_page_ptdesc(tlb, pt);
>   }
>   
>   static inline void pmd_populate_kernel(struct mm_struct *mm,
> diff --git a/arch/riscv/include/asm/sbi.h b/arch/riscv/include/asm/sbi.h
> index 6e68f8dff76b..ea84392ca9d7 100644
> --- a/arch/riscv/include/asm/sbi.h
> +++ b/arch/riscv/include/asm/sbi.h
> @@ -375,8 +375,12 @@ unsigned long riscv_cached_marchid(unsigned int cpu_id);
>   unsigned long riscv_cached_mimpid(unsigned int cpu_id);
>   
>   #if IS_ENABLED(CONFIG_SMP) && IS_ENABLED(CONFIG_RISCV_SBI)
> +DECLARE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +#define riscv_use_sbi_for_rfence() \
> +	static_branch_unlikely(&riscv_sbi_for_rfence)
>   void sbi_ipi_init(void);
>   #else
> +static inline bool riscv_use_sbi_for_rfence(void) { return false; }
>   static inline void sbi_ipi_init(void) { }
>   #endif
>   
> diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
> index 0d555847cde6..7ac80e9f2288 100644
> --- a/arch/riscv/include/asm/smp.h
> +++ b/arch/riscv/include/asm/smp.h
> @@ -49,12 +49,7 @@ void riscv_ipi_disable(void);
>   bool riscv_ipi_have_virq_range(void);
>   
>   /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence);
> -
> -/* Check if we can use IPIs for remote FENCEs */
> -DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -#define riscv_use_ipi_for_rfence() \
> -	static_branch_unlikely(&riscv_ipi_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr);
>   
>   /* Check other CPUs stop or not */
>   bool smp_crash_stop_failed(void);
> @@ -104,16 +99,10 @@ static inline bool riscv_ipi_have_virq_range(void)
>   	return false;
>   }
>   
> -static inline void riscv_ipi_set_virq_range(int virq, int nr,
> -					    bool use_for_rfence)
> +static inline void riscv_ipi_set_virq_range(int virq, int nr)
>   {
>   }
>   
> -static inline bool riscv_use_ipi_for_rfence(void)
> -{
> -	return false;
> -}
> -
>   #endif /* CONFIG_SMP */
>   
>   #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
> diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
> index a4559695ce62..1026e22955cc 100644
> --- a/arch/riscv/kernel/sbi-ipi.c
> +++ b/arch/riscv/kernel/sbi-ipi.c
> @@ -13,6 +13,9 @@
>   #include <linux/irqdomain.h>
>   #include <asm/sbi.h>
>   
> +DEFINE_STATIC_KEY_FALSE(riscv_sbi_for_rfence);
> +EXPORT_SYMBOL_GPL(riscv_sbi_for_rfence);
> +
>   static int sbi_ipi_virq;
>   
>   static void sbi_ipi_handle(struct irq_desc *desc)
> @@ -72,6 +75,12 @@ void __init sbi_ipi_init(void)
>   			  "irqchip/sbi-ipi:starting",
>   			  sbi_ipi_starting_cpu, NULL);
>   
> -	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE, false);
> +	riscv_ipi_set_virq_range(virq, BITS_PER_BYTE);
>   	pr_info("providing IPIs using SBI IPI extension\n");
> +
> +	/*
> +	 * Use the SBI remote fence extension to avoid
> +	 * the extra context switch needed to handle IPIs.
> +	 */
> +	static_branch_enable(&riscv_sbi_for_rfence);
>   }
> diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
> index 45dd4035416e..8e6eb64459af 100644
> --- a/arch/riscv/kernel/smp.c
> +++ b/arch/riscv/kernel/smp.c
> @@ -171,10 +171,7 @@ bool riscv_ipi_have_virq_range(void)
>   	return (ipi_virq_base) ? true : false;
>   }
>   
> -DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
> -EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
> -
> -void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
> +void riscv_ipi_set_virq_range(int virq, int nr)
>   {
>   	int i, err;
>   
> @@ -197,12 +194,6 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
>   
>   	/* Enabled IPIs for boot CPU immediately */
>   	riscv_ipi_enable();
> -
> -	/* Update RFENCE static key */
> -	if (use_for_rfence)
> -		static_branch_enable(&riscv_ipi_for_rfence);
> -	else
> -		static_branch_disable(&riscv_ipi_for_rfence);
>   }
>   
>   static const char * const ipi_names[] = {
> diff --git a/arch/riscv/mm/cacheflush.c b/arch/riscv/mm/cacheflush.c
> index bc61ee5975e4..d76fc73e594b 100644
> --- a/arch/riscv/mm/cacheflush.c
> +++ b/arch/riscv/mm/cacheflush.c
> @@ -21,7 +21,7 @@ void flush_icache_all(void)
>   {
>   	local_flush_icache_all();
>   
> -	if (IS_ENABLED(CONFIG_RISCV_SBI) && !riscv_use_ipi_for_rfence())
> +	if (riscv_use_sbi_for_rfence())
>   		sbi_remote_fence_i(NULL);
>   	else
>   		on_each_cpu(ipi_remote_fence_i, NULL, 1);
> @@ -69,8 +69,7 @@ void flush_icache_mm(struct mm_struct *mm, bool local)
>   		 * with flush_icache_deferred().
>   		 */
>   		smp_mb();
> -	} else if (IS_ENABLED(CONFIG_RISCV_SBI) &&
> -		   !riscv_use_ipi_for_rfence()) {
> +	} else if (riscv_use_sbi_for_rfence()) {
>   		sbi_remote_fence_i(&others);
>   	} else {
>   		on_each_cpu_mask(&others, ipi_remote_fence_i, NULL, 1);
> diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> index 893566e004b7..0435605b07d0 100644
> --- a/arch/riscv/mm/tlbflush.c
> +++ b/arch/riscv/mm/tlbflush.c
> @@ -79,10 +79,10 @@ static void __ipi_flush_tlb_all(void *info)
>   
>   void flush_tlb_all(void)
>   {
> -	if (riscv_use_ipi_for_rfence())
> -		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
> -	else
> +	if (riscv_use_sbi_for_rfence())
>   		sbi_remote_sfence_vma_asid(NULL, 0, FLUSH_TLB_MAX_SIZE, FLUSH_TLB_NO_ASID);
> +	else
> +		on_each_cpu(__ipi_flush_tlb_all, NULL, 1);
>   }
>   
>   struct flush_tlb_range_data {
> @@ -103,7 +103,6 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
>   			      unsigned long start, unsigned long size,
>   			      unsigned long stride)
>   {
> -	struct flush_tlb_range_data ftd;
>   	bool broadcast;
>   
>   	if (cpumask_empty(cmask))
> @@ -119,20 +118,18 @@ static void __flush_tlb_range(struct cpumask *cmask, unsigned long asid,
>   		broadcast = true;
>   	}
>   
> -	if (broadcast) {
> -		if (riscv_use_ipi_for_rfence()) {
> -			ftd.asid = asid;
> -			ftd.start = start;
> -			ftd.size = size;
> -			ftd.stride = stride;
> -			on_each_cpu_mask(cmask,
> -					 __ipi_flush_tlb_range_asid,
> -					 &ftd, 1);
> -		} else
> -			sbi_remote_sfence_vma_asid(cmask,
> -						   start, size, asid);
> -	} else {
> +	if (!broadcast) {
>   		local_flush_tlb_range_asid(start, size, stride, asid);
> +	} else if (riscv_use_sbi_for_rfence()) {
> +		sbi_remote_sfence_vma_asid(cmask, start, size, asid);
> +	} else {
> +		struct flush_tlb_range_data ftd;
> +
> +		ftd.asid = asid;
> +		ftd.start = start;
> +		ftd.size = size;
> +		ftd.stride = stride;
> +		on_each_cpu_mask(cmask, __ipi_flush_tlb_range_asid, &ftd, 1);
>   	}
>   
>   	if (cmask != cpu_online_mask)
> diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
> index 09fd292eb83d..0bdd9d7ec545 100644
> --- a/drivers/clocksource/timer-clint.c
> +++ b/drivers/clocksource/timer-clint.c
> @@ -251,7 +251,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
>   	}
>   
>   	irq_set_chained_handler(clint_ipi_irq, clint_ipi_interrupt);
> -	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE, true);
> +	riscv_ipi_set_virq_range(rc, BITS_PER_BYTE);
>   	clint_clear_ipi();
>   #endif
>   


Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>


