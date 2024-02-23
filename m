Return-Path: <linux-kernel+bounces-77619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4F6860824
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 02:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC2E61F22C74
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 01:16:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534E49470;
	Fri, 23 Feb 2024 01:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="glBwmgDH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32811847E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 01:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708650973; cv=none; b=Y606k0uiDLUZ7xz7UMYUPGC6lihyy2pL3w9soZU0ltpoNHGP6ddFhwe6e08m574UfBrzjSdSDkH2S6uY5ubXPiDcPli16a95Vt6JdaOWE6n0upYnboXwSl/0KTBk06VtMWYK3XVmXRHnX8uJLzzjAgdMP79p8VUkEh5Npwyqfu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708650973; c=relaxed/simple;
	bh=bt0v5yeGHnD4YYUl0ZoLlEH5P5CVzY1MYew/SO2Ese0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=I7WtydniFUtrzHic4cqj6GPcFLX323eY1KXLDWjtnE5+eECXnxm0PNDggJ0SaB9n40zGOBOzMQ2YMyhPzbILMfW0U98rdwdx8pJ4SW5Ohne6QkgroMTfK7Vd8FDactsEXzqQOPPjGzF1l7vgLRqZEXGk0Le5J5UctR9IsLuzEqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=glBwmgDH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D81F6C433C7;
	Fri, 23 Feb 2024 01:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708650972;
	bh=bt0v5yeGHnD4YYUl0ZoLlEH5P5CVzY1MYew/SO2Ese0=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=glBwmgDH1ptQVJ4b0DpxjYfcyEXDrD7YlmTYcmiliqnUHiPOkfEqi/vv/iobUoqcC
	 pBELv3sz4jxMjv0VGzP5fU12dzptwCKlXpWQAbLvrNpzbuKNlVKUzwH4/sIhbtOjIL
	 ZPpnlR9D+Owg82HbufKpIfUuVdoxWH2+uJnuTjQ5vsRXYufwjWluxjq/HVyD3fWt/N
	 DmuHSkE0lFvXyyk3l9qFNBFTs4PA3hPoUR6jJ8Vkq4qoYPogk1r2Lt+MISUjp6m+wD
	 UisZaeGQcVq57Ti3lt9aqu+s5CVQL0QaZxZPDahQToIObQWKSfP+7uzeJmiEGQw7zA
	 agxHTPjf1HzQQ==
Date: Thu, 22 Feb 2024 17:16:09 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: Roger Pau Monne <roger.pau@citrix.com>
cc: xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>, 
    Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RFC] x86/xen: attempt to inflate the memory balloon on
 PVH
In-Reply-To: <20240220174341.56131-1-roger.pau@citrix.com>
Message-ID: <alpine.DEB.2.22.394.2402221701190.754277@ubuntu-linux-20-04-desktop>
References: <20240220174341.56131-1-roger.pau@citrix.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1734207608-1708650207=:754277"
Content-ID: <alpine.DEB.2.22.394.2402221703300.754277@ubuntu-linux-20-04-desktop>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1734207608-1708650207=:754277
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.2.22.394.2402221703301.754277@ubuntu-linux-20-04-desktop>

On Tue, 20 Feb 2024, Roger Pau Monne wrote:
> When running as PVH or HVM Linux will use holes in the memory map as scratch
> space to map grants, foreign domain pages and possibly miscellaneous other
> stuff.  However the usage of such memory map holes for Xen purposes can be
> problematic.  The request of holesby Xen happen quite early in the kernel boot
> process (grant table setup already uses scratch map space), and it's possible
> that by then not all devices have reclaimed their MMIO space.  It's not
> unlikely for chunks of Xen scratch map space to end up using PCI bridge MMIO
> window memory, which (as expected) causes quite a lot of issues in the system.

Am I understanding correctly that XEN_BALLOON_MEMORY_HOTPLUG doesn't
help because it becomes available too late in the PVH boot sequence? 



