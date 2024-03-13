Return-Path: <linux-kernel+bounces-102391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA7A87B1D5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 831A0B21308
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3813E664BB;
	Wed, 13 Mar 2024 18:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRmVzu1V"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C11664B1;
	Wed, 13 Mar 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710356295; cv=none; b=D+NQyrpW4aLOuKim0r2rwfB0B5SR1xcFrnf4XGLeEGDagXLk9qymb3thDDVAwGAeW0YwFPt53O53/C7DmxdrSh/suRhBAgVdtWv7xZqN4UKpViJtAHnDMo/QyTlz9Y0NpLIWsq1kDsOD67yGl9UixIgIpbkl0pLgTOsOFIVMMAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710356295; c=relaxed/simple;
	bh=bNBkFpT1lOTc7bKOGWs+J1UlZ4uINXCUBQzy318SRVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai7fSiUrKNjUP5dULyqULZxYdpOVlsFkiPHn7loBpsavg2ocrC9UnOO0xqjC04Uv1qnYyMoRHDo+db2nV1BpegB36DsBGJyTdSTljPklaufVXr5gknXr3Rsd373ftBpCEQd8zwLGi2J/fLhFJQ1kjTVKaRqNXs09/LYLSQgZyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRmVzu1V; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710356294; x=1741892294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bNBkFpT1lOTc7bKOGWs+J1UlZ4uINXCUBQzy318SRVM=;
  b=CRmVzu1VBYz/QPdoKk2GfWdtSRiIzaDsucItiqoIL0PF/GbzxkQs0wJe
   NBpgBCLGK9a6qB/BQENNs/hFx/q6uqdk4OWq5i+iIoVU58mpnGdoUIqIW
   n824dSsbYuyFJhDPD5/9DhTYKASC9VF7VsiU6AeEgiCZsX3GPWzbddw3m
   wDeWfYfgUckNArwWlKcGJjGePgsR3IETREsUmvGPqScpTrg3JQwqU3rrE
   yi88xjpYsdhr09/RJqORJooA+OjdyFbWi9PwcLZ33wyFr1uQXSfrPa1Cp
   zVRjTpxjf36aS6xOjwGcCwM4H1rE4ETL3d6awZN1qeUyUELc7k2PdvZcz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="8965846"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="8965846"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 11:58:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11012"; a="914439188"
X-IronPort-AV: E=Sophos;i="6.07,123,1708416000"; 
   d="scan'208";a="914439188"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2024 11:58:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rkTnj-0000000CIfF-3JU8;
	Wed, 13 Mar 2024 20:58:07 +0200
Date: Wed, 13 Mar 2024 20:58:07 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, linus.walleij@linaro.org,
	phil@raspberrypi.com, 579lpy@gmail.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <ZfH3P9dTiBHpjN5b@smile.fi.intel.com>
References: <20240313174007.1934983-1-vassilisamir@gmail.com>
 <20240313174007.1934983-7-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240313174007.1934983-7-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 13, 2024 at 06:40:07PM +0100, Vasileios Amoiridis wrote:
> Add a buffer struct that will hold the values of the measurements
> and will be pushed to userspace and a buffer_handler function to
> read the data and push them.

..

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,

dev here

> +					      iio_pollfunc_store_time,
> +					      &bmp280_buffer_handler, NULL);
> +	if (ret)
> +		return dev_err_probe(data->dev, ret,

data->dev here

Are they the same? If not, why this difference?

> +				     "iio triggered buffer setup failed\n");

-- 
With Best Regards,
Andy Shevchenko



