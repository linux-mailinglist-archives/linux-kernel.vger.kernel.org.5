Return-Path: <linux-kernel+bounces-64861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53D728543E4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:15:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3D871F24566
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDE00125AB;
	Wed, 14 Feb 2024 08:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oLFuVriF"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8311CB6
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707898540; cv=none; b=eDr1R1g1gE9QheMGxT0XPx7X6PeMx4eRs1Ap0eAYXQLdeF5srIuHwReFrLjBzr2iinJJkVsW/pb2nIzUKJkFTUtmTcnvZxhIw6XnBtvJRmh3oDONxPHy+VdC01u6TeiK4YV5dW59LKfnZW/znQEQZEuhdHHPqIn6yWmBNkw0FZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707898540; c=relaxed/simple;
	bh=PyBpdEOx60TBrebzHSwTQy0Y4S9f8dvos9Myvh7EfXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gar6c+tNAzihQB4EcBNh7Wf+a8wedKGsEUXKkyJloRimimpKF5b8/ubrg3wc91Do+nGzcJ/W6P2mAudjIyjz/vXxUsetmGwXTyjzUFCk9kc0xP9cQcjdKyyPPzabrkbu501yBxUjZBoUKPrc86P2w4aLTTVZsD2+CCCBBb3BQhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oLFuVriF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dcbd1d4904dso2380684276.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707898538; x=1708503338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EKXGtE0o7nACfq6pe512roREe48CDHHUhw9NIs9DgqY=;
        b=oLFuVriFtiVA0wcsiW7gokiQ0tjTuZsx39BoW29pnfSWZ7UXTtDw4Uj5tAqtDoKqga
         UFayq81s2Vm9hfMtAcDr2oPkFke/ig4BaLAiPe3TwsGM4sjQ08CpFeJpvhkivfxdq9RJ
         m21PRRx/Bd3WlnH6cao6+43590eSdUTUOXpOWKFsdN+GHwV9r0k6Aoiagn1ZVsKDM0Dh
         4yvKjMlRZmC5Tt70IrNeXDUhlfR65PHZpDTOQvT8T+i5mHc4Vdpz3o5MnA5e+yCJiTQM
         6bGaRKPpRPRP8Y4vYjQ/9jyWyU+3bDYacCZFRSWed0yz0impkyMlQnqsWueMlM1xrzQV
         L0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707898538; x=1708503338;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EKXGtE0o7nACfq6pe512roREe48CDHHUhw9NIs9DgqY=;
        b=MdNVillprgTqdp0FvTB6BLwagekeDW9v3oaNdT7j3iRFTFtuCvtNBMIU3kA6GGJZeo
         ox4XltranwIRlUy80iKYuSaUO4df71Bqa3V4/MtYtSyZDS6eFNu0hpQ1c6sQov9MNA8z
         m8Z44cMD1gbcPUCw8SgTuvphRvqUUwAf8jpFRJ/lcJGdn469gY1xhJt06763yGTrQ4mX
         nUhn3TmykFn8jBkvn8/9HmSS3l9HXO3Vg9VqbO0fFyQgjeR3ompEFkZ5hmRZ/YKpwOIX
         YDdELo1TbqlISiOLQuechw5wqavP9cvjR93pZwc2SZL8ELbz/3Ak1J97v7YIOb1S3l3B
         1YTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHZBqFJhNny7e9hzOfY5ajh5KHzy7EojglX8y+1D9iqdjfMzvNoL4Au0Ns8Q9GqqRrQ7hFfrYCKJkfRqT3HSFnwAt+yGBM2Vkvnaqw
X-Gm-Message-State: AOJu0YyE0eZCQLLgEFfUJgCgMLaXa7R3IEGx3xb5cabTLGl3upcehAog
	pWrkVWvom9uJFbxT9QDOqHFAqg7ptxGDkfXWacgbR9z+FmWR8D3TmJKbpLJw937XuuzoErQok9Y
	SurOf+o6MNRhhZOYW+2nzLc1LxL4F4dbw82JFEA==
X-Google-Smtp-Source: AGHT+IFI6XgUc51w44SGa4dFJZmddk/Aj01+ufuewKBsrzYVS9b+Kup4A4AKPQTJHjDr+FyB9b7AIUFcQMO+GV9FPR8=
X-Received: by 2002:a5b:dc6:0:b0:dcd:36c1:ecb7 with SMTP id
 t6-20020a5b0dc6000000b00dcd36c1ecb7mr1383363ybr.54.1707898537795; Wed, 14 Feb
 2024 00:15:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213234513.2411604-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240213234513.2411604-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 14 Feb 2024 10:15:27 +0200
Message-ID: <CAA8EJpo0yeLyCkVvLFX7wUEV4+i+ORbaCB2qxN0izaWLdFqCrA@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, robdclark@gmail.com, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	ville.syrjala@linux.intel.com, quic_jesszhan@quicinc.com, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 14 Feb 2024 at 01:45, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> Lets move this to drm_dp_helper to achieve this.
>
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

My preference would be to have packing functions in
drivers/video/hdmi.c, as we already have
hdmi_audio_infoframe_pack_for_dp() there.

> ---
>  drivers/gpu/drm/display/drm_dp_helper.c | 78 +++++++++++++++++++++++++
>  drivers/gpu/drm/i915/display/intel_dp.c | 73 +----------------------
>  include/drm/display/drm_dp_helper.h     |  3 +
>  3 files changed, 84 insertions(+), 70 deletions(-)
>
> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> index b1ca3a1100da..066cfbbf7a91 100644
> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> @@ -2916,6 +2916,84 @@ void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
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
> +                           struct dp_sdp *sdp, size_t size)

