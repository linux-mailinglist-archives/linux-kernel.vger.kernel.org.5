Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 288D57B41EC
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 18:00:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjI3QAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234460AbjI3QAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 12:00:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEC7EB;
        Sat, 30 Sep 2023 09:00:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11892C433C7;
        Sat, 30 Sep 2023 16:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696089647;
        bh=GnDBtud2gOLs0KL+egFH2wAxcCUYgicSKPG1u0J6bFI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UoFsdHtr3HKzO4alyHJRv1nu+gt7fqTxEdx5hfy1nWv7dXqO23sPM9ZjMfz4s6H4T
         S5dowidN4SvRX8mZdWCuq425h4gB/E1QCc4+56Cp7PtOPwCHIJiXA88xW20CYFkeNu
         EUwuRVLcbA+ND/zZJpiCmAJL8Jbp5A2BUdqVweOvWTisGqDuUESYEHAJAYjicrJYiq
         F33xdZQEBEETxySGxp1NME8xGe1ccgOp2FIiMkmlpdukRTWnIhMrj1QOkIEPc71MHz
         SK1ybHWXMocM/BFMhZzSTY3OMNvQsWhEueaZvjLmeigyErep7YJior5oL5UGXH133d
         +OWN0vZsEvfkA==
Date:   Sat, 30 Sep 2023 17:00:46 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev,
        David Lechner <david@lechnology.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 26/27] staging: iio: resolver: ad2s1210: implement
 fault events
Message-ID: <20230930170046.36637e9c@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-26-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:31 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> When reading the position and velocity on the AD2S1210, there is also a
> 3rd byte following the two data bytes that contains the fault flag bits.
> This patch adds support for reading this byte and generating events when
> faults occur.
> 
> The faults are mapped to various channels and event types in order to
> have a unique event for each fault.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Use of x and y modifiers is a little odd.  What was your reasoning?
Was it just that there was a X_OR_Y modifier?  If so, don't use that!
It seemed like a good idea at the time, but it's not nice to deal with
and requires a channel with that modifier to hang the controls off
+ make sure userspace expects that event code.

