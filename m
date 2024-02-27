Return-Path: <linux-kernel+bounces-82675-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EED1868820
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:10:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3838B1C21F58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 04:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417A34D5B0;
	Tue, 27 Feb 2024 04:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="MAo+CXTj"
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A1638387;
	Tue, 27 Feb 2024 04:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709007036; cv=none; b=p88bi0YQIW80jNrCnZKw6gYFnlimsRpWEonRsZagajC0kH3h+tvHM9KWLHPtO+I8tSfQ0lYGZ2MfLNiQhqakyDtiWseSD6KKk0P6wbTjWw8xpjCnxG/uc+rEwJqXdjne2K80WQuCCogPeUSn7p8Nb0difZQpMwprgn/l35cNlAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709007036; c=relaxed/simple;
	bh=bd9QSV2wu+dedXDp3EE4WVF/b12K6ppAoOk7e+CLEmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ecLRftV2BeOQTrEsFR3VCHQhV40oiLGLgwj614Rlap+Ys9jPK0qqpMU9PZ5tAgKGBpfuwgsC1g2Mqe73clgBdoIkxHGpcWhuQG7AdBjFtpOfOMl5R7zbuSDZonIi4yJpSMGuSQNCxpnH4yklwGXyJbm6f9J4YtdOLbgQwfjwnqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=MAo+CXTj; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1709007024; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=zwkpXF9gJx+g/eWdNELvvxUaWV9Pu/V951Ww8oOa6pc=;
	b=MAo+CXTjflL4SSXdTLIt7EsmL7/4tGc3axK1Hdll+NySlKBJs4Ol/aFalJRybczZFm3OI38aU09ArJmer1EiGnIOPaICMp8p3FR5pATvMxgN8MYAk8vOB3Uap/+VvNib83fiFUeP4BxUMe3JtBcRCKS4UkADpl1n1IJ8VCI33p4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R641e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=liusong@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0W1LWtRr_1709007020;
Received: from 30.178.80.107(mailfrom:liusong@linux.alibaba.com fp:SMTPD_---0W1LWtRr_1709007020)
          by smtp.aliyun-inc.com;
          Tue, 27 Feb 2024 12:10:22 +0800
Message-ID: <188559cb-875e-498e-94a4-43b3a0b5e901@linux.alibaba.com>
Date: Tue, 27 Feb 2024 12:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv10 2/4] genirq: Provide a snapshot mechanism for interrupt
 statistics
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 tglx@linutronix.de, akpm@linux-foundation.org, pmladek@suse.com,
 kernelfans@gmail.com, deller@gmx.de, npiggin@gmail.com,
 tsbogend@alpha.franken.de, James.Bottomley@HansenPartnership.com,
 jan.kiszka@siemens.com
Cc: linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20240226020939.45264-1-yaoma@linux.alibaba.com>
 <20240226020939.45264-3-yaoma@linux.alibaba.com>
From: Liu Song <liusong@linux.alibaba.com>
In-Reply-To: <20240226020939.45264-3-yaoma@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


