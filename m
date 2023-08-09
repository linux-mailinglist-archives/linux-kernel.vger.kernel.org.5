Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A106E775F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 14:45:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbjHIMpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 08:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHIMpD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 08:45:03 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C6AB19A1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 05:45:02 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5D43A21836;
        Wed,  9 Aug 2023 12:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691585101; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pZ4GRECkCWju5X/MZmXzV9HITJy/PHZnpRNK78OYstQ=;
        b=N8wWSeXsFs+e0qv40XfAahn3WbDBmrX/ehGsyduyG+vSSUglNROAXGVnrS+eSB4BECdkvz
        gmN+eizo5mSuT/MZsI6T1+nztqIq11+r5sjn51UTxrx32Nau+JyPPXX3gTgc3SikQ7XmTl
        YawxGFB+KDZvTm1WOQ4ZYkQHVk3ExwA=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2D7892C142;
        Wed,  9 Aug 2023 12:45:00 +0000 (UTC)
Date:   Wed, 9 Aug 2023 14:44:56 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: hostile takeover: Re: [PATCH printk v2 3/8] printk: nbcon: Add
 acquire/release logic
Message-ID: <ZNOKSFAGPxYFeeJT@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have actually forgot one thing.

On Fri 2023-07-28 02:08:28, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add per console acquire/release functionality. The console 'locked'
> state is a combination of multiple state fields:
> 
>   - Hostile takeover
> 
>       The new owner takes the console over without 'req_prio'
>       handshake.
> 
>       This is required when friendly handovers are not possible,
>       i.e. the higher priority context interrupted the owning
>       context on the same CPU or the owning context is not able
>       to make progress on a remote CPU.

I always expected that there would be only one hostile takeover.
It would allow to take the lock a harsh way when the friendly
way fails.

> All other policy decisions have to be made at the call sites:
> 
>   - What is marked as an unsafe section.
>   - Whether to spinwait if there is already an owner.
>   - Whether to attempt a hostile takeover when safe.
>   - Whether to attempt a hostile takeover when unsafe.

But there seems to be actually two variants. How they are
supposed to be used, please?

I would expect that a higher priority context would always
be able to takeover the lock when it is in a safe context.

By other words, "hostile takeover when safe" would be
the standard behavior for context with a higher priority.

And if I get it correctly then nbcon_enter_unsafe() returns
"false" when there is a pending request with a higher priority.
And only requests with a higher priority are allowed.

By other words, the difference between normal takeover and
"hostile takeover when safe" is that the 1st one has to
wait until the current owner calls nbcon_enter_unsafe().
But the result is the same. The current owner might
prematurely end after calling nbcon_enter_unsafe().


Maybe, this another relic from the initial more generic approach?


> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -175,13 +175,28 @@ enum cons_flags {
>   * struct nbcon_state - console state for nbcon consoles
>   * @atom:	Compound of the state fields for atomic operations
>   *
> + * @req_prio:		The priority of a handover request
> + * @prio:		The priority of the current usage
> + * @unsafe:		Console is busy in a non takeover region
> + * @hostile_unsafe:	The @unsafe value before a hostile takeover
> + * @cpu:		The CPU on which the owner runs
> + *
>   * To be used for reading and preparing of the value stored in the nbcon
>   * state variable @console.nbcon_state.
> + *
> + * The @prio and @req_prio fields are particularly important to allow
> + * spin-waiting to timeout and give up without the risk of a waiter being
> + * assigned the lock after giving up.
>   */
>  struct nbcon_state {
>  	union {
>  		unsigned int	atom;
>  		struct {
> +			unsigned int prio		:  2;
> +			unsigned int req_prio		:  2;
> +			unsigned int unsafe		:  1;
> +			unsigned int hostile_unsafe	:  1;
> +			unsigned int cpu		: 24;
>  		};
>  	};
>  };
> @@ -194,6 +209,50 @@ struct nbcon_state {
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
> + */
> +enum nbcon_prio {
> +	NBCON_PRIO_NONE = 0,
> +	NBCON_PRIO_NORMAL,
> +	NBCON_PRIO_EMERGENCY,
> +	NBCON_PRIO_PANIC,
> +	NBCON_PRIO_MAX,
> +};
> +
> +struct console;
> +
> +/**
> + * struct nbcon_context - Context for console acquire/release
> + * @console:		The associated console
> + * @spinwait_max_us:	Limit for spinwait acquire
> + * @prio:		Priority of the context
> + * @unsafe:		This context is in an unsafe section

This seems to be an input value for try_acquire(). It is
controversial.

I guess that it removes the need to call nbcon_enter_unsafe()
right after try_acquire_console().

Hmm, this semantic is problematic:

  1. The result would be non-paired enter_unsafe()/exit_unsafe()
     calls.

  2. I would personally expect that this is an output value
     set by try_acquire() so that the context might know
     how it got the lock.

  3. Strictly speaking, as an input value, it would mean that
     try_acquire() is called when the console is in "unsafe" state.
     But the caller does not know in which state the console
     is until it acquires the lock.


> + * @hostile:		Acquire console by hostile takeover
> + * @takeover_unsafe:	Acquire console by hostile takeover even if unsafe
> + */
> +struct nbcon_context {
> +	/* members set by caller */
> +	struct console		*console;
> +	unsigned int		spinwait_max_us;
> +	enum nbcon_prio		prio;
> +	unsigned int		unsafe			: 1;
> +	unsigned int		hostile			: 1;
> +	unsigned int		takeover_unsafe		: 1;
> +};

The names make sense. But there are 4 names used struct nbcon_state
and struct nbcon_context. One is used twice:

   state.unsafe
   state.hostile_unsafe

   ctxt.unsafe
   ctxt.hostile
   ctxt.takeover_unsafe

For me it is not easy to remember which permutation is used where ;-)
It would be easier if we remove the "hostile when safe" variant.
Then 3 variables might be enough. I suggest something like:

  state.unsafe		 Console is busy and takeover is not safe.

  state.unsafe_takeover  A hostile takeover in an unsafe state happened
			 in the past. The console can't be safe until
			 re-initialized.

  ctxt.allow_unsafe_takeover Allow hostile takeover even if unsafe.
			Can be used only with PANIC prio. Might cause
			a system freeze when the console is used later.

Best Regards,
Petr
