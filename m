Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628667AEB8F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjIZLep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbjIZLek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:34:40 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE82E10E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 04:34:32 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 68C7D21857;
        Tue, 26 Sep 2023 11:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695728071; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=st5BNw7K4yGiN/VpqqgBm7geCu8TMuOpnD9++GzYwQ8=;
        b=oD0SwkL5UOwOgmmF8SrCH01KlQ3IutFtBUlRuVLk4hABjPOKHNYdpsLtaUM4MuXm9a4tZS
        iTGN1uqAuU6BEMrYcdHvcQdTcr2MT1Ze2iHq9noteUMKz9LY7g7oj9cpD5woAgvQE+Vq8/
        6igvtc3e4j67c1tMLrefOSVKwWIpxkk=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EB0462C142;
        Tue, 26 Sep 2023 11:34:30 +0000 (UTC)
Date:   Tue, 26 Sep 2023 13:34:30 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 07/11] printk: nbcon: Wire up nbcon into
 console_flush_all()
Message-ID: <ZRLBxsXPCym2NC5Q@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919230856.661435-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-09-20 01:14:52, John Ogness wrote:
> In atomic printing sections, the atomic nbcon consoles have
> their own behavior of allowing all urgent messages to be
> stored into the ringbuffer and then flushing afterwards.
> 
> However, the nbcon consoles must also emit messages when not
> within atomic printing sections. For this, the existing
> console_flush_all() function can be used.

I am not sure if I get it correctly. My understanding
of the above two paragraphs is that urgent messages will be
buffered and flushed later while normal messages would
be flushed immediately. This is exactly the opposite
from what I would expect.

My expectations are that printk() would try to flush
also nbcon consoles during early boot when the kthreads
are not available or in the emergency and panic contexts.

Of course, it might fail when the console has another owner
and it has the same or higher priority or when it is in
an unsafe state.

> Provide nbcon_console_emit_next_record(), which acts as the
> nbcon variant of console_emit_next_record(). Call this variant
> within console_flush_all() for nbcon consoles.

  + nbcon_console_emit_next_record()
    + nbcon_atomic_emit_one()
      + nbcon_emit_next_record()
	+ con->write_atomic()

It interleaves API with and without "atomic" in the name.
Also I guess that nbcon_emit_next_record() will be used
in the printk thread in "non-atomic" mode. But I might
be wrong.

The more I think about it the more it looks that the term
"atomic" creates more harm (confusion) than good.

> Note that when in an atomic printing section,
> nbcon_console_emit_next_record() does nothing. This is because
> atomic printing sections will handle the nbcon flushing when
> exiting the outermost atomic printing section.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/internal.h |  2 ++
>  kernel/printk/nbcon.c    | 46 ++++++++++++++++++++++++++++++++++++++++
>  kernel/printk/printk.c   | 26 +++++++++++++++--------
>  3 files changed, 65 insertions(+), 9 deletions(-)
> 
> diff --git a/kernel/printk/internal.h b/kernel/printk/internal.h
> index 6780911fa8f2..a3c6b5ce80e4 100644
> --- a/kernel/printk/internal.h
> +++ b/kernel/printk/internal.h
> @@ -77,6 +77,7 @@ void nbcon_seq_force(struct console *con, u64 seq);
>  bool nbcon_alloc(struct console *con);
>  void nbcon_init(struct console *con);
>  void nbcon_free(struct console *con);
> +bool nbcon_console_emit_next_record(struct console *con);
>  
>  /*
>   * Check if the given console is currently capable and allowed to print
> @@ -131,6 +132,7 @@ static inline void nbcon_seq_force(struct console *con, u64 seq) { }
>  static inline bool nbcon_alloc(struct console *con) { return false; }
>  static inline void nbcon_init(struct console *con) { }
>  static inline void nbcon_free(struct console *con) { }
> +static bool nbcon_console_emit_next_record(struct console *con) { return false; }
>  
>  static inline bool console_is_usable(struct console *con, short flags) { return false; }
>  
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index 82e6a1678363..de473a1003d8 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1017,6 +1017,52 @@ static bool nbcon_atomic_emit_one(struct nbcon_write_context *wctxt)
>  	return prb_read_valid(prb, ctxt->seq, NULL);
>  }
>  
> +/**
> + * nbcon_console_emit_next_record - Print one record for an nbcon console
> + *					in atomic mode

I am completely lost now. The API does not have "atomic" in the
name but it is supposed to be called in the atomic conext whatever
it means.

> + * @con:	The console to print on
> + *
> + * Return:	True if a record could be printed, otherwise false.
> + *
> + * This function is meant to be called by console_flush_all() to atomically
> + * print records on nbcon consoles. Essentially it is the nbcon version of
> + * console_emit_next_record().
> + *
> + * This function also returns false if the current CPU is in an elevated
> + * atomic priority state in order to allow the CPU to get all of the
> + * emergency messages into the ringbuffer first.
> + */
> +bool nbcon_console_emit_next_record(struct console *con)
> +{
> +	struct nbcon_cpu_state *cpu_state;
> +	bool progress = false;
> +
> +	migrate_disable();
> +
> +	cpu_state = nbcon_get_cpu_state();
> +
> +	/*
> +	 * Atomic printing from console_flush_all() only occurs if this
> +	 * CPU is not in an elevated atomic priority state. If it is, the
> +	 * atomic printing will occur when this CPU exits that state. This
> +	 * allows a set of emergency messages to be completely stored in
> +	 * the ringbuffer before this CPU begins flushing.
> +	 */
> +	if (cpu_state->prio <= NBCON_PRIO_NORMAL) {

It does something only when the CPU in "default normal state" or
"explicitely forced normal state" .

Where the "explicitely forced normal" probably happens after
nbcon_atomic_enter(NBCON_PRIO_NORMAL). Do we want anyone call
this? I would expect that the explicit context with direct flush
would be used only for emergency and panic messages.

> +		struct nbcon_write_context wctxt = { };
> +		struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +
> +		ctxt->console	= con;
> +		ctxt->prio	= NBCON_PRIO_NORMAL;
> +
> +		progress = nbcon_atomic_emit_one(&wctxt);
> +	}
> +
> +	migrate_enable();
> +
> +	return progress;
> +}


