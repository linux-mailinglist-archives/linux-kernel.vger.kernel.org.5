Return-Path: <linux-kernel+bounces-96984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B2F876416
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA3AC1C215C1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D4A957878;
	Fri,  8 Mar 2024 12:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JmMhgHWI"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291C45731C;
	Fri,  8 Mar 2024 12:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899908; cv=none; b=Mdt78vBw+W7yqHEPUIdspa6286wt0hdPwo9d/Gb5rcQt3nKYbhaxyqokl0lU8KPafSbRw4rTl6O+xc74r1wA8C9ea+ek1qodEObRVguPaiW5U0EarTxeDScqPr3sGC5kSwJThbPWVzFzNd1Nu2P13VTqleEgKnciHWJRVUB0RRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899908; c=relaxed/simple;
	bh=jYBhbPyZWHpimcyVfrOVHSZnH14S028uVYxrcmxAaVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LATVKQ6nH492lDxnlQiQiHDX01b1jxEVe1UxE3A1XFuMgGcDxxuWwJcmICoTH80HQv6rCgrakxEU0NruK43pFOTdhclpdAvnaK33X8ALDeqobDRrW+T3bTdQ9vd6TxMwhl9bRwMWCGS3uST76tXbPJCEnllLpuyvB/cjvib7R6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JmMhgHWI; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709899907; x=1741435907;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jYBhbPyZWHpimcyVfrOVHSZnH14S028uVYxrcmxAaVo=;
  b=JmMhgHWIXdxBXzJbzCANLgC0frqtDIPmU/o1IOeBKpmmRLoUmzEuZPk4
   F8IqOk/wJF543lajs7FCXXvBcmqFEkOJ0Eq7w9BxindzX8AMIo33eNPHs
   S4Eq2jkZv7o4KmeFNn37iEvyEQJ2d8JSGzUgdCCyKcep3Cx/4W7c7+V5X
   FT38nTzHbCg6H8NH0PtEdEeCVqzSqnO7arbKjTGPHTdjPKHvDNUnhtM0j
   dmUa+K/CQU7Ep0Tb1xYGFLg3zD/TNbhbmVlUetdBkfo6VAQqnsqO7hfr2
   jRyLNjMaOCoMXYVdvqwn4/6jikyY+5tczFGycmYy9sVZI9oBwjdg1hvSA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="30058268"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="30058268"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:11:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914244975"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914244975"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:11:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riZ4f-0000000AppX-1kjO;
	Fri, 08 Mar 2024 14:11:41 +0200
Date: Fri, 8 Mar 2024 14:11:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 3/3] spi: pxa2xx: Use proper SSP header in
 soc/pxa/ssp.c
Message-ID: <ZesAfXhFoFU08naT@smile.fi.intel.com>
References: <20240307170441.3884452-1-andriy.shevchenko@linux.intel.com>
 <20240307170441.3884452-4-andriy.shevchenko@linux.intel.com>
 <3cb1ae25-c660-4182-afe6-ded010fd4129@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cb1ae25-c660-4182-afe6-ded010fd4129@app.fastmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 11:06:00PM +0100, Arnd Bergmann wrote:
> On Thu, Mar 7, 2024, at 18:03, Andy Shevchenko wrote:
> > There is nothing from pxa2xx_spi.h used by soc/pxa/ssp.c.
> > Replace it with pxa2xx_ssp.h.
> >
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks. There is a v3.

-- 
With Best Regards,
Andy Shevchenko



