Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6476F7ACA10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 16:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbjIXOkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 10:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjIXOkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 10:40:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA9FB;
        Sun, 24 Sep 2023 07:40:05 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AE75C433C7;
        Sun, 24 Sep 2023 14:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695566404;
        bh=NXnXdvDgyMCz8lucrw3g7olRfu8jkj55sAdy8uI/qAA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrH4HlZATvaevxgNXmzcUQolGRGUMmiFyJwcbp+aaR5CqRzoJtKilluskaOnU7xsr
         pvx7FyYgJkhpjn4gtuadGK0kQS6jCPl4q97knhPuYHvlNtdKzlt4gIevWq7P6j2crg
         +ZBfG8JFxq3ktSg02PS6rL8ZgDSDfk7uf3yhCBC10sEkqxC9NCauut+0aQ8VukNcio
         9Ti+xw5H1xxLTK3yXkwt//GSra6i5hHbzX1q9DPnHn/vmVCsg0y5sLOll2Om+JW+70
         ZNd/XslTChS5P7YQApdKZjFhC5GUTFqF1GqHutCek2xAEpWzMWqoZrROTgdIbTjyBB
         knBcO2JaWaPcQ==
Date:   Sun, 24 Sep 2023 15:39:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     alisadariana@gmail.com
Cc:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] iio: adc: ad7192: Use bitfield access macros
Message-ID: <20230924153958.56755045@jic23-huawei>
In-Reply-To: <20230920003342.118813-2-alisadariana@gmail.com>
References: <20230920003342.118813-1-alisadariana@gmail.com>
        <20230920003342.118813-2-alisadariana@gmail.com>
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

On Wed, 20 Sep 2023 03:33:40 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisadariana@gmail.com>
> 
> Include bitfield.h and update driver to use bitfield access macros
> GENMASK, FIELD_PREP and FIELD_GET.
> 
> Remove old macros in favor of using FIELD_PREP and masks.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>

Hi Alisa-Darinana,

Please fix the author for these to match your sign off
git commit --amend --author="Alisa-Dariana Roman <alisa.roman@analog.com>"
should fix that up.

There are a few interesting corners in the original code where a single
macro was used for the get and set paths.  I think a few places you picked
the one with the wrong semantics whilst cleaning it up.

Also some unnecessary !! horribleness now we are extracting the value rather
than a shifted version of the value.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7192.c | 73 ++++++++++++++++++++--------------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 69d1103b9508..64bc09ce3cb1 100644
> --- a/drivers/iio/adc/ad7192.c
> +++ b/drivers/iio/adc/ad7192.c
> @@ -6,6 +6,7 @@
>   */
>  
>  #include <linux/interrupt.h>
> +#include <linux/bitfield.h>
>  #include <linux/clk.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
> @@ -43,7 +44,7 @@
>  #define AD7192_COMM_WEN		BIT(7) /* Write Enable */
>  #define AD7192_COMM_WRITE	0 /* Write Operation */
>  #define AD7192_COMM_READ	BIT(6) /* Read Operation */
> -#define AD7192_COMM_ADDR(x)	(((x) & 0x7) << 3) /* Register Address */
> +#define AD7192_COMM_ADDR_MASK	GENMASK(5, 3) /* Register Address Mask */
>  #define AD7192_COMM_CREAD	BIT(2) /* Continuous Read of Data Register */
>  
>  /* Status Register Bit Designations (AD7192_REG_STAT) */
> @@ -56,17 +57,16 @@
>  #define AD7192_STAT_CH1		BIT(0) /* Channel 1 */
>  
>  /* Mode Register Bit Designations (AD7192_REG_MODE) */
> -#define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
> -#define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
> -#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
> +#define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
>  #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
> -#define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
> +#define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
>  #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
>  #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
>  #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
>  #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
>  #define AD7192_MODE_REJ60	BIT(10) /* 50/60Hz notch filter */
> -#define AD7192_MODE_RATE(x)	((x) & 0x3FF) /* Filter Update Rate Select */
> +#define AD7192_MODE_RATE_MASK	GENMASK(9, 0)
> +				  /* Filter Update Rate Select Mask */

Put the comment on the line above the thing it is talking about, not the line below.

