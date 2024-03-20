Return-Path: <linux-kernel+bounces-109339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 179328817CE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C21262856D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC6985297;
	Wed, 20 Mar 2024 19:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QYKpL+qx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8644E85636
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962683; cv=none; b=Ab6sAkbz4+kFPWDYMB0V1pZvKZuReE88dLaZ5UmPFQZiIxFgLZtpfs5ek3xE6usZXb6iBGGm7ugkFNYIyVl/dSPopdn4gMTLoOPXK6g40+7WMbQS9oVO6PmDTf9WCZd5U6SdGRq4N5P0LSt51c42ululatJ9+faeqwz0RqeUNNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962683; c=relaxed/simple;
	bh=Z8zOpRe23G3rEgXuexMNpYPkYOkpCD3dluzXVqDuh18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEDp0/OysW+k8tC8KVZ6QDlbjXHj5cVPmbdZA/gvTQjanv/8Ad/ysclDJBw7JcGG3DCxcGuOfMp3sLp3/2whWgOqtX2Lba2yjlq03t+T67rJF2rxuzB3wbpmYhVSnfGRSGyaogHHJKDx4dcwJ4f4R1ksdvdXG+wamO8gCHtLSB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QYKpL+qx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61583C433C7;
	Wed, 20 Mar 2024 19:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710962683;
	bh=Z8zOpRe23G3rEgXuexMNpYPkYOkpCD3dluzXVqDuh18=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QYKpL+qx/ATcxpUa9YvUz2aaQyPnT6WoF5SftfZ64I55zpsWSAG0ssYDGnRNXyhFf
	 MIstR2Xu6QdCv4bS1+otLEUFQBsZjp6BBk9/O5yQBtC38bDGBDXzhy5apZBBCssmKi
	 VA6wvzQIYL9HlS4rD7q4Vzi+fjiKtDtv3LbPU3q8xINm3fA4bvrlnPcUR9/OgTBvFV
	 1vubcXgxdOc1929Agl7lsrXYKeqN8/NfGuxjleQPGpu4QHAmt9Nr9dyl+WhnqQslzj
	 soznFVl5xUSySBwh28wQefTSIbnh5RRXCcDHucXCf9v81GUpqJWAtVnMLDi9sYrv5l
	 DTNYLPU48o52g==
Message-ID: <d7d8540e-c417-41fa-aea9-acb80541a30d@kernel.org>
Date: Wed, 20 Mar 2024 20:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/7] sched/deadline: Deferrable dl server
Content-Language: en-US, pt-BR, it-IT
To: Joel Fernandes <joel@joelfernandes.org>, Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Valentin Schneider <vschneid@redhat.com>,
 linux-kernel@vger.kernel.org, Luca Abeni <luca.abeni@santannapisa.it>,
 Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Shuah Khan <skhan@linuxfoundation.org>, Phil Auld <pauld@redhat.com>
References: <cover.1699095159.git.bristot@kernel.org>
 <c7b706d30d6316c52853ca056db5beb82ba72863.1699095159.git.bristot@kernel.org>
 <1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <1e26ce6d-5567-477f-847b-445160b2f18c@joelfernandes.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/24 01:03, Joel Fernandes wrote:
> 
> 
> On 11/4/2023 6:59 AM, Daniel Bristot de Oliveira wrote:
>> Among the motivations for the DL servers is the real-time throttling
>> mechanism. This mechanism works by throttling the rt_rq after
>> running for a long period without leaving space for fair tasks.
>>
>> The base dl server avoids this problem by boosting fair tasks instead
>> of throttling the rt_rq. The point is that it boosts without waiting
>> for potential starvation, causing some non-intuitive cases.
>>
>> For example, an IRQ dispatches two tasks on an idle system, a fair
>> and an RT. The DL server will be activated, running the fair task
>> before the RT one. This problem can be avoided by deferring the
>> dl server activation.
>>
>> By setting the zerolax option, the dl_server will dispatch an
>> SCHED_DEADLINE reservation with replenished runtime, but throttled.
>>
>> The dl_timer will be set for (period - runtime) ns from start time.
>> Thus boosting the fair rq on its 0-laxity time with respect to
>> rt_rq.
>>
>> If the fair scheduler has the opportunity to run while waiting
>> for zerolax time, the dl server runtime will be consumed. If
>> the runtime is completely consumed before the zerolax time, the
>> server will be replenished while still in a throttled state. Then,
>> the dl_timer will be reset to the new zerolax time
>>
>> If the fair server reaches the zerolax time without consuming
>> its runtime, the server will be boosted, following CBS rules
>> (thus without breaking SCHED_DEADLINE).

