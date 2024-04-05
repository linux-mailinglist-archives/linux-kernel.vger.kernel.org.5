Return-Path: <linux-kernel+bounces-133107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3B21899EF4
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581511F21DD8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A6316DEDD;
	Fri,  5 Apr 2024 14:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dGlYVSZR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A3E3EA90
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712325990; cv=none; b=VA3/aYXIKAhms/XHZLHnMzDQJVd8rz5F2r0SmmpU9gSc3jxP5f0ThYvyGRuSHjYChXc5bnjhUIdru8Mw36fI5ogs2ur6sLiM7ouftGoC2nDYfoJmEOPYGNLLjRu/ZSUOZ/HKTu13c7TMCZ3vi1jnlD2NL0dUu1GJ6nFYvAHiKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712325990; c=relaxed/simple;
	bh=e+u4Ao5S+rmG2eUjE0RQd8JMFTOeOcQvXmjvrzNEayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R0yDrh0FjhocOkBJbM/+KRTcC7EtGC/5AsNO9kFOmRpdu6oNVVQ6etW+LOhvsySyFCCjiPGNq61O9uYw9cAqGrz4QNbe6rks9OefKmqGmmSU9G190ZdFGgaNOQSRsyVi9/bhL5EYQqCBHiXF2p6+cYFcRjL4/+wPJLQPbeXEeh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dGlYVSZR; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712325988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BW/ZzqPyokm6N/ohEkWVW4bty7+GiTWiikMeHfT8Uig=;
	b=dGlYVSZRdyQ0Zv5N+tuWLkq3kfTyWii0CtcmWGmUhSRtxtLmuDDLpnic9NJLtxuOBBqGyV
	MT1FFtsYYjE9ZiSMcjCFajqNDPP2woBQsC5EpRgM7sLariaaubeTTIiqoHhPvRxtBVj8an
	n47Vww+xIRpZrisweS/8LNjXjnxF5CY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-aZPfxSSnNYS6o1v-B2dPMg-1; Fri, 05 Apr 2024 10:06:22 -0400
X-MC-Unique: aZPfxSSnNYS6o1v-B2dPMg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0276A185A781;
	Fri,  5 Apr 2024 14:06:22 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.136])
	by smtp.corp.redhat.com (Postfix) with SMTP id 52EBBC017A0;
	Fri,  5 Apr 2024 14:06:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri,  5 Apr 2024 16:04:56 +0200 (CEST)
Date: Fri, 5 Apr 2024 16:04:49 +0200
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
Message-ID: <20240405140449.GB22839@redhat.com>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403203814.GD31764@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

On 04/03, Oleg Nesterov wrote:
>
> > > OTOH, Documentation/timers/no_hz.rst says
> > >
> > > 	Therefore, the
> > > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > > 	error message, and the boot CPU will be removed from the mask.
> > >
> > > and this doesn't match the reality.
> >
> > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > really solve the problem, right?
>
> I do not know. But I thought about this too.
>
> In the context of this discussion we do not care if the boot CPU goes down.
> But we need at least one housekeeping CPU after cpu_down(). The comment in
> cpu_down_maps_locked() says
>
> 	Also keep at least one housekeeping cpu onlined
>
> but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> empty or not.

This nearly killed me, but I managed to convince myself we shouldn't worry
about cpu_down().

HK_FLAG_TIMER implies HK_FLAG_TICK.

HK_FLAG_TICK implies tick_nohz_full_setup() which sets
tick_nohz_full_mask = non_housekeeping_mask.

When tick_setup_device() is called on a housekeeping CPU it does
		
	else if (tick_do_timer_boot_cpu != -1 &&
					!tick_nohz_full_cpu(cpu)) {
		tick_take_do_timer_from_boot();
		tick_do_timer_boot_cpu = -1;


	and this sets tick_do_timer_cpu = first-housekeeping-cpu.

cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.

So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
still think that the change below is the right approach.

But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.

What do you think?

Oleg.

> > > So it seems that we should fix housekeeping_setup() ? see the patch below.
> > >
> > > In any case the usage of cpu_present_mask doesn't look right to me.
> > >
> > > Oleg.
> > >
> > > --- a/kernel/sched/isolation.c
> > > +++ b/kernel/sched/isolation.c
> > > @@ -129,7 +154,7 @@ static int __init housekeeping_setup(char *str, unsigned long flags)
> > >  	cpumask_andnot(housekeeping_staging,
> > >  		       cpu_possible_mask, non_housekeeping_mask);
> > >
> > > -	if (!cpumask_intersects(cpu_present_mask, housekeeping_staging)) {
> > > +	if (!cpumask_test_cpu(smp_processor_id(), housekeeping_staging)) {
> > >  		__cpumask_set_cpu(smp_processor_id(), housekeeping_staging);
> > >  		__cpumask_clear_cpu(smp_processor_id(), non_housekeeping_mask);
> > >  		if (!housekeeping.flags) {
> > >


