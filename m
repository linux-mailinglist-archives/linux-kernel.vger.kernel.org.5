Return-Path: <linux-kernel+bounces-8754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E4581BBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C2711C22DF0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9365C55E72;
	Thu, 21 Dec 2023 16:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XO0qnS8H"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C57258237;
	Thu, 21 Dec 2023 16:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703175608; x=1734711608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+LUViFjrhWFYO8ZP8kMqmQZazZVfADjajAChlASICpI=;
  b=XO0qnS8HmvHOXmpBXWf3stDlBCQR93JVPtK6j35OkKBAZJhw3rkiX5ay
   2OwFlXF+Fq/ymZ9+JTCZ5gfj6tKbd9pFQGQ7f3cwqme2aCPG3T93cPLDj
   46TD7yJ9cuERNTCPMnU2O/4Rvdu39GullLtsEet0HMlzZxSzayKOJqAXg
   xkjFBUGpWdXVdBnXXkxdq3mAuZ9gUSx3iqpmDW0znuk4CXcPDF4owHEDj
   6RgsfZhMtRgGXsygSRTFNtXA3yY2c/IamMQFMyjNxdqwBMIrmf8FTRxhD
   N217m6PIRAdaSXXRFxBKfPjKVTZpitWCojTH+nnm/5N76ZlSjTNc7bqJr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2829595"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2829595"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:20:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="805653548"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="805653548"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:20:03 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGLiy-00000007tMe-1CxJ;
	Thu, 21 Dec 2023 18:16:40 +0200
Date: Thu, 21 Dec 2023 18:16:40 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 02/18] serial: sc16is7xx: fix invalid sc16is7xx_lines
 bitfield in case of probe error
Message-ID: <ZYRk6NpuUJvVEmOZ@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-3-hugo@hugovil.com>
 <ZYMK-l03S86Nw19I@smile.fi.intel.com>
 <20231221105639.17910de5e7d7a486834bd856@hugovil.com>
 <20231221111337.2c1af5bbe4920268dac25e8f@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221111337.2c1af5bbe4920268dac25e8f@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 11:13:37AM -0500, Hugo Villeneuve wrote:
> On Thu, 21 Dec 2023 10:56:39 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> > On Wed, 20 Dec 2023 17:40:42 +0200
> > Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

...

> > this will indeed fix the problem described in patch 1.
> > 
> > However, if I remove patch 1, and I simulate the same probe error as
> > described in patch 1, now we get stuck forever when trying to 
> > remove the driver. This is something that I observed before and
> > that patch 1 also corrected.
> > 
> > The problem is caused in sc16is7xx_remove() when calling this function
> > 
> >     kthread_flush_worker(&s->kworker);
> > 
> > I am not sure how best to handle that without patch 1.
> 
> Also, if we manage to get past kthread_flush_worker() and 
> kthread_stop() (commented out for testing purposes), we get another bug:
> 
> # rmmod sc16is7xx
> ...
> crystal-duart-24m already disabled
> WARNING: CPU: 2 PID: 340 at drivers/clk/clk.c:1090
> clk_core_disable+0x1b0/0x1e0
> ...
> Call trace:
> clk_core_disable+0x1b0/0x1e0
> clk_disable+0x38/0x60
> sc16is7xx_remove+0x1e4/0x240 [sc16is7xx]
> 
> This one is caused by calling clk_disable_unprepare(). But
> clk_disable_unprepare() has already been called in probe error handling
> code. Patch 1 also fixed this...

Word "fixed" is incorrect. "Papered over" is what it did.

-- 
With Best Regards,
Andy Shevchenko



