Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0C7C00C6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232713AbjJJPv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbjJJPv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:51:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2406093;
        Tue, 10 Oct 2023 08:51:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285FBC433C8;
        Tue, 10 Oct 2023 15:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696953115;
        bh=xhENSz7grzwpdlCR8twYps66OvcRA8IE/MCD3LioT8s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R/EgA2rrrAVQ+K71H6Oo2lYI5oY+tr7fyaNgH+u+ctOVU2EGzPoEU0jfmG975O6lL
         o7CGz6bZ3B5N/fMwTs9DJ1UKQRCswnd+Jt3DwVfmU/xjhkhq1sI8eiAPuOfchp6miD
         mhRJryjQjxjEUBJusNPUrGakk0KcKlbUocjRz/dYweq7u4AkiLKs10TOMj3ywSqEAf
         wr8g43/WM81cUNTqkloKa05nZjYI1Zhf9Y0RXHFLWZF0RkU0lDTNKUwNNk++atmdtJ
         hDbqJmZGYgiFucYG6CuvyaTWj5QV8kZc6g0zKQTvgM+Z6Xwpjk+eLHEKE0JQQ0Hz+4
         xI0SbrnGwniKw==
Date:   Tue, 10 Oct 2023 16:52:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 08/17] staging: iio: resolver: ad2s1210: convert LOS
 threshold to event attr
Message-ID: <20231010165206.7096de4f@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-8-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-8-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:25 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 has a programmable threshold for the loss of signal (LOS)
> fault. This fault is triggered when either the sine or cosine input
> falls below the threshold voltage.
> 
> This patch converts the custom device LOS threshold attribute to an
> event falling edge threshold attribute on a new monitor signal channel.
> The monitor signal is an internal signal that combines the amplitudes
> of the sine and cosine inputs as well as the current angle and position
> output. This signal is used to detect faults in the input signals.
> 
> The attribute now uses millivolts instead of the raw register value in
> accordance with the IIO ABI.

Hmm. The ABI is a bit ambigious on this front.  When we have 'normal'
device attributes we tend to use the presence of _scale attributes
to scale both raw channels and the events associated with them.
I don't think we talk about what to do if that isn't available or
what happens for 'processed' channels - i.e. the ones already in
base units because those tend not to have associated events (as their
is normally nasty maths involved that is only sometimes reversible.)

We may want to clarify the ABI on this, but this is definitely
a valid option given there is no _scale for the channel.

Hence in interests of moving forwards I'm going to apply it.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to poke at it.

Thanks,

Jonathan

> 
> Emitting the event will be implemented in a later patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> 
> v4 changes:
> * Fixed missing static qualifier on attribute definition.
> 
> v3 changes: This is a new patch in v3
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 76 +++++++++++++++++++++++++++++++--
>  1 file changed, 72 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 12437f697f79..d52aed30ca66 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -66,6 +66,11 @@
>  #define PHASE_360_DEG_TO_RAD_INT 6
>  #define PHASE_360_DEG_TO_RAD_MICRO 283185
>  
> +/* Threshold voltage registers have 1 LSB == 38 mV */
> +#define THRESHOLD_MILLIVOLT_PER_LSB 38
> +/* max voltage for threshold registers is 0x7F * 38 mV */
> +#define THRESHOLD_RANGE_STR "[0 38 4826]"
> +
>  enum ad2s1210_mode {
>  	MOD_POS = 0b00,
>  	MOD_VEL = 0b01,
> @@ -451,6 +456,38 @@ static const int ad2s1210_lot_threshold_urad_per_lsb[] = {
>  	1237, /* 16-bit: same as 14-bit */
>  };
>  
> +static int ad2s1210_get_voltage_threshold(struct ad2s1210_state *st,
> +					  unsigned int reg, int *val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, reg, &reg_val);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = reg_val * THRESHOLD_MILLIVOLT_PER_LSB;
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad2s1210_set_voltage_threshold(struct ad2s1210_state *st,
> +					  unsigned int reg, int val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	reg_val = val / THRESHOLD_MILLIVOLT_PER_LSB;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_write(st->regmap, reg, reg_val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static int ad2s1210_get_lot_high_threshold(struct ad2s1210_state *st,
>  					   int *val, int *val2)
>  {
> @@ -710,9 +747,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  static IIO_DEVICE_ATTR(fault, 0644,
>  		       ad2s1210_show_fault, ad2s1210_clear_fault, 0);
>  
> -static IIO_DEVICE_ATTR(los_thrd, 0644,
> -		       ad2s1210_show_reg, ad2s1210_store_reg,
> -		       AD2S1210_REG_LOS_THRD);
>  static IIO_DEVICE_ATTR(dos_ovr_thrd, 0644,
>  		       ad2s1210_show_reg, ad2s1210_store_reg,
>  		       AD2S1210_REG_DOS_OVR_THRD);
> @@ -749,6 +783,16 @@ static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
>  	},
>  };
>  
> +static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
> +	{
> +		/* Sine/cosine below LOS threshold fault. */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		/* Loss of signal threshold. */
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
>  static const struct iio_chan_spec ad2s1210_channels[] = {
>  	{
>  		.type = IIO_ANGL,
> @@ -807,12 +851,19 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.scan_index = -1,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),
>  		.info_mask_separate_available = BIT(IIO_CHAN_INFO_FREQUENCY),
> +	}, {
> +		/* monitor signal */
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = -1,
> +		.event_spec = ad2s1210_monitor_signal_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_monitor_signal_event_spec),
>  	},
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
>  	&iio_dev_attr_fault.dev_attr.attr,
> -	&iio_dev_attr_los_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_ovr_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_mis_thrd.dev_attr.attr,
>  	&iio_dev_attr_dos_rst_max_thrd.dev_attr.attr,
> @@ -851,11 +902,14 @@ static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
>  		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
>  		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
>  		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
> +static IIO_CONST_ATTR(in_altvoltage0_thresh_falling_value_available,
> +		      THRESHOLD_RANGE_STR);
>  static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_value_available, 0);
>  static IIO_DEVICE_ATTR_RO(in_angl1_thresh_rising_hysteresis_available, 0);
>  
>  static struct attribute *ad2s1210_event_attributes[] = {
>  	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
> +	&iio_const_attr_in_altvoltage0_thresh_falling_value_available.dev_attr.attr,
>  	&iio_dev_attr_in_angl1_thresh_rising_value_available.dev_attr.attr,
>  	&iio_dev_attr_in_angl1_thresh_rising_hysteresis_available.dev_attr.attr,
>  	NULL,
> @@ -908,6 +962,13 @@ static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_ALTVOLTAGE:
> +		if (chan->output)
> +			return -EINVAL;
> +		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
> +			return ad2s1210_get_voltage_threshold(st,
> +						AD2S1210_REG_LOS_THRD, val);
> +		return -EINVAL;
>  	case IIO_PHASE:
>  		return ad2s1210_get_phase_lock_range(st, val, val2);
>  	default:
> @@ -934,6 +995,13 @@ static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_ALTVOLTAGE:
> +		if (chan->output)
> +			return -EINVAL;
> +		if (type == IIO_EV_TYPE_THRESH && dir == IIO_EV_DIR_FALLING)
> +			return ad2s1210_set_voltage_threshold(st,
> +						AD2S1210_REG_LOS_THRD, val);
> +		return -EINVAL;
>  	case IIO_PHASE:
>  		return ad2s1210_set_phase_lock_range(st, val, val2);
>  	default:
> 

