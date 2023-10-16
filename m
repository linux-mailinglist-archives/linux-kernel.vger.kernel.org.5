Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 452437CA1CA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 10:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjJPIiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 04:38:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229574AbjJPIiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 04:38:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE3BA2;
        Mon, 16 Oct 2023 01:38:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A680C433C7;
        Mon, 16 Oct 2023 08:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697445494;
        bh=xWFlrFC+q+shWO7c9H1cTlZ6rekm8Rnfw0lH32cS9Sg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HARMr1biKEYJ6ejhBeFX4sLflXL9DemKqJ8+w/EozScH617gIvBnndB4EVuKicVeg
         HYoXnfKstljE/fpAg1EFvV0F3QAJ8DusiFdQN8uCk4SleZLLnioPeAxBsgN+plAZGx
         M1vTb6BrsN+u2KwEH4EA+jpmHAVkKQMPQb6O7qEGi/MU0/xXLkxUYgzwzS1T5OHMwZ
         23R6hZ/Elbqh3Hz3SZofdHBbBnC2W7/JwDCZSZeMbMJE4hBBmfnkN5Ibp2xhi3gQd+
         rpEodLl8HJ3+j5uZNaesLS6/ewTZccb6XfjXg1gbPiyaFOhDdAVcEUwrVB/Y9r4RGR
         5V7t2EpK0ALvA==
Date:   Mon, 16 Oct 2023 09:38:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Uwe =?UTF-8?B?S2xlaW5l?= =?UTF-8?B?LUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 4/5] iio: pressure: bmp280: Allow multiple chips id per
 family of devices
Message-ID: <20231016093831.3696be3b@jic23-huawei>
In-Reply-To: <9f8489d82325b2dfb5c8c71c3d558d509b2b01bf.1697381932.git.ang.iglesiasg@gmail.com>
References: <cover.1697381932.git.ang.iglesiasg@gmail.com>
        <9f8489d82325b2dfb5c8c71c3d558d509b2b01bf.1697381932.git.ang.iglesiasg@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Oct 2023 17:16:26 +0200
Angel Iglesias <ang.iglesiasg@gmail.com> wrote:

> Improve device detection in certain chip families known to have various
> chip ids.
> 
> Signed-off-by: Angel Iglesias <ang.iglesiasg@gmail.com>

A few minor things inline.

