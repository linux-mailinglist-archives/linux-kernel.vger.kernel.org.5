Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781D87AEBFC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 13:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbjIZL7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 07:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233884AbjIZL7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 07:59:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1C2DE;
        Tue, 26 Sep 2023 04:58:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="467831915"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="467831915"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:58:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="922395899"
X-IronPort-AV: E=Sophos;i="6.03,177,1694761200"; 
   d="scan'208";a="922395899"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 04:58:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andy@kernel.org>)
        id 1ql6iI-00000000aw9-1RsA;
        Tue, 26 Sep 2023 14:58:50 +0300
Date:   Tue, 26 Sep 2023 14:58:50 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Harvey Hunt <harveyhuntnexus@gmail.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-mips@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [RFT PATCH] mtd: rawnand: ingenic: move the GPIO quirk to
 gpiolib-of.c
Message-ID: <ZRLHeuohRgEtTLHz@smile.fi.intel.com>
References: <20230926090623.35595-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926090623.35595-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 11:06:23AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We have a special place for OF polarity quirks in gpiolib-of.c. Let's
> move this over there so that it doesn't pollute the driver.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
> This is an alternative to the previous patch that instead of replacing
> one active-low setter with another, just moves the quirk over to
> gpiolib-of.c

Much better than that in my opinion.
Reviewed-by: Andy Shevchenko <andy@kernel.org>

>  drivers/gpio/gpiolib-of.c                       |  9 +++++++++
>  drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c | 12 ------------
>  2 files changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-of.c b/drivers/gpio/gpiolib-of.c
> index 5515f32cf19b..58c0bbe9d569 100644
> --- a/drivers/gpio/gpiolib-of.c
> +++ b/drivers/gpio/gpiolib-of.c
> @@ -192,6 +192,15 @@ static void of_gpio_try_fixup_polarity(const struct device_node *np,
>  		 */
>  		{ "himax,hx8357",	"gpios-reset",	false },
>  		{ "himax,hx8369",	"gpios-reset",	false },
> +		/*
> +		 * The rb-gpios semantics was undocumented and qi,lb60 (along with
> +		 * the ingenic driver) got it wrong. The active state encodes the
> +		 * NAND ready state, which is high level. Since there's no signal
> +		 * inverter on this board, it should be active-high. Let's fix that
> +		 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
> +		 * helper, and be consistent with what other drivers do.
> +		 */
> +		{ "qi,lb60",		"rb-gpios",	true },
>  #endif
>  	};
>  	unsigned int i;
> diff --git a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> index 6748226b8bd1..c816dc137245 100644
> --- a/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> +++ b/drivers/mtd/nand/raw/ingenic/ingenic_nand_drv.c
> @@ -380,18 +380,6 @@ static int ingenic_nand_init_chip(struct platform_device *pdev,
>  		return ret;
>  	}
>  
> -	/*
> -	 * The rb-gpios semantics was undocumented and qi,lb60 (along with
> -	 * the ingenic driver) got it wrong. The active state encodes the
> -	 * NAND ready state, which is high level. Since there's no signal
> -	 * inverter on this board, it should be active-high. Let's fix that
> -	 * here for older DTs so we can re-use the generic nand_gpio_waitrdy()
> -	 * helper, and be consistent with what other drivers do.
> -	 */
> -	if (of_machine_is_compatible("qi,lb60") &&
> -	    gpiod_is_active_low(nand->busy_gpio))
> -		gpiod_toggle_active_low(nand->busy_gpio);
> -
>  	nand->wp_gpio = devm_gpiod_get_optional(dev, "wp", GPIOD_OUT_LOW);
>  
>  	if (IS_ERR(nand->wp_gpio)) {
> -- 
> 2.39.2
> 

-- 
With Best Regards,
Andy Shevchenko


