Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2E14793D55
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241002AbjIFNCE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240989AbjIFNCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4769510E2
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694005271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jq+8PcpSaMIH109h2ms6Ch2qLkD8AvXLZTAK4J2Qqds=;
        b=gpG3GYLKxZWy5y+MjNCsey6HvRT3Bmv/E6O9c6IIK3GixbWDSMVL8aGrMRoV3nU5Voqhgb
        Z6uH8/Z6bpwNHy/AP9Lp/BMWPhKFXUBpPI8etBBoQcwSQLPMTYXpIIjpnvU21Hm/2P8qfI
        euvOqf2a2jyemW/T/n3nTisQrdtJuwY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-c94FuLPiOuWQhAHQnIAIpA-1; Wed, 06 Sep 2023 09:01:06 -0400
X-MC-Unique: c94FuLPiOuWQhAHQnIAIpA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bd09fdec5cso41830981fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694005262; x=1694610062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jq+8PcpSaMIH109h2ms6Ch2qLkD8AvXLZTAK4J2Qqds=;
        b=UyHdSd/lOHPd9fK9wciXAjQwn7jJzd7/VLoQTxNsGgalcj3BW1HHfdDIMTRPbsIFF+
         MGPZhI9GbQCgoTB1OfanLtydXVTskuQUJAQCjHLG+yXOajxit3tr6nxjk9x+xuicY7YY
         uhbqIFqFKSaPGqThbvdV6VFWNlSgkZAEpcR3yLjM7wC6UtqpgxCV9QQkpO/NBUny8Mwc
         ebk5Peg2UyOaLv7qgJ4w3D1nYqLQCbiPZrHSWgoS7I0VkpaVGTK6YZeEXXl3xEFK6X4x
         bjsH0t7koEbaRIaQUMUoXj1fA7wtcGAtPqeQrT9QVcpmRc3eDIGtYs2/K1f9+xu3xUFi
         tvPw==
X-Gm-Message-State: AOJu0YxGx71FH8zmtEAMmNO6m4a9HZPCYzaZd7liuD43H1epathOKmOJ
        1GN9wAkittx4IKBYVdfrJWMEj0oRZE/L0OluYASu/ecPXpGmNWvZK7Fd/1MIV+Rbcguh+OQmjRd
        eA9gEZ+YT5uf8GpEpdwmoDD5L
X-Received: by 2002:a2e:a177:0:b0:2b9:f27f:e491 with SMTP id u23-20020a2ea177000000b002b9f27fe491mr2127407ljl.42.1694005262178;
        Wed, 06 Sep 2023 06:01:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoCrhgQkmlwcuKUAbvs9N0/AF1rSZUAm6EpcuVxlW1DjMIUJBTwNx+XHFiQUv6PYKtfefkVg==
X-Received: by 2002:a2e:a177:0:b0:2b9:f27f:e491 with SMTP id u23-20020a2ea177000000b002b9f27fe491mr2127375ljl.42.1694005261682;
        Wed, 06 Sep 2023 06:01:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id t1-20020a170906268100b00993150e5325sm9058355ejc.60.2023.09.06.06.01.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 06:01:01 -0700 (PDT)
Message-ID: <8f51b4a8-bb9c-4918-61a8-4ab402da1ed0@redhat.com>
Date:   Wed, 6 Sep 2023 15:01:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFT PATCH 11/21] platform: x86: android-tablets: don't access
 GPIOLIB private members
Content-Language: en-US, nl
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Dipen Patel <dipenp@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Gross <markgross@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-acpi@vger.kernel.org, timestamp@lists.linux.dev,
        linux-tegra@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20230905185309.131295-1-brgl@bgdev.pl>
 <20230905185309.131295-12-brgl@bgdev.pl>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230905185309.131295-12-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On 9/5/23 20:52, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> We're slowly removing cases of abuse of the GPIOLIB public API. One of
> the biggest issues is looking up and accessing struct gpio_chip whose
> life-time is tied to the provider and which can disappear from under any
> user at any given moment. We have provided new interfaces that use the
> opaque struct gpio_device which is reference counted and will soon be
> thorougly protected with appropriate locking.
> 
> Stop using old interfaces in this driver and switch to safer
> alternatives.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

First of all sorry for the issues this hack-ish kernel module
is causing for cleaning up gpiolib APIs.

I don't know how close a look you took at the code, so first of
all let me try to briefly explain what this hackish kernel module
is for:

There are some x86_64/ACPI tablets which shipped with Android as
factory OS. On these tablets the device-specific (BSP style)
kernel has things like the touchscreen driver simply having
a hardcoded I2C bus-number + I2C client address. Combined
with also hardcoded GPIO numbers (using the old number base APIs)
for any GPIOs it needs.

So the original Android kernels do not need the devices
to be properly described in ACPI and the ACPI tables are
just one big copy and paste job from some BSP which do
not accurately describe the hardware at all.

x86-android-tablets.ko identifies affected models by their
DMI strings and then manually instantiates things like
i2c-clients for the touchscreen, accelerometer and also
other stuff. Yes this is ugly but it allows mainline kernels
to run pretty well on these devices since other then
the messed up ACPI tables these are pretty standard x86/ACPI
tablets.

I hope this explains the hacks, now on to the problems
these are causing:

