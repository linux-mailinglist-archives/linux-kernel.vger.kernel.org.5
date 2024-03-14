Return-Path: <linux-kernel+bounces-103403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 103B187BEF4
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FF531C20EC3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668D26FE26;
	Thu, 14 Mar 2024 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipkufx3x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC821D53F;
	Thu, 14 Mar 2024 14:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710426768; cv=none; b=Ek2WcYU9J8NeyNP6ZRa79rS+mNTwvq4QED/IG1nu5FSKO/H/aPux/Mn2Bm+rKoyJJkm9OJQ8uO9uNc5V1FcqkZuf7/kY4bmC2TEgoH8jK97lJOan5mT16RLT7iIz4q3VXSh03Hb6tLUpWUlj4pxZyKxw9s3gQIhzEHhGw8bKrs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710426768; c=relaxed/simple;
	bh=DiUVeysbSuDpknPfqId6mBt1tb9vzHNzOcoWlzmxm68=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BWFV84KzYkSIm9dab5V363+2n0Cuj2xuaxa8zrRAYerRW7sCrMECE043f2INFzIFi7+EktRjN90ULr7qf1SHGAwofQryAlgTnGKYkpkg3kq3F5aOE78blPYMgKpIA3clgOZ3GaeGgPVc3765iLn9RDuxzpJrsAFhOwophO66IwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipkufx3x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5445AC433C7;
	Thu, 14 Mar 2024 14:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710426768;
	bh=DiUVeysbSuDpknPfqId6mBt1tb9vzHNzOcoWlzmxm68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ipkufx3xDcexYOSI9jGCF0BXBhSoSUT3yCnjh4qCIspT/K7fcbQAb3LCO+Ltogr6S
	 6nwJ/f/rxHn3Sua/j7RmOccYn4pWpMgS4O+3Ob5LPi2E0fSXKrJFg52tVfy1Tp/Jcd
	 RqWeyMdLdZe0aqtdqfxU+4bzOhx8pGhy5GdZPdnGKZ+F6uVH0OOfUSATuVthTAgpgR
	 dmfmGNKK6QZ60AyO/xUHo2r0Jk0POdOuv9aYS5xT1h3kKlro9Z9joZYcH5Bkm1OzaQ
	 xyDFg5g3G/toAcIgDqcToy11zJoeJ3AngsylZAZli3ofYVBzX6BsM6m+3BBu3AH0Mu
	 fvt/kl9KJJLkA==
Date: Thu, 14 Mar 2024 14:32:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Vasileios Amoiridis <vassilisamir@gmail.com>, lars@metafoo.de,
 ang.iglesiasg@gmail.com, mazziesaccount@gmail.com, ak@it-klinger.de,
 petre.rodan@subdimension.ro, linus.walleij@linaro.org,
 phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <20240314143231.671bf685@jic23-huawei>
In-Reply-To: <ZfH-b2KWcU_8-Nmh@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
	<20240313174007.1934983-3-vassilisamir@gmail.com>
	<ZfH4IyeFTGFBKT4J@smile.fi.intel.com>
	<20240313192245.GA1938985@vamoiridPC>
	<ZfH-b2KWcU_8-Nmh@smile.fi.intel.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Mar 2024 21:28:47 +0200
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Wed, Mar 13, 2024 at 08:22:45PM +0100, Vasileios Amoiridis wrote:
> > On Wed, Mar 13, 2024 at 09:01:55PM +0200, Andy Shevchenko wrote:  
> > > On Wed, Mar 13, 2024 at 06:40:03PM +0100, Vasileios Amoiridis wrote:  
> 
> ...
> 
> > > >  		case IIO_TEMP:
> > > > -			ret = data->chip_info->read_temp(data, val, val2);
> > > > +			ret = data->chip_info->read_temp(data);
> > > > +			*val = data->chip_info->temp_coeffs[0] * ret;
> > > > +			*val2 = data->chip_info->temp_coeffs[1];  
> > >   
> > > > +			if (!strcmp(indio_dev->name, "bmp580"))
> > > > +				ret = IIO_VAL_FRACTIONAL_LOG2;
> > > > +			else
> > > > +				ret = IIO_VAL_FRACTIONAL;  
> > > 
> > > I'm wondering if we may replace these strcmp():s by using enum and respective
> > > values in chip_info.  
> > 
> > The whole problem starts from the fact that all these BMPxxx_CHIP_ID defines are
> > not unique for the respective BMPxxx device. You mean to add a new variable
> > that could store some enum values that would be the actual chip_info IDs? Like:
> > 
> > enum chip_info_ids = {
> > 	BMP085,
> > 	BMP180,
> > 	...
> > 	BMP580,
> > };
> > 
> > and later for every chip_info struct to use it like this:
> > 
> > const struct bmp280_chip_info bmpxxx_chip_info = {
> > 	...
> > 	.chip_info_id = BIT(BMPxxx),  
> 
> No BIT(), but yes.
> 
Better to use something more meaningful such as just storing the
type you need to return alongside the values it refers to.
temp_coeffs_type = IIO_VAL_FRACTIONAL_LOG2 / IIO_VAL_FRACTIONAL as appropriate.
That way the data and what it is are found in one simple place.

Basic rule of thumb is that if there is a string comparison to identify
what to do in a driver (other than deep in the fw handling code) then
that is a bad design. Likewise any matching on an enum value that correlates
with that chip ID.  I want to see all the difference between chips in one place,
not scattered through the code.

Jonathan


> > 	...
> > }
> > 
> > And in the read_raw() function to just use the test_bit() function in the same
> > way that is done with the test_bit() and avail_scan_mask to test for the
> > enabled channels?  
> 
> If BIT() is more suitable, than also yes.
> 


