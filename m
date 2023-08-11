Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB027790E0
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 15:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjHKNhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 09:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjHKNhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 09:37:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B695AED
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 06:37:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6A6712185F;
        Fri, 11 Aug 2023 13:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691761028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=33V9JKQgva1bUx3HYWfm/I9OGbPbmPqi29loTrpJgWA=;
        b=N8kmNFQTiUGrZU52LMEARkbbVH3quedixUlnoMMSfVxfSxNCFu72UVr7R1nax7QT6DpiOW
        h5FhF14IYJuWUu+Doyvzsp7uutdp1q/2mn9LL5Y1DMOUKhKNZINrZniI3R5JGF6Tom1x/W
        gDNR01Od+fq86jvaU4Rok18hSqDHXI4=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0AB542C142;
        Fri, 11 Aug 2023 13:37:07 +0000 (UTC)
Date:   Fri, 11 Aug 2023 15:37:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 7/8] printk: nbcon: Add emit function and
 callback function for atomic printing
Message-ID: <ZNY5gPNyyw9RTo4X@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-8-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-8-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:32, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Implement an emit function for nbcon consoles to output printk
> messages. It utilizes the lockless printk_get_next_message() and
> console_prepend_dropped() functions to retrieve/build the output
> message. The emit function includes the required safety points to
> check for handover/takeover and calls a new write_atomic callback
> of the console driver to output the message. It also includes
> proper handling for updating the nbcon console sequence number.
> 
> A new nbcon_write_context struct is introduced. This is provided
> to the write_atomic callback and includes only the information
> necessary for performing atomic writes.
> 
> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -761,6 +787,99 @@ static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
>  	return true;
>  }
>  
> +/**
> + * nbcon_emit_next_record - Emit a record in the acquired context
> + * @wctxt:	The write context that will be handed to the write function
> + *
> + * Return:	True if the state is correct. False if ownership was
> + *		handed over or taken.

The meaning of "True if the state is correct" is not clear. I would
write something like:

 * Return:	True if this context still owns the console. False
 *		if the ownership has been handed over or taken.


> + *
> + * When this function returns false then the calling context is no longer
> + * the owner and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context. If the caller
> + * wants to do more it must reacquire the console first.
> + *
> + * When true is returned, @wctxt->ctxt.backlog indicates whether there are
> + * still records pending in the ringbuffer,
> + */
> +__maybe_unused
> +static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
> +{
> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
> +	struct console *con = ctxt->console;
> +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
> +	struct printk_message pmsg = {
> +		.pbufs = ctxt->pbufs,
> +	};
> +	unsigned long con_dropped;
> +	struct nbcon_state cur;
> +	unsigned long dropped;
> +	bool done;
> +
> +	ctxt->backlog = printk_get_next_message(&pmsg, ctxt->seq, is_extended, true);
> +	if (!ctxt->backlog)
> +		return true;
> +
> +	/*
> +	 * @con->dropped is not protected in case of hostile takeovers. In
> +	 * that situation the update can be racy so annotate it accordingly.
> +	 */
> +	con_dropped = data_race(READ_ONCE(con->dropped));
> +
> +	dropped = con_dropped + pmsg.dropped;
> +	if (dropped && !is_extended)
> +		console_prepend_dropped(&pmsg, dropped);
> +
> +	/* Safety point. Do not touch state in case of takeover. */
> +	nbcon_state_read(con, &cur);
> +	if (!nbcon_context_can_proceed(ctxt, &cur))
> +		return false;
> +
> +	/* For skipped records just update seq/dropped in @con. */
> +	if (pmsg.outbuf_len == 0)
> +		goto update_con;
> +
> +	/* Set the write context before calling write callback. */
> +	wctxt->hostile_unsafe = cur.hostile_unsafe;

Is there any reason why wctxt need to know about cur.hostile_usafe?
Will it use another console->*write*() callback or so?
Or will it do another decision based on this value?

My concern is that this value could change anytime. If we
copy this value then it might get out-of_date easily.

When thinking more about it. The value should be the same as long
as this context owns the console. If we really need to have
the value in struct nbcon_wctxt then we should set it when
the structure is initialized under the lock.

Honestly, it looks weird to set it in nbcon_emit_next_record().
It looks like a random place to me. And it means the value is
invalid before nbcon_emit_next_record() was called.
Do we guarantee that it won't be used in other code paths?


> +	wctxt->len = pmsg.outbuf_len;
> +	if (wctxt->len)
> +		wctxt->outbuf = &pmsg.pbufs->outbuf[0];

These two values are actually well defined for each wctxt.
It depends where nbcon_emit_next_record() is called from.
It might be:

  + console_unlock => the global "pbufs"
  + kthread or emergency printk() => con->pbufs
  + panic() => panic_nbcon_pbufs()

IMHO, the value should stay the same as long as the context
is used/exists.


It might make sense to do initialization of these values
with some actions. wxtxt might be initialized:

   + when defined according to the context where
     it is defined.

   + when ctxt is acquired if the values might change
     according to the current state of the system.

   + before each con->*write*() when the values
     might change even when the context is still
     acquired.


Important:

      All the above ideas and concers come to my head because
      I do not know the full context in which the API will
      be used. I see only the pieces that will be later
      put together.

      I could live with this code when this is the only
      location where the values are set and used. We could
      clean up the logic later when I see the entire puzzle.

      This "detail" most likely is not worth delaying
      the entire patchset. This probably fails into
      the category "perfection is enemy of good".

> +	else
> +		wctxt->outbuf = NULL;

It looks weird to call con->write_atomic() when outbuf() is NULL.
It actually could never happen because of the above used:

	if (pmsg.outbuf_len == 0)
		goto update_con;


> +	if (con->write_atomic) {
> +		done = con->write_atomic(con, wctxt);
> +	} else {
> +		nbcon_context_release(ctxt);
> +		WARN_ON_ONCE(1);
> +		done = false;
> +	}
> +
> +	/* If not done, the emit was aborted. */
> +	if (!done)
> +		return false;
> +
> +	/*
> +	 * Since any dropped message was successfully output, reset the
> +	 * dropped count for the console.
> +	 */
> +	dropped = 0;
> +update_con:
> +	if (dropped != con_dropped) {
> +		/* Counterpart to the READ_ONCE() above. */
> +		WRITE_ONCE(con->dropped, dropped);
> +	}

I would personally call nbcon_seq_try_update(ctxt) before
updating con->dropped.

If we are not able to udpate con->dropped then the current owner
will see the same lost messages. Or it is a REPLY_ALL in which
case the number is misleading anyway.

That said, both ways are racy. And it is not worth too big
complexity.

> +	ctxt->seq = pmsg.seq + 1;
> +	if (!nbcon_seq_try_update(ctxt)) {
> +		/* This context probably lost ownership. Check. */
> +		return nbcon_can_proceed(wctxt);
> +	}

I can't imagine a valid situation where nbcon_seq_try_update(ctxt)
fails and we could continue. If this happened then it would be
suspicious.

I would do:


	/*
	 * Since any dropped message was successfully output, reset the
	 * dropped count for the console.
	 */
	dropped = 0;

update_con:
	ctxt->seq = pmsg.seq + 1;
	if (!nbcon_seq_try_update(ctxt) {
		/*
		 * Anyone else manipulated the sequnce number.
		 * It should not happen without loosing access
		 * to the console.
		 */
		if (!nbcon_can_proceed(wctxt)
			return false;
		WARN_ON_ONCE(1);
	}

	if (dropped != con_dropped) {
		/* Counterpart to the READ_ONCE() above. */
		data_race(WRITE_ONCE(con->dropped, dropped));
	}

> +
> +	return true;
> +}
> +
>  /**
>   * nbcon_init - Initialize the nbcon console specific data
>   * @con:	Console to initialize
> -- 
> 2.39.2
