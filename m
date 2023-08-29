Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA6378C4E7
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232208AbjH2NJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 09:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232374AbjH2NJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:09:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744AA8
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 06:08:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693314534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofy911BTcj4/8yXuWPOvSKBlycNkyG2QcCvwhSrVb/U=;
        b=kkcym89FpipUoaY5cguC31W+ClVgwzEOBnEel58xmog657e+QVk3MQkfuUpFJPgFYcQzXw
        N6bFhQnN/rPi+nNrS5eXsr19rP0VxL8A5zi5oixRy0aw7FDMR3cLASxuoLe4APZXtFkKeg
        Su/lVrsimWfpwI7RIiB9+kJRTLS85QVcSlDnP0yzLc7fYheXmMKjuQbxbiYJ0gLpnb2o9g
        33sp/xAETCdSQnVjr8Kx+Y2Sz1jxltKHBWdBKJFRnbQTvIirYuBy5qRuIViIudooMjOVHm
        EkwsvmFs+YT5FFMz6tAudTyLDAwzR5JjAGgUz4IB6VWJ/BSqIHQ9dzqNBCo0AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693314534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofy911BTcj4/8yXuWPOvSKBlycNkyG2QcCvwhSrVb/U=;
        b=hXdj64BbiB/ICNIZ0vWhKwt4XiWZy1uM4rrgl6jKCZATdn2hRAsfH2DO5FMdugkt9oy7Lf
        GDzeP1V7u91uFwBw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 7/8] printk: nbcon: Add emit function and
 callback function for atomic printing
In-Reply-To: <ZNY5gPNyyw9RTo4X@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-8-john.ogness@linutronix.de>
 <ZNY5gPNyyw9RTo4X@alley>
Date:   Tue, 29 Aug 2023 15:14:53 +0206
Message-ID: <87cyz6ro62.fsf@jogness.linutronix.de>
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

On 2023-08-11, Petr Mladek <pmladek@suse.com> wrote:
>> +static bool nbcon_emit_next_record(struct nbcon_write_context *wctxt)
>> +{
>> +	struct nbcon_context *ctxt = &ACCESS_PRIVATE(wctxt, ctxt);
>> +	struct console *con = ctxt->console;
>> +	bool is_extended = console_srcu_read_flags(con) & CON_EXTENDED;
>> +	struct printk_message pmsg = {
>> +		.pbufs = ctxt->pbufs,
>> +	};
>> +	unsigned long con_dropped;
>> +	struct nbcon_state cur;
>> +	unsigned long dropped;
>> +	bool done;
>> +
>> +	ctxt->backlog = printk_get_next_message(&pmsg, ctxt->seq, is_extended, true);
>> +	if (!ctxt->backlog)
>> +		return true;
>> +
>> +	/*
>> +	 * @con->dropped is not protected in case of hostile takeovers. In
>> +	 * that situation the update can be racy so annotate it accordingly.
>> +	 */
>> +	con_dropped = data_race(READ_ONCE(con->dropped));
>> +
>> +	dropped = con_dropped + pmsg.dropped;
>> +	if (dropped && !is_extended)
>> +		console_prepend_dropped(&pmsg, dropped);
>> +
>> +	/* Safety point. Do not touch state in case of takeover. */
>> +	nbcon_state_read(con, &cur);
>> +	if (!nbcon_context_can_proceed(ctxt, &cur))
>> +		return false;
>> +
>> +	/* For skipped records just update seq/dropped in @con. */
>> +	if (pmsg.outbuf_len == 0)
>> +		goto update_con;
>> +
>> +	/* Set the write context before calling write callback. */
>> +	wctxt->hostile_unsafe = cur.hostile_unsafe;
>
> Is there any reason why wctxt need to know about cur.hostile_usafe?
> Will it use another console->*write*() callback or so?
> Or will it do another decision based on this value?

wctxt exists so that the driver understands its context. If
wctxt->hostile_unsafe is set, the driver knows that an unsafe hostile
takeover took place. This can certainly help the driver to make
decisions about what it wants to do.

> My concern is that this value could change anytime. If we
> copy this value then it might get out-of_date easily.

If this value changes, it means the owner changed. So the driver will
abort due to can_proceed() failing anyway.

> When thinking more about it. The value should be the same as long
> as this context owns the console. If we really need to have
> the value in struct nbcon_wctxt then we should set it when
> the structure is initialized under the lock.

This code _is_ initializing wctxt.

> Honestly, it looks weird to set it in nbcon_emit_next_record().
> It looks like a random place to me. And it means the value is
> invalid before nbcon_emit_next_record() was called.
> Do we guarantee that it won't be used in other code paths?

The wctxt structure only exists to serve the write callback. IMHO
initializing it just before calling the callbacks is the correct
placement.

> It might make sense to do initialization of these values
> with some actions. wxtxt might be initialized:
>
>    + when defined according to the context where
>      it is defined.

This is not appropriate because the same wctxt is recycled for multiple
consoles. (The associated @console is initialized during acquire.)

>    + when ctxt is acquired if the values might change
>      according to the current state of the system.

wctxt->len would still need to be set in nbcon_emit_next_record(). So we
would have multiple locations that are initializing different parts of
wctxt. I would prefer to have all the initialization in one place.

>    + before each con->*write*() when the values
>      might change even when the context is still
>      acquired.

This is how it is in v2. If the state values change, the driver bails
out due to can_proceed() failing.

>> +	else
>> +		wctxt->outbuf = NULL;
>
> It looks weird to call con->write_atomic() when outbuf() is NULL.
> It actually could never happen because of the above used:

Right. I will remove that for v3.

>> +update_con:
>> +	if (dropped != con_dropped) {
>> +		/* Counterpart to the READ_ONCE() above. */
>> +		WRITE_ONCE(con->dropped, dropped);
>> +	}
>
> I would personally call nbcon_seq_try_update(ctxt) before
> updating con->dropped.
>
> If we are not able to udpate con->dropped then the current owner
> will see the same lost messages. Or it is a REPLY_ALL in which
> case the number is misleading anyway.
>
> That said, both ways are racy. And it is not worth too big
> complexity.

I also debated this for a short time. Keep in mind that we are talking
about the following situation:

A context successfully pushed out a dropped message and the printk record.

The race is when the console has a hostile takeover and the new owner
starts printing before or during @dropped and @seq being updated.

As v2 is written, you will see either:

- the dropped message and printk record a second time
- only the printk record a second time

With your suggestion, you will see either:

- the dropped message and printk record a second time
- only the dropped message a second time

IMHO it is better to see the printk record a second time because it
makes it clear that there was a repeat. By seeing only the dropped
message a second time, a user might think that the number of records was
really dropped twice. Also, it is strange to see the dropped message
twice but not the printk record, since the dropped message preceeds the
printk record.

> I can't imagine a valid situation where nbcon_seq_try_update(ctxt)
> fails and we could continue. If this happened then it would be
> suspicious.
>
> I would do:
>
> 	if (!nbcon_seq_try_update(ctxt) {
> 		/*
> 		 * Anyone else manipulated the sequnce number.
> 		 * It should not happen without loosing access
> 		 * to the console.
> 		 */
> 		if (!nbcon_can_proceed(wctxt)
> 			return false;
> 		WARN_ON_ONCE(1);
> 	}

OK.

John
