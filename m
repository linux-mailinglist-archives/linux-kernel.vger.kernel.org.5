Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C157A4308
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239956AbjIRHmS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:42:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbjIRHlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:41:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD72DE7F;
        Mon, 18 Sep 2023 00:38:03 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="410544304"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="410544304"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:38:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10836"; a="815916722"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="815916722"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 00:37:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1qi8pP-0000000Et6E-2GVY;
        Mon, 18 Sep 2023 10:37:55 +0300
Date:   Mon, 18 Sep 2023 10:37:55 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     nikita.shubin@maquefel.me
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Lukasz Majewski <lukma@denx.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v4 01/42] gpio: ep93xx: split device in multiple
Message-ID: <ZQf+U2ZQWiJbJGGp@smile.fi.intel.com>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
 <20230915-ep93xx-v4-1-a1d779dcec10@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230915-ep93xx-v4-1-a1d779dcec10@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 15, 2023 at 11:10:43AM +0300, Nikita Shubin via B4 Relay wrote:
> From: Nikita Shubin <nikita.shubin@maquefel.me>
> 
> Prepare ep93xx SOC gpio to convert into device tree driver:
> - dropped banks and legacy defines
> - split AB IRQ and make it shared
> 
> We are relying on IRQ number information A, B ports have single shared
> IRQ, while F port have dedicated IRQ for each line.
> 
> Also we had to split single ep93xx platform_device into multiple, one
> for each port, without this we can't do a full working transition from
> legacy platform code into device tree capable. All GPIO_LOOKUP were
> change to match new chip namings.

...

>  #include <linux/reboot.h>
>  #include <linux/usb/ohci_pdriver.h>
>  #include <linux/random.h>
> +#include <linux/ioport.h>

Can it be squeezed to the most ordered part?

...

> +static struct resource ep93xx_a_gpio_resources[] = {
> +	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE,        0x04, "data"),

You can also use " + 0x00", but it's up to you.

> +	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x10, 0x04, "dir"),
> +	DEFINE_RES_MEM_NAMED(EP93XX_GPIO_PHYS_BASE + 0x90, 0x1c, "intr"),
>  	DEFINE_RES_IRQ(IRQ_EP93XX_GPIO_AB),
> +};

...

>  	.dev_id		= "i2c-gpio.0",
>  	.table		= {
>  		/* Use local offsets on gpiochip/port "G" */
> -		GPIO_LOOKUP_IDX("G", 1, NULL, 0,
> +		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 1, NULL, 0,
>  				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),
> -		GPIO_LOOKUP_IDX("G", 0, NULL, 1,
> +		GPIO_LOOKUP_IDX("gpio-ep93xx.6", 0, NULL, 1,
>  				GPIO_ACTIVE_HIGH | GPIO_OPEN_DRAIN),

Here the terminator is missing, I believe you need to have a separate fix patch
done first to prepend this one.

>  	},

...

>  #include <linux/seq_file.h>
> +#include <linux/interrupt.h>

Please, squeeze this to the most sorted part.

...

>  static void ep93xx_gpio_irq_mask_ack(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
> -	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
> -	int port_mask = BIT(d->irq & 7);

	irq_hw_number_t hwirq = irqd_to_hwirq(d);

> +	int port_mask = BIT(hwirq);
>  
>  	if (irqd_get_trigger_type(d) == IRQ_TYPE_EDGE_BOTH)
>  		eic->int_type2 ^= port_mask; /* switch edge direction */
>  
>  	eic->int_unmasked &= ~port_mask;
> -	ep93xx_gpio_update_int_params(epg, eic);
> +	ep93xx_gpio_update_int_params(eic);
>  
> -	writeb(port_mask, epg->base + eic->irq_offset + EP93XX_INT_EOI_OFFSET);
> +	writeb(port_mask, eic->base + EP93XX_INT_EOI_OFFSET);

>  	gpiochip_disable_irq(gc, irqd_to_hwirq(d));

	gpiochip_disable_irq(gc, hwirq);

>  }

...

>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
> -	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
>  
> -	eic->int_unmasked &= ~BIT(d->irq & 7);
> -	ep93xx_gpio_update_int_params(epg, eic);
> +	eic->int_unmasked &= ~BIT(irqd_to_hwirq(d));
> +	ep93xx_gpio_update_int_params(eic);
>  	gpiochip_disable_irq(gc, irqd_to_hwirq(d));
>  }

As per above.

...

> @@ -203,11 +164,10 @@ static void ep93xx_gpio_irq_unmask(struct irq_data *d)
>  {
>  	struct gpio_chip *gc = irq_data_get_irq_chip_data(d);
>  	struct ep93xx_gpio_irq_chip *eic = to_ep93xx_gpio_irq_chip(gc);
> -	struct ep93xx_gpio *epg = gpiochip_get_data(gc);
>  
>  	gpiochip_enable_irq(gc, irqd_to_hwirq(d));
> -	eic->int_unmasked |= BIT(d->irq & 7);
> -	ep93xx_gpio_update_int_params(epg, eic);
> +	eic->int_unmasked |= BIT(irqd_to_hwirq(d));
> +	ep93xx_gpio_update_int_params(eic);
>  }

As per above.

...

> +	irq_hw_number_t offset = irqd_to_hwirq(d);

(or use hwirq name to be consistent in the code).

...

> +	girq->parents = devm_kcalloc(dev, girq->num_parents,
> +				   sizeof(*girq->parents),

I would put this one to the previous line.

> +				   GFP_KERNEL);
> +	if (!girq->parents)
> +		return -ENOMEM;

...

> +			irq = platform_get_irq(pdev, i);

This will issue a warning or error message if IRQ is not found...

> +			if (irq < 0)

> +				continue;

...but this suggests that that is optional. Hence

			irq = platform_get_irq_optional(pdev, i);

?

...

> +	if (platform_irq_count(pdev) > 0) {
> +		dev_dbg(&pdev->dev, "setting up irqs for %s\n", dev_name(&pdev->dev));
> +		ret = ep93xx_setup_irqs(pdev, egc);
> +		if (ret)
> +			dev_err_probe(&pdev->dev, ret, "setup irqs failed");

Hmm... Missing return?

>  	}

-- 
With Best Regards,
Andy Shevchenko


