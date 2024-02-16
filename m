Return-Path: <linux-kernel+bounces-68563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22813857C72
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1945286405
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 12:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F18278B56;
	Fri, 16 Feb 2024 12:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jSIIGRyS"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868154F92;
	Fri, 16 Feb 2024 12:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708086012; cv=none; b=Yd5tvanxtlqkO1CRlY70yplaq9f/Eh9lI5vi15XlZYrwCFrScagU82raRCJrV4tMiJtlPLkH/w0HMTBzsT8HVLb+1VBLT0Y6ck1lG2LgEr2A6qB3SvWCg2b9fYiop/+T847W7g0QXA1cYWmeyRK6k6xwbuU+qBYDu6gIqbpUSwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708086012; c=relaxed/simple;
	bh=C1oxywUq64oqrzy/WRVZCjsNy7F0xfzOO3QucocTZ+0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=jZXmUuyDsHGpvpXZjK9NZMZGgdYrlgWeIyJW3CvdW4pRH+Ts0iZZlT8KQtJMpIlRyum4xbnEgADDUPY857+eZ/OHOMrrIfgSkEN2ES8UNEWJdQhipjR82DCKJvJo1I5PQiqU6TQsFWUtdFXMwQqAJTxcGJFQ8owJ0uzuLHUo+q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jSIIGRyS; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708086011; x=1739622011;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=C1oxywUq64oqrzy/WRVZCjsNy7F0xfzOO3QucocTZ+0=;
  b=jSIIGRySa26WcdWlqqwayFX2l3jjwPTEMvqMXu2Zjw961YALGIhiwKSQ
   mdj1BN0lgBHD77YhL/YPsSSg6qlppyLyHb1g/FY8Dpo00QZnFDbun+4tj
   k88jUWXq+jk9DLhlQ0VxrjQVE5/pXrN+F/W9vGi2rpvkg/N/r9bwoFzqk
   MqauntKke4235gAafIo8iaFeTXYPx1VcqEOrpmUYhDTmRmwRiwZuIHlpk
   HwMtLbCDEoBUHOvswVFMLVDiiSjxKGGD1/bKP8d9STdqW3poTwL0P9Q/f
   xSONop9HtdYXL0Ehi33UTc5oRlVnAQP2SF+TQpkOc2bUFm0VuKU1W1rFK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="2362098"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="2362098"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:20:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="4118732"
Received: from eliteleevi.tm.intel.com ([10.237.54.20])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 04:20:08 -0800
Date: Fri, 16 Feb 2024 14:19:54 +0200 (EET)
From: Kai Vehmanen <kai.vehmanen@linux.intel.com>
X-X-Sender: kvehmane@eliteleevi.tm.intel.com
To: Takashi Iwai <tiwai@suse.de>
cc: Hillf Danton <hdanton@sina.com>, Sven van Ashbrook <svenva@chromium.org>, 
    Karthikeyan Ramasubramanian <kramasub@chromium.org>, 
    LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
    linux-sound@vger.kernel.org, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
    "Arava, Jairaj" <jairaj.arava@intel.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu
 case
In-Reply-To: <87frxsiueo.wl-tiwai@suse.de>
Message-ID: <alpine.DEB.2.22.394.2402161246520.14041@eliteleevi.tm.intel.com>
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid> <20240215034528.240-1-hdanton@sina.com> <87h6iaf7di.wl-tiwai@suse.de> <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com> <875xypk6d6.wl-tiwai@suse.de>
 <20240216043426.1218-1-hdanton@sina.com> <87plwwiz6z.wl-tiwai@suse.de> <87frxsiueo.wl-tiwai@suse.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7 02160 Espoo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi,

On Fri, 16 Feb 2024, Takashi Iwai wrote:

> On Fri, 16 Feb 2024 09:35:32 +0100, Takashi Iwai wrote:
> > The fact that we have to drop __GFP_RETRY_MAYFAIL indicates that the
> > handling there doesn't suffice -- at least for the audio operation.
> 
> Reconsidering on this again, I wonder keeping __GFP_RETRY_MAYFAIL
> makes sense.  We did have __GFP_NORETRY for avoiding OOM-killer.
> But it's been over ages, and the memory allocation core became smart
> enough.
> 
> The side-effect of __GFP_RETRY_MAYFAIL is that the page reclaim and
> compaction happens even for high-order allocations, and that must be

for the original problem that led to "ALSA: memalloc: use 
__GFP_RETRY_MAYFAIL for DMA mem allocs", reclaim for low-order case
would be enough. I.e. the case was:

> OTOH, a slight concern with the drop of __GFP_RETRY_MAYFAIL is whether
> allowing OOM-killer for low order allocations is acceptable or not.
> 
> There are two patterns of calling allocators:
[..]
> 3. SNDRV_DMA_TYPE_NONCONTIG for large size:
>    this is called often, once per stream open, since the driver
>    doesn't keep the buffer.

So with SOF we have additional case where we do an allocation for the DSP 
firmware (snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV_SG, ...)) and this is 
called at system resume. With s/__GPF_RETRY_MAYFAIL/__GFP_NORETRY/, these 
allocations failed (on a iommu enabled Chromebook) at system resume in a 
case where system was not really running out of memory (reclaim was 
possible). A failed allocation means there's no audio in the system after 
resume, so we want to try harder.

But yeah, I think the proposed handling for (3) category would work. If 
needed, we can further specialize the DSP firmware case with some hint 
to snd_dma_alloc_pages().

Br, Kai

