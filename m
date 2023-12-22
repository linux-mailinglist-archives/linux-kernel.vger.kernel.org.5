Return-Path: <linux-kernel+bounces-9748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E3A81CAAA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:26:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E27F0289141
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DFA1CABB;
	Fri, 22 Dec 2023 13:26:40 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04DC1A5A2;
	Fri, 22 Dec 2023 13:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398900520"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="398900520"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:26:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="726787897"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="726787897"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 05:26:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rGfLA-000000089ng-2UHH;
	Fri, 22 Dec 2023 15:13:24 +0200
Date: Fri, 22 Dec 2023 15:13:24 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Tzuyi Chang <tychang@realtek.com>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] Add GPIO support for Realtek DHC(Digital Home
 Center) RTD SoCs.
Message-ID: <ZYWLdG9kxm2ql0uf@smile.fi.intel.com>
References: <20231222075812.6540-1-tychang@realtek.com>
 <20231222075812.6540-3-tychang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222075812.6540-3-tychang@realtek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 03:58:12PM +0800, Tzuyi Chang wrote:
> This driver enables configuration of GPIO direction, GPIO values, GPIO
> debounce settings and handles GPIO interrupts.

...

> +	help
> +	  Say yes here to support GPIO on Realtek DHC(Digital Home Center)
> +	  SoCs.

checkpatch.pl complains if it's less than 3 lines.

...

Please, follow IWYU principle.

> +#include <linux/bitops.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/interrupt.h>
> +#include <linux/irqchip.h>
> +#include <linux/irqchip/chained_irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>

> +#include <linux/spinlock.h>

+ types.h

...

> +struct rtd_gpio_info {
> +	const char		*name;
> +	unsigned int		gpio_base;
> +	unsigned int		num_gpios;
> +	u8			*dir_offset;
> +	u8			*dato_offset;
> +	u8			*dati_offset;
> +	u8			*ie_offset;
> +	u8			*dp_offset;
> +	u8			*gpa_offset;
> +	u8			*gpda_offset;
> +	u8			*deb_offset;
> +	u8			*deb_val;
> +	u8			(*get_deb_setval)(const struct rtd_gpio_info *info,
> +						   unsigned int offset, u8 *reg_offset,
> +						   u8 *shift, u8 deb_index);

Basically you should group input parameters and output for better
understanding.

	u8		(*get_deb_setval)(const struct rtd_gpio_info *info,
					  unsigned int offset, u8 deb_index,
					  u8 *reg_offset, u8 *shift);

Also indent the lines properly (besides the TABs).

> +};

Make it one TAB less in the middle.

...

> +static u8 rtd_gpio_get_deb_setval(const struct rtd_gpio_info *info, unsigned int offset,
> +				u8 *reg_offset, u8 *shift, u8 deb_val)

Why is it called val here and index in the other cases?
Can you come up with better naming that it can be consistent in all four places?

> +{
> +	*reg_offset = info->deb_offset[offset / 8];
> +	*shift = (offset % 8) * 4;
> +	return info->deb_val[deb_val];
> +}
> +
> +static u8 rtd1295_misc_gpio_get_deb_setval(const struct rtd_gpio_info *info, unsigned int offset,
> +					 u8 *reg_offset, u8 *shift, u8 deb_index)
> +{
> +	*reg_offset = info->deb_offset[0];
> +	*shift = (offset % 8) * 4;
> +	return info->deb_val[deb_index];
> +}

> +static u8 rtd1295_iso_gpio_get_deb_setval(const struct rtd_gpio_info *info, unsigned int offset,
> +					u8 *reg_offset, u8 *shift, u8 deb_index)
> +{
> +	*reg_offset = info->deb_offset[0];
> +	*shift = 0;
> +	return info->deb_val[deb_index];
> +}

...

> +static int rtd_gpio_gpa_offset(struct rtd_gpio *data, unsigned int offset)
> +{
> +	return data->info->gpa_offset[offset / 31];
> +}
> +
> +static int rtd_gpio_gpda_offset(struct rtd_gpio *data, unsigned int offset)
> +{
> +	return data->info->gpda_offset[offset / 31];
> +}

