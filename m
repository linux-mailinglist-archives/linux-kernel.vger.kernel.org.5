Return-Path: <linux-kernel+bounces-68640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B77857DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:27:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 988991C22762
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89D3012A16B;
	Fri, 16 Feb 2024 13:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtL8cFoK"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49381292C4;
	Fri, 16 Feb 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708090010; cv=none; b=jrlSnom1ocbfzrYwMRtipABThRKW24XUw2tg6UQmwH7Kig4UX8nMqjgMgDFMG5ZGJ6SNecpG0f5LujCfOnZJnTUP4BeJl+1gJLR1T/72oEqyzeCqA+76cC1/3uikrdLpaqB8TAUFRCf8eyHBGPxSTCuWWDIRBoz7gMoF1QlaDxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708090010; c=relaxed/simple;
	bh=nCSoQXvhVdKCB3DOU736XUg4x1krXDPxj7BClKnURSc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZo3iTymlKUHbimoT0MZ0mdh8yHxxqNdjsjURpVrq2c3sXdvxzH8LxUCFV+1BvggZcTGCUlRlexn7ENmkUQOPmH76lc74Q4uw1mh+DBhkJImp/ORzGvyhuiVBneoVRCtfInSiqzfU25y1mPhPlgOBzvDGir7wlHfQKRMEzqOr+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtL8cFoK; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a3d6d160529so95917766b.0;
        Fri, 16 Feb 2024 05:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708090007; x=1708694807; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U0Jt2rynQgnxjkqCU4MJk7EH2tlqprNDb1itfSDWYF0=;
        b=dtL8cFoKDLlz21h+wBZiPC/91rOnVjfevpD/r09TUxX4dpc99ixYepH6r6KTzfksdo
         rf4CMdKr8Qk6jRCzkpzsrlPso/bm5jxx9Oy3ngl/NCrA08zpMy0KKIY3kRTdnM3rUenF
         HXZzIZ4mtNm+NBJlDb7p+/fErXcrO92JSKgiYX8vHfpA56rsiI8HbLVrlLk3ktirg7VJ
         lg/Kqo2OeKargvAz2azB5hIHP2viNNJw/9Rxu0ZeIErMZtq9dsLABqN3pMwO7JVUOYuU
         srv0+FCyvX4YlgNCQoqJ4azCCLalU0HTyFMUpLlCsp3YyBdAQB18LvtYB65VUJOZRikA
         gTyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708090007; x=1708694807;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0Jt2rynQgnxjkqCU4MJk7EH2tlqprNDb1itfSDWYF0=;
        b=lHwhG8eG9yg++/HcMZDrydeOHHKQ/42roEzxkiYvhpG+1zgZh1sVVRaqLXAo9EqsJ+
         RWupgDDgE28ygdccMGria4qwN3yT1hViZWQrsLruOv/+EvQlfCkEOlKbMtCsIAjfpG2X
         hgP7/IUzliZn+GF/3NO56ZA3vkzCNxrYQJNGe8vGzU7irdqMMdDqDbqWaksTZxrZLiZD
         OIDzd2XPmijCft1Qc6z6xyL9484FaqGxVbdaodIa7fiBnXdmg483pjVTrKsRGV7kXUEE
         Py6fcOUCcxPX9kFiesbkrPJL/McVBlSEorTUHAFwrDWsez73z+6sUTQhNUd+eUFYLIfA
         zhDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnxgEbOKzsJJ+gdV1nej9GCzoIbDVale1Vtxn2uiDxrQwI/1O9olngDVEZWAFhvW6Idg1I9p0qcUpaAZ0ZH2h6FeqX5chIdVN8UMJYpZXAvJk22qF6xjIOWI3KRt+PdNjsNfcMtgvS
X-Gm-Message-State: AOJu0Yx6HymYwkK5rEtvEI+oUKw+NEG4EPJaj7v6Xt7V73YDbUEtJ2Xt
	8qrSOGPOjFmZ4MMBVPZlIXCbXSlN19UJQVE3fb1n5Gzb7FWT4+30
X-Google-Smtp-Source: AGHT+IHLqVWIWn7WaXKNW6HqTi6hGjNG8Sw1WJfMHyx605FUzb1qSRr2pCyyE6eyJFaut9/8H05uxA==
X-Received: by 2002:a17:906:228a:b0:a3d:eb7b:8eed with SMTP id p10-20020a170906228a00b00a3deb7b8eedmr1072942eja.34.1708090006867;
        Fri, 16 Feb 2024 05:26:46 -0800 (PST)
Received: from vamoiridPC ([2001:1458:204:1::102:961a])
        by smtp.gmail.com with ESMTPSA id vx12-20020a170907a78c00b00a3cf9b832eesm1547066ejc.40.2024.02.16.05.26.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 05:26:46 -0800 (PST)
From: Vasileios Amoiridis <vassilisamir@gmail.com>
X-Google-Original-From: Vasileios Amoiridis <vamoirid@vamoiridPC>
Date: Fri, 16 Feb 2024 14:26:44 +0100
To: Jonathan Cameron <jic23@kernel.org>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
	ang.iglesiasg@gmail.com, andriy.shevchenko@linux.intel.com,
	579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: iio: pressure: Add SPI support for BMP38x and
 BMP390
Message-ID: <20240216132644.GA4236@vamoiridPC>
References: <20240215164332.506736-1-vassilisamir@gmail.com>
 <20240216111834.73287ab0@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240216111834.73287ab0@jic23-huawei>

On Fri, Feb 16, 2024 at 11:18:34AM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 17:43:32 +0100
> Vasileios Amoiridis <vassilisamir@gmail.com> wrote:
> 
> > According to the datasheet of BMP38x and BMP390 devices, in SPI
> > operation, the first byte that returns after a read operation is
> > garbage and it needs to be dropped and return the rest of the
> > bytes.
> 
> Make it clear in the patch title that this is a fix and add a fixes tag.
> 

