Return-Path: <linux-kernel+bounces-71879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC99A85AC28
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4C81F22EE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:42:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AD451026;
	Mon, 19 Feb 2024 19:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="In4Gub8B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86127171B1;
	Mon, 19 Feb 2024 19:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708371770; cv=none; b=kDSponm/aWitWNf+eu23akfoghkFHQNUep3rH344fdRclpitnKwN+jvfTQPSyL0j8LdzONBngqHedjd6XobyquQT/t492or1UMTi5SNfNeO8zgqqYgxYMu4CkDk+dTa+0kR0ngIgGCYj2L1npy04WhHCEaIs6raWyHFhyQuvY5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708371770; c=relaxed/simple;
	bh=z36Xm5HHN0fIfsMYuoiFykLWFHt01jTaY4Z0D+jty5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bbQDNaYTTzBQjRI6+z5/rf3gqk2+/DHLyLbR5P+qlgGGC65RLqn7szMezPIHB/zHV+OrFYDNxJSAwadcMPt3BF+chQzVOWSaM+c9D5zS/JqFgNwKBumsbnPQNysW0jzuxDUbeZRiZZsFXyF9U1vZH/TsdWqKsjfTi41jjIW5hsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=In4Gub8B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91719C433C7;
	Mon, 19 Feb 2024 19:42:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708371770;
	bh=z36Xm5HHN0fIfsMYuoiFykLWFHt01jTaY4Z0D+jty5E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=In4Gub8BHaptX7+rgLZjwdSWQJMoufid7ev3pC9PSB+rpuqer0uA+eW0gj8fSu8u7
	 4x+PxNeLvnnIuJQc78rFUsptBVPU94UWn5K6tBsp9xv7ERR6dnGV0tRM6JF8Ly/3VN
	 ec52MqhN0Rvv/+cQTZ8fg/rnt+7fAJfgWuCJarQyNqZsxOuYurg3XKyA79bVPiRHPm
	 7jiF0KGdt3yA4pOvOPVLz3WyI1UYvTDv0LFjNZWh9F+bk653Txr6kS4lnO3hhRyTQq
	 GDWASpVtmWpSnla8zMetBBUc8b4s2jCbq2J7N/1FMDuu0HlAgzaAIxJnhU3FyVPAvq
	 jqqpmwO6E7u/A==
Date: Mon, 19 Feb 2024 19:42:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240219194213.6b0f02bc@jic23-huawei>
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
No line break. The fixes tag is part of the main tag block.
I can fix that whilst applying.
Otherwise this looks fine to me.

I'll leave it on list a little longer though as both Linus and Angel
are still about and might have time to also take a look at this.

> 
> Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
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


