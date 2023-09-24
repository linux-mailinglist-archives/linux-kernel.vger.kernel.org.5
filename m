Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0BA7AC928
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjIXN0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 09:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjIXNZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 09:25:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 549BD86AC;
        Sun, 24 Sep 2023 06:22:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F35EEC433C9;
        Sun, 24 Sep 2023 13:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695561737;
        bh=dlIkxCF0su0HUk7/Tf26X47cFTYHytesee0bpklpzAM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vi6lLzosEFWZcbI1zTRohpBEPvljk+ilCXbI+FUjMzuBEK52poqNbvziGCaiMRrWX
         Spy/+jTrL/bwYbg8xBRmmESIicudW7+XgA/Cvv4/r42db5Y2MSwZ3xzEX5LSZ5/kt/
         XbyQDz97UrPRhG2brGmyb6S9FY7j0BqwzzlaYSavYwuY5rmkpy4I/gPEVJKSVLJ8XJ
         rerTz1/mUM+nh9GpyC0QCx8AFihN53IGoal/2c6k32KLkiScUGPVciTWFcabHQTHhw
         lV/SCp2mTvwMblUey+hXcORONXE9+iSTRe0VNgaVKf0MJXxSs1+cwz1w6GVl5hNoRn
         86tGO13LEwEnQ==
Date:   Sun, 24 Sep 2023 14:22:09 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ivan Mikhaylov <fr0st61te@gmail.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: Add driver support for MAX34408/9
Message-ID: <20230924142209.5e688c7f@jic23-huawei>
In-Reply-To: <20230917211143.7094-3-fr0st61te@gmail.com>
References: <20230917211143.7094-1-fr0st61te@gmail.com>
        <20230917211143.7094-3-fr0st61te@gmail.com>
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

On Mon, 18 Sep 2023 00:11:43 +0300
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

Hi Ivan. 

A few additional comments from me to add to what Lars said.
Generally looking nice.

Jonathan

> 
> Link: https://www.analog.com/media/en/technical-documentation/data-sheets/MAX34408-MAX34409.pdf
> 
Link is part of the tags block, so no blank line here (tools can then handle it as
a tag rather than freeform text.

> Signed-off-by: Ivan Mikhaylov <fr0st61te@gmail.com>

> ---
>  drivers/iio/adc/Kconfig    |  11 ++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max34408.c | 334 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 346 insertions(+)
>  create mode 100644 drivers/iio/adc/max34408.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 517b3db114b8..538b086ed593 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -756,6 +756,17 @@ config MAX9611
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max9611.
>  
> +config MAX34408
> +	tristate "Maxim max34408/max344089 ADC driver"
> +	depends on I2C
> +	help
> +	  Say yes here to build support for Maxim max34408/max34409 current sense
> +	  monitor with 8-bits ADC interface with overcurrent delay/threshold and
> +	  shutdown delay.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max34408.
> +
>  config MCP320X
>  	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
>  	depends on SPI
> diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
> index 2facf979327d..8fee08546bcc 100644
> --- a/drivers/iio/adc/Makefile
> +++ b/drivers/iio/adc/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_MAX1241) += max1241.o
>  obj-$(CONFIG_MAX1363) += max1363.o
>  obj-$(CONFIG_MAX77541_ADC) += max77541-adc.o
>  obj-$(CONFIG_MAX9611) += max9611.o
> +obj-$(CONFIG_MAX34408) += max34408.o

Hmm. For consistency should be after max1363 I think. We've
gone with alphanumeric order so far rather than taking digits into account
so we should keep to that.

That also means moving it up in the Kconfig file.

I've not checked we've been consistent beyond the names I can see here though.

>  obj-$(CONFIG_MCP320X) += mcp320x.o
>  obj-$(CONFIG_MCP3422) += mcp3422.o
>  obj-$(CONFIG_MCP3911) += mcp3911.o
> diff --git a/drivers/iio/adc/max34408.c b/drivers/iio/adc/max34408.c
> new file mode 100644
> index 000000000000..96c1de59edb5
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
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>
> +
> +#define MAX34408_STATUS		0x0
Useful to give clear naming separation between regisers
and fields.   I'd stick _REG on the end.

> +#define MAX34408_CONTROL	0x1
> +#define MAX34408_OCDELAY	0x2
> +#define MAX34408_SDDELAY	0x3
> +
> +#define MAX34408_ADC1		0x4
> +#define MAX34408_ADC2		0x5
> +/* ADC3 & ADC4 always returns 0x0 on 34408 */

Perhaps name them MAX34409_ADC3 to make that clearer at
the point of use.

