Return-Path: <linux-kernel+bounces-64007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D323B8538EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 18:48:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 496B01F24115
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 17:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76A2604CC;
	Tue, 13 Feb 2024 17:48:40 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADF1604C0
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 17:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707846520; cv=none; b=NAL0dtS1Z9GAxKLLYTj88JP4MR8ILPRP2nvnaHOkKJyJ52xidE8wbCsnudgNWbZr9fKvwN8vkOxaaA+FrOAEvHiskwRNQP3f2fCIhkV3cfhELRDj4FeXvJrm0hV/ZhHyDfFpBTOOVXpT0emrojk43wiYbKehOjUbwzZTkTqzK08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707846520; c=relaxed/simple;
	bh=7ewTIC+OiMjtPxuyV7/Lbf12q8otsaPeyAGiT0v6Wxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyHkB9+oH3sagtMyaZNkO4XzvCBvxcoG9htRGpOdPYB7GRik5cSX6vRlzbEv5IgXA5eB2w9KQftPRvUdKr64pV25z4oEC5eqvYuaPTe9Hy/+5cpjNBWGvW7lzOSujm4dazdsZ595zFkxYtV5YyVO3nBhhNaSeAb8Rq0OwO3ETBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E3311FB;
	Tue, 13 Feb 2024 09:49:17 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.36.130])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E06323F766;
	Tue, 13 Feb 2024 09:48:32 -0800 (PST)
Date: Tue, 13 Feb 2024 17:48:30 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Maxwell Bland <mbland@motorola.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, catalin.marinas@arm.com, will@kernel.org,
	dennis@kernel.org, tj@kernel.org, cl@linux.com,
	akpm@linux-foundation.org, shikemeng@huaweicloud.com,
	david@redhat.com, rppt@kernel.org, anshuman.khandual@arm.com,
	willy@infradead.org, ryan.roberts@arm.com,
	rick.p.edgecombe@intel.com, pcc@google.com,
	rmk+kernel@armlinux.org.uk, tglx@linutronix.de, gshan@redhat.com,
	gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
	james.morse@arm.com, awheeler@motorola.com
Subject: Re: [PATCH] arm64: allow post-init vmalloc PXNTable
Message-ID: <ZcurbvkUR-BoGTxu@FVFF77S0Q05N.cambridge.arm.com>
References: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP5Mv+ydhk=Ob4b40ZahGMgT-5+-VEHxtmA=-LkJiEOOU+K6hw@mail.gmail.com>

On Tue, Feb 13, 2024 at 10:05:45AM -0600, Maxwell Bland wrote:
> Apologies if this is a duplicate mail, it will be the last one. Moto's SMTP
> server sucks!!
> 
> Ensures that PXNTable can be set on all table descriptors allocated
> through vmalloc. Normally, PXNTable is set only during initial memory
> mapping and does not apply thereafter, making it possible for attackers
> to target post-init allocated writable PTEs as a staging region for
> injection of their code into the kernel. Presently it is not possible to
> efficiently prevent these attacks as VMALLOC_END overlaps with _text,
> e.g.:
> 
> VMALLOC_START ffff800080000000 VMALLOC_END fffffbfff0000000
> _text         ffffb6c0c1400000 _end        ffffb6c0c3e40000
> 
> Setting VMALLOC_END to _text in init would resolve this issue with the
> caveat of a sizeable reduction in the size of available vmalloc memory
> due to requirements on aslr randomness. However, there are circumstances
> where this trade-off is necessary: in particular, hypervisor-level
> security monitors where 1) the microarchitecture contains race
> conditions on PTE level updates or 2) a per-PTE update verifier comes at
> a significant hit to performance.

Which "hypervisor-level security monitors" are you referring to? We don't
support any of those upstream AFAIK.

How much VA space are you potentially throwing away?

How does this work with other allocations of executable memory? e.g. modules,
BPF?

I'm not keen on this as-is.

Mark.

