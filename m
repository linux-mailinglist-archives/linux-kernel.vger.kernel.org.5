Return-Path: <linux-kernel+bounces-109059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E876F88141A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1676D1C22C20
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA184E1D5;
	Wed, 20 Mar 2024 15:05:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3955342044;
	Wed, 20 Mar 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710947154; cv=none; b=Yw/LfFErt/EGrZgSwhK0U0SrNFgegcaMNQtLm8HppsfPZWO2Pb00IVk+uOz5EtzSKk2HmWIQ+S4ecvd+Yiwfuv96SFoYkNEWQexh0JJeigllFjoyADUu7YrKWo3Day4m6aivCXas9V51SwSEVlhjHOIR8kQ5UpFr3vaeLPtckBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710947154; c=relaxed/simple;
	bh=d/cSt3fSGUqWXRJWnG+U0v3qY/qL1KyLp83SUbSo5X0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RfZ7hZmBxdSGWBXq5rhxyyT+ihpREXkwn69dWNxYhKOk6ampAJ+36ChQ9MsJRP9AUk5TXAmbM1pPZXVUNykOHqOCf0g0s/luLU5kFBgr89bEO8QOb4oskvMjtzubsvwBvLAV7JJw1n2QarjPRRmty7XHe0a8zV1qS/Wy5h2fPis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="23333147"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="23333147"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11019"; a="914670597"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="914670597"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 08:05:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1rmxVj-0000000EbEb-0Cg7;
	Wed, 20 Mar 2024 17:05:47 +0200
Date: Wed, 20 Mar 2024 17:05:46 +0200
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Hans de Goede <hdegoede@redhat.com>,
	Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 2/3] gpiolib: Fix debug messaging in
 gpiod_find_and_request()
Message-ID: <Zfr7Sut9G0x14lDN@smile.fi.intel.com>
References: <20231019173457.2445119-1-andriy.shevchenko@linux.intel.com>
 <20231019173457.2445119-3-andriy.shevchenko@linux.intel.com>
 <ZTGBqEUzgGCcZP1B@google.com>
 <ZVOSd62yCz4lFIP1@smile.fi.intel.com>
 <ZVPkIOk6gvnwkp9F@google.com>
 <ZVQg9hTQwGtNwIhv@surfacebook.localdomain>
 <ZVTcQnH_BEEFJ2Ut@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVTcQnH_BEEFJ2Ut@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Nov 15, 2023 at 02:57:06PM +0000, Dmitry Torokhov wrote:
> On Wed, Nov 15, 2023 at 03:37:58AM +0200, andy.shevchenko@gmail.com wrote:
> > Tue, Nov 14, 2023 at 09:18:24PM +0000, Dmitry Torokhov kirjoitti:
> > > On Tue, Nov 14, 2023 at 05:29:59PM +0200, Andy Shevchenko wrote:
> > > > On Thu, Oct 19, 2023 at 12:21:12PM -0700, Dmitry Torokhov wrote:
> > > > > On Thu, Oct 19, 2023 at 08:34:56PM +0300, Andy Shevchenko wrote:

Sorry for the late reply. Took me a bit to go through other things first.

..

> > > > > > When consolidating GPIO lookups in ACPI code, the debug messaging
> > > > > > had been broken and hence lost a bit of sense. Restore debug
> > > > > > messaging in gpiod_find_and_request() when configuring the GPIO
> > > > > > line via gpiod_configure_flags().
> > > > > 
> > > > > Could you give an example of the before/after messages to show exavtly
> > > > > what is being improved?
> > > > 
> > > > Before your patch:
> > > > 
> > > > [    5.266823] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > > [   14.182994] gpio-40 (?): no flags found for gpios
> > > > 
> > > > After your patch:
> > > > 
> > > > [    5.085048] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > > [   13.401402] gpio-40 (?): no flags found for (null)
> > > > 
> > > > After this patch:
> > > > 
> > > > [    3.871185] gpio-96 (ACPI:OpRegion): no flags found for ACPI:OpRegion
> > > > [   12.491998] gpio-40 (?): no flags found for gpios
> > > > 
> > > > ...
> > > > 
> > > > Looking at this it's definitely a fix.
> > > 
> > > If this ("(null)" vs static "gpios" string) is important, can we reduce
> > > the patch to:
> > > 
> > > diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
> > > index 76e0c38026c3..b868c016a9be 100644
> > > --- a/drivers/gpio/gpiolib.c
> > > +++ b/drivers/gpio/gpiolib.c
> > > @@ -4151,7 +4151,7 @@ int gpiod_configure_flags(struct gpio_desc *desc, const char *con_id,
> > >  
> > >  	/* No particular flag request, return here... */
> > >  	if (!(dflags & GPIOD_FLAGS_BIT_DIR_SET)) {
> > > -		gpiod_dbg(desc, "no flags found for %s\n", con_id);
> > > +		gpiod_dbg(desc, "no flags found for %s\n", con_id ?: "gpios");
> > >  		return 0;
> > >  	}
> > >  
> > > 
> > > instead of plumbing the names through?
> > 
> > Definitely no, because how can you guess that this is "gpios" and not "gpio"?
> > 
> > > Although this (and the original fix patch) are losing information, in
> > > the sense that "(null)" explicitly communicates that caller used
> > > default/NULL conn_id, and not something like "gpios-gpios".
> > 
> > This is not true, there was no such information before your patch and NULL
> > pointer printing is simply a bad style programming. We already had the cases
> > when users were scary by "NULL device *" and other similar stuff when it's
> > practically no problems in the flow. This has to be fixed anyway.
> > 
> > And what's the practical meaning of gpios-gpios / gpio-gpios / gpios-gpio /
> > gpio-gpio? I believe they are so weird that thinking about them would be lowest
> > priority over the issues with the messaging there.
> 
> Well, I think we should try to communicate better what it is that we are
> printing. Consider your example:
> 
> 	"gpio-40 (?): no flags found for gpios"
> 
> what gpios mean here? You need to go into the code to figure out that it
> is connection id (whatever it is for a person who is not ultimately
> familiar with gpio subsystem) and not "gpios" in a generic sense. Plus
> with your patch you need to ascend a couple of layers up to figure out
> that it is connection id and not something else. With "(null)" we at
> least did not obfuscate things just so they are visually pleasing to a
> random user.
> 
> How about we change a message a bit:
> 
> 	gpiod_dbg(desc, "no flags found for %s gpios\n",
> 		  con_id ?: "default");
> 
> We can argue if "default" should be "unnamed" or "unspecified" or
> something else.

We can use something with a space that would definitely may not be a connection
ID (in the DT/ACPI/swnode[?]).

Let me figure out, but yes, can be a workaround as a quickfix.

> And finally what would help most is having a consumer device for which
> we are carrying out the operation. You can figure it out from the
> sequence of debug messages, but having it right here would be better.

Maybe, but it's out of scope of this fix.

-- 
With Best Regards,
Andy Shevchenko



