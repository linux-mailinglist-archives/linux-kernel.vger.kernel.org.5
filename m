Return-Path: <linux-kernel+bounces-51414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C02848AF3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 04:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC5CEB2155B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 03:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521BD1C11;
	Sun,  4 Feb 2024 03:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XduU2Sx7"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC6B1C3D;
	Sun,  4 Feb 2024 03:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707018875; cv=none; b=CYamM+SRbtl/RRd6KdXW4JhsB6Itc+6xzG1U9EXPDLVRiCNu+xjVV+Fmw9tOzQT5N/PEcshPUKyJImHQWe3dkeathxGAfJi4NnnIyyGwgAFyKI83emaQWyquAWVYA8b8cD/WadOrYkwpoHT0lu3mYfik4Q3jJEyZnlHjlugUnY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707018875; c=relaxed/simple;
	bh=MbsFIpM7N+amsaNUWqQJtMZx6IckQhPTwMVERfrtk0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZMSNUxWrK/apiBJWu986Iat/1/U4jmph1TAN/OHeTZg1yL1YNL95cIihn6qt8D4M1YbSMu1N1Uh0fon9STz5z6ofxAPRO4vc/ejw+IyIpbOkHCLJFZ/b8APKEAYCbl7Pt4AWTJywDsdSJn0k87xjMhnWc7VvLvVdcBIn+FMph5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XduU2Sx7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707018874; x=1738554874;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MbsFIpM7N+amsaNUWqQJtMZx6IckQhPTwMVERfrtk0A=;
  b=XduU2Sx7KcW6R6SABvKCEwGKU1Vqh9z1q7h7y+DS+FlhnZqeKweY05ci
   IX9fG2WCfRl2azERXrrtpKIOD6cAvbpaS+7WaHB8QGE3mQjm2d7myYR4D
   c8PDbVxjYh31+TZS1xph+lwGe9fAEtLaxP2JHN54MJmYIBzxpiFCjZdSm
   6HoFjeT5DlsHjiDfOlnWlPVyKsWq4cgjgox9jbUm9jepKYCVwyCIGrsBO
   MNZDZaPnyqhB8CqEcZjY33yCNGWpdqLooJTGlnBePgQEwSOS7vEwOLVh2
   E+cQnDczjMQbvQkOjGtClwcOx8IhUAZIFvyD69yu2n6VNZAgiPM1ybsR1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10973"; a="536103"
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="536103"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:54:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,242,1701158400"; 
   d="scan'208";a="5173271"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2024 19:54:33 -0800
Date: Sat, 3 Feb 2024 19:55:52 -0800
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
Subject: Re: [PATCH 8/9] x86/hreset: Configure history reset
Message-ID: <20240204035552.GC26316@ranerica-svr.sc.intel.com>
References: <20240203040515.23947-1-ricardo.neri-calderon@linux.intel.com>
 <20240203040515.23947-9-ricardo.neri-calderon@linux.intel.com>
 <20240203093857.GBZb4JsahiDx2Ouegj@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240203093857.GBZb4JsahiDx2Ouegj@fat_crate.local>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Sat, Feb 03, 2024 at 10:38:57AM +0100, Borislav Petkov wrote:
> On Fri, Feb 02, 2024 at 08:05:14PM -0800, Ricardo Neri wrote:
> > +static __always_inline void setup_hreset(struct cpuinfo_x86 *c)
> > +{
> > +	if (!cpu_feature_enabled(X86_FEATURE_HRESET))
> > +		return;
> > +
> > +	/*
> > +	 * Use on all CPUs the hardware history features that the boot
> > +	 * CPU supports.
> > +	 */
> > +	if (c == &boot_cpu_data)
> > +		hardware_history_features = cpuid_ebx(0x20);
> 
> That's not what this does - that sets hardware_history_features on the
> BSP.

I meant to say that we will use the features that the BSP supports and
use them to configure all other CPUs. I will reword the comment to make
this clear.

> 
> Why isn't this whole thing called in bsp_init_intel()?

The register MSR_IA32_HW_HRESET_ENABLE needs to be configured on each CPU.

I can set hardware_history_features from bsp_init_intel() but I still
need to call setup_hreset() on every CPU.

