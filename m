Return-Path: <linux-kernel+bounces-101673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B68687AA55
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE66E1F230E2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 15:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EDA45C10;
	Wed, 13 Mar 2024 15:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHQc+hr0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2F947A5D;
	Wed, 13 Mar 2024 15:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710343416; cv=none; b=njp/wHzC41fQmPP+OkRaTAGU8kYxeU7yFCJ9CGz5Hr6WjE032oGRrc5KEbTjXkEVHFKjtSZCS/mMjUUb8l1HSdOycym2drrV/buJLxh9rvS0B37G1qFgJhYYkpYVBLGOHisZ+N6KqN+ymEmCgmY466TRCCmQxWJurwIlV04YtkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710343416; c=relaxed/simple;
	bh=IP2p6UB0Iw0uuB5s9+1fkRSK+RhQkxmHwBeJcrGlpEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lvMbUZEWMlRECYhVs/WaeI+ejZUwHSdWmqqK4HZkTncZYpEghn4g0w8KsMtjMaLzTlsSOW7VE8ZpyHTxt50nYNlPvTiTdUOmTQRR134/uw6x3CxujE5QoVYK8T56QCjehGgc2zQQEqLia3DTfmTbx3BubUWcGeCFhVOv28+H5l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHQc+hr0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 694F2C43390;
	Wed, 13 Mar 2024 15:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710343415;
	bh=IP2p6UB0Iw0uuB5s9+1fkRSK+RhQkxmHwBeJcrGlpEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lHQc+hr0Wq2NFCcdKe5SfpqUwSvs9H/E+m9e7UQp5YdGl4EKoulErVB8w4ygvnxHB
	 yT8J03v1/sQ7kcy6n5UDpDcK5m6rt9KEgbxMr5iJmf8up73XvVjuX3QlKVljupQmb/
	 0Ui6N7b/mk2ZzxhgO5a+jmVkn5rubI4tIrcQX+ofgq/AW0c67NWGnyvevI5pWRQ8LD
	 Qgm0ODhAJ2VzHWlE6XngxLY4j/45yucUpHyQFj5YyI4mJSxtkhV4t+rtB69fgvzhB1
	 szm3JN3CN/vh5L/OhXodECl/gighc7aF804j7a3bq01sPG0NdhkVv/Kl4eO96zGIGs
	 4/TKRbtYfu+kw==
Date: Wed, 13 Mar 2024 12:23:32 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Marco Elver <elver@google.com>
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
Message-ID: <ZfHE9Ev5T3Lq7o34@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>

On Wed, Mar 13, 2024 at 03:35:27PM +0100, Marco Elver wrote:
> On Tue, 12 Mar 2024 at 19:08, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> > the signal gets delayed until event_sched_out() which then uses
> > task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> > signal is delivered with disabled preemption.

> > While looking at this, I also stumbled upon __perf_pending_irq() which
> > requires disabled interrupts but this is not the case on PREEMPT_RT.

> > This series aim to address both issues while not introducing a new issue
> > at the same time ;)
> > Any testing is appreciated.

> > v1…v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy@linutronix.de/
> >     - Marco pointed me to the testsuite that showed two problems:
> >       - Delayed task_work from NMI / missing events.
> >         Fixed by triggering dummy irq_work to enforce an interrupt for
> >         the exit-to-userland path which checks task_work
> >       - Increased ref-count on clean up/ during exec.
> >         Mostly addressed by the former change. There is still a window
> >         if the NMI occurs during execve(). This is addressed by removing
> >         the task_work before free_event().
> >       The testsuite (remove_on_exec) fails sometimes if the event/
> >       SIGTRAP is sent before the sighandler is installed.
 
> Tested-by: Marco Elver <elver@google.com>
 
> It does pass the tests in tools/testing/selftests/perf_events (non-RT
> kernel, lockdep enabled). But I do recall this being a particularly
> sharp corner of perf, so any additional testing and review here is
> useful.

Right, I'm testing with the full 'perf test' suite now.

- Arnaldo

