Return-Path: <linux-kernel+bounces-72904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1699D85BA80
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B8D71C247B4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F274664CE;
	Tue, 20 Feb 2024 11:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZsxZ4dpT"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F802627FD;
	Tue, 20 Feb 2024 11:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708428381; cv=none; b=Lb+0rn5lJzSaCJbEz6xgl5z4J2LACkvvId36/kiiCeOkvYdjzJfHLS95fUPHIDWiQkl3Wbh8dB8JkI91XDBrdi9AHrraHxVzp1APkKIYWHzr1Yor9WVlm90AyqZ4BIGEeeZ0xRjaE9eltGl4m9ivMWUz8dSe6D1IZxUZV6pp1b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708428381; c=relaxed/simple;
	bh=kSRmGOgl9XhSYqCbtmR6R+h1WY/Xrefi5zprPxr1Ta0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NfMgc/Qo+tooSqGLs8O1gXEPioOcX6MNtbRM2ILImLFXjXZb6WLR1bTac5ox9KwDDQDbR36VPUgv39O2iKAbyN4r1v7LvnSag4rjyeOKJ8bdu0TfJC4OBzY9UukaF4Nwh0nL5n4QbIs4KPSwmKb+VaJMCtZ7LQ485kQZoeGrzBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZsxZ4dpT; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29026523507so3979915a91.0;
        Tue, 20 Feb 2024 03:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708428379; x=1709033179; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ddtWpIvM+oO5i/bsgIa3peQElhM8K7kUTRsouskQjrY=;
        b=ZsxZ4dpTFXkCMNu/5bo8gV9xAeDxEY9iDE+Q4JHoXehbgy6K8baQXuEc/wM0j3FgMh
         qaiWwaTSSlE8ZR6Jm7p1rUjkyqr1/rAstuzpuSFn+bCOuONdF0h0HiHCH6y+L2m8fZll
         hM1o/h26Bv24PbW8ahBfPhetrkmdDslN76QoTFURXzUI4ioFqdXxOyruUSZfP9tXO08y
         wxkcp2L3/Jdgtl3uBQc0/7nY3oMJiyjoFXpc+y0gVMQ9UXRgn9LyR5hagP92BxunVwPC
         n17usAtAJ9ZY1teGZLc9UXRbnEstz8PFll2QvikJ9sE7QYFwLvoXAg8ShvmaJngjorSC
         bc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708428379; x=1709033179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ddtWpIvM+oO5i/bsgIa3peQElhM8K7kUTRsouskQjrY=;
        b=cEC3oLdbsfxruUW0GouspV2ZPVqY2DcFM/MOJcVq4y+ylv59CvNbV8XyTXfJtMLvWS
         NYU68YWU10zoJ9JYeXi3jVP3ofPiEi6aUkOgdERiccEsV3KijR6nJOvLotgVszsMizqt
         RElTOB2W6T03oup5AHF6rAw5hdiMmlAbmHSwSpiFr1rEWRf770yCrB5bxDuafJUp0q6U
         PvFscoHCih3jWT991h9/pS+XRWKYef8PHmimWZq7ovGpRpE2+PY2Uc7/XAElfim+C9Lb
         15/xMPrIZMH398pIckLy0YCzKi3ckVhqvi+TKEXqsK1+8yWcRC0L3kcNtZHX/uqpZgOr
         jekA==
X-Forwarded-Encrypted: i=1; AJvYcCXeGpe6TsubP4sjBTLjWLy1KIuvPoG4V9FBAtGjeRBWJAANcFVlInEQ9KVVDYFtQ0j0U6JH3qQ31ymdSqHPb1E2naeNOIL1MFZOmx+iiM3rrefSGq8SSkO8tH0b5uBb2wvvf/kKaEn/4oQ9j+dSrvA=
X-Gm-Message-State: AOJu0Yw3r7gsWGGD+bVqhQ4BkEIOvrZ1qko/HR4B+WfZu22a3u6Fh0uA
	0hulnoBafUsRXz+464bwD17Fd8AeDIDCbjzose9cBdRJpqWmceoyWxjWP6vxNFWXY1cevqAuXCR
	WcOZZtfbbGg9iZFW5vok4zWnrmPM=
