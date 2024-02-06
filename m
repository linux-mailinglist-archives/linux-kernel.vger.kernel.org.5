Return-Path: <linux-kernel+bounces-55186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DC884B8F7
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76D301F24FDD
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F76134735;
	Tue,  6 Feb 2024 15:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="l+2+qdm1"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF93130E30;
	Tue,  6 Feb 2024 15:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232166; cv=none; b=PqbzOmtt6XHpwkX2T9JiFUIR2e0JfVq63tX7R+vIErfG6ERZdWQ6PWe0orhQqiPHGBlN/3a1nJEx9e/3n2k/2sTEjPhH7qqYWoZ6XSGPZnVPelnNN3u8DKXz3MpO/J4O6mFvi+15dcKJ/D1ziaKsG+FqhuGnoHffsE3JpqFnlNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232166; c=relaxed/simple;
	bh=zVeKe4QSAJqbzXHYc/ZtrbpDQe9hlBTFFtrfF+6N92c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YKyB70tU2CDgURcNFssV/7n+7DWn5HUCL3so+cPg16HiG2+VMNhEZjjjYcrbRtlJqseUuH6/QaNcvKZ2adf0foHrC03npOvn+ze2oZAk2ufZT+xqduY2uZ+EfqsANIRppjtnkXLOY312S9T4EZe7j6Zxh0/BeiWMy4HkfCRct7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=l+2+qdm1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707232165; x=1738768165;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zVeKe4QSAJqbzXHYc/ZtrbpDQe9hlBTFFtrfF+6N92c=;
  b=l+2+qdm1mIDtsf7da41+b0m0Z0t6TBafHhVLyDpQ0YU3dotzIAB9ZoYt
   MGzd1knJLGI5hZrSfWfSuOvSHkOxkuugHHiXPTEYZnDnw3K80UeN7UvJn
   OdX4Wff5ytPhapxtvWvpOVfYQqP9ion7Th59haUksl19hSYW0RwJRCoOD
   JJc4TZI6ElG+r+S1iL4QzbIn5On1+Jc1p2Y/cI3IiCtBI9eFZx8HHSoNV
   jwL0Kwg5uQe7fN2B5L5kukz2HUOd+DfJZKJMhpcPkrWgPtqrMDNMANdvQ
   LPi7GGnOlu8IVjgHSl98l2Pi3/+cbB86UAxgmu3k75pom9a3Wkw7k4DMV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11411288"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="11411288"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:09:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909662608"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909662608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 07:09:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXN4W-00000002N2u-3pP1;
	Tue, 06 Feb 2024 17:09:16 +0200
Date: Tue, 6 Feb 2024 17:09:16 +0200
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
Message-ID: <ZcJLnOiFoaABami1@smile.fi.intel.com>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
 <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:
> On 06-02-2024 15:25, Mike Looijmans wrote:
> > On 06-02-2024 14:50, Andy Shevchenko wrote:
> > > On Tue, Feb 06, 2024 at 02:33:47PM +0100, Mike Looijmans wrote:
> > > > On 06-02-2024 13:57, Andy Shevchenko wrote:
> > > > > On Tue, Feb 06, 2024 at 07:58:18AM +0100, Mike Looijmans wrote:

..

> > > > > > +    wasbusy = --priv->rdata_xfer_busy;
> > > > > Why preincrement? How would it be different from postincrement?
> > > > Maybe better write this as:
> > > > 
> > > > --priv->rdata_xfer_busy;
> > > > 
> > > > wasbusy = priv->rdata_xfer_busy;
> > > > 
> > > > I want the value after decrementing it.
> > > Yes, looks more obvious.
> > 
> > Having done that, and looking at it again, it's better to just eliminate
> > the local "wasbusy" altogether. More concise.
> 
> 
> This removes the decrement operator, so the method now looks like this:
> 
> 
> static void ads1298_rdata_release_busy_or_restart(struct ads1298_private
> *priv)
> {
>     guard(spinlock_irqsave)(&priv->irq_busy_lock);
> 
>     if (priv->rdata_xfer_busy > 1) {
>         /*
>          * DRDY interrupt occurred before SPI completion. Start a new
>          * SPI transaction now to retrieve the data that wasn't latched
>          * into the ADS1298 chip's transfer buffer yet.
>          */
>         spi_async(priv->spi, &priv->rdata_msg);
>         /*
>          * If more than one DRDY took place, there was an overrun. Since
>          * the sample is already lost, reset the counter to 1 so that
>          * we will wait for a DRDY interrupt after this SPI transaction.
>          */
>         priv->rdata_xfer_busy = 1;
>     } else {
>         /* No pending data, wait for DRDY */
>         priv->rdata_xfer_busy = 0;
>     }
> }

Yep and it looks like you reinvented atomics :-)

	atomic_t rdata_xfer_busy;
	...

But it's up to you what to do with that.
Maybe Jonathan can advice something different.

-- 
With Best Regards,
Andy Shevchenko



