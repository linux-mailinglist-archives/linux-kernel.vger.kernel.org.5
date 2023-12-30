Return-Path: <linux-kernel+bounces-13413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE38820505
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 13:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2CAC1C20F5F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 12:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D2B8BE7;
	Sat, 30 Dec 2023 12:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bSIYVExP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1845A79DF;
	Sat, 30 Dec 2023 12:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EADC433C9;
	Sat, 30 Dec 2023 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703937833;
	bh=r/tXXeAnCHvwEpo6MV27QydIsEHsS9gab9b2FMQ46lw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bSIYVExPSMmdhZNlM2OQW/NglPLY5lk1jBy32FLCj26Bd/thj7vw/RDqsvv02LJx1
	 XjuWAbzw2SVByS8Rwx6i1VeMv7K96TOIDNhDN/9QOeX/sRdErhQ3Xae2mLfD/Ysb8I
	 l9uoPoAAx2yXwDuTusoUE5CsYCtI/XIDskGOvkHm7YbKqg+MxcdCTSXEKgEAXqKlIR
	 q3yxsbL3VcEQwXGdUt80mknfTlMzNj39tI2ZsDxKkIB0sZOI07ZoRIB2dNCtDaZUlq
	 Ik24Srz8Vt5b4fv2cDqUcwbYUcIa7OERG/1OwYl/AXfSVyaIs6kKqymVBmkBAYJUjv
	 S17zA06Oq7WrQ==
Date: Sat, 30 Dec 2023 12:03:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: <cy_huang@richtek.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Rob Herring
 <robh+dt@kernel.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@pengutronix.de>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: rtq6056: Add support for the whole
 RTQ6056 family
Message-ID: <20231230120347.0816bd09@jic23-huawei>
In-Reply-To: <74db15583a9a68701dbff5a1a967c0d987d6dfb6.1703762557.git.cy_huang@richtek.com>
References: <cover.1703762557.git.cy_huang@richtek.com>
	<74db15583a9a68701dbff5a1a967c0d987d6dfb6.1703762557.git.cy_huang@richtek.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Dec 2023 19:29:35 +0800
<cy_huang@richtek.com> wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
> 
> RTQ6053 and RTQ6059 are the same series of RTQ6056.
> 
> The respective differences with RTQ6056 are listed below
> RTQ6053
> - chip package type
> 
> RTQ6059
> - Reduce the pinout for vbus sensing pin
> - Some internal ADC scaling change
> 
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Hi ChiYuan,

Some comments inline, most focus on not mixing device specific features
across code and data.  You always want them to be fully specified by
the the device specific const struct directly not by code using an
ID from there.  It ends up more readable and more flexible to have it
all done via data or callbacks where things are a too complex for data.

Thanks,

Jonathan

