Return-Path: <linux-kernel+bounces-32975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137358362A9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85BA5298302
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1A53B194;
	Mon, 22 Jan 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a9fiQe6q"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37B23AC0F;
	Mon, 22 Jan 2024 11:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=134.134.136.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705924300; cv=none; b=lEXDm2wlMrGfLoXWoG0DzLFZNZ2799bTaQoZGA7YzitwMBYwbmhaxZBJTwvnOaY2uScB2hLLZ+7vzW8EeBy1GzpCi9+Qp+Ng2Boz1NBlcw8mDQvlZDyswmiCYOnVwohKtbVIE3A2V6F4cRyhfhm1kYtc4J9M1f3FNmI+9c+ogtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705924300; c=relaxed/simple;
	bh=8U5I3BA2WDzmDr+uJ4+nC3p4EXcojAiWBaxOyz8f4SY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MbGwBnHsiYqZq2rR6RkVQS8TJ1GKxNFsvBL0FkB8+rPLwTfa1lUIRw15YCOGxFkaI/oSCzbzpE0eYr7LHwYrsgdoKR7cZzY/uIE13n7y8iCBluTzjQ4e4wsnbCJnZKxonAvvMIlFsSkau4yZ1tXE2RK5BvDK+5IhdUWRzv5F+SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a9fiQe6q; arc=none smtp.client-ip=134.134.136.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705924298; x=1737460298;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8U5I3BA2WDzmDr+uJ4+nC3p4EXcojAiWBaxOyz8f4SY=;
  b=a9fiQe6qJKEz2wf/IjrF5eVCX1eABI5QoxtXFU8V4/Unys36cEC5u86h
   drPeOVOob4a/Kjm87LSsSfUa2KBH/LrgtehK7l7X1ARZ73d3XqY5LXdpW
   j+rLU6ed7m8pEC/wKrFPYwUsRgjdG8fs99m6YwOKyP0EUKllw2IiivfH2
   FWQfl/iY6gIIvf3hE+B3R9XIzajEe/Z/NjmU8dWQtrBcsDFOxVFA0kF0b
   sEKjp+3R3NrTyYa8hg67Oqz+4WvSricWDKzHrUCtzzGC6Unbuwe9fOqL9
   +Xa9ZYrI5dhfJtCDNOocSwx+GsZuS2pdAB+IlWP6KyfV4zrNHuTUwkaPl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="465448418"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="465448418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:51:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="928968818"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="928968818"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 03:51:36 -0800
Message-ID: <521ead90-0eb8-468a-a56c-557a6ae64564@linux.intel.com>
Date: Mon, 22 Jan 2024 12:51:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ALSA: hda: Increase default bdl_pos_adj for Apollo
 Lake
Content-Language: en-US
To: Rui Salvaterra <rsalvaterra@gmail.com>, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240122114512.55808-2-rsalvaterra@gmail.com>
 <20240122114512.55808-3-rsalvaterra@gmail.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240122114512.55808-3-rsalvaterra@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/22/2024 12:45 PM, Rui Salvaterra wrote:
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
> index 66f013ee160d..1b550c42db09 100644
> --- a/sound/pci/hda/hda_intel.c
> +++ b/sound/pci/hda/hda_intel.c
> @@ -1732,6 +1732,8 @@ static int default_bdl_pos_adj(struct azx *chip)
>   		case PCI_DEVICE_ID_INTEL_HDA_BYT:
>   		case PCI_DEVICE_ID_INTEL_HDA_BSW:
>   			return 32;
> +		case PCI_DEVICE_ID_INTEL_HDA_APL:
> +			return 64;
>   		}
>   	}
>   

Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

