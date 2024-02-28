Return-Path: <linux-kernel+bounces-84452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BC186A6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067E61F29A3F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6E61CF9A;
	Wed, 28 Feb 2024 02:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TuUZR64z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C091CD0F;
	Wed, 28 Feb 2024 02:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709088861; cv=none; b=h6jdOmB6ZYeaQp2VQpW92a9zMm8C0fj5bFpyEX/aXQsRvrexAmMY1f5tvjOhPLTDk3AaoOOlQDDtq+F53DV1Z5OI/3qnOIE/C9W46cNpzGcAGbfDZenReU0lSZ3WDFB3on7DS59a5hq5nC4SUi7H95bH+trPoGhHlRywiC8Ouas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709088861; c=relaxed/simple;
	bh=DcplYvg9YXEcB4+RqfeA3kQTbwDp+wkHlaKrY7RctWg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qzSg7xTpxI14fok0BtTJxgjZw7PJHQyPRIbvEMSYi+xY1Wx6HCyCiXRwWHFRrVbEVYU2sPowWTu/N83kPuoN3UqXYg3JnPm6kaBPT4lHGEMMa82t4+4fyWf9vSAZ/AY275tSr836X0MH9LM7WLzyEPYTcGA7+05gGGn12BQAweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TuUZR64z; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709088859; x=1740624859;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DcplYvg9YXEcB4+RqfeA3kQTbwDp+wkHlaKrY7RctWg=;
  b=TuUZR64z+oozVqXme4TMA2i/zanHKazWaY1+AXke3mDm0YnP15h7oiTA
   Fp9jujkPoXckY1MnYFvX9mSsvjYv8nPkbYx7mqNEMjnoEYZtgfyIRX+b7
   EEC9AI4lmsrjBV97+H1WD91d5Hbf6bjQxL89Svc1x7ALWr3tbDKsj6bqr
   ruuGNaofd6KzGSM2YdFte7yzWeeSbduWi4LjCABKOX2/+SRkiXayLfU6q
   /W/M/omubGewkvMsdgd3OXAeNGHAkLEQwumModoBdlhR6v9FQHBzI9FCN
   9YIsbyc1bAgObZDoopIPvKR7Ze+rwX9MkTctt0ob/CHIEN+A1eRgBLgq7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="3632870"
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="3632870"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:54:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,189,1705392000"; 
   d="scan'208";a="44785267"
Received: from dschro4x-mobl.amr.corp.intel.com (HELO [10.212.137.190]) ([10.212.137.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 18:54:17 -0800
Message-ID: <75594a83-0d7c-4106-8f06-d940dcff02df@linux.intel.com>
Date: Tue, 27 Feb 2024 18:54:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 5/9] tools/arch/x86/intel_sdsi: Fix maximum meter
 bundle length
Content-Language: en-US
To: "David E. Box" <david.e.box@linux.intel.com>,
 rajvi.jingar@linux.intel.com, platform-driver-x86@vger.kernel.org,
 linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com
References: <20240228000016.1685518-1-david.e.box@linux.intel.com>
 <20240228000016.1685518-6-david.e.box@linux.intel.com>
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20240228000016.1685518-6-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 2/27/24 4:00 PM, David E. Box wrote:
> The maximum number of bundles in the meter certificate was set to 8 which
> is much less than the maximum. Instead, since the bundles appear at the end
> of the file, set it based on the remaining file size from the bundle start
> position.
>
> Fixes: aad129780bae ("platform/x86/intel/sdsi: Add support for reading the current meter state")
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>
> V2 - Split of V1 patch 7
>
>  tools/arch/x86/intel_sdsi/intel_sdsi.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/tools/arch/x86/intel_sdsi/intel_sdsi.c b/tools/arch/x86/intel_sdsi/intel_sdsi.c
> index 2cd92761f171..a02850a710ee 100644
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
> @@ -167,6 +166,9 @@ struct bundle_encoding_counter {
>  	uint32_t encoding;
>  	uint32_t counter;
>  };
> +#define METER_MAX_NUM_BUNDLES							\
> +		((METER_CERT_MAX_SIZE - sizeof(struct meter_certificate)) /	\
> +		 sizeof(struct bundle_encoding_counter))
>  
>  struct sdsi_dev {
>  	struct sdsi_regs regs;
> @@ -387,7 +389,7 @@ static int sdsi_meter_cert_show(struct sdsi_dev *s)
>  	}
>  
>  	if (mc->bundle_length > METER_MAX_NUM_BUNDLES * 8)  {
> -		fprintf(stderr, "More than %d bundles: %d\n",
> +		fprintf(stderr, "More than %ld bundles: actual %d\n",
>  			METER_MAX_NUM_BUNDLES, mc->bundle_length / 8);

I think you can avoid hardcoding here as well. sizeof(struct bundle_encoding_counter)

>  		return -1;
>  	}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