The original support for SPI was added 8 years ago. Should I include that commit
of 8 years ago in the fixes tag or just use a the word "fixes" with the rest of the
title?

> > 
> > Signed-off-by: Vasileios Amoiridis <vassilisamir@gmail.com>
> > ---
> >  drivers/iio/pressure/bmp280-spi.c | 47 ++++++++++++++++++++++++++++++-
> >  drivers/iio/pressure/bmp280.h     |  2 ++
> >  2 files changed, 48 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/iio/pressure/bmp280-spi.c b/drivers/iio/pressure/bmp280-spi.c
> > index 433d6fac83c4..c4b4a5d67f94 100644
> > --- a/drivers/iio/pressure/bmp280-spi.c
> > +++ b/drivers/iio/pressure/bmp280-spi.c
> > @@ -35,6 +35,32 @@ static int bmp280_regmap_spi_read(void *context, const void *reg,
> >  	return spi_write_then_read(spi, reg, reg_size, val, val_size);
> >  }
> >  
> > +static int bmp380_regmap_spi_read(void *context, const void *reg,
> > +				  size_t reg_size, void *val, size_t val_size)
> > +{
> > +	struct spi_device *spi = to_spi_device(context);
> > +	u8 ret[BMP380_SPI_MAX_REG_COUNT_READ + 1];
> 
> Given you rely on val_size < 3 you should check for that explcitly rather than
> potentially overflowing the buffer.
> ret is not a good naming choice for this variable as it's commonly used for
> integer return values.  Call it read_buf or something like that.
> 

Thanks for pointing this out it makes a lot of sense.

> > +	ssize_t status;
> > +	u8 buf;
> > +
> > +	memcpy(&buf, reg, reg_size);
> > +	buf |= 0x80;
> 
> Can you use regmap_bus read_flag_mask for this?  Seems to apply to 
> all devices supported. + that's common for spi regmaps
>

Yes I noticed it yesterday in my tests that this was missing and it actually
applies to all the devices. So the read_flag_mask should be added to both
regmap_bus structs. 
> 
> Mind you I note the bmp280_regmap_spi_write() is masking the bit out which seems
> backwards  - all the registers are defined with the bit set for that part
> but not the 380.  Ah well - not part of this fix even if it's odd.
> 
> 
> > +
> > +	/*
> > +	 * According to the BMP380, BMP388, BMP390 datasheets, for a basic
> > +	 * read operation, after the write is done, 2 bytes are received and
> > +	 * the first one has to be dropped. The 2nd one is the requested
> > +	 * value.
> > +	 */
> > +	status = spi_write_then_read(spi, &buf, 1, ret, val_size + 1);
> > +	if (status)
> > +		return status;
> > +
> > +	memcpy(val, ret + 1, val_size);
> > +
> > +	return 0;
> > +}
> > +
> >  static struct regmap_bus bmp280_regmap_bus = {
> >  	.write = bmp280_regmap_spi_write,
> >  	.read = bmp280_regmap_spi_read,
> > @@ -42,10 +68,18 @@ static struct regmap_bus bmp280_regmap_bus = {
> >  	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> >  };
> >  
> > +static struct regmap_bus bmp380_regmap_bus = {
> > +	.write = bmp280_regmap_spi_write,
> > +	.read = bmp380_regmap_spi_read,
> > +	.reg_format_endian_default = REGMAP_ENDIAN_BIG,
> > +	.val_format_endian_default = REGMAP_ENDIAN_BIG,
> > +};
> > +
> >  static int bmp280_spi_probe(struct spi_device *spi)
> >  {
> >  	const struct spi_device_id *id = spi_get_device_id(spi);
> >  	const struct bmp280_chip_info *chip_info;
> > +	struct regmap_bus *bmp_regmap_bus;
> >  	struct regmap *regmap;
> >  	int ret;
> >  
> > @@ -58,8 +92,19 @@ static int bmp280_spi_probe(struct spi_device *spi)
> >  
> >  	chip_info = spi_get_device_match_data(spi);
> >  
> > +	switch (chip_info->chip_id[0]) {
> > +	case BMP380_CHIP_ID:
> > +	case BMP390_CHIP_ID:
> > +		bmp_regmap_bus = &bmp380_regmap_bus;
> > +		break;
> > +	default:
> > +		bmp_regmap_bus = &bmp280_regmap_bus;
> > +		break;
> > +	}
> > +
> > +
> >  	regmap = devm_regmap_init(&spi->dev,
> > -				  &bmp280_regmap_bus,
> > +				  bmp_regmap_bus,
> >  				  &spi->dev,
> >  				  chip_info->regmap_config);
> >  	if (IS_ERR(regmap)) {
> > diff --git a/drivers/iio/pressure/bmp280.h b/drivers/iio/pressure/bmp280.h
> > index 4012387d7956..ca482b7e4295 100644
> > --- a/drivers/iio/pressure/bmp280.h
> > +++ b/drivers/iio/pressure/bmp280.h
> > @@ -191,6 +191,8 @@
> >  #define BMP380_TEMP_SKIPPED		0x800000
> >  #define BMP380_PRESS_SKIPPED		0x800000
> >  
> > +#define BMP380_SPI_MAX_REG_COUNT_READ   3
> This doesn't seem useful as only used in one place.

Could this define be moved in the bmp280-spi.c file or to not even use a define?

> > +
> >  /* BMP280 specific registers */
> >  #define BMP280_REG_HUMIDITY_LSB		0xFE
> >  #define BMP280_REG_HUMIDITY_MSB		0xFD
> 

