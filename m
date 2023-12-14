Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1977812E17
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 12:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443867AbjLNLGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 06:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443808AbjLNLGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 06:06:18 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617608E;
        Thu, 14 Dec 2023 03:06:23 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SrTxz75gnz6K8Dy;
        Thu, 14 Dec 2023 19:04:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
        by mail.maildlp.com (Postfix) with ESMTPS id 157831400CA;
        Thu, 14 Dec 2023 19:06:21 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 14 Dec
 2023 11:06:20 +0000
Date:   Thu, 14 Dec 2023 11:06:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mike Looijmans <mike.looijmans@topic.nl>
CC:     <devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>, Lee Jones <lee@kernel.org>,
        Leonard =?ISO-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Liam Beguin <liambeguin@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maksim Kiselev <bigunclemax@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Marius Cristea <marius.cristea@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        "Okan Sahin" <okan.sahin@analog.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <20231214110618.00007783@Huawei.com>
In-Reply-To: <20231213094722.31547-2-mike.looijmans@topic.nl>
References: <20231213094722.31547-1-mike.looijmans@topic.nl>
        <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.27993507-256d-4b05-88df-c8643e7f1a68@emailsignatures365.codetwo.com>
        <20231213094722.31547-2-mike.looijmans@topic.nl>
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

On Wed, 13 Dec 2023 10:47:22 +0100
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> Skeleton driver for the TI ADS1298 medical ADC. This device is
> typically used for ECG and similar measurements. Supports data
> acquisition at configurable scale and sampling frequency.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> 
Hi Mike,

Various small things inline - some of which probably overlap with Andy's
comments.

The larger one is I don't follow why this does manual protection against
concurrent handling of the result of an IRQ.  Much easier to just use
an IRQ threaded handler and IRQF_ONESHOT to mask the irq entirely until
after the initial handling is done.  If that doesn't work for some reason
then more comments needed to explain why!

Jonathan

> diff --git a/drivers/iio/adc/ti-ads1298.c b/drivers/iio/adc/ti-ads1298.c
> new file mode 100644
> index 000000000000..54466285063f
> --- /dev/null

> + */
> +#define ADS1298_SPI_BUS_SPEED_SLOW	ADS1298_CLK_RATE
> +/* For reading and writing registers, we need a 3-byte buffer */
> +#define ADS1298_SPI_CMD_BUFFER_SIZE	3
> +/* Outputs status word and 8 samples of 24 bits each, plus the command byte */
> +#define ADS1298_SPI_RDATA_BUFFER_SIZE	((ADS1298_MAX_CHANNELS + 1) * 3 + 1)
> +
> +struct ads1298_private {
> +	const struct ads1298_chip_info	*chip_info;

Looks like a tab whereas other cases are spaces.

> +	struct spi_device *spi;
> +	struct regulator *reg_avdd;
> +	struct regulator *reg_vref;
> +	struct clk *clk;
> +	struct regmap *regmap;
> +	struct completion completion;
> +	struct iio_trigger *trig;
> +	struct spi_transfer rdata_xfer;
> +	struct spi_message rdata_msg;
> +	spinlock_t irq_busy_lock; /* Handshake between SPI and DRDY irqs */
> +	bool rdata_xfer_busy;
> +
> +	/* Temporary storage for demuxing data after SPI transfer */
> +	u8 bounce_buffer[ADS1298_MAX_CHANNELS * 4];
> +
> +	/* For synchronous SPI exchanges (read/write registers) */
> +	u8 cmd_buffer[ADS1298_SPI_CMD_BUFFER_SIZE] ____cacheline_aligned;

Not sufficient on alignment - see discussion on patch series for IIO_DMA_MINALIGN
and use that instead. Boils down to there being a few systems with cacheline lengths
are different across caches (that's common) AND this value is the smallest one whereas
coherency is out past a cache with a bigger cache line length.

> +
> +	/* Buffer used for incoming SPI data */
> +	u8 rx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
Generally drivers don't allow DMA transfers that will trample on data in another
DMA transfer - as such it's only normally necessary to force the whole set of buffers
to sit in their own cacheline.  Hence we mark only first one as needing alignment.
> +	/* Contains the RDATA command and zeroes to clock out */
> +	u8 tx_buffer[ADS1298_SPI_RDATA_BUFFER_SIZE] ____cacheline_aligned;
> +};


...

> +static const u8 ads1298_pga_settings[] = { 6, 1, 2, 3, 4, 8, 12 };
> +
> +static int ads1298_get_scale(struct ads1298_private *priv,
> +			     int channel, int *val, int *val2)
> +{
> +	int ret;
> +	unsigned int regval;
> +	u8 gain;
> +
> +	if (priv->reg_vref) {
> +		ret = regulator_get_voltage(priv->reg_vref);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret / 1000; /* Convert to millivolts */
> +	} else {
> +		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG3, &regval);
> +		if (ret)
> +			return ret;
> +
> +		/* Refererence in millivolts */
> +		*val = regval & ADS1298_MASK_CONFIG3_VREF_4V ? 4000 : 2400;
> +	}
> +
> +	ret = regmap_read(priv->regmap, ADS1298_REG_CHnSET(channel), &regval);
> +	if (ret)
> +		return ret;
> +
> +	gain = ads1298_pga_settings[FIELD_GET(ADS1298_MASK_CH_PGA, regval)];
> +	*val /= gain; /* Full scale is VREF / gain */
> +
> +	*val2 = 23; /* Signed 24-bit, max amplitude is 2^23 */
> +
> +	return IIO_VAL_FRACTIONAL_LOG2;
> +}
> +
> +

