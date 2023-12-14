Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2112812E86
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443887AbjLNL1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:27:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443635AbjLNL1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:27:01 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D7FAA7;
        Thu, 14 Dec 2023 03:27:06 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrVRj55ySz6K6Dg;
        Thu, 14 Dec 2023 19:26:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 21EA01400C8;
        Thu, 14 Dec 2023 19:27:04 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 11:27:03 +0000
Date:   Thu, 14 Dec 2023 11:27:02 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        "Andrea Collamati" <andrea.collamati@gmail.com>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: spi-dac: Add driver for SPI shift register
 DACs
Message-ID: <20231214112702.00003bb8@Huawei.com>
In-Reply-To: <20231213090910.25410-2-mike.looijmans@topic.nl>
References: <20231213090910.25410-1-mike.looijmans@topic.nl>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.23e530d1-f5da-4919-8889-d7109d21097b@emailsignatures365.codetwo.com>
        <20231213090910.25410-2-mike.looijmans@topic.nl>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2023 10:09:10 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Add a driver for generic serial shift register DACs like TI DAC714.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 

Hi Mike,

In general looks good but I think we are going to have enough device specific stuff
here that we will want a compatible match.  Trying to push all the info to
DT is going to get messy fast.  Just take scaling.  There are all sorts of fun
things out there such as only use 3/4 of the reference voltage.

Various comments inline.

Jonathan

> new file mode 100644
> index 000000000000..0c0113d51604
> --- /dev/null
> +++ b/drivers/iio/dac/spi-dac.c
> @@ -0,0 +1,212 @@


