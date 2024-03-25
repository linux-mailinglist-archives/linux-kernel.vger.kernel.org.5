Return-Path: <linux-kernel+bounces-117778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5688AF7F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCED1FA1164
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17D7125D5;
	Mon, 25 Mar 2024 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j0EudwUK"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7CB11198
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711393943; cv=none; b=tAa59OMp9FnkCHx41OTycYVSy/mCzSx1gOHgtq4cPQybHqhWnTuz4uThDMARtqcDX7bekFcsSI+YXWBKQC3Z1GavSrpqM5xOjfhSIZPG/nBaq+DtFUjmeyj3ERJi31TDrRi+DRx8NLG89aAcseyoOi+VZaHJVMAim78qLCTmk5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711393943; c=relaxed/simple;
	bh=ck2KXyWg6lNnOKmae4H2aoNDFjqiV++vBs4EhFGkZuA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Evv/O8dl4ILnexXXY8tEJwfkhFiFhnZXw1epPpAc05SO4aJOnnT4xCu6u6/1zzL4mN+Gt5LUDzlR0VX33fiF8bOy17gVvvuoxSBk9TwUSR40JnAxUQmI+DdhzVxFFHRjzdUb1oyZeQtsiav3lmhEQC81T5jUoEDezCFg5eISkVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j0EudwUK; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711393942; x=1742929942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ck2KXyWg6lNnOKmae4H2aoNDFjqiV++vBs4EhFGkZuA=;
  b=j0EudwUKWpQIKZRvwLk0q71gkA5qPJwEGpA6Fml7qcOISO6qbalYxy3E
   kEIzgTsugcRBP0MCmAnXOmludgJPf294OJARa8Sm4+bctXWER53u9NyYk
   TKwxOO1IphTTM9XiVEUVcvtXj0tRYx3iYxqyHuNYg9n9yUrNJg9Vri0Pp
   h5YZoHcRDV8lcxNy+vi6wvv9ipStmW6SBZADLp4guL6JWEzwFlWTMK2yU
   ojbyVArckN7YOyfAD9wunCTTy/93U1iFc36xDegBu0IyPV0O40aGM8yPL
   ajPfn3y6qAUZxLZXK4FerTWsqrWe9yRPzMTZk2ZpoPtEL5pVmtG1R2v2a
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="6310967"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="6310967"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:12:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="914852273"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="914852273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 12:12:19 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ropk0-0000000G6cs-41Jn;
	Mon, 25 Mar 2024 21:12:16 +0200
Date: Mon, 25 Mar 2024 21:12:16 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Shahar Avidar <ikobh7@gmail.com>, elder@linaro.org, robh@kernel.org,
	parthiban.veerasooran@microchip.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] staging: pi433: Fix includes & macros.
Message-ID: <ZgHMkIX6RvP5dqyp@smile.fi.intel.com>
References: <20240324093201.793485-1-ikobh7@gmail.com>
 <ZgFBch_ccGnZBCmz@smile.fi.intel.com>
 <2024032520-implosion-living-d148@gregkh>
 <ZgHFbosacLDyhgaY@smile.fi.intel.com>
 <2024032504-unruly-starship-3967@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032504-unruly-starship-3967@gregkh>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 25, 2024 at 07:51:16PM +0100, Greg KH wrote:
> On Mon, Mar 25, 2024 at 08:41:50PM +0200, Andy Shevchenko wrote:
> > On Mon, Mar 25, 2024 at 07:05:46PM +0100, Greg KH wrote:
> > > On Mon, Mar 25, 2024 at 11:18:42AM +0200, Andy Shevchenko wrote:
> > > > On Sun, Mar 24, 2024 at 11:31:58AM +0200, Shahar Avidar wrote:
> > > > > 1. Untangle include hierarchy. 
> > > > > 2. Update #minors the driver can accept.
> > > > > 3. Make use of general macro instead of magic number.
> > > > 
> > > > > Shahar Avidar (3):
> > > > >   staging: pi433: Use headers in appropriate files.
> > > > >   staging: pi433: Reduce N_PI433_MINORS to conform with N_SPI_MINORS.
> > > > >   staging: pi433: Make use of spi mode macro instead of magic number.
> > > > 
> > > > For patches 1 and 3
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > That's impossible for b4 to parse, it would have applied this to all of
> > > the commits if I had taken them :(
> > 
> > You can apply only patches 1 and 3 as long as they are independent to patch 2.
> > 
> > 	b4 am -st -P 1,3 ...
> 
> I don't do that, it would not scale at all :)

Yeah, this requires too much maintainer's involvement.

Alternative option, in case you are fine with patch 2, is to drop my tags and
apply.

-- 
With Best Regards,
Andy Shevchenko



