Return-Path: <linux-kernel+bounces-59562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E4F84F8F3
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 16:54:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5D61F28C7F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 15:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F03D674E3B;
	Fri,  9 Feb 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VqbIldAv"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACDC57317B;
	Fri,  9 Feb 2024 15:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707494079; cv=none; b=M/pz3zkyglm9fktbhewNk9fb9i4IdcfeAowl1VeFKtKs1/3DywhZuwB3yT0wFVB5t4admw+nJS0pXHxj9aGLiSHOeZZ8PAmF8VEXK/PtWm+xI0TvEfiDNCjQpcGaj9ftDqsoKIfeFPwUAtT4gfA0w87fAZiJNyqMY+BAlz5nXJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707494079; c=relaxed/simple;
	bh=vU1JSrnglQJnuwXvcmwhcwFtTzyO1e7jQYcIH+DS4qo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b3HP96G8TW59VK40/56+r6za9+0Snf2GVqJRL+AGL/o8We7eQmyUytGpsiXzoeFM9qPyQ3k21gjdTD4EFHbzAKGyUSRsIwvNRTw3W+AtvJeMamMwe0i6GGFzo0rxOpnrKupDnSFA/8u6dQixi/0t2pMitrnwbJh1N7iLm01rbk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VqbIldAv; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707494078; x=1739030078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vU1JSrnglQJnuwXvcmwhcwFtTzyO1e7jQYcIH+DS4qo=;
  b=VqbIldAvkk43Lmgt0od0jVmw9A68IYZs8/3xV+VWSzPlBAvInxT3mBvM
   T5kaHuVoLp+IHhuh0xMyHvYYCg0pJiaa1xzhtkvvUKSRNECc6kkqFzLFh
   iQ7uA+kLKxKGTTxyn5BHIXE1WBm8Fe6uO88IMNmXClMcAYbbmcCjWOuaX
   JDAEERAJtb3q+HyW9HVuVfDJliHSyBFwuKzk9DRhwTJAwR33Sr8a/FUhG
   orbVPrSl2FzOvXx+YzTQ8/AxX/a5fM/+og83+4AXETyEOgg3YObJFDlpG
   6HzrYIvcMbxOLqhDaRidt0Z7p6HcrWcgIirW90aGUruPkYMVHAcegzEMH
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="18864965"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="18864965"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:54:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="910746066"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910746066"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 07:54:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYTCw-00000003BoT-47LJ;
	Fri, 09 Feb 2024 17:54:30 +0200
Date: Fri, 9 Feb 2024 17:54:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Mark Brown <broonie@kernel.org>
Cc: Andy Shevchenko <andy@black.fi.intel.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	kernel@pengutronix.de, Jonathan Corbet <corbet@lwn.net>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	James Clark <james.clark@arm.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 31/32] spi: Drop compat layer from renaming "master"
 to "controller"
Message-ID: <ZcZKtnbb04IeYyc6@smile.fi.intel.com>
References: <cover.1707324793.git.u.kleine-koenig@pengutronix.de>
 <ad1d949325b61a4682e8d6ecf9d05da751e6a99f.1707324794.git.u.kleine-koenig@pengutronix.de>
 <ZcZDugcgkClwX7qp@black.fi.intel.com>
 <ZcZJQzpMlSiiKqU0@finisterre.sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcZJQzpMlSiiKqU0@finisterre.sirena.org.uk>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 03:48:19PM +0000, Mark Brown wrote:
> On Fri, Feb 09, 2024 at 05:24:42PM +0200, Andy Shevchenko wrote:
> 
> > Besides, we still have drivers that use master/slave terminology in
> > their (local) variables, functions and data type names.
> 
> There are also devices that have the terminology in their register maps
> which we can't really do anything about.  This series was just getting
> rid of this specific compat API, not solving every problem ever.

Don't take me wrong, I am not against this series, it's a very good job by Uwe
(I planned to do myself something similar, but as you know only had time for
 definitions)!

My comment is to point Uwe's attention to (still) missing parts (as per my
first paragraph).

-- 
With Best Regards,
Andy Shevchenko