X-Google-Smtp-Source: AGHT+IHm6m4ir6svtFsCip5ontoROxpbE3avD251zgl+W6jZrTPkDx5bx72+4yEpOfdlfjRYO2RDPdGr5HTy5nXf7OE=
X-Received: by 2002:a17:90a:c24d:b0:299:1fce:e9e7 with SMTP id
 d13-20020a17090ac24d00b002991fcee9e7mr11265715pjx.32.1708428378821; Tue, 20
 Feb 2024 03:26:18 -0800 (PST)
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
 <CAHCN7xJi-6W6x+OJmkNwOX45SM4WHD5zkN42ZOp8ZxFnp3YL5w@mail.gmail.com>
 <1ff513b9-d4fd-4663-b46b-bb9662e3881c@imgtec.com> <CAHCN7xJ0TTS_-PA3Ox_RCpfyHJFk-s=-zs8W1Zm3dQTUAoqbpg@mail.gmail.com>
 <f2b2671e-5acc-4dec-9c2e-3c9cd2e1f19e@imgtec.com>
In-Reply-To: <f2b2671e-5acc-4dec-9c2e-3c9cd2e1f19e@imgtec.com>
From: Adam Ford <aford173@gmail.com>
Date: Tue, 20 Feb 2024 05:26:07 -0600
Message-ID: <CAHCN7xJAfg8+8KWsXNu+QT2swByH=Oc4seK4Gin2NEvS=pV2uw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depend on ARCH_K3
To: Matt Coster <Matt.Coster@imgtec.com>
Cc: Maxime Ripard <mripard@kernel.org>, Biju Das <biju.das.jz@bp.renesas.com>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Frank Binns <Frank.Binns@imgtec.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Sarah Walker <Sarah.Walker@imgtec.com>, Javier Martinez Canillas <javierm@redhat.com>, Nishanth Menon <nm@ti.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 3:21=E2=80=AFAM Matt Coster <Matt.Coster@imgtec.com=
> wrote:
>
> Hi Adam,
>
> On 19/02/2024 20:38, Adam Ford wrote:
> > On Mon, Feb 19, 2024 at 3:00=E2=80=AFAM Matt Coster <Matt.Coster@imgtec=
com> wrote:
> >>
> >> Hi Adam,
> >>
> >> On 18/02/2024 23:26, Adam Ford wrote:
> >>> On Fri, Feb 16, 2024 at 8:14=E2=80=AFAM Maxime Ripard <mripard@kernel=
org> wrote:
> >>>>
> >>>> On Fri, Feb 16, 2024 at 09:13:14AM +0000, Biju Das wrote:
> >>>>> Hi Maxime Ripard,
> >>>>>
> >>>>>> -----Original Message-----
> >>>>>> From: Maxime Ripard <mripard@kernel.org>
> >>>>>> Sent: Friday, February 16, 2024 9:05 AM
> >>>>>> Subject: Re: RE: [PATCH v2] drm/imagination: DRM_POWERVR should de=
pend on
> >>>>>> ARCH_K3
> >>>>>>
> >>>>>> On Fri, Feb 16, 2024 at 08:47:46AM +0000, Biju Das wrote:
> >>>>>>> Hi Adam Ford,
> >>>>>>>
> >>>>>>>> -----Original Message-----
> >>>>>>>> From: Adam Ford <aford173@gmail.com>
> >>>>>>>> Sent: Thursday, February 15, 2024 11:36 PM
> >>>>>>>> Subject: Re: [PATCH v2] drm/imagination: DRM_POWERVR should depe=
nd
> >>>>>>>> on
> >>>>>>>> ARCH_K3
> >>>>>>>>
> >>>>>>>> On Thu, Feb 15, 2024 at 11:22=E2=80=AFAM Adam Ford <aford173@gma=
il.com> wrote:
> >>>>>>>>>
> >>>>>>>>> On Thu, Feb 15, 2024 at 11:10=E2=80=AFAM Adam Ford <aford173@gm=
ail.com>
> >>>>>> wrote:
> >>>>>>>>>>
> >>>>>>>>>> On Thu, Feb 15, 2024 at 10:54=E2=80=AFAM Geert Uytterhoeven
> >>>>>>>>>> <geert@linux-m68k.org> wrote:
> >>>>>>>>>>>
> >>>>>>>>>>> Hi Maxime,
> >>>>>>>>>>>
> >>>>>>>>>>> On Thu, Feb 15, 2024 at 5:18=E2=80=AFPM Maxime Ripard
> >>>>>>>>>>> <mripard@kernel.org>
> >>>>>>>> wrote:
> >>>>>>>>>>>> On Thu, Feb 15, 2024 at 01:50:09PM +0100, Geert Uytterhoeven
> >>>>>>>> wrote:
> >>>>>>>>>>>>> Using the Imagination Technologies PowerVR Series 6 GPU
> >>>>>>>>>>>>> requires a proprietary firmware image, which is currently
> >>>>>>>>>>>>> only available for Texas Instruments K3 AM62x SoCs.  Hence
> >>>>>>>>>>>>> add a dependency on ARCH_K3, to prevent asking the user
> >>>>>>>>>>>>> about this driver when configuring a kernel without Texas
> >>>>>>>>>>>>> Instruments K3
> >>>>>>>> Multicore SoC support.
> >>>>>>>>>>>>
> >>>>>>>>>>>> This wasn't making sense the first time you sent it, and now
> >>>>>>>>>>>> that commit log is just plain wrong. We have firmwares for
> >>>>>>>>>>>> the G6110, GX6250, GX6650, BXE-4-32, and BXS-4-64 models,
> >>>>>>>>>>>> which can be found on (at least) Renesas, Mediatek,
> >>>>>>>>>>>> Rockchip, TI and StarFive, so across three
> >>>>>>>>>>>
> >>>>>>>>>>> I am so happy to be proven wrong!
> >>>>>>>>>>> Yeah, GX6650 is found on e.g. R-Car H3, and GX6250 on e.g.
> >>>>>>>>>>> R-Car M3-
> >>>>>>>> W.
> >>>>>>>>>>>
> >>>>>>>>>>>> architectures and 5 platforms. In two months.
> >>>>>>>>>>>
> >>>>>>>>>>> That sounds like great progress, thanks a lot!
> >>>>>>>>>>>
> >>>>>>>>>> Geert,
> >>>>>>>>>>
> >>>>>>>>>>> Where can I find these firmwares? Linux-firmware[1] seems to
> >>>>>>>>>>> lack all but the original K3 AM62x one.
> >>>>>>>>>>
> >>>>>>>>>> I think PowerVR has a repo [1], but the last time I checked it=
,
> >>>>>>>>>> the BVNC for the firmware didn't match what was necessary for
> >>>>>>>>>> the GX6250 on the RZ/G2M.  I can't remember what the
> >>>>>>>>>> corresponding R-Car3 model is.  I haven't tried recently becau=
se
> >>>>>>>>>> I was told more documentation for firmware porting would be
> >>>>>>>>>> delayed until everything was pushed into the kernel and Mesa.
> >>>>>>>>>> Maybe there is a better repo and/or newer firmware somewhere e=
lse.
> >>>>>>>>>>
> >>>>>>>>> I should have doubled checked the repo contents before I sent m=
y
> >>>>>>>>> last e-mail , but it appears the firmware  [2] for the RZ/G2M,
> >>>>>>>>> might be present now. I don't know if there are driver updates
> >>>>>>>>> necessary. I checked my e-mails, but I didn't see any
> >>>>>>>>> notification, or I would have tried it earlier.  Either way, th=
ank
> >>>>>>>>> you Frank for adding it.  I'll try to test when I have some tim=
e.
> >>>>>>>>>
> >>>>>>>>
> >>>>>>>> I don't have the proper version of Mesa setup yet, but for what =
it's
> >>>>>>>> worth, the firmware loads without error, and it doesn't hang.
> >>>>>>>
> >>>>>>> Based on [1] and [2],
> >>>>>>>
> >>>>>>> kmscube should work on R-Car as it works on RZ/G2L with panfrost =
as
> >>>>>>> earlier version of RZ/G2L which uses drm based on RCar-Du, later =
changed
> >>>>>> to rzg2l-du.
> >>>>>>
> >>>>>> IIRC, the mesa support isn't there yet for kmscube to start.
> >>>>>
> >>>>> What about glmark2? I tested glmark2 as well.
> >>>>
> >>>> It's not really a matter of kmscube itself, but the interaction with=
 the
