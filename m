Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CEDB769AEE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjGaPkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbjGaPj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:39:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BC4D8
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 08:39:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1466F221C3;
        Mon, 31 Jul 2023 15:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1690817993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h1MBU5+c7b+1OGxcoKp1LNUC4yJLobKrx6Af8WSH/P4=;
        b=V1i9zyliFpAZCjGYhTzLUaLZ4As0pft61i6UjQvl8T08UZMXh/HsCgY+FQQUgKl32nMeIr
        +qvb2FEpC8ryEoZ/CwuidFOneUVfBoAH+51h8i5fCNl2PNnZ/oNqjmINhCdRAdNU+w9Lb4
        CSNykXbnwj2AzBR8yo00RBzX7gXNVuU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A48192C142;
        Mon, 31 Jul 2023 15:39:52 +0000 (UTC)
Date:   Mon, 31 Jul 2023 17:39:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic
 infrastructure
Message-ID: <ZMfVyOKbYZKG9nUJ@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-2-john.ogness@linutronix.de>
 <ZMPU8YPHzJ8Q2V9W@alley>
 <87o7jv92tt.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7jv92tt.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 22:57:58, John Ogness wrote:
> Hi Petr,
> 
> On 2023-07-28, Petr Mladek <pmladek@suse.com> wrote:
> > The is nice explanation for adding the CON_NBCON, struct nbcon_state,
> > nbcon_init(), nbcon_cleanup() and the API for setting nbcon_state.
> >
> >> Note that nbcon consoles are not able to print simultaneously with
> >> boot consoles because it is not possible to know if they are using
> >> the same hardware. For this reason, nbcon consoles are handled as
> >> legacy consoles as long as a boot console is registered.
> >
> > But the patch does many more "unclear" things and only some are
> > explained by the above paragraph.
> 
> I must admit that this first patch is tricky. I am wiring up printk.c
> for nbcon consoles (consoles that will have threaded printing and their
> own synchronized atomic printing), yet those pieces are not there
> yet. So you end up with a lot of code paths where it seems like there
> are strange NOP paths added.
> 
> However, it is important to understand that those new paths will never
> be taken until actual nbcon consoles exist, which won't be until the end
> of the rework. The motivation for adding the new paths now is to
> demonstrate that we are not breaking any of the legacy stuff.

I know that splitting many changes into pieces is not an easy task.
And I am not sure what is a reasonable approach.

> Would it be a better approach to fully implement nbcon consoles and then
> as a final step wire it into printk.c? That is how we integrated the
> ringbuffer. (Spoiler alert: At the end of the email I decide that this
> is also the way I want to go for nbcon consoles.)

I am not sure how exactly you plan it. From my POV, it is perfectly
fine to prepare the infrastructure for nbcons. I would just add
the nbcon specific handling step by step. There is no need to add
NOP path now when there will be a real code later.

> >> +/*
> >> + * Specifies if the console lock/unlock dance is needed for console
> >> + * printing. If @have_boot_console is true, the nbcon consoles will
> >> + * be printed serially along with the legacy consoles because nbcon
> >> + * consoles cannot print simultaneously with boot consoles.
> >> + */
> >> +#define serialized_printing (have_legacy_console || have_boot_console)
> >
> > "serialized_printing" is a bit ambiguous name. We need serialized
> > printing also in panic(), ...
> >
> > What about?
> >
> > #define have_serialized_console (have_legacy_console || have_boot_console)
> 
> This macro is not about having a serialized console. The first sentence
> in the comment describes it best. It is just to signal if we need to do
> the console lock/unlock dance to generate console output.
> 
> Something like "need_bkl_dance" would be a better name, but it doesn't
> sound very technical.

I see.

Question: Will console_lock() serialize the early-boot handling
	of non-BKL conosles? I mean the direct flush in vprintk_emit().

At lest, the v1 patch set called cons_atomic_flush() in vprintk_emit()
without taking outside console_lock().

