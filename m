Return-Path: <linux-kernel+bounces-48072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 288828456E1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC6BE1F27744
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC1163AAA;
	Thu,  1 Feb 2024 12:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TdEl2bus"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09338163AAB;
	Thu,  1 Feb 2024 12:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789040; cv=none; b=GtsGIh/sVtNYU/FdPjGsHXqPayHw2tpzEf+dXJR6tsmk43LxnpWq8lfYkZHsMT8GwU/wd5S+ue2WhJymuOUFx6HkUjFF2AEGcDAo9okHntGyJy5PCDZPiwFAD93LIzAvmFux9/tOdK8q3SrTS0TPFMUsnBscdHRPbTL8u0CknBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789040; c=relaxed/simple;
	bh=cMkEfo42ar08rIRgf549MDh3sGVcDxZ39tgkRF74Xzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e659jcu5GSIrKX4gEL47FsxdqBRj3L1/2jRbZNpL2hPkaySjFX03Z8Eg/w0y/v3QbMyNwoC6TcwgNNOK2wVGFMc8rgr5K8HUMcHkRQ6iPRH5TC3ezKhSXdUahCiC8x8kMWMIPqTxNz+0Zfwr9qT8MEX1dK1CIiTl0k4BE2yc8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TdEl2bus; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706789039; x=1738325039;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMkEfo42ar08rIRgf549MDh3sGVcDxZ39tgkRF74Xzc=;
  b=TdEl2busVR6dyxzEFg2Ew15YKLvh9RpaHVuQ+p/jZA1Snk34EEsP7Lc6
   ma0ibEpZFbjfXLPLazD363DJJZOl8cyBAu/svHO0w5BERLA7m/JcMtbwi
   fWQcz2SiaWnl/juzYzfD38E247mn++tp8/s1ZUw/3rT9Uoqyb6jhgA8k7
   EH/4IeUsocZIBXzAyTn2vYD8yH7yDG9odByk4+6nzp4PreYrvoNhSwFC4
   fdNhYak4aOMbrwR+bkeU/kwMz34/iYuHTrNnCdNcvu5J8LP4tito2npgy
   ry75sP4K84jfY/6+FXVrDRrPrHmmXb2GNmqkKBDZKwNyEfS+j7KVUqTui
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11255990"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="11255990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="822905406"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="822905406"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 04:03:55 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rVVB1-00000000oik-1Ux1;
	Thu, 01 Feb 2024 13:24:15 +0200
Date: Thu, 1 Feb 2024 13:24:15 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pwm: dwc: simplify error handling
Message-ID: <Zbt_XxqYc3qKA6tr@smile.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-3-raag.jadav@intel.com>
 <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
 <ZbizxhQ5cxcDk2eK@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbizxhQ5cxcDk2eK@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Jan 30, 2024 at 10:31:02AM +0200, Raag Jadav wrote:
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
> > 
> > The pcim_iomap_table() fails IFF pcim_iomap_regions() fails.
> > You have checked the latter already.
> 
> I'm no expert on devres but I found a few NULL returns in alloc_dr()
> call path. In the interest of learning more about iomap, wouldn't we
> need to handle them (just in some odd case)?

It has nothing to do with devres. The logic is implemented in PCI core.

-- 
With Best Regards,
Andy Shevchenko