> ---
> v2
> - Remove rtq6053 in DT match table and make rtq6053 fallback compatible
>   with rtq6056
> ---
>  drivers/iio/adc/rtq6056.c | 264 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 250 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iio/adc/rtq6056.c b/drivers/iio/adc/rtq6056.c
> index ad4cea6839b2..5587178cea83 100644
> --- a/drivers/iio/adc/rtq6056.c
> +++ b/drivers/iio/adc/rtq6056.c
> @@ -39,6 +39,16 @@
>  #define RTQ6056_DEFAULT_CONFIG	0x4127
>  #define RTQ6056_CONT_ALLON	7
>  
> +#define RTQ6059_DEFAULT_CONFIG	0x3C47
> +#define RTQ6059_VBUS_LSB_OFFSET	3
> +#define RTQ6059_AVG_BASE	8
> +
> +enum {
> +	RICHTEK_DEV_RTQ6056 = 0,
> +	RICHTEK_DEV_RTQ6059,
> +	RICHTEK_DEV_MAX
> +};
> +
>  enum {
>  	RTQ6056_CH_VSHUNT = 0,
>  	RTQ6056_CH_VBUS,
> @@ -50,16 +60,29 @@ enum {
>  enum {
>  	F_OPMODE = 0,
>  	F_VSHUNTCT,
> +	F_SADC = F_VSHUNTCT,

If the devices have different register fields, better to have different enums
for them as well as that should result in less confusing code.


>  	F_VBUSCT,
> +	F_BADC = F_VBUSCT,
>  	F_AVG,
> +	F_PGA = F_AVG,
>  	F_RESET,
>  	F_MAX_FIELDS
>  };
>  
> +struct richtek_dev_data {
> +	int dev_id;

It almost always turns out to be a bad idea to use a mixture of
'data' in a structure like this and a device id plus special casing int he
code.  Better to add more data to this structure or callbacks specific
to the individual devices types.  So I shouldn't see a dev_id field in
here at all.

> +	int default_conv_time;
> +	unsigned int default_config;
> +	unsigned int calib_coefficient;
> +	const struct reg_field *reg_fields;
> +	const struct iio_chan_spec *channels;
> +};

...

>  static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
>  				    struct iio_chan_spec const *ch,
>  				    int *val)
>  {
> +	const struct richtek_dev_data *devdata = priv->devdata;
>  	struct device *dev = priv->dev;
>  	unsigned int addr = ch->address;
>  	unsigned int regval;
> @@ -168,10 +282,18 @@ static int rtq6056_adc_read_channel(struct rtq6056_priv *priv,
>  		return ret;
>  
>  	/* Power and VBUS is unsigned 16-bit, others are signed 16-bit */
> -	if (addr == RTQ6056_REG_BUSVOLT || addr == RTQ6056_REG_POWER)
> +	switch (addr) {
> +	case RTQ6056_REG_BUSVOLT:
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
> +			regval >>= RTQ6059_VBUS_LSB_OFFSET;

Store the offset as for other case below and apply it unconditionally. If it is
zero then this is a noop.

> +		fallthrough;
> +	case RTQ6056_REG_POWER:
>  		*val = regval;
> -	else
> +		break;
> +	default:
>  		*val = sign_extend32(regval, 16);

Fallthrough stuff is harder to read so only use it when there is significant saving
in code.  here just repeat the sign_extend32() in both cases.

> +		break;
> +	}
>  
>  	return IIO_VAL_INT;
>  }
> @@ -199,6 +321,28 @@ static int rtq6056_adc_read_scale(struct iio_chan_spec const *ch, int *val,
>  	}
>  }
>  

>  static int rtq6056_adc_get_sample_freq(struct rtq6056_priv *priv,
>  				       struct iio_chan_spec const *ch, int *val)
>  {
> @@ -292,11 +464,15 @@ static int rtq6056_adc_read_raw(struct iio_dev *indio_dev,
>  				int *val2, long mask)
>  {
>  	struct rtq6056_priv *priv = iio_priv(indio_dev);
> +	const struct richtek_dev_data *devdata = priv->devdata;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
>  		return rtq6056_adc_read_channel(priv, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
> +			return rtq6059_adc_read_scale(chan, val, val2);

Provide a callback for this as for other examples below.

> +
>  		return rtq6056_adc_read_scale(chan, val, val2);
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>  		*val = priv->avg_sample;
> @@ -313,16 +489,28 @@ static int rtq6056_adc_read_avail(struct iio_dev *indio_dev,
>  				  const int **vals, int *type, int *length,
>  				  long mask)
>  {
> +	struct rtq6056_priv *priv = iio_priv(indio_dev);
> +	const struct richtek_dev_data *devdata = priv->devdata;
> +
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
> +			return -EINVAL;

Shouldn't need this protection as the channels won't have relevant
bitmap bit set and this will never be called.

> +
>  		*vals = rtq6056_samp_freq_list;
>  		*type = IIO_VAL_INT;
>  		*length = ARRAY_SIZE(rtq6056_samp_freq_list);
>  		return IIO_AVAIL_LIST;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		*vals = rtq6056_avg_sample_list;
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059) {
> +			*vals = rtq6059_avg_sample_list;
> +			*length = ARRAY_SIZE(rtq6059_avg_sample_list);
Store all this in devdata.

		*vals = devdata->avg_sample_list;
		*length = devdata->avg_sample_list_length;

> +		} else {
> +			*vals = rtq6056_avg_sample_list;
> +			*length = ARRAY_SIZE(rtq6056_avg_sample_list);
> +		}
> +
>  		*type = IIO_VAL_INT;
> -		*length = ARRAY_SIZE(rtq6056_avg_sample_list);
>  		return IIO_AVAIL_LIST;
>  	default:
>  		return -EINVAL;
> @@ -334,6 +522,7 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
>  				 int val2, long mask)
>  {
>  	struct rtq6056_priv *priv = iio_priv(indio_dev);
> +	const struct richtek_dev_data *devdata = priv->devdata;
>  	int ret;
>  
>  	ret = iio_device_claim_direct_mode(indio_dev);
> @@ -342,10 +531,16 @@ static int rtq6056_adc_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SAMP_FREQ:
> -		ret = rtq6056_adc_set_samp_freq(priv, chan, val);
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
> +			ret = -EINVAL;
> +		else
> +			ret = rtq6056_adc_set_samp_freq(priv, chan, val);
>  		break;
>  	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> -		ret = rtq6056_adc_set_average(priv, val);
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059)
> +			ret = rtq6059_adc_set_average(priv, val);
> +		else
> +			ret = rtq6056_adc_set_average(priv, val);

Provide a callback in devdata so this becomes something like
		ret = devdata->set_averate(priv, val);

>  		break;
>  	default:

> +static const struct iio_info rtq6059_info = {
> +	.attrs = &rtq6056_attribute_group,

This is odd. you don't provide an access functions so you won't be able to read
channels etc. It isn't used so I guess you should just get rid of it.

> +};
> +
>  static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct rtq6056_priv *priv = iio_priv(indio_dev);
> +	const struct richtek_dev_data *devdata = priv->devdata;
>  	struct device *dev = priv->dev;
>  	struct {
>  		u16 vals[RTQ6056_MAX_CHANNEL];
> @@ -469,6 +670,10 @@ static irqreturn_t rtq6056_buffer_trigger_handler(int irq, void *p)
>  		if (ret)
>  			goto out;
>  
> +		if (devdata->dev_id == RICHTEK_DEV_RTQ6059 &&
> +		    addr == RTQ6056_REG_BUSVOLT)

Store an offset in the devdata->dev_id and this becomes something like.
		if (addr == RTQ6056_REG_BUS_VOLT)
			raw >>= devdata->vbus_offset;

> +			raw >>= RTQ6059_VBUS_LSB_OFFSET;
> +
>  		data.vals[i++] = raw;
>  	}
>  
> @@ -528,20 +733,26 @@ static int rtq6056_probe(struct i2c_client *i2c)
>  	struct rtq6056_priv *priv;
>  	struct device *dev = &i2c->dev;
>  	struct regmap *regmap;
> +	const struct richtek_dev_data *devdata;
>  	unsigned int vendor_id, shunt_resistor_uohm;
>  	int ret;
>  
>  	if (!i2c_check_functionality(i2c->adapter, I2C_FUNC_SMBUS_WORD_DATA))
>  		return -EOPNOTSUPP;
>  
> +	devdata = device_get_match_data(dev);
> +	if (!devdata)
> +		return dev_err_probe(dev, -EINVAL, "Invalid dev data\n");
> +
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
>  	priv = iio_priv(indio_dev);
>  	priv->dev = dev;
> -	priv->vshuntct_us = priv->vbusct_us = 1037;
> +	priv->vshuntct_us = priv->vbusct_us = devdata->default_conv_time;

I'd keep a _us postfix for default_conv_time to make the units of that
self documenting as well.

>  	priv->avg_sample = 1;
> +	priv->devdata = devdata;
>  	i2c_set_clientdata(i2c, priv);
>  
>  	regmap = devm_regmap_init_i2c(i2c, &rtq6056_regmap_config);
> @@ -556,20 +767,26 @@ static int rtq6056_probe(struct i2c_client *i2c)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to get manufacturer info\n");
>  
> +	/* For RTQ6059, this vendor id value is meaningless */

If that is the case, why are you checking it?
I'd read that comment as meaning this will fail for RTQ6059

>  	if (vendor_id != RTQ6056_VENDOR_ID)
>  		return dev_err_probe(dev, -ENODEV,
>  				     "Invalid vendor id 0x%04x\n", vendor_id);
>  
>  	ret = devm_regmap_field_bulk_alloc(dev, regmap, priv->rm_fields,
> -					   rtq6056_reg_fields, F_MAX_FIELDS);
> +					   devdata->reg_fields, F_MAX_FIELDS);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to init regmap field\n");
>  
>  	/*
> +	 * RTQ6053 & RTQ6056:
>  	 * By default, configure average sample as 1, bus and shunt conversion
>  	 * time as 1037 microsecond, and operating mode to all on.
> +	 *
> +	 * RTQ6059:
> +	 * By default, configure average sample as 1, bus and shunt conversion
> +	 * time as 532 microsecond, and operating mode to all on.
Move this documentation to where devdata->default_config is set. 
It's device specific information, so put it in the device specific place not
the main code flow.

>  	 */
> -	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, RTQ6056_DEFAULT_CONFIG);
> +	ret = regmap_write(regmap, RTQ6056_REG_CONFIG, devdata->default_config);
>  	if (ret)
>  		return dev_err_probe(dev, ret,
>  				     "Failed to enable continuous sensing\n");
> @@ -598,8 +815,8 @@ static int rtq6056_probe(struct i2c_client *i2c)
>  
>  	indio_dev->name = "rtq6056";
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = rtq6056_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(rtq6056_channels);
> +	indio_dev->channels = devdata->channels;
> +	indio_dev->num_channels = RTQ6056_MAX_CHANNEL + 1;

I'd embed the number of channels in devdata as well then the ARRAY_SIZE() code
that is obviously correct can still be used (just with different things being
counted depending on which channels are being used). The gain in readability
is worth the tiny bit of extra code and data.

>  	indio_dev->info = &rtq6056_info;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
> @@ -640,8 +857,27 @@ static int rtq6056_runtime_resume(struct device *dev)
>  static DEFINE_RUNTIME_DEV_PM_OPS(rtq6056_pm_ops, rtq6056_runtime_suspend,
>  				 rtq6056_runtime_resume, NULL);
>  
> +static const struct richtek_dev_data rtq6056_devdata = {
> +	.dev_id = RICHTEK_DEV_RTQ6056,
> +	.default_conv_time = 1037,
> +	.calib_coefficient = 5120000,
> +	.default_config = RTQ6056_DEFAULT_CONFIG,
> +	.reg_fields = rtq6056_reg_fields,
> +	.channels = rtq6056_channels,
> +};
> +
> +static const struct richtek_dev_data rtq6059_devdata = {
> +	.dev_id = RICHTEK_DEV_RTQ6059,
As mentioned above, this mix of data and a dev_id is not a good design pattern.
It tends to end up as insufficiently flexible as support for more devices is
added to a driver - plus it scatters the device type specific stuff all through
the driver rather than having it all in one place.

> +	.default_conv_time = 532,
> +	.calib_coefficient = 40960000,
> +	.default_config = RTQ6059_DEFAULT_CONFIG,
> +	.reg_fields = rtq6059_reg_fields,
> +	.channels = rtq6059_channels,
> +};
> +
>  static const struct of_device_id rtq6056_device_match[] = {
> -	{ .compatible = "richtek,rtq6056" },
> +	{ .compatible = "richtek,rtq6056", .data = &rtq6056_devdata },
> +	{ .compatible = "richtek,rtq6059", .data = &rtq6059_devdata },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rtq6056_device_match);


