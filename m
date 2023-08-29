Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2218378C432
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbjH2MYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235528AbjH2MYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:24:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7515CE4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 05:23:53 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693311832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEXQ/4qLDP7WzcOeGRTncftyK8L87CMmaZUOQzxpZNY=;
        b=MXso0wlk4AMBYArhUohfAWzRbliOJ2poKYWWhFNQugcfcEY6T4l0i7jqGyLH05jnrST3pM
        P9mjrzhvtE2EFdq76UJ+xF0Cf7xqGXbXWYFJaJWok25QteAA3qj9lJnRQvs7J5llD7z6in
        rAX/3RfurOozZKp31kQ8VDjtwTlCDoeaK/WJOAJG3W54pdgjc/55nWlFjjYZuGcJbSPWoO
        pWGUpNwECkGmUpn9c3NfKvolrOotAmynDdFwMVZqk3ZUDqlGCWB51B8zErzS7di4o7ZxUZ
        zyk9QuW3K1AFMA680siBil44LsqG9JLH/xE0ryeH5Fi16DtpyTjR2mr4LNX0Mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693311832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEXQ/4qLDP7WzcOeGRTncftyK8L87CMmaZUOQzxpZNY=;
        b=XL1/wb+AbJ1cTUILeCsgTcw8N2p2jLNce/duy9GIJHni20D6DGiM+cXO76lXWH6tnpws+D
        e7Mev7aPDKNZzhBQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 6/8] printk: nbcon: Add ownership state functions
In-Reply-To: <ZNTemiTUI38f11ek@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-7-john.ogness@linutronix.de>
 <ZNTemiTUI38f11ek@alley>
Date:   Tue, 29 Aug 2023 14:29:51 +0206
Message-ID: <87h6oirq94.fsf@jogness.linutronix.de>
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

On 2023-08-10, Petr Mladek <pmladek@suse.com> wrote:
>> +static bool nbcon_context_update_unsafe(struct nbcon_context *ctxt, bool unsafe)
>> +{
>> +	struct console *con = ctxt->console;
>> +	struct nbcon_state cur;
>> +	struct nbcon_state new;
>> +
>> +	nbcon_state_read(con, &cur);
>> +
>> +	/* The unsafe bit must not be cleared if @hostile_unsafe is set. */
>> +	if (!unsafe && cur.hostile_unsafe)
>> +		return nbcon_context_can_proceed(ctxt, &cur);
>> +
>> +	do {
>> +		if (!nbcon_context_can_proceed(ctxt, &cur))
>> +			return false;
>
> nbcon_context_can_proceed() returns "true" even when there
> is a pending request. It happens when the current state is "unsafe".

Correct.

>> +
>> +		new.atom = cur.atom;
>> +		new.unsafe = unsafe;
>> +	} while (!nbcon_state_try_cmpxchg(con, &cur, &new));
>
> If the new state is "safe" and there is a pending request
> then we should release the lock and return false here.

The function does release the lock and return false... after it clears
state.unsafe.

> It does not make sense to block the waiter just to realize
> that we can't enter "unsafe" state again.

Sorry, I do not understand what you mean.

>> +	ctxt->unsafe = unsafe;
>> +
>> +	return true;
>
> An easy solution would be to do here:
>
> 	ctxt->unsafe = unsafe;
> 	return nbcon_context_can_proceed(ctxt, &cur);

ctxt->unsafe is an input. It does not need to be updated anyway. (And
besides, it will be removed for v3.)

> But maybe, we can change the logic a bit. Something like:

I think with ctxt->unsafe removed, this v2 implementation is ok.

John
