Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972497C009E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjJJPqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjJJPqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:46:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E23A7;
        Tue, 10 Oct 2023 08:46:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65C0C433C8;
        Tue, 10 Oct 2023 15:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952766;
        bh=ImEYFz8ygZcDyI9Y0wXuf3tlwRqjI0LopJdMlkC0WlQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HHrZT8ujsyLGQ4Qk5PYkYw6XVdKNEv6AMtFl3opxCPW8EyMc8O2voIEy+7TebOIRy
         GQZ5uwIFYpTvbbjg22bfY9jB5u2b/8PPNd5hoMekZYSVAOGaKw7Tks4N55nhmy5+KM
         Xn0UEa6Qx7I3iEHU+pXgdPmxbpi5TP+tbFHFtMPxvzH8MPnZsXLWoYcHsWNaCOkuhQ
         1DaSinH+BxxprlhlP6QoBE5vhKXLW+P6Uegi89i5IF8hDn3CEc9IJA8S5DofvSHuk/
         pJW3eWU4YQCTlvlG7b+r9CD93z2rvv8vbXgpZD6/L0gqMTWTwyq+GKvqW4qViTtoeR
         w8XKurVXKHhOQ==
Date:   Tue, 10 Oct 2023 16:46:17 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/17] staging: iio: resolver: ad2s1210: add phase
 lock range support
Message-ID: <20231010164617.7c318d9b@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-5-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-5-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 chip has a phase lock range feature that allows selecting
> the allowable phase difference between the excitation output and the
> sine and cosine inputs. This can be set to either 44 degrees (default)
> or 360 degrees.
> 
> This patch adds a new phase channel with a phase0_mag_rising event that
> can be used to configure the phase lock range. Actually emitting the
> event will be added in a subsequent patch.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

Whilst I'm not feeling totally happy with some of the error condition
handling we have here, I think it's the best we can do without inventing
a whole knew path for error records.  Whilst I have some thoughts on that
and using the tracepoint approach used for RAS event handling for servers
etc and the heavier weight userspace software that entails, we can always
bolt that on top later and it doesn't solve the control element anyway..

So applied,

Thanks,

Jonathan

