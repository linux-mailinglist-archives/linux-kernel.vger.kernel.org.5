Return-Path: <linux-kernel+bounces-136834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D80B489D8D1
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791C21F2385D
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1083C12BE8B;
	Tue,  9 Apr 2024 12:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtE+LG9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3012AAD3
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664277; cv=none; b=ShYDSCs+NsMsCfYVKPNc5tZW8T5C9zhN2AFWLctIvT28tAQjUDZ3ErenopAJtkVXM5M0aCDrdUCBTrLjxF5zr5NMhwG0X04+Wvfr6U1f2MOcVebpt2jU2d01bieASQWdwwZ8V9qMkrSlYWEYt5ckOpeD9Vx+62JpoZMsXSKY984=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664277; c=relaxed/simple;
	bh=SJnZkNPc1CXXzqQ0bnkucXbJjyQtreGgabj+zHnZfmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SnU4Egbwn4YSbd4UWmJf/3Ee9YdkNBztI8iwIhByVIu+jhZ41tAiskOq5HNqLt5y+s5UhBrqeookwKOlqPeLT2K+4n5YN5sqnD/6MAsn3sSVs3OF/JFStLx1pZHwdWyRHa7AVXcbSGpyiQ08yNeVSO2FPJysY/RLT65SqM58+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FtE+LG9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EEB0C433C7;
	Tue,  9 Apr 2024 12:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664276;
	bh=SJnZkNPc1CXXzqQ0bnkucXbJjyQtreGgabj+zHnZfmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FtE+LG9CkOx2xLxiqPOWytg9pLYD8qjJahvq/7IX0a6gelLa1wBVa/NJHUXgi82sa
	 IfAFs7FgqGH8OeAPv/7c6baKyZUGLHR/htlHdTbT0FzRCKzhF1rqDYp4eKYI59rikv
	 r9S+xT3top5i5VVpuyESAj0bMzw8Nq1YUPXCfDsEinsFe7kU2+/LV/iwcRPWO3vCU6
	 hUnFMmpT3Njs3Pdy3BPpjeFg39Es8fMX80pA0Fy33x2qNk2qPbkbTJOfnvfnz6EM89
	 fSQ9wFDuRDyTqbmCKVwhVxJrV65cWQil2qM5heE0xgwhYm0cjcD4MK9jXQohVFNL/o
	 hyTA3yfKZaeZA==
Date: Tue, 9 Apr 2024 14:04:34 +0200
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
Message-ID: <ZhUu0uQxPgcXmQes@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
 <ZhByg-xQv6_PC3Pd@localhost.localdomain>
 <20240407130914.GA10796@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407130914.GA10796@redhat.com>

Le Sun, Apr 07, 2024 at 03:09:14PM +0200, Oleg Nesterov a écrit :
> On 04/05, Frederic Weisbecker wrote:
> >
> > +Cc Nick
> >
> > Le Fri, Apr 05, 2024 at 04:04:49PM +0200, Oleg Nesterov a écrit :
> > > On 04/03, Oleg Nesterov wrote:
> > > >
> > > > > > OTOH, Documentation/timers/no_hz.rst says
> > > > > >
> > > > > > 	Therefore, the
> > > > > > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > > > > > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > > > > > 	error message, and the boot CPU will be removed from the mask.
> > > > > >
> > > > > > and this doesn't match the reality.
> > > > >
> > > > > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > > > > really solve the problem, right?
> > > >
> > > > I do not know. But I thought about this too.
> > > >
> > > > In the context of this discussion we do not care if the boot CPU goes down.
> > > > But we need at least one housekeeping CPU after cpu_down(). The comment in
> > > > cpu_down_maps_locked() says
> > > >
> > > > 	Also keep at least one housekeeping cpu onlined
> > > >
> > > > but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> > > > to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> > > > empty or not.
> > >
> > > This nearly killed me, but I managed to convince myself we shouldn't worry
> > > about cpu_down().
> > >
> > > HK_FLAG_TIMER implies HK_FLAG_TICK.
> > >
> > > HK_FLAG_TICK implies tick_nohz_full_setup() which sets
> > > tick_nohz_full_mask = non_housekeeping_mask.
> > >
> > > When tick_setup_device() is called on a housekeeping CPU it does
> > >
> > > 	else if (tick_do_timer_boot_cpu != -1 &&
> > > 					!tick_nohz_full_cpu(cpu)) {
> > > 		tick_take_do_timer_from_boot();
> > > 		tick_do_timer_boot_cpu = -1;
> > >
> > >
> > > 	and this sets tick_do_timer_cpu = first-housekeeping-cpu.
> > >
> > > cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.
> > >
> > > So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
> > > still think that the change below is the right approach.
> > >
> > > But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.
> > >
> > > What do you think?
> >
> > Good analysis on this nasty housekeeping VS tick code. I promised so many
> > times to cleanup this mess but things keep piling up.
> >
> > It is indeed possible for the boot CPU to be a nohz_full CPU and as
> > you can see, it's only half-working. This is so ever since:
> >
> >     08ae95f4fd3b (nohz_full: Allow the boot CPU to be nohz_full)
> 
> Thanks... So this is intentional. I was confused by
> 
> 	Therefore, the
> 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> 	error message, and the boot CPU will be removed from the mask.
> 
> from Documentation/timers/no_hz.rst
> 
> > I would love
> > to revert that now but I don't know if anyone uses this and have it working
> > by chance somewhere... Should we continue to support a broken feature? Can we
> > break user ABI if it's already half-broken?
> 
> Well, the changelog says
> 
>     nohz_full has been trialed at a large supercomputer site and found to
>     significantly reduce jitter. In order to deploy it in production, they
>     need CPU0 to be nohz_full
> 
> so I guess this feature has users.
> 
> But after the commit aae17ebb53cd3da ("workqueue: Avoid using isolated cpus'
> timers on queue_delayed_work") the kernel will crash at boot time if the boot
> CPU is nohz_full.

Right but there are many possible calls to housekeeping on boot before the
first housekeeper becomes online.

Thanks.

