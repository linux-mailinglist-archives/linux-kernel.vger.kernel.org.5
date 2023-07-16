Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C8C754F40
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGPPLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjGPPLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:11:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1547E40;
        Sun, 16 Jul 2023 08:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AAB060D2D;
        Sun, 16 Jul 2023 15:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E71B3C433C8;
        Sun, 16 Jul 2023 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689520274;
        bh=VdpiZcvXDWtP2XlQQMhRdFjZSA/zVZUvGy00fv7HM5g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DLOUjjQB2mGULSTbWJUHHXT2aeeht+3fFHtzI/xx1a5j/HKlTQt0hlQyGalzXbdqK
         UYY0XNFali9MUiukZUNju/3LrB8Aup5UXZoBLES54BZITUSLDwIHNxoriQebcMFOtV
         AZYlLyVoInOGF3mw/LC4kAgyrrl0aYdrU9REISmRlAf9wU8hzT/L1JpTqsWwzZGxjL
         3mZoUtgC/HPKjGAAymgKpsmNYL931avQYSr6AK89hNADqii9AZ8TkRTO4cpcWZKvE2
         8bkmYw0ghefcpXKrNaxu/ZvB2/vHjxDz0/OCAlGFoHyYo70vXPBKUVkji0PesH0sSO
         6D2Pgm3aizf6w==
Date:   Sun, 16 Jul 2023 16:11:07 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Murata IRS-D200
Message-ID: <20230716161107.75dc183a@jic23-huawei>
In-Reply-To: <9c6d81050e15f6bf66f16cdbeccc011c2169a32b.1689174736.git.waqar.hameed@axis.com>
References: <cover.1689174736.git.waqar.hameed@axis.com>
        <9c6d81050e15f6bf66f16cdbeccc011c2169a32b.1689174736.git.waqar.hameed@axis.com>
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

On Wed, 12 Jul 2023 17:12:17 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Murata IRS-D200 is a PIR sensor for human detection. It has support for
> raw data measurements and detection event notification.
> 
> Add a driver with support for triggered buffer and events. Map the
> various settings to the `iio` framework, e.g. threshold values, sampling
> frequency, filter frequencies etc.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
Hi Waqar,

Some additional comments inline.

Jonathan

> ---
>  drivers/iio/proximity/Kconfig   |  12 +
>  drivers/iio/proximity/Makefile  |   1 +
>  drivers/iio/proximity/irsd200.c | 982 ++++++++++++++++++++++++++++++++
>  3 files changed, 995 insertions(+)
>  create mode 100644 drivers/iio/proximity/irsd200.c

> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> new file mode 100644
> index 000000000000..e6b9eca1bf8e
> --- /dev/null
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -0,0 +1,982 @@