notice: at this point in history, the term zero-laxity was removed from
the latest code we have, the term was moved to defer server... I will
remove from the long in the next time I send it.

>> Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
> 
> Hi, Daniel,
> We have one additional patch (other than the 15 I just sent).

Those 15 are the next thing I will review... I was working in the merge window.

Since I have just
> 3 more working days for the next 3 weeks, I thought I might as well reply inline
> here since it might be unnecessary to resend all 15 patches so soon just for the
> one new addition below. I am replying to this patch here, because the new patch
> is related (to 0-laxity).  But once I am back from holiday, I can resend it with
> the set I have unless you've applied it.

before starting... in three weeks, we will be very far still from any attempt to
ping Peter & ingo to ask if they could think about putting us into a queue.
Have fun :-)

as I explained at LPC.. and in chat... there is no "0-laxity", and repeating it
only creates more confusion. Let's use a deferred server... a regular deadline
reservation with deferred starting time at (now + period - runtime), and at that point
il will receive a new deadline one period away - (not one runtime away).

There will always be a person reading these emails and echoing the wrong things...
using 0-lax/0-laxity term here is a lose-lose.

> So, Vineeth and me came up with a patch below to "max cap" the DL server 0-lax
> time (max cap is default off keeping the regular behavior). This is needed to
> guarantee bandwidth for periodic CFS runners/sleepers.

Another point... "guarantee bandwidth"... the bandwith is provided under certain conditions.
If the conditions are not respected, the guarantee a dl reservation will provide is that
the task will not put a utilization higher than the one requested, so yes, a dl reservation
can and will enforce a lower utilization if the task does not respect the conditions.
Also, if the reservation is ready, but no task is ready...

> 
> The example usecase is:
> 
> Consider DL server params 25ms / 50ms.
> 
> Consider CFS task with duty cycle of 25ms / 76ms (run 25ms sleep 51ms).

define duty... like, runtime 25, period 76? sleeps for 51 relative to a starting time
or not?

there are some holes in your explanation, it is tricky to reply inline for these cases...
I am continuing but....

> 
>          run 25ms                    run 25ms
>          _______                     _______
>         |       | sleep 51          |       |  sleep 51
> -|------|-------|---------|---------|-------|----------|--------|------> t
>  0     25      50       101        126      151       202      227
>                           \ 0-lax /                    \ 0-lax /


trying to understand...

at time 0 the task is activated... RT tasks are spinning... assuming that so the
server was deferred to 25?

At 25, it becomes DL, with a new deadline of 75. If there is no other DL
task, run [25..50].

at 75 the task would have another 25 ms... but it decided not to run, throwing
away 25 ms until 100. At this point, I would say: is not an odd setup....

At point 100, the deferred server assumes that the starvation condition is gone,
and goes to the initial state.

now, that 0-lax means what? the zero-laxity time for the task... but not
from its start time, but from the beginning of the deferred server = 25 + 76 = 101
.. also 0-lax is a range?

and here, the system seems to start the same cycle with a 1 shift to repeat the
case that the task and the reservation did not match.

looking back, for the first cycle... with defer at 75, without at point 50, there
would be time for the server to run, but the task is just ready, so runtime is
thrown away.

So, this miss match between the configuration and the task setup is... clearly
causing runtime to be wasted... but one can change the parameter for them
to be better in sync...

and here, I assume that there is something missing in the explanation because...


> Here the 0-lax addition in the original v5's zero-lax patch causes lesser bandwidth.

which addition?

