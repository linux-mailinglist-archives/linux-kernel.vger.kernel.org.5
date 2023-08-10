Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 511DD777475
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234373AbjHJJ3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbjHJJ3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:29:02 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E568268E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 02:28:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id BC2C121854;
        Thu, 10 Aug 2023 09:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691659732; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9W2oEN1zd+AWfeWmkb2J9fV0gmbkf5c8yTWVYmd+rqs=;
        b=sNVzyPRGm305jFA5r83QeVnYA1l0PPSK0sxmjml74gWcM5QNIfnhLG9CwZk2wwYHLjEega
        bwJ/180dbIuiAbjK6jArwFgFkfqY3tebT5kPriAPL716tCMVUohs+vrQRtWe2WKpeer+vq
        YE5eFsCdExVn5OqFKP6OaZX/+tNg1xk=
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 984D22C142;
        Thu, 10 Aug 2023 09:28:52 +0000 (UTC)
Date:   Thu, 10 Aug 2023 11:28:52 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 5/8] printk: nbcon: Add sequence handling
Message-ID: <ZNSt1J5TiRdz9ZPx@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-6-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:30, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add an atomic_long_t field @nbcon_seq to the console struct to
> store the sequence number for nbcon consoles. For nbcon consoles
> this will be used instead of the non-atomic @seq field. The new
> field allows for safe atomic sequence number updates without
> requiring any locking.
> 
> On 64bit systems the new field stores the full sequence number.
> On 32bit systems the new field stores the lower 32 bits of the
> sequence number, which are expanded to 64bit as needed by
> folding the values based on the sequence numbers available in
> the ringbuffer.
> 
> For 32bit systems, having a 32bit representation in the console
> is sufficient. If a console ever gets more than 2^31 records
> behind the ringbuffer then this is the least of the problems.
> 
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3171,8 +3171,27 @@ void console_unblank(void)
>   */
>  void console_flush_on_panic(enum con_flush_mode mode)
>  {
> +	struct console *c;
>  	bool handover;
> -	u64 next_seq;
> +	short flags;
> +	int cookie;
> +	u64 seq;
> +
> +	seq = prb_first_valid_seq(prb);
> +
> +	/*
> +	 * Safely handle the atomic consoles before trying to flush any
> +	 * legacy consoles.
> +	 */

This is a bit weird because the loop below just sets sequence
number for NBCON consoles. But they are not really flushed.

I think that you already agreed with it for v3. But let me mention
it here for completeness.

I would prefer to just add the API and use it later when some
particular action get supported. And the flush could not do
anything until nbcon_write() callback is added.

As is it is now, this patch adds nbcon_read()/write() into random
locations and it is not clear how they will be used and if
it is enough.

That said, it makes sense to update the init() path.


> +	if (mode == CONSOLE_REPLAY_ALL) {
> +		cookie = console_srcu_read_lock();
> +		for_each_console_srcu(c) {
> +			flags = console_srcu_read_flags(c);
> +			if (flags & CON_NBCON)
> +				nbcon_seq_force(c, seq);
> +		}
> +		console_srcu_read_unlock(cookie);
> +	}


>  	if (!serialized_printing)
>  		return;

[...]

> @@ -3829,7 +3846,9 @@ static bool __pr_flush(struct console *con, int timeout_ms, bool reset_on_progre
>  			if (!console_is_usable(c))
>  				continue;
>  
> -			if (locked)
> +			if (flags & CON_NBCON)
> +				printk_seq = nbcon_seq_read(c);
> +			else if (locked)
>  				printk_seq = c->seq;
>  			else
>  				continue;

I think that I mentioned this already in a previous patch. The "else
continue" path is bad. It allows quietly skip messages for classic
consoles when "locked" is false. I know that it should not happen
but...

A solution would be to add WARN_ON_ONCE() before the continue.

> diff --git a/kernel/printk/printk_nbcon.c b/kernel/printk/printk_nbcon.c
> index 39fa64891ec6..8229a0a00d5b 100644
> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -108,6 +108,116 @@ static inline bool nbcon_state_try_cmpxchg(struct console *con, struct nbcon_sta
>  	return atomic_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_state), &cur->atom, new->atom);
>  }
>  
> +/* Convert sequence from u64 to unsigned long. */
> +static inline unsigned long __nbcon_seq_to_stored(u64 full_seq)
> +{
> +	/* On 32bit systems only the lower 32 bits are stored. */
> +	return (unsigned long)full_seq;
> +}
> +
> +/* Convert sequence from unsigned long to u64. */
> +static inline u64 __nbcon_seq_to_full(unsigned long stored_seq)
> +{
> +#ifdef CONFIG_64BIT
> +	return stored_seq;
> +#else
> +	u64 full_seq;
> +	u64 rb_seq;
> +
> +	/*
> +	 * The provided sequence is only the lower 32 bits of the ringbuffer
> +	 * sequence. It needs to be expanded to 64bit. Get the next sequence
> +	 * number from the ringbuffer and fold it.
> +	 */
> +	rb_seq = prb_next_seq(prb);
> +	full_seq = rb_seq - ((u32)rb_seq - stored_seq);
> +
> +	return full_seq;
> +#endif
> +}

