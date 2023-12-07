Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C20880896B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442024AbjLGNpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:45:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjLGNpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:45:16 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEDFD5E;
        Thu,  7 Dec 2023 05:45:22 -0800 (PST)
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="393100094"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393100094"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:45:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="915589071"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="915589071"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 05:45:19 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andy@kernel.org>)
        id 1rBEgn-00000002c3h-1M7R;
        Thu, 07 Dec 2023 15:45:17 +0200
Date:   Thu, 7 Dec 2023 15:45:17 +0200
From:   Andy Shevchenko <andy@kernel.org>
To:     TY Chang <tychang@realtek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Message-ID: <ZXHMbZRXLXGa_tq8@smile.fi.intel.com>
References: <20231207100723.15015-1-tychang@realtek.com>
 <20231207100723.15015-3-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207100723.15015-3-tychang@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 06:07:23PM +0800, TY Chang wrote:
> From: Tzuyi Chang <tychang@realtek.com>
> 
> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.

Why gpio-regmap can't be used?

...

> +struct rtd_gpio_info {

> +	u8			*dir_offset;
> +	u8			num_dir;
> +	u8			*dato_offset;
> +	u8			num_dato;
> +	u8			*dati_offset;
> +	u8			num_dati;
> +	u8			*ie_offset;
> +	u8			num_ie;
> +	u8			*dp_offset;
> +	u8			num_dp;
> +	u8			*gpa_offset;
> +	u8			num_gpa;
> +	u8			*gpda_offset;
> +	u8			num_gpda;
> +	u8			*deb_offset;
> +	u8			num_deb;

A lot of wasted space. Can you group pointers followed by u8 members?
Note, use `pahole` tool to check the struct layout in C.

> +};

...

> +struct rtd_gpio {
> +	struct platform_device		*pdev;

Why

	struct device *dev;

is not suffice?

> +	const struct rtd_gpio_info	*info;
> +	void __iomem			*base;
> +	void __iomem			*irq_base;

> +	struct gpio_chip		gpio_chip;

Make this to be the first member, it might reduce some code
(due to pointer arithmetics).

> +	unsigned int			irqs[2];
> +	spinlock_t			lock;
> +};
> +
> +

One blank line is enough.

...

> +static const struct rtd_gpio_info rtd_iso_gpio_info = {
> +	.name		= "rtd_iso_gpio",
> +	.type		= RTD_ISO_GPIO,
> +	.gpio_base	= 0,
> +	.num_gpios	= 82,
> +	.dir_offset	= (u8 []){ 0x0, 0x18, 0x2c },
> +	.num_dir	= 3,
> +	.dato_offset	= (u8 []){ 0x4, 0x1c, 0x30 },
> +	.num_dato	= 3,
> +	.dati_offset	= (u8 []){ 0x8, 0x20, 0x34 },
> +	.num_dati	= 3,
> +	.ie_offset	= (u8 []){ 0xc, 0x24, 0x38 },
> +	.num_ie		= 3,
> +	.dp_offset	= (u8 []){ 0x10, 0x28, 0x3c },
> +	.num_dp		= 3,
> +	.gpa_offset	= (u8 []){ 0x8, 0xe0, 0x90 },
> +	.num_gpa	= 3,
> +	.gpda_offset	= (u8 []){ 0xc, 0xe4, 0x94 },
> +	.num_gpda	= 3,
> +	.deb_offset	= (u8 []){ 0x44, 0x48, 0x4c, 0x50, 0x54, 0x58, 0x5c,
> +				   0x60, 0x64, 0x68, 0x6c },
> +	.num_deb	= 11,

Use ARRAY_SIZE() from array_size.h for all num_* assignments.

> +};

...

> +static const struct rtd_gpio_info rtd1619_iso_gpio_info = {

Ditto.

> +};

...

> +static const struct rtd_gpio_info rtd1395_iso_gpio_info = {

Ditto.

> +};
> +
> +static const struct rtd_gpio_info rtd1295_misc_gpio_info = {

Ditto.

> +};
> +
> +static const struct rtd_gpio_info rtd1295_iso_gpio_info = {

Ditto.

> +};

