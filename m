Return-Path: <linux-kernel+bounces-135903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AD989CCEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B1531C21C75
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816D146A8C;
	Mon,  8 Apr 2024 20:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKhoxQPo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738F7146596;
	Mon,  8 Apr 2024 20:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712607631; cv=none; b=c6Juh6Em/Kw/6PqWmLvMzjH4BxqxBF5aSp2gcYkyClsQ8qeJWXmrpdKYur/B2u8HNWqTgEvbMsV/CQY82Ac2zh0PZgXt2lG1oTo6tC3JRl2GepbZdghV3TyHHMYIvRcSgLfCAiybNDj4KFX4TQ5VXkfQCRj1aZAIV6qeDFUvqN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712607631; c=relaxed/simple;
	bh=fMWbEIfqpElLex0+WVwRKS2fcQkne1Z6iZmaYL1f1Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V2nV1S/guPX7oex+4nVeqMF3Py7VmZ4lGmrX8Xtzde//0ZFyQnUQ/l9QhszdOxQUBpL7mb/qDPx5j03d33FNvCrR/5A/ADHyt+blHo3ZOCWT3p9c72/tIU/ZQApgO/c2ab9QXE68N1vu8T5/qzX8tvNQD3g0sgi5S8Cj9oiZyvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKhoxQPo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E554C433C7;
	Mon,  8 Apr 2024 20:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712607631;
	bh=fMWbEIfqpElLex0+WVwRKS2fcQkne1Z6iZmaYL1f1Pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKhoxQPo21g0SByjZ2E69k0VeN1f5f7D8eGYt64qmcAAmgl3Aqgo0mSEWeWNkt45p
	 r85T2jr0G0yfSKV6JkYwwRXeN3RO/C+MeksNAfG8xy2lNpyWPLzG8ytNw/R7fNw8wT
	 /TdWHE4YEJWI6/zj95JBGq76XK964L+aGWw41XkpgJJQrmNa7RlW5dY3PA8k78zxgX
	 rHDVQttScyVhyorlf/9qEPeIPUZp2e7vVhPR+sM+6LL/n9guBLrbv7E91YyimuPcCo
	 6dqDA++QnEw/Ci827q+U1vFPBqqzWOhNr6aOOQ8aYP7gRHqtWrLZCM8HEHIJaxthMT
	 GEgPu6R5w/jog==
Date: Mon, 8 Apr 2024 17:20:27 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Ian Rogers <irogers@google.com>, LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf: Fix leaked events when sigtrap = 1
Message-ID: <ZhRRi0KENKnV5o7_@x1>
References: <20240329235812.18917-1-frederic@kernel.org>
 <CAP-5=fVwT1FPTps=i=hG2O0sWr9DH92VSt66Co=Rhf9dyZX7ag@mail.gmail.com>
 <ZhRI7WfjgkCTK9aK@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhRI7WfjgkCTK9aK@pavilion.home>

On Mon, Apr 08, 2024 at 09:43:41PM +0200, Frederic Weisbecker wrote:
> Le Fri, Mar 29, 2024 at 08:23:49PM -0700, Ian Rogers a écrit :
> > On Fri, Mar 29, 2024 at 4:58 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > >
> > > While looking at task_work users I just noticed that perf doesn't flush
> > > its own upon event exiting. This looks especially problematic with child
> > > events. Please have a thourough look at the last patch, I may easily
> > > have missed something within the maze.
> > >
> > > Frederic Weisbecker (4):
> > >   task_work: s/task_work_cancel()/task_work_cancel_func()/
> > >   task_work: Introduce task_work_cancel() again
> > >   perf: Fix event leak upon exit
> > >   perf: Fix event leak upon exec and file release
> > >
> > >  include/linux/perf_event.h |  1 +
> > >  include/linux/task_work.h  |  3 ++-
> > >  kernel/events/core.c       | 40 +++++++++++++++++++++++++++++++-------
> > >  kernel/irq/manage.c        |  2 +-
> > >  kernel/task_work.c         | 34 +++++++++++++++++++++++++++-----
> > >  security/keys/keyctl.c     |  2 +-
> > >  6 files changed, 67 insertions(+), 15 deletions(-)
> > 
> > Thanks for this! I wonder if this relates to fuzzing failures like:
> > https://lore.kernel.org/linux-perf-users/CAP-5=fUa+-Tj2b_hxk96Qg5=Qu7jYHgHREbsmBa2ZmuF-X9QaA@mail.gmail.com/
> > "[ 2519.138665] unexpected event refcount: 2; ptr=000000009c56b097"
> 
> Probably not since those seem to happen on perf_event_open() failures. This
> looks different.

Probably clashes with this one?

"[PATCH v3 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT."

https://lore.kernel.org/all/20240322065208.60456-1-bigeasy@linutronix.de/T/#u

- Arnaldo

