Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 437BA7C0105
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbjJJQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjJJQCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:02:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542F8B9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:02:45 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696953761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Rn5Os1D6mbuIatFwguyX+3/LudvCCUS08zsghsg2yU=;
        b=flyvWYxF6QixzAxq8OaXHWfBr2icL73xA8nmgYR4T3mYDseJc97PUXgW1uS1kwYet3QwRQ
        6Q1AKo71jvLGT9m4cRgm2lgciywjNGz8oSpGMIwd2CIDfWi6ZLN9DH4P9jN5WI7oEkfHDm
        pHrjGLKOdSgMkVrqmAEPHo87nDQ8352N/SMQ2cPEJ36E4IcFBSNR/pQ4XZtoey+/rXsw9J
        JXd223dgv8xKfk3tftTKKD2ccGKUE5HKD6POOoMrBt5dN9TYBlwSYwn7OVPvsB+5IDMs4A
        VN0Ac7HUYe5mU3tGS94eqhj2ag/lm/bjbKd7Hdb5L2ZcI0X/35saoLLW5p8fbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696953761;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+Rn5Os1D6mbuIatFwguyX+3/LudvCCUS08zsghsg2yU=;
        b=kFzw+JYJPlK+uVCbLEFFt7QtPU4rNwqdykm69ZKpGVpXY0YKUtzD7Kx7hM0RPMvKmWqSlX
        gZQ+QcTddQsbG5Dg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Linus Torvalds <torvalds@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
In-Reply-To: <ZSQc8ApLjlUpe80o@alley>
References: <ZRGvn4m2NGCn3Pef@alley> <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley> <87il7hv2v2.fsf@jogness.linutronix.de>
 <ZSQc8ApLjlUpe80o@alley>
Date:   Tue, 10 Oct 2023 18:08:40 +0206
Message-ID: <874jiy8nz3.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-09, Petr Mladek <pmladek@suse.com> wrote:
> We really have to distinguish emergency and panic context!

OK.

>> The LPC2022 demo/talk was recorded:
>> 
>> https://www.youtube.com/watch?v=TVhNcKQvzxI
>> 
>> At 55:55 is where the situation occurred and triggered the conversation,
>> ultimately leading to this new feature.
>
> Thanks for the link. My understanding is that the following scenario
> has happened:
>
> 1. System was booting and messages were being flushed using the kthread.
>
> 2. WARN() happened. It printed the 1st line, took over the per-console
>    console lock and started flushing the backlog. There were still
>    many pending messages from the boot.
>
> 3. NMI came and caused panic(). The panic context printed its first line,
>    took over the console from the WARN context, flushed the rest
>    of the backlog and continued printing/flushing more messages from
>    the panic() context.
>
>
> Problem:
>
> People complained that they saw only the first line from WARN().
> The related detailed info, including backtrace, was missing.
>
> It was because panic() interrupted WARN() before it was able
> to flush the backlog and print/flush all WARN() messages.

Thanks for taking the time to review it in detail.

> Proposed solution:
>
> WARN()/emergency context should first store the messages and
> flush them at the end.
>
> It would increase the chance that all WARN() messages will
> be stored in the ring buffer before NMI/panic() is called.
>
> panic() would then flush all pending messages including
> the stored WARN() messages.

OK.

> Important:
>
> The problem is that panic() interrupted WARN().

Ack.

>> You may also want to reread my summary:
>>
>> https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de
>
> Again, thanks for the pointer. Let me paste 2 paragraphs here:
>
> <paste>
> - Printing the backlog is important! If some emergency situation occurs,
>   make sure the backlog gets printed.
>
> - When an emergency occurs, put the full backtrace into the ringbuffer
>   before flushing any backlog. This ensures that the backtrace makes it
>   into the ringbuffer in case a panic occurs while flushing the backlog.
> </paste>
>
> My understanding is:
>
> 1st paragraph is the reason why:
>
>    + we have three priorities: normal, emergency, panic
>
>    + messages in normal context might be offloaded to kthread
>
>    + emergency and panic context should try to flush the messages
>      from this context.
>
>
> 2nd paragraph talks about that emergency context should first store
> the messages and flush them later. And the important part:
>
>      "in case a panic occurs while flushing the backlog.
>
>      => panic might interrupt emergency
>
> It clearly distinguishes emergency and panic context.
>
>
>> as well as Linus' follow-up message:
>> 
>> https://lore.kernel.org/lkml/CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com
>
> IMHO, the important part is:
>
> <paste>
> Yeah, I really liked the notion of doing the oops with just filling
> the back buffer but still getting it printed out if something goes
> wrong in the middle.
> </paste>
>
> He was talking about oops => emergency context
>
> Also he wanted to get it out when something goes wrong in the middle
>    => panic in the middle ?
>
>
> And another paragraph:
>
> <paste>
> I doubt it ends up being an issue in practice, but basically I wanted
> to just pipe up and say that the exact details of how much of the back
> buffer needs to be flushed first _could_ be tweaked if it ever does
> come up as an issue.
> </paste>
>
> Linus had doubts that there might be problems with too long backlog
> in practice. And I have the doubts as well.
>
> And this is my view. The deferred flush is trying to solve a corner
> case and we are forgetting what blocked printk kthreads >10 years.

OK. Thank you for the detailed analysis.

For v3 I will do something similar to what you proposed [0], except that
I will use a per-cpu variable (to track printk emergency nesting)
instead of adding a new field to the task struct.

John Ogness

[0] https://lore.kernel.org/lkml/ZRLBxsXPCym2NC5Q@alley/
