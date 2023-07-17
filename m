Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F4947561AC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:36:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGQLga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 07:36:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjGQLg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:36:29 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75EFE52;
        Mon, 17 Jul 2023 04:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689593786;
  x=1721129786;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=1a4oK02vUsyndxP6RIdPjh5KNRbKG2fiRD8lHj8x47U=;
  b=Wreuvvqb1qiH5OiM36newNhhlCyjQ4bvpHw2PViqCNr5xpKJWXxTLRmh
   gmdLC8byb//pfGDKFNAHsbdN2nEz5qt1sSW+oCu7Zy+2MJeW9oPzdG9fd
   rGIKboJicDUr90wHQkq2tWrNejMGd6SJVVu6VguM6ZWpTf0EPF2KQ/LLg
   WP8HRgBVdEBCtIMbAQWUvLoUxyAD720HZ2i9MBMEGD2RSitQkIPF/MYyx
   z358eY6gd78UFfCaxL4hv7YCptt3GOtFL+anfKbNOGzqp2+oQNO6IMKAx
   6GFUBtuPAzruVyNEzu+ukWhl3pW5CgK3rOZ04DZrUCJO0fXAme7GvUx4g
   Q==;
References: <cover.1689174736.git.waqar.hameed@axis.com>
 <9c6d81050e15f6bf66f16cdbeccc011c2169a32b.1689174736.git.waqar.hameed@axis.com>
 <20230716161107.75dc183a@jic23-huawei>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     <linux-iio@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <kernel@lists.axis.com>
Subject: Re: [PATCH v2 3/3] iio: Add driver for Murata IRS-D200
Date:   Mon, 17 Jul 2023 12:18:40 +0200
In-Reply-To: <20230716161107.75dc183a@jic23-huawei>
Message-ID: <pndjzuy93d8.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2023 at 16:11 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

