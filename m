Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E14E7B42C1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 19:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjI3Rbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 13:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233050AbjI3Rbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 13:31:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D99CE1;
        Sat, 30 Sep 2023 10:31:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2B8C433C7;
        Sat, 30 Sep 2023 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696095092;
        bh=OIF3qTZzv4fmyLYYTtHMwTXoCRzHXWoRyRsQrWSbiao=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gkG9ZrhksFsGZc9fwu+4MOLSw66E3EDZoVAihz5wLqZF2LnFUvtM+GNMIQe7p0vuJ
         L3lAtYDPJhKOeFapkxQk1kRVNCgCa9+y4QHMIiV0lxfN7nFuUYa4sDqk3izN0Y281U
         uXp5O9RwViNq4rbAaco51QsJdbKU1LENvkUjjahqAo7LVZGFaRL7iuLVTrBmCD7Vxx
         Tg1KCd/5MhWuJLuO2jLfGeTKpXkK+Rerh8v6b4gJkkb1U1diZNi03XjJSKE8s2BBK0
         vKxTrmBTE0NMeePVI5zjKpYFMEl3vsM1+f90b5ag7JYxhilyN5M1C1FGSYKCYK4dI2
         9mnvSIH9XJ8Cw==
Date:   Sat, 30 Sep 2023 18:31:33 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: ad7192: Add fast settling support
Message-ID: <20230930183117.45d311ed@jic23-huawei>
In-Reply-To: <20230924215148.102491-4-alisadariana@gmail.com>
References: <20230924215148.102491-1-alisadariana@gmail.com>
        <20230924215148.102491-4-alisadariana@gmail.com>
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

On Mon, 25 Sep 2023 00:51:48 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Add fast settling mode support for AD7193.
> 
> Add fast_settling_average_factor attribute. Expose to user the current
> value of the fast settling average factor. User can change the value by
> writing a new one.
> 
> Add fast_settling_average_factor_available attribute. Expose to user
> possible values for the fast settling average factor.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Hi Alisa-Dariana,

Some questions inline.

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad7192      |  18 +++
>  drivers/iio/adc/ad7192.c                      | 128 ++++++++++++++++--
>  2 files changed, 134 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> index f8315202c8f0..780c6841b0c3 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad7192
> @@ -19,6 +19,24 @@ Description:
>  		the bridge can be disconnected (when it is not being used
>  		using the bridge_switch_en attribute.
>  
> +What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute, if available, is used to activate or deactivate
> +		fast settling mode and set the value of the average factor to
> +		1, 2, 8 or 16. If the average factor is set to 1, the fast
> +		settling mode is disabled. The data from the sinc filter is
> +		averaged by chosen value. The averaging reduces the output data
> +		rate for a given FS word, however, the RMS noise improves.

So I got distracted in earlier patches, and didn't read your description closely
so was assuming this was some weird filter control.

Despite it being described as being closely related to the sinc filter, is this
just an oversampling ratio control?  If it is, then you can use the standard
ABI for this.  Making sure to reflect changes in this on the sampling frequency
as the apparent sampling frequency will reduce.


> +
> +What:		/sys/bus/iio/devices/iio:deviceX/fast_settling_average_factor_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible values for the fast
> +		settling average factor: 1, 2, 8, 16.
> +
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltagex_sys_calibration
>  KernelVersion:
>  Contact:	linux-iio@vger.kernel.org
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 0f9d33002d35..3b7de23b024e 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -60,6 +60,8 @@
>  #define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
>  #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
>  #define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
> +#define AD7192_MODE_AVG_MASK	GENMASK(17, 16)
> +		  /* Fast Settling Filter Average Select Mask (AD7193 only) */
>  #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
>  #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
>  #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
> @@ -182,6 +184,7 @@ struct ad7192_state {
>  	u32				mode;
>  	u32				conf;
>  	u32				scale_avail[8][2];
> +	u8				avg_avail[4];
>  	u8				gpocon;
>  	u8				clock_sel;
>  	struct mutex			lock;	/* protect sensor state */
> @@ -459,6 +462,13 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  		st->scale_avail[i][0] = scale_uv;
>  	}
>  
> +	if (st->chip_info->chip_id == CHIPID_AD7193) {
> +		st->avg_avail[0] = 1;
> +		st->avg_avail[1] = 2;
> +		st->avg_avail[2] = 8;
> +		st->avg_avail[3] = 16;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -483,6 +493,18 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
>  			  FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
>  }
>  
> +static ssize_t ad7192_show_average_factor(struct device *dev,
> +					  struct device_attribute *attr,
> +					  char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct ad7192_state *st = iio_priv(indio_dev);
> +	u8 avg_factor_index;
> +
> +	avg_factor_index = FIELD_GET(AD7192_MODE_AVG_MASK, st->mode);
> +	return sysfs_emit(buf, "%d\n", st->avg_avail[avg_factor_index]);
> +}
> +
>  static ssize_t ad7192_set(struct device *dev,
>  			  struct device_attribute *attr,
>  			  const char *buf,
> @@ -491,12 +513,10 @@ static ssize_t ad7192_set(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
> +	bool val, ret_einval;
> +	u8 val_avg_factor;

There isn't really that much code shared between the new use of this
and previous ones. I'd introduce a new callback for that particular sysfs
attribute instead of changing this one.


> +	unsigned int i;
>  	int ret;
> -	bool val;
> -
> -	ret = kstrtobool(buf, &val);
> -	if (ret < 0)
> -		return ret;
>  
>  	ret = iio_device_claim_direct_mode(indio_dev);
>  	if (ret)
> @@ -504,6 +524,10 @@ static ssize_t ad7192_set(struct device *dev,
>  
>  	switch ((u32)this_attr->address) {
>  	case AD7192_REG_GPOCON:
> +		ret = kstrtobool(buf, &val);
> +		if (ret < 0)
> +			return ret;
> +
>  		if (val)
>  			st->gpocon |= AD7192_GPOCON_BPDSW;
>  		else
> @@ -512,6 +536,10 @@ static ssize_t ad7192_set(struct device *dev,
>  		ad_sd_write_reg(&st->sd, AD7192_REG_GPOCON, 1, st->gpocon);
>  		break;
>  	case AD7192_REG_CONF:
> +		ret = kstrtobool(buf, &val);
> +		if (ret < 0)
> +			return ret;
> +
>  		if (val)
>  			st->conf |= AD7192_CONF_ACX;
>  		else
> @@ -519,6 +547,27 @@ static ssize_t ad7192_set(struct device *dev,
>  
>  		ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
>  		break;
> +	case AD7192_REG_MODE:
> +		ret = kstrtou8(buf, 10, &val_avg_factor);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret_einval = true;
I'd rather this relected the positive condition.
So maybe
		bool found = false;
> +		for (i = 0; i < ARRAY_SIZE(st->avg_avail); i++) {
> +			if (val_avg_factor == st->avg_avail[i]) {
> +				st->mode &= ~AD7192_MODE_AVG_MASK;
> +				st->mode |= FIELD_PREP(AD7192_MODE_AVG_MASK, i);
> +				ret_einval = false;
found = true;
break;
> +			}
> +		}
> +
> +		if (ret_einval)
if (!found)
	return -EINVAL;

> +			return -EINVAL;
> +
> +		ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
> +		if (ret)
> +			return ret;
> +		break;
>  	default:
>  		ret = -EINVAL;
>  	}
> @@ -528,15 +577,22 @@ static ssize_t ad7192_set(struct device *dev,
>  	return ret ? ret : len;
>  }


