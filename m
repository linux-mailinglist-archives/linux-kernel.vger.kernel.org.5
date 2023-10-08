Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587367BCDC0
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 12:17:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbjJHKNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 06:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjJHKN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 06:13:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 335A2B9
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 03:13:27 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696760005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyfYsQzaOeLTXQBHv3VBHVIY5Xsq/KdLp69dFVT7Uxc=;
        b=B9yMbKj+Ld4oAx8iNBwUTVe9fhZZ9OV/bhBArBYfFcz1cUUc96jT017mfeXCEMYiXEitg7
        r/DW8iwe5KpB1VIS7rGeel0TO014yF/4qFtsO3RokUtFKG5K0uRcOC6PFv/4lEz9CvrOEl
        AZAeDUu8U2nn0MZEn9oYldZE5VeUPYW/m/j9soZiCT9ToNc3BZ7+RCnw+FZAX1RqjVdM58
        WDBejKIYbmwFdYSFIZkztA3w4wMDTXyx8MrkUDzAaBlGXm5UmOvr3TfLHOx7IaGqErPjEH
        lnKIpwYtehNZuTpmLVq0+is/jRqfok+ziHez4H8wFp+rTk8cZNqXeKU/D+EJMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696760005;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IyfYsQzaOeLTXQBHv3VBHVIY5Xsq/KdLp69dFVT7Uxc=;
        b=6Y5TkTky3+TMm/7Vo2O4V7hJ4YfP8LJCRen2M97wkx+dJN9CrkX7j3we+MNj0CuwINs2WE
        Fa03uwJLm/k3Y6DQ==
To:     Petr Mladek <pmladek@suse.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: panic context: was: Re: [PATCH printk v2 04/11] printk: nbcon:
 Provide functions to mark atomic write sections
In-Reply-To: <ZSADUKp8oJ2Ws2vC@alley>
References: <ZRGvn4m2NGCn3Pef@alley> <87h6n5teos.fsf@jogness.linutronix.de>
 <ZSADUKp8oJ2Ws2vC@alley>
Date:   Sun, 08 Oct 2023 12:19:21 +0206
Message-ID: <87il7hv2v2.fsf@jogness.linutronix.de>
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

Hi Petr,

On 2023-10-06, Petr Mladek <pmladek@suse.com> wrote:
>> During the demo at LPC2022 we had the situation that there was a large
>> backlog when a WARN was hit. With current mainline the first line of the
>> WARN is put into the ringbuffer and then the entire backlog is flushed
>> before storing the rest of the WARN into the ringbuffer. At the time it
>> was obvious that we should finish storing the WARN message and then
>> start flushing the backlog.
>
> This talks about the "emergency" context (WARN/OOPS/watchdog).
> The system might be in big troubles but it would still try to continue.
>
> Do we really want to defer the flush also for panic() context?

We can start flushing right after the backtrace is in the
ringbuffer. But flushing the backlog _before_ putting the backtrace into
the ringbuffer was not desired because if there is a large backlog, the
machine may not survive to get the backtrace out. And in that case it
won't even be in the ringbuffer to be used by other debugging
tools.

> I ask because I was not on LPC 2022 in person and I do not remember
> all details.

The LPC2022 demo/talk was recorded:

https://www.youtube.com/watch?v=TVhNcKQvzxI

At 55:55 is where the situation occurred and triggered the conversation,
ultimately leading to this new feature.

You may also want to reread my summary:

https://lore.kernel.org/lkml/875yheqh6v.fsf@jogness.linutronix.de

as well as Linus' follow-up message:

https://lore.kernel.org/lkml/CAHk-=wieXPMGEm7E=Sz2utzZdW1d=9hJBwGYAaAipxnMXr0Hvg@mail.gmail.com

> But it is tricky in panic(), see 8th patch at
> https://lore.kernel.org/r/20230919230856.661435-9-john.ogness@linutronix.de
>
>    + nbcon_atomic_exit() is called only in one code path.

Correct. When panic() is complete and the machine goes into its infinite
loop. This is also the point where it will attempt an unsafe flush, if
it could not get the messages out yet.

>    + nbcon_atomic_flush_all() is used in other paths. It looks like
>      a "Whack a mole" game to me.

Several different outputs occur during panic(). The flush is everywhere
where something significant has been put into the ringbuffer and now it
would be OK to flush it.

>    + messages are never emitted by printk kthread either because
>      CPUs are stopped or the kthread is not allowed to get the lock

Correct.

> I see only one positive of the explicit flush. The consoles would
> not delay crash_exec() and the crash dump might be closer to
> the point where panic() was called.

It's only about getting the critical messages into the ringbuffer before
flushing. And since various things can go wrong during the many actions
within panic(), it makes sense to flush in between those actions.

> Otherwise I see only negatives => IMHO, we want to flush atomic
> consoles synchronously from printk() in panic().
>
> Does anyone really want explicit flushes in panic()?

So far you are the only one speaking against it. I expect as time goes
on it will get even more complex as it becomes tunable (also something
we talked about during the demo).

John