...

> +static int rtd_gpio_dir_offset(struct rtd_gpio *data, unsigned int offset)
> +{
> +	int index = offset / 32;

> +	if (index > data->info->num_dir)
> +		return -EINVAL;

When this conditional can be true?
Same Q to the similar checks over the code.

> +	return data->info->dir_offset[index];
> +}

...

> +	if (data->info->type == RTD1295_ISO_GPIO) {
> +		reg_offset = rtd_gpio_deb_offset(data, 0);
> +		if (reg_offset < 0)
> +			return reg_offset;
> +		shift = 0;
> +		deb_val += 1;
> +		write_en = BIT(shift + 3);
> +	} else if (data->info->type == RTD1295_MISC_GPIO) {
> +		reg_offset = rtd_gpio_deb_offset(data, 0);
> +		if (reg_offset < 0)
> +			return reg_offset;
> +		shift = (offset >> 4) * 4;
> +		deb_val += 1;
> +		write_en = BIT(shift + 3);
> +	} else {
> +		reg_offset = rtd_gpio_deb_offset(data, offset);
> +		if (reg_offset < 0)
> +			return reg_offset;
> +		shift = (offset % 8) * 4;
> +		write_en = BIT(shift + 3);
> +	}

You should probably have kind of chip_info constant structure that goes via
driver_data and will have a callback, so, here you will call one and get all
three at once:
 - register offset;
 - shift
 - updated debounce value

...

> +static int rtd_gpio_get_direction(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct rtd_gpio *data = gpiochip_get_data(chip);
> +	unsigned long flags;
> +	int reg_offset;
> +	u32 val;
> +
> +	reg_offset = rtd_gpio_dir_offset(data, offset);
> +	if (reg_offset < 0)
> +		return reg_offset;

> +	spin_lock_irqsave(&data->lock, flags);

So, is your IRQ chip going to work with CONFIG_PREEMT_RT?

> +	val = readl_relaxed(data->base + reg_offset);

> +	val &= BIT(offset % 32);

Why this is is under lock?

> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;
> +}

...

> +static int rtd_gpio_set_direction(struct gpio_chip *chip, unsigned int offset, bool out)
> +{

> +	unsigned long flags;


> +	spin_lock_irqsave(&data->lock, flags);


> +	spin_unlock_irqrestore(&data->lock, flags);

Consider to utilise guard() / scoped_guard() from cleanup.h.

> +}

...

> +static int rtd_gpio_direction_output(struct gpio_chip *chip, unsigned int offset, int value)
> +{

> +	chip->set(chip, offset, value);

Why? Can't you call the function by its name directly?

> +
> +	return rtd_gpio_set_direction(chip, offset, true);
> +}

...

> +static int rtd_gpio_get(struct gpio_chip *chip, unsigned int offset)
> +{
> +	struct rtd_gpio *data = gpiochip_get_data(chip);
> +	int dir_reg_offset, dat_reg_offset;
> +	unsigned long flags;
> +	u32 val;
> +
> +	dir_reg_offset = rtd_gpio_dir_offset(data, offset);
> +	if (dir_reg_offset < 0)
> +		return dir_reg_offset;
> +
> +	spin_lock_irqsave(&data->lock, flags);
> +
> +	val = readl_relaxed(data->base + dir_reg_offset);
> +	val &= BIT(offset % 32);

> +	dat_reg_offset = val ?
> +			 rtd_gpio_dato_offset(data, offset) : rtd_gpio_dati_offset(data, offset);

Can't you have the direction be cached and already know which offset to use
even before the lock?

> +	val = readl_relaxed(data->base + dat_reg_offset);

> +	val >>= offset % 32;
> +	val &= 0x1;

Why were these operations done under the lock?

> +	spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return val;
> +}

...

