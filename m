Return-Path: <linux-kernel+bounces-135743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA89C89CAAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEB02894CB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B10143C60;
	Mon,  8 Apr 2024 17:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nZ4TR5Ma"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA15F14389C;
	Mon,  8 Apr 2024 17:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596982; cv=none; b=Ujd3PKRlPIA+r/xXwv1rVqLjwpns90Qf8l0CVQ0ETVoF43rQye98mOSxziPTG92IAgxrEZg1wMU0+s8UkVuk+lgSY+2ujxKgMEm+QRRH0F/yoSPeWq9LHN12glBs1+aI4Rq51merzxBwsksT5uha7fabah6frru7sLLefBvGpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596982; c=relaxed/simple;
	bh=PSdUNjxecv9/EH8TvrTsRyagADl80n4dir3Oe48bPOI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kfu7ZbcDYAMFKHi4mAh4FtzjwtXKKW2SQgl5VoMY/dYg/kXraCrx/MJTHZsi08H9EAutpi6tsWPip5ZEy4+XIgY82KT+oOkR9eIMFPV+WwkLFU1GDwCY02BLYBXVgqYlUgFa7yRt4olqVR72MxhJyXESgm4ndcEE+LK31PKrmNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nZ4TR5Ma; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712596981; x=1744132981;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PSdUNjxecv9/EH8TvrTsRyagADl80n4dir3Oe48bPOI=;
  b=nZ4TR5MaekUhIy6cDlE9WHE8T+dN9+EtVSydQAII/uojo83l+ZwaYsVR
   Jcd9TlCZQXZfEGm5VTRKBRsi+MIb2nIUA4K46QxdLoEZutGW0oseiTAEl
   tjxzm202gQk0k+XioylUh5yxByoDZe8+wVb6F/htyrtuZXpfNqEdkYn+N
   MupaR4/s3lDVHej3FfBgalVLD2TnHOTjFmJlo/3Nfge2d4jlmFyyhmQoL
   6V7d/n1krPFCaMOgGnoNs+xjW1RrojKVzt2FKUIIIestBl0mZe+xuDKn3
   g4oCh4jVb3sZh8b5n3vQt7IimLOSLwGv8S7UcNFUpSgbUPATljJGJgAL1
   w==;
X-CSE-ConnectionGUID: oghk6tjmQiakx4EFQSU6Ag==
X-CSE-MsgGUID: RRXlIi+0SU6okRH0KXMJpA==
X-IronPort-AV: E=McAfee;i="6600,9927,11038"; a="7757467"
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="7757467"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:23:00 -0700
X-CSE-ConnectionGUID: a8sq+q/VRRmRTSHSWV6cuw==
X-CSE-MsgGUID: OlpQj4e/SoSchFFOlUJeuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,187,1708416000"; 
   d="scan'208";a="24697460"
Received: from shahsmit-mobl1.amr.corp.intel.com (HELO [10.212.101.141]) ([10.212.101.141])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 10:22:59 -0700
Message-ID: <ba585faa-d761-45ed-9e44-784097b3439a@linux.intel.com>
Date: Mon, 8 Apr 2024 10:37:29 -0500
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: Intel: sof_rt5682: Fix uninitialized variable in
 probe
To: Dan Carpenter <dan.carpenter@linaro.org>, Brent Lu <brent.lu@intel.com>
Cc: Cezary Rojewski <cezary.rojewski@intel.com>,
 Liam Girdwood <liam.r.girdwood@linux.intel.com>,
 Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
 Bard Liao <yung-chuan.liao@linux.intel.com>,
 Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
 Kai Vehmanen <kai.vehmanen@linux.intel.com>, Mark Brown
 <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Terry Cheong <htcheong@chromium.org>,
 Uday M Bhat <uday.m.bhat@intel.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Mac Chiang <mac.chiang@intel.com>, apoorv <apoorv@intel.com>,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <6e16433f-1897-46a2-b3ee-e177e7d846b8@moroto.mountain>
Content-Language: en-US
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <6e16433f-1897-46a2-b3ee-e177e7d846b8@moroto.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/8/24 02:35, Dan Carpenter wrote:
> Initialize "is_legacy_cpu" to false to prevent an uninitialized variable
> bug.
> 
> Fixes: 8efcd4864652 ("ASoC: Intel: sof_rt5682: use common module for sof_card_private initialization")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Good catch.

Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
>  sound/soc/intel/boards/sof_rt5682.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/sof_rt5682.c b/sound/soc/intel/boards/sof_rt5682.c
> index aadd341a202c..966bcd3e8bdc 100644
> --- a/sound/soc/intel/boards/sof_rt5682.c
> +++ b/sound/soc/intel/boards/sof_rt5682.c
> @@ -606,7 +606,7 @@ static int sof_audio_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_acpi_mach *mach = pdev->dev.platform_data;
>  	struct sof_card_private *ctx;
> -	bool is_legacy_cpu;
> +	bool is_legacy_cpu = false;
>  	int ret;
>  
>  	if (pdev->id_entry && pdev->id_entry->driver_data)

