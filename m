Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56EF075126D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 23:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjGLVNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 17:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbjGLVMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:12:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADAFD2D5A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:56 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689196313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/jsuRRgpKVi1Dyg8tuPASmeiuQU2l99KQrKwfJWYio=;
        b=zBdPbDU5kwGUJZfCdfJDaVfe9tUCMLOr+V/SgtGFcgZdR896Z/4izPg8GfUOQ1ENSE6dKf
        ctPYxqucX2m9EJwoiMdGE7eZZdHDEZ1DeDbYxmBggNVq6NCG+5nrqXwh+G9SGEM2iDevLV
        QD7apwP8HIbwB9k3CeFagYONHQWIaBbHiHlXF4385d9SsjV3bm+YBGAnv3IHO4aaj699ce
        Ax4gHRulsceJBeE9suuJJrS606GLK53BDi69dJAclNwdPChsYTIE4YJYT8PEyFuc8w/YdC
        82zStTPQY+dh2R9SDSyeKyb+JkQpM90KS7Z8cty/lISA6pzZnaKyIeRWj72z5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689196313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7/jsuRRgpKVi1Dyg8tuPASmeiuQU2l99KQrKwfJWYio=;
        b=aSW59uS2VueQlyWb+RkWeQsdzdJI2lImPJxTlftYjAUlwsaiGb0TRsXD9xmcW1RcM8fnst
        VoplwGI4h/Hh11DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
In-Reply-To: <ZK14p-ocWuuHkSAQ@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
 <ZK14p-ocWuuHkSAQ@alley>
Date:   Wed, 12 Jul 2023 23:17:49 +0206
Message-ID: <878rbkrg16.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-07-11, Petr Mladek <pmladek@suse.com> wrote:
> Just to be sure. The semaphore is not NMI safe because even the
> trylock takes an internal spin lock. Am I right, please?

Yes, that is one of the reasons. Sergey mentioned another (waking a task
on up()).

> Alternative solution would be to make down_trylock() NMI safe
> by using raw_spin_trylock_irqsave() for the internal lock.

NMI contexts are only allowed to take raw spinlocks if those spinlocks
are only used from NMI context. Otherwise you could have deadlock:

raw_spin_lock()
--- NMI ---
raw_spin_lock()

Using a trylock does not avoid the deadlock danger.

> Another question is whether we want to call c->unblank()
> in NMI even when down_trylock() was NMI safe. It seems that it
> is implemented only for struct console vt_console_driver.
> I am pretty sure that it takes more internal locks which
> are not NMI safe either.

Yes, it does. As an example, it calls mod_timer(), which is also not NMI
safe. Clearly the unblank() callback must not be called in NMI context.

> Finally, it is not only about NMI. Any locks might cause a deadlock
> in panic() in any context. It is because other CPUs are stopped
> and might block some locks.

With the atomic/threaded model this is not true. The port ownership can
be safely taken over from stopped CPUs.

> In my opinion, we should handle c->unblank() in panic() the same way
> as c->write() in panic().

I do not agree. Clearly unblank() is not NMI safe. Also, in current
mainline code, console_unblank() will already give up if the trylock
failed (rather than ignoring the lock, like write() does). So
console_unblank() might as well also give up if in NMI context.

John
