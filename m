Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462B57AD93D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbjIYNhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjIYNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:37:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CD83
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:37:07 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695649025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGDSLgZSdKcOXlcPNU3EmTBi5UZKRWa8ZqAxGYScQ7k=;
        b=Jery8T2F2WP7uudy/8tYZzr+//iP/fgJ7SpgOm7Akv5vxNM/jrSid5HZw4g+YdMjJCDoh2
        HVYmebEdU6MvapmloX3U2inF17aN+TRclObm/XHu36J88DX8F6jgj/Pjk0aJAGmiKEGmkN
        Ey8yoKCBsYXMLfNQvyXv7ZjAvj+Rnq5mtWfcgGB+EvXJ2gokUGth6Ok18Rknns4Q/M0aQ9
        XR/xvSfFoIobvBlGt8Vpwyiuj45ZSz50mT4YAV9FTIq5qpqVxREMaHpbNJj78OSMSrym/N
        iPB+PuabumgtfqyhnIwcuztA41P6peeYd18CFoAjoqzFr0a8yJRPQjKg9ZxIiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695649025;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGDSLgZSdKcOXlcPNU3EmTBi5UZKRWa8ZqAxGYScQ7k=;
        b=DBs6vZn2IIgiNt54vyTaseQaWCsU0uI7QLXbWZFgWvsbkrzCkgSniqabEsXRswaJJ0+FOt
        GNtI08x/HgJr5KCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/11] printk: nbcon: Wire up nbcon console
 atomic flushing
In-Reply-To: <ZQ3R4Lz1LHQYsylw@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-7-john.ogness@linutronix.de>
 <ZQ3R4Lz1LHQYsylw@alley>
Date:   Mon, 25 Sep 2023 15:43:03 +0206
Message-ID: <87a5tabchs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22, Petr Mladek <pmladek@suse.com> wrote:
>> Perform nbcon console atomic flushing at key call sites:
>> 
>> nbcon_atomic_exit() - When exiting from the outermost atomic
>> 	printing section.
>
> IMHO, it would not help because it all depends
> whether nbcon_context_try_acquire() succeeds or now, see below.

Sure, but it first attempts a _safe_ flush on all nbcon consoles that
alow it, _then_ it falls back to an _unsafe_ flush (which cannot fail,
but might explode).

>> 	If the priority was NBCON_PRIO_PANIC,
>> 	attempt a second flush allowing unsafe hostile
>> 	takeovers.
>
> I was first scared that this would be called by any printk()
> in panic(). But it seems that nbcon_atomic_exit() is called
> only one after disabling printk(). It might deserve a comment
> where it is supposed to be used. See a proposal below.

OK.

>> console_flush_on_panic() - Called from several call sites to
>> 	trigger ringbuffer dumping in an urgent situation.
>> 
>> console_flush_on_panic() - Typically the panic() function will
>
> This is a second description of console_flush_of_panic() which
> looks like a mistake.

Oops. The first one should not be there.

>> 	take care of atomic flushing the nbcon consoles on
>> 	panic. However, there are several users of
>> 	console_flush_on_panic() outside of panic().
>
> The generic panic() seems to use console_flush_on_panic() correctly
> at the very end.
>
> Hmm, I see that console_flush_on_panic() is called also in

[...]

> Anyway, we should make clear that console_flush_on_panic() might break
> the system and should be called as the last attempt to flush consoles.
> The above arch-specific users are worth review.

In an upcoming series you will see that console_flush_on_panic() only
takes the console lock if there are legacy consoles. Ideally, eventually
there will only be nbcon consoles, so your concern would disappear.

And if those users continue to use legacy consoles, then the risks will
be the same as now.

>>   * Return:	The previous priority that needs to be fed into
>>   *		the corresponding nbcon_atomic_exit()
>>   * Context:	Any context. Disables migration.
>> + *
>> + * When within an atomic printing section, no atomic printing occurs. This
>> + * is to allow all emergency messages to be dumped into the ringbuffer before
>> + * flushing the ringbuffer.
>
> The comment sounds like it is an advantage. But I think that it would be
> a disadvantage.

Please explain. At LPC2022 we agreed it was an advantage and it is
implemented on purpose using the atomic printing sections.

> Fortunately, this is not true. Even the atomic context tries
> to flush the messages immediately when it is able to get
> the per-cpu lock. It happes via console_flush_all() called
> from console_unlock().

You are talking about legacy consoles.

The goal of the nbcon consoles is to introduce a _new_ console type to
support controlled decisions for emergency printing. Legacy consoles
will continue to work (or not work) as before.

