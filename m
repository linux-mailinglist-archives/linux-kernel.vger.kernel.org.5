Return-Path: <linux-kernel+bounces-76738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEFB885FBCD
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E520DB22082
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500C31487C5;
	Thu, 22 Feb 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q65FEpMA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A32239FC7
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614258; cv=none; b=a1ItxPsyijXVk13hU3eUWZCnos8/Mptyal2EHz/RXupiQ696aRgGflTJRX93EB0vDHCytpDYBYqrGPLVcwYQ86/ZJWFJPnEg4qP73XgpauJgesiWWUYrSw5tFmAh5U8rO79A6ZKK7uPCOcHFJ4iD+YuFs18zQoaL21WjWNB6G5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614258; c=relaxed/simple;
	bh=FLnnfwOnjplXgzJeC+dzihkLf7mLPySqSS5uo2Y0V94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uQaT0+w9lAJGY4suXFtjPv5mzynJUb+wtjtdGlvVud2nq3lFmIwH7pdNNt/hWJpidl/Y2UnacvyqzxWZUbeqXhiLmMoBogqOvn/kW1DlXmZGTsXm/PLaYfW11icS0SoeXNezE4NefFfH/YDbvKRUFBQnAvH6tMXyv3WKfl1hcGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q65FEpMA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708614257; x=1740150257;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FLnnfwOnjplXgzJeC+dzihkLf7mLPySqSS5uo2Y0V94=;
  b=Q65FEpMAUxazkQqTBcJDZTNAaJFXFs+/v+TYo9YbqxsE0zROy9jy+jZI
   f9Ay7JuXRhGtnbtIFknCfkiWjRlgKc5nCoZmbJBF2ofnB0vIiBk1Zj0nj
   ZxGPcVvhtyXixSObQhI2Sg1Y6dhyGcvG3/7CZS/fiDyNRe6hpmaXR36FX
   a4YPDqE9KfVTd3gsJYuoZf1pLfij+qfQgbTtVaza0Qi057eoHEpYyK038
   yJ63p6DQKxQkqeso0nPxK+9Spiv80egmNkPbC9sCWwJd2ETBNX7IJSerT
   CZUbX/Dr9zRTRzREUIAWU8v0r/mvEva6r6Zegp0GABMxozGi7NVM6parI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2706672"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2706672"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:04:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="913539581"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="913539581"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 07:04:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdAcN-00000006etC-1HFZ;
	Thu, 22 Feb 2024 17:04:11 +0200
Date: Thu, 22 Feb 2024 17:04:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Yury Norov <yury.norov@gmail.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Jani Nikula <jani.nikula@intel.com>
Subject: Re: Re: [PATCH v3 1/3] bits: introduce fixed-type genmasks
Message-ID: <Zddiav19kX8FGKY9@smile.fi.intel.com>
References: <20240208074521.577076-1-lucas.demarchi@intel.com>
 <20240208074521.577076-2-lucas.demarchi@intel.com>
 <CAA8EJpprfrtOjNzT6TFhV1n6MXzLdTahanfxcRW4uVjeHaBduA@mail.gmail.com>
 <ZdZlVn9BI-0q1Xdn@smile.fi.intel.com>
 <btssirjumey2kcp5dyhe6m3embdwd5bswjz3c6swrhxfijfhld@lztxaptkegw6>
 <ZddfF7kb54o2c/QR@yury-ThinkPad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZddfF7kb54o2c/QR@yury-ThinkPad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 06:49:59AM -0800, Yury Norov wrote:
> On Wed, Feb 21, 2024 at 03:59:06PM -0600, Lucas De Marchi wrote:

..

> +#define __GENMASK(t, h, l) \
> +	((~0 - (1 << (l)) + 1) & (~0 >> (BITS_PER_LONG - 1 - (h))))

What's wrong on using the UL/ULL() macros?

Also it would be really good to avoid bifurcation of the implementations of
__GENMASK() for both cases.

..

> -#define __GENMASK(h, l) \
> -	(((~UL(0)) - (UL(1) << (l)) + 1) & \
> -	 (~UL(0) >> (BITS_PER_LONG - 1 - (h))))

This at bare minimum can be left untouched for asm case, no?

-- 
With Best Regards,
Andy Shevchenko



