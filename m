Return-Path: <linux-kernel+bounces-85730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDDB86BA06
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:35:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75556289230
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 21:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85570042;
	Wed, 28 Feb 2024 21:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CBbEtVVn"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4670020;
	Wed, 28 Feb 2024 21:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709156144; cv=none; b=FTLyq2yoxVZV5aB+YYBgpkVxMIyZnm5IpVp1Q4b8gmAgs98i90d/PKgCmDB98/Ng3T0jDmLetVglh43GZmm+PLG4kRQ2NsIxGyLKy5Hl6Y/FQKE0HIXzJM3kungQvSl86G8ktw3znGODUqIBGIdoTawE6iBEss00x7nPaU1Z530=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709156144; c=relaxed/simple;
	bh=bo+1raElk9CFzZGK1rXURbBjbxmJF3gx1clws/DrATo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AuxIxphJD6rFx7jfufSuiw0TKoF6D7lLqqcsxEEYllN/JzwIVkMYlZI+bOPw8ru9ufk7AQ5F+liwaYP6B958cABHgPQbBHYuIgrMdgNMvb5JR/HhwMiG0k7wl0T23JPPiMRnp5FAkl/zwRpL84yDcGUwo8nuJ/+i+d9+5R+4Kc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CBbEtVVn; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709156139; x=1740692139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=bo+1raElk9CFzZGK1rXURbBjbxmJF3gx1clws/DrATo=;
  b=CBbEtVVn/wtRypYTe6AUM1Wxn8CEr6T6a5CeubpnrqabFFmSDvWLtCdN
   WXR8MwH3DkwIfOG6Ca/Do2I5Zd6PSC5wgdwBA+pRvChXQmr31HPg/krpR
   yQLsYSvfYK83+sjzKz4mBBhpHM5Yabzw9sGa5h38ZbNx0jWLnh2pdGUYO
   YaqKsw1n3MN98JZGYAnptGOiQUVf7GgEkJeYgr1h+vEtKVlhh1N5j9III
   fmqAXgLX2V7mny+k2BycR0tS5QPrdBtfTnxRPBGDdzFtEwGeFuuW+YnU+
   jfgIdwenP/tZz67Carvu/EVDghFcAASvtibZiR0WQ3Ky+Lwbmz7QJ9/dC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="7371004"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7371004"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:35:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913961905"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="913961905"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 13:35:35 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfRaO-00000008VbH-138y;
	Wed, 28 Feb 2024 23:35:32 +0200
Date: Wed, 28 Feb 2024 23:35:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Stephen Boyd <swboyd@chromium.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in
 devm_fwnode_gpiod_get_index()
Message-ID: <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
References: <20240223065254.3795204-1-swboyd@chromium.org>
 <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
 <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 10:28:07PM +0100, Bartosz Golaszewski wrote:
> On Wed, Feb 28, 2024 at 7:57 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Thu, Feb 22, 2024 at 10:52:53PM -0800, Stephen Boyd wrote:
> > > This devm API takes a consumer device as an argument to setup the devm
> > > action, but throws it away when calling further into gpiolib. This leads
> > > to odd debug messages like this:
> > >
> > >  (NULL device *): using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup
> > >
> > > Let's pass the consumer device down, by directly calling what
> > > fwnode_gpiod_get_index() calls but pass the device used for devm. This
> > > changes the message to look like this instead:
> > >
> > >  gpio-keys gpio-keys: using DT '/gpio-keys/switch-pen-insert' for '(null)' GPIO lookup
> > >
> > > Note that callers of fwnode_gpiod_get_index() will still see the NULL
> > > device pointer debug message, but there's not much we can do about that
> > > because the API doesn't take a struct device.
> >
> > Have you seen this?
> > https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@linux.intel.com
> 
> Clearly yes as I queued the first one in that series. The rest did not
> make its way upstream for whatever reason. What is your point? You
> want to respin it?

It was a reply to Stephen. :-)

-- 
With Best Regards,
Andy Shevchenko