> +#define MAX34408_ADC3		0x6
> +#define MAX34408_ADC4		0x7
> +
> +#define MAX34408_OCT1		0x8
> +#define MAX34408_OCT2		0x9
> +#define MAX34408_OCT3		0xA
> +#define MAX34408_OCT4		0xB
> +
> +#define MAX34408_DID		0xC
> +#define MAX34408_DCYY		0xD
> +#define MAX34408_DCWW		0xE
> +
> +#define MAX34408_CHANNELS	2
> +#define MAX34409_CHANNELS	4
> +
> +/* Bit masks for status register */
> +#define STATUS_OC1		BIT(0
To avoid potential naming clashes with generic headers
all defines should be prefixed with MA34008_STATUS_OC1

(note this is why I suggest a REG postfix for the register
addreses.

> +#define STATUS_OC2		BIT(1)
> +/* OC3 & OC4 only for max34409 */
Define a mask for each.
#define MAX34008_STATUS_OC_MSK GENMASK(1, 0)
#define MAX34009_STATUS_OC_MSK GENMASK(3, 0)
and the comment isn't needed.

> +#define STATUS_OC3		BIT(2)
> +#define STATUS_OC4		BIT(3)
> +#define STATUS_SHTDN		BIT(4)
> +#define STATUS_ENA		BIT(5)
> +
> +/* Bit masks for control register */
> +#define CONTROL_AVG0		BIT(0)
> +#define CONTROL_AVG1		BIT(1)
> +#define CONTROL_AVG2		BIT(2)
> +#define CONTROL_ALERT		BIT(3)
> +
> +/* Bit masks for over current delay */
> +#define OCDELAY_OCD0		BIT(0)
> +#define OCDELAY_OCD1		BIT(1)
> +#define OCDELAY_OCD2		BIT(2)
> +#define OCDELAY_OCD3		BIT(3)
> +#define OCDELAY_OCD4		BIT(4)
> +#define OCDELAY_OCD5		BIT(5)
> +#define OCDELAY_OCD6		BIT(6)
Looks like a 7 bit field - clear in table 9 where
values are given as 00h to 7fh

#define OCDELAY_OCD_MASK	GENMASK(6, 0

Same for other similar multi bit fields.

> +#define OCDELAY_RESET		BIT(7)
> +
> +/* Bit masks for shutdown delay */
> +#define SDDELAY_SHD0		BIT(0)
> +#define SDDELAY_SHD1		BIT(1)
> +#define SDDELAY_SHD2		BIT(2)
> +#define SDDELAY_SHD3		BIT(3)
> +#define SDDELAY_SHD4		BIT(4)
> +#define SDDELAY_SHD5		BIT(5)
> +#define SDDELAY_SHD6		BIT(6)
> +#define SDDELAY_RESET		BIT(7)
> +
> +/**
> + * struct max34408_data - max34408/max34409 specific data.
> + * @regmap:	device register map.
> + * @dev:	max34408 device.
> + * @lock:	lock for protecting access to device hardware registers.
The locks in the underlying bus driver will do that for us.
Perhaps this is to allow read modify write cycles?
If so, give that extra detail here.

> + * @rsense:	Rsense value in uOhm.
> + */
> +struct max34408_data {
> +	struct regmap *regmap;
> +	struct device *dev;
> +	struct mutex lock;
> +	u32 rsense;
> +};
> +
> +static const struct regmap_config max34408_regmap_config = {
> +	.reg_bits	= 8,
> +	.val_bits	= 8,
> +	.max_register	= MAX34408_DCWW,
> +};
> +
> +static const struct iio_chan_spec max34408_channels[] = {
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 0,
> +		.indexed = 1,
> +	},
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 1,
> +		.indexed = 1,
> +	},
> +};
> +
> +static const struct iio_chan_spec max34409_channels[] = {
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 0,
> +		.indexed = 1,

I think a macro would help here as there is only one parameter.
#define MAX34008_CHANNEL(_index) 		\
	{ 					\
		.type = IIO_CURRENT,		\
		....
		.channel = (_index),		\
		.indexed = 1,
	}



> +	},
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 1,
> +		.indexed = 1,
> +	},
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 2,
> +		.indexed = 1,
> +	},
> +	{
> +		.type			= IIO_CURRENT,
> +		.info_mask_separate	= BIT(IIO_CHAN_INFO_RAW) |
> +					  BIT(IIO_CHAN_INFO_PROCESSED) |
> +					  BIT(IIO_CHAN_INFO_AVERAGE_RAW),
> +		.channel		= 3,
> +		.indexed = 1,
> +	},
> +};
> +
> +static int max34408_read_adc(struct max34408_data *max34408, int channel,
> +			     int *val)
> +{
> +	int rc;
> +	u32 adc_reg;
> +
> +	switch (channel) {
> +	case 0:
> +		adc_reg = MAX34408_ADC1;
> +		break;
> +	case 1:
> +		adc_reg = MAX34408_ADC2;
> +		break;
> +	case 2:
> +		adc_reg = MAX34408_ADC3;
> +		break;
> +	case 3:
> +		adc_reg = MAX34408_ADC4;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	rc = regmap_read(max34408->regmap, adc_reg, val);
return regmap_read();

Is same and saves us a couple of lines.

> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +
> +static int max34408_read_adc_avg(struct max34408_data *max34408, int channel, int *val)
> +{
> +	unsigned long ctrl;
> +	int rc;
> +	u8 tmp;
> +
> +	mutex_lock(&max34408->lock);

Consider the new guard() functionality for this lock.

	guard(mutex)(&max34408->lock); 

That should ensure the mutex is release whatever path you take out of the
function thus allowing you to drop the goto and explicit unlock.

It's new this cycle, so don't think we have any users in IIO yet, but
I'll be encouraging it's use for cases like this where it provides
nice simplifications to the code flow by allowing directly returning
instead of dancing through manual cleanup.


> +	rc = regmap_read(max34408->regmap, MAX34408_CONTROL, (u32 *)&ctrl);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* set averaging (0b100) default values*/
> +	tmp = ctrl;
> +	set_bit(CONTROL_AVG2, &ctrl);
> +	clear_bit(CONTROL_AVG1, &ctrl);
> +	clear_bit(CONTROL_AVG0, &ctrl);
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, ctrl);
> +	if (rc) {
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +		goto err_unlock;
> +	}
> +
> +	rc = max34408_read_adc(max34408, channel, val);
> +	if (rc)
> +		goto err_unlock;
> +
> +	/* back to old values */
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, tmp);
> +	if (rc)
> +		dev_err(max34408->dev,
> +			"Error (%d) writing control register\n", rc);
> +
> +err_unlock:
> +	mutex_unlock(&max34408->lock);
> +
> +	return rc;
> +}
> +
> +static int max34408_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max34408_data *max34408 = iio_priv(indio_dev);
> +	int rc;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		rc = max34408_read_adc_avg(max34408, chan->channel,
> +					   val);
> +		if (rc)
> +			return rc;
> +
> +		if (mask == IIO_CHAN_INFO_PROCESSED) {
> +			/*
> +			 * calcluate current for 8bit ADC with Rsense
> +			 * value.
> +			 * 10 mV * 1000 / Rsense uOhm = max current
> +			 * (max current * adc val * 1000) / (2^8 - 1) mA
> +			 */
> +			*val = DIV_ROUND_CLOSEST((10000 / max34408->rsense) *
> +						 *val * 1000, 256);

What Lars said about not supporting processed when we can expose the channel
nicely as raw and present the scale an offset as needed to let userspace
do this maths (it has floating point so will probably do it better than
we can easily do in kernel).

> +		}
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_RAW:
> +		rc = max34408_read_adc(max34408, chan->channel, val);
> +		if (rc)
> +			return rc;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info max34408_info = {
> +	.read_raw	= max34408_read_raw,
> +};
> +
> +static int max34408_probe(struct i2c_client *client)
> +{
> +	struct device_node *np = client->dev.of_node;
> +	struct max34408_data *max34408;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int rc;
> +
> +	regmap = devm_regmap_init_i2c(client, &max34408_regmap_config);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "regmap_init failed\n");
> +		return PTR_ERR(regmap);
> +	}
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*max34408));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	max34408 = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