> +
> +static int irsd200_read_data(struct irsd200_data *data, s16 *val)
> +{
> +	u8 buf[2];

__le16

> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, IRS_REG_DATA_LO, buf,
> +			       ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(data->dev, "Could not bulk read data (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	*val = (buf[1] << 8) | buf[0];


If you make buf a __le16 then you can use aligned conversions otherwise
get_unaligned_le16(buf) 

> +
> +	return 0;
> +}
> +

...

> +
> +static int irsd200_read_timer(struct irsd200_data *data, int *val, int *val2)
> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, IRS_REG_TIMER_LO, buf,
> +			       ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(data->dev, "Could not bulk read timer (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	ret = irsd200_read_data_rate(data, val2);
> +	if (ret)
> +		return ret;
> +
> +	/* Value is 10 bits. IRS_REG_TIMER_HI is the two MSBs. */
> +	*val = (buf[1] << 8) | buf[0];

Another one where type should be __le16 and appropriate conversion functions
used.

> +
> +	return 0;
> +}
> +
> +static int irsd200_write_timer(struct irsd200_data *data, int val, int val2)
> +{
> +	unsigned int regval;
> +	int data_rate;
> +	u8 buf[2];

__le16 might be more appropriate.

> +	int ret;
> +
> +	if (val < 0 || val2 < 0)
> +		return -ERANGE;
> +
> +	ret = irsd200_read_data_rate(data, &data_rate);
> +	if (ret)
> +		return ret;
> +
> +	/* Quantize from seconds. */
> +	regval = val * data_rate + (val2 * data_rate) / 1000000;
> +
> +	/* Value is 10 bits. */
> +	if (regval >= BIT(10))
> +		return -ERANGE;
> +
> +	/* IRS_REG_TIMER_LO is the 8 LSBs and IRS_REG_TIMER_HI is the 2 MSBs. */
> +	buf[0] = FIELD_GET(GENMASK(7, 0), regval);
> +	buf[1] = FIELD_GET(GENMASK(9, 8), regval);

I think I'd rather see this as appropriate put_unaligned_le16() or similar with
the input masked.

> +
> +	ret = regmap_bulk_write(data->regmap, IRS_REG_TIMER_LO, buf,
> +				ARRAY_SIZE(buf));
> +	if (ret) {
> +		dev_err(data->dev, "Could not bulk write timer (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
0;
> +}
> +
> +static int irsd200_write_nr_count(struct irsd200_data *data, int val)
> +{
> +	unsigned int regval;
> +	int ret;
> +
> +	/* A value of zero means that IRS_REG_STATUS is never set. */
> +	if (val <= 0 || val >= BIT(3))

BIT(3) is an unusual representation... Here, 8 is probably clearer unless
it really has something to do with that bit being set.

> +		return -ERANGE;
> +
> +	regval = val;
> +
> +	if (regval >= 2) {
> +		/*
> +		 * According to the data sheet, timer must be also set in this
> +		 * case (i.e. be non-zero). Check and enforce that.
> +		 */
> +		ret = irsd200_read_timer(data, &val, &val);
> +		if (ret)
> +			return ret;
> +
> +		if (val == 0) {
> +			dev_err(data->dev,
> +				"Timer must be non-zero when nr count is %u\n",
> +				regval);
> +			return -EPERM;
> +		}
> +	}
> +
> +	ret = regmap_write(data->regmap, IRS_REG_NR_COUNT, regval);
> +	if (ret) {
> +		dev_err(data->dev, "Could not write nr count (%d)\n", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +




> +
> +static int irsd200_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	unsigned int val;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		/* Clear the count register (by reading from it). */
> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &val);
I'd use a different variable than val, preferably named to indicate
we don't care about the contents.  Using val here and below is a little
confusing.

> +		if (ret)
> +			return ret;
> +
> +		val = !!state;
> +		ret = regmap_field_write(
> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], val);
> +		if (ret)
> +			return ret;
> +
> +		return val;

Why return val?  Should probably be 0 if this write succeeded.

> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
> +{
> +	struct iio_dev *indio_dev = dev_id;
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	enum iio_event_direction dir;
> +	unsigned int lower_count;
> +	unsigned int upper_count;
> +	unsigned int status = 0;
> +	unsigned int source = 0;
> +	unsigned int clear = 0;
> +	unsigned int count = 0;
> +	int ret;
> +
> +	ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
> +	if (ret) {
> +		dev_err(data->dev, "Could not read interrupt source (%d)\n",
> +			ret);
> +		return IRQ_NONE;

As below.  IRQ_NONE does not normally mean error, it means we are sure it is not
our interrupt.  Even in error cases, return IRQ_HANDLED.

If you confirm via status bits that it isn't out interrupt, that's when you
return IRQ_NONE.


> +	}
> +
> +	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
> +	if (ret) {
> +		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
> +			ret);
> +		return IRQ_NONE;
> +	}
> +
> +	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
> +		iio_trigger_poll_nested(indio_dev->trig);
> +		clear |= BIT(IRS_INTR_DATA);
> +	}
> +
> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
> +		/*
> +		 * The register value resets to zero after reading. We therefore
> +		 * need to read once and manually extract the lower and upper
> +		 * count register fields.
> +		 */
> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
> +		if (ret)
> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
> +
> +		upper_count = IRS_UPPER_COUNT(count);
> +		lower_count = IRS_LOWER_COUNT(count);
> +
> +		/*
> +		 * We only check the OR mode to be able to push events for
> +		 * rising and falling thresholds. AND mode is covered when both
> +		 * upper and lower count is non-zero, and is signaled with
> +		 * IIO_EV_DIR_EITHER.
> +		 */
> +		if (upper_count && !lower_count)
> +			dir = IIO_EV_DIR_RISING;
> +		else if (!upper_count && lower_count)
> +			dir = IIO_EV_DIR_FALLING;
> +		else
> +			dir = IIO_EV_DIR_EITHER;
> +
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
> +						    IIO_EV_TYPE_THRESH, dir),
> +			       iio_get_time_ns(indio_dev));
> +
> +		/*
> +		 * The OR mode will always trigger when the AND mode does, but
> +		 * not vice versa. However, it seems like the AND bit needs to
> +		 * be cleared if data capture _and_ threshold count interrupts
> +		 * are desirable, even though it hasn't explicitly been selected
> +		 * (with IRS_REG_INTR). Either way, it doesn't hurt...
> +		 */
> +		clear |= BIT(IRS_INTR_COUNT_THR_OR) |
> +			 BIT(IRS_INTR_COUNT_THR_AND);
> +	}
> +
> +	if (clear) {

if (!clear) then it's not our interrupt (I think) and you should return IRQ_NONE.

> +		ret = regmap_write(data->regmap, IRS_REG_STATUS, clear);
> +		if (ret)
> +			dev_err(data->dev,
> +				"Could not clear interrupt status (%d)\n", ret);
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
> +{
> +	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	s16 buf = 0;
> +	int ret;
> +
> +	ret = irsd200_read_data(data, &buf);
> +	if (ret)
> +		goto end;
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &buf,
> +					   iio_get_time_ns(indio_dev));
> +
> +end:
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return ret ? IRQ_NONE : IRQ_HANDLED;

An error in a read is not reported as IRQ_NONE.  The only time we should report
that is if we know it definitely wasn't our interrupt.  Otherwise we will
fire the spurious interrupt handling disable logic for the wrong reason.

> +}
> +


