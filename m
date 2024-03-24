Return-Path: <linux-kernel+bounces-112849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A61887EFB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:05:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F38FDB2114E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 21:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F318199BC;
	Sun, 24 Mar 2024 21:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UO2eYZCY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+Kosm0xv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87C749A
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 21:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711314339; cv=none; b=XfeUMnvL8RfRm16GukQl2dU+LuTBjovyR5NowOpsCeHwStaqCr+HtT5XzstgyVlXgknhMAbHueGZIl5Ddaq8m7F79RpCS+AhDAJRzQ7IY3NkV+/cDdzh73Dzk38BwMsyVdLZvEprlt/z1kq7WM90/bLYb/SwK/Egr7xI54VBfNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711314339; c=relaxed/simple;
	bh=eIWsYgeCvuULR3OVAMxcSHtDf1Ppf8K414oZ8pPgvDk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTA/OSuve4iipaPb6EwFz4RwKjjgTeg79Bs87ALFkGWp+apvsvmenWHbMOjxrcB8RaoJsnAa/i8ghY3d0w8EGwv76HB4O0wkwFjpyhM3kb0eDX9C8MH1aT6gesnOoHDi3JicKJ9VHjzxXk+HA3zwf0EWNu/urupY1eZxoRHBPO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UO2eYZCY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+Kosm0xv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711314336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOl9H6TQJGR2f/SWJSnA/4BR3k9Fhg4eknY4AbucXbk=;
	b=UO2eYZCYpjesx2fP1TkVAZZ4u5YMXz56TGrRNBtvp1NMwh2prZPQg8DhydNXcUIJgUaiim
	4b4KNQ4BJycRML2sf37b1Qdzoezt9/LOK3Qlk//rnEpkiclUeyamFLrWIaV5b63uRcrtmA
	wTYKuz5B98WjM8U5QyCXa756BbPCKSqjRM4ktEvHvpYSTPI1wzYWjZ9fwG52I7yEU8D6jd
	DVd33ey1xyJyGhDJCz5SvJgMtZaaJ6HiUE6qT3pBn12v1NKNBA9PBEgu4MEVVBYRj7AXKJ
	IFGLJLYz4agzOeBm+hPwIsBtmdx6O0INB1ag/mchG9uemKnqYwv9czjYpsTldA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711314336;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GOl9H6TQJGR2f/SWJSnA/4BR3k9Fhg4eknY4AbucXbk=;
	b=+Kosm0xvj+xhHpE/g1uaxNM83+/Ggqe+5faIVpoIaTKgMg65tfDHf45MmSszP9nap7onsB
	Pg2W0TScem0EhWBA==
To: Jacob Pan <jacob.jun.pan@linux.intel.com>, Dimitri Sivanich
 <sivanich@hpe.com>
Cc: David Woodhouse <dwmw2@infradead.org>, Lu Baolu
 <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon
 <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Steve Wahl
 <steve.wahl@hpe.com>, Russ
 Anderson <russ.anderson@hpe.com>, jacob.jun.pan@linux.intel.com
Subject: Re: [PATCH] Allocate DMAR fault interrupts locally
In-Reply-To: <20240321151357.1d18127f@jacob-builder>
References: <ZeDj/LK56borSxO4@hpe.com> <87plwe7w3m.ffs@tglx>
 <Ze9r47riIq9ovBCY@hpe.com> <20240321151357.1d18127f@jacob-builder>
Date: Sun, 24 Mar 2024 22:05:35 +0100
Message-ID: <87msqnfihs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob!

On Thu, Mar 21 2024 at 15:13, Jacob Pan wrote:
> On Mon, 11 Mar 2024 15:38:59 -0500, Dimitri Sivanich <sivanich@hpe.com>
> wrote:
>> So the code seems to have been designed based on the assumption that it
>> will be run on an already active (though not necessarily fully onlined?)
>> cpu.  To make this work, any code based on that assumption would need to
>> be fixed.  Otherwise, a different approach is needed.
>
> This may not be pretty but since DMAR fault is for unrecoverable faults,
> they are rare and infrequent, should never happen on a healthy system. Can
> we share one BSP vector for all DMARs? i.e. let dmar_fault() handler search
> for the offending DMAR for fault reasons.

