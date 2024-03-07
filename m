Return-Path: <linux-kernel+bounces-95887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EFE875497
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AA8C1F20357
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98DC5130AFB;
	Thu,  7 Mar 2024 16:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CE4+hIOO"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB0012FF89;
	Thu,  7 Mar 2024 16:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830288; cv=none; b=bhbWoW6LZEtExfXpBcsFB7r4/PVURGeFe8zZFKbxAu7sSjISjRt0sglNh/Vse6Bw3CSfulo/7M6Boy0GUCeZwYkagwPRAOxccyhMFkReYKs+kWO679faWzqpoxbsqI95Pe1PCn6UCVtDYWo+Dn/6cDCOMjwP180vaMqqWmHtboY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830288; c=relaxed/simple;
	bh=ITBR+JQjgwxGUmINz/P8/aHsgmaAee3FMOYne7O1USA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfNGZXsLA4CaRu9vXtiz7g0AMeoGugaL/gTYxW6JwU377X1k7MNQzR2og0q/HL7y2a9cehM0DaABa7hyUVVtsEH04Uwhq/04Da3UfEdP/OgWcGyb5CkgPSdj3scNdIeKeJV/DSbtJLH2HleiZZhFMkjcWG8FGAotclRDt6/oDR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CE4+hIOO; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709830287; x=1741366287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ITBR+JQjgwxGUmINz/P8/aHsgmaAee3FMOYne7O1USA=;
  b=CE4+hIOODq8cjqEIm/Dneouo7aiMhgme0/j/Kp0vlHFJt69vC9oia9ax
   X2GBXkZe5FPSGiiR6YQQVnJYZ/YA4OV2Xh9MzpNt/VXk2OCfO9mR+TD6N
   L4vQzNmRHdJnyMQXmme+d0Y748YPCMkwjeKpBsdp0hQyrYlFeGvyykwf7
   g8FgZlqAgXV/x0C6iJIKYYHCynnYoOZ1+IjTGSj6PhrW6+VwxP2IKVNbw
   z2rpXxcmt3QXSqFsSatsFsVnaZrPuYv+ZGG9R6BncnPv2EeWpHnmZjH3D
   xx7udUJ7eFj4mSC+nVUg/pPGE1TzB8URMYr96CnempCGi+D3GLfHwEHnh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15233741"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15233741"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:51:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219365"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="914219365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:51:24 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riGxl-0000000AcRd-3GkP;
	Thu, 07 Mar 2024 18:51:21 +0200
Date: Thu, 7 Mar 2024 18:51:21 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Message-ID: <ZenwiedQygeiiCZO@smile.fi.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
 <1e2581ba-f7ce-43ad-8e32-c62601c8f5c9@app.fastmail.com>
 <ZenuatjkgVhAAybv@smile.fi.intel.com>
 <fd47619b-e61f-4d89-af4c-5c967fa1ec2d@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd47619b-e61f-4d89-af4c-5c967fa1ec2d@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 05:47:56PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 17:42, Andy Shevchenko wrote:
> > On Thu, Mar 07, 2024 at 05:30:10PM +0100, Arnd Bergmann wrote:
> >> On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:
> >> >  	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
> >> 
> >> I think the normal interface these days would be
> >> platform_device_register_data(), which does it all in one step.
> >
> > I'm not sure how is this related to the SPI board info registration.
> 
> It's not. What I meant is that you could use
> platform_device_register_data() instead of the
> "platform_device_alloc(); platform_data = info; platform_device_add();"
> sequence.

Ah, thank you for elaboration.

> It should be a safe conversion, but it's also fine to stay
> with the existing version if you are worried about regressions.

Yeah, I prefer not to change it here (as it out of scope of my little
cleanup series).

-- 
With Best Regards,
Andy Shevchenko



