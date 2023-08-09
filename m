Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6CB7756FB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 12:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjHIKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjHIKUx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:20:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDC81FEA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 03:20:51 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2C4B421863;
        Wed,  9 Aug 2023 10:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691576450; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qR/YEybPcKdEjeQPbrqQ1LxJcRrOFh3Cev9EwgtgC3Q=;
        b=FjAzVpCCKKM9nBQAPCGlZnW3g9JhWye/vQBuAHytp28Y2idhKYa3DM8DcmofGTdGODt2uN
        y3GfuSWFLs/gHIcIdlxteTGMn4rbVyIVZuBzc39B8TZnw64WooJl2uyuNmxPDk+HxOIm0A
        UJMqTKcIkqrok6BTKQsKPOoM9a2EWh4=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 871EE2C142;
        Wed,  9 Aug 2023 10:20:49 +0000 (UTC)
Date:   Wed, 9 Aug 2023 12:20:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 3/8] printk: nbcon: Add acquire/release logic
Message-ID: <ZNNof7rNADMtyajC@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:28, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality. The console 'locked'
> state is a combination of multiple state fields:

I scratched my head on this patch many days and I am still not sure
how to deal with it. I propose some changes but ...

My proposal is a kind of inverted logic. It allows only limited number
of scenarios. It reduces backward loops. And it is more clear what
is possible in which part of the code.

I kind of like it this way.

The original approach allows what makes sense. Restart the entire
try_acquire loop when something has changed.

It might reduce code duplication. But it allows too many combinations
to my taste so that I am not able keep them in head. From my POV,
it might require more test+debug+fix loops. And the debug part
might be painful.

But it is possible that I just look at it from a wrong angle.


About this mail:

It is long. I updated it several days. I did not know how to
split it because most comments are somehow related.

I do not expect that you would answer every detail. Top level view
is more important. And also situations where I missed some context.


> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -76,6 +104,425 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
>  	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
>  }
>  
> +/**
> + * nbcon_context_try_acquire_direct - Try to acquire directly
> + * @ctxt:		The context of the caller
> + * @cur:		The current console state
> + *
> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.
> + *
> + * Errors:

It might be because I am not a native speaker. But I was a bit
confused by the below description. I think that I know what
it means but only because I "know" the context.

Especially using the same "Retrying the acquire will not be
immediately useful." does not help to understand the difference
of what the caller should do.

> + *
> + *	-EPERM:		A panic is in progress an this is not the panic CPU.
> + *			Retrying the acquire will not be immediately useful.

I would write something like:

 *	-EPERM:		A panic is in progress an this is not the panic CPU.
 *			This context is not allowed to take the lock.

But I would use is also when the priority is not sufficient. In this
case, any waiting does not make sense either. So, I would write:

 *	-EPERM:		The console is already owned by a context with
 *			the same or higher priority. Or a panic is in
 *			progress an this is not the panic CPU. Any waiting
 *			does not make sense in this case.

> + *
> + *	-EBUSY:		The console already has an owner. Retrying the
> + *			acquire will not be immediately useful.

I would write something like this:

 *	-EBUSY:		The console already has an owner with a lower
 *			The caller might try handover.

> + *
> + *	-EAGAIN:	An unexpected state change occurred. @cur has been
> + *			updated. The caller should retry the acquire.

The word "unexpected" sounds like it should never happen. It might
rare but it is a perfectly fine race. I would write:

  "@cur has changed in the meaning. The caller should retry."

> + *
> + * The general procedure is to change @prio from unowned to owned.
> + */
> +static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> +					    struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new = {
> +		.cpu			= cpu,
> +		.prio			= ctxt->prio,
> +		.unsafe			= cur->hostile_unsafe | ctxt->unsafe,
> +		.hostile_unsafe		= cur->hostile_unsafe,
> +	};
> +
> +	if (other_cpu_in_panic())
> +		return -EPERM;
> +
> +	/*
> +	 * Direct not possible if owner in unsafe region. If there
> +	 * was previously a hostile takeover, the console may be left
> +	 * in an unsafe state, even if it is now unowned.
> +	 */
> +	if (cur->unsafe)
> +		return -EBUSY;