> At least for PVH dom0 we have the possibility of using regions marked as
> UNUSABLE in the e820 memory map.  Either if the region is UNUSABLE in the
> native memory map, or it has been converted into UNUSABLE in order to hide RAM
> regions from dom0, the second stage translation page-tables can populate those
> areas without issues.
> 
> PV already has this kind of logic, where the balloon driver is inflated at
> boot.  Re-use the current logic in order to also inflate it when running as
> PVH.  onvert UNUSABLE regions up to the ratio specified in EXTRA_MEM_RATIO to
> RAM, while reserving them using xen_add_extra_mem() (which is also moved so
> it's no longer tied to CONFIG_PV).
> 
> Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> ---
> RFC reasons:
> 
>  * Note that it would be preferred for the hypervisor to provide an explicit
>    range to be used as scratch mapping space, but that requires changes to Xen,
>    and it's not fully clear whether Xen can figure out the position of all MMIO
>    regions at boot in order to suggest a scratch mapping region for dom0.
> 
>  * Should the whole set of xen_{add,del,chk,inv}_extra_mem() functions be moved
>    to a different file?  For the purposes of PVH only xen_add_extra_mem() is
>    moved and the chk and inv ones are PV specific and might not want moving to
>    a separate file just to guard them with CONFIG_PV.
> ---
>  arch/x86/include/asm/xen/hypervisor.h |  1 +
>  arch/x86/platform/pvh/enlighten.c     |  3 ++
>  arch/x86/xen/enlighten.c              | 32 +++++++++++++
>  arch/x86/xen/enlighten_pvh.c          | 68 +++++++++++++++++++++++++++
>  arch/x86/xen/setup.c                  | 44 -----------------
>  arch/x86/xen/xen-ops.h                | 14 ++++++
>  drivers/xen/balloon.c                 |  2 -
>  7 files changed, 118 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> index a9088250770f..31e2bf8d5db7 100644
> --- a/arch/x86/include/asm/xen/hypervisor.h
> +++ b/arch/x86/include/asm/xen/hypervisor.h
> @@ -62,6 +62,7 @@ void xen_arch_unregister_cpu(int num);
>  #ifdef CONFIG_PVH
>  void __init xen_pvh_init(struct boot_params *boot_params);
>  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> +void __init xen_reserve_extra_memory(struct boot_params *bootp);
>  #endif
>  
>  /* Lazy mode for batching updates / context switch */
> diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
> index 00a92cb2c814..a12117f3d4de 100644
> --- a/arch/x86/platform/pvh/enlighten.c
> +++ b/arch/x86/platform/pvh/enlighten.c
> @@ -74,6 +74,9 @@ static void __init init_pvh_bootparams(bool xen_guest)
>  	} else
>  		xen_raw_printk("Warning: Can fit ISA range into e820\n");
>  
> +	if (xen_guest)
> +		xen_reserve_extra_memory(&pvh_bootparams);
> +
>  	pvh_bootparams.hdr.cmd_line_ptr =
>  		pvh_start_info.cmdline_paddr;
>  
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 3c61bb98c10e..a01ca255b0c6 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -6,6 +6,7 @@
>  #include <linux/console.h>
>  #include <linux/cpu.h>
>  #include <linux/kexec.h>
> +#include <linux/memblock.h>
>  #include <linux/slab.h>
>  #include <linux/panic_notifier.h>
>  
> @@ -350,3 +351,34 @@ void xen_arch_unregister_cpu(int num)
>  }
>  EXPORT_SYMBOL(xen_arch_unregister_cpu);
>  #endif
> +
> +/* Amount of extra memory space we add to the e820 ranges */
> +struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
> +
> +void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
> +{
> +	unsigned int i;
> +
> +	/*
> +	 * No need to check for zero size, should happen rarely and will only
> +	 * write a new entry regarded to be unused due to zero size.
> +	 */
> +	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
> +		/* Add new region. */
> +		if (xen_extra_mem[i].n_pfns == 0) {
> +			xen_extra_mem[i].start_pfn = start_pfn;
> +			xen_extra_mem[i].n_pfns = n_pfns;
> +			break;
> +		}
> +		/* Append to existing region. */
> +		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
> +		    start_pfn) {
> +			xen_extra_mem[i].n_pfns += n_pfns;
> +			break;
> +		}
> +	}
> +	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
> +		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
> +
> +	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
> +}
> diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> index ada3868c02c2..c28f073c1df5 100644
> --- a/arch/x86/xen/enlighten_pvh.c
> +++ b/arch/x86/xen/enlighten_pvh.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/acpi.h>
>  #include <linux/export.h>
> +#include <linux/mm.h>
>  
>  #include <xen/hvc-console.h>
>  
> @@ -72,3 +73,70 @@ void __init mem_map_via_hcall(struct boot_params *boot_params_p)
>  	}
>  	boot_params_p->e820_entries = memmap.nr_entries;
>  }
> +
> +/*
> + * Reserve e820 UNUSABLE regions to inflate the memory balloon.
> + *
> + * On PVH dom0 the host memory map is used, RAM regions available to dom0 are
> + * located as the same place as in the native memory map, but since dom0 gets
> + * less memory than the total amount of host RAM the ranges that can't be
> + * populated are converted from RAM -> UNUSABLE.  Use such regions (up to the
> + * ratio signaled in EXTRA_MEM_RATIO) in order to inflate the balloon driver at
> + * boot.  Doing so prevents the guest (even if just temporary) from using holes
> + * in the memory map in order to map grants or foreign addresses, and
> + * hopefully limits the risk of a clash with a device MMIO region.  Ideally the
> + * hypervisor should notify us which memory ranges are suitable for creating
> + * foreign mappings, but that's not yet implemented.
> + */
> +void __init xen_reserve_extra_memory(struct boot_params *bootp)
> +{
> +	unsigned int i, ram_pages = 0, extra_pages;
> +
> +	for (i = 0; i < bootp->e820_entries; i++) {
> +		struct boot_e820_entry *e = &bootp->e820_table[i];
> +
> +		if (e->type != E820_TYPE_RAM)
> +			continue;
> +		ram_pages += PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr);
> +	}
> +
> +	/* Max amount of extra memory. */
> +	extra_pages = EXTRA_MEM_RATIO * ram_pages;
> +
> +	/*
> +	 * Convert UNUSABLE ranges to RAM and reserve them for foreign mapping
> +	 * purposes.
> +	 */
> +	for (i = 0; i < bootp->e820_entries && extra_pages; i++) {
> +		struct boot_e820_entry *e = &bootp->e820_table[i];
> +		unsigned long pages;
> +
> +		if (e->type != E820_TYPE_UNUSABLE)
> +			continue;
> +
> +		pages = min(extra_pages,
> +			PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr));
> +
> +		if (pages != (PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr))) {
> +			struct boot_e820_entry *next;
> +
> +			if (bootp->e820_entries ==
> +			    ARRAY_SIZE(bootp->e820_table))
> +				/* No space left to split - skip region. */
> +				continue;
> +
> +			/* Split entry. */
> +			next = e + 1;
> +			memmove(next, e,
> +				(bootp->e820_entries - i) * sizeof(*e));
> +			bootp->e820_entries++;
> +			next->addr = PAGE_ALIGN(e->addr) + PFN_PHYS(pages);
> +			e->size = next->addr - e->addr;
> +			next->size -= e->size;

Is this really worth doing? Can we just skip this range and continue or
simply break out and call it a day? Or even add the whole range instead?

The reason I am asking is that I am expecting E820_TYPE_UNUSABLE regions
not to be huge. Splitting one just to cover the few remaining pages out
of extra_pages doesn't seem worth it?

Everything else looks OK to me.


> +		}
> +		e->type = E820_TYPE_RAM;
> +		extra_pages -= pages;
> +
> +		xen_add_extra_mem(PFN_UP(e->addr), pages);
> +	}
> +}
> diff --git a/arch/x86/xen/setup.c b/arch/x86/xen/setup.c
> index b3e37961065a..380591028cb8 100644
> --- a/arch/x86/xen/setup.c
> +++ b/arch/x86/xen/setup.c
> @@ -38,9 +38,6 @@
>  
>  #define GB(x) ((uint64_t)(x) * 1024 * 1024 * 1024)
>  
> -/* Amount of extra memory space we add to the e820 ranges */
> -struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
> -
>  /* Number of pages released from the initial allocation. */
>  unsigned long xen_released_pages;
>  
> @@ -64,18 +61,6 @@ static struct {
>  } xen_remap_buf __initdata __aligned(PAGE_SIZE);
>  static unsigned long xen_remap_mfn __initdata = INVALID_P2M_ENTRY;
>  
> -/*
> - * The maximum amount of extra memory compared to the base size.  The
> - * main scaling factor is the size of struct page.  At extreme ratios
> - * of base:extra, all the base memory can be filled with page
> - * structures for the extra memory, leaving no space for anything
> - * else.
> - *
> - * 10x seems like a reasonable balance between scaling flexibility and
> - * leaving a practically usable system.
> - */
> -#define EXTRA_MEM_RATIO		(10)
> -
>  static bool xen_512gb_limit __initdata = IS_ENABLED(CONFIG_XEN_512GB);
>  
>  static void __init xen_parse_512gb(void)
> @@ -96,35 +81,6 @@ static void __init xen_parse_512gb(void)
>  	xen_512gb_limit = val;
>  }
>  
> -static void __init xen_add_extra_mem(unsigned long start_pfn,
> -				     unsigned long n_pfns)
> -{
> -	int i;
> -
> -	/*
> -	 * No need to check for zero size, should happen rarely and will only
> -	 * write a new entry regarded to be unused due to zero size.
> -	 */
> -	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
> -		/* Add new region. */
> -		if (xen_extra_mem[i].n_pfns == 0) {
> -			xen_extra_mem[i].start_pfn = start_pfn;
> -			xen_extra_mem[i].n_pfns = n_pfns;
> -			break;
> -		}
> -		/* Append to existing region. */
> -		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
> -		    start_pfn) {
> -			xen_extra_mem[i].n_pfns += n_pfns;
> -			break;
> -		}
> -	}
> -	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
> -		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
> -
> -	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
> -}
> -
>  static void __init xen_del_extra_mem(unsigned long start_pfn,
>  				     unsigned long n_pfns)
>  {
> diff --git a/arch/x86/xen/xen-ops.h b/arch/x86/xen/xen-ops.h
> index a87ab36889e7..79cf93f2c92f 100644
> --- a/arch/x86/xen/xen-ops.h
> +++ b/arch/x86/xen/xen-ops.h
> @@ -163,4 +163,18 @@ void xen_hvm_post_suspend(int suspend_cancelled);
>  static inline void xen_hvm_post_suspend(int suspend_cancelled) {}
>  #endif
>  
> +/*
> + * The maximum amount of extra memory compared to the base size.  The
> + * main scaling factor is the size of struct page.  At extreme ratios
> + * of base:extra, all the base memory can be filled with page
> + * structures for the extra memory, leaving no space for anything
> + * else.
> + *
> + * 10x seems like a reasonable balance between scaling flexibility and
> + * leaving a practically usable system.
> + */
> +#define EXTRA_MEM_RATIO		(10)
> +
> +void xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns);
> +
>  #endif /* XEN_OPS_H */
> diff --git a/drivers/xen/balloon.c b/drivers/xen/balloon.c
> index 976c6cdf9ee6..aaf2514fcfa4 100644
> --- a/drivers/xen/balloon.c
> +++ b/drivers/xen/balloon.c
> @@ -672,7 +672,6 @@ EXPORT_SYMBOL(xen_free_ballooned_pages);
>  
>  static void __init balloon_add_regions(void)
>  {
> -#if defined(CONFIG_XEN_PV)
>  	unsigned long start_pfn, pages;
>  	unsigned long pfn, extra_pfn_end;
>  	unsigned int i;
> @@ -696,7 +695,6 @@ static void __init balloon_add_regions(void)
>  
>  		balloon_stats.total_pages += extra_pfn_end - start_pfn;
>  	}
> -#endif
>  }
>  
>  static int __init balloon_init(void)
> -- 
> 2.43.0
> 
--8323329-1734207608-1708650207=:754277--

