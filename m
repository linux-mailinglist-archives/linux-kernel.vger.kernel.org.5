Return-Path: <linux-kernel+bounces-35394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3B839051
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 14:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87E3D1C217EA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 13:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593AE5EE9D;
	Tue, 23 Jan 2024 13:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t2W5xnYS"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1145EE95
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706017164; cv=none; b=KkR/xOmkRdVo98cXLw/VEgt86Vxuhfl3nrt+xdP29R0fcPT1Y/+cEyQhKX3BT55+8L3kLQwgQE19qqmuntL0CIvhILsty849lw4j3eoIYAlL5og8922rrcEmL3PihWDZvXL90EQmNbNNefjQyu+9zbzhnhF+N6fQSz8d1YkN0P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706017164; c=relaxed/simple;
	bh=PV0gotgQ8HWyyIYh2n0NsT4hz87RVuG5AXAATO5eiTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pMUEtZlGG+h+Vp+OiRNSdHXYiCz15sSCac5mqXx3GAh6v7UWyom1CML6447YlxVrzc4c+SGCfOaEZoVsYfc7Oj2X85as6TXNRjawOrEBvinRCEfWlHqTD67ERU19TKCTnm/VCI1gJaTf/MCrStZ+GFA3pxQRPyFXIRcQmvt50Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=t2W5xnYS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d746ce7d13so17650635ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 05:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706017162; x=1706621962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fs0Mh/MI7fPMkOhdn6T/Ousz65q9LrIAscwRh6VRAwA=;
        b=t2W5xnYSi54i5zGsN4UipF39H54v7DFpJX2v+qLBr+mnUkMs7+jlL9Ot2iqumnQFHt
         7wiGvPauXEYDJvZ/Nsdp053ZzlnfHynpf64d2QL7ejX52i/c+5ymAFQydU9ZviYOdapN
         bWtIHCRatAaR15o/9i65XyP/jz9YzwRP+hyxB5YLtxP05Yvi/ADw4NWUnlGLsPBaExUn
         99WTiQQ7auD0pU1G7xduulqWlamDwSfSyIl9JWk4X2cyuU/eR+15v64imVajX5h45YZi
         KIASgcyWmmn/rkbBPloFtWknxB1ROc51T5FuBnbwVlXqhEbtrE3qGJiS+Wgd9EqExma/
         IHmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706017162; x=1706621962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fs0Mh/MI7fPMkOhdn6T/Ousz65q9LrIAscwRh6VRAwA=;
        b=HVI6aYiSkM6jMfCRBIU22z2Lmkhxhku+jlrTDBcGdIcR7OIlQFJnX2MichhWQWtlGm
         aN/Zhfal8mELKBSpYhn6cNkBP4tYZhNOYxrY0cQZx8+XxyDhNQlw/w0bPywM0H2ERhZE
         3On8GuSwfbLuko7y3+qmoVidwIjNFFUVRxLRQaJcEnkWRKPAsIzxRtiZjRZ+UakI/bVA
         5AHSKEmiDgFCodcP/9kaeoNybi+L9uwVHE6+0vhP66mVhM8r9Qnl1TDIuM4yd65n2Ly7
         HMGCz6ozrsCYAuQ1CwgSJZ58rHJUL8NYiZw3z8KfeIFL26s0U9Tjz6N1NG6dmdy36b6D
         8cXA==
X-Gm-Message-State: AOJu0YyIolJDxiuD4yIFrOpyHxHJuL7hqd0oqQlpZ+7fK4Y7BdUOvDSL
	pYCxqywPYkxCKiUHhPixbuWXaduazuaq6iaNjnM/qOYKpGCz2g+rwzSe5dhwHhEDeV095JE51kp
	ign0hQOJ4tQSYvU5DJ8OABjoWbW2BwDh/jg4A+g==
X-Google-Smtp-Source: AGHT+IHM4TYCsFfRdFtuqPrOTde2m0HW4yM/WwYZTHHdONty5N9CXN8S4N9+HhcF/mKbhtJ7fDyhNeQ6+XqMl1pfrEM=
X-Received: by 2002:a17:90a:72c8:b0:28f:f863:e83a with SMTP id
 l8-20020a17090a72c800b0028ff863e83amr2933102pjk.97.1706017161933; Tue, 23 Jan
 2024 05:39:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119084548.2788-1-kprateek.nayak@amd.com> <b4f5ac150685456cf45a342e3bb1f28cdd557a53.camel@linux.intel.com>
 <21c8694c-26e4-3bc1-edd8-2267b0164a09@amd.com> <CAKfTPtCFJ5TRdsHHiH_fz9R2TC3euz_Rp=LH+aQ9KeZx3uH+ZQ@mail.gmail.com>
 <211132bf-3a50-bfe8-cdaf-af40ee7d0ce2@amd.com>
