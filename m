Return-Path: <linux-kernel+bounces-89047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9586186E9E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 20:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4BF01C22040
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 19:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C0E3B787;
	Fri,  1 Mar 2024 19:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="J+FPnGDz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118BF3B2A6
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709322265; cv=none; b=K2mhzPPpprz7UfO5zRQCCyzNgSGWwXos8kjpKSCGxQl3JzjdM/4arTUvTS5O0PIM7ro2zQ92UhrI1qsQMl+oloZiq5Bw0b5SPG9xpbpf71dBUo2qP7Q0mpv/zgIPdK+NJGTSd+gCV70eZ2YBbgTlin3X1KgrfbXCZgrXYuHlUI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709322265; c=relaxed/simple;
	bh=0W+wImXykfI+kFSl8R1LGXPsuEpOm5r99zqYr61SZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZsQIVPMD+skWdKWc+dWv4vyKDrpC0WARoEJYHhL9lfh6PW0bWnOtRSTDjqn4cbDSEASwaHA7c/5cY0y4auvQfzfMuSRBGgIEr9Ks3E2BqLLLnO8D7dTlBkp4ePgTFjNapDaoyIyrUDMjuAs2x02vcnXB+PS0gUAKTZyUOET9dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=J+FPnGDz; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709322264; x=1740858264;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0W+wImXykfI+kFSl8R1LGXPsuEpOm5r99zqYr61SZsE=;
  b=J+FPnGDz2qQrhyerZUT66yHt1bKZigYz85YkUIsWPcReq1WKano1JPfn
   w/81wUHkCUiAxTgnSGTcoGslWRgal0X7r8Mq6VEGz/CxnEzYF3k1OaoYI
   a/b9W4hKQSmki6sXVlOyazvSDsWl6+zUm21SRwyNne+cNvgbKKGp3jDF8
   PsBFF+ObodE2jXgnXNu4idO4UGFAYHQkj99ViIljmRz+n+eW1CELzlRnf
   hUESh7m02df6b7jXmZ7Dgi/+gP+7n6Wv4rNloB5sIk/WTBUC2SE4z1Evf
   SbzTvb+gCqzt4A+rYKX1UsnXwbqwefnSDKEO1yjajtwJLSOLBaOeJFJ0k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="3726936"
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="3726936"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:44:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,197,1705392000"; 
   d="scan'208";a="8521774"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.24.100.114])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:44:22 -0800
Date: Fri, 1 Mar 2024 11:50:00 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <20240301115000.4ba2e411@jacob-builder>
In-Reply-To: <87plwe7w3m.ffs@tglx>
References: <ZeDj/LK56borSxO4@hpe.com>
	<87plwe7w3m.ffs@tglx>
Organization: OTC
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Thomas,

On Thu, 29 Feb 2024 23:18:37 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> Dimitri!
> 
> On Thu, Feb 29 2024 at 14:07, Dimitri Sivanich wrote:
> 
> The subject lacks a subsystem prefix. You're doing this for how many
> decades now?
> 
> > The Intel IOMMU code currently tries to allocate all DMAR fault
> > interrupt 
> > +#ifdef CONFIG_X86_LOCAL_APIC  
> 
> I seriously doubt that this code can ever be compiled w/o X86_LOCAL_APIC:
> 
> obj-$(CONFIG_DMAR_TABLE) += dmar.o
> 
> config DMAR_TABLE
>         bool
> 
> config INTEL_IOMMU
>         depends on PCI_MSI && ACPI && X86
>         select DMAR_TABLE
> 
> config IRQ_REMAP
>         depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
>         select DMAR_TABLE
> 
> config X86_LOCAL_APIC
>         def_bool y
>         depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC ||
> PCI_MSI
> 
> What are you trying to achieve here other than #ifdef voodoo?
> 
> > +static void __init irq_remap_enable_fault_handling_thr(struct
> > work_struct *work) +{
> > +	irq_remap_enable_fault_handling();  
> 
> because if INTEL_IOMMU=y and IRQ_REMAP=n then X86_LOCAL_APIC=y and this
> muck gets invoked for nothing. 'git grep irq_remap_enable_fault_handling
> include/' might give you a hint.
> 
> > +}
> > +
> > +static int __init assign_dmar_vectors(void)
> > +{
> > +	struct work_struct irq_remap_work;
> > +	int nid;
> > +
> > +	INIT_WORK(&irq_remap_work,
> > irq_remap_enable_fault_handling_thr);
> > +	cpus_read_lock();
> > +	for_each_online_node(nid) {
> > +		/* Boot cpu dmar vectors are assigned before the rest
> > */
> > +		if (nid == cpu_to_node(get_boot_cpu_id()))
> > +			continue;
> > +		schedule_work_on(cpumask_first(cpumask_of_node(nid)),
> > +				 &irq_remap_work);
> > +		flush_work(&irq_remap_work);
> > +	}
> > +	cpus_read_unlock();
> > +	return 0;
> > +}
> > +
> > +arch_initcall(assign_dmar_vectors);  
> 
> Stray newline before arch_initcall(), but that's not the problem.
> 
> The real problems are:
> 
>  1) This approach only works when _ALL_ APs have been brought up during
>     boot. With 'maxcpus=N' on the command line this will fail to enable
>     fault handling when the APs which have not been brought up initially
>     are onlined later on.
> 
>     This might be working in practice because intel_iommu_init() will
>     enable the interrupts later on via init_dmars() unconditionally, but
>     that's far from correct because IRQ_REMAP does not depend on
>     INTEL_IOMMU.
The dmar fault interrupt is VT-d's own interrupt, not subject to IRQ_REMAP.
So this set up has nothing to do with IR, right?

Maybe we should not call it irq_remap_work, call it dmar_fault_irq_work
instead?

>  2) It leaves a gap where the reporting is not working between bringing
>     up the APs during boot and this initcall. Mostly theoretical, but
>     that does not make it more correct either.
> 
> What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
> space which enables the interrupt for the node _before_ the first AP of
> the node is brought up. That will solve the problem nicely w/o any of
> the above issues.
> 
> Thanks,
> 
>         tglx
> 


Thanks,

Jacob

