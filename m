Return-Path: <linux-kernel+bounces-87294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C22686D24E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D9D81C23818
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5367BAEB;
	Thu, 29 Feb 2024 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Aek6qwhm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1B36CBE2;
	Thu, 29 Feb 2024 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231404; cv=none; b=KSs3dSAQs+iChXbuD5k/6wQe3Q8fpHzTE7qyWYaev62jV3AtnPKTzJwZ7zjvPf2eqD3n+9koy6T2JjRJd0P5v6guNVhtizQ93X7vjBvvH/J8x7wsy3z+slngoKGgA4coqLrJLNgYkzym87KRmgPoIHKTX8hicL/Zf/ndOdqAMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231404; c=relaxed/simple;
	bh=wdwnItqwr53xgZo9ZcTcAPn6sVKRInT5VxZv5M627PA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D90OHBj/xt03k39rqk5svQb8NP+OXBtj2DhUQg5EyHBO8+s7DdxeJWOVW49ye/Cqwq9Q/dd6ccyKHqh9sCwuqM8zcx5+skwllRC8rx8U4cf90OrfMkj/I851uXQkpzXWKkKH5bYPsG0ODphXk44Poe4gTme3U94FXkBV2b8VQkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Aek6qwhm; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709231403; x=1740767403;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdwnItqwr53xgZo9ZcTcAPn6sVKRInT5VxZv5M627PA=;
  b=Aek6qwhmFs83mNs34xItpud2UUWbgMnQ24ZWHsLF/NlmNnlh7JDdQiCY
   nPIa1tpXbMsWo/EO9gfZLuN4B3FXHiB3qnzhoWiPw39IMISBNE/tb2C6N
   3dp2B6U2b6CKB00Dl5YbhwNY/l1S7O7AmlyaXSD6wQKpUwSYlPiOTo0ue
   WHKDdmwJmcv0CzvnrIxHFVJ0JNfaYlxfktOPkJT/4P9ZJa4JzKuMaG4Ya
   qzhFaHVgMJFHsJ0dywOTVucjdBkMEvxIqEAppbut1ZCBoULqTNUaAz90m
   8AmWNpyptKMfmgSgkehF92ReDpZUYp6v+hAT/lt2EDTDgLXrXTf+JRIsD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="3899390"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3899390"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:30:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="913988902"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913988902"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 10:29:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rflAL-00000008kGj-0j1X;
	Thu, 29 Feb 2024 20:29:57 +0200
Date: Thu, 29 Feb 2024 20:29:56 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Johan Hovold <johan@kernel.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpio: fix resource unwinding order in error path
Message-ID: <ZeDNJGbp_yAmuJqz@smile.fi.intel.com>
References: <20240229172549.444227-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240229172549.444227-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 29, 2024 at 06:25:49PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Hogs are added *after* ACPI so should be removed *before* in error path.

Now I got it, thanks for fixing that!

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



