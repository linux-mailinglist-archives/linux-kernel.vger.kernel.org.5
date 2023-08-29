Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80B778CF88
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 00:30:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbjH2WaC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 18:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236195AbjH2W3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 18:29:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F1231B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 15:29:44 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693348182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgk7QBXGhuh0CO4QS/5onyOS7s/KO0HAOy1RZqavFVQ=;
        b=Yzd1EDm7LDP9ZEZf6eXnjx2gf2YER8DjvBftLvvWzUQRqTt8HoxbRVyAxJAw/5ghW7UQV0
        9sQpLSq3gdrbjfm7/jDiZStPuCui0YekQzo/14neiJCiq+5x/nLBHyoJ/s0PYB/UlHgeyV
        YArLCXcQpowFCAgJesW8Y73ZFv6fh/yTPo9TOepjLOYvrgSF9Du46SZVfuTfW03Ar2Pd7i
        wL7iz21Q1yrcDtMw6/KEids9CZuMJp/Da4xY4HKlz8ozwJbFOrS3E4HONSsApTOsp+uenM
        7eFCWSBNt/eNRIIsx1XVFniHZ5YAj0K5WUrQuwA4GXSNA9qjoOFR3UNOh67RZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693348182;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tgk7QBXGhuh0CO4QS/5onyOS7s/KO0HAOy1RZqavFVQ=;
        b=CsJ0JVlae7efRR6iCAfuXKOAnR5hD1pr9+PCpQKPrzMypZ5dwwVgOy/rq27pyDmkfgB5gb
        H7GDnBRgRGO0kSBQ==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
 <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx>
 <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx>
 <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
 <87o7ir8hlh.ffs@tglx>
 <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
 <873502971b.ffs@tglx>
 <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
 <87msya6wmf.ffs@tglx>
 <CAMRc=Md6NA6-rBWL1ti66X5Rt3C4Y2irfrSZnCo3wQSCqT6nPQ@mail.gmail.com>
Date:   Wed, 30 Aug 2023 00:29:41 +0200
Message-ID: <877cpd7a96.ffs@tglx>
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

On Tue, Aug 29 2023 at 14:24, Bartosz Golaszewski wrote:
> On Tue, Aug 29, 2023 at 11:11=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> > On Mon, Aug 28, 2023 at 11:44=E2=80=AFPM Thomas Gleixner <tglx@linutro=
nix.de> wrote:
>> So when the USB device disconnects, then something needs to tell the
>> i2c-xx-driver that the I2C interface is not longer available, right?
>>
>> IOW, the unbind operation needs the following notification and teardown
>> order:
>>
>>    1) USB core notifies hid-cp2112
>>
>>    2) hid-cp2112 notifies i2c-xx-driver
>>
>>    3) i2c-xx-driver mops up and invokes free_irq()
>>
>>    4) hid-cp2112 removes the interrupt domain
>>
>> But it seems that you end up with a situation where the notification of
>> the i2c-xx-driver is either not happening or the driver in question is
>> simply failing to mop up and free the requested interrupt.
>>
>
> Yes, there's no notification of any kind.

I'm not buying that.

  usb disconnect
    ...
      cp2112_remove()
        i2c_del_adapter()
          i2c_unregister_device(client)
            ...
            device_unregister()
              device_del()
                bus_notify()            // Mechanism #1
                  i2c_device_remove()
                    if (dev->remove)
                       dev->remove()
                ...
                device_unbind_cleanup()
                  devres_release_all()  // Mechanism #2

        gpiochip_remove()

There are very well notifications to the drivers about unplug of a
device. Otherwise this would end up in a complete disaster and a lot
more stale data and state than just a procfs file or a requested
interrupt.

So the mechanisms are there, no?

If this is just about the problem that some device driver writers fail
to implement them correctly, then yes it makes sense to have a last
resort fallback which cleans them up and emits a big fat warning.

Making this a programming model would be beyond wrong.

> It's a common problem unfortunately across different subsystems. We
> have hot-unpluggable consumers using resources that don't support it
> (like interrupts in this example).

All hotpluggable consumers have at least one mechanism to mop up the
resources they allocated. There are a lot of resources in the kernel
which do not clean themself up magically.