Trivial: Single blank line only.

> +static int ads1298_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		/* When busy, just peek in the buffer */
> +		if (!iio_buffer_enabled(indio_dev)) {
Races - you need to claim direct mode to prevent that.

> +			ret = ads1298_read_one(priv, chan->scan_index);
> +			if (ret)
> +				return ret;
> +		}
> +		*val = sign_extend32(get_unaligned_be24(
> +					priv->rx_buffer + chan->address), 23);
> +		ret = IIO_VAL_INT;
> +		break;
> +	case IIO_CHAN_INFO_SCALE:
> +		ret = ads1298_get_scale(priv, chan->channel, val, val2);
> +		break;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1298_get_samp_freq(priv, val);
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		ret = regmap_read(priv->regmap, ADS1298_REG_CONFIG1, val);
> +		if (!ret) {
> +			ret = IIO_VAL_INT;
> +			*val = (16 << (*val & ADS1298_MASK_CONFIG1_DR));
> +		}
Takes a line or 2 more but better to keep consistent style on error handling
		if (ret)
			return ret;
		*val = 16 << (*val & ADS1298_MASK_CONFIG1_DR); /* Note fewer () */
		return IIO_VAL_INT;


> +		break;
> +	default:
> +		ret = -EINVAL;
Always return early if there is nothing to do.  Makes review easier as no
need to sanity check what happens for each path if it's already returned.

> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ads1298_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = ads1298_set_samp_freq(priv, val);

return ads1298_set_samp_freq()

> +		break;
> +	default:
> +		ret = -EINVAL;

return -EINVAL;

> +		break;
> +	}
> +
> +	return ret;
> +}

