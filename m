Return-Path: <linux-kernel+bounces-90529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45B8700BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:48:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 814001F22782
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 702DC3B780;
	Mon,  4 Mar 2024 11:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YEMibPcV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA83D3B3;
	Mon,  4 Mar 2024 11:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709552875; cv=none; b=HYlRuLWZGSir1cGJZ0jQ4rNx86b7nTon0gSaqc2QcD14rwnPY8tS+ibzsl+MEvCtkK8JnJD5fESI2T3Bse/gbO03cHr1+qJ744XB0zO1zKqm89Q0jtgtWNzGIBEo2hR78NVbnc7/8ahvU6qo9CYERNwj5HeKpZgA5XKpi3LB6GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709552875; c=relaxed/simple;
	bh=4zR1jOUqdc6ss1ZYeRqMYmCpC1QGJFlUqRDoDLSTFec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/kvIVhgqsE36nXutozFqBBOh13jBLAT0tOy4XjILk6wGTpLvHVajGOSofw+JnEgd3yUbCUfD53haXtKGhzTSMpbwSIljSO2d2p5TTyJUuU4i+jBxLSNJoCw5p5uhVMfKVUzeJDnSf4D/SB5X5kFicbkSubRoOJDAxZX4+8mEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YEMibPcV; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709552874; x=1741088874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4zR1jOUqdc6ss1ZYeRqMYmCpC1QGJFlUqRDoDLSTFec=;
  b=YEMibPcVpNYxYnDVOlQhELmlNArDRi9AHBlRJvZr9HujYSzBGyt5xzMH
   lhkNcS4lVRNGdnmr9t0GXn5G0VMzhmK8aCNMurTKNJlsN6NGEzVZvL0a/
   AhDD70BwJRCXACfMGJxAqiG3fTlU0LbzYwOpGewrQp5Uft3ZLN8TbviBy
   P9u2xq2yOlqc4NPC0STK7HPjFItp+jJ/gB7GPcTsn39d4n/RWSN2QfsdQ
   MRAz4rfuwbycWaUs2qvhGz4QuSfxEziZkJ7QMEUp+CQ+7maZ+SeIo8nhW
   UmJ9FnsdMixqEHa0qUqb8oPtexgK3n0VmcVmfgw/oNEx1M9iqMh8iOCNE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="7811525"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="7811525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:47:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11002"; a="914103758"
X-IronPort-AV: E=Sophos;i="6.06,203,1705392000"; 
   d="scan'208";a="914103758"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 03:47:50 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rh6nL-00000009hlX-2KCW;
	Mon, 04 Mar 2024 13:47:47 +0200
Date: Mon, 4 Mar 2024 13:47:47 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZeW048EyOAze7oZR@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-4-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240303165300.468011-4-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Mar 03, 2024 at 05:52:59PM +0100, Vasileios Amoiridis wrote:
> The scan mask for the BME280 device which contains humidity
> measurement needs to become different in order for the timestamp
> to be able to work. Scan masks are added for different combinations
> of measurements. The temperature measurement is needed for either
> pressure or humidity measurements.

..

> +enum bmp280_scan {
> +	BMP280_TEMP,
> +	BMP280_PRESS,
> +	BME280_HUMID,
> +};

Hmm... Why do we need to actually copy the IIO ones? Can't we use IIO ones
directly (or in some way)?

..

> +static const unsigned long bmp280_avail_scan_masks[] = {
> +	BIT(BMP280_TEMP),
> +	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> +	0,

No comma for the terminator line.

> +};

> +static const unsigned long bme280_avail_scan_masks[] = {
> +	BIT(BMP280_TEMP),
> +	BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> +	BIT(BME280_HUMID) | BIT(BMP280_TEMP),
> +	BIT(BME280_HUMID) | BIT(BMP280_PRESS) | BIT(BMP280_TEMP),
> +	0,

Ditto.

> +};

..

>  	const struct iio_chan_spec *channels;
>  	int num_channels;
> +	const unsigned long *avail_scan_masks;
>  	unsigned int start_up_time;

Please, run `pahole` every time you are changing data structure layout.
Here you efficiently wasted 8 bytes of memory AFAICS.

-- 
With Best Regards,
Andy Shevchenko



