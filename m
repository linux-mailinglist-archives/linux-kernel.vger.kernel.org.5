Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05265793D50
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240976AbjIFNBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjIFNB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:01:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB71E7B
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:01:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 52B4921B0D;
        Wed,  6 Sep 2023 13:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694005282; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=m9YsMgJHY26AS5R28GtaZqBQpuEJEQk3EuiW9F2028w=;
        b=H+Wuiyq7ya02lEVbz3BqdIwX9uJe7LkOw4jFb4ZrEboySUUOovBBlyBN2mUcuittYuYe3d
        La0mQJIRolRHZf+PsHaiIOSEfEFiXKH/5HyJd2TPzC+zJzTfU+Tctkgq/UTPGBdqJXUtJ8
        2KFVo1wAfYNaW9kCDBbP1YH9tAkX4Sc=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id F01582C142;
        Wed,  6 Sep 2023 13:01:21 +0000 (UTC)
Date:   Wed, 6 Sep 2023 15:01:21 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 2/7] printk: nbcon: Add acquire/release logic
Message-ID: <ZPh4IQSOSvwejH5k@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:34, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality. The console 'locked'
> state is a combination of multiple state fields:
> 
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -47,6 +80,431 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
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
> +		 * Direct acquires should never be attempted if
> +		 * an unsafe hostile takeover has ever happened.
> +		 */
> +		WARN_ON_ONCE(cur->unsafe_takeover);

I was a bit confused by this. My first thought was that
this function should never be called after hostile takeover.
And it did not make sense.

But it means that we should never be here if an unsafe hostile
takeover happened. I would slight change the comment:

		/*
		 * The console should never be safe for a direct acquire
		 * if an unsafe hostile takeover has ever happened.
		 */
		WARN_ON_ONCE(cur->unsafe_takeover);

> +		new.atom = cur->atom;
> +		new.prio	= ctxt->prio;
> +		new.req_prio	= NBCON_PRIO_NONE;
> +		new.unsafe	= cur->unsafe_takeover;
> +		new.cpu		= cpu;
> +
> +	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
> +
> +	cur->atom = new.atom;
> +
> +	return 0;
> +}
> +
> +static bool nbcon_waiter_matches(struct nbcon_state *cur, int expected_tag,
> +				int expected_prio)
> +{
> +	/*
> +	 * Since consoles can only be acquired by higher priorities,
> +	 * waiting contexts are uniquely identified by @prio. However,
> +	 * since owners and waiters can unexpectedly change, it is
> +	 * possible that later another waiter appears with the same
> +	 * priority. For this reason @req_tag is also needed.
> +	 *
> +	 * Using the waiting CPU would be better, but there are not enough
> +	 * bits in the state variable for this. Since unexpected waiter
> +	 * changes are rare and them going unnoticed does not cause fatal
> +	 * problems, the tagged bits should be sufficient.
> +	 */
> +
> +	if (cur->req_prio != expected_prio)
> +		return false;
> +
> +	if (cur->req_tag != expected_tag)
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * nbcon_context_try_acquire_requested - Try to acquire after having
> + *					 requested a handover
> + * @ctxt:	The context of the caller
> + * @cur:	The current console state
> + * @req_tag:	The tagged bits used to identify this waiting context

I would suggest to rename @req_tag to @req_cnt or @req_wait_cnt
and describe it:

 * @req_wait_cnt:	Counter to distinguish waiting contexts of
 *			the same priority.

Later update: I would actually remove the tag completely, see below.

> + * Return:	0 on success and @cur is updated to the new console state.
> + *		Otherwise an error code on failure.
> + *
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
> + *
> + * The use of tagged bits is to partially deal with the situation that while
> + * this waiting context is in udelay(1):
> + *
> + *   1. another context with higher priority directly takes ownership
> + *   2. the higher priority context releases ownership
> + *   3. a lower priority context takes ownership
> + *   4. a context with the same priority as this context requests ownership
> + *   5. this waiting context finishes udelay(1) and thinks it is the waiter

I was a bit confused by the above description. First, I though that 1, 2,
3, 4 would match the req_tag number.

> + *
> + * To address this rare situation, tagged bits are used so that the waiter
> + * can better identify if it is really the waiter. In the above  example, the
> + * original waiter would use a @req_tag value of 1, whereas the follow-up
> + * waiter would use a @req_tag value of 2. This allows the original waiter to
> + * identify in step 5 that it has been replaced by another waiter.
> + */

I thought about how to avoid the confusion and update the description
of the @req_tag handling. And I am pretty sure that the race could
not happen in the current implementation.

I suggest to remove @req_tag completely and describe the problem
above nbcon_waiter_matches() implementation. Something like:


/**
 * The request owner is well defined by the @req_prio because
 *
 *   1. Only a context with a higher priority could take over the request.
 *   2. There are only three priorities.
 *   3. Only one CPU is allowed to request PANIC priority.
 *   4. Lower priorities are ignored during panic() until reboot.
 *
 * As a result, the following scenario is not possible:
 *
 *   1. Another context with a higher priority directly takes ownership.
 *   2. The higher priority context releases the ownership.
 *   3. A lower priority context takes the ownership.
 *   4. Another context with the same priority as this context
 *	creates a request and starts waiting.
 */
static bool nbcon_waiter_matches(struct nbcon_state *cur,
				 int expected_prio)
{
	return cur->req_prio == expected_prio;
}

> +
> +	if (cur->req_tag != expected_tag)
> +		return false;
> +
> +	return true;
> +}
> +
> +static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
> +					       struct nbcon_state *cur,
> +					       char req_tag)
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
> +
> +		/* Is this context still the requester? */
> +		if (!nbcon_waiter_matches(cur, req_tag, ctxt->prio))
> +			return -EPERM;
> +
> +		/* If still locked, caller should continue waiting. */
> +		if (cur->prio != NBCON_PRIO_NONE)
> +			return -EBUSY;
> +
> +		/* Handover acquires should never be attempted if unsafe. */
> +		WARN_ON_ONCE(cur->unsafe);

IMHO, it is not completely clear how it is guranteed that cur->unsafe
could never be set at this point. It works because:

  1. The previous owner would never release the lock in unsafe region.

  2. cur->unsafe might be set also because of cur->unsafe_takeover
     but this is checked above.

I would personally use the following comment:

		/*
		 * The lock should have never been released in an unsafe
		 * region.
		 */
		WARN_ON_ONCE(cur->unsafe);

> +
> +		new.atom = cur->atom;
> +		new.prio	= ctxt->prio;
> +		new.req_prio	= NBCON_PRIO_NONE;
> +		new.unsafe	= cur->unsafe_takeover;
> +		new.cpu		= cpu;
> +
> +	} while (!nbcon_state_try_cmpxchg(con, cur, &new));
> +
> +	/* Handover success. This context now owns the console. */
> +
> +	cur->atom = new.atom;
> +
> +	return 0;
> +}

Otherwise, it looks good to me.

Best Regards,
Petr
