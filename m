Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F27AB7DD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjIVRmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjIVRmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:42:01 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58A08F
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:41:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6F50621AC3;
        Fri, 22 Sep 2023 17:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695404513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BMxhWDH6WFeclW/llKs2APNYZz39biXRsfKPOHWHd9w=;
        b=STuqsx9C/WGCOeGsDh1fivUY4spzhnM/36Yu+4XpFFtf1sANq/O2tOXk84AqHjN3Vr2Nlz
        Z8drmhGBXpCay2pPQW+ImgkSzQf3mcOkoFNPaR6THXK4N+J3fXaJpNzbj6Zf33SNkEd54B
        8bNFshPt9+nsH+9XLRZmAQUW9KBWzMQ=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0DD2C2C142;
        Fri, 22 Sep 2023 17:41:52 +0000 (UTC)
Date:   Fri, 22 Sep 2023 19:41:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/11] printk: nbcon: Wire up nbcon console
 atomic flushing
Message-ID: <ZQ3R4Lz1LHQYsylw@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:51, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Perform nbcon console atomic flushing at key call sites:
> 
> nbcon_atomic_exit() - When exiting from the outermost atomic
> 	printing section.

IMHO, it would not help because it all depends
whether nbcon_context_try_acquire() succeeds or now, see below.

> 	If the priority was NBCON_PRIO_PANIC,
> 	attempt a second flush allowing unsafe hostile
> 	takeovers.

I was first scared that this would be called by any printk()
in panic(). But it seems that nbcon_atomic_exit() is called
only one after disabling printk(). It might deserve a comment
where it is supposed to be used. See a proposal below.


> console_flush_on_panic() - Called from several call sites to
> 	trigger ringbuffer dumping in an urgent situation.
> 
> console_flush_on_panic() - Typically the panic() function will

This is a second description of console_flush_of_panic() which
looks like a mistake.

> 	take care of atomic flushing the nbcon consoles on
> 	panic. However, there are several users of
> 	console_flush_on_panic() outside of panic().

The generic panic() seems to use console_flush_on_panic() correctly
at the very end.

Hmm, I see that console_flush_on_panic() is called also in
arch/loongarch/kernel/reset.c and arch/powerpc/kernel/traps.c.

The loongarch code uses it in halt(). IMHO, it would be
better to use the normal flush. But maybe they accept the risk.
I know nothing about this architecture and who uses it.

The function defined on powerpc is then used in:

  + arch/powerpc/platforms/powernv/opal.c:

     IMHO, it should be replaced there by normal flush. It seems
     to call the generic panic() later.

  + arch/powerpc/platforms/ps3/setup.c:

      This seems to be used as a panic notifier ppc_panic_platform_handler().
      I am not completely sure but it does not look like the final flush.

  + arch/powerpc/platforms/pseries/setup.c:

      Same as ps3/setup.c. Also "just" a panic notifier.

Anyway, we should make clear that console_flush_on_panic() might break
the system and should be called as the last attempt to flush consoles.
The above arch-specific users are worth review.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1092,6 +1092,11 @@ void nbcon_atomic_flush_all(void)
>   * Return:	The previous priority that needs to be fed into
>   *		the corresponding nbcon_atomic_exit()
>   * Context:	Any context. Disables migration.
> + *
> + * When within an atomic printing section, no atomic printing occurs. This
> + * is to allow all emergency messages to be dumped into the ringbuffer before
> + * flushing the ringbuffer.

The comment sounds like it is an advantage. But I think that it would be
a disadvantage.

Fortunately, this is not true. Even the atomic context tries
to flush the messages immediately when it is able to get
the per-cpu lock. It happes via console_flush_all() called
from console_unlock().

