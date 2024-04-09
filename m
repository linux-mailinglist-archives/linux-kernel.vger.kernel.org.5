Return-Path: <linux-kernel+bounces-136684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3760A89D714
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC5421F242A8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB6681751;
	Tue,  9 Apr 2024 10:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tg43mS9k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC021EB46;
	Tue,  9 Apr 2024 10:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712658949; cv=none; b=tpbUVzal3+ppzplFr+849cSaLQnoomBnKvtj7M30v+hi6Aok+OLWVaDA61pxWogTqhC34ohrIR/u9qie6ME45CCPqRSx+1tDwJwS88cUe3MlK5gcr55shwtjIbq/yTORFJCLilcV3gBnTglvloS+j6hGsVr2lgcDC2pzEAIBTCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712658949; c=relaxed/simple;
	bh=VtU83v3DWvkdgwKB+G89/DK3CwaUjxGtmhjxn0puGsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ver0O2a7yPSohgHutzDNssst6689gmdH6LqvJ6VZEbNc2nkLWbddwWoz+pgGY3ba3AhTdAQJ5dBly8aaw8VejiTg2fprOYdO+SSw/Uxzv5GN39PFhPWIE2Ot4JtJ24jar8wK6J3MdFE7xTE+szPqA04ikuILGF4XTMVph6mRF+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tg43mS9k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6876AC433F1;
	Tue,  9 Apr 2024 10:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712658948;
	bh=VtU83v3DWvkdgwKB+G89/DK3CwaUjxGtmhjxn0puGsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tg43mS9kXZIXZvrq/9CZMbPD0lSXpOJRDmWZ2vTZcZNmU1Ydu6b7qkeTOrg7EqsU5
	 NpOaqhJOcnWbi0E1cZ4rc7RWiMsMZDfu+FLsrebBVGmeHXC9NnnQQql/98iMOEC+bT
	 9Vt3oPrIfe/6rvxEhoHlUxW4N1FxjjCIJNe5NMgEhDwMGKPTJNsevaHqSyjyPnJSR/
	 ChvnkD/69zdi8BwIkb1LlW8YHqlGW2GxkLYFACLate0fJ0mxnolEtyMncr1evVV4Ir
	 yw7CtSp/KUgH4auNBkn7JcPZTvsu4fmr+Ny0NPStYt7lGslfhmbrZvYl/0hVRTGE8b
	 IA0IWtYJZINnw==
Date: Tue, 9 Apr 2024 12:35:46 +0200
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
Message-ID: <ZhUaAjhQXN6ahtpS@localhost.localdomain>
References: <20240322065208.60456-1-bigeasy@linutronix.de>
 <20240322065208.60456-4-bigeasy@linutronix.de>
 <ZhRqSEbyd1rqVwfN@pavilion.home>
 <20240409062501.h4rA_ck4@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240409062501.h4rA_ck4@linutronix.de>

Le Tue, Apr 09, 2024 at 08:25:01AM +0200, Sebastian Andrzej Siewior a écrit :
> On 2024-04-09 00:06:00 [+0200], Frederic Weisbecker wrote:
> > > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > > index e0b2da8de485f..5400f7ed2f98b 100644
> > > --- a/kernel/events/core.c
> > > +++ b/kernel/events/core.c
> > > @@ -6785,14 +6785,6 @@ static void perf_pending_irq(struct irq_work *entry)
> > >  static void perf_pending_task(struct callback_head *head)
> > >  {
> > >  	struct perf_event *event = container_of(head, struct perf_event, pending_task);
> > > -	int rctx;
> > > -
> > > -	/*
> > > -	 * If we 'fail' here, that's OK, it means recursion is already disabled
> > > -	 * and we won't recurse 'further'.
> > > -	 */
> > > -	preempt_disable_notrace();
> > > -	rctx = perf_swevent_get_recursion_context();
> > >  
> > >  	if (event->pending_work) {
> > >  		event->pending_work = 0;
> > > @@ -6800,10 +6792,6 @@ static void perf_pending_task(struct callback_head *head)
> > >  		local_dec(&event->ctx->nr_pending);
> > >  	}
> > >  
> > > -	if (rctx >= 0)
> > > -		perf_swevent_put_recursion_context(rctx);
> > > -	preempt_enable_notrace();
> > 
> > Well, if a software event happens during perf_sigtrap(), the task work
> > may be requeued endlessly and the task may get stuck in task_work_run()...
> 
> The last time I checked it had no users in the task context. How would
> that happen?

I guess many tracepoint events would do the trick. Such as trace_lock_acquire()
for example.

Thanks.

