Return-Path: <linux-kernel+bounces-32974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE1728362A8
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:53:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FE451F2A775
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708173A8FC;
	Mon, 22 Jan 2024 11:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lScOjwsO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B03A1A2;
	Mon, 22 Jan 2024 11:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924270; cv=none; b=K/xLeV5WPeE8KvGIcHhKjqKWN6sf2LZDa3CTrq90sKV3etF2W38kBdstsFzL8wiPWp0Q1hrADIf33GzQbe0woYo2t0za5hx/sJl9rkmd9xTrJGboo91lhrSnjUr5rHWZ29lbAu6Im0zClEXWoPHK36Z4Ci9tZKeUKPZbiychacU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924270; c=relaxed/simple;
	bh=R5qPfOY2yMDbPjZwN9+6J1nkzleSUXE5Ry2YBndlaVo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bO9r8WPNVsr9Yqoimf0Flr6mIbuc4nJkBmTP6WlcWc612+cfZgkeKnwasfPMncCEKSawsC2dcIIxKrIm2Qu9ZuCPMp9syesNYYv3Zhm0RwlL3DyvhfTI9Q8t2VdO9ja2ullzUBIOtEAIyL2dG1Nvrf7JweBg0/ZYoS5CN3CswRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lScOjwsO; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705924268; x=1737460268;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R5qPfOY2yMDbPjZwN9+6J1nkzleSUXE5Ry2YBndlaVo=;
  b=lScOjwsO15dgV6/U9Jr6D6AiG6RXsHMo2oIKDO4ONi+J5trDGOISBIK7
   ao+OCA9LGy3zpyQ+Dc6PqmButV+cETpFWO5BfDE197cKGkIzqf5Khgu+/
   ldZqfDei4WN29Pn7AqEx1fcEXskF3sirwo8kjjTUjHoclVl1TA/6MlI4Y
   sDzgcaJuL4aQj5Ayqvidp4c1SBU/1E2s1pUB2d/uZIFSnLe5TUaaippZq
   lNUlnpnWFr2sdG21zAOX6jQnDD2w0xKoIp/UxkcNG/N/KRmow8jJjCVmx
   Qc4+poi/rrgHFZScfC3FHSHLPYwAxtZbXYhiSgGi3foYeLA9hOkl+IkOE
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="465448306"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="465448306"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:51:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="928968630"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="928968630"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:51:05 -0800
Message-ID: <c21377fb-da4c-4cdb-994c-e469d4cb1e46@linux.intel.com>
Date: Mon, 22 Jan 2024 12:51:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ALSA: hda: Replace numeric device IDs with constant
 values
Content-Language: en-US
To: Rui Salvaterra <rsalvaterra@gmail.com>, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122114512.55808-2-rsalvaterra@gmail.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240122114512.55808-2-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/2024 12:45 PM, Rui Salvaterra wrote:
> We have self-explanatory constants for Intel HDA devices, let's use them instead
> of magic numbers and code comments.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>   sound/pci/hda/hda_intel.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 2276adc84478..66f013ee160d 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1729,8 +1729,8 @@ static int default_bdl_pos_adj(struct azx *chip)
>   	/* some exceptions: Atoms seem problematic with value 1 */
>   	if (chip->pci->vendor == PCI_VENDOR_ID_INTEL) {
>   		switch (chip->pci->device) {
> -		case 0x0f04: /* Baytrail */
> -		case 0x2284: /* Braswell */
> +		case PCI_DEVICE_ID_INTEL_HDA_BYT:
> +		case PCI_DEVICE_ID_INTEL_HDA_BSW:
>   			return 32;
>   		}
>   	}

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

