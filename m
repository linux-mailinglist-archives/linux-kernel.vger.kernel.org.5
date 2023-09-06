Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC747935F5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjIFHKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjIFHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:10:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63CDDE4F;
        Wed,  6 Sep 2023 00:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693984240; x=1725520240;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CzVsvBBCQyE6nmVgfBDTPc4IJEBFPNuhlR6CIA56RSY=;
  b=jh/OGLjnnh+SnvwGZL7DuwN60omR4cuAf2PX0vJQ7p/CET3lBGgpZJR5
   7rjsb1HNryP1TBaRL/jk98Y422kNMsKrOVWp7KOOZosizmmytsIDyYmxf
   UQqbe0mltBJ4CM564EqEsMh/4fubF0TZ//RsrvAFbfgjKcdz6h9N0R/an
   F+lCVtfGBuzhnmh6DLJ/3+26qxG9Jx7cjiK4hSrVR9l2C+C3lY/wmowZb
   HuzC2ExpL/6BzIntGnhIca6vkn6qCvVoaU9XJTDTIrgVzcYKik44HxU+B
   vA0UOJgeBpPVy7bFaVQmyIT9RYibrXr1qW++ahSFmQ5ksD3eYTVpfLkRC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="407993429"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="407993429"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 00:10:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10824"; a="734933655"
X-IronPort-AV: E=Sophos;i="6.02,231,1688454000"; 
   d="scan'208";a="734933655"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 06 Sep 2023 00:10:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 1DF7F30D; Wed,  6 Sep 2023 10:10:32 +0300 (EEST)
Date:   Wed, 6 Sep 2023 10:10:32 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 08/21] gpio: acpi: provide
 acpi_gpio_device_free_interrupts()
Message-ID: <20230906071032.GA1599918@black.fi.intel.com>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-9-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230905185309.131295-9-brgl@bgdev.pl>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 05, 2023 at 08:52:56PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're moving away from public functions that take struct gpio_chip as
> argument as the chip - unlike struct gpio_device - is owned by its
> provider and tied to its lifetime.
> 
> Provide an alternative to acpi_gpiochip_free_interrupts().

Looks good to me, few minor comments below.

> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
>  drivers/gpio/gpiolib-acpi.c | 29 +++++++++++++++++++++++------
>  include/linux/gpio/driver.h | 12 ++++++++++++
>  2 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpiolib-acpi.c b/drivers/gpio/gpiolib-acpi.c
> index fbda452fb4d6..5633e39396bc 100644
> --- a/drivers/gpio/gpiolib-acpi.c
> +++ b/drivers/gpio/gpiolib-acpi.c
> @@ -558,12 +558,9 @@ void acpi_gpiochip_request_interrupts(struct gpio_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(acpi_gpiochip_request_interrupts);
>  
> -/**
> - * acpi_gpiochip_free_interrupts() - Free GPIO ACPI event interrupts.
> - * @chip:      GPIO chip
> - *
> - * Free interrupts associated with GPIO ACPI event method for the given
> - * GPIO chip.
> +/*
> + * This function is deprecated, use acpi_gpio_device_free_interrupts()
> + * instead.
>   */
>  void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
>  {
> @@ -604,6 +601,26 @@ void acpi_gpiochip_free_interrupts(struct gpio_chip *chip)
>  }
>  EXPORT_SYMBOL_GPL(acpi_gpiochip_free_interrupts);
>  
> +/**
> + * acpi_gpio_device_free_interrupts() - Free GPIO ACPI event interrupts.
> + * @chip	GPIO device

Should be:

@chip: GPIO device

> + *
> + * Free interrupts associated with GPIO ACPI event method for the given
> + * GPIO device.
> + */
> +void acpi_gpio_device_free_interrupts(struct gpio_device *gdev)
> +{
> +	struct gpio_chip *gc;
> +
> +	/* TODO: protect gdev->chip once SRCU is in place in GPIOLIB. */
> +	gc = gdev->chip;
> +	if (!gc)
> +		return;
> +
> +	acpi_gpiochip_free_interrupts(gc);
> +}
> +EXPORT_SYMBOL_GPL(acpi_gpio_device_free_interrupts);
> +
>  int acpi_dev_add_driver_gpios(struct acpi_device *adev,
>  			      const struct acpi_gpio_mapping *gpios)
>  {
> diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
> index b68b3493b29d..47906bc56b3d 100644
> --- a/include/linux/gpio/driver.h
> +++ b/include/linux/gpio/driver.h
> @@ -835,4 +835,16 @@ static inline struct fwnode_handle *gpiochip_node_get_first(struct device *dev)
>  	return NULL;
>  }
>  
> +/*
> + * FIXME: Remove this once the only driver that uses it - android tablets -
> + * becomes a good citizen and stops abusing GPIOLIB.

There are a acouple of more when grepping for acpi_gpiochip_free_interrupts().

I'm not entirely sure why these functions are exposed to the drivers in
the first place. IMHO GPIOLIB should deal with these but perhaps there
is some good reason these drivers do it...

> + */
> +#ifdef CONFIG_ACPI
> +void acpi_gpio_device_free_interrupts(struct gpio_device *gdev);
> +#else
> +static inline void acpi_gpio_device_free_interrupts(struct gpio_device *gdev)
> +{
> +}

I would put these {} to the same line:

static inline void acpi_gpio_device_free_interrupts(struct gpio_device *gdev) { }

> +#endif
> +
>  #endif /* __LINUX_GPIO_DRIVER_H */
> -- 
> 2.39.2
