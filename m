Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1CC7E02E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 13:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376317AbjKCMbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 08:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346763AbjKCMbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 08:31:23 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 446961BC
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 05:31:17 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id D9F23219CD;
        Fri,  3 Nov 2023 12:31:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1699014675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O+YgCJq25QQVRQEVc/Dh1/YtbZe8Mgg4zoVci01F4Aw=;
        b=F2Vl3rGLh5JtaarP8oUd0VPXRBqcpJblNSZTgqF7VVGhobscRm2cWjNsKmMEWfKp0bj9jD
        Ta/aFLVpASLAZ81Wg5uICQpp7jgtc5+hJjePFHwoJqnlV7nfe8qkSfd14fUaPzdzKL00Ji
        9mRApPpba4NJaTO4H2u/bOaEkPyR2gQ=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4D9C32C24A;
        Fri,  3 Nov 2023 12:31:15 +0000 (UTC)
Date:   Fri, 3 Nov 2023 13:31:15 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>,
        Chunlei Wang <chunlei.wang@mediatek.com>
Subject: Re: [RFC PATCH printk v1] printk: ringbuffer: Do not skip
 non-finalized with prb_next_seq()
Message-ID: <ZUToEzarc_F-bEXT@alley>
References: <ZTkxOJbDLPy12n41@alley>
 <87zfzwp8pk.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfzwp8pk.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-11-02 14:54:23, John Ogness wrote:
> On 2023-10-25, Petr Mladek <pmladek@suse.com> wrote:
> > there seems to be missing word in the subject:
> >
> >     s/non-finalized/non-finalized records/
> 
> Ack.
> 
> > On Thu 2023-10-19 15:31:45, John Ogness wrote:
> >> Commit f244b4dc53e5 ("printk: ringbuffer: Improve prb_next_seq()
> >> performance") introduced an optimization for prb_next_seq() by
> >> using best-effort to track recently finalized records. However,
> >> the order of finalization does not necessarily match the order
> >> of the records. This can lead to prb_next_seq() returning
> >> higher than desired sequence numbers, which results in the
> >> reader skipping over records that are not yet finalized. From
> >> the reader's perspective it results in messages never being
> >> seen.
> >
> > IMHO, "messages never being seen" is too strong.
> 
> Agreed. A reader does not use prb_next_seq() to decide what to print
> next. Worst case it thinks records are available that are not (available
> for that reader).
> 
> > I have found only one (or two) scenarios where the messages might
> > really get lost.
> >
> > 1. It might happen when real console is replacing a boot console.
> >    The real console is initialized with the value returned
> >    by prb_next_seq(). And the boot console might not be able
> >    to flush earlier non-finalized records.
> 
> This cannot happen because in this situation console_init_seq() sets
> @seq to the lowest boot console counter.

You are right.

> > 2. The other scenario is based on the fact that console_unlock()
> >    or pr_flush() might see lower prb_next_seq() than the last
> >    reserved record. It means that they might not flush all
> >    pending records.
> >
> >    But wait! This is actually the opposite case. pr_flush()
> >    and console_unlock() might miss the messages when
> >    they see too low prb_next_seq().
> >
> >    Important: This problem existed since introducing
> > 	      the lockless ring buffer!
> >
> >    The question is. Should pr_flush() and console_unlock()
> >    wait until all registered messages get finalized?
> >
> >    It would need to ignore only the last record when it
> >    is not finalized because it might be a continuous line.
> 
> Yes, this is the question to answer.
> 
> With the lockless ringbuffer we allow multiple CPUs/contexts to write
> simultaneously into the buffer. This creates an ambiguity as some
> writers will finalize sooner.
> 
> IMHO we need 2 different functions:

I thought about this as well.

> 1. A function that reports the last contiguous finalized record for a
> reader. This is useful for syslog and kmsg_dump to know what is
> available for them to read. We can use @last_finalized_seq for this,
> optimizing it correctly this time.

I would use this also for console_unlock() as well, see below.

> 2. A function that reports the last reserved sequence number of a
> writer. This is useful for pr_flush and console_unlock to know when they
> are finished.

This looks like the right solution for pr_flush() when it is called
with a timeout.

I am a bit afraid that console_unlock() or pr_flush() without a timeout
might get blocked when some CPU is not able to finalize a message.
It is realistic, especially during panic() when other CPUs might
get stopped by NMI.

Anyway, it would require waiting for the pending writers.
And only pr_flush() uses the sleep between checks.

So, I would personally use the @last_finalized_seq for
console_unlock() and pr_flush() without a timeout. We could
always call defer_console_output() when it is lower then
the last reserved seq.

Well, we actually do not even need to do this because
the reserved records must be added by some printk().
And this printk() will either flush the pending messages
or it will call defer_console_output().

The above paragraph describes a scenario which is not obvious.
We should probably document it somewhere, probably in the description
of prb_last_finalized_seq() or how it will be called.

> This function can begin with @last_finalized_seq, looking
> for the last finalized record (skipping over any non-finalized).

I though about using desc_ring->head_id or looking for the
last reserved sequence number.

Well, it is just a question where to cut the waiting. And
the very last finalized sequence number might be good
as well.

> > I agree that this might be optimized. I think about reducing the
> > number of cmpxchg even more, something like:
> >
> > static void desc_update_last_finalized(struct prb_desc_ring *desc_ring)
> > {
> > 	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> > 	u64 prev_seq = desc_last_finalized_seq(desc_ring);
> > 	u64 seq = prev_seq;
> >
> > try_again:
> > 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> > 		seq++;
> >
> > 	if (seq == prev_seq)
> > 		return;
> >
> > 	oldval = __u64seq_to_ulseq(prev_seq);
> > 	newval = __u64seq_to_ulseq(seq);
> >
> > 	if (!atomic_long_try_cmpxchg_relaxed(&desc_ring->last_finalized_seq,
> > 					     &oldval, newval)) {
> > 		prev_seq = seq;
> > 		goto try_again;
> > 	}
> > }
> 
> I am fine with this implementation.
> 
> > It looks to me that we could keep passing desc_ring as the parameter.
> 
> No, _prb_read_valid() needs it.

Ah, I see.

> > I feel that we need a read barrier here. It should be between the
> > above
> >
> > 	atomic_long_read(&desc_ring->last_finalized_seq))
> >
> > and the below
> >
> > 	while (_prb_read_valid(rb, &seq, NULL, NULL))
> > 		seq++;
> >
> > It should make sure that the _prb_read_valid() will see all messages
> > finalized which were seen finalized by the CPU updating
> > desc_ring->last_finalized_seq.
> 
> Generally we have not concerned ourselves with readers. But I agree we
> should make the optimization coherent with what a reader can actually
> read. It might save some CPU cycles for polling tasks.

