Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4547C0089
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233468AbjJJPly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbjJJPlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:41:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDCEB0;
        Tue, 10 Oct 2023 08:41:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3DFC433C8;
        Tue, 10 Oct 2023 15:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952507;
        bh=/NTCeOZLGiqM+pdB60lM6X8CBbdbcdi7UZF9GjGk5gA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=slX/YGir9TjDyCkkHw/gwRi42aAiMn+byHwAPesPGXoG7pcZvYNKwF0e7rl1puExR
         iXykvGn8fwXoT5i4YhauxrNuREsW6Ydt+RlpodqS0Df+HrUl0R5WIrVtbBcJDXTMej
         CbQ0AHHn6z47bM4kuZ4kbFI72YjcrNWh/L8BnSi9c6SQ42E2sSMaRxPMI8AY54ftKi
         V58G2ips8U9120CAZAljG/XHdanDWpb9suYRoZcinanlcAPgy3vzdyockC/nxHE8qh
         sNFtM60HtDaCjv68X6D6DJZs6fDtICXf8iDBtO5yc/7h0TN/2AZFhl4XmelJdA7aDl
         2/+WikfcERjLg==
Date:   Tue, 10 Oct 2023 16:41:59 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 03/17] staging: iio: resolver: ad2s1210: convert
 fexcit to channel attribute
Message-ID: <20231010164159.77ec7919@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-3-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-3-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:20 -0500
David Lechner <dlechner@baylibre.com> wrote:

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
Applied

> ---
> 
> v4 changes: None (rebased)
> 
> v3 changes:
> * This is a new patch in v3 instead of "iio: resolver: ad2s1210: rename fexcit
>   attribute"
> 
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 123 ++++++++++++++++++--------------
>  1 file changed, 71 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index af063eb25e9c..0c7772725330 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -227,54 +227,6 @@ static int ad2s1210_set_resolution_gpios(struct ad2s1210_state *st,
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
> @@ -478,6 +430,38 @@ static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
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
> @@ -510,6 +494,13 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
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
> @@ -527,9 +518,24 @@ static int ad2s1210_read_avail(struct iio_dev *indio_dev,
>  			       const int **vals, int *type,
>  			       int *length, long mask)
>  {
> +	static const int excitation_frequency_available[] = {
> +		AD2S1210_MIN_EXCIT,
> +		250, /* step */
> +		AD2S1210_MAX_EXCIT,
> +	};
> +
>  	struct ad2s1210_state *st = iio_priv(indio_dev);
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
> @@ -552,6 +558,13 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
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
> @@ -564,8 +577,6 @@ static int ad2s1210_write_raw(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static IIO_DEVICE_ATTR(fexcit, 0644,
> -		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
>  static IIO_DEVICE_ATTR(bits, 0644,
>  		       ad2s1210_show_resolution, ad2s1210_store_resolution, 0);
>  static IIO_DEVICE_ATTR(fault, 0644,
> @@ -609,11 +620,19 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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

