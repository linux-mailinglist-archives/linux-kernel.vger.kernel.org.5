Return-Path: <linux-kernel+bounces-122963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5313A890074
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CC8F29180C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DF7780605;
	Thu, 28 Mar 2024 13:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lWYLnBY6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC0F1DFF2;
	Thu, 28 Mar 2024 13:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711633056; cv=none; b=CIKCKY+Za+yX2adBiIw4juNUjrAyHUoi5iDYV7jPmSroy4/tzSjAdH5Rn2825Cw0SIGhzJmXYo78T2PPpbp3PSExKyRtaZlfZUlgB+X3oZ3TR0f9ElKOksaPC3EYPyENsiOGDjNmgzQonwLwYj548wLAeCeeCxpgy+2VvB7MrJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711633056; c=relaxed/simple;
	bh=2wMQZUMDKyXYoSYDs721zMsZSef9FBC/jEz9Dy7RV3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D8MzBXRuS5VgBGMcWSaHGEMZ8fAkpmZZzZtKAdrPtQDso8fKkcR0mfRVOYHGt6dngnKSyJ49MYhYkQWsHOJsLiwGF9EMViPCNaLiptffShn2cBbEE74m6gB152sZaW4BdtINs6ccs+UtljB+5jjAzF8XdbNJVA+ssQ8TfBMoKJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lWYLnBY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E83C433C7;
	Thu, 28 Mar 2024 13:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711633056;
	bh=2wMQZUMDKyXYoSYDs721zMsZSef9FBC/jEz9Dy7RV3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lWYLnBY6ZFpm71DWI7mSZV/kRZWK6TGyKJhQku59LxVf9R42TCo8fSEwYsbB1g3xr
	 pjD0m+rm6iTA9EoUQSfWp6pwBAmrtN+0otczQ8kF9fkMHcdxrlaTOh2eCFy6KGaV3f
	 t6DPxwYZyIdBeXP43/eBbB2I+T+tVBKjgux8HW21c0oqLJmekQV4XqKzNzy4pJIbGP
	 hNVtdhCEJiqKtEEMcnk33uHzMKXFDL7E/Lxf5GAwXpwnPX4zZ/r3bBXZ/HX8PaUPeV
	 LRq0EAdpcYHxzl82+PkSbpXH3aH3p+g4+YXTt0+mFuJhVbiTUTUobZ7ocvYxw+eW9Z
	 WZvEHhbZRGuXQ==
Date: Thu, 28 Mar 2024 13:37:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 1/7] iio: accel: adxl345: Make data_range obsolete
Message-ID: <20240328133720.7dfd46b0@jic23-huawei>
In-Reply-To: <20240327220320.15509-2-l.rubusch@gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 22:03:14 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace write() data_format by regmap_update_bits(), because bus specific
> pre-configuration may have happened before on the same register. For
> further updates to the data_format register then bus pre-configuration
> needs to be masked out.
> 
> Remove the data_range field from the struct adxl345_data, because it is
> not used anymore.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8bd30a23e..35df5e372 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -37,7 +37,15 @@
>  #define ADXL345_POWER_CTL_MEASURE	BIT(3)
>  #define ADXL345_POWER_CTL_STANDBY	0x00
>  
> +#define ADXL345_DATA_FORMAT_RANGE	GENMASK(1, 0) /* Set the g range */
> +#define ADXL345_DATA_FORMAT_JUSTIFY	BIT(2) /* Left-justified (MSB) mode */
>  #define ADXL345_DATA_FORMAT_FULL_RES	BIT(3) /* Up to 13-bits resolution */
> +#define ADXL345_DATA_FORMAT_SELF_TEST	BIT(7) /* Enable a self test */
> +#define ADXL345_DATA_FORMAT_MSK		(ADXL345_DATA_FORMAT_RANGE | \
> +					 ADXL345_DATA_FORMAT_JUSTIFY |  \
> +					 ADXL345_DATA_FORMAT_FULL_RES | \
> +					 ADXL345_DATA_FORMAT_SELF_TEST)
This needs renaming.  It's not a mask of everything in the register, or
even just of everything related to format. 

Actually I'd just not have this definition.  Use the build up value
from all the submasks at the call site.  Then we are just making it clear
only a subset of fields are being cleared.

Jonathan

> +
>  #define ADXL345_DATA_FORMAT_2G		0
>  #define ADXL345_DATA_FORMAT_4G		1
>  #define ADXL345_DATA_FORMAT_8G		2
> @@ -48,7 +56,6 @@
>  struct adxl345_data {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> -	u8 data_range;
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -218,15 +225,14 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
> -	/* Enable full-resolution mode */
> -	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
>  	data->info = device_get_match_data(dev);
>  	if (!data->info)
>  		return -ENODEV;
>  
> -	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> -			   data->data_range);
> -	if (ret < 0)
> +	/* Enable full-resolution mode */
> +	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> +	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to set data range\n");
>  
>  	indio_dev->name = data->info->name;