在 2024/2/26 10:09, Bitao Hu 写道:
> The soft lockup detector lacks a mechanism to identify interrupt storms
> as root cause of a lockup. To enable this the detector needs a
> mechanism to snapshot the interrupt count statistics on a CPU when the
> detector observes a potential lockup scenario and compare that against
> the interrupt count when it warns about the lockup later on. The number
> of interrupts in that period give a hint whether the lockup might be
> caused by an interrupt storm.
>
> Instead of having extra storage in the lockup detector and accessing
> the internals of the interrupt descriptor directly, convert the per CPU
> irq_desc::kstat_irq member to a data structure which contains the
> counter plus a snapshot member and provide interfaces to take a
> snapshot of all interrupts on the current CPU and to retrieve the delta
> of a specific interrupt later on.
>
> Originally-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Bitao Hu <yaoma@linux.alibaba.com>
> ---
>   arch/mips/dec/setup.c                |  2 +-
>   arch/parisc/kernel/smp.c             |  2 +-
>   arch/powerpc/kvm/book3s_hv_rm_xics.c |  2 +-
>   include/linux/irqdesc.h              |  9 ++++++--
>   include/linux/kernel_stat.h          |  3 +++
>   kernel/irq/internals.h               |  2 +-
>   kernel/irq/irqdesc.c                 | 34 ++++++++++++++++++++++------
>   kernel/irq/proc.c                    |  5 ++--
>   scripts/gdb/linux/interrupts.py      |  6 ++---
>   9 files changed, 46 insertions(+), 19 deletions(-)
>
> diff --git a/arch/mips/dec/setup.c b/arch/mips/dec/setup.c
> index 6c3704f51d0d..87f0a1436bf9 100644
> --- a/arch/mips/dec/setup.c
> +++ b/arch/mips/dec/setup.c
> @@ -756,7 +756,7 @@ void __init arch_init_irq(void)
>   				NULL))
>   			pr_err("Failed to register fpu interrupt\n");
>   		desc_fpu = irq_to_desc(irq_fpu);
> -		fpu_kstat_irq = this_cpu_ptr(desc_fpu->kstat_irqs);
> +		fpu_kstat_irq = this_cpu_ptr(&desc_fpu->kstat_irqs->cnt);
>   	}
>   	if (dec_interrupt[DEC_IRQ_CASCADE] >= 0) {
>   		if (request_irq(dec_interrupt[DEC_IRQ_CASCADE], no_action,
> diff --git a/arch/parisc/kernel/smp.c b/arch/parisc/kernel/smp.c
> index 444154271f23..800eb64e91ad 100644
> --- a/arch/parisc/kernel/smp.c
> +++ b/arch/parisc/kernel/smp.c
> @@ -344,7 +344,7 @@ static int smp_boot_one_cpu(int cpuid, struct task_struct *idle)
>   		struct irq_desc *desc = irq_to_desc(i);
>   
>   		if (desc && desc->kstat_irqs)
> -			*per_cpu_ptr(desc->kstat_irqs, cpuid) = 0;
> +			*per_cpu_ptr(desc->kstat_irqs, cpuid) = (struct irqstat) { };
>   	}
>   #endif
>   
> diff --git a/arch/powerpc/kvm/book3s_hv_rm_xics.c b/arch/powerpc/kvm/book3s_hv_rm_xics.c
> index e42984878503..f2636414d82a 100644
> --- a/arch/powerpc/kvm/book3s_hv_rm_xics.c
> +++ b/arch/powerpc/kvm/book3s_hv_rm_xics.c
> @@ -837,7 +837,7 @@ static inline void this_cpu_inc_rm(unsigned int __percpu *addr)
>    */
>   static void kvmppc_rm_handle_irq_desc(struct irq_desc *desc)
>   {
> -	this_cpu_inc_rm(desc->kstat_irqs);
> +	this_cpu_inc_rm(&desc->kstat_irqs->cnt);
>   	__this_cpu_inc(kstat.irqs_sum);
>   }
>   
> diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
> index d9451d456a73..2912b1998670 100644
> --- a/include/linux/irqdesc.h
> +++ b/include/linux/irqdesc.h
> @@ -17,6 +17,11 @@ struct irq_desc;
>   struct irq_domain;
>   struct pt_regs;
>   
> +struct irqstat {
> +	unsigned int	cnt;
> +	unsigned int	ref;
> +};
> +
>   /**
>    * struct irq_desc - interrupt descriptor
>    * @irq_common_data:	per irq and chip data passed down to chip functions
> @@ -55,7 +60,7 @@ struct pt_regs;
>   struct irq_desc {
>   	struct irq_common_data	irq_common_data;
>   	struct irq_data		irq_data;
> -	unsigned int __percpu	*kstat_irqs;
> +	struct irqstat __percpu	*kstat_irqs;
>   	irq_flow_handler_t	handle_irq;
>   	struct irqaction	*action;	/* IRQ action list */
>   	unsigned int		status_use_accessors;
> @@ -119,7 +124,7 @@ extern struct irq_desc irq_desc[NR_IRQS];
>   static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
>   					      unsigned int cpu)
>   {
> -	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
> +	return desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
>   }
>   
>   static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
> diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
> index 9935f7ecbfb9..98b3043ea5e6 100644
> --- a/include/linux/kernel_stat.h
> +++ b/include/linux/kernel_stat.h
> @@ -79,6 +79,9 @@ static inline unsigned int kstat_cpu_softirqs_sum(int cpu)
>   	return sum;
>   }
>   
> +extern void kstat_snapshot_irqs(void);
> +extern unsigned int kstat_get_irq_since_snapshot(unsigned int irq);
> +
>   /*
>    * Number of interrupts per specific IRQ source, since bootup
>    */
> diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
> index bcc7f21db9ee..1d92532c2aae 100644
> --- a/kernel/irq/internals.h
> +++ b/kernel/irq/internals.h
> @@ -258,7 +258,7 @@ static inline void irq_state_set_masked(struct irq_desc *desc)
>   
>   static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
>   {
> -	__this_cpu_inc(*desc->kstat_irqs);
> +	__this_cpu_inc(desc->kstat_irqs->cnt);
>   	__this_cpu_inc(kstat.irqs_sum);
>   }
>   
> diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
> index 27ca1c866f29..9cd17080b2d8 100644
> --- a/kernel/irq/irqdesc.c
> +++ b/kernel/irq/irqdesc.c
> @@ -122,7 +122,7 @@ static void desc_set_defaults(unsigned int irq, struct irq_desc *desc, int node,
>   	desc->name = NULL;
>   	desc->owner = owner;
>   	for_each_possible_cpu(cpu)
> -		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
> +		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
>   	desc_smp_init(desc, node, affinity);
>   }
>   
> @@ -418,8 +418,8 @@ static struct irq_desc *alloc_desc(int irq, int node, unsigned int flags,
>   	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
>   	if (!desc)
>   		return NULL;
> -	/* allocate based on nr_cpu_ids */
> -	desc->kstat_irqs = alloc_percpu(unsigned int);
> +
> +	desc->kstat_irqs = alloc_percpu(struct irqstat);
>   	if (!desc->kstat_irqs)
>   		goto err_desc;
>   
> @@ -593,7 +593,7 @@ int __init early_irq_init(void)
>   	count = ARRAY_SIZE(irq_desc);
>   
>   	for (i = 0; i < count; i++) {
> -		desc[i].kstat_irqs = alloc_percpu(unsigned int);
> +		desc[i].kstat_irqs = alloc_percpu(struct irqstat);
>   		alloc_masks(&desc[i], node);
>   		raw_spin_lock_init(&desc[i].lock);
>   		lockdep_set_class(&desc[i].lock, &irq_desc_lock_class);
> @@ -952,8 +952,7 @@ unsigned int kstat_irqs_cpu(unsigned int irq, int cpu)
>   {
>   	struct irq_desc *desc = irq_to_desc(irq);
>   
> -	return desc && desc->kstat_irqs ?
> -			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
> +	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
>   }
>   
>   static bool irq_is_nmi(struct irq_desc *desc)
> @@ -975,10 +974,31 @@ static unsigned int kstat_irqs(unsigned int irq)
>   		return data_race(desc->tot_count);
>   
>   	for_each_possible_cpu(cpu)
> -		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
> +		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
>   	return sum;
>   }
>   
> +void kstat_snapshot_irqs(void)
> +{
> +	struct irq_desc *desc;
> +	unsigned int irq;
> +
> +	for_each_irq_desc(irq, desc) {
> +		if (!desc->kstat_irqs)
> +			continue;
> +		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt));
> +	}
> +}
> +
> +unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
> +{
> +	struct irq_desc *desc = irq_to_desc(irq);
> +
> +	if (!desc || !desc->kstat_irqs)
> +		return 0;
> +	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
> +}
> +
>   /**
>    * kstat_irqs_usr - Get the statistics for an interrupt from thread context
>    * @irq:	The interrupt number
> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 623b8136e9af..6954e0a02047 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -490,7 +490,7 @@ int show_interrupts(struct seq_file *p, void *v)
>   
>   	if (desc->kstat_irqs) {
>   		for_each_online_cpu(j)
> -			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
> +			any_count |= data_race(per_cpu(desc->kstat_irqs->cnt, j));
>   	}
>   
>   	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
> @@ -498,8 +498,7 @@ int show_interrupts(struct seq_file *p, void *v)
>   
>   	seq_printf(p, "%*d: ", prec, i);
>   	for_each_online_cpu(j)
> -		seq_printf(p, "%10u ", desc->kstat_irqs ?
> -					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
> +		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
>   
>   	raw_spin_lock_irqsave(&desc->lock, flags);
>   	if (desc->irq_data.chip) {
> diff --git a/scripts/gdb/linux/interrupts.py b/scripts/gdb/linux/interrupts.py
> index ef478e273791..7e50f3b9dfad 100644
> --- a/scripts/gdb/linux/interrupts.py
> +++ b/scripts/gdb/linux/interrupts.py
> @@ -37,7 +37,7 @@ def show_irq_desc(prec, irq):
>       any_count = 0
>       if desc['kstat_irqs']:
>           for cpu in cpus.each_online_cpu():
> -            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)
> +            any_count += cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
>   
>       if (desc['action'] == 0 or irq_desc_is_chained(desc)) and any_count == 0:
>           return text;
> @@ -45,7 +45,7 @@ def show_irq_desc(prec, irq):
>       text += "%*d: " % (prec, irq)
>       for cpu in cpus.each_online_cpu():
>           if desc['kstat_irqs']:
> -            count = cpus.per_cpu(desc['kstat_irqs'], cpu)
> +            count = cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt']
>           else:
>               count = 0
>           text += "%10u" % (count)
> @@ -177,7 +177,7 @@ def arm_common_show_interrupts(prec):
>           if desc == 0:
>               continue
>           for cpu in cpus.each_online_cpu():
> -            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu))
> +            text += "%10u" % (cpus.per_cpu(desc['kstat_irqs'], cpu)['cnt'])
>           text += "      %s" % (ipi_types[ipi].string())
>           text += "\n"
>       return text
Looks good.

For the newly added struct irqstat, adding annotated comments to explain 
each field would be beneficial.

Reviewed-by: Liu Song <liusong@linux.alibaba.com>


