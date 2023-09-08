Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B198B79892C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 16:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbjIHOss (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 10:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjIHOss (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 10:48:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2351FC6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 07:48:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694184521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTrdSFyCoWh4NW0uf+rzUmbGZVj8FqZUC79wfn613SY=;
        b=lOICJJe76KAIpSKUNukZCjJy/jh7gg4TnEYiTrty24yQlv1ohz+9f/i0zjgXSEQEkaX/Gs
        e4Ro1Pjb6Mj5aWcigj0p/l0ebDBoYFZrwRSiA4V7Cy/0zcKh6yhX73y8Kvm6SxfpnunSF1
        7GAOeUfvaElsLF/RAYTWfdNW69PAqIPlYPk3IbLQWduNwl/OvZFBRkApvj709Sd35wEETk
        RqXPGG/D2UaGpchULlznOy2DHi75VcjmGJtg7Vu8Z07PVSTsV8MrK6QEGzy2WDNyWbioFU
        nyPGovNYlgekCYpNe6/0PtS9Zpav/Z0wM5ZVqlEHHD8EpCuf7qOwbhaPrH3wFg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694184521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RTrdSFyCoWh4NW0uf+rzUmbGZVj8FqZUC79wfn613SY=;
        b=tz72ZTxHa5ijMeaBxi8gs5kaFGTWWQBB6fVASBT4cPWCl43M1rir8GiQsttFQfePW6H7sj
        mYEmqVFwOmxzcDCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: hostile takeover: Re: [PATCH printk v2 3/8] printk: nbcon: Add
 acquire/release logic
In-Reply-To: <ZPnu5P3b74K1mYTu@alley>
References: <20230728000233.50887-1-john.ogness@linutronix.de>
 <20230728000233.50887-4-john.ogness@linutronix.de>
 <ZNOKSFAGPxYFeeJT@alley> <87o7iqrvvx.fsf@jogness.linutronix.de>
 <ZPnu5P3b74K1mYTu@alley>
Date:   Fri, 08 Sep 2023 16:54:39 +0206
Message-ID: <87a5twhgag.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-07, Petr Mladek <pmladek@suse.com> wrote:
> Hmm, I am actually not sure if nbcon_emit_next_record()
> calls printk_get_next_message() and con->write_atomic(con, wctxt)
> in "safe" or "unsafe" context.

It does not! In the early versions of this code it was not a problem
because we had a per-priority buffer for each console. But now we only
have one buffer that is shared by the NORMAL and EMERGENCY priorities
per console. For v4 I am creating a safe region around
printk_get_next_message() and console_prepend_dropped(). That will fix
the issue. Nice catch!

For the callbacks write_atomic() (and later, write_thread()) it should
not be called in unsafe. It is up to the drivers to decide what is safe
and unsafe.

>> 1. try direct
>> 2. try safe takeover
>> 3. try handover
>> 4. try hostile takeover
>
> I rather meant:
>
>   1. try direct
>   2. try handover +
>      try safe takeover in every waiting cycle
>   3. try hostile takeover
>
> But then it won't be a handover anymore.
>
> Anyway, I would keep it as is for now. As mentioned above,
> the current handover is more conservative approach because
> the lock is passed on well defined locations.

For v3 I made the change as I suggested above. So it will perform a
direct takeover if the priority is higher and it is safe. Yes, waiting
first might seem more polite and conservative. But if the driver is in a
safe state, I see no reason to make a higher priority context wait. If
it would be a problem for the first context to suddenly lose ownership,
then it should be marking it an unsafe region.

For fun I implemented it such that it only directly takes over an owner
after having waited. But it adds quite a bit of ugliness to the routine
and I don't think it is worth it.

For v4 I will keep it the same as v3: a direct takeover of an existing
owner when safe before trying the handover.

John Ogness
