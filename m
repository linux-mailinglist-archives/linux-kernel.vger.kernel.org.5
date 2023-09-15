Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80B297A2426
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjIORC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIORB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:01:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7BC519BC
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 10:01:50 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694797308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1mScgsqRtsZh1knvFTAiHj57hZ7Ur+YFgcnVaMkleNc=;
        b=qXmXheqC2kPe8n4aEP0cfb/Pr3VjgFc+weiHrQkc3J/YG09EV3w2f3DAPxyUsw8blYN67I
        xh6xzseRqprtmJCknLa7r0PJne3hSXMuTMloKeGn7Yif49aI3sk9bKDJDQe3M1n4E3XQqy
        RXMwqgh5neLAf5uLIEAuSruml6DHnNPkcy7k4e94PX9gUU4zVUZzFVUMPIjXqOkp64Z6zK
        jNE0OlFDaY/7pl3zpc+hE8klbPGeQ4DJlwT3tBQoBxYwszNLgE09pzHLC1JrqzzL2SFLg5
        KIuNmzwfNDUgWG7k621tr3GkQ5ZhRamEoyvmpbF+4EMu61qNtDKh1yhSHHzz1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694797308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1mScgsqRtsZh1knvFTAiHj57hZ7Ur+YFgcnVaMkleNc=;
        b=h4Xh6Ep7KYi7Ouo6573ZXhOci3Ja7fgXG843McCfS6lwSrvWZvGVpFEFIL82x5B1vfzMCD
        dqhhUkeqp2uLGBCQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v4 2+/8] printk: nbcon: Add acquire/release logic
In-Reply-To: <ZQMJZiPgfbIAlVqS@alley>
References: <20230908185008.468566-1-john.ogness@linutronix.de>
 <20230908185008.468566-3-john.ogness@linutronix.de>
 <ZQMHqJaNffsKFymG@alley> <ZQMJZiPgfbIAlVqS@alley>
Date:   Fri, 15 Sep 2023 19:07:43 +0206
Message-ID: <87v8cbv094.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-14, Petr Mladek <pmladek@suse.com> wrote:
> // This patch includes my proposed changes on top of
> // https://lore.kernel.org/all/20230908185008.468566-3-john.ogness@linutronix.de/

The changes in the code are fine. I agree with them and they pass all my
runtime tests. However, there are a couple places where I disagree with
your comments (or lack thereof) and would like to add some
clarification.

Following is your patched version, with my comments inline:

