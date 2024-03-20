Return-Path: <linux-kernel+bounces-109217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5757588164B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:15:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11A6B2851CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:15:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 221E16A35F;
	Wed, 20 Mar 2024 17:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="pjB0df84"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32F36A32B;
	Wed, 20 Mar 2024 17:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.114.26.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954923; cv=none; b=cnWFFQqgVGIH5IJrv1q0pMT0a7zkvfHe45f/+FDVwOirb5iRMfr5wR/bH/PL/keINXspB2mnWPvuaXQW5bgAnzKiSDNHdlL3J3DS+4pUoFf9sOGLxGH/UIZm+gtittLJ7/CZwaIYOjAlBSv0yt5C+w6k7lbjUPSbucnf4qMtb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954923; c=relaxed/simple;
	bh=z1/MMY0gz+SqFkVc+bk3yKmk8hs8tewnxrsZE84uUs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=egevFN3pf/A0pBK0UoGcHJMQqxpWPeT8KnGoYByXA06gjFwAxLIb7eRbj8gz34e6mXFgl4sfxKM+QrgYDM1JQ+RkAdNFI182d+q+fynSaX+qSkteujl7gBCCjiFpVAMnUBhGoVxbFKzrkxk8ZGCn5UBSRqIVmmlUoIJ+4J+Um68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=pjB0df84; arc=none smtp.client-ip=167.114.26.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1710954919;
	bh=z1/MMY0gz+SqFkVc+bk3yKmk8hs8tewnxrsZE84uUs8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pjB0df84D+cDiEfq2bHUmePByJL2vv4YfRKc6J9/6OyOtvgs2+xTvhB9nw5YEQdu+
	 pdnRKgp8WnSUm16yacJDeE+6+8RAh4fd6+S9ETaE89bs0texI4T/yaxxPwQG/ExvqG
	 R+nkG/zDov2hR2KlPGYo48aSDJJeGxQPIMot06gCpWEgrV9MQmdZrOVFZCOs0qcyHP
	 ldnFNZVrIsU1iJ+xxDVQPsngdCYtLtXzeikImT6vJ08Mv5baw4xtxp4HDdNTcuwizP
	 /C5+Hwx1/mLvAnfxsle+BcFfV3RgcvFCsowExRtxk1FMNMUsrODJpFJOlgAhMZq+2h
	 Rlx0DBn8lRRbw==
Received: from [172.16.0.134] (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4V0FbC3dglzkh3;
	Wed, 20 Mar 2024 13:15:19 -0400 (EDT)
Message-ID: <0015569b-15dc-4ccd-b322-67c3665c585e@efficios.com>
Date: Wed, 20 Mar 2024 13:15:39 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] tracing: Introduce restart_critical_timings()
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 linux-rt-users <linux-rt-users@vger.kernel.org>
References: <20240320122012.2c1f461f@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20240320122012.2c1f461f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024-03-20 12:20, Steven Rostedt wrote:
> From: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> I'm debugging some latency issues on a Chromebook and the preemptirqsoff
> tracer hit this:
> 
> # tracer: preemptirqsoff
> #
> # preemptirqsoff latency trace v1.1.5 on 5.15.148-21853-g165fd2387469-dirty
> # --------------------------------------------------------------------
> # latency: 7813 us, #60/60, CPU#1 | (M:preempt VP:0, KP:0, SP:0 HP:0 #P:2)
> #    -----------------
> #    | task: init-1 (uid:0 nice:0 policy:0 rt_prio:0)
> #    -----------------
> #  => started at: rwsem_optimistic_spin
> #  => ended at:   rwsem_optimistic_spin
> #
> #
> #                    _------=> CPU#
> #                   / _-----=> irqs-off
> #                  | / _----=> need-resched
> #                  || / _---=> hardirq/softirq
> #                  ||| / _--=> preempt-depth
> #                  |||| / _-=> migrate-disable
> #                  ||||| /     delay
> #  cmd     pid     |||||| time  |   caller
> #     \   /        ||||||  \    |    /
>     <...>-1         1...1.    0us!: rwsem_optimistic_spin+0x20/0x194 <-rwsem_optimistic_spin+0x20/0x194
>     <...>-1         1.N.1. 7813us : rwsem_optimistic_spin+0x140/0x194 <-rwsem_optimistic_spin+0x140/0x194
>     <...>-1         1.N.1. 7814us+: tracer_preempt_on+0x4c/0x6a <-rwsem_optimistic_spin+0x140/0x194
>     <...>-1         1.N.1. 7824us : <stack trace>
>   => rwsem_optimistic_spin+0x140/0x194
>   => rwsem_down_write_slowpath+0xc9/0x3fe
>   => copy_process+0xd08/0x1b8a
>   => kernel_clone+0x94/0x256
>   => __x64_sys_clone+0x7a/0x9a
>   => do_syscall_64+0x51/0xa1
>   => entry_SYSCALL_64_after_hwframe+0x5c/0xc6
> 
> Which isn't a real issue, as it's in the rwsem_optimistic_spin() code that
> spins with interrupts enabled, preempt disabled, and checks for
> need_resched(). If it is true, it breaks out and schedules.
> 
> Hence, it's hiding real issues, because it can spin for a very long time
> and this is not the source of the latency I'm tracking down.
> 
> I would like to introduce restart_critical_timings() and place it in
> locations that have this behavior.

Is there any way you could move this to need_resched() rather than
sprinkle those everywhere ?

Thanks,

Mathieu

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 
> diff --git a/include/linux/irqflags.h b/include/linux/irqflags.h
> index 147feebd508c..e9f97f60bfc0 100644
> --- a/include/linux/irqflags.h
> +++ b/include/linux/irqflags.h
> @@ -145,6 +145,13 @@ do {						\
>   # define start_critical_timings() do { } while (0)
>   #endif
>   
> +/* Used in spins that check need_resched() with preemption disabled */
> +static inline void restart_critical_timings(void)
> +{
> +	stop_critical_timings();
> +	start_critical_timings();
> +}
> +
>   #ifdef CONFIG_DEBUG_IRQFLAGS
>   extern void warn_bogus_irq_restore(void);
>   #define raw_check_bogus_irq_restore()			\
> diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
> index 2340b6d90ec6..fa7b43e53d20 100644
> --- a/kernel/locking/rwsem.c
> +++ b/kernel/locking/rwsem.c
> @@ -27,6 +27,7 @@
>   #include <linux/export.h>
>   #include <linux/rwsem.h>
>   #include <linux/atomic.h>
> +#include <linux/irqflags.h>
>   #include <trace/events/lock.h>
>   
>   #ifndef CONFIG_PREEMPT_RT
> @@ -780,6 +781,7 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
>   		 */
>   		barrier();
>   
> +		restart_critical_timings();
>   		if (need_resched() || !owner_on_cpu(owner)) {
>   			state = OWNER_NONSPINNABLE;
>   			break;
> @@ -912,6 +914,7 @@ static bool rwsem_optimistic_spin(struct rw_semaphore *sem)
>   		 * a writer, need_resched() check needs to be done here.
>   		 */
>   		if (owner_state != OWNER_WRITER) {
> +			restart_critical_timings();
>   			if (need_resched())
>   				break;
>   			if (rt_task(current) &&

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com


