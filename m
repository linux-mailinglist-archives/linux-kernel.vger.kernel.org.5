Return-Path: <linux-kernel+bounces-110740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC8388630C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:11:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDA01C203E3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880BA13699F;
	Thu, 21 Mar 2024 22:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HflWwjK2"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C7A136653
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 22:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711058979; cv=none; b=GJZuFMhUU9iYvt8IIw4ZtptR6QDWgdRkXmDXjUuF5aK+YYTU6DbKnt0cAwYeJVFtqcqSP0ilsc/8J6G4t8LV2ijXL+LHCMiQEb0G1CZt+e82SzBm8DHJXVwP6zEXKYK6z8Bt84bXOEmyUo2Im3sS+2U65AaCEkCQ7IqYfju5WtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711058979; c=relaxed/simple;
	bh=A9Tj9AR0ZR+h7MolLz8S04z6JYhfQeCOuRIBcl5Zv5A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tBkxCG8szWusqCHzz24G5M8j4C1HBRNJ7F1yJIPJeVfdHxhozqjhnq+el2MEblHKePsk9pschXJCQXiDyXhY45lM8mW4oNd6tGb+MTiiE9BLa4WJoiNov2JcxNt5JgJ/Jt9UW8baeTDNh30GWGt7hcQIGgt2rOw1Q4WKP5xscP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HflWwjK2; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711058978; x=1742594978;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=A9Tj9AR0ZR+h7MolLz8S04z6JYhfQeCOuRIBcl5Zv5A=;
  b=HflWwjK2zErCteEyH1aJBpY76ArTOEAPFcC5Deu0WPTOrBkdtg+4Itp/
   kfXqMmo/LPB+wz495jLLTg+MhBOpTZ1v4NYTgzsOo5aY/EdM6dV5ng4To
   L2H9encn5WU1fB0mjtJJ5pqF4dxssQGZIxfiKgvpq7xkJ00Fd1fPtjFYd
   VpDkVCKvI8oPbzr/tBJR5aNuiY3p+9fobbagtmra7iDn+ZYyN4dEcpXY4
   5OSqJg3zgXK9JUOCB5KRqIQncyXjPFeAePrxS9yZaoBcqAJQ5gsxVQX7j
   zFhB/OyqomZAVPpXzPYTiJ5W1BlAs3euMWHTXAjnT26oWobnaoTaT4uKp
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11020"; a="31525037"
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="31525037"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:09:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,144,1708416000"; 
   d="scan'208";a="52112421"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 15:09:37 -0700
Date: Thu, 21 Mar 2024 15:13:57 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Dimitri Sivanich <sivanich@hpe.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <20240321151357.1d18127f@jacob-builder>
In-Reply-To: <Ze9r47riIq9ovBCY@hpe.com>
References: <ZeDj/LK56borSxO4@hpe.com>
	<87plwe7w3m.ffs@tglx>
	<Ze9r47riIq9ovBCY@hpe.com>
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

Hi Dimitri,

On Mon, 11 Mar 2024 15:38:59 -0500, Dimitri Sivanich <sivanich@hpe.com>
wrote:

> Thomas!
> 
> On Thu, Feb 29, 2024 at 11:18:37PM +0100, Thomas Gleixner wrote:
> > Dimitri!
> > 
> > On Thu, Feb 29 2024 at 14:07, Dimitri Sivanich wrote:
> >   
> > > +}
> > > +
> > > +static int __init assign_dmar_vectors(void)
> > > +{
> > > +	struct work_struct irq_remap_work;
> > > +	int nid;
> > > +
> > > +	INIT_WORK(&irq_remap_work,
> > > irq_remap_enable_fault_handling_thr);
> > > +	cpus_read_lock();
> > > +	for_each_online_node(nid) {
> > > +		/* Boot cpu dmar vectors are assigned before the
> > > rest */
> > > +		if (nid == cpu_to_node(get_boot_cpu_id()))
> > > +			continue;
> > > +		schedule_work_on(cpumask_first(cpumask_of_node(nid)),
> > > +				 &irq_remap_work);
> > > +		flush_work(&irq_remap_work);
> > > +	}
> > > +	cpus_read_unlock();
> > > +	return 0;
> > > +}
> > > +
> > > +arch_initcall(assign_dmar_vectors);  
> > 
> > Stray newline before arch_initcall(), but that's not the problem.
> > 
> > The real problems are:
> > 
> >  1) This approach only works when _ALL_ APs have been brought up during
> >     boot. With 'maxcpus=N' on the command line this will fail to enable
> >     fault handling when the APs which have not been brought up initially
> >     are onlined later on.
> > 
> >     This might be working in practice because intel_iommu_init() will
> >     enable the interrupts later on via init_dmars() unconditionally, but
> >     that's far from correct because IRQ_REMAP does not depend on
> >     INTEL_IOMMU.
> > 
> >  2) It leaves a gap where the reporting is not working between bringing
> >     up the APs during boot and this initcall. Mostly theoretical, but
> >     that does not make it more correct either.
> > 
> > What you really want is a cpu hotplug state in the CPUHP_BP_PREPARE_DYN
> > space which enables the interrupt for the node _before_ the first AP of
> > the node is brought up. That will solve the problem nicely w/o any of
> > the above issues.
> >  
> 
> Initially this sounds like a good approach.  As things currently stand,
> however, there are (at least) several problems with attempting to
> allocate interrupts on cpus that are not running yet via the existing
> dmar_set_interrupt path.
> 
> - The code relies on node_to_cpumask_map (cpumask_of_node()), which has
> been allocated, but not populated at the CPUHP_BP_PREPARE_DYN stage.
> 
> - The irq_matrix cpumaps do not indicate being online or initialized yet,
> except for the boot cpu instance, of course.
> 
> So things still revert to boot cpu allocation, until we exhaust the
> vectors.
> 
> Of course, running the dmar_set_interrupt code from a CPUHP_AP_ONLINE_DYN
> state does work (although I believe there is a concurrency issue that
> could show up with the current dmar_set_interrupt path).
> 
> So the code seems to have been designed based on the assumption that it
> will be run on an already active (though not necessarily fully onlined?)
> cpu.  To make this work, any code based on that assumption would need to
> be fixed.  Otherwise, a different approach is needed.
This may not be pretty but since DMAR fault is for unrecoverable faults,
they are rare and infrequent, should never happen on a healthy system. Can
we share one BSP vector for all DMARs? i.e. let dmar_fault() handler search
for the offending DMAR for fault reasons.


Thanks,

Jacob