> Because the address of _text is aslr-sensitive and this patch associates
> this value with VMALLOC_END, we remove the use of VMALLOC_END in a print
> statement in mm/percpu.c. However, only the format string is updated in
> crash_core.c, since we are dead at that point regardless. VMALLOC_END is
> updated in kernel/setup.c to associate the feature closely with aslr and
> region allocation code.
> 
> Signed-off-by: Maxwell Bland <mbland@motorola.com>
> ---
>  arch/arm64/Kconfig                   | 13 +++++++++++++
>  arch/arm64/include/asm/pgtable.h     |  6 ++++++
>  arch/arm64/include/asm/vmalloc-pxn.h | 10 ++++++++++
>  arch/arm64/kernel/crash_core.c       |  2 +-
>  arch/arm64/kernel/setup.c            |  9 +++++++++
>  mm/percpu.c                          |  4 ++--
>  6 files changed, 41 insertions(+), 3 deletions(-)
>  create mode 100644 arch/arm64/include/asm/vmalloc-pxn.h
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index aa7c1d435139..5f1e75d70e14 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -2165,6 +2165,19 @@ config ARM64_DEBUG_PRIORITY_MASKING
>     If unsure, say N
>  endif # ARM64_PSEUDO_NMI
> 
> +config ARM64_VMALLOC_PXN
> + bool "Ensures table descriptors pointing to kernel data are PXNTable"
> + help
> +   Reduces the range of the kernel data vmalloc region to remove any
> +   overlap with kernel code, making it possible to enable the PXNTable
> +   bit on table descriptors allocated after the kernel's initial memory
> +   mapping.
> +
> +   This increases the performance of security monitors which protect
> +   against malicious updates to page table entries.
> +
> +   If unsure, say N.
> +
>  config RELOCATABLE
>   bool "Build a relocatable kernel image" if EXPERT
>   select ARCH_HAS_RELR
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 79ce70fbb751..49f64ea77c81 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -22,7 +22,9 @@
>   * and fixed mappings
>   */
>  #define VMALLOC_START (MODULES_END)
> +#ifndef CONFIG_ARM64_VMALLOC_PXN
>  #define VMALLOC_END (VMEMMAP_START - SZ_256M)
> +#endif
> 
>  #define vmemmap ((struct page *)VMEMMAP_START - (memstart_addr >> PAGE_SHIFT))
> 
> @@ -35,6 +37,10 @@
>  #include <linux/sched.h>
>  #include <linux/page_table_check.h>
> 
> +#ifdef CONFIG_ARM64_VMALLOC_PXN
> +#include <asm/vmalloc-pxn.h>
> +#endif
> +
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> 
> diff --git a/arch/arm64/include/asm/vmalloc-pxn.h
> b/arch/arm64/include/asm/vmalloc-pxn.h
> new file mode 100644
> index 000000000000..c8c4f878eb62
> --- /dev/null
> +++ b/arch/arm64/include/asm/vmalloc-pxn.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_ARM64_VMALLOC_PXN_H
> +#define _ASM_ARM64_VMALLOC_PXN_H
> +
> +#ifdef CONFIG_ARM64_VMALLOC_PXN
> +extern u64 __vmalloc_end __ro_after_init;
> +#define VMALLOC_END (__vmalloc_end)
> +#endif /* CONFIG_ARM64_VMALLOC_PXN */
> +
> +#endif /* _ASM_ARM64_VMALLOC_PXN_H */
> diff --git a/arch/arm64/kernel/crash_core.c b/arch/arm64/kernel/crash_core.c
> index 66cde752cd74..39dccae11a40 100644
> --- a/arch/arm64/kernel/crash_core.c
> +++ b/arch/arm64/kernel/crash_core.c
> @@ -24,7 +24,7 @@ void arch_crash_save_vmcoreinfo(void)
>   vmcoreinfo_append_str("NUMBER(MODULES_VADDR)=0x%lx\n", MODULES_VADDR);
>   vmcoreinfo_append_str("NUMBER(MODULES_END)=0x%lx\n", MODULES_END);
>   vmcoreinfo_append_str("NUMBER(VMALLOC_START)=0x%lx\n", VMALLOC_START);
> - vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%lx\n", VMALLOC_END);
> + vmcoreinfo_append_str("NUMBER(VMALLOC_END)=0x%llx\n", VMALLOC_END);
>   vmcoreinfo_append_str("NUMBER(VMEMMAP_START)=0x%lx\n", VMEMMAP_START);
>   vmcoreinfo_append_str("NUMBER(VMEMMAP_END)=0x%lx\n", VMEMMAP_END);
>   vmcoreinfo_append_str("NUMBER(kimage_voffset)=0x%llx\n",
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 42c690bb2d60..b7ccee672743 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -54,6 +54,11 @@
>  #include <asm/xen/hypervisor.h>
>  #include <asm/mmu_context.h>
> 
> +#ifdef CONFIG_ARM64_VMALLOC_PXN
> +u64 __vmalloc_end __ro_after_init = VMEMMAP_START - SZ_256M;
> +EXPORT_SYMBOL(__vmalloc_end);
> +#endif /* CONFIG_ARM64_VMALLOC_PXN */
> +
>  static int num_standard_resources;
>  static struct resource *standard_resources;
> 
> @@ -298,6 +303,10 @@ void __init __no_sanitize_address setup_arch(char
> **cmdline_p)
> 
>   kaslr_init();
> 
> +#ifdef CONFIG_ARM64_VMALLOC_PXN
> + __vmalloc_end = ALIGN_DOWN((u64) _text, PMD_SIZE);
> +#endif
> +
>   /*
>   * If know now we are going to need KPTI then use non-global
>   * mappings from the start, avoiding the cost of rewriting
> diff --git a/mm/percpu.c b/mm/percpu.c
> index 4e11fc1e6def..a902500ebfa0 100644
> --- a/mm/percpu.c
> +++ b/mm/percpu.c
> @@ -3128,8 +3128,8 @@ int __init pcpu_embed_first_chunk(size_t
> reserved_size, size_t dyn_size,
> 
>   /* warn if maximum distance is further than 75% of vmalloc space */
>   if (max_distance > VMALLOC_TOTAL * 3 / 4) {
> - pr_warn("max_distance=0x%lx too large for vmalloc space 0x%lx\n",
> - max_distance, VMALLOC_TOTAL);
> + pr_warn("max_distance=0x%lx too large for vmalloc space\n",
> + max_distance);
>  #ifdef CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK
>   /* and fail if we have fallback */
>   rc = -EINVAL;
> 
> base-commit: 716f4aaa7b48a55c73d632d0657b35342b1fefd7
> -- 
> 2.39.0

