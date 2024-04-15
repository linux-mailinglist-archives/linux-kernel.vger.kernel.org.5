Return-Path: <linux-kernel+bounces-145239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8798A5156
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:29:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3CF6B209F8
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC4384FDE;
	Mon, 15 Apr 2024 13:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lgdndwie"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59A871B3A;
	Mon, 15 Apr 2024 13:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187298; cv=none; b=RZybxS7ofvhTWaX07EGH1MIorp/YT0JtDkt0NVxsAUZ6xOOzROFK0CVdtLMhGjooqTXmzj4qsit70IzX0NRuge6KefKIFTw3meFu4XRRr9LTBDs0Ocy/ibCoeZiL9ztNwCUPpSeH8nQNUQJvujO/XkfivBLfyWEXLl3gzCq0jQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187298; c=relaxed/simple;
	bh=F8XpOKhH6IuTmCx0YAbTWlpjSq5rG+Fdl15Xl4Biwe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d+Y8lRPIbEvZ/nb5bQq1VLikdhWKybRNbFB++qTtVkm3NvU6F3YQEhmcrW/JZAfeyHoIdAbC7Q/FObuej8MHesEHOaLUA1s9nDwvN7lF2R7y2ZNnp6TDBrUnWkvfp1GiicMwhTC40cRia4aj3NNGP+ll0tcIXuDNl8LvuVWsTjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lgdndwie; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713187297; x=1744723297;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F8XpOKhH6IuTmCx0YAbTWlpjSq5rG+Fdl15Xl4Biwe0=;
  b=Lgdndwie0x/7b2M1el9rpprQ3yLIMUUDaAlx6n3Y/CSSwcxo8Hdh6oTl
   EW3yC5eSX4mkoHKacSczRDFjKiwqesCkkkML+XbfJDP4uGxqNpPtQGZRz
   iSiQnEXNMlljH48caVis4aUYALqwMzjsQUh0O+ITPKh+b5d2l8F+BbhMZ
   fE8I30ObqfkLTIwuD70phgTfdUHqz0OlWhBzRPBP6wP0QPg7idib74jnK
   IaC2DPGqZnNyscsb1RA0hJfyP3wOWgEN3cgMYx+ZLScgr3Z+I4t7jtGu4
   XecNhhrsQtNNfqF+Nwdh4hh2nC9JqBAqjg63VV8h+gZ6yqD6DCY/p4EE4
   Q==;
X-CSE-ConnectionGUID: 9qzFzgUkQjyvPF5Im1R3Iw==
X-CSE-MsgGUID: Krf74SQiTZKgNihTPEb6zQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11044"; a="19138813"
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="19138813"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:21:36 -0700
X-CSE-ConnectionGUID: WdSs8bzrQ9KtwFkjIO0jkA==
X-CSE-MsgGUID: QNWKI/BwQQCCTFfqPArLVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,203,1708416000"; 
   d="scan'208";a="21821974"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2024 06:21:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rwMH5-00000004PxP-0U7p;
	Mon, 15 Apr 2024 16:21:31 +0300
Date: Mon, 15 Apr 2024 16:21:30 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
Cc: linux-fpga@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moritz Fischer <mdf@kernel.org>, Wu Hao <hao.wu@intel.com>,
	Xu Yilun <yilun.xu@intel.com>, Tom Rix <trix@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v1 1/1] fpga: ice40-spi: Remove redundant of_match_ptr()
 macros
Message-ID: <Zh0p2vzG6h8M7Xpd@smile.fi.intel.com>
References: <20240412155830.96137-1-andriy.shevchenko@linux.intel.com>
 <Zhn0SgGulHq8Bbk3@yilunxu-OptiPlex-7050>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zhn0SgGulHq8Bbk3@yilunxu-OptiPlex-7050>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Apr 13, 2024 at 10:56:10AM +0800, Xu Yilun wrote:
> On Fri, Apr 12, 2024 at 06:58:30PM +0300, Andy Shevchenko wrote:
> > Since the driver hi6421-regulator depends on CONFIG_OF,
>                    ^
> It is ice40-spi

Oops, copy-and-paste typo.

> > it makes no difference to wrap of_match_ptr() here.
> > 
> > Remove of_match_ptr() macros to clean it up.
> > 
> > While at it, add missing mod_devicetable.h.
> > 
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Closes: https://lore.kernel.org/r/20240412151147.22a059ff@canb.auug.org.au
> > Fixes: 5d04660b29fb ("fpga: ice40-spi: Remove unused of_gpio.h")
> 
> Since 5d04660b29fb is not merged yet, could you just merge them into one?
> Or it breaks bisecting.

You can also fold it, but sure, I'll send a v2.

-- 
With Best Regards,
Andy Shevchenko



