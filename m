Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51710766FC1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjG1Or1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236415AbjG1OrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:47:25 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCCB44209
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 07:47:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6C119218BB;
        Fri, 28 Jul 2023 14:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690555637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BN4Hj8me7np93Ru/9pWphgsSs8InjaAU5cjPnqKklyc=;
        b=HLj/1C6o/ii92t3N5jNSeQpyBGHTuQc0suwGRC+nRweHVGho8gwu9k5XCAI7kv3Ch8cDh+
        zUc5koriMqBhXzOoqHoSBhZPyYaK/NUzCFS9MQHPB3ZYPT0Tm6oZPsGLKMOqzgSNfGmg6b
        fZcoKqSsZTZA4MM9X8xrG4/2vH/ah58=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 017D92C142;
        Fri, 28 Jul 2023 14:47:16 +0000 (UTC)
Date:   Fri, 28 Jul 2023 16:47:13 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic
 infrastructure
Message-ID: <ZMPU8YPHzJ8Q2V9W@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:26, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The current console/printk subsystem is protected by a Big Kernel Lock,
> (aka console_lock) which has ill defined semantics and is more or less
> stateless. This puts severe limitations on the console subsystem and
> makes forced takeover and output in emergency and panic situations a
> fragile endeavour that is based on try and pray.
> 
> The goal of non-BKL (nbcon) consoles is to break out of the console lock
> jail and to provide a new infrastructure that avoids the pitfalls and
> allows console drivers to be gradually converted over.
> 
> The proposed infrastructure aims for the following properties:
> 
>   - Per console locking instead of global locking
>   - Per console state that allows to make informed decisions
>   - Stateful handover and takeover
> 
> As a first step, state is added to struct console. The per console state
> is an atomic_t using a 32bit bit field.
> 
> Reserve state bits, which will be populated later in the series. Wire
> it up into the console register/unregister functionality and exclude
> such consoles from being handled in the legacy console mechanisms. Since
> the nbcon consoles will not depend on the console lock/unlock dance
> for printing, only perform said dance if a legacy console is registered.
> 
> The decision to use a bitfield was made as using a plain u32 with
> mask/shift operations turned out to result in uncomprehensible code.

The is nice explanation for adding the CON_NBCON, struct nbcon_state,
nbcon_init(), nbcon_cleanup() and the API for setting nbcon_state.

> Note that nbcon consoles are not able to print simultaneously with boot
> consoles because it is not possible to know if they are using the same
> hardware. For this reason, nbcon consoles are handled as legacy consoles
> as long as a boot console is registered.

But the patch does many more "unclear" things and only some are explained
by the above paragraph.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -442,6 +442,26 @@ static int console_msg_format = MSG_FORMAT_DEFAULT;
>  /* syslog_lock protects syslog_* variables and write access to clear_seq. */
>  static DEFINE_MUTEX(syslog_lock);
>  
> +/*
> + * Specifies if a legacy console is registered. See serialized_printing
> + * for details.
> + */
> +bool have_legacy_console;
> +
> +/*
> + * Specifies if a boot console is registered. See serialized_printing
> + * for details.
> + */
> +bool have_boot_console;
> +
> +/*
> + * Specifies if the console lock/unlock dance is needed for console
> + * printing. If @have_boot_console is true, the nbcon consoles will
> + * be printed serially along with the legacy consoles because nbcon
> + * consoles cannot print simultaneously with boot consoles.
> + */
> +#define serialized_printing (have_legacy_console || have_boot_console)

"serialized_printing" is a bit ambiguous name. We need serialized
printing also in panic(), ...

What about?

#define have_serialized_console (have_legacy_console || have_boot_console)

Or maybe have just this one variable.

