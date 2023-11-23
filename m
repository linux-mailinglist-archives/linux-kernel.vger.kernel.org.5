Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB657F63EF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 17:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229664AbjKWQ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 11:29:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWQ3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 11:29:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABA61A4;
        Thu, 23 Nov 2023 08:29:36 -0800 (PST)
Received: from nicolas-tpx395.localdomain (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16AF2660738E;
        Thu, 23 Nov 2023 16:29:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1700756974;
        bh=W9OJno9zWL87Qxzt1lrw2HV9tKieFu5N7CxYY6XcJ5w=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=nPSXvad4jVLNowxJzDky3utJQGiIxMatQmLQ2Mc6BMSkizxTDIUpveMwNRPpqYhsU
         93sqjq3R+JX85bgS0SdacRYcrFPO/SNzaq5Ze6SZ3ev3eW376gazom5CqfXNsDnbOi
         +2b5v/soOySGMxwRTuPDkc3ixdLmr6o1W4kGgXXWJqQq8ex+RCkFfixxVEEFv4UzVY
         UrbamrDKFjOaYYrKfsmxnbdXpql13gfslpY4nPNdUhx68+51mYio5AIF1umW2uBe+q
         70WmiUT55xrk4uz3q6aAWctbLntZWeAm/PV8XD4slVIPRN0k5qKFV6db4Wstm0Malr
         1C03wv5GQUHDw==
Message-ID: <8c754650a727490c1a9efec4bb2258e46c3d2752.camel@collabora.com>
Subject: Re: [PATCH 0/9] media: rkvdec: Add HEVC backend
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Thu, 23 Nov 2023 11:29:23 -0500
In-Reply-To: <82f81f63-3dfa-42fe-8744-63f36d73bb77@xs4all.nl>
References: <20231105233630.3927502-1-jonas@kwiboo.se>
         <39d991e9-6afd-4207-ad09-e342a6c02485@xs4all.nl>
         <c35c91be-a931-47e8-b5e8-5a4a83c841da@kwiboo.se>
         <82f81f63-3dfa-42fe-8744-63f36d73bb77@xs4all.nl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le mercredi 22 novembre 2023 =C3=A0 16:23 +0100, Hans Verkuil a =C3=A9crit=
=C2=A0:
> On 09/11/2023 18:44, Jonas Karlman wrote:
> > Hi Hans,
> >=20
> > On 2023-11-07 14:49, Hans Verkuil wrote:
> > > Hi Jonas,
> > >=20
> > > On 06/11/2023 00:36, Jonas Karlman wrote:
> > > > This series add a HEVC backend to the Rockchip Video Decoder driver=
.
> > > >=20
> > > > A version of this HEVC backend has been in use by the LibreELEC dis=
tro
> > > > for the past 3+ years [1]. It was initially created based on a copy=
 of
> > > > the H264 backend, unstable HEVC uAPI controls and a cabac table + s=
caling
> > > > matrix functions shamelessly copied 1:1 from the Rockchip mpp libra=
ry.
> > > >=20
> > > > It has since then been extended to use the stable HEVC uAPI control=
s and
> > > > improved opon e.g. to include support for rk3288 and fix decoding i=
ssues
> > > > by Alex Bee and Nicolas Dufresne.
> > > >=20
> > > > The version submitted in this series is based on the code currently=
 used
> > > > by the LibreELEC distro, excluding hard/soft reset, and with cabac =
table
> > > > and scaling matrix functions picked from Sebastian Fricke prior ser=
ies
> > > > to add a HEVC backend [2].
> > > >=20
> > > > Big thanks to Alex Bee, Nicolas Dufresne and Sebastian Fricke for m=
aking
> > > > this series possible!
> > >=20
> > > I ran this series through smatch and found these two issues:
> > >=20
> > > drivers/staging/media/rkvdec/rkvdec-hevc.c: In function 'transpose_an=
d_flatten_matrices':
> > > drivers/staging/media/rkvdec/rkvdec-hevc.c:429:83: warning: variable =
'new_value' set but not used [-Wunused-but-set-variable]
> > >   429 |         int i, j, row, x_offset, matrix_offset, rot_index, y_=
offset, matrix_size, new_value;
> > >       |                                                              =
                     ^~~~~~~~~
> > > drivers/staging/media/rkvdec/rkvdec-hevc.c:756 rkvdec_hevc_run_preamb=
le() error: we previously assumed 'ctrl' could be null (see line 755)
> >=20
> > Thanks, will fix in v2.
> >=20
> > >=20
> > > Also, this series drops the HEVC part from the TODO file, but
> > > I wonder if the last remaining item is still valid:
> > >=20
> > > * Evaluate introducing a helper to consolidate duplicated
> > >   code in rkvdec_request_validate and cedrus_request_validate.
> > >   The helper needs to the driver private data associated with
> > >   the videobuf2 queue, from a media request.
> > >=20
> > > It doesn't look like there is much duplicate code at all. It is certa=
inly not
> > > something that prevents this driver from moving out of staging.
> >=20
> > I agree, if this is still valid it is not something that should prevent
> > this driver from moving out of staging.
> >=20
> > There is however one remaining feature/issue that is not listed in TODO=
.
> >=20
> > In certain situations the hw block may need a reset after there has bee=
n
> > a decoding error, especially after a hevc decoding error. Decoding can
> > typically be re-started with successful result after a short pm
> > autosuspend timeout.
> >=20
> > We do have a soft/hard reset implementation in LibreELEC-distro,
> > excluded it from this series because reset is typically not needed, and
> > I think the reset code need some rework to be upstream ready.
> >=20
> > Would missing hard reset support be a reason for keeping this driver
> > in staging?
>=20
> I think Nicolas would be better placed to comment on that. If it is not
> considered a blocker, shouldn't there at least be a patch adding comments
> at the relevant place describing this issue? That way it is at least
> documented as a known issue.

I *think* that Sebastian have identified how to detect when the self reset =
is
not sufficient (and I guess the same may exist in LibreELEC tree). As the
failure is not fatal, and it will recover if you let the codec idle for a
little, I don't have any argument to make this a hard blocker.

But before we unstated with this known issue, I'd like to see this well
documented, and ideally see a kernel warning whenever that state is reached=
.
From there, it will be easy to justify a more invasive change to reset the
entire block. It may also help identify when getting user reports of issues=
.

Nicolas

>=20
> Regards,
>=20
> 	Hans
>=20
> >=20
> > Regards,
> > Jonas
> >=20
> > >=20
> > > Regards,
> > >=20
> > > 	Hans
> > >=20
> > > >=20
> > > > Patch 1 add the new HEVC backend.
> > > > Patch 2-3 add variants support to the driver.
> > > > Patch 4 add support for a rk3288 variant.
> > > > Patch 5 add a rk3328 variant to work around hw quirks.
> > > > Patch 6-7 add device tree node for rk3288.
> > > > Patch 8-9 extend vdec node reg size to include cache/perf registers=
.
> > > >=20
> > > > This was tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
> > > >=20
> > > >   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
> > > >   ...
> > > >   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0=
, Warnings: 0
> > > >=20
> > > >   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-=
request
> > > >   ...
> > > >   Ran 135/147 tests successfully
> > > >=20
> > > >   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-=
request
> > > >   ...
> > > >   Ran 9/9 tests successfully
> > > >=20
> > > > And on a TinkerBoard (RK3288):
> > > >=20
> > > >   v4l2-compliance 1.24.1, 32 bits, 32-bit time_t
> > > >   ...
> > > >   Total for rkvdec device /dev/video3: 47, Succeeded: 47, Failed: 0=
, Warnings: 0
> > > >=20
> > > >   Running test suite JCT-VC-HEVC_V1 with decoder FFmpeg-H.265-V4L2-=
request
> > > >   ...
> > > >   Ran 137/147 tests successfully
> > > >=20
> > > >   Running test suite JCT-VC-MV-HEVC with decoder FFmpeg-H.265-V4L2-=
request
> > > >   ...
> > > >   Ran 9/9 tests successfully
> > > >=20
> > > > This series depend on the following series:
> > > > - media: rkvdec: Add H.264 High 10 and 4:2:2 profile support [3]
> > > >=20
> > > > To fully runtime test this series you need above series and ffmpeg
> > > > patches from [4], this series and its depends is also available at =
[5].
> > > >=20
> > > > Full summary of fluster run can be found at [6].
> > > >=20
> > > > [1] https://github.com/LibreELEC/LibreELEC.tv/blob/master/projects/=
Rockchip/patches/linux/default/linux-2000-v4l2-wip-rkvdec-hevc.patch
> > > > [2] https://lore.kernel.org/linux-media/20230101-patch-series-v2-6-=
2-rc1-v2-0-fa1897efac14@collabora.com/
> > > > [3] https://lore.kernel.org/linux-media/20231105165521.3592037-1-jo=
nas@kwiboo.se/
> > > > [4] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
> > > > [5] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec=
-hevc-v1/
> > > > [6] https://gist.github.com/Kwiboo/4c0ed87774dede44ce6838451a1ec93d
> > > >=20
> > > > Regards,
> > > > Jonas
> > > >=20
> > > > Alex Bee (5):
> > > >   media: rkvdec: Add variants support
> > > >   media: rkvdec: Add RK3288 variant
> > > >   media: rkvdec: Disable QoS for HEVC and VP9 on RK3328
> > > >   ARM: dts: rockchip: Add vdec node for RK3288
> > > >   arm64: dts: rockchip: Expand reg size of vdec node for RK3399
> > > >=20
> > > > Jonas Karlman (4):
> > > >   media: rkvdec: Add HEVC backend
> > > >   media: rkvdec: Implement capability filtering
> > > >   media: dt-bindings: rockchip,vdec: Add RK3288 compatible
> > > >   arm64: dts: rockchip: Expand reg size of vdec node for RK3328
> > > >=20
> > > >  .../bindings/media/rockchip,vdec.yaml         |    4 +-
> > > >  arch/arm/boot/dts/rockchip/rk3288.dtsi        |   17 +-
> > > >  arch/arm64/boot/dts/rockchip/rk3328.dtsi      |    2 +-
> > > >  arch/arm64/boot/dts/rockchip/rk3399.dtsi      |    6 +-
> > > >  drivers/staging/media/rkvdec/Makefile         |    2 +-
> > > >  drivers/staging/media/rkvdec/TODO             |    7 -
> > > >  .../staging/media/rkvdec/rkvdec-hevc-data.c   | 1848 +++++++++++++=
++++
> > > >  drivers/staging/media/rkvdec/rkvdec-hevc.c    |  823 ++++++++
> > > >  drivers/staging/media/rkvdec/rkvdec-regs.h    |    3 +
> > > >  drivers/staging/media/rkvdec/rkvdec-vp9.c     |   10 +
> > > >  drivers/staging/media/rkvdec/rkvdec.c         |  180 +-
> > > >  drivers/staging/media/rkvdec/rkvdec.h         |   15 +
> > > >  12 files changed, 2886 insertions(+), 31 deletions(-)
> > > >  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc-data.c
> > > >  create mode 100644 drivers/staging/media/rkvdec/rkvdec-hevc.c
> > > >=20
> > >=20
> >=20
>=20
>=20