>> @@ -1130,8 +1135,13 @@ void nbcon_atomic_exit(enum nbcon_prio prio, enum nbcon_prio prev_prio)
>>  {
>>  	struct nbcon_cpu_state *cpu_state;
>>  
>> +	__nbcon_atomic_flush_all(false);
>
> IMHO, this would not help. Either this context was able to acquire the
> lock and flush each message directly.

What do you mean by "help"? We are exiting an atomic printing
section. This is where the accumulated emergency messages are to be
printed. If this is a nested atomic printing section, it does nothing
because the outermost atomic printing section will flush.

> Or it would fail to get the lock even here.

If it fails to get the lock, we are talking about the worst case
scenario. That scenario demands unsafe printing, which is only allowed
in panic. If we are not in panic, it is assumed the current owner will
take care of it.

>> +
>>  	cpu_state = nbcon_get_cpu_state();
>>  
>> +	if (cpu_state->prio == NBCON_PRIO_PANIC)
>> +		__nbcon_atomic_flush_all(true);
>
> It would deserve a comment that nbcon_atomic_exit() is used
> in panic() to calm down the consoles completely, similar effect
> as setting the variable "suppress_printk".

Actually, it is nbcon_atomic_enter() that does the calming down, but
only for the emergency CPU. Other CPUs are allowed to print as wildly as
they want. And all CPUs are allowed to continue to fill the ringbuffer.

@suppress_printk is quite different as it globally blocks any new
messages from being stored into the ringbuffer. This is not calming down
the consoles, but rather putting a finite limit on what they produce.

>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index 6ef33cefa4d0..419c0fabc481 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -3159,6 +3159,8 @@ void console_flush_on_panic(enum con_flush_mode mode)
>>  		console_srcu_read_unlock(cookie);
>>  	}
>>  
>> +	nbcon_atomic_flush_all();
>> +
>>  	console_flush_all(false, &next_seq, &handover);
>
> It seems that console_flush_all() tries to flush nbcon conosoles
> as well. And nbcon_atomic_flush_all() is explicitely called
> close above this flush_on_panic(). This is from panic()
> after this patchset is applied.
>
>
> void panic(const char *fmt, ...)
> {
> [...]
> 	nbcon_atomic_flush_all();
>
> 	console_unblank();
>
> 	/*
> 	 * We may have ended up stopping the CPU holding the lock (in
> 	 * smp_send_stop()) while still having some valuable data in the console
> 	 * buffer.  Try to acquire the lock then release it regardless of the
> 	 * result.  The release will also print the buffers out.  Locks debug
> 	 * should be disabled to avoid reporting bad unlock balance when
> 	 * panic() is not being callled from OOPS.
> 	 */
> 	debug_locks_off();
> 	console_flush_on_panic(CONSOLE_FLUSH_PENDING);
>
>
> By other words, we try to flush nbcon consoles 3 times almost
> immediately after each other.

"Almost immediately" != "immediately". Keep in mind that this is in
atomic printing context. Generally speaking, no messages will be seen on
the consoles yet. Anytime time there is a signficant piece (such as
console_unblank()) it would probably be wise to flush.

We will probably want even more flush points. But I wanted to at least
start with the risky points (such as console_unblank() when legacy
consoles still exist).

> It would deserve some comment what is the purpose. Otherwise, people
> would tend to remove the "redundant" calls.

OK.

>> @@ -3903,6 +3905,10 @@ void defer_console_output(void)
>>  
>>  void printk_trigger_flush(void)
>>  {
>> +	migrate_disable();
>> +	nbcon_atomic_flush_all();
>> +	migrate_enable();
>
> Can this be actually called in NMI?

No. I need to add in_nmi() checks.

>>  	defer_console_output();
>>  }
>
> This function would deserve some description because it looks strange.
> There are three names which are contradicting each other:
>
>   + trigger_flush:    it sounds like it tells someone to do the flush
>
>   + nbcon_atomic_flush_all: does the flush immediately
>
>   + defer_console_output: sounds like it prevents the current context
> 	to flush the consoles immediately

Agreed.

> We should either choose better names and/or add comments:
>
> /**
>  * console_flush_or_trigger() - Make sure that the consoles will get flushed.
>  *
>  * Try to flush consoles when possible or queue flushing consoles like
>  * in the deferred printk.
>  *
>  * Context: Can be used in any context (including NMI?)
>  */
> void printk_flush_or_trigger(void)
> {
> 	/*
> 	 * Try to flush consoles which do not depend on console_lock()
> 	 * and support safe atomic_write()
> 	 */
 	if (!in_nmi()) migrate_disable();
> 	nbcon_atomic_flush_all();
 	if (!in_nmi()) migrate_enable();
>
> 	/* Try flushing legacy consoles or queue the deferred handling. */
> 	if (!in_nmi() && console_trylock())
> 		console_unlock();
> 	else
> 		defer_console_output();
> }

I would be OK with this name and (fixed up for NMI) implementation.

> All in all. I feel a bit overwhelmed by the many *flush*() functions at
> the moment. Some flush only nbcon consoles. Some flush all. Some
> are using only the safe takeover/handover and some allow also
> harsh takeover. Some ignore port->lock because of bust_spinlock().
> Some are ignoring console_lock. They are called on different
> locations. The nbcon variants are called explicitly and also
> inside the generic *flush*() functions.

Agreed. This madness exists in part because we are continuing to support
legacy consoles. I tried to keep the two separate as much as
possible. But when it comes to flushing, there will be some overlap.

When working on the code, I tend to either look at the legacy consoles
_or_ the nbcon consoles. If you try to visualize the whole picture on a
system with legacy and nbcon consoles, it is a bit overwhelming. I
recommend focussing on them separately. I.e. when talking about nbcon
consoles, there is no reason to be concerned about the state of the
console lock or the port lock. When talking about legacy consoles, there
is no reason to be concerned about CPU atomic printing states.

John
