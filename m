Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB7F580BB82
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 15:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjLJOCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 09:02:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjLJOCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 09:02:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4283F1
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 06:02:41 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FB33C433C7;
        Sun, 10 Dec 2023 14:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702216961;
        bh=pLAIYZPXpRTMWD9790Kvx5fP2Dcl4IA+htrd+/ZzJbU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Fvr1quLaRvg6K2X3qJlgkDrHYKnsKjY8fg9g/4eI6/g6d5loLnzofvDm+Ddortt5v
         VBcX12ZmeRqEHPDKIJyuNoNEeBTLvspJATpLoXva+21elG9rJdtd7dEQ7Mo3QLP++t
         /L2Qpc/RZQ04mMVdBjuq7NTBZnDzvh62G7gSoml5g9kXgXZ2LOXYOGwqhbRZhq6Hsq
         dIJP/lo6ZcCcrmOHfTyk0CN4CLdNLqEii+aFOjYywtabnqg9D66vdC5Yvc+JsKIiy/
         7jMKT50upU/J/fYik3CTv6SFQEDrmM2YRThVvHHFK4GbYX+cI3bvOv+7zU0UlCoBxc
         vBx+3EQJrSSdA==
Date:   Sun, 10 Dec 2023 14:02:35 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        Stefan Popa <stefan.popa@analog.com>
Subject: Re: [PATCH 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
Message-ID: <20231210140235.43d2c6ea@jic23-huawei>
In-Reply-To: <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
References: <20231208-ad7380-mainline-v1-0-2b33fe2f44ae@baylibre.com>
        <20231208-ad7380-mainline-v1-2-2b33fe2f44ae@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
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

On Fri,  8 Dec 2023 09:51:41 -0600
David Lechner <dlechner@baylibre.com> wrote:

> This adds a new driver for the AD7380 family ADCs.
> 
> The driver currently implements basic support for the AD7380, AD7381,
> AD7383, and AD7384 2-channel differential ADCs. Support for additional
> single-ended and 4-channel chips that use the same register map as well
> as additional features of the chip will be added in future patches.
> 
> Co-developed-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Hi David / Stefan,

A few minor things inline.  Other than that question following through
from the bindings about 1-wire / 2-wire description it's all trivial
and some might be considered my odd tastes :)
Nice to see such a clean v1

Jonathan


> diff --git a/drivers/iio/adc/ad7380.c b/drivers/iio/adc/ad7380.c
> new file mode 100644
> index 000000000000..6a5ec59bd1fd
> --- /dev/null
> +++ b/drivers/iio/adc/ad7380.c

> +struct ad7380_state {
> +	const struct ad7380_chip_info *chip_info;
> +	struct spi_device *spi;
> +	struct regulator *vref;
> +	struct regmap *regmap;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the
> +	 * transfer buffers to live in their own cache lines.
> +	 * Make the buffer large enough for 2 16-bit samples and one 64-bit
> +	 * aligned 64 bit timestamp.
> +	 */
> +	struct {
> +		u16 raw[2];
> +		s64 ts __aligned(8);
> +	} scan_data __aligned(IIO_DMA_MINALIGN);
> +	u16 tx[2];
> +	u16 rx[2];
> +};

...



> +static irqreturn_t ad7380_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad7380_state *st = iio_priv(indio_dev);
> +	struct spi_transfer xfer = {
> +		.bits_per_word = st->chip_info->channels[0].scan_type.realbits,
> +		.len = 4,
> +		.rx_buf = &st->scan_data,
I'd make it explicit you are reading into st->scan_data->raw rather than using
the address of the containing structure. 

> +	};
> +	int ret;
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +
> +	if (ret == 0)
I'm not keen on this pattern. It saves a bit of text but makes things slightly less
obvious when compared to all the other error paths.

	if (ret)
		goto error;

	iio_push_to_buffers...

error:
	iio_trigger_notify_done...