I would expect that this function is able to take the lock when there
is no owner and no waiter.

The harsh takeover will be used as the last attempt in panic().
But what about messages printed after this flush? They should
be able to reach the console as well.

It might be enough when the information that there was a harsh
takeover in the past will stay stored in nbcon_state and
copied to nbcon_ctxt. If the console driver used a special
code after a harsh takeover, it would still know that it should
use it.


> +	/* Direct is only possible if it is unowned. */
> +	if (cur->prio != NBCON_PRIO_NONE)
> +		return -EBUSY;
> +
> +	/* Higher priority waiters are allowed to keep waiting. */
> +	if (cur->req_prio > ctxt->prio)
> +		new.req_prio = cur->req_prio;
> +	else
> +		new.req_prio = 0;

I am confused here.

1. I would expect that we bail out when there already is a request
   with a higher priority.

   It seems like this code tries to steal the lock that was
   released for the higher priority waiter. Honestly, I do
   not see any good reason for this. Higher priority
   request should always get the lock ASAP!

   If we do not want an extra delay then I would replace
   udelay(1) with cpu_relax(). The lock is supposed to
   wait the same way as a spinlock.

   Or is this somehow important for RT?

   I guess that the kthread might afford rescheduling here. But
   will it reschedule also in EMERGENCY context? It will not
   reschedule in PANIC for sure.

   Well, if we allow rescheduling then we need to guarantee
   that the process stays on the same CPU. I am not sure what
   is the plan here.


2. I would expect that we bail out even when there already is a request
   with the same priority.

   OK, the spinning context will detect this because nbcon_state_try_cmpxchg()
   will fail and it will restart everything with -EAGAIN. And it will
   later bail out in nbcon_context_try_acquire_handover().

   So, this likely works but it is pretty hairy to me. It is far from
   obvious and not documented. It took me long time to put
   all these pieces together.



> +	/* All looks good. Try to take ownership. */
> +
> +	if (!nbcon_state_try_cmpxchg(con, cur, &new))
> +		return -EAGAIN;
> +
> +	cur->atom = new.atom;
> +
> +	return 0;
> +}
> +
> +/**
> + * nbcon_context_try_acquire_handover - Try to acquire via handover
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + *
> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.
> + *
> + * Errors:
> + *
> + *	-EPERM:		A panic is in progress an this is not the panic CPU.
> + *			Retrying the acquire will not be immediately useful.
> + *
> + *	-EBUSY:		The current owner or waiter is such that this context
> + *			is not able to execute a handover. Retrying the
> + *			acquire will not be immediately useful.
> + *
> + *	-EAGAIN:	An unexpected state change occurred. @cur has been
> + *			updated. The caller should retry the acquire.
> + *

I have the same problems to understand the meaning of the error codes
as in nbcon_context_try_acquire_direct(). See an alternative text below.


> + * The general procedure is to set @req_prio and wait until unowned. Then
> + * set @prio (claiming ownership) and clearing @req_prio.
> + */
> +static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
> +					      struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new;
> +	int timeout;
> +	int err = 0;
> +
> +	/* Cannot request handover if owner has same or higher priority. */
> +	if (cur->prio >= ctxt->prio)
> +		return -EBUSY;
> +

I was surprised by the -EBUSY. Insufficient priority sounds more like
a permission problem.

I guess that you use -EBUSY so that it would try the harsh takeover.

It is not a big deal. But it should be explained in a comment.
But I would personally use -EPERM.

> +	/* Cannot request handover if a waiter has same or higher priority. */
> +	if (cur->req_prio >= ctxt->prio)
> +		return -EBUSY;

Same here.

> +
> +	/*
> +	 * If there is no owner, a handover may be in progress and this
> +	 * context (having a higher priority) could jump in directly.
> +	 */
> +	if (cur->prio == NBCON_PRIO_NONE)
> +		return nbcon_context_try_acquire_direct(ctxt, cur);

