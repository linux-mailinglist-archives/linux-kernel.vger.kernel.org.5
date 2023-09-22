Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71697AB22B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 14:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbjIVMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjIVMc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 08:32:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3E3AFB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 05:32:21 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 86D5621ADC;
        Fri, 22 Sep 2023 12:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695385940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oeOQQ3nkdyhP4PFzbKYgbd64o5DYPNwH2DJuLiW3ezU=;
        b=MoM1f/L7jJh3NOj/1dWHrBD3swdpylNWxe4+77i07yX6wdORLRK4SU0Bd8yc88yp1cEDOa
        V9o0zHL136cev7i0glnnkP7oW0BVth1d9IsdsoNE2WJxDENOgOE7YrpCBvpDiKpMuR02i3
        2bNnBfIva00JaT5r+yVn+sMU5YU8Q8E=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2970F2C142;
        Fri, 22 Sep 2023 12:32:20 +0000 (UTC)
Date:   Fri, 22 Sep 2023 14:32:19 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 05/11] printk: nbcon: Provide function for
 atomic flushing
Message-ID: <ZQ2JU9PyZIvu4spa@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:50, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide nbcon_atomic_flush() to perform atomic write flushing
> of all registered nbcon consoles. Like with legacy consoles,
> the nbcon consoles are flushed one record per console. This
> allows all nbcon consoles to generate pseudo-simultaneously,
> rather than one console waiting for the full ringbuffer to
> dump to another console before printing anything.
> 
> Note that if the current CPU is in a nested elevated priority
> state (EMERGENCY/PANIC), nbcon_atomic_flush() does nothing.

This confused me a bit. It was not clear to me if it was
"nested and elevated" or "the elevated priority was nested".
Well, it is probably because I am not a native speaker.

I would describe it another way, see below.

> This is in case the printing itself generates urgent messages
> (OOPS/WARN/PANIC), that those messages are fully stored into
> the ringbuffer before any printing resumes.

This feels like it was an advantage. But I would say that it is
a limitation. IMHO, it simply works this way and we should describe
it as a limitation. See below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -988,6 +986,105 @@ static __ref struct nbcon_cpu_state *nbcon_get_cpu_state(void)
>  	return this_cpu_ptr(&nbcon_pcpu_state);
>  }
>  
> +/**
> + * nbcon_atomic_emit_one - Print one record for a console in atomic mode
> + * @wctxt:			An initialized write context struct to use
> + *				for this context
> + *
> + * Returns false if the given console could not print a record or there are
> + * no more records to print, otherwise true.
> + *
> + * This is an internal helper to handle the locking of the console before
> + * calling nbcon_emit_next_record().
> + */
> +static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +
> +	if (!nbcon_context_try_acquire(ctxt))
> +		return false;
> +
> +	/*
> +	 * nbcon_emit_next_record() returns false when the console was
> +	 * handed over or taken over. In both cases the context is no
> +	 * longer valid.
> +	 */
> +	if (!nbcon_emit_next_record(wctxt))
> +		return false;
> +
> +	nbcon_context_release(ctxt);
> +
> +	return prb_read_valid(prb, ctxt->seq, NULL);

IMHO, it should be enough to check ctxt->backlog. I mean to do:

	return !!ctxt->backlog;

We are here only when nbcon_emit_next_record() owned the context and
was able to call printk_get_next_message(). nbcon_emit_next_record()
and nbcon_atomic_emit_one() would work consistently especially
when prb_read_valid() is not called under the console lock here.


> +}
> +
> +/**
> + * __nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
> + * @allow_unsafe_takeover:	True, to allow unsafe hostile takeovers
> + */
> +static void __nbcon_atomic_flush_all(bool allow_unsafe_takeover)
> +{
> +	struct nbcon_write_context wctxt = { };
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	struct nbcon_cpu_state *cpu_state;
> +	struct console *con;
> +	bool any_progress;
> +	int cookie;
> +
> +	cpu_state = nbcon_get_cpu_state();
> +
> +	/*
> +	 * Let the outermost flush of this priority print. This avoids
> +	 * nasty hackery for nested WARN() where the printing itself
> +	 * generates one and ensures such nested messages are stored to
> +	 * the ringbuffer before any printing resumes.

It is not clear to me what hackery was meant. The fact is that
only printk_once() or WARN_ONCE() should be used in the console
emit/flush code paths. Any non-once printk might block consoles
and even these nesting checks probably would not help much.

Anyway, I believe that we do not need this nesting counter.
The nesting is already prevented by nbcon_context_try_acquire().
It would not allow to take the nested lock with the same priority.

I guess that this extra nesting counter made some sense only in the earlier
variants of the per-cpu console lock.

I would personally just describe the behavior in the commit message
and in the comment above __nbcon_atomic_flush_all():

	* The messages are flushed only when this context is able to
	* get the per-console lock. Namely, it works only when the
	* lock is free or when this context has a higher priority
	* than the current owner.

> +	 *
> +	 * cpu_state->prio <= NBCON_PRIO_NORMAL is not subject to nesting
> +	 * and can proceed in order to allow any atomic printing for
> +	 * regular kernel messages.
> +	 */
> +	if (cpu_state->prio > NBCON_PRIO_NORMAL &&
> +	    cpu_state->nesting[cpu_state->prio] != 1)
> +		return;
> +
> +	do {
> +		any_progress = false;
> +
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(con) {
> +			short flags = console_srcu_read_flags(con);
> +			bool progress;
> +
> +			if (!(flags & CON_NBCON))
> +				continue;
> +
> +			if (!console_is_usable(con, flags))
> +				continue;
> +
> +			memset(ctxt, 0, sizeof(*ctxt));
> +			ctxt->console			= con;
> +			ctxt->spinwait_max_us		= 2000;
> +			ctxt->prio			= cpu_state->prio;
> +			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;
> +
> +			progress = nbcon_atomic_emit_one(&wctxt);
> +			if (!progress)
> +				continue;
> +			any_progress = true;
> +		}
> +		console_srcu_read_unlock(cookie);
> +	} while (any_progress);
> +}
> +
> +/**
> + * nbcon_atomic_flush_all - Flush all nbcon consoles in atomic mode
> + *
> + * Context:	Any context where migration is disabled.

We should make it more clear what migration is meant here. For
example:

 * Context:	Any context which could not be migrated to another CPU.

> + */
> +void nbcon_atomic_flush_all(void)
> +{
> +	__nbcon_atomic_flush_all(false);
> +}
> +

Best Regards,
Petr
