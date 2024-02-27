Return-Path: <linux-kernel+bounces-83610-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 526F8869C31
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D66901F21558
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDDF1C6B0;
	Tue, 27 Feb 2024 16:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R0+sMRFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mfiDY1/j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1901C697;
	Tue, 27 Feb 2024 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051578; cv=none; b=FYmXWaZ0T1gk7WG40K1CY5r0vfFvPuylWriMLZMO2f09Esd6rkjjqxNMczj4BagKgGgDsG+iJ1x2LjabZPZjMK/FYeIWB2SSCoVuONZXgla8za9va+x68HY2AR09MwY2xKSCfYdMWt17J1IqhOkITWAe1ceDcY49jK/vnlwu5j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051578; c=relaxed/simple;
	bh=t9pqBmZVkQ/Fpn1eD9/FTS+0fHOWuP1ehf9RwlvwGww=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lUwaLnQvEjKIimabc0F6j/NhuSsoCnobCWPbNppn7DQCw3ufTLsbR1j7aBsvfGxaTQ1VKm+/P7MafpJg3tGJV9IvM57rfPQAWnR7toQCUKxvCp4zf84+MYKCsnUSWREtfz/J/YxXH+AC61uWnMh6yi4pGyEPL02BtMGkWT5bNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R0+sMRFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mfiDY1/j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709051574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyV9bHeQYh2STSu1Aki+bC1PiR0RG4rZPyWUkh6MdoI=;
	b=R0+sMRFv9b8X+E5PlHqAnffQ9ul2R0l+89oJsQQqPEMzobmGax2CGW1kgeoxp2g7FE7y/H
	ZduHQ6oyjWkm9ZA5CLqotQqDCEtKhwhNagXbhtZj6x2P+eXwHgq8bn9YKdtPqmPMLZ9XkY
	0M9kSqf3ORH7ZF9SDePLRmHMbqIQkX3kvhftVrbUGqMyDdK+NZuwrz7YR5i9fjoBUyHlEZ
	SK+iNEKoWW3HFdwTwutyndjzwqx2Aso9GloWF+coyojZ7RwUTRw16z46SpvLt8Du7dXC26
	ttqFrpCCC/bMioXhJFtXB4Q09O1kXf9MzyxWlYi+Q24GgLZuajw5i7BshrGUfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709051574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SyV9bHeQYh2STSu1Aki+bC1PiR0RG4rZPyWUkh6MdoI=;
	b=mfiDY1/jYFYVkT3N2Y3yq9fwkvbnzRzZ3jJHlKwl01nm/DAsIpCmKZZwXdjDRmVLCuGQl6
	9QNGSBRBpVnBP7Cg==
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Daniel Lezcano
 <daniel.lezcano@linaro.org>, Emil Renner Berthing
 <emil.renner.berthing@canonical.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Walker
 Chen <walker.chen@starfivetech.com>, Xingyu Wu
 <xingyu.wu@starfivetech.com>, linux-kernel@vger.kernel.org, Conor Dooley
 <conor@kernel.org>
Subject: Re: [PATCH v8 2/3] clocksource: Add JH7110 timer driver
In-Reply-To: <20231219145402.7879-3-xingyu.wu@starfivetech.com>
References: <20231219145402.7879-1-xingyu.wu@starfivetech.com>
 <20231219145402.7879-3-xingyu.wu@starfivetech.com>
Date: Tue, 27 Feb 2024 17:32:54 +0100
Message-ID: <877cipamvd.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Dec 19 2023 at 22:54, Xingyu Wu wrote:
> +
> +struct jh7110_clkevt {
> +	struct clk *clk;
> +	struct reset_control *rst;
> +	void __iomem *base;
> +	u32 reload_val;
> +	int irq;
> +	char name[sizeof("jh7110-timer.chX")];
> +};
> +
> +struct jh7110_timer_priv {
> +	struct reset_control *prst;
> +	struct device *dev;
> +	struct jh7110_clkevt clkevt[JH7110_TIMER_CH_MAX];
> +};

Please format your data structures according to documentation:

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#struct-declarations-and-initializers