This looks superfluous. We are here because
nbcon_context_try_acquire_direct() failed.

> +	/* Cannot handover on same CPU. */
> +	if (cur->cpu == cpu)
> +		return -EBUSY;

-EBUSY looks natural in this case.


> +	/* Cannot request handover if caller unwilling to wait. */
> +	if (ctxt->spinwait_max_us == 0)
> +		return -EBUSY;
> +
> +	/* Set request for handover. */
> +	new.atom = cur->atom;
> +	new.req_prio = ctxt->prio;
> +	if (!nbcon_state_try_cmpxchg(con, cur, &new))
> +		return -EAGAIN;
> +
> +	cur->atom = new.atom;
> +
> +	debug_store(1, "handover: cpu%d SPINNING to acquire for prio%d\n", cpu, ctxt->prio);
> +
> +	/* Wait until there is no owner and then acquire directly. */
> +	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
> +		/* On successful acquire, this request is cleared. */
> +		err = nbcon_context_try_acquire_direct(ctxt, cur);

I guess that this is the reason why nbcon_context_try_acquire_direct()
tries to get the lock even when there is a request with the same
priority. But it means that more CPUs with the same priority
might get the lock via nbcon_context_try_acquire_direct().
Only one might succeed.

This made my head spin a lot. And it took me long time to understand
if the race is ok, if there will be more waiters with the same
priority spinning, ...

OK, callers with the same priority should not spin because
they will bail out at the beginning of this function. So, there should
be only one waiter, except, see below.

> +		if (!err)
> +			return 0;
> +
> +		/*
> +		 * If another CPU is in panic, the request must be removed
> +		 * before returning to the caller.
> +		 */
> +		if (err == -EPERM)
> +			break;
> +
> +		/* Continue spinwaiting on -EAGAIN and -EBUSY. */
> +
> +		udelay(1);
> +
> +		/* Re-read the state because some time has passed. */
> +		nbcon_state_read(con, cur);
> +
> +		/*
> +		 * If the waiter unexpectedly changed, this request is
> +		 * no longer set. Have the caller try again rather than
> +		 * guessing what has happened.
> +		 */
> +		if (cur->req_prio != ctxt->prio)

IMHO, the following might happen:

CPU0			CPU1			CPU2

