Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBDA379EB31
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjIMOfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235721AbjIMOfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:35:44 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE78690
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 07:35:39 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:f674:9611:cd05:f25a])
        by baptiste.telenet-ops.be with bizsmtp
        id lSbe2A0063fvA4V01Sberm; Wed, 13 Sep 2023 16:35:38 +0200
Received: from geert (helo=localhost)
        by ramsan.of.borg with local-esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qgQxu-003cyS-25;
        Wed, 13 Sep 2023 16:35:38 +0200
Date:   Wed, 13 Sep 2023 16:35:38 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH v1 05/10] gpio: pca953x: Simplify code with cleanup
 helpers
In-Reply-To: <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
Message-ID: <71232fcf-98c4-373a-805-141a349fd25@linux-m68k.org>
References: <20230901134041.1165562-1-andriy.shevchenko@linux.intel.com> <20230901134041.1165562-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 	Hi Andy,

On Fri, 1 Sep 2023, Andy Shevchenko wrote:
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in gpio-pca953x.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch, which is now commit 8e471b784a720f6f
("gpio: pca953x: Simplify code with cleanup helpers") in
gpio/gpio/for-next.

> --- a/drivers/gpio/gpio-pca953x.c
> +++ b/drivers/gpio/gpio-pca953x.c
> @@ -557,9 +554,8 @@ static int pca953x_gpio_get_value(struct gpio_chip *gc, unsigned off)
> 	u32 reg_val;
> 	int ret;
>
> -	mutex_lock(&chip->i2c_lock);
> -	ret = regmap_read(chip->regmap, inreg, &reg_val);
> -	mutex_unlock(&chip->i2c_lock);
> +	scoped_guard(mutex, &chip->i2c_lock)
> +		ret = regmap_read(chip->regmap, inreg, &reg_val);

I can't say I'm thrilled about the lack of curly braces.  I was also
surprised to discover that checkpatch nor gcc W=1 complain about the
indentation change.
I know we don't use curly braces in single-statement for_each_*() loops,
but at least these have the familiar "for"-prefix.  And having the scope
is very important here, so using braces, this would stand out more.

Hence can we please get curly braces, like

     scoped_guard(mutex, &chip->i2c_lock) {
 	    ret = regmap_read(chip->regmap, inreg, &reg_val);
     }

?

Thanks! ;-)

Gr{oetje,eeting}s,

 						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
 							    -- Linus Torvalds
