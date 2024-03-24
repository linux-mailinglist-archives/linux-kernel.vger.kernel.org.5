Return-Path: <linux-kernel+bounces-112654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F30887C98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 12:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B64A281B21
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 11:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B343179AF;
	Sun, 24 Mar 2024 11:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EHPS1b+h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDAD1759E;
	Sun, 24 Mar 2024 11:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711281363; cv=none; b=Rv+irXh5rcH9xnaPXKO9xSywYx2h5JN1VzxUaiPyyUT8NxbLtnCpXIPZYfUvWTQPGG+XKtxordUTXN6DV6jWHbW000PXKPu9QraLUEV2xa7SB5JG6Pb2QKJouZLHKlX1DmyBBVmhFSpBXa5/FG6eSdpkmh8CLp/IPiBUoJc5UXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711281363; c=relaxed/simple;
	bh=uFc5xOYMorRP4iyAhVgBe+McyNhmHUYOH62YqMisnBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y04x3mo4xL37Vk9bWjys16pPaDwQvRIZzIMbQITYt7QsJLQdQ8I8Us+/hmrWkC9ZZcVCLOBYNUzml9s7f5uBBSWtpwTJLqxqYikafu+TYX2FA/VpABCtSP0Tn0hFCUn6R4+x3CqwTkwaBmFXmzxbjWXq5eFSOJXts1xmBnLDxDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EHPS1b+h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5E7C433C7;
	Sun, 24 Mar 2024 11:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711281363;
	bh=uFc5xOYMorRP4iyAhVgBe+McyNhmHUYOH62YqMisnBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EHPS1b+htFbdIdhUpG07yQ+GSFFX2ipaeESGWCCw77WlyieKqBpo7yFph22STMKV7
	 U2BpzZra0RMtZbbrzU28LCGiXIDNE0YHe4mpKPaJKNmEXdXuJwcgCHn8t+rxKS33aL
	 SNfkb1WnI5yf1l9Kaz+YVUvMVbMiE/Swhp+FBDpMHgygMpUYaPQzMVDgDs9hz3WtCK
	 lvaSlbmdbPDk7t9K+CWrZjszamWpDwTT8kP8RjVj+DT5YxhPPqeVqgVMN+GftdsFUN
	 JfGVCVbSvMS+Ipsh7bUpiqkhtloCaHQvCLdhAqNSUCHudb+cIeS9D9lOSqA72AN1Xo
	 IHk4dRJ4XavFg==
Date: Sun, 24 Mar 2024 11:55:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
 linus.walleij@linaro.org, semen.protsenko@linaro.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <20240324115546.695d3e33@jic23-huawei>
In-Reply-To: <20240320174602.GA36450@vamoiridPC>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
	<20240319002925.2121016-7-vassilisamir@gmail.com>
	<ZfrFc9GF0_Jix5YT@smile.fi.intel.com>
	<20240320174602.GA36450@vamoiridPC>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 18:46:02 +0100
Vasileios Amoiridis <vassilisamir@gmail.com> wrote:

