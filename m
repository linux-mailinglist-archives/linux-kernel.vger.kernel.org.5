Return-Path: <linux-kernel+bounces-58525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B475084E798
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 19:21:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7087028D9AB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 18:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CF001272DB;
	Thu,  8 Feb 2024 18:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GsrgonOt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90BAB1272D7;
	Thu,  8 Feb 2024 18:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416460; cv=none; b=YhmBc5TEFaAqejyMxuZDU2QBwdhVMLgMCHc/oyOXxfxD9QEG6ivVVhTrsNOUbTTPY1Td0b+qWC9Hm/5PDakfNAwQV/W13XiU3eSR2jK0PxVpuQ5Vr67R4DkACpDvRGsw4+02APBS698/A74wBiRuWNSdNDxgW5e8df7wz9wtfZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416460; c=relaxed/simple;
	bh=T3vb+jr3/jxIvGpmzS29XAGMcNYik+deK0DgE3lOQZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Me+6BS8nyA29Ke6NgHALXOSduNYImllPpLSaUqHHwQ2t8RxJ274jnqw5eqSpB/cK2PQIrlrEykgeyqS1gfWoSN2W/ZGyAaGnVA/DEEgc/ZcK4AtFvAyiOJFxApuiy826zXNh6AOq/z0lbsYT2t+GohbtmiDudxhv87PLU++2vns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GsrgonOt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707416460; x=1738952460;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T3vb+jr3/jxIvGpmzS29XAGMcNYik+deK0DgE3lOQZk=;
  b=GsrgonOtIomwpGd7ICyT1bZuy84tEl7l/FLpANkDFgVrnEzpRwG6eL4W
   GsV8F345MFL+3olxXdp/Z2QE6ZjKYcMFMkzJrV8DPrHdfKvSF2wzpunpU
   Vbxd5P69HMiCRysHBfOD6/xNZS2Meuc0LRWIfLt9xAEfbOSw3zULIiuSW
   5uzbXosB8+3hpJqnLgSQIP9XgmGtFN/o7HT8XOExkOhS9Li3yq1MkZ1Av
   F41cM6bHh4/zq8eOWok15ywqf3k+PeZ8j4jLV1dJDfri3MSS5rQQRDFVV
   ltiudNz6icDSZDoyxRJDPRPXm05PHRf7hyVQEmFNTFex//VtycCci5jy6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1441439"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1441439"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:20:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910461465"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="910461465"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 10:20:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rY912-00000002wny-0ahW;
	Thu, 08 Feb 2024 20:20:52 +0200
Date: Thu, 8 Feb 2024 20:20:51 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: alexandru.tachici@analog.com, alisa.roman@analog.com,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, jic23@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	lars@metafoo.de, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, michael.hennerich@analog.com,
	robh+dt@kernel.org, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 1/5] iio: adc: ad7192: Use device api
Message-ID: <ZcUbg1sl1vaNiaH0@smile.fi.intel.com>
References: <20240208172459.280189-1-alisa.roman@analog.com>
 <20240208172459.280189-2-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240208172459.280189-2-alisa.roman@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

Subject should be:

  iio: adc: ad7192: Use device property APIs

On Thu, Feb 08, 2024 at 07:24:55PM +0200, Alisa-Dariana Roman wrote:
> Replace of.h and corresponding functions with preferred device specific
> functions.
> 
> Also replace of_device_get_match_data() with
> spi_get_device_match_data().

..

>  #include <linux/err.h>
>  #include <linux/sched.h>
>  #include <linux/delay.h>
> -#include <linux/of.h>

Actually this has to be replaced by property.h (placed somewhere before
slab.h).

-- 
With Best Regards,
Andy Shevchenko



