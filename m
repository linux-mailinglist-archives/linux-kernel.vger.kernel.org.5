Return-Path: <linux-kernel+bounces-119868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D4888CDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E927303685
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F3513D28F;
	Tue, 26 Mar 2024 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XhiNBpO7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="so1j1EtX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F6B3DABE1
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711483867; cv=none; b=ugUPNo0dB8NdrQ8VG0opEsLvbyccc7ogSgnP9jPN4FLvaoRmP/Vnuku1nUugrAf9HB/71fEn101E4mC+keSxL0tefWCjiILpgsX74i3ANhjjmdapj3+2tpkVdgnpOqHPDWCqZxeC6ml+hq88wdmkSeK3oIGmjz6cVPaugSV91qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711483867; c=relaxed/simple;
	bh=Qi86T8D/aetNJkBkIbzpDTWiOksu1tk7OALuKOcCL1E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nT95cyq7BUWpKAdRcb5HBDG0MTG3Ic8vl6P6aInPASP9cExhM69saXoK5c4RH2WdJWywL9JphNYIBkr3OZizJ3nX54LJXIbUkkD0Ys51Rb3OFV/iwmXP/aut5LnR5TS04XGNo1WQNF4cyYZZZMv67Oewlnt+A/qJY9S//vtPpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XhiNBpO7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=so1j1EtX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711483864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLYsrPiq5J0wZCfj/q/s3RyXPXdnzXn/EJnAMhRjnNM=;
	b=XhiNBpO7K8eF9NaGaXZqaLBez6KTX8VZWWfXmIAeqJ38bZ2sg52o8z1mYLrpCVMcVVTXkx
	2aXCo08qv0112q6lnpGPfibcRvvL04rKEvKBnI/nZsqObQPXdQTWpAovN6DdqiKd44BCoQ
	8X+e0brBjmhiXsWKJ0AXH0hlaMfBVQ2O9Syu3KfynU5MRZ5chzdzAh1P/O8ruiz0ed0x5Z
	PgyoYN2F+dnco5oFw2dw9f92M1JW81eK2LzZqDPw5OnsOTa8vvD5xXWYhZ1C0hdTfVSJCb
	jBTfhdX3d3XuTBemBJif5eoit1Pj9evYeQu9Q2r+3wr+p+IvSoUbG1g0B88P3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711483864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLYsrPiq5J0wZCfj/q/s3RyXPXdnzXn/EJnAMhRjnNM=;
	b=so1j1EtXxDx/CBeJgbfuTx9V9+Jc4ZFzK7AJYhWwQ99HWJlykwLf84Y2x4cgUdipnALRYC
	fXEJ1PLg9n/sjzBw==
To: Jason Gunthorpe <jgg@ziepe.ca>, "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>, Bixuan Cui
 <cuibixuan@huawei.com>, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Peng Fan
 <peng.fan@nxp.com>
Subject: Re: [PATCH 3/3] iommu/arm-smmu-v3: support suspend/resume
In-Reply-To: <87bk72fcf4.ffs@tglx>
References: <20240324-smmu-v3-v1-0-11bc96e156a5@nxp.com>
 <20240324-smmu-v3-v1-3-11bc96e156a5@nxp.com>
 <20240325134848.GA8419@ziepe.ca> <87bk72fcf4.ffs@tglx>
Date: Tue, 26 Mar 2024 21:11:03 +0100
Message-ID: <87msqkeotk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25 2024 at 18:29, Thomas Gleixner wrote:
> On Mon, Mar 25 2024 at 10:48, Jason Gunthorpe wrote:
>> On Sun, Mar 24, 2024 at 08:29:00PM +0800, Peng Fan (OSS) wrote:
>>> +	if (smmu->features & ARM_SMMU_FEAT_PRI) {
>>> +		desc = irq_get_msi_desc(smmu->priq.q.irq);
>>> +		if (desc) {
>>> +			get_cached_msi_msg(smmu->priq.q.irq, &msg);
>>> +			arm_smmu_write_msi_msg(desc, &msg);
>>> +		}
>>> +	}
>>> +}
>>
>> I wonder if this should be done instead by converting the driver away
>> from platform MSI to the new MSI mechanism?
>
> There is work in progress for that. Should come around in the next
> weeks.

But that won't solve it. The above is a horrible hack and I think this
should be solved completely differently.

On suspend the core interrupt code disables all interrupts which are not
marked as wakeup interrupts. On resume it reenables them including
restoring the affinity setting.

So this just should work, but it does not because the MSI message is
only written once, when the interrupt is activated. Further affinity
changes affect only the ITS table and do not result in a message write.

The most trivial way w/o changing any core code for it, would be to free
the interrupts on suspend and request them on resume again, because that
would deactivate and reactivate it.

Though that does not work if the IOMMU is resumed in the early resume
path. But we can enforce writing the message in the resume path.
See the untested below.

Thanks,

        tglx
---
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -223,6 +223,7 @@ struct irq_data {
  *				  irqchip have flag IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND set.
  * IRQD_RESEND_WHEN_IN_PROGRESS	- Interrupt may fire when already in progress in which
  *				  case it must be resent at the next available opportunity.
+ * IRQD_RESUMING		- Interrupt is resumed after suspend
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -249,6 +250,7 @@ enum {
 	IRQD_AFFINITY_ON_ACTIVATE	= BIT(28),
 	IRQD_IRQ_ENABLED_ON_SUSPEND	= BIT(29),
 	IRQD_RESEND_WHEN_IN_PROGRESS    = BIT(30),
+	IRQD_RESUMING			= BIT(31),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -443,6 +445,11 @@ static inline bool irqd_needs_resend_whe
 	return __irqd_to_state(d) & IRQD_RESEND_WHEN_IN_PROGRESS;
 }
 
+static inline bool irqd_resuming(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_RESUMING;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -617,6 +617,7 @@ static unsigned int msi_domain_get_hwsiz
 static inline void irq_chip_write_msi_msg(struct irq_data *data,
 					  struct msi_msg *msg)
 {
+	irq_data_get_msi_desc(data)->msg = *msg;
 	data->chip->irq_write_msi_msg(data, msg);
 }
 
@@ -652,7 +653,10 @@ int msi_domain_set_affinity(struct irq_d
 	int ret;
 
 	ret = parent->chip->irq_set_affinity(parent, mask, force);
-	if (ret >= 0 && ret != IRQ_SET_MASK_OK_DONE) {
+	if (ret < 0)
+		return ret;
+
+	if (ret != IRQ_SET_MASK_OK_DONE || irqd_resuming(irq_data)) {
 		BUG_ON(irq_chip_compose_msi_msg(irq_data, msg));
 		msi_check_level(irq_data->domain, msg);
 		irq_chip_write_msi_msg(irq_data, msg);
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -177,7 +177,13 @@ static void resume_irq(struct irq_desc *
 	irq_state_set_masked(desc);
 resume:
 	desc->istate &= ~IRQS_SUSPENDED;
+	/*
+	 * Ensure that MSI messages get rewritten on resume. The device
+	 * might have lost it due to power disabling.
+	 */
+	irqd_set(&desc->irq_data, IRQD_RESUMING);
 	__enable_irq(desc);
+	irqd_clear(&desc->irq_data, IRQD_RESUMING);
 }
 
 static void resume_irqs(bool want_early)



