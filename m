Return-Path: <linux-kernel+bounces-94837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 947148745C3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 02:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5F931F237CD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542614C9A;
	Thu,  7 Mar 2024 01:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQJYAn61"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5209B17FF
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 01:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709776263; cv=none; b=Zu1DRG2HV5xAxMubQrZUKj6Dj689tPpr9FiqXuPwEEnlwXhKggzJzpThzlE7CUYQMMTyCbna49zvJEZe9/JbK8pQZJII3IofCgitR8HbnCm0pT+haiR0RX86ItuvS01zZV0ENqlMy4tvmZ1rzJK23N0iAe2vJCTcMinDFA5a1uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709776263; c=relaxed/simple;
	bh=R/F1ZSbpZekKrxNMmgsEC5tthbinM6LLxoMhze4B9pg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=RvmXvv7tPtoV2GD+/A70oDehGg+4rMsW5wSAIxEkRyyCdQ8iQ0yOH1eQQ/pEn2HxQx8v1v8dbJH1bDE4fSN7kj/Kl8mG8aHc+GokT2YpmL+0DxwUTeZMJPv2TRyaN/AUIEwIOUpVhggUTAjon5Fua+b/kXXaIRTG1O3EEx+EXQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQJYAn61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7483C433F1;
	Thu,  7 Mar 2024 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709776262;
	bh=R/F1ZSbpZekKrxNMmgsEC5tthbinM6LLxoMhze4B9pg=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=CQJYAn61BKlYlIwGv8Is9yXYj5aZwec5Yk7lGaSAZca500AVqd5Z78/d8WQlG0AKb
	 OFzJAC8JW0SZ9PTb6MmjxW/PhtnKGx1gKurUlJ4sbSJIhgecsmyM4pjjirrr3p5vtK
	 djeK51MGCIMIDghgrF5EtuI6iti+e+qs1yVHdWv1oeICk6ZuoFpEnQE1FErujsq0d2
	 6D6CyEe6WsVkW3kmZVsHKxah23msyrO/IUDOAIWSNtzRZkMvsmItSSZsPkNtj0yqzn
	 RdhvP8Ow09BMK1EB62LvL+dzJJwrL+HiNYK2abnhvMTtkkunLCY9SW+DiVWgbD2bek
	 uaC2b8CGvDcbw==
Date: Wed, 6 Mar 2024 17:50:59 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: =?UTF-8?Q?Roger_Pau_Monn=C3=A9?= <roger.pau@citrix.com>
cc: Stefano Stabellini <sstabellini@kernel.org>, 
    xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>, 
    Boris Ostrovsky <boris.ostrovsky@oracle.com>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>, 
    Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RFC] x86/xen: attempt to inflate the memory balloon on
 PVH
In-Reply-To: <Zec_SGeM5bF3DPgj@macbook>
Message-ID: <alpine.DEB.2.22.394.2403061749190.853156@ubuntu-linux-20-04-desktop>
References: <20240220174341.56131-1-roger.pau@citrix.com> <alpine.DEB.2.22.394.2402221701190.754277@ubuntu-linux-20-04-desktop> <Zec_SGeM5bF3DPgj@macbook>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1275602164-1709776262=:853156"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1275602164-1709776262=:853156
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 5 Mar 2024, Roger Pau Monné wrote:
> On Thu, Feb 22, 2024 at 05:16:09PM -0800, Stefano Stabellini wrote:
> > On Tue, 20 Feb 2024, Roger Pau Monne wrote:
> > > When running as PVH or HVM Linux will use holes in the memory map as scratch
> > > space to map grants, foreign domain pages and possibly miscellaneous other
> > > stuff.  However the usage of such memory map holes for Xen purposes can be
> > > problematic.  The request of holesby Xen happen quite early in the kernel boot
> > > process (grant table setup already uses scratch map space), and it's possible
> > > that by then not all devices have reclaimed their MMIO space.  It's not
> > > unlikely for chunks of Xen scratch map space to end up using PCI bridge MMIO
> > > window memory, which (as expected) causes quite a lot of issues in the system.
> > 
> > Am I understanding correctly that XEN_BALLOON_MEMORY_HOTPLUG doesn't
> > help because it becomes available too late in the PVH boot sequence? 
> 
> No, not really, the hoptplug mechanism is available as early as the
> balloon driver requires, the issue is that when Linux starts making
> use of such unpopulated ranges (for example in order to map the shared
> info page) many drivers have not yet reserved their MMIO regions, and so it's
> not uncommon for the balloon driver to end up using address ranges that
> would otherwise be used by device BARs for example.
> 
> This causes havoc, Linux starts to reposition device BARs, sometimes
> it can manage to re-position them, otherwise some devices are not
> usable.

OK this is bad


