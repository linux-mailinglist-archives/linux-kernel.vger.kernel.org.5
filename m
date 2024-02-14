Return-Path: <linux-kernel+bounces-65771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A9CC855193
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B181F22790
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3060B12C543;
	Wed, 14 Feb 2024 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UeNipQP0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E48212C522
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 18:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707933777; cv=none; b=L8a0sskCL1hn9o6Z7bOe6QAlpVvsDtCqR7SNI8h8qhXxpDKWjJtu8YVT2/0UbxPJy8DaZeWh2+QCFVfKpeRuNMVQSayl37Dqk3TZjQb6scvpWmtxdglYbwl7f8xl3+VgKNln8HBYC4wQjPRndQ32npiZ+1owctHOk+AfS/VgWHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707933777; c=relaxed/simple;
	bh=e/LgkL0SqgQjKtc6j1iYXMsm83QxdYgrvDI5Mfb6UGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ojI/YZYA51rPbKk/C0xNHhb30EETVKCb/+paOoFB2pKgKVFkQ9Zvrv4Xk+ZCfYVFRvGVp0XTAB/lUBn/f8rBgjVC5UIaN5LU/LEd+1Xeo3tGLpADkMBKY4wJxRdN7qHA67GUsM0c94qoJ80lAS5aI+dfJq5PZAWzoLqxBGxfLvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UeNipQP0; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707933775; x=1739469775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=e/LgkL0SqgQjKtc6j1iYXMsm83QxdYgrvDI5Mfb6UGs=;
  b=UeNipQP0dAGn45qNfzJOenS2uDT7xIKp7f3KnC2eOTITJ5tibcfZthsl
   n98uuGwei+6lnJSsuQjZfJ2hw2C5XkldGAl9b+yDYdK8lCu+rTXVKkoVf
   r52fKd0+6NRgmkKwBfqPBnMQabHUe7nbKZum0pw2K7GcgemdjI6Iyg1xB
   PnkT/MR6hyUWZkAU2vuul0uJOotyRi1wInT7aVEZkjbAPnlgPfkdD2Pba
   pIzy2BKRtPSRepv3M9GthQsQK4rWMf8EnKHg1jBLPpASouyqJZeOQAmhR
   2W8vgStp8nn0Akbrw2ZEoxuDJrhkeo0eQSSpHGG3Uvp4gygq3ej+1fJaf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="5811627"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="5811627"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 10:02:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="826369674"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="826369674"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 14 Feb 2024 10:02:48 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 14 Feb 2024 20:02:47 +0200
Date: Wed, 14 Feb 2024 20:02:47 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	dri-devel@lists.freedesktop.org,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
	robdclark@gmail.com, freedreno@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org, quic_jesszhan@quicinc.com,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Subject: Re: [PATCH] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
Message-ID: <Zc0AR6pdLzDjCrAB@intel.com>
References: <20240213234513.2411604-1-quic_abhinavk@quicinc.com>
 <CAA8EJpo0yeLyCkVvLFX7wUEV4+i+ORbaCB2qxN0izaWLdFqCrA@mail.gmail.com>
 <eb8b3bac-5f97-8efd-721e-08e9544be3f8@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb8b3bac-5f97-8efd-721e-08e9544be3f8@quicinc.com>
X-Patchwork-Hint: comment

On Wed, Feb 14, 2024 at 09:17:34AM -0800, Abhinav Kumar wrote:
> 
> 
> On 2/14/2024 12:15 AM, Dmitry Baryshkov wrote:
> > On Wed, 14 Feb 2024 at 01:45, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> >> Lets move this to drm_dp_helper to achieve this.
> >>
> >> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> > 
> > My preference would be to have packing functions in
> > drivers/video/hdmi.c, as we already have
> > hdmi_audio_infoframe_pack_for_dp() there.
> > 
> 
> My preference is drm_dp_helper because it already has some VSC SDP stuff 
> and after discussion with Ville on IRC, I decided to post it this way.
> 
> hdmi_audio_infoframe_pack_for_dp() is an exception from my PoV as the 
> hdmi audio infoframe fields were re-used and packed into a DP SDP 
> thereby re-using the existing struct hdmi_audio_infoframe .
> 
> This is not like that. Here we pack from struct drm_dp_vsc_sdp to struct 
> dp_sdp both of which had prior usages already in this file.
> 
> So it all adds up and makes sense to me to be in this file.
> 
> I will let the other DRM core maintainers comment on this.
> 
> Ville, Jani?

Yeah, I'm not sure bloating the (poorly named) hdmi.c with all
SDP stuff is a great idea. Since other related stuff already
lives in the drm_dp_helper.c that seems reasonable to me at this
time. And if we get a decent amount of this then probably all
DP SDP stuff should be extracted into its own file.

