Return-Path: <linux-kernel+bounces-48063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8E528456CD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCD71F28E1D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E3E15F32D;
	Thu,  1 Feb 2024 12:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwlJyvOW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BC15F31D;
	Thu,  1 Feb 2024 12:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789016; cv=none; b=Agd9lBaeysgLkZY8mHr8Ar9EDZR7rc/3wjVTElHL149g4EEXFx+8fZEHJpfuEoe1BYYz8qKAHIYQP9mlTNzpUrw/mFVwIiTjd1hl2uytSvRpBiRXU8090/EBvwaIWTelgghRkrCy+V5jSBVjN3kyHdDJqAMj4pYS6qBKWFsqy7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789016; c=relaxed/simple;
	bh=xVSfc7rtZNEubzwrbp9DZR56mDddDOEvo4VK0ZpA1cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xi1tHu3CTA5cCIswF0ncMzybGhcaN5GdXLOhJAJD9FxKRKT9xyEZOL9yJvpJDx8ChBTs/G5Ki2H1/gyruLsQBmLuqG+D2/O6doQk2C44Lok3FGXVWiC5As8AvdY1rhK53AE27UjqLpA8u9HIXlB3UyRTVDwiFPCRijxqe1m/UGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwlJyvOW; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789015; x=1738325015;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xVSfc7rtZNEubzwrbp9DZR56mDddDOEvo4VK0ZpA1cA=;
  b=JwlJyvOWzLsKGuHKNVDTu+NTukGLSFUF6lVYivHnp9L87EIHRGoG9gt9
   7Gf6QHjbtXZOHYZlv+4yvE2EYUC7EQgeb3EvznwTLYtXkNXvRAJTde3ak
   AX9XpXVHGqx2BfEe3F8j0dkMUI0YCXTw6KoPi1/75wQ9pnK/tVd5ykAjJ
   44pCaezCCu5PXK7rD4gJrUWj2c2LehV3fgt1VeuDfAJXjRyFearbSX6co
   OwcVc0GF2s6XqXPyA34XMVoml1miOFqFsZhMkgn6X4LSQAGwDryGtO3TR
   Mfymmizc8fVipIr8zwYv22K6PfZmWLj+HoUMJfXyEsEv05Jpiy8dDqWIL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="10531590"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="10531590"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="738410714"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="738410714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:31 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVDa-00000000ok5-0Gob;
	Thu, 01 Feb 2024 13:26:54 +0200
Date: Thu, 1 Feb 2024 13:26:53 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] pwm: dwc: Add 16 channel support for Intel
 Elkhart Lake
Message-ID: <Zbt__WmU74vmLpPR@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-2-raag.jadav@intel.com>
 <ZbZqZDvdw-_D3hyb@smile.fi.intel.com>
 <ZbjPv_-S-6CQsaja@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbjPv_-S-6CQsaja@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 12:30:23PM +0200, Raag Jadav wrote:
> On Sun, Jan 28, 2024 at 04:53:24PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 22, 2024 at 08:32:36AM +0530, Raag Jadav wrote:
> > > Intel Elkhart Lake PSE includes two instances of PWM as a single PCI
> > > function with 8 channels each. Add support for the remaining channels.

..

> > First option: Always provide driver data (info is never NULL).
> 
> Allowing empty driver_data would save us from adding dummy info
> for single instance devices in the future.

Which may be too premature "optimisation". Why? Because if we ever have
something like pci_dev_get_match_data(), the empty will mean NULL, and
we may not get difference between empty and missing one.

> > Second option, have the body of the for-loop be factored to a helper
> > dwc_pwm_init_one() and here
> > 
> > 	if (!info)
> > 		return dwc_pwm_init_one(..., 1, 0);
> > 
> > 	for (i = 0; i < info->nr; i++) {
> > 		ret = dwc_pwm_init_one(...);
> > 		if (ret)
> > 			return ret;
> > 	}
> 
> Considering above, we're looking at something like this.

As one option, yes.

> static int dwc_pwm_init_one(struct device *dev, void __iomem *base, unsigned int size)
> {
>         struct dwc_pwm *dwc;
> 
>         dwc = dwc_pwm_alloc(dev);
>         if (!dwc)
>                 return -ENOMEM;
> 
>         dwc->base = base + size;
> 
>         return devm_pwmchip_add(dev, &dwc->chip);
> }

-- 
With Best Regards,
Andy Shevchenko