> + * The actual atomic printing occurs when exiting
> + * the outermost atomic printing section.
>   */
>  enum nbcon_prio nbcon_atomic_enter(enum nbcon_prio prio)
>  {
> @@ -1130,8 +1135,13 @@ void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
>  {
>  	struct nbcon_cpu_state *cpu_state;
>  
> +	__nbcon_atomic_flush_all(false);

IMHO, this would not help. Either this context was able to acquire the
lock and flush each message directly. Or it would fail to get the lock
even here.

> +
>  	cpu_state = nbcon_get_cpu_state();
>  
> +	if (cpu_state->prio == NBCON_PRIO_PANIC)
> +		__nbcon_atomic_flush_all(true);

It would deserve a comment that nbcon_atomic_exit() is used
in panic() to calm down the consoles completely, similar effect
as setting the variable "suppress_printk".

> +
>  	/*
>  	 * Undo the nesting of nbcon_atomic_enter() at the CPU state
>  	 * priority.
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 6ef33cefa4d0..419c0fabc481 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3159,6 +3159,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  		console_srcu_read_unlock(cookie);
>  	}
>  
> +	nbcon_atomic_flush_all();
> +
>  	console_flush_all(false, &next_seq, &handover);

It seems that console_flush_all() tries to flush nbcon conosoles
as well. And nbcon_atomic_flush_all() is explicitely called
close above this flush_on_panic(). This is from panic()
after this patchset is applied.


void panic(const char *fmt, ...)
{
[...]
	nbcon_atomic_flush_all();

	console_unblank();

	/*
	 * We may have ended up stopping the CPU holding the lock (in
	 * smp_send_stop()) while still having some valuable data in the console
	 * buffer.  Try to acquire the lock then release it regardless of the
	 * result.  The release will also print the buffers out.  Locks debug
	 * should be disabled to avoid reporting bad unlock balance when
	 * panic() is not being callled from OOPS.
	 */
	debug_locks_off();
	console_flush_on_panic(CONSOLE_FLUSH_PENDING);


By other words, we try to flush nbcon consoles 3 times almost
immediately after each other. I believe that there is a motivation
to do so. Anyway, I want to make sure that it was on purpose.

It would deserve some comment what is the purpose. Otherwise, people
would tend to remove the "redundant" calls.

>  }
>  
> @@ -3903,6 +3905,10 @@ void defer_console_output(void)
>  
>  void printk_trigger_flush(void)
>  {
> +	migrate_disable();
> +	nbcon_atomic_flush_all();
> +	migrate_enable();

Can this be actually called in NMI?

> +
>  	defer_console_output();
>  }

This function would deserve some description because it looks strange.
There are three names which are contradicting each other:

  + trigger_flush:    it sounds like it tells someone to do the flush

  + nbcon_atomic_flush_all: does the flush immediately

  + defer_console_output: sounds like it prevents the current context
	to flush the consoles immediately

We should either choose better names and/or add comments:

/**
 * console_flush_or_trigger() - Make sure that the consoles will get flushed.
 *
 * Try to flush consoles when possible or queue flushing consoles like
 * in the deferred printk.
 *
 * Context: Can be used in any context (including NMI?)
 */
void printk_flush_or_trigger(void)
{
	/*
	 * Try to flush consoles which do not depend on console_lock()
	 * and support safe atomic_write()
	 */
	migrate_disable();
	nbcon_atomic_flush_all();
	migrate_enable();

	/* Try flushing legacy consoles or queue the deferred handling. */
	if (!in_nmi() && console_trylock())
		console_unlock();
	else
		defer_console_output();
}


All in all. I feel a bit overwhelmed by the many *flush*() functions at
the moment. Some flush only nbcon consoles. Some flush all. Some
are using only the safe takeover/handover and some allow also
harsh takeover. Some ignore port->lock because of bust_spinlock().
Some are ignoring console_lock. They are called on different
locations. The nbcon variants are called explicitly and also
inside the generic *flush*() functions.

It is partly because it is Friday evening. Anyway, I need to think
more about it.

Best Regards,
Petr
