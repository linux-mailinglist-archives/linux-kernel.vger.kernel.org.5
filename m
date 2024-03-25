Return-Path: <linux-kernel+bounces-117936-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECD1188B17A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31BC1FA5D50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212A45B1F8;
	Mon, 25 Mar 2024 20:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm3I6HRb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3ED5810D;
	Mon, 25 Mar 2024 20:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398731; cv=none; b=VdBgSO5Ok/vXG8c/NXwjO31zDfW2X2FJ5k68XBParUkW8YoeY5wcsMeHuUsecGNHurUrbc5aI+gf3/SRRbQW6qWZbw0mmtFoeIEampSQBStwE7G7TK5dCxR9nnwh4vUskcURbT7z1Dr0TRpem6Ctu1rURITk07QyWhj21wAB3Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398731; c=relaxed/simple;
	bh=qILMoowlP+MlDq1kLYWNHuIzJ//eEQGBD9+LRceFSfI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=caVO3QQVw7FyAVPRq22Arvbx0JvDoQf/OjR8TDYn38cB6bmyewohcAGgtZ+6HHs22efZFXc126tP0wf8lRkrHyhLk+jEgjgDIYKW1iAMPyu44BU1isOKPOVjkuE1lrpH2H1X8DTQsiZwL//R/5MPAD0cpgki7XHXY0cBrcLdxgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm3I6HRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DAAC433C7;
	Mon, 25 Mar 2024 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711398730;
	bh=qILMoowlP+MlDq1kLYWNHuIzJ//eEQGBD9+LRceFSfI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mm3I6HRbRRayzxvsaz8irY6sEI96CCtz+DF85bnvgwe2FflFXo50kOkwh5axGc12u
	 S137VQPA8INyQnJDXY4eAh5iQOwQUT3QsHLjIWf0zCuedTbi/M6fiFA4ZdeynmyI6G
	 X5Vss3HOSkQ+HfCZJ6u94ra8xJcb/DZhoVHSzOHSkv0wICRtxvn7JF40dKZAve8CiZ
	 fN6pwRAF5yTHi2GtZIAUmU85cxhJ2b7kn07HUq8ocTCXWO8EUXH5Qh+5IuYUxeghMm
	 7Qwp0tH+vBbaQVU0TvgX3AK4g6Tid4WUNJB+0W40DZE0DwQ6+bxiX82QzhoNFB9vgn
	 a5ePSNW1E3o6Q==
Date: Mon, 25 Mar 2024 20:31:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 1/7] iio: accel: adxl345: Make data_range obsolete
Message-ID: <20240325203155.23ddfe3d@jic23-huawei>
In-Reply-To: <20240325153356.46112-2-l.rubusch@gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
	<20240325153356.46112-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 25 Mar 2024 15:33:50 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace write() data_format by regmap_update_bits(), because
> bus specific pre-configuration may have happened before on
> the same register. Changes then need to be masked.
> 
> Remove the data_range field from the struct adxl345_data,
> because it is not used anymore.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 8bd30a23e..be6758015 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -42,13 +42,13 @@
>  #define ADXL345_DATA_FORMAT_4G		1
>  #define ADXL345_DATA_FORMAT_8G		2
>  #define ADXL345_DATA_FORMAT_16G		3
> +#define ADXL345_DATA_FORMAT_MSK		~((u8) BIT(6)) /* ignore spi-3wire */

I'm not keen on seeing masking of a bit we don't yet
handle done by value.  Can we instead build this up by what we 'want' to
write rather than don't. Will need a few more defines perhaps to cover
the masks of SELF_TEST, INT_INVERT, FULL_RES, Justify and Range.

>  
>  #define ADXL345_DEVID			0xE5
>  
>  struct adxl345_data {
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> -	u8 data_range;
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -219,14 +219,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap)
>  	data = iio_priv(indio_dev);
>  	data->regmap = regmap;
>  	/* Enable full-resolution mode */
> -	data->data_range = ADXL345_DATA_FORMAT_FULL_RES;
>  	data->info = device_get_match_data(dev);
>  	if (!data->info)
>  		return -ENODEV;
>  
> -	ret = regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> -			   data->data_range);
> -	if (ret < 0)
> +	ret = regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> +				 ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_FORMAT_FULL_RES);
> +	if (ret)
>  		return dev_err_probe(dev, ret, "Failed to set data range\n");
>  
>  	indio_dev->name = data->info->name;


