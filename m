Return-Path: <linux-kernel+bounces-54000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D256584A903
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 23:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102CF1C25905
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812324D9E4;
	Mon,  5 Feb 2024 22:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O8391Xi7"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CA44D5A7;
	Mon,  5 Feb 2024 22:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707170853; cv=none; b=T4VZStqjjS57Vb/zy/zQ5knoUZ+p+fHBZmmM6tj709JNVOb7kMYdcP0qaJMyxKA6ltn4FmZEjsBT1qow1X/gV12D/0nLZk7r3wcQpIZ8cVcq4CregOzJmaNrII+mI+qwlFXHBLu2myGrAHePrtwU9x0kNjpsOylGuwXJx4oA2zQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707170853; c=relaxed/simple;
	bh=K8Wi9nbWh4scyBXEx/WRPqEifNVn6pTOX+L2VOPol0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbJMGt7JIbxfT9U0uLOIOQFGJyzFaAx9AMEc7dAZ69HKkJPSaE3FRlALOSkou9/+Nuif/4r4cNNq/68165oOgxXH48oAs1LZwyHAXYN6w97nYt/NFzK1bx+80G2R7OFnXMVgtUub5LlTEdmZPDL40GBzDZgsf0rA2oj9rjwr1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O8391Xi7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707170852; x=1738706852;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K8Wi9nbWh4scyBXEx/WRPqEifNVn6pTOX+L2VOPol0U=;
  b=O8391Xi7/SuRXbNwW2kggbghhBYcal0z6u90QnLTYBLgcH/Fw5i3hUW0
   7+8tdpHS4uVI/qNKoYCN0zGdGA285fKqawFoi+ItFctaS5dlrMpHtB7rY
   7zYUandL6odAxvzZUTIec0JzIu73ZHqYPvflLHMEYUUn/2Psy9FFRH9nB
   HtfxYAZGyRCKWTCOcHu+sofQ6697hKAybiGlVIRoxkBpfDl73Xn3uCCAJ
   81D7DTpJKMM1KdP8MIAnpDMahh7+sVMc4WNOVDESN6MPZdfyel1r64RHB
   o1WgDE0eaBqjDVThaUnoHKe7E4ynJRUwnBINIo+FO2/ORUHGRWcpSkc2K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="4410175"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="4410175"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:07:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="933269717"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933269717"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 14:07:30 -0800
Message-ID: <33d241bf-e360-44c5-b63d-550da3cc66d9@intel.com>
Date: Mon, 5 Feb 2024 15:07:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: remove CONFIG_CXL_PMU entry in drivers/cxl/Kconfig
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20240204094613.40687-1-masahiroy@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240204094613.40687-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 2:46 AM, Masahiro Yamada wrote:
> Commit 5d7107c72796 ("perf: CXL Performance Monitoring Unit driver")
> added the config entries for CXL_PMU in drivers/cxl/Kconfig and
> drivers/perf/Kconfig, so it can be toggled from multiple locations:
> 
> [1] Device Drivers
>      -> PCI support
>        -> CXL (Compute Expres Link) Devices
>          -> CXL Performance Monitoring Unit
> 
> [2] Device Drivers
>      -> Performance monitor support
>        -> CXL Performance Monitoring Unit
> 
> This complicates things, and nobody else does this.
> 
> I kept the one in drivers/perf/Kconfig because CONFIG_CXL_PMU controls
> the compilation of drivers/perf/cxl_pmu.c.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
>  drivers/cxl/Kconfig | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 67998dbd1d46..5f3c9c5529b9 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -144,17 +144,4 @@ config CXL_REGION_INVALIDATION_TEST
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say N.
>  
> -config CXL_PMU
> -	tristate "CXL Performance Monitoring Unit"
> -	default CXL_BUS
> -	depends on PERF_EVENTS
> -	help
> -	  Support performance monitoring as defined in CXL rev 3.0
> -	  section 13.2: Performance Monitoring. CXL components may have
> -	  one or more CXL Performance Monitoring Units (CPMUs).
> -
> -	  Say 'y/m' to enable a driver that will attach to performance
> -	  monitoring units and provide standard perf based interfaces.
> -
> -	  If unsure say 'm'.
>  endif