> +static void rtd_gpio_irq_handle(struct irq_desc *desc)
> +{
> +	int (*get_reg_offset)(struct rtd_gpio *gpio, unsigned int offset);
> +	struct rtd_gpio *data = irq_desc_get_handler_data(desc);
> +	struct irq_domain *domain = data->gpio_chip.irq.domain;
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	unsigned int irq = irq_desc_get_irq(desc);
> +	int reg_offset;
> +	u32 status;

> +	int hwirq;

Why signed?

> +	int i;
> +	int j;
> +
> +	chained_irq_enter(chip, desc);

> +	if (irq == data->irqs[0])
> +		get_reg_offset = &rtd_gpio_gpa_offset;
> +	else if (irq == data->irqs[1])
> +		get_reg_offset = &rtd_gpio_gpda_offset;

Can't it be done before entering into chained IRQ handler?

> +	for (i = 0; i < data->info->num_gpios; i = i + 31) {

31 ?!  In any case i += 31 is simply shorter.

> +		reg_offset = get_reg_offset(data, i);
> +		if (reg_offset < 0)
> +			return;
> +
> +		status = readl_relaxed(data->irq_base + reg_offset) >> 1;
> +		writel_relaxed(status << 1, data->irq_base + reg_offset);

> +		while (status) {
> +			j = __ffs(status);
> +			status &= ~BIT(j);

NIH for_each_set_bit()

> +			hwirq = i + j;
> +			if (rtd_gpio_check_ie(data, hwirq)) {
> +				int girq = irq_find_mapping(domain, hwirq);
> +				u32 irq_type = irq_get_trigger_type(girq);
> +
> +				if ((irq == data->irqs[1]) && ((irq_type & IRQ_TYPE_SENSE_MASK) !=
> +					IRQ_TYPE_EDGE_BOTH))
> +					break;

> +				generic_handle_irq(girq);

Why you can't use generic_handle_domain_irq()?

> +			}
> +		}
> +	}
> +
> +	chained_irq_exit(chip, desc);
> +}

...

> +	u32 mask = BIT(d->hwirq % 32);

Use proper type and getter for hwirq. It's mentioned in the Documentation.

...

> +static const struct irq_chip rtd_gpio_irq_chip = {
> +	.name = "rtd-gpio",
> +	.irq_enable = rtd_gpio_enable_irq,
> +	.irq_disable = rtd_gpio_disable_irq,
> +	.irq_set_type = rtd_gpio_irq_set_type,

> +	.flags = IRQCHIP_IMMUTABLE,

Is it? You seems missed something to fulfill the immutability requirements.
Please consult with the Documentation, it's all written there.

> +};

...

> +static const struct of_device_id rtd_gpio_of_matches[] = {
> +	{ .compatible = "realtek,rtd1295-misc-gpio", .data = &rtd1295_misc_gpio_info },
> +	{ .compatible = "realtek,rtd1295-iso-gpio", .data = &rtd1295_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1395-iso-gpio", .data = &rtd1395_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1619-iso-gpio", .data = &rtd1619_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1319-iso-gpio", .data = &rtd_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1619b-iso-gpio", .data = &rtd_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1319d-iso-gpio", .data = &rtd_iso_gpio_info },
> +	{ .compatible = "realtek,rtd1315e-iso-gpio", .data = &rtd_iso_gpio_info },

> +	{ },

No comma in the terminator entry.

> +};
> +MODULE_DEVICE_TABLE(of, rtd_gpio_of_matches);

Move all these closer to its user (struct platform_device below).

...

> +	data->gpio_chip.label = dev_name(&pdev->dev);

dev

...

> +	data->gpio_chip.fwnode = dev_fwnode(&pdev->dev);

dev

But why setting parent device is not suffice?

...

> +static int rtd_gpio_init(void)
> +{
> +	return platform_driver_register(&rtd_gpio_platform_driver);
> +}

> +

Unneeded blank line.

> +subsys_initcall(rtd_gpio_init);

Why? Anything that is not on standard initcall must be justified.

-- 
With Best Regards,
Andy Shevchenko


