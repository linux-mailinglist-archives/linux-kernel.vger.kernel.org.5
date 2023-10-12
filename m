Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D07047C6F6C
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378915AbjJLNkE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:40:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343605AbjJLNkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:40:03 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB1D91
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:40:02 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id 006d021491bc7-57b67c84999so587106eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697118001; x=1697722801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ebVxWYFVeqae0XvYrqRe+JXGBKqIKAzIWjffD9Kx3L8=;
        b=R2ZgeKsfyZBzM2SF1Ode/ezIwOjDNzbOn/3odIEbvKHDFw0I7XssAgiKhezQOzeluD
         M2j/AIQ/OU+za4Tyqw8dfJBk4nTXIFUCycWeLF2m7Sl6wvUvBV5qQ08Z12k9m/j4qwQV
         WvD4J0bvyOIxj/+y3+IaRha8Kt5Qc4bwU3FCwnr4ptMYe5d6JbEA4gnQJg1Fc/kh74ON
         9x8/UxPZVQ1UzBdChbXxYejBpGDu316c8vzPsGglV1kDSlQv0jiS3dXu3NFn5+PfBJXt
         XOpw+Qm6Fzs6tvAEHNfRIe/IERvUyGQl6yT/K/Mhcb7ykSQoSKqX3MscZDB0M10v64wi
         DhKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118001; x=1697722801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebVxWYFVeqae0XvYrqRe+JXGBKqIKAzIWjffD9Kx3L8=;
        b=L4IYZ6ouP0viJdFFC6X2JMd67spS19/Ax8iHUUPAJ/Mra22GPQd0c/XzC2bzktvBSZ
         AWCocTe+6TyFkm6+pineHGmjR+U72AMFf+ra8Gjp8ouiMV7Q9VsNz37H6X+QIZSh38zx
         xGHAz+Vw52QyOckAKXr6J+UBfEGtTg5EoCuxiEbiHdTskJnYbsq3qve3rElBDv2mVMBS
         bmLnjeeeu6y75fdXHma5WR3m1VkCSVslyf9TaByVUzeg2YA74Ayt4rxU09Sw8Hl/013k
         gnOHgSVYhoWyONutUhZKnn+dgvqMIVifl05aLZ33JAbJSo7cXi6J8ox7Bmp3DAiqkoVn
         Ol+A==
X-Gm-Message-State: AOJu0YzkJsSytrk6U5gALv3N49MoHXZxkg61aCidfZPEqXMZ6czKOMPA
        UL+0mrogBhPfef9yqw/reJcyGnn14S5y3A==
X-Google-Smtp-Source: AGHT+IGjeUdp6NposgVWYSOWeO45ONYtDQKQNATrio5Xp6LGhc8HKoo1w69Ru861VPqtM65vRZC/+A==
X-Received: by 2002:a05:6358:4297:b0:135:57d0:d173 with SMTP id s23-20020a056358429700b0013557d0d173mr26265273rwc.20.1697118001301;
        Thu, 12 Oct 2023 06:40:01 -0700 (PDT)
Received: from MacBook-Pro-3.local ([111.108.111.137])
        by smtp.gmail.com with ESMTPSA id m9-20020aa79009000000b00690d4c16296sm11807368pfo.154.2023.10.12.06.39.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 06:40:00 -0700 (PDT)
Date:   Thu, 12 Oct 2023 21:39:54 +0800
From:   Wei Gong <gongwei833x@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] genirq: avoid long loops in handle_edge_irq
Message-ID: <ZSf3KrAk8fpyNEZr@MacBook-Pro-3.local>
References: <20230928100638.42116-1-gongwei833x@gmail.com>
 <87r0m3q32t.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r0m3q32t.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

O Mon, Oct 09, 2023 at 04:32:10PM +0200, Thomas Gleixner wrote:
> On Thu, Sep 28 2023 at 18:06, Wei Gong wrote:
> > --- a/kernel/irq/chip.c
> > +++ b/kernel/irq/chip.c
> > @@ -831,7 +831,9 @@ void handle_edge_irq(struct irq_desc *desc)
> >  		handle_irq_event(desc);
> >  
> >  	} while ((desc->istate & IRQS_PENDING) &&
> > -		 !irqd_irq_disabled(&desc->irq_data));
> > +		 !irqd_irq_disabled(&desc->irq_data) &&
> > +		 cpumask_test_cpu(smp_processor_id(),
> > +				   irq_data_get_effective_affinity_mask(&desc->irq_data)));
> 
> Ok. So now that mask part is correct, but what guarantees that this does
> not lose interrupts?
> 
> Assume the following scenario:
> 
>    CPU 0                                CPU 1
> 
>    interrupt
>         set IN_PROGRESS
>         do {
>                                         change_affinity_to(CPU1);
>            handle_irq_event()
>                 ack_in_device()
>                                         interrupt
>                                            set PENDING
>         } while (COND)
> 
> Now $COND is not true due to the affinity change and the edge handler
> returns. As a consequence nothing acks the device and no further
> interrupts are sent by the device.
> 
> That might not be true for your case, but that's a generic function and the
> zoo of hardware which uses that is massive.
> 
> So no, we are not taking a risk here.
> 
> Thanks,
> 
>         tglx
> 
>     
By maintaining the original loop exit condition, if a mask mismatch is 
detected within the loop, we will not perform the unmask_irq operation. 
Instead, we will wait until the loop exits before executing unmask_irq.
Could this approach potentially solve the issue of lost interrupts?

Thanks,
Wei Gong

