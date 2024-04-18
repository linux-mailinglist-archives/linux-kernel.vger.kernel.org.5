Return-Path: <linux-kernel+bounces-149787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C12E18A95DF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 11:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5020FB21AC4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 09:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75A415AD87;
	Thu, 18 Apr 2024 09:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJ9tXmlW"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4EE158209;
	Thu, 18 Apr 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713432082; cv=none; b=AcX5ULcC/R+RqWXCn8f6vZbll2JYSTIZL4d+VBiotV5TLENX8o1sZyd1ij/kd0AukUC6hMMkfCIkBog8xWeTiGNAmWiz93ycccue5ezV5WfQK96vlYM0ddr4E3sr4kRxEHTAwawLeO9UMOz5ClGrH8dXbGZncMfZx5qRGnkHoLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713432082; c=relaxed/simple;
	bh=IlWNze6ctzdm9JLeCil+Nc1IfJcqrJwNQIEEI1aqgFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UiCtFHKPeccLfXGwe3Yq9LblLdVEpNds3C4GHcCx0jRbDFbd/jcBPrF2vXlcWesGQqkAPIlWmlR2fKXmvQlgGf1TXnsN9vmtInXmF7p+aJ1oWVP3926Yb9RAQOCevaZ8eYwGMwwdVuNyF2RfCKQ/yYP4cC+o2gfYcrq6uxJYQNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJ9tXmlW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713432081; x=1744968081;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=IlWNze6ctzdm9JLeCil+Nc1IfJcqrJwNQIEEI1aqgFU=;
  b=OJ9tXmlWEwFoNJM+Gm7V5ORsONLFbvOiH9g1163aQueM4i/UCxFXrRvD
   vAmtTev2dQe/QfqtAy9iH1zyzk0bPcmAubeDfasI7hXJJ9vCfU0WuUS1f
   OcdNwClBvrHcGMTMcLAhdCN510jBwwuDoSmNNB50Es0ZNR59cUvbErHjE
   BwRQCdGK4f9+NfiJeWE4dbCScTRBzSOJuQ3pBC3h8j7x41QrnumbV33z0
   GmPCMRG9wRVW3ujemX78q5W+m4FKsDcEPiY+FUJ2KTH+n60QJjV71yMIX
   GiJzc8YoFI0CqdcnEY1Sl6VN3VZnat/3wQVylvKq9fw9Sna415UHA6BUV
   Q==;
X-CSE-ConnectionGUID: 4CLwjnFYR6CdQWit9KbqTg==
X-CSE-MsgGUID: cbu0OmHER/6sDQzIuq67Dg==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26426464"
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="26426464"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:21:20 -0700
X-CSE-ConnectionGUID: a+X8M6xzRQSUoBAkrngLEQ==
X-CSE-MsgGUID: nmZY6+VJRy26bH1rmSBdaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,211,1708416000"; 
   d="scan'208";a="27495996"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2024 02:21:17 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rxNxD-00000000HVC-1qwy;
	Thu, 18 Apr 2024 12:21:15 +0300
Date: Thu, 18 Apr 2024 12:21:15 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [rfc, PATCH v1 1/1] gpiolib: Get rid of never false
 gpio_is_valid() calls
Message-ID: <ZiDmC1uF0S73SI9f@smile.fi.intel.com>
References: <20240221213208.17914-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=Mfh-ojboNUELXfszKUbZRfeZn9vsN-HMTdMQv6my6ZrdQ@mail.gmail.com>
 <Zh-oku-XzpcH_8FH@smile.fi.intel.com>
 <CAMRc=MfO_7smzcG2+FM2EHNb1FbqS7PbfJuzBH6gL6KXT2fVUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfO_7smzcG2+FM2EHNb1FbqS7PbfJuzBH6gL6KXT2fVUQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 17, 2024 at 10:47:23PM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 17, 2024 at 12:46 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Feb 27, 2024 at 02:06:05PM +0100, Bartosz Golaszewski wrote:
> > > On Wed, Feb 21, 2024 at 10:32 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > >
> > > > In the cases when gpio_is_valid() is called with unsigned parameter
> > > > the result is always true in the GPIO library code, hence the check
> > > > for false won't ever be true. Get rid of such calls.
> > > >
> > > > While at it, move GPIO device base to be unsigned to clearly show
> > > > it won't ever be negative. This requires a new definition for the
> > > > maximum GPIO number in the system.
> >
> > > > ---
> > >
> > > It looks like a risky change that late in the release cycle. I want to
> > > avoid some CI problems at rc6. Please resend it once v6.9-rc1 is
> > > tagged.
> >
> > Not sure why resend, but I missed that somehow. Can you consider applying it?
> 
> Applied, thanks!

Thank you!

I have grepped the kernel sources for these use cases:

  $ git grep -n -C6 '= devm_gpio_request([^A-Z]'
  $ git grep -n -C6 '= gpio_request([^A-Z]'

to see how many users might not have checked the validness of the GPIO before
passing to gpio_request(). All what I found is something like ~10 drivers.

They are basically in the risk category of my change.

Another risky part that touches everybody is the base finding algo.
I spent quite a time before sending this patch and looked at it again
to see if there is any potential flaw, but found nothing. Hopefully
we will see no reports or many and sooner than later while it sits
in Linux Next.

TL;DR: the above is a note to be in archives just in case.

-- 
With Best Regards,
Andy Shevchenko



