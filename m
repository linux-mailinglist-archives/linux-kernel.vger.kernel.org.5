Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6CA76665A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjG1IG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232323AbjG1IGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:06:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C444B4C13;
        Fri, 28 Jul 2023 01:04:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E20362039;
        Fri, 28 Jul 2023 08:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9882CC433C7;
        Fri, 28 Jul 2023 08:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690531494;
        bh=CXiZVvcV+ojGPFpfahfdm7Wb/7/9cDkOtsKxITsqOuI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nZKRfEzkiQ0izUp+ZniaHaY0JZCD+8/fpghcj1S2SXdnjd7DAh6J1vbLALVa8vrhU
         07tumoA0fJcIhnNn+bTZhO7Qpej9Vy6cxSFJ/6uzE7AbOmQuG8pm6S/Kx1hYDLEasI
         PFz5kztpAu8ClAAPCZxmgWv+KkM2TqjD5iMewGivje0WIwwVp+0lm6J7PE5UHII49B
         /6/ldKZR/eCrofOaLKQZaRW0dX6pgZeYfGT8PVdiLa9Y4NNS8hA1M3klhjc2OON00V
         llFt7sz9aB7iy2qBYUWHafEnGNWGNS+jaYPsnZ5Xok5kq2SQtk+Y74pZIueXE/h4J8
         rHV0hQ2Z0lLDw==
Date:   Fri, 28 Jul 2023 09:04:49 +0100
From:   Lee Jones <lee@kernel.org>
To:     Joseph Strauss <jstrauss@mailbox.org>
Cc:     pavel@ucw.cz, jansimon.moeller@gmx.de, conor@kernel.org,
        christophe.jaillet@wanadoo.fr, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] Add multicolor support to BlinkM LED driver
Message-ID: <20230728080449.GD8175@google.com>
References: <20230713154425.13964-1-jstrauss@mailbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230713154425.13964-1-jstrauss@mailbox.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jul 2023, Joseph Strauss wrote:

> Add multicolor support to the BlinkM driver, making it easier to control
> from userspace. The BlinkM LED is a programmable RGB LED. The driver
> currently supports only the regular LED sysfs class, resulting in the
> creation of three distinct classes, one for red, green, and blue. The
> user then has to input three values into the three seperate brightness
> files within those classes. The multicolor LED framework makes the
> device easier to control with the multi_intensity file: the user can
> input three values at once to form a color, while still controlling the
> lightness with the brightness file.
> 
> The main struct blinkm_led has changed slightly. The struct led_classdev
> for the regular sysfs classes remain. The blinkm_probe function checks
> CONFIG_LEDS_BLINKM_MULTICOLOR to decide whether to load the seperate
> sysfs classes or the single multicolor one, but never both. The
> blinkm_set_mc_brightness() function had to be added to calculate the
> three color components and then set the fields of the blinkm_data
> structure accordingly.
> 
> Signed-off-by: Joseph Strauss <jstrauss@mailbox.org>
> ---
> Changes in v2:
> - Replaced instances of the constant 3 with NUM_LEDS, where applicable
> - Fixed formatting errors
> - Replaced loop inside of blinkm_set_mc_brightness() with equivalent
>   statements
> - Changed id of multicolor class from 4 to 3
> - Replaced call to devm_kmalloc_array() with devm_kcalloc()
> Changes in v3:
> - Add CONFIG_LEDS_BLINKM_MULTICOLOR to check whether to use multicolor
>   funcitonality
> - Extend well-known-leds.txt to include standard names for RGB and indicator
>   LEDS
> - Change name of Blinkm sysfs class according to well-known-leds.txt
> - Simplify struct blinkm_led and struct blinkm_data
> - Remove magic numbers
> - Fix formatting errors
> - Remove unrelated changes
> 
>  Documentation/leds/leds-blinkm.rst     |  27 +++-
>  Documentation/leds/well-known-leds.txt |   8 +
>  drivers/leds/Kconfig                   |   8 +
>  drivers/leds/leds-blinkm.c             | 203 +++++++++++++++++--------
>  4 files changed, 177 insertions(+), 69 deletions(-)

