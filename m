Return-Path: <linux-kernel+bounces-1421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4EE814EC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52AC41F24C02
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3994D82EF2;
	Fri, 15 Dec 2023 17:27:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA933012B;
	Fri, 15 Dec 2023 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="8727217"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="8727217"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:27:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="892973975"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="892973975"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:27:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rEBxk-00000006BAk-29KE;
	Fri, 15 Dec 2023 19:27:00 +0200
Date: Fri, 15 Dec 2023 19:27:00 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 2/8] pinctrl: Add driver for the T-Head TH1520 SoC
Message-ID: <ZXyMZKvREy_FIl46@smile.fi.intel.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
 <20231215143906.3651122-3-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215143906.3651122-3-emil.renner.berthing@canonical.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 03:39:00PM +0100, Emil Renner Berthing wrote:
> Add pinctrl driver for the T-Head TH1520 RISC-V SoC.

...

+ array_size.h
+ bits.h
+ device.h

(and so on, please make sure you follow IWYU principle --
 "include what you use")

> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>

> +#include <linux/of.h>

Can you use device property API instead?

(I briefly checked, all of the used of_ ones have the respective generic
 implementations either in fwnode_property_ or device_property_ namespace).

OTOH, it's used in xlate/map functions which have device_node as a parameter...

> +#include <linux/platform_device.h>
> +#include <linux/seq_file.h>
> +#include <linux/spinlock.h>

...

> +#include "core.h"
> +#include "pinmux.h"
> +#include "pinconf.h"

All of them are needed?

...

> +static unsigned int th1520_padcfg_shift(unsigned int pin)
> +{
> +	return 16 * (pin & 0x1U);

BIT(0) ?

> +}

...

> +static unsigned int th1520_muxcfg_shift(unsigned int pin)
> +{
> +	return 4 * (pin & 0x7U);

GENMASK() ?

> +}

...

> +			return dev_err_probe(thp->pctl->dev, -EINVAL,
> +					     "no pins selected for %pOFn.%pOFn\n",
> +					     np, child);

> +			dev_err(thp->pctl->dev, "error parsing pin config of group %pOFn.%pOFn\n",
> +				np, child);

In the very same function you are using dev_err_probe(), please make sure
you use the same for all error messages as it will be a unified format
(in case of dev_err_probe() or if you explicitly do that with dev_err()
calls).

> +		}

...

> +static const struct pinctrl_ops th1520_pinctrl_ops = {
> +	.get_groups_count = th1520_pinctrl_get_groups_count,
> +	.get_group_name = th1520_pinctrl_get_group_name,
> +	.get_group_pins = th1520_pinctrl_get_group_pins,

> +	.pin_dbg_show = th1520_pin_dbg_show,

Is ifdeffery needed for this one?


> +	.dt_node_to_map = th1520_pinctrl_dt_node_to_map,
> +	.dt_free_map = th1520_pinctrl_dt_free_map,

Is ifdeffery needed for these two?

> +};

...

> +	mask = 0xfU << shift;
> +	value = ((uintptr_t)func->data & 0xfU) << shift;

GENMASK() in both cases.

> +	raw_spin_lock_irqsave(&thp->lock, flags);
> +	value |= readl_relaxed(muxcfg) & ~mask;

Instead of above, use the traditional pattern

	value = read()
	value = (value & ~mask) | (newval & mask);
	write()

where newval is defined with a proper type and you get rid of all those ugly
castings at once.

> +	writel_relaxed(value, muxcfg);
> +	raw_spin_unlock_irqrestore(&thp->lock, flags);

...

> +static u16 th1520_drive_strength_from_mA(u32 arg)
> +{
> +	u16 v;
> +
> +	for (v = 0; v < ARRAY_SIZE(th1520_drive_strength_in_mA) - 1; v++) {

You may drop -1 here AFAIU (see below).

> +		if (arg <= th1520_drive_strength_in_mA[v])
> +			break;

return directly.

> +	}

> +	return v;

return explicit value which will be robust against changes in the for-loop or
elsewhere in the code.

> +}

...

> +static int th1520_padcfg_rmw(struct th1520_pinctrl *thp, unsigned int pin,
> +			     u16 _mask, u16 _value)

Why not naming them without underscores?

> +{
> +	void __iomem *padcfg = th1520_padcfg(thp, pin);
> +	unsigned int shift = th1520_padcfg_shift(pin);

> +	u32 mask = (u32)_mask << shift;
> +	u32 value = (u32)_value << shift;

Oh, no castings, please.

> +	unsigned long flags;
> +
> +	raw_spin_lock_irqsave(&thp->lock, flags);

Use cleanup.h.

> +	value |= readl_relaxed(padcfg) & ~mask;
> +	writel_relaxed(value, padcfg);
> +	raw_spin_unlock_irqrestore(&thp->lock, flags);
> +	return 0;
> +}

...

> +#define PIN_CONFIG_THEAD_STRONG_PULL_UP	(PIN_CONFIG_END + 1)

Oh, custom flag! Linus, what is the expected approach for custom flags like this?
I believe this is quite error prone.

...

> +	value = readl_relaxed(th1520_padcfg(thp, pin));
> +	value = (value >> th1520_padcfg_shift(pin)) & 0x3ffU;

GENMASK() and in many other places like this.

...

> +		enabled = value & TH1520_PADCFG_IE;
> +		arg = enabled;

Assigning boolean to integer... Hmm...

> +		break;
> +	case PIN_CONFIG_INPUT_SCHMITT_ENABLE:
> +		enabled = value & TH1520_PADCFG_ST;
> +		arg = enabled;
> +		break;
> +	case PIN_CONFIG_SLEW_RATE:
> +		enabled = value & TH1520_PADCFG_SL;
> +		arg = enabled;
> +		break;

...

> +static int th1520_pinctrl_probe(struct platform_device *pdev)
> +{

	struct device *dev = &pdev->dev;

may give you some benefits.

> +	const struct th1520_padgroup *group = device_get_match_data(&pdev->dev);
> +	struct th1520_pinctrl *thp;
> +	int ret;
> +
> +	thp = devm_kzalloc(&pdev->dev, sizeof(*thp), GFP_KERNEL);
> +	if (!thp)
> +		return -ENOMEM;
> +
> +	thp->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(thp->base))
> +		return PTR_ERR(thp->base);
> +
> +	thp->desc.name = group->name;
> +	thp->desc.pins = group->pins;
> +	thp->desc.npins = group->npins;
> +	thp->desc.pctlops = &th1520_pinctrl_ops;
> +	thp->desc.pmxops = &th1520_pinmux_ops;
> +	thp->desc.confops = &th1520_pinconf_ops;
> +	thp->desc.owner = THIS_MODULE;
> +	thp->desc.num_custom_params = ARRAY_SIZE(th1520_pinconf_custom_params);
> +	thp->desc.custom_params = th1520_pinconf_custom_params;
> +	thp->desc.custom_conf_items = th1520_pinconf_custom_conf_items;
> +	mutex_init(&thp->mutex);
> +	raw_spin_lock_init(&thp->lock);
> +
> +	ret = devm_pinctrl_register_and_init(&pdev->dev, &thp->desc, thp, &thp->pctl);
> +	if (ret)
> +		return dev_err_probe(&pdev->dev, ret, "could not register pinctrl driver\n");
> +
> +	return pinctrl_enable(thp->pctl);
> +}

-- 
With Best Regards,
Andy Shevchenko



