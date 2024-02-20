Return-Path: <linux-kernel+bounces-73546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 132B685C3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:50:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C751C22ACF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 18:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94DA12BE85;
	Tue, 20 Feb 2024 18:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h2np8Ppa"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2447B76052
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708455011; cv=none; b=FOFCNZAgOQkZEyk8uiub/jmqYYO3TE2DrsfUsaihQ+rIr/zjgKZl3eHYyHf070e55vVHiwiJ3tlVMW0kWNYzKn9k+IVxkmsUtb+9gkhzum0NknpdJWvENjOkHyDS04Npu8w39kFiS5oqWx9jgSNbPXq/US0D8VJGgQy8RhE5x6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708455011; c=relaxed/simple;
	bh=yIdFUy3VNDtB987lnxaVH6G/W+iVUKX2zFVi0ddGiDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IRByEnDw2ke0c4c0HDIq7QY48jHiAtSzIRkVxDJxRtdTx0Ru33b07j8OMRmOAS+VdChJzJ34ySxPFZv9sbbdTg4wjHEh1S/TLXcuJ7/TtE7Dtpv0f/pIfa2+ar5Z8R3IK9RKhCLqxQvHaPbRYcHANXdZtnkQVXqiLM3YTE8k1zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h2np8Ppa; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-dcc86086c9fso5730920276.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708455008; x=1709059808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yRXnEtWmyWxcSqdR8eHmZ6LBceGmV3VoaDOluytk4Xg=;
        b=h2np8PpakuStvpfG2WeW2/x85DSV34/XYgjsc3mmV4ruXUrvddMWkzco0MZjER+E1H
         y3NANfgoXWnqGVm6W4DXQ6IefmDhf5u+Xj/Fi5+2BSQ6tlodjkzzclH766NN6y8GKi1x
         VzA11+6HnJWxa0R93rkR/Czpre6asPgRY+n/txWTV6zJyBUnWUwkunjsaNxznVMbo0pS
         zRzSKAySJVF8AP5MkItsxYM+AfHeOdGL3c/teVLWGtJ6GIxisDuMRj+mpKKK5W1e6Y3C
         79fG8sxIOuttDx6/DQRJWkIZqXvsH5gIuG2IxNUB3k3BM3GqWwHLugVOwj70r1RI2guv
         DpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708455008; x=1709059808;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRXnEtWmyWxcSqdR8eHmZ6LBceGmV3VoaDOluytk4Xg=;
        b=r8Qn/JbHc7XINp6j5FHciEJW43OCX41LJtNtHZ2l6ZdIKZDnMdYjVmRP8Dn/U679XD
         Eid8Gk7OhTx08ovGJU06fyvtzzImtRFgK/HNwCmcyc4zZcVXS0UplhE6FGXJhoTCXrxr
         EuIo75+F8jgMDj6fE6Egc0vTdxOskUQ0atcM2Ro0oNrJywGGlWQhGB9v1mFhlVQJnIET
         l/JQY3AiY6jloPQVgVdvmOK4zrPP6WdoY6+YRJbcMTyEl/92dNBIejv0XyYmmD2kYyiq
         50M4/TEa2mbNxyu38u913sKg8LzYvHV4WkyYqUPbfPXuUtK91edno3DWWJSXqXcE23IN
         g4Uw==
X-Forwarded-Encrypted: i=1; AJvYcCUJFhcWe2UN+1curyJLW3uA7s8j+HnDqHeBt5abymx3VU7ZtETphKREZ3GA7hzE8N+kz6Fnp5gbVob8++d6VBvAXLVPYBVNFNYwLBMd
X-Gm-Message-State: AOJu0YwFf9T4q6RVI7XKRR9GkQ7aNojCCk3ptipkJgwUGHWdZ7F53Goq
	lrj/HA6/3fGSgV7z1Vl3AoeyK3hJinQva9J2kL0A5NTHofT/LjIqjSXCHZarkA9sVc0gJxBr/fa
	bNOXso+GRpxdUzt7m1WoI5n6t/6eKu4qFjvrDVw==
X-Google-Smtp-Source: AGHT+IHfzdOSi2N+M382qbcFbtC0kxzFdORlzSBvrutFk2HVJP66VyvKWw2NTQeQmT7rsxSCNRtZBfmXNaK+RFZmtsw=
X-Received: by 2002:a5b:b03:0:b0:dc7:1a9a:11da with SMTP id
 z3-20020a5b0b03000000b00dc71a9a11damr16767205ybp.38.1708455008038; Tue, 20
 Feb 2024 10:50:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
In-Reply-To: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 20:49:56 +0200
Message-ID: <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
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

On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> Lets move this to drm_dp_helper to achieve this.
>
> changes in v2:
>         - rebased on top of drm-tip
>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

v1 had an explicit comment before the ack:

>    From my side, with the promise of the size fixup.

However I observe neither a second patch removing the size argument
nor it being dropped as a part of this patch.

> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
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
> +                           struct dp_sdp *sdp, size_t size)
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
> index 217196196e50..a9458df475e2 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4089,73 +4089,6 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
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
> @@ -4248,8 +4181,8 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
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
> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> index d02014a87f12..8474504d4c88 100644
> --- a/include/drm/display/drm_dp_helper.h
> +++ b/include/drm/display/drm_dp_helper.h
> @@ -812,4 +812,7 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
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