My proposal:

1. Add the API for entering emergency context and getting the context.
   I have already mentioned this in reply to 4rt patch. Here it is:

/* Allow to enter printk context with emergency prio */
#define PRINTK_STATE_EMERGENCY_MASK		0x000000ff
#define PRINTK_STATE_EMERGENCY_OFFSET		0x00000001

/* Allow unsafe takeover */
#define PRINTK_STATE_ALLOW_UNSAFE_TAKEOVER_BIT	0x00000100

void nbcon_emergency_enter(&printk_state)
{
	*printk_state = current->printk_state;

	WARN_ON_ONCE((*printk_state & PRINTK_STATE_EMERGENCY_MASK) == PRINTK_STATE_EMERGENCY_MASK);

	current->printk_state = *printk_state + PRINTK_STATE_EMERGENCY_OFFSET;
}

void nbcon_emergency_exit(printk_state)
{
	WARN_ON_ONCE(!(current->printk_state & PRINTK_STATE_EMERGENCY_MASK))

	current->printk_state = printk_state;
}

enum nbcon_prio nbcon_get_default_prio(void)
{
	if (panic_cpu == raw_smp_processor_id()
		return NBCON_PANIC_PRIO;

	/* Does current always exist? What about fork? */
	if (current && (current->printk_state && PRINTK_STATE_EMERGENCY_MASK))
		return NBCON_PRIO_EMERGENCY;

	return NBCON_PRIO_NORMAL;
}

/*
 * Extend this by adding a bit which would allow to enable the unsafe
 * takeover.
 */
bool nbcon_is_allowed_unsafe_takeover(void)
{
	bool allow_unsafe_takeover;

	allow_unsafe_takeover = (current->printk_state &
				  PRINTK_STATE_ALLOW_UNSAFE_TAKEOVER_BIT);

	if (allow_unsafe_takeover)
		if (WARN_ON_ONCE(raw_smp_processor_id() != panic_cpu))
			allow_unsafe_takeover - false;

	return allow_hostile_takeover;
}


2. Have a function for emitting a single line in the given write
   context and with already acquired console lock.

   Simply rename the existing:

   nbcon_emit_next_record() -> nbcon_wctxt_emit_next_record_acquired()
    or                      -> nbcon_wctxt_emit_next_record_locked()



3. Add the following APIs

/**
 * nbcon_wctxt_emit_next_record - try to emit next record using the
 *		given write context.
 *
 * @wctxt:			An initialized write context struct to use
 *				for this context
 *
 * Returns false if the given console could not print a record or there are
 * no more records to print, otherwise true.
 */
bool nbcon_wctxt_emit_next_record(struct nbcon_write_context *wctxt)
{
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);