..
> +static int ads1298_reg_access(struct iio_dev *indio_dev, unsigned int reg,
> +			      unsigned int writeval, unsigned int *readval)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +
> +	if (!readval)
> +		return regmap_write(priv->regmap, reg, writeval);
> +
> +	return regmap_read(priv->regmap, reg, readval);
> +}
> +
> +static int ads1298_update_scan_mode(struct iio_dev *indio_dev,
> +				    const unsigned long *scan_mask)
> +{
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int i;
> +
> +	/* Power down channels that aren't in use */
> +	for (i = 0; i < ADS1298_MAX_CHANNELS; i++) {
> +		regmap_update_bits(priv->regmap, ADS1298_REG_CHnSET(i),

Always check regmap accesses.  There's a horrible bus under this ;)

> +				   ADS1298_MASK_CH_PD,
> +				   test_bit(i, scan_mask) ?
> +							0 : ADS1298_MASK_CH_PD);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct iio_info ads1298_info = {
> +	.read_raw = &ads1298_read_raw,
> +	.write_raw = &ads1298_write_raw,
> +	.update_scan_mode = &ads1298_update_scan_mode,
> +	.debugfs_reg_access = &ads1298_reg_access,
> +};
> +
> +static void ads1298_rdata_unmark_busy(struct ads1298_private *priv)
> +{
> +	unsigned long flags;
> +
> +	/* Notify we're no longer waiting for the SPI transfer to complete */
> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
> +	priv->rdata_xfer_busy = false;
> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
> +}
> +
> +static void ads1298_rdata_complete(void *context)
> +{
> +	struct iio_dev *indio_dev = context;
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	int scan_index;
> +	u8 *bounce = priv->bounce_buffer;
> +
> +	if (!iio_buffer_enabled(indio_dev)) {

This can race I think with a transition into buffered mode.
You should be able to use iio_device_claim_direct_mode
here().  That will fail if you are in buffered mode but if it succeeds
it will hold us in non buffered mode until it is released.
 
> +		/* Happens when running in single transfer mode */
> +		ads1298_rdata_unmark_busy(priv);
> +		complete(&priv->completion);
> +		return;
> +	}
> +
> +	/* Demux the channel data into our bounce buffer */
> +	for_each_set_bit(scan_index, indio_dev->active_scan_mask,
> +			 indio_dev->masklength) {
> +		const struct iio_chan_spec *scan_chan =
> +					&indio_dev->channels[scan_index];
> +		const u8 *data = priv->rx_buffer + scan_chan->address;
> +
> +		/* Transfer 24-bit value into 32-bit array */
> +		memcpy(bounce + 1, data, 3);
> +		bounce += 4;
> +	}
> +
> +	/* rx_buffer can be overwritten from this point on */
> +	ads1298_rdata_unmark_busy(priv);
> +
> +	iio_push_to_buffers(indio_dev, priv->bounce_buffer);
> +}
> +
> +static irqreturn_t ads1298_interrupt(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct ads1298_private *priv = iio_priv(indio_dev);
> +	unsigned long flags;
> +	bool wasbusy;
> +
> +	/* Prevent that we submit a message that was still in progress */
> +	spin_lock_irqsave(&priv->irq_busy_lock, flags);
> +	wasbusy = priv->rdata_xfer_busy;
> +	priv->rdata_xfer_busy = true;
> +	spin_unlock_irqrestore(&priv->irq_busy_lock, flags);
> +
> +	if (!wasbusy)
> +		spi_async(priv->spi, &priv->rdata_msg);
> +
> +	return IRQ_HANDLED;

Can you not use the IRQF_ONESHOT and an IRQ thread to deal with what
you are using wasbusy for here?  I'm not keen on a reply saying we've
handled the interrupt when we really haven't finished with it.

This looks like a classic data ready trigger as well. Why handle
it without the trigger infrastructure?

> +};



> +
> +static const struct iio_buffer_setup_ops ads1298_setup_ops = {
> +	.postenable = &ads1298_buffer_postenable,
> +	.predisable = &ads1298_buffer_predisable,
> +};

...


> +static int ads1298_init(struct ads1298_private *priv)
> +{
> +	struct device *dev = &priv->spi->dev;
> +	int ret;
> +	unsigned int val;
> +
> +	/* Device initializes into RDATAC mode, which we don't want. */
> +	ret = ads1298_write_cmd(priv, ADS1298_CMD_SDATAC);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(priv->regmap, ADS1298_REG_ID, &val);
> +	if (ret)
> +		return ret;
> +
> +	if ((val & 0x18) == 0x10) {

FIELD_GET() and appropriate mask defines.

> +		dev_info(dev, "Found %s, %d channels\n",
> +			 ads1298_family_name(val),
> +			 4 + 2 * (val & 0x07));
> +	} else {
> +		dev_err(dev, "Unknown ID: 0x%x\n", val);

In order to support fall back DT compatibles etc, we generally only
print a message on a missmatched ID.  It might be for a new fully
compatible device with a DT binding deliberately specifying that
the older device is fine for matching against.
This is something we are slowly fixing up in older drives after
some long discussions with the DT maintainers a few years back.

> +		return -ENODEV;
> +	}
> +
> +	/* Enable internal test signal, double amplitude, double frequency */
> +	regmap_write(priv->regmap, ADS1298_REG_CONFIG2,
> +		ADS1298_MASK_CONFIG2_RESERVED |
> +		ADS1298_MASK_CONFIG2_INT_TEST |
> +		ADS1298_MASK_CONFIG2_TEST_AMP |
> +		ADS1298_MASK_CONFIG2_TEST_FREQ_FAST);
> +

Always check return values unless you expect them to fail (in which case document
that).

> +	val = ADS1298_MASK_CONFIG3_RESERVED; /* Must write 1 always */
> +	if (!priv->reg_vref) {
> +		/* Enable internal reference */
> +		val |= ADS1298_MASK_CONFIG3_PWR_REFBUF;

#FIELD_PREP() and masks preferred for consistency with multi bit fields.

> +		/* Use 4V VREF when power supply is at least 4.4V */
> +		if (regulator_get_voltage(priv->reg_avdd) >= 4400000)
> +			val |= ADS1298_MASK_CONFIG3_VREF_4V;
> +	}
> +	regmap_write(priv->regmap, ADS1298_REG_CONFIG3, val);
> +
> +	for (val = 0; val < ADS1298_MAX_CHANNELS; val++) {
> +		/* Set mux to analog input, PGA = 6x */

Use appropriate mask defines and FIELD_PREP() so that 0x00 doesn't
need a comment here as the define makes it clear what is going on.

> +		regmap_write(priv->regmap, ADS1298_REG_CHnSET(val), 0x00);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ads1298_probe(struct spi_device *spi)
> +{
> +	struct ads1298_private *priv;
> +	struct iio_dev *indio_dev;
> +	struct device *dev = &spi->dev;
> +	struct gpio_desc *reset_gpio;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (indio_dev == NULL)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +
> +	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(dev, ret, "Cannot get reset GPIO\n");
> +
> +	priv->reg_avdd = devm_regulator_get(dev, "avdd");
> +	if (IS_ERR(priv->reg_avdd))
> +		return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> +				     "Failed to get avdd regulator\n");
> +
> +	/* VREF can be supplied externally. Otherwise use internal reference */
> +	priv->reg_vref = devm_regulator_get_optional(dev, "vref");
> +	if (IS_ERR(priv->reg_vref)) {
> +		if (PTR_ERR(priv->reg_vref) == -ENODEV)
> +			priv->reg_vref = NULL;
> +		else
> +			return dev_err_probe(dev, PTR_ERR(priv->reg_avdd),
> +					     "Failed to get vref regulator\n");
> +	} else {
> +		ret = regulator_enable(priv->reg_vref);
> +		if (ret)
> +			return ret;
> +
> +		ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +					       priv->reg_vref);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->clk = devm_clk_get_enabled(dev, "clk");
> +	if (IS_ERR(priv->clk))
> +		return dev_err_probe(dev, PTR_ERR(priv->clk),
> +				     "Failed to get clk\n");
> +
> +	ret = regulator_enable(priv->reg_avdd);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to enable avdd regulator\n");
> +
> +	ret = devm_add_action_or_reset(dev, ads1298_reg_disable,
> +				       priv->reg_avdd);
> +	if (ret)
> +		return ret;
I'd group the getting of this regulator with it's enabling.  That will bring it
inline with how you handle vref.


> +
> +	priv->spi = spi;
> +	init_completion(&priv->completion);
> +	spin_lock_init(&priv->irq_busy_lock);
> +	priv->regmap = devm_regmap_init(dev, NULL, priv,
> +					&ads1298_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return PTR_ERR(priv->regmap);
> +
> +	priv->tx_buffer[0] = ADS1298_CMD_RDATA;
> +	priv->rdata_xfer.tx_buf = priv->tx_buffer;
> +	priv->rdata_xfer.rx_buf = priv->rx_buffer;
> +	priv->rdata_xfer.len = ADS1298_SPI_RDATA_BUFFER_SIZE;
> +	/* Must keep CS low for 4 clocks */
> +	priv->rdata_xfer.delay.value = 2;
> +	priv->rdata_xfer.delay.unit = SPI_DELAY_UNIT_USECS;
> +	spi_message_init_with_transfers(&priv->rdata_msg, &priv->rdata_xfer, 1);
> +	priv->rdata_msg.complete = &ads1298_rdata_complete;
> +	priv->rdata_msg.context = indio_dev;
> +
> +	/* Avoid giving all the same name, iio scope doesn't handle that well */

That's intentional - name is the type of chip, not a unique name.
If you need a way to identify the device then use the path of the parent
which will associate this with the underlying bus device and hence provide
a stable reference.  We deliberately don't attempt to provide a different way
to identify the device. readlink is your friend in userspace.
Some drivers got through review with naming coming from elsewhere but this
is the part number of the device.  With hindsight the ABI should have reflected
that to avoid confusion but we are stuck with 'name'.

> +	indio_dev->name = devm_kasprintf(dev, GFP_KERNEL, "%s@%s",
> +					 spi_get_device_id(spi)->name,
> +					 dev_name(dev));
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = ads1298_channels;
> +	indio_dev->num_channels = ADS1298_MAX_CHANNELS;
> +	indio_dev->info = &ads1298_info;
> +
> +	if (reset_gpio) {
> +		udelay(1); /* Minimum pulse width is 2 clocks at 2MHz */
> +		gpiod_set_value(reset_gpio, 0);
> +	} else {
> +		ret = ads1298_write_cmd(priv, ADS1298_CMD_RESET);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "RESET failed\n");
> +	}
> +	/* Wait 18 clock cycles for reset command to complete */
> +	udelay(9);
> +
> +	ret = ads1298_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Init failed\n");
> +
> +	ret = devm_request_irq(&spi->dev, spi->irq, &ads1298_interrupt,
> +			       IRQF_TRIGGER_FALLING, indio_dev->name,
> +			       indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_kfifo_buffer_setup(&spi->dev, indio_dev,
> +					  &ads1298_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ads1298_id[] = {
> +	{ "ads1298",  },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ads1298_id);
> +
> +static const struct of_device_id ads1298_of_table[] = {
> +	{ .compatible = "ti,ads1298" },
> +	{ },
No point in the trailing comma.
> +};
> +MODULE_DEVICE_TABLE(of, ads1298_of_table);

Thanks,

Jonathan


