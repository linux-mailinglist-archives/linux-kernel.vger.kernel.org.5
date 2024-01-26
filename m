Return-Path: <linux-kernel+bounces-39870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34AA83D6DD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:51:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10CEB1C2DBBC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BF556B60;
	Fri, 26 Jan 2024 09:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5A3qq6f"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6325644F;
	Fri, 26 Jan 2024 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259677; cv=none; b=B6uVBYvOhsSRiRXEmt7+zbNh1bpIBnSE6ib+KZpfogoL4Pn7XOOs0Wv/CSaWZU0sAfjDnypeSbIrkpMN653K+B4kERa5wbUt8cjQS6CHgouQjGBY1EAu/cPYvFt9Y1vnZ58QGg0jJ2J6LRoGWuELcNYnldTYgOkL4vDsjW78b4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259677; c=relaxed/simple;
	bh=bP6Pbyf0/1RfHTaipWWafRkw8/+6vZ8iLbsE5ssVdRc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZEdUv34rzgBFM6+bHloxBSllHrFfALLWDbWjjczY6AKyAGgxqPaXatHYw0Qp5GSyBjSQO8VADRe+SKd/evR30bwt9H5hueSEIEznBHKBv/PtEmJja9cZfSHrfmUJ8DdgBBBTD7BCJMC1oCvak3bUuePUMN2Lk9AYEIHs94toO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5A3qq6f; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706259676; x=1737795676;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bP6Pbyf0/1RfHTaipWWafRkw8/+6vZ8iLbsE5ssVdRc=;
  b=Q5A3qq6faFr3U7uA3r7Mgyck6mwqXjucNC6tWz/ke3RP2dr9s7N0+R9n
   lfjBLmNddxg6/lQUFw7JXsMD5WrFWfNXCkhN7HFHoshng2IzrNX5KmpiY
   z8843SE78XQmWb0AnElKjAl6d8iUjEWbsRINLnPhyQzZrj5QhSIq3MlhU
   k1EyYjdi24l4KD0xCvcXLQx5Lja2RJch0uJ7rFgiPJ/b8L0/Fkd5na8I/
   /IK94fK9w3Jb8KXCDD7EB4ybRg9yuOhFCT/fubc1apP6OOPSbNlPUoDe2
   BNYXOF6K/WfNqpxDCJHOduv7FcK3/+1DGlxN014ooIfNx8co8AR4HHF2j
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="2260496"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="2260496"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:01:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="787043910"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="787043910"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.8.107]) ([10.94.8.107])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jan 2024 01:01:13 -0800
Message-ID: <3b5bf4b7-a4ec-44be-975b-04590777a965@linux.intel.com>
Date: Fri, 26 Jan 2024 10:01:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ALSA: pcm: Add missing formats to formats list
Content-Language: en-US
To: Ivan Orlov <ivan.orlov0322@gmail.com>, perex@perex.cz, tiwai@suse.com
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20240125223522.1122765-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/25/2024 11:35 PM, Ivan Orlov wrote:
> Add 4 missing formats to 'snd_pcm_format_names' array in order to be
> able to get their names with 'snd_pcm_format_name' function.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>   sound/core/pcm.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/sound/core/pcm.c b/sound/core/pcm.c
> index a09f0154e6a7..d0788126cbab 100644
> --- a/sound/core/pcm.c
> +++ b/sound/core/pcm.c
> @@ -211,6 +211,10 @@ static const char * const snd_pcm_format_names[] = {
>   	FORMAT(DSD_U32_LE),
>   	FORMAT(DSD_U16_BE),
>   	FORMAT(DSD_U32_BE),
> +	FORMAT(S20_LE),
> +	FORMAT(S20_BE),
> +	FORMAT(U20_LE),
> +	FORMAT(U20_BE),
>   };
>   
>   /**

Maybe we can also add some kind of static_assert to check at compile 
time that all formats are handled, something like:
static_assert(ARRAY_SIZE(snd_pcm_format_names) == SNDRV_PCM_FORMAT_LAST 
+ 1);

Although looking at definitions there is a hole between 
SNDRV_PCM_FORMAT_U20_BE & SNDRV_PCM_FORMAT_SPECIAL, which will cause 
this idea to fail.

Perhaps with comment:
static_assert(ARRAY_SIZE(snd_pcm_format_names) == SNDRV_PCM_FORMAT_LAST 
+ 1 - 2); /* -2 for formats reserved for future use */
?

