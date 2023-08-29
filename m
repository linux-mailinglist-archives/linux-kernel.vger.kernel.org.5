Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9884178C109
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 11:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbjH2JM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 05:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbjH2JMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 05:12:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7237107
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 02:11:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693300313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tm2F38dG2xIDXsOpy2SujOcla1kxoaNTG+Y4ZJUbUNg=;
        b=jjYpFevHLgoODWktoUCSE/JyXqOsUJQdjdUf7OFJLqqexwxFmBG4XZ8pRMDjmVZ8kK42bI
        sDE4z1TzMH87MIquABSPGzveE3QS9AsCByqCctA/US0gdq5+/F7TBe9lu86xPK3FAbuswX
        ujsw4C2alA1LlS3sh5XZrOBDtFeg7KEbYldCL+VsmUAChCn7XLt2txkN9rul4flsOzZ1Ao
        CBzdUZ64d77EhtktzA8Re0w87faZ7rmrAO/+yzOsYMUiDNd1YHKZ/TahZ+f7KTQ0TT97ZX
        7J7No1y2aqDCuo0weNl0nYVAQn9eAQJiegMgLiyZ+uf4FoYPLj/aQcn05KU+6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693300313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tm2F38dG2xIDXsOpy2SujOcla1kxoaNTG+Y4ZJUbUNg=;
        b=bJ2tjBT9PUrm3IKFk+ZHmoNvDZhw/1NB+v1YSGxuHintREPXaGWb9L/04RLlmABgpoXOiH
        Y69KE4CsPWLijqBg==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=Meigus=WOGwM-fStkhtDeKyTd+9vZH19HoP+U1xpwYx9Q@mail.gmail.com>
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
Date:   Tue, 29 Aug 2023 11:11:52 +0200
Message-ID: <87msya6wmf.ffs@tglx>
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

On Tue, Aug 29 2023 at 08:26, Bartosz Golaszewski wrote:
> On Mon, Aug 28, 2023 at 11:44=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>> That's the module which provides the interrupt domain and hid-whatever
>> is the one which requests the interrupt, no?
>>
> Not at all! This is what I said: "we have the hid-cp2112 module which
> drives a GPIO-and-I2C-expander-on-a-USB-stick". Meaning: the
> hid-cp2112 module registers a USB driver for a GPIO expander on a
> stick. This GPIO chip is the interrupt controller here. It's the USB
> stick that provides interrupts for whatever else needs them (in real
> life: it can be an IIO device on the I2C bus which signals some events
> over the GPIOs). The user can get the interrupt number using the
> gpiod_to_irq() function. It can be unplugged at any moment and module
> references will not stop the USB bus from unbinding it.

Sorry for my confusion, but this all is confusing at best.

So what you are saying is that the GPIO driver, which creates the
interrupt domain is unbound and that unbind destroys the interrupt
domain, right? IOW, the wonderful world of plug and pray.

Let's look at the full picture again.

   USB -> USB-device
          |----------- GPIO
          |------------I2C  ---------- I2C-device
                 (hid-cp2112 driver)   (i2c-xx-driver)

i2x-xx-driver is the one which requests the interrupt from
hid-cp2112-GPIO, right?

So when the USB device disconnects, then something needs to tell the
i2c-xx-driver that the I2C interface is not longer available, right?

IOW, the unbind operation needs the following notification and teardown
order:

   1) USB core notifies hid-cp2112

   2) hid-cp2112 notifies i2c-xx-driver

   3) i2c-xx-driver mops up and invokes free_irq()

   4) hid-cp2112 removes the interrupt domain

But it seems that you end up with a situation where the notification of
the i2c-xx-driver is either not happening or the driver in question is
simply failing to mop up and free the requested interrupt.

As a consequence you want to work around it by mopping up the requested
interrupts somewhere else.

It's not clear to me what you are trying to achieve here.

   If this is meant as a hardening effort to catch such issues and let
   the kernel gracefully "survive", then I'm all ears.

   If this is just meant to paper over the shortcomings of subsystems or
   driver implemtations then I'm not interested at all.

Thanks,

        tglx




