Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8915E7AEC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234490AbjIZMO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 08:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjIZMOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 08:14:55 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6E9EB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 05:14:48 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0EC3021836;
        Tue, 26 Sep 2023 12:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695730487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XYXIgN38Y0GdmKnbBuf8KHd79V4STyBCtzwu6CZCTRQ=;
        b=O55PRIhDR0m70UWp1gwXJ1nJyAsfGUKHbm1aRDnh/FeG1QySA1QamiTEkB2EGG8o6ckpd6
        EAGC0NmR1W9Glv67X3e0mzvwRE5jZoONKyAflnyJxs6X0ZFo4JwemNSKXfrX2wPMkVo/IO
        dlKxCGZQJQ+Fa8fuV1wOJSv+fvwK0YA=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A82302C142;
        Tue, 26 Sep 2023 12:14:46 +0000 (UTC)
Date:   Tue, 26 Sep 2023 14:14:46 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 06/11] printk: nbcon: Wire up nbcon console
 atomic flushing
Message-ID: <ZRLLNh4g_BiwxIsA@alley>
References: <20230919230856.661435-1-john.ogness@linutronix.de>
 <20230919230856.661435-7-john.ogness@linutronix.de>
 <ZQ3R4Lz1LHQYsylw@alley>
 <87a5tabchs.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a5tabchs.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-09-25 15:43:03, John Ogness wrote:
> On 2023-09-22, Petr Mladek <pmladek@suse.com> wrote:
> >> console_flush_on_panic() - Called from several call sites to
> >> 	trigger ringbuffer dumping in an urgent situation.
> >> 
> >> console_flush_on_panic() - Typically the panic() function will
> >
> > This is a second description of console_flush_of_panic() which
> > looks like a mistake.
> 
> Oops. The first one should not be there.
> 
> >> 	take care of atomic flushing the nbcon consoles on
> >> 	panic. However, there are several users of
> >> 	console_flush_on_panic() outside of panic().
> >
> > The generic panic() seems to use console_flush_on_panic() correctly
> > at the very end.
> >
> > Hmm, I see that console_flush_on_panic() is called also in
> 
> [...]
> 
> > Anyway, we should make clear that console_flush_on_panic() might break
> > the system and should be called as the last attempt to flush consoles.
> > The above arch-specific users are worth review.
> 
> In an upcoming series you will see that console_flush_on_panic() only
> takes the console lock if there are legacy consoles. Ideally, eventually
> there will only be nbcon consoles, so your concern would disappear.

The legacy consoles have two risk levels:

  1. post->lock is ignored after bust_spinlocks()
  2. even console_lock is ignored in console_flush_on_panic()

The nbcon consoles have only one risk level:

  1. unsafe takeover is allowed

First, I thought that we wanted to allow the unsafe takeover in
console_flush_on_panic(). In that case, this function would
be dangerous even for nbcon consoles.

Now, I remember that we wanted to allow it only before entering
the infinite loop (blinking diodes). In this case,
console_flush_on_panic() would be really safe for nbcon consoles.


> And if those users continue to use legacy consoles, then the risks will
> be the same as now.
> 
> >>   * Return:	The previous priority that needs to be fed into
> >>   *		the corresponding nbcon_atomic_exit()
> >>   * Context:	Any context. Disables migration.
> >> + *
> >> + * When within an atomic printing section, no atomic printing occurs. This
> >> + * is to allow all emergency messages to be dumped into the ringbuffer before
> >> + * flushing the ringbuffer.
> >
> > The comment sounds like it is an advantage. But I think that it would be
> > a disadvantage.
> 
> Please explain. At LPC2022 we agreed it was an advantage and it is
> implemented on purpose using the atomic printing sections.

I am sorry but I do not remember the details. Do you remember
the motivation, please?

In each case, we can't just say that this works by design
because someone somewhere agreed on it. We must explain
why this is better and I do not see it at the moment.

I am terribly sorry if I agreed with this and I disagree now.
I have never been good in life discussion because there is
no enough time to think about all consequences.

Anyway, the proposed behavior (agreed on LPC2022) seems
to contradict the original plan from LPC 2019, see
https://lore.kernel.org/all/87k1acz5rx.fsf@linutronix.de/
Namely:

  --- cut ---
  3. Rather than defining emergency _messages_, we define an emergency
  _state_ where the kernel wants to flush the messages immediately before
  dying. Unlike oops_in_progress, this state will not be visible to
  anything outside of the printk infrastructure.

  4. When in emergency state, the kernel will use a new console callback
  write_atomic() to flush the messages in whatever context the CPU is in
  at that moment. Only consoles that implement the NMI-safe write_atomic()
  will be able to flush in this state.
  --- cut ---

We wanted to flush it ASAP.

I wonder if we discussed some limitations where the messages
could not be flushed immediately. Maybe, we discussed a scenario
when there are many pending messages which would delay
flushing the emergency ones. But we need to flush them anyway.

Now, I do not see any real advantage to first store all messages
and flush them later in the same context.

OK, flushign them immediately might cause delay when flushing the
first emergency one. But storing all might cause overwrinting
the first emergency messages.

I hope that my proposed change would actually make things easier
and will not affect that much the upcoming patchsets.

Best Regards,
Petr
