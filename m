Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058D67B175A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjI1J2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjI1J2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:28:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEFAC
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:28:13 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1695893291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzjhCOHnVrOWVu3L5BYh5+IXRIcy2pH3k0v3ndT/lxQ=;
        b=dKZhPIHcElXNxGS8THs4uvYfHwZ0aDzq5rpvddM0GIB+PpypbIYAjKvg2wlwCT2Q1xEjTi
        +xqfds0SdCrxlgOx7HEw5FPOJwhnQaEjFNHU1wlvyScxDX3zFny2Kb5vxA5x8hbGabyvT2
        1oqSUcY99f8svb2F87tRprO7TDxbG02wrm+7JwTIwXFKjT7hVvVYap7O2o1Js1yUFMvkK/
        HrCGktQzPbzMEQqRh66BKAYGYiWpwFjHxdFN19vv9R6597kf3tUwiYKY9ixqJfk+4v8eWR
        NNSjBj88Qt/FjIBrUsaEg+e2QDSazRfh+hLVBM1tWDamhb+35EAeXdNaBRU3hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1695893291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YzjhCOHnVrOWVu3L5BYh5+IXRIcy2pH3k0v3ndT/lxQ=;
        b=70MgudQgIU0oyenS2bcXWUrrgHk8f3TaVcpqZpDBvb2IUjxIuLvtEPjCF5G3243+V8qJoT
        l6vlLMD1u44vJcDg==
To:     Wei Gong <gongwei833x@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] genirq: avoid long loops in handle_edge_irq
In-Reply-To: <ZRTjgdptO5jswGwC@MacBook-Pro-3.local>
References: <20230925025154.37959-1-gongwei833x@gmail.com>
 <87msx9f7a2.ffs@tglx> <ZRPfjC9JEeUx8zKY@MacBook-Pro-3.local>
 <87edijfxjv.ffs@tglx> <ZRTjgdptO5jswGwC@MacBook-Pro-3.local>
Date:   Thu, 28 Sep 2023 11:28:10 +0200
Message-ID: <87bkdmfxzp.ffs@tglx>
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

On Thu, Sep 28 2023 at 10:22, Wei Gong wrote:
> On Wed, Sep 27, 2023 at 05:25:24PM +0200, Thomas Gleixner wrote:
>> On Wed, Sep 27 2023 at 15:53, Wei Gong wrote:
>> > O Tue, Sep 26, 2023 at 02:28:21PM +0200, Thomas Gleixner wrote:
>> >> On Mon, Sep 25 2023 at 10:51, Wei Gong wrote:
>> >> > diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
>> >> > index dc94e0bf2c94..6da455e1a692 100644
>> >> > --- a/kernel/irq/chip.c
>> >> > +++ b/kernel/irq/chip.c
>> >> > @@ -831,7 +831,8 @@ void handle_edge_irq(struct irq_desc *desc)
>> >> >  		handle_irq_event(desc);
>> >> >  
>> >> >  	} while ((desc->istate & IRQS_PENDING) &&
>> >> > -		 !irqd_irq_disabled(&desc->irq_data));
>> >> > +		 !irqd_irq_disabled(&desc->irq_data) &&
>> >> > +		 cpumask_test_cpu(smp_processor_id(), irq_data_get_affinity_mask(&desc->irq_data)));
>> >> 
>> >> Assume affinty mask has CPU0 and CPU1 set and the loop is on CPU0, but
>> >> the effective affinity is on CPU1 then how is this going to move the
>> >> interrupt?
>> >
>> > Loop is on the CPU0 means that the previous effective affinity was on CPU0.
>> > When the previous effective affinity is a subset of the new affinity mask,
>> > the effective affinity will not be updated.
>> 
>> That's an implementation detail of a particular interrupt chip driver,
>> but not a general guaranteed behaviour.
>> 
>
> Can replacing irq_data_get_affinity_mask with irq_data_get_effective_affinity_mask
> solve this issue?

Yes.
