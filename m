Return-Path: <linux-kernel+bounces-97971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E46E5877298
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 19:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B4C4282002
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 18:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD32C18F;
	Sat,  9 Mar 2024 18:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOpcCJg7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E206123741;
	Sat,  9 Mar 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710007483; cv=none; b=TV3KQ1WACK0cX3wpZqRljAbi05J3xKJNs//+RBXZKZ/8CXOK0GOdh/+AXDs+lLV6E3LhrNOU8lHxKLQ2JzOi/5UyUItEwdX0bgWvEI6FhDM+tPJMVamqbDVqF2JgJGKaKnjWy3o1oOn6Y36dChnM/thx65iz/esS6QPBUpb1MQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710007483; c=relaxed/simple;
	bh=t8+ewCeu3F5rRQydsgFR+Ay07/LEMHPTU/cmmvSkA5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp2wQ7j96PMo0EK66A8PoVXr64KaSfE5357E8dW2EE44pJYN/ZDyTXN4WRvkrL4ykHHePhLO6rwfSBTZ6sYBVEO1EdAOe1WD/+xLTEPBQMPk30FjWu9QbE2p6kzosXxAWuDvbr1jVpKiC+n6VZ+VZR/6BQmlQk0gdox3QBJOos4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOpcCJg7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF97AC433F1;
	Sat,  9 Mar 2024 18:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710007482;
	bh=t8+ewCeu3F5rRQydsgFR+Ay07/LEMHPTU/cmmvSkA5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fOpcCJg7iVaKatZ1J5E70RpXVJNy9B6+gXVVL53cJhivNGYZdDJ3DRsFyD2+SUpbu
	 Z/493jns3doTgDZkpoPa5+iN2qP1NucX+wGB9MiY0ctvPPdmSGgPODJ10VW5AStJfD
	 TP+yLmeXwEtYWhbADY3GVldqiQSdRO9fqNj3HJqhm01obdEDHcSrxyYfB1zuC7bVmz
	 j/8LxWCcXkgBebz88PxwczW3vi80r506L/11pzzh4O+cFu1ZO37KL8OKNBA5OCidqN
	 OhsvPaSygHQc47I6ojfQcZTOUkxQeLxvrr/iUWd9+PEBZfvcl7vkHOUdD4ml0Gck3Y
	 v1lfb3FFPE+PA==
Date: Sat, 9 Mar 2024 18:04:29 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: lars@metafoo.de, ang.iglesiasg@gmail.com,
 andriy.shevchenko@linux.intel.com, linus.walleij@linaro.org,
 semen.protsenko@linaro.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Fixes BMP38x and BMP390 SPI
 support
Message-ID: <20240309180429.1ebbe887@jic23-huawei>
In-Reply-To: <20240306180829.GA759506@vamoiridPC>
References: <20240219191359.18367-1-vassilisamir@gmail.com>
	<20240224163051.3edcf102@jic23-huawei>
	<20240306180829.GA759506@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 6 Mar 2024 19:08:29 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Sat, Feb 24, 2024 at 04:30:51PM +0000, Jonathan Cameron wrote:
