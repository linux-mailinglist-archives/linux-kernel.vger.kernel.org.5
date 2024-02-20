Return-Path: <linux-kernel+bounces-73078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D6C685BD3B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 14:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1261C22424
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 13:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958DD6A336;
	Tue, 20 Feb 2024 13:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zMPFh9lT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBJ5dQD1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD456A03B;
	Tue, 20 Feb 2024 13:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708435950; cv=none; b=Aa1yMDXEeC6V+AnmQmrbX9n0q0bdT5ysd3xTTwe5YE/hEjmBEjk0Dv0tebB0Pljzk3yEktg7Dl9JyFzRm652dkcSKPhKkRpRTJ3DktIttVo+SEF01DJTNRo8SXZDpJF2i7Z2dw8lZTpHpCzIEFTsX3oXHZrfTCO3rFWVDpfD/zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708435950; c=relaxed/simple;
	bh=qzi/UizA5c9QmFUDxzPrTmigiUQLZR5cRjUJ97AA0iE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AiQ+GWI7hjb8ps48xZErzI2a5Z42759Ly+wFsy5NVAYH29N/eJeP/NOvvnuez1FzwFDOjLZKYPI0sAfwQzZcQhW3+eSBRh3jJ2GOb2hsDbjv8ENbCSq9xpNdlA8jR4JPz6HeF4zDL3p4/pvIlcKmN97rbuu5uOT0nlt5TjHT9Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zMPFh9lT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBJ5dQD1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708435947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOnU4WzHsviBX/18xdq2+f5ceg73dYPZPqI4JOjdiVs=;
	b=zMPFh9lTXbL9VEGqZpNKX44wj0tcvXxI2s3z/FtNoX4KGUdv/UNtEZcuOZsNzCB+dFR8LM
	Bu0vTpFKOh5BcqW1+Wwm6sfazAkJHgrLUWbvcDXw6FT2yaGpPtqU2xjvR9ocI9A+IJ+ADX
	ZDYO2bwmCoMokPWYfr4axHj4Z9PstMT89FkfJjdJQER8n6SFyM6sJiWrKv8BMaoH+N9Ffy
	vVbIlUj52BCXP2XCOdC2HlhPaoqar+/QvyFiIlvxrtEdTGWIF3BCHhG6GlaH6c15Kl9GZJ
	DcrRA1nNb53VCJFBXlICgHFEyXMX4Fgy4Y4xyRofjzJS0CzIHzNE6t6bucEvkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708435947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nOnU4WzHsviBX/18xdq2+f5ceg73dYPZPqI4JOjdiVs=;
	b=cBJ5dQD19d4JkjP6smlml7Jvc4g/wZEyf/D7Z6rn7b0SmVP9aQxKoYXfJbz0KFx4hkC1RR
	QjsDXKDdHYW1XgCg==
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
Subject: Re: [PATCH v13 07/13] irqchip/riscv-imsic: Add device MSI domain
 support for platform devices
In-Reply-To: <20240220060718.823229-8-apatel@ventanamicro.com>
References: <20240220060718.823229-1-apatel@ventanamicro.com>
 <20240220060718.823229-8-apatel@ventanamicro.com>
Date: Tue, 20 Feb 2024 14:32:27 +0100
Message-ID: <875xyji7mc.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Feb 20 2024 at 11:37, Anup Patel wrote:
> +#ifdef CONFIG_SMP
> +static void imsic_msi_update_msg(struct irq_data *d, struct imsic_vector *vec)
> +{
> +	struct msi_msg msg[2] = { [1] = { }, };

That's a weird initializer and why do you need an array here?

       struct msi_msg msg = { };

Should be sufficient, no?

> +
> +	imsic_irq_compose_vector_msg(vec, msg);
> +	irq_data_get_irq_chip(d)->irq_write_msi_msg(d, msg);
> +}

> +static int imsic_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
> +				  unsigned int nr_irqs, void *args)
> +{
> +	struct imsic_vector *vec;
> +
> +	/* Legacy-MSI or multi-MSI not supported yet. */

Coming back to my earlier question:

>> What's legacy MSI in that context?
>
> The legacy-MSI is the MSI support in PCI v2.2 where
> number of MSIs allocated by device were either 1, 2, 4,
> 8, 16, or 32 and the data written is <data_word> + <irqnum>.

You talk about PCI/MSI, where more than one vector is named
multi-MSI. Contrary to the modern v3.0 variant which is PCI/MSI-X.

So this should be "Multi-MSI is not supported yet", no?

> +	if (nr_irqs > 1)
> +		return -ENOTSUPP;
> +
> +	vec = imsic_vector_alloc(virq, cpu_online_mask);
> +	if (!vec)
> +		return -ENOSPC;
> +
> +	irq_domain_set_info(domain, virq, virq,
> +			    &imsic_irq_base_chip, vec,
> +			    handle_simple_irq, NULL, NULL);

Please utilize the 100 characters.

> +	irq_set_noprobe(virq);
> +	irq_set_affinity(virq, cpu_online_mask);
> +
> +	return 0;
> +}

Thanks,

        tglx