There are of course a few overlaps here andthere (the audio SDP
I guess, and the CTA infoframe SDP). But I'm not sure that actually
needs any SDP specific stuff in hdmi.c, or could we just let hdmi.c
deal with the actual CTA-861 stuff and then have the DP SDP code
wrap that up in its own thing externally? Dunno, haven't really
looked at the details.

> 
> >> ---
> >>   drivers/gpu/drm/display/drm_dp_helper.c | 78 +++++++++++++++++++++++++
> >>   drivers/gpu/drm/i915/display/intel_dp.c | 73 +----------------------
> >>   include/drm/display/drm_dp_helper.h     |  3 +
> >>   3 files changed, 84 insertions(+), 70 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/drm/display/drm_dp_helper.c
> >> index b1ca3a1100da..066cfbbf7a91 100644
> >> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> >> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> >> @@ -2916,6 +2916,84 @@ void drm_dp_vsc_sdp_log(const char *level, struct device *dev,
> >>   }
> >>   EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
> >>
> >> +/**
> >> + * drm_dp_vsc_sdp_pack() - pack a given vsc sdp into generic dp_sdp
> >> + * @vsc: vsc sdp initialized according to its purpose as defined in
> >> + *       table 2-118 - table 2-120 in DP 1.4a specification
> >> + * @sdp: valid handle to the generic dp_sdp which will be packed
> >> + * @size: valid size of the passed sdp handle
> >> + *
> >> + * Returns length of sdp on success and error code on failure
> >> + */
> >> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> >> +                           struct dp_sdp *sdp, size_t size)
> > 
> > I know that you are just moving the function. Maybe there can be
> > patch#2, which drops the size argument? The struct dp_sdp already has
> > a defined size. The i915 driver just passes sizeof(sdp), which is more
> > or less useless.
> > 
> 
> Yes this is a valid point, I also noticed this. I can post it on top of 
> this once we get an agreement and ack on this patch first.
> 
> >> +{
> >> +       size_t length = sizeof(struct dp_sdp);
> >> +
> >> +       if (size < length)
> >> +               return -ENOSPC;
> >> +
> >> +       memset(sdp, 0, size);
> >> +
> >> +       /*
> >> +        * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> >> +        * VSC SDP Header Bytes
> >> +        */
> >> +       sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> >> +       sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> >> +       sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> >> +       sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> >> +
> >> +       if (vsc->revision == 0x6) {
> >> +               sdp->db[0] = 1;
> >> +               sdp->db[3] = 1;
> >> +       }
> >> +
> >> +       /*
> >> +        * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> >> +        * Format as per DP 1.4a spec and DP 2.0 respectively.
> >> +        */
> >> +       if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> >> +               goto out;
> >> +
> >> +       /* VSC SDP Payload for DB16 through DB18 */
> >> +       /* Pixel Encoding and Colorimetry Formats  */
> >> +       sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> >> +       sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> >> +
> >> +       switch (vsc->bpc) {
> >> +       case 6:
> >> +               /* 6bpc: 0x0 */
> >> +               break;
> >> +       case 8:
> >> +               sdp->db[17] = 0x1; /* DB17[3:0] */
> >> +               break;
> >> +       case 10:
> >> +               sdp->db[17] = 0x2;
> >> +               break;
> >> +       case 12:
> >> +               sdp->db[17] = 0x3;
> >> +               break;
> >> +       case 16:
> >> +               sdp->db[17] = 0x4;
> >> +               break;
> >> +       default:
> >> +               WARN(1, "Missing case %d\n", vsc->bpc);
> >> +               return -EINVAL;
> >> +       }
> >> +
> >> +       /* Dynamic Range and Component Bit Depth */
> >> +       if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> >> +               sdp->db[17] |= 0x80;  /* DB17[7] */
> >> +
> >> +       /* Content Type */
> >> +       sdp->db[18] = vsc->content_type & 0x7;
> >> +
> >> +out:
> >> +       return length;
> >> +}
> >> +EXPORT_SYMBOL(drm_dp_vsc_sdp_pack);
> >> +
> >>   /**
> >>    * drm_dp_get_pcon_max_frl_bw() - maximum frl supported by PCON
> >>    * @dpcd: DisplayPort configuration data
> >> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i915/display/intel_dp.c
> >> index f5ef95da5534..e94db51aeeb7 100644
> >> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> >> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> >> @@ -4110,73 +4110,6 @@ intel_dp_needs_vsc_sdp(const struct intel_crtc_state *crtc_state,
> >>          return false;
> >>   }
> >>
> >> -static ssize_t intel_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> >> -                                    struct dp_sdp *sdp, size_t size)
> >> -{
> >> -       size_t length = sizeof(struct dp_sdp);
> >> -
> >> -       if (size < length)
> >> -               return -ENOSPC;
> >> -
> >> -       memset(sdp, 0, size);
> >> -
> >> -       /*
> >> -        * Prepare VSC Header for SU as per DP 1.4a spec, Table 2-119
> >> -        * VSC SDP Header Bytes
> >> -        */
> >> -       sdp->sdp_header.HB0 = 0; /* Secondary-Data Packet ID = 0 */
> >> -       sdp->sdp_header.HB1 = vsc->sdp_type; /* Secondary-data Packet Type */
> >> -       sdp->sdp_header.HB2 = vsc->revision; /* Revision Number */
> >> -       sdp->sdp_header.HB3 = vsc->length; /* Number of Valid Data Bytes */
> >> -
> >> -       if (vsc->revision == 0x6) {
> >> -               sdp->db[0] = 1;
> >> -               sdp->db[3] = 1;
> >> -       }
> >> -
> >> -       /*
> >> -        * Revision 0x5 and revision 0x7 supports Pixel Encoding/Colorimetry
> >> -        * Format as per DP 1.4a spec and DP 2.0 respectively.
> >> -        */
> >> -       if (!(vsc->revision == 0x5 || vsc->revision == 0x7))
> >> -               goto out;
> >> -
> >> -       /* VSC SDP Payload for DB16 through DB18 */
> >> -       /* Pixel Encoding and Colorimetry Formats  */
> >> -       sdp->db[16] = (vsc->pixelformat & 0xf) << 4; /* DB16[7:4] */
> >> -       sdp->db[16] |= vsc->colorimetry & 0xf; /* DB16[3:0] */
> >> -
> >> -       switch (vsc->bpc) {
> >> -       case 6:
> >> -               /* 6bpc: 0x0 */
> >> -               break;
> >> -       case 8:
> >> -               sdp->db[17] = 0x1; /* DB17[3:0] */
> >> -               break;
> >> -       case 10:
> >> -               sdp->db[17] = 0x2;
> >> -               break;
> >> -       case 12:
> >> -               sdp->db[17] = 0x3;
> >> -               break;
> >> -       case 16:
> >> -               sdp->db[17] = 0x4;
> >> -               break;
> >> -       default:
> >> -               MISSING_CASE(vsc->bpc);
> >> -               break;
> >> -       }
> >> -       /* Dynamic Range and Component Bit Depth */
> >> -       if (vsc->dynamic_range == DP_DYNAMIC_RANGE_CTA)
> >> -               sdp->db[17] |= 0x80;  /* DB17[7] */
> >> -
> >> -       /* Content Type */
> >> -       sdp->db[18] = vsc->content_type & 0x7;
> >> -
> >> -out:
> >> -       return length;
> >> -}
> >> -
> >>   static ssize_t
> >>   intel_dp_hdr_metadata_infoframe_sdp_pack(struct drm_i915_private *i915,
> >>                                           const struct hdmi_drm_infoframe *drm_infoframe,
> >> @@ -4269,8 +4202,8 @@ static void intel_write_dp_sdp(struct intel_encoder *encoder,
> >>
> >>          switch (type) {
> >>          case DP_SDP_VSC:
> >> -               len = intel_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> >> -                                           sizeof(sdp));
> >> +               len = drm_dp_vsc_sdp_pack(&crtc_state->infoframes.vsc, &sdp,
> >> +                                         sizeof(sdp));
> >>                  break;
> >>          case HDMI_PACKET_TYPE_GAMUT_METADATA:
> >>                  len = intel_dp_hdr_metadata_infoframe_sdp_pack(dev_priv,
> >> @@ -4297,7 +4230,7 @@ void intel_write_dp_vsc_sdp(struct intel_encoder *encoder,
> >>          struct dp_sdp sdp = {};
> >>          ssize_t len;
> >>
> >> -       len = intel_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
> >> +       len = drm_dp_vsc_sdp_pack(vsc, &sdp, sizeof(sdp));
> >>
> >>          if (drm_WARN_ON(&dev_priv->drm, len < 0))
> >>                  return;
> >> diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
> >> index 863b2e7add29..f8db34a2f7a5 100644
> >> --- a/include/drm/display/drm_dp_helper.h
> >> +++ b/include/drm/display/drm_dp_helper.h
> >> @@ -813,4 +813,7 @@ int drm_dp_bw_overhead(int lane_count, int hactive,
> >>                         int bpp_x16, unsigned long flags);
> >>   int drm_dp_bw_channel_coding_efficiency(bool is_uhbr);
> >>
> >> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> >> +                           struct dp_sdp *sdp, size_t size);
> >> +
> >>   #endif /* _DRM_DP_HELPER_H_ */
> >> --
> >> 2.34.1
> >>
> > 
> > 

-- 
Ville Syrjälä
Intel

