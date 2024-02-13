Return-Path: <linux-kernel+bounces-63171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7136F852BE0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3211C28210E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE92137E;
	Tue, 13 Feb 2024 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sndpvb0D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mPzWZKTX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2C6208C3;
	Tue, 13 Feb 2024 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707814996; cv=none; b=tU3Me9DTsnK7ZiHbNm1dVa5pxnZrCvlGDliw9ZdmmPJNb9auO8pPKiXh8J4GgQPeaFiOJVjbxjQCJRuSZkpdOWh+t7iBWM6b3re4vTZuwMXxLy33DS9JFR35J8HRJeBjgUvQuy0iagf+ir3oQKlaHGQ9cFnlKJ9J+v/7hxfFb8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707814996; c=relaxed/simple;
	bh=gLbhyPC1ZnLyN/5YEgFVKTykViATyzllgItFsyVFqmA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hn5YsKx7wcJY88gGE71W9ReGIQoPDac1kTZ0JjwmaKhUlg4KcetOL0fRZWcOha0dz0StNSEn7p9OqF1dtcYiqdrd/u/jS6Qb4Y+xgZ4dmmZd2wrr6Z+2XCZ7clkR2mJqPPaoOvMRQ5kvXFvfrHOQug4B6Ls8r5ggyOKQAs/6cu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sndpvb0D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mPzWZKTX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707814992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6BkF0UFKnJMGjWiJAiIbSA+roMcS63IGX3gCMnqyxY=;
	b=Sndpvb0DgXvIkTtZrlJB3MFD1BU0yaK89cZb0EVlrgtSomCXTWHy0AXuguSxw0puaBIS17
	JZOlKdtNHcDdv+sIZxXi8YBAtGnAVEY3QZ8JhkzdnaFiNzuGQmT30hxvCsXcld3WQ4qwV6
	W3i+V6o6iL6m7Xx6/tWIFxjlON2SPDku6SbAO8u88OoY6ZU6sHidpzQqXTt72RbSNuRD5y
	tTgKynEFsybdCNic68siTDM2qcgJLYhbiGbJSoDmkzYJuasWokYcWEzVtAGDC/YqUqyd79
	jPqZLuZ83AgqAkJa9PLU1lNHinnoNWJkbEIHhjCtYqy81AJ5ZbLXsXwnAT2BsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707814992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=i6BkF0UFKnJMGjWiJAiIbSA+roMcS63IGX3gCMnqyxY=;
	b=mPzWZKTX3Zf0yCuaq/GYMTpdGtQ4v/5pgLbCUkITD6JSXtKcC3fYs70W0AL2SgOwHEqVJD
	QlZ6bxb3SYxwUqCg==
To: Changhuang Liang <changhuang.liang@starfivetech.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>, Jack Zhu
 <jack.zhu@starfivetech.com>, Changhuang Liang
 <changhuang.liang@starfivetech.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] irqchip: Add StarFive external interrupt controller
In-Reply-To: <20240130055843.216342-3-changhuang.liang@starfivetech.com>
References: <20240130055843.216342-1-changhuang.liang@starfivetech.com>
 <20240130055843.216342-3-changhuang.liang@starfivetech.com>
Date: Tue, 13 Feb 2024 10:03:12 +0100
Message-ID: <87cyt0ivn3.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jan 29 2024 at 21:58, Changhuang Liang wrote:
> +
> +struct starfive_irq_chip {
> +	void __iomem *base;
> +	struct irq_domain *root_domain;
> +	struct clk *clk;
> +};

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

Please.

