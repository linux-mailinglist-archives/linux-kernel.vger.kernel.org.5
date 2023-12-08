Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B56280AE21
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 21:43:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574731AbjLHUnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 15:43:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHUnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 15:43:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFB1171F;
        Fri,  8 Dec 2023 12:43:25 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702068203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhWMGItMyMopaoZ9JYHTOAW7DtcvRQ4SKNAg4c9vMrk=;
        b=z/kpVp+xnVyaxaBZ8E7KDP422Tc0/FU5nU/clN/dKP5WKNzobsdK6+a1sh2Cvxy11eSlLU
        ZZc3KAeOxzZeo2tT98q92AT6JOpDOb36UU7qi/V8VHy7VR5kSf6HfHFn1F26YXIqLpy44x
        KmzNODXvLx+WCdqN3EAnck4K2N61fyDgW5gNXVqdznzi2ck5/q52wFJ/OXm1ZNL+XocXyK
        OwWVw4lCbdSYl/Tf7BYZZz+6PshSeuFzDT1tEN7Yq0Iq/oyPN057Rpz7M1ELbFnzZMgLph
        XMajUp8xWLkyv5z427R4q+YOYrtKY8/iy4PTncU9i0Vr/RjHNy2/1SOAdBg5zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702068203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FhWMGItMyMopaoZ9JYHTOAW7DtcvRQ4SKNAg4c9vMrk=;
        b=G09GrqqGjLqCD+0vATnk1ceFRWhbzIUYKuO+FvHcAywKkmU9f6GOnGnk1Q/z4BQ2BFLjjv
        IUlfWrlOkslaKBCg==
To:     Ben Wolsieffer <ben.wolsieffer@hefring.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ben Wolsieffer <ben.wolsieffer@hefring.com>
Subject: Re: [PATCH 2/2] pinctrl: stm32: fix GPIO level interrupts
In-Reply-To: <20231204203357.2897008-3-ben.wolsieffer@hefring.com>
References: <20231204203357.2897008-1-ben.wolsieffer@hefring.com>
 <20231204203357.2897008-3-ben.wolsieffer@hefring.com>
Date:   Fri, 08 Dec 2023 21:43:21 +0100
Message-ID: <87ttosqvbq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben!

On Mon, Dec 04 2023 at 15:33, Ben Wolsieffer wrote:
> The STM32 doesn't support GPIO level interrupts in hardware, so the
> driver tries to emulate them using edge interrupts, by retriggering the
> interrupt if necessary based on the pin state after the handler
> finishes.
>
> Currently, this functionality does not work because the irqchip uses
> handle_edge_irq(), which doesn't run the irq_eoi() or irq_unmask()
> callbacks after handling the interrupt. This patch fixes this by using
> handle_level_irq() for level interrupts, which causes irq_unmask() to be
> called to retrigger the interrupt.

This does not make any sense at all. irq_unmask() does not retrigger
anything. It sets the corresponding bit in the mask register, not more
not less.

Switching to handle_level_irq() makes the following difference
vs. handle_edge_irq() when an interrupt is handled (ignoring the inner
loop):

      + irq_mask();
        irq_ack();
        ....
        handle();
        ....
      + irq_unmask();

So in both cases irq_ack() clears the interrupt in the Pending register,
right?

Now comes the interesting difference.

When the interrupt is raised again after irq_ack() while the handler is
running, i.e. a full toggle from active to inactive and back to active
where the back to active transition causes the edge detector to trigger,
then:

  1) in case of handle_edge_irq() this should immediately set it in the
     pending register again and raise another CPU interrupt, which
     should be handled once the interrupt service routine returned.

  2) in case of handle_level_irq() this does not set it in the pending
     register because it's masked. The unmask will set the pending
     register bit _if_ and only _if_ the edge detector has latched the
     detection. No idea whether that's the case. The manual is
     exceptionally blury about this.

So in theory both #1 and #2 should work. But the explanation in the
changelog is fairy tale material.

As I couldn't figure out why #1 would not work, I looked at the driver
in more detail and also at the STM32 manual. That tells me that the
irqchip driver is at least suboptimal. Why?

