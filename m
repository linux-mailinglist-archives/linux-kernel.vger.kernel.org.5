Return-Path: <linux-kernel+bounces-52782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27310849C9C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 15:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A0761C24C9E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE51249EB;
	Mon,  5 Feb 2024 14:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uqc9Xjlh"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E842C190;
	Mon,  5 Feb 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142018; cv=none; b=Qm/SRADGPM0NqPn0OnkKSUi6R5YuXt8TZBmJCoe2xUf8BX9V6bdPPdox18sz/HoNqmlz0MzOKdFNV0JDr/mf2sV3BNfRsAxyM82JS3rb9OvZExXkO1EIGBFyLoOcrzQ5BPaDYPkawX3K+t5VriZnI2TPreh1bG7cxGJ0DvKHQHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142018; c=relaxed/simple;
	bh=guYmxHTAy29VwFF6fYRyWkTFNPqWsV5pzBzH20n1Tx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tf5Xt+J2I6kE4Dfq2SASOELGfemyowwkqy9fdXOTar/TvwtqITw6AgGzObGVGUMXsuHnOpTIJMrpEq/SdJARWY/hjkWRGuBI4NpJy5KML/4poomSOhxZ/Ljz9QynnqQChJ4TpnyeilJx3o2GyWXBTrdPVtvdSTHezttuWjhC9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uqc9Xjlh; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707142017; x=1738678017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=guYmxHTAy29VwFF6fYRyWkTFNPqWsV5pzBzH20n1Tx8=;
  b=Uqc9XjlhglYpMwE2QPqC8+v1eqWMkM8Z5N0LvIssaMBzQh6DEM1x3v6g
   gZDWOQ1ZSghs0YK1Qh62AcnUcneox7KSfjyIEY3PRz8hPppergPdeCYDC
   YjyGapRSsT3BuV9VmP5mBXIghRnK9XpqCgDo+6L/bzpaVasx8RcDIpGmQ
   yXbfRZ1WgNPTOLnzy3/abr4dWU7ztWLDUz6rzWuyKv7WtvH4Waogb9jnh
   YGI9Cj+108p2X434RhbGoQjEwmYmlQIhbuXZg0X858yp7UZscWaaGqyhL
   ihb26dfzckCO9fPCHiDapOzWzH3I2QCWVFToEn73BCrUPZFKO9ayIISPY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="784185"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="784185"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:06:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909303702"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909303702"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 06:06:53 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzcY-0000000265b-1abU;
	Mon, 05 Feb 2024 16:06:50 +0200
Date: Mon, 5 Feb 2024 16:06:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 06/23] gpio: add SRCU infrastructure to struct
 gpio_desc
Message-ID: <ZcDreg9pXqFX8zwa@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-7-brgl@bgdev.pl>
 <ZcDRuRCT9xE48cYi@smile.fi.intel.com>
 <CAMRc=Mc5=p7tp0r8-MYiHRJ1yXDJLW2Uvm5C1CyoGBAcesdZug@mail.gmail.com>
 <ZcDpWf7u3bW34Y8s@smile.fi.intel.com>
 <CAMRc=Mf740MJEg5fkAZaeL5yZAvVpJvjJ3zWcn-gWqS6_ue1mA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf740MJEg5fkAZaeL5yZAvVpJvjJ3zWcn-gWqS6_ue1mA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 06:04:23AM -0800, Bartosz Golaszewski wrote:
> On Mon, 5 Feb 2024 14:57:45 +0100, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> said:
> > On Mon, Feb 05, 2024 at 02:54:08PM +0100, Bartosz Golaszewski wrote:
> >> On Mon, Feb 5, 2024 at 2:48 PM Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> wrote:
> >> > On Mon, Feb 05, 2024 at 10:34:01AM +0100, Bartosz Golaszewski wrote:

..

> >> > > +                     for (j = 0; j < i; j++)
> >> > > +                             cleanup_srcu_struct(&desc->srcu);
> >> >
> >> > What does this loop mean?
> >>
> >> I open-coded it because I want to store the value of i to go back and
> >> destroy the SRCU structs on failure.
> >
> > Where/how is j being used?
> >
> 
> In this bit:

I am sorry, but I don't see how...

>         for (i = 0; i < gc->ngpio; i++) {
>                 struct gpio_desc *desc = &gdev->descs[i];
> 
>                 ret = init_srcu_struct(&desc->srcu);
>                 if (ret) {
>                         for (j = 0; j < i; j++)
>                                 cleanup_srcu_struct(&desc->srcu);

So, you call the same several times, why?

>                         goto err_remove_of_chip;
>                 }

> >> > > +                     goto err_remove_of_chip;
> >> > > +             }

-- 
With Best Regards,
Andy Shevchenko



