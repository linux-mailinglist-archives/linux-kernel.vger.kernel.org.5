Return-Path: <linux-kernel+bounces-108980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89F18812EA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F288286266
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 14:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A56942073;
	Wed, 20 Mar 2024 14:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e1ksCSui"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD3C41C7A
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 14:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710943585; cv=none; b=Vcr7d7OgzTOV+yKEndkwzsBuP2ibCdRRorPuMsTQglD0YyXhkzYvpSgIb6zy+r9RmxkLOahLUcftucRKqnt0qb2BCBIKHsjko2ljhjVsyF2vy087FkRnLqM7otnGwLWM6o2ziHqn0osf1smVBhP47OHLqyJlMaFA0xmtd0+UIsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710943585; c=relaxed/simple;
	bh=b2UjMyzyHG+B0opTU4FbI5RLTxAWDJoL12HgRhHCcv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QWo67In+ZTgfZ5FmOnCJMdrYomN4oWTAtV6QbXmX0Qsox7pOVBv3Hhsn3qhxYWOiukUSth13mpA0vrE08j2mB+YMOmXtmm0bQzxu8iZSHDA3+ex9Gy4eSWFD7b/13XZcNRJEkwX+yq/7il88PD83tnX1I0fhe8VRYFAjxTuvvGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e1ksCSui; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710943582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WocJ9H5OztFtMbOa930v/B0kbNi2k0MpCuzyQiWZsc=;
	b=e1ksCSui6D/W5dlIEnnQZ+zRQh+i6gGZJgAWgK+7FmIjsgVvGeI/myIp1A5ZVY3rMjd4ji
	6sQjAVcof0YWOy2wtiNwkzpk/kkgEuFStotCOajhXVCxoNvvUQkQUjdesZ82P40WBN+Aq+
	1DIcA8vIdQFpYsTi3wyEm22tyI+pq5I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-eih9cY7BPNWODcVWdoa8ag-1; Wed, 20 Mar 2024 10:06:18 -0400
X-MC-Unique: eih9cY7BPNWODcVWdoa8ag-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAC4E891E68;
	Wed, 20 Mar 2024 14:06:17 +0000 (UTC)
Received: from metal.redhat.com (unknown [10.45.225.13])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F0AC01C060D3;
	Wed, 20 Mar 2024 14:06:14 +0000 (UTC)
From: Daniel Vacek <neelx@redhat.com>
To: Valentin Schneider <vschneid@redhat.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Daniel Vacek <neelx@redhat.com>,
	stable@vger.kernel.org,
	Bill Peters <wpeters@atpco.net>,
	Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: fix affine_move_task failure case
Date: Wed, 20 Mar 2024 15:03:05 +0100
Message-ID: <20240320140344.3178785-1-neelx@redhat.com>
In-Reply-To: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
References: <xhsmhfrwncuky.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Hi Valentin,

On Mon, Mar 18, 2024 at 6:34 PM Valentin Schneider <vschneid@redhat.com> wrote:
> On 18/03/24 12:17, Daniel Vacek wrote:
> > Bill Peters reported CPU hangs while offlining/onlining CPUs on s390.
> >
> > Analyzing the vmcore data shows `stop_one_cpu_nowait()` in `affine_move_task()`
> > can fail when racing with off-/on-lining resulting in a deadlock waiting for
> > the pending migration stop work completion which is never done.
> >
> > Fix this by correctly handling such a condition.
> >
>
> IIUC the problem is that the dest_cpu and its stopper thread can be taken
> down by take_cpu_down(), and affine_move_task() currently isn't aware of
> that. I thought we had tested this vs hotplug, but oh well...

I'm sorry, I should have provided more context in the first place. The machine
is an LPAR with 2 CPUs and CPU 0 was onlining (hotplugging?) CPU 1. The traces
show this scenario:

            CPU 0                       |           CPU 1
                                        |
        cpuplugd task 1429              |
 holds the `cpu_hotplug_lock`           |
    for writing in _cpu_up+0x16a        |
blocked on `cpuhp_state:1.done_up`      |
     completion in __cpuhp_kick_ap+0x76 |
                                        |
                                        |       cpuhp/1 task 17
                                        |supposed to complete bringup of the CPU
                                        |     (`cpuhp_state:1.done_up`) in cpuhp_thread_fun+0x108
                                        |blocked on `wq_pool_attach_mutex`
                                        |    in workqueue_online_cpu+0x9e
                                        |
        xfs-conv/dm-0 task 745          |
 holds the `wq_pool_attach_mutex`       |
    in worker_attach_to_pool+0x66        \
blocked on `task->migration_pending->done`|
     completion in affine_move_task+0x10a/

