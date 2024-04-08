Return-Path: <linux-kernel+bounces-135960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F56089CE35
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 00:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB98284CBA
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB811494B1;
	Mon,  8 Apr 2024 22:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oxEsmWF4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64067E8;
	Mon,  8 Apr 2024 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613963; cv=none; b=RJEV8YG7ygRiFcu8BKBtFkwXuo0L/AsKwk9dPdqAFt6HN8WsmRK04nMWIeHW/f1QNxaBoK+1xoFwcsY1Je6rsp/f6rrR1ZsvntRsdFOErAYL0TRFk9i9R21ZlN5Qt9CmLkXKsd/Zf9pkQa8x3QGboiUUBCkb7DyR39+UixlGoHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613963; c=relaxed/simple;
	bh=pqw1ADI+qMHaHDaHqcuxy0STdxD+4CZFkalH3Y8huiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tu9WKf2gXhjfOqqGawaX8q3+JCzeoGqSuPuLVj4vtYC7oDjvy+HhMpgN5cV5yU3rvI/VI6sQL6BV2QaDCoep8JJtXe7LdwIKTJMh/Z4RcYOQAtCx9w91d25Gbe+m/oa8cz6j//LFcLTqKBh7ZANCjwt164nJWxJr/qX9rH0RRNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oxEsmWF4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8F9C433C7;
	Mon,  8 Apr 2024 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712613963;
	bh=pqw1ADI+qMHaHDaHqcuxy0STdxD+4CZFkalH3Y8huiQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxEsmWF4PUKFwgzlzDlnOP9KQVB+NOANun/x2OkOQRKzRPVvt2uVPnG3gaXZXO51H
	 MjM2d8wqP+unjGiDWZ1EiSca5l1t1YORwrSFSMC85whZvCStBla0KUNYdqqhFZdLbZ
	 /TYh0RpZai+fY78A2HGBwK2TXyqbrkp5vg6W78bsRFA5DA9ZvHsRPzwpIn8Ii37Q9R
	 AhRS6O2THlIJwR1c+o+uaMsZr6q5J5MBuQ6qJywP7adjX44dIFCWi1Q7xv1Vw/ZijG
	 WRHpuPAzIwBj3R+CN3HOHj2/eiiSeD1CFRDlxOObLEKaFEFr7wzdHnC7KStIZ0Cnw0
	 JjZ88ZwDdilDw==
Date: Tue, 9 Apr 2024 00:06:00 +0200
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
Message-ID: <ZhRqSEbyd1rqVwfN@pavilion.home>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240322065208.60456-4-bigeasy@linutronix.de>

Le Fri, Mar 22, 2024 at 07:48:23AM +0100, Sebastian Andrzej Siewior a écrit :
> perf_swevent_get_recursion_context() is supposed to avoid recursion.
> This requires to remain on the same CPU in order to decrement/ increment
> the same counter. This is done by using preempt_disable(). Having
> preemption disabled while sending a signal leads to locking problems on
> PREEMPT_RT because sighand, a spinlock_t, becomes a sleeping lock.
> 
> This callback runs in task context and currently delivers only a signal
> to "itself". Any kind of recusrion protection in this context is not
> required.
> 
> Remove recursion protection in perf_pending_task().
> 
> Tested-by: Marco Elver <elver@google.com>
> Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/events/core.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e0b2da8de485f..5400f7ed2f98b 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -6785,14 +6785,6 @@ static void perf_pending_irq(struct irq_work *entry)
>  static void perf_pending_task(struct callback_head *head)
>  {
>  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
> -	int rctx;
> -
> -	/*
> -	 * If we 'fail' here, that's OK, it means recursion is already disabled
> -	 * and we won't recurse 'further'.
> -	 */
> -	preempt_disable_notrace();
> -	rctx = perf_swevent_get_recursion_context();
>  
>  	if (event->pending_work) {
>  		event->pending_work = 0;
> @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
>  		local_dec(&event->ctx->nr_pending);
>  	}
>  
> -	if (rctx >= 0)
> -		perf_swevent_put_recursion_context(rctx);
> -	preempt_enable_notrace();

Well, if a software event happens during perf_sigtrap(), the task work
may be requeued endlessly and the task may get stuck in task_work_run()...

> -
>  	put_event(event);
>  }
>  
> -- 
> 2.43.0
> 
> 

