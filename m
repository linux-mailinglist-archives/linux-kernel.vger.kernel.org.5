Return-Path: <linux-kernel+bounces-63338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67749852DD4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 247C7288AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26AD822638;
	Tue, 13 Feb 2024 10:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GwkPBvLE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FTIkVehm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04308225CE;
	Tue, 13 Feb 2024 10:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707820004; cv=none; b=Yyb4xzoZIaFkgfmItnJAf/URA4B73uf1k4p2ahxCb/YdYvG1zeEuJAc7X2x2TLaLAUbot4eVg9kv0kgAjX9DJASgbBxyTb99lbhCpLh+wH+G4SBZY45YLv8hWA49mTYGi0etingxREW71H0lecNt9x8PyiSpiIxaNtjpTwU17G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707820004; c=relaxed/simple;
	bh=aBnhq06nlMMvbU7IDlpipxtNtoUmHZ45y8K4GgkpUWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zxil/62HoUGi1RceahtHa18EnjErE2kcV21abwz1qTGp6FYQnSArIH1TAybzu1LIHmgPJ45WP/q2jprxmSxaG1vqj6mmvHWAFSRUx1vDpVKTTrJOaVmDcT4n5gp1rvI5YS50Cp5/skl71JMNQbfWVDLKPrQ8EWe0vjQi3OpWIuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GwkPBvLE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FTIkVehm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707820001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OirENwRVffLhqg4vLQeXmmc6qTeG6AWtBgzm4/Fep7o=;
	b=GwkPBvLE/NQAAT43xtyROcGSWgUiucZZB2ec2g3VMikr5ObnhcXmo+RS5IDSmyM1OUGiEd
	7xS8uBH10ljyxTHAf0TgsO0vUhc8J3cUumyVjdF+tArJNZ5Cb6qbN81/2L4SUuNb1n+xeM
	lTUKLPRc+bLsZCgPNl5jfAbi8uQEAR9a7o0M/zk8iHPMQOA0sGKzpV8m4ycyLpvhMqIrTG
	BzH2/fE2hX0EICezQmdB7T4kOaTHuSMg8g41lIojVhpEATsMu34Fr+weMIBkrFDgJ1m7zJ
	smGA9OsZA5tjREuhcauzD90erNoGucb+l9Ok3++FJGDwNXwNBXF9bmy5HX/vxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707820001;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OirENwRVffLhqg4vLQeXmmc6qTeG6AWtBgzm4/Fep7o=;
	b=FTIkVehmdBJJQ8PbMU0GBBiXWHp+VmaePW7Fc9q0HvKZTnjeSpYgSUQrZkAOitKr3WDpHK
	rs9WULSDRQ3oSFCA==
To: Nam Cao <namcao@linutronix.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Samuel Holland
 <samuel@sholland.org>, Marc Zyngier <maz@kernel.org>, Guo Ren
 <guoren@kernel.org>, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
Cc: Nam Cao <namcao@linutronix.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2] irqchip/sifive-plic: enable interrupt if needed
 before EOI
In-Reply-To: <20240131081933.144512-1-namcao@linutronix.de>
References: <20240131081933.144512-1-namcao@linutronix.de>
Date: Tue, 13 Feb 2024 11:26:40 +0100
Message-ID: <87wmr8hd7j.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Nam!

On Wed, Jan 31 2024 at 09:19, Nam Cao wrote:
> RISC-V PLIC cannot "end-of-interrupt" (EOI) disabled interrupts, as
> explained in the description of Interrupt Completion in the PLIC spec:
>
> "The PLIC signals it has completed executing an interrupt handler by
> writing the interrupt ID it received from the claim to the claim/complete
> register. The PLIC does not check whether the completion ID is the same
> as the last claim ID for that target. If the completion ID does not match
> an interrupt source that *is currently enabled* for the target, the
> completion is silently ignored."
>
> Commit 69ea463021be ("irqchip/sifive-plic: Fixup EOI failed when masked")
> ensured that EOI is successful by enabling interrupt first, before EOI.
>
> Commit a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask
> operations") removed the interrupt enabling code from the previous
> commit, because it assumes that interrupt should already be enabled at the
> point of EOI. However, this is incorrect: there is a window after a hart
> claiming an interrupt and before irq_desc->lock getting acquired,
> interrupt can be disabled during this window. Thus, EOI can be invoked
> while the interrupt is disabled, effectively nullify this EOI. This
> results in the interrupt never gets asserted again, and the device who
> uses this interrupt appears frozen.

Nice detective work!

> Make sure that interrupt is really enabled before EOI.
>
> Fixes: a1706a1c5062 ("irqchip/sifive-plic: Separate the enable and mask operations")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> ---
> v2:
>   - add unlikely() for optimization
>   - re-word commit message to make it clearer
>
>  drivers/irqchip/irq-sifive-plic.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index e1484905b7bd..0a233e9d9607 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -148,7 +148,13 @@ static void plic_irq_eoi(struct irq_data *d)
>  {
>  	struct plic_handler *handler = this_cpu_ptr(&plic_handlers);
>  
> -	writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	if (unlikely(irqd_irq_disabled(d))) {
> +		plic_toggle(handler, d->hwirq, 1);
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +		plic_toggle(handler, d->hwirq, 0);

It's unfortunate to have this condition in the hotpath, though it should
be cache hot, easy to predict and compared to the writel() completely in
the noise.

> +	} else {
> +		writel(d->hwirq, handler->hart_base + CONTEXT_CLAIM);
> +	}
>  }

Can the RISCV folks please have a look at this?

Thanks,

        tglx

