Return-Path: <linux-kernel+bounces-95874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D1A9875461
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:42:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF2591C222D7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E80D130AD1;
	Thu,  7 Mar 2024 16:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="INM5pfww"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF6212FF7F;
	Thu,  7 Mar 2024 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829746; cv=none; b=YetIR8t5KULkoU7eF6/i7zkhE1oNpauYjqiLjp1CMmzH5lZ0fRvlPlOICKb62gAsrfQj4a5TmJ/yglSeVl7QpoXWO/K8tXPwC2944YF6AjP7Bp3XJgaJpBB9sJhD/fJsmKInk8cbb2LQRdtIt/PjEftxitt4eSPI9tP9OIxWcSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829746; c=relaxed/simple;
	bh=ZXdkMhIS5MgKC1e5sI3Gt6Cf9SLaHZK+M2iKsKZocUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EbXH4cl60YvUM9ctdZF/gEq88vAJfuVmTSfxSRltmPE/QKrpWwkHbE1Mc+I4cjnt/Qus3Uo79NXjmXu79AD/AfoPZtJ5txJVHdURCUPal00ZSxIuFmc7pcLfaiq/54OihUPO9Z50bzojGWhyLnSPbe7y1cQ44KS9OFVv+lpfXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=INM5pfww; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709829745; x=1741365745;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZXdkMhIS5MgKC1e5sI3Gt6Cf9SLaHZK+M2iKsKZocUM=;
  b=INM5pfwwI5vuOT5sGBYMF/4nT1BedZ1i6n18HU5hee5PQD7jELbxSzlM
   CV7sulxdDux5gx+F739nei0HYy7eIai4Z8Pkroy3MnHL9woI8/Epx8fOP
   zo8pSpTltsE6htcwEeDNZTQb5zmSeXCJeCIaGlHIeKJhVRGv/e5HFDadV
   UNwtHXIZ6bjF+ZZLhFi/6yWte3zW/Uz5+WTznbYAMs9mdsHriaHCiR6HC
   BhNvi4db1JpelV4jhQYU9GSbrF/yNdX7GVdxtOzjbA/tW/G4NSiStc9QM
   uRzrVBhV1WDta6Zpe5IW7Mdg2WSRKTzzcGDAVadStO9DvHXQhTUJvrAO5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15232372"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="15232372"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:42:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219216"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="914219216"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:42:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riGp1-0000000AcG6-1YjK;
	Thu, 07 Mar 2024 18:42:19 +0200
Date: Thu, 7 Mar 2024 18:42:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 1/2] spi: pxa2xx: Kill pxa2xx_set_spi_info()
Message-ID: <ZenuatjkgVhAAybv@smile.fi.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-2-andriy.shevchenko@linux.intel.com>
 <1e2581ba-f7ce-43ad-8e32-c62601c8f5c9@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e2581ba-f7ce-43ad-8e32-c62601c8f5c9@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 05:30:10PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:
> > There is the only one user of the pxa2xx_set_spi_info(). Unexport it
> > and inline to the actual user.
> >
> I have no idea why you care about this,

PXA2xx headers contain a lot of legacy information for pre-OF era.
Besides slowing down the builds, this also pollutes an exported
namespace on many platforms where it's even not being used!

But this is just an ad-hoc clean up, as the main target to me was CS clean up
(as per next patch).

> but it's a nice cleanup,
> so I'm happy to see this get merged through the spi tree if
> that helps. Let me know if I should take it through the soc
> tree instead.

Thank you for the review!

..

> > -/* pxa2xx-spi platform-device ID equals respective SSP platform-device ID + 1 */
> 
> This comment might still be useful.

Okay.

..

> >  	spi_register_board_info(ARRAY_AND_SIZE(spitz_spi_devices));
> 
> I think the normal interface these days would be
> platform_device_register_data(), which does it all in one step.

I'm not sure how is this related to the SPI board info registration.

-- 
With Best Regards,
Andy Shevchenko