> static int nbcon_context_try_acquire_requested(struct nbcon_context *ctxt,
> 					       struct nbcon_state *cur)
> {
> 	unsigned int cpu = smp_processor_id();
> 	struct console *con = ctxt->console;
> 	struct nbcon_state new;
> 
> 	/* Note that the caller must still remove the request! */
> 	if (other_cpu_in_panic())
> 		return -EPERM;

You have no comments here. The following waiter check is an obvious
check to make. But what I think is not obvious, is that it will also
catch the situation when an unsafe hostile takeover has occurred. (My v4
had an explicit test for that case, but actually it is enough to check
the waiter.) I am adding comments here to mention that.

       /*
        * Note that the waiter will also change if there was an unsafe
        * hostile takeover.
        */

> 	if (!nbcon_waiter_matches(cur, ctxt->prio))
> 		return -EPERM;
> 
> 	/* If still locked, caller should continue waiting. */
> 	if (cur->prio != NBCON_PRIO_NONE)
> 		return -EBUSY;
> 
> 	/*
> 	 * The previous owner should have never released ownership
> 	 * in an unsafe region. And this function should not be
> 	 * called when the 'unsafe_takeover' is set.
> 	 */

The above comment says this function should not be called when
@unsafe_takeover is set. But that can legally occur. While spinning
there is a udelay(1) and then the state is re-read. During the udelay()
an unsafe hostile takeover is allowed to occur. This is another reason
why I wanted to explicitly mention that in the comment above. And I am
removing the 2nd sentence of this comment.

> 	WARN_ON_ONCE(cur->unsafe);

[...]

> static int nbcon_context_try_acquire_handover(struct nbcon_context *ctxt,
> 					      struct nbcon_state *cur)
> {
> 	unsigned int cpu = smp_processor_id();
> 	struct console *con = ctxt->console;
> 	struct nbcon_state new;
> 	int timeout;
> 	int request_err = -EBUSY;
> 
> 	/*
> 	 * Check that the handover is called when the direct acquire failed
> 	 * with -EBUSY.
> 	 */
> 	WARN_ON_ONCE(ctxt->prio <= cur->prio || ctxt->prio <= cur->req_prio);
> 	WARN_ON_ONCE(!cur->unsafe);
> 
> 	/* Handover is not possible on the same CPU. */
> 	if (cur->cpu == cpu)
> 		return -EBUSY;
> 
> 	/*
> 	 * Console stays unsafe after an unsafe takeover until re-initialized.
> 	 * Waiting is not going to help in this case.
> 	 */
> 	if (cur->unsafe_takeover)
> 		return -EBUSY;
> 
> 	/* Is the caller willing to wait? */
> 	if (ctxt->spinwait_max_us == 0)
> 		return -EBUSY;
> 
> 	/*
> 	 * Setup a request for the handover. The caller should try to acquire
> 	 * the conosle directly when the current state has been modified.
> 	 */
> 	new.atom = cur->atom;
> 	new.req_prio = ctxt->prio;
> 	if (!nbcon_state_try_cmpxchg(con, cur, &new))
> 		return -EAGAIN;
> 
> 	cur->atom = new.atom;
> 
> 	/* Wait until there is no owner and then acquire the console. */
> 	for (timeout = ctxt->spinwait_max_us; timeout >= 0; timeout--) {
> 		/* On successful acquire, this request is cleared. */
> 		request_err = nbcon_context_try_acquire_requested(ctxt, cur);
> 		if (!request_err)
> 			return 0;
> 
> 		/*
> 		 * If the acquire should be aborted, it must be ensured
> 		 * that the request is removed before returning to caller.
> 		 */
> 		if (request_err == -EPERM)
> 			break;
> 
> 		udelay(1);
> 
> 		/* Re-read the state because some time has passed. */
> 		nbcon_state_read(con, cur);
> 	}
> 
> 	/* Timed out or aborted. Carefully remove handover request. */
> 	do {
> 		/* No need to remove request if there is a new waiter. */

For me it was not obvious why -EPERM should be returned here. I am
extending this comment to provide some more details that may not be
immediately obvious.

               /*
                * No need to remove request if there is a new waiter. This
                * can only happen if a higher priority context has taken over
                * the console or the handover request.
                */

> 		if (!nbcon_waiter_matches(cur, ctxt->prio))
> 			return -EPERM;

[...]

> static int nbcon_context_try_acquire_hostile(struct nbcon_context *ctxt,
> 					     struct nbcon_state *cur)
> {
> 	unsigned int cpu = smp_processor_id();
> 	struct console *con = ctxt->console;
> 	struct nbcon_state new;
> 
> 	if (!ctxt->allow_unsafe_takeover)
> 		return -EPERM;
> 
> 	/*
> 	 * Check that the system is going to die and lower priorities will
> 	 * always be ignored. Using an unsafe consoles could break the running
> 	 * system. Also switching back to lower priorities would create a race
> 	 * in nbcon_waiter_matches().
> 	 */

Three things about this comment. First, it is not just a "check" but
actually an "enforcement". The if-statement prevents the hostile
takeover from happening.

Second, it mentions that "lower priorities will always be ignored". I
was confused by this because lower priorities are _always_ ignored. Only
higher priorities can ever take over ownership.

Third, it mentions switching back to lower priorities would create races
in nbcon_waiter_matches(). This seems like a strange place to talk about
that race. The comments within nbcon_waiter_matches() talk about why
that race does not exist. The unsafe hostile takeover is not a part of
that explanation.

It should also be clear that after all pending records have been flushed
in panic, the panic CPU _will_ release the console. What will prevent
other CPUs from taking ownership after that is _not_ a PANIC-prio owner
of the console, but rather because it is a panic situation and other
CPUs are not the panic CPU.

I am just simplifying the comment to:

        /* Ensure caller is allowed to perform unsafe hostile takeovers. */

> 	if (WARN_ON_ONCE(ctxt->prio != NBCON_PRIO_PANIC))
> 		return -EPERM;

John Ogness
