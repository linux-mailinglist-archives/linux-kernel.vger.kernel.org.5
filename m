Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEEDE7AF03A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234990AbjIZQGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIZQGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:06:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA72A11D
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 09:06:37 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695744390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s3ovhY9DoI1Yv3XFQPJUSt8S5TK7amx22b1Uakj1jc=;
        b=q4HPKlgxtFUnEGBXi2fRhpXW33qoQDy9cJe1FAc5HnDXSVVwTZXVsfK9rT72bjehc2V470
        iPzB8UI+9WHqoZr9MekwiZBlmi3tEAWz1TuoCg+r80b/3+5IsvUxgmUGdf96mL2kEZGrOs
        qgvp7cOJJeAMElnQMUzwgdXKR/HDw339lOO98JCGqzJRBBm9i5sOiM1IyFcA48BgUC1dO8
        Ud2fpuy+DCxhfJM2BD5Zws4nJLDOpx7qp03pBJ63xDWI8/+eo+zUjLOXpHBexcgC6OHEmq
        uezxl36ibg+kl7/mSQwFfcet8HFD5z1BFgwYr+nYaNQM04Z3/vlw+WV1Bpw5lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695744390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8s3ovhY9DoI1Yv3XFQPJUSt8S5TK7amx22b1Uakj1jc=;
        b=3j0xfBLVa9slRLFlAajouhC1FJ56wK/JheeE8UjkUJcPPGPJ9ayOJVgFSebEacre7RidA+
        vf6Sfmo6WDYuSUDg==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Wei Gong <gongwei833x@gmail.com>
Subject: Re: [PATCH v2] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <20230925025154.37959-1-gongwei833x@gmail.com>
References: <20230925025154.37959-1-gongwei833x@gmail.com>
Date:   Tue, 26 Sep 2023 14:28:21 +0200
Message-ID: <87msx9f7a2.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25 2023 at 10:51, Wei Gong wrote:
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index dc94e0bf2c94..6da455e1a692 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
>  		handle_irq_event(desc);
>  
>  	} while ((desc->istate & IRQS_PENDING) &&
> -		 !irqd_irq_disabled(&desc->irq_data));
> +		 !irqd_irq_disabled(&desc->irq_data) &&
> +		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));

Assume affinty mask has CPU0 and CPU1 set and the loop is on CPU0, but
the effective affinity is on CPU1 then how is this going to move the
interrupt?

Thanks,

        tglx
