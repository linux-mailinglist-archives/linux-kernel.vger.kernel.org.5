Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1BA578B0C2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjH1Mlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:41:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjH1MlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:41:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE10DE5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 05:41:16 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693226474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxSLNJCbx+KNYYLloHFBBla7B8CjkoO2HEbeDsdvQvk=;
        b=Z1cL8nd11qvV/L8+bn8wyaK+qEb8D9tnpGEgqB5lDDCjR3Jg6Z8lFuEQQP9+0i5gP1yuvB
        L0a/zr+vCAnbA7B/3HMC97TI855rNfEOAVm/hbeU3OeshRva6grnJtGrlgy0aJsXXAUXvw
        uknCUb/5LC+AczjAaURzBJrFZa3Qvh4VP47hK9tgfHylqFkr6QiFRBxis+S407a0Yud3Qc
        CL8U/Lh5kvm0wLgq9Ky6LJmh7EYT8cyTaIMiHo0gsQeEuz3tHvbnH7lxEOvqtdW+y2Pz9y
        4Z/A0acDbZ+4frsgE2VCeS2AUuz7oArPDc3+2r7FKd50Uc3fx2k9g9gvZMON+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693226474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxSLNJCbx+KNYYLloHFBBla7B8CjkoO2HEbeDsdvQvk=;
        b=RFT7BsdRgHfAO/7mPArofsVV4myOkPgOFJRegFqHRYfsq8zdExHEfodWciwEOrrckHs7KE
        zB8heV3MlPe2bzCQ==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
 <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx>
 <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
 <87il91c04a.ffs@tglx>
 <CAMRc=MfB=sMEmK02Y6SaG1T4PFZW2OD+box7NNoDY3KM1AchLA@mail.gmail.com>
Date:   Mon, 28 Aug 2023 14:41:14 +0200
Message-ID: <87o7ir8hlh.ffs@tglx>
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

On Mon, Aug 28 2023 at 12:06, Bartosz Golaszewski wrote:
> On Sat, Aug 26, 2023 at 5:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> How do you address this with slapping some NULL checks around? The only
>> way to clean this up is invoking free_irq().
>>
>
> This is not what I meant, let me rephrase the question:
>
> Is there any reason why whatever operations irq_free() performs could
> not be done by the irqchip when it knows it will be destroyed with
> irqs still in use? And then any new management operation that would be
> called by the now orphaned user would just bail out? Maybe not, I'm
> asking this question because I don't know and it's not obvious from
> the code.

The irqchip can do nothing and it is not directly involved in freeing
the interrupt descriptor. The entity, which allocated the interrupt
descriptors is responsible for that. That's in most modern cases the
interrupt domain.

It might be possible to free the actions in a teardown operation, but
that needs a lot of thoughts vs. concurrency and life time rules. A
simple 'let's invoke free_irq()' does not cut it.

>> The proper solution to this is to take a reference count on the module
>> which provides the interrupt chip and allocates the interrupt domain.
>> The core code has a mechanism for that. See request/free_irq().
>
> I guess you're referring to irq_alloc_descs()? Anyway, here's a
> real-life example: we have the hid-cp2112 module which drives a
> GPIO-and-I2C-expander-on-a-USB-stick. I plug it in and have a driver
> that requests one of its GPIOs as interrupt. Now I unplug it. How has
> taking the reference to the hid-cp2112 module protected me from
> freeing an irq domain with interrupts in use?

request_irq() does not care which module request the interrupt. It
always takes a refcount on irq_desc::owner. That points to the module
which created the interrupt domain and/or allocated the descriptors.

IOW, this needs a mechanism to store the module which creates the
interrupt domain somewhere in the domain itself and use it when
allocating interrupt descriptors. So in your case this would take a
refcount on the GPIO module.

Thanks,

        tglx
