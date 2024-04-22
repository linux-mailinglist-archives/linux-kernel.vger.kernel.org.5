Return-Path: <linux-kernel+bounces-153569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 340108ACFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96CDD1F21602
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 14:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690315382E;
	Mon, 22 Apr 2024 14:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXD72odo"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F16F1534F4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 14:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713796863; cv=none; b=mHQb7okxJWtcVufsQ5/VgbS6ctO04uQgWJ1ZDBVA7XETmfP6wfapYaX3AYN7Hht+RyHm2PD3EL0QYbR4CGVh+G6JABfFJaRkMryTEOIMZSl2K/9sLaljuhdhfjHvOLf4Ent/nw0P0lRpRGOpCWBGreo/CcQDAPjQnHvQNgWPGQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713796863; c=relaxed/simple;
	bh=nIMUuvEk/DgX3yywYvi5JJnIRhP+5O4wt358I0E1PeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yly1lVHHAd19cq4Pt+dg2t2g+/MPXKFBGdbITvw0o/MH1X1hoBSp63frb/rXJYRkSEtipq/u0e4/+XgpEJ2Jq8QUYfdJCeKR8b9CoJtD3J3czaclEP8yBJLhQ4Z4JcjZr+5LPOwBeAlElbOhDYoXQpiZD8KsEHZiXZCkBZJD2a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXD72odo; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso3011051a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 07:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713796861; x=1714401661; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R9LOOxnp6uDCj3fmcKccLPiFpdOHLZ+RePrbPeCtdEE=;
        b=DXD72odoSH97T6PmmX00/xfQ8ONeUEUfFq/mvEl6nup7LA8Oa1feXvcSQjdhhEdfET
         MaoVI5VdFkegaliCWUHQWKBN7u3KEDIEmV8gZR+iUqaTMIdarroY89LQXq5GAWdzvege
         /YGfxiGy01GJCz0cPSZJYd2mASh3X9vL5KbBAsTnAIjsNs6BkGQZ5Z4rpsakZ5iTF4Tm
         5LhUctTwmISFQScBYoiaawQNsuy7+KwIASp6I/hScsgvO79gDqFSL21emVke3G7gYrhK
         Gv89X3s8dd4Vs0YZYH1O6MJJ7YrF957rQXo7AhykXfdCa4R9p30IaQcPCzFfuU93YSFL
         W/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713796861; x=1714401661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R9LOOxnp6uDCj3fmcKccLPiFpdOHLZ+RePrbPeCtdEE=;
        b=DMUlMBcnsvCkBcGIFUx5V6nTZ2piWUScvagfmtHkxIP4A2FBWRO0bBDKbObaeEQEb9
         VTFDub5bO2HUGUoaT3MrjeF4POPkbcGjtOKmLP/xK4/12BBL7nMjAGO2tbqUNUj09owt
         TNbJuB44vnW+fs96hU0EFpgPZjuHAU10kmQ2+XVfuKPmxE0FrRSL7JuwO5d2eKR6D0H7
         Kra5PSAOtvKHuNrpvRrzKKe5ytwXfRVlRnIcLLRmd6XLQjzkDg4xRWTfq1y6je/q4m3R
         KGP2jkZc3ChitScwd3Sh+ZcF+EOF2o7FSrVY/jey3VuDQR+gUyzsKD6gtwGP1iaAp6eM
         6YDw==
X-Forwarded-Encrypted: i=1; AJvYcCXE8Qz5A2Js1GgzjPB5glkJ+/9+xMSAjeZkznudQCzLPwzfDX8HVtC3sNBhxY0b4kuqMJ0tmis5zc9Z1aE0pWZJayI6M88yDD5dIzUo
X-Gm-Message-State: AOJu0YxCB8zNu8KU5+hfMDWTanMwAtQxILQ0waLpEnInq1uxDymMhMrq
	tomi5I9A1V7uOYTr43W1Ixm/kbHZqkRVG6gOY+i0cTXVWaakPdhlA19HSMWb0Jcq/13ZVKqinHG
	b+ItWmZePWYHgoeH3N6n3Dw1jQInD3Q==
X-Google-Smtp-Source: AGHT+IEgc0XiwfDp8RVTyTAd5lS2sDXiuF3v9HjTRhVsGc5NIcwymNn2hdprUQwLiFncA8Ojla8Wfuwk9H/w2el4HR8=
X-Received: by 2002:a17:90b:4aca:b0:29b:c31:1fe1 with SMTP id
 mh10-20020a17090b4aca00b0029b0c311fe1mr14464782pjb.10.1713796861204; Mon, 22
 Apr 2024 07:41:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422052608.5297-1-maqianga@uniontech.com> <68f02c5c-5591-4d6f-9926-b0fc6f9f6287@amd.com>
 <D94775003178862D+20240422203329.49844e71@john-PC> <bde48eef-4d8a-4cfa-b824-6de88c0f87fd@amd.com>
In-Reply-To: <bde48eef-4d8a-4cfa-b824-6de88c0f87fd@amd.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Mon, 22 Apr 2024 10:40:48 -0400
Message-ID: <CADnq5_PQ67J9ytb89-DqOgDw5V-s98TOyVjT5BGfkWMYv5sMQg@mail.gmail.com>
Subject: Re: [PATCH] drm/amdgpu: Fixup bad vram size on gmc v6 and v7
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: Qiang Ma <maqianga@uniontech.com>, alexander.deucher@amd.com, Xinhui.Pan@amd.com, 
	airlied@gmail.com, daniel@ffwll.ch, srinivasan.shanmugam@amd.com, 
	Arunpravin.PaneerSelvam@amd.com, le.ma@amd.com, Felix.Kuehling@amd.com, 
	mukul.joshi@amd.com, amd-gfx@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 9:00=E2=80=AFAM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 22.04.24 um 14:33 schrieb Qiang Ma:
