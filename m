Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1544475E1C4
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbjGWMWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 08:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGWMWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 08:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A86F510CE;
        Sun, 23 Jul 2023 05:22:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 440B860CE8;
        Sun, 23 Jul 2023 12:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CB1C433C9;
        Sun, 23 Jul 2023 12:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690114939;
        bh=GZr5gZULYl86p/1DYn/P5s5ZbDhLDXF6Ftu3E72YOG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YW0oJgAL/qzyOkwF88oT5gHSEX4mNhfz83EU2PZIwKdg8ovrSjrf0gxtzd7mCIAyu
         YG4YakFwQGgacS3QI4t/lCaxtQjWrdOXJmR6emgZN93JfpZUBpfYbKHwzPV5H9Nv0E
         d/1+zbdD37l4ci4+yo4Eu7uo9G0TBHaVxIzJvO7p4C8ITKQZlLirseh+6rre49mz5v
         eIERodnWXTABfOm5Oj8m2lQzmob3Q9isaPO4nAed16HRGyV3FwnYe5Y2vQyB7yPfYt
         OQaSV3fWmWewga9uh/InED7RLHHn6qGHpTHm9c5Dk0NHD4Q5gonOMU7TCFqOzaIlCU
         zb3a+MZTYPSAw==
Date:   Sun, 23 Jul 2023 13:22:16 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iio: Add driver for Murata IRS-D200
Message-ID: <20230723132216.3c2f4924@jic23-huawei>
In-Reply-To: <d218a1bc75402b5ebd6e12a563f7315f83fe966c.1689753076.git.waqar.hameed@axis.com>
References: <cover.1689753076.git.waqar.hameed@axis.com>
        <d218a1bc75402b5ebd6e12a563f7315f83fe966c.1689753076.git.waqar.hameed@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jul 2023 09:51:17 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> Murata IRS-D200 is a PIR sensor for human detection. It has support for
> raw data measurements and detection event notification.
> 
> Add a driver with support for triggered buffer and events. Map the
> various settings to the `iio` framework, e.g. threshold values, sampling
> frequency, filter frequencies etc.
> 
> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>

Hi Waqar.

I had some more feedback (see inline) but as it was all very minor, I've
made the changes whilst applying.  Let me know if I messed anything up!

Applied to the togreg branch of iio.git and pushed out as testing for 0-day
to see if it can find anything we missed.

Thanks,

Jonathan


> +
> +/*
> + * Index corresponds to the (field) value of IRS_REG_FILTER register. Note that
> + * this represents a fractional value (e.g the first value corresponds to 3 / 10
> + * = 0.3 Hz).
> + */
> +static const unsigned int irsd200_hp_filter_freq[][2] = {
> +	{3, 10},
> +	{5, 10},
> +};

Prefer space after / before {}

...

> +static int irsd200_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir, int state)
> +{
> +	struct irsd200_data *data = iio_priv(indio_dev);
> +	unsigned int tmp;
> +	int ret;
> +
> +	switch (type) {
> +	case IIO_EV_TYPE_THRESH:
> +		/* Clear the count register (by reading from it). */
> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &tmp);
> +		if (ret)
> +			return ret;
> +
> +		tmp = !!state;

Don't use tmp again here as it suggests some use of previous value.
I'd just put !!state in where the parameter is used.

> +		ret = regmap_field_write(
> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], tmp);
> +		if (ret)
> +			return ret;
> +
> +		return 0;
		return regmap_field_write(
			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], !!state);

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
> +		return IRQ_HANDLED;
> +	}
> +
> +	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
> +	if (ret) {
> +		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
> +			ret);
> +		return IRQ_HANDLED;
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
> +		ret = regmap_write(data->regmap, IRS_REG_STATUS, clear);
> +		if (ret)
> +			dev_err(data->dev,
> +				"Could not clear interrupt status (%d)\n", ret);
> +	}
> +
> +	return clear ? IRQ_HANDLED : IRQ_NONE;

	if (!clear)
		return IRQ_NONE

	ret = regmap_write(data->regmap ...
	if (ret)
		...
	return IRQ_HANDLED;

Avoids complexity of checking clear multiple times and keeps the 'error' paths as
the ones that are indented. (here it might just be a shared interrupt rather than
an error).



> +}


> +
> +static const struct iio_chan_spec irsd200_channels[] = {
> +	{
> +		.type = IIO_PROXIMITY,
> +		.info_mask_separate =
> +			BIT(IIO_CHAN_INFO_RAW) |
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> +			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
> +		.info_mask_separate_available =
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +			BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) |
> +			BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY),
> +		.event_spec = irsd200_event_spec,
> +		.num_event_specs = ARRAY_SIZE(irsd200_event_spec),
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_CPU,

As a general rule, we don't adjust the byte ordering of data going out via
the buffered interface, instead leaving that work for userspace.
Given the handling here is very simple, I don't feel that strongly about
keeping to that, but thought I'd mention it.

Jonathan

> +		},
> +	},
> +};

