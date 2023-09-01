Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E74EA790240
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350649AbjIAStP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjIAStO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:49:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33EE1BF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 11:49:11 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693594150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuZ88b0upaT2I5pkWKqpzQVcxAV2S3QI2s0I0+Y7JVo=;
        b=IdFq9AWjhoCp7EbwCZWx80qmSmEcIKQ13qyxQafSAqgSD7fSo5limZ7otbrzXPN272oHiX
        GTxwEYjbHiK0nhYR7UU5PDXkKxadzY7dAEvh3gqWT7Fs1jJ3Qw+nTJO5qzN44ydUOm2xLR
        bYbmII+I74vHtEz3O8MecTG2DPxovR9Goiaisyq/CSJatGKkAYVJMueI7Rd0TwQwl4MLa9
        4Dy8zLyNhjXGnqrThy7MRduEr79+FQ4xDVeYCtR4jupOhZFW9L2SGe+tcsatVYMj1uWgDh
        t+bfJW2fhB2jJUanCCtr1jpAyEeAPc3mZPZllQrWJH5o7eOC3DI4S/8GDDpgng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693594150;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BuZ88b0upaT2I5pkWKqpzQVcxAV2S3QI2s0I0+Y7JVo=;
        b=gEko4mqtYErLM69T7ED5NKfZHvfiEKkBUF8bjCWxOtGzUSc4Rl9ug2la9tBMtjnnBSfw4x
        ah7G7cTzXZT808Cw==
To:     Joshua Hudson <joshudson@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86-ml <x86@kernel.org>
Subject: Re: System Call trashing registers
In-Reply-To: <CA+jjjYSMq-hKx5XsMDf=+n4wfAr6Btt7x8gpG5kdRRrzr6YK2Q@mail.gmail.com>
References: <CA+jjjYQWeqDY3EFQWmVzV2pXyhfRaHm6s-XWYSXfe1CxvkeuEQ@mail.gmail.com>
 <dbce949f-d8b5-fb88-af63-21a82e431aa3@gnuweeb.org>
 <CA+jjjYSMq-hKx5XsMDf=+n4wfAr6Btt7x8gpG5kdRRrzr6YK2Q@mail.gmail.com>
Date:   Fri, 01 Sep 2023 20:49:09 +0200
Message-ID: <87a5u54tlm.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01 2023 at 10:38, Joshua Hudson wrote:
> On Fri, Sep 1, 2023 at 9:24=E2=80=AFAM Ammar Faizi <ammarfaizi2@gnuweeb.o=
rg> wrote:
>
> Correction: it's been fixed again. Sorry about that.

When exactly was it broken? Which kernel version?

The save/restore mechanism is not changing every other day.

> I know the asmutils tools have been broken for a decade, but they're
> working now.
>
> What would happen is system calls that take arguments in ecx and edx woul=
d find
> ecx and edx trashed, but only a few calls actually did this, the
> primary offender
> being open(). The best regression test seems to be hexdump from
> asmutils because the
> corruption would reliably crash the binary. sched_yeild was never an
> affected syscall.

It does absolutely not matter which syscall is used. The save/restore
mechanism is identical for all syscalls.

Thanks,

        tglx