The EXTI controller is just an intermediate between the peripheral
(including GPIO pins) and the NVIC:

         |--------------|
         | Edge config  |   |-----------------|
 Source -|              |---| Int. Mask logic |---> Dedicated NVIC interrupt
         | Edge detect  | | |-----------------|
         |--------------| |
                          | |-----------------|   
                          |-| Evt. Mask logic |---> CPU event input
                          | |-----------------|   
                          |
                          | |-----------------|   
                          |-| Wakeup logic    |--->....
                            |-----------------|   

So there are two classes of sources conntect to EXTI:

   1) Direct events

      - Have a fixed edge
      - Can be masked for Interrupt and Event generation
      - No software trigger
      - Not tracked in the Pending register
      - Can evtl. wakeup the CPUs or from D3

   2) Configurable events

      - Have a configurable edge
      - Can be masked for Interrupt and Event generation
      - Software trigger
      - Tracked in the Pending register
      - Can evtl. wakeup the CPUs or from D3

The CPU event is a single input to the CPU which can be triggered by any
source which has the Event mask enabled.

For both classes there are sources which have no connection to the NVIC,
they can only be used to generate CPU events or trigger the wakeup
logic.

For direct events there is a category where the peripherial interrupt is
routed to both the EXTI and the NVIC directly. The EXTI does not provide
a connection to the NVIC and the event cannot be masked in EXTI to
prevent CPU interrupts. Only the CPU event masking works.

GPIO pins are configurable events which are connected to the NVIC via
the EXTI.

But the EXTI driver implements a chained interrupt handler which listens
on a ton of NVIC interrupts. I.e. for the STM32H7 on:

  <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <62>, <76>

NVIC   1: PVD_PVM           EXTI-SRC 16
NVIC   2: RTC_TAMP_STAMP    EXTI-SRC 18
NVIC   3: RTC_WAKEUP        EXTI-SRC 19
NVIC   6: EXTI0             EXTI-SRC  0
NVIC   7: EXTI1             EXTI-SRC  1
NVIC   8: EXTI2             EXTI-SRC  2
NVIC   9: EXTI3             EXTI-SRC  3
NVIC  10: EXTI4             EXTI-SRC  4
NVIC  23: EXTI5-9           EXTI-SRC  5-9
NVIC  40: EXTI10-15         EXTI-SRC 10-15
NVIC  41: RTC_ALARM         EXTI-SRC 17
NVIC  62: ETH_WKUP          EXTI-SRC 86
NVIC  76: OTG_HS_WKUP       EXTI-SRC 43

Each of these chained interrupts handles the full EXTI interrupt domain
with all three banks. This does not make any sense at all especially not
on a SMP machine.

Though it _should_ work, but it might cause interrupts handlers to be
invoked when nothing is pending when the edge handler is active. Which
in turn can confuse the underlying device driver depending on the
quality...

CPU0					CPU1

NVIC int X                      	NVIC int Y

 // read_pending() is serialized by a lock, but both read the same state
 pend = read_pending()			pend = read_pending()
 
 for_each_bit(bit, pend)	 	for_each_bit(bit, pend)	
    handle_irq(domain, base + bit)         handle_irq(domain, base + bit)
      lock(desc);                            lock(desc);
      ack();
      do {
         clear(PENDING);
         set(IN_PROGRESS);
         unlock(desc);
         handle();                           if (IN_PROGRESS) {
         lock(desc);                           ack();
                                               set(PENDING);
         				       unlock(desc);
         clear(IN_PROGRESS);                   return;
                                             }
      } while (PENDING); <- Will loop

See?

In fact the only NVIC interrupts which actually need demultiplexing are
NVIC #23 and NVIC #40 and those should only care about the EXTI
interrupts which are actually multiplexed on them. This let's randomly
run whatever is pending on any demux handler is far from correct.

All others are direct NVIC interrupts which just have the extra EXTI
interrupt masking, event masking and the wakeup magic. The indirection
via the chained handler is just pointless overhead and not necessarily
correct.

The exti_h variant of that driver does the right thing and installs a
hierarchical interrupt domain which acts as man in the middle between
the source and the NVIC. Though granted they don't have the odd problem
of multiplexing several GPIO interrupts to a single NVIC interrupt.

But in fact the regular exti driver could do the same and just handle
the two NVIC interrupts which need demultiplexing separately and let
everything else go through the hierarchy without bells and whistles.

Thanks,

        tglx
