Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC1C7F8BF2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232196AbjKYPLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 10:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232017AbjKYPLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 10:11:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A54F2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 07:11:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34DEC433C8;
        Sat, 25 Nov 2023 15:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700925085;
        bh=NZGKnbCqKEbmlzx2mxvmAGTdTSF3UibDriYC6WTduvs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OaiY8DKy9oZV1/6oSA5oQ2kitTPNckTpdefmRwbeJrkqkT2c1+99NYCOG2CC2CJrf
         nnaAHGaXBOAO1Sx7SOcOzPlTemSX1ATYYt1+KdHD7NEMugd0DMNlh3s+uD4pmN2+vV
         yMQA10Ip1C0OH1umL6O1/0PM6iY4K4v/0IUEZ5SOM/Q4fNMkfHUA9GcCyi2AGww5Ji
         FGCOs1leb3t+jCXE0QQt0OYDLw90zt4+Jtfw7zuWjKLSMawD+wJmfy534/uKgg/Xf2
         uHfqXecpxkGQs+5fWzRuaVn4XuIk0yeoNLSpaEU1EoJiDd9VzDyRreoURnSXllVLCw
         mOvFWMYlHNYQw==
Date:   Sat, 25 Nov 2023 15:11:16 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: light: add VEML6075 UVA and UVB light
 sensor driver
Message-ID: <20231125151116.6d9b6e46@jic23-huawei>
In-Reply-To: <20231110-veml6075-v2-3-d04efbc8bf51@gmail.com>
References: <20231110-veml6075-v2-0-d04efbc8bf51@gmail.com>
        <20231110-veml6075-v2-3-d04efbc8bf51@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Nov 2023 12:56:57 +0100
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The Vishay VEMl6075 is a low power, 16-bit resolution UVA and UVB
> light sensor with I2C interface and noise compensation (visible and
> infrarred).
> 
> Every UV channel generates an output signal measured in counts per
> integration period, where the integration time is configurable.
> 
> This driver adds support for both UV channels and the ultraviolet
> index (UVI) inferred from them according to the device application note
> with open-air (no teflon) coefficients.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Hi Javier,

A few more minor things. Looks good in general.

Jonathan

> diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> new file mode 100644
> index 000000000000..a33488884076
> --- /dev/null
> +++ b/drivers/iio/light/veml6075.c
> @@ -0,0 +1,486 @@
...


> +struct veml6075_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +	struct mutex lock; /* integration time/measurement trigger lock */

Could perhaps be clearer. Maybe something like
	/* Prevent integration time changing during a measurement */

> +};

> +
> +static int veml6075_shutdown(struct veml6075_data *data)

Only used in one place. Maybe just do the regmap bit directly there?

> +{
> +	return regmap_update_bits(data->regmap, VEML6075_CMD_CONF,
> +				  VEML6075_CONF_SD, VEML6075_CONF_SD);
> +}

> +
> +static int veml6075_uva_comp(int raw_uva, int comp1, int comp2)
> +{
> +	int comp1a_c, comp2a_c, uva_comp;
> +
> +	comp1a_c = (comp1 * VEML6075_A_COEF) / 1000U;
> +	comp2a_c = (comp2 * VEML6075_B_COEF) / 1000U;
> +	uva_comp = raw_uva - comp1a_c - comp2a_c;
> +
> +	return clamp_val(uva_comp, 0, U16_MAX);
> +}
> +
> +static int veml6075_uvb_comp(int raw_uvb, int comp1, int comp2)
> +{
> +	int comp1b_c, comp2b_c, uvb_comp;
> +
> +	comp1b_c = (comp1 * VEML6075_C_COEF) / 1000U;

Any of units.h appropriate here?  I'm not sure if the / 1000U is a units
thing or not.

> +	comp2b_c = (comp2 * VEML6075_D_COEF) / 1000U;
> +	uvb_comp = raw_uvb - comp1b_c - comp2b_c;
> +
> +	return clamp_val(uvb_comp, 0, U16_MAX);
> +}

