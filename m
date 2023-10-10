Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA907BF79B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:40:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230348AbjJJJk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjJJJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:40:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F83B9F;
        Tue, 10 Oct 2023 02:40:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F96DC433C7;
        Tue, 10 Oct 2023 09:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696930825;
        bh=E2xPENBRiIMEUR3iKFMwXUqnHFuFH4IyCJ1gJufNLVI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YdbObQNLlzrj/Znu7cE0dsejgV0oEqOmTQ43nOs6ilE8ithpjCzegSA4xZ9kz58EN
         O6Gji/blnDHTH+01P2xArQDH7AsYqIgTvdVHHwmJSctUsqm4iEnc+93cGzYl47iuwB
         SnVUvb7Y+5WlPqjbZO0ynwVrJRWHleLbnS1wpg7cCUKMeyLKDDdH/363qknWxCMc0G
         wH78k/GGinzGiEC3awsvDJhOuJeLtdtoQCKxwGW6r8hi+1tCb8nGiQM6Qgd0l9d7iT
         z5fryO+CPwE0vpcY/RZXXjMUOSRkShaPgn9UUk83aHDurdfod3lqWMBauicGkpPOpv
         54W7U2uPEt3yQ==
Date:   Tue, 10 Oct 2023 10:40:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: bu27008: Add processed illuminance channel
Message-ID: <20231010104037.4c23ba1d@jic23-huawei>
In-Reply-To: <07d2740d-d251-842c-ad9f-788fd2546110@gmail.com>
References: <ZRq4pdDn6N73n7BO@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
        <20231005161455.22d68c22@jic23-huawei>
        <07d2740d-d251-842c-ad9f-788fd2546110@gmail.com>
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

