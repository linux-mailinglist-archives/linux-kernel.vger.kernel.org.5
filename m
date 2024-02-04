Return-Path: <linux-kernel+bounces-51412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00090848AEE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B45B24B13
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3E01C13;
	Sun,  4 Feb 2024 03:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iUQldqP5"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7B615CC;
	Sun,  4 Feb 2024 03:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707018504; cv=none; b=Z0kQHRsPROUhDG8TGO+TtU/iynEW6vMz8nt4zMElmecT3D0i67uynO2DUJY0ev8rYIaXCT8FgcU/8rM72G3cU0HCj9oAnsCTvkJyo1cir/1FQjO/LdfbZq77hGfJHmiKnZqfoXbPWmxgAoJc/Kx99TXQ2bwKbpNWli5xg2W5zs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707018504; c=relaxed/simple;
	bh=aWUUDbYgtXEX3hNwoMIeTjKsd7fMGS91gppBgCBu6d0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RD18LDFDkGQH9n9CdJzEw452CMRPJrAm2i/JPo/tF49zt+7/Cr6fCSVENa+vjPGzkmzIMHjpbAWfU+ahPk18zVRdPaB/ST1M++oS2TbLF8DtTNC8lHqutft/sZyNHDZMyFOMMDi06jUjsdyuaXwh7TMu9KPQ8V9Jb3ZT6drr5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iUQldqP5; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707018503; x=1738554503;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aWUUDbYgtXEX3hNwoMIeTjKsd7fMGS91gppBgCBu6d0=;
  b=iUQldqP5IDIE3/UMj18dV+QZ1O7O8GFcsre35N04NCs9CIDO8nyfbult
   hQ8gFJZzJpnee9MkXHQfhuwBF9ti9mgMioeMwCwVjWbGkSphunO1B/9hB
   7FjAKBiWkVMJJS4co2uphp/kM/mn4htXmYzODncz1IS+S5AP649M1Ujrq
   PYA3nJ44klfopohrITv5NuLwiTiJ9GYJTPm8OsY0zIISgowLIUloJpqOP
   hq3jFoEXn55YfnHgXUgENnfFbYOy2ezFuM169KBOo7c4t8ulPvbZIEvKF
   5RWl7ctbYX9AfOTpQF7U7gxFbspFXx8aELEDTsT3r2pPsyCxrdJ5/VMiF
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="4253219"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="4253219"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:48:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5014054"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:48:22 -0800
Date: Sat, 3 Feb 2024 19:49:41 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: Borislav Petkov <bp@alien8.de>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <len.brown@intel.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	Zhuocheng Ding <zhuocheng.ding@intel.com>, x86@kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	Zhao Liu <zhao1.liu@linux.intel.com>
Subject: Re: [PATCH 7/9] x86/cpufeatures: Add feature bit for HRESET
Message-ID: <20240204034941.GB26316@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-8-ricardo.neri-calderon@linux.intel.com>
 <20240203093622.GAZb4JFuKt9U6PRfBd@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203093622.GAZb4JFuKt9U6PRfBd@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sat, Feb 03, 2024 at 10:36:22AM +0100, Borislav Petkov wrote:
> On Fri, Feb 02, 2024 at 08:05:13PM -0800, Ricardo Neri wrote:
> > diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> > index 8104f4791abd..3b42479c049d 100644
> > --- a/arch/x86/include/asm/cpufeatures.h
> > +++ b/arch/x86/include/asm/cpufeatures.h
> > @@ -326,6 +326,7 @@
> >  #define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
> >  #define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
> >  #define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
> > +#define X86_FEATURE_HRESET		(12*32+22) /* Hardware history reset instruction */
> 
>   #define X86_FEATURE_HRESET		(12*32+22) /* "" Hardware history reset instruction */
> 
> unless this really needs to be visible in /proc/cpuinfo:
> 
> Documentation/arch/x86/cpuinfo.rst

Good point. There is no need to expose HRESET in /proc/cpuinfo. I will
implement this change.

