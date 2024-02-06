Return-Path: <linux-kernel+bounces-55050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1096384B6E4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB915288944
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F193131734;
	Tue,  6 Feb 2024 13:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CMdm1TN0"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9A60130E5E;
	Tue,  6 Feb 2024 13:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707227463; cv=none; b=VOEF6MDykm1PpzqlMthK5+/cGKiHMIGeC/r8Nqf4Gci8cklrlwPBv4sZez9CGpat0b7mD3YOmoYkd3VDya6Tt5M8VBFYs528S1TQFPHVTyKvokH4GnMfjj1Vw7Am8v/4HclAGnpr2roHaUVhhcqXnq6FlJfKOBm3j7T6gh7sioM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707227463; c=relaxed/simple;
	bh=40318rXtRK8bMlqY1+g0mB2+CszJHFdZCwiUpgUGL6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=itmliTmvtjBAwZQ18ipWNnHbiEaQjqyBHDLg5j8FMWL8waeTgPDJqrYmZPhzi6yG8JYy/QeITF5RNST1IOj/56rU8xQT5zHeNzMQ8d195JrC+W9FIm66KtvW6EmH960HYcTJhqvhQ/fmsemM56tj+JtqBdpnZD0r3XCBf62HT3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CMdm1TN0; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707227462; x=1738763462;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=40318rXtRK8bMlqY1+g0mB2+CszJHFdZCwiUpgUGL6Y=;
  b=CMdm1TN0RK9fcsUSI1yNL5KCcS7uV1Ly3vF0krifkr9rpg+WKsQ87B3L
   W74p8/BN0Bsf35AxClOsdOWB0Jf6+eSYyo0g1aF+SV2YNdQzJapQhwloO
   GNbiWKJl9p/yqpgWue41CoOlCE7897pxXD0OMZhOt6nbZPRAQCy+cfa/b
   P6EaZOACVrCuSoApXZNeTaGTvdMxl79f4d0JF+i5vzxBDWSARawQ+W1JX
   2hyYiGrSNEBv0kqOCzoBbNa4otaw6H3OJnX9zaW1LMT1JmJ+dQjVvhh1S
   UixoiSR67HkLeLzGTbWKDRN7DQnce6C3skQtBUMKpQecUywWK7IDdWJ+V
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="1017395"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1017395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:51:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909641034"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909641034"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:50:57 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLqg-00000002M0b-34Uz;
	Tue, 06 Feb 2024 15:50:54 +0200
Date: Tue, 6 Feb 2024 15:50:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
> On 06-02-2024 13:57, Andy Shevchenko wrote:
> > On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:

..

> > > +	factor = (rate >> ADS1298_SHIFT_DR_HR) / val;
> > > +	if (factor >= 128)
> > I just realized that this comparison is probably better in a form
> > 
> > 	if (factor >= ADS1298_MASK_CONFIG1_HR)
> > 
> > as it points out why this is a special case in comparison to 'if (factor)'
> > below. What do you think?
> 
> The "HR" bit sets the device to high-res mode (which apparently doubles the
> internal sample rate).
> 
> But "128" could be written as "1 << ADS1298_SHIFT_DR_LP" which is the max
> oversampling factor.

Use BIT(..._DR_LP) and we are done here.

..

> > > +	wasbusy = --priv->rdata_xfer_busy;
> > Why preincrement? How would it be different from postincrement?
> 
> Maybe better write this as:
> 
> --priv->rdata_xfer_busy;
> 
> wasbusy = priv->rdata_xfer_busy;
> 
> I want the value after decrementing it.

Yes, looks more obvious.

> > > +	if (wasbusy) {
> > To me more robust code would look like
> > 
> > 	if (wasbusy < 1)
> > 		return;
> > 	...
> > 	if (wasbusy > 1)
> > 		...
> 
> wasbusy could have been unsigned.
> 
> This code will only ever execute with rdata_xfer_busy > 0 (or the SPI driver
> called our completion callback without us calling spi_async first)

You never know what may go wrong in the future :-) That said, I prefer robust
code against non-robust.

..

> > > +	wasbusy = priv->rdata_xfer_busy++;
> > So, it starts from negative?
> > 
> > > +	/* When no SPI transfer in transit, start one now */
> > > +	if (!wasbusy)
> > To be compatible with above perhaps
> > 
> > 	if (wasbusy < 1)
> > 
> > also makes it more robust (all negative numbers will be considered the same.
> > 
> > > +		spi_async(priv->spi, &priv->rdata_msg);
> 
> The "rdata_xfer_busy" starts at 0.
> 
> Increments when a DRDY occurs.
> 
> Decrements when SPI completion is reported.
> 
> So the meaning of "rdata_xfer_busy" is:
> 
> 0 = Waiting for DRDY interrupt
> 
> 1 = SPI transfer in progress
> 
> 2 = DRDY occured during SPI transfer, should start another on completion
> 
> >2 = Multiple DRDY during SPI transfer, overflow, we lost rdata_xfer_busy -
> 2 samples


Maybe another good comment is needed here as well?

..

> > > +	dev_dbg(dev, "Found %s, %u channels\n", ads1298_family_name(val),
> > > +		(unsigned int)(4 + 2 * (val & ADS1298_MASK_ID_CHANNELS)));
> > Castings in printf() is a big red flag usually (it's rarely we need them).
> > Why is it here?
> 
> Compiler complains that the expression is "unsigned long". Probably because
>  of ADS1298_MASK_ID_CHANNELS being so.

So, use the unsigned long specifier and drop casting.

..

> > > +	if (reset_gpio) {
> > > +		/* Minimum reset pulsewidth is 2 clock cycles */
> > > +		udelay(ADS1298_CLOCKS_TO_USECS(2));
> > > +		gpiod_set_value(reset_gpio, 0);
> > I would rewrite it as
> > 
> > 		/* Minimum reset pulsewidth is 2 clock cycles */
> > 		gpiod_set_value(reset_gpio, 1);
> > 		udelay(ADS1298_CLOCKS_TO_USECS(2));
> > 		gpiod_set_value(reset_gpio, 0);
> > 
> > to be sure we have a reset done correctly, and the comment will make more
> > sense.
> 
> If used, the reset must be asserted *before* the voltages and clocks are
> activated. This would obfuscate that, and add a redundant call to set_value.

Then perhaps you want reset framework to be used instead?

Dunno, but this comment seems confusing in a way that you somewhere asserted it
and it's not obvious where and here is the delay out of a blue. Perhaps you may
extend the comment?

> I did forget to use "cansleep" here, will add that.

-- 
With Best Regards,
Andy Shevchenko



