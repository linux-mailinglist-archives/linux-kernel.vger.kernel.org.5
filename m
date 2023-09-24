Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E07ACB10
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 19:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjIXR0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 13:26:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjIXR0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 13:26:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0F5126;
        Sun, 24 Sep 2023 10:25:57 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4248C433C8;
        Sun, 24 Sep 2023 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695576356;
        bh=bMpotNnwaohECqLY5FvgEgcZ0XP2V5cdsM+zfMWQjQ4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SXzScmqNF7XuuQ2Ls4XEJeulZKQhJqqykAKSjQIplhUQqEuPsGiPYewx/5JsfUIqf
         gb0WFVSIIErOs+S9zE0Ws9cHku3Zhyy3E+35aynp0e+mv2vZNzldHgyBDMYfEPZcOQ
         tfAyVISJjf51o/eMxQIZYcoylY+8SIQnHgaY+8546ZUJWA4kHTNAQ1yteHILGbhNnk
         /LE7v6YNZEew68H7QN1Vj1ksGMy2OXXUt/K/hPcLEtbqtT1n2m+xFSJYS/hfl7/anR
         7nc/8JmMgAHcsPa/yYkcj1R54EbCw2VGtP7JAzhh/iX/HNq+Y6RYO7Zo5gbQlf802v
         /wZ0K6WkmmEAA==
Date:   Sun, 24 Sep 2023 18:25:48 +0100
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
Subject: Re: [PATCH v2 05/19] staging: iio: resolver: ad2s1210: fix probe
Message-ID: <20230924182548.580dc03f@jic23-huawei>
In-Reply-To: <20230921144400.62380-6-dlechner@baylibre.com>
References: <20230921144400.62380-1-dlechner@baylibre.com>
        <20230921144400.62380-6-dlechner@baylibre.com>
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

On Thu, 21 Sep 2023 09:43:46 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This fixes a number of issues in the ad2s1210_probe() function:
> - Move call to ad2s1210_setup_gpios() after `st->sdev = spi;`. This
>   fixes use of this pointer before it is initialized.
> - Check return value on ad2s1210_initial().
Should mention moving it as well.
> - Move devm_iio_device_register() to the end to avoid race of
>   registering before fully initialized.
> - Remove call to spi_setup(). Note: MODE_3 was incorrect, it should be
>   MODE_1 but we can let the device tree select this.
> - Change default value for fclkin. This is an external oscillator, not
>   the SPI bus clock. (Will use device tree to get the correct value
>   in a future patch. For now, using the eval board value.)
> - Remove spi_set_drvdata().

Hmm. This is a lot of different things. I'd prefer it more split up
as a few of these are not completely trivial.

> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>

I think the patch split up broke on this one...

> ---
>  drivers/staging/iio/resolver/ad2s1210.c | 30 ++++++++++++-------------
>  1 file changed, 15 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0bdd5a30d45d..9c7f76114360 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -3,6 +3,7 @@
>   * ad2s1210.c support for the ADI Resolver to Digital Converters: AD2S1210
>   *
>   * Copyright (c) 2010-2010 Analog Devices Inc.
> + * Copyright (C) 2023 BayLibre, SAS

Bit early to justify that, but I'm fine with it anyway as it will soon
be justified!

>   */
>  #include <linux/types.h>
>  #include <linux/mutex.h>
> @@ -657,12 +658,8 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
> -	st = iio_priv(indio_dev);
> -	ret = ad2s1210_setup_gpios(st);
> -	if (ret < 0)
> -		return ret;
>  
> -	spi_set_drvdata(spi, indio_dev);

Looks fine, but unconnected to the rest of this patch.

> +	st = iio_priv(indio_dev);
>  
>  	mutex_init(&st->lock);
>  	st->sdev = spi;
> @@ -671,22 +668,25 @@ static int ad2s1210_probe(struct spi_device *spi)
>  	st->resolution = 12;
>  	st->fexcit = AD2S1210_DEF_EXCIT;
>  
> +	ret = ad2s1210_setup_clocks(st);

doesn't exist yet.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_setup_gpios(st);

> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ad2s1210_initial(st);
> +	if (ret < 0)
> +		return ret;
> +
>  	indio_dev->info = &ad2s1210_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->channels = ad2s1210_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(ad2s1210_channels);
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  
> -	ret = devm_iio_device_register(&spi->dev, indio_dev);
> -	if (ret)
> -		return ret;
> -
> -	st->fclkin = spi->max_speed_hz;
> -	spi->mode = SPI_MODE_3;
> -	spi_setup(spi);
> -	ad2s1210_initial(st);
> -
> -	return 0;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id ad2s1210_of_match[] = {

