Return-Path: <linux-kernel+bounces-103395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D380187BEDB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:27:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03A411C20ABC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BA6FE24;
	Thu, 14 Mar 2024 14:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fw43UPCC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2191F5D8F8;
	Thu, 14 Mar 2024 14:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426437; cv=none; b=BOaY5/ro0hQi7L6/Cad+oxQjf7KQWdBHlUtIAC/NWfcgRqChTLU8zqpAwv9nGAzoPl+xL6Ivc8d0UOzSngC5TPTNsSOv0go/nALkQinB3BVIEtis4d4aRvs6YuMWG3WOJCfVqU+zsiDPm9evUsqb13PDA/wNi3Nm3Fm3Gu31ChA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426437; c=relaxed/simple;
	bh=x8duBZfq2CwdbVtYRgrRjeErlATVcK0LqzfKY/hrrRs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aAsqo8Y3S2w4JWcTgTIr6vigG6g/HrA3pTOG+crBBuowMtMDJG72zbNly6oWI9ciNhF2XEvkr9DMgbxyU9JiT55Nn1IsgHGHm2Uoq2alfFd5AHJGA0sKuQ2NdYst/6UQYUkr6EYybAdkwdl/EUx6626vXF9kHC58xJSoN9j4u2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fw43UPCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1FCC433C7;
	Thu, 14 Mar 2024 14:27:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710426436;
	bh=x8duBZfq2CwdbVtYRgrRjeErlATVcK0LqzfKY/hrrRs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fw43UPCCPAUskpMLXmkzS+5p+FnIUsZEfgNHQhEu3mU8R17Ld+KbLbSm5JYWmbT0S
	 X3qsH3lY/DxgvcEKoHl8ylTfb0eOVCVYAOnkRlLzIZAk4Me3S7XjsBlJhxRyCEfDrv
	 tjYRK/K/uE1+jAe+BnZ5aeiTMBL8nURHuEqibAcXBjpMzR8Dfx9xtnmzFz6BHNVH8Q
	 El/C5e6llmytVWSDRJe1+lpU28xS3q009KppF1tbsuk3C/Zp7ybfRxSXrTgXJN3+kB
	 2n9OqA1uYgHsCJSDYrrQzG26QAsc87taVyIPd8zIHl1diCfcAvZh52SVjyWCfpVKJu
	 EskIxOdPDwXUw==
Date: Thu, 14 Mar 2024 14:27:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, andriy.shevchenko@linux.intel.com,
 ang.iglesiasg@gmail.com, phil@raspberrypi.com, 579lpy@gmail.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: pressure: Fixes SPI support for BMP3xx devices
Message-ID: <20240314142700.32df91a2@jic23-huawei>
In-Reply-To: <20240311005432.1752853-1-vassilisamir@gmail.com>
References: <20240311005432.1752853-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Mar 2024 01:54:32 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> Bosch does not use unique BMPxxx_CHIP_ID for the different versions of
> the device which leads to misidentification of devices if their ID is
> used. Use a new value in the chip_info structure instead of the
> BMPxxx_CHIP_ID, in order to choose the regmap_bus to be used.
> 
> Fixes: a9dd9ba32311 ("iio: pressure: Fixes BMP38x and BMP390 SPI support")
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
Other than switching to a bool as Andy suggested, this looks fine to me.

Jonathan

> ---
>  drivers/iio/pressure/bmp280-core.c | 1 +
>  drivers/iio/pressure/bmp280-spi.c  | 9 ++-------
>  drivers/iio/pressure/bmp280.h      | 1 +
>  3 files changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-core.c b/drivers/iio/pressure/bmp280-core.c
> index fe8734468ed3..5ea9039caf75 100644
> --- a/drivers/iio/pressure/bmp280-core.c
> +++ b/drivers/iio/pressure/bmp280-core.c
> @@ -1233,6 +1233,7 @@ const struct bmp280_chip_info bmp380_chip_info = {
>  	.chip_id = bmp380_chip_ids,
>  	.num_chip_id = ARRAY_SIZE(bmp380_chip_ids),
>  	.regmap_config = &bmp380_regmap_config,
> +	.spi_read_extra_byte = 1,
>  	.start_up_time = 2000,
>  	.channels = bmp380_channels,
>  	.num_channels = 2,
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index a444d4b2978b..3a5fec5d47fd 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -96,15 +96,10 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  
>  	chip_info = spi_get_device_match_data(spi);
>  
> -	switch (chip_info->chip_id[0]) {
> -	case BMP380_CHIP_ID:
> -	case BMP390_CHIP_ID:
> +	if (chip_info->spi_read_extra_byte)
>  		bmp_regmap_bus = &bmp380_regmap_bus;
> -		break;
> -	default:
> +	else
>  		bmp_regmap_bus = &bmp280_regmap_bus;
> -		break;
> -	}
>  
>  	regmap = devm_regmap_init(&spi->dev,
>  				  bmp_regmap_bus,
> diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> index 4012387d7956..70bceaccf447 100644
> --- a/drivers/iio/pressure/bmp280.h
> +++ b/drivers/iio/pressure/bmp280.h
> @@ -423,6 +423,7 @@ struct bmp280_chip_info {
>  	int num_chip_id;
>  
>  	const struct regmap_config *regmap_config;
> +	int spi_read_extra_byte;
>  
>  	const struct iio_chan_spec *channels;
>  	int num_channels;


