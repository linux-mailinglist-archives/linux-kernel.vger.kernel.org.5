Return-Path: <linux-kernel+bounces-55001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F81284B61D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF3284D31
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117DC130AC7;
	Tue,  6 Feb 2024 13:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nwcXWzzV"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909E41DA3F;
	Tue,  6 Feb 2024 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225234; cv=none; b=sSDH5WL8UrF1LZdQHMAjWodCsGlPkO3ECtSlWsI6+6Sj91RkSQODIG08mJ4cZPtxfiRJioObWGYDJnI7xlVj7ghjHWB+lE+xAEUUG5AgzQVrgmak/B0nv02dyEkSxrPNP/OXoY6g7N7Ovflb3wkPTtMGW5PDDGP7m7WPrDFN0U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225234; c=relaxed/simple;
	bh=JyZh+adA1uVkYt9vxH+nUWXV8/wcgCYlgQumPyvaH5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=psM1Hq77mU/Q6tBIwlPVVvqNc5u3zm8ldqzd2ObPHqpz3WhXOAIicUgX07DLkVf2sK0TJ4xe8krFyd3LIPmpMhqRz5WpRt21MxiModhmensGfoBPWyKVYH5KB6b99d/UrYHEBTkXXKzdpWJF+dE+nwbjRIyec8k7eGArvXkFaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nwcXWzzV; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707225232; x=1738761232;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=JyZh+adA1uVkYt9vxH+nUWXV8/wcgCYlgQumPyvaH5A=;
  b=nwcXWzzVMCE3oaTOkIzMV60ELzdZYRmdyoxtTKo17/kc5sKXUqALvxFR
   4h4rSsBmz5IAVtKwe5TzNGYKgCg9S03ez4t/aEn5U0C7t8Z5CS2S92/Qv
   fE+EqR1vqDt4J6gYdm0L+oQRmA1LYIfjl2X/FwqOnhAtjgAfsCj/2s02f
   yZ87NjNKPOeUqyxoNOqIWcSrXK/mOgHSfw+LGMsW2LXBqIryxnQfuGPHI
   7LmrZQ5zyDPYuDXwddugHTTGGw+oOKVFl8UODefO+uDz3Qf5fngvptzm3
   +W3wMzszniWCUVs3M1sGlxX2TRvu4KfxITJJXDUHlo0LIUntfIHbfJ0ee
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="26188121"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="26188121"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:13:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="909633156"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="909633156"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 05:13:49 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rXLGk-00000002LYh-0Zwm;
	Tue, 06 Feb 2024 15:13:46 +0200
Date: Tue, 6 Feb 2024 15:13:45 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 21/23] gpio: protect the pointer to gpio_chip in
 gpio_device with SRCU
Message-ID: <ZcIwiU4UNbcoa8Km@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-22-brgl@bgdev.pl>
 <ZcDVNA6Id7Bmckt0@smile.fi.intel.com>
 <CAMRc=MdoGQZKM37kk=j6NpdkUUjDvs3-8YeiZVQO2EpPHRZ7Uw@mail.gmail.com>
 <ZcIlEEgHn5AaTEyz@smile.fi.intel.com>
 <CAMRc=Mcq2UgS4EcVAOghQzFq_jXA83rGMse+pxa5ieK8MXZm-w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mcq2UgS4EcVAOghQzFq_jXA83rGMse+pxa5ieK8MXZm-w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Feb 06, 2024 at 01:57:39PM +0100, Bartosz Golaszewski wrote:
> On Tue, Feb 6, 2024 at 1:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Mon, Feb 05, 2024 at 08:36:39PM +0100, Bartosz Golaszewski wrote:
> > > On Mon, Feb 5, 2024 at 1:31 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> >
> > ...
> >
> > > >
> > > > >  int gpiod_get_direction(struct gpio_desc *desc)
> > > > >  {
> > > > > -     struct gpio_chip *gc;
> > > > >       unsigned long flags;
> > > > >       unsigned int offset;
> > > > >       int ret;
> > > > >
> > > > > -     gc = gpiod_to_chip(desc);
> > > > > +     if (!desc)
> > > > > +             /* Sane default is INPUT. */
> > > > > +             return 1;
> > > >
> > > > Hmm... I can't imagine how this value may anyhow be used / useful.
> > >
> > > What else would you return for an optional (NULL) GPIO?
> >
> > An error. If somebody asks for direction of the non-existing GPIO, there is no
> > (valid) answer for that.

> All other functions return 0 for desc == NULL to accommodate
> gpiod_get_optional(). I think we should stay consistent here.

The way you proposed is inconsistent, i.e. you may not return any direction
for the unknown / non-existing GPIO. You speculate it will be 1, I may consider
that in my (hypothetical for now) case it should be 0.

Just don't make all bananas to be oranges. It won't work.

-- 
With Best Regards,
Andy Shevchenko