> +static void starfive_intc_mod(struct starfive_irq_chip *irqc, u32 reg, u32 mask, u32 data)
> +{
> +	u32 value;
> +
> +	value = ioread32(irqc->base + reg) & ~mask;
> +	data &= mask;

Why?

> +	data |= value;
> +	iowrite32(data, irqc->base + reg);

How is this serialized against concurrent invocations of this code on
different CPUs for different interrupts?

It's not and this requires a raw_spinlock for protection.

> +}
> +
> +static void starfive_intc_unmask(struct irq_data *d)
> +{
> +	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +
> +	starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq), 0);
> +}
> +
> +static void starfive_intc_mask(struct irq_data *d)
> +{
> +	struct starfive_irq_chip *irqc = irq_data_get_irq_chip_data(d);
> +
> +	starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_MASK, BIT(d->hwirq), BIT(d->hwirq));
> +}
> +
> +static struct irq_chip intc_dev = {
> +	.name = "starfive jh8100 intc",
> +	.irq_unmask = starfive_intc_unmask,
> +	.irq_mask = starfive_intc_mask,
> +};

See documentation please.

> +static int starfive_intc_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hwirq)
> +{
> +	irq_domain_set_info(d, irq, hwirq, &intc_dev, d->host_data,
> +			    handle_level_irq, NULL, NULL);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops starfive_intc_domain_ops = {
> +	.xlate = irq_domain_xlate_onecell,
> +	.map = starfive_intc_map,
> +};

Ditto.

> +static void starfive_intc_irq_handler(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct starfive_irq_chip *irqc = irq_data_get_irq_handler_data(&desc->irq_data);

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	unsigned long value = 0;

Pointless initialization

> +	int hwirq;
> +
> +	chained_irq_enter(chip, desc);
> +
> +	value = ioread32(irqc->base + STARFIVE_INTC_SRC0_INT);
> +	while (value) {
> +		hwirq = ffs(value) - 1;
> +
> +		generic_handle_domain_irq(irqc->root_domain, hwirq);
> +
> +		starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq), BIT(hwirq));
> +		starfive_intc_mod(irqc, STARFIVE_INTC_SRC0_CLEAR, BIT(hwirq), 0);
> +
> +		clear_bit(hwirq, &value);
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}
> +
> +static int __init starfive_intc_init(struct device_node *intc,
> +				     struct device_node *parent)
> +{
> +	struct starfive_irq_chip *irqc;
> +	struct reset_control *rst;
> +	int ret;
> +	int parent_irq;

See Documentation

> +	irqc = kzalloc(sizeof(*irqc), GFP_KERNEL);
> +	if (!irqc)
> +		return -ENOMEM;
> +
> +	irqc->base = of_iomap(intc, 0);
> +	if (!irqc->base) {
> +		pr_err("Unable to map IC registers\n");
> +		ret = -ENXIO;
> +		goto err_free;
> +	}
> +
> +	rst = of_reset_control_get_exclusive(intc, NULL);
> +	if (IS_ERR(rst)) {
> +		pr_err("Unable to get reset control %pe\n", rst);
> +		ret = PTR_ERR(rst);
> +		goto err_unmap;
> +	}
> +
> +	irqc->clk = of_clk_get(intc, 0);
> +	if (IS_ERR(irqc->clk)) {
> +		pr_err("Unable to get clock\n");
> +		ret = PTR_ERR(irqc->clk);
> +		goto err_rst;
> +	}
> +
> +	ret = reset_control_deassert(rst);
> +	if (ret)
> +		goto err_clk;
> +
> +	ret = clk_prepare_enable(irqc->clk);
> +	if (ret)
> +		goto err_clk;
> +
> +	irqc->root_domain = irq_domain_add_linear(intc, STARFIVE_INTC_SRC_IRQ_NUM,
> +						  &starfive_intc_domain_ops, irqc);
> +	if (!irqc->root_domain) {
> +		pr_err("Unable to create IRQ domain\n");
> +		ret = -EINVAL;
> +		goto err_clk;
> +	}
> +
> +	parent_irq = of_irq_get(intc, 0);
> +	if (parent_irq < 0) {
> +		pr_err("Failed to get main IRQ: %d\n", parent_irq);
> +		ret = parent_irq;
> +		goto err_clk;

Leaks the interrupt domain, no?

Thanks,

        tglx