> ---
>  .../platform/x86/x86-android-tablets/core.c   | 38 ++++++++++---------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/platform/x86/x86-android-tablets/core.c b/drivers/platform/x86/x86-android-tablets/core.c
> index 2fd6060a31bb..687f84cd193c 100644
> --- a/drivers/platform/x86/x86-android-tablets/core.c
> +++ b/drivers/platform/x86/x86-android-tablets/core.c
> @@ -12,6 +12,7 @@
>  
>  #include <linux/acpi.h>
>  #include <linux/dmi.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/irq.h>
> @@ -21,27 +22,28 @@
>  #include <linux/string.h>
>  
>  #include "x86-android-tablets.h"
> -/* For gpiochip_get_desc() which is EXPORT_SYMBOL_GPL() */
> -#include "../../../gpio/gpiolib.h"
> -#include "../../../gpio/gpiolib-acpi.h"
> -
> -static int gpiochip_find_match_label(struct gpio_chip *gc, void *data)
> -{
> -	return gc->label && !strcmp(gc->label, data);
> -}
>  
>  int x86_android_tablet_get_gpiod(const char *label, int pin, struct gpio_desc **desc)
>  {
> +	struct gpio_device *gdev;
>  	struct gpio_desc *gpiod;
> -	struct gpio_chip *chip;
>  
> -	chip = gpiochip_find((void *)label, gpiochip_find_match_label);
> -	if (!chip) {
> -		pr_err("error cannot find GPIO chip %s\n", label);
> +	/*
> +	 * FIXME: handle GPIOs correctly! This driver should really use struct
> +	 * device and GPIO lookup tables.
> +	 *
> +	 * WONTDO: We do leak this reference, but the whole approach to getting
> +	 * GPIOs in this driver is such an abuse of the GPIOLIB API that it
> +	 * doesn't make it much worse and it's the only way to keep the
> +	 * interrupt requested later functional...
> +	 */
> +	gdev = gpio_device_find_by_label(label);
> +	if (!gdev) {
> +		pr_err("error cannot find GPIO device %s\n", label);
>  		return -ENODEV;
>  	}
>  
> -	gpiod = gpiochip_get_desc(chip, pin);
> +	gpiod = gpio_device_get_desc(gdev, pin);
>  	if (IS_ERR(gpiod)) {
>  		pr_err("error %ld getting GPIO %s %d\n", PTR_ERR(gpiod), label, pin);
>  		return PTR_ERR(gpiod);


So rather then the above I think what needs to happen here
(and I can hopefully make some time for that this weekend) is:

1. Have the x86-android-tablets code instantiate a
   "x86-android-tablets" platform-dev
2. Have the code generate a gpiod_lookup_table for all GPIOs
   for which it currently uses x86_android_tablet_get_gpiod()
   with the .dev_id set to "x86-android-tablets"
3. Use regular gpiod_get() on the "x86-android-tablets" pdev
   to get the desc.

I think this should solve all the issues with 
x86_android_tablet_get_gpiod() poking inside
gpiolib external since now it is only using
public gpiolib APIs, right ?

One question about 2. there are 2 ways to do this:

i. Have the module_init() function loop over all
x86_dev_info members which will result in calling
x86_android_tablet_get_gpiod() and have it generate
one big gpiod_lookup_table for all GPIOs needed
in one go. At which point x86_android_tablet_get_gpiod()
goes away and can be directly replaced with gpiod_get()
calls on the pdev.

ii. Keep x86_android_tablet_get_gpiod() and have it
generate a gpiod_lookup_table with just 1 entry for
the GPIO which its caller wants. Register the lookup
table, do the gpiod_get() and then immediately
unregister the lookup table again.

ii. Would be easier for me to implement, especially
since there is also some custom (board specific)
init code calling x86_android_tablet_get_gpiod()
which would require some special handling for i.

OTOH I guess some people will consider ii. somewhat
ugly, although AFAICT it is perfectly ok to use
the gpiolib lookup APIs this way.

Can you please let me known if you are ok with ii,
or if you would prefer me going with solution i. ?

That way when I can make some time to start working
on this I can pick the preferred solution right away.



> @@ -257,9 +259,9 @@ static void x86_android_tablet_cleanup(void)
>  
>  static __init int x86_android_tablet_init(void)
>  {
> +	struct gpio_device *gdev __free(gpio_device_put) = NULL;
>  	const struct x86_dev_info *dev_info;
>  	const struct dmi_system_id *id;
> -	struct gpio_chip *chip;
>  	int i, ret = 0;
>  
>  	id = dmi_first_match(x86_android_tablet_ids);
> @@ -273,13 +275,13 @@ static __init int x86_android_tablet_init(void)
>  	 * _AEI (ACPI Event Interrupt) handlers, disable these.
>  	 */
>  	if (dev_info->invalid_aei_gpiochip) {
> -		chip = gpiochip_find(dev_info->invalid_aei_gpiochip,
> -				     gpiochip_find_match_label);
> -		if (!chip) {
> +		gdev = gpio_device_find_by_label(
> +				dev_info->invalid_aei_gpiochip);
> +		if (!gdev) {
>  			pr_err("error cannot find GPIO chip %s\n", dev_info->invalid_aei_gpiochip);
>  			return -ENODEV;
>  		}
> -		acpi_gpiochip_free_interrupts(chip);
> +		acpi_gpio_device_free_interrupts(gdev);
>  	}
>  
>  	/*

After some recent improvements there is only 1 board left which sets
dev_info->invalid_aei_gpiochip and that can easily be replaced with
with adding 1 extra entry to gpiolib_acpi_quirks[] inside
drivers/gpio/gpiolib-acpi.c .

So I believe the right solution here is to just remove
dev_info->invalid_aei_gpiochip support for x86-android-tablets
all together and then at least x86-android-tablets will no
longer be making any hackish acpi_gpiochip_free_interrupts() calls.

I don't want to make any promises wrt the timing, but I should
be able to prepare a set of patches which simply removes all
the private gpiolib API use from x86-android-tablets, so that
you don't need to workaround that in this patch series.

With some luck I can have an immutable branch with 6.6-rc1 +
such a patch-series ready for you soon after 6.6-rc1 is
released.

Regards,

Hans