> > On Mon, 22 Apr 2024 11:40:26 +0200
> > Christian K=C3=B6nig <christian.koenig@amd.com> wrote:
> >
> >> Am 22.04.24 um 07:26 schrieb Qiang Ma:
> >>> Some boards(like Oland PRO: 0x1002:0x6613) seem to have
> >>> garbage in the upper 16 bits of the vram size register,
> >>> kern log as follows:
> >>>
> >>> [    6.000000] [drm] Detected VRAM RAM=3D2256537600M, BAR=3D256M
> >>> [    6.007812] [drm] RAM width 64bits GDDR5
> >>> [    6.031250] [drm] amdgpu: 2256537600M of VRAM memory ready
> >>>
> >>> This is obviously not true, check for this and clamp the size
> >>> properly. Fixes boards reporting bogus amounts of vram,
> >>> kern log as follows:
> >>>
> >>> [    2.789062] [drm] Probable bad vram size: 0x86800800
> >>> [    2.789062] [drm] Detected VRAM RAM=3D2048M, BAR=3D256M
> >>> [    2.789062] [drm] RAM width 64bits GDDR5
> >>> [    2.789062] [drm] amdgpu: 2048M of VRAM memory ready
> >> Well we had patches like this one here before and so far we always
> >> rejected them.
> >>
> >> When the mmCONFIG_MEMSIZE register isn't properly initialized then
> >> there is something wrong with your hardware.
> >>
> >> Working around that in the software driver is not going to fly.
> >>
> >> Regards,
> >> Christian.
> >>
> > Hi Christian:
> > I see that two patches for this issue have been merged, and the
> > patches are as follows:
> >
> > 11544d77e397 drm/amdgpu: fixup bad vram size on gmc v8
> > 0ca223b029a2 drm/radeon: fixup bad vram size on SI
>
> Mhm, I remember that we discussed reverting those but it looks like that
> never happened. I need to ask around internally.
>
> Question is do you see any other problems with the board? E.g. incorrect
> connector or harvesting configuration?

I'll need to dig up the past discussion again, but IIRC, the issue was
only seen on some non-x86 platforms.  Maybe something specific to MMIO
on those?

Alex


>
> Regards,
> Christian.
>
> >
> > Qiang Ma
> >
> >>> Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c | 11 +++++++++--
> >>>    drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 13 ++++++++++---
> >>>    2 files changed, 19 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c index
> >>> 23b478639921..3703695f7789 100644 ---
> >>> a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c +++
> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c @@ -309,8 +309,15 @@ static
> >>> int gmc_v6_0_mc_init(struct amdgpu_device *adev) }
> >>>     adev->gmc.vram_width =3D numchan * chansize;
> >>>     /* size in MB on si */
> >>> -   adev->gmc.mc_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> >>> 1024ULL * 1024ULL;
> >>> -   adev->gmc.real_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> >>> 1024ULL * 1024ULL;
> >>> +   tmp =3D RREG32(mmCONFIG_MEMSIZE);
> >>> +   /* some boards may have garbage in the upper 16 bits */
> >>> +   if (tmp & 0xffff0000) {
> >>> +           DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
> >>> +           if (tmp & 0xffff)
> >>> +                   tmp &=3D 0xffff;
> >>> +   }
> >>> +   adev->gmc.mc_vram_size =3D tmp * 1024ULL * 1024ULL;
> >>> +   adev->gmc.real_vram_size =3D adev->gmc.mc_vram_size;
> >>>
> >>>     if (!(adev->flags & AMD_IS_APU)) {
> >>>             r =3D amdgpu_device_resize_fb_bar(adev);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c index
> >>> 3da7b6a2b00d..1df1fc578ff6 100644 ---
> >>> a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c +++
> >>> b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c @@ -316,10 +316,10 @@
> >>> static void gmc_v7_0_mc_program(struct amdgpu_device *adev) static
> >>> int gmc_v7_0_mc_init(struct amdgpu_device *adev) {
> >>>     int r;
> >>> +   u32 tmp;
> >>>
> >>>     adev->gmc.vram_width =3D
> >>> amdgpu_atombios_get_vram_width(adev); if (!adev->gmc.vram_width) {
> >>> -           u32 tmp;
> >>>             int chansize, numchan;
> >>>
> >>>             /* Get VRAM informations */
> >>> @@ -363,8 +363,15 @@ static int gmc_v7_0_mc_init(struct
> >>> amdgpu_device *adev) adev->gmc.vram_width =3D numchan * chansize;
> >>>     }
> >>>     /* size in MB on si */
> >>> -   adev->gmc.mc_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> >>> 1024ULL * 1024ULL;
> >>> -   adev->gmc.real_vram_size =3D RREG32(mmCONFIG_MEMSIZE) *
> >>> 1024ULL * 1024ULL;
> >>> +   tmp =3D RREG32(mmCONFIG_MEMSIZE);
> >>> +   /* some boards may have garbage in the upper 16 bits */
> >>> +   if (tmp & 0xffff0000) {
> >>> +           DRM_INFO("Probable bad vram size: 0x%08x\n", tmp);
> >>> +           if (tmp & 0xffff)
> >>> +                   tmp &=3D 0xffff;
> >>> +   }
> >>> +   adev->gmc.mc_vram_size =3D tmp * 1024ULL * 1024ULL;
> >>> +   adev->gmc.real_vram_size =3D adev->gmc.mc_vram_size;
> >>>
> >>>     if (!(adev->flags & AMD_IS_APU)) {
> >>>             r =3D amdgpu_device_resize_fb_bar(adev);
> >>
>

