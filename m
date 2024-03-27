Return-Path: <linux-kernel+bounces-120277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61BB688D53C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 04:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8ACA1F2A144
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 03:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C194D2374C;
	Wed, 27 Mar 2024 03:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BzjYRUbS"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A4022EEF
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711511519; cv=none; b=jQcBIbkHZfUrBPBueLCPaQ3tv4ddhDjywUy1BgQb1xrbEkCUM38ob6LyGueEeMA+usrzoYK4hY28qzVwNXbLKY2qNE/ceILv2UFw63gAZbg+1mjG1NZlH/hVKH/MsaFZCjIuvFLWdUlnIxIawP0/txhLyeOucVeKEP5hdgpPid0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711511519; c=relaxed/simple;
	bh=QJXMC3Tfd+pY2vuD9RHG++UN+yhGriDzRLPIyxqGcfo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kgIFshR2ybGIA5hARGORNL5lxbOuJIXtl0WKv+vY34h+NgjA0HLW5nMftu3dQCCqkJ21Vog2iJ6vtslRKMD3ZcCg9O81/10xGcu7eSebYcdTyr2wkpF7ucerjCkEPGU+6edGeVgv5CxDugTA6rKqXC4h5z6wLObSAYKPzl4kmw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BzjYRUbS; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ea9a60f7f5so3032533b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711511517; x=1712116317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lmokegW/aYOBSsEsNTcEzid1Q/wMq3xKUwCpHBJxfNU=;
        b=BzjYRUbSMjG4l+hCU3iWE/wdkNRfc/wOXFuXsTVVIB0z9dY+Lr8Y2phRbwB+bAtbTS
         phvzMKVUaio+M+Ct5Ms0YiMRbCxRQI4TP3ZOJRIxM8TLYamPu47iNf4lY8BJssixeFn+
         DAn7IvjR9h19orZ2Vl4WCQaPmimifYOYJaZhuhzF0HJ5p72XhjhHFYNXOO5soyHO+v80
         gVcl+LenvprbwzaYd8jGE5MmyTGzWbERx75pmP0xGi8TtjSftPPwtcYNj/oNd83GbRUJ
         RTZENlDXwGc5rQdxATHXMJKshvNUXURPhe6Pg+Fw9O7cw+6KKINWCX8EVv5QFbzrgbqw
         HHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711511517; x=1712116317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lmokegW/aYOBSsEsNTcEzid1Q/wMq3xKUwCpHBJxfNU=;
        b=jJR2g9b8A5dYBUMZ7K6kKYnBIFGvqgBZ8RqieUJRDnzru6jO1Fk3dvqV166SF9U3zw
         2LrsiuUYcDyhPaGtExMYigj8kYORyhz1iznNGkq9I/UKWD8/ehq+m0YzQ97ZzGo0mxLm
         CUTya6/0NObyhp6kcyLGTGoJwne7mQU9+dpanGgQk1DyPG4QY4Dr/tD6ED/sKNtCubz0
         TSu5fXbxdNHZz5YsQOHpNaTKrexTjwFqTKJDldoaR0ifbN3dcr4EaaHkpdK0m0Vg7TCr
         hCkY+wOPAo8Opz9tcY/3VFfL+1SIBrw51fyKdjXDK/uUQ5PiwIOSPkUUo7cTu+IldF/1
         c4SQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWIRd15vBIS1PI2qeiLNYx8+uz99NvBfFaQ/+uaQCqoAAcylu20i5j18bIbvOTIfIFk33bARx4JplJAPK4PBXylEEMeiejZFTdNc7r
X-Gm-Message-State: AOJu0YwBzjIEzsXstvinzoDwDcsSIyLBGhZj2nPx/Z3A7vV+P68vYC0K
	eav8HDg905PKYi0hq+DLV4JCmYD6fQ/AmXcYVPNOEo2VTCNRkyde/V+43SBlstSf6Zz0Rc+PosU
	oZZTO+rAcEGfIUAZp3mKMqP4u0jAvNR0nlGM=
