Return-Path: <linux-kernel+bounces-68380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F40857975
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1E09280DEA
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE9725551;
	Fri, 16 Feb 2024 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c9JY2yn4"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAE124B39
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 09:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708077126; cv=none; b=JLzVgQcuSWrV/6l/oK1VXABbDXAtDZwwUOQCuu8qthgRFw/1CiAmEXiIhQLc8bf8smPhtAe5kFTNHadqNOP+zHvi3emM/FoQQvw8zVBN7kLSQqZb1TqbWwssJXK5NKy/EleEFrT+2p/iVdr1mIaCv6rTEQupcMpwqprppQ+D6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708077126; c=relaxed/simple;
	bh=1DmYPShGc1WqUllF/gBgHGJAcAVWQWXf2YSAvLKPay0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mj0eLrvRRmDrQqSBCsDWTacUoM9CA/5KdRmL3TloFNu8/MiW1S+nsoqfSD4fTn//V2YFyebVg5uJarP/fFwtc6SJAlVO7zBMI/1+8oPb5VZ1qHHKkytZMqfOXsdv+cCR3M4mYyIsNo3L3W8MvO3RxbQ/52CTfR8rbo8abff8tik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c9JY2yn4; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708077124; x=1739613124;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=1DmYPShGc1WqUllF/gBgHGJAcAVWQWXf2YSAvLKPay0=;
  b=c9JY2yn4aIqQXuMhK47puFQnbOrYO7GPCZliex8X34k7QMZ+ypIMo7xQ
   HR0ifF53J9uQDmXMJCjl3DINRTTD3QGZW+QzU8RuUGlqmq4E9TebCs+6z
   mwUhQZjWeEVbMFKG47hq5t4Xo4ESCkfgEv/TfOsUCMiH7ZSNY2r0qqLnA
   eZoEYiHC1UuLQ3GAfbev2ONpGDdoMuJzPgCEvtMCndAAXVlZpR/OL8Is5
   lblJKPTF0OfAjd6dyxOMHrWy20s8NnP/7O42TBJT2YKG1O9jmY8zzyrMU
   NwmnneuZ9RlBuGwGTKo1g6Po2SX8kV6ddKeDtLI9aIRyxDdu7k+apxV36
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="13305122"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="13305122"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:52:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="935815479"
X-IronPort-AV: E=Sophos;i="6.06,164,1705392000"; 
   d="scan'208";a="935815479"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO localhost) ([10.252.48.79])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2024 01:51:57 -0800
From: Jani Nikula <jani.nikula@linux.intel.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel@lists.freedesktop.org, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin
 <tvrtko.ursulin@linux.intel.com>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, robdclark@gmail.com,
 freedreno@lists.freedesktop.org, dmitry.baryshkov@linaro.org,
 intel-gfx@lists.freedesktop.org, ville.syrjala@linux.intel.com,
 quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org,
 intel-xe@lists.freedesktop.org
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
In-Reply-To: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
Date: Fri, 16 Feb 2024 11:51:54 +0200
Message-ID: <87eddc4tz9.fsf@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, 15 Feb 2024, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> Lets move this to drm_dp_helper to achieve this.
>
> changes in v2:
> 	- rebased on top of drm-tip
>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

Acked-by: Jani Nikula <jani.nikula@intel.com>

> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 78 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 71 +---------------------
>  include/drm/display/drm_dp_helper.h     |  3 +
>  3 files changed, 83 insertions(+), 69 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index 8d6ce46471ae..6c91f400ecb1 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2913,6 +2913,84 @@ void drm_dp_vsc_sdp_log(struct drm_printer *p, const struct drm_dp_vsc_sdp *vsc)
>  }
>  EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
>  
> +/**
> + * drm_dp_vsc_sdp_pack() - pack a given vsc sdp into generic dp_sdp
> + * @vsc: vsc sdp initialized according to its purpose as defined in
> + *       table 2-118 - table 2-120 in DP 1.4a specification
> + * @sdp: valid handle to the generic dp_sdp which will be packed
> + * @size: valid size of the passed sdp handle
> + *
> + * Returns length of sdp on success and error code on failure
> + */
> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> +			    struct dp_sdp *sdp, size_t size)
> +{
> +	size_t length = sizeof(struct dp_sdp);
> +
> +	if (size < length)
> +		return -ENOSPC;
> +
> +	memset(sdp, 0, size);
> +
> +	/*
> +	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> +	 * VSC SDP Header Bytes
> +	 */
> +	sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> +	sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> +	sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> +	sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> +
> +	if (vsc->revision == 0x6) {
> +		sdp->db[0] = 1;
> +		sdp->db[3] = 1;
> +	}
> +
> +	/*
> +	 * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> +	 * Format as per DP 1.4a spec and DP 2.0 respectively.
> +	 */
> +	if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> +		goto out;
> +
> +	/* VSC SDP Payload for DB16 through DB18 */
> +	/* Pixel Encoding and Colorimetry Formats  */
> +	sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> +	sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> +
> +	switch (vsc->bpc) {
> +	case 6:
> +		/* 6bpc: 0x0 */
> +		break;
> +	case 8:
> +		sdp->db[17] = 0x1; /* DB17[3:0] */
> +		break;
> +	case 10:
> +		sdp->db[17] = 0x2;
> +		break;
> +	case 12:
> +		sdp->db[17] = 0x3;
> +		break;
> +	case 16:
> +		sdp->db[17] = 0x4;
> +		break;
> +	default:
> +		WARN(1, "Missing case %d\n", vsc->bpc);
> +		return -EINVAL;
> +	}
> +
> +	/* Dynamic Range and Component Bit Depth */
> +	if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> +		sdp->db[17] |= 0x80;  /* DB17[7] */
> +
> +	/* Content Type */
> +	sdp->db[18] = vsc->content_type & 0x7;
> +
> +out:
> +	return length;
> +}
> +EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
> +
>  /**
>   * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
>   * @dpcd: DisplayPort configuration data
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index 217196196e50..a9458df475e2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4089,73 +4089,6 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
>  	return false;
>  }
>  
> -static ssize_t intel_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> -				     struct dp_sdp *sdp, size_t size)
> -{
> -	size_t length = sizeof(struct dp_sdp);
> -
> -	if (size < length)
> -		return -ENOSPC;
> -
> -	memset(sdp, 0, size);
> -
> -	/*
> -	 * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> -	 * VSC SDP Header Bytes
> -	 */
> -	sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> -	sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> -	sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> -	sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> -
> -	if (vsc->revision == 0x6) {
> -		sdp->db[0] = 1;
> -		sdp->db[3] = 1;
> -	}
> -
> -	/*
> -	 * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> -	 * Format as per DP 1.4a spec and DP 2.0 respectively.
> -	 */
> -	if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> -		goto out;
> -
> -	/* VSC SDP Payload for DB16 through DB18 */
> -	/* Pixel Encoding and Colorimetry Formats  */
> -	sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> -	sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> -
> -	switch (vsc->bpc) {
> -	case 6:
> -		/* 6bpc: 0x0 */
> -		break;
> -	case 8:
> -		sdp->db[17] = 0x1; /* DB17[3:0] */
> -		break;
> -	case 10:
> -		sdp->db[17] = 0x2;
> -		break;
> -	case 12:
> -		sdp->db[17] = 0x3;
> -		break;
> -	case 16:
> -		sdp->db[17] = 0x4;
> -		break;
> -	default:
> -		MISSING_CASE(vsc->bpc);
> -		break;
> -	}
> -	/* Dynamic Range and Component Bit Depth */
> -	if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> -		sdp->db[17] |= 0x80;  /* DB17[7] */
> -
> -	/* Content Type */
> -	sdp->db[18] = vsc->content_type & 0x7;
> -
> -out:
> -	return length;
> -}
> -
>  static ssize_t
>  intel_dp_hdr_metadata_infoframe_sdp_pack(struct drm_i915_private *i915,
>  					 const struct hdmi_drm_infoframe *drm_infoframe,
> @@ -4248,8 +4181,8 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
>  
>  	switch (type) {
>  	case DP_SDP_VSC:
> -		len = intel_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> -					    sizeof(sdp));
> +		len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> +					  sizeof(sdp));
>  		break;
>  	case HDMI_PACKET_TYPE_GAMUT_METADATA:
>  		len = intel_dp_hdr_metadata_infoframe_sdp_pack(dev_priv,
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index d02014a87f12..8474504d4c88 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -812,4 +812,7 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
>  		       int bpp_x16, unsigned long flags);
>  int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
>  
> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> +			    struct dp_sdp *sdp, size_t size);
> +
>  #endif /* _DRM_DP_HELPER_H_ */

-- 
Jani Nikula, Intel

