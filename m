Return-Path: <linux-kernel+bounces-85779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E47086BAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 23:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53E41284A3A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 22:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263D61361B9;
	Wed, 28 Feb 2024 22:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g5bT2mMk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985BE1361CC;
	Wed, 28 Feb 2024 22:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709158655; cv=none; b=hffAZMwABH0G6BUABugqiizhVWXj6ygczrjj6t7ErkQaFsZFn5h/V10n7YAX88hZ8ylRwl/g0uzNLoXpKak6cGKMOF2eNifAyjlksUddXib+ViY/BOTjwarejiolUuAN7RIeDU/oBqPPNFoeCIonArBzp64BfbYGDfqzD6CzU+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709158655; c=relaxed/simple;
	bh=A+DPmo7xOF29SHP4hGw/KWKBS/l1dEFAz8NqRjg0920=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=WZaMxYlOTFm8SlhqLuyjCaf+O2Sw4mTR6MfvhhB8cyBLR8vg6eN/70obiq/kQyLyA5WDIv2AJbunoq+AvC7eqf8SSeTxZREwuUFD9MwqAFk/X465euWcy++v/i3R+tmdZfVUA5Gar+bSGw16dHgvOsHlnZdin3OKlhcKsuy14/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g5bT2mMk; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709158654; x=1740694654;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=A+DPmo7xOF29SHP4hGw/KWKBS/l1dEFAz8NqRjg0920=;
  b=g5bT2mMkgV8eKdjEFXRpAVKyNH949NHZGvRVck5kO6MJGns4tOJG4z4i
   DOA13arJfskcFAvGYUg9+g+uFxZ7EvHBq8TjXeC1tiAuMbAdNj6uZcs3P
   G9dC7IJZ0lGdC4fMmkbywYtnR2/ygMrRy8i9nx8PogIh0Fzl5ZTbi8NYZ
   Nsy8n6WuIJV8mN20wsr5xf7qc6t13PPR9gPD72nM11jkHGDyoLha9WA6d
   KppyihzFFNtawoHXjVIUN272D3P09ZFJjW40s6YzN8FFM7ZG/UkJ6H41Y
   3WxMOzmhJNTmO3jqTqREbd5HUgZFUm+Qi3+CTXWYQHoEP42mCylyyIq/x
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="3473348"
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="3473348"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 14:17:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,191,1705392000"; 
   d="scan'208";a="7699638"
Received: from smleviti-mobl1.amr.corp.intel.com (HELO [10.246.128.202]) ([10.246.128.202])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 14:17:31 -0800
Message-ID: <5674b85d-2974-4f1c-9241-42982c1dbbe8@linux.intel.com>
Date: Wed, 28 Feb 2024 17:17:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ASoC: Intel: bytcr_rt5640: Add an extra entry for the
 Chuwi Vi8 tablet
To: =?UTF-8?Q?Alban_Boy=C3=A9?= <alban.boye@protonmail.com>,
 cezary.rojewski@intel.com, broonie@kernel.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240228192807.15130-1-alban.boye@protonmail.com>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240228192807.15130-1-alban.boye@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/28/24 2:28 PM, Alban Boyé wrote:
> The bios version can differ depending if it is a dual-boot variant of the tablet.
> Therefore another DMI match is required.
> 
> Signed-off-by: Alban Boyé <alban.boye@protonmail.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5640.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index 03be5e26ec4a..05f38d1f7d82 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -685,6 +685,18 @@ static const struct dmi_system_id byt_rt5640_quirk_table[] = {
>   					BYT_RT5640_SSP0_AIF1 |
>   					BYT_RT5640_MCLK_EN),
>   	},
> +	{	/* Chuwi Vi8 dual-boot (CWI506) */
> +		.matches = {
> +			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Insyde"),
> +			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "i86"),
> +			/* The above are too generic, also match BIOS info */
> +			DMI_MATCH(DMI_BIOS_VERSION, "CHUWI2.D86JHBNR02"),
> +		},
> +		.driver_data = (void *)(BYTCR_INPUT_DEFAULTS |
> +					BYT_RT5640_MONO_SPEAKER |
> +					BYT_RT5640_SSP0_AIF1 |
> +					BYT_RT5640_MCLK_EN),
> +	},
>   	{
>   		/* Chuwi Vi10 (CWI505) */
>   		.matches = {

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