If console_lock never serializes non-BKL consoles then I rather would define:

	#define serialized_nbcon (have_nbcon && have_boot_console)
and use:

  + "have_legacy_console" when console lock/unlock dance is neded.

  + "serialize_nbcon" the non-BKL consoles need to be serialized

IMHO, it will be more clear what is going on.

But I might be wrong. Maybe, we should really introduce these
variables in the patchset which would add the corresponding
code paths for non-BKL consoles.

> >> @@ -2955,8 +2975,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
> >>  
> >>  		cookie = console_srcu_read_lock();
> >>  		for_each_console_srcu(con) {
> >> +			short flags = console_srcu_read_flags(con);
> >>  			bool progress;
> >>  
> >> +			/*
> >> +			 * console_flush_all() is only for legacy consoles,
> >> +			 * unless a boot console is registered. See
> >> +			 * serialized_printing for details.
> >> +			 */
> >> +			if ((flags & CON_NBCON) && !have_boot_console)
> >> +				continue;
> >
> > I suggest to:
> >
> >    + Update console_flush_all() description. Mention that it flushes
> >      only serialized consoles
> 
> Agreed. It is only responsible for bkl dance flushing.

Will it flush only legacy consoles? Or will it flush also non-BKL
consoles during the early boot?

> >    + Add a comment into console_init_seq() about that flushing only
> >      serialized consoles is enough. All consoles are serialized
> >      when there is a boot console registered.
> 
> OK.
> 
> >    + (Optional) Rename console_flush_all() to console_flush_all_serialized()
> >      to make it more clear. But the updated comment might be enough.
> 
> I guess "serialized" is not really a good name. I'll think about
> this. But I agree that it should no longer be called
> console_flush_all().

I would call it _legacy() when it will be used only for legacy
consoles.

And somthing like _directly() when it is used for flushing
all consoles directly.

> >    + (Future) Get rid of @bootcon_registered. It seems that
> >      "have_boot_console" would be enough. Well, it should be
> >      done in a separate patch and could be done later.
> 
> Agreed. I will add a patch for this.

Great. Feel free to postpone it.

> >> @@ -3486,6 +3522,15 @@ void register_console(struct console *newcon)
> >>  	newcon->dropped = 0;
> >>  	console_init_seq(newcon, bootcon_registered);
> >>  
> >> +	if (!(newcon->flags & CON_NBCON)) {
> >> +		have_legacy_console = true;
> >> +	} else if (!nbcon_init(newcon)) {
> >> +		goto unlock;
> >
> > In case of err, we should revert the changes done above:
> >
> >   + clear CONSOLE_ENABLED and CON_CONSDEV flags
> >   + call newcon->exit() as a counter part to newcon->setup()
> 
> Agreed. That is a bit ugly. Perhaps I will split nbcon_init() into 2
> pieces. The part that can fail (memory allocation) can happen before
> @newcon is touched. And the part that will always succeed (initializing
> structures and setting the sequence number) can happen here.

Whatever looks reasonable.


> >> @@ -3577,11 +3625,34 @@ static int unregister_console_locked(struct console *console)
> >>  	 */
> >>  	synchronize_srcu(&console_srcu);
> >>  
> >> +	if (console->flags & CON_NBCON)
> >> +		nbcon_cleanup(console);
> >> +
> >>  	console_sysfs_notify();
> >>  
> >>  	if (console->exit)
> >>  		res = console->exit(console);
> >>  
> >> +	/*
> >> +	 * If the current console was a boot and/or legacy console, the
> >> +	 * related global flags might need to be updated.
> >> +	 */
> >> +	if (is_boot_con || is_legacy_con) {
> >> +		bool found_boot_con = false;
> >> +		bool found_legacy_con = false;
> >> +
> >> +		for_each_console(c) {
> >> +			if (c->flags & CON_BOOT)
> >> +				found_boot_con = true;
> >> +			if (!(c->flags & CON_NBCON))
> >> +				found_legacy_con = true;
> >> +		}
> >> +		if (!found_boot_con)
> >> +			have_boot_console = false;
> >> +		if (!found_legacy_con)
> >> +			have_legacy_console = false;
> >> +	}
> >
> > This is a bit racy in situations where this value is checked
> > without the console_list_lock, e.g. in vprintk_emit().
> 
> You are correct. I can move this above the synchronize_srcu(), then
> there are no races because the variables are checked under the
> console_srcu_read_lock. The kthreads won't be started until after the
> synchronize_srcu().

I would rather keep it as it is now. The current version makes sure
that no SRCU walk will see a boot console when "have_boot_console"
is already cleared.

> (Although it wouldn't be an issue anyway if an nbcon
> is simultaneously accessed from a console_unlock context and a kthread
> context. nbcon consoles do not require any serialization.)

Yup.

> >> @@ -3758,7 +3834,12 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
> >>  			 */
> >>  			if (!console_is_usable(c))
> >>  				continue;
> >> -			printk_seq = c->seq;
> >> +
> >> +			if (locked)
> >> +				printk_seq = c->seq;
> >> +			else
> >> +				continue;
> >
> > This is strange. It basically means that __pr_flush() is a NOP when
> > serialized_printing is false.
> 
> But at this point in the rework @serialized_printing can never be
> false. The important thing at this point is that we are not breaking the
> legacy consoles. When @serialized_printing is true, everything works as
> before.

I think that it is wrong even after adding the nbcon check. The code
looks like this at the end of this patchset:

			/*
			 * If consoles are not usable, it cannot be expected
			 * that they make forward progress, so only increment
			 * @diff for usable consoles.
			 */
			if (!console_is_usable(c))
				continue;

			if (flags & CON_NBCON)
				printk_seq = nbcon_seq_read(c);
			else if (locked)
				printk_seq = c->seq;
			else
				continue;

I guess that the "else-continue" path will never happen. But when
it happens then pr_flush() would ignore a usable console and it looks
wrong.


> >> @@ -3893,7 +3975,11 @@ void defer_console_output(void)
> >>  	 * New messages may have been added directly to the ringbuffer
> >>  	 * using vprintk_store(), so wake any waiters as well.
> >>  	 */
> >> -	__wake_up_klogd(PRINTK_PENDING_WAKEUP | PRINTK_PENDING_OUTPUT);
> >> +	int val = PRINTK_PENDING_WAKEUP;
> >> +
> >> +	if (serialized_printing)
> >> +		val |= PRINTK_PENDING_OUTPUT;
> >> +	__wake_up_klogd(val);
> >
> > This would deserve an explanation why PRINTK_PENDING_WAKEUP is enough.
> >
> > I know that it is because it will be done by kthreads. But I know it
> > only because I know the wide context, plans, ...
> 
> Right.
> 
> > I would prefer if we split this patch into two:
> >
> >   + 1st adding the nbcon_state-related API and logic
> >   + 2nd adding have_serialized_console and related stuff
> >
> > The various cases where the have_{legacy,boot,serialized}_console
> > variables are set/used would deserve some explanation. At least, we
> > should mention that they will be handled by a kthread. Some hunks
> > might be even be better moved to a patch adding the alternative code
> > path for threaded/atomic consoles.
> 
> Then perhaps I will remove all changes to printk.c until the end of the
> rework. Only necessary minor changes due to shared code (like making
> shared functions in printk.c non-static) would be made.
> 
> This has the advantage that when I do modify printk.c, I could
> immediately add all explanations about the nbcon threaded and atomic
> paths and they would make sense because you would see the threaded and
> atomic functions being called in those paths.

It looks like a better approach. I hope that it will not add you
too much work. But it will help with the review definitely because
it won't leave these non-answered questions in the common code.

Thanks a lot for the effort.

Best Regards,
Petr