~~~
crash> b 1429
PID: 1429     TASK: 99398000          CPU: 0    COMMAND: "cpuplugd"
 #0 [997df970] __schedule+0x34c at 3089c424
 #1 [997df9e0] schedule+0x7e at 3089cafe
 #2 [997dfa20] schedule_timeout+0x26e at 308a1d8e
     [inlined] do_wait_for_common
     [inlined] __wait_for_common
 #3 [997dfad8] wait_for_common+0x14a at 3089d902
    [ret call] wait_for_completion+0x1a at 3089d96a

     [inlined] wait_for_ap_thread                      <<< blocked on `cpuhp_state:1.done_up` completion
    [ret call] __cpuhp_kick_ap+0x76 at 300c610e
 #4 [997dfb58] cpuhp_kick_ap+0xc4 at 300c61dc
     [inlined] bringup_wait_for_ap
    [ret call] bringup_cpu+0xea at 300c6402
 #5 [997dfba8] cpuhp_invoke_callback+0xcc at 300c4f14
 #6 [997dfc40] _cpu_up+0x16a at 300c798a               <<< holds the `cpu_hotplug_lock` for writing
 #7 [997dfc98] do_cpu_up+0xc6 at 300c7b66
 #8 [997dfcd8] cpu_subsys_online+0x58 at 305a0a00
 #9 [997dfd28] device_online+0x9e at 30598e7e
#10 [997dfd68] online_store+0x88 at 30598f28
#11 [997dfda8] kernfs_fop_write+0xdc at 3040276c
#12 [997dfdf8] vfs_write+0xa8 at 30354760
#13 [997dfe58] ksys_write+0x62 at 30354a32

crash> cpuhp_cpu_state.state cpuhp_state:a | paste - -
[0]: 1aef424e0      state = CPUHP_ONLINE,               # (195)
[1]: 1aef654e0      state = CPUHP_AP_WORKQUEUE_ONLINE,  # (159)

crash> cpuhp_cpu_state.bringup,thread,done_up.done cpuhp_state:1 -d | paste - - - -
[1]: 1aef654e0      bringup = true,      thread = 0x81134400,      done_up.done = 0,  <<<

crash> b 17
PID: 17       TASK: 81134400          CPU: 1    COMMAND: "cpuhp/1"
 #0 [81143b68] __schedule+0x34c at 3089c424
 #1 [81143bd8] schedule+0x7e at 3089cafe
 #2 [81143c18] schedule_preempt_disabled+0x2a at 3089cfba
 #3 [81143c30] __mutex_lock+0x320 at 3089df60

 #4 [81143cb0] workqueue_online_cpu+0x9e at 300e847e   <<< blocked on `wq_pool_attach_mutex`
 #5 [81143d20] cpuhp_invoke_callback+0xcc at 300c4f14
 #6 [81143db8] cpuhp_thread_fun+0x108 at 300c6848      <<< supposed to complete the bring-up of the CPU (`cpuhp_state:1.done_up`)

crash> b 745
PID: 745      TASK: 82359100          CPU: 0    COMMAND: "xfs-conv/dm-0"
 #0 [8b4bfa20] __schedule+0x34c at 3089c424
 #1 [8b4bfa90] schedule+0x7e at 3089cafe
 #2 [8b4bfad0] schedule_timeout+0x26e at 308a1d8e
     [inlined] do_wait_for_common
     [inlined] __wait_for_common
 #3 [8b4bfb88] wait_for_common+0x14a at 3089d902
    [ret call] wait_for_completion+0x1a at 3089d96a

 #4 [8b4bfc08] affine_move_task+0x10a at 300fb51a        <<< blocked on `task->migration_pending->done` completion
 #5 [8b4bfd08] __set_cpus_allowed_ptr+0x12e at 300fb926
    [ret call] set_cpus_allowed_ptr+0xa at 300fba32
 #6 [8b4bfd78] worker_attach_to_pool+0x66 at 300e1dae    <<< holds the `wq_pool_attach_mutex`
 #7 [8b4bfdc8] rescuer_thread+0x12c at 300e5bac

crash> rx 8b4bfea0
        8b4bfea0:  [863373c0:kmalloc-192] 

crash> worker.task,rescue_wq 863373c0
  task = 0x82359100,
  rescue_wq = 0x8aa44400,

crash> list -s pool_workqueue.pool pool_workqueue.mayday_node -hO workqueue_struct.maydays 0x8aa44400 | paste - -
1fffff7f751900    pool = 0x1aef56a00,

crash> worker_pool.attrs 0x1aef56a00
  attrs = 0x80088180,

