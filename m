Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3D67B40D8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234264AbjI3OX3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjI3OX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:23:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02A3C5;
        Sat, 30 Sep 2023 07:23:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3565CC433C8;
        Sat, 30 Sep 2023 14:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696083804;
        bh=c755zVlWXxQovsxHLo0qYqvK1xDXA/WABDKjLlXgABc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kSSwq4ODa4PedjG5oPwH8oG5biSLYLe/edSU/N6jW0WHSyfAK/+0BxpjERaFpihA9
         TkiMLNYLBC1rD+DDf2Xd/JgFX8SnxlAHu77LYz06/px+aNf31hVuvRaZDgQYDN/Rs+
         CwzGFp1HHvExleStybJ4aCHGle4CrzWyJErNXbkU4KsK3EqJbOhxPNlmxf8UVnn4Ls
         GxFk6afMg3kvppJqLS6rHD8y6uI7r1L/sKdwXwTY7YmrxtTx5ipIvGelnWiDMOvjkG
         A+uHJ4PZWQzWf7FrHrHoNZqDKFViZf6L28VbY1t+POi/EH3nXFajfPrhLpJmJ+DSR6
         u+RbO75q6EnRA==
Date:   Sat, 30 Sep 2023 15:23:24 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: Add driver support for MAX34408/9
Message-ID: <20230930152324.33e6e199@jic23-huawei>
In-Reply-To: <20230929200844.23316-3-fr0st61te@gmail.com>
References: <20230929200844.23316-1-fr0st61te@gmail.com>
        <20230929200844.23316-3-fr0st61te@gmail.com>
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

On Fri, 29 Sep 2023 23:08:44 +0300
Ivan Mikhaylov <fr0st61te@gmail.com> wrote:

> The MAX34408/MAX34409 are two- and four-channel current monitors that are
> configured and monitored with a standard I2C/SMBus serial interface. Each
> unidirectional current sensor offers precision high-side operation with a
> low full-scale sense voltage. The devices automatically sequence through
> two or four channels and collect the current-sense samples and average them
> to reduce the effect of impulse noise. The raw ADC samples are compared to
> user-programmable digital thresholds to indicate overcurrent conditions.
> Overcurrent conditions trigger a hardware output to provide an immediate
> indication to shut down any necessary external circuitry.
> 
> Add as ADC driver which only supports current monitoring for now.
> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> 
> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>

Hi Ivan,