I know that you are just moving the function. Maybe there can be
patch#2, which drops the size argument? The struct dp_sdp already has
a defined size. The i915 driver just passes sizeof(sdp), which is more
or less useless.

> +{
> +       size_t length = sizeof(struct dp_sdp);
> +
> +       if (size < length)
> +               return -ENOSPC;
> +
> +       memset(sdp, 0, size);
> +
> +       /*
> +        * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> +        * VSC SDP Header Bytes
> +        */
> +       sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> +       sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> +       sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> +       sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> +
> +       if (vsc->revision == 0x6) {
> +               sdp->db[0] = 1;
> +               sdp->db[3] = 1;
> +       }
> +
> +       /*
> +        * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> +        * Format as per DP 1.4a spec and DP 2.0 respectively.
> +        */
> +       if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> +               goto out;
> +
> +       /* VSC SDP Payload for DB16 through DB18 */
> +       /* Pixel Encoding and Colorimetry Formats  */
> +       sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> +       sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> +
> +       switch (vsc->bpc) {
> +       case 6:
> +               /* 6bpc: 0x0 */
> +               break;
> +       case 8:
> +               sdp->db[17] = 0x1; /* DB17[3:0] */
> +               break;
> +       case 10:
> +               sdp->db[17] = 0x2;
> +               break;
> +       case 12:
> +               sdp->db[17] = 0x3;
> +               break;
> +       case 16:
> +               sdp->db[17] = 0x4;
> +               break;
> +       default:
> +               WARN(1, "Missing case %d\n", vsc->bpc);
> +               return -EINVAL;
> +       }
> +
> +       /* Dynamic Range and Component Bit Depth */
> +       if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> +               sdp->db[17] |= 0x80;  /* DB17[7] */
> +
> +       /* Content Type */
> +       sdp->db[18] = vsc->content_type & 0x7;
> +
> +out:
> +       return length;
> +}
> +EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
> +
>  /**
>   * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
>   * @dpcd: DisplayPort configuration data
> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> index f5ef95da5534..e94db51aeeb7 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4110,73 +4110,6 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
>         return false;
>  }
>
> -static ssize_t intel_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> -                                    struct dp_sdp *sdp, size_t size)
> -{
> -       size_t length = sizeof(struct dp_sdp);
> -
> -       if (size < length)
> -               return -ENOSPC;
> -
> -       memset(sdp, 0, size);
> -
> -       /*
> -        * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> -        * VSC SDP Header Bytes
> -        */
> -       sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> -       sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> -       sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> -       sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> -
> -       if (vsc->revision == 0x6) {
> -               sdp->db[0] = 1;
> -               sdp->db[3] = 1;
> -       }
> -
> -       /*
> -        * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> -        * Format as per DP 1.4a spec and DP 2.0 respectively.
> -        */
> -       if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> -               goto out;
> -
> -       /* VSC SDP Payload for DB16 through DB18 */
> -       /* Pixel Encoding and Colorimetry Formats  */
> -       sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> -       sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> -
> -       switch (vsc->bpc) {
> -       case 6:
> -               /* 6bpc: 0x0 */
> -               break;
> -       case 8:
> -               sdp->db[17] = 0x1; /* DB17[3:0] */
> -               break;
> -       case 10:
> -               sdp->db[17] = 0x2;
> -               break;
> -       case 12:
> -               sdp->db[17] = 0x3;
> -               break;
> -       case 16:
> -               sdp->db[17] = 0x4;
> -               break;
> -       default:
> -               MISSING_CASE(vsc->bpc);
> -               break;
> -       }
> -       /* Dynamic Range and Component Bit Depth */
> -       if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> -               sdp->db[17] |= 0x80;  /* DB17[7] */
> -
> -       /* Content Type */
> -       sdp->db[18] = vsc->content_type & 0x7;
> -
> -out:
> -       return length;
> -}
> -
>  static ssize_t
>  intel_dp_hdr_metadata_infoframe_sdp_pack(struct drm_i915_private *i915,
>                                          const struct hdmi_drm_infoframe *drm_infoframe,
> @@ -4269,8 +4202,8 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
>
>         switch (type) {
>         case DP_SDP_VSC:
> -               len = intel_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> -                                           sizeof(sdp));
> +               len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> +                                         sizeof(sdp));
>                 break;
>         case HDMI_PACKET_TYPE_GAMUT_METADATA:
>                 len = intel_dp_hdr_metadata_infoframe_sdp_pack(dev_priv,
> @@ -4297,7 +4230,7 @@ void intel_write_dp_vsc_sdp(struct intel_encoder *encoder,
>         struct dp_sdp sdp = {};
>         ssize_t len;
>
> -       len = intel_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
> +       len = drm_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
>
>         if (drm_WARN_ON(&dev_priv->drm, len < 0))
>                 return;
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index 863b2e7add29..f8db34a2f7a5 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -813,4 +813,7 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
>                        int bpp_x16, unsigned long flags);
>  int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
>
> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> +                           struct dp_sdp *sdp, size_t size);
> +
>  #endif /* _DRM_DP_HELPER_H_ */
> --
> 2.34.1
>


-- 
With best wishes
Dmitry

