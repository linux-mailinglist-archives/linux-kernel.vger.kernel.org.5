Return-Path: <linux-kernel+bounces-87630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 399D386D6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8E1E2856C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E4F74BF3;
	Thu, 29 Feb 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzqnCwJI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZrFPrNcu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4D45025E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245127; cv=none; b=ipCfYi4D9csH5Sm1O3nsYEcZFGXxAD1p3wblDlPDXWHgGRu57r6i05LpOyLAOqMgfaHn6YJPFZSLS2bCLp4CLHBKSKKq9LFBPJtq6Z8LWbrs4/RBHD+ifi9xyVsBwZABX02NoZ07eFVNDcK/uSGUoXQRIEgOwOdrCgJidId36Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245127; c=relaxed/simple;
	bh=AZ8vFdseDArLDA3MltLutOe9fOfNmbM09SyXJH4sSSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JGVX8xSHvfALwN3mT/4wlVMDs7OjPe4YLRpy/ZS6lrXKh3vq2JwoT/TkefqPYjSjjzrl6od3VEOnMPeLsR0pmYv9xIvo2gIhl1M0qecmxikjIo59Vorxp/7FPTCkIUoOBnU354OIBZEJPl6KR6RVQuoLCCbIAtTIF9OHnNBkILI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzqnCwJI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZrFPrNcu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709245118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HChKMC5lwAPM5OQ3TNfOuideypjcOh5mp5j1eeugdCU=;
	b=ZzqnCwJIdsnJzyForWXkD39afr1UzcRMe+yCoFg+yUzg9aAibO01rPFZXCJb1PzSR/qjpm
	ioAbp4XkH+4OC+nhnETymgN4Fc7AzuI17QW4GBb3DBsRIxl8ZHjZXzblmttTy6VTabYYU3
	am5FS68SwPppnpGoXcZD7kk7DwiX9MOFAC9pzdR0Nnq1b+aZIeYKQ3EVpYnAjxaOf/nYgH
	f5miZxMVdYxqdTnAuLsLZJXCsLzofepSwSoKUYjbxDXYHW6hCX5hUya+0S7+M7MKF0Lxz2
	dml8GPiXVfr221UdVBHcLRuAwegHGRNIHgnOXk35QWXP3cib2n6VAV0879EdaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709245118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HChKMC5lwAPM5OQ3TNfOuideypjcOh5mp5j1eeugdCU=;
	b=ZrFPrNcu6WHGLZcJLQ4BHrpFkVLY22P9euudu1uVi5MQxx+pD4tkIKbBYblYkm+YMvxrK7
	SigmuIl0MVDBIwBA==
To: Dimitri Sivanich <sivanich@hpe.com>, Dimitri Sivanich
 <sivanich@hpe.com>, David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev
Cc: linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
In-Reply-To: <ZeDj/LK56borSxO4@hpe.com>
References: <ZeDj/LK56borSxO4@hpe.com>
Date: Thu, 29 Feb 2024 23:18:37 +0100
Message-ID: <87plwe7w3m.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dimitri!

On Thu, Feb 29 2024 at 14:07, Dimitri Sivanich wrote:

The subject lacks a subsystem prefix. You're doing this for how many
decades now?

> The Intel IOMMU code currently tries to allocate all DMAR fault interrupt
>  
> +#ifdef CONFIG_X86_LOCAL_APIC

I seriously doubt that this code can ever be compiled w/o X86_LOCAL_APIC:

obj-$(CONFIG_DMAR_TABLE) += dmar.o

config DMAR_TABLE
        bool

config INTEL_IOMMU
        depends on PCI_MSI && ACPI && X86
        select DMAR_TABLE

config IRQ_REMAP
        depends on X86_64 && X86_IO_APIC && PCI_MSI && ACPI
        select DMAR_TABLE

config X86_LOCAL_APIC
        def_bool y
        depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI

What are you trying to achieve here other than #ifdef voodoo?

> +static void __init irq_remap_enable_fault_handling_thr(struct work_struct *work)
> +{
> +	irq_remap_enable_fault_handling();

because if INTEL_IOMMU=y and IRQ_REMAP=n then X86_LOCAL_APIC=y and this
muck gets invoked for nothing. 'git grep irq_remap_enable_fault_handling
include/' might give you a hint.

> +}
> +
> +static int __init assign_dmar_vectors(void)
> +{
> +	struct work_struct irq_remap_work;
> +	int nid;
> +
> +	INIT_WORK(&irq_remap_work, irq_remap_enable_fault_handling_thr);
> +	cpus_read_lock();
> +	for_each_online_node(nid) {
> +		/* Boot cpu dmar vectors are assigned before the rest */
> +		if (nid == cpu_to_node(get_boot_cpu_id()))
> +			continue;
> +		schedule_work_on(cpumask_first(cpumask_of_node(nid)),
> +				 &irq_remap_work);
> +		flush_work(&irq_remap_work);
> +	}
> +	cpus_read_unlock();
> +	return 0;
> +}
> +
> +arch_initcall(assign_dmar_vectors);

Stray newline before arch_initcall(), but that's not the problem.

The real problems are:

 1) This approach only works when _ALL_ APs have been brought up during
    boot. With 'maxcpus=N' on the command line this will fail to enable
    fault handling when the APs which have not been brought up initially
    are onlined later on.

    This might be working in practice because intel_iommu_init() will
    enable the interrupts later on via init_dmars() unconditionally, but
    that's far from correct because IRQ_REMAP does not depend on
    INTEL_IOMMU.

 2) It leaves a gap where the reporting is not working between bringing
    up the APs during boot and this initcall. Mostly theoretical, but
    that does not make it more correct either.

What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
space which enables the interrupt for the node _before_ the first AP of
the node is brought up. That will solve the problem nicely w/o any of
the above issues.

Thanks,

        tglx

