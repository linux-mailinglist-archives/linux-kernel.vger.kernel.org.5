Return-Path: <linux-kernel+bounces-85563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E38586B7C6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9003C1C22777
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B1174404;
	Wed, 28 Feb 2024 18:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpjqGX52"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5739871EAB;
	Wed, 28 Feb 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709146668; cv=none; b=UibFVXbcGBF96z6AAdMcEM2TFpYVZpo7zVi/5d9pIN76EPVAgNwB8HCOolwgQy7lS0psd2Us3x6/RQXHAdl333l5f360EGgREFBZkFB+YX+BSh0IeOC10thT3jw6ukT6CI10WESl8TO2sRCqSxNn4hKGqu8vj6jvjypPBafvCOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709146668; c=relaxed/simple;
	bh=gDw3jRm0AM60tHCxqaG2rfJ1npT2cZmBML0MaxvzlBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fdPZxV5KZW1zOf+QNikWvWAGcKo2M6wR1E8D+/hCt/T41imBdqrp7fDquz3Ys6RmN+VampM0cJtrBLAZfljr6XcfKtT1DEjiWr4+oV/xvmZ2AAe3xTprNGrUi/Tz0e43Sgs5716WQ14iTR4VA8Mtsr9SXzB7Vc+Jij82UpKnJII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpjqGX52; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709146667; x=1740682667;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gDw3jRm0AM60tHCxqaG2rfJ1npT2cZmBML0MaxvzlBA=;
  b=bpjqGX526MSYYQ3txjhWTnGEIllsnt/nKfr9xion8azTYJiNE/Nrj661
   z5kxuo3pl0q/qdwjjCLp9W4yKS1BjRUqBhe6cBdxruIAzstDhucdgsoSs
   2vLI9vtJyueJRiynn5HBPXhUr5Pd53uvQScANp5BQBazdsKf/KgL0IJyz
   QB1+N48LHqhmJrKfMXc+IQU4VjUzy7N92Nb2c/iwaGfliL44VRXYWXbLV
   zpxkbGGNdQKwI8k6anaS6fWbLZNPo9ECuP6iCcVDo6NL+BMuNxOvw08X/
   A7W7rA4IdSNWqt4yBoSQshdQuGWlvbDlPvMChQUVbF4LPJsjtU8RclNLs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="21025990"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="21025990"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:57:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913958400"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913958400"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 10:57:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfP7c-00000008Izz-2Ern;
	Wed, 28 Feb 2024 20:57:40 +0200
Date: Wed, 28 Feb 2024 20:57:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-gpio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in
 devm_fwnode_gpiod_get_index()
Message-ID: <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
References: <20240223065254.3795204-1-swboyd@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240223065254.3795204-1-swboyd@chromium.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 22, 2024 at 10:52:53PM -0800, Stephen Boyd wrote:
> This devm API takes a consumer device as an argument to setup the devm
> action, but throws it away when calling further into gpiolib. This leads
> to odd debug messages like this:
> 
>  (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup
> 
> Let's pass the consumer device down, by directly calling what
> fwnode_gpiod_get_index() calls but pass the device used for devm. This
> changes the message to look like this instead:
> 
>  gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup
> 
> Note that callers of fwnode_gpiod_get_index() will still see the NULL
> device pointer debug message, but there's not much we can do about that
> because the API doesn't take a struct device.

Have you seen this?
https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@linux.intel.com

-- 
With Best Regards,
Andy Shevchenko



