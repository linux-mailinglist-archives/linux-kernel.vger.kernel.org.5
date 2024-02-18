Return-Path: <linux-kernel+bounces-70620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3EA0859A2E
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 00:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DA31C20C1F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 23:26:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B61573182;
	Sun, 18 Feb 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N69duQ3r"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E8971B52;
	Sun, 18 Feb 2024 23:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708298803; cv=none; b=d4jL93apavsgffrKoEkyqsa+3WfSS9zyUkEmlb0aRO6jQIaRsG3hlac4EPHpQZ2LYKKXMqIhj3Zi3g5lc4CBzQJ1OORU551w0wFvgnH2otrdlB2WHX6VBrY25xu58itemJdeO6axzWbp8ZG2PCIHNGnReuHYnEwVlLaIgbOFL2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708298803; c=relaxed/simple;
	bh=fYk+1gURJYpHdNPyMxphhkphfeGqjtQXJluEVlUYLuU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oV0j+6DOTyh5/n2+qcnmHG4jq9bIAYwEuxYf3IDryspkDr8qp0zekQAUxZlNfGvl2ReUdiGanOohk9L9Ha12geFfHrZMdmgT9oAY4K6OKTeZi9l4z6ymHVmJp2e7AaXRdA1Ln5xli4c5QEMlMSNJQocU+e2RRGM1/Qt1ZWSViR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N69duQ3r; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5d3912c9a83so2786223a12.3;
        Sun, 18 Feb 2024 15:26:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708298801; x=1708903601; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nhTyD3n0vlZPBN9ggvTgDSqbeJoS4N+nJwoxfnz8ic4=;
        b=N69duQ3ryGlxIwp8DebR+A37950U/R18zZKUMMNI8kB/Rziv2aVvw0vbm9hN3is3os
         uSZzZPEw2MEnsx4bqgCJtD//7HLZ7SiJFMuNA3JkltQGaUvNpdPq0p8Guv9jhuxmNoEF
         vUKPS7kxfOUBOS1Kbir79fqU7Dq+uIJFKBaHyquu8Eiopn0ouCEUYs1cLrnmXxSvOC9a
         x66hwWm5VURaRg2aGPz8NCvjh4vJRq+lOjzvia3cq/xSWAGwBN0fFzFTqQNXm92GC7IP
         7Y5eCHIGkavP9dA1hOqqAD25MA0qO/DXpHFr2zfcLisspQ85Cc1TDu9TCQHXEnhmuKaK
         y4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708298801; x=1708903601;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nhTyD3n0vlZPBN9ggvTgDSqbeJoS4N+nJwoxfnz8ic4=;
        b=ExhxUUaTR+MKzXPVfkUdlVbSzXaUat6NyoK8gGyy/ErtV9ahUqQ6+9VqtZGmBXOM7u
         mI+bYXUz/wxmq56YmHjPGo0I6iOb2r+q1p3IQjtDo5swyJO5rFbYqXjFaQvp727rHPmH
         H3M/6miwZ5dTIVXZKzhV3hK34+Sw6SG2kksQL4nN+OrQs8R8BMtb4l6f7iAb20q6xban
         DE25EraEoQzSpg4ezhkBi/f+ZBh4g5DeI6Kqgt6FDLp+Gmau3AC8LF8+CaBlCYEXnMyv
         7LBz3bNZRRbXNemdSJ4QNN24PcngyFwRzTA3qqOMz7L+OeXXR08DiTBOGUQIMy+xSYhN
         8b7A==
X-Forwarded-Encrypted: i=1; AJvYcCWP/W9FAYSrgCjtAeMvEgb1g5MNU5jkcF/LcOmmT6EFJdqHdFGfKN/8O+kn0HR7gS3kkit/0Gf5iVGpQ8jFe7jhurDy9GDEKvCmnsNr0xOb3z9zuSnIA3erv8C/wVkFYEAHPKV7rw590fBp9QAOQXg=
X-Gm-Message-State: AOJu0YzzlP7HegDyqgU8cvM+qxUSAQ/xdWzzAzKc5Jc8gS4myccvYMqQ
	6Yr/FmhFedUcmXk9zXTAdTlr9Io3HZ3YBCU13ueY98IulNJThMnTcD3edXGOA26bxNMME6CskpI
	Y2o3h1j8v+EHaSfEeO9PJ23vxZZI=