# EMERGENCY PRIO)
nbcon_context_try_acquire_handover()
nbcon_context_try_acquire_handover  for (timeout...

    udelay()

			# current owner releases the lock

			# another try_acquire in EMERGENCY_PRIO
			nbcon_context_try_acquire_direct()
			# SUCCESS, the lock was free
			# req_prio is clear

						# another try_acquire in EMERGENCY_PRIO
						nbcon_context_try_acquire_direct()
						# -EBUSY, lock owned by CPU1

						# nbcon_context_try_acquire_handover()
						# see clear req_prio
						# set req_prio to and is spinning


    nbcon_state_read(con, cur);

    if (cur->req_prio != ctxt->prio)
      # fails because req_prio is the same even
      # when the owner is different

RESULT: Two CPUs are happily spinning.

Maybe, this particular race is acceptable. But is it the only race?

My feeling:

   It took me quite some time to make mental mode of the code.
   Then I had to do many spins with various variants to find
   the above race.

   And I am not sure if this is the only one. My brain is hurting.


Update after several days:

   I thought about this many days. (Partly because there was a weekend
   and I was busy with other things). I was not sure if I wanted to avoid
   these races because of my intuition (might be a good reason) or because
   I wanted to do it my way (would be a bad reason).

   And I do not feel comfortable with this patch even after many days.
   The stealing and the many continue/restart paths create to many
   combinations. It might be perfectly fine if everything works.
   But it will create many complications when there is a problem.

   And the question is not only whether the lock work as expected.
   The problem is that the stealing also makes the result less
   predictable. It would add more possible "races" also to
   the try_acquire() callers.

   IMHO, the semantic of this lock would be much easier when it
   guarantees that higher priority request will block any lower
   priority one. And that only one EMERGENCY context will wait
   and get the lock.


So, I would prefer to make this more straightforward:

1. nbcon_context_try_acquire_direct() should take the lock only
   when the lock is free and there is not pending request
   with the same or higher priority.

	if (cur->req_prio >= ctxt->prio)
		return -EPERM;


2. nbcon_context_try_acquire_handover() might duplicate some code
   with _direct() variant. But it should guarantee that there will
   be only one waiter a straightforward way.

   I would suggest something like this for the waiting loop:


	err = -EBUSY;
	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--)	{
		/*
		 * We are here because the lock is not free.
		 *
		 * In theory, the following race might happen during udelay().
		 * The lock was taken and released by a higher priority
		 * context. Then the lock was taken with a lower priority
		 * context and another CPU with our priority started handover.
		 * As a result, two CPUs might be cycling now.
		 *
		 * It would not be a big deal. Only one CPU
		 * would succeed with taking over the lock. The other
		 * would bail out.
		 *
		 * But in practice, this could not happen because
		 * messages with NORMAL prio are serialized either by
		 * console_lock() or by the kthread. All messages with
		 * PANIC priority are handled on panic CPU. And panic
		 * context overrides any other context and the
		 * priority never goes down.
		 *
		 * An ultimate solution would be adding req_cpu to
		 * check that someone else starter spinning on another
		 * CPU. But it is not worth it as described above.
		 */
		udelay(1);  or cpu_relax() ?

		/* Re-read the state because some time has passed. */
		nbcon_state_read(con, cur);

		/* See below how this is implemented. */
		err = nbcon_context_try_acquire_request(ctxt, cur);
	while (err = -EBUSY);

	/* Was it timeout? */
	if (err != -EBUSY)
		return err;

	/* Timed out. Carefully remove the request. */
	do {
		new.atom = cur->atom;
		new.req_prio = NBCON_PRIO_NONE;
		if (nbcon_state_try_cmpxchg(con, cur, &new)) {
			debug_store(1, "handover: cpu%d TIMEOUT to acquire for prio%d\n",
				    cpu, ctxt->prio);
			/*
			 * Request successfully unset. Report failure of
			 * acquiring via handover.
			 */
			cur->atom = new.atom;
			return -EBUSY;
		}

		/*
		 * Something has changed. Maybe the lock is free or
		 * taken over by a higher priority task. Or maybe
		 * just some other meta data has changed.
		 *
		 * We would get the lock when it is free and the
		 * request is still ours. And we will get -EBUSY
		 * when the request is still ours.
		 */
		err = nbcon_context_try_acquire_request(ctxt, cur);
	while (err = -EBUSY);

	return err;
}

, where

/*
 * Try to take the lock when it is reserved for us. It is called for
 * a re-read @cur state.
 *
 * Returns:
 *
 *   0:		successfully acquired the lock.
 *
 *   -EPERM:	The console has been taken by a context with a higher
 *		priority. Or a panic is in progress an this is not
 *		the panic CPU. Waiting does not make sense any longer.
 *
 *   -EBUSY:    The lock is still blocked and reserved for us. It makes
 *		sense to continue waiting until the timeout.
 */
static int nbcon_context_try_acquire_request(struct nbcon_context *ctxt,
					     struct nbcon_state *cur)
{
	struct nbcon_state new;

	if (other_cpu_in_panic())
		return -EPERM;

	/* A higher priority context took over the request/lock */
	if (cur->req_prio != ctxt->prio)
		return -EPERM;

	/* Request is ours. But is the lock still owned? */
	if (cur->prio != NBCON_PRIO_NONE)
		return -EBUSY;

	/* The lock is available and is reserved for us. Try to get it. */
	 new.atom = cur->atom;
	 new.cpu = smp_processor_id();
	 new.prio = ctxt->prio;
	 new.req_prio = 0;
	 new.unsafe = cur->hostile_unsafe | ctxt->unsafe;

	if (!nbcon_state_try_cmpxchg(con, cur, &new))
		return 0;

	/*
	 * Someone else manipulated the state. But the lock was free
	 * and blocked for us. Only a higher priority context was
	 * allowed to take over it.
	 */
	return -EPERM;
}

Just for comparison. The _direct() variant might look like:

/*
 * Try to get the lock when it is free not requested by another
 * context with the same or higher priority.
 *
 * Returns:
 *
 *   0:		successfully acquired the lock.
 *
 *   -EPERM:	The console is already owned by a context with
 *		the same or higher priority. Or a panic is in
 *		progress an this is not the panic CPU. Any waiting
 *		does not make sense in this case.
 *
 *   -EBUSY:	The console already has an owner with a lower
 *		The caller might try handover.
 *
 */
static int nbcon_context_try_acquire_directly(struct nbcon_context *ctxt,
					      struct nbcon_state *cur)
{
	struct nbcon_state new;

try_again:
	if (other_cpu_in_panic())
		return -EPERM;

	/* Could override only request from a lower priority context. */
	if (ctxt->prio <= cur->req_prio)
		return -EPERM;

	if (cur->prio != NBCON_PRIO_NONE)
		return -EBUSY;

	/* The lock is available and we are free to take it. */
	 new.atom = cur->atom;
	 new.cpu = smp_processor_id();
	 new.prio = ctxt->prio;
	 /* Clear request from a lower priority context. */
	 new.req_prio = 0;
	 new.unsafe = cur->hostile_unsafe | ctxt->unsafe;

	/*
	 * The state might have changed when anyone else took the lock.
	 * Check again if we could busy wait or give up.
	 */
	if (nbcon_state_try_cmpxchg(con, cur, &new))
		goto try_again;

	return 0;
}

So, there is some code duplication but it is clear what is going on.
And there are only two error codes.

> +	}
> +
> +	/* Timeout. Safely remove handover request and report failure. */
> +	do {
> +		/* No need to remove request if there is another waiter. */
> +		if (cur->req_prio != ctxt->prio) {
> +			if (err == -EPERM)
> +				return err;
> +			return -EBUSY;
> +		}
> +
> +		/* Unset request for handover. */
> +		new.atom = cur->atom;
> +		new.req_prio = NBCON_PRIO_NONE;
> +		if (nbcon_state_try_cmpxchg(con, cur, &new)) {
> +			debug_store(1, "handover: cpu%d TIMEOUT to acquire for prio%d\n",
> +				    cpu, ctxt->prio);
> +			/*
> +			 * Request successfully unset. Report failure of
> +			 * acquiring via handover.
> +			 */
> +			cur->atom = new.atom;
> +			return -EBUSY;
> +		}
> +
> +		/*
> +		 * Unable to remove request. Try direct acquire. If
> +		 * successful, this request is also cleared.
> +		 */
> +		err = nbcon_context_try_acquire_direct(ctxt, cur);
> +	} while (err);
> +
> +	/* Direct acquire at timeout succeeded! */
> +	return 0;
> +}
> +
> +/**
> + * nbcon_context_try_acquire_hostile - Try to acquire via hostile takeover
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + *
> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.
> + *
> + * Errors:
> + *
> + *	-EPERM:		A panic is in progress an this is not the panic CPU
> + *			or this context is not the single panic context.
> + *			Retrying the acquire will not be immediately useful.
> + *
> + *	-EBUSY:		The current owner is in an unsafe region and
> + *			@takeover_unsafe was not set. Retrying the acquire
> + *			is only immediately useful if @takeover_unsafe is
> + *			set.
> + *
> + *	-EAGAIN:	An unexpected state change occurred. @cur has been
> + *			updated. The caller should retry the acquire.
> + *
> + * The general procedure is to set @prio (forcing ownership). This method
> + * must only be used as a final attempt during panic.
> + */
> +static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
> +					     struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new = {
> +		.cpu			= cpu,
> +		.prio			= ctxt->prio,
> +		.unsafe			= cur->hostile_unsafe | ctxt->unsafe,
> +		.hostile_unsafe		= cur->hostile_unsafe | cur->unsafe,

We do hostile only when it is unsafe. So, I would expect:

		.unsafe			= true;
		.hostile_unsafe		= true;
> +	};
> +
> +	if (other_cpu_in_panic())
> +		return -EPERM;
> +
> +	/* Hostile takeovers must only be in the single panic context! */
> +	if (WARN_ON_ONCE(ctxt->prio != NBCON_PRIO_PANIC || cur->prio == NBCON_PRIO_PANIC))
> +		return -EPERM;

