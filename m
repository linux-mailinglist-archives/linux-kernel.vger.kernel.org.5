Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E861C7ACB32
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjIXR7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXR7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:59:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36282FA;
        Sun, 24 Sep 2023 10:59:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0911C433C8;
        Sun, 24 Sep 2023 17:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695578350;
        bh=DtuGFc95uNt0rfMj/FIhrVYgTxyWUnjNj+n/XRqLJ5s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=G5ynYbOQOjE70ewF8Lxs2qiF9BAA+U2/qi3qVpFwQeB1xU7a/hKG4xT3n+ZlVkskB
         UegYD2rXproSgfPeUmk0VYcHsFU946/eSC2nDK/H01f+KHktMzGdjSfZtApi5DZe3C
         gXBkz+gvtC9bEBt947z3xlug/IDcqkffT6C2OXsm9zUmnW+luaO+CaZr65rveil5pp
         z3UUeL7kZDEfdZ+DFOX7pFR+nNol/XJaNAC2+RRv55ywkyntt+UwkXheHrlga1QIur
         0g1kfZndfx16DViRFBYdC2BL9OzTl/QfwTRv9ANX4D7UPp4MNRnmRJyZSJXo1Jj1bm
         3+HTcfp9AV/aw==
Date:   Sun, 24 Sep 2023 18:59:02 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 09/19] staging: iio: resolver: ad2s1210: use regmap
 for config registers
Message-ID: <20230924185902.579a444b@jic23-huawei>
In-Reply-To: <20230921144400.62380-10-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-10-dlechner@baylibre.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 09:43:50 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This makes use of the regmap API to read and write the configuration
> registers. This simplifies code quite a bit and makes it safer
> (previously, it was easy to write a bad value to the config registers
> which causes the chip to lock up and need to be reset).
> 
I'd like a bit more description in here -mostly because I have no idea
what the original code was doing.
What were the MSB writes that followed main config writes for and why
can we get rid of them>

Also, using regmap for only some accesses is a bit unusual. Add some
text here to justify that decision.

Jonathan

> Signed-off-by: David Lechner <dlechner@baylibre.com>


> -/* write 1 bytes (address or data) to the chip */
> -static int ad2s1210_config_write(struct ad2s1210_state *st, u8 data)
> +/*
> + * Writes the given data to the given register address.
> + *
> + * If the mode is configurable, the device will first be placed in
> + * configuration mode.
> + */
> +static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
> +				     unsigned int val)
>  {
> -	int ret;
> +	struct ad2s1210_state *st = context;
> +	struct spi_transfer xfers[] = {
> +		{
> +			.len = 1,
> +			.rx_buf = &st->rx[0],
> +			.tx_buf = &st->tx[0],
> +			.cs_change = 1,
> +		}, {
> +			.len = 1,
> +			.rx_buf = &st->rx[1],
> +			.tx_buf = &st->tx[1],
> +		},
> +	};
> +
> +	/* values can only be 7 bits, the MSB indicates an address */
> +	if (val & ~0x7F)
> +		return -EINVAL;
> +
> +	st->tx[0] = reg;
> +	st->tx[1] = val;
>  
>  	ad2s1210_set_mode(MOD_CONFIG, st);
> -	st->tx[0] = data;
> -	ret = spi_write(st->sdev, st->tx, 1);
> -	if (ret < 0)
> -		return ret;
>  
> -	return 0;
> +	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
>  }
>  
> -/* read value from one of the registers */
> -static int ad2s1210_config_read(struct ad2s1210_state *st,
> -				unsigned char address)
> +/*
> + * Reads value from one of the registers.
> + *
> + * If the mode is configurable, the device will first be placed in
> + * configuration mode.
> + */
> +static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
> +				    unsigned int *val)
>  {
> +	struct ad2s1210_state *st = context;
>  	struct spi_transfer xfers[] = {
>  		{
>  			.len = 1,
> @@ -146,22 +176,34 @@ static int ad2s1210_config_read(struct ad2s1210_state *st,
>  			.tx_buf = &st->tx[1],
>  		},
>  	};
> -	int ret = 0;
> +	int ret;
>  
>  	ad2s1210_set_mode(MOD_CONFIG, st);
> -	st->tx[0] = address | AD2S1210_MSB_IS_HIGH;
> +	st->tx[0] = reg;
> +	/* Must be valid register address here otherwise this could write data.
> +	 * It doesn't matter which one.
> +	 */
>  	st->tx[1] = AD2S1210_REG_FAULT;
> -	ret = spi_sync_transfer(st->sdev, xfers, 2);
> +
> +	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
>  	if (ret < 0)
>  		return ret;
>  
> -	return st->rx[1];
> +	/* If the D7 bit is set on any read/write register, it indicates a

IIO comments are
	/*
	 * If ...

> +	 * parity error. The fault register is read-only and the D7 bit means
> +	 * something else there.
> +	 */
> +	if (reg != AD2S1210_REG_FAULT && st->rx[1] & AD2S1210_ADDRESS_DATA)
> +		return -EBADMSG;
> +
> +	*val = st->rx[1];
> +
> +	return 0;
>  }
>


>  static ssize_t ad2s1210_store_control(struct device *dev,
> @@ -264,25 +297,13 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>  		return -EINVAL;
>  
>  	mutex_lock(&st->lock);
> -	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	data = udata & AD2S1210_MSB_IS_LOW;
> -	ret = ad2s1210_config_write(st, data);
> +	data = udata & ~AD2S1210_ADDRESS_DATA;
> +	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	if (ret & AD2S1210_MSB_IS_HIGH) {
> -		ret = -EIO;
> -		dev_err(dev,
> -			"ad2s1210: write control register fail\n");
> -		goto error_ret;
> -	}
>  	st->resolution =
> -		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
>  	ad2s1210_set_resolution_pin(st);
>  	ret = len;
>  	st->hysteresis = !!(data & AD2S1210_ENABLE_HYSTERESIS);
> @@ -315,30 +336,17 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  		dev_err(dev, "ad2s1210: resolution out of range\n");
>  		return -EINVAL;
>  	}
> +
> +	data = (udata - 10) >> 1;
> +
>  	mutex_lock(&st->lock);
> -	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	data = ret;
> -	data &= ~AD2S1210_SET_RESOLUTION;
> -	data |= (udata - 10) >> 1;
> -	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
> +	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +				 AD2S1210_SET_RES, data);
>  	if (ret < 0)
>  		goto error_ret;
> -	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	data = ret;
> -	if (data & AD2S1210_MSB_IS_HIGH) {
> -		ret = -EIO;
> -		dev_err(dev, "ad2s1210: setting resolution fail\n");
> -		goto error_ret;
> -	}
> +
>  	st->resolution =
> -		ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> +		ad2s1210_resolution_value[data & AD2S1210_SET_RES];
>  	ad2s1210_set_resolution_pin(st);
>  	ret = len;
>  error_ret:
> @@ -351,13 +359,14 @@ static ssize_t ad2s1210_show_fault(struct device *dev,
>  				   struct device_attribute *attr, char *buf)
>  {
>  	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int value;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	ret = ad2s1210_config_read(st, AD2S1210_REG_FAULT);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_FAULT, &value);
>  	mutex_unlock(&st->lock);
>  
> -	return (ret < 0) ? ret : sprintf(buf, "0x%02x\n", ret);
> +	return ret < 0 ? ret : sprintf(buf, "0x%02x\n", value);