	if (!nbcon_context_try_acquire(ctxt))
		return false;

	if (!nbcon_wctxt_emit_next_record_acquired(wctxt))
		return false;

	nbcon_context_release(ctxt);

	return prb_read_valid(prb, ctxt->seq, NULL);
}

/**
 * nbcon_emit_next_record_no_wait - try to emit next record on the given console
 *				  It will not wait when the console is locked.
 * @con:	The console to print on
 *
 * Return:	True if a record could be printed, otherwise false.
 */
bool nbcon_emit_next_record(struct console *con)
{
	struct nbcon_write_context wctxt = { };
	enum nbcon_prio;
	bool allow_unnsafe_takeover;

	prio = nbcon_get_default_prio();
	allow_unsafe_takeover = nbcon_allowed_unsafe_takeover();

	ctxt->console = con;
	ctxt->prio    = prio;

	return nbcon_wctxt_emit_next_record(wctxt);
}

/* Add to the existing console_flush_all() */
static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handover)
{
[...]
	do {
		any_progress = false;

		cookie = console_srcu_read_lock();
		for_each_console_srcu(con) {
			short flags = console_srcu_read_flags(con);
			u64 printk_seq;
			bool progress;

			if (!console_is_usable(con, flags))
				continue;
			any_usable = true;

+ 			if (flags & CON_NBCON) {
+ 				progress = nbcon_emit_next_record_no_wait(con);
+ 				printk_seq = nbcon_seq_read(con);
			} else {
				progress = console_emit_next_record(con, handover, cookie);
[...]
}

/*
 * Like console_flush_all() but flushing only nbcon consoles.
 *
 * It might be used in console_flush_on_panic()
 * before flushing also legacy consoles.
 */
void nbcon_flush_all(void)
{
	struct nbcon_write_context wctxt = { };
	struct nbcon_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
	struct console *con;
	bool any_progress;
	enum nbcon_prio;
	int cookie;

	prio = nbcon_get_default_prio();
	allow_unsafe_takeover = nbcon_is_allowed_unsafe_takeover();

	do {
		any_progress = false;

		cookie = console_srcu_read_lock();
		for_each_console_srcu(con) {
			short flags = console_srcu_read_flags(con);
			bool progress;

			if (!(flags & CON_NBCON))
				continue;

			if (!console_is_usable(con, flags))
				continue;

			memset(ctxt, 0, sizeof(*ctxt));
			ctxt->console			= con;
			ctxt->spinwait_max_us		= 2000;
			ctxt->prio			= prio;
			ctxt->allow_unsafe_takeover	= allow_unsafe_takeover;

			progress = nbcon_wctxt_emit_next_record(&wctxt);
			if (!progress)
				continue;
			any_progress = true;
		}
		console_srcu_read_unlock(cookie);
	} while (any_progress);
}


void nbcon_flush_on_panic(void)
{
	if (WARN_ON_ONCE(raw_smp_processor_id() != panic_cpu))
		return;

	current->printk_state |= PRINTK_STATE_ALLOW_UNSAFE_TAKEOVER_BIT;

	nbcon_flush_all();

	/*
	 * Maybe we should not clear it. This should be called at
	 * the very end of panic. If we allowed an unsafe takeover once
	 * then we might also keep it allowed.
	 *
	 * Then the additional explicit flushes would not be needed.
	 * I mean the one after "Rebooting in %d seconds.." or
	 * after "---[ end Kernel panic - not syncing.."
	 *
	 * Also it would allow to see messages printed in
	 * emergency_restart().
	 *
	 * By other words. The unsafe flush either worked or not.
	 * It can't be worse when trying more unsafe takeovers.
	 */
	/* current->printk_state &= ~PRINTK_STATE_ALLOW_UNSAFE_TAKEOVER_BIT; */
}

IMHO, this would simplify the API and logic a lot.

Note that all the complexity with different priorities and unsafe
flushes is already handled by nbcon_context_try_acquire(). I do
not see any reason to add yet another logic above.

Also I would prefer to rename

  con->atomic_write()  -> con->nbcon_write()

and get rid of the "atomic" word completely. I know that it was
mentioned during the original session with Linus. But it is just
a name. The behavior is more important. And I think that the word
"atomic" adds quite some confusion and even complexity in this
implementation.

Does it make any sense, please?

Best Regards,
Petr
