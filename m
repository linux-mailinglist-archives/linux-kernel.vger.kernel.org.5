Return-Path: <linux-kernel+bounces-8723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5745181BB81
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9BE4B229A5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2055E5D;
	Thu, 21 Dec 2023 16:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fW2oFWnM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4EE539F3;
	Thu, 21 Dec 2023 16:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703174915; x=1734710915;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ht2da222gkdrScCbMu4NEKmjUDgWThAi8y/EPds7Zrs=;
  b=fW2oFWnMqAHHsxNkZDzRKrGxu3EGAjupGf3pFEmiV27gLX3j/b1cQ5nj
   pSxC2UB6jZ2iid0Z4cj+o6Q1k3BjFBcPCrcKfApWkQS6VHSChZR7cBfep
   IKqL2AvDoKSFw/Zqn69y/YUdnLUx6WlSM+ZMCOZJq3bKuBkmMIT1SXdrp
   kBlNL/IphiW7IOjvsF/CEICqw1gjzNUZNso2oLB9adsLnqRY8huErZDA+
   m/KIoELTVxQBSEh+XP1bU7pMHxkfvcBeiIvDWo6iXMLkgIuNZQfRH+AqN
   ePw/MBIJ3496Leu3gENkHTjjqoc2OXzBZNeg8yZqj3LKvXDbBeThGvZrY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="2827900"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="2827900"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:08:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="1023900990"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="1023900990"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 08:08:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rGLY2-00000007tEd-2Dpc;
	Thu, 21 Dec 2023 18:05:22 +0200
Date: Thu, 21 Dec 2023 18:05:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Hugo Villeneuve <hugo@hugovil.com>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, jringle@gridpoint.com,
	kubakici@wp.pl, phil@raspberrypi.org, bo.svangard@embeddedart.se,
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>, stable@vger.kernel.org,
	Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH 02/18] serial: sc16is7xx: fix invalid sc16is7xx_lines
 bitfield in case of probe error
Message-ID: <ZYRiQpt56IVYhwOg@smile.fi.intel.com>
References: <20231219171903.3530985-1-hugo@hugovil.com>
 <20231219171903.3530985-3-hugo@hugovil.com>
 <ZYMK-l03S86Nw19I@smile.fi.intel.com>
 <20231221105639.17910de5e7d7a486834bd856@hugovil.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221105639.17910de5e7d7a486834bd856@hugovil.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Dec 21, 2023 at 10:56:39AM -0500, Hugo Villeneuve wrote:
> On Wed, 20 Dec 2023 17:40:42 +0200
> Andy Shevchenko <andriy.shevchenko@intel.com> wrote:
> > On Tue, Dec 19, 2023 at 12:18:46PM -0500, Hugo Villeneuve wrote:

...

> > Yes, this seems to be the correct one to fix the problem described in
> > the patch 1. I dunno why the patch 1 even exists.
> 
> Hi,
> this will indeed fix the problem described in patch 1.
> 
> However, if I remove patch 1, and I simulate the same probe error as
> described in patch 1, now we get stuck forever when trying to 
> remove the driver. This is something that I observed before and
> that patch 1 also corrected.
> 
> The problem is caused in sc16is7xx_remove() when calling this function
> 
>     kthread_flush_worker(&s->kworker);
> 
> I am not sure how best to handle that without patch 1.

So, it means we need to root cause this issue. Because patch 1 looks
really bogus.

-- 
With Best Regards,
Andy Shevchenko



