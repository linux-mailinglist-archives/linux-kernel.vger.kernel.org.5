Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C226752565
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 16:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbjGMOnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 10:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjGMOnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 10:43:24 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE56173F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 07:43:22 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3B9B81F45E;
        Thu, 13 Jul 2023 14:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689259401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FIvh+vVYlNIFwVPxiD9u5KP2JAt5h0oIzAC1ncqL5+k=;
        b=iyJZdUPowQSev+CBq39skUm2Oqi1IcXiRmdA4dGPsEsz0BAARfXkdbQ0XSNxCYPmk6yvfR
        IlEdWJBXImUQLc+wYwFwKCUDVOriy0AoGwlFTL1ocpc60u/wfRE5vUVEkzbYt9MHFLyIf6
        3nnfcfB+VYJfLDPUv5DWBmb2SmxUKhs=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DCE102C142;
        Thu, 13 Jul 2023 14:43:20 +0000 (UTC)
Date:   Thu, 13 Jul 2023 16:43:20 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
Message-ID: <ZLANiK_1YoBu1YpU@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
 <ZK14p-ocWuuHkSAQ@alley>
 <878rbkrg16.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rbkrg16.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2023-07-12 23:17:49, John Ogness wrote:
> On 2023-07-11, Petr Mladek <pmladek@suse.com> wrote:
> > Just to be sure. The semaphore is not NMI safe because even the
> > trylock takes an internal spin lock. Am I right, please?
> 
> Yes, that is one of the reasons. Sergey mentioned another (waking a task
> on up()).

I see.

> > Alternative solution would be to make down_trylock() NMI safe
> > by using raw_spin_trylock_irqsave() for the internal lock.
> 
> NMI contexts are only allowed to take raw spinlocks if those spinlocks
> are only used from NMI context. Otherwise you could have deadlock:
> 
> raw_spin_lock()
> --- NMI ---
> raw_spin_lock()
> 
> Using a trylock does not avoid the deadlock danger.
> 
> > Another question is whether we want to call c->unblank()
> > in NMI even when down_trylock() was NMI safe. It seems that it
> > is implemented only for struct console vt_console_driver.
> > I am pretty sure that it takes more internal locks which
> > are not NMI safe either.
> 
> Yes, it does. As an example, it calls mod_timer(), which is also not NMI
> safe. Clearly the unblank() callback must not be called in NMI context.
> 
> > Finally, it is not only about NMI. Any locks might cause a deadlock
> > in panic() in any context. It is because other CPUs are stopped
> > and might block some locks.
> 
> With the atomic/threaded model this is not true. The port ownership can
> be safely taken over from stopped CPUs.

Right. But it would mean using the special lock also in c->unblank()
code. And it is only tty console which is one of the most complicated
consoles.

> > In my opinion, we should handle c->unblank() in panic() the same way
> > as c->write() in panic().
> 
> I do not agree. Clearly unblank() is not NMI safe. Also, in current
> mainline code, console_unblank() will already give up if the trylock
> failed (rather than ignoring the lock, like write() does). So
> console_unblank() might as well also give up if in NMI context.

You are right.

OK, could we at least improve the commit message, please?

Something like:

<proposal>
console_sem() is not NMI safe even when using down_trylock(). Both
down_trylock() and up() are using an interal spinlock. up() might even
call wake_up_process() with another locks.

It is even worse in the panic() code path where the locks might be blocked
by stopped CPUs.

The sepaphore is used in two code paths, in console_unblank() and when
flushing console messages. On the low level, it is needed when calling
c->unblank() and c->write() callbacks.

Both code paths are not safe in panic() but they are handled differently.
c->unblank() is called only when console_trylock() succeeded. c->write()
is called in console_flush_on_panic() even when console_trylock().
The risk of a deadlock in c->write() callbacks is reduced by using trylock()
for the internal locks when oops_in_progess variable is set.

Reduce the risk of deadlocks caused the console semapthore by:

  + bailing out from console_unblank() in NMI
  + not taking the console_sem() in console_flush_on_panic() at all

Simple removal of console_trylock() in console_flush_on_panic() would
cause that other CPUs might still be able to take it and race.
The problem is avoided by checking panic_in_progress() in console_lock()
and console_trylock(). They will never succeed on non-panic CPUs.

The change is a preparation step for introducing printk kthreads and
atomic console write callbacks. It would make the panic() code path
completely safe for consoles without c->unblank() callback.
</proposal>


Wait, the last paragraph is not true. console_trylock() is still
called in console_unblank() in non-NMI context. But the lock
might be blocked by a stopped CPU.

It can be solved by checking whether there is any registered console
with c->unblank() callback first. As a result, console_trylock()
would be called only when a tty console is registered. The panic() path
really might be completely safe where only safe consoles are
registered.

It would make sense to do separate patch for console_unblank()
and console_flush_on_panic().

Of course, we might also improve console_unblank() later. But I
would still like to improve the commit message. You know, the original
commit title and message is talking about NMI. But the patch
has effects even in non-NMI context.

Best Regards,
Petr
