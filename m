Return-Path: <linux-kernel+bounces-58247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216B84E372
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:46:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FF891C23D59
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103287A713;
	Thu,  8 Feb 2024 14:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E1lymJLx"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011D69300;
	Thu,  8 Feb 2024 14:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403573; cv=none; b=L/xALv6rolQ69/W74oWyJAIYU/7SDcOdMFUAROaLhgwZ3SKpF4X4S16pmmokteSSZQMXw56BGthWB7psWid+sI949ReMXzGhb7rYDvYs+hRnbscGl5QiXOFnlEC7xM6Rh4lreonLj5aFJxIQO5ywPaZ2c18zJ/9wu9jiTvBTImU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403573; c=relaxed/simple;
	bh=Ycp/275UvtnRb1jLK/6lublEGbsUfigtHuXe5sUsrlI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=A+E5FrtAJi0oe7Be2vdejpyAPThaUF8v8mC+8WsmYXeBuxB/G6VYtkd5qqxM6xSwdgfWbhYlfKHTwYfWxnYDu1E9WmXyrlzdzyyITpeSELdmtFwx2d4EsD9/Qsa6X1TAO2pUEae3lc+wgVAkhS0PTpC7I9xISLwDqwJb+NPAZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E1lymJLx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707403571; x=1738939571;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ycp/275UvtnRb1jLK/6lublEGbsUfigtHuXe5sUsrlI=;
  b=E1lymJLxAtmSs/6pRzof05u+1YvHlW4FqiNduLF7XIk8prQx059lDx6u
   fbt4o09nD7jGwBDvB+kMsvnJDoA149BwltG08NVjO9b5s3eDUI9mt7Dnd
   hPtEhjeDyM5CTc1UgImHEKeOzOJ6YTHK3DmXfKQblLaaQAygCzF1ipOHI
   22cX6U+wvdXb+d3W1CEzmpVfX/3M9M0NQQq2J6+w1xejU0/7k+WMPhsBq
   AlkbpB3X3eaZJvc6+dHdKG411eCeH2bPtDL3gu9vfwXmJVbKOqkG3qxrX
   AoUbVnsd8xIW3pP+sBKhLto0s7XBSM7fbRsNhuZpQQcIV4D8iv9k3rOf9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10978"; a="1384812"
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1384812"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:46:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,254,1701158400"; 
   d="scan'208";a="1658892"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 06:46:08 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 16:46:04 +0200 (EET)
To: "David E. Box" <david.e.box@linux.intel.com>
cc: Netdev <netdev@vger.kernel.org>, 
    sathyanarayanan.kuppuswamy@linux.intel.com, 
    LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 7/8] tools: Fix errors in meter_certificate display
In-Reply-To: <20240201010747.471141-8-david.e.box@linux.intel.com>
Message-ID: <654cf0d5-e6c4-ac98-154a-29c0536ae2a4@linux.intel.com>
References: <20240201010747.471141-1-david.e.box@linux.intel.com> <20240201010747.471141-8-david.e.box@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 31 Jan 2024, David E. Box wrote:

> The maximum number of bundles in the meter certificate was hardcoded to
> 8 which caused extra bundles not to display. Instead, since the bundles
> appear at the end of the file, set it to the remaining size from where
> the bundles start.
> 
> Add missing 'version' field to struct meter_certificate.
> 
> Fix errors in the calculation of the start position of the counters and
> in the display loop.

Why are all these bundled into a single commit? They sound like 
independent changes.

-- 
 i.

> Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 51 +++++++++++++++-----------
>  1 file changed, 30 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 2cd92761f171..a8fb6d17405f 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -43,7 +43,6 @@
>  #define METER_CERT_MAX_SIZE	4096
>  #define STATE_MAX_NUM_LICENSES	16
>  #define STATE_MAX_NUM_IN_BUNDLE	(uint32_t)8
> -#define METER_MAX_NUM_BUNDLES	8
>  
>  #define __round_mask(x, y) ((__typeof__(x))((y) - 1))
>  #define round_up(x, y) ((((x) - 1) | __round_mask(x, y)) + 1)
> @@ -154,11 +153,12 @@ struct bundle_encoding {
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
> @@ -167,6 +167,9 @@ struct bundle_encoding_counter {
>  	uint32_t encoding;
>  	uint32_t counter;
>  };
> +#define METER_MAX_NUM_BUNDLES							\
> +		(METER_CERT_MAX_SIZE - sizeof(struct meter_certificate) /	\
> +		 sizeof(struct bundle_encoding_counter))
>  
>  struct sdsi_dev {
>  	struct sdsi_regs regs;
> @@ -334,6 +337,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	uint32_t count = 0;
>  	FILE *cert_ptr;
>  	int ret, size;
> +	char name[4];
>  
>  	ret = sdsi_update_registers(s);
>  	if (ret)
> @@ -375,32 +379,39 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
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
>  	}
>  
>  	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
> -		fprintf(stderr, "More than %d bundles: %d\n",
> +		fprintf(stderr, "More than %ld bundles: actual %d\n",
>  			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);
>  		return -1;
>  	}
>  
> -	bec = (void *)(mc) + sizeof(mc);
> +	bec = (void *)(mc) + sizeof(*mc);
>  
> -	printf("Number of Feature Counters:          %d\n", mc->bundle_length / 8);
> -	while (count++ < mc->bundle_length / 8) {
> -		char feature[5];
> +	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
> +	while (count < mc->bundle_length / 8) {
> +		char feature[4];
>  
> -		feature[4] = '\0';
>  		get_feature(bec[count].encoding, feature);
> -		printf("    %s:          %d\n", feature, bec[count].counter);
> +		printf("    %.4s:          %d\n", feature, bec[count].counter);
> +		++count;
>  	}
>  
>  	return 0;
> @@ -480,7 +491,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  			sizeof(*lki) +			// size of the license key info
>  			offset;				// offset to this blob content
>  		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
> -		char feature[5];
> +		char feature[4];
>  		uint32_t i;
>  
>  		printf("     Blob %d:\n", count - 1);
> @@ -493,11 +504,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  		printf("        Blob revision ID:           %u\n", lbc->rev_id);
>  		printf("        Number of Features:         %u\n", lbc->num_bundles);
>  
> -		feature[4] = '\0';
> -
>  		for (i = 0; i < min(lbc->num_bundles, STATE_MAX_NUM_IN_BUNDLE); i++) {
>  			get_feature(bundle[i].encoding, feature);
> -			printf("                 Feature %d:         %s\n", i, feature);
> +			printf("                 Feature %d:         %.4s\n", i, feature);
>  		}
>  
>  		if (lbc->num_bundles > STATE_MAX_NUM_IN_BUNDLE)
> 