>  
>  /* Mode Register: AD7192_MODE_SEL options */
>  #define AD7192_MODE_CONT		0 /* Continuous Conversion Mode */
> @@ -92,13 +92,12 @@
>  #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
>  #define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
>  #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
> -#define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
> -#define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
> +#define AD7192_CONF_CHAN_MASK	GENMASK(18, 8) /* Channel select mask */
>  #define AD7192_CONF_BURN	BIT(7) /* Burnout current enable */
>  #define AD7192_CONF_REFDET	BIT(6) /* Reference detect enable */
>  #define AD7192_CONF_BUF		BIT(4) /* Buffered Mode Enable */
>  #define AD7192_CONF_UNIPOLAR	BIT(3) /* Unipolar/Bipolar Enable */
> -#define AD7192_CONF_GAIN(x)	((x) & 0x7) /* Gain Select */
> +#define AD7192_CONF_GAIN_MASK	GENMASK(2, 0) /* Gain Select */
>  
>  #define AD7192_CH_AIN1P_AIN2M	BIT(0) /* AIN1(+) - AIN2(-) */
>  #define AD7192_CH_AIN3P_AIN4M	BIT(1) /* AIN3(+) - AIN4(-) */
> @@ -130,7 +129,7 @@
>  #define CHIPID_AD7192		0x0
>  #define CHIPID_AD7193		0x2
>  #define CHIPID_AD7195		0x6
> -#define AD7192_ID_MASK		0x0F
> +#define AD7192_ID_MASK		GENMASK(3, 0)
>  
>  /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
>  #define AD7192_GPOCON_BPDSW	BIT(6) /* Bridge power-down switch enable */
> @@ -272,7 +271,7 @@ static int ad7192_set_channel(struct ad_sigma_delta *sd, unsigned int channel)
>  	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
>  
>  	st->conf &= ~AD7192_CONF_CHAN_MASK;
> -	st->conf |= AD7192_CONF_CHAN(channel);
> +	st->conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, channel);
>  
>  	return ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, st->conf);
>  }
> @@ -283,7 +282,7 @@ static int ad7192_set_mode(struct ad_sigma_delta *sd,
>  	struct ad7192_state *st = ad_sigma_delta_to_ad7192(sd);
>  
>  	st->mode &= ~AD7192_MODE_SEL_MASK;
> -	st->mode |= AD7192_MODE_SEL(mode);
> +	st->mode |= FIELD_PREP(AD7192_MODE_SEL_MASK, mode);
>  
>  	return ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  }
> @@ -295,7 +294,7 @@ static int ad7192_append_status(struct ad_sigma_delta *sd, bool append)
>  	int ret;
>  
>  	mode &= ~AD7192_MODE_STA_MASK;
> -	mode |= AD7192_MODE_STA(append);
> +	mode |= FIELD_PREP(AD7192_MODE_STA_MASK, append);
>  
>  	ret = ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, mode);
>  	if (ret < 0)
> @@ -399,17 +398,17 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  	if (ret)
>  		return ret;
>  
> -	id &= AD7192_ID_MASK;
> +	id = FIELD_GET(AD7192_ID_MASK, id);
>  
>  	if (id != st->chip_info->chip_id)
>  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
>  			 id, st->chip_info->chip_id);
>  
> -	st->mode = AD7192_MODE_SEL(AD7192_MODE_IDLE) |
> -		AD7192_MODE_CLKSRC(st->clock_sel) |
> -		AD7192_MODE_RATE(480);
> +	st->mode = FIELD_PREP(AD7192_MODE_SEL_MASK, AD7192_MODE_IDLE) |
> +		FIELD_PREP(AD7192_MODE_CLKSRC_MASK, st->clock_sel) |
> +		FIELD_PREP(AD7192_MODE_RATE_MASK, 480);
>  
> -	st->conf = AD7192_CONF_GAIN(0);
> +	st->conf = FIELD_PREP(AD7192_CONF_GAIN_MASK, 0);
>  
>  	rej60_en = of_property_read_bool(np, "adi,rejection-60-Hz-enable");
>  	if (rej60_en)
> @@ -455,7 +454,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  	for (i = 0; i < ARRAY_SIZE(st->scale_avail); i++) {
>  		scale_uv = ((u64)st->int_vref_mv * 100000000)
>  			>> (indio_dev->channels[0].scan_type.realbits -  
> -			((st->conf & AD7192_CONF_UNIPOLAR) ? 0 : 1));
> +			!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf));
>  		scale_uv >>= i;
>  
>  		st->scale_avail[i][1] = do_div(scale_uv, 100000000) * 10;
> @@ -472,7 +471,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
> +	return sysfs_emit(buf, "%d\n", !!FIELD_GET(AD7192_CONF_ACX, st->conf));

Can drop the !! as FIELD_GET() will shift it so the value is 0 or 1 anyway.