> >>>> compositor entirely. You can run a headless vulkan rendering, but an
> >>>> application that renders to a window won't work.
> >>>
> >>> I have made a little progress.  I have Ubuntu running on an RZ/G2M
> >>> (Rogue GX6250) with a device tree configuring the GPU and the GPU
> >>> loads with firmware.
> >>>
> >>>   powervr fd000000.gpu: [drm] loaded firmware powervr/rogue_4.45.2.58=
_v1.fw
> >>>   powervr fd000000.gpu: [drm] FW version v1.0 (build 6513336 OS)
> >>>   [drm] Initialized powervr 1.0.0 20230904 for fd000000.gpu on minor =
0
> >>>
> >>> drmdevice lists card0 and renderD128
> >>> --- Checking the number of DRM device available ---
> >>> --- Devices reported 2 ---
> >>> --- Retrieving devices information (PCI device revision is ignored) -=
--
> >>> device[0]
> >>> +-> available_nodes 0x05
> >>> +-> nodes
> >>> |   +-> nodes[0] /dev/dri/card0
> >>> |   +-> nodes[2] /dev/dri/renderD128
> >>> +-> bustype 0002
> >>> |   +-> platform
> >>> |       +-> fullname /soc/gpu@fd000000
> >>> +-> deviceinfo
> >>>     +-> platform
> >>>         +-> compatible
> >>>                     renesas,r8a774a1-gpu
> >>>                     img,img-axe
> >>>
> >>> There is more to this dump, but it seems to repeat. I wanted to show
> >>> that it seems like it's trying to work.
> >>>
> >>> I think I need to modify the powervr code in mesa to recognize the
> >>> renesas,r8a774a1-gpu and associate it with the rcar-du, but I am not
> >>> sure, and I am hoping someone might be able to provide some guidance,
> >>> since I think I am missing something somewhere. I modified
> >>> pvr_device.c in the mesa driver to attempt do this:
> >>>
> >>> /* This is the list of supported DRM render/display driver configs. *=
/
> >>> static const struct pvr_drm_device_config pvr_drm_configs[] =3D {
> >>>    DEF_CONFIG("mediatek,mt8173-gpu", "mediatek-drm"),
> >>>    DEF_CONFIG("ti,am62-gpu", "ti,am625-dss"),
> >>>    DEF_CONFIG("renesas,r8a774a1-gpu", "rcar-du"),
> >>> };
> >>>
> >>> When I run modetest -M rcar-du, I can see the encoders and connectors
> >>> and I can display test patterns, so the rcar-du is working.
> >>>
> >>> I built Mesa 24.0.1 with the following options:
> >>>
> >>> meson setup builddir -Dvulkan-drivers=3Dimagination-experimental
> >>> -Dimagination-srv=3Dtrue -Dtools=3Dall -Dgallium-drivers=3Dzink,kmsro=
,swrast
> >>>
> >>> I have tried to set PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1 the Mesa
> >>> documentation for the powerVR, and I have exported the variable for
> >>> VK_ICD_FILENAMES to point to the powervr json file.
> >>>
> >>> when I try to run glmark2-drm, I was expecting the GL reddered to be
> >>> the powervr, but it keeps using the
> >>> GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)
> >>>
> >>> I realize this driver is still in its infancy, but I was hoping
> >>> someone could give me some guidance to let me know if the work to do
> >>> is on the Mesa side or the rcar-du driver side, or something else.
> >>>
> >>> I rebuilt both libdrm and mesa.  While I don't get any errors, I also
> >>> don't get the hardware acceleration I was hoping for.
> >>>
> >>> I even tried  PVR_I_WANT_A_BROKEN_VULKAN_DRIVER=3D1
> >>> MESA_LOADER_DRIVER_OVERRIDE=3Dzink MESA_DEBUG=3Dcontect glmark2-drm
> >>>
> >>> ...but it only renders with llvmpipe
> >>>
> >>>     glmark2 2023.01
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> >>>     OpenGL Information
> >>>     GL_VENDOR:      Mesa
> >>>     GL_RENDERER:    llvmpipe (LLVM 15.0.7, 128 bits)
> >>>     GL_VERSION:     4.5 (Compatibility Profile) Mesa 24.0.1
> >>>     Surface Config: buf=3D32 r=3D8 g=3D8 b=3D8 a=3D8 depth=3D32 stenc=
il=3D0 samples=3D0
> >>>     Surface Size:   3840x2160 fullscreen
> >>>
> >>>
> >>> I am not as familiar with the Mesa side, but if I can get this workin=
g
> >>> to a point where something is rendered, even if it's not 100%
> >>> compliant, I'd like to push patches to the kernel and/or Mesa if
> >>> necessary.
> >>>
> >>> adam
> >>>
> >>>
> >>>
> >>>
> >>>>
> >>>> Maxime
> >>
> >> I suggest you try running Vulkan demos (we use Sascha Willems=E2=80=99=
 [1])
> >> instead of GL at this stage. Support for Zink is currently under heavy
> >> development so you may have trouble differentiating between issues wit=
h
> >> your kernel changes and the incompleteness in Mesa.
> >
> > I hacked the look-up-tables in the Mesa PowerVR driver to match the
> > values of the other GX6250. I know there must be some minor
> > differences, but I don't know what they are right now.
>
> In case you missed my other email, we have device info for the GX6250
> variant you=E2=80=99re using in [2]. I=E2=80=99ve been informed that bran=
ch should be
> usable as-is =E2=80=93 can you give that a try?

I did  migrate to the branch you referenced and remove my hacked
lookup-table, but I get similar results.

>
> > I also had to tweak   src/imagination/vulkan/pvr_device.c again to the
> > following:
> >   DEF_CONFIG("renesas,r8a774a1-gpu", "renesas,du-r8a774a1"),
>
> Ah yes, not perfectly as-is then. These lines (pvr_drm_configs) declare
> the pairing of GPU to display hardware. You=E2=80=99ll still need this tw=
eak.
>
> > I am not positive that is the correct thing to do, but with that, I
> > can now run vulkaninfo.
> > I know that it's not fully Vulkan compliant yet, but it appears there
> > is some progress:
> >
> > Layers: count =3D 2
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > VK_LAYER_MESA_device_select (Linux device selection layer) Vulkan
> > version 1.3.211, layer version 1:
> >         Layer Extensions: count =3D 0
> >         Devices: count =3D 2
> >                 GPU id =3D 0 (Imagination PowerVR Rogue GX6250)
> >                 Layer-Device Extensions: count =3D 0
> >
> >                 GPU id =3D 1 (llvmpipe (LLVM 15.0.7, 128 bits))
> >                 Layer-Device Extensions: count =3D 0
> >
> > VK_LAYER_MESA_overlay (Mesa Overlay layer) Vulkan version 1.3.211,
> > layer version 1:
> >         Layer Extensions: count =3D 0
> >         Devices: count =3D 2
> >                 GPU id =3D 0 (Imagination PowerVR Rogue GX6250)
> >                 Layer-Device Extensions: count =3D 0
> >
> >                 GPU id =3D 1 (llvmpipe (LLVM 15.0.7, 128 bits))
> >                 Layer-Device Extensions: count =3D 0
> >
> >
> > I then tried to redndr with vkgears, but it didn't redner.  When I run
> > vkgears, I get the following:
> >
> > LAYER:            Searching for layer manifest files
> > LAYER:               In following locations:
> > LAYER:                  /home/aford/.config/vulkan/implicit_layer.d
> > LAYER:                  /etc/xdg/xdg-ubuntu/vulkan/implicit_layer.d
> > LAYER:                  /etc/xdg/vulkan/implicit_layer.d
> > LAYER:                  /etc/vulkan/implicit_layer.d
> > LAYER:                  /home/aford/.local/share/vulkan/implicit_layer.=
d
> > LAYER:                  /usr/share/ubuntu/vulkan/implicit_layer.d
> > LAYER:                  /usr/share/gnome/vulkan/implicit_layer.d
> > LAYER:                  /usr/local/share/vulkan/implicit_layer.d
> > LAYER:                  /usr/share/vulkan/implicit_layer.d
> > LAYER:                  /var/lib/snapd/desktop/vulkan/implicit_layer.d
> > LAYER:               Found the following files:
> > LAYER:
> > /usr/share/vulkan/implicit_layer.d/VkLayer_MESA_device_select.json
> > LAYER:            Searching for layer manifest files
> > LAYER:               In following locations:
> > LAYER:                  /home/aford/.config/vulkan/explicit_layer.d
> > LAYER:                  /etc/xdg/xdg-ubuntu/vulkan/explicit_layer.d
> > LAYER:                  /etc/xdg/vulkan/explicit_layer.d
> > LAYER:                  /etc/vulkan/explicit_layer.d
> > LAYER:                  /home/aford/.local/share/vulkan/explicit_layer.=
d
> > LAYER:                  /usr/share/ubuntu/vulkan/explicit_layer.d
> > LAYER:                  /usr/share/gnome/vulkan/explicit_layer.d
> > LAYER:                  /usr/local/share/vulkan/explicit_layer.d
> > LAYER:                  /usr/share/vulkan/explicit_layer.d
> > LAYER:                  /var/lib/snapd/desktop/vulkan/explicit_layer.d
> > LAYER:               Found the following files:
> > LAYER:
> > /usr/share/vulkan/explicit_layer.d/VkLayer_MESA_overlay.json
> > ERROR:            loader_validate_instance_extensions: Instance
> > extension VK_KHR_wayland_surface not supported by available ICDs or
> > enabled layers.
> > Failed to create Vulkan instance.
> >
> > I have tried running in X.org mode instead of Wayland, but I get a
> > different set of errors:
>
> We haven=E2=80=99t been testing with window systems yet =E2=80=93 can you=
 try building
> the Sascha Willems demos [1] with -DUSE_D2D_WSI=3DON and try running
> triangle?

I didn't realize you hadn't tried window systems yet.

I'll give that a try.  I appreciate the suggestions.

adam
>
> Matt
>
> [2]: https://gitlab.freedesktop.org/imagination/mesa/-/tree/dev/devinfo
>
> > [ 11102.013] (II) Loading /usr/lib/xorg/modules/libfbdevhw.so
> > [ 11102.014] (II) Module fbdevhw: vendor=3D"X.Org Foundation"
> > [ 11102.014]    compiled for 1.21.1.7, module version =3D 0.0.2
> > [ 11102.014]    ABI class: X.Org Video Driver, version 25.2
> > [ 11102.015] (II) FBDEV(0): using default device
> > [ 11102.016] (II) modeset(G0): using drv /dev/dri/card1
> > [ 11102.016] (EE)
> > Fatal server error:
> > or all framebuffer devices
> > [ 11102.016] (EE)
> > [ 11102.017] (EE)
> > Please consult the The X.Org Foundation support at http://wiki.x.org  f=
or help.
> >
> > I think I am close.
> >
> > adam
> >>
> >> Matt
> >>
> >> [1]: https://github.com/SaschaWillems/Vulkan

