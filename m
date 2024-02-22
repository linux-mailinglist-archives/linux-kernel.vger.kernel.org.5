Return-Path: <linux-kernel+bounces-77475-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8D728605D7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 23:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 712611F2443C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 22:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F4118059;
	Thu, 22 Feb 2024 22:55:28 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CF6256A
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708642527; cv=none; b=GZPjdlVAQk3Y3mNjXqUP07CU0/3aCX7ocCGB7jc0fcKxMW44U64/IcrTTqI4TXqlTRhb2gL4IqLaM/e699dvLVdz6gNexUJIJgTTX1kbaHF71zDrSDua+TMLKvmr83JlwqURapdANZ41SgyhMAuGOLTe+h3sQnUp1EYhpqz5z2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708642527; c=relaxed/simple;
	bh=EPCcr1ZcPmoYlF6Aa/he5Fx0lw6N1qSblFP9FR4V1yw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYsgczfnvz/XOqqVVbpJgGPxAF4BtC4xkvePr7Ma2ITYcoltXcQoPeMzw1VZrxWdbz8eWGM5NOCFH7zOWnllimq81des1giemSvzpSLP8K2LONxqd0zPSiyGaYOlzKUpTxiDmX25lXIaisf4QQ3OWJWUmHYhznPqLR/yayjme2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8976C433F1;
	Thu, 22 Feb 2024 22:55:25 +0000 (UTC)
Date: Thu, 22 Feb 2024 17:57:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann
 <dietmar.eggemann@arm.com>, Ben Segall <bsegall@google.com>, Mel Gorman
 <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>, kernel-team@android.com, Zimuzo
 Ezeozue <zezeozue@google.com>
Subject: Re: [PATCH] [RFC] sched: Add trace_sched_waking() tracepoint to
 sched_ttwu_pending()
Message-ID: <20240222175715.0593cb09@gandalf.local.home>
In-Reply-To: <20240222204917.1719153-1-jstultz@google.com>
References: <20240222204917.1719153-1-jstultz@google.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 12:49:03 -0800
John Stultz <jstultz@google.com> wrote:

> Zimuzo reported seeing occasional cases in perfetto traces where
> tasks went from sleeping directly to trace_sched_wakeup()
> without always seeing a trace_sched_waking().
> 
> Looking at the code, trace_sched_wakeup() is only called in
> ttwu_do_wakeup()
> 
> The call paths that get you to ttwu_do_wakeup() are:
> try_to_wake_up() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_runnable() -> ttwu_do_wakeup()
> try_to_wake_up() -> ttwu_queue() -> ttwu_do_activate() -> ttwu_do_wakeup()
> sched_ttwu_pending() -> ttwu_do_activate() -> ttwu_do_wakeup()
> 
> where trace_sched_waking() is currently called only in
> try_to_wake_up().
> 
> So this patch adds a trace_sched_waking() call to
> sched_ttwu_pending(), so we see the same state machine
> transitions.
> 
> With this change, the number of unexpected state transitions
> in perfetto was greatly reduced.
> 
> This has been in my drafts for awhile, so I wanted to send
> this out for thoughts/feedback.

I just added at the same location as your trace event:

   trace_printk("SCHED_WAKING %s:%d\n", p->comm, p->pid);

And then ran: trace-cmd record -e 'sched_wak*'

Where trace-cmd report gives:

     kworker/0:1-10    [000] d..3.   190.212851: sched_waking:         comm=kworker/7:3 pid=114 prio=120 target_cpu=007
          <idle>-0     [002] d.h2.   190.212856: bprint:               sched_ttwu_pending: SCHED_WAKING kworker/2:1:110
          <idle>-0     [002] dNh2.   190.212861: sched_wakeup:         kworker/2:1:110 [120] CPU:002
          <idle>-0     [001] d.h2.   190.212911: bprint:               sched_ttwu_pending: SCHED_WAKING kworker/1:1:85
          <idle>-0     [003] d.h2.   190.212918: bprint:               sched_ttwu_pending: SCHED_WAKING kworker/3:1:77
          <idle>-0     [001] dNh2.   190.212919: sched_wakeup:         kworker/1:1:85 [120] CPU:001
          <idle>-0     [003] dNh2.   190.212927: sched_wakeup:         kworker/3:1:77 [120] CPU:003
          <idle>-0     [004] d.h2.   190.212930: bprint:               sched_ttwu_pending: SCHED_WAKING kworker/4:1:115
          <idle>-0     [004] dNh2.   190.212939: sched_wakeup:         kworker/4:1:115 [120] CPU:004
          <idle>-0     [007] d.h2.   190.212943: bprint:               sched_ttwu_pending: SCHED_WAKING kworker/7:3:114
          <idle>-0     [007] dNh2.   190.212952: sched_wakeup:         kworker/7:3:114 [120] CPU:007
          <idle>-0     [001] d.h3.   190.511970: sched_waking:         comm=gmain pid=474 prio=120 target_cpu=001
          <idle>-0     [001] dNh4.   190.511989: sched_wakeup:         gmain:474 [120] CPU:001
          <idle>-0     [006] d.s3.   190.708715: sched_waking:         comm=kcompactd0 pid=70 prio=120 target_cpu=006
          <idle>-0     [006] dNs4.   190.708726: sched_wakeup:         kcompactd0:70 [120] CPU:006
          <idle>-0     [002] d.s4.   190.916737: sched_waking:         comm=kworker/2:1 pid=110 prio=120 target_cpu=002
          <idle>-0     [002] dNs5.   190.916747: sched_wakeup:         kworker/2:1:110 [120] CPU:002
          <idle>-0     [005] d.s4.   191.044665: sched_waking:         comm=kworker/5:0H pid=44 prio=100 target_cpu=005
          <idle>-0     [005] dNs5.   191.044675: sched_wakeup:         kworker/5:0H:44 [100] CPU:005
          <idle>-0     [006] d.s3.   191.212680: sched_waking:         comm=kcompactd0 pid=70 prio=120 target_cpu=006
          <idle>-0     [006] dNs4.   191.212691: sched_wakeup:         kcompactd0:70 [120] CPU:006
          <idle>-0     [001] d.s3.   191.556713: sched_waking:         comm=khugepaged pid=73 prio=139 target_cpu=001
          <idle>-0     [001] dNs4.   191.556723: sched_wakeup:         khugepaged:73 [139] CPU:001
          <idle>-0     [001] dNs4.   191.556728: sched_waking:         comm=kworker/1:1 pid=85 prio=120 target_cpu=001

Where only sched_wakeup shows the trace_printk() output but other
sched_waking events have a matching sched_wakeup event. I would say this is
a bug.

This will also cause some of my tooling to be incorrect too, as I normally
just use "sched_waking" to find wake ups :-/

-- Steve

