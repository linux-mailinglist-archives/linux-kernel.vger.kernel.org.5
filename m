Return-Path: <linux-kernel+bounces-48018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11CD684564B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 450951C23ACE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCFE15D5A3;
	Thu,  1 Feb 2024 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJyJ3vcY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F18215CD52;
	Thu,  1 Feb 2024 11:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706787194; cv=none; b=ZG93B9mCtfQORip3rgirM41Rs/bGiN7dgKops5hZnmSocrNOwA/tO9Ii7BrBohkB+1y0qx3ErSFB3xwWl21GlegMgsG2pdu10a5tQ8eoor4gdyZ8RdjzjAo40jE/U+/j3Fr7ombK6IzSGYDT1jMYi1IR5Sa0nM54e3zdPvWGxqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706787194; c=relaxed/simple;
	bh=SpA5zVrSl+lHbVMJomAs4rJfHde7ZHv1wIAINFvCdgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=beFKM2ZVf1nOMfxmwRH9o5q1BL1Czi2wMollj57ijNdpziV2/WNwNQGRLerrbnQ+pOiWU4MC9pXdsqDajZxm/pQwX9m1C0hGHofR89cRzVauzxPZIVvZxy7QnCkM0gvxE0PPv1FL1gMTPmWZTsToKki6rLoiOzmGNInT6aLJOWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mJyJ3vcY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706787194; x=1738323194;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=SpA5zVrSl+lHbVMJomAs4rJfHde7ZHv1wIAINFvCdgs=;
  b=mJyJ3vcYLT5F0TdzGgkcQLr+kNf3vg5WHuPm7Ft8oK661VxpqqsCy5NW
   vWHUBZ6923ufKd77I8wELq4fx4hKaoTsqC/unXf5iz2jDfGtBVEQfjOXH
   DSqsSR/bJjCyrlVv/NqLJ1Gow6Nl4Y/CEVbtofHQT22psxNbGASq6cYYR
   xQmnOHEwoshTEMno9yS/gD2sBe9UrsZxSEF6hxOUyuqI0X8spAlxyFUfu
   ilGa2eWfTMKj9Gdru9oMZs32MLxefFjL6VrnG44Io5sYq0PJYW5vmQF8x
   mVD3FrOHmyQFjfJ5YwadX/9jbIsKB2eODR1jOw2b++fGK/0RsicAMZxTU
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="56174"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="56174"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:33:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="1119919385"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="1119919385"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 03:33:00 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVV99-00000000ogy-0PC7;
	Thu, 01 Feb 2024 13:22:19 +0200
Date: Thu, 1 Feb 2024 13:22:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Raag Jadav <raag.jadav@intel.com>, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pwm: dwc: simplify error handling
Message-ID: <Zbt-6vpx1LnFBCIL@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-3-raag.jadav@intel.com>
 <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
 <r6vulwv76x7ydkmszlwlswjve7y2pmasz77wkqub73qopd5src@y3ta72owtw5b>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <r6vulwv76x7ydkmszlwlswjve7y2pmasz77wkqub73qopd5src@y3ta72owtw5b>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Jan 28, 2024 at 05:58:38PM +0100, Uwe Kleine-König wrote:
> On Sun, Jan 28, 2024 at 04:48:16PM +0200, Andy Shevchenko wrote:
> > On Mon, Jan 22, 2024 at 08:32:37AM +0530, Raag Jadav wrote:
> > > Simplify error handling in ->probe() function using dev_err_probe() helper.

..

> > >  	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > > -	if (ret) {
> > > -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > > -		return ret;
> > > -	}
> > > +	if (ret)
> > > +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > >  
> > >  	base = pcim_iomap_table(pci)[0];
> > 
> > > -	if (!base) {
> > > -		dev_err(dev, "Base address missing\n");
> > > -		return -ENOMEM;
> > > -	}
> > > +	if (!base)
> > > +		return dev_err_probe(dev, -ENOMEM, "Base address missing\n");
> > 
> > This check is bogus. Just remove it completely.
> 
> This would be a separate patch though. IMHO mechanically converting to
> dev_err_probe() is fine.

Sure, that's what I meant. First patch to remove, followed by dev_err_probe()
conversion.

-- 
With Best Regards,
Andy Shevchenko



