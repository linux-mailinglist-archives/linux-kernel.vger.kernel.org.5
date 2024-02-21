Return-Path: <linux-kernel+bounces-74881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7095C85DEBB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 222D81F21D54
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23717BB0B;
	Wed, 21 Feb 2024 14:21:25 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4AA4C62;
	Wed, 21 Feb 2024 14:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525285; cv=none; b=AebVgJ4wICl2AU6Hc99XCoTx/X+is6obuieMng64xE4D8X8uA9JoIoLd/u/rfyvOi+v/ZTa85lAjtp1BtmcHAM/Xa0S2MvD5aMFyNxtLYxU87S73GGAEqZJPW0J5pRDMM3t2M73H/a/zYzCHVQzgR6/QzGcmU2wsGDSylkAwBig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525285; c=relaxed/simple;
	bh=A4HgXRGDVVWg5a5ZtE9lWeLwYz5CzwymEup8k2SG11U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC1EJVHD3R0zZCKynpJKn/TwQ5ne0THN922PxXvtaceUwdvdEMmRRtplKQmiV+WP1ZYOLg2nifs4KXHMWFFXDQSd/VdfV4680Y+8XjyBgKpXuflhlD8YeO3U3etZWLEu9/q+FX+bcYQTvvl98XJK08QsLumgCgJG608aHmzmA/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA07CC43390;
	Wed, 21 Feb 2024 14:21:21 +0000 (UTC)
Date: Wed, 21 Feb 2024 09:23:09 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Metin Kaya <metin.kaya@arm.com>
Cc: linux-kernel@vger.kernel.org, John Stultz <jstultz@google.com>, Joel
 Fernandes <joelaf@google.com>, Qais Yousef <qyousef@google.com>, Ingo
 Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot
 <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Valentin Schneider <vschneid@redhat.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Ben Segall <bsegall@google.com>, Zimuzo Ezeozue <zezeozue@google.com>,
 Youssef Esmat <youssefesmat@google.com>, Mel Gorman <mgorman@suse.de>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Will Deacon
 <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng
 <boqun.feng@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Xuewen Yan
 <xuewen.yan94@gmail.com>, K Prateek Nayak <kprateek.nayak@amd.com>, Thomas
 Gleixner <tglx@linutronix.de>, kernel-team@android.com,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Add trace events for Proxy Execution (PE)
Message-ID: <20240221092309.00432f37@gandalf.local.home>
In-Reply-To: <20240202083338.1328060-1-metin.kaya@arm.com>
References: <20240202083338.1328060-1-metin.kaya@arm.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  2 Feb 2024 08:33:38 +0000
Metin Kaya <metin.kaya@arm.com> wrote:

> Add sched_[start, finish]_task_selection trace events to measure the
> latency of PE patches in task selection.
> 
> Moreover, introduce trace events for interesting events in PE:
> 1. sched_pe_enqueue_sleeping_task: a task gets enqueued on wait queue of
>    a sleeping task (mutex owner).
> 2. sched_pe_cross_remote_cpu: dependency chain crosses remote CPU.
> 3. sched_pe_task_is_migrating: mutex owner task migrates.
> 
> New trace events can be tested via this command:
> $ perf trace \
>   -e sched:sched_start_task_selection \
>   -e sched:sched_finish_task_selection \
>   -e sched:sched_pe_enqueue_sleeping_task \
>   -e sched:sched_pe_cross_remote_cpu \
>   -e sched:sched_pe_task_is_migrating
> 
> Notes:
> 1. These trace events are not intended to merge upstream. Instead, they
>    are only for making PE tests easier and will be converted to trace
>    points once PE patches hit upstream.

I wonder if the tracepoints should be added though? That is, not adding the
trace_events that show up in tracefs, but just the tracepoints so that bpf
or local modules could hook to them?

-- Steve


> 2. This patch is based on John's Proxy Execution v7 patch series (see
>    the link below) which is also available at
>    https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v7-6.7-rc6/.
> 
> Link: https://lore.kernel.org/linux-kernel/CANDhNCrHd+5twWVNqBAhVLfhMhkiO0KjxXBmwVgaCD4kAyFyWw@mail.gmail.com/