> On Wed, Mar 20, 2024 at 01:16:03PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 19, 2024 at 01:29:25AM +0100, Vasileios Amoiridis wrote:  
> > > BMP2xx, BMP3xx, and BMP5xx use consecutive buffers for their
> > > temperature, pressure and humidity readings. This facilitates
> > > the use of burst reads in order to acquire data much faster
> > > and in a different way from the one used in oneshot captures.
> > > 
> > > BMP085 and BMP180 use a completely different measurement
> > > process that is well defined and is used in their buffer_handler().  
> > 
> > ...
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_TEMP_MSB,
> > > -			       data->buf, sizeof(data->buf));
> > > +			       data->buf, BMP280_NUM_TEMP_BYTES);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_PRESS_MSB,
> > > -			       data->buf, sizeof(data->buf));
> > > +			       data->buf, BMP280_NUM_PRESS_BYTES);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP280_REG_HUMIDITY_MSB,
> > > -			       &data->be16, sizeof(data->be16));
> > > +			       &data->be16, BME280_NUM_HUMIDITY_BYTES);  
> >   
> > > -	adc_humidity = be16_to_cpu(data->be16);
> > > +	adc_humidity = get_unaligned_be16(&data->be16);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_TEMP_XLSB,
> > > -			       data->buf, sizeof(data->buf));
> > > +			       data->buf, BMP280_NUM_TEMP_BYTES);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP380_REG_PRESS_XLSB,
> > > -			       data->buf, sizeof(data->buf));
> > > +			       data->buf, BMP280_NUM_PRESS_BYTES);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB, data->buf,
> > > -			       sizeof(data->buf));
> > > +			       BMP280_NUM_TEMP_BYTES);  
> >   
> > >  	ret = regmap_bulk_read(data->regmap, BMP580_REG_PRESS_XLSB, data->buf,
> > > -			       sizeof(data->buf));
> > > +			       BMP280_NUM_PRESS_BYTES);  
> > 
> > These smell to me as candidates to a separate patch with more explanation why.
> > (Yes, with the definitions you introduced.) But I leave it to Jonathan to
> > decide if we need to split.

The are somewhat confusing, though only when you start doing bulk reads
to do these makes sense - so I'm not sure how to do it as 2 patches.

Pity we don't have sizeof(be24) available.

> > 
> > ...
> > 
> > The below are applicable to the bmp280_buffer_handler(),
> > bmp380_buffer_handler() implementations as well.
> > 
> > ...
> >   
> > > +	/* Burst read data registers */
> > > +	ret = regmap_bulk_read(data->regmap, BMP580_REG_TEMP_XLSB,
> > > +			       data->buf, 6);  
> > 
> > Magic size.
> >   
> 
> Hi Andy,
> 
> Thank you again for your feedback. When I was writing it, it was 
> looking as a magic number to me as well but then I though that 
> since I put the comment above it could be obvious. Now that I see 
> it again, I think it was not a good idea and maybe some type of 
> definition like
> 
> 	#define BMP280_BURST_READ_NUM_BYTES 6
> 	#define BME280_BURST_READ_NUM_BYTES 8
I think these are sums of the other quantities.  Better to
express them as such if possible.

> 
> could look better and be more intuitive.
> 
> > ...
> >   
> > > +	/* Temperature calculations */
> > > +	memcpy(&chan_value, &data->buf[3], 3);  
> > 
> > _le24() + sign_extend32()?
> >   
> 
> In the next line from your comment the _le24 or _be24 takes place.
I think you can get that data directly rather than bouncing it via
a memcpy.
e.g.
adc_temp = FIELD_GET(BMP280_MEAS_TRIM_MASK, get_unaligned_be24(&data->buf[3]);

> If the sign_extend32() is needed here, shouldn't it also be used
> in all the oneshot captures as well?

Is this actually signed?  Compensated values are, but at this point
it's just a raw adc count.  So I'm not seeing why we'd sign extend it
(unless the device is returning a signed be24 - I haven't checked.)


> 
> > ...
> >   
> > > +	/* Pressure calculations */
> > > +	memcpy(&chan_value, &data->buf[0], 3);  
> > 
> > _le24() + sign_extend32()?
> > 
> > ...
> >   
> > >  	/*
> > > -	 * Maximum number of consecutive bytes read for a temperature or
> > > -	 * pressure measurement is 3.
> > > +	 * Maximum number of a burst read for temperature, pressure, humidity
> > > +	 * is 8 bytes.
> > >  	 */
> > > -	if (val_size > 3)
> > > +	if (val_size > 8)  
> > 
> > sizeof() / new definition for the buf[] size?
> >   
> 
> In a previous commit that I was fixing this SPI driver, Jonathan had mentioned
> that there is no need for a specific definition since it will only be used
> here so that's why I kept it as is.

Never trust me ;)  Size of the buf is sensible here.

Jonathan

> 
> Cheers,
> Vasilis
> > >  		return -EINVAL;  
> > 
> > -- 
> > With Best Regards,
> > Andy Shevchenko
> > 
> >   