Various small comments inline. Mostly simplifications to the code.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
> new file mode 100644
> index 000000000000..f576c65e3900
> --- /dev/null
> +++ b/drivers/iio/adc/max34408.c
> @@ -0,0 +1,334 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Maxim MAX34409/34408 ADC, 4-Channels/2-Channels, 8bits, I2C
> + *
> + * Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> + *
> + * TODO: ALERT interrupt, Overcurrent delay, Shutdown delay
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_device.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define MAX34408_STATUS_REG		0x0
> +#define MAX34408_CONTROL_REG		0x1
> +#define MAX34408_OCDELAY_REG		0x2
> +#define MAX34408_SDDELAY_REG		0x3
> +
> +#define MAX34408_ADC1_REG		0x4
> +#define MAX34408_ADC2_REG		0x5
> +/* ADC3 & ADC4 always returns 0x0 on 34408 */
> +#define MAX34409_ADC3_REG		0x6
> +#define MAX34409_ADC4_REG		0x7
> +
> +#define MAX34408_OCT1_REG		0x8
> +#define MAX34408_OCT2_REG		0x9
> +#define MAX34408_OCT3_REG		0xA
> +#define MAX34408_OCT4_REG		0xB
> +
> +#define MAX34408_DID_REG		0xC
> +#define MAX34408_DCYY_REG		0xD
> +#define MAX34408_DCWW_REG		0xE
> +
> +/* Bit masks for status register */
> +#define MAX34408_STATUS_OC_MSK		GENMASK(1, 0)
> +#define MAX34409_STATUS_OC_MSK		GENMASK(3, 0)
> +#define MAX34408_STATUS_SHTDN		BIT(4)
> +#define MAX34408_STATUS_ENA		BIT(5)
> +
> +/* Bit masks for control register */
> +#define MAX34408_CONTROL_AVG0		BIT(0)
> +#define MAX34408_CONTROL_AVG1		BIT(1)
> +#define MAX34408_CONTROL_AVG2		BIT(2)
> +#define MAX34408_CONTROL_ALERT		BIT(3)
> +
> +/* Bit masks for over current delay */
> +#define MAX34408_OCDELAY_OCD_MSK	GENMASK(6, 0)
> +#define MAX34408_OCDELAY_RESET		BIT(7)
> +
> +/* Bit masks for shutdown delay */
> +#define MAX34408_SDDELAY_SHD_MSK	GENMASK(6, 0)
> +#define MAX34408_SDDELAY_RESET		BIT(7)
> +
> +#define MAX34408_DEFAULT_RSENSE		1000
> +
> +/**
> + * struct max34408_data - max34408/max34409 specific data.
> + * @regmap:	device register map.
> + * @dev:	max34408 device.
> + * @lock:	lock for protecting access to device hardware registers, mostly
> + *		for read modify write cycles for control registers.
> + * @rsense:	Rsense value in uOhm.

Bot complained about this doc being out of date.
As mentioned below, an array seems more appropriate to me than 4
separate struct elements.

> + */
> +struct max34408_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	u32 input1_rsense;
> +	u32 input2_rsense;
> +	u32 input3_rsense;
> +	u32 input4_rsense;
> +};
> +
> +static const struct regmap_config max34408_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= MAX34408_DCWW_REG,
> +};
> +
> +struct max34408_adc_model_data {
> +	const char *model_name;
> +	const struct iio_chan_spec *channels;
> +	const int num_channels;
> +};
> +
> +#define MAX34008_CHANNEL(_index)					\
> +	{								\
> +		.type = IIO_CURRENT,					\
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |	\

I'd drop the tab and not force that indent.  A space is enough and consistent
with other elements.

> +					  BIT(IIO_CHAN_INFO_SCALE) |	\
> +					  BIT(IIO_CHAN_INFO_OFFSET),	\
> +		.channel = (_index),					\
> +		.indexed = 1,						\
> +	}
> +
> +static const struct iio_chan_spec max34408_channels[] = {
> +	MAX34008_CHANNEL(0),
> +	MAX34008_CHANNEL(1),
> +};
> +
> +static const struct iio_chan_spec max34409_channels[] = {
> +	MAX34008_CHANNEL(0),
> +	MAX34008_CHANNEL(1),
> +	MAX34008_CHANNEL(2),
> +	MAX34008_CHANNEL(3),
> +};
> +
> +static int max34408_read_adc(struct max34408_data *max34408, int channel,
> +			     int *val)
> +{
> +	u32 adc_reg;
> +
> +	switch (channel) {
> +	case 0:
> +		adc_reg = MAX34408_ADC1_REG;
Channels have an .address field for this purpose.
I would put this in there then this just becomes

	return regmap_read(max34408->regmap, chan->address, val);

with no need for the switch statement.


> +		break;
> +	case 1:
> +		adc_reg = MAX34408_ADC2_REG;
> +		break;
> +	case 2:
> +		adc_reg = MAX34409_ADC3_REG;
> +		break;
> +	case 3:
> +		adc_reg = MAX34409_ADC4_REG;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return regmap_read(max34408->regmap, adc_reg, val);
> +}
> +
> +static int max34408_read_adc_avg(struct max34408_data *max34408, int channel, int *val)
> +{
> +	unsigned int ctrl;
> +	int rc;
> +	u8 tmp;
> +
> +	guard(mutex)(&max34408->lock);
> +	rc = regmap_read(max34408->regmap, MAX34408_CONTROL_REG, (u32 *)&ctrl);
> +	if (rc)
> +		return rc;
> +
> +	/* set averaging (0b100) default values*/
> +	tmp = ctrl;
> +	ctrl |= MAX34408_CONTROL_AVG2;
> +	ctrl &= ~MAX34408_CONTROL_AVG1;
> +	ctrl &= ~MAX34408_CONTROL_AVG0;
It's a 3 bit field. Define a single mask for the field and then either
as set of defines for the values, or (if my maths is write)

#define	MAX34408_CONTROL_AVG_FIELD_TO_SAMPLES(x)	(1 << x)
#define MAX34408_CONTROL_AVG_SAMPLES_TO_FIELD(x)  ffs(x)

to go backwards and forwards from the encoded value which is just powers of 2

> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, ctrl);
> +	if (rc) {
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +		return rc;
> +	}
> +
> +	rc = max34408_read_adc(max34408, channel, val);
> +	if (rc)
> +		return rc;
> +
> +	/* back to old values */
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL_REG, tmp);
> +	if (rc)
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +
> +	return rc;
> +}
> +
> +static int max34408_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34408_data *max34408 = iio_priv(indio_dev);
> +	int input_rsense;
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		rc = max34408_read_adc_avg(max34408, chan->channel,
> +					   val);
Fits on one line under 80 chars.  Check for other cases and tidy
those up as well.

