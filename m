Return-Path: <linux-kernel+bounces-136836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D6E989D8D5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40DE82895DE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3842412C531;
	Tue,  9 Apr 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMM4y0+B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183912B14F
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664343; cv=none; b=hwnuZUNFPm0xZU2JSx/Y707iql/Yg4oYW0LwLaPPQnxod7GdoDC7kyWrdGOxPJx4YFmB3EHyi3WW9TH0SLtl7Gw0MtqqtoJ/sWYuRYf91coJak0Z9Rc9oIr6z0zkuDOtfp7eHSP9M9mMvPDcG350ipaHDVGBQaZpsFBX4jQFY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664343; c=relaxed/simple;
	bh=rB7F6QBtKpM2186uH8oTdXauJTkSKgKa/TE7t8fJJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cewotJv/aNGJlZN97fSpnTETkBNG0SzT/VT/lBlA9kOSg3OYdvqkcE3ktDRe7Th7cZMCM1e8Dd6dikipYPlfg6pdS83dVqk49/kzxORmNe0ODlse8M5CWi9ATEO4wJ8cLBE/zwHWmC+PMdKnKkdi/sG+P2lFum7lLybZjCXUHqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uMM4y0+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56CAC43390;
	Tue,  9 Apr 2024 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664343;
	bh=rB7F6QBtKpM2186uH8oTdXauJTkSKgKa/TE7t8fJJrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uMM4y0+BqMXwWTyaiCHwO4zoAYf13RmSVA68h9Zq3pHIfktxfkynXTTHwd0CvnbiT
	 NkVmqJuAtIj1jv+7e3ybM8Za/eRSgoImffdcfUvmAt08uZjVoltgmsaYAhdthSmlFc
	 s9oLgCNrrbGBEg3/ALranj4qzcgXsLZDMVUZBMNozwctVBhW5z6uh8YKGJiKSoJyRC
	 48DBf/B0E1hfRZKbHLn7qaXXTjqvyKxPTxG1+NSdE0RkGCfVNW2M58VkTTKlGRQO83
	 DOLmj3fEuVXyqDkRdJQq5d3aunnBG35XLzRfK9+KqCF/XobYqv3YMGKQqTJkpzL+zO
	 ZpuIPAIRrr4eg==
Date: Tue, 9 Apr 2024 14:05:40 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Nick Piggin <npiggin@gmail.com>, Tejun Heo <tj@kernel.org>,
	Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Re: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq:
 Avoid using isolated cpus' timers on queue_delayed_work)
Message-ID: <ZhUvFFeKfFtJGSY8@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
 <20240407135248.GB10796@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407135248.GB10796@redhat.com>

Le Sun, Apr 07, 2024 at 03:52:48PM +0200, Oleg Nesterov a écrit :
> On 04/07, Oleg Nesterov wrote:
> >
> > On 04/05, Frederic Weisbecker wrote:
> > >
> > > +Cc Nick
> > >
> > > Le Fri, Apr 05, 2024 at 04:04:49PM +0200, Oleg Nesterov a écrit :
> > > > On 04/03, Oleg Nesterov wrote:
> > > > >
> > > > > > > OTOH, Documentation/timers/no_hz.rst says
> > > > > > >
> > > > > > > 	Therefore, the
> > > > > > > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > > > > > > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > > > > > > 	error message, and the boot CPU will be removed from the mask.
> > > > > > >
> > > > > > > and this doesn't match the reality.
> > > > > >
> > > > > > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > > > > > really solve the problem, right?
> > > > >
> > > > > I do not know. But I thought about this too.
> > > > >
> > > > > In the context of this discussion we do not care if the boot CPU goes down.
> > > > > But we need at least one housekeeping CPU after cpu_down(). The comment in
> > > > > cpu_down_maps_locked() says
> > > > >
> > > > > 	Also keep at least one housekeeping cpu onlined
> > > > >
> > > > > but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> > > > > to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> > > > > empty or not.
> > > >
> > > > This nearly killed me, but I managed to convince myself we shouldn't worry
> > > > about cpu_down().
> > > >
> > > > HK_FLAG_TIMER implies HK_FLAG_TICK.
> > > >
> > > > HK_FLAG_TICK implies tick_nohz_full_setup() which sets
> > > > tick_nohz_full_mask = non_housekeeping_mask.
> > > >
> > > > When tick_setup_device() is called on a housekeeping CPU it does
> > > >
> > > > 	else if (tick_do_timer_boot_cpu != -1 &&
> > > > 					!tick_nohz_full_cpu(cpu)) {
> > > > 		tick_take_do_timer_from_boot();
> > > > 		tick_do_timer_boot_cpu = -1;
> > > >
> > > >
> > > > 	and this sets tick_do_timer_cpu = first-housekeeping-cpu.
> > > >
> > > > cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.
> > > >
> > > > So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
> > > > still think that the change below is the right approach.
> > > >
> > > > But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.
> > > >
> > > > What do you think?
> > >
> > > Good analysis on this nasty housekeeping VS tick code. I promised so many
> > > times to cleanup this mess but things keep piling up.
> > >
> > > It is indeed possible for the boot CPU to be a nohz_full CPU and as
> > > you can see, it's only half-working. This is so ever since:
> > >
> > >     08ae95f4fd3b (nohz_full: Allow the boot CPU to be nohz_full)
> >
> > Thanks... So this is intentional. I was confused by
> >
> > 	Therefore, the
> > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > 	error message, and the boot CPU will be removed from the mask.
> >
> > from Documentation/timers/no_hz.rst
> >
> > > I would love
> > > to revert that now but I don't know if anyone uses this and have it working
> > > by chance somewhere... Should we continue to support a broken feature? Can we
> > > break user ABI if it's already half-broken?
> >
> > Well, the changelog says
> >
> >     nohz_full has been trialed at a large supercomputer site and found to
> >     significantly reduce jitter. In order to deploy it in production, they
> >     need CPU0 to be nohz_full
> >
> > so I guess this feature has users.
> >
> > But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolated cpus'
> > timers on queue_delayed_work") the kernel will crash at boot time if the boot
> > CPU is nohz_full.
> >
> > So we need a workaround at least. I am starting to think I will send a trivial
> > patch which changes __queue_delayed_work() to validate the cpu returned by
> > housekeeping_any_cpu(HK_TYPE_TIMER).
> >
> > But perhaps something like below makes more sense as a (stupid) workaround?
> 
> Or simply
> 
> 
> diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> index 373d42c707bc..e912555c6fc8 100644
> --- a/kernel/sched/isolation.c
> +++ b/kernel/sched/isolation.c
> @@ -46,7 +46,11 @@ int housekeeping_any_cpu(enum hk_type type)
>  			if (cpu < nr_cpu_ids)
>  				return cpu;
>  
> -			return cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			cpu = cpumask_any_and(housekeeping.cpumasks[type], cpu_online_mask);
> +			if (cpu < nr_cpu_ids)
> +				return cpu;
> +
> +			WARN_ON_ONCE(system_state == SYSTEM_RUNNING);
>  		}
>  	}
>  	return smp_processor_id();

Yep, looks good!

Thanks.

