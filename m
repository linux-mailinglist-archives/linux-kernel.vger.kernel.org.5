Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09377FC267
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:16:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346034AbjK1P10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:27:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345968AbjK1P1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:27:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0CD64
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:27:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABED0C433D9;
        Tue, 28 Nov 2023 15:27:27 +0000 (UTC)
Date:   Tue, 28 Nov 2023 10:27:48 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Pavlu <petr.pavlu@suse.com>
Cc:     mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
        zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] tracing: Simplify and fix "buffered event"
 synchronization
Message-ID: <20231128102748.23328618@gandalf.local.home>
In-Reply-To: <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
References: <20231127151248.7232-1-petr.pavlu@suse.com>
        <20231127151248.7232-2-petr.pavlu@suse.com>
        <20231127124130.1041ffd4@gandalf.local.home>
        <77037ca1-8116-4bc6-b286-67059db0848e@suse.com>
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

On Tue, 28 Nov 2023 16:05:00 +0100
Petr Pavlu <petr.pavlu@suse.com> wrote:

> On 11/27/23 18:41, Steven Rostedt wrote:
> > On Mon, 27 Nov 2023 16:12:47 +0100
> > Petr Pavlu <petr.pavlu@suse.com> wrote:
> >   
> >> The following warning appears when using buffered events:
> >> [  203.556451] WARNING: CPU: 53 PID: 10220 at kernel/trace/ring_buffer.c:3912 ring_buffer_discard_commit+0x2eb/0x420  
> > 
> > Hmm, I don't have a waring on line 3912, do you have extra code (debugging)
> > in your version?  
> 
> The series is based on 2cc14f52aeb7 (tag: v6.7-rc3). It is the following
> code and RB_WARN_ON():

Interesting.

