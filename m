Return-Path: <linux-kernel+bounces-155803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A3BC8AF754
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 21:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D948028FC71
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 19:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FB01419A1;
	Tue, 23 Apr 2024 19:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cudp1Usa"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B316F140378
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 19:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713900578; cv=none; b=AVuAWELCtYCaRjm1tXFb/thenh5f/VzVxNzIpjEYTeeBZygCt/PIVMNxEr0nxpcluWdmvcfGabjs6AcJtAsU503UpLBNqFnOh7qxf6vnc8SnVfXVTPDeqEwnhhMIOLS8t6x/9VWJ9iyulIv3wT/HgUCQ1E0sQzQFXsAjznvK4MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713900578; c=relaxed/simple;
	bh=N7xqgdyUBrU4OycirH8PRTFXCp+RXcCHK7+gXzGrhe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IByqz9OS1W5mxPL4YJq8k/7x98ZumSHPPRlOu1Lb4ABqnvXr+HN31HHXhOYA4qzJp3BNuTDFTLz4a61T3N9Sak0NzlsDIFLqoVkeJrWDuk/Zonf3oSfdsey5D+JV/rrpUGRhv8Y1Elo6I2MnUqQTOpPNxV6YVbbzF4qPPvaZS7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cudp1Usa; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713900577; x=1745436577;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=N7xqgdyUBrU4OycirH8PRTFXCp+RXcCHK7+gXzGrhe4=;
  b=cudp1UsaGccMzWzi8vWxCuwENDCRzOGVkIbWPnnawhPe+pXuOWeAmQjN
   Yeht+eRul2QYBGSuVN6gATp13fttGnX8nBP+wS+fmT5S2txzGFt1M444J
   XR4DURxQ7pKrM328h7L2JJwy/ryId0qO0NpQVcCwXGg+P29hyUL8/Ytmj
   nvSE/Z+QFM1nVfrdZOBdeDvexgwxuacKqFnYHncrzI0BZQ1QHF1hiUN3p
   p04103SjzXpGkN27WlSSA6cOKfru56fNNeRSCi4pkl1hljDihSmJ3bozI
   l37541KGax7d/XHaRvht0SsWsuIzn6zm9NvwREYivLZjwiCa02yJkgeg1
   Q==;
X-CSE-ConnectionGUID: HmcxbZs1SkWBmQ6ceawtNg==
X-CSE-MsgGUID: s93b5d0sRp2s/Gxb97rFDQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20200632"
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="20200632"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:29:36 -0700
X-CSE-ConnectionGUID: KFNWnypfQp6128Pbl5Mpsg==
X-CSE-MsgGUID: uHB1geUFT4eaWHuLlOyZ+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,222,1708416000"; 
   d="scan'208";a="24509950"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2024 12:29:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rzLpb-00000000RvJ-2ReU;
	Tue, 23 Apr 2024 22:29:31 +0300
Date: Tue, 23 Apr 2024 22:29:31 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: linux-kernel@vger.kernel.org, Willy Tarreau <w@1wt.eu>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: limits.h in tools/
Message-ID: <ZigMG8ZsBryO57zz@smile.fi.intel.com>
References: <ZigEvxn0-70og0H1@smile.fi.intel.com>
 <ZigKWZKY6kq-w0Tp@x1>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZigKWZKY6kq-w0Tp@x1>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 04:22:01PM -0300, Arnaldo Carvalho de Melo wrote:
> On Tue, Apr 23, 2024 at 09:58:07PM +0300, Andy Shevchenko wrote:
> > It seems tons of the code in tools include linux/limits.h. But I haven't found
> > where do we copy it. Any pointers?
> > 
> > Based on the discussion 20220603183231.15159C385A9@smtp.kernel.org.
> 
> ⬢[acme@toolbox perf-tools-next]$ diff -u /usr/include/linux/limits.h include/uapi/linux/limits.h 
> --- /usr/include/linux/limits.h	2024-01-31 21:00:00.000000000 -0300
> +++ include/uapi/linux/limits.h	2024-02-03 16:18:02.652000641 -0300
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> -#ifndef _LINUX_LIMITS_H
> -#define _LINUX_LIMITS_H
> +#ifndef _UAPI_LINUX_LIMITS_H
> +#define _UAPI_LINUX_LIMITS_H
>  
>  #define NR_OPEN	        1024
>  
> ⬢[acme@toolbox perf-tools-next]$
> 
> And in the places where I test build perf I saw no problem so far, the
> build failures below are unrelated, but still outstanding, see below.
> 
> But then is for building tools/, not the kernel, right? The discussion
> you said this question was based on is about changing
> include/linux/xarray.h, a kernel file, so should really be including
> just kernel headers, files in the kernel source tree, outside tools/, I
> don't see where what tools/ uses to build is relevant here? Can you
> please elaborate?

I believe the tool in question is tools/testing/radix-tree/xarray.c.

-- 
With Best Regards,
Andy Shevchenko



