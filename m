Return-Path: <linux-kernel+bounces-136875-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B28689D94B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B389A284622
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5B912D745;
	Tue,  9 Apr 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qit/Rphu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B97C22318;
	Tue,  9 Apr 2024 12:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712666214; cv=none; b=JoB8JeG2OEfVQ9ioCRyT61XiWC9+DzmZOyXBTgoMoOhxv1d3gjAZDiVeMuJAk/CryINyhgZH3Df2QCYZOLAf1vVl7QEe5peqTJEHCLMWMgxo1rkkJ5Q17ADr2t0DiO6RUxogoF8ujV+XIzUb0cKGB67fMhGhMJJuCAxtQCWm35I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712666214; c=relaxed/simple;
	bh=PCvyTmJFSBw/wF40SXFhkTfbKGm+lHZssDURb5RxCoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BoGwBFscXKmGUVRkMDZNRlsMs/Hs8kVgSy07fc1gAUeydubmkOAzZh/wl0FByFg3S+lukZyujG5NGtwQZ9ja2ra8+ECC7gTry9Zkio0ZjvuZjWIrpfYvoVCOMsH+jB935FoqHQF3A63rT+L2+B4FFygMu+ywA9bZRufyBxL08Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qit/Rphu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A15CC433F1;
	Tue,  9 Apr 2024 12:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712666213;
	bh=PCvyTmJFSBw/wF40SXFhkTfbKGm+lHZssDURb5RxCoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qit/RphuZykfOHrkij6ZIkv1Qecy6nLHuhMx7XEMF51KTWC+HGbppgU0AK8gFBBaN
	 MEHQ97xUdN4r7yJoGgnwXx35nhSOoL2FCFLz8BXBRuLanxXq0RHdTslAH4V9kONz/P
	 GqyMDdRiXBepBE9VikefvML5XxetOrB4Y7TbdcD2T/G8S8WMT1fgUwL4dRXMgl9oz/
	 Rg/8StVaH7BdVBsHKYdodOYbHC7Y8HBqZzt8451ISYjNgBH7mse3NC7mYgEh0zxr7D
	 5Lt8XyU9geBjz4IFMZfUHkpXlKUrldyWDzzPAk34F4OtUnjkIEuVNswDgcMQv7WYtV
	 a/ZVFNmYVdDwA==
Date: Tue, 9 Apr 2024 14:36:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Marco Elver <elver@google.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 2/4] perf: Enqueue SIGTRAP always via task_work.
Message-ID: <ZhU2YwettB6i6AMp@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-3-bigeasy@linutronix.de>
 <ZhRhn1B0rMSNv6mV@pavilion.home>
 <20240409085732.FBItbOSO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409085732.FBItbOSO@linutronix.de>

Le Tue, Apr 09, 2024 at 10:57:32AM +0200, Sebastian Andrzej Siewior a écrit :
> > >  static void
> > >  perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> > >  {
> > > @@ -13088,6 +13084,18 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
> > >  		 * Kick perf_poll() for is_event_hup();
> > >  		 */
> > >  		perf_event_wakeup(parent_event);
> > > +		/*
> > > +		 * Cancel pending task_work and update counters if it has not
> > > +		 * yet been delivered to userland. free_event() expects the
> > > +		 * reference counter at one and keeping the event around until
> > > +		 * the task returns to userland can be a unexpected if there is
> > > +		 * no signal handler registered.
> > > +		 */
> > > +		if (event->pending_work &&
> > > +		    task_work_cancel_match(current, task_work_cb_match, event)) {
> > > +			put_event(event);
> > > +			local_dec(&event->ctx->nr_pending);
> > > +		}
> > 
> > So exiting task, privileged exec and also exit on exec call into this before
> > releasing the children.
> > 
> > And parents rely on put_event() from file close + the task work.
> > 
> > But what about remote release of children on file close?
> > See perf_event_release_kernel() directly calling free_event() on them.
> 
> Interesting things you are presenting. I had events popping up at random
> even after the task decided that it won't go back to userland to handle
> it so letting it free looked like the only option…
> 
> > One possible fix is to avoid the reference count game around task work
> > and flush them on free_event().
> > 
> > See here:
> > 
> > https://lore.kernel.org/all/202403310406.TPrIela8-lkp@intel.com/T/#m63c28147d8ac06b21c64d7784d49f892e06c0e50
> 
> That wake_up() within preempt_disable() section breaks on RT.

Ah, but the wake-up still wants to go inside recursion protection somehow or
it could generate task_work loop again due to tracepoint events...

Although... the wake up occurs only when the event is dead after all...

> How do we go on from here?

I'd tend to think you need my patchset first because the problems it
fixes were not easily visible as long as there was an irq work to take
care of things most of the time. But once you rely on task_work only then
these become a real problem. Especially the sync against perf_release().

Thanks.

> 
> > Thanks.
> 
> Sebastian

