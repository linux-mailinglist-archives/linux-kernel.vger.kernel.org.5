Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7127897A5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 17:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbjHZPIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 11:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjHZPI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 11:08:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8145DE7A
        for <linux-kernel@vger.kernel.org>; Sat, 26 Aug 2023 08:08:25 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693062502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qB6NKf1rTDJjATkFH/UnaGcjPPFHSbGWib4zNLySX4=;
        b=n80ru71FgqQ47H707H+DywF5kcWVJ4sTczfrFt3IqSdSbxaSa6wZxkOIxxC4raW8wPgp0j
        3VDhE4i843uF1dUzD1GNYjsuyD3RkaFv9rYyP2KsIue2mqWcPikHUmwD7vO0X7vXP3AmMf
        PXS69HRX8lW6n1XVWpGQr0lbbLKYqI6yBVrqkIpzmjb/SUX/IuFvcyBbNHWIgum0U4NRsb
        VVUYUkb46dAcsOySSPkf3DAcnsfobElBXdpJjhilthbauM4a5tk9xAmOd6KGxRAOhVvtAY
        xxbs0TWZK49hBdNucDIRzX3x0rJ/pWz2t/7+b/uGC5kFNbnQX40o49uIlhv0VA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693062502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0qB6NKf1rTDJjATkFH/UnaGcjPPFHSbGWib4zNLySX4=;
        b=+VicHw5XE7TQ6NLCByFIavQ3dUIU/e5/099f+606qca+91TQqp0GlLuzm0KKD/gZ8/QLX+
        N5uAQhuDbpjMd2AA==
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 2/2] genirq: proc: fix a procfs entry leak
In-Reply-To: <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
References: <20230814093621.23209-1-brgl@bgdev.pl>
 <20230814093621.23209-3-brgl@bgdev.pl> <875y54ci86.ffs@tglx>
 <CAMRc=Mfg52iqFKj0QMB55K5MCxhgPLbF-0WSRG0ktN3RbofMtQ@mail.gmail.com>
 <873507cziz.ffs@tglx>
 <CAMRc=MdYteOxy87jdSEvBxnN7tx_J1X2aSsRzKZ6WKL31-ipmA@mail.gmail.com>
 <87sf87aw36.ffs@tglx>
 <CAMRc=Mcvkjmy2F=92SWRdCKL0US_YSwsvpWjcfOH9CBGw3GB0g@mail.gmail.com>
Date:   Sat, 26 Aug 2023 17:08:21 +0200
Message-ID: <87il91c04a.ffs@tglx>
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

On Fri, Aug 25 2023 at 22:07, Bartosz Golaszewski wrote:
> On Fri, Aug 25, 2023 at 7:08=E2=80=AFPM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>> The point is that something frees an in-use interrupt descriptor, which
>> is obviously wrong to begin with.
>>
> It happens in irq_dispose_mapping() when the domain is not
> hierarchical and irq_free_desc() is called in the if branch.

Again. You are explaining what the callchain is. That's not interesting
at all (I can find the places which invoke irq_free_descs() with grep).

The question is WHY is irq_dispose_mapping() called when the interrupt
in question _IS_ in use, i.e. requested and not yet released via
free_irq().

That's the underlying problem which needs to be addressed.

> Now for irqs, the consumer-facing "handle" is the interrupt number. I
> don't know what the rationale is for that as it forces us to convert
> it to a descriptor internally everytime we use it (tree lookup!) but

Perhaps because operating on an integer is not really giving you access
to the underlying mechanisms. The tree lookup is really not an issue and
it's a mechanism which is used all over the place in the kernel to
translate a cookie or identifier to the internal data representation of
a subsystem.

> As I explained before in this thread - it's perfectly normal for the
> provider of most resources in the kernel to be gone with users still
> holding the respective handles.

No. It's not most. It's only the case when the subsystem explicitely
documents that it can handle it, which the interrupt subsystem does not.

> Maybe functions in linux/interrupt.h could use some audit in order to
> make sure they can handle this.

Maybe you stop claiming that it's perfectly legit to free resources
which are in use. It's not and the interrupt subsystem never was making
this guarantee and never was designed for it.

> It seems to me that the current infrastructure is ready as all it
> takes is checking if irq_to_desc() returns a non-NULL value. Or I may
> be getting it wrong and it's much more complex than that.

Again:

It's not just NULL checks, which exist already. It's not just a stale
procfs file which needs to be removed. Did you actually look what
free_irq() does?

Obviously not, otherwise you might have noticed that removing the
resources leaks:

   1) The interrupt action itself
   2) Any interrupt threads associated with the action
   3) The procfs entry
   4) Any resource which was allocated during request_irq()
   5) Interrupt descriptor pointers stored separately for low level
      interrupt handling code

Further it might:

   1) leave hardware in an undefined state
   2) race against an interrupt being processed concurrently

How do you address this with slapping some NULL checks around? The only
way to clean this up is invoking free_irq().

>> So just claiming that it's fine to free in-use interrupts and everything
>> is greate by removing the procfs entries is just wishful thinking.
>>
>> You simply cannot free an in-use interrupt descriptor and I'm going to
>> add a big fat warning into that code to that effect.
>>
> With the above example, if our GPIO desc is analogous to the interrupt
> number in the irq world - I'm not really sure what the role of the
> irq_desc is. Should it be the *handle* that users get when they
> request an irq? Maybe it is what the GPIO device is for us? Should it
> be reference counted then?

It's an internal data structure which is not accessible outside of the
interrupt core and architecture low level code. The number is the
identifier for the consumers to interact with the core code. That
concept is called abstraction. What's so hard about that?

>> So if it turns out that this is a general problem, then we have to sit
>> down and solve it from ground up.
>
> It may very well be. I guess it will require a more detailed
> investigation. I'd still say this patch is correct though, as the
> self-contained function removing a procfs hierarchy should remove all
> sub-directories and not just leak them. They don't hold any irq
> resources anyway.

This patch is not correct at all. Once again:

 The interrupt subsystem is not designed to have its underlying
 resources be freed when an interrupt is in-use.

It's that simple. And no, your patch is not changing this. It tries to
paper over the violation of the rule of this subsystem.

The below is going to be applied ASAP to make this entirely clear. And
yes, that's going to leak a bit more than just the procfs entry.

The proper solution to this is to take a reference count on the module
which provides the interrupt chip and allocates the interrupt domain.
The core code has a mechanism for that. See request/free_irq().

Unfortunately it is not properly utilized by the irqdomain
infrastructure today. But that's a fixable problem.

Thanks,

        tglx
---
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 27ca1c866f29..5382fd4e7588 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -466,6 +466,9 @@ static void free_desc(unsigned int irq)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
=20
+	if (WARN_ON_ONCE(desc->action))
+		return;
+
 	irq_remove_debugfs_entry(desc);
 	unregister_irq_proc(irq, desc);
=20