It might not be pretty on the first thought, but it has a charm.

You are right. If DMAR faults happen then there is an issue which is
going to affect the machine badly anyway, so the extra search through
the iommu list is not necessarily horrible and it does not matter at all
whether the access is local or not.

But there are two interrupts involved. The DMAR one and the SVM one.

And all of that DMAR/SVM code is built around the assumption that
everything can be set up at boot time on the BSP.

The DMAR case definitely is solvable by sharing the interrupt, see the
uncompiled below. I still need to wrap my brain around the SVM part, but
feel free to beat me to it or preferrably explain to me that it's not
necessary at all :)

Thanks,

        tglx
---
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1182,7 +1182,6 @@ static void free_iommu(struct intel_iomm
 			iommu->pr_irq = 0;
 		}
 		free_irq(iommu->irq, iommu);
-		dmar_free_hwirq(iommu->irq);
 		iommu->irq = 0;
 	}
 
@@ -1956,17 +1955,21 @@ void dmar_msi_mask(struct irq_data *data
 	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
 }
 
-void dmar_msi_write(int irq, struct msi_msg *msg)
+static void dmar_iommu_msi_write(struct intel_iommu *iommu, struct msi_msg *msg)
 {
-	struct intel_iommu *iommu = irq_get_handler_data(irq);
 	int reg = dmar_msi_reg(iommu, irq);
-	unsigned long flag;
+	unsigned long flags;
 
-	raw_spin_lock_irqsave(&iommu->register_lock, flag);
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 	writel(msg->data, iommu->reg + reg + 4);
 	writel(msg->address_lo, iommu->reg + reg + 8);
 	writel(msg->address_hi, iommu->reg + reg + 12);
-	raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+}
+
+void dmar_msi_write(int irq, struct msi_msg *msg)
+{
+	dmar_iommu_msi_write(irq_get_handler_data(irq), msg);
 }
 
 void dmar_msi_read(int irq, struct msi_msg *msg)
@@ -2100,23 +2103,37 @@ irqreturn_t dmar_fault(int irq, void *de
 
 int dmar_set_interrupt(struct intel_iommu *iommu)
 {
-	int irq, ret;
+	static int dmar_irq;
+	int ret;
 
-	/*
-	 * Check if the fault interrupt is already initialized.
-	 */
+	/* Don't initialize it twice for a given iommu */
 	if (iommu->irq)
 		return 0;
 
-	irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
-	if (irq > 0) {
-		iommu->irq = irq;
+	/*
+	 * There is one shared interrupt for all IOMMUs to prevent vector
+	 * exhaustion.
+	 */
+	if (!dmar_irq) {
+		int irq = dmar_alloc_hwirq(iommu->seq_id, iommu->node, iommu);
+
+		if (irq <= 0) {
+			pr_err("No free IRQ vectors\n");
+			return -EINVAL;
+		}
+		dmar_irq = irq;
 	} else {
-		pr_err("No free IRQ vectors\n");
-		return -EINVAL;
+		struct msi_msg msg;
+
+		/*
+		 * Get the MSI message from the shared interrupt and write
+		 * it to the iommu MSI registers.
+		 */
+		dmar_msi_read(dmar_irq, &msg);
+		dmar_iommu_msi_write(iommu, &msg);
 	}
 
-	ret = request_irq(irq, dmar_fault, IRQF_NO_THREAD, iommu->name, iommu);
+	ret = request_irq(dmar_irq, dmar_fault, IRQF_NO_THREAD | IRQF_SHARED, iommu->name, iommu);
 	if (ret)
 		pr_err("Can't request irq\n");
 	return ret;