I wanted to agree. But then I found this scenario:

CPU0				CPU1

console_unlock()
  console_flush_all()

				printk()
				  vprintk_store()
    return;
				    prb_final_commit;

				  console_trylock();  # failed

  while (prb_read_valid());


Now, the race:

  + console_flush_all() did not flush the message from CPU1 because
    it was not finalized in time.

  + CPU1 failed to get console_lock() => CPU0 is responsible for
    flushing

  + prb_read_valid() failed on CPU0 because it did not see
    the prb_desc finalized (missing barrier).


Result: The message does not reach the console until another printk()
	tries to flush messages.

Sigh: Even the barrier in prb_next_seq() would not help in this case
      because the while cycle checks prb_read_valid().

Reason: The race is on printk/console_unlock() level. We would need
	something like:

vprintk_emit()
{

	vprintk_store()

	if (!in_sched) {
		/*
		 * Make sure that either the current console_lock() owner
		 * will see the finalized messages or we will see
		 * free console_lock().
		 */
		smp_mb();

		if (console_trylock_spinning())
			console_unlock();
	} ...

}

and

console_unlock()
{
	do {
		console_flush_all();

		__console_unlock();

		/*
		 * Make sure that we either a newly stored message
		 * or the writer will see free console_lock().
		 */
		 smp_mb();
	} while(prb_read_valid(prb, next_seq, NULL) && console_trylock());
}

I believe that it is not needed for defer_console_output()
and wake_up_klogd() because there the barrier is hidden
in the irq_work API.

We needed it only for console_unlock() because there is the race
when console_lock() is temporary released.


> Writing and reading of @last_finalized_seq will provide the necessary
> boundaries to guarantee this:
> 
> ...finalize record...
> atomic_long_try_cmpxchg_release(&desc_ring->last_finalized_seq, ...);
> 
> and
> 
> atomic_long_read_acquire(&desc_ring->last_finalized_seq);
> ...read record...

Yup. something like this.

Well, it is suspicious that there is no _release() counter part.
It suggests that this might not be the right solution. Maybe
the barriers really needed to be on the reader side.

> This guarantees that if a reader sees a certain @last_finalized_seq
> value, that they will also see the record that was finalized.
> 
> This will be the 13th memory barrier pair to be added to the
> documentation.

I know. We need to be careful about the design to do not
make it over-complicated.

Well, I still feel that the barrier in desc_update_last_finalized()
and prb_next_seq() might be needed when the prb_next_seq()
caller gives up when there is no progress (no new message
could be proceed).

And I think that there will be some users in the nbcon code.

But again, this need not be the right location. Usually,
the prb_next_seq() caller will be responsible for flushing
new messages. And there has to be a barrier between the
writer and the flusher like in the vprintk_emit()/console_unlock()
case above.

I mean, that the flusher either has to see the bigger prb_next_seq()
or it has to be scheduled to check it again later. And this
need to be handled by a barrier in vprintk_emit().


Sigh, sigh, sigh, my brain is cycling now ;-)

My notice that atomic_long_read_acquire() in prb_next_seq()
would not have _release() counter part suggests that
the prb API for readers does not help with synchronization.

I have to think more about it. Maybe some acquire/release
or synchronized for_each_finalized_seq() API
might be useful.

Or maybe the synchronization has to be on the printk() level.


Anyway, I feel that this might fall to the "perfection is
the enemy of good" category. We only need to make sure that
the flush will not get stuck. And that the final flush will try
hard.

The races are probably hard to hit in practice.


Best Regards,
Petr
