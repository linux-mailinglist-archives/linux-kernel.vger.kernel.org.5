Return-Path: <linux-kernel+bounces-79739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5354862606
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 17:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8F41F21DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 16:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C13412B69;
	Sat, 24 Feb 2024 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJq87c58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122CEC7;
	Sat, 24 Feb 2024 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708792264; cv=none; b=H6iWDbqoYW4x8xdWRtZzJBnF5Znl3/aGZ0Dbv3eMKx1+FJ96odyw9cXItR/kp3S9l6zj3NksriNL60F5I6RLDYBT04NElmFM3VmeCzd+KfeEkwLXAvWf48E73LK2dqKUUJPFdhcyw5KskxVv72atith9ZAf6R4OhmcAESzh/GI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708792264; c=relaxed/simple;
	bh=8nObHrysG8EXeSQ7JcK3mcZ3ndfVs2t62O/vtkPkBSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eDw4oBIXBgklAZmEBXmR21z2ifuYL6OrspNtlIAzM3TY1e+USSh7uScvBWImqeB4ZLv0lONoDm5i7sE7VROV0e1ecV7MfVt7qJftlfAOvpOeKU5ZkgAXiFNEVCeaT4szUv+CLyWwJsXLkcgWENHwORV5xjmnsLSS91hb1QF2WW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJq87c58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB705C433F1;
	Sat, 24 Feb 2024 16:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708792263;
	bh=8nObHrysG8EXeSQ7JcK3mcZ3ndfVs2t62O/vtkPkBSI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VJq87c58xgQ/XrRNUqLPWtkBdCAm2Dqy+IbhDu6TdUtQ4ZIs7idX3goka6Lyo017v
	 wpoEuxWAOsNZu1VDNzbFEKRNELIgpYT8j8WwgOoU+eHaWve93Umyo6oTjmJZPxe7Rq
	 XyyAg1RuLEbil9exGoFBRWl6HNN7buhWKEWzanjoDSkJNh+fZ9aWdjcrQXJXIo7F9D
	 /ckyb/iYOmGwf3t/qNa0j82O1PCtPV51lvsijjRODOEq8QpbVrTg8FKCFcOOBrn0FA
	 8FAkQ8ekqRvvRnnFX5XZskviGlLsz/T7MzTzZw6BS/glMRJzJppsBZ5zpqC0T3oyde
	 w5rEUgEXA8UDA==
Date: Sat, 24 Feb 2024 16:30:51 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240224163051.3edcf102@jic23-huawei>
In-Reply-To: <20240219191359.18367-1-vassilisamir@gmail.com>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 19 Feb 2024 20:13:59 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> According to the datasheet of BMP38x and BMP390 devices, for an SPI
> read operation the first byte that is returned needs to be dropped,
> and the rest of the bytes are the actual data returned from the
> sensor.
> 
> Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>

Applied and marked for stable - with tweaks to header order and the space above
as per discussion.
> ---
>  drivers/iio/pressure/bmp280-spi.c | 49 ++++++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> index e8a5fed07e88..1972014dca93 100644
> --- a/drivers/iio/pressure/bmp280-spi.c
> +++ b/drivers/iio/pressure/bmp280-spi.c
> @@ -8,6 +8,7 @@
>  #include <linux/spi/spi.h>
>  #include <linux/err.h>
>  #include <linux/regmap.h>
> +#include <linux/bits.h>
>  
>  #include "bmp280.h"
>  
> @@ -35,6 +36,33 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
>  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
>  }
>  
> +static int bmp380_regmap_spi_read(void *context, const void *reg,
> +				  size_t reg_size, void *val, size_t val_size)
> +{
> +	struct spi_device *spi = to_spi_device(context);
> +	u8 rx_buf[4];
> +	ssize_t status;
> +
> +	/*
> +	 * Maximum number of consecutive bytes read for a temperature or
> +	 * pressure measurement is 3.
> +	 */
> +	if (val_size > 3)
> +		return -EINVAL;
> +	/*
> +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> +	 * the first byte needs to be dropped and the rest are the requested
> +	 * data.
> +	 */
> +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> +	if (status)
> +		return status;
> +
> +	memcpy(val, rx_buf + 1, val_size);
> +
> +	return 0;
> +}
> +
>  static struct regmap_bus bmp280_regmap_bus = {
>  	.write = bmp280_regmap_spi_write,
>  	.read = bmp280_regmap_spi_read,
> @@ -42,10 +70,19 @@ static struct regmap_bus bmp280_regmap_bus = {
>  	.val_format_endian_default = REGMAP_ENDIAN_BIG,
>  };
>  
> +static struct regmap_bus bmp380_regmap_bus = {
> +	.write = bmp280_regmap_spi_write,
> +	.read = bmp380_regmap_spi_read,
> +	.read_flag_mask = BIT(7),
> +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> +};
> +
>  static int bmp280_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
>  	const struct bmp280_chip_info *chip_info;
> +	struct regmap_bus *bmp_regmap_bus;
>  	struct regmap *regmap;
>  	int ret;
>  
> @@ -58,8 +95,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
>  
>  	chip_info = spi_get_device_match_data(spi);
>  
> +	switch (chip_info->chip_id[0]) {
> +	case BMP380_CHIP_ID:
> +	case BMP390_CHIP_ID:
> +		bmp_regmap_bus = &bmp380_regmap_bus;
> +		break;
> +	default:
> +		bmp_regmap_bus = &bmp280_regmap_bus;
> +		break;
> +	}
> +
>  	regmap = devm_regmap_init(&spi->dev,
> -				  &bmp280_regmap_bus,
> +				  bmp_regmap_bus,
>  				  &spi->dev,
>  				  chip_info->regmap_config);
>  	if (IS_ERR(regmap)) {