J
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index ea02a623bb58..e3bb4d7906a9 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -38,6 +38,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/irq.h> /* For irq_get_irq_data() */
>  #include <linux/completion.h>
> +#include <linux/overflow.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/random.h>
>  
> @@ -794,10 +795,12 @@ static int bmp280_chip_config(struct bmp280_data *data)
>  }
>  
>  static const int bmp280_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +static const u8 bmp280_chip_ids[] = { BMP280_CHIP_ID };
>  
>  const struct bmp280_chip_info bmp280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> -	.chip_id = BMP280_CHIP_ID,
> +	.chip_id = bmp280_chip_ids,
> +	.num_chip_id = ARRAY_SIZE(bmp280_chip_ids),
>  	.regmap_config = &bmp280_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
> @@ -846,9 +849,12 @@ static int bme280_chip_config(struct bmp280_data *data)
>  	return bmp280_chip_config(data);
>  }
>  
> +static const u8 bme280_chip_ids[] = { BME280_CHIP_ID };
> +
>  const struct bmp280_chip_info bme280_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> -	.chip_id = BME280_CHIP_ID,
> +	.chip_id = bme280_chip_ids,
> +	.num_chip_id = ARRAY_SIZE(bme280_chip_ids),
>  	.regmap_config = &bmp280_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
> @@ -1220,10 +1226,12 @@ static int bmp380_chip_config(struct bmp280_data *data)
>  
>  static const int bmp380_oversampling_avail[] = { 1, 2, 4, 8, 16, 32 };
>  static const int bmp380_iir_filter_coeffs_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128};
> +static const u8 bmp380_chip_ids[] = { BMP380_CHIP_ID };
>  
>  const struct bmp280_chip_info bmp380_chip_info = {
>  	.id_reg = BMP380_REG_ID,
> -	.chip_id = BMP380_CHIP_ID,
> +	.chip_id = bmp380_chip_ids,
> +	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
>  	.regmap_config = &bmp380_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp380_channels,
> @@ -1720,10 +1728,12 @@ static int bmp580_chip_config(struct bmp280_data *data)
>  }
>  
>  static const int bmp580_oversampling_avail[] = { 1, 2, 4, 8, 16, 32, 64, 128 };
> +static const u8 bmp580_chip_ids[] = { BMP580_CHIP_ID, BMP580_CHIP_ID_ALT };
>  
>  const struct bmp280_chip_info bmp580_chip_info = {
>  	.id_reg = BMP580_REG_CHIP_ID,
> -	.chip_id = BMP580_CHIP_ID,
> +	.chip_id = bmp580_chip_ids,
> +	.num_chip_id = ARRAY_SIZE(bmp580_chip_ids),
>  	.regmap_config = &bmp580_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp380_channels,
> @@ -1983,10 +1993,12 @@ static int bmp180_chip_config(struct bmp280_data *data)
>  
>  static const int bmp180_oversampling_temp_avail[] = { 1 };
>  static const int bmp180_oversampling_press_avail[] = { 1, 2, 4, 8 };
> +static const u8 bmp180_chip_ids[] = { BMP180_CHIP_ID };
>  
>  const struct bmp280_chip_info bmp180_chip_info = {
>  	.id_reg = BMP280_REG_ID,
> -	.chip_id = BMP180_CHIP_ID,
> +	.chip_id = bmp180_chip_ids,
> +	.num_chip_id = ARRAY_SIZE(bmp180_chip_ids),
>  	.regmap_config = &bmp180_regmap_config,
>  	.start_up_time = 2000,
>  	.channels = bmp280_channels,
> @@ -2077,6 +2089,7 @@ int bmp280_common_probe(struct device *dev,
>  	struct bmp280_data *data;
>  	struct gpio_desc *gpiod;
>  	unsigned int chip_id;
> +	unsigned int i;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> @@ -2142,10 +2155,30 @@ int bmp280_common_probe(struct device *dev,
>  	ret = regmap_read(regmap, data->chip_info->id_reg, &chip_id);
>  	if (ret < 0)
>  		return ret;
> -	if (chip_id != data->chip_info->chip_id) {
> -		dev_err(dev, "bad chip id: expected %x got %x\n",
> -			data->chip_info->chip_id, chip_id);
> -		return -EINVAL;
> +
> +	for (i = 0; i < data->chip_info->num_chip_id; i++) {
> +		if (chip_id == data->chip_info->chip_id[i])
> +			break;
> +	}
> +
> +	if (i == data->chip_info->num_chip_id) {
> +		size_t nbuf;
> +		char *buf;
> +
> +		// 0x<id>, so four chars per number plus one space + ENDL

Trivial but /* */ comment syntax for IIO please.

> +		if (check_mul_overflow(data->chip_info->num_chip_id, 5, &nbuf))
> +			return ret;
> +
> +		buf = kmalloc_array(data->chip_info->num_chip_id, 5, GFP_KERNEL);
> +		if (!buf)
> +			return ret;
> +
> +		for (i = 0; i < data->chip_info->num_chip_id; i++)
> +			snprintf(&buf[i*5], nbuf - i*5, "0x%x ", data->chip_info->chip_id[i]);

I'd uses multiple dev_err() lines and skip this complexity. Doesn't need to be as pretty as this
given it's an error reprot :)  However, we should support fallback compatibles. So this should
be a dev_warn at most and we should go on with whatever firmware said.  Note the original code didn't
do this (I used to get this wrong in reviews) but it would be good to improve it whilst here.

> +
> +		dev_err(dev, "bad chip id: expected one of [ %s ] got 0x%x\n", buf, chip_id);
In probe so dev_err_probe() preferred and with the autocleanup this can be return dev_err_probe()

> +		kfree(buf);

The new autocleanup stuff is nice for this sort of case.

char *buf __free(kfree) = NULL;



> +		return ret;
>  	}
>  
>  	if (data->chip_info->preinit) {
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 5c0563ce7572..a230fcfc4a85 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -418,7 +418,8 @@ struct bmp280_data {
>  
>  struct bmp280_chip_info {
>  	unsigned int id_reg;
> -	const unsigned int chip_id;
> +	const u8 *chip_id;
> +	int num_chip_id;
>  
>  	const struct regmap_config *regmap_config;
>  