>  }
>  
>  static ssize_t ad7192_show_bridge_switch(struct device *dev,
> @@ -482,7 +481,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
> +	return sysfs_emit(buf, "%d\n",
> +			  !!FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
Drop the !!

>  }
>  
>  static ssize_t ad7192_set(struct device *dev,
> @@ -537,14 +537,14 @@ static void ad7192_get_available_filter_freq(struct ad7192_state *st,
>  
>  	/* Formulas for filter at page 25 of the datasheet */
>  	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SYNC4_FILTER * AD7192_MODE_RATE(st->mode));
> +				 AD7192_SYNC4_FILTER * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
FIELD_GET()
>  	freq[0] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
>  	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 AD7192_SYNC3_FILTER * AD7192_MODE_RATE(st->mode));
> +				 AD7192_SYNC3_FILTER * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));
FIELD_GET()

>  	freq[1] = DIV_ROUND_CLOSEST(fadc * 240, 1024);
>  
> -	fadc = DIV_ROUND_CLOSEST(st->fclk, AD7192_MODE_RATE(st->mode));
> +	fadc = DIV_ROUND_CLOSEST(st->fclk, FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));

As below FIELD_GET()

>  	freq[2] = DIV_ROUND_CLOSEST(fadc * 230, 1024);
>  	freq[3] = DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  }
> @@ -665,11 +665,11 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
>  	unsigned int fadc;
>  
>  	fadc = DIV_ROUND_CLOSEST(st->fclk,
> -				 st->f_order * AD7192_MODE_RATE(st->mode));
> +				 st->f_order * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));

As below.  I think this should be a FIELD_GET()

>  
> -	if (st->conf & AD7192_CONF_CHOP)
> +	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
>  		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
> -	if (st->mode & AD7192_MODE_SINC3)
> +	if (FIELD_GET(AD7192_MODE_SINC3, st->mode))
>  		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  	else
>  		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
> @@ -682,7 +682,8 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> -	bool unipolar = !!(st->conf & AD7192_CONF_UNIPOLAR);
> +	bool unipolar = !!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf);
> +	u8 gain = FIELD_PREP(AD7192_CONF_GAIN_MASK, st->conf);
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -691,8 +692,8 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  		switch (chan->type) {
>  		case IIO_VOLTAGE:
>  			mutex_lock(&st->lock);
> -			*val = st->scale_avail[AD7192_CONF_GAIN(st->conf)][0];
> -			*val2 = st->scale_avail[AD7192_CONF_GAIN(st->conf)][1];
> +			*val = st->scale_avail[gain][0];
> +			*val2 = st->scale_avail[gain][1];
>  			mutex_unlock(&st->lock);
>  			return IIO_VAL_INT_PLUS_NANO;
>  		case IIO_TEMP:
> @@ -713,7 +714,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SAMP_FREQ:
>  		*val = st->fclk /
> -			(st->f_order * 1024 * AD7192_MODE_RATE(st->mode));
> +			(st->f_order * 1024 * FIELD_PREP(AD7192_MODE_RATE_MASK, st->mode));

FIELD_GET() I think. Though not 100% sure of intent and as it just masks
it isn't a code change to flip from one to the other.

>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		*val = ad7192_get_3db_filter_freq(st);
> @@ -746,8 +747,8 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			if (val2 == st->scale_avail[i][1]) {
>  				ret = 0;
>  				tmp = st->conf;
> -				st->conf &= ~AD7192_CONF_GAIN(-1);
> -				st->conf |= AD7192_CONF_GAIN(i);
> +				st->conf &= ~AD7192_CONF_GAIN_MASK;
> +				st->conf |= FIELD_PREP(AD7192_CONF_GAIN_MASK, i);
>  				if (tmp == st->conf)
>  					break;
>  				ad_sd_write_reg(&st->sd, AD7192_REG_CONF,
> @@ -769,8 +770,8 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		st->mode &= ~AD7192_MODE_RATE(-1);
> -		st->mode |= AD7192_MODE_RATE(div);
> +		st->mode &= ~AD7192_MODE_RATE_MASK;
> +		st->mode |= FIELD_PREP(AD7192_MODE_RATE_MASK, div);
>  		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  		break;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> @@ -830,7 +831,7 @@ static int ad7192_update_scan_mode(struct iio_dev *indio_dev, const unsigned lon
>  
>  	conf &= ~AD7192_CONF_CHAN_MASK;
>  	for_each_set_bit(i, scan_mask, 8)
> -		conf |= AD7192_CONF_CHAN(i);
> +		conf |= FIELD_PREP(AD7192_CONF_CHAN_MASK, i);
>  
>  	ret = ad_sd_write_reg(&st->sd, AD7192_REG_CONF, 3, conf);
>  	if (ret < 0)