> > On Mon, 19 Feb 2024 20:13:59 +0100
> > Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> >   
> > > According to the datasheet of BMP38x and BMP390 devices, for an SPI
> > > read operation the first byte that is returned needs to be dropped,
> > > and the rest of the bytes are the actual data returned from the
> > > sensor.
> > > 
> > > Fixes: 8d329309184d ("iio: pressure: bmp280: Add support for BMP380 sensor family")
> > > 
> > > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>  
> > 
> > Applied and marked for stable - with tweaks to header order and the space above
> > as per discussion.  
> 
> Hi Jonathan,
> 
> I just got my hands on a BME280 humidity sensor and I realized that this commit,
> even though it fixes the SPI support for the BMP38x and BMP390 devices, it breaks
> the SPI support for BME280 and BMP58x. The problem is descirbed below, inline.
> 
> > > ---
> > >  drivers/iio/pressure/bmp280-spi.c | 49 ++++++++++++++++++++++++++++++-
> > >  1 file changed, 48 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > > index e8a5fed07e88..1972014dca93 100644
> > > --- a/drivers/iio/pressure/bmp280-spi.c
> > > +++ b/drivers/iio/pressure/bmp280-spi.c
> > > @@ -8,6 +8,7 @@
> > >  #include <linux/spi/spi.h>
> > >  #include <linux/err.h>
> > >  #include <linux/regmap.h>
> > > +#include <linux/bits.h>
> > >  
> > >  #include "bmp280.h"
> > >  
> > > @@ -35,6 +36,33 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
> > >  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> > >  }
> > >  
> > > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > > +				  size_t reg_size, void *val, size_t val_size)
> > > +{
> > > +	struct spi_device *spi = to_spi_device(context);
> > > +	u8 rx_buf[4];
> > > +	ssize_t status;
> > > +
> > > +	/*
> > > +	 * Maximum number of consecutive bytes read for a temperature or
> > > +	 * pressure measurement is 3.
> > > +	 */
> > > +	if (val_size > 3)
> > > +		return -EINVAL;
> > > +	/*
> > > +	 * According to the BMP3xx datasheets, for a basic SPI read opertion,
> > > +	 * the first byte needs to be dropped and the rest are the requested
> > > +	 * data.
> > > +	 */
> > > +	status = spi_write_then_read(spi, reg, 1, rx_buf, val_size + 1);
> > > +	if (status)
> > > +		return status;
> > > +
> > > +	memcpy(val, rx_buf + 1, val_size);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static struct regmap_bus bmp280_regmap_bus = {
> > >  	.write = bmp280_regmap_spi_write,
> > >  	.read = bmp280_regmap_spi_read,
> > > @@ -42,10 +70,19 @@ static struct regmap_bus bmp280_regmap_bus = {
> > >  	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> > >  };
> > >  
> > > +static struct regmap_bus bmp380_regmap_bus = {
> > > +	.write = bmp280_regmap_spi_write,
> > > +	.read = bmp380_regmap_spi_read,
> > > +	.read_flag_mask = BIT(7),
> > > +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> > > +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> > > +};
> > > +
> > >  static int bmp280_spi_probe(struct spi_device *spi)
> > >  {
> > >  	const struct spi_device_id *id = spi_get_device_id(spi);
> > >  	const struct bmp280_chip_info *chip_info;
> > > +	struct regmap_bus *bmp_regmap_bus;
> > >  	struct regmap *regmap;
> > >  	int ret;
> > >  
> > > @@ -58,8 +95,18 @@ static int bmp280_spi_probe(struct spi_device *spi)
> > >  
> > >  	chip_info = spi_get_device_match_data(spi);
> > >  
> > > +	switch (chip_info->chip_id[0]) {
> > > +	case BMP380_CHIP_ID:
> > > +	case BMP390_CHIP_ID:  
> 
> These chip IDs, even though they are IDs, they are not unique and they are
> shared among sensors (see bmp280.h line 290). This means that this cases 
> are true also for BME280 and BMP58x devices which of course should not 
> happen because their regmap bus is the bmp280_* and not the bmp380_*.

Gah. Anyone who can go say very rude things to bosch please do so.
There is no point in having an ID register if you don't make it change
for incompatible parts!

> 
> It can easily be solved by removing the switch-case statement and adding
> an if(!(strcmp(id->name,"bmp380")) which checks the name which is indeed
> unique. I guess that this patch should be reverted, how should I proceed?

Add a flag to the chip_info structure that says whether the extra byte
is needed for a given part.  Then use that to pick the regmap.
Alternative would be a pointer to the right regmap, but that is probably
messier to do.

If the fix is simple, stack it as a fix for the fix. If not we can revert
it. Unfortunately it already hit mainline before I saw your message.
Make sure you include a short rant about who bad the hardware is.

Jonathan


> 
> > > +		bmp_regmap_bus = &bmp380_regmap_bus;
> > > +		break;
> > > +	default:
> > > +		bmp_regmap_bus = &bmp280_regmap_bus;
> > > +		break;
> > > +	}
> > > +
> > >  	regmap = devm_regmap_init(&spi->dev,
> > > -				  &bmp280_regmap_bus,
> > > +				  bmp_regmap_bus,
> > >  				  &spi->dev,
> > >  				  chip_info->regmap_config);
> > >  	if (IS_ERR(regmap)) {  
> >   


