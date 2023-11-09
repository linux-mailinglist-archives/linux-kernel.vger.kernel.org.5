Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FF17E70AB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 18:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344822AbjKIRpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 12:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234659AbjKIRp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 12:45:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42D902D65;
        Thu,  9 Nov 2023 09:45:27 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DFDCB6607423;
        Thu,  9 Nov 2023 17:45:23 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699551925;
        bh=c2JNVnT9JoiIN7t0Y6Bmq6v+0myfgFD1QT9HldMSizU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lZKzx66QBHtImSKlg+XJGUFdKmZAY9Of/Ub9fCFMrzTNfLAv7hE3vxqdS55nX8Vts
         LEC5MhKYS507k9rhCWGNZiCfM3qKq8SNRsFWosMVa3lxk77Q1oiJu68I9Al1AyYLch
         UCfVyN5W9kZSOpFAwepeZmOcYzDHmmeLIDbzE9xMMNEKrEKRNm6TaUhw6jS1RI9W+A
         9Nk7bA7S0tzJ6lSI67o2IK34Hu6W6mo8bFtAVzEyVpHdk+1Z3MGOySjnZWjiVZSoWL
         TLCBw2O5b1a9o+mvJA/wAlWIM/4nSgBaKbl62V8ziC4Dsv0MiKgLS/1kYeQTpzg4nB
         7A5b55ucqqLug==
Message-ID: <27626e6685fccad44eaec3a50fd330094d5d72fe.camel@collabora.com>
Subject: Re: [PATCH 0/9] media: rkvdec: Add HEVC backend
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 09 Nov 2023 12:45:14 -0500
In-Reply-To: <20231105233630.3927502-1-jonas@kwiboo.se>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

Le dimanche 05 novembre 2023 =C3=A0 23:36 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> This series add a HEVC backend to the Rockchip Video Decoder driver.
>=20
> A version of this HEVC backend has been in use by the LibreELEC distro
> for the past 3+ years [1]. It was initially created based on a copy of
> the H264 backend, unstable HEVC uAPI controls and a cabac table + scaling
> matrix functions shamelessly copied 1:1 from the Rockchip mpp library.
>=20
> It has since then been extended to use the stable HEVC uAPI controls and
> improved opon e.g. to include support for rk3288 and fix decoding issues
> by Alex Bee and Nicolas Dufresne.
>=20
> The version submitted in this series is based on the code currently used
> by the LibreELEC distro, excluding hard/soft reset, and with cabac table
> and scaling matrix functions picked from Sebastian Fricke prior series
> to add a HEVC backend [2].
>=20
> Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for making
> this series possible!
>=20
> Patch 1 add the new HEVC backend.
> Patch 2-3 add variants support to the driver.
> Patch 4 add support for a rk3288 variant.
> Patch 5 add a rk3328 variant to work around hw quirks.
> Patch 6-7 add device tree node for rk3288.
> Patch 8-9 extend vdec node reg size to include cache/perf registers.
>=20
> This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
>=20
>   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>   ...
>   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warn=
ings: 0
>=20
>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-reques=
t
>   ...
>   Ran 135/147 tests successfully

Just tested, same score on GStreamer. Failing are:

    - DBLK_D_VIXS_2
    - DSLICE_A_HHI_5
    - EXT_A_ericsson_4
    - PICSIZE* (all 4, resolution reason)
    - SAODBLK_A_MainConcept_4
    - SAODBLK_B_MainConcept_4
    - TSUNEQBD_A_MAIN10_Technicolor_2
    - WPP_D_ericsson_MAIN_2

To be noted that TSUNEQBD_A_MAIN10_Technicolor_2 has 10bit luma, and
9bit chroma. Works on Hantro G2, but I just tried waving your check,=20
and the results did not match the MD5. This is of low important though,
I have never seen such a stream in the wild and MTK VCODEC also does
not support it.

>=20
>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-reques=
t
>   ...
>   Ran 9/9 tests successfully

Fails with GStreamer, but most likely a GStreamer issue, I'll have a
look later. JCT-VC-RExt and JCT-VC-SCC also fails. I know of a fact
that we did not implement SCC in the uAPI (and it may not be supported
by this hardware anyway).

Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
> And on a TinkerBoard (RK3288):
>=20
>   v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
>   ...
>   Total for rkvdec device /dev/video3: 47, Succeeded: 47, Failed: 0, Warn=
ings: 0
>=20
>   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-reques=
t
>   ...
>   Ran 137/147 tests successfully
>=20
>   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-reques=
t
>   ...
>   Ran 9/9 tests successfully
>=20
> This series depend on the following series:
> - media: rkvdec: Add H.264 High 10 and 4:2:2 profile support [3]
>=20
> To fully runtime test this series you need above series and ffmpeg
> patches from [4], this series and its depends is also available at [5].
>=20
> Full summary of fluster run can be found at [6].
>=20
> [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/Rockch=
ip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch
> [2] https://lore.kernel.org/linux-media/20230101-patch-series-v2-6-2-rc1-=
v2-0-fa1897efac14@collabora.com/
> [3] https://lore.kernel.org/linux-media/20231105165521.3592037-1-jonas@kw=
iboo.se/
> [4] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
> [5] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-hevc-=
v1/
> [6] https://gist.github.com/Kwiboo/4c0ed87774dede44ce6838451a1ec93d
>=20
> Regards,
> Jonas
>=20
> Alex Bee (5):
>   media: rkvdec: Add variants support
>   media: rkvdec: Add RK3288 variant
>   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
>   ARM: dts: rockchip: Add vdec node for RK3288
>   arm64: dts: rockchip: Expand reg size of vdec node for RK3399
>=20
> Jonas Karlman (4):
>   media: rkvdec: Add HEVC backend
>   media: rkvdec: Implement capability filtering
>   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
>   arm64: dts: rockchip: Expand reg size of vdec node for RK3328
>=20
>  .../bindings/media/rockchip,vdec.yaml         |    4 +-
>  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
>  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |    2 +-
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |    6 +-
>  drivers/staging/media/rkvdec/Makefile         |    2 +-
>  drivers/staging/media/rkvdec/TODO             |    7 -
>  .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1848 +++++++++++++++++
>  drivers/staging/media/rkvdec/rkvdec-hevc.c    |  823 ++++++++
>  drivers/staging/media/rkvdec/rkvdec-regs.h    |    3 +
>  drivers/staging/media/rkvdec/rkvdec-vp9.c     |   10 +
>  drivers/staging/media/rkvdec/rkvdec.c         |  180 +-
>  drivers/staging/media/rkvdec/rkvdec.h         |   15 +
>  12 files changed, 2886 insertions(+), 31 deletions(-)
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
>  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
>=20

