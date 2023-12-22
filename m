Return-Path: <linux-kernel+bounces-9716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE38381CA21
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1556AB223D6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32FD1805E;
	Fri, 22 Dec 2023 12:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cy1EqYpX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8718624;
	Fri, 22 Dec 2023 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248865; x=1734784865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=7ZJveX1s7cgliTk+K43ko5ol4fPOQ4lq4WTKaVnm9yM=;
  b=cy1EqYpXh0BNY2Z+mDv0C5Psx864p6UHoA9Y/3kHPKowy2M47zn020SI
   O/AbkzDvEH9Eg62h71gCWFD1jGYojjMct+rm2R/dV1dow0N4VyhjSQFD7
   I+Z4EsLKSHT+5PVYMK2aWLXs+q5i2PpzokRMAdbo1T/tTr4116TRArknO
   Ty9XoCXXBI7Ux9+v6Ui2qWtJxXK76nuKdQD8XJXTTq2WNz1Lj9fIa57+T
   qmolHMiHQIHSFiNjW+oz0MWXGPigdsuaJdkHClN2DqfzGuCEy87HlnwNV
   0aPMr0t0WRtbDlS4ky7cUM78bmBdIoYyKedrPntAFYm0OPpF4EYpDIvWC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3196494"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3196494"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:41:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950265804"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950265804"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:41:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGepo-0000000891T-0eik;
	Fri, 22 Dec 2023 14:41:00 +0200
Date: Fri, 22 Dec 2023 14:40:59 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYWD26B-xQqiDOD2@smile.fi.intel.com>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
 <CAMRc=McSXrivkzhJVEh7-+1fzO6EBLMawhxYd7YgcsXW9wBKbA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McSXrivkzhJVEh7-+1fzO6EBLMawhxYd7YgcsXW9wBKbA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 09:58:48AM +0100, Bartosz Golaszewski wrote:
> On Fri, Dec 22, 2023 at 2:12 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > On Thu, Dec 21, 2023 at 07:55:27PM +0200, Andy Shevchenko wrote:
> > > Instead of repeating the same code and reduce possible miss
> > > of READ_ONCE(), split line_get_debounce_period() heler out
> > > and use in the existing cases.
> > >
> >
> > helper
> >
> >
> > Not a fan of this change.
> >
> 
> Yeah, sorry but NAK. READ_ONCE() is well known and tells you what the
> code does. Arbitrary line_get_debounce_period() makes me have to look
> it up.

We have setter, but not getter. It looks confusing, more over, the setter makes
much more than just set. Hence another way to solve this is make clear (by
changing name) that the setter is not _just_ a setter.

-- 
With Best Regards,
Andy Shevchenko



