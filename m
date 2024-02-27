Return-Path: <linux-kernel+bounces-83433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F94869923
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2663828367A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA46B13B2B4;
	Tue, 27 Feb 2024 14:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dniY1zKx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6BE54BFE;
	Tue, 27 Feb 2024 14:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045619; cv=none; b=XV3KROtYH4/r6SMWdkE8D+GwnK0bLoxsUWrBmcOw3BRIS3P7sNfVpuv7x1A53ba+lBsQPucnvViHz33l4TNW9sqv4EceMr8VB2sXHv7OQyCKlz5uJ1myHLQp7qDIi0P1ZLrk6RNvYqVR6KYL4Bef0cUHk20X/01iIL3Tt+9rXUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045619; c=relaxed/simple;
	bh=7/HCLIxM8m8H1jm7lU/8tplk21ZMnEDIzNTpS1ZlOpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mv5VkgcmVSI5SInGNSBHB/MN5ZJZcJtr2jAHfkmhrhtnpK+LidAz3ZphrgeLI1Ugaphza2mop4Hhqp4ZJhWlyzCnX+lSgO3iy2QjzNeJxGp/8bG4jTiQ2Ozc3ls1zrh3i4uRvw1OKIv4ez2n7sMLusVrW9oUEqEvG3cK90QpRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dniY1zKx; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709045618; x=1740581618;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7/HCLIxM8m8H1jm7lU/8tplk21ZMnEDIzNTpS1ZlOpY=;
  b=dniY1zKx53x/l8Jx7pQdXo+PH7oze7L9oX046VkrPn5AF++5/48IhiwJ
   J39lwlvK8T2gr99OQvRbBFNKOWR4HQxUMLumo3/MAl8vu7Ob8TSiQ6x1u
   WgBMQVzvF8/LDs2rlFJi8cOMPxLI528ogDOZXfIqRtMcjHUwqTWlvWOV3
   t79XndhikQMgXIuj/H3mkUrrLu59xCiSRJfgSukzgaRu2K8jFlI68+u3b
   Oo7nIgY0fFYnEGsIH0VNIgur5dgSj/ZsMiKVuohy1lqxNjP4tBOwz+qKn
   7OGVLERrpIHOPM/PM2ljsv3Mity/oz+YpT4iSnAywx6BwVoy4UY2hqUUn
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="14537331"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="14537331"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:53:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="913914249"
X-IronPort-AV: E=Sophos;i="6.06,188,1705392000"; 
   d="scan'208";a="913914249"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 06:53:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1reypo-00000007yED-0xt7;
	Tue, 27 Feb 2024 16:53:32 +0200
Date: Tue, 27 Feb 2024 16:53:31 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Arturas Moskvinas <arturas.moskvinas@gmail.com>,
	linus.walleij@linaro.org, u.kleine-koenig@pengutronix.de,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpio: 74x164: Enable output pins after registers are
 reset
Message-ID: <Zd33a69X9Ej4llbk@smile.fi.intel.com>
References: <20240226134656.608559-1-arturas.moskvinas@gmail.com>
 <ZdyZnqS_jKelbs6G@smile.fi.intel.com>
 <3f629079-6809-4cae-bd4d-8b0ee4860196@gmail.com>
 <CAMRc=McUsv9ic5aU7oAaJ06zWtpna0CkkxPWr2nqPhEig5vPOg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McUsv9ic5aU7oAaJ06zWtpna0CkkxPWr2nqPhEig5vPOg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 27, 2024 at 02:14:40PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 27, 2024 at 7:58 AM Arturas Moskvinas
> <arturas.moskvinas@gmail.com> wrote:
> > On 2/26/24 16:01, Andy Shevchenko wrote:
> > > On Mon, Feb 26, 2024 at 03:46:56PM +0200, Arturas Moskvinas wrote:
> > >> Move output enabling after chip registers are cleared.
> > > Does this fix anything? If so, maybe elaborate a bit the potential behavioural
> > > changes on the real lines.
> >
> > Chip outputs are enabled[1] before actual reset is performed[2] which
> > might cause pin output value to flip flop if previous pin value was set
> > to 1 in chip. Change fixes that behavior by making sure chip is fully
> > reset before all outputs are enabled.
> >
> > Flip-flop can be noticed when module is removed and inserted again and
> > one of the pins was changed to 1 before removal. 100 microsecond
> > flipping is noticeable on oscilloscope (100khz SPI bus).
> >
> > For a properly reset chip - output is enabled around 100 microseconds
> > (on 100khz SPI bus) later during probing process hence should be
> > irrelevant behavioral change.
> >
> > [1] -
> > https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L130
> > [2] -
> > https://elixir.bootlin.com/linux/v6.7.4/source/drivers/gpio/gpio-74x164.c#L150
> >
> > Arturas Moskvinas
> 
> And this is precisely the kind of information that needs to go into
> commit messages. I can tell *what* you're doing by looking at the
> code. What I can't tell is *why*.

+1. Please, add this to the commit message of v2, also try to find the commit
that you can mark to be fixed with help of Fixes tag.

-- 
With Best Regards,
Andy Shevchenko



