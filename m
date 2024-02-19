Return-Path: <linux-kernel+bounces-71471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 889A085A5CC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:22:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB61F24A41
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF54374D9;
	Mon, 19 Feb 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4upGx7kJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4+9ecyFE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7289374C6;
	Mon, 19 Feb 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708352558; cv=none; b=kloREZTaezgs7OESS8fD2sM0xGFQ2Ofd0Kx9Y2revh48pBHQIFjzBlW/vMxoBE6ZwL3U9eSIEsPUe9s1l9OFLTtnJdIdcImjEeN5FdU9DN3K7piG442o2EsYh9K0qxc/a3x9SQ7kEPGNF7jWLzeD184L/Fi6896puPIKuh5E+F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708352558; c=relaxed/simple;
	bh=VirNTJqU30QLy7416ZaZEoSyRmXkYqVSdeOtlf+rVxA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=avZItcXGZuf+grnBPXVkIzcq5iVBSRBfZSH2a5DrJI/7nmf+YF/P4+3Qp8otDbsuex3I7HAB0zFUe91xALkCjhTLwq6vpFWasitOgipcYfRbtXPNjfluz2wgZVoNhr4QmrpU2Qfwv5Lip+/Ie/5lhgDrEOVpRlh0ptloEdv97Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4upGx7kJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4+9ecyFE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708352554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iEgdflkmZKXImf680lz4hgFumtn+q/R0YDjSc4t/Vc=;
	b=4upGx7kJ727A884ML4hUkx8C8e9g9smfQg662DB+Eql0qhnTPCpSxSOyFEBVeuIEZl3D2x
	lifGEA6YdZDxZ3NATNyidGIV9C47gWKE1F+bi+RMUbfG6GS5JyQqSU1eF7ydP141pP96cO
	Ejs2/ZFtgYFx6xD+cXA+D6dF14bXZ1Bzog1pajHS8HEuh3FLJOXqNLOya45j2829Og2LQV
	KSVySQTHgr2Cwbsv/m17DEgTr0sZup4bsdHay2QH+ElPRfgphVBLWy8FzODQOHxWfmARqj
	+TEWoE/Dyg9x3UBjG4oHCdTBdpxv3lEZlgWMKlBfaLh5q6Id5RObd4Dpti1oRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708352554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8iEgdflkmZKXImf680lz4hgFumtn+q/R0YDjSc4t/Vc=;
	b=4+9ecyFEBiX9R65rg3DVI+yqWFudZBvINi2tHB1FDWo7lijLMJysfGElaqbRllJylJYfxs
	KB6fhvkKSS/LqXBg==
To: Antonio Borneo <antonio.borneo@foss.st.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre
 Torgue <alexandre.torgue@foss.st.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 03/12] irqchip/stm32-exti: Map interrupts through
 interrupt nexus node
In-Reply-To: <20240216094758.916722-4-antonio.borneo@foss.st.com>
References: <20240216094758.916722-1-antonio.borneo@foss.st.com>
 <20240216094758.916722-4-antonio.borneo@foss.st.com>
Date: Mon, 19 Feb 2024 15:22:34 +0100
Message-ID: <87a5nwa5zp.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Feb 16 2024 at 10:47, Antonio Borneo wrote:
> diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
> index 69982f21126a..95bb3dd10b2c 100644
> --- a/drivers/irqchip/irq-stm32-exti.c
> +++ b/drivers/irqchip/irq-stm32-exti.c
> @@ -61,6 +61,7 @@ struct stm32_exti_host_data {
>  	struct stm32_exti_chip_data *chips_data;
>  	const struct stm32_exti_drv_data *drv_data;
>  	struct hwspinlock *hwlock;
> +	struct device_node *irq_map_node;

Please keep variable declarations ordered in reverse fir tree layout:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

>  };
>  
>  static struct stm32_exti_host_data *stm32_host_data;
> @@ -713,8 +714,9 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
>  	u8 desc_irq;
>  	struct irq_fwspec *fwspec = data;
>  	struct irq_fwspec p_fwspec;
> +	struct of_phandle_args out_irq;

Please move this into the condition path where it is actually used.

>  	irq_hw_number_t hwirq;
> -	int bank;
> +	int bank, ret;
>  	u32 event_trg;
>  	struct irq_chip *chip;
>  
> @@ -731,6 +733,25 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
>  
>  	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
>  
> +	if (host_data->irq_map_node) {
> +		out_irq.np = host_data->irq_map_node;

Thanks,

        tglx

