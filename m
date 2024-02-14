Return-Path: <linux-kernel+bounces-65864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546E78552F4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09D69282A6C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 19:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1084613A27C;
	Wed, 14 Feb 2024 19:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kh9QF0SP"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D0171A2
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 19:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707937839; cv=none; b=A0L+pZMYm9U94ERzLyEVeFT0dGlF5uYDQje2GiIe0z4Ewun8dOuK6QQfKSNCeFFxbDLQpXdSE8YFa+pNH+obK3YH0lLuL8eUoKTsWvGpCX8WYMAsDw0LueyX3YD3alzNWVpOcoMgOUfA5r2xUcoYoJ8hfNBJSJ9oMmQah4muerw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707937839; c=relaxed/simple;
	bh=gCviKrVLxbB9y0hOk8/aiIqeItVd7YXVOu+7aa27CVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s5bu2ppqzQmJij6odB6JzYbZntjUCSpT/2gJcV7dAZU+Qwpo/NofLVrM7fcuZ+FvIgm9+Rzmu5jBVzren7fedMSPlbgUSkrrNEIv+ZHXbUhnDbP30oAho0s91oc/7zxQm2ylIFhKLyKvtp+PHoYMRqQdvuCQTIIovzJKt3G4GcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kh9QF0SP; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcc80d6006aso17485276.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:10:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707937836; x=1708542636; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uq831+oypzfGO9lO95Fszd/4mrvaWFJLcRrSZ1YqWm8=;
        b=kh9QF0SPdXblmlZPbLo/X3RjF1Wnrh2gs4TtRN5eG88F+0yzs3PovZgto7z0f+nWMa
         qNeGILdd8oz2bM6RrT1t6Jzj1zAEGkNSYxU+6Cl8c0qS0hxQjyYvmHZw3VNjDXlKFekP
         YAi/6dAFcvPBY1N/Bvrfwh7Xs0Y5KDtDyI2Bcfs9TGCTfuOuMgkkHT7nQGpGnysvZVxT
         QK8lPps17nqisHesx9AAM4g5yBen2DWQgCpFhnC1o6MrOpmkpt4G+UnjfEuKh95QBdSF
         YwxOTUd8R0JY3S1PEJDF5cGT3gbIIMi9kscluwsdyIaCYTfs/wcscEaDWPDQd+ctU8Cm
         U/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707937836; x=1708542636;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uq831+oypzfGO9lO95Fszd/4mrvaWFJLcRrSZ1YqWm8=;
        b=pHeCMJOsg+V+E29Y/aNagFEmVE4onebF+vCnMhdf/Ej8ICnwdXw3/AFu3EV5Swr/ba
         YfW+IIF+xIpCG/8+qT93SemOR4GD3gKSa2+GTXTDoe67opUEXhBMvTGxFF8pcbijrXaK
         Bl9esjbTOk+KR9AX3yc5ZZMHNqJF5LFDuEYconmCsESOqKjqxst4bReRnXD5h4n5cGtU
         PeJtl47cdItLRUHtn+kUVIeO35Krj8fl6gqslGgnXUMBkOgvPTMR7S1tdfTG2TlrwbqR
         pExWjm73dybFU3iQb+Tmdt55i2ABUhTgzKlhPSzRJxsdGVx7610/vnbtNXUvVKASOkiB
         TvLA==
X-Forwarded-Encrypted: i=1; AJvYcCXxpgJAkFPZcIj3U2qGs/haQM3BG+piaqWiO+pKxCUTab7eTvdB8NGU44SeBnRspE7ZVnCkzEAigcsKw4gmKhLmnSiaIKuInx679MZG
X-Gm-Message-State: AOJu0Yw+QLQdfnME3k7mYK5jDfcu4QVfMmiarKZC3LNmRpPetOP7JpZ1
	dK+U76kn7OLHMhIkEF1k/PGJAbauyDh6Ad7+Y9m61YiESEGBguEa5q6pCPYrNRt09uwDo1v1Zt3
	CcTVM+TNHq1EwYgCpkUsd9v6dB2DNb6Jv4PZoqA==
X-Google-Smtp-Source: AGHT+IFmsVR2aJSFUOiWSYzFcUYy50TjKK+2YxD61ipvFBAbBI+bFm3GfY2tdB3QV5bM1o3Q0AKeikm65DKhHmKecag=
X-Received: by 2002:a25:83cf:0:b0:dcd:5c7:8466 with SMTP id
 v15-20020a2583cf000000b00dcd05c78466mr3316434ybm.44.1707937835898; Wed, 14
 Feb 2024 11:10:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240213234513.2411604-1-quic_abhinavk@quicinc.com>
 <CAA8EJpo0yeLyCkVvLFX7wUEV4+i+ORbaCB2qxN0izaWLdFqCrA@mail.gmail.com>
 <eb8b3bac-5f97-8efd-721e-08e9544be3f8@quicinc.com> <Zc0AR6pdLzDjCrAB@intel.com>
 <fa63e9c1-3cec-41df-c643-33950346b76c@quicinc.com>
