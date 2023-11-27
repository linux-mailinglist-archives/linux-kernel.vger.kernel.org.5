Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 662A97FA83A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:41:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbjK0RlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:41:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjK0RlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:41:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B015219B
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:41:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50D0C433C9;
        Mon, 27 Nov 2023 17:41:10 +0000 (UTC)
Date:   Mon, 27 Nov 2023 12:41:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Message-ID: <20231127124130.1041ffd4@gandalf.local.home>
In-Reply-To: <20231127151248.7232-2-petr.pavlu@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
        <20231127151248.7232-2-petr.pavlu@suse.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Nov 2023 16:12:47 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> The following warning appears when using buffered events:
> [  203.556451] WARNING: CPU: 53 PID: 10220 at kernel/trace/ring_buffer.c:3912 ring_buffer_discard_commit+0x2eb/0x420

Hmm, I don't have a waring on line 3912, do you have extra code (debugging)
in your version?

> [...]
> [  203.670690] CPU: 53 PID: 10220 Comm: stress-ng-sysin Tainted: G            E      6.7.0-rc2-default #4 56e6d0fcf5581e6e51eaaecbdaec2a2338c80f3a
> [  203.670704] Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
> [  203.670709] RIP: 0010:ring_buffer_discard_commit+0x2eb/0x420
> [  203.735721] Code: 4c 8b 4a 50 48 8b 42 48 49 39 c1 0f 84 b3 00 00 00 49 83 e8 01 75 b1 48 8b 42 10 f0 ff 40 08 0f 0b e9 fc fe ff ff f0 ff 47 08 <0f> 0b e9 77 fd ff ff 48 8b 42 10 f0 ff 40 08 0f 0b e9 f5 fe ff ff
> [  203.735734] RSP: 0018:ffffb4ae4f7b7d80 EFLAGS: 00010202
> [  203.735745] RAX: 0000000000000000 RBX: ffffb4ae4f7b7de0 RCX: ffff8ac10662c000
> [  203.735754] RDX: ffff8ac0c750be00 RSI: ffff8ac10662c000 RDI: ffff8ac0c004d400
> [  203.781832] RBP: ffff8ac0c039cea0 R08: 0000000000000000 R09: 0000000000000000
> [  203.781839] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
> [  203.781842] R13: ffff8ac10662c000 R14: ffff8ac0c004d400 R15: ffff8ac10662c008
> [  203.781846] FS:  00007f4cd8a67740(0000) GS:ffff8ad798880000(0000) knlGS:0000000000000000
> [  203.781851] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  203.781855] CR2: 0000559766a74028 CR3: 00000001804c4000 CR4: 00000000001506f0
> [  203.781862] Call Trace:
> [  203.781870]  <TASK>
> [  203.851949]  trace_event_buffer_commit+0x1ea/0x250
> [  203.851967]  trace_event_raw_event_sys_enter+0x83/0xe0
> [  203.851983]  syscall_trace_enter.isra.0+0x182/0x1a0
> [  203.851990]  do_syscall_64+0x3a/0xe0
> [  203.852075]  entry_SYSCALL_64_after_hwframe+0x6e/0x76
> [  203.852090] RIP: 0033:0x7f4cd870fa77
> [  203.982920] Code: 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 66 90 b8 89 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e9 43 0e 00 f7 d8 64 89 01 48
> [  203.982932] RSP: 002b:00007fff99717dd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000089
> [  203.982942] RAX: ffffffffffffffda RBX: 0000558ea1d7b6f0 RCX: 00007f4cd870fa77
> [  203.982948] RDX: 0000000000000000 RSI: 00007fff99717de0 RDI: 0000558ea1d7b6f0
> [  203.982957] RBP: 00007fff99717de0 R08: 00007fff997180e0 R09: 00007fff997180e0
> [  203.982962] R10: 00007fff997180e0 R11: 0000000000000246 R12: 00007fff99717f40
> [  204.049239] R13: 00007fff99718590 R14: 0000558e9f2127a8 R15: 00007fff997180b0
> [  204.049256]  </TASK>
> 
> For instance, it can be triggered by running these two commands in
> parallel:
> $ while true; do
>     echo hist:key=id.syscall:val=hitcount > \
>       /sys/kernel/debug/tracing/events/raw_syscalls/sys_enter/trigger;
>   done
> $ stress-ng --sysinfo $(nproc)
> 
> The warning indicates that the current ring_buffer_per_cpu is not in the
> committing state. It happens because the active ring_buffer_event
> doesn't actually come from the ring_buffer_per_cpu but is allocated from
> trace_buffered_event.
> 
> The bug is in function trace_buffered_event_disable() where the
> following normally happens:
> * The code invokes disable_trace_buffered_event() via
>   smp_call_function_many() and follows it by synchronize_rcu(). This
>   increments the per-CPU variable trace_buffered_event_cnt on each
>   target CPU and grants trace_buffered_event_disable() the exclusive
>   access to the per-CPU variable trace_buffered_event.
> * Maintenance is performed on trace_buffered_event, all per-CPU event
>   buffers get freed.
> * The code invokes enable_trace_buffered_event() via
>   smp_call_function_many(). This decrements trace_buffered_event_cnt and
>   releases the access to trace_buffered_event.
> 
> A problem is that smp_call_function_many() runs a given function on all
> target CPUs except on the current one. The following can then occur:
> * Task X executing trace_buffered_event_disable() runs on CPU A.
> * The control reaches synchronize_rcu() and the task gets rescheduled on
>   another CPU B.
> * The RCU synchronization finishes. At this point,
>   trace_buffered_event_disable() has the exclusive access to all
>   trace_buffered_event variables except trace_buffered_event[A] because
>   trace_buffered_event_cnt[A] is never incremented and if the buffer is
>   currently unused, remains set to 0.
> * A different task Y is scheduled on CPU A and hits a trace event. The
>   code in trace_event_buffer_lock_reserve() sees that
>   trace_buffered_event_cnt[A] is set to 0 and decides the use the buffer
>   provided by trace_buffered_event[A].
> * Task X continues its execution in trace_buffered_event_disable(). The
>   code incorrectly frees the event buffer pointed by
>   trace_buffered_event[A] and resets the variable to NULL.
> * Task Y writes event data to the now freed buffer and later detects the
>   created inconsistency.
> 
> The issue is observable since commit dea499781a11 ("tracing: Fix warning
> in trace_buffered_event_disable()") which moved the call of
> trace_buffered_event_disable() in __ftrace_event_enable_disable()
> earlier, prior to invoking call->class->reg(.. TRACE_REG_UNREGISTER ..).
> The underlying problem in trace_buffered_event_disable() is however
> present since the original implementation in commit 0fc1b09ff1ff
> ("tracing: Use temp buffer when filtering events").
> 
> The bug is simply fixable by replacing smp_call_function_many() by
> on_each_cpu_mask(), but the code has other issues as well:

Or by simply calling the update for the local CPU as well as the many:

	preempt_disable();
	/* For each CPU, set the buffer as used. */
	disable_trace_buffered_event(NULL);
	smp_call_function_many(tracing_buffer_mask,
			       disable_trace_buffered_event, NULL, 1);
	preempt_enable();

> * Function trace_event_buffer_lock_reserve() reads trace_buffered_event
>   and trace_buffered_event_cnt in reverse order than they are written in
>   trace_buffered_event_disable() and without any memory barrier. It
>   could happen that trace_event_buffer_lock_reserve() still finds
>   a valid pointer in trace_buffered_event which is being freed by
>   trace_buffered_event_disable() but later already sees the decremented
>   value of trace_buffered_event_cnt back to 0 and incorrectly decides to
>   use the provided buffer.

Not an issue (see below)

> * Function trace_buffered_event_enable() initializes memory of each
>   allocated trace_buffered_event to zero but no memory barrier is
>   present to ensure this operation is completed before publishing its
>   pointer for use in trace_event_buffer_lock_reserve().

Yes, a wmb() may be helpful, but as the reader will see either the
allocated page or NULL, and can handle both cases. I decided not to add it
because it really doesn't matter if we do.

> * Calling function trace_buffered_event_enable() normally requires
>   pairing it with trace_buffered_event_disable(). However, the function
>   has no error return code and in case of a failure decrements back
>   trace_buffered_event_ref. This results in underflow of the counter
>   when trace_buffered_event_disable() gets called later.

Not an issue.

Even on failure the ref count will be greater than zero, where 
trace_buffered_event_disable() handles it properly, and the freeing can
handle no pages being allocated.

That is:

	free_page((unsigned long)per_cpu(trace_buffered_event, cpu));

would be the same as: free_page((unsigned long)NULL);

Which is perfectly fine to do.

> 
> Instead of using the per-CPU variable trace_buffered_event_cnt for the
> exclusive access during the disable operation, introduce a new variable
> trace_buffered_event_enabled to reflect the current state and
> appropriately adjust the code. The variable indicates whether buffered
> events are currently enabled and trace_buffered_event together with
> trace_buffered_event_cnt are ok to use.

The current logic is perfectly fine. The only bug here (which you found)
was the missing update to the counter of the current CPU.

> 
> The updated synchronization mechanism fixes the mentioned problems and
> avoids also sending IPIs across the system.
> 
> Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
> Fixes: dea499781a11 ("tracing: Fix warning in trace_buffered_event_disable()")
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
> ---

Let me explain why it works.

In trace_event_buffer_lock_reserve():

		preempt_disable_notrace();
		if ((entry = __this_cpu_read(trace_buffered_event))) {
			int max_len = PAGE_SIZE - struct_size(entry, array, 1);

			val = this_cpu_inc_return(trace_buffered_event_cnt);

			if (val == 1 && likely(len <= max_len)) {

If val == 1 and len <= max_len, then this is going to use the "buffered event".

Notice that preemption is disabled.

				trace_event_setup(entry, type, trace_ctx);
				entry->array[0] = len;
				/* Return with preemption disabled */
				return entry;

And we return with preemption disabled!

Everything after this does not use the "buffered event" and is not part of
this code.

			}
			this_cpu_dec(trace_buffered_event_cnt);
		}
		/* __trace_buffer_lock_reserve() disables preemption */
		preempt_enable_notrace();


Now, on commit (when we are done with the "buffered event"):

__buffer_unlock_commit(struct trace_buffer *buffer, struct ring_buffer_event *event)
{
	__this_cpu_write(trace_taskinfo_save, true);

	/* If this is the temp buffer, we need to commit fully */
	if (this_cpu_read(trace_buffered_event) == event) {
		/* Length is in event->array[0] */
		ring_buffer_write(buffer, event->array[0], &event->array[1]);
		/* Release the temp buffer */
		this_cpu_dec(trace_buffered_event_cnt);
		/* ring_buffer_unlock_commit() enables preemption */
		preempt_enable_notrace();

Preemption is finally enabled here. That is, this could not preempt from
the time we found the "buffered event" to the time we released it.

	} else
		ring_buffer_unlock_commit(buffer);
}


Now lets look at the trace_buffered_event_disable():

void trace_buffered_event_disable(void)
{
	int cpu;

	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));

	if (WARN_ON_ONCE(!trace_buffered_event_ref))
		return;

	if (--trace_buffered_event_ref)
		return;

	preempt_disable();
	/* For each CPU, set the buffer as used. */
	smp_call_function_many(tracing_buffer_mask,
			       disable_trace_buffered_event, NULL, 1);
	preempt_enable();

The above will up the counter of all the buffers (after the bug you found
is fixed ;-)

That means, we just need to wait till all the currently running users of
the buffer are done with it.

	/* Wait for all current users to finish */
	synchronize_rcu();

The synchronize_rcu() also synchronizes preempt disabled sections. That is,
after the synchronize_rcu() completes, all users of the "buffered event"
are done with it, and because we upped the count, there will be no more
users.

That is *there is no race here*!

At this point, there are no users of the "buffered event" and we can do
whatever we want without locks or memory barriers. This is RCU 101.

	for_each_tracing_cpu(cpu) {
		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
		per_cpu(trace_buffered_event, cpu) = NULL;
	}
	/*
	 * Make sure trace_buffered_event is NULL before clearing
	 * trace_buffered_event_cnt.
	 */
	smp_wmb();

	preempt_disable();
	/* Do the work on each cpu */
	smp_call_function_many(tracing_buffer_mask,
			       enable_trace_buffered_event, NULL, 1);
	preempt_enable();
}



Now, the reason you found the crash was from the first issue you mentioned.
That is, we didn't disable the current CPU and if we migrated, things would
get really messed up. The only fix here is to make sure all CPUs have their
trace_buffered_event_cnt get incremented.

Thanks,

-- Steve