You added the brackets in earlier patch. I've dropped them now
from my tree which will make this not quite apply.



>  }
>  

...

>  
>  static ssize_t ad2s1210_store_reg(struct device *dev,
> @@ -409,14 +420,11 @@ static ssize_t ad2s1210_store_reg(struct device *dev,
>  	struct iio_dev_attr *iattr = to_iio_dev_attr(attr);
>  
>  	ret = kstrtou8(buf, 10, &data);
> -	if (ret)
> +	if (ret < 0)
>  		return -EINVAL;
> +
Unrelated. Also unnecessary as it doesn't return postive values.

>  	mutex_lock(&st->lock);
> -	ret = ad2s1210_config_write(st, iattr->address);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_config_write(st, data & AD2S1210_MSB_IS_LOW);
> -error_ret:
> +	ret = regmap_write(st->regmap, iattr->address, data);
>  	mutex_unlock(&st->lock);
>  	return ret < 0 ? ret : len;
>  }
> @@ -583,23 +591,12 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	mutex_lock(&st->lock);
>  	ad2s1210_set_resolution_pin(st);
>  
> -	ret = ad2s1210_config_write(st, AD2S1210_REG_CONTROL);
> -	if (ret < 0)
> -		goto error_ret;
> -	data = AD2S1210_DEF_CONTROL & ~(AD2S1210_SET_RESOLUTION);
> +	data = AD2S1210_DEF_CONTROL & ~AD2S1210_SET_RES;

Somewhat unrelated and you may sort it later, but I'd like
to see DEF_CONTROL broken out and FIELD_PREP() used for all the fields.
Seems crazy to use a value, then drop some bits then fill them in with
something else.

>  	data |= (st->resolution - 10) >> 1;
> -	ret = ad2s1210_config_write(st, data);
> -	if (ret < 0)
> -		goto error_ret;
> -	ret = ad2s1210_config_read(st, AD2S1210_REG_CONTROL);
> +	ret = regmap_write(st->regmap, AD2S1210_REG_CONTROL, data);
>  	if (ret < 0)
>  		goto error_ret;
>  
> -	if (ret & AD2S1210_MSB_IS_HIGH) {
I guess this was meant to be a sanity check on the chip responding. 

> -		ret = -EIO;
> -		goto error_ret;
> -	}
> -
>  	ret = ad2s1210_update_frequency_control_word(st);
>  	if (ret < 0)
>  		goto error_ret;
> @@ -652,6 +649,52 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  	return 0;
>  }

