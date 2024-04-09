Return-Path: <linux-kernel+bounces-136887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B2E89D967
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FC3228A134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E2912DDB8;
	Tue,  9 Apr 2024 12:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoGEWQbo"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4C61A5A2;
	Tue,  9 Apr 2024 12:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712667074; cv=none; b=LWGwAT6JPaxBisnp0yz7NMHL0gug9AmPDQkQ5nEz+svyIAgF3TMm4UIEwG8NWffI0qBujmi223rRtvNbkiVRq8QlmSucZEqbRCmurojIeEI7W6ihr8rCTrlJgAi5tvtimOUEGoo0FyquW+GSngvIrXvbFICApBqGAuGpEQloJq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712667074; c=relaxed/simple;
	bh=qLaR1T3JCwD+pcaCnaUzLtRoSUp8R3ZkvQx5FcERa6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWXq9VGaUlbdfMSYeYzApuqEl8vXBDuh1giCuUCUCG4tP54QEtF/rR0oIyhKSkMzACoovuMrZZXMoY8TKMFZ8FHOmu7FEeV7tzZc/6ubPXlLsIuEJQyzkMWEI2J+WsF6jPoICwpMXbGkgnn9XZ9VgWdjE+wnLzMScW+JiYmKY4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoGEWQbo; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712667073; x=1744203073;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qLaR1T3JCwD+pcaCnaUzLtRoSUp8R3ZkvQx5FcERa6E=;
  b=QoGEWQbom5g8+IpDR1YEFyhxlPB2224xElM/kkaiFxCds6yP2vDFKGNw
   OgFSDsjKZ45NRQ6nFEYr+1tCo5qbo37f34GiT5hYLqG6YZQSUt+sl+yqm
   iv3nVrCRAsGFZ0qfMmyYaJg+RFT2Vjl0vayFfcham3cGOSgm7uJqZRRLQ
   +GFm/hnbZz1mpMdVJk2Gah0qyfhSMrBtFtWMW1MvlKUqgGbACYhSssM6I
   sP2bY0Pb/zixokc1hDMbZ1VGn6l27iHP3qXYPB+TNuLhs2LCq19m2jzkE
   yvdAROnAluU1kq+qgDibI2x5rUuABxfUIPpwti+tLeXSwl5wLeUTzTrNJ
   g==;
X-CSE-ConnectionGUID: pJXgfUAETemAJHQp8KMYbw==
X-CSE-MsgGUID: Z9T7qQTRT4Stmnx6g9itNw==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="8080657"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="8080657"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:51:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="915399074"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399074"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 05:51:07 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruAwL-00000002o6H-0JxC;
	Tue, 09 Apr 2024 15:51:05 +0300
Date: Tue, 9 Apr 2024 15:51:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Arend van Spriel <arend.vanspriel@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 1/2] gpiolib: Fix a mess with the GPIO_* flags
Message-ID: <ZhU5uDJk_M_TtKH2@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf73fFHo83gNvDXGy9BosB1MNz_=8kt56hLA12bPBb8CA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mf73fFHo83gNvDXGy9BosB1MNz_=8kt56hLA12bPBb8CA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 11:42:37AM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 9, 2024 at 1:17 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > The GPIO_* flag definitions are *almost* duplicated in two files
> > (with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
> > on one set of definitions while the rest is on the other. Clean up
> > this mess by providing only one source of the definitions to all.
> >
> > Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors")
> > Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_own")
> > Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consistent")
> > Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with active low/high")
> > Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/gpio/gpiolib-of.c                     |  5 ++---
> >  drivers/gpio/gpiolib.c                        |  8 +++-----
> >  .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
> >  include/linux/gpio/driver.h                   |  3 +--
> >  include/linux/gpio/machine.h                  | 20 +++++--------------
> >  5 files changed, 12 insertions(+), 26 deletions(-)
> 
> I don't think ./dt-bindings/gpio/gpio.h is the right source of these
> defines for everyone - including non-OF systems. I would prefer the
> ones in include/linux/gpio/machine.h be the upstream source but then
> headers in include/dt-bindings/ cannot include them so my second-best
> suggestion is to rename the ones in include/linux/gpio/machine.h and
> treewide too. In general values from ./dt-bindings/gpio/gpio.h should
> only be used in DTS sources and gpiolib-of code.

Then, please fix that your way. It's quite annoying issue.

-- 
With Best Regards,
Andy Shevchenko



