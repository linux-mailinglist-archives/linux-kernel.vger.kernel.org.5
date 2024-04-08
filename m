Return-Path: <linux-kernel+bounces-135926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1306589CD26
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 22:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A5CAB23CAF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488DD147C63;
	Mon,  8 Apr 2024 20:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dB8VNrrK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B0F1EB46;
	Mon,  8 Apr 2024 20:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712609934; cv=none; b=R0dH2H7QnkKTx2qsHml3OXMVsi3CpgjIO7U/UGxgzM5w9AyaOlttrOyR0k6PBD46DHRnO/oMuMNHNaRZXFoJ0dKven8WLK6s/krZN00r5MXk4pSC55i5h2f0B2xDA2BmjL7Ys5utOeiqY6u0XJai7y7no8y9+FfBHKqLJDMj0nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712609934; c=relaxed/simple;
	bh=RivaelhbL8/R2Cq/U40S9EoXUuV3ar3kkSKVrsKkD5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/chz0fEd8EAbLYm0Ss3fjMTINS8oVeIENsonxGWPq1QurLw7rVmaBmN8bzdll7FBCt4ctP5cSpRfOhq0nuCup6M9Idqd2RyIXgGxP4NBo+Fa/hwkDo3oyfyYtDZY3WJuqdrqTjUqyHm3LWca2swwaH7BOKmqRGcHehpF7e7Y54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dB8VNrrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC297C433C7;
	Mon,  8 Apr 2024 20:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712609934;
	bh=RivaelhbL8/R2Cq/U40S9EoXUuV3ar3kkSKVrsKkD5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dB8VNrrKnfxdSYX24RUGwsY507ar92cFxs2Z8aq8tQhWOdLwCUmAjfjW9hlhGec73
	 70ZZpZh3RlmUii4yn7UvP3FbHr8ukhibrAbcdQEslDHeXY4/w1vL2rwM9qMsCyjUhA
	 0nJM2wOn/o33xP9Pu8T1C6ZBQPcWC3gEsEV4K9sOJ65i5kJUyirrI4PNzNNaeKERGW
	 0ys7HfQ8eyC6/LfsxFPG/PJH4qLsIcwa5NF1T8QV2otwTquyedrOQG26BDGB1V7hxC
	 dlkoCXFTZ456xuiBF2etG9Fxihvzpzmlgx5TU04xRONZJKr1ERWi82BxqFg1cVM19L
	 yfuhSpSA5jZfw==
Date: Mon, 8 Apr 2024 22:58:51 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Ian Rogers <irogers@google.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 0/4] perf: Fix leaked events when sigtrap = 1
Message-ID: <ZhRaizXTwxpe_bm_@pavilion.home>
References: <20240329235812.18917-1-frederic@kernel.org>
 <CAP-5=fVwT1FPTps=i=hG2O0sWr9DH92VSt66Co=Rhf9dyZX7ag@mail.gmail.com>
 <ZhRI7WfjgkCTK9aK@pavilion.home>
 <ZhRRi0KENKnV5o7_@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhRRi0KENKnV5o7_@x1>

Le Mon, Apr 08, 2024 at 05:20:27PM -0300, Arnaldo Carvalho de Melo a écrit :
> On Mon, Apr 08, 2024 at 09:43:41PM +0200, Frederic Weisbecker wrote:
> > Le Fri, Mar 29, 2024 at 08:23:49PM -0700, Ian Rogers a écrit :
> > > On Fri, Mar 29, 2024 at 4:58 PM Frederic Weisbecker <frederic@kernel.org> wrote:
> > > >
> > > > While looking at task_work users I just noticed that perf doesn't flush
> > > > its own upon event exiting. This looks especially problematic with child
> > > > events. Please have a thourough look at the last patch, I may easily
> > > > have missed something within the maze.
> > > >
> > > > Frederic Weisbecker (4):
> > > >   task_work: s/task_work_cancel()/task_work_cancel_func()/
> > > >   task_work: Introduce task_work_cancel() again
> > > >   perf: Fix event leak upon exit
> > > >   perf: Fix event leak upon exec and file release
> > > >
> > > >  include/linux/perf_event.h |  1 +
> > > >  include/linux/task_work.h  |  3 ++-
> > > >  kernel/events/core.c       | 40 +++++++++++++++++++++++++++++++-------
> > > >  kernel/irq/manage.c        |  2 +-
> > > >  kernel/task_work.c         | 34 +++++++++++++++++++++++++++-----
> > > >  security/keys/keyctl.c     |  2 +-
> > > >  6 files changed, 67 insertions(+), 15 deletions(-)
> > > 
> > > Thanks for this! I wonder if this relates to fuzzing failures like:
> > > https://lore.kernel.org/linux-perf-users/CAP-5=fUa+-Tj2b_hxk96Qg5=Qu7jYHgHREbsmBa2ZmuF-X9QaA@mail.gmail.com/
> > > "[ 2519.138665] unexpected event refcount: 2; ptr=000000009c56b097"
> > 
> > Probably not since those seem to happen on perf_event_open() failures. This
> > looks different.
> 
> Probably clashes with this one?
> 
> "[PATCH v3 0/4] perf: Make SIGTRAP and __perf_pending_irq() work on RT."
> 
> https://lore.kernel.org/all/20240322065208.60456-1-bigeasy@linutronix.de/T/#u

Nice, I think it partially fixes the issues I've seen. Lemme review that.

Thanks.

> 
> - Arnaldo

