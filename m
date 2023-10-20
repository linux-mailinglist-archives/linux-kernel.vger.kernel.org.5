Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFF927D0B0F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376574AbjJTJCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376554AbjJTJCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:02:52 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4AFD46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:02:50 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:02:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697792567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlWarTiBrVKN0IicVfyeqlDJwebAqfMrHUe7mm3ynGk=;
        b=mBXQMLdZZY2DsaoUkW4yVJ05JdY14sRnFHRhiKCHo9gxrQie010QKeyCv32huN2sy2A2Nb
        D7yMuGZPotIH4soROIIi+yJrLg4A/8+8whQGDgwGHOKGcS6t22ZD+OKac+N0x/24XZULEY
        HTpB1IHZYNeqS8SDJFVowkbfV8fFCD7dqNUWJDuyBWan41HPLyRh5apwEnwJOMSgk/uXN/
        Xmoi0pCZFNRz2P2KpRh2qbZ50B/i/BW5sK/i/RsepQ0Rdg+/tJB9FS2CS80lVrqEYN0xgr
        LoPaW0C/6GuoYYPXXlvlCfUs9e6tagKrULrGuiOFfGkfUSmnBISt67LjMbZ6NQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697792567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AlWarTiBrVKN0IicVfyeqlDJwebAqfMrHUe7mm3ynGk=;
        b=RiZcwS8UDaYLOzEgorSk4g5RyvjO6lUYJxS+DOkNJdg/67+1Wk04U40j/ZwMjBhsgKH+g+
        oEgpxMYpV5LmK+AA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     John Stultz <jstultz@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Stephen Boyd <sboyd@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org
Subject: Re: [PATCH] clocksource: disable irq when holding watchdog_lock.
Message-ID: <20231020090245.cPAViz09@linutronix.de>
References: <80ff5036-8449-44a6-ba2f-0130d3be6b57@I-love.SAKURA.ne.jp>
 <CANDhNCpw+hEHNbtdAZR01HsHW_L1C0BXjZq21eXouQGNnYuUNQ@mail.gmail.com>
 <878r826xys.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <878r826xys.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-16 23:47:55 [+0200], Thomas Gleixner wrote:
>   But the explicit local_irq_disable()/enable() pair around the readout
>   means that the patch above is obviously broken:
> 
>     spin_lock_irqsave(&watchdog_lock, flags);
>     cs_watchdog_read()
>       local_irq_disable();
>       ...
>       local_irq_enable();  <--- FAIL
> 
>   Lockdep should have yelled at that too, but even if it failed to do
>   so then it's still very obviously wrong.

Lockdep will shout from local_irq_enable() if the lock is still held.
That is working and I just verified it. However I didn't get to that
part in cs_watchdog_read() in my testing so that might be why lockdep
didn't complain in Tetsuo's case. After adding a irq-enable before the
unlock for lockdep-testing I did see the splat.

> Something like the uncompiled/untested below should cure it for real. It
> really does not matter whether the TSC unstable event happens a bit
> later. The system is unhappy no matter what.
The snippet below is perfect :)

> That said, this whole clocksource watchdog mess wants a proper
> overhaul. It has become a pile of warts and duct tape by now and after
> staring at it long enough there is no real reason to run it in a timer
> callback anymore. It just can move into delayed work and the whole
> locking problem can be reduced to the clocksource_mutex and some well
> thought out atomic operations to handle the mark unstable case. But
> that's a different story and not relevant for curing the problem at
> hand.

A pile of warts. Okay. This explains why the lock is acquired everywhere
with irqsave while in-IRQ access is not desired.

> Thanks,
> 
>         tglx

Sebastian
