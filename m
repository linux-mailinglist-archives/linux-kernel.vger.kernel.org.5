Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C848B7A7511
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233602AbjITH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjITH6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:58:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CDCE4;
        Wed, 20 Sep 2023 00:58:11 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7540622696;
        Wed, 20 Sep 2023 07:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1695196690; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HhvtpludUjIr++HnR2WYgKkCmY0kr0ew9GoO5GG10A0=;
        b=B1245b9ttuxgIdWWprtAfA6rU3+OR02SOASLM7wuOEHHj8rhAtO8CoZ56Als8UKJBM+TWR
        MO6hVGOSCz7bvFS/nq55lAth6ketQI/xF3e3pNfUEssmMNKyIe2N/pVy1PDBoCJqKbFBY4
        xR3O3LKETqdt52j5zmEq1faOygbg3K8=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 3800D2C142;
        Wed, 20 Sep 2023 07:58:10 +0000 (UTC)
Date:   Wed, 20 Sep 2023 09:58:09 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
Message-ID: <ZQqmEaYeWrurNmGr@alley>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-2-john.ogness@linutronix.de>
 <ZQmvMMRvnUxh1NJn@alley>
 <87msxiuekv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87msxiuekv.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Peter into Cc who also has a big experience with locking APIs.
Well, I think that he would not care ;-)

On Tue 2023-09-19 21:51:12, Thomas Gleixner wrote:
> On Tue, Sep 19 2023 at 16:24, Petr Mladek wrote:
> > On Thu 2023-09-14 20:43:18, John Ogness wrote:
> > IMHO, it would have been better to pass the flags variable directly
> > via a macro as it is done in most *_lock_*_irqsafe() APIs. I mean
> > something like:
> >
> > /**
> >  * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
> >  * @up:		Pointer to UART port structure
> >  * @flags:	Interrupt flags storage
> >  *
> >  * Returns: True if lock was acquired, false otherwise
> >  */
> > #define uart_port_lock_irqsave(up, flags)		\
> > ({							\
> > 	local_irq_save(flags);				\
> > 	uart_port_lock(lock)				\
> > })
> 
> It's worse.
> 
>      1) Macros are not type safe by themself and rely on type safety
>         of the inner workings.
> 
>      2) Macros are bad for grep as you can't search for a 'struct foo *'
>         argument. Even semantic parsers have their problems with macro
>         constructs. I just learned that again when doing this.
> 
>      3) Macros are just horrible to read
> 
>      4) If you want to out of line the wrapper later, then you still
>         have to keep the macro around because the 'flags' argument is by
>         value and not a pointer.
> 
> >From a code generation point of view it's completely irrelevant whether
> you have a macro or an inline. That was different 25 years ago, but who
> cares about museum compilers today.

I probably was not clear enough. The difference and the motivation
is to pass the "flags" variable instead of pointer "*flags".

Both most common APIs, local_irq_save(flags) and
spin_lock_irqsave(lock, flags) pass the variable. Also most
subsystem specific wrappers do so.

IMHO, some consistency makes the life easier for developers,
especially for frequently used API. And the patchset seems to be
adding >350 users of the uart_port_lock_*irqsave() API.

I do not know. Maybe using macros was bad decision for local_irq*()
and spin_lock*() API. Anyway, we are going to live with
the uart_port_lock*() API for a looong time. And I want to be sure
that we do not create (small) headaches for future generations.

OK, maybe this particular difference is not important enough.
As I said, I do not resist on the change.

Best Regards,
Petr
