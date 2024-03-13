Return-Path: <linux-kernel+bounces-102392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB89187B189
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 313401C27F28
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E1D56440;
	Wed, 13 Mar 2024 19:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EY2Pydaj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A463225DE;
	Wed, 13 Mar 2024 19:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356556; cv=none; b=CWAB6Bz3oqwwPDx8R2Twl3mteZUmvDPzUzx2eOlvaF+cWfkS9+Q07Pp7pxgIURXPidbxljaMITfj5YnD4X7TLrtbUr9JDlbR9bpo3DQWyrOhAc9qaLspyfaHrgAQNPrTcI5QwHLxFBXPdLEFwgRJ0Dm9OwKQECAZ50WTiQHGpEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356556; c=relaxed/simple;
	bh=Yz4mTpJ4QQ7245qWd/JzIlgbf8MSRzBz6tfWD10wBdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRMeU2ZxnXgC0AnkV5qf/V2Y72jCDmI9epQNThNB6zIyVXd1o2v6DRdc5/EvrNi/Q0ova6+fTv2O1U1bcr54wMyWw24fZxyQOAZoB0L8dk0XRwMUkoeN0pwqdq8xsdn9c7o65aB1K1zkFSjJ5ILFUcIKlYw/6Y9CtmVU5IPOh/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EY2Pydaj; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710356555; x=1741892555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yz4mTpJ4QQ7245qWd/JzIlgbf8MSRzBz6tfWD10wBdM=;
  b=EY2PydajNR7eYIRpiP1tPxjr02VAOQXFJ+YZp0ysv3dfSTlzh1WllK2s
   zVo/Ih6RffqowtI8N1Et0qUe8rg6XfyP2D8UeH7bYatHTThbGAzZIVPtn
   IKm5G8A3ttYh3DjYsfGM52p2XKjwabGPIaqXWaGeJN6J4ncDkgF/JNLkg
   2fCOCNl+O7ejxoOVuyQIy71JRzotuUza8bK1P4JPUJm3/xNP3GeRyNtwh
   qpPPY/xsm209uyECG+mR4kiMWbAXt8cx48nJz27QZDwbdEo6r2VWexXjt
   jr1zYxBf2MJETkFI1K5OASP7407H31FrW1P1aDtHw2AGuxEwzrw2tSZm0
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8966436"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8966436"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:02:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439267"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439267"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 12:01:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkTrP-0000000CIhg-2NCK;
	Wed, 13 Mar 2024 21:01:55 +0200
Date: Wed, 13 Mar 2024 21:01:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/6] iio: pressure: Simplify read_* functions
Message-ID: <ZfH4IyeFTGFBKT4J@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-3-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174007.1934983-3-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 06:40:03PM +0100, Vasileios Amoiridis wrote:

In the Subject: ... read_*() functions

> Add the coefficients for the IIO standard units inside the chip_info
> structure.
> 
> Remove the calculations with the coefficients for the IIO compatibility
> from inside the read_(temp/press/humid) functions and move it to the

read_{temp,press,humid}()

> read_raw function.

read_raw()

> Execute the calculations with the coefficients inside the read_raw

read_raw()

> oneshot capture functions.
> 
> Also fix raw_* and comp_* values signs.

..

>  		case IIO_TEMP:
> -			ret = data->chip_info->read_temp(data, val, val2);
> +			ret = data->chip_info->read_temp(data);
> +			*val = data->chip_info->temp_coeffs[0] * ret;
> +			*val2 = data->chip_info->temp_coeffs[1];

> +			if (!strcmp(indio_dev->name, "bmp580"))
> +				ret = IIO_VAL_FRACTIONAL_LOG2;
> +			else
> +				ret = IIO_VAL_FRACTIONAL;

I'm wondering if we may replace these strcmp():s by using enum and respective
values in chip_info.

>  			break;

-- 
With Best Regards,
Andy Shevchenko



