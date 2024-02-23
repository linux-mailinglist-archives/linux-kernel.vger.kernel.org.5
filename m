Return-Path: <linux-kernel+bounces-78915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE425861A98
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7402831B3
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB77B143C76;
	Fri, 23 Feb 2024 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BB2z76Of"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB5F12DD86;
	Fri, 23 Feb 2024 17:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710561; cv=none; b=qw01NNbl4/DhM/76gyFkuYXTYnrOwFnrjZDQsIUVlHvo6InffC865uHwvrS60d2wGDYrqBIu8BNrS2lziGgTr1u5fC1po3AEgX7Y+ZmcfE5r+4GWuH2fJaPYy7MkLHKNvOeb6Ll0+0vuIYcwlC8shDD3Z2rvbmesVlawSAQDFHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710561; c=relaxed/simple;
	bh=VvNeYnAwtvXOKfFrax2KDN3vOg/BZkU++ZaxRRjRLKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=skiTiUtNWkIIzGaJulU7W5zPhGFRV3SJxFG8iyv0RX24yGxpRKCclCDqIdJ9Y7Di82E+YZmyBxzILbUeoKZC+4G/S01Xy6LWSUvqoeJqnqHqNpO53c/gPuJx2vxTCvqLkBZgxVjr8MOvtNNQIYXZbNY7Vs68JppBwy2DwkcmSjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BB2z76Of; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708710559; x=1740246559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VvNeYnAwtvXOKfFrax2KDN3vOg/BZkU++ZaxRRjRLKc=;
  b=BB2z76OfHIiQ/FdCEW5ciS8E8TJF+9/K57UcQduhBiJwvsREMOpEh7d0
   PePo/xSAGDTzoIQ1j0wYz4COOLMKVQbswjCXyiESxBmGv2Gc79DUzN5wd
   k9+Io0HbMw2EjLdW80IgWFWQ/NGo/fbqnZ6LH5NnO3iK+1kyzR5ZDm7QM
   MnpwvhHBMGj3vf4bgzs+p/CmlMQhezvXTeoxK9kS4xXfGGNBGAvi4G3vW
   m/W99fCQ3tzU5BvEh5LYnU1pruTFVj2WkpG8Ea3LV8Q2OPClnV+exV+tx
   /e883cckTcaZrwHW/oCZ/qgYmaCjcEiIQ+kJtw0F+gMxSAoOn4UHeWmL7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="6854525"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="6854525"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:49:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="913752364"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="913752364"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 09:49:14 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rdZfb-00000006xlV-0qQz;
	Fri, 23 Feb 2024 19:49:11 +0200
Date: Fri, 23 Feb 2024 19:49:10 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	linux-iio@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, llvm@lists.linux.dev,
	Tomislav Denis <tomislav.denis@avl.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] iio: pressure: dlhl60d: Initialize empty DLH bytes
Message-ID: <ZdjallR88R5KkATw@smile.fi.intel.com>
References: <20240223172936.it.875-kees@kernel.org>
 <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdjaOLVd1yxNXhsp@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 23, 2024 at 07:47:36PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 23, 2024 at 09:29:39AM -0800, Kees Cook wrote:
> > 3 bytes were being read but 4 were being written. Explicitly initialize
> > the unused bytes to 0 and refactor the loop to use direct array
> > indexing, which appears to silence a Clang false positive warning[1].

..

> >  	for_each_set_bit(chn, indio_dev->active_scan_mask,
> > -		indio_dev->masklength) {
> > -		memcpy(tmp_buf + i,
> > +			 indio_dev->masklength) {
> > +		memcpy(&tmp_buf[i++],
> >  			&st->rx_buf[1] + chn * DLH_NUM_DATA_BYTES,
> >  			DLH_NUM_DATA_BYTES);
> > -		i++;
> >  	}
> 
> Not that I'm against the changes, but they (in accordance with the commit
> message) are irrelevant to this fix. I prefer fixes to be more focused on
> the real issues.

Ah, sorry, there are two changes here:
- indentation (which is indeed irrelevant)
- and indexing, which seems the needed one.

Whatever,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



