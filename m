Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC9BA76773D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 22:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjG1UwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 16:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjG1UwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 16:52:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6196430D3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 13:52:03 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690577521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/uIvs3zEzm8vzx+799L/PLXub+P8a23kCaLRnWmqz/E=;
        b=w6dDhRHJHK2GuTmjni9s+0eMYRTJ0UBVN40GzF3Ir9NcSqcCkg+JOFyIy0ZwbgA5a2y24L
        y22sYIwTAuMKDqGh2xWXgwErSORsTOLM0BpwyvMS0nqYBevDsaL3V9ahh4HsAiu/3ezFcF
        uZoQuGkyVwdpAV/Qx7kSzW0v6inmRfYKrJouoJ4t0zBT6RrR5qV0CeHEk3Y4trcJhDDT2F
        Y5qzmLFk5m8ZwHhIL3/C6FzI55JN8VEV+eiePbxdRfB3+OJCOAYhH3XhMuZwUkwmeNbj4w
        hQHC9JggYUid3kPYIcIrEiJZxzohS/12R8ogcpKOQ5hyeTqLdih1nn2m9pU+iA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690577521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/uIvs3zEzm8vzx+799L/PLXub+P8a23kCaLRnWmqz/E=;
        b=jqvI4K5PAUSDAI70d+GqE8AtFiDQb61iMUfEItnUCqwDXkr2gypWYo52FwL42vI8ikxvvl
        5p/hpnIpq+PVWeBA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic
 infrastructure
In-Reply-To: <ZMPU8YPHzJ8Q2V9W@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-2-john.ogness@linutronix.de>
 <ZMPU8YPHzJ8Q2V9W@alley>
Date:   Fri, 28 Jul 2023 22:57:58 +0206
Message-ID: <87o7jv92tt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On 2023-07-28, Petr Mladek <pmladek@suse.com> wrote:
> The is nice explanation for adding the CON_NBCON, struct nbcon_state,
> nbcon_init(), nbcon_cleanup() and the API for setting nbcon_state.
>
>> Note that nbcon consoles are not able to print simultaneously with
>> boot consoles because it is not possible to know if they are using
>> the same hardware. For this reason, nbcon consoles are handled as
>> legacy consoles as long as a boot console is registered.
>
> But the patch does many more "unclear" things and only some are
> explained by the above paragraph.

I must admit that this first patch is tricky. I am wiring up printk.c
for nbcon consoles (consoles that will have threaded printing and their
own synchronized atomic printing), yet those pieces are not there
yet. So you end up with a lot of code paths where it seems like there
are strange NOP paths added.

However, it is important to understand that those new paths will never
be taken until actual nbcon consoles exist, which won't be until the end
of the rework. The motivation for adding the new paths now is to
demonstrate that we are not breaking any of the legacy stuff.

Would it be a better approach to fully implement nbcon consoles and then
as a final step wire it into printk.c? That is how we integrated the
ringbuffer. (Spoiler alert: At the end of the email I decide that this
is also the way I want to go for nbcon consoles.)

>> +/*
>> + * Specifies if the console lock/unlock dance is needed for console
>> + * printing. If @have_boot_console is true, the nbcon consoles will
>> + * be printed serially along with the legacy consoles because nbcon
>> + * consoles cannot print simultaneously with boot consoles.
>> + */
>> +#define serialized_printing (have_legacy_console || have_boot_console)
>
> "serialized_printing" is a bit ambiguous name. We need serialized
> printing also in panic(), ...
>
> What about?
>
> #define have_serialized_console (have_legacy_console || have_boot_console)

This macro is not about having a serialized console. The first sentence
in the comment describes it best. It is just to signal if we need to do
the console lock/unlock dance to generate console output.

Something like "need_bkl_dance" would be a better name, but it doesn't
sound very technical.

