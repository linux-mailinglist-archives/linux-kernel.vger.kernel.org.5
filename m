Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8E575B88D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 22:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbjGTUKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 16:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjGTUKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 16:10:33 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2901526AC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 13:10:29 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 73e5902b-2739-11ee-b972-005056bdfda7;
        Thu, 20 Jul 2023 23:10:20 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Thu, 20 Jul 2023 23:10:20 +0300
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] pinctrl: cy8c95x0: Add reset support
Message-ID: <ZLmUrA1ANfAVJYHi@surfacebook>
References: <20230714081902.2621771-1-Naresh.Solanki@9elements.com>
 <20230714081902.2621771-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714081902.2621771-2-Naresh.Solanki@9elements.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jul 14, 2023 at 10:19:01AM +0200, Naresh Solanki kirjoitti:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> This patch adds support for an optional "reset" GPIO pin in the cy8c95x0

Find "This patch" in the Submitting Patches documentation and modify this
accordingly.

> pinctrl driver. On probe, the reset pin is pulled low to bring chip out
> of reset. The reset pin has an internal pull-down and can be left
> floating if not required.
> 
> The datasheet doesn't mention any timing related to the reset pin.
> 
> Based on empirical tests, it was found that the chip requires a
> delay of 250 milliseconds before accepting I2C transfers after driving
> the reset pin low. Therefore, a delay of 250ms is added before
> proceeding with I2C transfers.

...

> +	/* bring the chip out of reset if reset pin is provided */
> +	chip->gpio_reset = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);

&client->dev

> +	if (IS_ERR(chip->gpio_reset)) {
> +		ret = dev_err_probe(chip->dev, PTR_ERR(chip->gpio_reset),

chip->dev

Why inconsistent?

> +				    "Failed to get GPIO 'reset'\n");
> +		goto err_exit;

I haven't looked at the context, but this seems like a smoke, we usually don't
have such in devm-enabled drivers.

> +	} else if (chip->gpio_reset) {
> +		usleep_range(1000, 2000);
> +		gpiod_set_value_cansleep(chip->gpio_reset, 0);

> +		usleep_range(250000, 300000);

This is incorrect use of usleep_range(). Please, read documentation
Documentation/timers/timers-howto.rst on the topic. The fix can be switching to
fsleep() in both branches.


> +		gpiod_set_consumer_name(chip->gpio_reset, "CY8C95X0 RESET");

This can be done uncoditionally before toggling the reset.

> +	}

...

This change wasn't Cc'ed to me, however I was contributing a lot into this driver.
I would recommend to use my "smart" script [1] to send patches. It has some
heuristics which works well in 98% of the cases for me.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh


-- 
With Best Regards,
Andy Shevchenko


