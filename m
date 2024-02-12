Return-Path: <linux-kernel+bounces-61287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C19F6851064
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0051F2233F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B46E17C6B;
	Mon, 12 Feb 2024 10:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUbQvxKU"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A3C17BBE
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707732826; cv=none; b=ct6EijAsfDppGF5f8G+1+IxyLekU2W/sOUqkuWYwk3G818pH9fuvOivZH0wOSRvroO/8EsLNOJ1jzNTuVtSxpOc+OnUjbalXABHBo/4li8eEWNNi6HILcNmpotPGGSXKXG+OsMUJsUKASXHrtw1IBFI+w4dvcvSgfe+soBQsI7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707732826; c=relaxed/simple;
	bh=b5yCS+oa4RLidNsPnjoIz0El0jlSvCjtFpTobsF8c/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=p2R0XBl6+mBxw5kRfUqXqsqBtQkx7IcOcZ5PGxJ1CPsPajU9nLT1EGXS2Jj4vqrpAFsIJ8r9iPVy9ZIUH8B3+4i+LLLGKi3RI+Eimtrhb7OSbWcWxIBCpN7oTLwOGP9UtiX/ZoQScNN+y82Fi0qRWH9j8l19XkPV+d4Yr9vheTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUbQvxKU; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707732825; x=1739268825;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=b5yCS+oa4RLidNsPnjoIz0El0jlSvCjtFpTobsF8c/k=;
  b=BUbQvxKUpg7Wli9zzblglGb7nBEKV6tXP63ePzIB9UKoTFgZlM1PD5Tn
   awZSmLQGCeF3QucE4cCq4LXn7WQZZIo8NxSjaN8QDmAbCxNX1cce9l7s9
   /mxj9IfHcWGg+sun86jtHQwhCaK7ReB121MSpGbo+Gnu63HIo9xpwkfbD
   XLK8zDAdFffb2EspLMPlm9TRE7jPu7QDrz8Yqa2Tj209I06+gxnmrJLbN
   rE6K1M3WqK7NwM89cUh6IRyjYihs12agHjMqYU5TiUDYGFRUSuf8309sq
   VtzLphJj9fg/GNkqXmEEthbsF0UcCW993+Lgyxxepe0/jiigeOqiy44u3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10981"; a="1581057"
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="1581057"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:13:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,262,1701158400"; 
   d="scan'208";a="7296805"
Received: from belyakov-mobl.ccr.corp.intel.com (HELO localhost) ([10.252.63.91])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 02:13:39 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>
Cc: Paloma Arellano <quic_parellan@quicinc.com>, robdclark@gmail.com,
 freedreno@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
 intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 quic_jesszhan@quicinc.com, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/dp: add an API to indicate if sink supports VSC SDP
In-Reply-To: <20240210202704.977303-1-quic_abhinavk@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240210202704.977303-1-quic_abhinavk@quicinc.com>
Date: Mon, 12 Feb 2024 12:13:34 +0200
Message-ID: <87il2u9ei9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, 10 Feb 2024, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> From: Paloma Arellano <quic_parellan@quicinc.com>
>
> YUV420 format is supported only in the VSC SDP packet and not through
> MSA. Hence add an API which indicates the sink support which can be used
> by the rest of the DP programming.
>
> changes in v3:
> 	- fix the commit title prefix to drm/dp
> 	- get rid of redundant !!
> 	- break out this change from series [1] to get acks from drm core
> 	  maintainers
>
> Changes in v2:
> 	- Move VSC SDP support check API from dp_panel.c to
> 	  drm_dp_helper.c
>
> [1]: https://patchwork.freedesktop.org/series/129180/
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Paloma Arellano <quic_parellan@quicinc.com>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 21 +++++++++++++++++++++
>  include/drm/display/drm_dp_helper.h     |  1 +
>  2 files changed, 22 insertions(+)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index b1ca3a1100da..7a851f92b249 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2916,6 +2916,27 @@ void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
>  }
>  EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
>  
> +/**
> + * drm_dp_vsc_sdp_supported() - check if vsc sdp is supported
> + * @aux: DisplayPort AUX channel
> + * @dpcd: DisplayPort configuration data
> + *
> + * Returns true if vsc sdp is supported, else returns false
> + */
> +bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE])
> +{
> +	u8 rx_feature;
> +
> +	if (drm_dp_dpcd_readb(aux, DP_DPRX_FEATURE_ENUMERATION_LIST, &rx_feature) != 1) {
> +		drm_dbg_dp(aux->drm_dev, "failed to read DP_DPRX_FEATURE_ENUMERATION_LIST\n");
> +		return false;
> +	}
> +
> +	return (dpcd[DP_DPCD_REV] >= DP_DPCD_REV_13) &&
> +		(rx_feature & DP_VSC_SDP_EXT_FOR_COLORIMETRY_SUPPORTED);

I guess you could bail out early without further dpcd access with the
dpcd rev check?

BR,
Jani.


> +}
> +EXPORT_SYMBOL(drm_dp_vsc_sdp_supported);
> +
>  /**
>   * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
>   * @dpcd: DisplayPort configuration data
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index 863b2e7add29..948381b2b0b1 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -100,6 +100,7 @@ struct drm_dp_vsc_sdp {
>  
>  void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
>  			const struct drm_dp_vsc_sdp *vsc);
> +bool drm_dp_vsc_sdp_supported(struct drm_dp_aux *aux, const u8 dpcd[DP_RECEIVER_CAP_SIZE]);
>  
>  int drm_dp_psr_setup_time(const u8 psr_cap[EDP_PSR_RECEIVER_CAP_SIZE]);

-- 
Jani Nikula, Intel