I would personally do it this way:

#ifdef CONFIG_64BIT

$define __seq_to_nbcon_seq(seq) seq
$define __nbcon_seq_to_seq(seq) seq

#else /* CONFIG_64BIT */

$define __seq_to_nbcon_seq(seq) ((u32)seq)

static inline u64 __nbcon_seq_to_seq(u32 nbcon_seq)
{
	u64 seq;
	u64 rb_next_seq;

	/*
	 * The provided sequence is only the lower 32 bits of the ringbuffer
	 * sequence. It needs to be expanded to 64bit. Get the next sequence
	 * number from the ringbuffer and fold it.
	 *
	 * Having a 32bit representation in the console is sufficient.
	 * If a console ever gets more than 2^31 records behind
	 * the ringbuffer then this is the least of the problems.
	 *
	 * Also the access to the ring buffer is always safe.
	 */
	 rb_next_seq = prb_next_seq(prb);
	 seq = rb_next_seq - ((u32)rb_next_seq - nbcon_seq);

	return seq;
}

#endif /* CONFIG_64BIT */

It looks more clear to me.

> +
> +/**
> + * nbcon_seq_init - Helper function to initialize the console sequence
> + * @con:	Console to work on
> + *
> + * Set @con->nbcon_seq to the starting record (specified with con->seq).
> + * If the starting record no longer exists, the oldest available record
> + * is chosen. This is because on 32bit systems only the lower 32 bits of
> + * the sequence number are stored. The upper 32 bits are derived from the
> + * sequence numbers available in the ringbuffer.

It makes sense even on 64-bit systems. I would do:

s/This is because on 32bit systems/This is especially important on 32bit systems/


> + *
> + * For init only. Do not use for runtime updates.
> + */
> +static void nbcon_seq_init(struct console *con)
> +{
> +	u64 seq = max_t(u64, con->seq, prb_first_valid_seq(prb));
> +
> +	atomic_long_set(&ACCESS_PRIVATE(con, nbcon_seq), __nbcon_seq_to_stored(seq));
> +
> +	/* Clear con->seq since nbcon consoles use con->nbcon_seq instead. */
> +	con->seq = 0;
> +}

[...]

> +/**
> + * nbcon_seq_try_update - Try to update the console sequence number
> + * @ctxt:	Pointer to an acquire context that contains
> + *		all information about the acquire mode
> + *
> + * Return:	True if the console sequence was updated, false otherwise.
> + *
> + * On 32bit the sequence in con->nbcon_seq is only the lower 32 bits.
> + * Therefore it must be expanded to 64bit upon a failed cmpxchg in
> + * order to correctly verify that the new sequence (ctxt->seq) is
> + * larger.
> + *
> + * In case of fail the console has been likely taken over. However, the
> + * caller must still assume it has ownership and decide how to proceed.
> + */
> +__maybe_unused
> +static bool nbcon_seq_try_update(struct nbcon_context *ctxt)
> +{
> +	struct console *con = ctxt->console;
> +	u64 con_seq = nbcon_seq_read(con);
> +
> +	while (con_seq < ctxt->seq) {

What if anyone called nbcon_seq_force() to reply the entire log
in the meantime?

IMHO, we should remember the original nbcon_seq before
the context handle a line. And this function should update
nbcon_seq only when it has not been changed by other context
in the meantime.

> +		unsigned long seq = __nbcon_seq_to_stored(con_seq);
> +
> +		if (atomic_long_try_cmpxchg(&ACCESS_PRIVATE(con, nbcon_seq), &seq,
> +					    __nbcon_seq_to_stored(ctxt->seq))) {
> +			return true;
> +		}
> +
> +		/* Expand new @seq value for comparing. */
> +		con_seq = __nbcon_seq_to_full(seq);
> +	}
> +	return false;
> +}
> +
>  /**
>   * nbcon_context_try_acquire_direct - Try to acquire directly
>   * @ctxt:		The context of the caller

Best Regards,
Petr
