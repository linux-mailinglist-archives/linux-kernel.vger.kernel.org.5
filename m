Return-Path: <linux-kernel+bounces-69331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB415858779
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 287861C24EC9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ECFA13A253;
	Fri, 16 Feb 2024 20:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IHl9ORoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UQZ1bO66"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEF17E104;
	Fri, 16 Feb 2024 20:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708116614; cv=none; b=RgEyWzLrVWVcnkueaR4P5fHjAkpChsd8M+ffTBYPvHKQ549AYDoxZk+6Oa6WUMJe2IJzXn+oJvv0N10JETRu9sxFWpx7Wb2/Vi9cQkUFsSsioY//UNIF9U21LT9yXoa3dZIcVTJK90j6bdG0k06CiV2sWqJnf9AEJc/h0DMI990=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708116614; c=relaxed/simple;
	bh=h3wIsXmqlT30Nejp9wNW9D81WtR4fDbq5xf7it79kko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uXG73n7Rlh7E250y1Jd/QNfQVcu188YTTX64/Q4Y+jLpK+S2qBrDy2GjlBx7LkRulCLvTmHy+Wxa/8Y5Igi8pL5ZRWn8YzXg/riKAJqtlw06g6Y8U8+7GjoQLKO44smz+K/gA+/+IJPZ4RK0OHw+aIjWWoRb4KA/7wgo0DmJIp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IHl9ORoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UQZ1bO66; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708116611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MiNcyV6cuA2bEaO9pcAB0n2lgB9jPzAIMw9Rcvipmc=;
	b=IHl9ORoCzIXPoV6LABWoXZZeMThG96CoIBAQQ027SKATZEF6fDtWiZ+bTW4kAY8lPa27DL
	Eo4oTrIMRPfMUn84ibsglx2TpDLUv3K0b85/SkLNV1z+KsIqNFC7n0oEiMVgIxu87uW7SM
	gvkoKgs9jvUqkGi9yLTP7IWTTMRVxzGIMhqUE2sUzhakn9LAeuR0LULqYWkqRFEWvIasLv
	EUrOGTu9obLyx99g44CXIknPz4XE1ItIo56xNMLgDlofUnnpx2GK7jbWIUKgbTBEzntOXN
	hNXXARggoTtPidzCj/D3DyFrgc7uETU2mjLp+kb+XMhpRhqnHgMsYlzQq7YGSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708116611;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/MiNcyV6cuA2bEaO9pcAB0n2lgB9jPzAIMw9Rcvipmc=;
	b=UQZ1bO66o3f1pXva2taPAXPSKlpKkqJV7Ezk94IO8xuYtdCOe4hdhfUQZY8wcsbasEmJJ8
	cRHlhm4HLiyx/WCw==
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
Subject: Re: [PATCH v12 22/25] irqchip: Add RISC-V advanced PLIC driver for
 direct-mode
In-Reply-To: <20240127161753.114685-23-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-23-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 21:50:10 +0100
Message-ID: <875xyocewt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> +static int aplic_direct_irqdomain_translate(struct irq_domain *d,
> +					 struct irq_fwspec *fwspec,
> +					 unsigned long *hwirq,
> +					 unsigned int *type)

Please align the arguments to the first argument of the first line and
use the 100 characters, i.e.

static int aplic_direct_irqdomain_translate(struct irq_domain *d, struct irq_fwspec *fwspec,
					    unsigned long *hwirq, unsigned int *type)
{

All over the place.

> +{
> +	struct aplic_priv *priv = d->host_data;
> +
> +	return aplic_irqdomain_translate(fwspec, priv->gsi_base,
> +					 hwirq, type);
> +}
> +
> +static int aplic_direct_irqdomain_alloc(struct irq_domain *domain,
> +				     unsigned int virq, unsigned int nr_irqs,
> +				     void *arg)
> +{
> +	int i, ret;
> +	unsigned int type;
> +	irq_hw_number_t hwirq;
> +	struct irq_fwspec *fwspec = arg;
> +	struct aplic_priv *priv = domain->host_data;
> +	struct aplic_direct *direct =
> +			container_of(priv, struct aplic_direct, priv);

Variable ordering. Please make this consistent according to documentation.

> +	ret = aplic_irqdomain_translate(fwspec, priv->gsi_base,
> +					&hwirq, &type);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < nr_irqs; i++) {
> +		irq_domain_set_info(domain, virq + i, hwirq + i,
> +				    &aplic_direct_chip, priv,
> +				    handle_fasteoi_irq, NULL, NULL);
> +		irq_set_affinity(virq + i, &direct->lmask);
> +		/* See the reason described in aplic_msi_irqdomain_alloc() */

I still have to understand that "reason". :)

> +		irq_set_status_flags(virq + i, IRQ_DISABLE_UNLAZY);
> +	}

Thanks,

        tglx

