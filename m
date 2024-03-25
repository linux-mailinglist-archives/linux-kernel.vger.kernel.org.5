Return-Path: <linux-kernel+bounces-117085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B64E88A6D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:36:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF2D71F62999
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D2B1304BD;
	Mon, 25 Mar 2024 13:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MyDb3BtA"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1805584D1B
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371958; cv=none; b=qHLyCKGf0ZxOpoqvcIfYoJlNkwKn6dfut1Yw6plE4b/xJDe3VATflDQ8iXPEZzxBiMoBIXxsT4U2sjMMHergioCRohaIKv/4K4T1H3th1ryjEbUzyie6NwE4ndEazaHro1uFQzpgm/kpoYVDTgsHG1HlN3C5aMcsQR3AX+Ua04A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371958; c=relaxed/simple;
	bh=0jy18Hu8o5WScUcgqk/t5XiNGY9l+KJGLuQ1Wb2fHz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5HAcSGH2rbryREQcmaI+8+J2vbX/cgrrLu3poN2Qxmr+2KIzw0kCraQy9bg1exju6LW9FVXiINcTfa7xdGX3vD5SCYy1FwRkPz+ApoNjGC6oJZ2Lb3SmmhH9QGN4QBK/ncZ3ZUA8SFn2ZBoPCRgo2iJ4YcRy7iiqYvD0F8JU7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MyDb3BtA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711371957; x=1742907957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0jy18Hu8o5WScUcgqk/t5XiNGY9l+KJGLuQ1Wb2fHz4=;
  b=MyDb3BtAY/bPekSsRQuTiSpsRys1v7Vg7CEwWkfx56JE9AVb/y3lJqn/
   S5dRRi+H/Uct4jjhkyY3/rAD04MPAH6NwbYxN93IXi5K3L8/XEgqUbYte
   LXXBgekJu6GZWN34vur5zowa13WRhnsBLSCFVr5lv8K9LA7pQwG2yB9rS
   3uYB3KsYKTCXAAWQGeGmgoNKx2XG9r9Ad+BQWbNAeT01Qe4WEaa3lDwRy
   7dPZqtVFue/7eAFN2IJrXnCWuckmT/HzOZv5APSJlWIL6G/pONB5t2kU7
   fkgCm8BUpBuZEW051ELr2tsd7ToTQ7iCSW/USPx+FPXRhXShrBKhxDIm+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="10164785"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="10164785"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:05:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="914842940"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="914842940"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 06:05:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rok0x-0000000FzB8-1WtD;
	Mon, 25 Mar 2024 15:05:23 +0200
Date: Mon, 25 Mar 2024 15:05:22 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/35] Fast kernel headers: reduce header dependencies
Message-ID: <ZgF2khndC_QTu5Bw@smile.fi.intel.com>
References: <20240209164027.2582906-1-max.kellermann@ionos.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240209164027.2582906-1-max.kellermann@ionos.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Feb 09, 2024 at 05:39:52PM +0100, Max Kellermann wrote:
> This patch set aims to reduce the dependencies between headers, in
> order to have cleaner code and speed up the build.  It continues
> previous efforts by other developers.
> 
> As a preparation, the first patch adds "#include" directives to source
> files that were missing previously, but due to indirect includes, this
> was never noticed.  After the cleanup, many missing directives would
> result in a compiler failure.
> 
> The second patch removes superfluous "#include" directives, some of
> which may be a leftover from refactoring patches.
> 
> The third patch replaces existing "#include" directives with narrower
> ones, e.g. use "spinlock_types.h" instead of "spinlock.h".  This
> continues the work others have done over the years.
> 
> The remaining patches add new "XXX_types.h" headers with lighter
> dependencies.  They have only basic struct/enum/const/macro
> definitions and maybe a few trivial inline functions, but no "extern"
> functions and no complex header dependencies.
> 
> Just like the other attempts to reduce header dependencies in the
> past, this is just the beginning.  There are still too many
> dependencies, and the speedup gained by this large patch set is not
> yet impressive.
> 
> Prior to this patch set:
> 
>  real	0m34.677s
>  user	23m13.045s
>  sys	2m26.007s
> 
> With this patch set:
> 
>  real	0m34.464s
>  user	22m19.073s
>  sys	2m15.246s
> 
> (Building the directories kernel,lib,mm on ARM64 "allyesconfig".)
> 
> I have tested this patch set with:
> 
> - ARCH=arm allyesconfig
> - ARCH=arm defconfig
> - ARCH=arm64 allyesconfig
> - ARCH=arm64 defconfig
> - ARCH=mips defconfig
> - ARCH=riscv defconfig
> - ARCH=x86_64 allyesconfig
> - ARCH=xtensa defconfig
> 
> Pretty sure, other architectures may fail to build, but before I test
> all of them, I'd like to get some feedback on whether my approach
> would be accepted.
> 
> For more gains, huge headers like "linux/mm.h", "linux/fs.h" and
> "linux/sched.h" would need to be optimized.  Nearly everybody includes
> them, and they include nearly everything.

Are you going to pursue this (with probably refined kernel.h approach
as we have Ingo's patches and an additional split that is already in
the upstream)?

-- 
With Best Regards,
Andy Shevchenko



