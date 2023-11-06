Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58C97E2007
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbjKFLa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjKFLa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:30:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C952BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:30:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699270252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J++GZwFIDRZnaCqPOr6tSshYqf4AWD2ZqLB8oYm0+P0=;
        b=3uEzjdT+KYm8xyRkFavJ/SYTDRyPLpvttQZsPMAnBAMWzTO+BcafafrfURgA/JHA3oryS7
        4raWL0BTFEeaKd73zTtOeRvykErKdGdCsSCPoAvjyMKWI1zLI165Acpt46bEOAAADOTwE2
        0T3Oq0iCoEHBVT21Ju0DUXJRsVkg4DS8pRfuOdpFQZN17R9ycM0O6nzsfSa4j+jbbdxaMA
        dXqDfXbO11XgIeQ8BBtE4CK3wh/EdIDbcP1Ly+fHPr2Jcb1rXPcUeAGdAEihxQm6mzVmug
        TrdHc9I58s+qF0jh2aAEij4W95keLu1MDAcmn9xaQzF89h/sveKhvl0QefGW3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699270252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J++GZwFIDRZnaCqPOr6tSshYqf4AWD2ZqLB8oYm0+P0=;
        b=sfaiC7iVprjLWqEtSYHXAULDFEZP+IDKxdIUFAiQBAX8q2yx6DMGv7UnNpMDDDc14r+wZF
        JXOEEbPZxuTIv6Cw==
To:     James Tai <james.tai@realtek.com>, linux-kernel@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
In-Reply-To: <20231102142731.2087245-3-james.tai@realtek.com>
References: <20231102142731.2087245-1-james.tai@realtek.com>
 <20231102142731.2087245-3-james.tai@realtek.com>
Date:   Mon, 06 Nov 2023 12:30:51 +0100
Message-ID: <87wmuvgluc.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02 2023 at 22:27, James Tai wrote:
> Realtek DHC (Digital Home Center) SoCs share a common interrupt controller design.
> This universal interrupt controller driver provides support for various variants
> within the Realtek DHC SoC family.
>
> Each DHC SoC features two sets of extended interrupt controllers, each capable of
> handling up to 32 interrupts. These expansion controllers are connected to the GIC
> (Generic Interrupt Controller).
>
> Signed-off-by: James Tai <james.tai@realtek.com>
> Change-Id: I1e711c70414c97c2c8497bd4ac9e8bbd964225c3

Please remove these internal change ids. They are not useful for anyone
outside realtek.
  
> +config REALTEK_DHC_INTC
> +	tristate
> +	select IRQ_DOMAIN
> +


> +static unsigned int realtek_intc_get_ints(struct realtek_intc_data *data)

static inline perhaps?

> +{
> +	return readl(data->base + data->info->isr_offset);
> +}
> +
> +static void realtek_intc_clear_ints_bit(struct realtek_intc_data *data, int bit)
> +{
> +	writel(BIT(bit) & ~1, data->base + data->info->isr_offset);
> +}
> +
> +static unsigned int realtek_intc_get_inte(struct realtek_intc_data *data)
> +{
> +	unsigned int val;
> +	unsigned long flags;

	unsigned long flags;
	unsigned int val;

https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

Please fix the variable declarations all over the place.

> +	spin_lock_irqsave(&data->lock, flags);

This needs to be a raw spinlock.

> +	val = readl(data->base + data->info->scpu_int_en_offset);
> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return val;
> +}