> ---
> 
> v3 changes: This is a new patch in v3
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 175 +++++++++++++++++++++++++++++---
>  1 file changed, 161 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index e1c95ec73545..dc3cc3ab855e 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -21,6 +21,7 @@
>  #include <linux/types.h>
>  
>  #include <linux/iio/buffer.h>
> +#include <linux/iio/events.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
>  #include <linux/iio/trigger_consumer.h>
> @@ -35,6 +36,16 @@
>  #define AD2S1210_SET_ENRES		GENMASK(3, 2)
>  #define AD2S1210_SET_RES		GENMASK(1, 0)
>  
> +/* fault register flags */
> +#define AD2S1210_FAULT_CLIP		BIT(7)
> +#define AD2S1210_FAULT_LOS		BIT(6)
> +#define AD2S1210_FAULT_DOS_OVR		BIT(5)
> +#define AD2S1210_FAULT_DOS_MIS		BIT(4)
> +#define AD2S1210_FAULT_LOT		BIT(3)
> +#define AD2S1210_FAULT_VELOCITY		BIT(2)
> +#define AD2S1210_FAULT_PHASE		BIT(1)
> +#define AD2S1210_FAULT_CONFIG_PARITY	BIT(0)
> +
>  #define AD2S1210_REG_POSITION_MSB	0x80
>  #define AD2S1210_REG_POSITION_LSB	0x81
>  #define AD2S1210_REG_VELOCITY_MSB	0x82
> @@ -71,6 +82,8 @@
>  /* max voltage for threshold registers is 0x7F * 38 mV */
>  #define THRESHOLD_RANGE_STR "[0 38 4826]"
>  
> +#define FAULT_ONESHOT(bit, new, old) (new & bit && !(old & bit))
> +
>  enum ad2s1210_mode {
>  	MOD_POS = 0b00,
>  	MOD_VEL = 0b01,
> @@ -98,8 +111,13 @@ struct ad2s1210_state {
>  	unsigned long clkin_hz;
>  	/** The selected resolution */
>  	enum ad2s1210_resolution resolution;
> +	/** Copy of fault register from the previous read. */
> +	u8 prev_fault_flags;
>  	/** For reading raw sample value via SPI. */
> -	__be16 sample __aligned(IIO_DMA_MINALIGN);
> +	struct {
> +		__be16 raw;
> +		u8 fault;
> +	} sample __aligned(IIO_DMA_MINALIGN);;
>  	/** Scan buffer */
>  	struct {
>  		__be16 chan[2];
> @@ -158,7 +176,15 @@ static int ad2s1210_regmap_reg_write(void *context, unsigned int reg,
>  	if (ret < 0)
>  		return ret;
>  
> -	return spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
> +	ret = spi_sync_transfer(st->sdev, xfers, ARRAY_SIZE(xfers));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* soft reset also clears the fault register */
> +	if (reg == AD2S1210_REG_SOFT_RESET)
> +		st->prev_fault_flags = 0;
> +
> +	return 0;
>  }
>  
>  /*
> @@ -200,6 +226,10 @@ static int ad2s1210_regmap_reg_read(void *context, unsigned int reg,
>  	if (ret < 0)
>  		return ret;
>  
> +	/* reading the fault register also clears it */
> +	if (reg == AD2S1210_REG_FAULT)
> +		st->prev_fault_flags = 0;
> +
>  	/*
>  	 * If the D7 bit is set on any read/write register, it indicates a
>  	 * parity error. The fault register is read-only and the D7 bit means
> @@ -283,14 +313,92 @@ static ssize_t ad2s1210_clear_fault(struct device *dev,
>  	return ret < 0 ? ret : len;
>  }
>  
> -static int ad2s1210_single_conversion(struct ad2s1210_state *st,
> +static void ad2s1210_push_events(struct iio_dev *indio_dev,
> +				 u8 flags, s64 timestamp)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +
> +	/* Sine/cosine inputs clipped */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_CLIP, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_MOD_EVENT_CODE(IIO_ALTVOLTAGE, 1,
> +			       			  IIO_MOD_X_OR_Y,
Hmm. So this is a weird corner I'd forgotten about and explains your
use of X and Y modifiers. 
Long ago this was added to support a similar case to the one you have,
but mixing and matching modifiers like this doesn't scale, so
I think we'd be better just signally events on both channels.
If nothing else, someone waiting for an event on a specific channel
isn't looking for this weird modifier.

When it was used before we added a channel for MOD_X_OR_Y so events
were enabled on that. It's horrible though so don't do that.

> +						  IIO_EV_TYPE_MAG,
> +						  IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +	/* Sine/cosine inputs below LOS threshold */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_LOS, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_FALLING),
> +			       timestamp);
> +
> +	/* Sine/cosine inputs exceed DOS overrange threshold */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_DOS_OVR, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +
> +	/* Sine/cosine inputs exceed DOS mismatch threshold */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_DOS_MIS, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ALTVOLTAGE, 0,
> +						    IIO_EV_TYPE_MAG,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +	/* Tracking error exceeds LOT threshold */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_LOT, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ANGL, 1,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +
> +	/* Velocity exceeds maximum tracking rate */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_VELOCITY, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_ANGL_VEL, 0,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       timestamp);
> +
> +	/* Phase error exceeds phase lock range */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_PHASE, flags, st->prev_fault_flags))
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(IIO_PHASE, 0,
> +						    IIO_EV_TYPE_MAG,
> +						    IIO_EV_DIR_NONE),
> +			       timestamp);
> +
> +	/* Configuration parity error */
> +	if (FAULT_ONESHOT(AD2S1210_FAULT_CONFIG_PARITY, flags,
> +			  st->prev_fault_flags))
> +		/*
> +		 * Userspace should also get notified of this via error return
> +		 * when trying to write to any attribute that writes a register.
> +		 */
> +		dev_err_ratelimited(&indio_dev->dev,
> +				    "Configuration parity error\n");
> +
> +	st->prev_fault_flags = flags;
> +}
> +
> +static int ad2s1210_single_conversion(struct iio_dev *indio_dev,
>  				      struct iio_chan_spec const *chan,
>  				      int *val)
>  {
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	s64 timestamp;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
>  	gpiod_set_value(st->sample_gpio, 1);
> +	timestamp = iio_get_time_ns(indio_dev);
>  	/* delay (6 * tck + 20) nano seconds */
>  	udelay(1);
>  
> @@ -307,17 +415,17 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  	}
>  	if (ret < 0)
>  		goto error_ret;
> -	ret = spi_read(st->sdev, &st->sample, 2);
> +	ret = spi_read(st->sdev, &st->sample, 3);
>  	if (ret < 0)
>  		goto error_ret;
>  
>  	switch (chan->type) {
>  	case IIO_ANGL:
> -		*val = be16_to_cpu(st->sample);
> +		*val = be16_to_cpu(st->sample.raw);
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_ANGL_VEL:
> -		*val = (s16)be16_to_cpu(st->sample);
> +		*val = (s16)be16_to_cpu(st->sample.raw);
>  		ret = IIO_VAL_INT;
>  		break;
>  	default:
> @@ -325,6 +433,8 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  		break;
>  	}
>  
> +	ad2s1210_push_events(indio_dev, st->rx[2], timestamp);
> +
>  error_ret:
>  	gpiod_set_value(st->sample_gpio, 0);
>  	/* delay (2 * tck + 20) nano seconds */
> @@ -608,7 +718,7 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		return ad2s1210_single_conversion(st, chan, val);
> +		return ad2s1210_single_conversion(indio_dev, chan, val);
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
>  		case IIO_ANGL:
> @@ -721,6 +831,14 @@ static const struct iio_event_spec ad2s1210_position_event_spec[] = {
>  	},
>  };
>  
> +static const struct iio_event_spec ad2s1210_velocity_event_spec[] = {
> +	{
> +		/* Velocity exceeds maximum tracking rate fault. */
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +	},
> +};
> +
>  static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
>  	{
>  		/* Phase error fault. */
> @@ -754,6 +872,14 @@ static const struct iio_event_spec ad2s1210_monitor_signal_event_spec[] = {
>  	},
>  };
>  
> +static const struct iio_event_spec ad2s1210_sin_cos_event_spec[] = {
> +	{
> +		/* Sine/cosine clipping fault. */
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_NONE,
> +	},
> +};
> +
>  static const struct iio_chan_spec ad2s1210_channels[] = {
>  	{
>  		.type = IIO_ANGL,
> @@ -784,6 +910,8 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		},
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
> +		.event_spec = ad2s1210_velocity_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_velocity_event_spec),
>  	},
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  	{
> @@ -820,6 +948,26 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.scan_index = -1,
>  		.event_spec = ad2s1210_monitor_signal_event_spec,
>  		.num_event_specs = ARRAY_SIZE(ad2s1210_monitor_signal_event_spec),
> +	}, {
> +		/* sine input */
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.channel = 1,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_Y,
A bit odd and I'm not sure it's beneficial over just using an index
and a label for the channel. 

If a modifier is necessary then we could add a new one for this.
Another option might be to provide in_altvoltage0_phase 

or... can we map this to i (inphase) and q (quadrature) phases?
Sort of feels like we can, and those modifiers already exist.

Note though that if we do that, we'll need to modify the various
ABI docs etc to include the modifiers whenever it's about the sine
and cosine channels.

> +		.scan_index = -1,
> +		.event_spec = ad2s1210_sin_cos_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_sin_cos_event_spec),
> +	}, {
> +		/* cosine input */
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.channel = 1,
> +		.modified = 1,
> +		.channel2 = IIO_MOD_X,
> +		.scan_index = -1,
> +		.event_spec = ad2s1210_sin_cos_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_sin_cos_event_spec),
>  	},
>  };
>  
> @@ -936,7 +1084,7 @@ static const struct attribute_group ad2s1210_event_attribute_group = {
>  
>  static int ad2s1210_initial(struct ad2s1210_state *st)
>  {
> -	unsigned char data;
> +	unsigned int data;
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> @@ -1073,12 +1221,11 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>  		if (ret < 0)
>  			goto error_ret;
>  
> -		/* REVIST: we can read 3 bytes here and also get fault flags */
> -		ret = spi_read(st->sdev, st->rx, 2);
> +		ret = spi_read(st->sdev, &st->sample, 3);
>  		if (ret < 0)
>  			goto error_ret;
>  
> -		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
>  	}
>  
>  	if (test_bit(1, indio_dev->active_scan_mask)) {
> @@ -1086,14 +1233,14 @@ static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
>  		if (ret < 0)
>  			goto error_ret;
>  
> -		/* REVIST: we can read 3 bytes here and also get fault flags */
> -		ret = spi_read(st->sdev, st->rx, 2);
> +		ret = spi_read(st->sdev, &st->sample, 3);
>  		if (ret < 0)
>  			goto error_ret;
>  
> -		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +		memcpy(&st->scan.chan[chan++], &st->sample.raw, 2);
>  	}
>  
> +	ad2s1210_push_events(indio_dev, st->sample.fault, pf->timestamp);
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
>  
>  error_ret:
> 

