Return-Path: <linux-kernel+bounces-77696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308B986091E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDD4F1F245A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00779C153;
	Fri, 23 Feb 2024 03:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UUikE3iZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE4228EB;
	Fri, 23 Feb 2024 03:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657377; cv=none; b=hXdQFDH7hfqDGTDrCjJYjcbxUQR7ZbNb2cXNUqJQu1w8LaOeIWcUaZdeFdZAx2qZRhiijwpBWYwFSh6u3tABJ2fUGDCrf6Z4LVQDpXEAzhsAcDuDOyvn8W/E0rGWthWfWZRvhSzr/Ot0R82yKB0lPlR9I4/2jtAr8ukOWBzoY2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657377; c=relaxed/simple;
	bh=a6fNiZpl6dtF1P3XA1YjNgrwZuGCYiJxtvbHbd8qi8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=s7SlBCul0iUMAAed+DOj5smIsycsKI8WevxznyqYKMRW9JSbY682NsqpI7yZGXJ/Luw0lKrASQ97aq/+/oWDm0dqEV6Z+EHEYA/9pg9+eQQ9sHpswYcaT3MXK72KAmqDbuRnIF8nQwszKUYkyqoUMmOkuyD/L2ds3tefd4+gQLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UUikE3iZ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708657375; x=1740193375;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=a6fNiZpl6dtF1P3XA1YjNgrwZuGCYiJxtvbHbd8qi8g=;
  b=UUikE3iZeeiEbxQkAbnCUN0Uijt1BS+D+JQXrpEoIHcPmX+MR00InzHi
   LWe+gsjDVdOgfdnL+/7epLIkZQLKOyNWj2J6/lAPFFBGj1yWufEceWbNt
   hWftvM1weBE2RiFQ8F9EpziB6hrZ3RO/f/CHVB70XzRT0txjMJukbvr0Y
   NkZWWCyFGrAsWhvBR+bcmbFTnCDFmDtgA8DPtSX8Uo4lLzngozP1VFON+
   Gf9dHnLRZPVGPht2V5eNDC00quNbQt8Uh6/ZmtwKSIWmIaHIuFyFY8HD/
   B5PLMTO43P17sk9CmOWyb/3dqKiEA8VnuKEyfINriHVW4SyIsRfIkAETx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10992"; a="2818368"
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="2818368"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,179,1705392000"; 
   d="scan'208";a="5922601"
Received: from rdegger-desk1.amr.corp.intel.com (HELO [10.209.74.18]) ([10.209.74.18])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 19:02:54 -0800
Message-ID: <5bc6645f-1068-44a7-a1e3-34ed183a82a1@linux.intel.com>
Date: Thu, 22 Feb 2024 19:02:53 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] platform/x86/intel/vsec: Remove nuisance message
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240221211204.515159-1-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240221211204.515159-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/21/24 1:12 PM, David E. Box wrote:
> intel_vsec_walk_header() is used to configure features from devices that
> don't provide a PCI VSEC or DVSEC structure. Some of these features may
> be unsupported and fail to load. Ignore them silently as we do for
> unsupported features described by VSEC/DVSEC.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Change looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/platform/x86/intel/vsec.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/drivers/platform/x86/intel/vsec.c b/drivers/platform/x86/intel/vsec.c
> index 778eb0aa3479..0fdfaf3a4f5c 100644
> --- a/drivers/platform/x86/intel/vsec.c
> +++ b/drivers/platform/x86/intel/vsec.c
> @@ -236,10 +236,7 @@ static bool intel_vsec_walk_header(struct pci_dev *pdev,
>  
>  	for ( ; *header; header++) {
>  		ret = intel_vsec_add_dev(pdev, *header, info);
> -		if (ret)
> -			dev_info(&pdev->dev, "Could not add device for VSEC id %d\n",
> -				 (*header)->id);
> -		else
> +		if (!ret)
>  			have_devices = true;
>  	}
>  
>
> base-commit: 841c35169323cd833294798e58b9bf63fa4fa1de

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


