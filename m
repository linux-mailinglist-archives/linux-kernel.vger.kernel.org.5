Return-Path: <linux-kernel+bounces-55320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D91A84BAFC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 17:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2AA28937E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63AD15A7;
	Tue,  6 Feb 2024 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BPfO+0m4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7160F6FD9;
	Tue,  6 Feb 2024 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237187; cv=none; b=iCgs9u+VUpdpdKQihNY7O9uhrkrUa5t04xB22Zf1GnxsShiIRak+tVScL6TLRlq43DkekH32bNo3+fYA9FVTKR4ESznPM0Uu3N+CDZIJyJyds4XjFyfIAfHg51zW983hMO2QBxeT6qb1xTLABmFkCGc8sK36PMIZ/3Y6t4Rd51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237187; c=relaxed/simple;
	bh=GSuiWPKyc+YVVjRbfb/kMab24liziVoCM3MPWEYyLNg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=soKsNPT1pq+PK43nLvXKgR5layEw2C6j0p+Tjs0eiAtHd5IhZkzycr7CwmmOzyKxsfAtHmETL1k6e7BNCBo1bDeUdhxloYhi6m3EidhnpO8YSH4y+Ay9gPSfTI1+iHI5yyTUwayU9DJcc21RxqLY0d1XKlHgBDT7ZN1ZuWLEeY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BPfO+0m4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707237186; x=1738773186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GSuiWPKyc+YVVjRbfb/kMab24liziVoCM3MPWEYyLNg=;
  b=BPfO+0m4oYvwTnUZ8RET7DOs0SYhFYxbeeRz+aDrAKvAj0Hc3AblrRVe
   i9/A7bcvmvCGUUp8iTy+ZGmA9M4taI5YGwzJjYXZQD7Nw3GkUV4Wf4nLj
   gAPGMCPTTWcbuQkeRqXv3vLYU8Hne6iT+EsRq7/dn2Js7o1Qk8jpPHjrs
   JAoRaQWlA4qr8lz4mLU6eI4GRHotTA2s17l80efhsoz+TRcRsYKVNZ9rA
   GTlRLVC47qUw1Z068MZWMR1nblibp5sXp1WPcmkze/9H8EKpWt8NxIN2s
   Xiu8zDR+N1JnWjVV4mHVZDokobRN64dfNr5+v89QoySNoVi4x+Ib7QjD1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="696612"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="696612"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:33:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="909687822"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909687822"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:33:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXONW-00000002O8X-2XGc;
	Tue, 06 Feb 2024 18:32:58 +0200
Date: Tue, 6 Feb 2024 18:32:58 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Liam Beguin <liambeguin@gmail.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mark Brown <broonie@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Okan Sahin <okan.sahin@analog.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: ti-ads1298: Add driver
Message-ID: <ZcJfOgDMmLBpEho2@smile.fi.intel.com>
References: <20240206065818.2016910-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.fd628a1a-a926-426e-a239-bfd8c9858b94@emailsignatures365.codetwo.com>
 <20240206065818.2016910-2-mike.looijmans@topic.nl>
 <ZcIsuiuisQjTIxJv@smile.fi.intel.com>
 <4c6654f5-2d9e-4c1b-a5de-7bdeacf5e99f@topic.nl>
 <ZcI5PoWojKRrdpVl@smile.fi.intel.com>
 <67387cf4-1065-4313-b4c6-054128ba8f3a@topic.nl>
 <40a3a47b-1388-4ed0-a24b-2c0bcef3be3d@topic.nl>
 <ZcJLnOiFoaABami1@smile.fi.intel.com>
 <e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e04ca010-289c-4216-95ea-2f2418613378@topic.nl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 04:44:03PM +0100, Mike Looijmans wrote:
> On 06-02-2024 16:09, Andy Shevchenko wrote:
> > On Tue, Feb 06, 2024 at 03:47:45PM +0100, Mike Looijmans wrote:

..

> > But it's up to you what to do with that.
> > Maybe Jonathan can advice something different.
> > 
> The spinlock also protects the call to spi_async().

I don't get this. Locks usually protect the data and not the code.
Can you elaborate?

-- 
With Best Regards,
Andy Shevchenko



