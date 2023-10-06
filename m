Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039967BBC29
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjJFPxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232754AbjJFPxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:53:00 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF41B6
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:52:58 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 499A62185C;
        Fri,  6 Oct 2023 15:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696607577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yI6spWpx3F/LtFc0h5Tns0DBbE8oo/pO119sC13dWN4=;
        b=esqlHLFs6HxfWLWdl6zwkp8MYvoYYcqVdzAaEcz3t7n7cCIeS0UolZ8vqP76SfFtPkfu9t
        EC8t5c4/lOnAyFJ+Yp19tYywoiEFwzV8DexdYoBNGQO1CF35NnGrAb/IwWJSD9xHMUKRrI
        ogaBynIS1WivEnQ+jjROCduz0RbVsEs=
Received: from suse.cz (pmladek.udp.ovpn1.nue.suse.de [10.163.31.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 99FB62C142;
        Fri,  6 Oct 2023 15:52:56 +0000 (UTC)
Date:   Fri, 6 Oct 2023 17:52:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 04/11] printk: nbcon: Provide functions to mark
 atomic write sections
Message-ID: <ZSAtV2d9WAGdBhBS@alley>
References: <ZRGvn4m2NGCn3Pef@alley>
 <87h6n5teos.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6n5teos.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-10-05 14:57:47, John Ogness wrote:
> On 2023-09-25, Petr Mladek <pmladek@suse.com> wrote:
> > From my POV:
> >
> >    + It did not mention/explained "atomic write" at all
> 
> Agreed.
> 
> >    + It said that the urgent messages required immediate printing.
> >      And Later, it said that they would get flushed later. Which
> >      is contradicting each other.
> 
> I agree that the wording needs to be dramatically improved. The term
> "urgent message" was not meant to represent a single printk() call.
> 
> >    + The handling of priorities is not only about CPU nesting.
> >      The same rules should apply also when other CPU is printing
> >      messages in a higher priority context.
> 
> Sorry, I do not understand what you mean here. Each CPU is responsible
> for its own state. If another CPU is in a higher priority state, that
> CPU will be responsible for ensuring its own WARN/OOPS is stored and
> flushed.

You are right that my comment was confusing. I had in mind that
flushing one emergency context would flush all pending messages
from other CPUs and even from other emergency context. Your
explanation is better.

> (From v2 I see that the CPU does not try hard enough. I would
> fix that for v3.)

Yes, this should be fixed.

> There are 3 different types of priority:
> 
> 1. The printk record priority: KERN_ERR, KERN_WARNING, etc.
> 
> 2. The priority of a console owner: used for controlled takeovers.
> 
> 3. The priority state of a CPU: only elevated for urgent messages, used
> to store all urgent messages and then afterwards print directly by
> taking ownership of consoles.

I know that the you want to distinguish 2. and 3. But I think that
they should be the same. I mean that nbcon_context_try_acquire()
should use the PRIO according to what context it is in.

Is there any situation where it should be different, please?

IMHO, it might simplify some logic when they are the same.

> I need to choose terminology carefully to make it easy to distinguish
> between these 3 types. v2 failed to name, describe, and document this
> correctly.

> >   + We must somewhere explain the "atomic context" and "atomic_write".
> >     callback. One important question is why it is atomic. Is it because it
> >
> >       + _can_ be called in atomic context?
> >       + _must_ be called in atomic context?
> 
> Its main reason for existing is because it can be called from atomic
> (including NMI) contexts. But like atomic_t, it can be used from any
> context.
> 
> >     It is called also from console_unlock() for boot messages
> >     so it need not be in atomic context.
> >
> >     What about renaming it to "nbcon_write" to avoid this confusion?
> 
> When we introduce the threads, there will be a 2nd callback (currently
> planned write_thread()). This callback is guaranteed to be called from a
> printing kthread, which for console drivers like fbcon will prove to be
> helpful in cleaning up its code.

I see.

> I will reserve the word "atomic" _only_ when talking about which
> printing callback is used. That should help to avoid associating the
> callback with a certain context or priority. But I think the name
> "write_atomic" is appropriate.

Sounds good.

> >> The "nesting" array is needed in order to support a feature that is not
> >> explained in the commit message: If nested OOPS/WARN/PANIC occur, only
> >> the outermost OOPS/WARN/PANIC will do the flushing. I will add this
> >> information to the commit message.
> >
> > What is the motivation for the feature, please?
> 
> During the demo at LPC2022 we had the situation that there was a large
> backlog when a WARN was hit. With current mainline the first line of the
> WARN is put into the ringbuffer and then the entire backlog is flushed
> before storing the rest of the WARN into the ringbuffer. At the time it
> was obvious that we should finish storing the WARN message and then
> start flushing the backlog.

This talks about contenxt using NBCON_PRIO_EMERGENCY. I am pretty sure
that we want to flush the messages synchronously from printk() in
panic(). Let's discuss this in the other thread with Linus in Cc [1].

> > My proposal:
> >
> > There are only two higher priority contexts:
> >
> >   + NBCON_PRIO_PANIC should be used when panic_cpu == raw_smp_processor_id()
> 
> This is the case with v2.

Ah, I see, nbcon_atomic_enter(NBCON_PRIO_PANIC) is called right after
setting panic_cpu. But this is actually another reason to get rid
of the nbcon_atomic_enter() call why?

  + The information about entering context with NBCON_PRIO_PANIC is
    already provided by panic_cpu variable.

  + Nesting is not possible because only one one context is allowed
    to acquire panic_cpu.

  + nbcon_atomic_exit() is almost useless because it is called only
    in one code path. Explicit nbcon_atomic_flush_all() calls
    are needed in other code paths.

IMHO, getting rid of nbcon_atomic_enter(NBCON_PRIO_PANIC) would have
several advantages:

  + enter()/exit() API would be needed only for NBCON_PRIO_EMERGENCY.
    We could call it nbcon_emergency_enter()/exit() and avoid
    the confusing atomic_enter name.

  + Nesting is important only for NBCON_PRIO_EMERGENCY context =>
    the per-CPU variable might be a simple refecence counter =>
    easier code and no need to remember the previous value
    and pass it to _exit() as a parameter.

> >   + NBCON_PRIO_EMERGENCY contex would require some enter/exit wrappers
> >     and tracking. But it does not necessarily need to be per-CPU
> >     variable.
> <
> > I think about adding "int printk_state" into struct task_struct.
> > It might be useful also for other things, e.g. for storing the last
> > log level of non-finished message. Entering section with enforced
> > minimal loglevel or so.
> 
> printk() calls are quite rare. And warning states are even more
> rare. IMHO adding such a field to every task is a huge price to
> pay. Also, printk operates in non-task contexts (hardirq, nmi). Although
> @current probably points to something existing, there could be some
> tricky corner cases.

Fair enough. Per-CPU variables are fine after all.

> My proposal:
> 
> You have provided excellent feedback regarding naming and
> documentation. Allow me to fix these things to clarify the various
> functions and their roles.

We should first agree on the approach in panic() in the other thread [1].

IMHO, the context using NBCON_PRIO_EMERGENCY should be the only one
where we need enter/exit and the deferred flush. In this case,
the per-CPU variable would be a simple nesting counter. And maybe
the explicit flush would be needed only in emergency context.
=> easier code, logic, naming.

[1] https://lore.kernel.org/r/ZSADUKp8oJ2Ws2vC@alley

Best Regards,
Petr
