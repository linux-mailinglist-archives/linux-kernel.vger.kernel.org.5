Return-Path: <linux-kernel+bounces-154046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B19B8AD687
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C70201C21818
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85F51CABF;
	Mon, 22 Apr 2024 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kp1ExzYm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8yBclRjK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C776EAC7;
	Mon, 22 Apr 2024 21:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713821361; cv=none; b=aitgr0y0dWOvIoSP9eyExSBWy2pxahsY3IsaUmFaXbFb5hZinSFLalVtOMAugS0d0CeScIRdCoMxyM6SpJhY+lp5hMr3VJIutEvJO13700qxSYMkdMmCehJFlYPs6RqaWJ1uLEfAe2ha2KS1ogUFVRq7tOhghnCp2713udDyfks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713821361; c=relaxed/simple;
	bh=X5yECVocRSVoXWNUjSJ5FQCElLwOjfvcL5E4tS0Ma9M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kTfzIo+i9TaKmgi8FMgHSrj0/zCMIrQlaifsebKnzf4kk+0jKWpuaOAmr53up6Mpmnzh3qAJpHu6WAzvBD6sTElPPlERE8IDOjIkwglbo2nNWOMn1UrhwGctSJkNjoNI6LMMTk/5EI6N2JMHW+pkJwifI9yjpDBxoJQ1328JIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kp1ExzYm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8yBclRjK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1713821357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeyuEbrEx1MPoiOjVnW6ImI9gPSzPtQTfgem9Ff9pSI=;
	b=Kp1ExzYmRQaKsiOSMmITaxogq9JhEcwIV44iCbU3V3uLKMCZdFmzlU/cp5WOiq9W/5Ke2q
	f/oSqov0Oi7SrAFfSMB4PIcdRpNUuC8kcO/VtCwHXVFRP2ZrVpgUxoirToSyH3vNJynEDq
	4kVknKPcFks1ZyH/UgLHuqzblH0UHkD/v1SNCt0SeJQIORup+f2ijCa05zMpRcH5RbOi4T
	RzKxtqUuKbuGReooLq5SAmPQ3QilUGGOeNXG15K+e1AGEjEAVWXz2VtboxK4IZCjZgFNVz
	JDJeNcIKuj7DtJ/IJmmL2vxbL3CoyU07mK2YhQM4dPBFw8XadUmEjKTQh+Wyyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1713821357;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eeyuEbrEx1MPoiOjVnW6ImI9gPSzPtQTfgem9Ff9pSI=;
	b=8yBclRjKCw8Nf5LARioW+Naqyx6TNa7SarnX433TQUWLxfqWJf4L9ckMKEY6o/Lhiozidf
	M/WO8dzdvVdbAEAg==
To: Florian Fainelli <florian.fainelli@broadcom.com>,
 linux-kernel@vger.kernel.org
Cc: opendmb@gmail.com, Florian Fainelli <florian.fainelli@broadcom.com>, Tim
 Ross <tim.ross@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, "open list:BROADCOM BMIPS MIPS
 ARCHITECTURE" <linux-mips@vger.kernel.org>, "moderated list:BROADCOM
 BCM7XXX ARM
 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] irqchip/irq-brcmstb-l2: Avoid saving mask on shutdown
In-Reply-To: <20240416194343.469318-1-florian.fainelli@broadcom.com>
References: <20240416194343.469318-1-florian.fainelli@broadcom.com>
Date: Mon, 22 Apr 2024 23:29:14 +0200
Message-ID: <87le55ulw5.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Apr 16 2024 at 12:43, Florian Fainelli wrote:
> The interrupt controller shutdown path does not need to save the mask of
> enabled interrupts because the next state the system is going to be in
> is akin to a cold boot, or a kexec'd kernel.

Sure, but

> Reported-by: Tim Ross <tim.ross@broadcom.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/irqchip/irq-brcmstb-l2.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
> index 2b0b3175cea0..c988886917f7 100644
> --- a/drivers/irqchip/irq-brcmstb-l2.c
> +++ b/drivers/irqchip/irq-brcmstb-l2.c
> @@ -118,7 +118,7 @@ static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
>  	chained_irq_exit(chip, desc);
>  }
>  
> -static void brcmstb_l2_intc_suspend(struct irq_data *d)
> +static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
>  {
>  	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
>  	struct irq_chip_type *ct = irq_data_get_chip_type(d);
> @@ -127,7 +127,8 @@ static void brcmstb_l2_intc_suspend(struct irq_data *d)
>  
>  	irq_gc_lock_irqsave(gc, flags);
>  	/* Save the current mask */
> -	b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
> +	if (save)
> +		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);

what's the conditional actually buying you except more complex code?

Thanks,

        tglx

        

