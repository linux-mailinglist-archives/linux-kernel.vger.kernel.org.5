Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B825780A771
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574328AbjLHPbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232481AbjLHPbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:31:02 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD810F1;
        Fri,  8 Dec 2023 07:31:05 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702049463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kM2gfM4stLx1K6L+3Wj5bEw38BxAF95LAx7kBEjCuto=;
        b=TTjqPrRzGk9nL8pZrlbLig8nLw0elK3wmLC3t/4aftYWymZ9tjnUWH2smJ+JJWgvEkwj3/
        9+rkK3i7pnw0wiKFTu8NNb/TGug3LJVtDO/GRzKrssaoxKRcO5DfNKEfOcazgbFQhlXw5i
        7bueF3+LDojAH5/kP3XhDQ1o6JD6MnCt3Svw+VhHt/dmTaNoR4URC5C2U1DWKl4UTBbWqs
        /m5NLKj65RFR3hy6qvhE1vn4B6ss3eCwMHpSTuTG+IGp8q7jlqzSHteAtlFZof5PsQIOGP
        Q9oz3gAjBLoDBxhDvd4qqnJgius0uOmFjDHE7VFIRUy8lQ7wexHMQmVmyn5/PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702049463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kM2gfM4stLx1K6L+3Wj5bEw38BxAF95LAx7kBEjCuto=;
        b=IG0x/GKvuLwBqMEc1i1QfOJ2/hxnHDNm8aeL9CD5msZe2NOJs5rU8mlAKByuz+L/sgJT5k
        nVja4PdTSis57qAg==
To:     James Tai <james.tai@realtek.com>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH v3 2/6] irqchip: Add interrupt controller support for
 Realtek DHC SoCs
In-Reply-To: <20231129054339.3054202-3-james.tai@realtek.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-3-james.tai@realtek.com>
Date:   Fri, 08 Dec 2023 16:31:02 +0100
Message-ID: <87cyvgsocp.ffs@tglx>
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

On Wed, Nov 29 2023 at 13:43, James Tai wrote:
> Realtek DHC (Digital Home Center) SoCs share a common interrupt controller
> design. This universal interrupt controller driver provides support for
> various variants within the Realtek DHC SoC family.
>
> Each DHC SoC features two sets of extended interrupt controllers, each
> capable of handling up to 32 interrupts. These expansion controllers are
> connected to the GIC (Generic Interrupt Controller).
>
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/r/202311201929.2FpvMRlg-lkp@intel.com/

These tags are pointless as they are not related to anything in
tree. You addressed review comments and 0-day fallout, but neither Dan
nor 0-day reported that the interrupt controller for Realtek DHC SoCs is
missing.

> +#include "irq-realtek-intc-common.h"
> +
> +struct realtek_intc_data;

struct realtek_intc_data is declared in irq-realtek-intc-common.h, so
what's the point of this forward declaration?

