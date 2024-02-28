Return-Path: <linux-kernel+bounces-84456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E8186A6F8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79D971F2BBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489D41CFAB;
	Wed, 28 Feb 2024 02:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T9lQDdkj"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198671CD24;
	Wed, 28 Feb 2024 02:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089162; cv=none; b=BOS4/sBy2ymnWhSRK08aAHlwIpeJjCxnlxpqeIvhzBiK8s987XkRLWyZ0rr2wxC+Prwz3i23admP32VIR5KypBKWm5UElt8g5C+dyFJtI9z2hu8TDeVqDLCnjQ4cODaG2JpWab8Ee/0FmbmQAakGwVAI+qOI7P8Jmgr1fAAvGmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089162; c=relaxed/simple;
	bh=+Z1tIfGnJXnPWTFBKhO7BGRahx2cBbP1PxxMCAfAlVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sfQ52HLNAJE2nzG3ZgUg13uXypk/1pkzXtly4UgTJTLrfuEwRaTEeU/wzb71RYe8nXhk0jLMoI+HZ+lHGYEm06EqezyaWOGzjetgp1Yt6I4RHmQ4bEl6jauQPEEXrkCfzZM0OfPhdeMef0fQejTBdiyxLb7oUkcHGAsWshz44aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T9lQDdkj; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709089161; x=1740625161;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=+Z1tIfGnJXnPWTFBKhO7BGRahx2cBbP1PxxMCAfAlVI=;
  b=T9lQDdkjF6dP/Ho3pRf6FI+2BSRPRiOiO9wHe321j/vgs3i3sSRC3gG1
   LEyEmtuHznIqH/vKAfnmtc1T4451E9T75M67fVA5g0Go5ycbuJtyp1YaU
   5yjny9xZb7XQpjqVvV7VHUWf/WP//3RnKVWku8pDE29GDY24KqnI++Cbv
   c0sL/GGVpOg5tfrL3BabtEXiGk8tm41KDhV4eoNLyJ6coEyybKKzdzxwc
   bmpyD1vCGBAcr9jGIB1JLErrmV/xLL3OvOtfx4TgNxsX/CV6JMANWqOni
   9l/VJe2UFo80Rtxyx8zduqjHk3yVj9vyDxRawMjkzmGulGyG1R15BEACJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3329191"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3329191"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:59:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="11837304"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:59:20 -0800
Message-ID: <5149642c-4718-4ce4-a0e0-5648260aa04a@linux.intel.com>
Date: Tue, 27 Feb 2024 18:59:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 8/9] platform/x86/intel/sdsi: Simplify ascii printing
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-9-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-9-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> Use printf width specifier to set the display length of encoded feature
> names.
>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---

Looks fine to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> V2 - Split of V1 patch 7
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 2acc6be5f5d6..a8fb6d17405f 100644
> --- a/tools/arch/x86/intel_sdsi/intel_sdsi.c
> +++ b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> @@ -407,11 +407,10 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  
>  	printf("Number of Feature Counters:   %d\n", mc->bundle_length / 8);
>  	while (count < mc->bundle_length / 8) {
> -		char feature[5];
> +		char feature[4];
>  
> -		feature[4] = '\0';
>  		get_feature(bec[count].encoding, feature);
> -		printf("    %s:          %d\n", feature, bec[count].counter);
> +		printf("    %.4s:          %d\n", feature, bec[count].counter);
>  		++count;
>  	}
>  
> @@ -492,7 +491,7 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
>  			sizeof(*lki) +			// size of the license key info
>  			offset;				// offset to this blob content
>  		struct bundle_encoding *bundle = (void *)(lbc) + sizeof(*lbc);
> -		char feature[5];
> +		char feature[4];
>  		uint32_t i;
>  
>  		printf("     Blob %d:\n", count - 1);
> @@ -505,11 +504,9 @@ static int sdsi_state_cert_show(struct sdsi_dev *s)
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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


