Return-Path: <linux-kernel+bounces-1426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A93814EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E121F22DA5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EB3134CD;
	Fri, 15 Dec 2023 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="humko8g6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357F982ECD;
	Fri, 15 Dec 2023 17:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702661611; x=1734197611;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y3i9ObbG7YHUbC2/n+tb9zuNB3tXQIBP33yXqqK+ZoU=;
  b=humko8g6bZfV7iJ8C4Ukpp5x+PFcBF3Cz3dSQ5B47OHteyNIT4GU5K3m
   tY6cu3UxbMrw3V5AtRim3aI1d0RvSOhFSgflZWN3b/LzIHWx4PAOy160l
   K8jiRWkAguk8lreCH/NpIYjIBzBjm7t/KXXGvU916EhKy9gmmhlFcxklL
   bRnrPWGec95Tll7jTaLsloerbExEGeLALuql2t+ixlLgApsgLn+LtXgqc
   vmfWgPWeWpDRBWh0pHI7DadNkKQV0dN02JBe9D0nfr5o2IDkkgiW1m7Kg
   AzmHxhNppl165abnGEa0Iw0Nce7SmFE27Ok2drAUVOxTgLLpG8h/fKvLE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="385723422"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="385723422"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:33:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="865473028"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="865473028"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:33:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rEC3x-00000006BG9-2tef;
	Fri, 15 Dec 2023 19:33:25 +0200
Date: Fri, 15 Dec 2023 19:33:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 2/2] gpiolib: use a mutex to protect the list of GPIO
 devices
Message-ID: <ZXyN5WrJL6NmV_l8@smile.fi.intel.com>
References: <20231215155300.21186-1-brgl@bgdev.pl>
 <20231215155300.21186-3-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215155300.21186-3-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 15, 2023 at 04:53:00PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> The global list of GPIO devices is never modified or accessed from
> atomic context so it's fine to protect it using a mutex. Add a new
> global lock dedicated to the gpio_devices list and use it whenever
> accessing or modifying it.
> 
> While at it: fold the sysfs registering of existing devices into
> gpiolib.c and make gpio_devices static within its compilation unit.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



