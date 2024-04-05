Return-Path: <linux-kernel+bounces-133658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 355DD89A6BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664421C20897
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAD317557C;
	Fri,  5 Apr 2024 21:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKQof1J9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F5D174EF3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 21:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353927; cv=none; b=gdFLTh88VV2/n6dCBeEwxT8AWB5LajaM+CheEGP5QNi/WRZ9+KCgdSpkPnHdu+u27z000OjxVE2+J0dYRzCb5ypFPI6LcMBB3/NW96vrcQhNijbZrFoOFnKJvU2gV7z9kqgO3M0wecF7+1c4qSbljXhKGBbGsXwl+SwOXZOTy5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353927; c=relaxed/simple;
	bh=R7P/IXBN3U1X+IlN1yc+r7zwuk1qsaWQywc9Htpv00I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJ051vrG4y4SkXueL9cmIebKXMuD0gxIrRUbfsg6/dXtqYlyAGQs+HUwH5GuK4Hfr7haO+jiysEU9uktEkPp6+L4cr0+mOJEIKvZ9nLzj8ZYDcyESH197M42jlC7OXjWdr9zju5c9ANsIyWdxHf05Z71e6CriVnZLHmolM+aVRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKQof1J9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E760FC433F1;
	Fri,  5 Apr 2024 21:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712353926;
	bh=R7P/IXBN3U1X+IlN1yc+r7zwuk1qsaWQywc9Htpv00I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKQof1J9LxxtArQfGTsZehrLaaPz9mmN1dVepAPtSjaqObRtkEN5oXx5G/cDl1s07
	 PWxvY7qz81BhrFSdzCa5iol5DwUchCeVcieacBMH1/42z+8b7Fz291xKaR/ycggD2m
	 RQmapT3c0zDuaoTm+A8H+5vnHC1S2U2IqFc3sOYi/B1FnLnGOcmw165CZJSlF/fZo8
	 1svzQ5fs07D0a9bC7Et0tEv9ql5kl6qrREPvFMxtx/KgFOtpHLpHT6MaTPcYAxEOiu
	 T3DEiR6y+PvdPrVGkI9/Dlg3Fgu7Pu0N5NnF+9G8Jz4Q3DilenAgzaSxUMRnLctW66
	 lqXCnQ8gQRr5w==
Date: Fri, 5 Apr 2024 23:52:03 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>, Nick Piggin <npiggin@gmail.com>
Cc: Tejun Heo <tj@kernel.org>, Leonardo Bras <leobras@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	linux-kernel@vger.kernel.org, Junyao Zhao <junzhao@redhat.com>,
	Chris von Recklinghausen <crecklin@redhat.com>
Subject: Nohz_full on boot CPU is broken (was: Re: [PATCH v2 1/1] wq: Avoid
 using isolated cpus' timers on queue_delayed_work)
Message-ID: <ZhByg-xQv6_PC3Pd@localhost.localdomain>
References: <20240130010046.2730139-2-leobras@redhat.com>
 <20240402105847.GA24832@redhat.com>
 <Zg2qFinSkAOmRHcM@slm.duckdns.org>
 <20240403203814.GD31764@redhat.com>
 <20240405140449.GB22839@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240405140449.GB22839@redhat.com>

+Cc Nick

Le Fri, Apr 05, 2024 at 04:04:49PM +0200, Oleg Nesterov a écrit :
> On 04/03, Oleg Nesterov wrote:
> >
> > > > OTOH, Documentation/timers/no_hz.rst says
> > > >
> > > > 	Therefore, the
> > > > 	boot CPU is prohibited from entering adaptive-ticks mode.  Specifying a
> > > > 	"nohz_full=" mask that includes the boot CPU will result in a boot-time
> > > > 	error message, and the boot CPU will be removed from the mask.
> > > >
> > > > and this doesn't match the reality.
> > >
> > > Don't some archs allow the boot CPU to go down too tho? If so, this doesn't
> > > really solve the problem, right?
> >
> > I do not know. But I thought about this too.
> >
> > In the context of this discussion we do not care if the boot CPU goes down.
> > But we need at least one housekeeping CPU after cpu_down(). The comment in
> > cpu_down_maps_locked() says
> >
> > 	Also keep at least one housekeeping cpu onlined
> >
> > but it checks HK_TYPE_DOMAIN, and I do not know (and it is too late for me
> > to try to read the code ;) if housekeeping.cpumasks[HK_TYPE_TIMER] can get
> > empty or not.
> 
> This nearly killed me, but I managed to convince myself we shouldn't worry
> about cpu_down().
> 
> HK_FLAG_TIMER implies HK_FLAG_TICK.
> 
> HK_FLAG_TICK implies tick_nohz_full_setup() which sets
> tick_nohz_full_mask = non_housekeeping_mask.
> 
> When tick_setup_device() is called on a housekeeping CPU it does
> 		
> 	else if (tick_do_timer_boot_cpu != -1 &&
> 					!tick_nohz_full_cpu(cpu)) {
> 		tick_take_do_timer_from_boot();
> 		tick_do_timer_boot_cpu = -1;
> 
> 
> 	and this sets tick_do_timer_cpu = first-housekeeping-cpu.
> 
> cpu_down(tick_do_timer_cpu) will fail, tick_nohz_cpu_down() will nack it.
> 
> So cpu_down() can't make housekeeping.cpumasks[HK_FLAG_TIMER] empty and I
> still think that the change below is the right approach.
> 
> But probably WARN_ON() in housekeeping_any_cpu() makes sense anyway.
> 
> What do you think?

Good analysis on this nasty housekeeping VS tick code. I promised so many
times to cleanup this mess but things keep piling up.

It is indeed possible for the boot CPU to be a nohz_full CPU and as
you can see, it's only half-working. This is so ever since:

    08ae95f4fd3b (nohz_full: Allow the boot CPU to be nohz_full)

I wish I had nacked it before it got merged, especially as the changelog mentions
that the user could have solved this with modifying its setup... I would love
to revert that now but I don't know if anyone uses this and have it working
by chance somewhere... Should we continue to support a broken feature? Can we
break user ABI if it's already half-broken?

Anyway so during boot it's possible to have an empty
housekeeping_mask(HK_TYPE_TIMER) & cpu_online_mask. After boot though (provided
any CPU from the housekeeping_mask(HK_TYPE_TIMER) has actually booted, which
isn't even guaranteed if maxcpus= is passed...) the first online housekeeping can't
go down like you spotted.

Thanks.

