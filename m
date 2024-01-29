Return-Path: <linux-kernel+bounces-44212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA3BC841EE7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A652128D897
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B458ABA;
	Tue, 30 Jan 2024 09:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WWOOqlyo"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B663537E0;
	Tue, 30 Jan 2024 09:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706605887; cv=none; b=tmJc8S0ZO78LlwbcF/z59Nn1K1AFxTztRXlcwthPn/AheKJOOOAauOBo3UNKQdGlWjZzuEDDVhm5bjCggSs8Qm/2YNY/ADqG0RSUDr3JdSAbN+6dXHObEw97PAYd0VJ64lQBgftPx3/JVC4acLA7nHHWCuA3hEHpr6oBl0i6xaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706605887; c=relaxed/simple;
	bh=RvaoRqi6d2649HMPir89XZBkoGY4LvB2aJ08/fzLesM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwIoCxdBp5hZxuRZ25uccirHrW/xfc0uVG65KgwzNU77ZrQN2wRDHLXoWE7NYYqqMHhr3ZQLGTy4K8VyAoKNRnAnbWZTY0NBXZoozc/ZD0dDNnym1AbiOKYVH/Ybn5vqo8RcBhnnCFPT1obXy9xSQ0R6a+pOodnUwbPGjiXYm1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WWOOqlyo; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706605885; x=1738141885;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=RvaoRqi6d2649HMPir89XZBkoGY4LvB2aJ08/fzLesM=;
  b=WWOOqlyobAZ/aHu/H5+bqb2uPi9W00i74sxn2oTn9h3jOe9lwbLRmQG7
   C6y12SuuoOW3selaV5Ut3dycE9IyRJ4Ar88Th5fm3j38D/kD69PrkigyM
   hSLHmKZP1JaKGsBf/Y00ad3FzQ6aRMwwt6+bVW8+uswOTm7fiz8X50b2/
   84MoCEeBw45Tc7NXk5wBTEZo+R8tLTaPOyTP3MZH1NoyiaDLTAnWLLneY
   INZxTRykTqeuMVslw0IF4RLP8kKKJarfRdW5nyXzNX+fwICWxkrEM0QtV
   fS0iiCXNG0pxEFi9VbE2kC3EzN6/xWvhieuTpxML5Tt/S83o4A7ep2Y3V
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="3055983"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="3055983"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:08:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="931378461"
X-IronPort-AV: E=Sophos;i="6.05,707,1701158400"; 
   d="scan'208";a="931378461"
Received: from vkamysba-mobl1.amr.corp.intel.com (HELO [10.254.116.178]) ([10.254.116.178])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 01:07:25 -0800
Message-ID: <4f54a12c-c8a3-414c-b4df-3f7b25e6d524@linux.intel.com>
Date: Mon, 29 Jan 2024 18:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/18] ASoC: cs35l56: Fix default SDW TX mixer registers
Content-Language: en-US
To: Richard Fitzgerald <rf@opensource.cirrus.com>, broonie@kernel.org,
 tiwai@suse.com
Cc: alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
References: <20240129162737.497-1-rf@opensource.cirrus.com>
 <20240129162737.497-9-rf@opensource.cirrus.com>
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20240129162737.497-9-rf@opensource.cirrus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/29/24 17:27, Richard Fitzgerald wrote:
> Patch the SDW TX mixer registers to silicon defaults.
> 
> CS35L56 is designed for SDCA and a generic SDCA driver would
> know nothing about these chip-specific registers. So the
> firmware sets up the SDW TX mixer registers to whatever audio
> is relevant on a specific system.
> 
> This means that the driver cannot assume the initial values
> of these registers. But Linux has ALSA controls to configure
> routing, so the registers can be patched to silicon default and
> the ALSA controls used to select what audio to feed back to the
> host capture path.

humm, which has the precedence then?
a) the values set by firmware
b) the default values set by the driver?

Also if the firmware touches those registers shouldn't they be marked as
'volatile'?


> Backport note:
> This won't apply to kernels older than v6.6.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
> Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
> ---
>  sound/soc/codecs/cs35l56-shared.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/sound/soc/codecs/cs35l56-shared.c b/sound/soc/codecs/cs35l56-shared.c
> index 35789ffc63af..a812abf90836 100644
> --- a/sound/soc/codecs/cs35l56-shared.c
> +++ b/sound/soc/codecs/cs35l56-shared.c
> @@ -12,6 +12,15 @@
>  #include "cs35l56.h"
>  
>  static const struct reg_sequence cs35l56_patch[] = {
> +	/*
> +	 * Firmware can change these to non-defaults to satisfy SDCA.
> +	 * Ensure that they are at known defaults.
> +	 */
> +	{ CS35L56_SWIRE_DP3_CH1_INPUT,		0x00000018 },
> +	{ CS35L56_SWIRE_DP3_CH2_INPUT,		0x00000019 },
> +	{ CS35L56_SWIRE_DP3_CH3_INPUT,		0x00000029 },
> +	{ CS35L56_SWIRE_DP3_CH4_INPUT,		0x00000028 },
> +
>  	/* These are not reset by a soft-reset, so patch to defaults. */
>  	{ CS35L56_MAIN_RENDER_USER_MUTE,	0x00000000 },
>  	{ CS35L56_MAIN_RENDER_USER_VOLUME,	0x00000000 },

