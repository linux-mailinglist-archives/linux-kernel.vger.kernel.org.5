Return-Path: <linux-kernel+bounces-76609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1C985F9F6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E25881C24E84
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 13:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99864134721;
	Thu, 22 Feb 2024 13:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IihEN++O"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E012FF73;
	Thu, 22 Feb 2024 13:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609072; cv=none; b=MTY3rQ0Nxmli3HSvcLydDO+YhoQiySw96eBVcRC9q8cgfeUirhQagTGOhZOnjtt74fikGPtIdpZHm2mvEwx1vb1GHQ5Xa/YomKJFMHSyP784uYHFyYz8hC/oOQ2dmvfJXIJe7DNh7xQ6ZnFn7+nXEIngURA5wP5hmqDV+MKNpcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609072; c=relaxed/simple;
	bh=MwxV11beFPWKUQr1OLOaWNjxLg2SPPTjqifSYXHht8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tGGZoMKRBvfoOg0dhHTxyO4r5vmYIGJj93Q0bPfdVotQt1DGwdX8m0Ep0C2csNl/UymzavZcrpnc/KWIWlHyYO7UBeuRzpchv1YGlLhehOwC4Zq++saKSKM5VRplffFQcACKAGBV04gkkfrHD6HnrfUpILikfeJD12AOtsmQ2p8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IihEN++O; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609070; x=1740145070;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=MwxV11beFPWKUQr1OLOaWNjxLg2SPPTjqifSYXHht8s=;
  b=IihEN++Og91pe8MVnK0lPunwM0qiAsgp6+2wJ+pM5yaXfYbuooNjgnPO
   h/GuPGMQ8wlPq+R7tbySAtpkkwcHFBIkko691aWk7W97wn/NN50CtN6Oe
   5amFJSuXRPYZyTGA5QMdsfXvCKRz4W9tjilpJffIKqbh5BXJcode7dxlg
   YWy0vnCVQ6/IvBIsHLIkCSuF5DLRY2IjIk8gLOZvFfAMETddeegw0MOGH
   L2rg3m2WAzUKsNr/k8KcyhRgWCIjnqS8lsQ9GCCKhWR93tMbPdTSGI/0C
   MFkBPlUMVVBO2+Jvezw5nMXbLrOmV2k+EWs6aV/Gf6fRpl6dovt1Aakeb
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="25294482"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="25294482"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:37:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="913527279"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="913527279"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:37:48 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rd9Gj-00000006diA-1pl1;
	Thu, 22 Feb 2024 15:37:45 +0200
Date: Thu, 22 Feb 2024 15:37:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in
 gpiochip_add_data_with_key()
Message-ID: <ZddOKTP73ja6ejTc@smile.fi.intel.com>
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com>
 <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 05:33:59AM -0800, Bartosz Golaszewski wrote:
> On Thu, 22 Feb 2024 14:25:24 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Thu, Feb 22, 2024 at 10:37:06AM +0100, Bartosz Golaszewski wrote:
> >> On Wed, Feb 21, 2024 at 8:28 PM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >> >
> >> > After shuffling the code, error path wasn't updated correctly.
> >> > Fix it here.
> >> >         gpiochip_irqchip_free_valid_mask(gc);
> >> >  err_remove_acpi_chip:
> >> >         acpi_gpiochip_remove(gc);
> >> > +       gpiochip_remove_pin_ranges(gc);
> >> >  err_remove_of_chip:
> >> >         gpiochip_free_hogs(gc);
> >> >         of_gpiochip_remove(gc);
> >>
> >> This undoes machine_gpiochip_add() and I think it also needs to be
> >> moved before acpi_gpiochip_remove().
> >
> > You mean it should be like
> >
> >        gpiochip_irqchip_free_valid_mask(gc);

> >        gpiochip_free_hogs(gc);

But should it be here...

> > err_remove_acpi_chip:

..or here?

I'm sorry I really need more (morning) coffee, maybe you can simply update
yourself or submit a correct fix?

> >        acpi_gpiochip_remove(gc);
> >        gpiochip_remove_pin_ranges(gc);
> > err_remove_of_chip:
> >        of_gpiochip_remove(gc);
> >
> > ?
> 
> Yes, because the sequence is:
> 
> 	ret = of_gpiochip_add(gc);
> 	if (ret)
> 		goto err_cleanup_desc_srcu;
> 
> 	ret = gpiochip_add_pin_ranges(gc);
> 	if (ret)
> 		goto err_remove_of_chip;
> 
> 	acpi_gpiochip_add(gc);
> 
> 	machine_gpiochip_add(gc);
> 
> 	ret = gpiochip_irqchip_init_valid_mask(gc);
> 	if (ret)
> 		goto err_remove_acpi_chip;

-- 
With Best Regards,
Andy Shevchenko



