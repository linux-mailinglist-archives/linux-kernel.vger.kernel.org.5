Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90CFB7ACB4B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjIXSR2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 14:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIXSR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 14:17:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D35FB;
        Sun, 24 Sep 2023 11:17:20 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1777CC433C7;
        Sun, 24 Sep 2023 18:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695579440;
        bh=UB9EHCgTSx/Ae7TVo6Ze4gnE+haUhN6Xn6Ix/hTUP2g=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sBLsgvTCv9GofGv/degCP1e20cVhtusQ6l7YSH7NQm2qSsuY9EcpCi7Ip0nphjFV8
         auoly+qTSPLwfcUOkVs+Dfxle9YdPA9fIjFKGZUAv7DXSWZ5mK4MlSJpJKdOs/KesF
         1DgYYdEB9lMSTB2innNEP9vOKaGQiq3OgcEL0jsaN3yyAb56xlp5qp/ijO+ucYuYLJ
         g+wnsIzWzSSpm90MWxI4TF5tF2jrhx1S/yuUVN3VTzO9YDEIdJduwD7+v1i44rkpQ7
         0mIgCMrqOCehVL1AUTqdF+0C1QtDwD46An6FDFYuOpWEKkcoDwPn8U1fxTNamUobrE
         Fl+skn1kXMKEQ==
Date:   Sun, 24 Sep 2023 19:17:11 +0100
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
Subject: Re: [PATCH v2 19/19] staging: iio: resolver: ad2s1210: add
 triggered buffer support
Message-ID: <20230924191711.244ec842@jic23-huawei>
In-Reply-To: <20230921144400.62380-20-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-20-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:44:00 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This adds support for triggered buffers to the AD2S1210 resolver driver.
> 
Looks good. A few trivial comments inline.

Jonathan

> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 84 ++++++++++++++++++++++++-
>  1 file changed, 83 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index f5b8b290e860..44a2ecaeeeff 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -19,8 +19,11 @@
>  #include <linux/sysfs.h>
>  #include <linux/types.h>
>  
> +#include <linux/iio/buffer.h>
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> +#include <linux/iio/trigger_consumer.h>
> +#include <linux/iio/triggered_buffer.h>
>  
>  #define DRV_NAME "ad2s1210"
>  
> @@ -85,6 +88,12 @@ struct ad2s1210_state {
>  	unsigned long fclkin;
>  	/** The selected resolution */
>  	enum ad2s1210_resolution resolution;
> +	/** Scan buffer */
> +	struct {
> +		__be16 chan[2];
> +		/* Ensure timestamp is naturally aligned. */
> +		s64 timestamp __aligned(8);
> +	} scan;
>  	u8 rx[2] __aligned(IIO_DMA_MINALIGN);
>  	u8 tx[2];
>  };
> @@ -592,18 +601,35 @@ static const struct iio_chan_spec ad2s1210_channels[] = {
>  		.type = IIO_ANGL,
>  		.indexed = 1,
>  		.channel = 0,
> +		.scan_index = 0,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_HYSTERESIS),
>  		.info_mask_separate_available =
>  					BIT(IIO_CHAN_INFO_HYSTERESIS),
> +		.datasheet_name = "position",
>  	}, {
>  		.type = IIO_ANGL_VEL,
>  		.indexed = 1,
>  		.channel = 0,
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 's',
> +			.realbits = 16,
> +			.storagebits = 16,
> +			.endianness = IIO_BE,
> +		},
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE),
> -	}
> +		.datasheet_name = "velocity",

Not sure adding these is useful at this stage unless you have in kernel
consumers for this device.

> +	},
> +	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
>  static struct attribute *ad2s1210_attributes[] = {
> @@ -665,6 +691,55 @@ static int ad2s1210_debugfs_reg_access(struct iio_dev *indio_dev,
>  	return ret;
>  }
>  
> +static irqreturn_t ad2s1210_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ad2s1210_state *st = iio_priv(indio_dev);
> +	size_t chan = 0;
> +	int ret;
> +
> +	mutex_lock(&st->lock);
> +
> +	memset(&st->scan, 0, sizeof(st->scan));
> +	gpiod_set_value(st->sample_gpio, 1);
> +
> +	if (test_bit(0, indio_dev->active_scan_mask)) {
> +		ret = ad2s1210_set_mode(st, MOD_POS);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		/* REVIST: we can read 3 bytes here and also get fault flags */

Given we have fault detection outputs, does it make sense to do so?
Or should we just rely on those triggering an interrupt?

> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +	}
> +
> +	if (test_bit(1, indio_dev->active_scan_mask)) {
> +		ret = ad2s1210_set_mode(st, MOD_VEL);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		/* REVIST: we can read 3 bytes here and also get fault flags */
> +		ret = spi_read(st->sdev, st->rx, 2);
> +		if (ret < 0)
> +			goto error_ret;
> +
> +		memcpy(&st->scan.chan[chan++], st->rx, 2);
> +	}
> +
> +	iio_push_to_buffers_with_timestamp(indio_dev, &st->scan, pf->timestamp);
> +
> +error_ret:
> +	gpiod_set_value(st->sample_gpio, 0);
> +	mutex_unlock(&st->lock);
> +	iio_trigger_notify_done(indio_dev->trig);
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static const struct iio_info ad2s1210_info = {
>  	.read_raw = ad2s1210_read_raw,
>  	.read_avail = ad2s1210_read_avail,
> @@ -850,6 +925,13 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad2s1210_trigger_handler, NULL);
> +	if (ret < 0)
> +		return dev_err_probe(&spi->dev, ret,
> +				     "iio triggered buffer setup failed\n");
> +
>  	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  