> +static inline unsigned int realtek_intc_get_ints(struct realtek_intc_data *data)
> +{
> +	return readl(data->base + data->info->isr_offset);
> +}
> +
> +static inline void realtek_intc_clear_ints_bit(struct realtek_intc_data *data, int bit)
> +{
> +	writel(BIT(bit) & ~1, data->base + data->info->isr_offset);

That '& ~1' solves what aside of preventing bit 0 from being written?

> +static int realtek_intc_domain_map(struct irq_domain *d, unsigned int irq, irq_hw_number_t hw)
> +{
> +	struct realtek_intc_data *data = d->host_data;
> +
> +	irq_set_chip_and_handler(irq, &realtek_intc_chip, handle_level_irq);
> +	irq_set_chip_data(irq, data);
> +	irq_set_probe(irq);
> +
> +	return 0;
> +}
> +
> +static const struct irq_domain_ops realtek_intc_domain_ops = {
> +	.xlate = irq_domain_xlate_onecell,
> +	.map = realtek_intc_domain_map,

	.xlate	= irq_domain_xlate_onecell,
	.map	= realtek_intc_domain_map,

Please.

> +};
> +
> +static int realtek_intc_subset(struct device_node *node, struct realtek_intc_data *data, int index)
> +{
> +	struct realtek_intc_subset_data *subset_data = &data->subset_data[index];
> +	const struct realtek_intc_subset_cfg *cfg = &data->info->cfg[index];
> +	int irq;
> +
> +	irq = irq_of_parse_and_map(node, index);

irq_of_parse_and_map() returns an 'unsigned int' where 0 is fail.

> +	if (irq <= 0)
> +		return irq;
> +
> +	subset_data->common = data;
> +	subset_data->cfg = cfg;
> +	subset_data->parent_irq = irq;
> +	irq_set_chained_handler_and_data(irq, realtek_intc_handler, subset_data);
> +
> +	return 0;
> +}
> +
> +int realtek_intc_probe(struct platform_device *pdev, const struct realtek_intc_info *info)
> +{
> +	struct realtek_intc_data *data;
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	int ret, i;
> +
> +	data = devm_kzalloc(dev, struct_size(data, subset_data, info->cfg_num), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	data->base = of_iomap(node, 0);
> +	if (!data->base) {
> +		ret = -ENOMEM;
> +		goto out_cleanup;

devm_kzalloc() is automatically cleaned up when the probe function
fails, so 'return -ENOMEM;' is sufficient.

> +	}
> +
> +	data->info = info;
> +
> +	raw_spin_lock_init(&data->lock);
> +
> +	data->domain = irq_domain_add_linear(node, 32, &realtek_intc_domain_ops, data);
> +	if (!data->domain) {
> +		ret = -ENOMEM;

This 'ret = -ENOMEM;' is pointless as the only error code returned in this
function is -ENOMEM. So you can just return -ENOMEM in the error path, no?

> +		goto out_cleanup;
> +	}
> +
> +	data->subset_data_num = info->cfg_num;
> +	for (i = 0; i < info->cfg_num; i++) {
> +		ret = realtek_intc_subset(node, data, i);
> +		if (ret) {
> +			WARN(ret, "failed to init subset %d: %d", i, ret);
> +			ret = -ENOMEM;
> +			goto out_cleanup;

                if (WARN(ret, "....."))
                	goto cleanup;

> +		}
> +	}
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +
> +out_cleanup:
> +
> +	if (data->base)
> +		iounmap(data->base);

Leaks the irqdomain.

> +
> +	devm_kfree(dev, data);

Pointless exercise.

> +	return ret;
> +}
> +EXPORT_SYMBOL(realtek_intc_probe);

EXPORT_SYMBOL_GPL

> +/**
> + * realtek_intc_subset_cfg - subset interrupt mask
> + * @ints_mask: inetrrupt mask
> + */
> +struct realtek_intc_subset_cfg {
> +	unsigned int	ints_mask;
> +};

The value of a struct wrapping a single 'unsigned int' is? What's wrong
with using unsigned int (actually you want u32 as this represents a
hardware mask) directly? Not enough obfuscation, right?

> +/**
> + * realtek_intc_info - interrupt controller data.
> + * @isr_offset: interrupt status register offset.
> + * @umsk_isr_offset: unmask interrupt status register offset.
> + * @scpu_int_en_offset: interrupt enable register offset.
> + * @cfg: cfg of the subset.
> + * @cfg_num: number of cfg.

 * @isr_offset:		interrupt status register offset
 * @umsk_isr_offset:	unmask interrupt status register offset
 * @scpu_int_en_offset:	interrupt enable register offset

Can you spot the difference?

Please fix all over the place.

> + */
> +struct realtek_intc_info {
> +	const struct realtek_intc_subset_cfg *cfg;
> +	unsigned int			     isr_offset;
> +	unsigned int			     umsk_isr_offset;
> +	unsigned int			     scpu_int_en_offset;
> +	const u32			     *isr_to_scpu_int_en_mask;
> +	int				     cfg_num;
> +};
> +
> +/**
> + * realtek_intc_subset_data - handler of a interrupt source only handles ints
> + *                            bits in the mask.
> + * @cfg: cfg of the subset.

Seriously. 'cfg of'? This is a description, so can you spell the words
out? This is really neither space constraint nor subject to Xitter
rules. Fix this all over the place please.

> + * @common: common data.
> + * @parent_irq: interrupt source.
> + */
> +struct realtek_intc_subset_data {
> +	const struct realtek_intc_subset_cfg *cfg;
> +	struct realtek_intc_data	     *common;
> +	int				     parent_irq;
> +};
> +
> +/**
> + * realtek_intc_data - configuration data for realtek interrupt controller driver.
> + * @base: base of interrupt register
> + * @info: info of intc
> + * @domain: interrupt domain
> + * @lock: lock
> + * @saved_en: status of interrupt enable
> + * @subset_data_num: number of subset data
> + * @subset_data: subset data
> + */
> +struct realtek_intc_data {
> +	void __iomem			*base;
> +	const struct realtek_intc_info	*info;
> +	struct irq_domain		*domain;
> +	struct raw_spinlock		lock;
> +	unsigned int			saved_en;
> +	int				subset_data_num;
> +	struct realtek_intc_subset_data subset_data[];
> +};
> +
> +#define IRQ_ALWAYS_ENABLED U32_MAX
> +#define DISABLE_INTC (0)
> +#define CLEAN_INTC_STATUS GENMASK(31, 1)

#define IRQ_ALWAYS_ENABLED	U32_MAX
#define DISABLE_INTC		(0)
#define CLEAN_INTC_STATUS	GENMASK(31, 1)

Please, as that makes this readable.

Thanks,

        tglx
