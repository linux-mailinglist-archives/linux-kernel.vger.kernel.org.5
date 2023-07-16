Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C733754EE6
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjGPNsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:48:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82486E71;
        Sun, 16 Jul 2023 06:48:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E32860C90;
        Sun, 16 Jul 2023 13:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06AA2C433C8;
        Sun, 16 Jul 2023 13:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689515313;
        bh=iT4f3iCd/KUaa4VNnDhB8rEKbhuOYRFO4HL9LhIvzH0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Z5AicpNfRuohhPLgNO5sx4G3wz2wjXTmcvNNEYG1v6AYMOEWNOGX/alByZAKTI6TO
         J/9vt/E+NpkdY6+NFYuF6s/5Vw2JG3Mb28bHQAO/dx/ttpBhu0oU5GmILI/tMxPCpn
         jwVh1mZBF9DNxFMjXVBVGuF1q3mOhDZRofTGJ7pEer68xUITDUVpioTZj1O+lNWlIt
         4ka2uzCKaLk+chnXMBMC3jjcJYY+WOz3ZyUAy9ImmwGxn3+CuUIu7BYolbJ4182Wpj
         zq+OY5qfFlWKBs27Gprci7oRKeotvPHefj/VHB4bzNWI+yLO7ip/SRoh7u3RDTgqgi
         aVabvLEY+qY2w==
Date:   Sun, 16 Jul 2023 14:48:27 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Roan van Dijk <roan@protonic.nl>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: chemical: scd4x: Add pressure compensation
Message-ID: <20230716144827.5b084922@jic23-huawei>
In-Reply-To: <20230711101419.2065107-1-roan@protonic.nl>
References: <20230711101419.2065107-1-roan@protonic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2023 12:14:19 +0200
Roan van Dijk <roan@protonic.nl> wrote:

> This patch adds pressure compensation to the scd4x driver. The pressure can
> be written to the sensor in hPa. The pressure will be compensated
> internally by the sensor.
> 
> Signed-off-by: Roan van Dijk <roan@protonic.nl>
Hi Roan,

I made a tiny tweak to alignment.. (see below) and applied to the togreg
branch of iio.git which I'll initially push out as testing for 0-day to
see if it can find anything we missed.

Thanks,

Jonathan

