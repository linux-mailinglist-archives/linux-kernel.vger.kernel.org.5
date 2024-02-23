Return-Path: <linux-kernel+bounces-77699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2154586092F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11FF28638F
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8307C2DA;
	Fri, 23 Feb 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZzF+rUau"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1A7C13C;
	Fri, 23 Feb 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657764; cv=none; b=VpmYSOo3hYStYGIH+48PPEtt/1a2thbLEBk+sk89HxKLN8jqslcK0ysxYrfdJ5E65kv6GZ4USRKH8/NoqSv1p9NQ1yh3m0bvod3C0GrLr77lyZ5gveQhEDDWvGXCkXa5xEOpiKLvs8zhO4FqWIhHVYDs2/KFJ6HN8/B2v+p9eL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657764; c=relaxed/simple;
	bh=/6WvbFZ0o/8sJFaNJURwmKXqRX5w9t3INnSLhPEqsE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pBkw7ITzN7uaSmuTtpFxRJepZls3IowxeOtvQTwwyYXAcCjSGHMOAfm+7i5N3tWQ9NsLtGxWB6QcdTRuNi3DU/cY/wzDWVb4mj1s+II4SdfavWRe2IUK54jYsmWvNxdNAwj26n9ExLdeRxzGX+LU3LyA0VHexGPptjoT3/K8zrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZzF+rUau; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708657763; x=1740193763;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/6WvbFZ0o/8sJFaNJURwmKXqRX5w9t3INnSLhPEqsE0=;
  b=ZzF+rUau8EcZFl4c5ehxQxj8fwNAzTff8JRUjaPLSdTr2NYcMm5dvy4E
   0wAXrzcvlkEnLWsGlofSGZPU1e1IHaPtAnJBV28OjgJVsn6901jRaTMXf
   tvR97RaNUrz0TjQj09Oc5uMewGK+ObtdAS6tPXmKR7iRFb7dfmBcnt1bY
   xMvn3Kw6FliIV1He1tBTnq+e4Mr/ZI+s4W//y+NmLpFlKGepXe9dbUPXM
   N/nIOiRcUMZVn6FdttOrGkPswkvP+TFdJvG7ID1fG9cPHLohcx5n7rgal
   gS/4iyMVN3sYBOUvagxG7WUVL9jLZH4AKbn3KrE/zGOc58k/e6v2SKCeZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2830685"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2830685"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:09:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="10462191"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:09:21 -0800
Message-ID: <c5357fa8-3f90-4f3e-a4c5-43d8ad4fdaa0@linux.intel.com>
Date: Thu, 22 Feb 2024 19:09:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] platform/x86/intel/pmc/arl: Put GNA device in D3
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
 <20240221211204.515159-3-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240221211204.515159-3-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/21/24 1:12 PM, David E. Box wrote:
> To unblock Package C state entry, put the GNA device in D3 by default if no
> driver is loaded for it.

Can you add more details about the C state issue? If no driver is enumerated,
should it not follow the firmware default value? Why not fix this in firmware?

>
> Fixes: 83f168a1a437 ("platform/x86/intel/pmc: Add Arrow Lake S support to intel_pmc_core driver")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel/pmc/arl.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/platform/x86/intel/pmc/arl.c b/drivers/platform/x86/intel/pmc/arl.c
> index 683ae828276b..34b4cd23bfe5 100644
> --- a/drivers/platform/x86/intel/pmc/arl.c
> +++ b/drivers/platform/x86/intel/pmc/arl.c
> @@ -673,6 +673,7 @@ static struct pmc_info arl_pmc_info_list[] = {
>  };
>  
>  #define ARL_NPU_PCI_DEV			0xad1d
> +#define ARL_GNA_PCI_DEV			0xae4c
>  /*
>   * Set power state of select devices that do not have drivers to D3
>   * so that they do not block Package C entry.
> @@ -680,6 +681,7 @@ static struct pmc_info arl_pmc_info_list[] = {
>  static void arl_d3_fixup(void)
>  {
>  	pmc_core_set_device_d3(ARL_NPU_PCI_DEV);
> +	pmc_core_set_device_d3(ARL_GNA_PCI_DEV);
>  }
>  
>  static int arl_resume(struct pmc_dev *pmcdev)

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