The / 31 so-o-o counter intuitive, please add a comment in each case to explain
why [it's not 32 or other power-of-2].

...

> +	raw_spin_lock_irqsave(&data->lock, flags);
> +	writel_relaxed(val, data->base + reg_offset);
> +	raw_spin_unlock_irqrestore(&data->lock, flags);

Convert to use cleanup.c, in particular here it becomes

	guard(raw_spinlock_irqsave)(&data->lock);

	writel_relaxed(val, data->base + reg_offset);

...

> +	val = readl_relaxed(data->base + dir_reg_offset);
> +	val &= BIT(offset % 32);
> +	dat_reg_offset = val ?
> +			 rtd_gpio_dato_offset(data, offset) : rtd_gpio_dati_offset(data, offset);
> +
> +	val = readl_relaxed(data->base + dat_reg_offset);

> +	val >>= offset % 32;
> +	val &= 0x1;

Replace 3 LoCs by 1:

	return !!(val & BIT(ofsset % 32));


Missed locking. How do you guarantee that you will get consistent results
between the reads?

...

> +	val &= BIT(offset % 32);
> +
> +	return val ? GPIO_LINE_DIRECTION_OUT : GPIO_LINE_DIRECTION_IN;

	if (val & BIT(...))
		return _OUT;
	return _IN;

...

> +	for (i = 0; i < data->info->num_gpios; i += 31) {

Same, add explanation why 31.

Note, I actually prefer to see use of valid_mask instead of this weirdness.
Then you will need to comment only once and use 32 (almost?) everywhere.

> +		reg_offset = get_reg_offset(data, i);
> +
> +		status = readl_relaxed(data->irq_base + reg_offset) >> 1;
> +		writel_relaxed(status << 1, data->irq_base + reg_offset);
> +
> +		for_each_set_bit(j, &status, 31) {
> +			hwirq = i + j;

Nice, but you can do better

		/* Bit 0 is special... bla-bla-bla... */
		status = readl_relaxed(data->irq_base + reg_offset);
		status &= ~BIT(0);
		writel_relaxed(status, data->irq_base + reg_offset);

		for_each_set_bit(j, &status, 32) {
			hwirq = i + j - 1;

> +			if (rtd_gpio_check_ie(data, hwirq)) {
> +				int girq = irq_find_mapping(domain, hwirq);
> +				u32 irq_type = irq_get_trigger_type(girq);
> +
> +				if ((irq == data->irqs[1]) && ((irq_type & IRQ_TYPE_SENSE_MASK) !=
> +					IRQ_TYPE_EDGE_BOTH))

Do you need mask? Isn't irq_type already properly masked here?

> +					break;
> +				generic_handle_domain_irq(domain, hwirq);
> +			}
> +		}
> +	}

...

> +	u32 clr_mask = BIT(hwirq % 31) << 1;
> +	u32 ie_mask = BIT(hwirq % 32);

This blows the mind. Needs a comment.

...

> +static int rtd_gpio_irq_set_type(struct irq_data *d, unsigned int type)
> +{
> +	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
> +	struct rtd_gpio *data = gpiochip_get_data(gc);
> +	irq_hw_number_t hwirq = irqd_to_hwirq(d);
> +	u32 mask = BIT(hwirq % 32);
> +	unsigned long flags;
> +	int dp_reg_offset;
> +	bool polarity;
> +	u32 val;
> +
> +	dp_reg_offset = rtd_gpio_dp_offset(data, hwirq);
> +
> +	switch (type & IRQ_TYPE_SENSE_MASK) {
> +	case IRQ_TYPE_EDGE_RISING:
> +		polarity = 1;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_FALLING:
> +		polarity = 0;
> +		break;
> +
> +	case IRQ_TYPE_EDGE_BOTH:
> +		polarity = 1;
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	raw_spin_lock_irqsave(&data->lock, flags);
> +
> +	val = readl_relaxed(data->base + dp_reg_offset);
> +	if (polarity)
> +		val |= mask;
> +	else
> +		val &= ~mask;
> +	writel_relaxed(val, data->base + dp_reg_offset);
> +
> +	raw_spin_unlock_irqrestore(&data->lock, flags);
> +
> +	return 0;
> +}

...

> +	irq_chip->handler = handle_simple_irq;

Please, apply bad handler here and lock it in the set_type callback above.

You may read eb441337c714 ("gpio: pca953x: Set IRQ type when handle Intel
Galileo Gen 2") to understand the difference.

...

> +static int rtd_gpio_init(void)
> +{
> +	return platform_driver_register(&rtd_gpio_platform_driver);
> +}

> +

Redundant blank line, but see below.

> +module_init(rtd_gpio_init);
> +
> +static void __exit rtd_gpio_exit(void)
> +{
> +	platform_driver_unregister(&rtd_gpio_platform_driver);
> +}
> +module_exit(rtd_gpio_exit);

There is no special initcall, you may use module_platform_driver() macro
instead.

-- 
With Best Regards,
Andy Shevchenko



