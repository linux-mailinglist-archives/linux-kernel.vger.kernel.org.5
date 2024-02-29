Return-Path: <linux-kernel+bounces-87570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130C486D601
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:18:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF801289D91
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885D516FF4B;
	Thu, 29 Feb 2024 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="es7kiwcP"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8230016FF34;
	Thu, 29 Feb 2024 21:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241508; cv=none; b=O3TyHyEe1Z7NXub+WGiJfvKew0S1DDoQBzF6DkWarmXV0pSHGQKfdZZT09bFED2kecKWtKfIfPPF3Ai3j7ljqpX4HohZ4jklSbNWq6zaM1slE/DAC/to18RN7+C6BDmJ7w+L8U8hGCJYakcWC4gki4C0sUCmLgqNkiBp+vMt+rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241508; c=relaxed/simple;
	bh=59iOag6GB72bkNMijk1auQJkojkJz2SZvr7evBnMPuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/mXICPnr9lQVTxX1548QiRevU+neoILlocnaswysmLqlHrdqLISHUH4IUj1bVWm5nS+kELqQ+iaaL1/YWRThCjY8paE6vH4iIFQZaysNGPkV7wQynhN2aBa/kt66mf0aTvSrvut+chred5tSLpyUoUOcYQ5wtb8LamhrktPbj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=es7kiwcP; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709241508; x=1740777508;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=59iOag6GB72bkNMijk1auQJkojkJz2SZvr7evBnMPuA=;
  b=es7kiwcPWTXsaCbdh3Klix22/HClX3Zf1HqzG6XZ4c4HBxV+tzkTxoD2
   mQzEl37GtgQ452KzqEbOhMwFTFI8G16wcSuHoQ29WfcuGaML3Za04M/ko
   DjNXHx4BOB9jG0sLwhA8X+UsKmVWhEYtz53Fu2xmDpHWO5v9OeCf1Mc9h
   mZ3Duadk0n8aE3KPJ5UWuBnIGRT5g9d9hdiUFNKCF2EKzmhbG3yqSpFEJ
   CDZ4SZIUqayjunCM8z7X8dtTnssZGWM1lglddFQ1UhpGB/Es8SwJHvySA
   JgooW6Ucl/8uWrGfS1aIcfJje3w485bhs2dDkh6EvYLGLu02o8GMH2Z9/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10999"; a="7572755"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="7572755"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:18:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="45509481"
Received: from gditter-mobl1.amr.corp.intel.com (HELO [10.209.51.74]) ([10.209.51.74])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 13:18:27 -0800
Message-ID: <0f335f76-1a76-4964-9dd4-0491fe4bcf91@linux.intel.com>
Date: Thu, 29 Feb 2024 13:18:26 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: Allow reading core-power state on HWP
 disabled systems
Content-Language: en-US
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 hdegoede@redhat.com, markgross@kernel.org, ilpo.jarvinen@linux.intel.com,
 andriy.shevchenko@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240229002659.1416623-1-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/28/24 4:26 PM, Srinivas Pandruvada wrote:
> When HWP (Hardware P-states) is disabled, dynamic SST features are
> disabled. But user should still be able to read the current core-power
> state, with legacy P-states. This will allow users to read current
> configuration with static SST enabled from BIOS.
>
> To address this, do not call disable_dynamic_sst_features() when the
> request is for reading the state.
>
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 2662fbbddf0c..1d918000d72b 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -462,10 +462,10 @@ static long isst_if_core_power_state(void __user *argp)
>  	struct tpmi_per_power_domain_info *power_domain_info;
>  	struct isst_core_power core_power;
>  
> -	if (disable_dynamic_sst_features())
> +	if (copy_from_user(&core_power, argp, sizeof(core_power)))
>  		return -EFAULT;
>  
> -	if (copy_from_user(&core_power, argp, sizeof(core_power)))
> +	if (core_power.get_set && disable_dynamic_sst_features())
>  		return -EFAULT;
>  
>  	power_domain_info = get_instance(core_power.socket_id, core_power.power_domain_id);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