>> @@ -2603,7 +2623,7 @@ void resume_console(void)
>>   */
>>  static int console_cpu_notify(unsigned int cpu)
>>  {
>> -	if (!cpuhp_tasks_frozen) {
>> +	if (!cpuhp_tasks_frozen && serialized_printing) {
>
> It would be worth adding a comment why this does something only when
> serialized_printing is set.

OK.

> My understanding is that others will be handled by the respective
> kthreads which are not blocked by a hotplug of particular CPU.

Correct. This function is only important when the bkl dance is needed
(which is also the only thing this function does).

>> @@ -2955,8 +2975,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>>  
>>  		cookie = console_srcu_read_lock();
>>  		for_each_console_srcu(con) {
>> +			short flags = console_srcu_read_flags(con);
>>  			bool progress;
>>  
>> +			/*
>> +			 * console_flush_all() is only for legacy consoles,
>> +			 * unless a boot console is registered. See
>> +			 * serialized_printing for details.
>> +			 */
>> +			if ((flags & CON_NBCON) && !have_boot_console)
>> +				continue;
>
> I suggest to:
>
>    + Update console_flush_all() description. Mention that it flushes
>      only serialized consoles

Agreed. It is only responsible for bkl dance flushing.

>    + Add a comment into console_init_seq() about that flushing only
>      serialized consoles is enough. All consoles are serialized
>      when there is a boot console registered.

OK.

>    + (Optional) Rename console_flush_all() to console_flush_all_serialized()
>      to make it more clear. But the updated comment might be enough.

I guess "serialized" is not really a good name. I'll think about
this. But I agree that it should no longer be called
console_flush_all().

>    + (Future) Get rid of @bootcon_registered. It seems that
>      "have_boot_console" would be enough. Well, it should be
>      done in a separate patch and could be done later.

Agreed. I will add a patch for this.

>> @@ -3075,6 +3104,9 @@ void console_unblank(void)
>>  	struct console *c;
>>  	int cookie;
>>  
>> +	if (!serialized_printing)
>> +		return;
>
> This looks strange. Even nbcon might need to get unblanked.

Honestly, I never thought that an nbcon console would implement
unblank. I suppose the unblank() callback for nbcon consoles will have
the requirement that it cannot assume it is not also within its write
callbacks.

> But we actually handled this a better way in a previous patch, see
> https://lore.kernel.org/r/20230717194607.145135-3-john.ogness@linutronix.de

I will change it so that nbcon consoles are also allowed to implement
unblank.

>> @@ -3142,6 +3174,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
>>  	bool handover;
>>  	u64 next_seq;
>>  
>> +	if (!serialized_printing)
>> +		return;
>
> Honestly, this does not make much sense. console_flush_on_panic()
> should try to flush all consoles. The kthreads do not work
> in panic().

The atomic console flushing will appear above this statement. But with
this first patch that infrastructure is not in place yet. Keep in mind
that after this patch @serialized_printing will _always_ be true. The
series will gradually insert additional nbcon pieces.

>> @@ -3486,6 +3522,15 @@ void register_console(struct console *newcon)
>>  	newcon->dropped = 0;
>>  	console_init_seq(newcon, bootcon_registered);
>>  
>> +	if (!(newcon->flags & CON_NBCON)) {
>> +		have_legacy_console = true;
>> +	} else if (!nbcon_init(newcon)) {
>> +		goto unlock;
>
> In case of err, we should revert the changes done above:
>
>   + clear CONSOLE_ENABLED and CON_CONSDEV flags
>   + call newcon->exit() as a counter part to newcon->setup()

Agreed. That is a bit ugly. Perhaps I will split nbcon_init() into 2
pieces. The part that can fail (memory allocation) can happen before
@newcon is touched. And the part that will always succeed (initializing
structures and setting the sequence number) can happen here.

>> @@ -3577,11 +3625,34 @@ static int unregister_console_locked(struct console *console)
>>  	 */
>>  	synchronize_srcu(&console_srcu);
>>  
>> +	if (console->flags & CON_NBCON)
>> +		nbcon_cleanup(console);
>> +
>>  	console_sysfs_notify();
>>  
>>  	if (console->exit)
>>  		res = console->exit(console);
>>  
>> +	/*
>> +	 * If the current console was a boot and/or legacy console, the
>> +	 * related global flags might need to be updated.
>> +	 */
>> +	if (is_boot_con || is_legacy_con) {
>> +		bool found_boot_con = false;
>> +		bool found_legacy_con = false;
>> +
>> +		for_each_console(c) {
>> +			if (c->flags & CON_BOOT)
>> +				found_boot_con = true;
>> +			if (!(c->flags & CON_NBCON))
>> +				found_legacy_con = true;
>> +		}
>> +		if (!found_boot_con)
>> +			have_boot_console = false;
>> +		if (!found_legacy_con)
>> +			have_legacy_console = false;
>> +	}
>
> This is a bit racy in situations where this value is checked
> without the console_list_lock, e.g. in vprintk_emit().

You are correct. I can move this above the synchronize_srcu(), then
there are no races because the variables are checked under the
console_srcu_read_lock. The kthreads won't be started until after the
synchronize_srcu(). (Although it wouldn't be an issue anyway if an nbcon
is simultaneously accessed from a console_unlock context and a kthread
context. nbcon consoles do not require any serialization.)

>> @@ -3739,13 +3811,17 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>>  	seq = prb_next_seq(prb);
>>  
>>  	for (;;) {
>> +		locked = false;
>>  		diff = 0;
>>  
>> -		/*
>> -		 * Hold the console_lock to guarantee safe access to
>> -		 * console->seq.
>> -		 */
>> -		console_lock();
>> +		if (serialized_printing) {
>> +			/*
>> +			 * Hold the console_lock to guarantee safe access to
>> +			 * console->seq.
>> +			 */
>> +			console_lock();
>> +			locked = true;
>> +		}
>>  
>>  		cookie = console_srcu_read_lock();
>>  		for_each_console_srcu(c) {
>> @@ -3758,7 +3834,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>>  			 */
>>  			if (!console_is_usable(c))
>>  				continue;
>> -			printk_seq = c->seq;
>> +
>> +			if (locked)
>> +				printk_seq = c->seq;
>> +			else
>> +				continue;
>
> This is strange. It basically means that __pr_flush() is a NOP when
> serialized_printing is false.

But at this point in the rework @serialized_printing can never be
false. The important thing at this point is that we are not breaking the
legacy consoles. When @serialized_printing is true, everything works as
before.

>> @@ -3893,7 +3975,11 @@ void defer_console_output(void)
>>  	 * New messages may have been added directly to the ringbuffer
>>  	 * using vprintk_store(), so wake any waiters as well.
>>  	 */
>> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
>> +	int val = PRINTK_PENDING_WAKEUP;
>> +
>> +	if (serialized_printing)
>> +		val |= PRINTK_PENDING_OUTPUT;
>> +	__wake_up_klogd(val);
>
> This would deserve an explanation why PRINTK_PENDING_WAKEUP is enough.
>
> I know that it is because it will be done by kthreads. But I know it
> only because I know the wide context, plans, ...

Right.

> I would prefer if we split this patch into two:
>
>   + 1st adding the nbcon_state-related API and logic
>   + 2nd adding have_serialized_console and related stuff
>
> The various cases where the have_{legacy,boot,serialized}_console
> variables are set/used would deserve some explanation. At least, we
> should mention that they will be handled by a kthread. Some hunks
> might be even be better moved to a patch adding the alternative code
> path for threaded/atomic consoles.

Then perhaps I will remove all changes to printk.c until the end of the
rework. Only necessary minor changes due to shared code (like making
shared functions in printk.c non-static) would be made.

This has the advantage that when I do modify printk.c, I could
immediately add all explanations about the nbcon threaded and atomic
paths and they would make sense because you would see the threaded and
atomic functions being called in those paths.

Taking PREEMPT_RT as an example, the current total remaining rework
diffstat (including this series) for printk.c is:

 kernel/printk/printk.c |  419 ++++++++++++++++++++++++-------
 1 file changed, 329 insertions(+), 90 deletions(-)

And probably that could be split into several patches.

For v3 I will only touch printk.c to expose shared code. (But your
comments are still important because you pointed out several things that
need to be different when I do get around to modifying printk.c.)

John
