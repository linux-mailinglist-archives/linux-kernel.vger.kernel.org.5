Return-Path: <linux-kernel+bounces-136824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA9989D8AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE891C21DB9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164E012AADF;
	Tue,  9 Apr 2024 12:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vCeatPVO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA5786651;
	Tue,  9 Apr 2024 12:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664053; cv=none; b=gRpFv6PWI3uP6IY7IhmJkhI1eQi8kQqBBo99LElnRRmq8sNiMkZy/eXyG847eNHQOV0+W+oU1rjQOGfaBhFmWY0B38kFCs7cUEhQFLy6gvtPhlVQW76nQpuB/XsHEfzFcL+3uGSMUmESUMG1lv166aFof6VQdmL9eui8j234hR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664053; c=relaxed/simple;
	bh=tAyPAeaQANhI4c3tAyeCyOp+cseGWerbAlJvZtQeEac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVAsG53aGCe3s2IumZEYfyTu3GErtFfH4w5aK8ZblS8cMFlpLd4LszW0mWqLZtl/rxhYggQwHNwVXZa7Jk5Fqkd4qsb4Xy2EwpVz9umfmBaAcWvjHCbXqZHwC5ibMbKcODROhvL3snAOioDSoXjx3mMayRxxsbbZruJeBnjr5hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vCeatPVO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63AB4C433F1;
	Tue,  9 Apr 2024 12:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712664052;
	bh=tAyPAeaQANhI4c3tAyeCyOp+cseGWerbAlJvZtQeEac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vCeatPVOqX3Hx7iTF3LlEUcKobQjBcaRcBc+fJpctd/culjL8StZejl0MHXkpetUm
	 eYa8kVtD6iizmqCJs/r5uYdajS02qAc9/rJ8H9LkYw/XYk73EC/DkPp8415WO7xGEC
	 K1qXCt9G1iTV6jyTJsCPv7dZMZC2LL46PmD87sEL3nRwcr88pwhMVj0UNWoWMBmhAx
	 w/AHNjgvxZV2nKPZtpUrCRfcPEvayZbDK9kja90XB4QDPjLq5HYT/ucwEVbVyfvDcc
	 PAw6kGw4pZOX7tx8QrPZQOmj9lLbyTgD+94FH+uxRXtdJdLSk2cWy4JsjBs/t9aoqW
	 FepHEf5w4IOZQ==
Date: Tue, 9 Apr 2024 14:00:49 +0200
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
Subject: Re: [PATCH v3 3/4] perf: Remove perf_swevent_get_recursion_context()
 from perf_pending_task().
Message-ID: <ZhUt8XMndGSwNuwx@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
 <20240409105405.TXUU--_W@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409105405.TXUU--_W@linutronix.de>

Le Tue, Apr 09, 2024 at 12:54:05PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-09 12:35:46 [+0200], Frederic Weisbecker wrote:
> > > > > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
> > > > >  		local_dec(&event->ctx->nr_pending);
> > > > >  	}
> > > > >  
> > > > > -	if (rctx >= 0)
> > > > > -		perf_swevent_put_recursion_context(rctx);
> > > > > -	preempt_enable_notrace();
> > > > 
> > > > Well, if a software event happens during perf_sigtrap(), the task work
> > > > may be requeued endlessly and the task may get stuck in task_work_run()...
> > > 
> > > The last time I checked it had no users in the task context. How would
> > > that happen?
> > 
> > I guess many tracepoint events would do the trick. Such as trace_lock_acquire()
> > for example.
> 
> So the perf_trace_buf_alloc() is invoked from that trace point and
> avoids the recursion. And any trace event from within perf_sigtrap()
> would trigger the endless loop?

No sure I'm following:

1) event->perf_event_overflow() -> task_work_add()
//return to userspace
2) task_work_run() -> perf_pending_task() -> perf_sigtrap() -> tracepoint event
   -> perf_event_overflow() -> task_work_add()
3) task_work_run() -> perf_pending_task() -> etc...

What am I missing?

Thanks.

