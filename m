Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 097167BA360
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:56:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236020AbjJEP4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjJEPzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:55:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592A72D7B;
        Thu,  5 Oct 2023 08:14:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C45AAC433C7;
        Thu,  5 Oct 2023 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696518889;
        bh=JColYyM5Rr6TFSiBQAOWJCP2k5bUNn4wKeQSZq6UwUk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EaO1Ol+RMiBeWrtDXeMF/lLes/EpgDpeWs3as1gjRX943F5s+v4xmGB5Ha4qWQabk
         n9O8LlQw8YS7QXCuIKeWuX14VswH9dCo3XXumIa8eJ9DYxdhpZFgyjnef/06T4iA20
         k4d4kv4LpLS7J96X+7o8DPWOe3TTxDtcuvXoD5hWNYTlmxXAf5orWtiIaTtRcOVLJQ
         a0S6/qFMnC5qk7jtB2RK4Mk9OrRhI50iT7zCN/sgUGb2ajc5iuUmqQhmh9+d85v74/
         TUwWTFk5Hh0T5dJ7YOPHU6OfNmJketn6SSVv+lvU06ADeVPS54tK3/jZjO9o5L+IQ6
         jp9fVpUskRYIA==
Date:   Thu, 5 Oct 2023 16:14:55 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bu27008: Add processed illuminance channel
Message-ID: <20231005161455.22d68c22@jic23-huawei>
In-Reply-To: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
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

On Mon, 2 Oct 2023 15:33:41 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The RGB + IR data can be used to calculate illuminance value (Luxes).
> Implement the equation obtained from the ROHM HW colleagues and add a
> light data channel outputting illuminance values in (nano) Luxes.
Units in the ABI doc for illuminance are Lux, not nanolux.
I'm guessing that you actually provide it in Lux but via scale.

Make that clearer in this description if so.

> 
> Both the read_raw and buffering values is supported, with the limitation
> that buffering is only allowed when suitable scan-mask is used. (RGB+IR,
> no clear).
> 
> The equation has been developed by ROHM HW colleagues for open air sensor.
> Adding any lens to the sensor is likely to impact to the used c1, c2, c3
> coefficients. Also, The output values have only been tested on BU27008.
> 
> According to the HW colleagues, the very same equation should work also
> on BU27010.
> 
> Calculate and output illuminance values from BU27008 and BU27010.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 

A few comments inline, but in general looks fine to me.

Jonathan

> ---
> 
> I did very dummy testing at very normal daylight inside a building. No
> special equipments were used - I simply compared values computed from
> BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
> phone. Results were roughly the same (around 400 lux). Couldn't repeat
> test on BU27010, but the data it outputs should be same format as
> BU27008 data so equation should work for both sensors.
> ---
>  drivers/iio/light/rohm-bu27008.c | 216 ++++++++++++++++++++++++++++++-
>  1 file changed, 211 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> index 6a6d77805091..d480cf761377 100644
> --- a/drivers/iio/light/rohm-bu27008.c
> +++ b/drivers/iio/light/rohm-bu27008.c
> @@ -130,6 +130,7 @@
>   * @BU27008_BLUE:	Blue channel. Via data2 (when used).
>   * @BU27008_CLEAR:	Clear channel. Via data2 or data3 (when used).
>   * @BU27008_IR:		IR channel. Via data3 (when used).
> + * @BU27008_LUX:	Illuminance channel, computed using RGB and IR.
>   * @BU27008_NUM_CHANS:	Number of channel types.
>   */
>  enum bu27008_chan_type {
> @@ -138,6 +139,7 @@ enum bu27008_chan_type {
>  	BU27008_BLUE,
>  	BU27008_CLEAR,
>  	BU27008_IR,
> +	BU27008_LUX,
>  	BU27008_NUM_CHANS
>  };
>  
> @@ -172,6 +174,8 @@ static const unsigned long bu27008_scan_masks[] = {
>  	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
>  	/* buffer is R, G, B, IR */
>  	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
> +	/* buffer is R, G, B, IR, LUX */
> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR) | BIT(BU27008_LUX),
>  	0
>  };
>  
> @@ -331,6 +335,19 @@ static const struct iio_chan_spec bu27008_channels[] = {
>  	 * Hence we don't advertise available ones either.
>  	 */
>  	BU27008_CHAN(IR, DATA3, 0),
> +	{
> +		.type = IIO_LIGHT,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +		.channel = BU27008_LUX,
> +		.scan_index = BU27008_LUX,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 64,
> +			.storagebits = 64,
> +			.endianness = IIO_CPU,
> +		},
> +	},
>  	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
>  };
>  
> @@ -1004,6 +1021,183 @@ static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
>  	return ret;
>  }
>  
> +static int bu27008_get_rgb_ir(struct bu27008_data *data, unsigned int *red,
> +		    unsigned int *green, unsigned int *blue, unsigned int *ir)
> +{
> +	int ret, chan_sel, int_time, tmpret, valid;
> +	__le16 chans[BU27008_NUM_HW_CHANS];
> +
> +	chan_sel = BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) - 1);
> +
> +	ret = regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
> +				 data->cd->chan_sel_mask, chan_sel);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_meas_set(data, true);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_get_int_time_us(data);
> +	if (ret < 0)
> +		int_time = BU27008_MEAS_TIME_MAX_MS;
> +	else
> +		int_time = ret / USEC_PER_MSEC;
> +
> +	msleep(int_time);
> +
> +	ret = regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
> +				       valid, (valid & BU27008_MASK_VALID),
> +				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
> +				       BU27008_MAX_VALID_RESULT_WAIT_US);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chans,
> +			       sizeof(chans));
> +	if (ret)
> +		goto out;
> +
> +	*red = le16_to_cpu(chans[0]);
> +	*green = le16_to_cpu(chans[1]);
> +	*blue = le16_to_cpu(chans[2]);
> +	*ir = le16_to_cpu(chans[3]);

