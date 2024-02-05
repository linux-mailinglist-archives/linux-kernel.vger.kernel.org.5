Return-Path: <linux-kernel+bounces-53916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F2484A7FF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10297289EEF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A1813474A;
	Mon,  5 Feb 2024 20:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AoBZ6hj2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4605213472D
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 20:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707164922; cv=none; b=QCdC5H4x3TeDYzWTpMMsIX75hPgvmcCFP8koViH4zD5RQx/Tdk+y+KQp810G8vb7fIk4l4AJMI6O6g1uPU535pD6R/cqMSQMW0yrI6A6DoZZCihib75+Gj1bow5aIYitGkP+sjDHJmcSob92OGEBhgZ54H0A9EO45494T0P6RLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707164922; c=relaxed/simple;
	bh=XpivmY6ib69pXpZ7ii9oBxf6gCCiDNN1XjEi8/M3fCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sOEfgGBW4Z/wxBNmJc1edWyet3gKWZAImhatyoM9arRXwG9aMcQsLZGkAQKBLI3op7spppQwLxyWHMo9WUoMs1WzbJrUAjRdaMwBkJ3uYGJWGtzgmIhEATsrnN0UlpF2g7DsXGVBNfl49AYZDtelBV1zG/VNUzAQKFTkDG69t54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoBZ6hj2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B158AC433F1;
	Mon,  5 Feb 2024 20:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707164922;
	bh=XpivmY6ib69pXpZ7ii9oBxf6gCCiDNN1XjEi8/M3fCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AoBZ6hj26Um+kCTmNQWGH6P1pNsPabqL1nGMXcFoLs4Vp4NSjpsF5o3pJK5EnCPVx
	 hkWebOVgP3e2dR9l0Z9qv3CuEsg5oDOrvDNUcgcwT+12oM7+f0J6LmKnwlQDQsb2We
	 qY4Crmui5HrC53UHgMlxCEDDgu02viILJoOMJXawuv4Ykz00D7LOzv0gvdhOL7khan
	 bOk5g1CfXb7ANF8RmJhSNeTwyIuiXtt4eRoF9GWxcKDxRrUmWylSCbKCj8WLq9EseR
	 EaF7vvU8W56ojuBl4ct7pX0sa/Tf2GNDdlJwfggWBHgKDALB+XQAMtmAvLvOZGPkHc
	 l8M858HEw7vHg==
Date: Mon, 5 Feb 2024 21:28:38 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZcFE9vVTqyVZ_0SC@pavilion.home>
References: <ZbvHvKdpgqfsJp0E@localhost.localdomain>
 <871q9qucjy.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871q9qucjy.fsf@somnus>

Le Mon, Feb 05, 2024 at 04:59:45PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >> +static bool tmigr_handle_remote_up(struct tmigr_group *group,
> >> +				   struct tmigr_group *child,
> >> +				   void *ptr)
> >> +{
> >> +	struct tmigr_remote_data *data = ptr;
> >> +	u64 now, next = KTIME_MAX;
> >> +	struct tmigr_event *evt;
> >> +	unsigned long jif;
> >> +	u8 childmask;
> >> +
> >> +	jif = data->basej;
> >> +	now = data->now;
> >> +
> >> +	childmask = data->childmask;
> >> +
> >> +again:
> >> +	/*
> >> +	 * Handle the group only if @childmask is the migrator or if the
> >> +	 * group has no migrator. Otherwise the group is active and is
> >> +	 * handled by its own migrator.
> >> +	 */
> >> +	if (!tmigr_check_migrator(group, childmask))
> >> +		return true;
> >> +
> >> +	raw_spin_lock_irq(&group->lock);
> >> +
> >> +	evt = tmigr_next_expired_groupevt(group, now);
> >> +
> >> +	if (evt) {
> >> +		unsigned int remote_cpu = evt->cpu;
> >> +
> >> +		raw_spin_unlock_irq(&group->lock);
> >> +
> >> +		next = tmigr_handle_remote_cpu(remote_cpu, now, jif);
> >> +
> >> +		/* check if there is another event, that needs to be handled */
> >> +		goto again;
> >> +	} else {
> >> +		raw_spin_unlock_irq(&group->lock);
> >> +	}
> >> +
> >> +	/*
> >> +	 * Update of childmask for the next level and keep track of the expiry
> >> +	 * of the first event that needs to be handled
> >> +	 */
> >> +	data->childmask = group->childmask;
> >> +	data->firstexp = next;
> >
> > So assume we have:
> >
> >             [GRP1:0]
> >         migrator = [GRP0:0]
> >         active   = [GRP0:0]
> >         nextevt  = TIMER3
> >         /                    \
> >     [GRP0:0]                  [GRP0:1]
> >  migrator = CPU0           migrator = NONE
> >  active   = CPU0           active   = NONE
> >  nextevt  = KTIME_MAX      nextevt  = TIMER3
> >     /         \                /         \
> >    0           1              2           3
> >   idle       idle           idle         idle (TIMER3)
> >
> > Then CPU 0 goes idle:
> >
> >             [GRP1:0]
> >         migrator = NONE
> >         active   = NONE
> >         nextevt  = TIMER3
> >         /                    \
> >     [GRP0:0]                  [GRP0:1]
> >  migrator = NONE           migrator = NONE
> >  active   = NONE           active   = NONE
> >  nextevt  = KTIME_MAX      nextevt  = TIMER3
> >     /         \                /         \
> >    0           1              2           3
> >   idle       idle           idle         idle (TIMER3)
> >
> > CPU 0 is the idle migrator and its tmc->wakeup is TIMER3.
> > But CPU 0 has a local timer that expires before TIMER3.
> >
> > When that timer interrupt fires, it raises the softirq, which
> > executes on IRQ tail. So CPU0 eventually calls tmigr_handle_remote()
> > before TIMER3 has expired.
> >
> > This leads to tmigr_next_expired_groupevt() to return NULL and then
> > data->firstexp = KTIME_MAX and then tmc->wakeup = KTIME_MAX.
> >
> > Later on, tmigr_new_timer() is called with a KTIME_MAX global
> > event and so tmc->wakeup stays with KTIME_MAX, ignoring TIMER3.
> >
> > It looks like you need to handle the tmigr_next_expired_groupevt()
> > case returning NULL.
> 
> Yes. You are right. group->next_expiry is updated via
> tmigr_next_expired_groupevt(). So I should take this value to rely on
> for the firstevt.
> 
> But with this, we do not need the return value of
> tmigr_handle_remote_cpu(). When the upperst level is inactive and there
> is a timer (e.g. propagated there by tmigr_handle_remote_cpu()), the
> return value of tmigr_handle_remote_cpu() is the next_expiry of the top
> level group. But this value is also noticed by walking the hierarchy up
> to the top level with tmigr_handle_remote_up().

Indeed that's a nice simplification!

This also cure an issue with KTIME_MAX overwriting data->firstexp in
tmigr_handle_remote_up() while walking upper level after an expiration
on below level.

Thanks.

