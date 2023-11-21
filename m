Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26937F3377
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 17:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjKUQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 11:17:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjKUQRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 11:17:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19C5112
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 08:17:38 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700583456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AO5kesI1HmDAihR6XXO3SekHStdGriMuI91PxRGMYVg=;
        b=VuZLF+io25nu8e82+NON/UNkilGW2j0iMgE6Ijg1eouipnoC8vZ/r1YL+Y1GoRxoZLSzyv
        s3C0j2wFdvc0bJbE3oRrfNWHJrEnitDgXHnxUedeBEzvb7NQ/4/yGgfzZxbfHoGp+ah9OD
        zEc3HpnSkygoyO2+Tj/NLMxGrnT9x+bbOlZw8Jt2Q/wcaV4Pxhcr1omZ4yT5rAhOZX4q0r
        BzZpHnTHBPZeD86wZXSNkR/R+lw9Ux1o9kpayQM+KaXxfYjOlqNmbs083YulY079qRn8wp
        643I6jmoBs5bP0w3uC1PAzZgL7T8yT6hxlQZKFR1LbnXmfj3ZWAnyhlC2H6hyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700583456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AO5kesI1HmDAihR6XXO3SekHStdGriMuI91PxRGMYVg=;
        b=bha82Qz14hKJM0w3dswspNNWNZFIbGHrlRHi4QCRjX0HvIMbcXabULGV/7Bb0Qn31lh4JG
        6XwkUedyB/tBoaBQ==
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Mukesh Ojha <quic_mojha@quicinc.com>
Subject: Re: [PATCH printk v2 1/9] printk: ringbuffer: Do not skip
 non-finalized records with prb_next_seq()
In-Reply-To: <20231120134556.DkKNwy7B@linutronix.de>
References: <20231106210730.115192-1-john.ogness@linutronix.de>
 <20231106210730.115192-2-john.ogness@linutronix.de>
 <20231120134556.DkKNwy7B@linutronix.de>
Date:   Tue, 21 Nov 2023 17:23:35 +0106
Message-ID: <87lear2i8w.fsf@jogness.linutronix.de>
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

On 2023-11-20, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
> based on my research this should be the most recent post of this patch.
> If so then
>
> On 2023-11-06 22:13:22 [+0106], John Ogness wrote:
>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +	/*
>> +	 * The provided sequence is only the lower 32 bits of the ringbuffer
>> +	 * sequence. It needs to be expanded to 64bit. Get the first sequence
>> +	 * number from the ringbuffer and fold it.
>> +	 */
>> +	seq = rb_first_seq - ((u32)rb_first_seq - ulseq);
>
> This needs to become
> 	seq = rb_first_seq - ((s32)((u32)rb_first_seq - ulseq));
>
> in order to continue booting on 32bit.

Indeed. The code assumes the passed in value (@ulseq) always represents
a 64-bit number that is less than or equal to the basis value
(@rb_first_seq). For kernel/printk/nbcon.c:__nbcon_seq_to_seq() that
assumption is correct. For this function, it is not.

Your change will round up or down to the nearest 32 bits of the basis
value.

For example, with @rb_first_seq = 0x200000000 and @ulseq = 0x1:

before your change (where @ulseq cannot represent something higher than
@rb_first_seq):

    @ulseq translates to 0x100000001

after your change:

    @ulseq translates to 0x200000001

Since __ulseq_to_u64seq() must deal with arbitrary values, I think the
32-bit rounding is appropriate.

Despite not strictly being necessary (because of the valid assumption),
I think we should also update __nbcon_seq_to_seq() to avoid any bizarre
cases due to different translations of the 32-bit value.

In fact, there is no reason to have 2 macros for this. I will create a
single macro using the 32-bit rounding.

Thanks for researching this!

John