X-Google-Smtp-Source: AGHT+IGUsPYb9972j6yCMOmaks7UNYlKIisX9svjagf58yyhiFOkRq2is776kHhGpq8sJnFdM7jJUN9HgOUaw6O9Yng=
X-Received: by 2002:a05:6a21:1706:b0:1a3:e46d:1a03 with SMTP id
 nv6-20020a056a21170600b001a3e46d1a03mr601803pzb.24.1711511517237; Tue, 26 Mar
 2024 20:51:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131075703.24600-1-maqianga@uniontech.com>
 <A65A2F93D9F165EC+20240313141827.40f30bd5@john-PC> <BL1PR12MB5144F6A9CAB0504C8AD5728CF7292@BL1PR12MB5144.namprd12.prod.outlook.com>
 <933F2B53EE8DA7B7+20240327113100.6742ccd5@john-PC>
In-Reply-To: <933F2B53EE8DA7B7+20240327113100.6742ccd5@john-PC>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Tue, 26 Mar 2024 23:51:45 -0400
Message-ID: <CADnq5_OrMX=hVyLHWZecy8N6=dUaFOrMF+pf_2GTMRB3-iWskg@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt ack bit before
 hpd initialization
To: Qiang Ma <maqianga@uniontech.com>
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, 
	"Koenig, Christian" <Christian.Koenig@amd.com>, "Pan, Xinhui" <Xinhui.Pan@amd.com>, 
	"airlied@gmail.com" <airlied@gmail.com>, "daniel@ffwll.ch" <daniel@ffwll.ch>, 
	"SHANMUGAM, SRINIVASAN" <SRINIVASAN.SHANMUGAM@amd.com>, 
	"sunran001@208suo.com" <sunran001@208suo.com>, 
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 11:41=E2=80=AFPM Qiang Ma <maqianga@uniontech.com> =
wrote:
>
> On Thu, 14 Mar 2024 14:40:40 +0000
> "Deucher, Alexander" <Alexander.Deucher@amd.com> wrote:
>
> > [Public]
> >
> > > -----Original Message-----
> > > From: Qiang Ma <maqianga@uniontech.com>
> > > Sent: Wednesday, March 13, 2024 2:18 AM
> > > To: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig,
> > > Christian <Christian.Koenig@amd.com>; Pan, Xinhui
> > > <Xinhui.Pan@amd.com>; airlied@gmail.com; daniel@ffwll.ch;
> > > SHANMUGAM, SRINIVASAN <SRINIVASAN.SHANMUGAM@amd.com>;
> > > sunran001@208suo.com Cc: amd-gfx@lists.freedesktop.org;
> > > dri-devel@lists.freedesktop.org; linux- kernel@vger.kernel.org
> > > Subject: Re: [PATCH v2] drm/amdgpu: Clear the hotplug interrupt ack
> > > bit before hpd initialization
> > >
> > > On Wed, 31 Jan 2024 15:57:03 +0800
> > > Qiang Ma <maqianga@uniontech.com> wrote:
> > >
> > > Hello everyone, please help review this patch.
> >
> > This was applied back in January, sorry if I forget to reply.
> >
> > Alex
>
> Hi, Alex, it doesn't matter, please take some time to help review this
> patch.
>
> This patch mainly solves the problem that after unplugging the HDMI
> display during bios initialization, the display does not light up after
> the system starts.
>

I already reviewed and applied the patch.  It's in mainline:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Daeaf3e6cf84282500b6fa03621b0c225ce1af18a

Alex