In-Reply-To: <211132bf-3a50-bfe8-cdaf-af40ee7d0ce2@amd.com>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Tue, 23 Jan 2024 14:39:10 +0100
Message-ID: <CAKfTPtC446Lo9CATPp7PExdkLhHQFoBuY-JMGC7agOHY4hs-Pw@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Skip newidle_balance() when an idle CPU is
 woken up to process an IPI
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com, 
	gautham.shenoy@amd.com, David Vernet <void@manifault.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 11:01, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
>
> Hello Vincent,
>
> On 1/23/2024 1:36 PM, Vincent Guittot wrote:
> > On Tue, 23 Jan 2024 at 05:58, K Prateek Nayak <kprateek.nayak@amd.com> wrote:
> >>
> >> Hello Tim,
> >>
> >> On 1/23/2024 3:29 AM, Tim Chen wrote:
> >>> On Fri, 2024-01-19 at 14:15 +0530, K Prateek Nayak wrote:
> >>>>
> >>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >>>> index b803030c3a03..1fedc7e29c98 100644
> >>>> --- a/kernel/sched/fair.c
> >>>> +++ b/kernel/sched/fair.c
> >>>> @@ -8499,6 +8499,16 @@ done: __maybe_unused;
> >>>>      if (!rf)
> >>>>              return NULL;
> >>>>
> >>>> +    /*
> >>>> +     * An idle CPU in TIF_POLLING mode might end up here after processing
> >>>> +     * an IPI when the sender sets the TIF_NEED_RESCHED bit and avoids
> >>>> +     * sending an actual IPI. In such cases, where an idle CPU was woken
> >>>> +     * up only to process an interrupt, without necessarily queuing a task
> >>>> +     * on it, skip newidle_balance() to facilitate faster idle re-entry.
> >>>> +     */
> >>>> +    if (prev == rq->idle)
> >>>> +            return NULL;
> >>>> +
> >>>
> >>> Should we check the call function queue directly to detect that there is
> >>> an IPI waiting to be processed? something like
> >>>
> >>>       if (!llist_empty(&per_cpu(call_single_queue, rq->cpu)))
> >>>               return NULL;
> >>
> >> That could be a valid check too. However, if an IPI is queued right
> >> after this check, the processing is still delayed since
> >> newidle_balance() only bails out for scenarios when a wakeup is trying
> >> to queue a new task on the CPU running the newidle_balance().
> >>
> >>>
> >>> Could there be cases where we want to do idle balance in this code path?
> >>> Say a cpu is idle and a scheduling tick came in, we may try
> >>> to look for something to run on the idle cpu.  Seems like after
> >>> your change above, that would be skipped.
> >>
> >> Wouldn't scheduler_tick() do load balancing when the time comes? In my
> >> testing, I did not see a case where the workloads I tested were
> >> sensitive to the aspect of newidle_balance() being invoked at scheduler
> >> tick. Have you come across a workload which might be sensitive to this
> >> aspect that I can quickly test and verify? Meanwhile, I'll run the
> >> workloads mentioned in the commit log on an Intel system to see if I
> >> can spot any sensitivity to this change.
> >
> > Instead of trying to fix spurious need_resched in the scheduler,
> > can't we find a way to prevent it from happening ?
>
> The need_resched is not spurious. It is an effect of the optimization
> introduced by commit b2a02fc43a1f ("smp: Optimize
> send_call_function_single_ipi()") where, to pull a CPU out of
> TIF_POLLING out of idle (and this happens for C0 (POLL) and C1 (MWAIT)
> on the test machine), instead of sending an IPI for
> smp_call_function_single(), the sender sets the TIF_NEED_RESCHED flag in
> the idle task's thread info and in the path to "schedule_idle()", the
> call to "flush_smp_call_function_queue()" processes the function call.

I mean it's spurious in the sense that we don't need to resched but we
need to pull the CPU out of the polling loop. At that time we don't
know if there is a need to resched

>
> But since "TIF_NEED_RESCHED" was set to pull the CPU out of idle, the
> scheduler now believes a new task exists which leads to the following
> call stack:

Exactly, TIF_NEED_RESCHED has been set so scheduler now believes it
needs to look for a task. The solution is to not set TIF_NEED_RESCHED
if you don't want the scheduler to look for a task including pulling
it from another cpu

>
>   do_idle()
>     schedule_idle()
>       __schedule(SM_NONE)
>         /* local_irq_disable() */
>         pick_next_task()
>           __pick_next_task()
>             pick_next_task_fair()
>               newidle_balance()
>               ... /* Still running with IRQs disabled */
>
> Since IRQs are disabled, the processing of IPIs are delayed leading
> issue similar to the one outlined in commit 792b9f65a568 ("sched:
> Allow newidle balancing to bail out of load_balance") when benchmarking
> ipistorm.

IMO it's not the same because commit 792b9f65a568 wants to abort early
if something new happened

>
> >
> > Because of TIF_NEED_RESCHED being set when TIF_POLLING is set, idle
> > load balances are already skipped for a less aggressive newly idle
> > load balanced:
> > https://lore.kernel.org/all/CAKfTPtC9Px_W84YRJqnFNkL8oofO15D-P=VTCMUUu7NJr+xwBA@mail.gmail.com/
>
> Are you referring to the "need_resched()" condition check in
> "nohz_csd_func()"? Please correct me if I'm wrong.

yes

>
> When I ran with sched-scoreboard
> (https://github.com/AMDESE/sched-scoreboard/)with the patch on an idle
> system for 60s I see the idle "load_balance count" go up in sched-stat

If TIF_POLLING is not set, you will use normal IPI but otherwise, the
wakeup for an idle load balance is skipped because need_resched is set
and we have an newly idle load balance  which you now want to skip too

>
> Following are the data for idle balance on SMT domain for each kernel:
>
> o tip:sched/core
>
>   < ----------------------------------------  Category:  idle ----------- >
>   load_balance count on cpu idle                             :       2678
>   load_balance found balanced on cpu idle                    :       2678
>     ->load_balance failed to find busier queue on cpu idle   :          0
>     ->load_balance failed to find busier group on cpu idle   :       2678
>   load_balance move task failed on cpu idle                  :          0
>   *load_balance success count on cpu idle                    :          0
>   imbalance sum on cpu idle                                  :          0
>   pull_task count on cpu idle                                :          0
>   *avg task pulled per successfull lb attempt (cpu idle)     :          0
>     ->pull_task when target task was cache-hot on cpu idle   :          0
>   -------------------------------------------------------------------------
>
> o tip:sched/core + patch
>
>   < ----------------------------------------  Category:  idle ----------- >
>   load_balance count on cpu idle                             :       1895
>   load_balance found balanced on cpu idle                    :       1895
>     ->load_balance failed to find busier queue on cpu idle   :          0
>     ->load_balance failed to find busier group on cpu idle   :       1895
>   load_balance move task failed on cpu idle                  :          0
>   *load_balance success count on cpu idle                    :          0
>   imbalance sum on cpu idle                                  :          0
>   pull_task count on cpu idle                                :          0
>   *avg task pulled per successfull lb attempt (cpu idle)     :          0
>     ->pull_task when target task was cache-hot on cpu idle   :          0
>   -------------------------------------------------------------------------
>
> Am I missing something? Since "load_balance count" is only updated when
> "load_balance()" is called.
>
> >
> > The root of the problem is that we keep TIF_NEED_RESCHED set
>
> We had prototyped a TIF_NEED_IPI flag to skip calls to schedule_idle()
> on CPUs in TIF_POLLING when the idle CPU has to only process an IPI.
> Although it solves the problem described in the commit log, it also
> required enabling and testing it on multiple architectures.

Yes, but that's the right solution IMO and it will prevent us to then
try to catch the needless TIF_NEED_RESCHED

>
>   $ grep -r "_TIF_POLLING" arch/ | cut -d '/' -f2 | uniq
>   csky
>   x86
>   powerpc
>   parisc
>   openrisc
>   sparc
>   nios2
>   microblaze
>   sh
>   alpha
>
> This optimization in the scheduler was the simpler of the two to achieve
> the same result in case of ipistorm.
>
> >
> >>
> >> [..snip..]
>
> --
> Thanks and Regards,
> Prateek

