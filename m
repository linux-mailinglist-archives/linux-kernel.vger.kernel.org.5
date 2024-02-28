Return-Path: <linux-kernel+bounces-84454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B033E86A6F4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:57:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 608071F2B23F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9A1CF99;
	Wed, 28 Feb 2024 02:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aBqsgk7I"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A8D1CD0F;
	Wed, 28 Feb 2024 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089043; cv=none; b=RQg17SAxH+Lyu7mqJeqBeFp6g0RPBCfx9BNxVp3K0+eUEVjWUVMUGsRBLBjBpmp4vxExgzYOAidgNeBTJ74ap+oOkRZtkdsXlRw6JtugBXeZlNK2nf6N/TpXlJVmGjJDWd5a+UzcYwdw36Ut9oJlizRVQfaOhwn4jiF8Kj34xaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089043; c=relaxed/simple;
	bh=DrPnGSdQxL+NuAAOgZAbBL33b9iEFzBIqVQV9hhR2RA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V7/2bK+rXwnU8ogwzJSMNffol5sSxIdQ44weIE86aKAFOe1h92DEXEThjJAUaWKjRfbgKLg0ZJ/hEaVbcyxPUmMDaYdvUlj587rHTMIAG22QvfRZ64GBL+tlWRrZf4LHJzkjr9nqrk4lvAMPHghM0hMP3E82gJaa1xIuJ04a0xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aBqsgk7I; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709089041; x=1740625041;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DrPnGSdQxL+NuAAOgZAbBL33b9iEFzBIqVQV9hhR2RA=;
  b=aBqsgk7IfG9V3IYlYYQTZ5rrEt7LU5MuBig+3LWwUFlgdRC7l0CJrmrW
   vLkk0uEpHyvRrKPgEy4Z1xmNulV3PBkiGriTe39rYQdp+5fy4mUyyL9iw
   A86690eeqEjfUN3k18gnAaiFE+nADEhsgNzN7SuFAf/bG6eSwMXTCkklf
   Jl+VPm9hgmLQHsUkQpTqJk82/hW2gLF3ipeCSiTM0n2y/+DrvxcmlJvzd
   tIcuajWr9OcrPZxLw+e4E3etGE9YmpDOVrh8iwWgtPHsuwxLSH7bis32C
   MMHB/hu7qRvg7Ue5dLHGpfJjZGFYMYPujXGg/axTjcDO/ZdJTmcmDLmgG
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3328970"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3328970"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:57:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11836841"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:57:20 -0800
Message-ID: <9661c185-0132-44da-beef-05da55c5a98f@linux.intel.com>
Date: Tue, 27 Feb 2024 18:57:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 6/9] tools/arch/x86/intel_sdsi: Add missing version
 field
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-7-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-7-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> Add missing 'version' field to struct meter_certificate. Also fix output
> string alignment.
>
> Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>
> V2 - Split of V1 patch 7
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 29 +++++++++++++++++---------
>  1 file changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index a02850a710ee..def1b9a01738 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -153,11 +153,12 @@ struct bundle_encoding {
>  };
>  
>  struct meter_certificate {
> -	uint32_t block_signature;
> +	uint32_t signature;
> +	uint32_t version;
> +	uint64_t ppin;
>  	uint32_t counter_unit;
> -	uint64_t ppin;
>  	uint32_t bundle_length;
> -	uint32_t reserved;
> +	uint64_t reserved;
>  	uint32_t mmrc_encoding;
>  	uint32_t mmrc_counter;
>  };
> @@ -336,6 +337,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	uint32_t count = 0;
>  	FILE *cert_ptr;
>  	int ret, size;
> +	char name[4];

Nit: IMO, instead of hardcoding, you can introduce a macro like FEATURE_LEN.
It is up to you.

>  
>  	ret = sdsi_update_registers(s);
>  	if (ret)
> @@ -377,12 +379,19 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	printf("\n");
>  	printf("Meter certificate for device %s\n", s->dev_name);
>  	printf("\n");
> -	printf("Block Signature:       0x%x\n", mc->block_signature);
> -	printf("Count Unit:            %dms\n", mc->counter_unit);
> -	printf("PPIN:                  0x%lx\n", mc->ppin);
> -	printf("Feature Bundle Length: %d\n", mc->bundle_length);
> -	printf("MMRC encoding:         %d\n", mc->mmrc_encoding);
> -	printf("MMRC counter:          %d\n", mc->mmrc_counter);
> +
> +	get_feature(mc->signature, name);
> +	printf("Signature:                    %.4s\n", name);
> +
> +	printf("Version:                      %d\n", mc->version);
> +	printf("Count Unit:                   %dms\n", mc->counter_unit);
> +	printf("PPIN:                         0x%lx\n", mc->ppin);
> +	printf("Feature Bundle Length:        %d\n", mc->bundle_length);
> +
> +	get_feature(mc->mmrc_encoding, name);
> +	printf("MMRC encoding:                %.4s\n", name);
> +
> +	printf("MMRC counter:                 %d\n", mc->mmrc_counter);
>  	if (mc->bundle_length % 8) {
>  		fprintf(stderr, "Invalid bundle length\n");
>  		return -1;
> @@ -396,7 +405,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	bec = (void *)(mc) + sizeof(mc);
>  
> -	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
> +	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);

Try to use sizeof instead of hardcoded value.

>  	while (count++ < mc->bundle_length / 8) {
>  		char feature[5];
>  

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