> ---
> 
> v4 changes:
> * Changed event direction from none to rising.
> * Fixed missing static qualifier on attribute definition.
> 
> v3 changes:
> * This is a new patch to replace "staging: iio: resolver: ad2s1210: add
>  phase_lock_range attributes"
> 
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 125 ++++++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 66ef35fbb6fe..83f6ac890dbc 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -56,6 +56,13 @@
>  #define AD2S1210_MIN_FCW	0x4
>  #define AD2S1210_MAX_FCW	0x50
>  
> +/* 44 degrees ~= 0.767945 radians */
> +#define PHASE_44_DEG_TO_RAD_INT 0
> +#define PHASE_44_DEG_TO_RAD_MICRO 767945
> +/* 360 degrees ~= 6.283185 radians */
> +#define PHASE_360_DEG_TO_RAD_INT 6
> +#define PHASE_360_DEG_TO_RAD_MICRO 283185
> +
>  enum ad2s1210_mode {
>  	MOD_POS = 0b00,
>  	MOD_VEL = 0b01,
> @@ -379,6 +386,54 @@ static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
>  	return ret;
>  }
>  
> +static int ad2s1210_get_phase_lock_range(struct ad2s1210_state *st,
> +					 int *val, int *val2)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +			       AD2S1210_PHASE_LOCK_RANGE_44);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret) {
> +		/* 44 degrees as radians */
> +		*val = PHASE_44_DEG_TO_RAD_INT;
> +		*val2 = PHASE_44_DEG_TO_RAD_MICRO;
> +	} else {
> +		/* 360 degrees as radians */
> +		*val = PHASE_360_DEG_TO_RAD_INT;
> +		*val2 = PHASE_360_DEG_TO_RAD_MICRO;
> +	}
> +
> +	return IIO_VAL_INT_PLUS_MICRO;
> +}
> +
> +static int ad2s1210_set_phase_lock_range(struct ad2s1210_state *st,
> +					 int val, int val2)
> +{
> +	int deg, ret;
> +
> +	/* convert radians to degrees - only two allowable values */
> +	if (val == PHASE_44_DEG_TO_RAD_INT && val2 == PHASE_44_DEG_TO_RAD_MICRO)
> +		deg = 44;
> +	else if (val == PHASE_360_DEG_TO_RAD_INT &&
> +		 val2 == PHASE_360_DEG_TO_RAD_MICRO)
> +		deg = 360;
> +	else
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +				 AD2S1210_PHASE_LOCK_RANGE_44,
> +				 deg == 44 ? AD2S1210_PHASE_LOCK_RANGE_44 : 0);
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
>  static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
>  {
>  	unsigned int reg_val;
> @@ -551,6 +606,16 @@ static IIO_DEVICE_ATTR(lot_low_thrd, 0644,
>  		       ad2s1210_show_reg, ad2s1210_store_reg,
>  		       AD2S1210_REG_LOT_LOW_THRD);
>  
> +static const struct iio_event_spec ad2s1210_phase_event_spec[] = {
> +	{
> +		/* Phase error fault. */
> +		.type = IIO_EV_TYPE_MAG,
> +		.dir = IIO_EV_DIR_RISING,
> +		/* Phase lock range. */
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +};
> +
>  static const struct iio_chan_spec ad2s1210_channels[] = {
>  	{
>  		.type = IIO_ANGL,
> @@ -567,6 +632,14 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
> +	}, {
> +		/* used to configure phase lock range and get phase lock error */
> +		.type = IIO_PHASE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.scan_index = -1,
> +		.event_spec = ad2s1210_phase_event_spec,
> +		.num_event_specs = ARRAY_SIZE(ad2s1210_phase_event_spec),
>  	}, {
>  		/* excitation frequency output */
>  		.type = IIO_ALTVOLTAGE,
> @@ -595,6 +668,21 @@ static const struct attribute_group ad2s1210_attribute_group = {
>  	.attrs = ad2s1210_attributes,
>  };
>  
> +static IIO_CONST_ATTR(in_phase0_mag_rising_value_available,
> +		      __stringify(PHASE_44_DEG_TO_RAD_INT) "."
> +		      __stringify(PHASE_44_DEG_TO_RAD_MICRO) " "
> +		      __stringify(PHASE_360_DEG_TO_RAD_INT) "."
> +		      __stringify(PHASE_360_DEG_TO_RAD_MICRO));
> +
> +static struct attribute *ad2s1210_event_attributes[] = {
> +	&iio_const_attr_in_phase0_mag_rising_value_available.dev_attr.attr,
> +	NULL,
> +};
> +
> +static const struct attribute_group ad2s1210_event_attribute_group = {
> +	.attrs = ad2s1210_event_attributes,
> +};
> +
>  static int ad2s1210_initial(struct ad2s1210_state *st)
>  {
>  	unsigned char data;
> @@ -619,6 +707,40 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	return ret;
>  }
>  
> +static int ad2s1210_read_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int *val, int *val2)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PHASE:
> +		return ad2s1210_get_phase_lock_range(st, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad2s1210_write_event_value(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      enum iio_event_info info,
> +				      int val, int val2)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +
> +	switch (chan->type) {
> +	case IIO_PHASE:
> +		return ad2s1210_set_phase_lock_range(st, val, val2);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
>  				       unsigned int reg, unsigned int writeval,
>  				       unsigned int *readval)
> @@ -639,10 +761,13 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
>  }
>  
>  static const struct iio_info ad2s1210_info = {
> +	.event_attrs = &ad2s1210_event_attribute_group,
>  	.read_raw = ad2s1210_read_raw,
>  	.read_avail = ad2s1210_read_avail,
>  	.write_raw = ad2s1210_write_raw,
>  	.attrs = &ad2s1210_attribute_group,
> +	.read_event_value = ad2s1210_read_event_value,
> +	.write_event_value = ad2s1210_write_event_value,
>  	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
>  };
>  
> 