> +
> +static int irsd200_probe(struct i2c_client *client)
> +{
> +	struct iio_trigger *trigger;
> +	struct irsd200_data *data;
> +	struct iio_dev *indio_dev;
> +	size_t i;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(&client->dev, -ENOMEM,
> +				     "Could not allocate iio device\n");
> +
> +	data = iio_priv(indio_dev);
> +	data->dev = &client->dev;
> +
> +	data->regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(data->dev, PTR_ERR(data->regmap),
> +				     "Could not initialize regmap\n");
> +
> +	for (i = 0; i < IRS_REGF_MAX; ++i) {
> +		data->regfields[i] = devm_regmap_field_alloc(
> +			data->dev, data->regmap, irsd200_regfields[i]);
> +		if (IS_ERR(data->regfields[i]))
> +			return dev_err_probe(
> +				data->dev, PTR_ERR(data->regfields[i]),
> +				"Could not allocate register field %zu\n", i);
> +	}
> +
> +	data->regulator = devm_regulator_get(data->dev, "vdd");

devm_regulator_get_enable()

> +	if (IS_ERR(data->regulator))
> +		return dev_err_probe(data->dev, PTR_ERR(data->regulator),
> +				     "Could not get regulator\n");
> +
> +	ret = regulator_enable(data->regulator);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,
> +				     "Could not enable regulator (%d)\n", ret);
> +
> +	ret = devm_add_action_or_reset(data->dev, irsd200_regulator_disable,
> +				       data->regulator);
> +	if (ret)
> +		return dev_err_probe(
> +			data->dev, ret,
> +			"Could not add regulator disable devres action (%d)\n",
> +			ret);

...


