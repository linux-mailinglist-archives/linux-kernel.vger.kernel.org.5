Return-Path: <linux-kernel+bounces-47927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C227B8454BD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B66A290794
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7242615B0FE;
	Thu,  1 Feb 2024 10:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTO+TCCk"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB064DA0A
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781805; cv=none; b=LGDT+jPcThxv/qebHBZXRtBFHiTnmKkQ5jQHW3H+KRNaqJ9+aG9065qQTqAQ5UkT8KprikDsOvCQXDyxVVg1iZQXEb61vqCmdpKLWD3SHD1+kuRMUYX3t62JA+FZvPaxLwTnhCTL3wItnYyqhh//AMO3IT88EtYqeW9wvMtjmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781805; c=relaxed/simple;
	bh=SMbbGGWUmvD7XTGC4Ymv5iB6mMaT4d+KU3zA8ododTc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jf6N+nLIK9HayWRpcTHE1LggLdVlKpo+msjr86ai3jpYbne3HcKV7pwfMK0WBlrEM0ujrdY28XbU7dze9IHDowopA0D2waMPX96QtvLHsv3yvjpcFEIlvA0/RjIZw45H/tUsUM7xUWePqJ+kglOX7TjtuTO2V/dbeRDPsdymNKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTO+TCCk; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706781803; x=1738317803;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=SMbbGGWUmvD7XTGC4Ymv5iB6mMaT4d+KU3zA8ododTc=;
  b=JTO+TCCkWHeijeH1wfaj8IlzyBmOdjSORpbwhPjOOOg96kGdZxRv+2Mu
   3TgpWKRv6LKicJXr4e5S5X+1NSO9Clc9o9BEIiXbbRtHZzXkGq53yhr0P
   wXdz2to1or/P7hgSJnNkyR6WQRFqnIhbyiz3mxsGnuZ5GUi4ymAK8jhFS
   FQrKqPOBrWiDmtOMo3O/A3Rdw4/vUEvldk0EDT6YIIIZpZ8eKLCi8+82n
   lD+nCsxY+7dDlnoD707jgBOzRNSxTRRUHIMql6SEBF4rroqPw4aha6CDN
   +9NnmLZ/u+7tFAHeaZkd9YtJcI2HwmuubUsi2WGsNtQI2xRA5fJe/QeEQ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="41742"
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="41742"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 02:03:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,234,1701158400"; 
   d="scan'208";a="42236"
Received: from aragners-mobl.ger.corp.intel.com (HELO localhost) ([10.252.43.111])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2024 02:03:18 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Cong Liu <liucong2@kylinos.cn>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Cong Liu <liucong2@kylinos.cn>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/modes: Replace deprecated simple_strtol with kstrtol
In-Reply-To: <20240201070226.3292315-1-liucong2@kylinos.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240201070226.3292315-1-liucong2@kylinos.cn>
Date: Thu, 01 Feb 2024 12:03:15 +0200
Message-ID: <87frych57g.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 01 Feb 2024, Cong Liu <liucong2@kylinos.cn> wrote:
> This patch replaces the use of the deprecated simple_strtol [1] function
> in the drm_modes.c file with the recommended kstrtol function. This change
> improves error handling and boundary checks.
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#simple-strtol-simple-strtoll-simple-strtoul-simple-strtoull
>
> Signed-off-by: Cong Liu <liucong2@kylinos.cn>

This is completely wrong, and obviously not tested at all.

The recommended replacements are *not* drop-in replacements. Look into
the documentation of the functions.

BR,
Jani.

> ---
>  drivers/gpu/drm/drm_modes.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_modes.c b/drivers/gpu/drm/drm_modes.c
> index 893f52ee4926..fce0fb1df9b2 100644
> --- a/drivers/gpu/drm/drm_modes.c
> +++ b/drivers/gpu/drm/drm_modes.c
> @@ -1942,7 +1942,7 @@ static int drm_mode_parse_cmdline_bpp(const char *str, char **end_ptr,
>  		return -EINVAL;
>  
>  	str++;
> -	bpp = simple_strtol(str, end_ptr, 10);
> +	bpp = kstrtol(str, end_ptr, 10);
>  	if (*end_ptr == str)
>  		return -EINVAL;
>  
> @@ -1961,7 +1961,7 @@ static int drm_mode_parse_cmdline_refresh(const char *str, char **end_ptr,
>  		return -EINVAL;
>  
>  	str++;
> -	refresh = simple_strtol(str, end_ptr, 10);
> +	refresh = kstrtol(str, end_ptr, 10);
>  	if (*end_ptr == str)
>  		return -EINVAL;
>  
> @@ -2033,7 +2033,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
>  	int remaining, i;
>  	char *end_ptr;
>  
> -	xres = simple_strtol(str, &end_ptr, 10);
> +	xres = kstrtol(str, &end_ptr, 10);
>  	if (end_ptr == str)
>  		return -EINVAL;
>  
> @@ -2042,7 +2042,7 @@ static int drm_mode_parse_cmdline_res_mode(const char *str, unsigned int length,
>  	end_ptr++;
>  
>  	str = end_ptr;
> -	yres = simple_strtol(str, &end_ptr, 10);
> +	yres = kstrtol(str, &end_ptr, 10);
>  	if (end_ptr == str)
>  		return -EINVAL;
>  
> @@ -2100,7 +2100,7 @@ static int drm_mode_parse_cmdline_int(const char *delim, unsigned int *int_ret)
>  		return -EINVAL;
>  
>  	value = delim + 1;
> -	*int_ret = simple_strtol(value, &endp, 10);
> +	*int_ret = kstrtol(value, &endp, 10);
>  
>  	/* Make sure we have parsed something */
>  	if (endp == value)

-- 
Jani Nikula, Intel

