Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319E178CD71
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240476AbjH2US6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240362AbjH2USj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:18:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B366E9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 13:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0926164432
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:18:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD401C433C8;
        Tue, 29 Aug 2023 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693340315;
        bh=0FffNEBmJnVThNLbGRqsvKM/Q0PTUpKzomHTk97O9C0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zErBNAM4wczXbncJZYl4hd8YMJfqyl9W8bA4NeKoN+9RrZrDJEijkAsEGvYDEUmT7
         V9Rk1eWlAcIx6yJ3ts4/bn7YSo0k646hNnMoJ8okpmqjAR5DVEQhB1SkZ9wu33xkvS
         mGeCb3ah04bGqZAiA8LK9FrAC4CxIYtIG0cPrEUM=
Date:   Tue, 29 Aug 2023 22:18:32 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
Message-ID: <2023082908-bulb-scrubbed-32af@gregkh>
References: <87sf87aw36.ffs@tglx>
 <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx>
 <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx>
 <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx>
 <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx>
 <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:24:21PM +0200, Bartosz Golaszewski wrote:
> On Tue, Aug 29, 2023 at 11:11 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> >
> > On Tue, Aug 29 2023 at 08:26, Bartosz Golaszewski wrote:
> > > On Mon, Aug 28, 2023 at 11:44 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> > >> That's the module which provides the interrupt domain and hid-whatever
> > >> is the one which requests the interrupt, no?
> > >>
> > > Not at all! This is what I said: "we have the hid-cp2112 module which
> > > drives a GPIO-and-I2C-expander-on-a-USB-stick". Meaning: the
> > > hid-cp2112 module registers a USB driver for a GPIO expander on a
> > > stick. This GPIO chip is the interrupt controller here. It's the USB
> > > stick that provides interrupts for whatever else needs them (in real
> > > life: it can be an IIO device on the I2C bus which signals some events
> > > over the GPIOs). The user can get the interrupt number using the
> > > gpiod_to_irq() function. It can be unplugged at any moment and module
> > > references will not stop the USB bus from unbinding it.
> >
> > Sorry for my confusion, but this all is confusing at best.
> >
> > So what you are saying is that the GPIO driver, which creates the
> > interrupt domain is unbound and that unbind destroys the interrupt
> > domain, right? IOW, the wonderful world of plug and pray.
> >
> > Let's look at the full picture again.
> >
> >    USB -> USB-device
> >           |----------- GPIO
> >           |------------I2C  ---------- I2C-device
> >                  (hid-cp2112 driver)   (i2c-xx-driver)
> >
> > i2x-xx-driver is the one which requests the interrupt from
> > hid-cp2112-GPIO, right?
> >
> 
> Yes! Sorry if I was not being clear about it.
> 
> > So when the USB device disconnects, then something needs to tell the
> > i2c-xx-driver that the I2C interface is not longer available, right?
> >
> > IOW, the unbind operation needs the following notification and teardown
> > order:
> >
> >    1) USB core notifies hid-cp2112
> >
> >    2) hid-cp2112 notifies i2c-xx-driver
> >
> >    3) i2c-xx-driver mops up and invokes free_irq()
> >
> >    4) hid-cp2112 removes the interrupt domain
> >
> > But it seems that you end up with a situation where the notification of
> > the i2c-xx-driver is either not happening or the driver in question is
> > simply failing to mop up and free the requested interrupt.
> >
> 
> Yes, there's no notification of any kind.

Why not fix that?

> It's a common problem unfortunately across different subsystems. We
> have hot-unpluggable consumers using resources that don't support it
> (like interrupts in this example).

Then the driver for the controller of that hot-pluggable irq controller
should be fixed.

> > As a consequence you want to work around it by mopping up the requested
> > interrupts somewhere else.
> >
> 
> The approach I'm proposing - and that we implement in GPIO - is
> treating the "handle" to the resource as what's often called in
> programming - a weak reference. The resource itself is released not by
> the consumer, but the provider. The consumer in turn can get the weak
> reference from the provider and has to have some way of converting it
> to a strong one for the duration of any of the API calls. It can be
> implemented internally with a mutex, spinlock, an RCU read section or
> otherwise (in GPIO we're using rw_semaphores but I'm working on
> migrating to SRCU in order to protect the functions called from
> interrupt context too which is missing ATM). If for any reason the
> provider vanishes, then the next API call will fail. If it vanishes
> during a call, then we'll wait for the call to exit before freeing the
> resources, even if the underlying HW is already gone (the call in
> progress may fail, that's alright).
> 
> For interrupts it would mean that when the consumer calls
> request_irq(), the number it gets is a weak reference to the irq_desc.
> For any management operation we lock irq_desc. If the domain is
> destroyed, irq_descs get destroyed with it (after all users leave the
> critical section). Next call to any of the functions looks up the irq
> number and sees it's gone. It fails or silently returns depending on
> the function (e.g. irq_free() would have to ignore the missing
> lookup).
> 
> But I'm just floating ideas here.

That's a nice idea, but a lot of work implementing this.  Good luck!

Fixing the driver might be simpler :)

greg k-h
