Return-Path: <linux-kernel+bounces-59897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F3F84FD11
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA6911F26FD7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 19:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE19584A45;
	Fri,  9 Feb 2024 19:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F14fcLzX"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1688287F;
	Fri,  9 Feb 2024 19:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507717; cv=none; b=rlw/ZJwIZxqTKtHNCPdQNMx5ZVBQXau8tD77y9D37rstFBNW1JqeQkWPsqtQyrnz0etp7WDQZwenzamIDr56Xu7uiYPDfHLkFnoqaK++CnyyRT2rMaOUG5v7wKoqs3maiLpAEBBB3S0QXDwpR1hWcdqP+ssSKE5P9aW+0p4dWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507717; c=relaxed/simple;
	bh=K4kGHFR79qYmns8UFB0SR/ptRolARmZfpDSEAM/WafA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueYVdc37qPcwCoNQV0wlbYkMrhqGg0rlhtYNM9dFshIBXONo0v/iYfGxUGsACKOXIG1N4eAd3aLgsBbWkRpL8Qgq+sxhHT/ZvtE8TO72Bs2+j/2CIBmkH3Zq9KBTQrq9fa7NcC2STNB2Kl8KqDiq6VTRUPoA2RFhYNeWgsDqoSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F14fcLzX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707507715; x=1739043715;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=K4kGHFR79qYmns8UFB0SR/ptRolARmZfpDSEAM/WafA=;
  b=F14fcLzX8g2qlibOJ52DpqmkfLOQCE3OZ25BOldpI/cOh3MH2zZR1Vst
   2eBncBjh8ce3SpzWccRTpf6zul+PRiGyHOwtm6f//NVwPnA4U14dmLiKi
   TzYvZq7wyT4sOx8ELeDCCgHLlBhzQPx+VBeilBwqIaOFjgOoyoWilHyZP
   L/dbWYEksiu+PoyXf6Dp2eup3MpLo20kR0mR/tSCafIFRO8rXH7L6KAAa
   XA4Ty1R/Avs5TjXEuUtRCX4T72goQcobvx6PTfoKWVmOmWzlysVRLyQFB
   SIuyb9Y+qqpYBXYCw4dr4K1ebQXLuRWLlRo8exYCikMwC1nYjFZsUFMrC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="5341467"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="5341467"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:41:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910803382"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910803382"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 11:41:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYWkw-00000003GZg-1HCS;
	Fri, 09 Feb 2024 21:41:50 +0200
Date: Fri, 9 Feb 2024 21:41:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <ZcZ__nnOz1QA7uUZ@smile.fi.intel.com>
References: <20240208070529.28562-1-raag.jadav@intel.com>
 <20240208070529.28562-3-raag.jadav@intel.com>
 <ZcUNe09gDtkztmbk@smile.fi.intel.com>
 <ZcZ6kUkf-GktlU4p@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcZ6kUkf-GktlU4p@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 09:18:41PM +0200, Raag Jadav wrote:
> On Thu, Feb 08, 2024 at 07:20:59PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 08, 2024 at 12:35:26PM +0530, Raag Jadav wrote:
> > > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > > function with 8 channels each. Add support for the remaining channels.
> > 
> > Side Q: Have you used --histogram diff algo when prepared the series?
> > If no, it's better to start using it.
> 
> I used it for a few weeks, but I think I've grown a bit too comfortable
> with patience.
> 
> I'll use histogram for pinctrl stuff if you insist :)

It's recommended by Torvalds:
https://lore.kernel.org/linux-gpio/CAHk-=wiVNOFP1dzKdCqXvoery5p8QoBB5THiJUMbZ1TxJb7FhQ@mail.gmail.com/

-- 
With Best Regards,
Andy Shevchenko



