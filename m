Return-Path: <linux-kernel+bounces-153999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DD98AD5F1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71AB51F21AA6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 20:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19E11B810;
	Mon, 22 Apr 2024 20:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/8ITGiw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZEY6QAm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A341B27D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 20:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713818216; cv=none; b=YbBWrObKGHGcPe4X3VtYHnGlGm5ObBfQQsj+h8M2iq8kx/vHeaNoTN3efg8QcEK7z/Z3DnY17XE8yOUepDAjOls2k5NNLRLpcEdsRwU0cqX5K4I//UhoMkrLaSszL9SjybxEpYZrDG43oBOPMLcrXKND3Whof1RlJL2nQyZzpHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713818216; c=relaxed/simple;
	bh=nEEh+p/pOR+i3sWyfCCcWPrhLXtXRkyqPqoZBUWXcII=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jhcQdp5ALuR78eTG/7di7+uIDSTj5+zCKwc7Uw8rGaKTi6hKww5vZWsZGTyWpyVbNOtxZpQADR8YhtHW14OMm3VfmAqNBMtHB2f7iDDRaZUJvjB7sLK90lHGNlT7A29G54/ZgZLgL1XmQbCo7zBz71y5xWULZsA5fl5PJptSHKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/8ITGiw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZEY6QAm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713818212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvLpSHrC5/9iiW/Dv8MHf/zZJefXZFsPZo0QVjjkUkA=;
	b=r/8ITGiwwXkMyWn6RUaFKw0tdjRLYK9bDuEHCThrZf+tFx4hSCUAm1xFvILaW5daqjQ1o8
	njdKqSmRO1UUAJq4e/+ENz9gAYIBu7tti1MhPYtBVruSpOz5KcV/hSEuyJGA7Lyool8j58
	Aicia8FnoRYfwt2wAakzqa3h15SJ2MNEVtoLbPc43pVPxlWXcuU4Mpd2R6i9GfDC2z5oc2
	ql8ek4KEuGgA9EVSZCRLyn2kRhNzNSobk0Dt0HQ/HeYIL31illcd3cBFid9lXE8D2/dIYm
	PQkJoaqaeTMsjq4VNXK9Qdp5GDTIVMjKjfU5+Op8nPGhKTIxfW00FNSL2u15ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713818212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LvLpSHrC5/9iiW/Dv8MHf/zZJefXZFsPZo0QVjjkUkA=;
	b=1ZEY6QAmWXv3mgHqDQSFaua0l9jSh71NS5aFL+eGRsUk0fbgt5Fi4GNs1XJivKz9tTUGjA
	6OLddZZn1GXImGAw==
To: David Stevens <stevensd@chromium.org>
Cc: linux-kernel@vger.kernel.org, David Stevens <stevensd@chromium.org>
Subject: Re: [PATCH] genirq: Disable suspended irqs when restoring affinity
In-Reply-To: <20240418074652.126355-1-stevensd@chromium.org>
References: <20240418074652.126355-1-stevensd@chromium.org>
Date: Mon, 22 Apr 2024 22:36:49 +0200
Message-ID: <87wmopuobi.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 18 2024 at 16:46, David Stevens wrote:
> In irq_restore_affinity_of_irq(), after initializing an affinity
> managed irq, disable the irq if it should be suspended. This ensures
> that irqs are not delivered to drivers during the noirq phase of
> resuming from S3, after non-boot CPUs are brought back online.
>
> Signed-off-by: David Stevens <stevensd@chromium.org>
> ---
>  kernel/irq/cpuhotplug.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/kernel/irq/cpuhotplug.c b/kernel/irq/cpuhotplug.c
> index 1ed2b1739363..c00132013708 100644
> --- a/kernel/irq/cpuhotplug.c
> +++ b/kernel/irq/cpuhotplug.c
> @@ -197,6 +197,8 @@ static void irq_restore_affinity_of_irq(struct irq_desc *desc, unsigned int cpu)
>  
>  	if (irqd_is_managed_and_shutdown(data)) {
>  		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
> +		if (desc->istate & IRQS_SUSPENDED)
> +			__disable_irq(desc);

Makes sense. But I rather avoid the whole startup/disable dance in this
case and let resume_device_irqs() deal with it.

Thanks,

        tglx
---
--- a/kernel/irq/cpuhotplug.c
+++ b/kernel/irq/cpuhotplug.c
@@ -195,10 +195,15 @@ static void irq_restore_affinity_of_irq(
 	    !irq_data_get_irq_chip(data) || !cpumask_test_cpu(cpu, affinity))
 		return;
 
-	if (irqd_is_managed_and_shutdown(data)) {
-		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
+	/*
+	 * Don't restore suspended interrupts here when a system comes back
+	 * from S3. They are reenabled via resume_device_irqs().
+	 */
+	if (desc->istat & IRQS_SUSPENDED)
 		return;
-	}
+
+	if (irqd_is_managed_and_shutdown(data))
+		irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 
 	/*
 	 * If the interrupt can only be directed to a single target
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -800,10 +800,14 @@ void __enable_irq(struct irq_desc *desc)
 		irq_settings_set_noprobe(desc);
 		/*
 		 * Call irq_startup() not irq_enable() here because the
-		 * interrupt might be marked NOAUTOEN. So irq_startup()
-		 * needs to be invoked when it gets enabled the first
-		 * time. If it was already started up, then irq_startup()
-		 * will invoke irq_enable() under the hood.
+		 * interrupt might be marked NOAUTOEN so irq_startup()
+		 * needs to be invoked when it gets enabled the first time.
+		 * This is also required when __enable_irq() is invoked for
+		 * a managed and shutdown interrupt from the S3 resume
+		 * path.
+		 *
+		 * If it was already started up, then irq_startup() will
+		 * invoke irq_enable() under the hood.
 		 */
 		irq_startup(desc, IRQ_RESEND, IRQ_START_FORCE);
 		break;

