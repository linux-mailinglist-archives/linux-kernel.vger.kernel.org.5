Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A48E57E4B0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344104AbjKGVnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:43:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbjKGVnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:43:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1E710DF;
        Tue,  7 Nov 2023 13:43:13 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BDF06607401;
        Tue,  7 Nov 2023 21:43:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699393391;
        bh=OBGXpRnlFzwp5OJvsG7Sy/2FmTCeMQkmDM476G9u2lQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=TJkRjPGYStWKLmgF4ytNxy65LpERkg2dKy1ux0ILCyKTeeCi4qte6wNFyGIOJWuqU
         SxZO3WMhxY7ER10ROewX/cbWVm4+qdEqHAJWZz2nOcaUpYmlJ7OsBv+F5YiHNZQoMc
         w9foClFwkz4cSXk2w1dgZ50Qx7mOB1qjfe6epDv3sv8Qv5RlH27oPDRzfaMdQv5O8V
         qrzM9J4wO7WucGvtYfSRhRT7NnxeDooGvTdQ25ZG8mon+hxDQxIN9pfw6UQBXDBB35
         Wlv8gzV237j780ulrj2yhHtEPoLifclMP+shWl9l9RZUkQYxRrsDC3y3a5jI1Y0YdM
         vXWTl3Vv6Fajg==
Message-ID: <874b6ea3309ff302dcdd9ff92f9098130b979c27.camel@collabora.com>
Subject: Re: [PATCH v4 00/11] media: rkvdec: Add H.264 High 10 and 4:2:2
 profile support
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Jonas Karlman <jonas@kwiboo.se>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Sebastian Fricke <sebastian.fricke@collabora.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 07 Nov 2023 16:43:01 -0500
In-Reply-To: <20231105165521.3592037-1-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonas,

thanks for this work.

Le dimanche 05 novembre 2023 =C3=A0 16:54 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> This is a revival of a 3 year old series [1] now that NV15/NV20/NV30 supp=
ort
> for display driver have landed in mainline tree.
>=20
> This series adds H.264 High 10 and 4:2:2 profile support to the Rockchip
> Video Decoder driver.
>=20
> Patch 1 adds helpers for calculating plane bytesperline and sizeimage.
> Patch 2 adds two new pixelformats for semi-planer 10-bit 4:2:0/4:2:2 YUV.
>=20
> Patch 3 change to use bytesperline and buffer height to configure strides=
.
> Patch 4 change to use values from SPS/PPS control to configure the HW.
> Patch 5 remove an unnecessary call to validate sps at streaming start.
>=20
> Patch 6-10 refactor code to support filtering of CAPUTRE formats based
> on the image format returned from a get_image_fmt ops.
>=20
> Patch 11 adds final bits to support H.264 High 10 and 4:2:2 profiles.
>=20
> Tested on a ROCK Pi 4 (RK3399) and Rock64 (RK3328):
>=20
>   v4l2-compliance 1.24.1, 64 bits, 64-bit time_t
>   ...
>   Total for rkvdec device /dev/video1: 46, Succeeded: 46, Failed: 0, Warn=
ings: 0
>=20
>   Running test suite JVT-FR-EXT with decoder FFmpeg-H.264-V4L2-request
>   ...
>   Ran 65/69 tests successfully

I added GStreamer support for these formats and could confirm this
results with GStreamer too.

https://gitlab.freedesktop.org/gstreamer/gstreamer/-/merge_requests/5612


For the set:
Tested-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>

>=20
>   Running test suite JVT-AVC_V1 with decoder FFmpeg-H.264-V4L2-request
>   ...
>   Ran 127/135 tests successfully

I'm getting 129 with GStreamer, which matches also with FFMpeg software
decoder.

>=20
> Before this series:
>=20
>   Running test suite JVT-FR-EXT with decoder FFmpeg-H.264-V4L2-request
>   ...
>   Ran 44/69 tests successfully

I had 43 with GStreamer, but then I notice you fixed something in
fluster. The good news this is now upstream, thanks for spotting.

https://github.com/fluendo/fluster/pull/148

>=20
> Changes in v4:
> - Fix failed v4l2-compliance tests related to CAPTURE queue
> - Rework CAPTURE format filter anv validate to use an image format
> - Run fluster test suite JVT-FR-EXT [4] and JVT-AVC_V1 [5]
> Link to v3: https://lore.kernel.org/linux-media/20231029183427.1781554-1-=
jonas@kwiboo.se/
>=20
> Changes in v3:
> - Drop merged patches
> - Use bpp and bpp_div instead of prior misuse of block_w/block_h
> - New patch to use values from SPS/PPS control to configure the HW
> - New patch to remove an unnecessary call to validate sps at streaming st=
art
> - Reworked pixel format validation
> Link to v2: https://lore.kernel.org/linux-media/20200706215430.22859-1-jo=
nas@kwiboo.se/
>=20
> Changes in v2:
> - Collect r-b tags
> - SPS pic width and height in mbs validation moved to rkvdec_try_ctrl
> - New patch to not override output buffer sizeimage
> - Reworked pixel format validation
> - Only align decoded buffer instead of changing frmsize step_width
> Link to v1: https://lore.kernel.org/linux-media/20200701215616.30874-1-jo=
nas@kwiboo.se/
>=20
> Following commits adds support for NV15/NV20/NV30 to VOP driver:
> 728c15b4b5f3 ("drm/fourcc: Add NV20 and NV30 YUV formats")
> d4b384228562 ("drm/rockchip: vop: Add NV15, NV20 and NV30 support")
>=20
> To fully runtime test this series you may need above drm commits and ffmp=
eg
> patches from [2], this series and drm patches is also available at [3].
>=20
> [1] https://lore.kernel.org/linux-media/20200706215430.22859-1-jonas@kwib=
oo.se/
> [2] https://github.com/Kwiboo/FFmpeg/commits/v4l2-request-n6.1-dev/
> [3] https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-high-=
10-v4/
> [4] https://gist.github.com/Kwiboo/f4ac15576b2c72887ae2bc5d58b5c865
> [5] https://gist.github.com/Kwiboo/459a1c8f1dcb56e45dc7a7a29cc28adf
>=20
> Regards,
> Jonas
>=20
> Alex Bee (1):
>   media: rkvdec: h264: Don't hardcode SPS/PPS parameters
>=20
> Jonas Karlman (10):
>   media: v4l2-common: Add helpers to calculate bytesperline and
>     sizeimage
>   media: v4l2: Add NV15 and NV20 pixel formats
>   media: rkvdec: h264: Use bytesperline and buffer height as virstride
>   media: rkvdec: h264: Remove SPS validation at streaming start
>   media: rkvdec: Extract rkvdec_fill_decoded_pixfmt into helper
>   media: rkvdec: Move rkvdec_reset_decoded_fmt helper
>   media: rkvdec: Extract decoded format enumeration into helper
>   media: rkvdec: Add image format concept
>   media: rkvdec: Add get_image_fmt ops
>   media: rkvdec: h264: Support High 10 and 4:2:2 profiles
>=20
>  .../media/v4l/pixfmt-yuv-planar.rst           | 128 +++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |  80 +++----
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>  drivers/staging/media/rkvdec/rkvdec-h264.c    |  83 +++----
>  drivers/staging/media/rkvdec/rkvdec.c         | 217 +++++++++++++-----
>  drivers/staging/media/rkvdec/rkvdec.h         |  18 +-
>  include/uapi/linux/videodev2.h                |   2 +
>  7 files changed, 396 insertions(+), 134 deletions(-)
>=20

