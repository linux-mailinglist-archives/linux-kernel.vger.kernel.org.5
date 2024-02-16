Return-Path: <linux-kernel+bounces-69345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAFB8587B8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6289FB2996C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9371468F4;
	Fri, 16 Feb 2024 21:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="09tYLByR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sTHsysm3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3967F145B13;
	Fri, 16 Feb 2024 21:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708117447; cv=none; b=XFagkPgZTvWKMx38WIufHi007H+N+g2CmhV48lSUq2S8UP/ua5/98uUBXLg8hsLvlYQO8QAtmqXe57wflGN8dlhlSfuX/pwkcD8XwWJRgPmpzfy9abRkoLml3Ty9Niky8/D4Tnr6e9YIVFXYvaMH1YadnSl307xsbRLN8JZyh40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708117447; c=relaxed/simple;
	bh=2HGv2SAPNP/8SNhuPL7jV7rNyYJBGuWopRtV7aLEqMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pkf9Ekz/V8TWMeNcNaXeYlx2twoDzdgLkEPulmX7DnhlzkcRUkwKyccTA0Xoc7i1gpsT4vzfrnoYpK8beDnez47dFB5eaLfPjUfN6YYe5I5HGivJwLMAu1srzLqS59YAPtCNyzZ2eH5i4y9N0R+M+WyKBSK/9Gl2jEnVXcbRZVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=09tYLByR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sTHsysm3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708117444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPil28lXVu/5EuMTMJHAF2NuE7S20nDRKRUxcPw2x9A=;
	b=09tYLByROgD3bDLYAoILh20drVnloPdm8qHaCVHSa8YslAkk+vHe5GCMRqEPgmXapRXwp7
	haMLpBFhy7xqoxZcqtyf08Ob2ZjGCB9hHnx50L0qLeyomv7uwZvRwLH5+eCY0q2Kl3SlS8
	wMobBVNcDkGtumiuGA36kP32BR/n7Od+jQT19U9Hk6sC/MdjnDn31ojtc+Xf3o707kLWlw
	hJHDBj443oH4lxAbBirQ48SRQP4as2LG7Q3yN3yRzLeFpVFJFq5MfBoxZW7EXofWFsaCyK
	Owe5hwIfmeW55ddNzU4jbNTyfHMS0Z8JV9K5LFqZln4wBoUDprmPjYu1DfgFbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708117444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aPil28lXVu/5EuMTMJHAF2NuE7S20nDRKRUxcPw2x9A=;
	b=sTHsysm3f+56VNyke1nWTeQXTpJX/RT7U3ejiMXUtOjW65iwO9Uv6f1hJoBVOWapBEc/Mk
	3esMRQST3WxV1PBg==
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
Subject: Re: [PATCH v12 23/25] irqchip/riscv-aplic: Add support for MSI-mode
In-Reply-To: <20240127161753.114685-24-apatel@ventanamicro.com>
References: <20240127161753.114685-1-apatel@ventanamicro.com>
 <20240127161753.114685-24-apatel@ventanamicro.com>
Date: Fri, 16 Feb 2024 22:04:03 +0100
Message-ID: <8734tsce9o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Jan 27 2024 at 21:47, Anup Patel wrote:
> We extend the existing APLIC irqchip driver to support MSI-mode for
> RISC-V platforms having both wired interrupts and MSIs.

We? Just s/We//

> +
> +static void aplic_msi_irq_unmask(struct irq_data *d)
> +{
> +	aplic_irq_unmask(d);
> +	irq_chip_unmask_parent(d);
> +}
> +
> +static void aplic_msi_irq_mask(struct irq_data *d)
> +{
> +	aplic_irq_mask(d);
> +	irq_chip_mask_parent(d);
> +}

Again asymmetric vs. unmask()

> +static void aplic_msi_irq_eoi(struct irq_data *d)
> +{
> +	struct aplic_priv *priv = irq_data_get_irq_chip_data(d);
> +	u32 reg_off, reg_mask;
> +
> +	/*
> +	 * EOI handling only required only for level-triggered
> +	 * interrupts in APLIC MSI mode.
> +	 */
> +
> +	reg_off = APLIC_CLRIP_BASE + ((d->hwirq / APLIC_IRQBITS_PER_REG) * 4);
> +	reg_mask = BIT(d->hwirq % APLIC_IRQBITS_PER_REG);
> +	switch (irqd_get_trigger_type(d)) {
> +	case IRQ_TYPE_LEVEL_LOW:
> +		if (!(readl(priv->regs + reg_off) & reg_mask))
> +			writel(d->hwirq, priv->regs + APLIC_SETIPNUM_LE);

A comment what this condition is for would be nice.

Thanks,

        tglx