> +
> +static int veml6075_read_uvi(struct veml6075_data *data, int *val, int *val2)
> +{
> +	int ret, c1, c2, uva, uvb, uvi_micro;
> +
> +	guard(mutex)(&data->lock);
> +
> +	ret = veml6075_request_measurement(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = veml6075_read_comp(data, &c1, &c2);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VEML6075_CMD_UVA, &uva);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, VEML6075_CMD_UVB, &uvb);
> +	if (ret < 0)
> +		return ret;
> +
> +	uvi_micro = veml6075_get_uvi_micro(data, veml6075_uva_comp(uva, c1, c2),
> +					   veml6075_uvb_comp(uvb, c1, c2));
> +	if (uvi_micro < 0)
> +		return uvi_micro;
> +
> +	*val = uvi_micro / 1000000LL;

MICRO for divisor.
https://elixir.bootlin.com/linux/latest/source/include/linux/units.h#L18


> +	*val2 = uvi_micro % 1000000LL;
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}

...

> +static int veml6075_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct veml6075_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = veml6075_read_uv_direct(data, chan->channel, val);
> +		break;
> +	case IIO_CHAN_INFO_PROCESSED:
> +		ret = veml6075_read_uvi(data, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = veml6075_read_int_time_ms(data, val);
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		return veml6075_read_responsivity(chan->channel, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
return in remaining case statements above.  No point in break unless
there is shared stuff to do after the switch.
> +}
> +
> +static int veml6075_write_int_time_ms(struct veml6075_data *data, int val)
> +{
> +	int i = ARRAY_SIZE(veml6075_it_ms);
> +
> +	guard(mutex)(&data->lock);
> +
> +	while (i-- > 0) {
> +		if (val == veml6075_it_ms[i])
> +			break;
> +	}
> +	if (i < 0)
> +		return -EINVAL;
> +
> +	return regmap_update_bits(data->regmap, VEML6075_CMD_CONF,
> +				  VEML6075_CONF_IT,
> +				  FIELD_PREP(VEML6075_CONF_IT, i));
> +}
> +
> +static int veml6075_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct veml6075_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_INT_TIME:
> +		ret = veml6075_write_int_time_ms(data, val);
		return here.
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret;
return above and safe a few lines + local variable ret.

> +}
> +
> +static const struct iio_info veml6075_info = {
> +	.read_avail = veml6075_read_avail,
> +	.read_raw = veml6075_read_raw,
> +	.write_raw = veml6075_write_raw,
> +};

...

> +static const struct regmap_config veml6075_regmap_config = {
> +	.name = "veml6075",
> +	.reg_bits = 8,
> +	.val_bits = 16,
> +	.max_register = VEML6075_CMD_ID,
> +	.readable_reg = veml6075_readable_reg,
> +	.writeable_reg = veml6075_writable_reg,
> +	.val_format_endian = REGMAP_ENDIAN_LITTLE,
> +
stray blank line here that should go.
> +};
> +
> +static int veml6075_probe(struct i2c_client *client)
> +{
> +	struct veml6075_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int config, ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6075_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

why? Doesn't look like you get it back anywhere in the driver.


> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	mutex_init(&data->lock);
> +
> +	indio_dev->name = "veml6075";
> +	indio_dev->info = &veml6075_info;
> +	indio_dev->channels = veml6075_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6075_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> +	if (ret < 0 && ret != -ENODEV)

I'm lost here.  devm_regulator_get_enable() shouldn't return -ENODEV
unless you have specified that an incomplete set of regs are provided.
If you've specified that you should provide a fixed reg.
https://elixir.bootlin.com/linux/latest/source/drivers/regulator/core.c#L2194
The paths to not having that provided shouldn't effect normal use (IIRC).

So I'd not expect special handling for -ENODEV.
That would be appropriate if you were using the optional variant, but
this regulator isn't optional (we might just not have described it!)


> +		return ret;
> +
> +	/* default: 100ms integration time, active force enable, shutdown */
> +	config = FIELD_PREP(VEML6075_CONF_IT, VEML6075_IT_100_MS) |
> +		FIELD_PREP(VEML6075_CONF_AF, VEML6075_AF_ENABLE) |
> +		FIELD_PREP(VEML6075_CONF_SD, VEML6075_SD_ENABLE);
> +	ret = regmap_write(data->regmap, VEML6075_CMD_CONF, config);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

