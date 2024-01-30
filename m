Return-Path: <linux-kernel+bounces-44331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE0C84205E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:01:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD9D28C9A9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F748664A6;
	Tue, 30 Jan 2024 09:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lixVOgru"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B921265BCD;
	Tue, 30 Jan 2024 09:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608608; cv=none; b=XvAsafkaoU1arseMb/KzurWN/mAlU58LehRo8FmexkWCIWl7qbqVoD4WuhOa4h7+8l7/mKQeCQuPeu2Vnyw0un96Y7OmrQGGJBU1/Qa0tfE9QyVDUbH45032LCh7nhFX8rVVwY43f/p2y/7DDDckxttWNvLaIqRTSj9mf4l5Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608608; c=relaxed/simple;
	bh=2VPEHzexv7amn45miqUGZIow01lrVch6FhfSAsTulbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oBNB0qO8FsFXDEm7KA4cu1gtg/e0k41OwuP7ZxQhs/TrxcZUtlGbXUyJxpJ76aynbgWjx1CFiG3AjWTaaf+Cn3CvX/isooA9CtXMlvVGTE7CpFCwICJV6oLVk1J7iGAjSkrQUlbFX8e8crHkrac0QB47z6iIWrIfp5M8629J/SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lixVOgru; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706608607; x=1738144607;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=2VPEHzexv7amn45miqUGZIow01lrVch6FhfSAsTulbI=;
  b=lixVOgruDwwDPGQWr4a0FcxSnnTj5bSXkAfyUjs5dOLvVDfkvstg2ctR
   YsZ2m3ttn01ndURRrTfuUbxlKMFCc5B/uaRh2q3AA0bLrhKgpO18/bXUe
   fpL+Id9e0ex60HKrd+P3Q7czELTNmi9cAILBOGxIIfU382+kj6MpYSH1A
   Ma7GfUmI0om2oXoqRbe34S6HxDEPnptfYCjcjmmtgYhNDu4GNH7nD3Ukl
   YjYv5Ao1vRDx/jNuEmbyCMhXPCEteUJYYsQP9cYG47YfkZndLU/HPGvDW
   4U9fyzzrpm/rsKJZggLoICmewnv8lIv+yzDBXbHaSFmwu2T01IcssRQ4X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="21747643"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="21747643"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:56:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="29852762"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:56:43 -0800
Message-ID: <8c92d33d-923b-4805-abdf-752e8943072e@linux.intel.com>
Date: Tue, 30 Jan 2024 10:56:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] sound: soc: wcd934x: fix an incorrect use of kstrndup()
Content-Language: en-US
To: Fullway Wang <fullwaywang@outlook.com>, broonie@kernel.org,
 srinivas.kandagatla@linaro.org, bgoswami@quicinc.com, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
 fullwaywang@tencent.com
References: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <PH7PR20MB59255EF9DFFB022CB1BBB574BF712@PH7PR20MB5925.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/18/2024 8:52 AM, Fullway Wang wrote:
> In wcd934x_codec_enable_dec(), kstrndup() is used to alloc memory.
> However, kmemdup_nul() should be used instead with the size known.
> 
> This is similar to CVE-2019-12454 which was fixed in commit
> a549881.
> 
> Signed-off-by: Fullway Wang <fullwaywang@outlook.com>
> ---
>   sound/soc/codecs/wcd934x.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/codecs/wcd934x.c b/sound/soc/codecs/wcd934x.c
> index 1b6e376f3833..4565a0e1877f 100644
> --- a/sound/soc/codecs/wcd934x.c
> +++ b/sound/soc/codecs/wcd934x.c
> @@ -4990,7 +4990,7 @@ static int wcd934x_codec_enable_dec(struct snd_soc_dapm_widget *w,
>   	char *dec;
>   	u8 hpf_coff_freq;
>   
> -	widget_name = kstrndup(w->name, 15, GFP_KERNEL);
> +	widget_name = kmemdup_nul(w->name, 15, GFP_KERNEL);
>   	if (!widget_name)
>   		return -ENOMEM;
>   

This change looks weird to me, and looking at code I'm even more 
confused. As far as I can tell code tries to find a number in w->name. 
It shouldn't need a duplicate string for this, it can search in existing 
one, same applies to referenced commit.

And when it comes to a549881 as already mentioned in 
https://lore.kernel.org/alsa-devel/7573d8ce-7160-39b1-8901-be9155c451a1@suse.cz/ 
the size is at most 15 not equal to, so change was misguided. If you 
look at actual code widget name is around 8 characters.

Also it seems like consensus was that CVE was bogus and it was a wrong 
change:
https://lore.kernel.org/alsa-devel/20190618230527.GE6248@lindsey/
there was a revert send, but it seems like it was not applied:
https://lore.kernel.org/alsa-devel/20190612133040.5kgtio7gidxx64gh@xylophone.i.decadent.org.uk/




