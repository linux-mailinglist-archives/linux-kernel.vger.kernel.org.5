Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BCF79D885
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbjILSRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbjILSRG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:17:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8640F10D3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:17:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1694542620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP33QWzHGl/4j0pHQ1O3gL3LXAJfnczl0GLzGdTIsDw=;
        b=ToNTpjz8FKHMaOZPactrCjcJL4PwcIaxBg6YYxVeOWLaeIVWtc+2hNLCF8Vtl4hYi+xccE
        wll7P0LjR+kZ60qwzbvUNrL5x+nmXBDlBx15sb+BzVrKJPaeRzA+Cu/9DGPV20zI5USbxy
        wSsIJcYE1pJiyy/M+qG7IA4WTLmcH+Og6fiYd43S+5Cgk3uhX3WKUl8aU0Dile5GVFjI4s
        GXDmAA5XH3Y8W/Q+W7Xew0VqpU844RUUPl1oZCtGH4CBD/ijhbwcBHRZvJlYkoysJcN09Q
        RD6hikYdGNESB81lXUus/r+ybzysSaQgHIm6JFDCx0MSVdF1ABAgzchL0G1AeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1694542620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MP33QWzHGl/4j0pHQ1O3gL3LXAJfnczl0GLzGdTIsDw=;
        b=9zTYp95ItpgX6fGC4M71AOqDdf8NYFi9BG3MmtC8hwOZxbHCEMsJGf1Z+aCPjo5qLjrbgX
        W/g0GUgQ22WsC9Cw==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
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
 <877cpd7a96.ffs@tglx>
 <CAMRc=MfNaydT8gnvusKdJrNrtjKVE4LTqdanh3+WNd5QF-2q_Q@mail.gmail.com>
Date:   Tue, 12 Sep 2023 20:16:59 +0200
Message-ID: <87y1hb1ckk.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06 2023 at 16:54, Bartosz Golaszewski wrote:
> On Wed, Aug 30, 2023 at 12:29=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>   usb disconnect
>>     ...
>>       cp2112_remove()
>>         i2c_del_adapter()
>>           i2c_unregister_device(client)
>>             ...
>>             device_unregister()
>>               device_del()
>>                 bus_notify()            // Mechanism #1
>>                   i2c_device_remove()
>>                     if (dev->remove)
>>                        dev->remove()
>>                 ...
>>                 device_unbind_cleanup()
>>                   devres_release_all()  // Mechanism #2
>>
>>         gpiochip_remove()
>>
>> There are very well notifications to the drivers about unplug of a
>> device. Otherwise this would end up in a complete disaster and a lot
>> more stale data and state than just a procfs file or a requested
>> interrupt.
>
> I'm not sure how either of the two helps here. #2 just releases
> managed resources owned by cp2112. It can remove the domain with an
> appropriate devm action but it won't do anything for the users of
> interrupts. #1 is a bus notification emitted when the I2C adapter
> exposed by cp2112 has been deleted.

No. The domain is not yet gone at the point where the I2C bus
notification happens. Look at the above invocation chain.

The removal of the attached I2C devices happens _before_ the domain is
removed. Anything else does not make sense at all.

So the cleanup of those devices should free the interrupt, in the same
way it frees other resources, no?

i2c_device_remove()
  if (driver->remove)
    driver->remove()    // Driver specific cleanup

  // Devres cleanup operating on the to be removed I2C device
  devres_release_group(&client->dev, client->devres_group_id);

So again:

       cp2112_remove()
         i2c_del_adapter()      // Cleans up all I2C users

       gpiochip_remove()        // Removes the interrupt domain.

So you do not need any magic bus notififications and whatever. It's all
there already.

> This one in particular doesn't help us, the domain is long gone by now
> but if I get what you mean correctly, you'd want the driver to call
> request_irq() and then set up a notifier block for the
> BUS_NOTIFY_UNBIND_DRIVER notification of the provider of that
> interrupt? Doesn't that break like half a dozen of abstraction layers?
> Because now the device driver which is the GPIO consumer needs to know
> where it gets its interrupts from?

Again. It does not. The point is that the device is removed in the
hotplug event chain, which cleans up the associated resources.
devm_request_irq() already takes care of that.

> You would think that plug-and-play works well in the kernel and it's
> true for certain parts but it really isn't the case for subsystems
> that were not considered as very plug-and-play until people started
> putting them on a stick. Some devices that are not typically
> hot-pluggable - like serial - have been used with USB for so long that
> they do handle unplugging very well. But as soon as you put i2c on
> USB, you'll see what a mess it is. If you have an I2C device on a USB
> I2C expander and it's being used, when you pull the plug, you'll see
> that the kernel thread removing the device will block on a call to
> wait_for_completion() until all users release their i2c adapter
> references. They (the users) are not however notified in any generic
> way about the provider of their resources being gone.

So why aren't you fixing this and instead trying to implement force
unplug mechanisms which require a pile of unholy hacks all over the
place?

>> All hotpluggable consumers have at least one mechanism to mop up the
>> resources they allocated. There are a lot of resources in the kernel
>> which do not clean themself up magically.
>>
>
> Yeah, hotpluggable consumers are fine. The problem here is
> hotpluggable *providers* with consumers who don't know that.

Then these consumers have to be fixed and made aware of the new world order
of hotplug, no?

>> Your idea of tracking request_irq()/free_irq() at some subsystem level
>> is not going to work either simply because it requires that such muck is
>> sprinkled all over the place.
>>
> I was thinking more about tracking it at the irq domain level so that
> when a domain is destroyed with interrupts requested, these interrupts
> are freed. I admit I still don't have enough in-depth knowledge about
> linux interrupts to understand why it  can't work, I need to spend
> more time on this. I'll be back.

There is no need for special tracking. The core can figure out today
whether an interrupt which is mapped by the domain is requested or
not. That's not the problem at all.

The problems are the life time rules, references, concurrency etc. They
are not magically going away by some new form of tracking.

It's amazing that you insist on solving the problem at the wrong end.

The real problem is that there are device drivers and subsystems which
are not prepared for hotplug, right?

As interrupts are only a small part of the overall problem, I'm
absolutely not seeing how adding heuristics all over the place is a
sensible design principle.

What's so problematic about teaching the affected subsystems and drivers
that hotplug exists?

Thanks,

        tglx

