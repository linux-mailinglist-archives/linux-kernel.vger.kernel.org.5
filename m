Return-Path: <linux-kernel+bounces-48242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B5D8458FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F65F28632A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6014C5B673;
	Thu,  1 Feb 2024 13:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FYhdbYvD"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AE86627;
	Thu,  1 Feb 2024 13:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794522; cv=none; b=RyWAaYkXcbCYjoPZseEtLcfsfyj+UNVeLokwEV8u+/JmRi1ngSY5v6vjlWOPZjuzPL5UPbFeXKsW2GtlfqZYA4rmbvvhUrXaqDxJOTMk0QOSY16FMSgVne++doA6VO+E9caj0YMnHXE4wUYXIguoFYBZLaomNJ7OjjKVug5d+Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794522; c=relaxed/simple;
	bh=8R003JGMGdcafl0yvgQeD16x26KoEPRNjns70fXm3Is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ehKs8j0Ylh1agjbvawak0yrXvaAeu76K2tLf/CVDFRIRfiLzRZWXifyE0ieM43SC5lhrVgGre3BHu/nf+Zvfc8EIrOzHV2YcOeEhQjENRlNknSsbgCTSGQZfSnbwfpBYqfZNAReFAYFPXtd/A9VgktE1VbYHsbmmfOqISa0JBrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FYhdbYvD; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706794520; x=1738330520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=8R003JGMGdcafl0yvgQeD16x26KoEPRNjns70fXm3Is=;
  b=FYhdbYvDx+GTRQaJjLrv1rWY+zfVWEQW1GH1wX2oUuonZoOECzBsSmmF
   BxiBTr7cpyY1DxC/+htJLZnhaZXQHj6WBHnqfgiEYSPh/c6NEcQWilUgV
   WzIyr6oa9u/EEDY9uMF10ypEwfeoOygkU6oHmHvZaGLecnTgoieb/vZpF
   iZUn8QOoVBVLCcYIX1iVSP2Q4YxdG+ipF94Fip2tKygyGaHEyYp80l3Al
   chhHQwldVH/9AX8Otzn1nDQ80Ar/7mXhR8JQsREBtqE90Ts6gteGBht3u
   64gb1vbkbx0j6HKP26lxV2EpWybI1BH+FcMwSIM3x4vQJBlba9qopWcx3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="2828438"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="2828438"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="879105718"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="879105718"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 05:35:18 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rVWxr-00000000qJ3-1xbs;
	Thu, 01 Feb 2024 15:18:47 +0200
Date: Thu, 1 Feb 2024 15:18:47 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arturas Moskvinas <arturas.moskvinas@gmail.com>
Cc: linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
	radim.pavlik@tbs-biometrics.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: mcp23s08: Check only GPIOs which have
 interrupts enabled
Message-ID: <ZbuaNwW1XwzaLB6X@smile.fi.intel.com>
References: <20240130073710.10110-1-arturas.moskvinas@gmail.com>
 <ZbuCP4rN_DEsH-Un@smile.fi.intel.com>
 <CAPo8RJaE-jAmbp8XTzS6cPceOpLiPcjVvWg28_3eoX62Z9Bc-A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPo8RJaE-jAmbp8XTzS6cPceOpLiPcjVvWg28_3eoX62Z9Bc-A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 01, 2024 at 02:19:38PM +0200, Arturas Moskvinas wrote:
> On Thu, Feb 1, 2024 at 2:03 PM Andy Shevchenko <andriy.shevchenko@intel.com>
> wrote:

..

> > > +             /* We must check all of the inputs with enabled interrupts
> > > +              * on the chip, otherwise we may not notice a change
> > > +              * on >=2 pins.
> >
> > Missing space after =. But better to spell in proper English, i.e.
> > "...great than or equal to 2 pins."
> >
> +               /*
> +                * We must check all of the inputs with enabled interrupts
> +                * on the chip, otherwise we may not notice a change
> +                * on more than one pin.
> 
> Does this sound better?

LGTM, thanks.

-- 
With Best Regards,
Andy Shevchenko



