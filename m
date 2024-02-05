Return-Path: <linux-kernel+bounces-52735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E02849C0C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 14:39:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 733AEB26A8E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 13:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACC0210F4;
	Mon,  5 Feb 2024 13:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h6khPwUS"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221F62C694;
	Mon,  5 Feb 2024 13:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707140293; cv=none; b=hRFiiCSAU1G8GmhbufyzaMGeHKzD66MuOwDNt5MwHNe7m6l5I3XPYsk4i2isYazwr6MAdZXAKaot9qe/JDwqXivuBlMrdWuZyWb1B5F7jsKKM9o9ijrXoMA4jgGn5FtrdJMXShWFQwlun+TARXKfe162Q3b6nf0SKxnR5K2QVjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707140293; c=relaxed/simple;
	bh=a9V3krKfDbi0uXou9IfA/2KI6GaqL1lBaZ3Lvq9VJv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vz99JVrYVcRVw+XcYS9Ljb33FVFE0AzlczMmhfP5I82oWzGAePaQpR/X1IuvLD2QL73f1y0Q3QA92fVE2RUdCVkIl2NkyIKOuB5Eoi73W10jX7O8PuBokv0J+obSnHwGxwoRNwupBtUBV1EfnRQskIgxU0aDDSNaxfNmB6ra3Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h6khPwUS; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707140293; x=1738676293;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a9V3krKfDbi0uXou9IfA/2KI6GaqL1lBaZ3Lvq9VJv4=;
  b=h6khPwUSWqT2Y9qIAmcLMBwNEXc0HAkzSA9o0P9LcYQt96aInEA+kSD0
   HYZRONWodPzpG5zlKuT9zGlDIwVlXymaCYbtdgRLQ665s0gKwNhdgwtS+
   b6AQpuo941bJDCdnUp/+WxbL448GftQsr8PQV0A5uJ5fS+u5HwjWyuHZJ
   lwdTAj+ykZnTMrWAEop13h/A7Kz8+h873vKN0tIVS3bSi44J2w4NyGfFS
   Usee9s41LSQvRikuDhXJJEqRyKE9YV6vc8S90w+XFKwHVDLnvP1NvCpNS
   EpC1FB0J2A94lz5xkNuBrxnaQ7aMmrjSbuAxCPEDmi3OUO9m5C64aLgpI
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="429351"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="429351"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:38:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="909299518"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="909299518"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:38:07 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rWzAi-000000025ef-3myv;
	Mon, 05 Feb 2024 15:38:04 +0200
Date: Mon, 5 Feb 2024 15:38:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 08/23] gpio: sysfs: use gpio_device_find() to iterate
 over existing devices
Message-ID: <ZcDkvOrlSRkmYIk_@smile.fi.intel.com>
References: <20240205093418.39755-1-brgl@bgdev.pl>
 <20240205093418.39755-9-brgl@bgdev.pl>
 <ZcDSKYqFHSUZb2Qx@smile.fi.intel.com>
 <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfh5CcftXUStGOXvUF-s3aNxnaNM0sDt72LKrBfttqitQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 05, 2024 at 02:19:10PM +0100, Bartosz Golaszewski wrote:
> On Mon, Feb 5, 2024 at 1:36 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Feb 05, 2024 at 10:34:03AM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > With the list of GPIO devices now protected with SRCU we can use
> > > gpio_device_find() to traverse it from sysfs.

..

> > > +static int gpiofind_sysfs_register(struct gpio_chip *gc, void *data)
> > > +{
> > > +     struct gpio_device *gdev = gc->gpiodev;
> > > +     int ret;
> > > +
> > > +     if (gdev->mockdev)
> > > +             return 0;
> > > +
> > > +     ret = gpiochip_sysfs_register(gdev);
> > > +     if (ret)
> > > +             chip_err(gc, "failed to register the sysfs entry: %d\n", ret);
> >
> > > +     return 0;
> >
> > ???

What the point of function to be int if you effectively ignore this by always
returning 0?

> Not sure what the ... and ??? mean? The commit message should have
> read "... traverse it from gpiofind_sysfs_register()" I agree but the
> latter?

I didn't realize this may not be obvious :-(.

> > > +}

-- 
With Best Regards,
Andy Shevchenko