>> +static int irsd200_read_data(struct irsd200_data *data, s16 *val)
>> +{
>> +	u8 buf[2];
>
> __le16
>
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(data->regmap, IRS_REG_DATA_LO, buf,
>> +			       ARRAY_SIZE(buf));
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not bulk read data (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	*val = (buf[1] << 8) | buf[0];
>
>
> If you make buf a __le16 then you can use aligned conversions otherwise
> get_unaligned_le16(buf) 
>
>> +
>> +	return 0;
>> +}
>> +
>
> ...
>
>> +
>> +static int irsd200_read_timer(struct irsd200_data *data, int *val, int *val2)
>> +{
>> +	u8 buf[2];
>> +	int ret;
>> +
>> +	ret = regmap_bulk_read(data->regmap, IRS_REG_TIMER_LO, buf,
>> +			       ARRAY_SIZE(buf));
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not bulk read timer (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = irsd200_read_data_rate(data, val2);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Value is 10 bits. IRS_REG_TIMER_HI is the two MSBs. */
>> +	*val = (buf[1] << 8) | buf[0];
>
> Another one where type should be __le16 and appropriate conversion functions
> used.
>
>> +
>> +	return 0;
>> +}
>> +
>> +static int irsd200_write_timer(struct irsd200_data *data, int val, int val2)
>> +{
>> +	unsigned int regval;
>> +	int data_rate;
>> +	u8 buf[2];
>
> __le16 might be more appropriate.
>
>> +	int ret;
>> +
>> +	if (val < 0 || val2 < 0)
>> +		return -ERANGE;
>> +
>> +	ret = irsd200_read_data_rate(data, &data_rate);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* Quantize from seconds. */
>> +	regval = val * data_rate + (val2 * data_rate) / 1000000;
>> +
>> +	/* Value is 10 bits. */
>> +	if (regval >= BIT(10))
>> +		return -ERANGE;
>> +
>> +	/* IRS_REG_TIMER_LO is the 8 LSBs and IRS_REG_TIMER_HI is the 2 MSBs. */
>> +	buf[0] = FIELD_GET(GENMASK(7, 0), regval);
>> +	buf[1] = FIELD_GET(GENMASK(9, 8), regval);
>
> I think I'd rather see this as appropriate put_unaligned_le16() or similar with
> the input masked.

I was choosing between these functions or manually doing things. I'll
update to use the endian conversions!

>> +
>> +	ret = regmap_bulk_write(data->regmap, IRS_REG_TIMER_LO, buf,
>> +				ARRAY_SIZE(buf));
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not bulk write timer (%d)\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
> 0;

(The mystery continues! :) )

>> +static int irsd200_write_nr_count(struct irsd200_data *data, int val)
>> +{
>> +	unsigned int regval;
>> +	int ret;
>> +
>> +	/* A value of zero means that IRS_REG_STATUS is never set. */
>> +	if (val <= 0 || val >= BIT(3))
>
> BIT(3) is an unusual representation... Here, 8 is probably clearer unless
> it really has something to do with that bit being set.

Yeah, I agree.

[...]

>> +static int irsd200_write_event_config(struct iio_dev *indio_dev,
>> +				      const struct iio_chan_spec *chan,
>> +				      enum iio_event_type type,
>> +				      enum iio_event_direction dir, int state)
>> +{
>> +	struct irsd200_data *data = iio_priv(indio_dev);
>> +	unsigned int val;
>> +	int ret;
>> +
>> +	switch (type) {
>> +	case IIO_EV_TYPE_THRESH:
>> +		/* Clear the count register (by reading from it). */
>> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &val);
> I'd use a different variable than val, preferably named to indicate
> we don't care about the contents.  Using val here and below is a little
> confusing.

I get that. Let's use `tmp`.

>
>> +		if (ret)
>> +			return ret;
>> +
>> +		val = !!state;
>> +		ret = regmap_field_write(
>> +			data->regfields[IRS_REGF_INTR_COUNT_THR_OR], val);
>> +		if (ret)
>> +			return ret;
>> +
>> +		return val;
>
> Why return val?  Should probably be 0 if this write succeeded.

Yes, will fix! (copy-pasting is dangerous...)

>
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static irqreturn_t irsd200_irq_thread(int irq, void *dev_id)
>> +{
>> +	struct iio_dev *indio_dev = dev_id;
>> +	struct irsd200_data *data = iio_priv(indio_dev);
>> +	enum iio_event_direction dir;
>> +	unsigned int lower_count;
>> +	unsigned int upper_count;
>> +	unsigned int status = 0;
>> +	unsigned int source = 0;
>> +	unsigned int clear = 0;
>> +	unsigned int count = 0;
>> +	int ret;
>> +
>> +	ret = regmap_read(data->regmap, IRS_REG_INTR, &source);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not read interrupt source (%d)\n",
>> +			ret);
>> +		return IRQ_NONE;
>
> As below.  IRQ_NONE does not normally mean error, it means we are sure it is not
> our interrupt.  Even in error cases, return IRQ_HANDLED.
>
> If you confirm via status bits that it isn't out interrupt, that's when you
> return IRQ_NONE.

Alright, let's do that then (and in `irsd200_trigger_handler()`).

>> +	}
>> +
>> +	ret = regmap_read(data->regmap, IRS_REG_STATUS, &status);
>> +	if (ret) {
>> +		dev_err(data->dev, "Could not acknowledge interrupt (%d)\n",
>> +			ret);
>> +		return IRQ_NONE;
>> +	}
>> +
>> +	if (status & BIT(IRS_INTR_DATA) && iio_buffer_enabled(indio_dev)) {
>> +		iio_trigger_poll_nested(indio_dev->trig);
>> +		clear |= BIT(IRS_INTR_DATA);
>> +	}
>> +
>> +	if (status & BIT(IRS_INTR_COUNT_THR_OR) &&
>> +	    source & BIT(IRS_INTR_COUNT_THR_OR)) {
>> +		/*
>> +		 * The register value resets to zero after reading. We therefore
>> +		 * need to read once and manually extract the lower and upper
>> +		 * count register fields.
>> +		 */
>> +		ret = regmap_read(data->regmap, IRS_REG_COUNT, &count);
>> +		if (ret)
>> +			dev_err(data->dev, "Could not read count (%d)\n", ret);
>> +
>> +		upper_count = IRS_UPPER_COUNT(count);
>> +		lower_count = IRS_LOWER_COUNT(count);
>> +
>> +		/*
>> +		 * We only check the OR mode to be able to push events for
>> +		 * rising and falling thresholds. AND mode is covered when both
>> +		 * upper and lower count is non-zero, and is signaled with
>> +		 * IIO_EV_DIR_EITHER.
>> +		 */
>> +		if (upper_count && !lower_count)
>> +			dir = IIO_EV_DIR_RISING;
>> +		else if (!upper_count && lower_count)
>> +			dir = IIO_EV_DIR_FALLING;
>> +		else
>> +			dir = IIO_EV_DIR_EITHER;
>> +
>> +		iio_push_event(indio_dev,
>> +			       IIO_UNMOD_EVENT_CODE(IIO_PROXIMITY, 0,
>> +						    IIO_EV_TYPE_THRESH, dir),
>> +			       iio_get_time_ns(indio_dev));
>> +
>> +		/*
>> +		 * The OR mode will always trigger when the AND mode does, but
>> +		 * not vice versa. However, it seems like the AND bit needs to
>> +		 * be cleared if data capture _and_ threshold count interrupts
>> +		 * are desirable, even though it hasn't explicitly been selected
>> +		 * (with IRS_REG_INTR). Either way, it doesn't hurt...
>> +		 */
>> +		clear |= BIT(IRS_INTR_COUNT_THR_OR) |
>> +			 BIT(IRS_INTR_COUNT_THR_AND);
>> +	}
>> +
>> +	if (clear) {
>
> if (!clear) then it's not our interrupt (I think) and you should return IRQ_NONE.

Yeah, this is probably the only place we can be sure it isn't our
interrupt.

[...]

>> +static int irsd200_probe(struct i2c_client *client)
>> +{
>> +	struct iio_trigger *trigger;
>> +	struct irsd200_data *data;
>> +	struct iio_dev *indio_dev;
>> +	size_t i;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return dev_err_probe(&client->dev, -ENOMEM,
>> +				     "Could not allocate iio device\n");
>> +
>> +	data = iio_priv(indio_dev);
>> +	data->dev = &client->dev;
>> +
>> +	data->regmap = devm_regmap_init_i2c(client, &irsd200_regmap_config);
>> +	if (IS_ERR(data->regmap))
>> +		return dev_err_probe(data->dev, PTR_ERR(data->regmap),
>> +				     "Could not initialize regmap\n");
>> +
>> +	for (i = 0; i < IRS_REGF_MAX; ++i) {
>> +		data->regfields[i] = devm_regmap_field_alloc(
>> +			data->dev, data->regmap, irsd200_regfields[i]);
>> +		if (IS_ERR(data->regfields[i]))
>> +			return dev_err_probe(
>> +				data->dev, PTR_ERR(data->regfields[i]),
>> +				"Could not allocate register field %zu\n", i);
>> +	}
>> +
>> +	data->regulator = devm_regulator_get(data->dev, "vdd");
>
> devm_regulator_get_enable()

I suggested it, but didn't use it... (because I was testing with
hardware on an older tree where it was not present...). Sorry!
