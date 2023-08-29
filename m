Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECC5078CFC9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 01:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239836AbjH2XAx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbjH2XAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 19:00:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A13CE7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 16:00:40 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1693350038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=eRsq6z4bI01UDfoYoOiOk2ujqJLXFQ0iRDcqbzQ/r6U=;
        b=E5SLHgU6ielUcv4yazDB9AQ/RU9Pbc2O+W9whGtE4bYLRu/UkANOVdlVggiF/nwwwG/ySU
        1NU8q4VjMpk88w5Q5Bpf6yUS1RX5QNRNX4C0JbJqunVu8wlvyJNDSyVhcPekI2l90PMyE/
        QznhC7ax2IdHBvbjo3m2D5jJw7GHRL0ifLDJ3bAaW5bntVe8HmMYqD62vXhAc1ZXZ2MGDc
        ajE6oLJiGJ3pp327GcEIwKBc0m+ax2PwQTQtNbKLdPw7opeMR+Y73oo60mlCAgT8MSXjRd
        VqK3OehXiD33XwwMJx21Is9qqTZhpsBm5u2VQIj2y8s99W89ZPc4Q7yiPCHDJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1693350038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=eRsq6z4bI01UDfoYoOiOk2ujqJLXFQ0iRDcqbzQ/r6U=;
        b=+YvxJwTdYFUXJ/I1bWrhWT7G0W3on/kLPEHkwqM/4TdhJ7h6YaVZPB/+f3MQ+HVNsK+ncj
        yYKmHegbA3G4oVBA==
To:     Marc Zyngier <maz@kernel.org>, John Garry <john.garry@huawei.com>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>, linux-kernel@vger.kernel.org
Subject: Re: PCI MSI issue with reinserting a driver
In-Reply-To: <3d3d0155e66429968cb4f6b4feeae4b3@kernel.org>
Date:   Wed, 30 Aug 2023 01:00:38 +0200
Message-ID: <87350178tl.ffs@tglx>
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

On Wed, Feb 03 2021 at 17:23, Marc Zyngier wrote:
> On 2021-02-02 15:46, John Garry wrote:
>> On 02/02/2021 14:48, Marc Zyngier wrote:
>>> We can't really do that. All the events must be contiguous,
>>> and there is also a lot of assumptions in the ITS driver that
>>> LPI allocations is also contiguous.
>>> 
>>> But there is also the fact that for Multi-MSI, we *must*
>>> allocate 32 vectors. Any driver could assume that if we have
>>> allocated 17 vectors, then there is another 15 available.

In theory. In practice no driver can assume that simply because there is
no corresponding interrupt descriptor. The PCI/MSI code allocates $N
vectors, the MSI code allocates exactly $N interrupt descriptors, so
there is no way that the driver can make up N = round_up_power_of_to($N)
magically.

The only reason why this makes sense is when its_dev and the associated
bitmap is shared between devices because that way you ensure that above
the non-allocated interrupts there is a gap up to the next power of two
to catch malfunctioning hardware/drivers.

If its_dev is not shared, then this makes no difference as the gap is
there naturaly.

> I'm not overly keen on handling this in the ITS though, and I'd rather
> we try and do it in the generic code. How about this (compile tested
> only)?
...
> @@ -1399,8 +1399,19 @@ static void irq_domain_free_irqs_hierarchy(struct 
> irq_domain *domain,
>   		return;
>
>   	for (i = 0; i < nr_irqs; i++) {
> -		if (irq_domain_get_irq_data(domain, irq_base + i))
> -			domain->ops->free(domain, irq_base + i, 1);
> +		int n ;
> +
> +		/* Find the largest possible span of IRQs to free in one go */
> +		for (n = 0;
> +		     ((i + n) < nr_irqs &&
> +		      irq_domain_get_irq_data(domain, irq_base + i + n));
> +		     n++);
> +
> +		if (!n)
> +			continue;
> +
> +		domain->ops->free(domain, irq_base + i, n);
> +		i += n;

TBH. That makes my eyes bleed and it's just an ugly workaround, which
works by chance for that ITS implementation detail. That's really not
the place to do that.

I've stared at this before when I was doing the initial PoC to convert
GIC over to the per device MSI domain model and did not come up with a
solution to implement support for dynamic PCI-MSI allocation.

I know that you need a fix for the current code, but we really should
move all this muck over to the per device model which makes this way
simpler as you really have per device mechanisms.

The underlying problem is the whole bulk allocation/free assumption in
the ITS driver, which you need to address anyway when you ever want to
support dynamic PCI/MSI-X and PCI/IMS.

For that this really needs to be properly split up:

   1) Initialization: Reserve a LPI bitmap region for a sufficiently
      large number of MSI interrupts which handles the power of 2
      requirement

   2) Alloc: Allocate the individual interrupts within the bitmap
      region

   3) Free: Free the individual interrupts and just clear the
      corresponding bit within the bitmap region

   4) Teardown: Release the bitmap region

But lets look at that later.

For the problem at hand I rather see something like the below instead of
this hideous 'try to find a range' hackery which is incomprehensible
without a comment the size of a planet.

That's not pretty either, but at least it makes it entirely clear that
the underlying irqdomain requires this for whatever insane reason.

Thanks,

        tglx
---
 include/linux/irqdomain.h |    8 ++++++++
 kernel/irq/irqdomain.c    |    9 +++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -208,6 +208,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
 
+	/* Irq domain requires bulk freeing of interrupts */
+	IRQ_DOMAIN_FREE_BULK		= (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -572,6 +575,11 @@ static inline bool irq_domain_is_msi_dev
 	return domain->flags & IRQ_DOMAIN_FLAG_MSI_DEVICE;
 }
 
+static inline bool irq_domain_free_bulk(struct irq_domain *domain)
+{
+	return domain->flags & IRQ_DOMAIN_FREE_BULK;
+}
+
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1442,14 +1442,19 @@ static void irq_domain_free_irqs_hierarc
 					   unsigned int irq_base,
 					   unsigned int nr_irqs)
 {
-	unsigned int i;
+	unsigned int i, tofree = 1;
 
 	if (!domain->ops->free)
 		return;
 
+	if (irq_domain_free_bulk(domain)) {
+		tofree = nr_irqs;
+		nr_irqs = 1;
+	}
+
 	for (i = 0; i < nr_irqs; i++) {
 		if (irq_domain_get_irq_data(domain, irq_base + i))
-			domain->ops->free(domain, irq_base + i, 1);
+			domain->ops->free(domain, irq_base + i, tofree);
 	}
 }
 