I wondered if we actually might want to take over the lock from
a nested PANIC context on the panic() CPU.

For example, when panic() was in normal process context
and NMI came when flushing a message to the console.
Should the NMI context take over the lock a harsh way?

But it actually does not make sense. The harsh takeover
is allowed only in the final flush_in_panic() which is
called from the same context as the panic() function.


> +
> +	/*
> +	 * If a hostile takeover in unsafe regions is wanted,
> +	 * this is additionally requested.
> +	 */
> +	if (cur->unsafe && !ctxt->takeover_unsafe)
> +		return -EBUSY;

I would return -EPERM because we simply can't take the lock
in this context now.

> +	if (!nbcon_state_try_cmpxchg(con, cur, &new))
> +		return -EAGAIN;

Do we really need to start from the very beginning?

If try_cmpxchg fails it means that a non-panic CPU
still owns the lock and is manipulating the state.

I would just repeat the cmpxchg inside this function.
I would just revisit the values of the .unsafe and
.takeover_unsafe flags. The forced takeover might
be safe now.

> +
> +	cur->atom = new.atom;
> +
> +	return 0;
> +}
> +
> +/**
> + * nbcon_context_try_acquire - Try to acquire nbcon console
> + * @ctxt:	The context of the caller
> + *
> + * Return:	True if the console was acquired. False otherwise.
> + *
> + * The attempts to acquire always begin with the safest methods and only
> + * upon failure move to more aggressive methods.
> + *
> + * If the caller requested a hostile takeover, on success @ctxt is
> + * updated so that the caller can see if indeed a hostile (and
> + * possibly unsafe) takeover occurred.
> + */
> +__maybe_unused
> +static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
> +{
> +	__maybe_unused
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +	bool hostile;
> +	int err;
> +
> +	/* @takeover_unsafe is only valid when hostile takeover requested. */
> +	WARN_ON_ONCE(ctxt->takeover_unsafe && !ctxt->hostile);
> +
> +	nbcon_state_read(con, &cur);
> +
> +try_again:
> +	hostile = false;
> +
> +	/* ACQUIRE DIRECT */
> +
> +	debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
> +		    "direct: cpu%d trying DIRECT acquire prio%d\n", cpu, ctxt->prio);
> +	err = nbcon_context_try_acquire_direct(ctxt, &cur);
> +	if (!err) {
> +		debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
> +			    "direct: cpu%d SUCCESS prio%d\n", cpu, ctxt->prio);
> +		goto success;
> +	} else if (err == -EPERM) {
> +		debug_store(1, "direct: cpu%d FAILED prio%d (non-panic cpu)\n",
> +			    cpu, ctxt->prio);
> +		return false;
> +	} else if (err == -EAGAIN) {
> +		debug_store(1, "direct: cpu%d FAILED prio%d (state race)\n",
> +			    cpu, ctxt->prio);
> +		goto try_again;
> +	} else {
> +		debug_store(1, "direct: cpu%d FAILED prio%d (already owned by cpu%d)\n",
> +			    cpu, ctxt->prio, cur.cpu);
> +		/* Continue to next method. */
> +	}

