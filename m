Return-Path: <linux-kernel+bounces-102339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599587B0E5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:04:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 574531C273E3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FC2605D0;
	Wed, 13 Mar 2024 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivF6CPGg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD2A605DE;
	Wed, 13 Mar 2024 18:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710353673; cv=none; b=NXyLQDAMbRPc1/Wy642Ute5XCIY1qGdVla4UVv1Ib4FoqSomClHlvcWrqA681+54WvvmZP/551ETtCjHVXSb/avDw+wc7ubQWEFh+QKjgaISsZZd3OD2YAEkUWt5B+ay7mIvIeFynSn7AGLdq30TFGKQj2R07FwO8zDj8j5XJHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710353673; c=relaxed/simple;
	bh=TNsbIG73NJ2s8kx6QAgm6sHZZACJCXrLFk+uu7waAMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QkQkQ05CVQaO99sgsrs23ZKAM8i9+/NhUnVSn5tlp/k7rawb0rrcv7nuQjaBFIb31cgfgX61cYoeMolWGjcFxclIWniXkfHf24bq4NDxJrJXLvJQVqfA8TTreBKYqGvni1PSGvK9hm+xoi+8y4g2/+dsKY3TW8pUNRwuKt5fvC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivF6CPGg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6F9C433F1;
	Wed, 13 Mar 2024 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710353671;
	bh=TNsbIG73NJ2s8kx6QAgm6sHZZACJCXrLFk+uu7waAMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ivF6CPGgFPCX98z7CAELLpGZeuAFTB2HCZ+oVCegSk3BJ0eIiwidSX5m9sqRCtPzI
	 wEnH5fsgQ75rFmoxFqJeEz3YAnpbD0DEQJgItbItHAB9ILD7qxhsn/GWMillLBsDc9
	 ChA4i3IT4anWW7MYDYIdFhGibQ4peD34IHRct3XrQCkc4Kq6YLJVKDLcL5dNxGZkrF
	 PZIdZW9vjIYMwnVnAtsFoh+IjsTeYrUJEzDWDmI8FLVOYeOKDb8NvacfrTxQLf2FOm
	 yClXdfNOQotjOhPWjYDpZvxKe13oSvRicj27E12i/Sis7YrLzcfy9rYys/4AQ1ygyx
	 ZhN3+jjiSXpGg==
Date: Wed, 13 Mar 2024 15:14:28 -0300
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
Message-ID: <ZfHtBB5_-3RByE8p@x1>
References: <20240312180814.3373778-1-bigeasy@linutronix.de>
 <CANpmjNMYGa46pRQUOfzTa_FRvftOGqg+UDeD_B-tbZgYw-MWww@mail.gmail.com>
 <ZfHE9Ev5T3Lq7o34@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZfHE9Ev5T3Lq7o34@x1>

On Wed, Mar 13, 2024 at 12:23:32PM -0300, Arnaldo Carvalho de Melo wrote:
> On Wed, Mar 13, 2024 at 03:35:27PM +0100, Marco Elver wrote:
> > On Tue, 12 Mar 2024 at 19:08, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> > > Arnaldo reported that "perf test sigtrap" fails on PREEMPT_RT. Sending
> > > the signal gets delayed until event_sched_out() which then uses
> > > task_work_add() for its delivery. This breaks on PREEMPT_RT because the
> > > signal is delivered with disabled preemption.
 
> > > While looking at this, I also stumbled upon __perf_pending_irq() which
> > > requires disabled interrupts but this is not the case on PREEMPT_RT.
 
> > > This series aim to address both issues while not introducing a new issue
> > > at the same time ;)
> > > Any testing is appreciated.
 
> > > v1…v2: https://lore.kernel.org/all/20240308175810.2894694-1-bigeasy@linutronix.de/
> > >     - Marco pointed me to the testsuite that showed two problems:
> > >       - Delayed task_work from NMI / missing events.
> > >         Fixed by triggering dummy irq_work to enforce an interrupt for
> > >         the exit-to-userland path which checks task_work
> > >       - Increased ref-count on clean up/ during exec.
> > >         Mostly addressed by the former change. There is still a window
> > >         if the NMI occurs during execve(). This is addressed by removing
> > >         the task_work before free_event().
> > >       The testsuite (remove_on_exec) fails sometimes if the event/
> > >       SIGTRAP is sent before the sighandler is installed.
>  
> > Tested-by: Marco Elver <elver@google.com>
>  
> > It does pass the tests in tools/testing/selftests/perf_events (non-RT
> > kernel, lockdep enabled). But I do recall this being a particularly
> > sharp corner of perf, so any additional testing and review here is
> > useful.

> Right, I'm testing with the full 'perf test' suite now.

'perf test' doesn't show any regression, now I'm running Vince Weaver's
https://github.com/deater/perf_event_tests, storing the results with
this patchset and then without, to do a diff, lets see...

- Arnaldo

