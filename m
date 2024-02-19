Return-Path: <linux-kernel+bounces-71691-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C647085A910
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A23F281243
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF773FB32;
	Mon, 19 Feb 2024 16:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFRSz/Gp"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D263CF6B;
	Mon, 19 Feb 2024 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708360706; cv=none; b=fCDj6nsuEha1WYhuFlyTVvXXwyRWKqBcq1oYWeqD7WJd2RR0J4TBk7VCyIAAmj8vI2wiNlVFE91es7KIQ0mFyIGZlzL/FCAJNgadLbyY5ZHJ2L85MoY05hbiiEdSqV/88JeVz14PBHYHQHhql4tDIBllTFTPQGwOOHTj6241o+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708360706; c=relaxed/simple;
	bh=B0McRFiVQ4zvQ0zQtJQLBXN492Rof6/KLgH56S0njgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9Y/PCmM1TtLA0mcx5voDmTmSz9ptbrv/6Ml3lCrGWlGDSNbt11Q4jX8k+hj0DQsuzjuFwsvIwwl+eKjO/VD0+Na9HA2ECSb9moOmJis5h1dv6Rsab1I33juaKNI8CZMJYxo7SIWpFb9ZhHnAdTSc8AYBPOuNyhAohVZN4xPyCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFRSz/Gp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2909a632e40so3203395a91.0;
        Mon, 19 Feb 2024 08:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708360704; x=1708965504; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MphQCNHjjTUpCfQntf3thPefGsApaLmo+Ze0xknBPn4=;
        b=KFRSz/Gp1Hc0n2sFM0l9ritqkfFCv1dmaDbQAwoizDpfReAlTqn2FfEkXIjuAf3uuD
         TfJmlEDqn+K9DeZR003brFfZlZmvsIVv/NYnD+zomeLD4ywqGh03Sy9wY5YtBdxf4MnK
         N6sK0dSN+nbcbJlI9QW5iWLcoaFnBqtflLJXawyaao5QzSmlVhUtewwiwx6qRMUUy1d+
         ev1rd64Ax95cdhtvNsQvegUZ1VAJ3FOoHMgGopIufeYeKqXdRIgccQL5ayPqFMOeHGex
         Df0aKqq1plIyo/qGF0qnLp174RwYeKq6WJx7stN8iRuL+rt2r2jSTlcfqWdzR0awpw47
         fqUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708360704; x=1708965504;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MphQCNHjjTUpCfQntf3thPefGsApaLmo+Ze0xknBPn4=;
        b=WvT0yi+G9/mFRdibBEoFDaAZd2xh3NAhbKyl9rquNRlmqW/CsiNb353KqPOKDg8hzb
         3Wf3+9Z+OyaHwxPfEzaQ1kSz62i8Svrf3efGjTVXEcSVD+X/AdLcAAY6EAqj7mIX8nuM
         V9hBxwvvuTK0Oi4mIt732fTNSFBRpuYY7BngTZn/4HwGyIpq9WL5rO5/GMDbJEAtayPh
         N34WzrDISlYAbsVSDBACIOHz2+fhQMnyM5ek+RobKouA3fzAr6gO2hihYUgP8A1LlxrO
         OgBNQ/NI9uowNj83jISYSW2oevQtZL+Pw/jY/E/o/wAIlsk1DfkerwQyj1ST2BLlEuXa
         4OrA==
X-Forwarded-Encrypted: i=1; AJvYcCV1T6UFk67IeHkPCpvGvOgfcNcMcjz/DfbaZPrI78QC+z1wn3SKjXaYwOefI5xMa6Cos4uRSbTCxKP5fOcgOtBfOd6/65zH4TCsksIz61YoVoiN/wDGz6MvnVxyb4Kotw6Eh8axWS4ypsUsI0+M3mw=
X-Gm-Message-State: AOJu0YwUwb8qAMqcnQL0SDp7bMriNm7SMXWanrjUh/FHuoYixrsUcLk+
	IJGNbbII9C7hxSElGVDjNcnkeCNXbhNeYXHvIB8TEnNEYGDkoVBDAEMKAjK+Ev9M4j6XQP1coL0
	E8n5gY++DQgwredlrtWQiwCFaO6E=
