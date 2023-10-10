Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DA67C0085
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233401AbjJJPkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjJJPkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:40:49 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793F993;
        Tue, 10 Oct 2023 08:40:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36A0AC433C8;
        Tue, 10 Oct 2023 15:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696952448;
        bh=Bns2XY9k0e9ThFmHo3x2+L8G5fFyPtlK1e6YKoRto9M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RVjr6yXORxZIobDS/hkTiOZX/wAlelhrNwLoRUciv7VDfByEpoJZrgYp1VzCJcRsR
         LB0POM2c3OyvHQviGCeuWG414/XCmUnmm44uzGEHqbp20mbwwT3Dt4Br68E/bqB4Rk
         5+Hg3fnxcU/DdYLn/zHSRvKz8P2w1LLgs0mQnZ8PXjTvVGmnh8+/e/s0cU1oyK/Bbn
         b9y1vqTQtPTag5/mwQVujrOcLnVtsTw4TJQJU2/Sm2jw0CSpmVIUWrIxybXpc7Job8
         DNaCLY08P2LakVd2rnu6kcqFp3veInA2ksGwhPRwrG8leFM20LvvHG468GMbZNZMQh
         zoPZK618+aEHg==
Date:   Tue, 10 Oct 2023 16:40:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Axel Haslam <ahaslam@baylibre.com>,
        Philip Molloy <pmolloy@baylibre.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/17] staging: iio: resolver: ad2s1210: implement
 hysteresis as channel attr
Message-ID: <20231010164058.29ee52b4@jic23-huawei>
In-Reply-To: <20231005-ad2s1210-mainline-v4-2-ec00746840fc@baylibre.com>
References: <20231005-ad2s1210-mainline-v4-0-ec00746840fc@baylibre.com>
        <20231005-ad2s1210-mainline-v4-2-ec00746840fc@baylibre.com>
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

On Thu,  5 Oct 2023 19:50:19 -0500
David Lechner <dlechner@baylibre.com> wrote:

> The AD2S1210 resolver has a hysteresis feature that can be used to
> prevent flicker in the LSB of the position register. This can be either
> enabled or disabled. Disabling hysteresis is useful for increasing
> precision by oversampling.
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied

> ---
> 
> v4 changes:
> * Fixed hysteresis raw values when st->resolution != 16.
> 
> v3 changes:
> * Refactored into more functions to reduce complexity of switch statements.
> * Use early return instead of break in switch statements.
> 
> 
>  drivers/staging/iio/resolver/ad2s1210.c | 91 +++++++++++++++++++++++++++++++--
>  1 file changed, 88 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 8fbde9517fe9..af063eb25e9c 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -76,7 +76,8 @@ struct ad2s1210_state {
>  	struct regmap *regmap;
>  	/** The external oscillator frequency in Hz. */
>  	unsigned long clkin_hz;
> -	bool hysteresis;
> +	/** Available raw hysteresis values based on resolution. */
> +	int hysteresis_available[2];
>  	u8 resolution;
>  	/** For reading raw sample value via SPI. */
>  	__be16 sample __aligned(IIO_DMA_MINALIGN);
> @@ -311,6 +312,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  		goto error_ret;
>  
>  	st->resolution = udata;
> +	st->hysteresis_available[1] = 1 << (16 - st->resolution);
>  	ret = len;
>  
>  error_ret:
> @@ -447,6 +449,35 @@ static int ad2s1210_single_conversion(struct ad2s1210_state *st,
>  	return ret;
>  }
>  
> +static int ad2s1210_get_hysteresis(struct ad2s1210_state *st, int *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_test_bits(st->regmap, AD2S1210_REG_CONTROL,
> +			       AD2S1210_ENABLE_HYSTERESIS);
> +	mutex_unlock(&st->lock);
> +
> +	if (ret < 0)
> +		return ret;
> +
> +	*val = ret << (16 - st->resolution);
> +	return IIO_VAL_INT;
> +}
> +
> +static int ad2s1210_set_hysteresis(struct ad2s1210_state *st, int val)
> +{
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +	ret = regmap_update_bits(st->regmap, AD2S1210_REG_CONTROL,
> +				 AD2S1210_ENABLE_HYSTERESIS,
> +				 val ? AD2S1210_ENABLE_HYSTERESIS : 0);
> +	mutex_unlock(&st->lock);
> +
> +	return ret;
> +}
> +
>  static const int ad2s1210_velocity_scale[] = {
>  	17089132, /* 8.192MHz / (2*pi * 2500 / 2^15) */
>  	42722830, /* 8.192MHz / (2*pi * 1000 / 2^15) */
> @@ -479,7 +510,55 @@ static int ad2s1210_read_raw(struct iio_dev *indio_dev,
>  		default:
>  			return -EINVAL;
>  		}
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			return ad2s1210_get_hysteresis(st, val);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad2s1210_read_avail(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       const int **vals, int *type,
> +			       int *length, long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			*vals = st->hysteresis_available;
> +			*type = IIO_VAL_INT;
> +			*length = ARRAY_SIZE(st->hysteresis_available);
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
>  
> +static int ad2s1210_write_raw(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      int val, int val2, long mask)
> +{
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		switch (chan->type) {
> +		case IIO_ANGL:
> +			return ad2s1210_set_hysteresis(st, val);
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -520,7 +599,10 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
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
> @@ -596,6 +678,8 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
>  
>  static const struct iio_info ad2s1210_info = {
>  	.read_raw = ad2s1210_read_raw,
> +	.read_avail = ad2s1210_read_avail,
> +	.write_raw = ad2s1210_write_raw,
>  	.attrs = &ad2s1210_attribute_group,
>  	.debugfs_reg_access = &ad2s1210_debugfs_reg_access,
>  };
> @@ -711,8 +795,9 @@ static int ad2s1210_probe(struct spi_device *spi)
>  
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> -	st->hysteresis = true;
>  	st->resolution = 12;
> +	st->hysteresis_available[0] = 0;
> +	st->hysteresis_available[1] = 1 << (16 - st->resolution);
>  
>  	ret = ad2s1210_setup_clocks(st);
>  	if (ret < 0)
> 

