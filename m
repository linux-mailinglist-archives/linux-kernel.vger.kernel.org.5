Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C6793E30
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:58:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241335AbjIFN6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFN55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:57:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE5710F5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:57:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 6D3BD22302;
        Wed,  6 Sep 2023 13:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1694008668; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7OA73ODeuzanjyJ7EdEc/ybpFb3Wkpfax58iwx/ejk=;
        b=JLreQiKBrnJ/262TLjvojvwGvo+cWAQJRs44luEzvaAIzVPfuA1+463ffos5L9Mxzoqe2V
        42gufn4LdhH526Cl18Dq8jGQEZtYK4cIlRZdn/bQJCI3E5JoMl6oBMdAUeufe3/STv381+
        D7aBgwOUWISJ07jSjegKjASgCwBZTFk=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1E7D22C142;
        Wed,  6 Sep 2023 13:57:48 +0000 (UTC)
Date:   Wed, 6 Sep 2023 15:57:47 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 4/7] printk: nbcon: Add ownership state
 functions
Message-ID: <ZPiFW6H-umxxB4CE@alley>
References: <20230903150539.245076-1-john.ogness@linutronix.de>
 <20230903150539.245076-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230903150539.245076-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-09-03 17:11:36, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Provide functions that are related to the safe handover mechanism
> and allow console drivers to dynamically specify unsafe regions:
> 
>  - nbcon_context_can_proceed()
> 
>    Invoked by a console owner to check whether a handover request
>    is pending or whether the console has been taken over by another
>    context. If a handover request is pending, this function will
>    also perform the handover, thus cancelling its own ownership.
> 
>  - nbcon_context_update_unsafe()
> 
>    Invoked by a console owner to denote that the driver is about
>    to enter or leave a critical region where a take over is unsafe.
>    This function is also a cancellation point where loss of
>    ownership can occur.
> 
>    The unsafe state is stored in the console state and allows a
>    new context to make informed decisions whether to attempt a
>    takeover of such a console. The unsafe state is also available
>    to the driver so that it can make informed decisions about the
>    required actions and possibly take a special emergency path.
> 
> Co-developed-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> Signed-off-by: Thomas Gleixner (Intel) <tglx@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

See one comment below.

> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -518,6 +517,112 @@ static void nbcon_context_release(struct nbcon_context *ctxt)
>  	ctxt->pbufs = NULL;
>  }
>  
> +/**
> + * nbcon_context_can_proceed - Check whether ownership can proceed
> + * @ctxt:	The nbcon context from nbcon_context_try_acquire()
> + * @cur:	The current console state
> + *
> + * Return:	True if this context still owns the console. False if
> + *		ownership was handed over or taken.
> + *
> + * Must be invoked after the record was dumped into the assigned buffer
> + * and at appropriate safe places in the driver.
> + *
> + * When this function returns false then the calling context no longer owns
> + * the console and is no longer allowed to go forward. In this case it must
> + * back out immediately and carefully. The buffer content is also no longer
> + * trusted since it no longer belongs to the calling context.
> + */
> +static bool nbcon_context_can_proceed(struct nbcon_context *ctxt, struct nbcon_state *cur)
> +{
> +	unsigned int cpu = smp_processor_id();
> +
> +	/* Make sure this context still owns the console. */
> +	if (!nbcon_owner_matches(cur, cpu, ctxt->prio))
> +		return false;
> +
> +	/* The console owner can proceed if there is no waiter. */
> +	if (cur->req_prio == NBCON_PRIO_NONE)
> +		return true;
> +
> +	/*
> +	 * A console owner within an unsafe region is always allowed to
> +	 * proceed, even if there are waiters. It can perform a handover
> +	 * when exiting the unsafe region. Otherwise the waiter will
> +	 * need to perform an unsafe hostile takeover.
> +	 */
> +	if (cur->unsafe)
> +		return true;
> +
> +	/* Waiters always have higher priorities than owners. */
> +	WARN_ON_ONCE(cur->req_prio <= cur->prio);
> +
> +	/*
> +	 * Having a safe point for take over and eventually a few
> +	 * duplicated characters or a full line is way better than a
> +	 * hostile takeover. Post processing can take care of the garbage.
> +	 * Release and hand over.
> +	 */
> +	nbcon_context_release(ctxt);
> +
> +	/*
> +	 * It is not known whether the handover succeeded. The outermost

It was not immediately clear to me what exactly "handover succeeded" did mean.
I would write:

	* It is not clear whether the waiter really took the lock
	* and re-printed the record. The outermost calsite...

> +	 * callsite has to make the final decision whether printing
> +	 * should proceed or not (via reacquire, possibly hostile). The
> +	 * console is now unlocked so go back all the way instead of
> +	 * trying to implement heuristics in tons of places.
> +	 */
> +	return false;
> +}

Best Regards,
Petr
