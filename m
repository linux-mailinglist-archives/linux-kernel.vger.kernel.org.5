Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8567A054A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238845AbjINNQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238759AbjINNQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:16:31 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A881A5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:16:26 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7118B1F459;
        Thu, 14 Sep 2023 13:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694697385; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y6DgCNsz0EdfcsoLf7NeuArEVb9AN2m/e3y7iiIX19A=;
        b=usI4kt986qqMIgCwdpK/xzzNbxWI8lAq13VO/WVvyilqvI3DtcZ1ZD+JOLZWTwUK+epmXH
        pvHonhLCmgYUDXGGgJCebrIn2wgu3Sl6EayvcY6aTLVuMfoqbkXm4KjRZ6E8hdcmQOMIVs
        AkhBnjDJqViJVfpZ+SQqGYuOzNOzRQg=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 11D7A2C142;
        Thu, 14 Sep 2023 13:16:24 +0000 (UTC)
Date:   Thu, 14 Sep 2023 15:16:24 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v4 2/8] printk: nbcon: Add acquire/release logic
Message-ID: <ZQMHqJaNffsKFymG@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908185008.468566-3-john.ogness@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have spent on this patch much more time than expected. There were
basically two triggers:

  + I decided to check the commit message and all the comments more
    carefully and some sentences looked outdated, harder to follow,
    or confused me a bit.

  + It looked strange that try_acquire_direct() could take over
    lock from a context with lower priority when the console was
    in the safe state. But try_acquire_handover_requested()
    did not check the 'unsafe' flag and just waited until
    the current owner releases the lock.

I started modifying the code to add the check of the 'unsafe'.
It triggered some code shuffling and updates of comments.

Then I realized that it actually worked even before because
try_acquire_handover() was called when the console was
in unstable state and the current owner released the console
immediately on exit from unsafe_exit(). So that handover
never had to wait for the next unsafe_enter(). (I am not sure
if I am dumb or if it was really that tricky to realize.)

Also I realized that the do/while cycle should not be
needed in try_acquire_handover_requested() anymore.

Also I updated the comments and did few code clean ups.

Below, I just describe motivation for the changes. I'll
attach a diff with the proposed changes so that you could
just use them if you agree.


On Fri 2023-09-08 20:56:02, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality. The console 'locked'
> state is a combination of multiple state fields:
> 
>   - The 'prio' field contains the priority of the context that owns
>     the console. This field is used for decisions whether to attempt
>     friendly handovers and also prevents takeovers from a less

It is not longer only handover. It is also takeover in the safe state.

>     severe context, e.g. to protect the panic CPU. A value of 0
>     (NBCON_PRIO_NONE) means the console is not locked.
> 
>   - The 'cpu' field denotes on which CPU the console is locked.

If we explained what 'prio' is for. It might make sense to explain
what 'cpu' is for.

> The acquire mechanism comes with several flavours:
> 
>   - Direct acquire when the console is not owned or is owned by a
>     lower priority context and the console is in a safe state.
>
>   - Friendly handover mechanism based on a request/grant handshake.
>     The requesting context must have a higher priority than the
>     current owner.

I would like mention that it is used when the console is in an unsafe
state. And that the current owner releases the lock on exit from
the unsafe state.

IMHO, this is very important piece of the puzzle. It took me long
time to realize it, see above.

>     The requesting context:
> 
>       1) Sets its priority into the 'req_prio' field.
> 
>       2) Waits (with a timeout) for the owning context to unlock the
>          console.
> 
>       3) Sets the 'prio' field and clears the 'req_prio' field.
> 
>     The owning context:
> 
>       1) Observes the 'req_prio' field set.
> 
>       2) Gives up console ownership by clearing the 'prio' field.
> 
>   - Unsafe hostile takeover
> 
>       The new owner takes the console over without 'req_prio'
>       handshake. The new owner must have a higher priority than
>       the previous owner.
> 
>       This is required when friendly handovers are not possible,
>       i.e. the higher priority context interrupted the owning
>       context on the same CPU or the owning context is not able
>       to make progress on a remote CPU.

This is too generic. There is only one user in the end.

> The release is the counterpart that either releases the console
> directly or yields it gracefully over to a requester.

