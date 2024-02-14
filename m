Return-Path: <linux-kernel+bounces-66124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B90855758
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A3B25E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:36:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736951420A8;
	Wed, 14 Feb 2024 23:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lfqk1F6e";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3f1nx5PQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D292574B
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953799; cv=none; b=YeXBqn9xkxq/vND02Nr2r4RSe5J5rj8sS5DFRaK+FBju3r8m/5K2odbij22ACMAW1oyPLDfiZmc7BgcWCiXlP0EgP/Olxg6F9MSH4Ac/lDMfj+H2MsNWjnArj3TvL0WRa/TsDxIsl/Wk3wKl7vzxXUF8I3HOO6Jf/Vuh3GHuHj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953799; c=relaxed/simple;
	bh=zd6L+JirXYb9RJJTMyqMFnBDXyLuZEtp3hoaLf51cYM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SSv1NlrRal+0XjCeVYiIUvr2eHfKuX3D/6vAfwr+AO+bgYfrLGglEZdFIvXx4xlede8w+hSBhycZnyigNokLuh4mKIODxbnaQ2xy6e0mBYnu/gIdR2R/Rf3uyifJXiQ3ImUTepNl+xsrIqN75lSngvE4ePM96rDbRS5a9544lX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lfqk1F6e; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3f1nx5PQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707953795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnraHAYZS5nKpdZRhg4CnvYWWLS8hA9ptlRZifrVoJ8=;
	b=Lfqk1F6eDyuQFYbVSibifuM3J2rFv2z+qtsr1jyhAdlErdrmr4b9jBHwxynnADP8XXTbjb
	hFWsVgJ4aWNO7be7kXEGr66fJeb2zb1hsn+5BlQXfE/3G2FicI3dEytnZrvyLYNcCb30zC
	We0cSL38XjGmKSJYdCsiXFAbO7o3c8q7oBpHypKhSE7V6UIpLPfzSF63Sy73+zsLq3wawH
	6p01trfUmNyU3uNz2IQ22mUC8wXopk3y7AD23O2OAupuhEERMiZpqmjacq2lAAg3cLHeeG
	coExPmunZ9wfdlLRhMF+n4YmWIPibke5NzZGKQrcDnYK17P0SAnvquK/A99dPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707953795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xnraHAYZS5nKpdZRhg4CnvYWWLS8hA9ptlRZifrVoJ8=;
	b=3f1nx5PQq7WMeZ+/Wd0NAtORdx7zOeWjX9Jz+/AXwCVmyab4gfN1fX19++yXFvC38zWxlL
	2LbegzGv4yzCnKCQ==
To: Bitao Hu <yaoma@linux.alibaba.com>, dianders@chromium.org,
 akpm@linux-foundation.org, pmladek@suse.com, maz@kernel.org,
 liusong@linux.alibaba.com
Cc: linux-kernel@vger.kernel.org, Bitao Hu <yaoma@linux.alibaba.com>
Subject: Re: [PATCH 2/3] watchdog/softlockup: report the most time-consuming
 hardirq
In-Reply-To: <20240123121223.22318-3-yaoma@linux.alibaba.com>
References: <20240123121223.22318-1-yaoma@linux.alibaba.com>
 <20240123121223.22318-3-yaoma@linux.alibaba.com>
Date: Thu, 15 Feb 2024 00:36:34 +0100
Message-ID: <8734tufwjh.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 23 2024 at 20:12, Bitao Hu wrote:
> +/*
> + * If the proportion of time spent handling irq exceeds 50% during a sampling period,
> + * then it is necessary to tally the handling time of each irq.
> + */
> +static inline bool need_trace_irqtime(int type)
> +{
> +	int tail = this_cpu_read(cpustat_tail);
> +
> +	if (--tail == -1)
> +		tail = 4;
> +	return this_cpu_read(cpustat_diff[tail][type]) > sample_period/2;
> +}
> +
> +static void irq_handler_entry_callback(void *data, int irq, struct irqaction *action)
> +{
> +	this_cpu_ptr(irq_to_desc(irq)->irq_time)->start_time = local_clock();
> +}
> +
> +static void irq_handler_exit_callback(void *data, int irq, struct irqaction *action, int ret)
> +{
> +	u64 delta;
> +	struct per_irqtime *irq_time;
> +
> +	if (test_bit(SOFTLOCKUP_HARDIRQ, this_cpu_ptr(&softlockup_flags))) {
> +		irq_time = this_cpu_ptr(irq_to_desc(irq)->irq_time);
> +		delta = local_clock() - irq_time->start_time;
> +		irq_time->delta += delta;
> +	}
> +}

I can understand what you are trying to achieve, but you inflict the
overhead of two tracepoints to every interrupt unconditionally.

For the vast majority of usage scenarios that's just pointless overhead
for no value. That's not acceptable at all.

Instrumentation and debugging has to find the least intrusive solution
and not just go for the perfect picture. Remember: perfect is the enemy
of good.

You really have to think hard about what you really need to achieve for
a particular problem case.

In this case it's completely sufficient to know the number of interrupts
which happened since softlockup detection took a snapshot and the actual
analysis.

That's especially true when interrupt time accounting is active because
then the only interesting information is which interrupts fired during
the observation period.

Even if that's not available it is a reasonable assumption that the
number of interrupts during the observation period gives a pretty
conclusive hint about the potential cause of the problem.

