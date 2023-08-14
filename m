Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A483677C215
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 23:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjHNVGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjHNVGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 17:06:19 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E4A1718
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 14:06:18 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 68379b0b-3ae6-11ee-b3cf-005056bd6ce9;
        Tue, 15 Aug 2023 00:06:16 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 15 Aug 2023 00:06:15 +0300
To:     TY Chang <tychang@realtek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] pinctrl: realtek: Add pinctrl driver for RTD1315E
Message-ID: <ZNqXRyryCSRTM0IA@surfacebook.localdomain>
References: <20230726090409.16606-1-tychang@realtek.com>
 <20230726090409.16606-3-tychang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726090409.16606-3-tychang@realtek.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Jul 26, 2023 at 05:04:04PM +0800, TY Chang kirjoitti:
> Add RTD1315E support using realtek common pinctrl driver.

...

> +config PINCTRL_RTD1315E
> +	tristate "Realtek DHC 1315E pin controller driver"

> +	depends on PINCTRL_RTD

Why not select and the above be hidden symbol?

...

> +#include <linux/module.h>

> +#include <linux/of.h>

Not used. Use correct headers

> +#include <linux/platform_device.h>

+ Blank line

> +#include <linux/pinctrl/pinctrl.h>

Make use of struct pinconfig, struct pinfunction and respective PINCTRL_PIN*()
macros.

...

> +#define RTD1315E_GROUP(_name) \
> +	{ \
> +		.name = # _name, \
> +		.pins = rtd1315e_ ## _name ## _pins, \
> +		.num_pins = ARRAY_SIZE(rtd1315e_ ## _name ## _pins), \
> +	}

NIH PINCTRL_PINGROUP().

...

> +#define RTD1315E_FUNC(_name) \
> +	{ \
> +		.name = # _name, \
> +		.groups = rtd1315e_ ## _name ## _groups, \
> +		.num_groups = ARRAY_SIZE(rtd1315e_ ## _name ## _groups), \
> +	}

NIH PINCTRL_PINFUNCTION().

...

> +static const struct of_device_id rtd1315e_pinctrl_of_match[] = {
> +	{ .compatible = "realtek,rtd13xxe-pinctrl", },

> +	{},

No comma for the terminator entry.

> +};

...

Same comments for all new drivers in the series.

-- 
With Best Regards,
Andy Shevchenko