So what's so special about interrupts? They are not any different from a
pointer which is registered at some entity and the device driver writer
forgets to unregister it, but the underlying resource is freed. That's
even worse than the leaked interrupt and cannot be magically undone at
all.

Whatever you try, you can't turn driver programming into a task which
can be accomplished w/o brains.

> For interrupts it would mean that when the consumer calls
> request_irq(), the number it gets is a weak reference to the irq_desc.

Interrupt numbers are weak references by definition. request_irq() does
not return an interrupt number, it returns success or fail. The
interrupt number is handed to request_irq(), no?

The entities which hand out the interrupt number are a complete
different story. But that number is from their perspective a weak
reference too.

> For any management operation we lock irq_desc.

That's required anyway, but irq_desc::lock is not a sufficient
protection against a teardown race.

> If the domain is destroyed, irq_descs get destroyed with it

Interrupts consist of more than just an interrupt descriptor. If you
care to look at the internals, then the descriptor is the last entity
which goes away simply because all other related resources hang off the
interrupt descriptor.

So they obviously need to be mopped up first and trying to mop up
requested interrupts at the point where the interrupt descriptor is
freed is way too late.

In fact they need to mopped up first, which is obvious from the setup
ordering as everything underneath must be in place already before
request_irq() can succeed. The only sensible ordering for teardown is
obviously the reverse of setup, but that's not specific to interrupts at
all.

> (after all users leave the critical section).

Which critical section? Interrupts have more than just the
irq_desc::lock critical section which needs to be left.

> Next call to any of the functions looks up the irq number and sees
> it's gone. It fails or silently returns depending on the function
> (e.g. irq_free() would have to ignore the missing lookup).

That's what happens today already.

The missing bit is the magic function which mops up when the driver
writer blew it up. But that's far from a 'put a trivial free_irq() call
somewhere'.

First of all we have too many interrupt mechanisms ranging from the
linux 0.1 model with static interrupt spaces to hierarchical interrupt
domains.

  - Almost everything which is interrupt domain based (hierarchical or
    not) can probably be "addressed" by some definition of "addressed"
    because there are only a few places in the core code which are
    involved in releasing individual or domain wide resources.

    But see below.

  - The incarnations which do not use interrupt domains are way harder
    because the teardown of the interrupt resources is not happening in
    the core code. It's happening at the driver side and the core is
    only involved to release the interrupt descriptor. But that's too
    late.

    The good news about those is that probably the vast majority of the
    instances is built in, mostly legacy and not pluggable.

So lets assume that anything which is not interrupt domain based is not
relevant, which reduces the problem space significantly. But the
remaining space is still non-trivial.

  1) Life-time

     Interrupt descriptors are RCU freed but that's mostly for external
     usage like /proc/interrupts

     Still most of the core code relies on the proper setup/teardown
     order, so there would be quite some work to do vs. validating that
     an interrupt descriptor is consistent at all hierarchy levels.

     That's going to be interesting vs. interfaces which can be invoked
     from pretty much any context (except NMI).

     irq_desc::lock is not the panacea here because it obviously can
     only be held for real short truly atomic sections. But quite some
     of the setup/teardown at all levels requires sleepable context.

  2) Concurrency

     Protection against concurrent interrupt handler execution is
     covered in free_irq() as it fully synchronizes.

     That's the least of my worries.

     Whatever the invalidation mechanism might be, pretty much every
     usage site of irq_to_desc() and any usage site of interrupt
     descriptors which are stored outside of the maple_tree for
     performance reasons need to be audited.

     The validation has to take into account whether that's an requested
     descriptor or an unused one.
=20=20
So no, neither removing some procfs entry at the wrong point nor
slapping some variant of free_irq() into random places is going to cut
it.

Your idea of tracking request_irq()/free_irq() at some subsystem level
is not going to work either simply because it requires that such muck is
sprinkled all over the place.

I completely agree that the interrupt core code does not have enough
places which emit a prominent warning when the rules are violated.

So sure, in some way or the other a "fix" by some definition of "fix"
could be implemented, but I'm really not convinced that's the right way
to waste^Wspend our time with.

Especially not because interrupt handling is a hot-path and any
life-time/conncurrency validation mechanism will introduce overhead no
matter what.

Thanks,

        tglx
