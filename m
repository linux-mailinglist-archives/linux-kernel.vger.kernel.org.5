Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F347D1DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 17:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjJUPkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 11:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJUPkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 11:40:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8441114;
        Sat, 21 Oct 2023 08:40:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874C6C433C8;
        Sat, 21 Oct 2023 15:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697902806;
        bh=9oBWi/LxSvLSdGfAsKVuFgUhgXmjZH7LyHx+eKijLpM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pCdiicmjOh01qke14D0Co52yKXNzmFSdbfDkYhVNjwCnoIjl6Lucy/tXNEVv8XKv1
         jaiHjEm27THnrdHt0tk17BB6q5uwUat5YJJYW5R/mRd4EVZxucMz5IytT44op7QNDF
         KiB+W3zLe3xVtQU8rYBg3eB4o13PU+QvhPr+UEwxt15IeFumehpRNRJyWIySP+6pPr
         +IfJs79ZrWMVOUNHp4XKI9ERD9Ux6jlztm+wArksvlCimrAdQCOrg9yi28cIqOA4UP
         mX+geboAGfkzKv7QPNxyX2Q4HktPhmrn+/fsbp/3NbfrTe9P1EzYrQv2wrzGxDM8+F
         tpaHCb1zebhSQ==
Date:   Sat, 21 Oct 2023 16:40:00 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: bu27008: Add illuminance channel
Message-ID: <20231021164000.7b07b839@jic23-huawei>
In-Reply-To: <ZTJcOxSb/WHzdN8h@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZTJcOxSb/WHzdN8h@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
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

On Fri, 20 Oct 2023 13:53:47 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The RGB + IR data can be used to calculate the illuminance value (luxes).
> Implement the equation obtained from the ROHM HW colleagues and add a
> raw light data channel outputting illuminance values in (nano) Luxes.
> 
> Both the read_raw and buffering values are supported, with the limitation
> that buffering is only allowed when a suitable scan-mask is used. (RGB+IR,
> no clear).
> 
> The equation has been developed by ROHM HW colleagues for open air sensor.
> Adding any lens to the sensor is likely to impact to used c1, c2, c3
> coefficients. Also, the output values have only been tested on BU27008.
> 
> According to the HW colleagues, the very same equation should work on
> BU27010 as well.
> 
> Calculate and output illuminance values from BU27008 and BU27010.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
LGTM.
Applied to the togreg branch of iio.git but that will only be pushed out
as testing until after the merge window closes and I can rebase on rc1.

Thanks,

Jonathan

