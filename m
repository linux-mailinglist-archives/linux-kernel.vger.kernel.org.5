Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34063788D9A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 19:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344195AbjHYRIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 13:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344206AbjHYRId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 13:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FE82108
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 10:08:31 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692983310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hjr3OmFeHDRkR6I/FegbqlyvqwLAYiXWrVZyQt5r8cU=;
        b=RDWCBYSuQMMwP7wWs+njOYgELDizbIdBU/VQ/GJpn4CN0EupuCOKsCuOpqU6pcl5/Md1bG
        W73GP5IDmzXliuibwrt9dt8/zJCIXHIvoNAJO9mwhty/gYPEG30yKv2uf0gXvBhOgrYzFS
        5hq0F4edybK70FK9Rf/pyDfeldJJx04MEeW+Q5E2cD74H2YUtnNgmPWiunpmc4SXJxxUhP
        NmMIlIC6/sbgVlOxgCWl/qUpptZVz7J6wtOWtfhqbkINUFqew7TeXFXl+1woYoReLBRvWR
        VVplI+Iihh+Cz4oTu2+amu2H9mVu3FvBkGGVSsXSdx283lONS53mX8te9CS30g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692983310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hjr3OmFeHDRkR6I/FegbqlyvqwLAYiXWrVZyQt5r8cU=;
        b=9kW7yYHrsvqce3JyTNiiBxF6fzhKLc+krfGqzIUz6Jxx/BJSKumKyFwvHXBBbktRlKyBa1
        CAwo18y8LKaDnaBg==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
 <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
Date:   Fri, 25 Aug 2023 19:08:29 +0200
Message-ID: <87sf87aw36.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25 2023 at 13:01, Bartosz Golaszewski wrote:
> On Fri, Aug 25, 2023 at 10:11=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> On Fri, Aug 25 2023 at 00:36, brgl@bgdev.pl wrote:
>> > On Thu, 24 Aug 2023 22:12:41 +0200, Thomas Gleixner <tglx@linutronix.d=
e> said:
>> > Here a GPIO device - that is also an irq chip - is unbound (this is a =
testing
>> > module unbound during a test-case but it can be anything else, like an=
 I2C
>> > expander for which the driver is unloaded) while some users called
>> > request_irq() on its interrupts (this is orthogonal to gpiod_get() and=
 doesn't
>> > take a reference to the module, so nothing is stopping us from
>> > unloading it)
>>
>> You just described the real problem in this sentence. So why are you
>> trying to cure a symptom?
>
> Honestly I'm not following. Even if we did have a way of taking the
> reference to the underlying GPIO module (I'm 99% percent sure, it's
> not possible: we're not using any of the GPIO interfaces for that,

The point is that something frees an in-use interrupt descriptor, which
is obviously wrong to begin with.

Now you go and cure the symptom of a stale procfs file, but as I said
before this is the least of the worries.

Care to look at what free_irq() does and you might figure out why this
stale file is just an easy to observe symptom, but obviously not the
real problem.

This leaves an activated interrupt around with stale pointers to the
descriptor. The interrupt could be on the flight. The associated thread
could be running. There can be resources claimed via request_irq() which
will not be freed either. There can be management operations on the
interrupt in parallel.

A driver which successfully requests an interrupt can rightfully expect
that any management operation on the interrupt, e.g. disable(),
enable(), set_*() is valid until the point it invokes free_irq().

IOW, the descriptor including the associated interrupt chips (software
representation) in the hierarchy must be at least in a consistent state
and accessible. If the underlying hardware vanished, e.g. USB
disconnect, then still the software side must be intact. Of course an
disable_irq() won't reach the hardware anymore, but that's something the
relevant driver has to handle correctly.

So just claiming that it's fine to free in-use interrupts and everything
is greate by removing the procfs entries is just wishful thinking.

You simply cannot free an in-use interrupt descriptor and I'm going to
add a big fat warning into that code to that effect.

So if it turns out that this is a general problem, then we have to sit
down and solve it from ground up.

Thanks,

        tglx
