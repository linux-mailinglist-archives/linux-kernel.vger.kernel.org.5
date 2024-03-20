Return-Path: <linux-kernel+bounces-109434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA79D881906
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:26:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5ABE1B22AAA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36628595F;
	Wed, 20 Mar 2024 21:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QWoiFCHY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD5A1DFC6;
	Wed, 20 Mar 2024 21:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710969955; cv=none; b=IhCcfsBhz2SUflpUiMchVS4jZXT8LLWTof9pOMneF1iw2PHXNLSLOAUecfZ5qQRTxyb4xlhDITRjYKHa7cjAzqWDqvlEjPZ1PaCte09q5j2S2gctQ01M02/n29PhnKQvzn/0ZfqW3MKtfuE5v4wp05fWpfN0lF/mBOUV7sdMdIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710969955; c=relaxed/simple;
	bh=e/nDT9NnHBdr5T4GvpQRoq6C1PbdgRzno2+D3yXYPNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3Q6pfoKWVHDZbhBUIxDWIokYQ4RBP2zkBxOlXG6rJU7jxw1Pn/tscz6cz1cz9wFucdJTMWFHwOkBSXMpO8nqGkkdar2bmJqkgoETWe29xCc6p45kfPSjaB3x5IMuDccHKz93UAFquDRV/600FTEj8E1JHRnLkQZOEBWLvWYeF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QWoiFCHY; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710969954; x=1742505954;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=e/nDT9NnHBdr5T4GvpQRoq6C1PbdgRzno2+D3yXYPNo=;
  b=QWoiFCHY/osw8En516tO5xxR1MHrD+mXNI2b30XjDNAqLv2bt/E1jEzT
   Drc5IlKLqdO02oOPUJDFE9J5Za0tNfwwPxgQU38QtFXs3a+pvw4fcVrsI
   8HdRn79aAr/pEwypm67Ep8Nw7cslFRMJQjLLsCVXq2zj3vbWhYqlWM2m+
   BvwN+/Ufa1dZ+78QpfPq+pDoL1wMJaIi3s5q0auwf2BemTlJCl7iNtPSM
   8lva7VsKRm2IaVIL5EPe/HOHP2MNTK7idMEqsbcauzjk/7Tfywm669kaj
   BwB1OFLPooL4XcqTU3E2OWnhHi3u2ABDhs4trAniNvAy4MLgi5TtwjSKC
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="6106093"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="6106093"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:25:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914679509"
X-IronPort-AV: E=Sophos;i="6.07,141,1708416000"; 
   d="scan'208";a="914679509"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 14:25:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rn3RS-0000000Eh68-3cjG;
	Wed, 20 Mar 2024 23:25:46 +0200
Date: Wed, 20 Mar 2024 23:25:46 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, ang.iglesiasg@gmail.com,
	mazziesaccount@gmail.com, ak@it-klinger.de,
	petre.rodan@subdimension.ro, phil@raspberrypi.com, 579lpy@gmail.com,
	linus.walleij@linaro.org, semen.protsenko@linaro.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/6] iio: pressure: Add triggered buffer support for
 BMP280 driver
Message-ID: <ZftUWg31QvA99syr@smile.fi.intel.com>
References: <20240319002925.2121016-1-vassilisamir@gmail.com>
 <20240319002925.2121016-7-vassilisamir@gmail.com>
 <ZfrFc9GF0_Jix5YT@smile.fi.intel.com>
 <20240320174602.GA36450@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240320174602.GA36450@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Mar 20, 2024 at 06:46:02PM +0100, Vasileios Amoiridis wrote:
> On Wed, Mar 20, 2024 at 01:16:03PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 19, 2024 at 01:29:25AM +0100, Vasileios Amoiridis wrote:

..

> > >  	/*
> > > -	 * Maximum number of consecutive bytes read for a temperature or
> > > -	 * pressure measurement is 3.
> > > +	 * Maximum number of a burst read for temperature, pressure, humidity
> > > +	 * is 8 bytes.
> > >  	 */
> > > -	if (val_size > 3)
> > > +	if (val_size > 8)
> > 
> > sizeof() / new definition for the buf[] size?
> 
> In a previous commit that I was fixing this SPI driver, Jonathan had mentioned
> that there is no need for a specific definition since it will only be used
> here so that's why I kept it as is.

It seems not only here, but also in the buf[] definition in the struct.

-- 
With Best Regards,
Andy Shevchenko



