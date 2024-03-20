Return-Path: <linux-kernel+bounces-109403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64F118818AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EDA9B224A0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7052C4204C;
	Wed, 20 Mar 2024 20:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QgJGxvIL"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4547B1B7F5;
	Wed, 20 Mar 2024 20:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967092; cv=none; b=i/tRzWiED9WMDVw3+gKiwjuudphTdDyhwWQ1Sg7mOsuozzkIrDoH1nqKn9ohxxXWNTD75bf9KjyfNE9xO/pEbZ36+1KewZGNQfGoSF13NxS3/41GmDkir6glSGzdusP2m0RSlhQE933XwzkytSZ72MGyWU0cNH3FQh9RoA+8W/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967092; c=relaxed/simple;
	bh=hNgRL40LSQB7xQcowVuzTKGVxepJYYGDnej/MLNsDIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YXYAVA9vUmRxJkEHo9xahIxwtudP6zfkwmP53peM7TgeAVOzo6LB45+7eAUxlPJeJPjzIzbBHeq7nYT4rjdR1c41kyMriZD39d2MWOd+gkPxXTbp3Zt2TH95u8hr9iKXbSPw5hbzxbWNh+Mau4ErsWgaLcXZdz/eO5Hhi4zu710=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QgJGxvIL; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710967091; x=1742503091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hNgRL40LSQB7xQcowVuzTKGVxepJYYGDnej/MLNsDIE=;
  b=QgJGxvIL5Ame/tjQhnONkB8JFVUSufY1AqI9EyQDOKjnOeZsH0PySuyj
   jrx7vWnOrYaLJ/LWK+U6JuVCcty3Z/27nu5obz1jyU1jNXF3P+1Y+3zo1
   yxYHVs0X3FcN/k0QIAJgceJugMm/y15bXZVW0MsXj7x5JEjrfW9zAbs1I
   y1KLgzgLGPq90nZRP4e7KdiMHSDhzdnFhILMFRwOSqaweeMfjDeiJxtaW
   Woy27HPSnzmM63e1G96jtCNAVaLrQXREowoFzzSGq4saAzIeLbAQekzSU
   yYHQw85P7olwKNd4qF0HBSI/lRUYmGTg3+TLa/DBp1Ghy6Oy8Q0kVA/iY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="5792099"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="5792099"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:38:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914678292"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="914678292"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 13:38:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rn2hH-0000000EgP1-2vqb;
	Wed, 20 Mar 2024 22:38:03 +0200
Date: Wed, 20 Mar 2024 22:38:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZftJK3cqFNU9-dCG@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-6-vassilisamir@gmail.com>
 <ZfrDW1ESxnFg__od@smile.fi.intel.com>
 <20240320184516.GB36450@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320184516.GB36450@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 07:45:16PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 20, 2024 at 01:07:07PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 19, 2024 at 01:29:24AM +0100, Vasileios Amoiridis wrote:

..

> > > +enum bmp280_scan {
> > > +	BMP280_TEMP,
> > > +	BMP280_PRESS,
> > > +	BME280_HUMID
> > 
> > The last is not a terminator, please leave trailing comma.
> > 
> > > +};
> 
> What do you mean it is not a terminator? In general with the enum
> variables I would write:
> 
> 	enum var { a, b, c };

This example is different to what you used. I.o.w. _this_ example is okay.

> Why in this case there is a comma needed after the BME280_HUMID element?

It's pure style issue that helps to avoid the unneeded churn in the future in
case the list is getting expanded. You can easily imagine what I mean.

-- 
With Best Regards,
Andy Shevchenko



