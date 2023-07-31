Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEC576A210
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjGaUjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 16:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbjGaUjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 16:39:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761861BCF
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 13:39:05 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690835943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aXZQTsMiC63g2UstCGyW0ZPrqeg5a29N7/rbS4gUX0=;
        b=uvmHYaMxDIpydrhcn2USjKudVJPgjhgSTzRoo46MGI9Cl/ChQvrkp1Y3jHGwLAQiKSWGv4
        YOmCbTUx9HTIlxQLZoQXUdF7NHlcVq0MseX0dZC6a94RbyB6oTPNQiex9jhFotXJY6Dr5I
        FXEhphuG+YPc1yRJDhVZlw3rADy9hb4sv39DcE19sLzCTcRgHXbFa6bBlQEzsTotd5tBEk
        9Z7YDfrhxISHativFRrBRCMEt31LUGvOMcMz0nvt2G1ZmQE7dMvrybwITvc/G8p1bopNLm
        SjDNY/Pk64xpeO6ufWzqe8CYevaXDtrh0zk+RGIKjy//m+ov5OGa6x9AeVaUNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690835943;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6aXZQTsMiC63g2UstCGyW0ZPrqeg5a29N7/rbS4gUX0=;
        b=dKOLlqe8D2bwXxKlXegTUOU7R+qgro9NnOI1RGfg0YP7ouKnm7bDmaSD67hAfjNOhfAhQ1
        +As79U9J1XpaCfDw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v2 1/8] printk: Add non-BKL (nbcon) console basic
 infrastructure
In-Reply-To: <ZMfVyOKbYZKG9nUJ@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-2-john.ogness@linutronix.de>
 <ZMPU8YPHzJ8Q2V9W@alley> <87o7jv92tt.fsf@jogness.linutronix.de>
 <ZMfVyOKbYZKG9nUJ@alley>
Date:   Mon, 31 Jul 2023 22:45:00 +0206
Message-ID: <87cz07ak9n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-31, Petr Mladek <pmladek@suse.com> wrote:
>>> #define have_serialized_console (have_legacy_console || have_boot_console)
>> 
>> This macro is not about having a serialized console. The first
>> sentence in the comment describes it best. It is just to signal if we
>> need to do the console lock/unlock dance to generate console output.
>> 
>> Something like "need_bkl_dance" would be a better name, but it
>> doesn't sound very technical.
>
> I see.
>
> Question: Will console_lock() serialize the early-boot handling
> 	of non-BKL conosles? I mean the direct flush in vprintk_emit().

Initially there will be no nbcon consoles that support CON_BOOT. This
means that there are no nbcon consoles in "early boot". The only reason
that nbcon consoles and legacy boot consoles would co-exist (aside from
the brief moment before boot consoles are unregistered) is if
keep_bootcon is used.

As long as a boot console is registered, nbcon consoles are also bound
to console_lock() serialization. We have no choice until we can safely
link boot consoles to regular consoles.

I think this will be ok for the first release. The 8250 will not become
less reliable in early boot. And once the boot console is unregistered,
the 8250 nbcon console will be able to fly.

> At lest, the v1 patch set called cons_atomic_flush() in vprintk_emit()
> without taking outside console_lock().

Yes. But in the v1 patch set, console_is_usable() returns false for
nbcon consoles if there is a boot console registered. So the
cons_atomic_flush() in vprintk_emit() would not end up printing
anything.

As per your v1 feedback, that check will no longer be in
console_is_usable(), but instead will be further out in higher level
code.

> If console_lock never serializes non-BKL consoles then I rather would define:
>
> 	#define serialized_nbcon (have_nbcon && have_boot_console)
> and use:
>
>   + "have_legacy_console" when console lock/unlock dance is neded.
>
>   + "serialize_nbcon" the non-BKL consoles need to be serialized
>
> IMHO, it will be more clear what is going on.

We have 3 scenarios that I would like to easily identify using global
variable(s).

1. There are only nbcon consoles. The console lock never needs to be
taken.

2. There are nbcon consoles and regular legacy consoles. The console
lock must be taken to serialize only the regular legacy consoles. There
are separate code paths (without the console lock) that will take care
of nbcon atomic printing and nbcon threaded printing.

3. There are nbcon consoles and boot consoles. The console lock must be
taken to serialize all consoles.

Perhaps rather than using 2 booleans and a macro, we just use a single
atomic_t that describes the console serialization mode? The effect is
the same, but maybe it makes the intention of the code a bit easier to
understand?

SERMOD_BOOTCON      = 0,
SERMOD_WITH_LEGACY  = 1,
SERMOD_ONLY_NBCON   = 2,

Or maybe describe the modes based on their behavior rather than their
condition:

SERMOD_ONLY_CONSOLE_LOCK  = 0,
SERMOD_ALSO_CONSOLE_LOCK  = 1,
SERMOD_NO_CONSOLE_LOCK    = 2,

>>>    + Update console_flush_all() description. Mention that it flushes
>>>      only serialized consoles
>> 
>> Agreed. It is only responsible for bkl dance flushing.
>
> Will it flush only legacy consoles? Or will it flush also non-BKL
> consoles during the early boot?

It will also flush nbcon consoles if a boot console is registered.

> I think that it is wrong even after adding the nbcon check. The code
> looks like this at the end of this patchset:
>
> 			/*
> 			 * If consoles are not usable, it cannot be expected
> 			 * that they make forward progress, so only increment
> 			 * @diff for usable consoles.
> 			 */
> 			if (!console_is_usable(c))
> 				continue;
>
> 			if (flags & CON_NBCON)
> 				printk_seq = nbcon_seq_read(c);
> 			else if (locked)
> 				printk_seq = c->seq;
> 			else
> 				continue;
>
> I guess that the "else-continue" path will never happen. But when
> it happens then pr_flush() would ignore a usable console and it looks
> wrong.

My reason for keeping the "if locked" was to remind the developer that
the console lock must be held in order to safely read @console->seq. But
you are right that it makes things look awkward. I will just change the
code to:

			if (flags & CON_NBCON)
				printk_seq = nbcon_seq_read(c);
			else
				printk_seq = c->seq;

There is already a comment at the console_lock() explaining why it is
taken. That is enough.

John
