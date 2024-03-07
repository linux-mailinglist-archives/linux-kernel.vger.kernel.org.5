Return-Path: <linux-kernel+bounces-95896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891398754AF
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4277F2829DB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF8A12FF80;
	Thu,  7 Mar 2024 16:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W+GGObi6"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2CF1DA37;
	Thu,  7 Mar 2024 16:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709830521; cv=none; b=SN/R6XQ4rkSx9i7FYPqH5drYLMmmsGZgYUbP/2wzjAxo3LQmZ4+HwPe00BFGL797fqWrLyXL4djzTUPZ1LU6TNRlV/GfHOg1D7EyvcBIBqkhzFoX8qhQYwqD3bNDlBlHWAP0Ct43VdeWb+utzXcegh0ixY39jeMMJNEDIMNGW50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709830521; c=relaxed/simple;
	bh=Ipk+TDrwrzyF7yUi8O5auCTNSAEiZjSmrvEdfyq9cck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o+LK4PgMt7qDtiTNaBxbt+PaVDUfa6r9JxcE3vad9YG/XwlhFtH5vgScZrtxr6gQ+VFpmZ9EZKG4kil32ulYOvTIMuB9XFRONtTpIbE9DR8H9tLE23qllEUopIFnC15iXFkQ+oJZuvB0WqAkRrndjlCid2uV/apN7H3Ilr+T1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W+GGObi6; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709830520; x=1741366520;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ipk+TDrwrzyF7yUi8O5auCTNSAEiZjSmrvEdfyq9cck=;
  b=W+GGObi6J0TUAtH1yvEMOTWjDbV4xPt48DMFhOZ32QnSfPTs29Bk2r+P
   4Zk2DYFtkwCj3954sQVc44N8kWYblmbX4DM7ePD5w/3O+vMlnt/L8Zmhj
   /K7CZJ+lqMGNMWyya2jhoCAPQWsgScSjCrQsnM9eOUiEJ5t21aTEgP/xS
   IdeNGqDdOUhRXd3Rd1gxeHrB3XBL1kuhz0HScfCot1kXs4SNyU7d67vzS
   llZzv4dvWtiPk5jQm3VEh3QrsPXJ3+2Lc+b92nwaQHtg1fQWjb8WR9wHf
   012EmG0Xf/CCZxiaQIjOG73HoYYbTKwvAE4WpCohCIYKOU1vtC0l5R/xG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="15234111"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="15234111"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:55:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914219447"
X-IronPort-AV: E=Sophos;i="6.07,212,1708416000"; 
   d="scan'208";a="914219447"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2024 08:55:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riH1W-0000000AcUp-0i6I;
	Thu, 07 Mar 2024 18:55:14 +0200
Date: Thu, 7 Mar 2024 18:55:13 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-spi@vger.kernel.org, Daniel Mack <daniel@zonque.org>,
	Haojian Zhuang <haojian.zhuang@gmail.com>,
	Robert Jarzmik <robert.jarzmik@free.fr>,
	Russell King <linux@armlinux.org.uk>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v1 2/2] spi: pxa2xx: Make num_chipselect 8-bit in the
 struct pxa2xx_spi_controller
Message-ID: <ZenxcRXjiyOpdxsQ@smile.fi.intel.com>
References: <20240307160823.3800932-1-andriy.shevchenko@linux.intel.com>
 <20240307160823.3800932-3-andriy.shevchenko@linux.intel.com>
 <64cde1d1-1d4f-484a-940f-536c1279287e@app.fastmail.com>
 <ZenxGMHYcCFlpUd4@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZenxGMHYcCFlpUd4@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 07, 2024 at 06:53:44PM +0200, Andy Shevchenko wrote:
> On Thu, Mar 07, 2024 at 05:37:17PM +0100, Arnd Bergmann wrote:
> > On Thu, Mar 7, 2024, at 17:07, Andy Shevchenko wrote:

..

> > I wonder if we could just move the entire header to drivers/spi/.
> > The spitz board only fills the num_chipselect field anyway,
> > and that could be derived from the GPIO lookups instead.
> 
> It seems to be used by drivers/soc/pxa/ssp.c.

At closer look it seems a leftover!

-- 
With Best Regards,
Andy Shevchenko



