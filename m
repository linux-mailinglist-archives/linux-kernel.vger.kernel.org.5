Return-Path: <linux-kernel+bounces-43563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BC584158A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6614B1C24413
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A1915958D;
	Mon, 29 Jan 2024 22:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlI9wuNW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE33E604C5
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706566909; cv=none; b=tTj6tTv7qP/pRjmJG64qeZQZlxiuvi6fVJGt2xCulZcRPzCdlAjgaEgGARaPryAPAuBub6rH/yAFE/1BXYw5j9OChmlrNJ1NnU10NcjE1XtBMKL+lilCcXPMdJJTw3F9c34sirrYbg4KicOO4f9pdVk+TctADHjHNaGtWLqeT6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706566909; c=relaxed/simple;
	bh=FTMWuaADebvmwGwTX/rc57uT2xejBM2n+L472Cqyuyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tLf8xgNCjvWXJ2+J/otFAZ3anjn2Xiu8GwNrr7MrdSfZt7qn2Omvhn9/SfFJdJTSKR9b/OC8qF8nNd8co1v7x7OCpUh4cSb/eoI0PPp0J9VJAvPS7wmu4VBoQZC3cgxCE54jK8CvXZ7m2Y51GrzAWu2cYEPvDIvJ7i1olZP5+v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlI9wuNW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0891CC433C7;
	Mon, 29 Jan 2024 22:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706566909;
	bh=FTMWuaADebvmwGwTX/rc57uT2xejBM2n+L472Cqyuyo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OlI9wuNWhjAsjVAuXRUxU6IauebnuhJP4vkYNGXU9ograN3cFwPCtJSJeAkMFMkkr
	 h3VPeYjIgq61f6nedPm3tyIZcIPvcgfeWZ/9Kl27i+1Tx/V+nrpBLTMS/CMizKF3hF
	 nQKkce0b7vYfXIvhXEjG3JocXMTQWrR2i29h8TvrpXtjcWDDdinEBtciBtnlgthgPI
	 QLgRWOmj5eTL3OprVEGw3jqinkuFfdjSueB5SoZksYJaV3EBTUh/3ubt+fgI0jtiaq
	 LTXwFbZGJ3dkAynZzg2hRCFbbtT2BKdu9BZ8+iFIB6j4Po18y+Za0bth2dGfeJnqUY
	 Kh5Uh7YVW1jbQ==
Date: Mon, 29 Jan 2024 23:21:46 +0100
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <Zbgk-q863VU6yZKm@pavilion.home>
References: <ZbWJtkAj9z0S9xsH@pavilion.home>
 <87sf2gqups.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf2gqups.fsf@somnus>

Le Mon, Jan 29, 2024 at 11:50:39AM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >> +static bool tmigr_inactive_up(struct tmigr_group *group,
> >> +			      struct tmigr_group *child,
> >> +			      void *ptr)
> >> +{
> >> +	union tmigr_state curstate, newstate, childstate;
> >> +	struct tmigr_walk *data = ptr;
> >> +	bool walk_done;
> >> +	u8 childmask;
> >> +
> >> +	childmask = data->childmask;
> >> +	curstate.state = atomic_read(&group->migr_state);
> >> +	childstate.state = 0;
> >> +
> >> +	do {
> >
> > So I got the confirmation from Boqun (+Cc) and Paul that a failing cmpxchg
> > may not order the load of the old value against subsequent loads. And
> > that may apply to atomic_try_cmpxchg() as well.
> >
> > Therefore you not only need to turn group->migr_state read into
> > an atomic_read_acquire() but you also need to do this on each iteration
> > of this loop. For example you can move the read_acquire right here.
> 
> I tried to read and understand more about the memory barriers especially
> the acquire/release stuff. So please correct me whenever I'm wrong.
> 
> We have to make sure that the child/group state values contain the last
> updates and prevent reordering to be able to rely on those values.
> 
> So I understand, that we need the atomic_read_acquire() here for the
> child state, because we change the group state accordingly and need to
> make sure, that it contains the last update of it. The cmpxchg which
> writes the child state is (on success) a full memory barrier. And the
> atomic_read_acquire() makes sure all preceding "critical sections"
> (which ends with the full memory barrier) are visible. Is this right?

Right. And BTW I'm being suggested by Paul to actually avoid
atomic_read_acquire() after cmpxchg() failure because that implies an
error prone re-read. So pick up your favourite between smp_rmb() or
smp_mb__after_atomic().

With the latter this could look like:

curstate.state = atomic_read_acquire(&group->migr_state);
for (;;) {
    childstate.state = atomic_read(&child->migr_state);
    ...
    if (atomic_try_cmpxchg(&group->migr_state, &curstate.state, newstate.state))
       break;
    smp_mb__after_atomic();
}

> 
> To make sure the proper states are used, atomic_read_acquire() is then
> also required in:
>   - tmigr_check_migrator()
>   - tmigr_check_migrator_and_lonely()
>   - tmigr_check_lonely()

Not sure about those. I'll check them.

>   - tmigr_new_timer_up() (for childstate and groupstate)

Actually you need to fix some ordering there that I suggested a while ago :)
See https://lore.kernel.org/all/ZIhKT3h7Dc0G3xoU@lothringen/

>   - tmigr_connect_child_parent()
> Right?
> 
> Regarding the pairing of acquire: What happens when two
> atomic_read_acquire() are executed afterwards without pairing 1:1 with a
> release or stronger memory barrier?

I think I'll need an example.

> 
> Now I want to understand the case for the group state here and also in
> active_up path. When reading it without acquire, it is possible, that
> not all changes are visible due to reordering,... . But then the worst
> outcome would be that the cmpxchg fails and the loop has to be done once
> more? Is this right?

Right. This one looks good as it doesn't depend on the child's value.

> 
> I know that memory barriers are not for free and redo the loop is also
> not for free. But I don't know which of both is worse. At least in
> inactive_up() path, we are not in the critical path. In active_up() it
> would be good to take the less expensive option.

I don't think you need to change the active_up(), from a quick glance.

> 
> I want to understand the atomic_try_cmpxchg_acquire() variant: The Read
> is an acquire, so even if the compare/write fails, the value which is
> handed back is the one which was update last with a succesful cmpxchg
> and then we can rely on this value?

So cmpxchg_acquire() provides a weaker ordering than cmpxchg(). Instead
of issuing a full memory barrier, it issues an acquire barrier, which is
really not what you want since you actually want to order what precedes
the cmpxchg() with the write that it performs. At the very least you would
actually need cmpxchg_release().

And most importantly, neither cmpxchg(), cmpxchg_release() nor cmpxchg_acquire()
guarantee any ordering on failure.

Thanks.