Getting there.  Couple of nits now.

> diff --git a/Documentation/leds/leds-blinkm.rst b/Documentation/leds/leds-blinkm.rst
> index c74b5bc877b1..a483f20aead1 100644
> --- a/Documentation/leds/leds-blinkm.rst
> +++ b/Documentation/leds/leds-blinkm.rst
> @@ -13,9 +13,27 @@ The device accepts RGB and HSB color values through separate commands.
>  Also you can store blinking sequences as "scripts" in
>  the controller and run them. Also fading is an option.
>  
> -The interface this driver provides is 2-fold:
> +The interface this driver provides is 3-fold:
>  
> -a) LED class interface for use with triggers
> +a) LED multicolor class interface for use with triggers
> +#######################################################
> +
> +The registration follows the scheme::
> +
> +  blinkm-<i2c-bus-nr>-<i2c-device-nr>:rgb:indicator
> +
> +  $ ls -h /sys/class/leds/blinkm-1-9:rgb:indicator
> +  brightness  device  max_brightness  multi_index  multi_intensity  power  subsystem  trigger  uevent
> +
> +The order in which to write the intensity values can be found in multi_index.
> +Exactly three values between 0 and 255 must be written to multi_intensity to change the color::
> +
> +  $ echo 255 100 50 > multi_intensity
> +
> +The overall brightness of the color that you choose can also be changed by
> +writing a value between 0 and 255 to the brightness file.
> +
> +b) LED class interface for use with triggers
>  ############################################
>  
>  The registration follows the scheme::
> @@ -50,7 +68,7 @@ E.g.::
>    $
>  
>  
> -b) Sysfs group to control rgb, fade, hsb, scripts ...
> +c) Sysfs group to control rgb, fade, hsb, scripts ...
>  #####################################################
>  
>  This extended interface is available as folder blinkm
> @@ -79,6 +97,7 @@ E.g.::
>  
>  
>  
> -as of 6/2012
> +as of 05/2023
>  
>  dl9pf <at> gmx <dot> de
> +jstrauss <at> mailbox <dot> org
> diff --git a/Documentation/leds/well-known-leds.txt b/Documentation/leds/well-known-leds.txt
> index 2160382c86be..2ac4eaed1454 100644
> --- a/Documentation/leds/well-known-leds.txt
> +++ b/Documentation/leds/well-known-leds.txt
> @@ -70,3 +70,11 @@ Good: "platform:*:charging" (allwinner sun50i)
>  * Screen
>  
>  Good: ":backlight" (Motorola Droid 4)
> +
> +* Indicators
> +
> +Good: ":indicator" (Blinkm)
> +
> +* RGB
> +
> +Good: ":rgb" (Blinkm)
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 499d0f215a8b..f38d786f9a89 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -736,6 +736,14 @@ config LEDS_BLINKM
>  	  This option enables support for the BlinkM RGB LED connected
>  	  through I2C. Say Y to enable support for the BlinkM LED.
>  
> +config LEDS_BLINKM_MULTICOLOR
> +	bool "Enable multicolor support for BlinkM I2C RGB LED"
> +	depends on LEDS_BLINKM
> +	depends on LEDS_CLASS_MULTICOLOR
> +	help
> +	  This option enables multicolor sysfs class support for BlinkM LED and
> +	  disables the older, separated sysfs interface
> +
>  config LEDS_POWERNV
>  	tristate "LED support for PowerNV Platform"
>  	depends on LEDS_CLASS
> diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
> index e19cc8a7b7ca..a2295d0d0a2b 100644
> --- a/drivers/leds/leds-blinkm.c
> +++ b/drivers/leds/leds-blinkm.c
> @@ -2,6 +2,7 @@
>  /*
>   *  leds-blinkm.c
>   *  (c) Jan-Simon Möller (dl9pf@gmx.de)
> + *  (c) Joseph Strauss (jstrauss@mailbox.org)
>   */
>  
>  #include <linux/module.h>
> @@ -15,6 +16,10 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/leds.h>
>  #include <linux/delay.h>
> +#include <linux/led-class-multicolor.h>
> +#include <linux/kconfig.h>
> +
> +#define NUM_LEDS 3
>  
>  /* Addresses to scan - BlinkM is on 0x09 by default*/
>  static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
> @@ -22,19 +27,24 @@ static const unsigned short normal_i2c[] = { 0x09, I2C_CLIENT_END };
>  static int blinkm_transfer_hw(struct i2c_client *client, int cmd);
>  static int blinkm_test_run(struct i2c_client *client);
>  
> +/* Contains data structures for both the color-seperated sysfs classes, and the new multicolor class */
>  struct blinkm_led {
>  	struct i2c_client *i2c_client;
> +	/* used when multicolor support is disabled */
>  	struct led_classdev led_cdev;
> +	struct led_classdev_mc mcled_cdev;
>  	int id;
>  };
>  
> -#define cdev_to_blmled(c)          container_of(c, struct blinkm_led, led_cdev)
> +#define led_cdev_to_blmled(c)				container_of(c, struct blinkm_led, led_cdev)
> +#define mcled_cdev_to_led(c)				container_of(c, struct blinkm_led, mcled_cdev)
>  
>  struct blinkm_data {
>  	struct i2c_client *i2c_client;
>  	struct mutex update_lock;
>  	/* used for led class interface */
> -	struct blinkm_led blinkm_leds[3];
> +	struct blinkm_led blinkm_leds[NUM_LEDS];
> +
>  	/* used for "blinkm" sysfs interface */
>  	u8 red;			/* color red */
>  	u8 green;		/* color green */
> @@ -419,11 +429,29 @@ static int blinkm_transfer_hw(struct i2c_client *client, int cmd)
>  	return 0;
>  }
>  
> +static int blinkm_set_mc_brightness(struct led_classdev *led_cdev,
> +				 enum led_brightness value)
> +{
> +	struct led_classdev_mc *mcled_cdev = lcdev_to_mccdev(led_cdev);
> +	struct blinkm_led *led = mcled_cdev_to_led(mcled_cdev);
> +	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
> +
> +	led_mc_calc_color_components(mcled_cdev, value);
> +
> +	data->next_red = (u8) mcled_cdev->subled_info[RED].brightness;
> +	data->next_green = (u8) mcled_cdev->subled_info[GREEN].brightness;
> +	data->next_blue = (u8) mcled_cdev->subled_info[BLUE].brightness;
> +
> +	blinkm_transfer_hw(led->i2c_client, BLM_GO_RGB);
> +
> +	return 0;
> +}
> +
>  static int blinkm_led_common_set(struct led_classdev *led_cdev,
>  				 enum led_brightness value, int color)
>  {
>  	/* led_brightness is 0, 127 or 255 - we just use it here as-is */
> -	struct blinkm_led *led = cdev_to_blmled(led_cdev);
> +	struct blinkm_led *led = led_cdev_to_blmled(led_cdev);
>  	struct blinkm_data *data = i2c_get_clientdata(led->i2c_client);
>  
>  	switch (color) {
> @@ -569,7 +597,11 @@ static int blinkm_probe(struct i2c_client *client,
>  			const struct i2c_device_id *id)
>  {
>  	struct blinkm_data *data;
> -	struct blinkm_led *led[3];
> +	/* For multicolor support */
> +	struct blinkm_led *mc_led;
> +	struct mc_subled *mc_led_info;
> +	/* 3 seperate classes for red, green, and blue respectively */
> +	struct blinkm_led *leds[NUM_LEDS];
>  	int err, i;
>  	char blinkm_led_name[28];
>  
> @@ -580,6 +612,12 @@ static int blinkm_probe(struct i2c_client *client,
>  		goto exit;
>  	}
>  
> +	mc_led_info = devm_kcalloc(&client->dev, NUM_LEDS, sizeof(*mc_led_info),
> +					GFP_KERNEL);
> +	if (!mc_led_info) {
> +		err = -ENOMEM;
> +		goto exit;
> +	}
>  	data->i2c_addr = 0x08;
>  	/* i2c addr  - use fake addr of 0x08 initially (real is 0x09) */
>  	data->fw_ver = 0xfe;
> @@ -598,81 +636,116 @@ static int blinkm_probe(struct i2c_client *client,
>  		goto exit;
>  	}
>  
> -	for (i = 0; i < 3; i++) {
> -		/* RED = 0, GREEN = 1, BLUE = 2 */
> -		led[i] = &data->blinkm_leds[i];
> -		led[i]->i2c_client = client;
> -		led[i]->id = i;
> -		led[i]->led_cdev.max_brightness = 255;
> -		led[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> -		switch (i) {
> -		case RED:
> -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> -					 "blinkm-%d-%d-red",
> -					 client->adapter->nr,
> -					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> -							blinkm_led_red_set;
> -			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> +	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
> +		/* Register red, green, and blue sysfs classes */
> +		for (i = 0; i < NUM_LEDS; i++) {
> +			/* RED = 0, GREEN = 1, BLUE = 2 */
> +			leds[i] = &data->blinkm_leds[i];
> +			leds[i]->i2c_client = client;
> +			leds[i]->id = i;
> +			leds[i]->led_cdev.max_brightness = 255;
> +			leds[i]->led_cdev.flags = LED_CORE_SUSPENDRESUME;
> +			switch (i) {
> +			case RED:
> +				snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> +						 "blinkm-%d-%d-red",
> +						 client->adapter->nr,
> +						 client->addr);
> +				leds[i]->led_cdev.name = blinkm_led_name;
> +				leds[i]->led_cdev.brightness_set_blocking =
> +								blinkm_led_red_set;
> +				err = led_classdev_register(&client->dev,
> +								&leds[i]->led_cdev);
> +				if (err < 0) {
> +					dev_err(&client->dev,
> +						"couldn't register LED %s\n",
> +						leds[i]->led_cdev.name);
> +					goto failred;
> +				}
> +				break;
> +			case GREEN:
> +				snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> +						 "blinkm-%d-%d-green",
> +						 client->adapter->nr,
> +						 client->addr);
> +				leds[i]->led_cdev.name = blinkm_led_name;
> +				leds[i]->led_cdev.brightness_set_blocking =
> +								blinkm_led_green_set;
> +				err = led_classdev_register(&client->dev,
> +							&leds[i]->led_cdev);
>  			if (err < 0) {
>  				dev_err(&client->dev,
>  					"couldn't register LED %s\n",

This tabbing needs adjusting too.

> -					led[i]->led_cdev.name);
> -				goto failred;
> -			}
> -			break;
> -		case GREEN:
> -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> -					 "blinkm-%d-%d-green",
> -					 client->adapter->nr,
> -					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> -							blinkm_led_green_set;
> -			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> -			if (err < 0) {
> -				dev_err(&client->dev,
> -					"couldn't register LED %s\n",
> -					led[i]->led_cdev.name);
> +					leds[i]->led_cdev.name);
>  				goto failgreen;
>  			}
> -			break;
> -		case BLUE:
> -			snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> -					 "blinkm-%d-%d-blue",
> -					 client->adapter->nr,
> -					 client->addr);
> -			led[i]->led_cdev.name = blinkm_led_name;
> -			led[i]->led_cdev.brightness_set_blocking =
> -							blinkm_led_blue_set;
> -			err = led_classdev_register(&client->dev,
> -						    &led[i]->led_cdev);
> -			if (err < 0) {
> -				dev_err(&client->dev,
> -					"couldn't register LED %s\n",
> -					led[i]->led_cdev.name);
> -				goto failblue;
> -			}
> -			break;
> -		}		/* end switch */
> -	}			/* end for */
> +				break;
> +			case BLUE:
> +				snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> +						 "blinkm-%d-%d-blue",
> +						 client->adapter->nr,
> +						 client->addr);
> +				leds[i]->led_cdev.name = blinkm_led_name;
> +				leds[i]->led_cdev.brightness_set_blocking =
> +								blinkm_led_blue_set;
> +				err = led_classdev_register(&client->dev,
> +								&leds[i]->led_cdev);
> +				if (err < 0) {
> +					dev_err(&client->dev,
> +						"couldn't register LED %s\n",
> +						leds[i]->led_cdev.name);
> +					goto failblue;
> +				}
> +				break;
> +			}		/* end switch */

