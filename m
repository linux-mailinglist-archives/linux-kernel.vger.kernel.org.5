Return-Path: <linux-kernel+bounces-34209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A361083759A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E0C28A07E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732B3482DA;
	Mon, 22 Jan 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbrFyVfL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA85E482C4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960167; cv=none; b=MqTqsy7TwLiqqeezOUkQGdxOBZ7L1LY+ni1LO2/RTwj1zaaoMMuFeoXKVCcbEBYW5+iY6RDMY+FrzrrgimgOHrj4xsjk3VIGJiZM1RW6eWYW1d59enkWCJw+xtuBGR1Ihyqq63zsNTHylkgsYIVufMtj3uH5zHtSNxtzoN44n78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960167; c=relaxed/simple;
	bh=Cy7gOE5kLl/KLAlT+jj4Xtve6DQ5tH//jS0kHlc6gAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cOSQ0KWG5O4E13anRTwnrgXTnNsOGgQoHjXwrLtWqo6mQ5WucbPfnydFt+9c6uurfd+j8FYiabrRxuvvdmWO8kJ9HfsiGowX5UgRB//5OB2QcVQU/CrbdqqfxolzhDtrN1y2MNjrsyC0hWPG6TEm2RlljehxxIpM46Dnvc6qO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbrFyVfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6FFAC43390;
	Mon, 22 Jan 2024 21:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960167;
	bh=Cy7gOE5kLl/KLAlT+jj4Xtve6DQ5tH//jS0kHlc6gAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VbrFyVfLjwiX/4+rwgQOXfUPjobuZxa9w3MkRwedmaqM3XRn1DBpuaTs4rzFGlS6/
	 5jF1UzYLiOR7A8ZvGXa1x+kf9tIm+kLWRYyFeff+Oac8oVHJMHX+vHy8fq3Nr4Kz42
	 UKfNdjMroFrULMX+9FODykr550OkR+ok1vOeHgczud6KOuBrKENo1qQI5LXbjXKt2X
	 B0uIHkZTsUg1Xbfgvnbo0KENn/XSP2X6+eX7R/S8hXsAl4kpWhhIrXuZMHo+Bxf+Ke
	 L2tVFz3neWS04jQFCN3Rzp3ZRApfj09uHUXf/4lcjCIX7MBOHxczuFKhGFifC7iFQ8
	 rsdgbk5QPnxxg==
Date: Mon, 22 Jan 2024 22:49:23 +0100
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
Subject: Re: [PATCH v10 03/20] timers: Move marking timer bases idle into
 tick_nohz_stop_tick()
Message-ID: <Za7i44ofgsgzqrZo@pavilion.home>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-4-anna-maria@linutronix.de>
 <Zaf6E61X_l1Bx6Mu@localhost.localdomain>
 <87ttn5y4lc.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttn5y4lc.fsf@somnus>

Le Mon, Jan 22, 2024 at 12:45:03PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Jan 15, 2024 at 03:37:26PM +0100, Anna-Maria Behnsen a écrit :
> >> @@ -889,12 +884,41 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> >>  static void tick_nohz_stop_tick(struct tick_sched *ts, int cpu)
> >>  {
> >>  	struct clock_event_device *dev = __this_cpu_read(tick_cpu_device.evtdev);
> >> +	unsigned long basejiff = ts->last_jiffies;
> >>  	u64 basemono = ts->timer_expires_base;
> >> -	u64 expires = ts->timer_expires;
> >> +	bool timer_idle;
> >> +	u64 expires;
> >>  
> >>  	/* Make sure we won't be trying to stop it twice in a row. */
> >>  	ts->timer_expires_base = 0;
> >>  
> >> +	/*
> >> +	 * Now the tick should be stopped definitely - so the timer base needs
> >> +	 * to be marked idle as well to not miss a newly queued timer.
> >> +	 */
> >> +	expires = timer_base_try_to_set_idle(basejiff, basemono, &timer_idle);
> >> +	if (!timer_idle) {
> >> +		/*
> >> +		 * Do not clear tick_stopped here when it was already set - it
> >
> > Can that really happen? Looking at __get_next_timer_interrupt(), you're making a
> > behavioural change: if base->is_idle was previously set and the next timer is
> > now below/equal a jiffy, base->is_idle is not going to be cleared by
> > __get_next_timer_interrupt().
> >
> > Therefore you shouldn't observe ts->tick_stopped && !timer_idle
> >
> > But I'm assuming that behavioural change wasn't intended?
> 
> It was intended to keep tick_stopped and base->is_idle in sync. So when
> tick_stopped is set also base->is_idle needs to be set and dropping it
> before tick_stopped is dropped will break the plan to keep it in sync.

Ok that sounds good.

Thanks!

