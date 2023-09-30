Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C727B4180
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234413AbjI3PMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234276AbjI3PMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:12:15 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EA0E1;
        Sat, 30 Sep 2023 08:12:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3F3EC433C7;
        Sat, 30 Sep 2023 15:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696086732;
        bh=t/GLHPKHZ9+CZpz9+L6eaoBiMr0cyswcr79Y6q0H8jM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZSAv+6riznXwdFimkPSS03yZdG2Kn2BxMXWmHZCnEKaU7/8+8MYOft0GvW+/EgCJK
         kbd4wEpiwfC/YNxOl4pJb9Fvtaml+Zyw7y6NQwx8cpTUhSfuNYuRmi0PC1BbUMgRL2
         YbNOtn0xElBhvA1jcwL1RNm2VReFNUrUpcwAgapW4hogjOIzF+l6OTcNRmVh78A36Z
         +rPZULp+c8k7pZvEjKhN6OEgcWyOUMN9MVSQNHLi6VJTvc0NnYAKns+wOfSvUBEscF
         coLdxjhiUG63d1JtKpGIB5NO/E+IkMeL8XejZSVSQE9xEmiaL5MSMBQ6Kz+36hXUsx
         /vsvaTX+L0fAQ==
Date:   Sat, 30 Sep 2023 16:12:11 +0100
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
Subject: Re: [PATCH v3 17/27] staging: iio: resolver: ad2s1210: convert
 fexcit to channel attribute
Message-ID: <20230930161211.40656092@jic23-huawei>
In-Reply-To: <20230929-ad2s1210-mainline-v3-17-fa4364281745@baylibre.com>
References: <20230929-ad2s1210-mainline-v3-0-fa4364281745@baylibre.com>
        <20230929-ad2s1210-mainline-v3-17-fa4364281745@baylibre.com>
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

On Fri, 29 Sep 2023 12:23:22 -0500
David Lechner <dlechner@baylibre.com> wrote:

> From: David Lechner <david@lechnology.com>
> 
> From: David Lechner <dlechner@baylibre.com>
> 
> The ad2s1210 driver has a device-specific attribute `fexcit` for setting
> the frequency of the excitation output. This converts it to a channel in
> order to use standard IIO ABI.
> 
> The excitation frequency is an analog output that generates a sine wave.
> Only the frequency is configurable. According to the datasheet, the
> specified range of the excitation frequency is from 2 kHz to 20 kHz and
> can be set in increments of 250 Hz.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
And this is the point where things got non trivial given I skipped
the hysterisis patch.

This looks good to me though, so will pick it up once questions on that
earlier patch are resolved.

Thanks,

Jonathan

> ---
> 
> v3 changes:
> * This is a new patch in v3 instead of "iio: resolver: ad2s1210: rename fexcit
>   attribute"
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 122 ++++++++++++++++++--------------
>  1 file changed, 70 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index b15d71b17266..6accb9e3db46 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -224,54 +224,6 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
>  				     bitmap);
>  }
>  
> -static ssize_t ad2s1210_show_fexcit(struct device *dev,
> -				    struct device_attribute *attr,
> -				    char *buf)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	unsigned int value;
> -	u16 fexcit;
> -	int ret;
> -
> -	mutex_lock(&st->lock);
> -	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &value);
> -	if (ret < 0)
> -		goto error_ret;
> -
> -	fexcit = value * st->clkin_hz / (1 << 15);
> -
> -	ret = sprintf(buf, "%u\n", fexcit);
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -	return ret;
> -}
> -
> -static ssize_t ad2s1210_store_fexcit(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> -{
> -	struct ad2s1210_state *st = iio_priv(dev_to_iio_dev(dev));
> -	u16 fexcit;
> -	int ret;
> -
> -	ret = kstrtou16(buf, 10, &fexcit);
> -	if (ret < 0 || fexcit < AD2S1210_MIN_EXCIT || fexcit > AD2S1210_MAX_EXCIT)
> -		return -EINVAL;
> -
> -	mutex_lock(&st->lock);
> -	ret = ad2s1210_reinit_excitation_frequency(st, fexcit);
> -	if (ret < 0)
> -		goto error_ret;
> -
> -	ret = len;
> -
> -error_ret:
> -	mutex_unlock(&st->lock);
> -
> -	return ret;
> -}
> -
>  static ssize_t ad2s1210_show_resolution(struct device *dev,
>  					struct device_attribute *attr,
>  					char *buf)
> @@ -474,6 +426,38 @@ static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
>  	return ret;
>  }
>  
> +static int ad2s1210_get_excitation_frequency(struct ad2s1210_state *st, int *val)
> +{
> +	unsigned int reg_val;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_read(st->regmap, AD2S1210_REG_EXCIT_FREQ, &reg_val);
> +	if (ret < 0)
> +		goto error_ret;
> +
> +	*val = reg_val * st->clkin_hz / (1 << 15);
> +	ret = IIO_VAL_INT;
> +
> +error_ret:
> +	mutex_unlock(&st->lock);
> +	return ret;
> +}
> +
> +static int ad2s1210_set_excitation_frequency(struct ad2s1210_state *st, int val)
> +{
> +	int ret;
> +
> +	if (val < AD2S1210_MIN_EXCIT || val > AD2S1210_MAX_EXCIT)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->lock);
> +	ret = ad2s1210_reinit_excitation_frequency(st, val);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static const int ad2s1210_velocity_scale[] = {
>  	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
>  	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
> @@ -506,6 +490,13 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ALTVOLTAGE:
> +			return ad2s1210_get_excitation_frequency(st, val);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_HYSTERESIS:
>  		switch (chan->type) {
>  		case IIO_ANGL:
> @@ -523,9 +514,23 @@ static int ad2s1210_read_avail(struct iio_dev *indio_dev,
>  			       const int **vals, int *type,
>  			       int *length, long mask)
>  {
> +	static const int excitation_frequency_available[] = {
> +		AD2S1210_MIN_EXCIT,
> +		250, /* step */
> +		AD2S1210_MAX_EXCIT,
> +	};
>  	static const int hysteresis_available[] = { 0, 1 };
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ALTVOLTAGE:
> +			*type = IIO_VAL_INT;
> +			*vals = excitation_frequency_available;
> +			return IIO_AVAIL_RANGE;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_HYSTERESIS:
>  		switch (chan->type) {
>  		case IIO_ANGL:
> @@ -548,6 +553,13 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  	struct ad2s1210_state *st = iio_priv(indio_dev);
>  
>  	switch (mask) {
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->type) {
> +		case IIO_ALTVOLTAGE:
> +			return ad2s1210_set_excitation_frequency(st, val);
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_HYSTERESIS:
>  		switch (chan->type) {
>  		case IIO_ANGL:
> @@ -560,8 +572,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_DEVICE_ATTR(fexcit, 0644,
> -		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
>  static IIO_DEVICE_ATTR(bits, 0644,
>  		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
>  static IIO_DEVICE_ATTR(fault, 0644,
> @@ -605,11 +615,19 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
> -	}
> +	}, {
> +		/* excitation frequency output */
> +		.type = IIO_ALTVOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.output = 1,
> +		.scan_index = -1,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_FREQUENCY),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_FREQUENCY),
> +	},
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
> -	&iio_dev_attr_fexcit.dev_attr.attr,
>  	&iio_dev_attr_bits.dev_attr.attr,
>  	&iio_dev_attr_fault.dev_attr.attr,
>  	&iio_dev_attr_los_thrd.dev_attr.attr,
> 