X-Google-Smtp-Source: AGHT+IEgoVaWt7mOZ5iKUkSrh+d3reSiwK9gsA4lNhx1UoNkutpaWsiXuQSif6o1CeBRO84Y2oVZsV9zJoJR38v8Q4c=
X-Received: by 2002:a05:6a21:3416:b0:1a0:5841:6740 with SMTP id
 yn22-20020a056a21341600b001a058416740mr10131762pzb.14.1708298800689; Sun, 18
 Feb 2024 15:26:40 -0800 (PST)
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
In-Reply-To: <wxwad77x2mxhhwdsbgiytzn6x54t4sywodjhzefwldo277njiz@ru7z54wxgelu>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 18 Feb 2024 17:26:29 -0600
Message-ID: <CAHCN7xJi-6W6x+OJmkNwOX45SM4WHD5zkN42ZOp8ZxFnp3YL5w@mail.gmail.com>
Subject: Re: RE: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Maxime Ripard <mripard@kernel.org>
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
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

On Fri, Feb 16, 2024 at 8:14=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Fri, Feb 16, 2024 at 09:13:14AM +0000, Biju Das wrote:
> > Hi Maxime Ripard,
> >
> > > -----Original Message-----
> > > From: Maxime Ripard <mripard@kernel.org>
> > > Sent: Friday, February 16, 2024 9:05 AM
> > > Subject: Re: RE: [PATCH v2] drm/imagination: DRM_POWERVR should depen=
d on
> > > ARCH_K3
> > >
> > > On Fri, Feb 16, 2024 at 08:47:46AM +0000, Biju Das wrote:
> > > > Hi Adam Ford,
> > > >
> > > > > -----Original Message-----
> > > > > From: Adam Ford <aford173@gmail.com>
> > > > > Sent: Thursday, February 15, 2024 11:36 PM
> > > > > Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depen=
d
> > > > > on
> > > > > ARCH_K3
> > > > >
> > > > > On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@gmai=
l.com> wrote:
> > > > > >
> > > > > > On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gm=
ail.com>
> > > wrote:
> > > > > > >
> > > > > > > On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> > > > > > > <geert@linux-m68k.org> wrote:
> > > > > > > >
> > > > > > > > Hi Maxime,
> > > > > > > >
> > > > > > > > On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard
> > > > > > > > <mripard@kernel.org>
> > > > > wrote:
> > > > > > > > > On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoe=
ven
> > > > > wrote:
> > > > > > > > > > Using the Imagination Technologies PowerVR Series 6 GPU
> > > > > > > > > > requires a proprietary firmware image, which is current=
ly
> > > > > > > > > > only available for Texas Instruments K3 AM62x SoCs.  He=
nce
> > > > > > > > > > add a dependency on ARCH_K3, to prevent asking the user
> > > > > > > > > > about this driver when configuring a kernel without Tex=
as
> > > > > > > > > > Instruments K3
> > > > > Multicore SoC support.
> > > > > > > > >
> > > > > > > > > This wasn't making sense the first time you sent it, and =
now
> > > > > > > > > that commit log is just plain wrong. We have firmwares fo=
r
> > > > > > > > > the G6110, GX6250, GX6650, BXE-4-32, and BXS-4-64 models,
> > > > > > > > > which can be found on (at least) Renesas, Mediatek,
> > > > > > > > > Rockchip, TI and StarFive, so across three
> > > > > > > >
> > > > > > > > I am so happy to be proven wrong!
> > > > > > > > Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g.
> > > > > > > > R-Car M3-
> > > > > W.
> > > > > > > >
> > > > > > > > > architectures and 5 platforms. In two months.
> > > > > > > >
> > > > > > > > That sounds like great progress, thanks a lot!
> > > > > > > >
> > > > > > > Geert,
> > > > > > >
> > > > > > > > Where can I find these firmwares? Linux-firmware[1] seems t=
o
> > > > > > > > lack all but the original K3 AM62x one.
> > > > > > >
> > > > > > > I think PowerVR has a repo [1], but the last time I checked i=
t,
> > > > > > > the BVNC for the firmware didn't match what was necessary for
> > > > > > > the GX6250 on the RZ/G2M.  I can't remember what the
> > > > > > > corresponding R-Car3 model is.  I haven't tried recently beca=
use
> > > > > > > I was told more documentation for firmware porting would be
> > > > > > > delayed until everything was pushed into the kernel and Mesa.
> > > > > > > Maybe there is a better repo and/or newer firmware somewhere =
else.
> > > > > > >
> > > > > > I should have doubled checked the repo contents before I sent m=
y
> > > > > > last e-mail , but it appears the firmware  [2] for the RZ/G2M,
> > > > > > might be present now. I don't know if there are driver updates
> > > > > > necessary. I checked my e-mails, but I didn't see any
> > > > > > notification, or I would have tried it earlier.  Either way, th=
ank
> > > > > > you Frank for adding it.  I'll try to test when I have some tim=
e.
> > > > > >
> > > > >
> > > > > I don't have the proper version of Mesa setup yet, but for what i=
t's
> > > > > worth, the firmware loads without error, and it doesn't hang.
> > > >
> > > > Based on [1] and [2],
> > > >
> > > > kmscube should work on R-Car as it works on RZ/G2L with panfrost as
> > > > earlier version of RZ/G2L which uses drm based on RCar-Du, later ch=
anged
> > > to rzg2l-du.
> > >
> > > IIRC, the mesa support isn't there yet for kmscube to start.
> >
> > What about glmark2? I tested glmark2 as well.
>
> It's not really a matter of kmscube itself, but the interaction with the
> compositor entirely. You can run a headless vulkan rendering, but an
> application that renders to a window won't work.