X-Google-Smtp-Source: AGHT+IGMquqVsiVFAvHYpiEy08vrbbMr27M6m+kodmL69uOLYyCtGxaqSJ1hgtPjTZJuNLz01YPEot/Q+Zp2MH8jooE=
X-Received: by 2002:a17:90b:78e:b0:299:3e54:83fe with SMTP id
 l14-20020a17090b078e00b002993e5483femr6100831pjz.36.1708360704235; Mon, 19
 Feb 2024 08:38:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6be2558b8462fc08095c24c9257563ab5f3ae013.1708001398.git.geert+renesas@glider.be>
 <kycepdxukfsww3tnxoo5hoiuo3vcgpqqmynokzhtl4vodgm6zc@ih4uhw7gz4jh>
 <CAMuHMdVf7ophCwKt-n_N-LBHV4+t14Gjb4d1O0T8FDk_9xMFtA@mail.gmail.com>
 <CAHCN7xJ65RP8TO7cS0p5DwE6zru5NEF0_JA+8siT_OpSeLD7pA@mail.gmail.com>
 <CAHCN7x+EnSU8qk5dBFco=0vkeknGq18qEN7vFmZs0_q83T_3+w@mail.gmail.com>
 <CAHCN7xKffJ29zyjoJVAcy3b_d=-zkFzbL=URj4yWJWzYvRdB_Q@mail.gmail.com>
 <TYCPR01MB11269CBE8429A31DE5002A5A5864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <nzrkujogauvn262ucxippwidyub6ikcohcjpbpn4hzj7rymctm@4owntgrmcquf>
 <TYCPR01MB11269CBAA20275E11D9AD6500864C2@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <wxwad77x2mxhhwdsbgiytzn6x54t4sywodjhzefwldo277njiz@ru7z54wxgelu>
 <CAHCN7xJi-6W6x+OJmkNwOX45SM4WHD5zkN42ZOp8ZxFnp3YL5w@mail.gmail.com> <TYCPR01MB11269B2104687F091CFA3405F86512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB11269B2104687F091CFA3405F86512@TYCPR01MB11269.jpnprd01.prod.outlook.com>
