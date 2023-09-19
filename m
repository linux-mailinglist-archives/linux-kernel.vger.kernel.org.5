Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2747A6BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 21:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232991AbjISTvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 15:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbjISTvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 15:51:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA3DC8F;
        Tue, 19 Sep 2023 12:51:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695153073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaZuXVH/yWX2HfqC1wT9oG9U7tC9Fe66Kju6+PemjNE=;
        b=hxH2gWis1h/G6X0KO8PF1cKbP5Ze7IroBs9DlpFMtSTvzIYmZjfGN7d9zGW1rW5aVG5yui
        nH28E1NuEVBsVNK/+KKe/0gXSEYzFyjvqC8pz+ruKv9q2uqUfIvqG6ItSvoUeFbMkwogfc
        nnIavRTX8yo7aflQ9wBxDuv6XOnHTSURJQOAh2mDP6Fn5lmlIs22t2YJynb2cl4jLYtoeD
        i3WzP36kzThI2KBbQDbIcjVYqmMrURmG2r0rZznxyUbTgSlVGGzAKchPM9pgILz6KAUs+j
        e0Wu9ccdMXdpgT2DJXifCQTEJ//D9t6q/1VRN6lmWIPVI3yKNH8CSMejDAPOuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695153073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oaZuXVH/yWX2HfqC1wT9oG9U7tC9Fe66Kju6+PemjNE=;
        b=v7iZwIgVAXht5h0chh0hokvJsE5IDEj70BLcZ5t7baL2FwOEj3NfsQicLMFBYOO48Nv2Hp
        Lzfn7jTNZtHxDfCA==
To:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty v1 01/74] serial: core: Provide port lock wrappers
In-Reply-To: <ZQmvMMRvnUxh1NJn@alley>
References: <20230914183831.587273-1-john.ogness@linutronix.de>
 <20230914183831.587273-2-john.ogness@linutronix.de>
 <ZQmvMMRvnUxh1NJn@alley>
Date:   Tue, 19 Sep 2023 21:51:12 +0200
Message-ID: <87msxiuekv.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 19 2023 at 16:24, Petr Mladek wrote:
> On Thu 2023-09-14 20:43:18, John Ogness wrote:
> IMHO, it would have been better to pass the flags variable directly
> via a macro as it is done in most *_lock_*_irqsafe() APIs. I mean
> something like:
>
> /**
>  * uart_port_trylock_irqsave - Try to lock the UART port, save and disable interrupts
>  * @up:		Pointer to UART port structure
>  * @flags:	Interrupt flags storage
>  *
>  * Returns: True if lock was acquired, false otherwise
>  */
> #define uart_port_lock_irqsave(up, flags)		\
> ({							\
> 	local_irq_save(flags);				\
> 	uart_port_lock(lock)				\
> })

It's worse.

     1) Macros are not type safe by themself and rely on type safety
        of the inner workings.

     2) Macros are bad for grep as you can't search for a 'struct foo *'
        argument. Even semantic parsers have their problems with macro
        constructs. I just learned that again when doing this.

     3) Macros are just horrible to read

     4) If you want to out of line the wrapper later, then you still
        have to keep the macro around because the 'flags' argument is by
        value and not a pointer.

From a code generation point of view it's completely irrelevant whether
you have a macro or an inline. That was different 25 years ago, but who
cares about museum compilers today.

Thanks,

        tglx