This is not meant to find the oddball issue of an interrupt handler
which consumes a lot of time per invocation. This is about storm
detection where the handler runs briefly and actually returns
IRQ_HANDLED so that the spurious detection does not catch it.

This can be implemented with exactly zero overhead for the good case,
keeping it self contained to the interrupt core code and providing
sensible interfaces for the watchdog code.

See the uncompiled patch for illustration below.

As a side note: While C does not allow proper encapsulation it's a non
starter to fiddle with the interrupt descriptor internals in random code
just because the compiler allows you to do so. While not enforced there
are clear boundaries and we went a long way to encapsulate this.

Thanks,

        tglx
---
 include/linux/irqdesc.h |    9 +++++++--
 kernel/irq/internals.h  |    2 +-
 kernel/irq/irqdesc.c    |   32 ++++++++++++++++++++++++++------
 kernel/irq/proc.c       |    9 +++------
 4 files changed, 37 insertions(+), 15 deletions(-)

--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -17,6 +17,11 @@ struct irq_desc;
 struct irq_domain;
 struct pt_regs;
 
+struct irqstat {
+	unsigned int	cnt;
+	unsigned int	ref;
+};
+
 /**
  * struct irq_desc - interrupt descriptor
  * @irq_common_data:	per irq and chip data passed down to chip functions
@@ -55,7 +60,7 @@ struct pt_regs;
 struct irq_desc {
 	struct irq_common_data	irq_common_data;
 	struct irq_data		irq_data;
-	unsigned int __percpu	*kstat_irqs;
+	struct irqstat __percpu	*kstat_irqs;
 	irq_flow_handler_t	handle_irq;
 	struct irqaction	*action;	/* IRQ action list */
 	unsigned int		status_use_accessors;
@@ -119,7 +124,7 @@ extern struct irq_desc irq_desc[NR_IRQS]
 static inline unsigned int irq_desc_kstat_cpu(struct irq_desc *desc,
 					      unsigned int cpu)
 {
-	return desc->kstat_irqs ? *per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static inline struct irq_desc *irq_data_to_desc(struct irq_data *data)
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -258,7 +258,7 @@ static inline void irq_state_set_masked(
 
 static inline void __kstat_incr_irqs_this_cpu(struct irq_desc *desc)
 {
-	__this_cpu_inc(*desc->kstat_irqs);
+	__this_cpu_inc(desc->kstat_irqs->cnt);
 	__this_cpu_inc(kstat.irqs_sum);
 }
 
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -122,7 +122,7 @@ static void desc_set_defaults(unsigned i
 	desc->name = NULL;
 	desc->owner = owner;
 	for_each_possible_cpu(cpu)
-		*per_cpu_ptr(desc->kstat_irqs, cpu) = 0;
+		*per_cpu_ptr(desc->kstat_irqs, cpu) = (struct irqstat) { };
 	desc_smp_init(desc, node, affinity);
 }
 
@@ -418,8 +418,8 @@ static struct irq_desc *alloc_desc(int i
 	desc = kzalloc_node(sizeof(*desc), GFP_KERNEL, node);
 	if (!desc)
 		return NULL;
-	/* allocate based on nr_cpu_ids */
-	desc->kstat_irqs = alloc_percpu(unsigned int);
+
+	desc->kstat_irqs = alloc_percpu(struct irqstat);
 	if (!desc->kstat_irqs)
 		goto err_desc;
 
@@ -952,8 +952,7 @@ unsigned int kstat_irqs_cpu(unsigned int
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 
-	return desc && desc->kstat_irqs ?
-			*per_cpu_ptr(desc->kstat_irqs, cpu) : 0;
+	return desc && desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, cpu) : 0;
 }
 
 static bool irq_is_nmi(struct irq_desc *desc)
@@ -975,10 +974,31 @@ static unsigned int kstat_irqs(unsigned
 		return data_race(desc->tot_count);
 
 	for_each_possible_cpu(cpu)
-		sum += data_race(*per_cpu_ptr(desc->kstat_irqs, cpu));
+		sum += data_race(per_cpu(desc->kstat_irqs->cnt, cpu));
 	return sum;
 }
 
+void kstat_snapshot_irqs(void)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc) {
+		if (!desc->kstat_irqs)
+			continue;
+		this_cpu_write(desc->kstat_irqs->ref, this_cpu_read(desc->kstat_irqs->cnt));
+	}
+}
+
+unsigned int kstat_get_irq_since_snapshot(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	if (!desc || !desc->kstat_irqs)
+		return 0;
+	return this_cpu_read(desc->kstat_irqs->cnt) - this_cpu_read(desc->kstat_irqs->ref);
+}
+
 /**
  * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -488,18 +488,15 @@ int show_interrupts(struct seq_file *p,
 	if (!desc || irq_settings_is_hidden(desc))
 		goto outsparse;
 
-	if (desc->kstat_irqs) {
-		for_each_online_cpu(j)
-			any_count |= data_race(*per_cpu_ptr(desc->kstat_irqs, j));
-	}
+	if (desc->kstat_irqs)
+		any_count = data_race(desc->tot_count);
 
 	if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
 		goto outsparse;
 
 	seq_printf(p, "%*d: ", prec, i);
 	for_each_online_cpu(j)
-		seq_printf(p, "%10u ", desc->kstat_irqs ?
-					*per_cpu_ptr(desc->kstat_irqs, j) : 0);
+		seq_printf(p, "%10u ", desc->kstat_irqs ? per_cpu(desc->kstat_irqs->cnt, j) : 0);
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 	if (desc->irq_data.chip) {