> 
> ---
> Revision history:
> v1 => v2:
> - reduce lux function parameters using an array
> - streamline code by converting channel data to meaningful values in
>   bu27008_calc_nlux() for both the raw read and buffering
> - some minor styling
> 
> I did very dummy testing at very normal daylight inside a building. No
> special equipments were used - I simply compared values computed from
> BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
> phone. Results were roughly the same (around 400 lux). Couldn't repeat
> test on BU27010, but the data it outputs should be same format as
> BU27008 data so equation should work for both sensors.
> ---
>  drivers/iio/light/rohm-bu27008.c | 201 ++++++++++++++++++++++++++++++-
>  1 file changed, 196 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> index 6a6d77805091..0f010eff1981 100644
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
> @@ -1004,6 +1021,169 @@ static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
>  	return ret;
>  }
>  
> +#define BU27008_LUX_DATA_RED	0
> +#define BU27008_LUX_DATA_GREEN	1
> +#define BU27008_LUX_DATA_BLUE	2
> +#define BU27008_LUX_DATA_IR	3
> +#define LUX_DATA_SIZE (BU27008_NUM_HW_CHANS * sizeof(__le16))
> +
> +static int bu27008_read_lux_chans(struct bu27008_data *data, unsigned int time,
> +				  __le16 *chan_data)
> +{
> +	int ret, chan_sel, tmpret, valid;
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
> +	msleep(time / USEC_PER_MSEC);
> +
> +	ret = regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
> +				       valid, (valid & BU27008_MASK_VALID),
> +				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
> +				       BU27008_MAX_VALID_RESULT_WAIT_US);
> +	if (ret)
> +		goto out;
> +
> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chan_data,
> +			       LUX_DATA_SIZE);
> +	if (ret)
> +		goto out;
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
> + * 0x4FFFB000 which still fits in 32-bit integer. This won't overflow.
> + */
> +#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) (le16_to_cpu(chan) * \
> +				   1024 * 20 / (gain) / (time))
> +static u64 bu27008_calc_nlux(struct bu27008_data *data, __le16 *lux_data,
> +		unsigned int gain, unsigned int gain_ir, unsigned int time)
> +{
> +	unsigned int red, green, blue, ir;
> +	s64 c1, c2, c3, nlux;
> +
> +	time /= 10000;
> +	ir = NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_IR], gain_ir, time);
> +	red = NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_RED], gain, time);
> +	green = NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_GREEN], gain, time);
> +	blue = NORM_CHAN_DATA_FOR_LX_CALC(lux_data[BU27008_LUX_DATA_BLUE], gain, time);
> +
> +	if ((u64)ir * 100LLU > (u64)green * 18LLU) {
> +		c1 = -22370;
> +		c2 = 321900;
> +		c3 = -120371;
> +	} else {
> +		c1 = -10740;
> +		c2 = 305415;
> +		c3 = -129367;
> +	}
> +	nlux = c1 * red + c2 * green + c3 * blue;
> +
> +	return max_t(s64, 0, nlux);
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
> +	/* Max integration time is 400000. Fits in signed int. */
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
> +static int bu27008_buffer_fill_lux(struct bu27008_data *data,
> +				   struct bu27008_buf *raw)
> +{
> +	unsigned int gain, gain_ir, time;
> +	int ret;
> +
> +	ret = bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
> +	if (ret)
> +		return ret;
> +
> +	raw->lux = bu27008_calc_nlux(data, raw->chan, gain, gain_ir, time);
> +
> +	return 0;
> +}
> +
> +static int bu27008_read_lux(struct bu27008_data *data, struct iio_dev *idev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2)
> +{
> +	__le16 lux_data[BU27008_NUM_HW_CHANS];
> +	unsigned int gain, gain_ir, time;
> +	u64 nlux;
> +	int ret;
> +
> +	ret = bu27008_get_time_n_gains(data, &gain, &gain_ir, &time);
> +	if (ret)
> +		return ret;
> +
> +	ret = bu27008_read_lux_chans(data, time, lux_data);
> +	if (ret)
> +		return ret;
> +
> +	nlux = bu27008_calc_nlux(data, lux_data, gain, gain_ir, time);
> +	*val = (int)nlux;
> +	*val2 = nlux >> 32LLU;
> +
> +	return IIO_VAL_INT_64;
> +}
> +
>  static int bu27008_read_raw(struct iio_dev *idev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -1018,7 +1198,10 @@ static int bu27008_read_raw(struct iio_dev *idev,
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
> @@ -1026,6 +1209,11 @@ static int bu27008_read_raw(struct iio_dev *idev,
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
> @@ -1236,10 +1424,7 @@ static irqreturn_t bu27008_trigger_handler(int irq, void *p)
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
> @@ -1257,6 +1442,12 @@ static irqreturn_t bu27008_trigger_handler(int irq, void *p)
>  	if (ret < 0)
>  		goto err_read;
>  
> +	if (test_bit(BU27008_LUX, idev->active_scan_mask)) {
> +		ret = bu27008_buffer_fill_lux(data, &raw);
> +		if (ret)
> +			goto err_read;
> +	}
> +
>  	iio_push_to_buffers_with_timestamp(idev, &raw, pf->timestamp);
>  err_read:
>  	iio_trigger_notify_done(idev->trig);
> 
> base-commit: 89e2233386a5670d15908628b63e611cb03b0d03