I have made a little progress.  I have Ubuntu running on an RZ/G2M
(Rogue GX6250) with a device tree configuring the GPU and the GPU
loads with firmware.

  powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58_v1.fw
  powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
  [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor 0

drmdevice lists card0 and renderD128
--- Checking the number of DRM device available ---
--- Devices reported 2 ---
--- Retrieving devices information (PCI device revision is ignored) ---
device[0]
+-> available_nodes 0x05
+-> nodes
|   +-> nodes[0] /dev/dri/card0
|   +-> nodes[2] /dev/dri/renderD128
+-> bustype 0002
|   +-> platform
|       +-> fullname /soc/gpu@fd000000
+-> deviceinfo
    +-> platform
        +-> compatible
                    renesas,r8a774a1-gpu
                    img,img-axe

There is more to this dump, but it seems to repeat. I wanted to show
that it seems like it's trying to work.

I think I need to modify the powervr code in mesa to recognize the
renesas,r8a774a1-gpu and associate it with the rcar-du, but I am not
sure, and I am hoping someone might be able to provide some guidance,
since I think I am missing something somewhere. I modified
pvr_device.c in the mesa driver to attempt do this:

/* This is the list of supported DRM render/display driver configs. */
static const struct pvr_drm_device_config pvr_drm_configs[] =3D {
   DEF_CONFIG("mediatek,mt8173-gpu", "mediatek-drm"),
   DEF_CONFIG("ti,am62-gpu", "ti,am625-dss"),
   DEF_CONFIG("renesas,r8a774a1-gpu", "rcar-du"),
};

When I run modetest -M rcar-du, I can see the encoders and connectors
and I can display test patterns, so the rcar-du is working.

I built Mesa 24.0.1 with the following options:

meson setup builddir -Dvulkan-drivers=3Dimagination-experimental
-Dimagination-srv=3Dtrue -Dtools=3Dall -Dgallium-drivers=3Dzink,kmsro,swras=
t

I have tried to set PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 the Mesa
documentation for the powerVR, and I have exported the variable for
VK_ICD_FILENAMES to point to the powervr json file.

when I try to run glmark2-drm, I was expecting the GL reddered to be
the powervr, but it keeps using the
GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)

I realize this driver is still in its infancy, but I was hoping
someone could give me some guidance to let me know if the work to do
is on the Mesa side or the rcar-du driver side, or something else.

I rebuilt both libdrm and mesa.  While I don't get any errors, I also
don't get the hardware acceleration I was hoping for.

I even tried  PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1
MESA_LOADER_DRIVER_OVERRIDE=3Dzink MESA_DEBUG=3Dcontect glmark2-drm

..but it only renders with llvmpipe

    glmark2 2023.01
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
    OpenGL Information
    GL_VENDOR:      Mesa
    GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)
    GL_VERSION:     4.5 (Compatibility Profile) Mesa 24.0.1
    Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D32 stencil=3D0=
 samples=3D0
    Surface Size:   3840x2160 fullscreen


I am not as familiar with the Mesa side, but if I can get this working
to a point where something is rendered, even if it's not 100%
compliant, I'd like to push patches to the kernel and/or Mesa if
necessary.

adam




>
> Maxime

