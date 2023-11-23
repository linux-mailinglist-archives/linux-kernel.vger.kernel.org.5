Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DC87F636F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjKWP5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:57:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbjKWP5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:57:43 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C9D1D4E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 07:57:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4EFC433C8;
        Thu, 23 Nov 2023 15:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700755070;
        bh=eG+RrbQFNYApofZ3Dfp5pt4gOAt+nrl6EHgb2YJxdrU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OBqS0UYjbrW4w7H2l0g2mkGHCx71WwN2p9tQjbNCQKf9eTnyrj/d12RzblQGjOWz0
         /VKtkI7XjGkI+LEkBvkXOjh7muXuQxtbqdPAYgG/bLn1D+OgXIptn89LIfxG3RRxTX
         YB3llOi0/VvVkXR9AVRbyTko4j75/5hrnS9K2Z9YZC0NEIp/YgljH4gLYT+i0AFcKX
         cEV+Na7fe82TeUhX5E2FVTNs5wGPbTmr7UwfmZC6zIbluVTx2BsGeABGym7gM1v5Nw
         mXHTwvqBbgitR7ISk31u3GxZvy7r4i0Mp/UiIkxZPDf5LwAjCzYCMlZgj6pKSdEa7i
         WLXxIV8R/MWGg==
Date:   Thu, 23 Nov 2023 15:57:44 +0000
From:   Lee Jones <lee@kernel.org>
To:     Dmitry Rokosov <ddrokosov@salutedevices.com>
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andy.shevchenko@gmail.com, kernel@sberdevices.ru,
        rockosov@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH v4 02/11] leds: aw200xx: support HWEN hardware control
Message-ID: <20231123155744.GE1354538@google.com>
References: <20231121202835.28152-1-ddrokosov@salutedevices.com>
 <20231121202835.28152-3-ddrokosov@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231121202835.28152-3-ddrokosov@salutedevices.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2023, Dmitry Rokosov wrote:

> HWEN is hardware control, which is used for enable/disable aw200xx chip.
> It's high active, internally pulled down to GND.
> 
> After HWEN pin set high the chip begins to load the OTP information,
> which takes 200us to complete. About 200us wait time is needed for
> internal oscillator startup and display SRAM initialization. After
> display SRAM initialization, the registers in page 1 to page 5 can be
> configured via i2c interface.
> 
> Signed-off-by: Dmitry Rokosov <ddrokosov@salutedevices.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/leds/leds-aw200xx.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/drivers/leds/leds-aw200xx.c b/drivers/leds/leds-aw200xx.c
> index 842a22087b16..7762b3a132ac 100644
> --- a/drivers/leds/leds-aw200xx.c
> +++ b/drivers/leds/leds-aw200xx.c
> @@ -10,6 +10,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/container_of.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/leds.h>
>  #include <linux/mod_devicetable.h>
> @@ -116,6 +117,7 @@ struct aw200xx {
>  	struct mutex mutex;
>  	u32 num_leds;
>  	u32 display_rows;
> +	struct gpio_desc *hwen;
>  	struct aw200xx_led leds[] __counted_by(num_leds);
>  };
>  
> @@ -358,6 +360,25 @@ static int aw200xx_chip_check(const struct aw200xx *const chip)
>  	return 0;
>  }
>  
> +static void aw200xx_enable(const struct aw200xx *const chip)
> +{
> +	gpiod_set_value_cansleep(chip->hwen, 1);
> +
> +	/*
> +	 * After HWEN pin set high the chip begins to load the OTP information,
> +	 * which takes 200us to complete. About 200us wait time is needed for
> +	 * internal oscillator startup and display SRAM initialization. After
> +	 * display SRAM initialization, the registers in page1 to page5 can be
> +	 * configured via i2c interface.
> +	 */
> +	fsleep(400);
> +}
> +
> +static void aw200xx_disable(const struct aw200xx *const chip)
> +{
> +	return gpiod_set_value_cansleep(chip->hwen, 0);
> +}
> +
>  static int aw200xx_probe_fw(struct device *dev, struct aw200xx *chip)
>  {
>  	struct fwnode_handle *child;
> @@ -517,6 +538,14 @@ static int aw200xx_probe(struct i2c_client *client)
>  	if (IS_ERR(chip->regmap))
>  		return PTR_ERR(chip->regmap);
>  
> +	chip->hwen = devm_gpiod_get_optional(&client->dev, "enable",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(chip->hwen))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->hwen),
> +				     "Cannot get enable gpio");

Nit: "GPIO"

> +
> +	aw200xx_enable(chip);
> +
>  	ret = aw200xx_chip_check(chip);
>  	if (ret)
>  		return ret;
> @@ -537,6 +566,9 @@ static int aw200xx_probe(struct i2c_client *client)
>  	ret = aw200xx_chip_init(chip);
>  
>  out_unlock:
> +	if (ret)
> +		aw200xx_disable(chip);
> +
>  	mutex_unlock(&chip->mutex);
>  	return ret;
>  }
> @@ -546,6 +578,7 @@ static void aw200xx_remove(struct i2c_client *client)
>  	struct aw200xx *chip = i2c_get_clientdata(client);
>  
>  	aw200xx_chip_reset(chip);
> +	aw200xx_disable(chip);
>  	mutex_destroy(&chip->mutex);
>  }
>  
> -- 
> 2.36.0
> 

-- 
Lee Jones [李琼斯]
