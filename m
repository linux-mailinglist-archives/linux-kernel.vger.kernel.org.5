Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787967CF292
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 10:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344957AbjJSI3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 04:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344876AbjJSI3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 04:29:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DE0C0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 01:29:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697704139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTNZQn913nqK1MFyUXNs4QgdGxSHWbAGxR3c+5S3lyg=;
        b=aCW4lG/JGZQAeeTE47th31hvvzEBUUubWaFTNjEOHbNAWQzr98BEkq17favj0ZA5gaS23t
        //5cnN5mAIGQeMyzAp92cHrlaho9NjBobVEQ5FBcKPLu1gMHJbtHMIIyHKUPIGrkewfYtz
        fiUZUmEtTnLdAj4BR2rIuxi3yNYVMSBLVTvp+XzhmbAXEuflOTIQ8bcour2g6GUQde6pKZ
        HrJyBhM90Yl8jj+3wc1J8sPaYo46qNQMZ7PZ0zxAJP5+PjUrl9VP/JQTktHvziwCU3pd18
        f5NeENB3EKLxtY2IIUcfETjjPSt8HQ9m4Vm7r3I4hSkiqlgVtpGMzJtzbe/GqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697704139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTNZQn913nqK1MFyUXNs4QgdGxSHWbAGxR3c+5S3lyg=;
        b=FvsI0VKulDqobYZe25lzTSmtij9p6bo3ObNrhBWf04rtCv6nCrUhWb3BVXH4Ak7g9qUNWv
        jKAB5Lc024NLbDBw==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <ZTDUiXnb_Sn-5bT2@MacBook-Pro-3.local>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
 <87r0m3q32t.ffs@tglx> <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
 <877cnqlxmz.ffs@tglx> <ZTDUiXnb_Sn-5bT2@MacBook-Pro-3.local>
Date:   Thu, 19 Oct 2023 10:28:58 +0200
Message-ID: <87zg0f2eyd.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19 2023 at 15:02, Wei Gong wrote:
> O Fri, Oct 13, 2023 at 10:44:36AM +0200, Thomas Gleixner wrote:
>> > By maintaining the original loop exit condition, if a mask mismatch is 
>> > detected within the loop, we will not perform the unmask_irq operation. 
>> > Instead, we will wait until the loop exits before executing unmask_irq.
>> > Could this approach potentially solve the issue of lost interrupts?
>> 
>> How so exactly?
>> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index 8f8f1d62f..b846659ce 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -823,7 +823,9 @@ void handle_edge_irq(struct irq_desc *desc)
>  		 */
>  		if (unlikely(desc->istate & IRQS_PENDING)) {
>  			if (!irqd_irq_disabled(&desc->irq_data) &&
> -			    irqd_irq_masked(&desc->irq_data))
> +			    irqd_irq_masked(&desc->irq_data) &&
> +			    cpumask_test_cpu(smp_processor_id(),
> +				    irq_data_get_effective_affinity_mask(&desc->irq_data)))
>  				unmask_irq(desc);
>  		}
>  
> @@ -832,6 +834,10 @@ void handle_edge_irq(struct irq_desc *desc)
>  	} while ((desc->istate & IRQS_PENDING) &&
>  		 !irqd_irq_disabled(&desc->irq_data));
>  
> +if (!irqd_irq_disabled(&desc->irq_data) &&
> +    irqd_irq_masked(&desc->irq_data))
> +	unmask_irq(desc);

What is this supposed to solve? The last interrupt has been delivered
already. It's the one which sets the PENDING bit.

Again:

    CPU 0                                CPU 1

    interrupt #1
	 set IN_PROGRESS
	 do {
					 change_affinity_to(CPU1);
	    handle_irq_event()
		 ack_in_device(interrupt #1)

					 interrupt #2
					    set PENDING
                                            mask();
	 } while (COND)

         unmask();

The unmask does not make the interrupt #2 magically reappear. This is
edge, which is a fire and forget mechanism. That's why we have the
PENDING bit logic for edge to ensure that no interrupt is lost.

With your change interrupt #2 is lost forever.

So if the device depends on ack_in_device() for being able to send the
next interrupt, then the lack of ack_in_device() for interrupt #2 makes
it stale.

It may well be that your particular device does not need the
ack_in_device() sequence, but this is generic core code which has to
work for everything.

I'm still having a hard time to understand why this is such a big
issue at all. What's the practical impact of processing a bunch of
interrupts on CPU0 after changing the affinity to CPU1?

  It's obviously suboptimal in terms of locality, but that's a temporary
  problem which resolves itself. It's suboptimal, but correct behaviour.

Your attempts of "fixing" it at the core edge handler level result in a
fundamental correctness problem.

There are certainly ways to solve it at that level, but for that you
have to fully understand and accept the fundamental properties and
intricacies of edge triggered interrupts in the first place.

Whether the resulting complexity is worth it, is a different
question. As long as there is not a compelling reason to do so, the
answer is simply no.

Thanks,

        tglx