I'd be tempted to use an array + definitely pass them as u16 rather
than unsigned int.


> +
> +out:
> +	tmpret = bu27008_meas_set(data, false);
> +	if (tmpret)
> +		dev_warn(data->dev, "Stopping measurement failed\n");
> +
> +	return ret;
> +}
> +
> +/*
> + * Following equation for computing lux out of register values was given by
> + * ROHM HW colleagues;
> + *
> + * Red = RedData*1024 / Gain * 20 / meas_mode
> + * Green = GreenData* 1024 / Gain * 20 / meas_mode
> + * Blue = BlueData* 1024 / Gain * 20 / meas_mode
> + * IR = IrData* 1024 / Gain * 20 / meas_mode
> + *
> + * where meas_mode is the integration time in mS / 10
> + *
> + * IRratio = (IR > 0.18 * Green) ? 0 : 1
> + *
> + * Lx = max(c1*Red + c2*Green + c3*Blue,0)
> + *
> + * for
> + * IRratio 0: c1 = -0.00002237, c2 = 0.0003219, c3 = -0.000120371
> + * IRratio 1: c1 = -0.00001074, c2 = 0.000305415, c3 = -0.000129367
> + */
> +
> +/*
> + * The max chan data is 0xffff. When we multiply it by 1024 * 20, we'll get
> + * 0x4FFFB000 which still fits in 32-bit integer. So this can't overflow.
> + */
> +#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) ((chan) * 1024 * 20 / \
> +				   (gain) / (time))
> +static u64 bu27008_calc_nlux(struct bu27008_data *data, unsigned int red,
> +		unsigned int green, unsigned int blue,  unsigned int ir,
> +		unsigned int gain, unsigned int gain_ir, unsigned int time)
> +{
> +	s64 c1, c2, c3, nlux;
> +
> +	time /= 10000;
> +	ir = NORM_CHAN_DATA_FOR_LX_CALC(ir, gain_ir, time);
> +	red = NORM_CHAN_DATA_FOR_LX_CALC(red, gain, time);
> +	green = NORM_CHAN_DATA_FOR_LX_CALC(green, gain, time);
> +	blue = NORM_CHAN_DATA_FOR_LX_CALC(blue, gain, time);
I'd prefer to see the inputs parameters and the normalized version given different
names. Also the inputs are still u16, so nice to reflect that here.
Also when doing normalization I'd used fixed with types so there is no
confusion over what was intended (here u32)

> +
> +	if ((u64)ir * 100LLU > 18LLU * (u64)green) {

Putting scaling for ir to the right and green to the left is
unusual. I'd chose one side and stick to it.

> +		c1 = -22370;
> +		c2 = 321900;
> +		c3 = -120371;
> +	} else {
> +		c1 = -10740;
> +		c2 = 305415;
> +		c3 = -129367;
> +	}
> +	nlux = c1 * red + c2 * green + c3 * blue;
> +	if (nlux < 0)
> +		nlux = 0;

	return max(0, nlux); is a bit neater and makes
it clear this is simple clamping to possible values given unlikely we'll see
negative light sources :)


