Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7C178BA6C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 23:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbjH1Vod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 17:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjH1VoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 17:44:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054ABA8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 14:44:02 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693259041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DboAAARXm51AnGn+cWlTQSo67qlI8rj5YDSWR7e3JZg=;
        b=wVJxeqKODdAGGPQG0l2a0F+elJUnV11BLAU7z6Wwu0xV4fEnDK6ZFNMIkCqrAomciJBk8Z
        ZUONMTKZTGg4x5FTBjHYYImolaUfD/TL6lOPOQIMMarM1rAWMKmLAoacR5lFz2yEPjduk9
        ikKEVldqDEZvhkGo4tIbW78SMeoSlFt9NjlD9p0YulXN/nsGlxUai2SX7JZ2ySXW6m58ju
        yrpqunlCiVkzlN2zitUPdWZjfKnMzva4RvP9Ys38FpD66zy41pdvBxwZLSn7CRxP0ShLs4
        GxH5/9KzgzimYrmNI6xWljJJ8fsFBh7M6RgKQoCvowV+96MjQWswzh8G+NnBDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693259041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DboAAARXm51AnGn+cWlTQSo67qlI8rj5YDSWR7e3JZg=;
        b=9m7eJg2P6Gy5mVw73NntsSXMQvd9iR6Ap/7TStnF/J5os+pI8uZuLvonaa3JMSWVWQ16GX
        JRSESf21k0KX9wCg==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=Mf9f9MxfRY+=Et9+wO5fZr61SRthcGhoHZsJ6-x6k+BgQ@mail.gmail.com>
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
Date:   Mon, 28 Aug 2023 23:44:00 +0200
Message-ID: <873502971b.ffs@tglx>
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

On Mon, Aug 28 2023 at 21:03, Bartosz Golaszewski wrote:
> On Mon, Aug 28, 2023 at 2:41=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> > I guess you're referring to irq_alloc_descs()? Anyway, here's a
>> > real-life example: we have the hid-cp2112 module which drives a
>> > GPIO-and-I2C-expander-on-a-USB-stick. I plug it in and have a driver
>> > that requests one of its GPIOs as interrupt. Now I unplug it. How has
>> > taking the reference to the hid-cp2112 module protected me from
>> > freeing an irq domain with interrupts in use?
>>
>> request_irq() does not care which module request the interrupt. It
>> always takes a refcount on irq_desc::owner. That points to the module
>> which created the interrupt domain and/or allocated the descriptors.
>>
>> IOW, this needs a mechanism to store the module which creates the
>> interrupt domain somewhere in the domain itself and use it when
>> allocating interrupt descriptors. So in your case this would take a
>> refcount on the GPIO module.
>>
> This is still not complete. In the above example, the USB bus can
> still unbind the GPIO device that created the domain on hot-unplug,
> triggering its cleanup routines (.remove(), devres chain) and
> destroying the domain and keeping the reference to the hid-cp2112
> module will not help it. This is why I suggested tracking the irq
> requests and freeing them in said cleanup path.

Are you actually reading what I write?

>> So in your case this would take a refcount on the GPIO module.

That's the module which provides the interrupt domain and hid-whatever
is the one which requests the interrupt, no?

Thanks,

        tglx
