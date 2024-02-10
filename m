Return-Path: <linux-kernel+bounces-60443-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD32B850503
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38F0EB22629
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C78D5BAFF;
	Sat, 10 Feb 2024 15:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTz1Qphl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB875BACE;
	Sat, 10 Feb 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707580750; cv=none; b=BE6k136rbRFAjpFrKzRqVMB4MHw55Ck5sJ89eHquoq59OWg+Q1Fvw8PJb8IN31y+K6vYseYx70h+CcJqrElxWdCCHNmESN2whLSkuppuqUKTaI1+a5CD7bYoVNQIVugFUmmxqyPcrv6u4OFLl1gxPg0qyyO0VRgPFT6xrz+Awec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707580750; c=relaxed/simple;
	bh=TOjZsjxJyygjDyYQGqewggBEGJHNfuXPQcHw7Mdj2+M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gIha+PqA+2e1VJW9D+czIjUKcjD6b/aFEhhMARuoys1fMXi7+EBOdCqvCV60XGcVOVy00pX0Mg1S2XxruadzJ4csKFXpuEEnZGKt4thKe/tMTtvDfJntD7C11xNe36IyQqRagZ3C/9O1DNgJ7EWXBN49yg6NyWvI6r5Z4CPsdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTz1Qphl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4380BC433C7;
	Sat, 10 Feb 2024 15:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707580749;
	bh=TOjZsjxJyygjDyYQGqewggBEGJHNfuXPQcHw7Mdj2+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NTz1QphlwbzTHVWCSwPpgXWsOdAr4Hmt9aQX3r3RPrxQO0F4FVxHHRqNew5kozh2n
	 XipNX/pb/hgXhgWozAgOwQ+GyvNeve5z8r5/1+GmKenekQU049HfMU9N7yJFgNybRr
	 3InoHLMeyeucbBNvU4VvMuV51G+3IXGmYby08wLFCEaLcAgYudKRCC2ubI5T4egNCX
	 oFL5CDyf1Q+SdDFNm71QlK8pN1tUIu470inhduSE3Tc1wQNfUJTWcIOjR3JN4bdJUD
	 vK+pgK5hJFRvWEj86wtzTUELp17Cq4s17ROFs7gY7LqyAg6QSpEhi3j9ljPBAXVacn
	 CvkTreJqeaKEw==
Date: Sat, 10 Feb 2024 15:58:57 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: Jonathan.Cameron@huawei.com, oskar.andero@gmail.com, lars@metafoo.de,
 lukas@wunner.de, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: mcp320x: Simplify device removal logic
Message-ID: <20240210155857.59c58dcc@jic23-huawei>
In-Reply-To: <20240208094339.82633-1-arturas.moskvinas@gmail.com>
References: <20240208094339.82633-1-arturas.moskvinas@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Feb 2024 11:43:39 +0200
Arturas Moskvinas <arturas.moskvinas@gmail.com> wrote:

> Use devm_* APIs to enable regulator and to register in IIO infrastructure.
> 
> Signed-off-by: Arturas Moskvinas <arturas.moskvinas@gmail.com>

Don't get the same regulator twice so as automate turning it off.
The devm_regulator_get_enable() call is carefully hiding the
regulator for cases where the driver never accesses it.

Here we need it to read the voltage.

To convert such a case to fully devm managed, use a
devm_add_action_or_reset() and a custom callback.

> ---
>  drivers/iio/adc/mcp320x.c | 19 ++-----------------
>  1 file changed, 2 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp320x.c b/drivers/iio/adc/mcp320x.c
> index f3b81798b3c9..4685eed35271 100644
> --- a/drivers/iio/adc/mcp320x.c
> +++ b/drivers/iio/adc/mcp320x.c
> @@ -388,7 +388,6 @@ static int mcp320x_probe(struct spi_device *spi)
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &mcp320x_info;
> -	spi_set_drvdata(spi, indio_dev);
>  
>  	device_index = spi_get_device_id(spi)->driver_data;
>  	chip_info = &mcp320x_chip_infos[device_index];
> @@ -441,31 +440,17 @@ static int mcp320x_probe(struct spi_device *spi)
>  	if (IS_ERR(adc->reg))
>  		return PTR_ERR(adc->reg);

Just above here is the first regulator get. Whilst it may work
we should not get it twice as the logic gets confused at the very least.


>  
> -	ret = regulator_enable(adc->reg);
> +	ret = devm_regulator_get_enable(&spi->dev, "vref");
>  	if (ret < 0)
>  		return ret;
>  
>  	mutex_init(&adc->lock);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret < 0)
> -		goto reg_disable;
> -
> -	return 0;
> -
> -reg_disable:
> -	regulator_disable(adc->reg);
> -
> -	return ret;
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static void mcp320x_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct mcp320x *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -	regulator_disable(adc->reg);
>  }
Had the change otherwise been ok...

You should be able to remove this function completely now it is empty.
https://elixir.bootlin.com/linux/latest/source/drivers/spi/spi.c#L446
checks it's existence before calling it.

Thanks

Jonathan

>  
>  static const struct of_device_id mcp320x_dt_ids[] = {
> 
> base-commit: 047371968ffc470769f541d6933e262dc7085456


