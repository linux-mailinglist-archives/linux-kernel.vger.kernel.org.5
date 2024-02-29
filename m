Return-Path: <linux-kernel+bounces-86594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2F386C786
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 11:58:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA0411C22CC9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 10:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F74E7A73F;
	Thu, 29 Feb 2024 10:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kUj+VfAm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A4B7A711;
	Thu, 29 Feb 2024 10:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709204324; cv=none; b=nuBZ/E3DE39wk9CWuBzR60jkKnULJdf8wzH7JUuE+ps1ViE3FS28M7nZhnOl9bqjuC7R/LyGH6LG/30rkMrJWzVlKV5K2WQvg8evRtoJlS8a0iIU/b/LiHcVGhzI1vV0wYLR0IS5UKysl5DAX2PptFAw2SgKgf1l4H6qwkAxwwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709204324; c=relaxed/simple;
	bh=a/GVLuUrTUXA8L8R4irxd4Al3SblyPKMDzQJ/K5AMdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=olQreu3zqGt3okfhdBRE6c1p5XlzPZ/mBAJ99Cvd6aRMoEpwhyDHYlBKQNnNfaXXtOvAujQ5iihY2pq7aXtn8g004bhi+sTwUyqh/HP45qUZX4xM3SJiNPcsQhoyOY6gTa+T+pT/Sqkdkp7dOUOyKWEYN3uIBNDgzr7jNmlIeQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kUj+VfAm; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709204323; x=1740740323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a/GVLuUrTUXA8L8R4irxd4Al3SblyPKMDzQJ/K5AMdE=;
  b=kUj+VfAmaHPr/JlpAtOiJqtmIqvb+M7gz2ENHVlNjyRqxyyxaGq26U/+
   KF3jI826whARDXQrq7PEhquUSAyZgdeAWc5aDRieDKe8wZRS59W0Jd6k3
   5Y77Npxg0XPif0djlBxIFRiJff/j90KNdhk7biVuyVhs6PXZ/8ko4E1Vq
   ftGXlSJgx3KoHMYnEg12HTb4TfQraCd2tD4gBSYSeWYOCaD3CJUZJi37f
   UBXUW4Ozaj9f/X2n5YuWmOSepd1CQ9DTMHae/Szhw3sey1yj135X+iTn7
   uZtnChZMNDuULr/cTJgoJ1YaarSAbnH0IoUwfNFrl9FfgI43bNV1sumZB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3789902"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="3789902"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:58:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="913979058"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="913979058"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 02:58:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rfe7Z-00000008eCZ-1cLi;
	Thu, 29 Feb 2024 12:58:37 +0200
Date: Thu, 29 Feb 2024 12:58:37 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-gpio@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2] gpiolib: Pass consumer device through to core in
 devm_fwnode_gpiod_get_index()
Message-ID: <ZeBjXfKH_Wl2Giai@smile.fi.intel.com>
References: <20240223065254.3795204-1-swboyd@chromium.org>
 <Zd-CJHkCHpuIEnWh@smile.fi.intel.com>
 <CAMRc=Mdapd2jTACGqm-ujZrAunRmNeJ8_3+bpsN4ieCre52yrg@mail.gmail.com>
 <Zd-nI9XoYW3hrPXx@smile.fi.intel.com>
 <CAE-0n52cgFvaHPDLBd-cn0WMisxX41-fPJHkroTucxHNk39SZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-0n52cgFvaHPDLBd-cn0WMisxX41-fPJHkroTucxHNk39SZQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 28, 2024 at 01:38:54PM -0800, Stephen Boyd wrote:
> Quoting Andy Shevchenko (2024-02-28 13:35:31)
> > On Wed, Feb 28, 2024 at 10:28:07PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Feb 28, 2024 at 7:57 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:

..

> > > > Have you seen this?
> > > > https://lore.kernel.org/r/20231019173457.2445119-1-andriy.shevchenko@linux.intel.com
> > >
> > > Clearly yes as I queued the first one in that series. The rest did not
> > > make its way upstream for whatever reason. What is your point? You
> > > want to respin it?
> >
> > It was a reply to Stephen. :-)
> 
> I saw it but it hadn't gone anywhere for many months so I fixed the
> problem I saw. Will you resend it?

Yes, this is the plan, too many things are ongoing, so have had no time (yet)
to address comments and resubmit. In any case I'm not against your change, it
makes it better anyway without hacking the code.

-- 
With Best Regards,
Andy Shevchenko



