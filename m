Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BF57ACB38
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjIXSFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:05:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B68AFA;
        Sun, 24 Sep 2023 11:05:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030CCC433C8;
        Sun, 24 Sep 2023 18:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695578737;
        bh=iru/77/T+RQ94qKNjJz/efepLg+hlk3IoPzLAJ8FxpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t6SeVMYYgWxh7g8Nik0J1P1ug48IZ1oVlkA4OHK/Mo00XsWTwizEIPMMzbqvLwqtT
         Xip4HYeGyFMsEcFm/vHSa5eRR4mLtBPvKs44/xZ0docrnLEjwJhtsrNMuq+gwT4FaA
         gOdUJJ+7DFSdAM9cdxLHp5o2tqzAfvJwEFbNa5JqaZIYqjnShxkURpymuK1atWkbZL
         BlL4x7GSk1aO4lFWOaA0weopPmm+beK6cq4SUjNFCQM32wb4wGYqEetKZJtuC/Nu+J
         n9/RuTQIiNDTzD9AYQAOYcRyvIYpWyuQf8M3jvmcMhxSzV0y6iVjfztsUgTOrYmvsm
         7PJi+ARK1snZQ==
Date:   Sun, 24 Sep 2023 19:05:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>
Subject: Re: [PATCH v2 13/19] staging: iio: resolver: ad2s1210: implement
 hysteresis as channel attr
Message-ID: <20230924190529.08411ba8@jic23-huawei>
In-Reply-To: <20230921144400.62380-14-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-14-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:54 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 resolver has a hysteresis feature that can be used to
> prevent flicker in the LSB of the position register. This can be either
> enabled or disabled. Disabling hysteresis is useful for increasing
> precision by oversampling.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I'd forgotten we even had hysteresis defined other than for events.
This seems like what it was for, it's just rarely seen in hardware
as trivial for software to do the same.

Maybe some good uses of the new cleanup.h auto releasing of locks
stuff in here.

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 88 ++++++++++++++++++++++++-
>  1 file changed, 85 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 7a1069d948eb..fe413759deb9 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -80,7 +80,6 @@ struct ad2s1210_state {
>  	/** The external oscillator frequency in Hz. */
>  	unsigned long fclkin;
>  	unsigned int fexcit;
> -	bool hysteresis;
>  	u8 resolution;
>  	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
>  	u8 tx[2];
> @@ -456,6 +455,27 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			mutex_lock(&st->lock);
> +			ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +					       AD2S1210_ENABLE_HYSTERESIS);
> +			if (ret < 0)
> +				goto error_info_hysteresis;
> +
> +			*val = !!ret;
> +			ret = IIO_VAL_INT;
> +
> +error_info_hysteresis:

scoped_guard might be a good solution here that avoids messy labels
within deeply nested code.


> +			mutex_unlock(&st->lock);
> +			break;
> +		default:
> +			ret = -EINVAL;
> +			break;
> +		}
> +		break;
> +
>  	default:
>  		ret = -EINVAL;
>  		break;
> @@ -464,6 +484,64 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static int ad2s1210_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type,
> +			       int *length, long mask)
> +{
> +	static const int available[] = { 0, 1 };
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*vals = available;
> +			*type = IIO_VAL_INT;
> +			*length = ARRAY_SIZE(available);
> +			ret = IIO_AVAIL_LIST;
> +			break;
> +		default:
> +			break;
> +		}
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ad2s1210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	int ret = -EINVAL;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			mutex_lock(&st->lock);
> +			ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +						 AD2S1210_ENABLE_HYSTERESIS,
> +						 val ? AD2S1210_ENABLE_HYSTERESIS
> +						     : 0);
> +			mutex_unlock(&st->lock);
> +			break;
I'd return in these as easier to follow at this function grows.

> +
> +		default:
> +			break;
> +		}
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
>  static IIO_DEVICE_ATTR(fexcit, 0644,
>  		       ad2s1210_show_fexcit,	ad2s1210_store_fexcit, 0);
>  static IIO_DEVICE_ATTR(bits, 0644,
> @@ -499,7 +577,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.indexed = 1,
>  		.channel = 0,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -				      BIT(IIO_CHAN_INFO_SCALE),
> +				      BIT(IIO_CHAN_INFO_SCALE) |
> +				      BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.info_mask_separate_available =
> +					BIT(IIO_CHAN_INFO_HYSTERESIS),
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.indexed = 1,
> @@ -573,6 +654,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad2s1210_info = {
>  	.read_raw = ad2s1210_read_raw,
> +	.read_avail = ad2s1210_read_avail,
> +	.write_raw = ad2s1210_write_raw,
>  	.attrs = &ad2s1210_attribute_group,
>  	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
>  };
> @@ -689,7 +772,6 @@ static int ad2s1210_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->hysteresis = true;
>  	st->resolution = 12;
>  	st->fexcit = AD2S1210_DEF_EXCIT;
>  

