Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698607C00D7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJJPyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbjJJPyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:54:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C78B6;
        Tue, 10 Oct 2023 08:54:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 444C3C433C8;
        Tue, 10 Oct 2023 15:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953268;
        bh=334TTwxYglUekaWMsB57+v0igvm5gfyOdjtAHmB47f0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HWdV+Zob0M5WKuLZR4gcG9h90d4SXgbgZneqSfxewUusUDtgHzlH/OtdYaqsZCXvH
         dg1sOD8YxMpEU1MyJlKowBQ0LV+bPlcBbC67/8F2a+J1Mozz30kd+4wRkoLhzEDdqK
         TBKMmW0r4S28zHiC7XLPxMzT/gxJXn7L1I4BlfomQA/0vtUmrOD+ybU49t0p/QKxRN
         UcGpKL2Llm4TfDaQkPWzbNG027Ul+gYsE88RLrWJ/DvQuwToZ29XUDY7wPZBuDOEFw
         GYVNL3VSILIjsaUEoGjZTN5Tl+sWRlZ8ODk/Q4rU/BXTB8j/mhyZaSbxfIgCP6CHwy
         2GWWCeNUzmzEA==
Date:   Tue, 10 Oct 2023 16:54:41 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 07/17] staging: iio: resolver: ad2s1210: convert LOT
 threshold attrs to event attrs
Message-ID: <20231010165441.10e17a1c@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-7-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-7-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:24 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 monitors the internal error signal (difference between
> estimated angle and measured angle) to determine a loss of position
> tracking (LOT) condition. When the error value exceeds a threshold, a
> fault is triggered. This threshold is user-configurable.
> 
> This patch converts the custom lot_high_thrd and lot_low_thrd attributes
> in the ad2s1210 driver to standard event attributes. This will allow
> tooling to be able to expose these in a generic way.
> 
> Since the low threshold determines the hysteresis, it requires some
> special handling to expose the difference between the high and low
> register values as the hysteresis instead of exposing the low register
> value directly.
> 
> The attributes also return the values in radians now as required by the
> ABI.
> 
> Actually emitting the fault event will be done in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
I noticed it first on next patch, but we are a bit vague on what the units
of event thresholds are - normally tracking an associated channel.  That
gets tricky if there isn't an associated channel read facility.

I've applied this anyway, but we may want to think a bit more on that.
One approach is to add IIO_CHAN_INFO_SCALE and read_raw support for these
channels. 

Not what you have here is valid without one of those because absence
of _scale, means _scale == 1 anyway so we are good with having these
in radians.

Jonathan

