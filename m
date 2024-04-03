Return-Path: <linux-kernel+bounces-129394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 04802896A08
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E410B2652A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F06076FE00;
	Wed,  3 Apr 2024 09:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fgezqj4l"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF146EB5A
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712135343; cv=none; b=AWErVC2tiDK9IQcnEPSY7ZOPoGHqoxIj9kTDcjm3rZQFk7JvqjmQfR/pip+a+x9AhiLBoYqTCpX534pGwHygjKKzY+4tU1a5Xx8hslshx9ic24AjjWjRg2FSiuhsgwSoj1J6VYEPAwveYFQLwH4z+aeo7c0CoEwtlWq4tMGpMhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712135343; c=relaxed/simple;
	bh=Yb9QyBiQXo7mWEPBE/uw2+O0Igsh+LJ2Gjdh7jHenow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qk5IVCrUqD17ApfcTx2hpLYEuw7OrkuwAuGIFV0f18IA4LpnmpYhliALYamyMv8i3hBGjMylkbL8iwimmOI+k7RLiiL7eHGcZiYyZ5gqbPlnVBGiyeslAVvaBnz4oQyFb9IhKOduFjbwmaWGTKrGu4gm7qdSr9VRscbyt3uwSwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fgezqj4l; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712135341; x=1743671341;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Yb9QyBiQXo7mWEPBE/uw2+O0Igsh+LJ2Gjdh7jHenow=;
  b=fgezqj4lrQMqUatGADlebsTNPvM+KtjejFFYIhPWD9iYp+SxVT1JAV68
   j7P88IaUj95M4avKw45jt4XsZwq2G1SU0miyMeio136nOcrgXW8gxsgUN
   4JqJPiRjxM44qm84kd5O6sYrDG9M4rokYDM/z8vrO+cWIgO2l8VtyV3jS
   TnbH8BZmG98ckxWtWoy9nyrvnxNukrvaGxQXoOUHvTOZt7wA1YD76lXPr
   097gr5Nc/DsIBnUtlxeOwqURaL1j6XWUvBQFoYPtBdCBHQwrhv3VkkoeX
   9AKm5Jv1UkzZrXUfNARy3bA4xH+GrSSr8fi8YFpeEgrVfMbLrviv9KnrJ
   A==;
X-CSE-ConnectionGUID: M0wZR0iFSCWGbceLBsK4rA==
X-CSE-MsgGUID: /2UH/cG/QEqEKrR/2oxbJA==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="7480766"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="7480766"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:09:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="915175140"
X-IronPort-AV: E=Sophos;i="6.07,177,1708416000"; 
   d="scan'208";a="915175140"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 02:08:58 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rrwc3-000000014Oy-414i;
	Wed, 03 Apr 2024 12:08:55 +0300
Date: Wed, 3 Apr 2024 12:08:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, Alan Cox <alan@linux.intel.com>,
	Jason Hu <jia-cheng.hu@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jin Qian <jinqian@android.com>, Arnd Bergmann <arnd@arndb.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 03/34] platform: goldfish: remove ACPI_PTR() annotations
Message-ID: <Zg0cpzfAl5dHZWlR@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-4-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240403080702.3509288-4-arnd@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 03, 2024 at 10:06:21AM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> On platforms without ACPI support, this causes a W=1 warning from gcc when
> the driver is built-in:
> 
> drivers/platform/goldfish/goldfish_pipe.c:925:36: warning: 'goldfish_pipe_acpi_match' defined but not used [-Wunused-const-variable=]
>   925 | static const struct acpi_device_id goldfish_pipe_acpi_match[] = {
>       |                                    ^~~~~~~~~~~~~~~~~~~~~~~~
> 
> There is no real harm in just keeping the small table around, so rather
> than adding more #ifdef checks, just reference it unconditionally to avoid
> the warning.

With this change you also may replace acpi.h by mod_devicetable.h. Please, also
check all other conversions that you may replace of*.h/acpi.h by a proper one,
i.e. mod_devicetable.h.

When addressed, this one
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