crash> workqueue_attrs.cpumask[0].bits 0x80088180
  cpumask[0].bits = {0x1, 0x0, ...

crash> cpumask.bits __cpu_active_mask
  bits = {0x1, 0x0, ...

crash> cpumask.bits __cpu_online_mask
  bits = {0x3, 0x0, ...

crash> task_struct.migration_pending,flags 0x82359100
    migration_pending = 0x8b4bfce8,
  flags = 0x4208060,
             ^ PF_KTHREAD

crash> pd distribute_cpu_mask_prev:0
per_cpu(distribute_cpu_mask_prev, 0) = 0

crash> set_affinity_pending.refs.refs.counter,arg,stop_pending,done.done 0x8b4bfce8 -d
  refs.refs.counter = 1
  arg = {
    task = 0x82359100,
    dest_cpu = 0,
    pending = 0x8b4bfce8
  }
  stop_pending = 1,
  done.done = 0,
~~~

In other words the `set_cpus_allowed_ptr()` is called from a worker thread which
tries to migrate. The worker pool is only allowed on CPU 0 and that was supposed
to be the destination as per the stack structure. In this case I thought it's OK
to leave the task on the old CPU and the Bill's testing scenario was successful
with the proposed patch. IIUC, it's exercising the hotplug due to load-balancing.

This was on RHEL 8.8.z kernel. I see upstream changed a bit so I'm not sure it's
still reproducible. Also, I'm not sure why this only happens on s390 and not on
x86. I imagine the CPU hotplug slightly differs? Anyways this seems to be timing
sensitive and the timing will differ greatly for sure.

> > Fixes: 9e81889c7648 ("sched: Fix affine_move_task() self-concurrency")
> > Cc: stable@vger.kernel.org
> > Reported-by: Bill Peters <wpeters@atpco.net>
> > Tested-by: Bill Peters <wpeters@atpco.net>
> > Signed-off-by: Daniel Vacek <neelx@redhat.com>
> > ---
> >  kernel/sched/core.c | 13 +++++++++++--
> >  1 file changed, 11 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 9116bcc903467..d0ff5c611a1c8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3069,8 +3069,17 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
> >               preempt_disable();
> >               task_rq_unlock(rq, p, rf);
> >               if (!stop_pending) {
> > -			stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> > -					    &pending->arg, &pending->stop_work);
> > +			stop_pending =
> > +				stop_one_cpu_nowait(cpu_of(rq), migration_cpu_stop,
> > +						    &pending->arg, &pending->stop_work);
> > +
> > +			if (!stop_pending) {
> > +				rq = task_rq_lock(p, rf);
> > +				pending->stop_pending = false;
> > +				p->migration_pending = NULL;
> > +				task_rq_unlock(rq, p, rf);
> > +				complete_all(&pending->done);
> > +			}
>
> This can leave the task @p on a now-illegal CPU; consider a task affined to
> CPUs 0-1, migrate_disable(); then affined to CPUs 2-3, then in
> migrate_enable() the dest_cpu is chosen as 3 but that's racing with it
> being brought down. The stop_one_cpu_nowait() fails, and we leave the task
> on CPUs 0-1.
>
> Issuing a redo of affine_move_task() with a different dest_cpu doesn't
> sound great, and while very unlikely that doesn't have forward progress
> guarantees.
>
> Unfortunately we can't hold the hotplug lock during the affinity change of
> migrate_enable(), as migrate_enable() isn't allowed to block.
>
> Now, the CPU selection in __set_cpus_allowed_ptr_locked() that is passed
> down to affine_move_task() relies on the active mask, which itself is
> cleared in sched_cpu_deactivate() and is followed by a
> synchronize_rcu().
>
> What if we made the affinity change of migrate_enable() an RCU read-side
> section? Then if a CPU X is observed as active in
>   migrate_enable()->__set_cpus_allowed_ptr_locked()
> , then its' hotplug state cannot go lower than CPUHP_AP_ACTIVE until the task is
> migrated away.
>
> Something like the below. Thoughts?
> ---
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 929fce69f555e..c6d128711d1a9 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2450,8 +2450,11 @@ void migrate_enable(void)
>  	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
>  	 */
>  	guard(preempt)();
> -	if (p->cpus_ptr != &p->cpus_mask)
> +	if (p->cpus_ptr != &p->cpus_mask) {
> +		guard(rcu)();
>  		__set_cpus_allowed_ptr(p, &ac);
> +	}
> +
>  	/*
>  	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
>  	 * regular cpus_mask, otherwise things that race (eg.

With the above being said, I don't see any relation to `migrate_enable()` and
this change looks irrelevant in the context.

Any fresh ideas?

--nX