> ---
> 
> v4 changes:
> * Fixed missing static qualifier on attribute definition.
> 
> v3 changes: This is a new patch in v3
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 191 ++++++++++++++++++++++++++++++--
>  1 file changed, 183 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 4d651a2d0f38..12437f697f79 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -443,6 +443,123 @@ static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
>  	return ret;
>  }
>  
> +/* map resolution to microradians/LSB for LOT registers */
> +static const int ad2s1210_lot_threshold_urad_per_lsb[] = {
> +	6184, /* 10-bit: ~0.35 deg/LSB, 45 deg max */
> +	2473, /* 12-bit: ~0.14 deg/LSB, 18 deg max */
> +	1237, /* 14-bit: ~0.07 deg/LSB, 9 deg max */
> +	1237, /* 16-bit: same as 14-bit */
> +};
> +
> +static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
> +					   int *val, int *val2)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = 0;
> +	*val2 = reg_val * ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad2s1210_set_lot_high_threshold(struct ad2s1210_state *st,
> +					   int val, int val2)
> +{
> +	unsigned int high_reg_val, low_reg_val, hysteresis;
> +	int ret;
> +
> +	/* all valid values are between 0 and pi/4 radians */
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	/*
> +	 * We need to read both high and low registers first so we can preserve
> +	 * the hysteresis.
> +	 */
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	hysteresis = high_reg_val - low_reg_val;
> +	high_reg_val = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +	low_reg_val = high_reg_val - hysteresis;
> +
> +	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, high_reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD, low_reg_val);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
> +static int ad2s1210_get_lot_low_threshold(struct ad2s1210_state *st,
> +					  int *val, int *val2)
> +{
> +	unsigned int high_reg_val, low_reg_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &high_reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_LOW_THRD, &low_reg_val);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	/* sysfs value is hysteresis rather than actual low value */
> +	*val = 0;
> +	*val2 = (high_reg_val - low_reg_val) *
> +		ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad2s1210_set_lot_low_threshold(struct ad2s1210_state *st,
> +					  int val, int val2)
> +{
> +	unsigned int reg_val, hysteresis;
> +	int ret;
> +
> +	/* all valid values are between 0 and pi/4 radians */
> +	if (val != 0)
> +		return -EINVAL;
> +
> +	hysteresis = val2 / ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_LOT_HIGH_THRD, &reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	ret = regmap_write(st->regmap, AD2S1210_REG_LOT_LOW_THRD,
> +			   reg_val - hysteresis);
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
>  {
>  	unsigned int reg_val;
> @@ -608,12 +725,19 @@ static IIO_DEVICE_ATTR(dos_rst_max_thrd, 0644,
>  static IIO_DEVICE_ATTR(dos_rst_min_thrd, 0644,
>  		       ad2s1210_show_reg, ad2s1210_store_reg,
>  		       AD2S1210_REG_DOS_RST_MIN_THRD);
> -static IIO_DEVICE_ATTR(lot_high_thrd, 0644,
> -		       ad2s1210_show_reg, ad2s1210_store_reg,
> -		       AD2S1210_REG_LOT_HIGH_THRD);
> -static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
> -		       ad2s1210_show_reg, ad2s1210_store_reg,
> -		       AD2S1210_REG_LOT_LOW_THRD);
> +
> +static const struct iio_event_spec ad2s1210_position_event_spec[] = {
> +	{
> +		/* Tracking error exceeds LOT threshold fault. */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate =
> +			/* Loss of tracking high threshold. */
> +			BIT(IIO_EV_INFO_VALUE) |
> +			/* Loss of tracking low threshold. */
> +			BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +};
>  
>  static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
>  	{
> @@ -657,6 +781,15 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  				      BIT(IIO_CHAN_INFO_SCALE),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
> +	{
> +		/* used to configure LOT thresholds and get tracking error */
> +		.type = IIO_ANGL,
> +		.indexed = 1,
> +		.channel = 1,
> +		.scan_index = -1,
> +		.event_spec = ad2s1210_position_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_position_event_spec),
> +	},
>  	{
>  		/* used to configure phase lock range and get phase lock error */
>  		.type = IIO_PHASE,
> @@ -684,8 +817,6 @@ static struct attribute *ad2s1210_attributes[] = {
>  	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_rst_min_thrd.dev_attr.attr,
> -	&iio_dev_attr_lot_high_thrd.dev_attr.attr,
> -	&iio_dev_attr_lot_low_thrd.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -693,14 +824,40 @@ static const struct attribute_group ad2s1210_attribute_group = {
>  	.attrs = ad2s1210_attributes,
>  };
>  
> +static ssize_t
> +in_angl1_thresh_rising_value_available_show(struct device *dev,
> +					    struct device_attribute *attr,
> +					    char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int step = ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +
> +	return sysfs_emit(buf, "[0 0.%06d 0.%06d]\n", step, step * 0x7F);
> +}
> +
> +static ssize_t
> +in_angl1_thresh_rising_hysteresis_available_show(struct device *dev,
> +						 struct device_attribute *attr,
> +						 char *buf)
> +{
> +	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> +	int step = ad2s1210_lot_threshold_urad_per_lsb[st->resolution];
> +
> +	return sysfs_emit(buf, "[0 0.%06d 0.%06d]\n", step, step * 0x7F);
> +}
> +
>  static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
>  		      __stringify(PHASE_44_DEG_TO_RAD_INT) "."
>  		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
>  		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
>  		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
> +static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
> +static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
>  
>  static struct attribute *ad2s1210_event_attributes[] = {
>  	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
> +	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
> +	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
>  	NULL,
>  };
>  
> @@ -742,6 +899,15 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
>  	struct ad2s1210_state *st = iio_priv(indio_dev);
>  
>  	switch (chan->type) {
> +	case IIO_ANGL:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			return ad2s1210_get_lot_high_threshold(st, val, val2);
> +		case IIO_EV_INFO_HYSTERESIS:
> +			return ad2s1210_get_lot_low_threshold(st, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_PHASE:
>  		return ad2s1210_get_phase_lock_range(st, val, val2);
>  	default:
> @@ -759,6 +925,15 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
>  	struct ad2s1210_state *st = iio_priv(indio_dev);
>  
>  	switch (chan->type) {
> +	case IIO_ANGL:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			return ad2s1210_set_lot_high_threshold(st, val, val2);
> +		case IIO_EV_INFO_HYSTERESIS:
> +			return ad2s1210_set_lot_low_threshold(st, val, val2);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_PHASE:
>  		return ad2s1210_set_phase_lock_range(st, val, val2);
>  	default:
> 