> +/* IRQ handler for the timer */
> +static irqreturn_t jh7110_timer_interrupt(int irq, void *data)
> +{
> +	struct clock_event_device *evt = data;
> +	struct jh7110_clkevt *clkevt = &jh7110_timer_info.clkevt[0];
> +	u8 cpu_id = smp_processor_id();
> +	u32 reg = readl(clkevt->base + JH7110_TIMER_INT_STATUS);

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#variable-declarations

> +	/* Check interrupt status and channel(cpu) ID */
> +	if (!(reg & BIT(cpu_id)))
> +		return IRQ_NONE;
> +
> +	clkevt = &jh7110_timer_info.clkevt[cpu_id];
> +	writel(JH7110_TIMER_INT_CLR_ENA, (clkevt->base + JH7110_TIMER_INT_CLR));
> +
> +	if (evt->event_handler)
> +		evt->event_handler(evt);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int jh7110_timer_set_periodic(struct clock_event_device *evt)
> +{
> +	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
> +
> +	writel(JH7110_TIMER_MODE_CONTIN, clkevt->base + JH7110_TIMER_CTL);
> +	return 0;
> +}
> +
> +static int jh7110_timer_set_oneshot(struct clock_event_device *evt)
> +{
> +	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
> +
> +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
> +	return 0;
> +}
> +
> +static int jh7110_timer_set_next_event(unsigned long next,
> +				       struct clock_event_device *evt)
> +{
> +	struct jh7110_clkevt *clkevt = JH7110_PERCPU_GET_CLKEVT;
> +
> +	writel(JH7110_TIMER_MODE_SINGLE, clkevt->base + JH7110_TIMER_CTL);
> +	writel(next, clkevt->base + JH7110_TIMER_LOAD);
> +
> +	return jh7110_timer_start(clkevt);
> +}
> +
> +static DEFINE_PER_CPU(struct clock_event_device, jh7110_clock_event) = {
> +	.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT,
> +	.rating = JH7110_CLOCKEVENT_RATING,
> +	.set_state_shutdown = jh7110_timer_shutdown,
> +	.set_state_periodic = jh7110_timer_set_periodic,
> +	.set_state_oneshot = jh7110_timer_set_oneshot,
> +	.set_state_oneshot_stopped = jh7110_timer_shutdown,
> +	.tick_resume = jh7110_timer_tick_resume,
> +	.set_next_event = jh7110_timer_set_next_event,
> +	.suspend = jh7110_timer_suspend,
> +	.resume = jh7110_timer_resume,
> +};

See formatting rules.

> +static int jh7110_timer_starting_cpu(unsigned int cpu)
> +{
> +	struct clock_event_device *evt = per_cpu_ptr(&jh7110_clock_event, cpu);
> +	struct jh7110_timer_priv *priv = &jh7110_timer_info;
> +	int ret;
> +	u32 rate;
> +
> +	if (cpu >= JH7110_TIMER_CH_MAX)
> +		return -ENOMEM;
> +
> +	ret = clk_prepare_enable(priv->clkevt[cpu].clk);
> +	if (ret)
> +		return ret;
> +
> +	ret = reset_control_deassert(priv->clkevt[cpu].rst);
> +	if (ret)
> +		return ret;
> +
> +	rate = clk_get_rate(priv->clkevt[cpu].clk);
> +	evt->cpumask = cpumask_of(cpu);
> +	evt->irq = priv->clkevt[cpu].irq;
> +	evt->name = priv->clkevt[cpu].name;
> +	clockevents_config_and_register(evt, rate, JH7110_TIMER_MIN_TICKS,
> +					JH7110_TIMER_MAX_TICKS);
> +
> +	ret = devm_request_irq(priv->dev, evt->irq, jh7110_timer_interrupt,
> +			       IRQF_TIMER | IRQF_IRQPOLL,
> +			       evt->name, evt);

How is this all supposed to work from a CPU hotplug state callback which
runs in the early bringup phase with interrupts disabled? clk_prepare()
which is invoked from clk_prepare_enable() can sleep and
devm_request_irq() can sleep too.

Did you ever test this with the required debug config options enabled?

  https://www.kernel.org/doc/html/latest/process/submit-checklist.html

Obviously not.

> +	if (ret)
> +		return ret;
> +
> +	ret = irq_set_affinity(evt->irq, cpumask_of(cpu));
> +	if (ret)
> +		return ret;
> +	/* Use one-shot mode */
> +	writel(JH7110_TIMER_MODE_SINGLE, (priv->clkevt[cpu].base + JH7110_TIMER_CTL));
> +
> +	return jh7110_timer_start(&priv->clkevt[cpu]);
> +}
> +
> +static void jh7110_timer_release(void *data)
> +{
> +	struct jh7110_timer_priv *priv = data;
> +	int i;
> +
> +	for (i = 0; i < JH7110_TIMER_CH_MAX; i++) {
> +		/* Disable each channel of timer */
> +		if (priv->clkevt[i].base)
> +			writel(JH7110_TIMER_DIS, priv->clkevt[i].base + JH7110_TIMER_ENABLE);
> +
> +		/* Avoid no initialization in the loop of the probe */
> +		if (!IS_ERR_OR_NULL(priv->clkevt[i].rst))
> +			reset_control_assert(priv->clkevt[i].rst);
> +
> +		if (!IS_ERR_OR_NULL(priv->clkevt[i].clk))
> +			clk_disable_unprepare(priv->clkevt[i].clk);

Same problem. And of course this does not undo the other steps of
jh7110_timer_starting_cpu() so if you offline a CPU and then online it
again the callback will fail because the clockevent is already
registered and the interrupt requested. Clearly untested too.

Thanks,

        tglx



