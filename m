Return-Path: <linux-kernel+bounces-73089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BEB85BD6B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A27D1F24A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102E16A355;
	Tue, 20 Feb 2024 13:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FzLow9j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKDEH5iz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBFE367C49;
	Tue, 20 Feb 2024 13:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436460; cv=none; b=ATSlq60JfYP8Q/N217YDb1IXrzLXvTBPL+7Bkl2tttiqvGM1uJCMnzD03t65e+Wxyr7LmGOdZrQrpX1ihEmprSXdVZzOfxLnffP9LIhMu+OlGdmth+Ptute3kWKFjPEwI/xmhFDZ1mlcY3BuO8XMEhT8/dGNihcKm7rACS82fRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436460; c=relaxed/simple;
	bh=8XETYMkLOdN3i8VuC1iAxvlHgE6YEgxb3oFXYXINxBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XGxkTd7fQ3nN7dcJvdPT2GijM/ktAC3cE8AOZN6pD9KKxXcHuwHFDXaEQIDc7g6j9yVJYo5w9QLLm0/GmsmHedgkxpEMEPHWASBganpJt+Ra0C+kwDb80fVvhER+0lZMhoKitTkWfJNa70HkIsNOoPCoOvzTcVG/Q6CuzebvpBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FzLow9j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKDEH5iz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708436457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RERjxgu8dqdL6aUr837paWAP3NAbeqyENHSlhkJ7sJc=;
	b=3FzLow9j1OLGi62YTb/xPduwMDyy2OL4cGeobfLs0rjJoz9MtV1ffOAl2Nm6oEofTI+AZ/
	laPmvLOjhmWOPp66A4oP4SaRk20DRrCXRSdloKczm21/m4pVcQeZbMfIgbzYU6ecHzRx/N
	xaJ58GwCWyWgLTunV9W+vWs3lE0HveIHwrHhSQgS7MwC3mkdCFuAT58+Yl9BcPQlOsIwqG
	oU0DQY84nC6P/tfXxBPSMBXGCgftWN31rL2SbuBOUhuMhklAeMXYLqIvM2bdXuZEVKzMj9
	8hzb5rSCiEIvqNksYGqAHzVtld/NVTbkYyPUQgTh/urBlEEzCUmvMBQwdxm2ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708436457;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RERjxgu8dqdL6aUr837paWAP3NAbeqyENHSlhkJ7sJc=;
	b=nKDEH5izTI650ZGE5NgM3CY9zurMtqKTsRCVaPMSnjgdPpTIKmVr94JSPJI6Q2nxyv+yXt
	EOLe514i4KzxWhDA==
To: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Conor Dooley <conor+dt@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, =?utf-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Atish
 Patra <atishp@atishpatra.org>, Andrew Jones <ajones@ventanamicro.com>,
 Sunil V L <sunilvl@ventanamicro.com>, Saravana Kannan
 <saravanak@google.com>, Anup Patel <anup@brainfault.org>,
 linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Anup Patel
 <apatel@ventanamicro.com>
Subject: Re: [PATCH v13 10/13] irqchip: Add RISC-V advanced PLIC driver for
 direct-mode
In-Reply-To: <20240220060718.823229-11-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-11-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 14:40:56 +0100
Message-ID: <87zfvvgsnr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> +/*
> + * To handle an APLIC direct interrupts, we just read the CLAIMI register
> + * which will return highest priority pending interrupt and clear the
> + * pending bit of the interrupt. This process is repeated until CLAIMI
> + * register return zero value.
> + */
> +static void aplic_direct_handle_irq(struct irq_desc *desc)
> +{
> +	struct aplic_idc *idc = this_cpu_ptr(&aplic_idcs);
> +	struct irq_domain *irqdomain = idc->direct->irqdomain;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	irq_hw_number_t hw_irq;
> +	int irq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	while ((hw_irq = readl(idc->regs + APLIC_IDC_CLAIMI))) {
> +		hw_irq = hw_irq >> APLIC_IDC_TOPI_ID_SHIFT;
> +		irq = irq_find_mapping(irqdomain, hw_irq);
> +
> +		if (unlikely(irq <= 0))
> +			dev_warn_ratelimited(idc->direct->priv.dev,
> +					     "hw_irq %lu mapping not found\n", hw_irq);

Lacks brackets. See Documentation....

> +		else
> +			generic_handle_irq(irq);
> +	}
> +
> +static int aplic_direct_starting_cpu(unsigned int cpu)
> +{
> +	if (aplic_direct_parent_irq)
> +		enable_percpu_irq(aplic_direct_parent_irq,
> +				  irq_get_trigger_type(aplic_direct_parent_irq));

Ditto.

> +	return 0;
> +}

> +void aplic_init_hw_global(struct aplic_priv *priv, bool msi_mode)
> +{
> +	u32 val;
> +#ifdef CONFIG_RISCV_M_MODE
> +	u32 valH;

No camel case please.

> +
> +	if (msi_mode) {
> +		val = lower_32_bits(priv->msicfg.base_ppn);
> +		valH = FIELD_PREP(APLIC_xMSICFGADDRH_BAPPN, upper_32_bits(priv->msicfg.base_ppn));
> +		valH |= FIELD_PREP(APLIC_xMSICFGADDRH_LHXW, priv->msicfg.lhxw);
> +		valH |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXW, priv->msicfg.hhxw);
> +		valH |= FIELD_PREP(APLIC_xMSICFGADDRH_LHXS, priv->msicfg.lhxs);
> +		valH |= FIELD_PREP(APLIC_xMSICFGADDRH_HHXS, priv->msicfg.hhxs);
> +		writel(val, priv->regs + APLIC_xMSICFGADDR);
> +		writel(valH, priv->regs + APLIC_xMSICFGADDRH);
> +	}

Thanks,

        tglx

