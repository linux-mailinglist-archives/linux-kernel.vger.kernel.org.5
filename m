Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 454607BE2D9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 16:32:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbjJIOcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 10:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjJIOcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 10:32:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64DC19E
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 07:32:15 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696861931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRfnMjNIXZBaxYosW9RF4JgfCE/f8ZpF2zkbOj/f4Uc=;
        b=2/p+FZGvxwS0D8pUxzDkDFNWe6ycuFI8S+zJ/wCIQ/lH/byNrNhjm+ck/TEQx/YLgDVVvr
        9XIUYXxvcUrpd+x4BgCCyqHAYzBXKU2anp7xJFP8yfRuSOVlU4Qyd95TWWB4vCK/BrOTYn
        3Rw/iBC44hMfZEZ6L3CnuS4WcQoDnB74j+wE9v+8Fb6BbPay6kaLYusmlYaHxAucN0DSGr
        TCdG3tBSKs30eNlD/aYoeSocq/Df0KdptohaIyDrne+6fbS6Wn3z6jQZvM/RpG4L9p+Ouf
        RZhedfO+6H7LYzzlgSMlknTAOuydWmrPqomwPnbFRWA00Hwsn/pb4xNuYmuNSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696861931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bRfnMjNIXZBaxYosW9RF4JgfCE/f8ZpF2zkbOj/f4Uc=;
        b=saorFBDKf0FVKlDJVqFY3GG+LE1DEPFDEgwU6PjVLl3iQDADZVEpkGnoPVtkg+wu7+kfdH
        YTksDkXOtvU0A9Dw==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <20230928100638.42116-1-gongwei833x@gmail.com>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
Date:   Mon, 09 Oct 2023 16:32:10 +0200
Message-ID: <87r0m3q32t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28 2023 at 18:06, Wei Gong wrote:
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -831,7 +831,9 @@ void handle_edge_irq(struct irq_desc *desc)
>  		handle_irq_event(desc);
>  
>  	} while ((desc->istate & IRQS_PENDING) &&
> -		 !irqd_irq_disabled(&desc->irq_data));
> +		 !irqd_irq_disabled(&desc->irq_data) &&
> +		 cpumask_test_cpu(smp_processor_id(),
> +				   irq_data_get_effective_affinity_mask(&desc->irq_data)));

Ok. So now that mask part is correct, but what guarantees that this does
not lose interrupts?

Assume the following scenario:

   CPU 0                                CPU 1

   interrupt
        set IN_PROGRESS
        do {
                                        change_affinity_to(CPU1);
           handle_irq_event()
                ack_in_device()
                                        interrupt
                                           set PENDING
        } while (COND)

Now $COND is not true due to the affinity change and the edge handler
returns. As a consequence nothing acks the device and no further
interrupts are sent by the device.

That might not be true for your case, but that's a generic function and the
zoo of hardware which uses that is massive.

So no, we are not taking a risk here.

Thanks,

        tglx

    
