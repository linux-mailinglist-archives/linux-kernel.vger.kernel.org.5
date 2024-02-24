Return-Path: <linux-kernel+bounces-79731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 38A088625E6
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C17CF1F21938
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C1247A70;
	Sat, 24 Feb 2024 16:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="npXLMhhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3C14642A;
	Sat, 24 Feb 2024 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708790638; cv=none; b=BwAGyp4j2olwrOKAzadpZm6SmZ95mHtzHzVm7HsNfZ6zQKq2wvWTP2GF9Q2jigOFEsnvj/6o2RoIM6Am7YMRqna3gQ+Pu0mz9YvZC2B4J93RNWUHlg9UfWn8uZdq2e5mKMUYSAKv+9GvFu1htsUGnBTIrmSb7dy1uccKs2RINsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708790638; c=relaxed/simple;
	bh=1r4k3QAJpDE4euxXFH0/VkZbwY2Jf+GxPeLp35ybxak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EAyCgdylLc5SB1U4dNAQLEzcs55UoS3vBacUTs5ZsXYyuQvxR2Bm9NfB0gilezXk0sm78EPsB5WCS1HCoz5Nj46gImVnzkx1QxSUBgZJ1ZHqXsyr0GhK7UNuDGEwq4I5EC5Rud4ae7chZcJv5aST5D1Z7k1+y1KWBeL4oPs2XjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=npXLMhhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E053C433F1;
	Sat, 24 Feb 2024 16:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708790638;
	bh=1r4k3QAJpDE4euxXFH0/VkZbwY2Jf+GxPeLp35ybxak=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=npXLMhhwobQkfE5ybRsfEzJLe23/vw2a6aNks5xKZ+B4aeAgB8ooqdYzVSdIA6D0o
	 zjjiEBxHgHENgT5USYN+NYUTrFvibuwn8ncGRUMZA9CMzYTAtzb8PgOc7v2iyCPIN8
	 EH/iMD0zB+JMW0w3Ni6Foem9h6Ri27vz/MhFHMlrvy2mPF0pogMs4nLLvNjb9+ALyu
	 dRpbgEOVl244BGG74cC1YI5uDIwDAY86XLLbcFCHeCn2be9699/YfvggEE/W6lNNjz
	 Sl+XpIqofRYjV8IWQ0tHqM3SmBGYcy1uMEqdqaBO+RX8C9VxnioDIeHG7IthLGI0Xd
	 J3sVQwUgN4tMg==
Date: Sat, 24 Feb 2024 16:03:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: Jonathan.Cameron@huawei.com, oskar.andero@gmail.com, lars@metafoo.de,
 lukas@wunner.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: mcp320x: Simplify device removal logic
Message-ID: <20240224160346.61675eba@jic23-huawei>
In-Reply-To: <20240219074139.193464-2-arturas.moskvinas@gmail.com>
References: <20240219074139.193464-2-arturas.moskvinas@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 09:41:40 +0200
Arturas Moskvinas <arturas.moskvinas@gmail.com> wrote:

> Use devm_* APIs to enable/disable regulator and to register in IIO infrastructure.
> 
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Applied to the togreg branch of iio.git. Initially pushed out as testing
to let 0-day have a first go at pointing out what we missed in review.

Thanks,

Jonathan

> 
> ---
> v1 -> v2:
> - Use devm_add_action_or_reset instead of devm_regulator_get_enable to automate disabling regulator
> - Remove empty mcp320x_remove function
> ---
>  drivers/iio/adc/mcp320x.c | 29 +++++++++--------------------
>  1 file changed, 9 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index f3b81798b3c9..da1421bd7b62 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -371,6 +371,11 @@ static const struct mcp320x_chip_info mcp320x_chip_infos[] = {
>  	},
>  };
>  
> +static void mcp320x_regulator_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int mcp320x_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -388,7 +393,6 @@ static int mcp320x_probe(struct spi_device *spi)
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mcp320x_info;
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	device_index = spi_get_device_id(spi)->driver_data;
>  	chip_info = &mcp320x_chip_infos[device_index];
> @@ -445,27 +449,13 @@ static int mcp320x_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	mutex_init(&adc->lock);
> -
> -	ret = iio_device_register(indio_dev);
> +	ret = devm_add_action_or_reset(&spi->dev, mcp320x_regulator_disable, adc->reg);
>  	if (ret < 0)
> -		goto reg_disable;
> -
> -	return 0;
> -
> -reg_disable:
> -	regulator_disable(adc->reg);
> -
> -	return ret;
> -}
> +		return ret;
>  
> -static void mcp320x_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct mcp320x *adc = iio_priv(indio_dev);
> +	mutex_init(&adc->lock);
>  
> -	iio_device_unregister(indio_dev);
> -	regulator_disable(adc->reg);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id mcp320x_dt_ids[] = {
> @@ -520,7 +510,6 @@ static struct spi_driver mcp320x_driver = {
>  		.of_match_table = mcp320x_dt_ids,
>  	},
>  	.probe = mcp320x_probe,
> -	.remove = mcp320x_remove,
>  	.id_table = mcp320x_id,
>  };
>  module_spi_driver(mcp320x_driver);
> 
> base-commit: 8d3dea210042f54b952b481838c1e7dfc4ec751d


