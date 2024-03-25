Return-Path: <linux-kernel+bounces-117747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4940288AF04
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD162E3C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195E13DAC14;
	Mon, 25 Mar 2024 18:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EzeZitHa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795C03DABFE
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392740; cv=none; b=cTARl8yCyl9VsJq78/LgaTI4QiQMsKPKRcb0AUz/9B5FdP5kESdUFqeacq+HjZbskqm1hPuqw+2p5e3U9LX3KPNgtju/YInOJNCpi+vilyPPDjB/me6OnRXoeWZzsQ+Cmco01eE9Nt2gbV+cCGLMWm+9aAxXF53zpkfZUOeiFbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392740; c=relaxed/simple;
	bh=lmYFhkv+i14ePbwiixcKpM1Q4Qmdn2SsVSrrKa2tT8w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pJcYMa5tqNJBa7JkFeAcLDcraOgdjD21RPzxxTbLePD1jZ5rjPqoLqlor8L8kh7PQ72WC8iWWjAi3aauqDpbIXsSqmXCZ7BLvQ8X63h83k4O6RZ3oPQ69LDjsoWtyrHTLD1Q14h/AP6A79kmCNW2k6dClotcFZLrNsWsR2fRwLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EzeZitHa; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711392738; x=1742928738;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=lmYFhkv+i14ePbwiixcKpM1Q4Qmdn2SsVSrrKa2tT8w=;
  b=EzeZitHa12szJ4cvKHNnQLSwyJiTjerqInWRww/cAiV6VfSqFLVQLmoG
   oFojiCBP/b0n325Ej6X48+8Oczyem7bmXeUXpCjEiTapr+WePa6o9HMMi
   BqLutsMq0q8ceQR2lW/8eFKfTvuBZJFF1qVSRq8lRaNSU47F6XTKkbVLG
   lcMgU0IHZiXFJFVnZ11hvLOXF17M5FOjUWuV8DCOPIGI72Zl7S/WsxMQ6
   TEiV/eGiq2UQB7L2JOmDFUhq+JnKpiaVhyBuw9EOQ5LhLyi9napzaY6g1
   mQf5a5WSRKFAcusBEmBFoLAxA7TbeNPRElgKkGrESHDkRpd6oleSLLGon
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17047407"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17047407"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:52:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="15765917"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.54.39.125])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:52:17 -0700
Date: Mon, 25 Mar 2024 11:56:38 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Dimitri Sivanich <sivanich@hpe.com>, David Woodhouse
 <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, Steve Wahl <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
Message-ID: <20240325115638.342716e5@jacob-builder>
In-Reply-To: <87msqnfihs.ffs@tglx>
References: <ZeDj/LK56borSxO4@hpe.com>
	<87plwe7w3m.ffs@tglx>
	<Ze9r47riIq9ovBCY@hpe.com>
	<20240321151357.1d18127f@jacob-builder>
	<87msqnfihs.ffs@tglx>
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

On Sun, 24 Mar 2024 22:05:35 +0100, Thomas Gleixner <tglx@linutronix.de>
wrote:

> Jacob!
> 
> On Thu, Mar 21 2024 at 15:13, Jacob Pan wrote:
> > On Mon, 11 Mar 2024 15:38:59 -0500, Dimitri Sivanich <sivanich@hpe.com>
> > wrote:  
> >> So the code seems to have been designed based on the assumption that it
> >> will be run on an already active (though not necessarily fully
> >> onlined?) cpu.  To make this work, any code based on that assumption
> >> would need to be fixed.  Otherwise, a different approach is needed.  
> >
> > This may not be pretty but since DMAR fault is for unrecoverable faults,
> > they are rare and infrequent, should never happen on a healthy system.
> > Can we share one BSP vector for all DMARs? i.e. let dmar_fault()
> > handler search for the offending DMAR for fault reasons.  
> 
> It might not be pretty on the first thought, but it has a charm.
> 
> You are right. If DMAR faults happen then there is an issue which is
> going to affect the machine badly anyway, so the extra search through
> the iommu list is not necessarily horrible and it does not matter at all
> whether the access is local or not.
> 
> But there are two interrupts involved. The DMAR one and the SVM one.
Actually, there are three. perfmon for the newer SoCs with enhanced command
interface.

> And all of that DMAR/SVM code is built around the assumption that
> everything can be set up at boot time on the BSP.
> 
> The DMAR case definitely is solvable by sharing the interrupt, see the
> uncompiled below. I still need to wrap my brain around the SVM part, but
> feel free to beat me to it or preferrably explain to me that it's not
> necessary at all :)
> 
I don't think it is necessary for SVM (page request interrupts) nor PERMON
IRQs. Their affinity already set to their local node and spread out.
Unlike DMAR fault IRQ, they are performance critical. SVM PRQ needs to have
access to local queues (see potential bug below).