On Fri, 6 Oct 2023 08:01:15 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/5/23 18:14, Jonathan Cameron wrote:
> > On Mon, 2 Oct 2023 15:33:41 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >   
> >> The RGB + IR data can be used to calculate illuminance value (Luxes).
> >> Implement the equation obtained from the ROHM HW colleagues and add a
> >> light data channel outputting illuminance values in (nano) Luxes.  
> > Units in the ABI doc for illuminance are Lux, not nanolux.
> > I'm guessing that you actually provide it in Lux but via scale.
> > 
> > Make that clearer in this description if so.  
> 
> Yep. Also, the "processed" is misleading as I implement a raw channel. I 
> did originally think I'll only implement the read_raw (as I thought 
> we'll need all RGBC + IR and end up doing two accesses - which wouldn't 
> be nice due to the doubled measurement time). I actually did that and 
> used INT_PLUS_NANO. While implementing this I noticed the 'clear' data 
> was not used - and thought I might as well support buffering when RGB+IR 
> are enabled. I needed the scale to get the buffered values to decent 
> format though - so I converted channel to raw one and added scale. The 
> commit title still contains the 'processed' which reflects the original 
> thinking. Thanks for pointing out the confusion.
> 
> >> Both the read_raw and buffering values is supported, with the limitation
> >> that buffering is only allowed when suitable scan-mask is used. (RGB+IR,
> >> no clear).
> >>
> >> The equation has been developed by ROHM HW colleagues for open air sensor.
> >> Adding any lens to the sensor is likely to impact to the used c1, c2, c3
> >> coefficients. Also, The output values have only been tested on BU27008.
> >>
> >> According to the HW colleagues, the very same equation should work also
> >> on BU27010.
> >>
> >> Calculate and output illuminance values from BU27008 and BU27010.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >>  
> > 
> > A few comments inline, but in general looks fine to me.  
> 
> Thanks Jonathan. I had to give also the BU27008 sensor away for a while. 
> I guess I won't send the next version until I am able to do some very 
> basic testing even if the changes were minor. That's probably sometime 
> next week.
> 
> > 
> > Jonathan
> >   
> >> ---
> >>
> >> I did very dummy testing at very normal daylight inside a building. No
> >> special equipments were used - I simply compared values computed from
> >> BU27008 RGB+IR channels, to values displayed by the ALS in my mobile
> >> phone. Results were roughly the same (around 400 lux). Couldn't repeat
> >> test on BU27010, but the data it outputs should be same format as
> >> BU27008 data so equation should work for both sensors.
> >> ---
> >>   drivers/iio/light/rohm-bu27008.c | 216 ++++++++++++++++++++++++++++++-
> >>   1 file changed, 211 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iio/light/rohm-bu27008.c b/drivers/iio/light/rohm-bu27008.c
> >> index 6a6d77805091..d480cf761377 100644
> >> --- a/drivers/iio/light/rohm-bu27008.c
> >> +++ b/drivers/iio/light/rohm-bu27008.c
> >> @@ -130,6 +130,7 @@
> >>    * @BU27008_BLUE:	Blue channel. Via data2 (when used).
> >>    * @BU27008_CLEAR:	Clear channel. Via data2 or data3 (when used).
> >>    * @BU27008_IR:		IR channel. Via data3 (when used).
> >> + * @BU27008_LUX:	Illuminance channel, computed using RGB and IR.
> >>    * @BU27008_NUM_CHANS:	Number of channel types.
> >>    */
> >>   enum bu27008_chan_type {
> >> @@ -138,6 +139,7 @@ enum bu27008_chan_type {
> >>   	BU27008_BLUE,
> >>   	BU27008_CLEAR,
> >>   	BU27008_IR,
> >> +	BU27008_LUX,
> >>   	BU27008_NUM_CHANS
> >>   };
> >>   
> >> @@ -172,6 +174,8 @@ static const unsigned long bu27008_scan_masks[] = {
> >>   	ALWAYS_SCANNABLE | BIT(BU27008_CLEAR) | BIT(BU27008_IR),
> >>   	/* buffer is R, G, B, IR */
> >>   	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR),
> >> +	/* buffer is R, G, B, IR, LUX */
> >> +	ALWAYS_SCANNABLE | BIT(BU27008_BLUE) | BIT(BU27008_IR) | BIT(BU27008_LUX),
> >>   	0
> >>   };
> >>   
> >> @@ -331,6 +335,19 @@ static const struct iio_chan_spec bu27008_channels[] = {
> >>   	 * Hence we don't advertise available ones either.
> >>   	 */
> >>   	BU27008_CHAN(IR, DATA3, 0),
> >> +	{
> >> +		.type = IIO_LIGHT,
> >> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> >> +				      BIT(IIO_CHAN_INFO_SCALE),
> >> +		.channel = BU27008_LUX,
> >> +		.scan_index = BU27008_LUX,
> >> +		.scan_type = {
> >> +			.sign = 'u',
> >> +			.realbits = 64,
> >> +			.storagebits = 64,
> >> +			.endianness = IIO_CPU,
> >> +		},
> >> +	},
> >>   	IIO_CHAN_SOFT_TIMESTAMP(BU27008_NUM_CHANS),
> >>   };
> >>   
> >> @@ -1004,6 +1021,183 @@ static int bu27008_read_one(struct bu27008_data *data, struct iio_dev *idev,
> >>   	return ret;
> >>   }
> >>   
> >> +static int bu27008_get_rgb_ir(struct bu27008_data *data, unsigned int *red,
> >> +		    unsigned int *green, unsigned int *blue, unsigned int *ir)
> >> +{
> >> +	int ret, chan_sel, int_time, tmpret, valid;
> >> +	__le16 chans[BU27008_NUM_HW_CHANS];
> >> +
> >> +	chan_sel = BU27008_BLUE2_IR3 << (ffs(data->cd->chan_sel_mask) - 1);
> >> +
> >> +	ret = regmap_update_bits(data->regmap, data->cd->chan_sel_reg,
> >> +				 data->cd->chan_sel_mask, chan_sel);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = bu27008_meas_set(data, true);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret = bu27008_get_int_time_us(data);
> >> +	if (ret < 0)
> >> +		int_time = BU27008_MEAS_TIME_MAX_MS;
> >> +	else
> >> +		int_time = ret / USEC_PER_MSEC;
> >> +
> >> +	msleep(int_time);
> >> +
> >> +	ret = regmap_read_poll_timeout(data->regmap, data->cd->valid_reg,
> >> +				       valid, (valid & BU27008_MASK_VALID),
> >> +				       BU27008_VALID_RESULT_WAIT_QUANTA_US,
> >> +				       BU27008_MAX_VALID_RESULT_WAIT_US);
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	ret = regmap_bulk_read(data->regmap, BU27008_REG_DATA0_LO, chans,
> >> +			       sizeof(chans));
> >> +	if (ret)
> >> +		goto out;
> >> +
> >> +	*red = le16_to_cpu(chans[0]);
> >> +	*green = le16_to_cpu(chans[1]);
> >> +	*blue = le16_to_cpu(chans[2]);
> >> +	*ir = le16_to_cpu(chans[3]);  
> > 
> > I'd be tempted to use an array + definitely pass them as u16 rather
> > than unsigned int.  
> 
> I'm not really convinced the u16 is better here. We need the 32 bits 
> later for the calculations - and (afaics) using natural size int for 
> arguments shouldn't harm. We read the channel data to correct type array 
> so code should be pretty clear as to what we have in HW.

ok.  I don't like lack of range clamping - so at the point of the caller
I can't immediately see that these will be sub 16bit value.  Not htat
important I guess.

> 
> Also, I think that having an array obfuscates what element is which 
> channel because these ICs didn't have the 1 to 1 mapping from channel 
> index to colour. I was thinking of adding a struct for this but decided 
> to just keep it simple and clear.
A struct or array + enum would work. 
I just don't much like lots of very similar parameters. 
> 
> >> +
> >> +out:
> >> +	tmpret = bu27008_meas_set(data, false);
> >> +	if (tmpret)
> >> +		dev_warn(data->dev, "Stopping measurement failed\n");
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +/*
> >> + * Following equation for computing lux out of register values was given by
> >> + * ROHM HW colleagues;
> >> + *
> >> + * Red = RedData*1024 / Gain * 20 / meas_mode
> >> + * Green = GreenData* 1024 / Gain * 20 / meas_mode
> >> + * Blue = BlueData* 1024 / Gain * 20 / meas_mode
> >> + * IR = IrData* 1024 / Gain * 20 / meas_mode
> >> + *
> >> + * where meas_mode is the integration time in mS / 10
> >> + *
> >> + * IRratio = (IR > 0.18 * Green) ? 0 : 1
> >> + *
> >> + * Lx = max(c1*Red + c2*Green + c3*Blue,0)
> >> + *
> >> + * for
> >> + * IRratio 0: c1 = -0.00002237, c2 = 0.0003219, c3 = -0.000120371
> >> + * IRratio 1: c1 = -0.00001074, c2 = 0.000305415, c3 = -0.000129367
> >> + */
> >> +
> >> +/*
> >> + * The max chan data is 0xffff. When we multiply it by 1024 * 20, we'll get
> >> + * 0x4FFFB000 which still fits in 32-bit integer. So this can't overflow.
> >> + */
> >> +#define NORM_CHAN_DATA_FOR_LX_CALC(chan, gain, time) ((chan) * 1024 * 20 / \
> >> +				   (gain) / (time))
> >> +static u64 bu27008_calc_nlux(struct bu27008_data *data, unsigned int red,
> >> +		unsigned int green, unsigned int blue,  unsigned int ir,
> >> +		unsigned int gain, unsigned int gain_ir, unsigned int time)
> >> +{
> >> +	s64 c1, c2, c3, nlux;
> >> +
> >> +	time /= 10000;
> >> +	ir = NORM_CHAN_DATA_FOR_LX_CALC(ir, gain_ir, time);
> >> +	red = NORM_CHAN_DATA_FOR_LX_CALC(red, gain, time);
> >> +	green = NORM_CHAN_DATA_FOR_LX_CALC(green, gain, time);
> >> +	blue = NORM_CHAN_DATA_FOR_LX_CALC(blue, gain, time);  
> 
> > I'd prefer to see the inputs parameters and the normalized version given different
> > names. Also the inputs are still u16, so nice to reflect that here.  
> 
> So, you suggest we bring the data as u16 until here and only here we 
> assign it into 32bit variables when doing the 'normalization'? I'm sure 
> it works, but I dislike doing computations like multiplying u16 by u32 
> as I never know (out of my head) how the implicit type conversions work 
> and if we get some results cropped. Adding the casts to computation make 
> it less pretty for my eyes while having all variables in large enough 
> types does not leave me wondering if it works correctly and if explicit 
> casts are needed.
> 
> I am not strongly opposing this though if you insist - I am sure I can 
> at the end of the day get the code right - but I am afraid I will later 
> look at the code and wonder if it contains hideous issues...

This isn't particularly important either way.  My gut would have
been to keep them as __le16 to the point where the maths happens
but I don't mind it happening elsewhere.

I do want different names though given the inputs and outputs are
different 'things'.


> 
> > Also when doing normalization I'd used fixed with types so there is no
> > confusion over what was intended (here u32)  
> 
> Ok.
> 
> >   
> >> +
> >> +	if ((u64)ir * 100LLU > 18LLU * (u64)green) {  
> > 
> > Putting scaling for ir to the right and green to the left is
> > unusual. I'd chose one side and stick to it.  
> 
> Sorry Jonathan. I must be a bit slow today but I just seem to not be 
> able to think how you would like to have this? I think this line is 
> somehow mappable to the:

if ((u64)ir * 100LLU > (u64)green * 18LLU)
or
if ((100LLU * (u64)ir > 18LLU * (u64)green)

Either is fine.  Just don't like the scaling from different sides of
the variable.  I can see how you got there from 0.18 * Green but equally
valid to premultiply by 100 as it is to post multiply (when doing the
maths on paper).

> 
> IRratio = (IR > 0.18 * Green) ? 0 : 1
> formula I got from HW colleagues and added in the comment preceding the 
> function.
> 