> +		if (rc)
> +			return rc;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * calcluate current for 8bit ADC with Rsense
> +		 * value.
> +		 * 10 mV * 1000 / Rsense uOhm = max current
> +		 * (max current * adc val * 1000) / (2^8 - 1) mA
> +		 */
> +		switch (chan->channel) {
> +		case 0:
> +			input_rsense = max34408->input1_rsense;
Array?
Then this becomes
		input_rsense = max34408->input_rsense[chan->channel];

or skip the local variable and use it directly

		*val = 10000 / max34408->input_rsense[chan->chanel];
		*val2 = 8;
		return IIO_VAL_FRACTION_LOG2;

> +			break;
> +		case 1:
> +			input_rsense = max34408->input2_rsense;
> +			break;
> +		case 2:
> +			input_rsense = max34408->input3_rsense;
> +			break;
> +		case 3:
> +			input_rsense = max34408->input4_rsense;
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		*val = 10000 / input_rsense;
> +		*val2 = 8;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		*val = 0;

When the offset is 0, there is no in exposing that interface.
0 is the default if the file isn't there in sysfs.

> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max34408_info = {
> +	.read_raw	= max34408_read_raw,
> +};

...

> +static int max34408_probe(struct i2c_client *client)
> +{
> +	const struct max34408_adc_model_data *model_data;
> +	const struct of_device_id *match;
> +	struct max34408_data *max34408;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	match = of_match_device(max34408_of_match, &client->dev);
> +	if (!match)
> +		return -EINVAL;
> +	model_data = match->data;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err_probe(&client->dev, PTR_ERR(regmap),
> +			      "regmap_init failed\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max34408));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	max34408 = iio_priv(indio_dev);
> +	max34408->regmap = regmap;
> +	max34408->dev = &client->dev;
> +	mutex_init(&max34408->lock);
> +
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,input1-rsense-val-micro-ohms",
> +				      &max34408->input1_rsense);
> +	if (rc)
> +		max34408->input1_rsense = MAX34408_DEFAULT_RSENSE;
> +
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,input2-rsense-val-micro-ohms",
> +				      &max34408->input2_rsense);
> +	if (rc)
> +		max34408->input2_rsense = MAX34408_DEFAULT_RSENSE;
> +
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,input3-rsense-val-micro-ohms",
> +				      &max34408->input3_rsense);
> +	if (rc)
> +		max34408->input3_rsense = MAX34408_DEFAULT_RSENSE;
> +
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,input4-rsense-val-micro-ohms",
> +				      &max34408->input4_rsense);
> +	if (rc)
> +		max34408->input4_rsense = MAX34408_DEFAULT_RSENSE;
> +
So, device_property_read_u32() is guaranteed to have no side effects on the
value being set if there is an error. Hence normal way of doing defaults
for optional parameters is the simpler.

	max34408->input4_rsense = MAX34408_DEFAULT_RENSE;
	device_property_read_u32(dev, "....", &max34408->input4_rsense);

So deliberately don't check the return value.

Not I would also suggest introducing a
struct device *dev = &client->dev; local variable as you use &client->dev
a lot.

Jonathan