In-Reply-To: <fa63e9c1-3cec-41df-c643-33950346b76c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 14 Feb 2024 21:10:24 +0200
Message-ID: <CAA8EJppqMZFG=wN3kdn75Mx6zYX58LDJHV6Vv3Zuk=bw-h3mRg@mail.gmail.com>
Subject: Re: [PATCH] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, robdclark@gmail.com, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	quic_jesszhan@quicinc.com, linux-kernel@vger.kernel.org, 
	intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 at 20:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wro=
te:
>
>
>
> On 2/14/2024 10:02 AM, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Wed, Feb 14, 2024 at 09:17:34AM -0800, Abhinav Kumar wrote:
> >>
> >>
> >> On 2/14/2024 12:15 AM, Dmitry Baryshkov wrote:
> >>> On Wed, 14 Feb 2024 at 01:45, Abhinav Kumar <quic_abhinavk@quicinc.co=
m> wrote:
> >>>>
> >>>> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> >>>> Lets move this to drm_dp_helper to achieve this.
> >>>>
> >>>> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
> >>>
> >>> My preference would be to have packing functions in
> >>> drivers/video/hdmi.c, as we already have
> >>> hdmi_audio_infoframe_pack_for_dp() there.
> >>>
> >>
> >> My preference is drm_dp_helper because it already has some VSC SDP stu=
ff
> >> and after discussion with Ville on IRC, I decided to post it this way.
> >>
> >> hdmi_audio_infoframe_pack_for_dp() is an exception from my PoV as the
> >> hdmi audio infoframe fields were re-used and packed into a DP SDP
> >> thereby re-using the existing struct hdmi_audio_infoframe .
> >>
> >> This is not like that. Here we pack from struct drm_dp_vsc_sdp to stru=
ct
> >> dp_sdp both of which had prior usages already in this file.
> >>
> >> So it all adds up and makes sense to me to be in this file.
> >>
> >> I will let the other DRM core maintainers comment on this.
> >>
> >> Ville, Jani?
> >
> > Yeah, I'm not sure bloating the (poorly named) hdmi.c with all
> > SDP stuff is a great idea. Since other related stuff already
> > lives in the drm_dp_helper.c that seems reasonable to me at this
> > time. And if we get a decent amount of this then probably all
> > DP SDP stuff should be extracted into its own file.
> >
>
> Yes, thanks.
>
> > There are of course a few overlaps here andthere (the audio SDP
> > I guess, and the CTA infoframe SDP). But I'm not sure that actually
> > needs any SDP specific stuff in hdmi.c, or could we just let hdmi.c
> > deal with the actual CTA-861 stuff and then have the DP SDP code
> > wrap that up in its own thing externally? Dunno, haven't really
> > looked at the details.
> >
>
> Thats a good way to look at it. this packing is from DP spec and not CTA
> so makes more sense to be in this file.
>
> In that case, R-b?
>
> >>
> >>>> ---
> >>>>    drivers/gpu/drm/display/drm_dp_helper.c | 78 ++++++++++++++++++++=
+++++
> >>>>    drivers/gpu/drm/i915/display/intel_dp.c | 73 +-------------------=
---
> >>>>    include/drm/display/drm_dp_helper.h     |  3 +
> >>>>    3 files changed, 84 insertions(+), 70 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/display/drm_dp_helper.c b/drivers/gpu/d=
rm/display/drm_dp_helper.c
> >>>> index b1ca3a1100da..066cfbbf7a91 100644
> >>>> --- a/drivers/gpu/drm/display/drm_dp_helper.c
> >>>> +++ b/drivers/gpu/drm/display/drm_dp_helper.c
> >>>> @@ -2916,6 +2916,84 @@ void drm_dp_vsc_sdp_log(const char *level, st=
ruct device *dev,
> >>>>    }
> >>>>    EXPORT_SYMBOL(drm_dp_vsc_sdp_log);
> >>>>
> >>>> +/**
> >>>> + * drm_dp_vsc_sdp_pack() - pack a given vsc sdp into generic dp_sdp
> >>>> + * @vsc: vsc sdp initialized according to its purpose as defined in
> >>>> + *       table 2-118 - table 2-120 in DP 1.4a specification
> >>>> + * @sdp: valid handle to the generic dp_sdp which will be packed
> >>>> + * @size: valid size of the passed sdp handle
> >>>> + *
> >>>> + * Returns length of sdp on success and error code on failure
> >>>> + */
> >>>> +ssize_t drm_dp_vsc_sdp_pack(const struct drm_dp_vsc_sdp *vsc,
> >>>> +                           struct dp_sdp *sdp, size_t size)
> >>>
> >>> I know that you are just moving the function. Maybe there can be
> >>> patch#2, which drops the size argument? The struct dp_sdp already has
> >>> a defined size. The i915 driver just passes sizeof(sdp), which is mor=
e
> >>> or less useless.
> >>>
> >>
> >> Yes this is a valid point, I also noticed this. I can post it on top o=
f
> >> this once we get an agreement and ack on this patch first.
> >>

From my side, with the promise of the size fixup.

Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


--=20
With best wishes
Dmitry

