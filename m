Return-Path: <linux-kernel+bounces-117735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9CF88AEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7311FA708C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0A77172B;
	Mon, 25 Mar 2024 18:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhvVE48T"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9698470CA6
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711392118; cv=none; b=TS2SeUUgpK0iMF2AuvaTcEdaHmCDX8sAjR0IsqzUYP8voFYBqLlWsFK/g55anp98BPEfVhA71uTb0QYEQhHt8bhy91e4XQgckdMqr7XUz+4H+M0c6I7Inq+m5wpV4LRJRYsfm2EabH7aLjHy/OcV7qQz8rJ1pDzh9XV7GDlyeXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711392118; c=relaxed/simple;
	bh=DN6fY0CPCVtdDqMxIfm/YCxvO3elYB2ZwS4nFyQi4f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+vUY2g+UPL4hgkE3yD2Zg9uXuAP/USTeGmXHB5Kxu/WGmsFeme5nmjcI4OH+1VRbfeXX8OZc8iXCSlqYWy4VWyaKgE6xc0ivC9kir0P5n52PUv1k34P7neTWcdDrEroMHT59zWqJ/tOFGBrYHEwIxMkTKjLYxorL5GBtSqYb3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhvVE48T; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711392116; x=1742928116;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DN6fY0CPCVtdDqMxIfm/YCxvO3elYB2ZwS4nFyQi4f8=;
  b=NhvVE48TAQ44NNp2PqKf7Xk03RV7cB14ARqak4XnrxYk/UPOB9tVF5S7
   21fLUXNZgKVa88A9u9Vso6RghmYWYTUjE/RylYeiQwRxQ+k5IDZJMuPh+
   JvlOeZzdgGUihphAcDWYv1rmySvKId2JY1AYc8XzI8LBVVeTGDWZ/kQZl
   aOnE9+r5a7XeNnhB88QlYWc3CB+H2CvWyIsftHnskhRkeDn4WxMKxDDDm
   uVUhiVSFpO2IuSFWB8l7E7Qq5OvfsEFZw0Thx4SyQPyBv9/1ax8yE+zVI
   ss/4XTN6ylqmFQa0ZxUTRZbr8FJ8vk7hqfw4OUUkBA5mJFdnaweBFV9Gm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17046145"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="17046145"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:41:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914851669"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914851669"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 11:41:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ropGZ-0000000G5qQ-0GKC;
	Mon, 25 Mar 2024 20:41:51 +0200
Date: Mon, 25 Mar 2024 20:41:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Shahar Avidar <ikobh7@gmail.com>, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <ZgHFbosacLDyhgaY@smile.fi.intel.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
 <2024032520-implosion-living-d148@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032520-implosion-living-d148@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 07:05:46PM +0100, Greg KH wrote:
> On Mon, Mar 25, 2024 at 11:18:42AM +0200, Andy Shevchenko wrote:
> > On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> > > 1. Untangle include hierarchy. 
> > > 2. Update #minors the driver can accept.
> > > 3. Make use of general macro instead of magic number.
> > 
> > > Shahar Avidar (3):
> > >   staging: pi433: Use headers in appropriate files.
> > >   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
> > >   staging: pi433: Make use of spi mode macro instead of magic number.
> > 
> > For patches 1 and 3
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> That's impossible for b4 to parse, it would have applied this to all of
> the commits if I had taken them :(

You can apply only patches 1 and 3 as long as they are independent to patch 2.

	b4 am -st -P 1,3 ...

or we can wait for the author to react on the comments and issue a new version.

-- 
With Best Regards,
Andy Shevchenko



