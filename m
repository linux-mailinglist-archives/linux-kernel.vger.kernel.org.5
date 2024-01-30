Return-Path: <linux-kernel+bounces-44138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FB841DCA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CDEC28AED6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1246F5821B;
	Tue, 30 Jan 2024 08:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RirXi2tD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D652F58208;
	Tue, 30 Jan 2024 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706603470; cv=none; b=FKHRBCyx1zMxszEOdwTrNQFhqdLCXMpsjt5Gi+p1DWf4K7GT8cAGhJtdjvAE1V2/g4XuAATEqP+XfxKfdu7jMjKpCiCHNN8PuJ+9l0D7ELRiouf/efR6xrYEXzF7npfi+3YN4Ka8xu4idlvxBuz4K9qe69cvSW3LylyrkZDbfPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706603470; c=relaxed/simple;
	bh=eDILxyTaa4HC4XR5/xnYTNtOe1gaCpqv7fIDLS+DWwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AWde2R0aXcUBbEN63ggkeTL3oJ5w6AmmnvSIa6IZVIPUVVG3c1Fe0SbYKrwC1yzbVlAUs/cSCk4qkaMSj5RlEWP7ZA/+AHR0CyGcnKS2dVqZl/zRx35NA7JVQ7/rquib9vK7vGxr5hugdhLF9+NeLdWTH2WsOKSNgqF/utujJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RirXi2tD; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706603468; x=1738139468;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=eDILxyTaa4HC4XR5/xnYTNtOe1gaCpqv7fIDLS+DWwA=;
  b=RirXi2tDno8PxMbu8J4rVBcZOMtpKlD9NTvk6Li/ik9WX/1jLhPR6t/Q
   nmCZ8mL9+KuXX1WnIvHLbrrze0+0ZH3DByDW78TT+rgr6+OJt6qMj5DAL
   cnlocRLcteYurHZrjwk9i1tBUJoG6GNoEBiHxLawIqkSKdP3cbcBVahZC
   LsS1riqognM5ormI9a4dG/rcLPo1g8SmoEAd6SyUlOM0yhEeVeIcVADgM
   W+hL+miPH1PLLPnAh+haIzfX6/A2oyfctkMp84mczOaIBIJ7DgUBozeYK
   gLubwAeuEQUY9uZbZyg/YLWxfE1ZYpaSfd5BOSNSuQNznZWoJkC+FcLnF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="24686973"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="24686973"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="737696481"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="737696481"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 00:31:05 -0800
Date: Tue, 30 Jan 2024 10:31:02 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: u.kleine-koenig@pengutronix.de, jarkko.nikula@linux.intel.com,
	mika.westerberg@linux.intel.com, lakshmi.sowjanya.d@intel.com,
	linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] pwm: dwc: simplify error handling
Message-ID: <ZbizxhQ5cxcDk2eK@black.fi.intel.com>
References: <20240122030238.29437-1-raag.jadav@intel.com>
 <20240122030238.29437-3-raag.jadav@intel.com>
 <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbZpMO9b7L-DNIcb@smile.fi.intel.com>

On Sun, Jan 28, 2024 at 04:48:16PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 22, 2024 at 08:32:37AM +0530, Raag Jadav wrote:
> > Simplify error handling in ->probe() function using dev_err_probe() helper.
> 
> ...
> 
> >  	ret = pcim_iomap_regions(pci, BIT(0), pci_name(pci));
> > -	if (ret) {
> > -		dev_err(dev, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> > -		return ret;
> > -	}
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to iomap PCI BAR (%pe)\n", ERR_PTR(ret));
> >  
> >  	base = pcim_iomap_table(pci)[0];
> 
> > -	if (!base) {
> > -		dev_err(dev, "Base address missing\n");
> > -		return -ENOMEM;
> > -	}
> > +	if (!base)
> > +		return dev_err_probe(dev, -ENOMEM, "Base address missing\n");
> 
> This check is bogus. Just remove it completely.
> 
> The pcim_iomap_table() fails IFF pcim_iomap_regions() fails.
> You have checked the latter already.

I'm no expert on devres but I found a few NULL returns in alloc_dr()
call path. In the interest of learning more about iomap, wouldn't we
need to handle them (just in some odd case)?

Raag