> +
> +	return nlux;
> +}
> +
> +static int bu27008_get_time_n_gains(struct bu27008_data *data,
> +		unsigned int *gain, unsigned int *gain_ir, unsigned int *time)
> +{
> +	int ret;
> +
> +	ret = bu27008_get_gain(data, &data->gts, gain);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bu27008_get_gain(data, &data->gts_ir, gain_ir);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = bu27008_get_int_time_us(data);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Max integration time is 400000i. Fits in signed int. */
> +	*time = ret;
> +
> +	return 0;
> +}
> +
> +struct bu27008_buf {
> +	__le16 chan[BU27008_NUM_HW_CHANS];
> +	u64 lux __aligned(8);
> +	s64 ts __aligned(8);
> +};
> +
> +static int bu27008_buffer_get_lux(struct bu27008_data *data,
> +				  struct bu27008_buf *raw)
> +{
> +	unsigned int red, green, blue, ir, gain, gain_ir, time;
> +	int ret;
> +
> +	red = le16_to_cpu(raw->chan[0]);
> +	green = le16_to_cpu(raw->chan[1]);
> +	blue = le16_to_cpu(raw->chan[2]);
> +	ir = le16_to_cpu(raw->chan[3]);
> +	ret = bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
> +	if (ret)
> +		return ret;
> +
> +	raw->lux = bu27008_calc_nlux(data, red, green, blue, ir, gain, gain_ir,
> +				     time);

Probably call this function *fill_in_lux() or something like that because I'd expect
a *get_lux() function to return the lux value.

> +
> +	return 0;
> +}
> +
> +static int bu27008_read_lux(struct bu27008_data *data, struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2)
> +{
> +	unsigned int red, green, blue, ir, gain, gain_ir, time;
> +	u64 nlux;
> +	int ret;
> +
> +	ret = bu27008_get_rgb_ir(data, &red, &green, &blue, &ir);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
> +	if (ret)
> +		return ret;
> +
> +	nlux = bu27008_calc_nlux(data, red, green, blue, ir, gain, gain_ir,
> +				 time);
> +	*val = (int)nlux;
> +	*val2 = nlux >> 32LLU;
> +
> +	return IIO_VAL_INT_64;
> +}
> +
>  static int bu27008_read_raw(struct iio_dev *idev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -1012,13 +1206,17 @@ static int bu27008_read_raw(struct iio_dev *idev,
>  	int busy, ret;
>  
>  	switch (mask) {
> +

Unwanted change.

>  	case IIO_CHAN_INFO_RAW:
No IIO_CHAN_INFO_PROCESSED so I'm a bit surprised if this o
>  		busy = iio_device_claim_direct_mode(idev);
>  		if (busy)
>  			return -EBUSY;
>  
>  		mutex_lock(&data->mutex);
> -		ret = bu27008_read_one(data, idev, chan, val, val2);
> +		if (chan->type == IIO_LIGHT)
> +			ret = bu27008_read_lux(data, idev, chan, val, val2);
> +		else
> +			ret = bu27008_read_one(data, idev, chan, val, val2);
>  		mutex_unlock(&data->mutex);
>  
>  		iio_device_release_direct_mode(idev);
> @@ -1026,6 +1224,11 @@ static int bu27008_read_raw(struct iio_dev *idev,
>  		return ret;
>  
>  	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_LIGHT) {
> +			*val = 0;
> +			*val2 = 1;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		}
>  		ret = bu27008_get_scale(data, chan->scan_index == BU27008_IR,
>  					val, val2);
>  		if (ret)
> @@ -1231,15 +1434,13 @@ static const struct iio_trigger_ops bu27008_trigger_ops = {
>  	.reenable = bu27008_trigger_reenable,
>  };
>  
> +

Unrelated and probably unwanted change.

>  static irqreturn_t bu27008_trigger_handler(int irq, void *p)
>  {
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *idev = pf->indio_dev;
>  	struct bu27008_data *data = iio_priv(idev);
> -	struct {
> -		__le16 chan[BU27008_NUM_HW_CHANS];
> -		s64 ts __aligned(8);
> -	} raw;
> +	struct bu27008_buf raw;
>  	int ret, dummy;
>  
>  	memset(&raw, 0, sizeof(raw));
> @@ -1256,6 +1457,11 @@ static irqreturn_t bu27008_trigger_handler(int irq, void *p)
>  			       sizeof(raw.chan));
>  	if (ret < 0)
>  		goto err_read;

Blank line here appropriate given no block of unrelated code.

> +	if (test_bit(BU27008_LUX, idev->active_scan_mask)) {
> +		ret = bu27008_buffer_get_lux(data, &raw);
> +		if (ret)
> +			goto err_read;
> +	}
>  
>  	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>  err_read:
> 
> base-commit: 5e99f692d4e32e3250ab18d511894ca797407aec

