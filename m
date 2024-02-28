Return-Path: <linux-kernel+bounces-84455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC2286A6F6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB431C25876
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975161CF9A;
	Wed, 28 Feb 2024 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kq80yqOB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECCB6AC2;
	Wed, 28 Feb 2024 02:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089110; cv=none; b=QWS1XdFBBOJX9dSNiaePjl4rX0fhiAH/hpDnq19OuJZwMUdzYE5Xqm0thjdT5QsirzeuAtl2TNKIKv+jeegu3MycNVWtF6dcjeIGpZY7QMBPEC8C83iARHJmJ3UUozy1R32P+EidF3EDlyHY5yVk+jGohBvvKhOGPHAJLaI9LjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089110; c=relaxed/simple;
	bh=YVRITWNTfH8R/bTxmgns7GdmWfPmUJT2M1Q16oDqS4w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=o1r6jWR2YzY9ko6XhvfbMMuM+8R5krYIjzg0+NBfRB/3/3UQlJ5OHGOAlyX+UbLHatBei1CC6Lrju71Zsa/TGpVmp3bXZTY6Rs54R2V2JRgQbWu2fsbD1KoPZKw7zB/718yRy6hUnjHy1XxS2zUnqppEng8G4emZF38K1DmxQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kq80yqOB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709089109; x=1740625109;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=YVRITWNTfH8R/bTxmgns7GdmWfPmUJT2M1Q16oDqS4w=;
  b=Kq80yqOB1V78/sFY0eENcqMJxq2lVeYadH+IUVG8yu69aJUgPjUoyfMI
   TSeDLdjzgi2hNCYHgLnpYfEb5skQHOgvJihlUF/slFj2wrINABffngcdO
   hI9r4VxYK/OXAjaILv9++hBb86dTdTqvTgZzkFUgx2KnkQSbadNmyutew
   dllait8yniK9UQsK9LALGDAGUeVIDSImVkZtq8jZ36i8qzRd4Cv3JXZUC
   mRMKHThW+GR2s2rXO9cafyLFn0EyX4wGIArQI15zjAlOrvYjhRHAq55Qr
   CJodbPZB4oc1d18n+hnuywv9IgndmMCT3zNSR5ps4xDG9pwRU4VGFPrHp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3329129"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3329129"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:58:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11837062"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:58:28 -0800
Message-ID: <f2db03b0-9d81-4886-a279-ae4893563d9a@linux.intel.com>
Date: Tue, 27 Feb 2024 18:58:27 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/9] tools/arch/x86/intel_sdsi: Fix meter_certificate
 decoding
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-8-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-8-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> Fix errors in the calculation of the start position of the counters and in
> the display loop.
>
> Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>
> V2 - Split of V1 patch 7
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index def1b9a01738..2acc6be5f5d6 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -403,15 +403,16 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  		return -1;
>  	}
>  
> -	bec = (void *)(mc) + sizeof(mc);
> +	bec = (void *)(mc) + sizeof(*mc);
>  
>  	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
> -	while (count++ < mc->bundle_length / 8) {
> +	while (count < mc->bundle_length / 8) {
>  		char feature[5];
>  
>  		feature[4] = '\0';
>  		get_feature(bec[count].encoding, feature);
>  		printf("    %s:          %d\n", feature, bec[count].counter);
> +		++count;
>  	}
>  
>  	return 0;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


