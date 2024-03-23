Return-Path: <linux-kernel+bounces-112446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDEC8879F1
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 19:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EFB71C20C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 18:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053C54C3C3;
	Sat, 23 Mar 2024 18:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oz2hmpjB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC341A38CA;
	Sat, 23 Mar 2024 18:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711218686; cv=none; b=Pc3GJlGITZGc808PmFiSCBSHDEnH+bYWWfpeKs/295KP5UwXZ6JRgwQGAWfLoU4q6oGJmYG5hXsxhb03d0h4vYeAiznvjdPE9UitDxgTrS6AtIxx5PsVw3We1m7iP0BWNdAWbeuo9HAgF+wZrzgncIT+JpfSAIwcX3xD9NfzWBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711218686; c=relaxed/simple;
	bh=RwxR7Gihy9h5sOtc+XMoy6vq77seYRBhJ7NrFl1S14g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnG1Ih+DLyqt5c355dbn70qbLbFbM9pzyNTlsNVFg5nAE2Uec4B719G3aFecKMQ0n+dfTNtPkw2jl1NT8r1RHQJ2O7BxqTFqsJdBuNrzPd2TJVpGUS+TPQ3Wz4/uWkDkCxDrEahsoRfsaWA4vf1hzhAqyQq+bM7jOg4YxKwIBX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oz2hmpjB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03D8C433C7;
	Sat, 23 Mar 2024 18:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711218685;
	bh=RwxR7Gihy9h5sOtc+XMoy6vq77seYRBhJ7NrFl1S14g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oz2hmpjBJx4fBLZg90q1P4/SIVwbFUYHpjKdzFTMoKiSJlehzr+SlfvSuNdxRDy2X
	 /lvNJlS9FPTXLGeJnA1tPXGpuw8mSsTeeQBJ0NfyYobp8IGqAhAFxbkJ0k5lnHHbsT
	 8JzD2YLIwnH1KfS9yB/xbx3EpYK6A1P+07381zwSI1OAZDp3Y7zFNesI+H9k4hz1Vu
	 NXmBS55Nieagq2mDC935MYejOEMplt7g8uVig0Tn7dqXMbQdz5KuZzpx8NZfLxGp1/
	 psQJzBH/4+6eJDcDzyZ/RglC1OdkcxnqbWKF1Lp1KeEriasC3gvxF5r6JvV8qJyFNy
	 Bhye46tNmsj+g==
Date: Sat, 23 Mar 2024 18:31:11 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2] iio: adc: ad7944: simplify adi,spi-mode property
 parsing
Message-ID: <20240323183111.3826fbdd@jic23-huawei>
In-Reply-To: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
References: <20240319-ad7944-cleanups-v2-1-50e77269351b@baylibre.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Mar 2024 09:27:45 -0500
David Lechner <dlechner@baylibre.com> wrote:

> This simplifies the adi,spi-mode property parsing by using
> device_property_match_property_string() instead of two separate
> functions. Also, the error return value is now more informative
> in cases where there was problem parsing the property.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
Applied with the patch description tweaked to the togreg-normal branch
of iio.git (I'll unwind that back to my more normal branch handling
next week) and pushed out for 0-day to take a look at it.

Thanks,

Jonathan

> ---
> Changes in v2:
> - Reorder error path to avoid else statement
> - Link to v1: https://lore.kernel.org/r/20240318-ad7944-cleanups-v1-1-0cbb0349a14f@baylibre.com
> ---
>  drivers/iio/adc/ad7944.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7944.c b/drivers/iio/adc/ad7944.c
> index d5ec6b5a41c7..261a3f645fd8 100644
> --- a/drivers/iio/adc/ad7944.c
> +++ b/drivers/iio/adc/ad7944.c
> @@ -366,7 +366,6 @@ static int ad7944_probe(struct spi_device *spi)
>  	struct ad7944_adc *adc;
>  	bool have_refin = false;
>  	struct regulator *ref;
> -	const char *str_val;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*adc));
> @@ -382,16 +381,18 @@ static int ad7944_probe(struct spi_device *spi)
>  
>  	adc->timing_spec = chip_info->timing_spec;
>  
> -	if (device_property_read_string(dev, "adi,spi-mode", &str_val) == 0) {
> -		ret = sysfs_match_string(ad7944_spi_modes, str_val);
> -		if (ret < 0)
> -			return dev_err_probe(dev, -EINVAL,
> -					     "unsupported adi,spi-mode\n");
> +	ret = device_property_match_property_string(dev, "adi,spi-mode",
> +						    ad7944_spi_modes,
> +						    ARRAY_SIZE(ad7944_spi_modes));
> +	if (ret < 0) {
> +		if (ret != -EINVAL)
> +			return dev_err_probe(dev, ret,
> +					     "getting adi,spi-mode property failed\n");
>  
> -		adc->spi_mode = ret;
> -	} else {
>  		/* absence of adi,spi-mode property means default mode */
>  		adc->spi_mode = AD7944_SPI_MODE_DEFAULT;
> +	} else {
> +		adc->spi_mode = ret;
>  	}
>  
>  	if (adc->spi_mode == AD7944_SPI_MODE_CHAIN)
> 
> ---
> base-commit: 1446d8ef48196409f811c25071b2cc510a49fc60
> change-id: 20240318-ad7944-cleanups-9f95a7c598b6