> So the task runs 50ms every 227ms, instead of 50ms every 152ms.

..

> 
> A simple unit test confirms the issue, and it is fixed by Vineeth's patch below:
> 
> Please take a look at the patch below (applies only to v5.15 but Vineeth is
> rebase on mainline as we speak), thanks.
> 
> -----8<--------
> From: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> Subject: [PATCH] sched/deadline/dlserver: sysctl for dlserver maxdefer time
> 
> Inorder to avoid dlserver preempting RT tasks when it wakes up, dlserver
> is throttled(deferred) until zero lax time. This is the farthest time
> before deadline where dlserver can meet its deadline.
> 
> Zero lax time causes cfs tasks with sleep/run pattern where the cfs
> tasks doesn't get the bandwidth promised by dlserver. So introduce a
> sysctl for limiting the defer time of dlserver.

so... that explanation before to reach to the conclusion that limiting the
amount of time to defer the server is a fix? there is a huge gap here.

> 
> Suggested-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
> ---
>  include/linux/sched/sysctl.h | 2 ++
>  kernel/sched/deadline.c      | 6 ++++++
>  kernel/sysctl.c              | 7 +++++++
>  3 files changed, 15 insertions(+)
> 
> diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
> index 4939e6128840..a27fba6fe0ab 100644
> --- a/include/linux/sched/sysctl.h
> +++ b/include/linux/sched/sysctl.h
> @@ -41,6 +41,8 @@ extern unsigned int sysctl_iowait_apply_ticks;
>  extern unsigned int sysctl_sched_dl_period_max;
>  extern unsigned int sysctl_sched_dl_period_min;
>  +extern unsigned int sysctl_sched_dlserver_maxdefer_ms;
> +
>  #ifdef CONFIG_UCLAMP_TASK
>  extern unsigned int sysctl_sched_uclamp_util_min;
>  extern unsigned int sysctl_sched_uclamp_util_max;
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index d638cc5b45c7..69c9fd80a67d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -1071,6 +1071,11 @@ static int start_dl_timer(struct sched_dl_entity *dl_se)
>  	if (dl_se->dl_defer_armed) {
>  		WARN_ON_ONCE(!dl_se->dl_throttled);
>  		act = ns_to_ktime(dl_se->deadline - dl_se->runtime);
> +		if (sysctl_sched_dlserver_maxdefer_ms) {
> +			ktime_t dlserver_maxdefer = rq_clock(rq) +
> ms_to_ktime(sysctl_sched_dlserver_maxdefer_ms);
> +			if (ktime_after(act, dlserver_maxdefer))
> +				act = dlserver_maxdefer;


that is, having a global limit... we have a per-cpu set of variables,
that is bounded by a global limit.

<joking>
It is already hard to put in sync with two parameters. Now we need a
third one that is global :-)
<joking>

reading the code was actually more instructive than reading the comments.
The good point is that this puts a nail in the coffin of "zerolax" :-)

that is, you all want also to control for how long the defer happens. Now
it is fixed... (period - runtime). You all would like to have the ability
to set it so something closer, so to defer less.

That phrase is simple :-)

It is already possible! how? This can be done by adjusting runtime/period.
Which are already per CPU. The DL server does not need to give an entire
chuck all at once; one can split it into smaller runtime/period slices,
as EEVDF does. And here we get back to the things we talked about when
trying to use EDF... but now it is only for one task :-) It is easier.

This also reduces the amount of time thrown away because there is no
task ready. It is the main cause of time wasted anyway. And the CFS
scheduler is really aperiodic, in practice, these more corner
case timelines will hardly happen... unless you try to force with
a simple test case.

now... could I change the defer per-cpu option to have a value between
0 and (period - runtime) so we could defer less than (period - runtime),
with proper check and granularity (per cpu) in the next version I send
for the interface.... maybe... it is less prone to have a no no from
people who care a lot about the interface.

But I am asking myself: is it worth the complexity? I would try first
getting used with the runtime/period setup only...

I will start reviewing the other patches as soon as the worries
of the merge window passes away. Hopefully tomorrow.

-- Daniel

