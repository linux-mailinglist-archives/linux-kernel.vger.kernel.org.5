Return-Path: <linux-kernel+bounces-9713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A3681CA18
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 13:39:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EFFFB2244D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58BA3182AA;
	Fri, 22 Dec 2023 12:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fw2tCvjq"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7375F1805E;
	Fri, 22 Dec 2023 12:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703248783; x=1734784783;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4jzU/jOI7fcuTOLcNvkWp28yln/orfWdR4vIx47zvaM=;
  b=fw2tCvjqN2+jKslhF18/Z+52QGQa1dI1ktdk0Oq9KN0XqJdWxQFfUNfK
   GrokKCPxtikZWU3k6JscCIsB+1LsCEQ/Frql+NWOqsVv3fbkPpNX5k4y2
   T7NPcm52Am/jQr53SQD0liGQum+oQhDefz2rVzhmrDWCa98K4UEsbIO4p
   zvFM3oV4PwU0AxeFfxExkCEZ+6wEdO/3I7mHziafXRsnUtEHjB2o6cIxy
   /+i0RQkTI3I21qTThxC4Mo9PpGvWR4xiM2GdveZFs/wTSuqOgF8yaGJPD
   Sgyg/spukaY3JAYrcTEjSKASbIB2jctyzcpOZud4mtqJFWGRU9hjT0E2E
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="3196402"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="3196402"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:39:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="950265472"
X-IronPort-AV: E=Sophos;i="6.04,296,1695711600"; 
   d="scan'208";a="950265472"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 04:39:41 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rGeoU-0000000890A-2iUd;
	Fri, 22 Dec 2023 14:39:38 +0200
Date: Fri, 22 Dec 2023 14:39:38 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kent Gibson <warthog618@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Subject: Re: [PATCH v1 1/1] gpiolib: cdev: Split line_get_debounce_period()
 and use
Message-ID: <ZYWDij-J1YruTIM7@smile.fi.intel.com>
References: <20231221175527.2814506-1-andriy.shevchenko@linux.intel.com>
 <ZYTihbWMcHMHSkC_@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYTihbWMcHMHSkC_@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Dec 22, 2023 at 09:12:37AM +0800, Kent Gibson wrote:
> On Thu, Dec 21, 2023 at 07:55:27PM +0200, Andy Shevchenko wrote:
> > Instead of repeating the same code and reduce possible miss
> > of READ_ONCE(), split line_get_debounce_period() heler out
> > and use in the existing cases.
> >
> 
> helper
> 
> Not a fan of this change.
> 
> So using READ_ONCE() is repeating code??

Yes. Because one may forget about it.

> Doesn't providing a wrapper around READ_ONCE() just rename that repitition?
> What of all the other uses of READ_ONCE() in cdev (and there are a lot) -
> why pick on debounce_period?

Because you have a setter, but getter. Inconsistency.

> The line_set_debounce_period() is necessary as the set is now a
> multi-step process as it can impact whether the line is contained
> in the supinfo_tree.  The get is just a get.
> 
> And you could've included me in the Cc so I didn't just find it by
> accident.

Maybe it's time to add you to the MAINTAINERS for this file as a designated
reviewer?

-- 
With Best Regards,
Andy Shevchenko