> Qiang Ma
> >
> > >
> > >   Qiang Ma
> > >
> > > > Problem:
> > > > The computer in the bios initialization process, unplug the HDMI
> > > > display, wait until the system up, plug in the HDMI display, did
> > > > not enter the hotplug interrupt function, the display is not
> > > > bright.
> > > >
> > > > Fix:
> > > > After the above problem occurs, and the hpd ack interrupt bit is
> > > > 1, the interrupt should be cleared during hpd_init initialization
> > > > so that when the driver is ready, it can respond to the hpd
> > > > interrupt normally.
> > > >
> > > > Signed-off-by: Qiang Ma <maqianga@uniontech.com>
> > > > ---
> > > > v2:
> > > >  - Remove unused variable 'tmp'
> > > >  - Fixed function spelling errors
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/dce_v10_0.c |  2 ++
> > > > drivers/gpu/drm/amd/amdgpu/dce_v11_0.c |  2 ++
> > > > drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 22
> > > > ++++++++++++++++++---
> > > -
> > > > drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 22
> > > > ++++++++++++++++++---
> > > -
> > > >  4 files changed, 40 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c index
> > > > bb666cb7522e..12a8ba929a72 100644 ---
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c +++
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c @@ -51,6 +51,7 @@
> > > >
> > > >  static void dce_v10_0_set_display_funcs(struct amdgpu_device
> > > > *adev); static void dce_v10_0_set_irq_funcs(struct amdgpu_device
> > > > *adev); +static void dce_v10_0_hpd_int_ack(struct amdgpu_device
> > > > *adev, int hpd);
> > > >  static const u32 crtc_offsets[] =3D {
> > > >     CRTC0_REGISTER_OFFSET,
> > > > @@ -363,6 +364,7 @@ static void dce_v10_0_hpd_init(struct
> > > > amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
> > > >             WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> > > > hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> > > > +           dce_v10_0_hpd_int_ack(adev,
> > > > amdgpu_connector->hpd.hpd); dce_v10_0_hpd_set_polarity(adev,
> > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> > > >                            amdgpu_connector->hpd.hpd); diff --git
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c index
> > > > 7af277f61cca..745e4fdffade 100644 ---
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c +++
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v11_0.c @@ -51,6 +51,7 @@
> > > >
> > > >  static void dce_v11_0_set_display_funcs(struct amdgpu_device
> > > > *adev); static void dce_v11_0_set_irq_funcs(struct amdgpu_device
> > > > *adev); +static void dce_v11_0_hpd_int_ack(struct amdgpu_device
> > > > *adev, int hpd);
> > > >  static const u32 crtc_offsets[] =3D
> > > >  {
> > > > @@ -387,6 +388,7 @@ static void dce_v11_0_hpd_init(struct
> > > > amdgpu_device *adev) AMDGPU_HPD_DISCONNECT_INT_DELAY_IN_MS);
> > > >             WREG32(mmDC_HPD_TOGGLE_FILT_CNTL +
> > > > hpd_offsets[amdgpu_connector->hpd.hpd], tmp);
> > > > +           dce_v11_0_hpd_int_ack(adev,
> > > > amdgpu_connector->hpd.hpd); dce_v11_0_hpd_set_polarity(adev,
> > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> > > > amdgpu_connector->hpd.hpd); } diff --git
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c index
> > > > 143efc37a17f..28c4a735716b 100644 ---
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c +++
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c @@ -272,6 +272,21 @@
> > > static
> > > > void dce_v6_0_hpd_set_polarity(struct amdgpu_device *adev,
> > > > WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > >
> > > > +static void dce_v6_0_hpd_int_ack(struct amdgpu_device *adev,
> > > > +                            int hpd)
> > > > +{
> > > > +   u32 tmp;
> > > > +
> > > > +   if (hpd >=3D adev->mode_info.num_hpd) {
> > > > +           DRM_DEBUG("invalid hdp %d\n", hpd);
> > > > +           return;
> > > > +   }
> > > > +
> > > > +   tmp =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> > > > +   tmp |=3D DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > +   WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > +
> > > >  /**
> > > >   * dce_v6_0_hpd_init - hpd setup callback.
> > > >   *
> > > > @@ -311,6 +326,7 @@ static void dce_v6_0_hpd_init(struct
> > > amdgpu_device
> > > > *adev) continue;
> > > >             }
> > > >
> > > > +           dce_v6_0_hpd_int_ack(adev,
> > > > amdgpu_connector->hpd.hpd); dce_v6_0_hpd_set_polarity(adev,
> > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> > > > amdgpu_connector->hpd.hpd); } @@ -3088,7 +3104,7 @@ static int
> > > > dce_v6_0_hpd_irq(struct amdgpu_device *adev, struct amdgpu_irq_src
> > > > *source,
> > > >                         struct amdgpu_iv_entry *entry)  {
> > > > -   uint32_t disp_int, mask, tmp;
> > > > +   uint32_t disp_int, mask;
> > > >     unsigned hpd;
> > > >
> > > >     if (entry->src_data[0] >=3D adev->mode_info.num_hpd) { @@
> > > > -3101,9 +3117,7 @@ static int dce_v6_0_hpd_irq(struct
> > > > amdgpu_device *adev, mask =3D interrupt_status_offsets[hpd].hpd;
> > > >
> > > >     if (disp_int & mask) {
> > > > -           tmp =3D RREG32(mmDC_HPD1_INT_CONTROL +
> > > > hpd_offsets[hpd]);
> > > > -           tmp |=3D
> > > DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > -           WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> > > > tmp);
> > > > +           dce_v6_0_hpd_int_ack(adev, hpd);
> > > >             schedule_delayed_work(&adev->hotplug_work, 0);
> > > >             DRM_DEBUG("IH: HPD%d\n", hpd + 1);
> > > >     }
> > > > diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c index
> > > > adeddfb7ff12..8ff2b5adfd95 100644 ---
> > > > a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c +++
> > > > b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c @@ -264,6 +264,21 @@
> > > static
> > > > void dce_v8_0_hpd_set_polarity(struct amdgpu_device *adev,
> > > > WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > >
> > > > +static void dce_v8_0_hpd_int_ack(struct amdgpu_device *adev,
> > > > +                            int hpd)
> > > > +{
> > > > +   u32 tmp;
> > > > +
> > > > +   if (hpd >=3D adev->mode_info.num_hpd) {
> > > > +           DRM_DEBUG("invalid hdp %d\n", hpd);
> > > > +           return;
> > > > +   }
> > > > +
> > > > +   tmp =3D RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd]);
> > > > +   tmp |=3D DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > +   WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd], tmp); }
> > > > +
> > > >  /**
> > > >   * dce_v8_0_hpd_init - hpd setup callback.
> > > >   *
> > > > @@ -303,6 +318,7 @@ static void dce_v8_0_hpd_init(struct
> > > amdgpu_device
> > > > *adev) continue;
> > > >             }
> > > >
> > > > +           dce_v8_0_hpd_int_ack(adev,
> > > > amdgpu_connector->hpd.hpd); dce_v8_0_hpd_set_polarity(adev,
> > > > amdgpu_connector->hpd.hpd); amdgpu_irq_get(adev, &adev->hpd_irq,
> > > > amdgpu_connector->hpd.hpd); } @@ -3176,7 +3192,7 @@ static int
> > > > dce_v8_0_hpd_irq(struct amdgpu_device *adev, struct amdgpu_irq_src
> > > > *source,
> > > >                         struct amdgpu_iv_entry *entry)  {
> > > > -   uint32_t disp_int, mask, tmp;
> > > > +   uint32_t disp_int, mask;
> > > >     unsigned hpd;
> > > >
> > > >     if (entry->src_data[0] >=3D adev->mode_info.num_hpd) { @@
> > > > -3189,9 +3205,7 @@ static int dce_v8_0_hpd_irq(struct
> > > > amdgpu_device *adev, mask =3D interrupt_status_offsets[hpd].hpd;
> > > >
> > > >     if (disp_int & mask) {
> > > > -           tmp =3D RREG32(mmDC_HPD1_INT_CONTROL +
> > > > hpd_offsets[hpd]);
> > > > -           tmp |=3D
> > > DC_HPD1_INT_CONTROL__DC_HPD1_INT_ACK_MASK;
> > > > -           WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[hpd],
> > > > tmp);
> > > > +           dce_v8_0_hpd_int_ack(adev, hpd);
> > > >             schedule_delayed_work(&adev->hotplug_work, 0);
> > > >             DRM_DEBUG("IH: HPD%d\n", hpd + 1);
> > > >     }
> >
> >
>

