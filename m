Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16A7A62CA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjISMZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:25:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjISMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:24:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C48EF2;
        Tue, 19 Sep 2023 05:24:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Rqgm75Wvkz6HJjD;
        Tue, 19 Sep 2023 20:22:47 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 19 Sep
 2023 13:24:47 +0100
Date:   Tue, 19 Sep 2023 13:24:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alisadariana@gmail.com>
CC:     Alisa-Dariana Roman <alisa.roman@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: adc: ad7192: Use bitfield access macros
Message-ID: <20230919132440.00000380@Huawei.com>
In-Reply-To: <20230918214854.252781-2-alisadariana@gmail.com>
References: <20230918214854.252781-1-alisadariana@gmail.com>
        <20230918214854.252781-2-alisadariana@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2023 00:48:52 +0300
alisadariana@gmail.com wrote:

> From: Alisa-Dariana Roman <alisadariana@gmail.com>
> 
> Include bitfield.h and update driver to use bitfield access macros
> GENMASK, FIELD_PREP and FIELD_GET.
> 
> Also simplify AD7192_CONF_GAIN(-1) to AD7192_CONF_GAIN_MASK and
> AD7192_MODE_RATE(-1) to AD7192_MODE_RATE_MASK.
> 
> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> ---
>  drivers/iio/adc/ad7192.c | 50 +++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
> index 69d1103b9508..e83fecb63c1d 100644
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
> @@ -43,7 +44,9 @@
>  #define AD7192_COMM_WEN		BIT(7) /* Write Enable */
>  #define AD7192_COMM_WRITE	0 /* Write Operation */
>  #define AD7192_COMM_READ	BIT(6) /* Read Operation */
> -#define AD7192_COMM_ADDR(x)	(((x) & 0x7) << 3) /* Register Address */
> +#define AD7192_COMM_ADDR_MASK	GENMASK(5, 3) /* Register Address Mask */
> +#define AD7192_COMM_ADDR(x)	FIELD_PREP(AD7192_COMM_ADDR_MASK, x)
> +				  /* Register Address */
>  #define AD7192_COMM_CREAD	BIT(2) /* Continuous Read of Data Register */
>  
>  /* Status Register Bit Designations (AD7192_REG_STAT) */
> @@ -56,17 +59,24 @@
>  #define AD7192_STAT_CH1		BIT(0) /* Channel 1 */
>  
>  /* Mode Register Bit Designations (AD7192_REG_MODE) */
> -#define AD7192_MODE_SEL(x)	(((x) & 0x7) << 21) /* Operation Mode Select */
> -#define AD7192_MODE_SEL_MASK	(0x7 << 21) /* Operation Mode Select Mask */
> -#define AD7192_MODE_STA(x)	(((x) & 0x1) << 20) /* Status Register transmission */
> +#define AD7192_MODE_SEL_MASK	GENMASK(23, 21) /* Operation Mode Select Mask */
> +#define AD7192_MODE_SEL(x)	FIELD_PREP(AD7192_MODE_SEL_MASK, x)

Hi  Alisa-Dariana,

Whilst it is a bigger change, I'd ideally like all these XXX(x) calls to be replaced
inline with the FIELD_PREP(). It is just as clear to read and in many cases better
because you get patterns that go form

st->mode &= ~AD7192_MODE_SEL_MASK;
st->mode |= AD7192_MODE_SEL(mode);

which becomes the more visible and obvious
st->mode &= ~AD7192_MODE_SEL_MASK;
st->mode |= FIELD_PREP(AD7192_MODE_SEL_MASK, mode);
where you can clearly see the same bits were removed from st->mode, then
filled in with the new field value.

That's obscured with the additional macro.

Jonathan