> +
>  #ifdef CONFIG_PRINTK
>  DECLARE_WAIT_QUEUE_HEAD(log_wait);
>  /* All 3 protected by @syslog_lock. */
> @@ -2286,7 +2306,7 @@ asmlinkage int vprintk_emit(int facility, int level,
>  	printed_len = vprintk_store(facility, level, dev_info, fmt, args);
>  
>  	/* If called from the scheduler, we can not call up(). */
> -	if (!in_sched) {
> +	if (!in_sched && serialized_printing) {
>  		/*
>  		 * The caller may be holding system-critical or
>  		 * timing-sensitive locks. Disable preemption during
> @@ -2603,7 +2623,7 @@ void resume_console(void)
>   */
>  static int console_cpu_notify(unsigned int cpu)
>  {
> -	if (!cpuhp_tasks_frozen) {
> +	if (!cpuhp_tasks_frozen && serialized_printing) {

It would be worth adding a comment why this does something only when
serialized_printing is set.

My understanding is that others will be handled by the respective
kthreads which are not blocked by a hotplug of particular CPU.


>  		/* If trylock fails, someone else is doing the printing */
>  		if (console_trylock())
>  			console_unlock();
> @@ -2955,8 +2975,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
>  
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(con) {
> +			short flags = console_srcu_read_flags(con);
>  			bool progress;
>  
> +			/*
> +			 * console_flush_all() is only for legacy consoles,
> +			 * unless a boot console is registered. See
> +			 * serialized_printing for details.
> +			 */
> +			if ((flags & CON_NBCON) && !have_boot_console)
> +				continue;

This makes sense when console_flush_all() is called from
console_unlock() but not when it is called from console_init_seq().

Well, it is fine even in console_init_seq() because it is used there
only when there are boot consoles. Except that it checks "bootcon_registered"
instead of "have_boot_console". So that it is far from clear.

I suggest to:

   + Update console_flush_all() description. Mention that it flushes
     only serialized consoles

   + Add a comment into console_init_seq() about that flushing only
     serialized consoles is enough. All consoles are serialized
     when there is a boot console registered.

   + (Optional) Rename console_flush_all() to console_flush_all_serialized()
     to make it more clear. But the updated comment might be enough.

   + (Future) Get rid of @bootcon_registered. It seems that
     "have_boot_console" would be enough. Well, it should be
     done in a separate patch and could be done later.

> +
>  			if (!console_is_usable(con))
>  				continue;
>  			any_usable = true;
> @@ -3075,6 +3104,9 @@ void console_unblank(void)
>  	struct console *c;
>  	int cookie;
>  
> +	if (!serialized_printing)
> +		return;

This looks strange. Even nbcon might need to get unblanked.

I guess that you do this because you want to avoid taking
console_lock() in the panic() when there are not consoles
which would implement unblank().

But we actually handled this a better way in a previous patch, see
https://lore.kernel.org/r/20230717194607.145135-3-john.ogness@linutronix.de

So, I would remove this hunk.

> +
>  	/*
>  	 * First check if there are any consoles implementing the unblank()
>  	 * callback. If not, there is no reason to continue and take the
> @@ -3142,6 +3174,9 @@ void console_flush_on_panic(enum con_flush_mode mode)
>  	bool handover;
>  	u64 next_seq;
>  
> +	if (!serialized_printing)
> +		return;

Honestly, this does not make much sense. console_flush_on_panic()
should try to flush all consoles. The kthreads do not work
in panic().

I guess that the motivation is the same as in console_unblank().
Note that console_lock() has already been removed, see
https://lore.kernel.org/all/20230717194607.145135-5-john.ogness@linutronix.de/

I would remove this hunk as well. Or it would deserve some explanation.

> +
>  	/*
>  	 * Ignore the console lock and flush out the messages. Attempting a
>  	 * trylock would not be useful because:
> @@ -3486,6 +3522,15 @@ void register_console(struct console *newcon)
>  	newcon->dropped = 0;
>  	console_init_seq(newcon, bootcon_registered);
>  
> +	if (!(newcon->flags & CON_NBCON)) {
> +		have_legacy_console = true;
> +	} else if (!nbcon_init(newcon)) {
> +		goto unlock;

In case of err, we should revert the changes done above:

  + clear CONSOLE_ENABLED and CON_CONSDEV flags
  + call newcon->exit() as a counter part to newcon->setup()

> +	}
> +
> +	if (newcon->flags & CON_BOOT)
> +		have_boot_console = true;
> +
>  	/*
>  	 * Put this console in the list - keep the
>  	 * preferred driver at the head of the list.
> @@ -3577,11 +3625,34 @@ static int unregister_console_locked(struct console *console)
>  	 */
>  	synchronize_srcu(&console_srcu);
>  
> +	if (console->flags & CON_NBCON)
> +		nbcon_cleanup(console);
> +
>  	console_sysfs_notify();
>  
>  	if (console->exit)
>  		res = console->exit(console);
>  
> +	/*
> +	 * If the current console was a boot and/or legacy console, the
> +	 * related global flags might need to be updated.
> +	 */
> +	if (is_boot_con || is_legacy_con) {
> +		bool found_boot_con = false;
> +		bool found_legacy_con = false;
> +
> +		for_each_console(c) {
> +			if (c->flags & CON_BOOT)
> +				found_boot_con = true;
> +			if (!(c->flags & CON_NBCON))
> +				found_legacy_con = true;
> +		}
> +		if (!found_boot_con)
> +			have_boot_console = false;
> +		if (!found_legacy_con)
> +			have_legacy_console = false;
> +	}

Just thinking loudly:

This is a bit racy in situations where this value is checked
without the console_list_lock, e.g. in vprintk_emit().

I think that it is actually OK because they are only setting "false".
As a result, other code might try to flush the consoles the serialized
way even when not really needed.

I think that it is a race which we could ignore. The chance is
super-small that it might hit us in the future. (Famous last words :-)


> +
>  	return res;
>  }
>  
> @@ -3730,6 +3801,7 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	struct console *c;
>  	u64 last_diff = 0;
>  	u64 printk_seq;
> +	bool locked;
>  	int cookie;
>  	u64 diff;
>  	u64 seq;
> @@ -3739,13 +3811,17 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  	seq = prb_next_seq(prb);
>  
>  	for (;;) {
> +		locked = false;
>  		diff = 0;
>  
> -		/*
> -		 * Hold the console_lock to guarantee safe access to
> -		 * console->seq.
> -		 */
> -		console_lock();
> +		if (serialized_printing) {
> +			/*
> +			 * Hold the console_lock to guarantee safe access to
> +			 * console->seq.
> +			 */
> +			console_lock();
> +			locked = true;
> +		}
>  
>  		cookie = console_srcu_read_lock();
>  		for_each_console_srcu(c) {
> @@ -3758,7 +3834,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  			 */
>  			if (!console_is_usable(c))
>  				continue;
> -			printk_seq = c->seq;
> +
> +			if (locked)
> +				printk_seq = c->seq;
> +			else
> +				continue;

This is strange. It basically means that __pr_flush() is a NOP when
serialized_printing is false.

We should optimize the console_lock() handling after we implement
the path for nbcons.

In each case, we should not skip any usable console here.

> +
>  			if (printk_seq < seq)
>  				diff += seq - printk_seq;
>  		}
> @@ -3767,7 +3848,8 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  		if (diff != last_diff && reset_on_progress)
>  			remaining = timeout_ms;
>  
> -		console_unlock();
> +		if (locked)
> +			console_unlock();
>  
>  		/* Note: @diff is 0 if there are no usable consoles. */
>  		if (diff == 0 || remaining == 0)
> @@ -3893,7 +3975,11 @@ void defer_console_output(void)
>  	 * New messages may have been added directly to the ringbuffer
>  	 * using vprintk_store(), so wake any waiters as well.
>  	 */
> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
> +	int val = PRINTK_PENDING_WAKEUP;
> +
> +	if (serialized_printing)
> +		val |= PRINTK_PENDING_OUTPUT;
> +	__wake_up_klogd(val);

This would deserve an explanation why PRINTK_PENDING_WAKEUP is enough.

I know that it is because it will be done by kthreads. But I know it
only because I know the wide context, plans, ...

>  }
>  
>  void printk_trigger_flush(void)

I would prefer if we split this patch into two:

  + 1st adding the nbcon_state-related API and logic
  + 2nd adding have_serialized_console and related stuff

The various cases where the have_{legacy,boot,serialized}_console variables are
set/used would deserve some explanation. At least, we should
mention that they will be handled by a kthread. Some hunks might be even
be better moved to a patch adding the alternative code path for
threaded/atomic consoles.

Best Regards,
Petr

PS: I am sorry that I did not comment this in v1. Everything was new
    at that time. And this somehow fallen through cracks.