Hmm, the many debug_store() calls are a bit disturbing here.
Is the custom message really importnat? Would be enough to do?:

	debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
		    "direct: cpu%d trying DIRECT acquire prio%d\n", cpu, ctxt->prio);
	err = nbcon_context_try_acquire_direct(ctxt, &cur);
	debug_store(ctxt->prio > NBCON_PRIO_NORMAL,
		    "direct: cpu%d DIRECT acquire prio%d returned %pe\n", cpu, ctxt->prio, ERR_PTR(err));

	if (!err)
		goto success;
	if (err == -EPERM)
		return -false;
	WARN_ON_ONCE(err != -EBUSY);

	/* ACQUIRE VIA HANDOVER */
...


> +	debug_store(1, "handover: cpu%d REQUESTING prio%d from cpu%d\n",
> +		    cpu, ctxt->prio, cur.cpu);
> +	err = nbcon_context_try_acquire_handover(ctxt, &cur);
> +	if (!err) {
> +		debug_store(1, "handover: cpu%d SUCCESS prio%d\n",
> +			    cpu, ctxt->prio);
> +		goto success;
> +	} else if (err == -EPERM) {
> +		debug_store(1, "handover: cpu%d FAILED requesting prio%d (non-panic cpu)\n",
> +			    cpu, ctxt->prio);
> +		return false;
> +	} else if (err == -EAGAIN) {
> +		debug_store(1, "handover: cpu%d FAILED requesting prio%d (state race)\n",
> +			    cpu, ctxt->prio);
> +		goto try_again;
> +	} else {
> +		debug_store(1, "handover: cpu%d FAILED requesting prio%d (cpu%d/prio%d/timeout)\n",
> +			    cpu, ctxt->prio, cur.cpu, cur.prio);
> +		/* Continue to next method. */
> +	}
> +
> +	/* ACQUIRE VIA HOSTILE TAKEOVER */
> +
> +	/* Only attempt hostile takeover if explicitly requested. */
> +	if (!ctxt->hostile)
> +		return false;
> +
> +	debug_store(1,
> +		    "hostile: cpu%d trying HOSTILE acquire for prio%d from cpu%d (takeover_unsafe=%d)\n",
> +		    cpu, ctxt->prio, cur.cpu, ctxt->takeover_unsafe);
> +	err = nbcon_context_try_acquire_hostile(ctxt, &cur);
> +	if (!err) {
> +		debug_store(1, "hostile: cpu%d SUCCESS prio%d\n", cpu, ctxt->prio);
> +		/* Let caller know if the takeover was unsafe. */
> +		ctxt->takeover_unsafe = cur.hostile_unsafe;
> +		hostile = true;
> +		goto success;
> +	} else if (err == -EPERM) {
> +		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (non-panic cpu)\n",
> +			    cpu, ctxt->prio);
> +		return false;
> +	} else if (err == -EAGAIN) {
> +		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (state race)\n",
> +			    cpu, ctxt->prio);
> +		goto try_again;
> +	} else {
> +		debug_store(1, "hostile: cpu%d FAILED acquire prio%d (unsafe)\n",
> +			    cpu, ctxt->prio);
> +		/* Continue to next method. */
> +	}
> +
> +	/* No methods left to try. */
> +	return false;
> +success:
> +	if (!hostile) {
> +		/* Let caller know it was not a hostile takeover. */
> +		ctxt->hostile = 0;
> +		ctxt->takeover_unsafe = 0;

nbcon_context_try_acquire_direct() sets new.unsafe when
cur->hostile_unsafe is set.

My understanding is that any acquire is unsafe when there
was an unsafe hostile takeover in the past. IMHO, ctxt should
be aware of this and we should not blindly clear these variables.

> +	}
> +	return true;
> +}

> +/**
> + * nbcon_context_release - Release the console
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + */
> +__maybe_unused
> +static void nbcon_context_release(struct nbcon_context *ctxt)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +	struct nbcon_state new;
> +
> +	nbcon_state_read(con, &cur);
> +	do {
> +		if (!nbcon_owner_matches(&cur, cpu, ctxt->prio))
> +			return;
> +
> +		new.atom = cur.atom;
> +		new.prio = NBCON_PRIO_NONE;
> +		new.unsafe = cur.hostile_unsafe;
> +
> +		/*
> +		 * If @hostile_unsafe is set, it is kept set so that
> +		 * the state remains permanently unsafe.
> +		 */

This comment should be above the new.unsafe assignment.

> +
> +	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
> +}
> +
>  /**
>   * nbcon_init - Initialize the nbcon console specific data
>   * @con:	Console to initialize
