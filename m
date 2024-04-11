Return-Path: <linux-kernel+bounces-140402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 164AB8A13F2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93F4FB25A81
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D6D14B065;
	Thu, 11 Apr 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ItXuUV94"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C9D14AD0E;
	Thu, 11 Apr 2024 12:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712837085; cv=none; b=PXEzSerTNfPUowWZjoxPAZ66p5BKrji0FLoIiK+i17bsgwhQV4sxKMO8WAyKac4SbL4zIhnn3AxiVr8seHJ9k2oyqrWyncb4+/y8XBHuP7SApz+o1H5KBKyRfkGyLy7H/nSncd1pT7NWm83sRv6ppW0yARMJv/Nb89B38QBCHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712837085; c=relaxed/simple;
	bh=xTkF8wx7JBTmFK3mgmRAiHBZbcPnN27OP3J1vTmrxhI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XRMWAciv979Fxpvts8SDCIThfOGpR/WoMQFBWvcc3EdhbmZhbipAF+CTlNxCk3W8sRHACaq8zdIst5rvbpx9ehB++9Xy7x3woMWDgTKXin0BpwFlxEBelP701xJhb3yjnuzUz71Ekvhq87ArBXBgMVxruDSsr6gDEiquaFA+Crc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ItXuUV94; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712837084; x=1744373084;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=xTkF8wx7JBTmFK3mgmRAiHBZbcPnN27OP3J1vTmrxhI=;
  b=ItXuUV94o1tq0Bc2sModz7zMmbSR1Wz/SG2O7wwAzelWDHSHRG8GShwg
   OIvEnWKvhnanaExAmrtGGKN0G0o1zwrcF/DZjOEI8uxcMHTZxEktr6oHx
   4JmGfIRWvGC2VUV05+DI2ncCYVm1ImA31L/TwdKMyBf18G6wgXP7dmGRJ
   BvnZNKsyjFhfxjpfYmZrN4BZ7QVE8Q63rho7l75de6YRm/SLRU9vGPqbR
   BAEc79QhIa+ejuSyDs+mOOu2+tcxZEdMNqYfPFtVuVXJXIUt1YE7+sRfC
   Gz3OLi7YhUy0YYd/tR/uqIwBZLdOWXRWev5cJY3FeXULlwtaiOA35dYWS
   g==;
X-CSE-ConnectionGUID: VEDatFd/Sq+VkObhLgbnRQ==
X-CSE-MsgGUID: bop0ol1+TeOisslIG0GDtA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8093915"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="8093915"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:04:43 -0700
X-CSE-ConnectionGUID: Ks/IUgP/QAKd3BhXy+A8GA==
X-CSE-MsgGUID: ARmyUGWSQl6RoziNKLSn0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="20954852"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO [10.0.2.15]) ([10.251.215.66])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 05:04:40 -0700
Message-ID: <97124d27-066d-4df3-99c6-e040c90c314e@intel.com>
Date: Thu, 11 Apr 2024 15:04:37 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] perf scripts python: Add a script to run instances of
 perf script in parallel
From: Adrian Hunter <adrian.hunter@intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, Andi Kleen <ak@linux.intel.com>,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
References: <20240313123634.4353-1-adrian.hunter@intel.com>
Content-Language: en-US
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
In-Reply-To: <20240313123634.4353-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/03/24 14:36, Adrian Hunter wrote:
> Add a Python script to run a perf script command multiple times in
> parallel, using perf script options --cpu and --time so that each job
> processes a different chunk of the data.
> 
> The script supports the use of normal perf script options like
>  --dlfilter and --script, so that the benefit of running parallel jobs
> naturally extends to them also. In addition, a command can be provided
> (refer --pipe-to option) to pipe standard output to a custom command.
> 
> Refer to the script's own help text at the end of the patch for more
> details.
> 
> The script is useful for Intel PT traces, that can be efficiently
> decoded by perf script when split by CPU and/or time ranges. Running
> jobs in parallel can decrease the overall decoding time.
> 
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
> 
> 
> Changes in V2:
> 
> 	Added option to pipe to a custom command
> 	Added option to set a minimum time interval
> 	Minor tidying

Any comments?