>   3895  void ring_buffer_discard_commit(struct trace_buffer *buffer,
>   3896                                  struct ring_buffer_event *event)
>   3897  {
> [...]
>   3908           * This must only be called if the event has not been
>   3909           * committed yet. Thus we can assume that preemption
>   3910           * is still disabled.
>   3911           */
>   3912          RB_WARN_ON(buffer, !local_read(&cpu_buffer->committing));
>   3913  
>   3914          rb_decrement_entry(cpu_buffer, event);
>   3915          if (rb_try_to_discard(cpu_buffer, event))
>   3916                  goto out;
> 
> https://github.com/torvalds/linux/blob/2cc14f52aeb78ce3f29677c2de1f06c0e91471ab/kernel/trace/ring_buffer.c#L3912
> 
> >> [...]
> >> [  203.670690] CPU: 53 PID: 10220 Comm: stress-ng-sysin Tainted: G            E      6.7.0-rc2-default #4 56e6d0fcf5581e6e51eaaecbdaec2a2338c80f3a

I was looking at the above 6.7.0-rc2-default, which made me somewhat confused.


> >> [  203.670704] Hardware name: Intel Corp. GROVEPORT/GROVEPORT, BIOS GVPRCRB1.86B.0016.D04.1705030402 05/03/2017
> >> [  203.670709] RIP: 0010:ring_buffer_discard_commit+0x2eb/0x420
> >> [  203.735721] Code: 4c 8b 4a 50 48 8b 42 48 49 39 c1 0f 84 b3 00 00 00 49 83 e8 01 75 b1 48 8b 42 10 f0 ff 40 08 0f 0b e9 fc fe ff ff f0 ff 47 08 <0f> 0b e9 77 

> >> * Function trace_buffered_event_enable() initializes memory of each
> >>   allocated trace_buffered_event to zero but no memory barrier is
> >>   present to ensure this operation is completed before publishing its
> >>   pointer for use in trace_event_buffer_lock_reserve().  
> > 
> > Yes, a wmb() may be helpful, but as the reader will see either the
> > allocated page or NULL, and can handle both cases. I decided not to add it
> > because it really doesn't matter if we do.  
> 
> My concern is about the earlier call "memset(event, 0, sizeof(*event));"
> in trace_buffered_event_enable() which writes the obtained event page
> prior to publishing it via "per_cpu(trace_buffered_event, cpu) = event;".
> I think another CPU running trace_event_buffer_lock_reserve() could see
> already the valid event pointer, write to the event page and only then
> the memory could see the memset() write coming from
> trace_buffered_event_enable(). The event data would then become
> corrupted.

OK, I'll buy that. Feel free to send an patch that adds that wmb with a
comment explaining the above.

> 
> >   
> >> * Calling function trace_buffered_event_enable() normally requires
> >>   pairing it with trace_buffered_event_disable(). However, the function
> >>   has no error return code and in case of a failure decrements back
> >>   trace_buffered_event_ref. This results in underflow of the counter
> >>   when trace_buffered_event_disable() gets called later.  
> > 
> > Not an issue.
> > 
> > Even on failure the ref count will be greater than zero, where 
> > trace_buffered_event_disable() handles it properly, and the freeing can
> > handle no pages being allocated.
> > 
> > That is:
> > 
> > 	free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
> > 
> > would be the same as: free_page((unsigned long)NULL);
> > 
> > Which is perfectly fine to do.  
> 
> The situation that I have on my mind is the following:
> * The counter trace_buffered_event_ref is at 0.
> * The soft mode gets enabled for some event and
>   trace_buffered_event_enable() is called. The function increments
>   trace_buffered_event_ref to 1 and starts allocating event pages.
> * The allocation fails for some page and trace_buffered_event_disable()
>   is called for cleanup.
> * Function trace_buffered_event_disable() decrements
>   trace_buffered_event_ref back to 0, recognizes that it was the last
>   use of buffered events and frees all allocated pages.
> * The control goes back to trace_buffered_event_enable() which returns.
>   The caller of trace_buffered_event_enable() has no information that
>   the function actually failed.
> * Some time later, the soft mode is disabled for the same event.
>   Function trace_buffered_event_disable() is called. It warns on
>   "WARN_ON_ONCE(!trace_buffered_event_ref)" and returns.
> 
> The end result is only an ugly warning but I think it is still good to
> fix.

Ah, I missed the call to trace_buffered_event_disable() in the failure
path. Actually, since the trace_buffered_event is only an optimization, I
think the best thing to do is to just return without the clean up,
expecting that the other caller will do the clean up. We could even not
even stop the loop!

That is, just have:

void trace_buffered_event_enable(void)
{
	struct ring_buffer_event *event;
	struct page *page;
	int cpu;

	WARN_ON_ONCE(!mutex_is_locked(&event_mutex));

	if (trace_buffered_event_ref++)
		return;

	for_each_tracing_cpu(cpu) {
		page = alloc_pages_node(cpu_to_node(cpu),
					GFP_KERNEL | __GFP_NORETRY, 0);

		/* This is just an optimization and can handle failures */
		if (!page) {
			pr_err("Failed to create event buffer\n");
			break;
		}

		event = page_address(page);
		memset(event, 0, sizeof(*event));

		per_cpu(trace_buffered_event, cpu) = event;

		preempt_disable();
		if (cpu == smp_processor_id() &&
		    __this_cpu_read(trace_buffered_event) !=
		    per_cpu(trace_buffered_event, cpu))
			WARN_ON_ONCE(1);
		preempt_enable();
	}
}

> > 
> > Now, the reason you found the crash was from the first issue you mentioned.
> > That is, we didn't disable the current CPU and if we migrated, things would
> > get really messed up. The only fix here is to make sure all CPUs have their
> > trace_buffered_event_cnt get incremented.  
> 
> The potential race that I see is the following:
> * Function trace_buffered_event_disable() is called on CPU 0. It
>   increments trace_buffered_event_cnt on each CPU and waits via
>   synchronize_rcu() for each user of trace_buffered_event to complete.

> * After synchronize_rcu() is already finished, the situation is that all
>   counters trace_buffered_event_cnt are at 1 and all pointers
>   trace_buffered_event are still valid.

> * At this point, on a different CPU 1, the execution reaches
>   trace_event_buffer_lock_reserve(). The function calls
>   preempt_disable_notrace() and enters an RCU read-side critical section
>   but that is not important because all RCU stuff is already performed
>   and completed in trace_buffered_event_disable(). The function proceeds
>   and reads a still valid pointer from trace_buffered_event[CPU1] into
>   the local variable "entry". However, it doesn't yet read
>   trace_buffered_event_cnt[CPU1] which happens later.

> * Function trace_buffered_event_disable() continues. It frees
>   trace_buffered_event[CPU1] and decrements
>   trace_buffered_event_cnt[CPU1] back to 0.

> * Function trace_event_buffer_lock_reserve() continues. It reads and
>   increments trace_buffered_event_cnt[CPU1] from 0 to 1. This makes it
>   believe that it can use the "entry" that it already obtained but the
>   pointer is now invalid and any access results in a use-after-free.

OK, so you are saying we need another synchronize_rcu() after we set the
trace_buffered_event to NULL?


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

	/* Wait for all current users to finish */
	synchronize_rcu();

	for_each_tracing_cpu(cpu) {
		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
		per_cpu(trace_buffered_event, cpu) = NULL;
	}
	/*
	 * Make sure trace_buffered_event is NULL before clearing
	 * trace_buffered_event_cnt.
	 */
-	smp_wmb();
+	synchronize_rcu();

	preempt_disable();
	/* Do the work on each cpu */
	smp_call_function_many(tracing_buffer_mask,
			       enable_trace_buffered_event, NULL, 1);
	preempt_enable();
}

I agree with that.

-- Steve