I don't see this being used. If it is not don't set it.

> +	max34408->regmap = regmap;
> +	max34408->dev = &client->dev;
> +	mutex_init(&max34408->lock);
> +	rc = device_property_read_u32(&client->dev,
> +				      "maxim,rsense-val-micro-ohms",
> +				      &max34408->rsense);

As I mentioned in the review of the binding, I can't see why these
will necessarily be the same for all channels.

> +	if (rc)
> +		return -EINVAL;
> +
> +	/* disable ALERT and averaging */
> +	rc = regmap_write(max34408->regmap, MAX34408_CONTROL, 0x0);
> +	if (rc)
> +		return rc;
> +
> +	if (of_device_is_compatible(np, "maxim,max34408")) {
> +		indio_dev->channels = max34408_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(max34408_channels);
> +		indio_dev->name = "max34408";
> +	} else if (of_device_is_compatible(np, "maxim,max34409")) {
> +		indio_dev->channels = max34409_channels;
> +		indio_dev->num_channels = ARRAY_SIZE(max34409_channels);
> +		indio_dev->name = "max34409";

Lars mentioned this already. Much prefer chip specific data to be
data, not code.  So this wants to go in a chip type specific structure that
is static const.  In general that scales much better as we get more variants
supported by a driver over time + as Lars mentioned works with other firmware
types. Not sure it applies elsewhere (I'm reviewing driver in reverse) but
in general use the generic firmware accessors in linux/property.h not the
of specific ones.  We are slowly moving almost all IIO drivers over to that
generic firmware approach, but it's take a while so you'll still find plenty
of examples that are using of specific calls.

> +	}
> +	indio_dev->info = &max34408_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->dev.of_node = np;

That should be set by the IIO core (though it does it in a more general fashion than this).

https://elixir.bootlin.com/linux/latest/source/drivers/iio/industrialio-core.c#L1905
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}

