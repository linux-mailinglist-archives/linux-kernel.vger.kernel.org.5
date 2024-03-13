Return-Path: <linux-kernel+bounces-102365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F32D687B136
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF47F28E34F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E14974E3C;
	Wed, 13 Mar 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pfF+4e44"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AAA51A38EB;
	Wed, 13 Mar 2024 18:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710354656; cv=none; b=Ik0YAPh6fgQanUwxuoQ9Yym0cTP3pmUkx7Mg9ybIEYljkO3CT0ZxQLY10a77cJ+wkwxr0oDMQJKqkLmKb1bLtgN9iAbubXlM98noqjWo5/bYQls6UYjcQdAFjVEEKMoXhuyPw692mXjGiTcxcywaVReSjTQtHec3T1QzRHyfYPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710354656; c=relaxed/simple;
	bh=7s94+cjLLDIJusp3vjMpmy9yEPbRqXpO24U8ePfCfsc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FFjqMVYth0Hojno+i1QlRATvlXN11AA7jQnFbA9pdr4gagHPaqXcjbTHs9QBtNnMeQMOOIliNiLkyqmNYs5QuOj8QrPixUwDrJCaFrkkJo7tV8vohl0AJHfboBGHC6ZoDb/prejPW3MSTAHbbRjWf6o9iBhhq9Wk4jXPFO3YwOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pfF+4e44; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C4FEC433C7;
	Wed, 13 Mar 2024 18:30:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710354656;
	bh=7s94+cjLLDIJusp3vjMpmy9yEPbRqXpO24U8ePfCfsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pfF+4e44rtiouk4rArEjhT/DUfXRmGsjkdlO9DtYrSQ29xS1z/LqVhioHkfvD2D0S
	 u7+254dsEa7jEXMiNbC1gaQl4shsF+4ymgLl6fqUZ7NgaD3fOeVugmtzdRHHc0ghgf
	 TSGSk+tRrlbuPODXSn3vYev0LwrLEGVLGOxac6SuaRcrYQBVk2dHV4pqj64csmiQN3
	 J3RIXvloCqx2uEUKLS1qFlYXlFxsSeikgtMda9dHRJUf6RJBBiQKRXOLXvuSb35UhC
	 RglrvS0ulH69jYCA1riUUEWDJeyIXnE4cZfPhYXogh4klpH5FkQVKqn5Xi0liHdbs9
	 DatFPeH3EDkXA==
Date: Wed, 13 Mar 2024 15:30:52 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Marco Elver <elver@google.com>, Vince Weaver <vincent.weaver@maine.edu>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Ian Rogers <irogers@google.com>, Ingo Molnar <mingo@redhat.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 0/4] perf: Make SIGTRAP and __perf_pending_irq() work
 on RT.
Message-ID: <ZfHw3J5PY6qy4mXn@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
 <ZfHtBB5_-3RByE8p@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfHtBB5_-3RByE8p@x1>

On Wed, Mar 13, 2024 at 03:14:28PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 13, 2024 at 12:23:32PM -0300, Arnaldo Carvalho de Melo wrote:
> > On Wed, Mar 13, 2024 at 03:35:27PM +0100, Marco Elver wrote:
> > > On Tue, 12 Mar 2024 at 19:08, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > > Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> > > > the signal gets delayed until event_sched_out() which then uses
> > > > task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> > > > signal is delivered with disabled preemption.
>  
> > > > While looking at this, I also stumbled upon __perf_pending_irq() which
> > > > requires disabled interrupts but this is not the case on PREEMPT_RT.
>  
> > > > This series aim to address both issues while not introducing a new issue
> > > > at the same time ;)
> > > > Any testing is appreciated.
>  
> > > > v1…v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy@linutronix.de/
> > > >     - Marco pointed me to the testsuite that showed two problems:
> > > >       - Delayed task_work from NMI / missing events.
> > > >         Fixed by triggering dummy irq_work to enforce an interrupt for
> > > >         the exit-to-userland path which checks task_work
> > > >       - Increased ref-count on clean up/ during exec.
> > > >         Mostly addressed by the former change. There is still a window
> > > >         if the NMI occurs during execve(). This is addressed by removing
> > > >         the task_work before free_event().
> > > >       The testsuite (remove_on_exec) fails sometimes if the event/
> > > >       SIGTRAP is sent before the sighandler is installed.
> >  
> > > Tested-by: Marco Elver <elver@google.com>

> > > It does pass the tests in tools/testing/selftests/perf_events (non-RT
> > > kernel, lockdep enabled). But I do recall this being a particularly
> > > sharp corner of perf, so any additional testing and review here is
> > > useful.
> 
> > Right, I'm testing with the full 'perf test' suite now.
> 
> 'perf test' doesn't show any regression, now I'm running Vince Weaver's
> https://github.com/deater/perf_event_tests, storing the results with
> this patchset and then without, to do a diff, lets see...

[root@nine perf_event_tests]# diff -u results.6.8.0-rc7-rt6 results.6.8.0-rc7.sebastian-rt6+ | grep ^[+-]
--- results.6.8.0-rc7-rt6	2024-03-13 15:26:37.923323518 -0300
+++ results.6.8.0-rc7.sebastian-rt6+	2024-03-13 15:14:11.505333801 -0300
-Linux nine 6.8.0-rc7-rt6 #1 SMP PREEMPT_RT Fri Mar  8 17:36:48 -03 2024 x86_64 x86_64 x86_64 GNU/Linux
+Linux nine 6.8.0-rc7.sebastian-rt6+ #2 SMP PREEMPT_RT Tue Mar 12 18:01:31 -03 2024 x86_64 x86_64 x86_64 GNU/Linux
-    Testing "branch-misses" generalized event...               FAILED
+    Testing "branch-misses" generalized event...               PASSED
-    Testing uncore events...                                   SKIPPED
+    Testing uncore events...                                   PASSED
-    We are running release 6.8.0-rc7-rt6
+    We are running release 6.8.0-rc7.sebastian-rt6+
-    Running on CPU 4
+    Running on CPU 2
-    Running on CPU 6
+    Running on CPU 2
-    Measuring on CPU 5
-Running on CPU 6
-Measuring on CPU 5
+    Measuring on CPU 6
+Running on CPU 2
+Measuring on CPU 6
[root@nine perf_event_tests]#

So basically:

-    Testing "branch-misses" generalized event...               FAILED
+    Testing "branch-misses" generalized event...               PASSED
-    Testing uncore events...                                   SKIPPED
+    Testing uncore events...                                   PASSED

So things improved! I'll re-run to see if these results are stable...

- Arnaldo

