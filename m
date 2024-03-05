Return-Path: <linux-kernel+bounces-92630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5130D872321
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBCFEB22ED4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A994B127B66;
	Tue,  5 Mar 2024 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="bI/3mKHY"
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58E4127B53
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653837; cv=none; b=KBS9LJ70fT5RNL4UmyhKOZG4nxDlT6+rvwWSeuGmm3pMl/ydTPq69m+sPcPQa2bRX76uEqLUNxcmLCTDc7QXpwC3EfEuKIYgk5zze2ERW6DTtePh7TcNi0pL0y709IbGaa2sFoYI4BvE2zwkGlJNeM4ZR9rUeYLhtN7M7yNqPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653837; c=relaxed/simple;
	bh=gre3Gs3nmOqCN6F8EWRmGKYHGuddHuaxSogJsIu6aG4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgw7XG0l4ORlhk/57cP5wT9snEddDKCv4f4CmquPbqhRjbEif80fmuOUxH2Nwnnf1Bz1OLKlgjKnET0U0Cl/zqBfKYxty46t2uBDlBWPpI9EatzRhC3ODpuFqon0XRjHxmLAMXpLZDi3BmKA04TH2KJdwhyYtuljJR/fmfVwPFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=bI/3mKHY; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a142375987so395241eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1709653835; x=1710258635; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cSwqEeyJX27O1JLT5yCpxeLX8dCP1IAM2t3/nC3O9uc=;
        b=bI/3mKHYMo+imJ9k/Nn0rQe8t9aLkE9vWE5TOptIteGlRwk/YXppKxzaiZ+nl4vEnb
         u0kQ8UyvS9wcL3Herhu9wZgEvjl1XGY+Gz+aNe9AAXOnNbF5kgdbq5MHUqi9ixkyqMvW
         GB9oiwjEN4wTpfgKtnd7bZZtG4jSMEWbCLVX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653835; x=1710258635;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cSwqEeyJX27O1JLT5yCpxeLX8dCP1IAM2t3/nC3O9uc=;
        b=rjjVAYwOMxJHxKyeDChvPhEPNCXpHt8Kunt8LxJ2q+1QCxP/4bDR3OTC2bK2dt90WT
         66p723RG3pS4GI6f43l95M6aWS2FnCUvCGm0yXBQGNm0fLfG/RSXU4iy8rmAVcB5WbtC
         6XCyxxTcCi0tgY7o+WIroK9SewCKK0UgYq2K5xxSQtChUU4BNhsktA05QCyikvbX3dZu
         30DTBT7Fntkor4MnOaGG2pjJBqByv9b4ReB0FNsk2yMo1feHF7d9qmt2e9gWl2DiaN3y
         fBzcfDdcrOG+tbS1lFu9dIzRx1FxUf0GPNIAp80Qd5DXIDCiqqwQSUQQvLDLrjTgaj92
         bk4A==
X-Forwarded-Encrypted: i=1; AJvYcCUfgOBD/61RfH36hkT/k4fxJ6oi6iYJcVPYGo6vPRQzNrZ2mn4xnvWqh2z3TKzWSPouh5k1nyGT9UHr18DIeVn0v4nvpl77GDOIY8H+
X-Gm-Message-State: AOJu0Yyp2XvU1bvGASmczPIjCZd7OQlec6gw0L6updZeq3D9SQeWJKHk
	dF2g0kpAfnTLiqt3nq5gar51+Qjua8x9ewDnIxDcM7cHUIHSCbll2Lve+g/L1H8=
X-Google-Smtp-Source: AGHT+IE/IMcuOiiWALJVnleoLZ9uK203bZmDz0H+yNwVrrrVSNk44jf3q+brmAGBQFsabIchMvDbPw==
X-Received: by 2002:a05:6358:7587:b0:17b:f880:a3c1 with SMTP id x7-20020a056358758700b0017bf880a3c1mr2489415rwf.17.1709653834543;
        Tue, 05 Mar 2024 07:50:34 -0800 (PST)
