Return-Path: <linux-kernel+bounces-33723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE58836DB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EC6B1C24D1D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3582B5A0EF;
	Mon, 22 Jan 2024 16:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aiVJbN7N"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63259B59;
	Mon, 22 Jan 2024 16:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705942209; cv=none; b=K41dF8zWRbO/YGoB+8VH06vIuGqoaWlkh4ZVf43IkA4cK1Tyb8NrT7vDgjPfGQ6noLkfkuAj0dJxvpAt9sRzolZLQey+Dkt0zWKIXhg/FmxKUa9YXD+FvPL0DPrz5Ztc6qi0w7d4do8ev0CEFSi20550is8Er3Hsz7L7asqp2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705942209; c=relaxed/simple;
	bh=EZEN8wunnYsDyYg7Dr1Xlc4lB1BxwhqBccW9u8ITo2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0bxwet5iw+5hrKrvt8QAGJJzSBME9TLRQco54CIi530kTYHRViwx5mSD2adNsBmHzsX3X4WlkxPhBGsVpsZ65csipcvaM9DwUoMO0xTojR2/MWx55gUXoC7evY3WYORFl6Bq6Eun+Vp3bbhTEpzfCeaGfLOHNumYNxqEtW1xaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aiVJbN7N; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705942207; x=1737478207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EZEN8wunnYsDyYg7Dr1Xlc4lB1BxwhqBccW9u8ITo2Q=;
  b=aiVJbN7NVienxuHBqv0OhpNx/Snp95z2mVkzKrtd8P9ULKF4+HCQPLk3
   h6jG7mwM2BRJQUlknIy253jSavKv/naIuJB2yu31hn9UmwtFdBD7gsYSZ
   94FNLGV6lE6Evc/k39foGEroI/NieY19BFb1QddarsXqsgI/aoebjGpsi
   5KeM2zCGqyIJSL2HGGeZ4+P3WGrS+NtvDNxydJukaYMkTaI0+I9gNdjTX
   PQbCRm2mvA6bRxrjGHvU3uP7BhijtaYHsQlh3RzCXpMcgGLh6PaurTNL0
   eeS3TniadhEm1g8KpfltOdrU4U6tBp6bAMRCsYfQqI5spPkT0k1/nFre5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="150555"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="150555"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:50:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819776348"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819776348"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 22 Jan 2024 08:50:01 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 22 Jan 2024 18:50:00 +0200
Date: Mon, 22 Jan 2024 18:50:00 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	maarten.lankhorst@linux.intel.com, tzimmermann@suse.de,
	airlied@gmail.com, daniel@ffwll.ch, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 04/53] drm: Fix color LUT rounding
Message-ID: <Za6ano6dg0Mau7OI@intel.com>
References: <20240122150949.994249-1-sashal@kernel.org>
 <20240122150949.994249-4-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240122150949.994249-4-sashal@kernel.org>
X-Patchwork-Hint: comment

On Mon, Jan 22, 2024 at 10:08:05AM -0500, Sasha Levin wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> [ Upstream commit c6fbb6bca10838485b820e8a26c23996f77ce580 ]

Why is this being backported?

> 
> The current implementation of drm_color_lut_extract()
> generates weird results. Eg. if we go through all the
> values for 16->8bpc conversion we see the following pattern:
> 
> in            out (count)
>    0 -   7f ->  0 (128)
>   80 -  17f ->  1 (256)
>  180 -  27f ->  2 (256)
>  280 -  37f ->  3 (256)
> ...
> fb80 - fc7f -> fc (256)
> fc80 - fd7f -> fd (256)
> fd80 - fe7f -> fe (256)
> fe80 - ffff -> ff (384)
> 
> So less values map to 0 and more values map 0xff, which
> doesn't seem particularly great.
> 
> To get just the same number of input values to map to
> the same output values we'd just need to drop the rounding
> entrirely. But perhaps a better idea would be to follow the
> OpenGL int<->float conversion rules, in which case we get
> the following results:
> 
> in            out (count)
>    0 -   80 ->  0 (129)
>   81 -  181 ->  1 (257)
>  182 -  282 ->  2 (257)
>  283 -  383 ->  3 (257)
> ...
> fc7c - fd7c -> fc (257)
> fd7d - fe7d -> fd (257)
> fe7e - ff7e -> fe (257)
> ff7f - ffff -> ff (129)
> 
> Note that since the divisor is constant the compiler
> is able to optimize away the integer division in most
> cases. The only exception is the _ULL() case on 32bit
> architectures since that gets emitted as inline asm
> via do_div() and thus the compiler doesn't get to
> optimize it.
> 
> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Link: https://patchwork.freedesktop.org/patch/msgid/20231013131402.24072-2-ville.syrjala@linux.intel.com
> Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> Acked-by: Maxime Ripard <mripard@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  include/drm/drm_color_mgmt.h | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)
> 
> diff --git a/include/drm/drm_color_mgmt.h b/include/drm/drm_color_mgmt.h
> index 81c298488b0c..54b2b2467bfd 100644
> --- a/include/drm/drm_color_mgmt.h
> +++ b/include/drm/drm_color_mgmt.h
> @@ -36,20 +36,17 @@ struct drm_plane;
>   *
>   * Extract a degamma/gamma LUT value provided by user (in the form of
>   * &drm_color_lut entries) and round it to the precision supported by the
> - * hardware.
> + * hardware, following OpenGL int<->float conversion rules
> + * (see eg. OpenGL 4.6 specification - 2.3.5 Fixed-Point Data Conversions).
>   */
>  static inline u32 drm_color_lut_extract(u32 user_input, int bit_precision)
>  {
> -	u32 val = user_input;
> -	u32 max = 0xffff >> (16 - bit_precision);
> -
> -	/* Round only if we're not using full precision. */
> -	if (bit_precision < 16) {
> -		val += 1UL << (16 - bit_precision - 1);
> -		val >>= 16 - bit_precision;
> -	}
> -
> -	return clamp_val(val, 0, max);
> +	if (bit_precision > 16)
> +		return DIV_ROUND_CLOSEST_ULL(mul_u32_u32(user_input, (1 << bit_precision) - 1),
> +					     (1 << 16) - 1);
> +	else
> +		return DIV_ROUND_CLOSEST(user_input * ((1 << bit_precision) - 1),
> +					 (1 << 16) - 1);
>  }
>  
>  u64 drm_color_ctm_s31_32_to_qm_n(u64 user_input, u32 m, u32 n);
> -- 
> 2.43.0

-- 
Ville Syrjälä
Intel