> > > At least for PVH dom0 we have the possibility of using regions marked as
> > > UNUSABLE in the e820 memory map.  Either if the region is UNUSABLE in the
> > > native memory map, or it has been converted into UNUSABLE in order to hide RAM
> > > regions from dom0, the second stage translation page-tables can populate those
> > > areas without issues.
> > > 
> > > PV already has this kind of logic, where the balloon driver is inflated at
> > > boot.  Re-use the current logic in order to also inflate it when running as
> > > PVH.  onvert UNUSABLE regions up to the ratio specified in EXTRA_MEM_RATIO to
> > > RAM, while reserving them using xen_add_extra_mem() (which is also moved so
> > > it's no longer tied to CONFIG_PV).
> > > 
> > > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > > ---
> > > RFC reasons:
> > > 
> > >  * Note that it would be preferred for the hypervisor to provide an explicit
> > >    range to be used as scratch mapping space, but that requires changes to Xen,
> > >    and it's not fully clear whether Xen can figure out the position of all MMIO
> > >    regions at boot in order to suggest a scratch mapping region for dom0.
> > > 
> > >  * Should the whole set of xen_{add,del,chk,inv}_extra_mem() functions be moved
> > >    to a different file?  For the purposes of PVH only xen_add_extra_mem() is
> > >    moved and the chk and inv ones are PV specific and might not want moving to
> > >    a separate file just to guard them with CONFIG_PV.
> > > ---
> > >  arch/x86/include/asm/xen/hypervisor.h |  1 +
> > >  arch/x86/platform/pvh/enlighten.c     |  3 ++
> > >  arch/x86/xen/enlighten.c              | 32 +++++++++++++
> > >  arch/x86/xen/enlighten_pvh.c          | 68 +++++++++++++++++++++++++++
> > >  arch/x86/xen/setup.c                  | 44 -----------------
> > >  arch/x86/xen/xen-ops.h                | 14 ++++++
> > >  drivers/xen/balloon.c                 |  2 -
> > >  7 files changed, 118 insertions(+), 46 deletions(-)
> > > 
> > > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> > > index a9088250770f..31e2bf8d5db7 100644
> > > --- a/arch/x86/include/asm/xen/hypervisor.h
> > > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > > @@ -62,6 +62,7 @@ void xen_arch_unregister_cpu(int num);
> > >  #ifdef CONFIG_PVH
> > >  void __init xen_pvh_init(struct boot_params *boot_params);
> > >  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> > > +void __init xen_reserve_extra_memory(struct boot_params *bootp);
> > >  #endif
> > >  
> > >  /* Lazy mode for batching updates / context switch */
> > > diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
> > > index 00a92cb2c814..a12117f3d4de 100644
> > > --- a/arch/x86/platform/pvh/enlighten.c
> > > +++ b/arch/x86/platform/pvh/enlighten.c
> > > @@ -74,6 +74,9 @@ static void __init init_pvh_bootparams(bool xen_guest)
> > >  	} else
> > >  		xen_raw_printk("Warning: Can fit ISA range into e820\n");
> > >  
> > > +	if (xen_guest)
> > > +		xen_reserve_extra_memory(&pvh_bootparams);
> > > +
> > >  	pvh_bootparams.hdr.cmd_line_ptr =
> > >  		pvh_start_info.cmdline_paddr;
> > >  
> > > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > > index 3c61bb98c10e..a01ca255b0c6 100644
> > > --- a/arch/x86/xen/enlighten.c
> > > +++ b/arch/x86/xen/enlighten.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/console.h>
> > >  #include <linux/cpu.h>
> > >  #include <linux/kexec.h>
> > > +#include <linux/memblock.h>
> > >  #include <linux/slab.h>
> > >  #include <linux/panic_notifier.h>
> > >  
> > > @@ -350,3 +351,34 @@ void xen_arch_unregister_cpu(int num)
> > >  }
> > >  EXPORT_SYMBOL(xen_arch_unregister_cpu);
> > >  #endif
> > > +
> > > +/* Amount of extra memory space we add to the e820 ranges */
> > > +struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
> > > +
> > > +void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
> > > +{
> > > +	unsigned int i;
> > > +
> > > +	/*
> > > +	 * No need to check for zero size, should happen rarely and will only
> > > +	 * write a new entry regarded to be unused due to zero size.
> > > +	 */
> > > +	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
> > > +		/* Add new region. */
> > > +		if (xen_extra_mem[i].n_pfns == 0) {
> > > +			xen_extra_mem[i].start_pfn = start_pfn;
> > > +			xen_extra_mem[i].n_pfns = n_pfns;
> > > +			break;
> > > +		}
> > > +		/* Append to existing region. */
> > > +		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
> > > +		    start_pfn) {
> > > +			xen_extra_mem[i].n_pfns += n_pfns;
> > > +			break;
> > > +		}
> > > +	}
> > > +	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
> > > +		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
> > > +
> > > +	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
> > > +}
> > > diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> > > index ada3868c02c2..c28f073c1df5 100644
> > > --- a/arch/x86/xen/enlighten_pvh.c
> > > +++ b/arch/x86/xen/enlighten_pvh.c
> > > @@ -1,6 +1,7 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  #include <linux/acpi.h>
> > >  #include <linux/export.h>
> > > +#include <linux/mm.h>
> > >  
> > >  #include <xen/hvc-console.h>
> > >  
> > > @@ -72,3 +73,70 @@ void __init mem_map_via_hcall(struct boot_params *boot_params_p)
> > >  	}
> > >  	boot_params_p->e820_entries = memmap.nr_entries;
> > >  }
> > > +
> > > +/*
> > > + * Reserve e820 UNUSABLE regions to inflate the memory balloon.
> > > + *
> > > + * On PVH dom0 the host memory map is used, RAM regions available to dom0 are
> > > + * located as the same place as in the native memory map, but since dom0 gets
> > > + * less memory than the total amount of host RAM the ranges that can't be
> > > + * populated are converted from RAM -> UNUSABLE.  Use such regions (up to the
> > > + * ratio signaled in EXTRA_MEM_RATIO) in order to inflate the balloon driver at
> > > + * boot.  Doing so prevents the guest (even if just temporary) from using holes
> > > + * in the memory map in order to map grants or foreign addresses, and
> > > + * hopefully limits the risk of a clash with a device MMIO region.  Ideally the
> > > + * hypervisor should notify us which memory ranges are suitable for creating
> > > + * foreign mappings, but that's not yet implemented.
> > > + */
> > > +void __init xen_reserve_extra_memory(struct boot_params *bootp)
> > > +{
> > > +	unsigned int i, ram_pages = 0, extra_pages;
> > > +
> > > +	for (i = 0; i < bootp->e820_entries; i++) {
> > > +		struct boot_e820_entry *e = &bootp->e820_table[i];
> > > +
> > > +		if (e->type != E820_TYPE_RAM)
> > > +			continue;
> > > +		ram_pages += PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr);
> > > +	}
> > > +
> > > +	/* Max amount of extra memory. */
> > > +	extra_pages = EXTRA_MEM_RATIO * ram_pages;
> > > +
> > > +	/*
> > > +	 * Convert UNUSABLE ranges to RAM and reserve them for foreign mapping
> > > +	 * purposes.
> > > +	 */
> > > +	for (i = 0; i < bootp->e820_entries && extra_pages; i++) {
> > > +		struct boot_e820_entry *e = &bootp->e820_table[i];
> > > +		unsigned long pages;
> > > +
> > > +		if (e->type != E820_TYPE_UNUSABLE)
> > > +			continue;
> > > +
> > > +		pages = min(extra_pages,
> > > +			PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr));
> > > +
> > > +		if (pages != (PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr))) {
> > > +			struct boot_e820_entry *next;
> > > +
> > > +			if (bootp->e820_entries ==
> > > +			    ARRAY_SIZE(bootp->e820_table))
> > > +				/* No space left to split - skip region. */
> > > +				continue;
> > > +
> > > +			/* Split entry. */
> > > +			next = e + 1;
> > > +			memmove(next, e,
> > > +				(bootp->e820_entries - i) * sizeof(*e));
> > > +			bootp->e820_entries++;
> > > +			next->addr = PAGE_ALIGN(e->addr) + PFN_PHYS(pages);
> > > +			e->size = next->addr - e->addr;
> > > +			next->size -= e->size;
> > 
> > Is this really worth doing? Can we just skip this range and continue or
> > simply break out and call it a day? Or even add the whole range instead?
> > 
> > The reason I am asking is that I am expecting E820_TYPE_UNUSABLE regions
> > not to be huge. Splitting one just to cover the few remaining pages out
> > of extra_pages doesn't seem worth it?
> 
> No, they are usually quite huge on PVH dom0, because when building a
> PVH dom0 the E820_TYPE_RAM ranges that are not made available to dom0
> because of a dom0_mem option end up being reported as
> E820_TYPE_UNUSABLE in the e820 provided to dom0.
> 
> That's mostly the motivation of the change, to be able to reuse those
> ranges as scratch space for foreign mappings.
> 
> Ideally the hypervisor should somehow report suitable ranges in the
> address space for domains to create foreign mappings, but this does
> require an amount of extra work I don't have time to do ATM, hence
> this stopgap proposal.

I see. We have gained this feature on ARM not long ago for Dom0 and
Dom0less guests.

All right, I have no reservations. The patch looks OK to me. Juergen?
--8323329-1275602164-1709776262=:853156--

