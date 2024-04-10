Return-Path: <linux-kernel+bounces-138349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B16A889F006
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0D21C20D05
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A5E159219;
	Wed, 10 Apr 2024 10:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pcnhCCBb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60384159218;
	Wed, 10 Apr 2024 10:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745533; cv=none; b=OjD7F2HPN8ZeNzLry0AvKvjwzYQV/J4hw91hbeX3XLKTza4LDo6LuYWwMv7AJ9EryOul6ecDUQ7Tarne/ZFynRJlf3Ads3TRSGwzVq1L4K/6rBFz3ytMSUyuG0msTe+k9nKAbFgff/SVfWWdgdVSot+Bk3JMC/a1gxG6PfSnQnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745533; c=relaxed/simple;
	bh=t7GHWU4HSYHo8xvnfjr3suCp1+Uv/uMlq4X/AQl8Qoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDt1PCJMyJJlqADTIChaXqScabmToE7QYFBSWkm5b8W1x/jQLpUCn9064ykSZVz3tUem6N74T8Tf++yTQZPcFaLyMoTJCRiF1bwuQpjUwktxNTm/eSA58yg+jmz+VylUKobUoLpmQbG1p1uENBFV5QU/RGHbGkOqQcGJ+qfLdJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pcnhCCBb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65ACFC433F1;
	Wed, 10 Apr 2024 10:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712745532;
	bh=t7GHWU4HSYHo8xvnfjr3suCp1+Uv/uMlq4X/AQl8Qoc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pcnhCCBbcH29seTH6YJe4Dxo0mwJrYZF5/TXxBBu8OXbt7FMU/vDdVMJyP47VKsCA
	 vGTC/MJGVRZTYFMCbf9GoRZRYBfhPwP/DSwKCSFawRTDDWP5XkquzQdJtK5LBcsJHE
	 xZFVMRaDXrdrK89d4va5XUZczcZ+Zd+9Cu+Jsfmtfr6eJVf+3nSyZi77kXgN0ZDNX4
	 RfbBj1oPrh5Y4jKNCeaF8KdIHEHr9/NDjqZoR9SufJ52A44kHgoUIv2jaQdue5DEIl
	 IEaZlvV/jLvkE1NNOiBft9NolPgtLKB7Jt+6gU/P7lEpgPzwTvmSdueC72mHUpkBtq
	 0dv7ejQXujpAQ==
Date: Wed, 10 Apr 2024 12:38:50 +0200
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
Message-ID: <ZhZsOvM3uTP6nTnZ@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
 <ZhUaAjhQXN6ahtpS@localhost.localdomain>
 <20240409105405.TXUU--_W@linutronix.de>
 <ZhUt8XMndGSwNuwx@localhost.localdomain>
 <20240409133336.Y4Io-16-@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409133336.Y4Io-16-@linutronix.de>

Le Tue, Apr 09, 2024 at 03:33:36PM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-09 14:00:49 [+0200], Frederic Weisbecker wrote:
> > Le Tue, Apr 09, 2024 at 12:54:05PM +0200, Sebastian Andrzej Siewior a écrit :
> > > On 2024-04-09 12:35:46 [+0200], Frederic Weisbecker wrote:
> > > > > > > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
> > > > > > >  		local_dec(&event->ctx->nr_pending);
> > > > > > >  	}
> > > > > > >  
> > > > > > > -	if (rctx >= 0)
> > > > > > > -		perf_swevent_put_recursion_context(rctx);
> > > > > > > -	preempt_enable_notrace();
> > > > > > 
> > > > > > Well, if a software event happens during perf_sigtrap(), the task work
> > > > > > may be requeued endlessly and the task may get stuck in task_work_run()...
> > > > > 
> > > > > The last time I checked it had no users in the task context. How would
> > > > > that happen?
> > > > 
> > > > I guess many tracepoint events would do the trick. Such as trace_lock_acquire()
> > > > for example.
> > > 
> > > So the perf_trace_buf_alloc() is invoked from that trace point and
> > > avoids the recursion. And any trace event from within perf_sigtrap()
> > > would trigger the endless loop?
> > 
> > No sure I'm following:
> > 
> > 1) event->perf_event_overflow() -> task_work_add()
> > //return to userspace
> > 2) task_work_run() -> perf_pending_task() -> perf_sigtrap() -> tracepoint event
> >    -> perf_event_overflow() -> task_work_add()
> > 3) task_work_run() -> perf_pending_task() -> etc...
> >
> > What am I missing?
> 
> Yes, that is what I tried to say.

Oh ok.. :o)

> Anyway, I misunderstood the concept
> before. That means we need to keep that counter here and a
> migrate_disable() is needed to avoid CPU migration which is sad.

I fear that won't work either. The task is then pinned but another
task can come up on that CPU and its software events will be ignored...

Some alternatives:

_ Clear event->pending_work = 0 after perf_sigtrap(), preventing an
event in there from adding a new task work. We may miss a signal though...

_ Make the recursion context per task on -RT...

> > Thanks.
> 
> Sebastian

