Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 624D37778E3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbjHJM5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 08:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234086AbjHJM5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 08:57:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FFC5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 05:57:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E746F1F45B;
        Thu, 10 Aug 2023 12:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1691672218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JAHC6dB07bPq5q1OppINIV5WpnpOyXqbN/zghncjI5k=;
        b=oRg9Y9KnpJ6sEmexwRx0igwkd4CjsDtHlmjLw0BZNASP/+dcMrcUhHD6F4f4at5pdfXgz5
        cRwFBr3jx4SzGptgG6BsrFFvVmfZm+GfJJ6B3Vf5rQPHyX9QMVJEGwvmpE1yh77KG9TAAX
        uQYOKJ0r8exXpk6gKacL0SfmMcNDoao=
Received: from suse.cz (dhcp108.suse.cz [10.100.51.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 972C62C142;
        Thu, 10 Aug 2023 12:56:58 +0000 (UTC)
Date:   Thu, 10 Aug 2023 14:56:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 6/8] printk: nbcon: Add ownership state
 functions
Message-ID: <ZNTemiTUI38f11ek@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230728000233.50887-7-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-07-28 02:08:31, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide functions that are related to the safe handover mechanism
> and allow console drivers to dynamically specify unsafe regions:
> --- a/kernel/printk/printk_nbcon.c
> +++ b/kernel/printk/printk_nbcon.c
> @@ -650,6 +649,118 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
>  	ctxt->pbufs = NULL;
>  }
>  
> +/**
> + * nbcon_context_can_proceed - Check whether ownership can proceed
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + * @cur:	The current console state
> + *
> + * Return:	True if the state is correct. False if ownership was
> + *		handed over or taken.
> + *
> + * Must be invoked after the record was dumped into the assigned buffer
> + * and at appropriate safe places in the driver.
> + *
> + * When this function returns false then the calling context is no longer
> + * the owner and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + */
> +static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
> +{
[...]
> +	/*
> +	 * A console owner within an unsafe region is always allowed to
> +	 * proceed, even if there are waiters. It can perform a handover
> +	 * when exiting the unsafe region. Otherwise the waiter will
> +	 * need to perform an unsafe hostile takeover.
> +	 */
> +	if (cur->unsafe) {
> +		debug_store(cur->req_prio > cur->prio,
> +			    "handover: cpu%d IGNORING HANDOVER prio%d -> prio%d (unsafe)\n",
> +			    cpu, cur->prio, cur->req_prio);
> +		return true;
> +	}
[...]
> +}
> +
> +/**
> + * nbcon_context_update_unsafe - Update the unsafe bit in @con->nbcon_state
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + * @unsafe:	The new value for the unsafe bit
> + *
> + * Return:	True if the state is correct. False if ownership was
> + *		handed over or taken.
> + *
> + * Typically the unsafe bit is set during acquire. This function allows
> + * modifying the unsafe status without releasing ownership.
> + *
> + * When this function returns false then the calling context is no longer
> + * the owner and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + *
> + * Internal helper to avoid duplicated code
> + */
> +__maybe_unused
> +static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
> +{
> +	struct console *con = ctxt->console;
> +	struct nbcon_state cur;
> +	struct nbcon_state new;
> +
> +	nbcon_state_read(con, &cur);
> +
> +	/* The unsafe bit must not be cleared if @hostile_unsafe is set. */
> +	if (!unsafe && cur.hostile_unsafe)
> +		return nbcon_context_can_proceed(ctxt, &cur);
> +
> +	do {
> +		if (!nbcon_context_can_proceed(ctxt, &cur))
> +			return false;

nbcon_context_can_proceed() returns "true" even when there
is a pending request. It happens when the current state is "unsafe".
But see below.

> +
> +		new.atom = cur.atom;
> +		new.unsafe = unsafe;
> +	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));

If the new state is "safe" and there is a pending request
then we should release the lock and return false here.

It does not make sense to block the waiter just to realize
that we can't enter "unsafe" state again.

> +	ctxt->unsafe = unsafe;
> +
> +	return true;

An easy solution would be to do here:

	ctxt->unsafe = unsafe;
	return nbcon_context_can_proceed(ctxt, &cur);

> +}

But maybe, we can change the logic a bit. Something like:

/**
 * nbcon_context_update_unsafe - Update the unsafe bit in @con->nbcon_state
 * @ctxt:	The nbcon context from nbcon_context_try_acquire()
 * @unsafe:	The new value for the unsafe bit
 *
 * Return:	True if the state is correct. False if ownership was
 *		handed over or taken.
 *
 * When this function returns false then the calling context is no longer
 * the owner and is no longer allowed to go forward. In this case it must
 * back out immediately and carefully. The buffer content is also no longer
 * trusted since it no longer belongs to the calling context.
 *
 * Internal helper to avoid duplicated code
 */
static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
{
	struct console *con = ctxt->console;
	struct nbcon_state cur;
	struct nbcon_state new;
	bool updated, can_proceed;

	if (!nbcon_context_can_proceed(ctxt, &cur))
		return false;

	/* The unsafe bit must not be cleared if @hostile_unsafe is set. */
	if (cur.hostile_unsafe)
		unsafe = true;

	if (cur.unsafe == unsafe)
		return true;

	do {
		new.atom = cur.atom;
		new.unsafe = unsafe;

		updated = nbcon_state_try_cmpxchg(con, &cur, &new));
		/*
		 * The state has changed. Either there is a new
		 * request lor there was a hostile takeover.
		 */
		can_proceed = nbcon_context_can_proceed(ctxt, &cur);
	} while (!updated && can_proceed);

	if (updated)
		ctxt->unsafe = unsafe;

	return can_proceed;
}

Best Regards,
Petr