Received: from localhost ([213.195.118.74])
        by smtp.gmail.com with ESMTPSA id pf10-20020a056214498a00b0068f914ac80bsm6380202qvb.50.2024.03.05.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 07:50:34 -0800 (PST)
Date: Tue, 5 Mar 2024 16:50:32 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org, Juergen Gross <jgross@suse.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	linux-kernel@vger.kernel.org, Jan Beulich <jbeulich@suse.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH RFC] x86/xen: attempt to inflate the memory balloon on PVH
Message-ID: <Zec_SGeM5bF3DPgj@macbook>
References: <20240220174341.56131-1-roger.pau@citrix.com>
 <alpine.DEB.2.22.394.2402221701190.754277@ubuntu-linux-20-04-desktop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <alpine.DEB.2.22.394.2402221701190.754277@ubuntu-linux-20-04-desktop>

On Thu, Feb 22, 2024 at 05:16:09PM -0800, Stefano Stabellini wrote:
> On Tue, 20 Feb 2024, Roger Pau Monne wrote:
> > When running as PVH or HVM Linux will use holes in the memory map as scratch
> > space to map grants, foreign domain pages and possibly miscellaneous other
> > stuff.  However the usage of such memory map holes for Xen purposes can be
> > problematic.  The request of holesby Xen happen quite early in the kernel boot
> > process (grant table setup already uses scratch map space), and it's possible
> > that by then not all devices have reclaimed their MMIO space.  It's not
> > unlikely for chunks of Xen scratch map space to end up using PCI bridge MMIO
> > window memory, which (as expected) causes quite a lot of issues in the system.
> 
> Am I understanding correctly that XEN_BALLOON_MEMORY_HOTPLUG doesn't
> help because it becomes available too late in the PVH boot sequence? 

No, not really, the hoptplug mechanism is available as early as the
balloon driver requires, the issue is that when Linux starts making
use of such unpopulated ranges (for example in order to map the shared
info page) many drivers have not yet reserved their MMIO regions, and so it's
not uncommon for the balloon driver to end up using address ranges that
would otherwise be used by device BARs for example.

This causes havoc, Linux starts to reposition device BARs, sometimes
it can manage to re-position them, otherwise some devices are not
usable.