The word 'yield' has always been a magic to me. Does it still
fit here? The release method does not longer assign the lock
to the requestor. It just makes the lock free and keeps the request.

> All operations on @console::nbcon_state are atomic cmpxchg based
> to handle concurrency.
> 
> The acquire/release functions implement only minimal policies:
> 
>   - Preference for higher priority contexts.
>   - Protection of the panic CPU.
> 
> All other policy decisions have to be made at the call sites:
> 
>   - What is marked as an unsafe section.
>   - Whether to spin-wait if there is already an owner and the
>     console is in an unsafe state.
>   - Whether to attempt an unsafe hostile takeover.
> 
> The design allows to implement the well known:
> 
>     acquire()
>     output_one_line()
>     release()
> 
> algorithm, but also allows to avoid the per line acquire/release for
> e.g. panic situations by doing the acquire once and then relying on
> the panic CPU protection for the rest.

IMHO, the locking around each line will be used in panic as well.
So I would not mention this.

> diff --git a/include/linux/console.h b/include/linux/console.h
> index a2d37a7a98a8..eeebb82d6d07 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -194,6 +210,49 @@ struct nbcon_state {
>   */
>  static_assert(sizeof(struct nbcon_state) <= sizeof(int));
>  
> +/**
> + * nbcon_prio - console owner priority for nbcon consoles
> + * @NBCON_PRIO_NONE:		Unused
> + * @NBCON_PRIO_NORMAL:		Normal (non-emergency) usage
> + * @NBCON_PRIO_EMERGENCY:	Emergency output (WARN/OOPS...)
> + * @NBCON_PRIO_PANIC:		Panic output
> + * @NBCON_PRIO_MAX:		The number of priority levels
> + *
> + * A context wanting to produce emergency output can carefully takeover the
> + * console, even without consent of the owner. Ideally such a takeover is only
> + * when @nbcon_state::unsafe is not set. However, a context wanting to produce
> + * panic output can ignore the unsafe flag as a last resort. If panic output
> + * is active, no takeover is possible until the panic output releases the
> + * console.

Some things are not longer valid in the last versions. I would write
something li

 * A higher priority context can takeover the console when it is
 * in the safe state. The final attempt to flush consoles in panic()
 * can be allowed to do so even in an unsafe state (Hope and pray).

> + */
> +enum nbcon_prio {
> +	NBCON_PRIO_NONE = 0,
> +	NBCON_PRIO_NORMAL,
> +	NBCON_PRIO_EMERGENCY,
> +	NBCON_PRIO_PANIC,
> +	NBCON_PRIO_MAX,
> +};
> +
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 10266d3e7883..57ddfb7f0994 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -4,10 +4,43 @@
>  
>  #include <linux/kernel.h>
>  #include <linux/console.h>
> +#include <linux/delay.h>
>  #include "internal.h"
>  /*
>   * Printk console printing implementation for consoles that do not depend on
>   * the legacy style console_lock mechanism.

I have realized that the comments are a bit outdated, see below.

I would personally use the (updated) text from the commit message
here. It looks easier to follow.

> + *
> + * Console is locked on a CPU when @nbcon_state::prio is set and
> + * @nbcon_state:cpu == current CPU. This is valid for the current execution
> + * context.

OK

> + *
> + * Nesting execution contexts on the same CPU can carefully take over if
> + * the driver allows reentrancy via @nbcon_state::unsafe = false. When the
> + * interrupted context resumes it checks the state before entering an unsafe
> + * region and aborts the operation if it detects a takeover.

It is not only about nested contexts. It is primary about contexts with a
higher priority. I think that the rules were different in the original
implementation.

> + *
> + * In case of panic the nesting context can take over the console forcefully.

This describes panic.

> + * A concurrent writer on a different CPU with a higher priority can directly
> + * take over if the console is not in an unsafe state by carefully writing
> + * its priority into @nbcon_state::prio.

This acutally describes the contex with a higher priority.

> + *
> + * If the console is in an unsafe state, the concurrent writer with a higher
> + * priority can request to take over the console by:
> + *
> + *	1) Carefully writing the desired priority into @nbcon_state::req_prio
> + *	   if there is no higher priority request pending.
> + *
> + *	2) Carefully spin on @nbcon_state::prio until it is no longer locked.
> + *
> + *	3) Attempt to lock the console by carefully writing the desired
> + *	   priority to @nbcon_state::prio and carefully removing the desired
> + *	   priority from @nbcon_state::req_prio.
> + *
> + * In case the owner does not react on the request and does not make
> + * observable progress, the waiter will timeout and can then decide to do
> + * an unsafe hostile takeover. Upon unsafe hostile takeover, the console
> + * is kept permanently in the unsafe state.

The comment does not take about direct acquire. I think that all the
variants were better described in the commit message.

>   */
  
>  /**
> @@ -47,6 +80,405 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
>  	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
>  }
>  
> +/**
> + * nbcon_context_try_acquire_direct - Try to acquire directly
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + *
> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.

There is not need to update @cur on success. It won't be used any
longer. On the other hand, it might be useful to say that it is
updated when any modification failed.

> + *
> + * Errors:
> + *
> + *	-EPERM:		A panic is in progress and this is not the panic CPU
> + *			or this context does not have a priority above the
> + *			current owner or waiter. No acquire method can be
> + *			successful for this context.
> + *
> + *	-EBUSY:		The console is in an unsafe state. The caller should
> + *			try using the handover acquire method.
> + *
> + * The general procedure is to change @nbcon_state::prio from unowned to
> + * owned. Or, if the console is not in the unsafe state, to change
> + * @nbcon_state::prio to a higher priority owner.

This is common for all try_acquire() variant. A more important
information is when this variant is supposed to succeed.

> + */
> +static int nbcon_context_try_acquire_direct(struct nbcon_context *ctxt,
> +					    struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new;
> +
> +	do {
> +		if (other_cpu_in_panic())
> +			return -EPERM;
> +
> +		if (ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio)
> +			return -EPERM;
> +
> +		if (cur->unsafe)
> +			return -EBUSY;
> +
> +		/*
> +		 * The console should never be safe for a direct acquire
> +		 * if an unsafe hostile takeover has ever happened.
> +		 */
> +		WARN_ON_ONCE(cur->unsafe_takeover);
> +
> +		new.atom = cur->atom;
> +		new.prio	= ctxt->prio;
> +		new.req_prio	= NBCON_PRIO_NONE;
> +		new.unsafe	= cur->unsafe_takeover;
> +		new.cpu		= cpu;
> +
> +	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
> +
> +	cur->atom = new.atom;

There is no need to update @cur. The caller will just return 0 as well.

> +	return 0;
> +}
> +
> +/**
> + * nbcon_context_try_acquire_requested - Try to acquire after having
> + *					 requested a handover
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + *
> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.
> + *

Same as above. There is not need to update @cur on success. It won't be used any
longer. On the other hand, it might be useful to say that it is
updated when any modification failed.

> + * Errors:
> + *
> + *	-EPERM:		A panic is in progress and this is not the panic CPU
> + *			or this context is no longer the waiter. For the
> + *			former case, the caller must carefully remove the
> + *			request before aborting the acquire.
> + *
> + *	-EBUSY:		The console is still locked. The caller should
> + *			continue waiting.
> + *
> + * This is a helper function for nbcon_context_try_acquire_handover().
> + */
> +static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
> +					       struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new;
> +
> +	do {
> +		/*
> +		 * Note: If the acquire is aborted due to a panic CPU,
> +		 * the caller must still remove the request!
> +		 */
> +		if (other_cpu_in_panic())
> +			return -EPERM;
> +
> +		/*
> +		 * If an unsafe hostile takeover has occurred, a handover
> +		 * is no longer possible.
> +		 */
> +		if (cur->unsafe_takeover)
> +			return -EPERM;

This should never happen without clearing the waiter. The check
of nbcon_waiter_matches() and WARN_ON_ONCE(cur->unsafe) should
be enough.

> +
> +		/* Is this context still the requester? */
> +		if (!nbcon_waiter_matches(cur, ctxt->prio))
> +			return -EPERM;
> +
> +		/* If still locked, caller should continue waiting. */
> +		if (cur->prio != NBCON_PRIO_NONE)
> +			return -EBUSY;
> +
> +		/*
> +		 * The previous owner should have never released ownership
> +		 * in an unsafe region.
> +		 */
> +		WARN_ON_ONCE(cur->unsafe);
> +
> +		new.atom = cur->atom;
> +		new.prio	= ctxt->prio;
> +		new.req_prio	= NBCON_PRIO_NONE;
> +		new.unsafe	= cur->unsafe_takeover;
> +		new.cpu		= cpu;

We are here because the console has been released because of our
request. The following cmpxchg() could fail only when the console
has been acquired by a higher priority context. In which
case we are not longer owner of the request and should
return -EPERM.

> +	} while (!nbcon_state_try_cmpxchg(con, cur, &new));

I would replace the while cycle with:

	if (!nbcon_state_try_cmpxchg(con, cur, &new)) {
		/*
		 * The console has been released because our request.
		 * The acquire could fail only when it has been taken
		 * over by a higher priority context.
		 */
		WARN_ON_ONCE(nbcon_waiter_matches(cur, ctxt->prio));
		return -EPERM;
	}

It would help to find when it does not work as designed.

> +
> +	/* Handover success. This context now owns the console. */
> +
> +	cur->atom = new.atom;

There is no need to update @cur. The caller will just return 0 as well.

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
> + *	-EPERM:		This context is on the same CPU as the current owner

This is not a reason to return -EPERM. The console still could get
acquired using the hostile takeover.


> + *			or the console is permanently in an unsafe state or
> + *			this context is unwilling to wait or a panic is in

What does exactly mean that this context is unwilling to wait, please?
Should we return -EPERM in this case?

> + *			progress and this is not the panic CPU. This is not
> + *			the panic context, so no acquire method can be
> + *			successful for this context.

We should add that -EPERM is returned also when a higher priority context has
taken the console in the meantime.

> + *
> + *	-EBUSY:		The current owner or waiter is such that this context
> + *			is not able to execute a handover.

This is a bit vague.

> + *			an unsafe hostile takeover to acquire.
> + *
> + *	-EAGAIN:	@cur is not the current console state. @cur has been
> + *			updated. The caller should retry with direct acquire.
> + *
> + * The general procedure is to set @req_prio and wait until unowned. Then
> + * set @prio (claiming ownership) and clearing @req_prio.
> + *
> + * Note that it is expected that the caller tried
> + * nbcon_context_try_acquire_direct() with @cur before calling this function.
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
> +	/*
> +	 * Handovers are not possible on the same CPU or when the console
> +	 * is permanently in an unsafe state or if the caller is unwilling
> +	 * to wait.
> +	 */
> +	if (cur->cpu == cpu ||
> +	    cur->unsafe_takeover ||
> +	    ctxt->spinwait_max_us == 0) {
> +		goto fail_handover;
> +	}
> +
> +	/* Setup a request for handover. */
> +	new.atom = cur->atom;
> +	new.req_prio = ctxt->prio;
> +	if (!nbcon_state_try_cmpxchg(con, cur, &new))
> +		return -EAGAIN;
> +
> +	cur->atom = new.atom;
> +
> +	/* Wait until there is no owner and then acquire directly. */
> +	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
> +		/* On successful acquire, this request is cleared. */
> +		err = nbcon_context_try_acquire_requested(ctxt, cur);
> +		if (!err)
> +			return 0;
> +
> +		/*
> +		 * If the acquire should be aborted, it must be ensured
> +		 * that the request is removed before returning to caller.
> +		 */
> +		if (err == -EPERM)
> +			break;
> +
> +		udelay(1);
> +
> +		/* Re-read the state because some time has passed. */
> +		nbcon_state_read(con, cur);
> +	}
> +
> +	/* Timed out or should abort. Carefully remove handover request. */
> +	do {
> +		/* No need to remove request if there is a new waiter. */
> +		if (!nbcon_waiter_matches(cur, ctxt->prio))
> +			goto fail_handover;
> +
> +		/* Unset request for handover. */
> +		new.atom = cur->atom;
> +		new.req_prio = NBCON_PRIO_NONE;
> +		if (nbcon_state_try_cmpxchg(con, cur, &new)) {
> +			/*
> +			 * Request successfully unset. Report failure of
> +			 * acquiring via handover.
> +			 */
> +			cur->atom = new.atom;
> +			goto fail_handover;
> +		}
> +
> +		/*
> +		 * Unable to remove request. Try to acquire in case
> +		 * the owner has released the lock.
> +		 */
> +	} while (nbcon_context_try_acquire_requested(ctxt, cur));
> +
> +	/* Acquire at timeout succeeded! */
> +	return 0;
> +
> +fail_handover:
> +	/*
> +	 * If this is the panic context, the caller can try to acquire using
> +	 * the unsafe hostile takeover method.
> +	 */
> +	if (ctxt->prio == NBCON_PRIO_PANIC &&
> +	    ctxt->prio > cur->prio &&
> +	    ctxt->prio > cur->req_prio &&
> +	    !other_cpu_in_panic()) {
> +		return -EBUSY;

I did not like it even in v3. I am sorry that I did not tell you.

Any location calling "goto fail_handover" knows whether to return
-EBUSY or -EPERM. I mean that it know whether the error is fatal
or the harsh takeover is allowed. The error codes are even used
inside this function. It is strange and hard to follow when
we re-compute the error code by a "magic" check.

They just do not know whether "ctxt->prio == NBCON_PRIO_PANIC"
but it would be more appropriate to check it in
nbcon_context_acquire_hostile() anyway.

The priority and panic context should be checked using
some consistency checkes in try_acquire_hostile().

> +	}
> +	return -EPERM;
> +}
> +
> +/**
> + * nbcon_context_acquire_hostile - Acquire via unsafe hostile takeover
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + *
> + * @cur is updated to the new console state.
> + *
> + * The general procedure is to set @prio (forcing ownership). This method
> + * must only be used as a final attempt during panic.
> + */
> +static void nbcon_context_acquire_hostile(struct nbcon_context *ctxt,
> +					  struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state new;
> +

It would be more appropriate to check that "ctxt->prio == NBCON_PRIO_PANIC" here.

> +	do {
> +		new.atom = cur->atom;
> +		new.cpu			= cpu;
> +		new.prio		= ctxt->prio;
> +		new.unsafe		|= cur->unsafe_takeover;
> +		new.unsafe_takeover	|= cur->unsafe;
> +
> +	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
> +
> +	cur->atom = new.atom;

There is not need to set @cur on success. I won't be used.

> +}
> +
> +/**
> + * nbcon_context_try_acquire - Try to acquire nbcon console
> + * @ctxt:	The context of the caller
> + *
> + * Return:	True if the console was acquired. False otherwise.
> + *
> + * If the caller allowed an unsafe hostile takeover, on success the
> + * caller should check the current console state to see if it is
> + * in an unsafe state. Otherwise, on success the caller may assume
> + * the console is not in an unsafe state.
> + */
> +__maybe_unused
> +static bool nbcon_context_try_acquire(struct nbcon_context *ctxt)
> +{
> +	__maybe_unused
> +	unsigned int cpu = smp_processor_id();
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +	int err;
> +
> +	/* unsafe hostile takeovers are only allowed for panic */
> +	WARN_ON_ONCE(ctxt->allow_unsafe_takeover && (ctxt->prio != NBCON_PRIO_PANIC));

This would better fit into nbcon_context_acquire_hostile(). I know
that it would be checked there only when direct and handover failed.
But there is a good chance to hit it when used in non-panic context.

> +	nbcon_state_read(con, &cur);
> +
> +	do {
> +		err = nbcon_context_try_acquire_direct(ctxt, &cur);
> +		if (!err)
> +			goto success;
> +		else if (err == -EPERM)
> +			return false;
> +
> +		err = nbcon_context_try_acquire_handover(ctxt, &cur);
> +		if (!err)
> +			goto success;
> +		else if (err == -EPERM)
> +			return false;
> +
> +	} while (err == -EAGAIN);
> +
> +	/* Only attempt unsafe hostile takeover if explicitly requested. */
> +	if (!ctxt->allow_unsafe_takeover)
> +		return false;
> +
> +	nbcon_context_acquire_hostile(ctxt, &cur);
> +success:
> +	return true;
> +}

Best Regards,
Petr