> +				  /* Operation Mode Select */
>  #define AD7192_MODE_STA_MASK	BIT(20) /* Status Register transmission Mask */
> -#define AD7192_MODE_CLKSRC(x)	(((x) & 0x3) << 18) /* Clock Source Select */
> +#define AD7192_MODE_STA(x)	FIELD_PREP(AD7192_MODE_STA_MASK, x)
> +				  /* Status Register transmission */
> +#define AD7192_MODE_CLKSRC_MASK	GENMASK(19, 18) /* Clock Source Select Mask */
> +#define AD7192_MODE_CLKSRC(x)	FIELD_PREP(AD7192_MODE_CLKSRC_MASK, x)
> +				  /* Clock Source Select */
>  #define AD7192_MODE_SINC3	BIT(15) /* SINC3 Filter Select */
>  #define AD7192_MODE_ENPAR	BIT(13) /* Parity Enable */
>  #define AD7192_MODE_CLKDIV	BIT(12) /* Clock divide by 2 (AD7190/2 only)*/
>  #define AD7192_MODE_SCYCLE	BIT(11) /* Single cycle conversion */
>  #define AD7192_MODE_REJ60	BIT(10) /* 50/60Hz notch filter */
> -#define AD7192_MODE_RATE(x)	((x) & 0x3FF) /* Filter Update Rate Select */
> +#define AD7192_MODE_RATE_MASK	GENMASK(9, 0)
> +				  /* Filter Update Rate Select Mask */
> +#define AD7192_MODE_RATE(x)	FIELD_PREP(AD7192_MODE_RATE_MASK, x)
> +				  /* Filter Update Rate Select */
>  
>  /* Mode Register: AD7192_MODE_SEL options */
>  #define AD7192_MODE_CONT		0 /* Continuous Conversion Mode */
> @@ -92,13 +102,16 @@
>  #define AD7192_CONF_CHOP	BIT(23) /* CHOP enable */
>  #define AD7192_CONF_ACX		BIT(22) /* AC excitation enable(AD7195 only) */
>  #define AD7192_CONF_REFSEL	BIT(20) /* REFIN1/REFIN2 Reference Select */
> -#define AD7192_CONF_CHAN(x)	((x) << 8) /* Channel select */
> -#define AD7192_CONF_CHAN_MASK	(0x7FF << 8) /* Channel select mask */
> +#define AD7192_CONF_CHAN_MASK	GENMASK(18, 8) /* Channel select mask */
> +#define AD7192_CONF_CHAN(x)	FIELD_PREP(AD7192_CONF_CHAN_MASK, x)
> +				  /* Channel select */
>  #define AD7192_CONF_BURN	BIT(7) /* Burnout current enable */
>  #define AD7192_CONF_REFDET	BIT(6) /* Reference detect enable */
>  #define AD7192_CONF_BUF		BIT(4) /* Buffered Mode Enable */
>  #define AD7192_CONF_UNIPOLAR	BIT(3) /* Unipolar/Bipolar Enable */
> -#define AD7192_CONF_GAIN(x)	((x) & 0x7) /* Gain Select */
> +#define AD7192_CONF_GAIN_MASK	GENMASK(2, 0) /* Gain Select */
> +#define AD7192_CONF_GAIN(x)	FIELD_PREP(AD7192_CONF_GAIN_MASK, x)
> +				  /* Gain Select */
>  
>  #define AD7192_CH_AIN1P_AIN2M	BIT(0) /* AIN1(+) - AIN2(-) */
>  #define AD7192_CH_AIN3P_AIN4M	BIT(1) /* AIN3(+) - AIN4(-) */
> @@ -130,7 +143,7 @@
>  #define CHIPID_AD7192		0x0
>  #define CHIPID_AD7193		0x2
>  #define CHIPID_AD7195		0x6
> -#define AD7192_ID_MASK		0x0F
> +#define AD7192_ID_MASK		GENMASK(3, 0)
>  
>  /* GPOCON Register Bit Designations (AD7192_REG_GPOCON) */
>  #define AD7192_GPOCON_BPDSW	BIT(6) /* Bridge power-down switch enable */
> @@ -399,7 +412,7 @@ static int ad7192_setup(struct iio_dev *indio_dev, struct device_node *np)
>  	if (ret)
>  		return ret;
>  
> -	id &= AD7192_ID_MASK;
> +	id = FIELD_GET(AD7192_ID_MASK, id);
>  
>  	if (id != st->chip_info->chip_id)
>  		dev_warn(&st->sd.spi->dev, "device ID query failed (0x%X != 0x%X)\n",
> @@ -472,7 +485,7 @@ static ssize_t ad7192_show_ac_excitation(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->conf & AD7192_CONF_ACX));
> +	return sysfs_emit(buf, "%d\n", !!FIELD_GET(AD7192_CONF_ACX, st->conf));
>  }
>  
>  static ssize_t ad7192_show_bridge_switch(struct device *dev,
> @@ -482,7 +495,8 @@ static ssize_t ad7192_show_bridge_switch(struct device *dev,
>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>  	struct ad7192_state *st = iio_priv(indio_dev);
>  
> -	return sysfs_emit(buf, "%d\n", !!(st->gpocon & AD7192_GPOCON_BPDSW));
> +	return sysfs_emit(buf, "%d\n",
> +			  !!FIELD_GET(AD7192_GPOCON_BPDSW, st->gpocon));
>  }
>  
>  static ssize_t ad7192_set(struct device *dev,
> @@ -667,9 +681,9 @@ static int ad7192_get_3db_filter_freq(struct ad7192_state *st)
>  	fadc = DIV_ROUND_CLOSEST(st->fclk,
>  				 st->f_order * AD7192_MODE_RATE(st->mode));
>  
> -	if (st->conf & AD7192_CONF_CHOP)
> +	if (FIELD_GET(AD7192_CONF_CHOP, st->conf))
>  		return DIV_ROUND_CLOSEST(fadc * 240, 1024);
> -	if (st->mode & AD7192_MODE_SINC3)
> +	if (FIELD_GET(AD7192_MODE_SINC3, st->mode))
>  		return DIV_ROUND_CLOSEST(fadc * 272, 1024);
>  	else
>  		return DIV_ROUND_CLOSEST(fadc * 230, 1024);
> @@ -682,7 +696,7 @@ static int ad7192_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad7192_state *st = iio_priv(indio_dev);
> -	bool unipolar = !!(st->conf & AD7192_CONF_UNIPOLAR);
> +	bool unipolar = !!FIELD_GET(AD7192_CONF_UNIPOLAR, st->conf);
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -746,7 +760,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			if (val2 == st->scale_avail[i][1]) {
>  				ret = 0;
>  				tmp = st->conf;
> -				st->conf &= ~AD7192_CONF_GAIN(-1);
> +				st->conf &= ~AD7192_CONF_GAIN_MASK;
>  				st->conf |= AD7192_CONF_GAIN(i);
>  				if (tmp == st->conf)
>  					break;
> @@ -769,7 +783,7 @@ static int ad7192_write_raw(struct iio_dev *indio_dev,
>  			break;
>  		}
>  
> -		st->mode &= ~AD7192_MODE_RATE(-1);
> +		st->mode &= ~AD7192_MODE_RATE_MASK;
>  		st->mode |= AD7192_MODE_RATE(div);
>  		ad_sd_write_reg(&st->sd, AD7192_REG_MODE, 3, st->mode);
>  		break;

