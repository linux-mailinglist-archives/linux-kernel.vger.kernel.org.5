Return-Path: <linux-kernel+bounces-95876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F6C875464
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF67C28322F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E0AB12F399;
	Thu,  7 Mar 2024 16:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NDvbyee6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBE161
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829842; cv=none; b=oG0RBuWkvU+UvALeKe6sN7EmnK1/rl3eJjIuqDITGAKlxSpzHijKP8A+3w/Zhit94Ps767c11PjG/p+MqUa3OtPw6XTbYBnHMlp4WSP7l+odR0+kQS9W6k9hmgtuxQ8Ky4DMBd7sMDF05I3KgSjrwrX2jPjPSUQhmBwvJw7fR5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829842; c=relaxed/simple;
	bh=gaZEpwC4w0EVPLOzZztBRRG7BCZgMnNQ4ch6Lg9f/6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZR+rvcauGCFKD4T1ZIpxEG54VygQU1JhmSoqLnArTCMbEkL2mONvmzT5Y1mVFAC1AlCu3Wh0Ip7cag9+FY7oc4ZARsd9PbAEOIWm/TNPPgtBEEFg3vWo1y6T2oqzExve7poBoCGrHOkFLgdBAYppJXYlfoGF4hiw7sT0gA3Rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NDvbyee6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709829841; x=1741365841;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=gaZEpwC4w0EVPLOzZztBRRG7BCZgMnNQ4ch6Lg9f/6I=;
  b=NDvbyee6byefBHVWm9zOjK156XL6pRITwULdrf4Xh+CwyujResmcpMSf
   l/V2ZWUe1+MxLN/jwUahL8w4+Y5CbMTyF86AuoFMO48/J88jyGEwi0txP
   T90S2mVR57rNK6PMrmwSFlgdllUsGma2LUU/z/FgjtiyWLgZlnZXazA5y
   czkVrXTyzMp7YQ7x5NPj9KoJOcwzAzK2cR1B0AlKZ9S9l+rPMA/cjK89F
   VJNQQNE29oo+r8rglRoQS3I3KIyFqM3MTwO4HxbEJrqxLTfHA5HbDWT+0
   jGY3qlWIcxOIWn2Af9AU+cwZSw77/OVlH2PPs/5KiWqyEqPuqvPUTyDFY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15232837"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15232837"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:44:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219247"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914219247"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:43:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riGqa-0000000AcKA-3niw;
	Thu, 07 Mar 2024 18:43:56 +0200
Date: Thu, 7 Mar 2024 18:43:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v1 0/5] w1: gpio: A set of cleanups
Message-ID: <ZenuzMtybS4CzwHv@smile.fi.intel.com>
References: <20240307143644.3787260-1-andriy.shevchenko@linux.intel.com>
 <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vsaqquulifmpk5fanl4i67nzag5huyibzy5lfr2jdsgk2dv7t3@5i4opts7npsj>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 05:38:54PM +0100, Uwe Kleine-König wrote:
> Hello Andy,
> 
> I wonder about your choice of recipients. I would have added Krzysztof
> to To and me at most to Cc:.

It's automatically generated using get_maintainers.pl.
See details in the source of the script [1] I'm using.

[1]: https://github.com/andy-shev/home-bin-tools/blob/master/ge2maintainer.sh

-- 
With Best Regards,
Andy Shevchenko



