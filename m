Return-Path: <linux-kernel+bounces-59399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A47684F659
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAD171F27FAD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8B952F8B;
	Fri,  9 Feb 2024 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SI+2ojvZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225D845BE2;
	Fri,  9 Feb 2024 13:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487185; cv=none; b=fqeK2ftg6umXQ593ojKP4z4HXEbwqIXPtHx8++lEAXC2zoddgnzlpUFkuhLhw1sMoij4slsK3CBItmzBhVcHTknJH+9lV72cSYf0+4tJjSyv6/1eP85ozUQVDRjQ8IwVFGJiK8/dpVrFmt3wu3rEGgmuzErS3yx9dfe93lMp11c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487185; c=relaxed/simple;
	bh=XaY/Kz2A2Fwa93L+UssnP2qdVGISIQcm0HgemWEekMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DANLDZngS5kQ4JV6UELKma2rmvY63XAB/4tFKclRsTGE7TPZqXNRPyWvujcFVbxx92KmTzgS/HDARQpTLtzsdEmYXwoyK9H+cRaMc/NnBInaJAcA9AKW9j80/RylzC2ENiuZhQQIh9/9U9bCNUnn5kYFmB6Hzd1ufdIbVxYlraM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SI+2ojvZ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707487184; x=1739023184;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XaY/Kz2A2Fwa93L+UssnP2qdVGISIQcm0HgemWEekMU=;
  b=SI+2ojvZzzOjA1yG+TRhxNimonODGipUGfZWe8zDp7P25u/zqx1GKHiE
   G/x3lbdd+xClgvjXTiuHT/bAjSXyqrDibD2TfKL8QYc30Ne6Qw/hVTqgo
   WtIXyrnAIfTh+O58eUaUg/e5Bzpk5+RZSqc0pwDU7GaonXRGz0PBZbcpC
   86Bo8BXCPVX9Z8gjXk1jAvibbDH4S/UmBNzgym54V+/y0OMvXBm3hhhPx
   Velh3qmKASwyZbwKovr45EDbQJWBy5mlag+VFe7fGdWACDUFUyUM5Bg2F
   sWu6JFQ1QErlzf+cDK1Y2++Clxi38UcSfsMwKsbVZH/PK/mmXr4tgUWNx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="23910814"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="23910814"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:59:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="910715481"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="910715481"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 05:59:40 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rYRPm-00000003AJZ-00RS;
	Fri, 09 Feb 2024 15:59:38 +0200
Date: Fri, 9 Feb 2024 15:59:37 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Wolfram Sang <wsa@the-dreams.de>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 19/24] gpio: remove unnecessary checks from
 gpiod_to_chip()
Message-ID: <ZcYvycJ9wXfKIGYg@smile.fi.intel.com>
References: <20240208095920.8035-1-brgl@bgdev.pl>
 <20240208095920.8035-20-brgl@bgdev.pl>
 <ZcURtLZoEftBDpsy@smile.fi.intel.com>
 <CAMRc=MdaxrjKVoBe92ci+4U-VbxyuxMVu30-m2E3My0k7KN65A@mail.gmail.com>
 <ZcUqWy34Z_QGutNn@smile.fi.intel.com>
 <CAMRc=Me75F3KmTJbiNZKXNpwU0a_fSd3UffWORwXzDLKAMcXag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Me75F3KmTJbiNZKXNpwU0a_fSd3UffWORwXzDLKAMcXag@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 08, 2024 at 08:34:56PM +0100, Bartosz Golaszewski wrote:
> On Thu, Feb 8, 2024 at 8:24 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Thu, Feb 08, 2024 at 08:17:14PM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Feb 8, 2024 at 6:39 PM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Thu, Feb 08, 2024 at 10:59:15AM +0100, Bartosz Golaszewski wrote:

..

> > > > > -     if (!desc || IS_ERR(desc) || !desc->gdev || !desc->gdev->chip)
> > > > > +     if (!desc || IS_ERR(desc))
> > > >
> > > > IS_ERR_OR_NULL()
> > >
> > > Ah, good point. It's a small nit though so I'll fix it when applying
> > > barring some major objections for the rest.
> > >
> > > > >               return -EINVAL;
> >
> > thinking more about it, shouldn't we return an actual error to the caller which
> > is in desc?
> >
> >      if (!desc)
> >                return -EINVAL;
> >      if (IS_ERR(desc))
> >         return PTR_ERR(desc);
> >
> > ?
> 
> Hmm... maybe but that's out of the scope of this series.

Yeah, but just think about it.

-- 
With Best Regards,
Andy Shevchenko



