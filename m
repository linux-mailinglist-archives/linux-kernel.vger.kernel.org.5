Return-Path: <linux-kernel+bounces-32855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 167188360FA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C384A28C0C0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5254247F78;
	Mon, 22 Jan 2024 11:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5FDCqDh"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0A047F6E;
	Mon, 22 Jan 2024 11:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921533; cv=none; b=BDkNaMfwcFxWLXbtCJXZRwCP9yhDLMAoy6uZ+l3jWsoDayyHBmEosUZQzdRDBh8DHiYs1mJv7gfccf/N85F5obNIN+dtSI4Z3GEO8K2mHg2rzXbuGYWjaL+l520JM9HAvpJCkdBoIA3rAt+wo0qi6t6ygNmbttutK57qqe1l63k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921533; c=relaxed/simple;
	bh=6ZklisPid4pGWh8xv7uYvwv1UbtizZrGDGHyMTYB4L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n1dpCEpGbNBQKuSjU++lTHyN46g7lz1FLd1cAZYheh1Nl/uzvd6eotO7udHHv/yyPoKeCxepTXSfb0FIdUlw1tFqH7lRe9DIP8MCpw+7cb46QCDuq/bEpXc4Lp9FPANoQxS+/BPipZYrjllKl37d5YHz7TeUOXipBd5tOR0s2LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5FDCqDh; arc=none smtp.client-ip=192.55.52.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705921531; x=1737457531;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6ZklisPid4pGWh8xv7uYvwv1UbtizZrGDGHyMTYB4L8=;
  b=C5FDCqDhTaUHG0ua9N6SYd3zWI3RMZDNhYAzOYoJfWI4Ig0KTjeMEpeO
   BCO/HnqYF/rC7k0mcQxZVmphfpNbPzXRSJHLhaiO60anoMJOtieNN2Mdu
   5xdlM7doAmIt55seccfetCZInUOSm5ISsR+P/98YojGiHQP4FLEpkctEx
   a0KL9k5zjWvAJgxNvJM/V8CjBHKDtaA437qNKPoRtnvORKfNxddtJvB65
   rk6BIF4K6sopliFd4MXAKZNz87LnpZPQD2RGXYaxdCMlH/f9Drf+wMsTy
   6VO6IBwIevOftbcWyrNusHqjuLFSg0Qrp3RI0FZFdR9o6G/NSlGoyeaQH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="400046461"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="400046461"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="1255951"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:05:29 -0800
Message-ID: <0b6f3998-135f-4059-a8a8-e924281353f8@linux.intel.com>
Date: Mon, 22 Jan 2024 12:05:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
To: Rui Salvaterra <rsalvaterra@gmail.com>, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122092338.25047-2-rsalvaterra@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240122092338.25047-2-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/22/2024 10:23 AM, Rui Salvaterra wrote:
> Apollo Lake seems to also suffer from IRQ timing issues. After being up for ~4
> minutes, a Pentium N4200 system ends up falling back to workqueue-based IRQ
> handling:
> 
> [  208.019906] snd_hda_intel 0000:00:0e.0: IRQ timing workaround is activated
> for card #0. Suggest a bigger bdl_pos_adj.
> 
> Unfortunately, the Baytrail and Braswell workaround value of 32 samples isn't
> enough to fix the issue here. Default to 64 samples.
> 
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>   sound/pci/hda/hda_intel.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
> index 2276adc84478..9fb54813693c 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1732,6 +1732,8 @@ static int default_bdl_pos_adj(struct azx *chip)
>   		case 0x0f04: /* Baytrail */
>   		case 0x2284: /* Braswell */
>   			return 32;
> +		case 0x5a98: /* Apollo Lake */
> +			return 64;
>   		}
>   	}
>   

And seems like I've missed some IDs, when doing PCI IDs conversion. 
Anyway, can you use PCI_DEVICE_ID_INTEL_HDA_APL instead of 0x5a98 as it 
is self describing (no need for comment)?

And if you want more patches in kernel - convert first 0x0f04 & 0x2284 
to PCI_DEVICE_ID_INTEL_HDA_BYT & PCI_DEVICE_ID_INTEL_HDA_BSW and then do 
the above change ;)