> +
> +static int spidac_cmd_single(struct spidac *priv,
> +			     const struct iio_chan_spec *chan, int val)
> +{
> +	u8 *data = priv->data + chan->address;
> +	unsigned int bytes = chan->scan_type.storagebits >> 3;
> +	int ret;
> +	unsigned int i;
> +
> +	/* Write big-endian value into data */
> +	data += bytes - 1;
> +	for (i = 0; i < bytes; i++, val >>= 8, data--)
> +		*data = val & 0xff;
> +
> +	ret = spi_write(priv->spi, priv->data, priv->data_size);
> +	if (ret)
> +		return ret;
> +
> +	gpiod_set_value(priv->loaddacs, 1);
> +	udelay(1);

Delay needs to come from somewhere.  Some devices will need longer.

> +	gpiod_set_value(priv->loaddacs, 0);
> +
> +	return 0;
> +}
> +
> +static int spidac_decode(struct spidac *priv, const struct iio_chan_spec *chan)
> +{
> +	u8 *data = priv->data + chan->address;
> +	unsigned int bytes = chan->scan_type.storagebits >> 3;
> +	unsigned int i;
> +	int val = 0;
> +
> +	/* Read big-endian value from data */

Why assume it's big endian? In theory at least it might not be
so I think this needs specific compatibles to be used.

> +	for (i = 0; i < bytes; i++, data++)
> +		val = (val << 8) | *data;
> +
> +	return val;
> +}
> +
> +static int spidac_read_raw(struct iio_dev *iio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct spidac *priv;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		priv = iio_priv(iio_dev);
> +
> +		mutex_lock(&priv->lock);
> +		*val = spidac_decode(priv, chan);
> +		mutex_unlock(&priv->lock);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = 1;

If it defaults to 0, don't bother providing it. 
The actual scale here needs to come from somewhere - so I'd argue something
is needed in the dt-binding to indicate that it's a reference regulator, or
a fixed value or similar.  May need to use specific compatibles for that as the
scaling relationships can be a bit odd.


> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int spidac_write_raw(struct iio_dev *iio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct spidac *priv = iio_priv(iio_dev);
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_RAW)
> +		return -EINVAL;
> +
> +	mutex_lock(&priv->lock);
> +	ret = spidac_cmd_single(priv, chan, val);
> +	mutex_unlock(&priv->lock);

	guard(mutex)(&priv->lock);
	return spi_dac_cmd_single()...

> +
> +	return ret;
> +}
> +
> +static const struct iio_info spidac_info = {
> +	.read_raw = spidac_read_raw,
> +	.write_raw = spidac_write_raw,
> +};
> +
> +static int spidac_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *iio_dev;
> +	struct spidac *priv;
> +	struct iio_chan_spec *channels;
> +	struct gpio_desc *reset_gpio;
> +	u32 num_channels;
> +	u32 bits_per_channel;
> +	u32 bytes_per_channel;
> +	u32 i;
> +
> +	iio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*priv));
> +	if (!iio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(iio_dev);
> +	priv->loaddacs = devm_gpiod_get_optional(&spi->dev, "ldac",
> +						 GPIOD_OUT_LOW);
> +	if (IS_ERR(priv->loaddacs))
> +		return PTR_ERR(priv->loaddacs);

Use return dev_err_probe() for these as we want the debug info that
stores for deferred probing cases.

> +
> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset",
> +					     GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return PTR_ERR(reset_gpio);
Same here.

> +
> +	priv->spi = spi;
> +	spi_set_drvdata(spi, iio_dev);
> +	num_channels = 1;
> +	bits_per_channel = 16;
> +
> +	device_property_read_u32(&spi->dev, "num-channels", &num_channels);
> +	device_property_read_u32(&spi->dev, "bits-per-channel",
> +				 &bits_per_channel);
> +	bytes_per_channel = DIV_ROUND_UP(bits_per_channel, 8);
> +
> +	channels = devm_kcalloc(&spi->dev, num_channels, sizeof(*channels),
> +				GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	priv->data_size = num_channels * bytes_per_channel;
> +	priv->data = devm_kzalloc(&spi->dev, priv->data_size,
> +				  GFP_KERNEL | GFP_DMA);

As pointed out by Nuno, don't use GFP_DMA - its a historical artifact.

> +	if (!priv->data)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < num_channels; i++) {
> +		struct iio_chan_spec *chan = &channels[i];
> +
> +		chan->type = IIO_VOLTAGE;
> +		chan->indexed = 1;
> +		chan->output = 1;
> +		chan->channel = i;
> +		chan->address = i * bytes_per_channel;
> +		chan->info_mask_separate = BIT(IIO_CHAN_INFO_RAW);
> +		chan->info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SCALE);
> +		chan->scan_type.sign = 's';

You aren't using it yet, so don't set it but we'd need information on this being a bipolar
channel to set this as s.  Otherwise normal unipolar ADCs are going to be interpreted as
negative by standard tooling.

> +		chan->scan_type.realbits = bits_per_channel;
> +		chan->scan_type.storagebits = bits_per_channel;

Nuno observed this one.  Fine to have realbits reflect the actual bits per channel
but storagebits is both only relevant if doing buffered storage and must be power of 2 (>= 8)

> +	}
> +
> +	iio_dev->info = &spidac_info;
> +	iio_dev->modes = INDIO_DIRECT_MODE;
> +	iio_dev->channels = channels;
> +	iio_dev->num_channels = num_channels;
> +	iio_dev->name = spi_get_device_id(spi)->name;

This is unfortunately possibly flaky when fallback compatibles get used.
I'd just hard code it for now.

> +
> +	mutex_init(&priv->lock);
> +
> +	if (reset_gpio) {
> +		udelay(1);
> +		gpiod_set_value(reset_gpio, 0);
> +	}
> +
> +	return devm_iio_device_register(&spi->dev, iio_dev);
> +}
> +
> +static const struct spi_device_id spidac_id[] = {
> +	{"spi-dac"},

Nuno pointed out why you need dac714 here.

> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, spidac_id);
> +
> +static const struct of_device_id spidac_of_match[] = {
> +	{ .compatible = "spi-dac" },
> +	{ .compatible = "ti,dac714" },
> +	{ },

No comma on terminating entries. Also, consistent spacing for {}

> +};
> +MODULE_DEVICE_TABLE(of, spidac_of_match);
> +
> +static struct spi_driver spidac_driver = {
> +	.driver = {
> +		   .name = "spi-dac",
> +		   .of_match_table = spidac_of_match,
> +		   },
Align closing brackets as 
	},

> +	.probe = spidac_probe,
> +	.id_table = spidac_id,
> +};
> +module_spi_driver(spidac_driver);
> +
> +MODULE_AUTHOR("Mike Looijmans <mike.looijmans@topic.nl>");
> +MODULE_DESCRIPTION("SPI shift register DAC driver");
> +MODULE_LICENSE("GPL");