> ---
> 
> Changes since v2:
>  - Fix for kernel test robot errors of uninitialized symbols
>  - Changed pressure compensation to output channel instead of a channel
>    with calibbias
>  - Pressure can now be compensated during measurements
> 
>  drivers/iio/chemical/scd4x.c | 79 +++++++++++++++++++++++++++++++++---
>  1 file changed, 73 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/chemical/scd4x.c b/drivers/iio/chemical/scd4x.c
> index a4f22d926400..4bb5d215c54c 100644
> --- a/drivers/iio/chemical/scd4x.c
> +++ b/drivers/iio/chemical/scd4x.c
> @@ -36,6 +36,8 @@
>  #define SCD4X_WRITE_BUF_SIZE 5
>  #define SCD4X_FRC_MIN_PPM 0
>  #define SCD4X_FRC_MAX_PPM 2000
> +#define SCD4X_PRESSURE_COMP_MIN_MBAR 700
> +#define SCD4X_PRESSURE_COMP_MAX_MBAR 1200
>  #define SCD4X_READY_MASK 0x01
>  
>  /*Commands SCD4X*/
> @@ -45,6 +47,8 @@ enum scd4x_cmd {
>  	CMD_STOP_MEAS           = 0x3f86,
>  	CMD_SET_TEMP_OFFSET     = 0x241d,
>  	CMD_GET_TEMP_OFFSET     = 0x2318,
> +	CMD_SET_AMB_PRESSURE	= 0xe000,
> +	CMD_GET_AMB_PRESSURE	= 0xe000,
>  	CMD_FRC                 = 0x362f,
>  	CMD_SET_ASC             = 0x2416,
>  	CMD_GET_ASC             = 0x2313,
> @@ -137,7 +141,8 @@ static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
>  	 * Measurement needs to be stopped before sending commands.
>  	 * Except for reading measurement and data ready command.
>  	 */
> -	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS) &&
> +			(cmd != CMD_GET_AMB_PRESSURE)) {

Alignment here odd...

>  		ret = scd4x_send_command(state, CMD_STOP_MEAS);
>  		if (ret)
>  			return ret;
> @@ -166,7 +171,8 @@ static int scd4x_read(struct scd4x_state *state, enum scd4x_cmd cmd,
>  	}
>  
>  	/* start measurement */
> -	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS)) {
> +	if ((cmd != CMD_GET_DATA_READY) && (cmd != CMD_READ_MEAS) &&
> +			(cmd != CMD_GET_AMB_PRESSURE)) {
Also here

>  		ret = scd4x_send_command(state, CMD_START_MEAS);
>  		if (ret)
>  			return ret;
> @@ -188,9 +194,11 @@ static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t a
>  	buf[4] = crc;
>  
>  	/* measurement needs to be stopped before sending commands */
> -	ret = scd4x_send_command(state, CMD_STOP_MEAS);
> -	if (ret)
> -		return ret;
> +	if (cmd != CMD_SET_AMB_PRESSURE) {
> +		ret = scd4x_send_command(state, CMD_STOP_MEAS);
> +		if (ret)
> +			return ret;
> +	}
>  
>  	/* execution time */
>  	msleep_interruptible(500);
> @@ -200,7 +208,7 @@ static int scd4x_write(struct scd4x_state *state, enum scd4x_cmd cmd, uint16_t a
>  		return ret;
>  
>  	/* start measurement, except for forced calibration command */
> -	if (cmd != CMD_FRC) {
> +	if ((cmd != CMD_FRC) && (cmd != CMD_SET_AMB_PRESSURE)) {
>  		ret = scd4x_send_command(state, CMD_START_MEAS);
>  		if (ret)
>  			return ret;
> @@ -338,6 +346,18 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> +		if (chan->output) {
> +			mutex_lock(&state->lock);
> +			ret = scd4x_read(state, CMD_GET_AMB_PRESSURE, &tmp, sizeof(tmp));
> +			mutex_unlock(&state->lock);
> +
> +			if (ret)
> +				return ret;
> +
> +			*val = be16_to_cpu(tmp);
> +			return IIO_VAL_INT;
> +		}
> +
>  		ret = iio_device_claim_direct_mode(indio_dev);
>  		if (ret)
>  			return ret;
> @@ -386,6 +406,25 @@ static int scd4x_read_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +static const int scd4x_pressure_calibbias_available[] = {
> +	SCD4X_PRESSURE_COMP_MIN_MBAR, 1, SCD4X_PRESSURE_COMP_MAX_MBAR,
> +};
> +
> +static int scd4x_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    const int **vals, int *type, int *length, long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = scd4x_pressure_calibbias_available;
> +		*type = IIO_VAL_INT;
> +
> +		return IIO_AVAIL_RANGE;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +
>  static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
>  				int val, int val2, long mask)
>  {
> @@ -399,6 +438,21 @@ static int scd4x_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
>  		mutex_unlock(&state->lock);
>  
>  		return ret;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_PRESSURE:
> +			if (val < SCD4X_PRESSURE_COMP_MIN_MBAR ||
> +			    val > SCD4X_PRESSURE_COMP_MAX_MBAR)
> +				return -EINVAL;
> +
> +			mutex_lock(&state->lock);
> +			ret = scd4x_write(state, CMD_SET_AMB_PRESSURE, val);
> +			mutex_unlock(&state->lock);
> +
> +			return ret;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -503,9 +557,22 @@ static const struct iio_info scd4x_info = {
>  	.attrs = &scd4x_attr_group,
>  	.read_raw = scd4x_read_raw,
>  	.write_raw = scd4x_write_raw,
> +	.read_avail = scd4x_read_avail,
>  };
>  
>  static const struct iio_chan_spec scd4x_channels[] = {
> +	{
> +		/*
> +		 * this channel is special in a sense we are pretending that
> +		 * sensor is able to change measurement chamber pressure but in
> +		 * fact we're just setting pressure compensation value
> +		 */
> +		.type = IIO_PRESSURE,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +		.output = 1,
> +		.scan_index = -1,
> +	},
>  	{
>  		.type = IIO_CONCENTRATION,
>  		.channel2 = IIO_MOD_CO2,

