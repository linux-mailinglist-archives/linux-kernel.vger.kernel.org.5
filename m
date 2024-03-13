Return-Path: <linux-kernel+bounces-102387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5F87B17D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:17:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B77B71C2833A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67E14CB47;
	Wed, 13 Mar 2024 18:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HyY4TDpC"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AD3210F8;
	Wed, 13 Mar 2024 18:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356096; cv=none; b=alIlLmCsVmhjep9G6F/6/HaRN16O4y0Kw2sDo2ie1CTnc6F+YAI8CF91xiv/yIW/FJjC8EwH5AQLQSD7SOM2fRLBCC+EaYe1FXUFcW33gdHqW5nuZIk6XKCQIJfUTLTU1M7eH7HdfX1+BAJE+ksBnAWWnwhOv6ZNBzB34AILHp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356096; c=relaxed/simple;
	bh=ZG1LuLekRiLfxzr/Jqbgw2nhEBHoB9a7CHQNHKlXSjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FPAKm3+c6G3DoX2ggHFNVFWOSNXXRWJ674K65G+6R3MunbIwaKe8+ypGqXUZKaE51BxAq/cbl/Byyokep2608nAcrCDw0QJYUGHxHwq/LHqaDClh8T6HvMDpFz7nMOY99J6f1xHvn1/hOsczzgxsAjXTH7xjFJhwNnTYZwUcVWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HyY4TDpC; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710356095; x=1741892095;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZG1LuLekRiLfxzr/Jqbgw2nhEBHoB9a7CHQNHKlXSjA=;
  b=HyY4TDpCBQz9e5NsE8v5i+JFFzk6UOIT2D/oclrMEMz3VbV8LPeryGNX
   C5IgEyfHHr5y7ddzU89JJP3GVyutAupqoqdDOCaTdoLLr6e1jO1t+W3De
   MaKvwWvKho0R42yIhmOeUK5wMl/7uZh0xl2Ke1BZGgzz522/XkxV3aiJS
   ahWGh4m0aqQ+lpY6RMw95FIMcqnv+w+xU5N7a4WzBoJJtQaZRH++Z8L3J
   pilG8AA7I6qf4aLafRCa7VPM2Xc5fDnQRIH4pI8la+Z3y43CkZ2sYTYQJ
   zYaciv9vDdtoIwZSzAlfLsaVfedAKIPGikk+fsgzPdz1Za3n9gAbstAxH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8965627"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8965627"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 11:54:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439124"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439124"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 11:54:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkTkV-0000000CIce-3mnc;
	Wed, 13 Mar 2024 20:54:47 +0200
Date: Wed, 13 Mar 2024 20:54:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZfH2dxmSzcw1_3vt@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-6-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174007.1934983-6-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 06:40:06PM +0100, Vasileios Amoiridis wrote:
> The scan mask for the BME280 supports humidity measurement needs
> to be distinguished from the rest in order for the timestamp to
> be able to work. Scan masks are added for different combinations
> of measurements. The temperature measurement is always needed for
> pressure and humidity measurements.

(Just to make sure if you used --histogram diff algo when preparing the series)

..

>  	{
> -		.type = IIO_HUMIDITYRELATIVE,
> +		.type = IIO_PRESSURE,
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED) |
>  				      BIT(IIO_CHAN_INFO_RAW) |
>  				      BIT(IIO_CHAN_INFO_SCALE) |
>  				      BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |

Stray change

>  					   BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY),
> +		.scan_index = 1,
> +		.scan_type = {
> +			.sign = 'u',
> +			.realbits = 32,
> +			.storagebits = 32,
> +			.endianness = IIO_CPU,
> +		},
>  	},

-- 
With Best Regards,
Andy Shevchenko