From: Adam Ford <aford173@gmail.com>
Date: Mon, 19 Feb 2024 10:38:12 -0600
Message-ID: <CAHCN7x+BVYoeDC+Rt4PV-dxyMZ-0GyYfiRcXwmVWwursz5NAfg@mail.gmail.com>
Subject: Re: RE: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Biju Das <biju.das.jz@bp.renesas.com>
Cc: Maxime Ripard <mripard@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <sarah.walker@imgtec.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, Marek Vasut <marek.vasut@mailbox.org>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 1:45=E2=80=AFAM Biju Das <biju.das.jz@bp.renesas.co=
m> wrote:
>
> Hi Adam,
>
> > -----Original Message-----
> > From: Adam Ford <aford173@gmail.com>
> > Sent: Sunday, February 18, 2024 11:26 PM
> > Subject: Re: RE: RE: [PATCH v2] drm/imagination: DRM_POWERVR should dep=
end
> > on ARCH_K3
> >
> > On Fri, Feb 16, 2024 at 8:14=E2=80=AFAM Maxime Ripard <mripard@kernel.o=
rg> wrote:
> > >
> > > On Fri, Feb 16, 2024 at 09:13:14AM +0000, Biju Das wrote:
> > > > Hi Maxime Ripard,
> > > >
> > > > > -----Original Message-----
> > > > > From: Maxime Ripard <mripard@kernel.org>
> > > > > Sent: Friday, February 16, 2024 9:05 AM
> > > > > Subject: Re: RE: [PATCH v2] drm/imagination: DRM_POWERVR should
> > > > > depend on
> > > > > ARCH_K3
> > > > >
> > > > > On Fri, Feb 16, 2024 at 08:47:46AM +0000, Biju Das wrote:
> > > > > > Hi Adam Ford,
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Adam Ford <aford173@gmail.com>
> > > > > > > Sent: Thursday, February 15, 2024 11:36 PM
> > > > > > > Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should
> > > > > > > depend on
> > > > > > > ARCH_K3
> > > > > > >
> > > > > > > On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@=
gmail.com>
> > wrote:
> > > > > > > >
> > > > > > > > On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford
> > > > > > > > <aford173@gmail.com>
> > > > > wrote:
> > > > > > > > >
> > > > > > > > > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoev=
en
> > > > > > > > > <geert@linux-m68k.org> wrote:
> > > > > > > > > >
> > > > > > > > > > Hi Maxime,
> > > > > > > > > >
> > > > > > > > > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard
> > > > > > > > > > <mripard@kernel.org>
> > > > > > > wrote:
> > > > > > > > > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert
> > > > > > > > > > > Uytterhoeven
> > > > > > > wrote:
> > > > > > > > > > > > Using the Imagination Technologies PowerVR Series 6
> > > > > > > > > > > > GPU requires a proprietary firmware image, which is
> > > > > > > > > > > > currently only available for Texas Instruments K3
> > > > > > > > > > > > AM62x SoCs.  Hence add a dependency on ARCH_K3, to
> > > > > > > > > > > > prevent asking the user about this driver when
> > > > > > > > > > > > configuring a kernel without Texas Instruments K3
> > > > > > > Multicore SoC support.
> > > > > > > > > > >
> > > > > > > > > > > This wasn't making sense the first time you sent it,
> > > > > > > > > > > and now that commit log is just plain wrong. We have
> > > > > > > > > > > firmwares for the G6110, GX6250, GX6650, BXE-4-32, an=
d
> > > > > > > > > > > BXS-4-64 models, which can be found on (at least)
> > > > > > > > > > > Renesas, Mediatek, Rockchip, TI and StarFive, so
> > > > > > > > > > > across three
> > > > > > > > > >
> > > > > > > > > > I am so happy to be proven wrong!
> > > > > > > > > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e=
g.
> > > > > > > > > > R-Car M3-
> > > > > > > W.
> > > > > > > > > >
> > > > > > > > > > > architectures and 5 platforms. In two months.
> > > > > > > > > >
> > > > > > > > > > That sounds like great progress, thanks a lot!
> > > > > > > > > >
> > > > > > > > > Geert,
> > > > > > > > >
> > > > > > > > > > Where can I find these firmwares? Linux-firmware[1]
> > > > > > > > > > seems to lack all but the original K3 AM62x one.
> > > > > > > > >
> > > > > > > > > I think PowerVR has a repo [1], but the last time I
> > > > > > > > > checked it, the BVNC for the firmware didn't match what
> > > > > > > > > was necessary for the GX6250 on the RZ/G2M.  I can't
> > > > > > > > > remember what the corresponding R-Car3 model is.  I
> > > > > > > > > haven't tried recently because I was told more
> > > > > > > > > documentation for firmware porting would be delayed until
> > everything was pushed into the kernel and Mesa.
> > > > > > > > > Maybe there is a better repo and/or newer firmware somewh=
ere
> > else.
> > > > > > > > >
> > > > > > > > I should have doubled checked the repo contents before I
> > > > > > > > sent my last e-mail , but it appears the firmware  [2] for
> > > > > > > > the RZ/G2M, might be present now. I don't know if there are
> > > > > > > > driver updates necessary. I checked my e-mails, but I didn'=
t
> > > > > > > > see any notification, or I would have tried it earlier.
> > > > > > > > Either way, thank you Frank for adding it.  I'll try to tes=
t
> > when I have some time.
> > > > > > > >
> > > > > > >
> > > > > > > I don't have the proper version of Mesa setup yet, but for
> > > > > > > what it's worth, the firmware loads without error, and it
> > doesn't hang.
> > > > > >
> > > > > > Based on [1] and [2],
> > > > > >
> > > > > > kmscube should work on R-Car as it works on RZ/G2L with panfros=
t
> > > > > > as earlier version of RZ/G2L which uses drm based on RCar-Du,
> > > > > > later changed
> > > > > to rzg2l-du.
> > > > >
> > > > > IIRC, the mesa support isn't there yet for kmscube to start.
> > > >
> > > > What about glmark2? I tested glmark2 as well.
> > >
> > > It's not really a matter of kmscube itself, but the interaction with
> > > the compositor entirely. You can run a headless vulkan rendering, but
> > > an application that renders to a window won't work.
> >
> > I have made a little progress.  I have Ubuntu running on an RZ/G2M (Rog=
ue
> > GX6250) with a device tree configuring the GPU and the GPU loads with
> > firmware.
> >
> >   powervr fd000000.gpu: [drm] loaded firmware
> > powervr/rogue_4.45.2.58_v1.fw
> >   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
> >   [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor 0
> >
> > drmdevice lists card0 and renderD128
> > --- Checking the number of DRM device available ---
> > --- Devices reported 2 ---
> > --- Retrieving devices information (PCI device revision is ignored) ---
> > device[0]
> > +-> available_nodes 0x05
> > +-> nodes
> > |   +-> nodes[0] /dev/dri/card0
> > |   +-> nodes[2] /dev/dri/renderD128
> > +-> bustype 0002
> > |   +-> platform
> > |       +-> fullname /soc/gpu@fd000000
> > +-> deviceinfo
> >     +-> platform
> >         +-> compatible
> >                     renesas,r8a774a1-gpu
> >                     img,img-axe
> >
> > There is more to this dump, but it seems to repeat. I wanted to show th=
at
> > it seems like it's trying to work.
> >
> > I think I need to modify the powervr code in mesa to recognize the
> > renesas,r8a774a1-gpu and associate it with the rcar-du, but I am not su=
re,
> > and I am hoping someone might be able to provide some guidance, since I
> > think I am missing something somewhere. I modified pvr_device.c in the
> > mesa driver to attempt do this:
> >
> > /* This is the list of supported DRM render/display driver configs. */
> > static const struct pvr_drm_device_config pvr_drm_configs[] =3D {
> >    DEF_CONFIG("mediatek,mt8173-gpu", "mediatek-drm"),
> >    DEF_CONFIG("ti,am62-gpu", "ti,am625-dss"),
> >    DEF_CONFIG("renesas,r8a774a1-gpu", "rcar-du"), };
> >
> > When I run modetest -M rcar-du, I can see the encoders and connectors a=
nd
> > I can display test patterns, so the rcar-du is working.
> >
> > I built Mesa 24.0.1 with the following options:
> >
> > meson setup builddir -Dvulkan-drivers=3Dimagination-experimental
> > -Dimagination-srv=3Dtrue -Dtools=3Dall -Dgallium-drivers=3Dzink,kmsro,s=
wrast
> >
> > I have tried to set PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 the Mesa
> > documentation for the powerVR, and I have exported the variable for
> > VK_ICD_FILENAMES to point to the powervr json file.
> >
> > when I try to run glmark2-drm, I was expecting the GL reddered to be th=
e
> > powervr, but it keeps using the
> > GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)
> >
> > I realize this driver is still in its infancy, but I was hoping someone
> > could give me some guidance to let me know if the work to do is on the
> > Mesa side or the rcar-du driver side, or something else.
> >
> > I rebuilt both libdrm and mesa.  While I don't get any errors, I also
> > don't get the hardware acceleration I was hoping for.
> >
> > I even tried  PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1
> > MESA_LOADER_DRIVER_OVERRIDE=3Dzink MESA_DEBUG=3Dcontect glmark2-drm
> >
> > ...but it only renders with llvmpipe
> >
> >     glmark2 2023.01
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >     OpenGL Information
> >     GL_VENDOR:      Mesa
> >     GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)
> >     GL_VERSION:     4.5 (Compatibility Profile) Mesa 24.0.1
> >     Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D32 stencil=
=3D0 samples=3D0
> >     Surface Size:   3840x2160 fullscreen
> >
> >
> > I am not as familiar with the Mesa side, but if I can get this working =
to
> > a point where something is rendered, even if it's not 100% compliant, I=
'd
> > like to push patches to the kernel and/or Mesa if necessary.
>
> FYI, the glmark2 I tested on RZ/G2L with panfrost is with wayland window =
system [1].
>
> Maybe there should be an panfrost equivalent package for powevr is availa=
ble in mesa??
> That is the only difference w.r.to panfrost.
>
> PACKAGECONFIG_append_pn-mesa =3D " egl kmsro panfrost"
>

I am not using Yocto, because I am using Ubuntu, but I have build Mesa
per the instructions they provided, but the glue that connects the
powervr to the rcar-du isn't as clear.  I looked at the panfrost
implementation, but I didn't see anything obvious.   It looks like the
panfrost integrates with the kms driver, which I was rather expecting
powervr would do.  I can tell the mesa library is build built and
loaded but it's not attempting to use it for some reason

The GX6250 that is supported looks like it needs some additional
look-up-tables added to src/imagination/common/pvr_device_info.c
inside Mesa because the LUT they have is for a different BVNC despite
the firmware for the BVNC being posted.  I'll have to see if I can
find documentation for the the features that are enabled or not within
this variant of the the GX6250.

adam

>
> [1] https://renesas.info/wiki/RZ-G/Panfrost_for_RZG2L
>
>
> Cheers,
> Biju
>