> +static void realtek_intc_enable_irq(struct irq_data *data)
> +{
> +	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 scpu_int_en, mask;

See above.

> +
> +	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
> +	if (!mask)
> +		return;
> +
> +	spin_lock_irqsave(&intc_data->lock, flags);
> +
> +	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
> +	scpu_int_en |= mask;
> +	writel(scpu_int_en, intc_data->base + intc_data->info->umsk_isr_offset);
> +
> +	spin_unlock_irqrestore(&intc_data->lock, flags);
> +}
> +
> +static void realtek_intc_disable_irq(struct irq_data *data)
> +{
> +	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(data);
> +	unsigned long flags;
> +	u32 scpu_int_en, mask;
> +
> +	mask = intc_data->info->isr_to_scpu_int_en_mask[data->hwirq];
> +	if (!mask)
> +		return;
> +
> +	spin_lock_irqsave(&intc_data->lock, flags);
> +
> +	scpu_int_en = readl(intc_data->base + intc_data->info->scpu_int_en_offset);
> +	scpu_int_en &= ~mask;
> +	writel(scpu_int_en, intc_data->base + intc_data->info->umsk_isr_offset);
> +
> +	spin_unlock_irqrestore(&intc_data->lock, flags);
> +}
> +
> +static int realtek_intc_lookup_parent_irq(struct realtek_intc_data *intc_data, struct irq_data *d)
> +{
> +	unsigned int mask = BIT(d->hwirq);
> +	int i;
> +
> +	for (i = 0; i < intc_data->subset_data_num; i++)
> +		if (intc_data->subset_data[i].cfg->ints_mask & mask)
> +			return intc_data->subset_data[i].parent_irq;

Lacks brackets around the for loop. See documentation.

> +
> +	return -EINVAL;
> +}
> +
> +static int realtek_intc_set_affinity(struct irq_data *d, const struct cpumask *mask_val, bool force)
> +{
> +	struct realtek_intc_data *intc_data = irq_data_get_irq_chip_data(d);
> +	int irq;
> +	struct irq_chip *chip;
> +	struct irq_data *data;
> +
> +	irq = realtek_intc_lookup_parent_irq(intc_data, d);
> +	if (irq < 0)
> +		return irq;
> +
> +	chip = irq_get_chip(irq);
> +	data = irq_get_irq_data(irq);

So instead of two lookups you want to do:

	data = irq_get_irq_data(irq);
        if (!data)
        	return;
        chip = irq_data_get_irq_chip(data);        
...
       
> +
> +	irq_data_update_effective_affinity(d, cpu_online_mask);

So you update the effective affinity even if it cannot be set or if the
parent irq returns an error code?

Aside of that setting it to cpu_online mask is just wrong. This is _NOT_
the effective affinity because the underlying GIC selects a single
target CPU out of the caller provides cpu mask.

That said, this is also completely inconsistent vs. the other interrupts
which share that GIC interrupt instance. I.e. /proc/irq/$N/affinity and
effective_affinity become random number generators. That'll confuse
existing userspace tools.

Having an affinity setter for demultiplexes interrupts is simply wrong.

> +	if (chip && chip->irq_set_affinity)
> +		return chip->irq_set_affinity(data, mask_val, force);
> +	else
> +		return -EINVAL;
> +}
> +
> +static struct irq_chip realtek_intc_chip = {
> +	.name = "realtek-intc",
> +	.irq_mask = realtek_intc_mask_irq,
> +	.irq_unmask = realtek_intc_unmask_irq,
> +	.irq_enable = realtek_intc_enable_irq,
> +	.irq_disable = realtek_intc_disable_irq,
> +	.irq_set_affinity = realtek_intc_set_affinity,

See docs vs. formatting of struct initializers.

> +};
> +
> +
> +	data->subset_data_num = info->cfg_num;
> +	for (i = 0; i < info->cfg_num; i++) {
> +		ret = realtek_intc_subset(node, data, i);
> +		WARN(ret, "failed to init subset %d: %d", i, ret);

If this fails, then you still expose the affected interrupts as
functional?

> +/**
> + * realtek_intc_subset_cfg - subset interrupt mask
> + * @ints_mask: inetrrupt mask
> + */
> +struct realtek_intc_subset_cfg {
> +	unsigned int ints_mask;
> +};
> +
> +/**
> + * realtek_intc_info - interrupt controller data.
> + * @isr_offset: interrupt status register offset.
> + * @umsk_isr_offset: unmask interrupt status register offset.
> + * @scpu_int_en_offset: interrupt enable register offset.
> + * @cfg: cfg of the subset.
> + * @cfg_num: number of cfg.
> + */
> +struct realtek_intc_info {
> +	unsigned int isr_offset;
> +	unsigned int umsk_isr_offset;
> +	unsigned int scpu_int_en_offset;
> +	const u32 *isr_to_scpu_int_en_mask;
> +	const struct realtek_intc_subset_cfg *cfg;
> +	int cfg_num;

See formatting doc.

> +
> +#define IRQ_ALWAYS_ENABLED  (-1)

U32_MAX ?

> +#define DISABLE_INTC (0)
> +#define CLEAN_INTC_STATUS (0xfffffffe)

That's what GENMASK() is for.

Thanks,

        tglx
 
