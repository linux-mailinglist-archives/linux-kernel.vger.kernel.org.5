Return-Path: <linux-kernel+bounces-130591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F8C897A31
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E266828CA01
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BD15688F;
	Wed,  3 Apr 2024 20:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sfor8slN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71335155A59
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712176791; cv=none; b=aQ+LOQ5AOnnzX5XToS4NHSxSNBpqtfw5VuURhgqdhSMTQ2rP+39IaPze9lAsLfYW2Y0ks7LpR2ya7sd1EMHAFBiHbZ8qk4/V9ICTmSOQS6QhKiREE+EF77yPdwLV52e6FMyrO2NLeP4b6atqBf4SsIthKFO6lW4jFHYeJj1Xeh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712176791; c=relaxed/simple;
	bh=eOi+5WikSTorjSEPPxKitefyYKeYvbuIEeHrzNbFRQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbmdWqrMcs9pJVpTyTELeDWwA5dxHP8sX1XNxVVaDNioCv1PiUy3ud8uvQaLOor2QKLQvVYfz8Kfgk4imFH3QyL4Uvm4U/9vSJJkrqwS3tyDVn9+DwbQ1CZQTn7CaiwWh1EllfUWsDkbsNnHFP/IIb3HquQpH5dbDp4KTmZp5R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sfor8slN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712176788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=10W1a6ACeEYknqtbR5jDT5gL3yupRWkQ7v3GNEKtOOo=;
	b=Sfor8slNidH6RapnnZfX/s1/kwR9H4SCRJ9aqpR1PeSe6p9zqs/6TxrmWDuUlIvcO29U7g
	HZs9E1koVWdhuunNsLvQcJgfXG7njK4c/0dI6O/drCCMGXnFHeoUUOH9SlVjP4pECe0MrO
	yWkUKRm84o5erktw/+PZmOxTtqj3Fdg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-EfadVLGUMnSNE28BtlkcVA-1; Wed, 03 Apr 2024 16:39:47 -0400
X-MC-Unique: EfadVLGUMnSNE28BtlkcVA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B4C6D863012;
	Wed,  3 Apr 2024 20:39:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.49])
	by smtp.corp.redhat.com (Postfix) with SMTP id 0E24D2166B32;
	Wed,  3 Apr 2024 20:39:43 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Apr 2024 22:38:22 +0200 (CEST)
Date: Wed, 3 Apr 2024 22:38:14 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Tejun Heo <tj@kernel.org>
Cc: Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v2 1/1] wq: Avoid using isolated cpus' timers on
 queue_delayed_work
Message-ID: <20240403203814.GD31764@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zg2qFinSkAOmRHcM@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Hi Tejun,

On 04/03, Tejun Heo wrote:
>
> (cc'ing Frederic and quoting whole body)
>
> Hello, Oleg.
>
> On Tue, Apr 02, 2024 at 12:58:47PM +0200, Oleg Nesterov wrote:
> > This patch was applied as aae17ebb53cd3da but as Chris reports with this
> > commit the kernel can crash at boot time because __queue_delayed_work()
> > doesn't check that housekeeping_any_cpu() returns a valid cpu < nr_cpu_ids.
> >
> > Just boot the kernel with nohz_full=mask which includes the boot cpu, say
> > nohz_full=0-6 on a machine with 8 CPUs. __queue_delayed_work() will use
> > add_timer_on(timer, NR_CPUS /* returned by housekeeping_any_cpu */) until
> > start_secondary() brings CPU 7 up.
> >
> > The problem is simple, but I do not know what should we do, I know nothing
> > about CPU isolation.
> >
> > We can fix __queue_delayed_work(), this is simple, but other callers of
> > housekeeping_any_cpu() seem to assume it must always return a valid CPU
> > too. So perhaps we should change housekeeping_any_cpu()
>
> Yeah, patching this up from wq side is easy but housekeeping_any_cpu()
> always being able to pick a housekeeping CPU would be better.
>
> > -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			if (cpu < nr_cpu_ids)
> > +				return cpu;
> >
> > ?
> >
> > But I'm afraid this can hide other problems. May be
> >
> > -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> > +			if (cpu < nr_cpu_ids)
> > +				return cpu;
> > +
> > +			WARN_ON(system_state > SYSTEM_BOOTING);
> >
> > ?
> >
> > -------------------------------------------------------------------------------
> > OTOH, Documentation/timers/no_hz.rst says
> >
> > 	Therefore, the
> > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > 	error message, and the boot CPU will be removed from the mask.
> >
> > and this doesn't match the reality.
>
> Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> really solve the problem, right?

I do not know. But I thought about this too.

In the context of this discussion we do not care if the boot CPU goes down.
But we need at least one housekeeping CPU after cpu_down(). The comment in
cpu_down_maps_locked() says

	Also keep at least one housekeeping cpu onlined

but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
empty or not.

Oleg.	

> > So it seems that we should fix housekeeping_setup() ? see the patch below.
> >
> > In any case the usage of cpu_present_mask doesn't look right to me.
> >
> > Oleg.
> >
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
> >  	cpumask_andnot(housekeeping_staging,
> >  		       cpu_possible_mask, non_housekeeping_mask);
> >
> > -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> > +	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
> >  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
> >  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> >  		if (!housekeeping.flags) {
> >