> > At least for PVH dom0 we have the possibility of using regions marked as
> > UNUSABLE in the e820 memory map.  Either if the region is UNUSABLE in the
> > native memory map, or it has been converted into UNUSABLE in order to hide RAM
> > regions from dom0, the second stage translation page-tables can populate those
> > areas without issues.
> > 
> > PV already has this kind of logic, where the balloon driver is inflated at
> > boot.  Re-use the current logic in order to also inflate it when running as
> > PVH.  onvert UNUSABLE regions up to the ratio specified in EXTRA_MEM_RATIO to
> > RAM, while reserving them using xen_add_extra_mem() (which is also moved so
> > it's no longer tied to CONFIG_PV).
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > RFC reasons:
> > 
> >  * Note that it would be preferred for the hypervisor to provide an explicit
> >    range to be used as scratch mapping space, but that requires changes to Xen,
> >    and it's not fully clear whether Xen can figure out the position of all MMIO
> >    regions at boot in order to suggest a scratch mapping region for dom0.
> > 
> >  * Should the whole set of xen_{add,del,chk,inv}_extra_mem() functions be moved
> >    to a different file?  For the purposes of PVH only xen_add_extra_mem() is
> >    moved and the chk and inv ones are PV specific and might not want moving to
> >    a separate file just to guard them with CONFIG_PV.
> > ---
> >  arch/x86/include/asm/xen/hypervisor.h |  1 +
> >  arch/x86/platform/pvh/enlighten.c     |  3 ++
> >  arch/x86/xen/enlighten.c              | 32 +++++++++++++
> >  arch/x86/xen/enlighten_pvh.c          | 68 +++++++++++++++++++++++++++
> >  arch/x86/xen/setup.c                  | 44 -----------------
> >  arch/x86/xen/xen-ops.h                | 14 ++++++
> >  drivers/xen/balloon.c                 |  2 -
> >  7 files changed, 118 insertions(+), 46 deletions(-)
> > 
> > diff --git a/arch/x86/include/asm/xen/hypervisor.h b/arch/x86/include/asm/xen/hypervisor.h
> > index a9088250770f..31e2bf8d5db7 100644
> > --- a/arch/x86/include/asm/xen/hypervisor.h
> > +++ b/arch/x86/include/asm/xen/hypervisor.h
> > @@ -62,6 +62,7 @@ void xen_arch_unregister_cpu(int num);
> >  #ifdef CONFIG_PVH
> >  void __init xen_pvh_init(struct boot_params *boot_params);
> >  void __init mem_map_via_hcall(struct boot_params *boot_params_p);
> > +void __init xen_reserve_extra_memory(struct boot_params *bootp);
> >  #endif
> >  
> >  /* Lazy mode for batching updates / context switch */
> > diff --git a/arch/x86/platform/pvh/enlighten.c b/arch/x86/platform/pvh/enlighten.c
> > index 00a92cb2c814..a12117f3d4de 100644
> > --- a/arch/x86/platform/pvh/enlighten.c
> > +++ b/arch/x86/platform/pvh/enlighten.c
> > @@ -74,6 +74,9 @@ static void __init init_pvh_bootparams(bool xen_guest)
> >  	} else
> >  		xen_raw_printk("Warning: Can fit ISA range into e820\n");
> >  
> > +	if (xen_guest)
> > +		xen_reserve_extra_memory(&pvh_bootparams);
> > +
> >  	pvh_bootparams.hdr.cmd_line_ptr =
> >  		pvh_start_info.cmdline_paddr;
> >  
> > diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> > index 3c61bb98c10e..a01ca255b0c6 100644
> > --- a/arch/x86/xen/enlighten.c
> > +++ b/arch/x86/xen/enlighten.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/console.h>
> >  #include <linux/cpu.h>
> >  #include <linux/kexec.h>
> > +#include <linux/memblock.h>
> >  #include <linux/slab.h>
> >  #include <linux/panic_notifier.h>
> >  
> > @@ -350,3 +351,34 @@ void xen_arch_unregister_cpu(int num)
> >  }
> >  EXPORT_SYMBOL(xen_arch_unregister_cpu);
> >  #endif
> > +
> > +/* Amount of extra memory space we add to the e820 ranges */
> > +struct xen_memory_region xen_extra_mem[XEN_EXTRA_MEM_MAX_REGIONS] __initdata;
> > +
> > +void __init xen_add_extra_mem(unsigned long start_pfn, unsigned long n_pfns)
> > +{
> > +	unsigned int i;
> > +
> > +	/*
> > +	 * No need to check for zero size, should happen rarely and will only
> > +	 * write a new entry regarded to be unused due to zero size.
> > +	 */
> > +	for (i = 0; i < XEN_EXTRA_MEM_MAX_REGIONS; i++) {
> > +		/* Add new region. */
> > +		if (xen_extra_mem[i].n_pfns == 0) {
> > +			xen_extra_mem[i].start_pfn = start_pfn;
> > +			xen_extra_mem[i].n_pfns = n_pfns;
> > +			break;
> > +		}
> > +		/* Append to existing region. */
> > +		if (xen_extra_mem[i].start_pfn + xen_extra_mem[i].n_pfns ==
> > +		    start_pfn) {
> > +			xen_extra_mem[i].n_pfns += n_pfns;
> > +			break;
> > +		}
> > +	}
> > +	if (i == XEN_EXTRA_MEM_MAX_REGIONS)
> > +		printk(KERN_WARNING "Warning: not enough extra memory regions\n");
> > +
> > +	memblock_reserve(PFN_PHYS(start_pfn), PFN_PHYS(n_pfns));
> > +}
> > diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
> > index ada3868c02c2..c28f073c1df5 100644
> > --- a/arch/x86/xen/enlighten_pvh.c
> > +++ b/arch/x86/xen/enlighten_pvh.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <linux/acpi.h>
> >  #include <linux/export.h>
> > +#include <linux/mm.h>
> >  
> >  #include <xen/hvc-console.h>
> >  
> > @@ -72,3 +73,70 @@ void __init mem_map_via_hcall(struct boot_params *boot_params_p)
> >  	}
> >  	boot_params_p->e820_entries = memmap.nr_entries;
> >  }
> > +
> > +/*
> > + * Reserve e820 UNUSABLE regions to inflate the memory balloon.
> > + *
> > + * On PVH dom0 the host memory map is used, RAM regions available to dom0 are
> > + * located as the same place as in the native memory map, but since dom0 gets
> > + * less memory than the total amount of host RAM the ranges that can't be
> > + * populated are converted from RAM -> UNUSABLE.  Use such regions (up to the
> > + * ratio signaled in EXTRA_MEM_RATIO) in order to inflate the balloon driver at
> > + * boot.  Doing so prevents the guest (even if just temporary) from using holes
> > + * in the memory map in order to map grants or foreign addresses, and
> > + * hopefully limits the risk of a clash with a device MMIO region.  Ideally the
> > + * hypervisor should notify us which memory ranges are suitable for creating
> > + * foreign mappings, but that's not yet implemented.
> > + */
> > +void __init xen_reserve_extra_memory(struct boot_params *bootp)
> > +{
> > +	unsigned int i, ram_pages = 0, extra_pages;
> > +
> > +	for (i = 0; i < bootp->e820_entries; i++) {
> > +		struct boot_e820_entry *e = &bootp->e820_table[i];
> > +
> > +		if (e->type != E820_TYPE_RAM)
> > +			continue;
> > +		ram_pages += PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr);
> > +	}
> > +
> > +	/* Max amount of extra memory. */
> > +	extra_pages = EXTRA_MEM_RATIO * ram_pages;
> > +
> > +	/*
> > +	 * Convert UNUSABLE ranges to RAM and reserve them for foreign mapping
> > +	 * purposes.
> > +	 */
> > +	for (i = 0; i < bootp->e820_entries && extra_pages; i++) {
> > +		struct boot_e820_entry *e = &bootp->e820_table[i];
> > +		unsigned long pages;
> > +
> > +		if (e->type != E820_TYPE_UNUSABLE)
> > +			continue;
> > +
> > +		pages = min(extra_pages,
> > +			PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr));
> > +
> > +		if (pages != (PFN_DOWN(e->addr + e->size) - PFN_UP(e->addr))) {
> > +			struct boot_e820_entry *next;
> > +
> > +			if (bootp->e820_entries ==
> > +			    ARRAY_SIZE(bootp->e820_table))
> > +				/* No space left to split - skip region. */
> > +				continue;
> > +
> > +			/* Split entry. */
> > +			next = e + 1;
> > +			memmove(next, e,
> > +				(bootp->e820_entries - i) * sizeof(*e));
> > +			bootp->e820_entries++;
> > +			next->addr = PAGE_ALIGN(e->addr) + PFN_PHYS(pages);
> > +			e->size = next->addr - e->addr;
> > +			next->size -= e->size;
> 
> Is this really worth doing? Can we just skip this range and continue or
> simply break out and call it a day? Or even add the whole range instead?
> 
> The reason I am asking is that I am expecting E820_TYPE_UNUSABLE regions
> not to be huge. Splitting one just to cover the few remaining pages out
> of extra_pages doesn't seem worth it?

No, they are usually quite huge on PVH dom0, because when building a
PVH dom0 the E820_TYPE_RAM ranges that are not made available to dom0
because of a dom0_mem option end up being reported as
E820_TYPE_UNUSABLE in the e820 provided to dom0.

That's mostly the motivation of the change, to be able to reuse those
ranges as scratch space for foreign mappings.

Ideally the hypervisor should somehow report suitable ranges in the
address space for domains to create foreign mappings, but this does
require an amount of extra work I don't have time to do ATM, hence
this stopgap proposal.

> Everything else looks OK to me.

Thanks, Roger.

