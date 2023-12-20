Return-Path: <linux-kernel+bounces-7110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF6C81A1C3
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 16:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE0FF1F21D29
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 15:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDDD3E466;
	Wed, 20 Dec 2023 15:02:06 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B4F3D97C;
	Wed, 20 Dec 2023 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3044485"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="3044485"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:02:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="920005433"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="920005433"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 07:02:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rFy1q-00000007ZA3-1w1S;
	Wed, 20 Dec 2023 16:58:34 +0200
Date: Wed, 20 Dec 2023 16:58:34 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, brgl@bgdev.pl,
	linus.walleij@linaro.org
Subject: Re: [PATCH 2/4] gpiolib: cdev: allocate linereq using kvzalloc()
Message-ID: <ZYMBGrlY3mTWhKVv@smile.fi.intel.com>
References: <20231220015106.16732-1-warthog618@gmail.com>
 <20231220015106.16732-3-warthog618@gmail.com>
 <ZYL6gIpG5GBONVSO@smile.fi.intel.com>
 <ZYL_077xycZ0ZVBy@rigel>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYL_077xycZ0ZVBy@rigel>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Dec 20, 2023 at 10:53:07PM +0800, Kent Gibson wrote:
> On Wed, Dec 20, 2023 at 04:30:24PM +0200, Andy Shevchenko wrote:
> > On Wed, Dec 20, 2023 at 09:51:04AM +0800, Kent Gibson wrote:
> > > The size of struct linereq may exceed a page, so allocate space for
> > > it using kvzalloc() instead of kzalloc().
> >
> > It might be this needs a bit of elaboration. The kmalloc() tries to allocate
> > a contiguous (in physical address space) chunk of memory and with fragmented
> > memory it might be not possible. So the above issue might (rarely) happen.
> > In most cases the call to kmalloc() will succeed.
> 
> For sure, the kzalloc() generally works - or we wouldn't've gotten this
> far as tests with MAX_LINES would've been failing.
> We are targetting a very niche failure mode here.
> 
> The size allocated can only be determined at runtime, may be more or
> less than a page, and we don't care whether the physical memory allocated
> is contiguous.
> As such kvzalloc() is the appropriate allocator.
> 
> Are you suggesting repeating the relevant sections of the
> kmalloc/vmalloc() documentation or Memory Allocation Guide as part of the
> checkin comment?

I suggesting to make clear in the commit message that:
- there is no bug per se with the code logic (i.o.w.
  there is no issue to have allocations bigger than one page)
- this is very rarely case when it might be a problem

You can also put a reference to the documentation, if you wish.
This should be harmless and adding not more than a line into
the commit message (or even as a Link: tag to the HTML variant of it).

-- 
With Best Regards,
Andy Shevchenko



