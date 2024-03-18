Return-Path: <linux-kernel+bounces-105995-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C5187E741
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 758821F21B84
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 452D42E83C;
	Mon, 18 Mar 2024 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UrxgUAiZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEBF2D60A;
	Mon, 18 Mar 2024 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757371; cv=none; b=GqDB8AfG+KksQy2sw1e/fW15/bf9VUuMn6gi4tvJbg0TGajzZEiaYIqknHWACdcJIzLmW3U2l7hSbcOdUCvWpDLimTmFOIQHotzU3W6icU30yFWC0YtnTyZBESRsny99Az4mWCHO0hjiXqcoaODPoMzMwrsPnjuPhSUYHprXniw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757371; c=relaxed/simple;
	bh=46dpx8iOYMFqOP9ytJf3zMpAk2DMYl4dsoucER8jWbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMcKYBdfaZu8q4XuudXZq14c1pad0bIqgP7e1os5OukyxO8y4v9uROpS8el83gx1L1mA6I0dxR34MmctOdBnKe0wwXqdXNbX/0BZ1w9FQYIF+tV3ltH1m2ePM8GuqgodD552Q1nsL02aBYylj1rUpTbm3IjbFvpq3CLXYnwJ9hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UrxgUAiZ; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710757370; x=1742293370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=46dpx8iOYMFqOP9ytJf3zMpAk2DMYl4dsoucER8jWbQ=;
  b=UrxgUAiZylVuk3fqd6JDJkwdo1Br+S0byFtPyALbZRs1j+x2J+CHZO/P
   2gMSkUoZED7bo0vhdghETHqFZRtngCuOgmOioBATg3rbE1i5PDn0Z+qKk
   VQeuKok17ckC87+tbejIy3856DBU4G9vGZs7h/SxfPlIPmyTg5zm+kqND
   lE9Yn+2kvkc28IfcbrVZ0bwR03Q1E/Wb/M/IATbVyt8bOTAMpChrVghgn
   LghV34kQbdYvFFMyKyk4CcxB5WFMDuFj7v4TzKkbBFH77vypL0BQNK3oj
   XjQx+JQmXf7t54AanpyCZH0WXaz/jMxWmpiQwmDuoOKXtod264S2J6MyG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="17008451"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="17008451"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:22:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11016"; a="914587760"
X-IronPort-AV: E=Sophos;i="6.07,134,1708416000"; 
   d="scan'208";a="914587760"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2024 03:22:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rmA8i-0000000Dud2-0mO5;
	Mon, 18 Mar 2024 12:22:44 +0200
Date: Mon, 18 Mar 2024 12:22:43 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_lpc18xx: disable clks on error in probe()
Message-ID: <ZfgV84MvVZQFYsvc@smile.fi.intel.com>
References: <92646c10-e0b5-4117-a9ac-ce9987d33ce3@moroto.mountain>
 <ZfgReWkDIFnoUiCZ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfgReWkDIFnoUiCZ@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 18, 2024 at 12:03:38PM +0200, Andy Shevchenko wrote:
> On Sat, Mar 16, 2024 at 12:30:09PM +0300, Dan Carpenter wrote:
> > Goto the clean up path to clean up a couple clocks before returning
> > on this error path.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Thank you for fixing this!

Btw, alternatively it may be switched to use devm_clk_get_enabled().

-- 
With Best Regards,
Andy Shevchenko