No default?

> +		}			/* end for */
> +	} else {
> +		/* Register multicolor sysfs class */
> +		/* The first element of leds is used for multicolor facilities */
> +		mc_led = &data->blinkm_leds[RED];
> +		mc_led->i2c_client = client;
> +
> +		mc_led_info[RED].color_index = LED_COLOR_ID_RED;
> +		mc_led_info[GREEN].color_index = LED_COLOR_ID_GREEN;
> +		mc_led_info[BLUE].color_index = LED_COLOR_ID_BLUE;
> +
> +		mc_led->mcled_cdev.subled_info = mc_led_info;
> +		mc_led->mcled_cdev.num_colors = NUM_LEDS;
> +		mc_led->mcled_cdev.led_cdev.brightness = 255;
> +		mc_led->mcled_cdev.led_cdev.max_brightness = 255;
> +		mc_led->mcled_cdev.led_cdev.flags = LED_CORE_SUSPENDRESUME;
> +
> +		snprintf(blinkm_led_name, sizeof(blinkm_led_name),
> +			 "blinkm-%d-%d:rgb:indicator",
> +			 client->adapter->nr,
> +			 client->addr);
> +		mc_led->mcled_cdev.led_cdev.name = blinkm_led_name;
> +		mc_led->mcled_cdev.led_cdev.brightness_set_blocking = blinkm_set_mc_brightness;
> +
> +		err = led_classdev_multicolor_register(&client->dev, &mc_led->mcled_cdev);
> +		if (err < 0) {
> +			dev_err(&client->dev, "couldn't register LED %s\n",
> +					mc_led->led_cdev.name);
> +			goto failmulti;
> +		}
> +	}
>  
> -	/* Initialize the blinkm */
>  	blinkm_init_hw(client);
>  
>  	return 0;
>  
> +failmulti:
> +	led_classdev_unregister(&leds[BLUE]->led_cdev);
> +
>  failblue:
> -	led_classdev_unregister(&led[GREEN]->led_cdev);
> +	led_classdev_unregister(&leds[GREEN]->led_cdev);
>  
>  failgreen:
> -	led_classdev_unregister(&led[RED]->led_cdev);
> +	led_classdev_unregister(&leds[RED]->led_cdev);
>  
>  failred:
>  	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
> +
>  exit:
>  	return err;
>  }
> @@ -684,7 +757,7 @@ static void blinkm_remove(struct i2c_client *client)
>  	int i;
>  
>  	/* make sure no workqueue entries are pending */
> -	for (i = 0; i < 3; i++)
> +	for (i = 0; i < NUM_LEDS; i++)
>  		led_classdev_unregister(&data->blinkm_leds[i].led_cdev);
>  
>  	/* reset rgb */
> @@ -741,6 +814,6 @@ static struct i2c_driver blinkm_driver = {
>  module_i2c_driver(blinkm_driver);
>  
>  MODULE_AUTHOR("Jan-Simon Moeller <dl9pf@gmx.de>");
> +MODULE_AUTHOR("Joseph Strauss <jstrauss@mailbox.org>");
>  MODULE_DESCRIPTION("BlinkM RGB LED driver");
>  MODULE_LICENSE("GPL");
> -
> -- 
> 2.40.1
> 

-- 
Lee Jones [李琼斯]
