Return-Path: <linux-kernel+bounces-136960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E43889DA59
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 537121F2210B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 13:35:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6B312FB3F;
	Tue,  9 Apr 2024 13:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CFijhd1M"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A167A12EBE5;
	Tue,  9 Apr 2024 13:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712669423; cv=none; b=LWP+G9SWnkLXad4n4HyfmnUdVAdjGq+c5nxeHBmF28LqPLfSmmvQklrcJhkOZ2+9tzeTx4Jzm5CUxEyTcstIec76C7OXTI8D/7coKVGRMBbQ3nKV7vy2PwjFSJtAAlZO/gDutUf1e3HVOns5qFpcwtZGPYqoQH4oK/csYQ8Jwjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712669423; c=relaxed/simple;
	bh=fwIbdQ6kieHWU7HxacTenkKM95bShpnCbvagYrNsuEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OOxJ5GLEY9JQZKWFgQv5ZUbzblgnkCpVPTOWV3AJ0fOP5ddIfj8Hl9aYzXE/PfVDdIsJdUUKZ55zpB42KdG+/XR8AxGl3GxXzWKu1SVEQAzsuMfdUpX8VpPI5fchFnIIsgCSeuFZnqFxnSdhNt73eiSrvF2Q8yLDw1Al4shc28I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CFijhd1M; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712669421; x=1744205421;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fwIbdQ6kieHWU7HxacTenkKM95bShpnCbvagYrNsuEE=;
  b=CFijhd1MWC8DuYDeKFcKls+VPi9QYuJ0NeUz/2XEpzkSe76wRs+LAzu6
   cKEKg5T+Aoquzn2LvpkxdZlZSl3kn9E0IeEwzLrbZY381zlVVoZvJkbnY
   VFxbabtLOCg46OAx2RAvpcTi50yGXxnampfBJuOLbbAQzcLTNqOAt6n2u
   X29AV7IGy5+RTjxIyGdKkv4NZxQ4AGGC5PmGb80wegHl1D/UpaaTgHTJ1
   YY2NAP94YPE9kt2VmhuUW90QKnwgbZe838F1X4MOPp+pJfR+vpAEyu5hw
   hj07rpZGgxHaOIZi868pn+wRTWvEnC8nnWEMO53A/GQn5BlxXOWlQQ4lw
   g==;
X-CSE-ConnectionGUID: d3hFL4NER+uyb7sBYSmTcQ==
X-CSE-MsgGUID: pz/7gzCIT6OukG7VKjksHw==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="25423555"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="25423555"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:30:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915399886"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="915399886"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 06:30:16 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ruBYD-00000002ob8-2kVm;
	Tue, 09 Apr 2024 16:30:13 +0300
Date: Tue, 9 Apr 2024 16:30:13 +0300
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
Message-ID: <ZhVC5Qa472_xQs3A@smile.fi.intel.com>
References: <20240408231727.396452-1-andriy.shevchenko@linux.intel.com>
 <20240408231727.396452-2-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mf73fFHo83gNvDXGy9BosB1MNz_=8kt56hLA12bPBb8CA@mail.gmail.com>
 <ZhU5uDJk_M_TtKH2@smile.fi.intel.com>
 <CAMRc=Meh6K2zxpVPHvsDcr5vMMeagK7FGhnUPz3bb2rQQCPHJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Meh6K2zxpVPHvsDcr5vMMeagK7FGhnUPz3bb2rQQCPHJA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 09, 2024 at 02:55:20PM +0200, Bartosz Golaszewski wrote:
> On Tue, Apr 9, 2024 at 2:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Apr 09, 2024 at 11:42:37AM +0200, Bartosz Golaszewski wrote:
> > > On Tue, Apr 9, 2024 at 1:17 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > The GPIO_* flag definitions are *almost* duplicated in two files
> > > > (with unmatches OPEN_SOURCE / OPEN_DRAIN). Moreover, some code relies
> > > > on one set of definitions while the rest is on the other. Clean up
> > > > this mess by providing only one source of the definitions to all.
> > > >
> > > > Fixes: b424808115cb ("brcm80211: brcmsmac: Move LEDs to GPIO descriptors")
> > > > Fixes: 5923ea6c2ce6 ("gpio: pass lookup and descriptor flags to request_own")
> > > > Fixes: fed7026adc7c ("gpiolib: Make use of enum gpio_lookup_flags consistent")
> > > > Fixes: 4c0facddb7d8 ("gpio: core: Decouple open drain/source flag with active low/high")
> > > > Fixes: 69d301fdd196 ("gpio: add DT bindings for existing consumer flags")
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  drivers/gpio/gpiolib-of.c                     |  5 ++---
> > > >  drivers/gpio/gpiolib.c                        |  8 +++-----
> > > >  .../broadcom/brcm80211/brcmsmac/led.c         |  2 +-
> > > >  include/linux/gpio/driver.h                   |  3 +--
> > > >  include/linux/gpio/machine.h                  | 20 +++++--------------
> > > >  5 files changed, 12 insertions(+), 26 deletions(-)
> > >
> > > I don't think ./dt-bindings/gpio/gpio.h is the right source of these
> > > defines for everyone - including non-OF systems. I would prefer the
> > > ones in include/linux/gpio/machine.h be the upstream source but then
> > > headers in include/dt-bindings/ cannot include them so my second-best
> > > suggestion is to rename the ones in include/linux/gpio/machine.h and
> > > treewide too. In general values from ./dt-bindings/gpio/gpio.h should
> > > only be used in DTS sources and gpiolib-of code.
> >
> > Then, please fix that your way. It's quite annoying issue.
> 
> This is not difficult in itself

I'm not sure, what about enum gpio_lookup_flags? Shall we resurrect it?
I see that you have better vision anyway. Consider my patch as a problem
report (and as bonus you have already list of Fixes tags :-).

> but it's a tree-wide change so we will
> probably have to send it to Torvalds at the end of the merge window in
> a separate pull-request.

WFM!

> I don't really have time now, I'll be travelling for 5 weeks in a row.
> I'll see closer to the merge window. Or next release cycle.

But can you prioritize this? It's a carefully planted minefield with already
a bug and confusion here.

-- 
With Best Regards,
Andy Shevchenko