Is my preference.
> +		iio_push_to_buffers_with_timestamp(indio_dev, &st->scan_data,
> +						   pf->timestamp);
> +
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int ad7380_read_direct(struct ad7380_state *st,
> +			      struct iio_chan_spec const *chan, int *val)
> +{
> +	struct spi_transfer xfers[] = {
> +		/* toggle CS (no data xfer) to trigger a conversion */
> +		{
> +			.speed_hz = AD7380_REG_WR_SPEED_HZ,
> +			.bits_per_word = chan->scan_type.realbits,
> +			.delay = {
> +				.value = 190, /* t[CONVERT] */
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +			.cs_change = 1,
> +			.cs_change_delay = {
> +				.value = 10, /* t[CSH] */
> +				.unit = SPI_DELAY_UNIT_NSECS,
> +			},
> +		},
> +		/* then read both channels */
> +		{
> +			.speed_hz = AD7380_REG_WR_SPEED_HZ,
> +			.bits_per_word = chan->scan_type.realbits,
> +			.rx_buf = &st->rx[0],
> +			.len = 4,
> +		},
> +	};
> +	int ret;
> +
> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +

Trivial, but no blank line here. It's good to keep error check and
the call in the same block.

> +	if (ret < 0)
> +		return ret;
> +
> +	*val = sign_extend32(st->rx[chan->scan_index],
> +			     chan->scan_type.realbits - 1);
> +
> +	return IIO_VAL_INT;
> +}
> +

...

> +
> +static int ad7380_init(struct ad7380_state *st)
> +{
> +	int ret;
> +
> +	/* perform hard reset */
> +	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +				 AD7380_CONFIG2_RESET,
> +				 FIELD_PREP(AD7380_CONFIG2_RESET,
> +					    AD7380_CONFIG2_RESET_HARD));
> +	if (ret < 0)
> +		return ret;
> +
> +
Trivial: Single blank line

> +	/* select internal or external reference voltage */
> +	ret = regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG1,
> +				 AD7380_CONFIG1_REFSEL,
> +				 FIELD_PREP(AD7380_CONFIG1_REFSEL, !!st->vref));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* SPI 1-wire mode */
> +	return regmap_update_bits(st->regmap, AD7380_REG_ADDR_CONFIG2,
> +				  AD7380_CONFIG2_SDO,
> +				  FIELD_PREP(AD7380_CONFIG2_SDO, 1));
> +}
> +
> +static void ad7380_release_regulator(void *p)
> +{
> +	struct regulator *reg = p;

The local variable doesn't really add anything over putting p
in the regulator_disable() call.

> +
> +	regulator_disable(reg);
> +}
> +
> +static int ad7380_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct ad7380_state *st;
> +	const char *str_val;
> +	int ret;
> +
> +	ret = device_property_read_string(&spi->dev, "adi,sdo-mode", &str_val);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "Failed to read adi,sdo-mode property\n");
> +
> +	if (strcmp(str_val, "1-wire"))
> +		return dev_err_probe(&spi->dev, -EINVAL,
> +				     "Only 1-wire SDO is supported\n");

Discussion on this binding in the dt-binding patch.
As mentioned there, it feels like a place where a default would be sensible.

> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
> +
> +	st->vref = devm_regulator_get_optional(&spi->dev, "refio");
> +	if (IS_ERR(st->vref)) {
> +		/*
> +		 * If there is no REFIO supply, then it means that we are using
> +		 * the internal 2.5V reference.
> +		 */
> +		if (PTR_ERR(st->vref) == -ENODEV)
> +			st->vref = NULL;
> +		else
> +			return dev_err_probe(&spi->dev, PTR_ERR(st->vref),
> +					     "Failed to get refio regulator\n");
> +	}
> +
> +	if (st->vref) {
> +		ret = regulator_enable(st->vref);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev, ad7380_release_regulator,

Naming wise maybe ad7380_disable_regulator is less misleading that release (which in
my mind is the bit the unwind for devm_regulator_get_optional() is doing)

> +					       st->vref);
> +		if (ret)
> +			return ret;
> +	}