So on my dual socket system. IRQ 40-47 are DMAR-prq (SVM). I see:

root@984fee003c4f:~/jacob/irqstat# for i in {40..47}; do     cat /sys/kernel/debug/irq/irqs/$i | grep -e eff;done
effectiv: 2
effectiv: 3
effectiv: 4
effectiv: 5
effectiv: 49
effectiv: 50
effectiv: 51
effectiv: 52
(reverse-i-search)`nom': sudo apt-get install g^Cme-settings-daemon
root@984fee003c4f:~/jacob/irqstat# numactl --hardware
available: 2 nodes (0-1)
node 0 cpus: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 33 34 35 36
103 104 105 106 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 128 129 130 1
node 0 size: 64198 MB
node 0 free: 60458 MB
node 1 cpus: 48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63 64 65 66 67 68 69 70 71 72 73 74 75 76 77 78 79 80 8
7 148 149 150 151 152 153 154 155 156 157 158 159 160 161 162 163 164 165 166 167 168 169 170 171 172 173 174 175
90 191
node 1 size: 64437 MB
node 1 free: 62793 MB
node distances:
node   0   1
  0:  10  21
  1:  21  10

I will give the code below a try, perhaps use a built-in device to
trigger DMAR faults.

On a separate note, just found out that page request queues are not
allocated locally, probably should be:

--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -67,7 +67,8 @@ int intel_svm_enable_prq(struct intel_iommu *iommu)
        struct page *pages;
        int irq, ret;
 
-       pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+       pages = alloc_pages_node(iommu->node, GFP_KERNEL | __GFP_ZERO, PRQ_ORDER);
+
> ---
> --- a/drivers/iommu/intel/dmar.c
> +++ b/drivers/iommu/intel/dmar.c
> @@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iomm
>  			iommu->pr_irq = 0;
>  		}
>  		free_irq(iommu->irq, iommu);
> -		dmar_free_hwirq(iommu->irq);
>  		iommu->irq = 0;
>  	}
>  
> @@ -1956,17 +1955,21 @@ void dmar_msi_mask(struct irq_data *data
>  	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
>  }
>  
> -void dmar_msi_write(int irq, struct msi_msg *msg)
> +static void dmar_iommu_msi_write(struct intel_iommu *iommu, struct
> msi_msg *msg) {
> -	struct intel_iommu *iommu = irq_get_handler_data(irq);
>  	int reg = dmar_msi_reg(iommu, irq);
> -	unsigned long flag;
> +	unsigned long flags;
>  
> -	raw_spin_lock_irqsave(&iommu->register_lock, flag);
> +	raw_spin_lock_irqsave(&iommu->register_lock, flags);
>  	writel(msg->data, iommu->reg + reg + 4);
>  	writel(msg->address_lo, iommu->reg + reg + 8);
>  	writel(msg->address_hi, iommu->reg + reg + 12);
> -	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
> +	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
> +}
> +
> +void dmar_msi_write(int irq, struct msi_msg *msg)
> +{
> +	dmar_iommu_msi_write(irq_get_handler_data(irq), msg);
>  }
>  
>  void dmar_msi_read(int irq, struct msi_msg *msg)
> @@ -2100,23 +2103,37 @@ irqreturn_t dmar_fault(int irq, void *de
>  
>  int dmar_set_interrupt(struct intel_iommu *iommu)
>  {
> -	int irq, ret;
> +	static int dmar_irq;
> +	int ret;
>  
> -	/*
> -	 * Check if the fault interrupt is already initialized.
> -	 */
> +	/* Don't initialize it twice for a given iommu */
>  	if (iommu->irq)
>  		return 0;
>  
> -	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
> -	if (irq > 0) {
> -		iommu->irq = irq;
> +	/*
> +	 * There is one shared interrupt for all IOMMUs to prevent vector
> +	 * exhaustion.
> +	 */
> +	if (!dmar_irq) {
> +		int irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node,
> iommu); +
> +		if (irq <= 0) {
> +			pr_err("No free IRQ vectors\n");
> +			return -EINVAL;
> +		}
> +		dmar_irq = irq;
>  	} else {
> -		pr_err("No free IRQ vectors\n");
> -		return -EINVAL;
> +		struct msi_msg msg;
> +
> +		/*
> +		 * Get the MSI message from the shared interrupt and
> write
> +		 * it to the iommu MSI registers.
> +		 */
> +		dmar_msi_read(dmar_irq, &msg);
> +		dmar_iommu_msi_write(iommu, &msg);
>  	}
>  
> -	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name,
> iommu);
> +	ret = request_irq(dmar_irq, dmar_fault, IRQF_NO_THREAD |
> IRQF_SHARED, iommu->name, iommu); if (ret)
>  		pr_err("Can't request irq\n");
>  	return ret;


Thanks,

Jacob

