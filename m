Return-Path: <linux-kernel+bounces-91146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FD3870A14
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 20:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B0521F24045
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C534478B72;
	Mon,  4 Mar 2024 19:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gx+rcACV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724DF6216C;
	Mon,  4 Mar 2024 19:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709579238; cv=none; b=ikefvIUlTNYBVWal0HZ1SUdOjxepBeCfadE+AcBVSM9vkSqKgwFuPsaTqerolybzwmV6JdeD/jzadiZDclBDDLRAYkAvxzWfBJr0zFK1OngdCIH2DUmIkJtQ95p5Pqwgj+tUJ5HsKfsq4yKUAm4NVHkrMLxzF42NBQLnqDuEm74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709579238; c=relaxed/simple;
	bh=mVZkpIDYKuvFmvLbrVSnVhIgcusPY/WYVe9DsXaOYqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjAkKic/FEKujT/Y19w/9+HFC73RcPLBhUxOgk0rWVo/8AMh0Ju/1rsIrJ3PCk5w1RzX0pesgGV9rcub9j9127lYYijFhQ6WfsF+RnR1MueyBA+4zl5tjt9kgBA6uo+1TFfGGEv4j/1pd61nvz7n8/QMetvxEFtNEkpynXFIVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gx+rcACV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709579237; x=1741115237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mVZkpIDYKuvFmvLbrVSnVhIgcusPY/WYVe9DsXaOYqY=;
  b=gx+rcACVjbdZSpTXhc7nGyl1FM2rhuULy6YQnm4/6ZtCKhSwsIAFx3wY
   /wsBA0Yy0KPOTTobGFJVdiw6B69rYmkXRkEXI/3uMEzOF/0NJBPk6wuFI
   2xN378kOMIntla8muwKV8E6Wpr/yTBptFHIr8jkhN3vPp/f3kQkF95+vx
   ncJWfq3it2XhtaWDcObNXWh+TNc6IpAK4rvSttX6i7rwU7vVoON5b9mlc
   tqcvX1vcZ+V+JJ9qu330SIZoaoKkgMrnsVJINevMDsori6k4udec26Q9e
   hiX6tZJwl47vsPDSNhubZ402SkZIH8I7dvdcUcwHA2H1G7PYsXY1F1BOb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="15497810"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="15497810"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:07:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="914113233"
X-IronPort-AV: E=Sophos;i="6.06,204,1705392000"; 
   d="scan'208";a="914113233"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2024 11:07:12 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rhDeX-00000009nPN-3idO;
	Mon, 04 Mar 2024 21:07:09 +0200
Date: Mon, 4 Mar 2024 21:07:09 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: pressure: Add timestamp and scan_masks for
 BMP280 driver
Message-ID: <ZeYb3S1VNoziKHbb@smile.fi.intel.com>
References: <20240303165300.468011-1-vassilisamir@gmail.com>
 <20240303165300.468011-4-vassilisamir@gmail.com>
 <ZeW048EyOAze7oZR@smile.fi.intel.com>
 <20240304185017.GA3955@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240304185017.GA3955@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 04, 2024 at 07:50:17PM +0100, Vasileios Amoiridis wrote:
> On Mon, Mar 04, 2024 at 01:47:47PM +0200, Andy Shevchenko wrote:
> > On Sun, Mar 03, 2024 at 05:52:59PM +0100, Vasileios Amoiridis wrote:

..

> > > +enum bmp280_scan {
> > > +	BMP280_TEMP,
> > > +	BMP280_PRESS,
> > > +	BME280_HUMID,
> > > +};
> > 
> > Hmm... Why do we need to actually copy the IIO ones? Can't we use IIO ones
> > directly (or in some way)?
> 
> What do you mean exactly by copying the IIO ones? These values are used as
> indexes to enable channels in the avail_scan_masks below.

Yeah, I have now an answer to my question. The IIO drivers provide these lists
as mapping between available channels (as starting from 0) and real channels
as per IIO specifications (which can be anything, although limited currently
by 40 or so).

-- 
With Best Regards,
Andy Shevchenko



