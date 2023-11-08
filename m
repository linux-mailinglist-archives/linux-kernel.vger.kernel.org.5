Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705E17E4F2D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:52:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344352AbjKHCwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:52:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjKHCwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:52:35 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED3B1722;
        Tue,  7 Nov 2023 18:52:32 -0800 (PST)
Received: from [100.84.166.245] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 17A3D66074E4;
        Wed,  8 Nov 2023 02:52:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699411951;
        bh=56x84uN8wKaIHVowpKm8cQCDQhNz4exGtHGEiO8IHms=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ZkhKj5ouAjRec30yzst59NFli0BWmsYJEC6io+koTAQFWiJzhrnkY6IB/tB+sYJuh
         N166FX59AFsi3gEdJI99mgukIJ92T3sAlIXH5FjLZDOCeO6aoc4UAp1YdZ+G0XCjmL
         SmcBzKs5PVUFQJ9xycV2xJ5sdpjTOspcIjeAzDbVzzXPX5DWo1EY9hA4NuORuW742v
         5zFnjqoJNAU0w2ke3UTdsWSGW8+WtZP4f8nrBrW2XR83iFDA9ptmkQ7ufSynD1ef8l
         4I9BTrnlaPylS1VhOb/67mE3Pk7Ut2HkcFTuvBDX0V9sGIEIp0qMx83F7LDR1dmmqg
         th/pO02Ws9B/w==
Message-ID: <e12bffd61450fde2512632e205be5473e450a4e0.camel@collabora.com>
Subject: Re: [PATCH v4 02/11] media: v4l2: Add NV15 and NV20 pixel formats
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
Date:   Tue, 07 Nov 2023 21:52:18 -0500
In-Reply-To: <20231105165521.3592037-3-jonas@kwiboo.se>
References: <20231105165521.3592037-1-jonas@kwiboo.se>
         <20231105165521.3592037-3-jonas@kwiboo.se>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le dimanche 05 novembre 2023 =C3=A0 16:55 +0000, Jonas Karlman a =C3=A9crit=
=C2=A0:
> Add NV15 and NV20 pixel formats used by the Rockchip Video Decoder for
> 10-bit buffers.
>=20
> NV15 and NV20 is 10-bit 4:2:0/4:2:2 semi-planar YUV formats similar to
> NV12 and NV16, using 10-bit components with no padding between each
> component. Instead, a group of 4 luminance/chrominance samples are
> stored over 5 bytes in little endian order:
>=20
> YYYY =3D UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes
>=20
> The '15' and '20' suffix refers to the optimum effective bits per pixel
> which is achieved when the total number of luminance samples is a
> multiple of 8 for NV15 and 4 for NV20.

I had this mostly documented already in September:

https://patchwork.linuxtv.org/project/linux-media/patch/20230914150651.3114=
134-3-nicolas.dufresne@collabora.com/
https://patchwork.linuxtv.org/project/linux-media/patch/20230914150651.3114=
134-4-nicolas.dufresne@collabora.com/

I think I was improving a bit the documentation avoiding to repeat what
NV15 (little and big endian) is over and over. I've had no feedback on
V2, so assumed it going to be picked, but then it will certainly
conflict with this change.

>=20
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v4:
> - No change
>=20
> v3:
> - Use bpp and bpp_div instead of the misuse of block_w/block_h
> - Update documentation, expand to use full 4x4 sample image
>=20
>  .../media/v4l/pixfmt-yuv-planar.rst           | 128 ++++++++++++++++++
>  drivers/media/v4l2-core/v4l2-common.c         |   2 +
>  drivers/media/v4l2-core/v4l2-ioctl.c          |   2 +
>  include/uapi/linux/videodev2.h                |   2 +
>  4 files changed, 134 insertions(+)
>=20
> diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst =
b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> index 1840224faa41..4366cdcb970e 100644
> --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> @@ -79,6 +79,13 @@ All components are stored with the same number of bits=
 per component.
>        - Cr, Cb
>        - Yes
>        - Linear
> +    * - V4L2_PIX_FMT_NV15
> +      - 'NV15'
> +      - 10
> +      - 4:2:0
> +      - Cb, Cr
> +      - Yes
> +      - Linear

I'd like to see 8 and 10bit formats grouped and not mixed.

>      * - V4L2_PIX_FMT_NV12M
>        - 'NM12'
>        - 8
> @@ -158,6 +165,13 @@ All components are stored with the same number of bi=
ts per component.
>        - Cr, Cb
>        - Yes
>        - Linear
> +    * - V4L2_PIX_FMT_NV20
> +      - 'NV20'
> +      - 10
> +      - 4:2:2
> +      - Cb, Cr
> +      - Yes
> +      - Linear
>      * - V4L2_PIX_FMT_NV16M
>        - 'NM16'
>        - 8
> @@ -288,6 +302,57 @@ of the luma plane.
>        - Cr\ :sub:`11`
> =20
> =20
> +.. _V4L2-PIX-FMT-NV15:
> +
> +NV15
> +----
> +
> +Semi-planar 10-bit YUV 4:2:0 format similar to NV12, using 10-bit compon=
ents
> +with no padding between each component. A group of 4 components are stor=
ed over
> +5 bytes in little endian order.
> +
> +.. flat-table:: Sample 4x4 NV15 Image (1 byte per cell)
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start + 0:
> +      - Y'\ :sub:`00[7:0]`
> +      - Y'\ :sub:`01[5:0]`\ Y'\ :sub:`00[9:8]`
> +      - Y'\ :sub:`02[3:0]`\ Y'\ :sub:`01[9:6]`
> +      - Y'\ :sub:`03[1:0]`\ Y'\ :sub:`02[9:4]`
> +      - Y'\ :sub:`03[9:2]`
> +    * - start + 5:
> +      - Y'\ :sub:`10[7:0]`
> +      - Y'\ :sub:`11[5:0]`\ Y'\ :sub:`10[9:8]`
> +      - Y'\ :sub:`12[3:0]`\ Y'\ :sub:`11[9:6]`
> +      - Y'\ :sub:`13[1:0]`\ Y'\ :sub:`12[9:4]`
> +      - Y'\ :sub:`13[9:2]`
> +    * - start + 10:
> +      - Y'\ :sub:`20[7:0]`
> +      - Y'\ :sub:`21[5:0]`\ Y'\ :sub:`20[9:8]`
> +      - Y'\ :sub:`22[3:0]`\ Y'\ :sub:`21[9:6]`
> +      - Y'\ :sub:`23[1:0]`\ Y'\ :sub:`22[9:4]`
> +      - Y'\ :sub:`23[9:2]`
> +    * - start + 15:
> +      - Y'\ :sub:`30[7:0]`
> +      - Y'\ :sub:`31[5:0]`\ Y'\ :sub:`30[9:8]`
> +      - Y'\ :sub:`32[3:0]`\ Y'\ :sub:`31[9:6]`
> +      - Y'\ :sub:`33[1:0]`\ Y'\ :sub:`32[9:4]`
> +      - Y'\ :sub:`33[9:2]`
> +    * - start + 20:
> +      - Cb\ :sub:`00[7:0]`
> +      - Cr\ :sub:`00[5:0]`\ Cb\ :sub:`00[9:8]`
> +      - Cb\ :sub:`01[3:0]`\ Cr\ :sub:`00[9:6]`
> +      - Cr\ :sub:`01[1:0]`\ Cb\ :sub:`01[9:4]`
> +      - Cr\ :sub:`01[9:2]`
> +    * - start + 25:
> +      - Cb\ :sub:`10[7:0]`
> +      - Cr\ :sub:`10[5:0]`\ Cb\ :sub:`10[9:8]`
> +      - Cb\ :sub:`11[3:0]`\ Cr\ :sub:`10[9:6]`
> +      - Cr\ :sub:`11[1:0]`\ Cb\ :sub:`11[9:4]`
> +      - Cr\ :sub:`11[9:2]`
> +
> +
>  .. _V4L2-PIX-FMT-NV12MT:
>  .. _V4L2-PIX-FMT-NV12MT-16X16:
>  .. _V4L2-PIX-FMT-NV12-4L4:
> @@ -500,6 +565,69 @@ number of lines as the luma plane.
>        - Cr\ :sub:`32`
> =20
> =20
> +.. _V4L2-PIX-FMT-NV20:
> +
> +NV20
> +----
> +
> +Semi-planar 10-bit YUV 4:2:2 format similar to NV16, using 10-bit compon=
ents
> +with no padding between each component. A group of 4 components are stor=
ed over
> +5 bytes in little endian order.
> +
> +.. flat-table:: Sample 4x4 NV20 Image (1 byte per cell)
> +    :header-rows:  0
> +    :stub-columns: 0
> +
> +    * - start + 0:
> +      - Y'\ :sub:`00[7:0]`
> +      - Y'\ :sub:`01[5:0]`\ Y'\ :sub:`00[9:8]`
> +      - Y'\ :sub:`02[3:0]`\ Y'\ :sub:`01[9:6]`
> +      - Y'\ :sub:`03[1:0]`\ Y'\ :sub:`02[9:4]`
> +      - Y'\ :sub:`03[9:2]`
> +    * - start + 5:
> +      - Y'\ :sub:`10[7:0]`
> +      - Y'\ :sub:`11[5:0]`\ Y'\ :sub:`10[9:8]`
> +      - Y'\ :sub:`12[3:0]`\ Y'\ :sub:`11[9:6]`
> +      - Y'\ :sub:`13[1:0]`\ Y'\ :sub:`12[9:4]`
> +      - Y'\ :sub:`13[9:2]`
> +    * - start + 10:
> +      - Y'\ :sub:`20[7:0]`
> +      - Y'\ :sub:`21[5:0]`\ Y'\ :sub:`20[9:8]`
> +      - Y'\ :sub:`22[3:0]`\ Y'\ :sub:`21[9:6]`
> +      - Y'\ :sub:`23[1:0]`\ Y'\ :sub:`22[9:4]`
> +      - Y'\ :sub:`23[9:2]`
> +    * - start + 15:
> +      - Y'\ :sub:`30[7:0]`
> +      - Y'\ :sub:`31[5:0]`\ Y'\ :sub:`30[9:8]`
> +      - Y'\ :sub:`32[3:0]`\ Y'\ :sub:`31[9:6]`
> +      - Y'\ :sub:`33[1:0]`\ Y'\ :sub:`32[9:4]`
> +      - Y'\ :sub:`33[9:2]`
> +    * - start + 20:
> +      - Cb\ :sub:`00[7:0]`
> +      - Cr\ :sub:`00[5:0]`\ Cb\ :sub:`00[9:8]`
> +      - Cb\ :sub:`01[3:0]`\ Cr\ :sub:`00[9:6]`
> +      - Cr\ :sub:`01[1:0]`\ Cb\ :sub:`01[9:4]`
> +      - Cr\ :sub:`01[9:2]`
> +    * - start + 25:
> +      - Cb\ :sub:`10[7:0]`
> +      - Cr\ :sub:`10[5:0]`\ Cb\ :sub:`10[9:8]`
> +      - Cb\ :sub:`11[3:0]`\ Cr\ :sub:`10[9:6]`
> +      - Cr\ :sub:`11[1:0]`\ Cb\ :sub:`11[9:4]`
> +      - Cr\ :sub:`11[9:2]`
> +    * - start + 30:
> +      - Cb\ :sub:`20[7:0]`
> +      - Cr\ :sub:`20[5:0]`\ Cb\ :sub:`20[9:8]`
> +      - Cb\ :sub:`21[3:0]`\ Cr\ :sub:`20[9:6]`
> +      - Cr\ :sub:`21[1:0]`\ Cb\ :sub:`21[9:4]`
> +      - Cr\ :sub:`21[9:2]`
> +    * - start + 35:
> +      - Cb\ :sub:`30[7:0]`
> +      - Cr\ :sub:`30[5:0]`\ Cb\ :sub:`30[9:8]`
> +      - Cb\ :sub:`31[3:0]`\ Cr\ :sub:`30[9:6]`
> +      - Cr\ :sub:`31[1:0]`\ Cb\ :sub:`31[9:4]`
> +      - Cr\ :sub:`31[9:2]`
> +
> +
>  .. _V4L2-PIX-FMT-NV24:
>  .. _V4L2-PIX-FMT-NV42:
> =20
> diff --git a/drivers/media/v4l2-core/v4l2-common.c b/drivers/media/v4l2-c=
ore/v4l2-common.c
> index 834b426da8b1..c65ffab5800a 100644
> --- a/drivers/media/v4l2-core/v4l2-common.c
> +++ b/drivers/media/v4l2-core/v4l2-common.c
> @@ -270,8 +270,10 @@ const struct v4l2_format_info *v4l2_format_info(u32 =
format)
>  		/* YUV planar formats */
>  		{ .format =3D V4L2_PIX_FMT_NV12,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
>  		{ .format =3D V4L2_PIX_FMT_NV21,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
> +		{ .format =3D V4L2_PIX_FMT_NV15,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .bpp_div =
=3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 2 },
>  		{ .format =3D V4L2_PIX_FMT_NV16,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_NV61,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
> +		{ .format =3D V4L2_PIX_FMT_NV20,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 5, 10, 0, 0 }, .bpp_div =
=3D { 4, 4, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_NV24,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_NV42,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 1, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 1, .vdiv =3D 1 },
>  		{ .format =3D V4L2_PIX_FMT_P010,    .pixel_enc =3D V4L2_PIXEL_ENC_YUV,=
 .mem_planes =3D 1, .comp_planes =3D 2, .bpp =3D { 2, 2, 0, 0 }, .bpp_div =
=3D { 1, 1, 1, 1 }, .hdiv =3D 2, .vdiv =3D 1 },
> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-co=
re/v4l2-ioctl.c
> index 9b1de54ce379..937434e5f2c1 100644
> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> @@ -1347,8 +1347,10 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *=
fmt)
>  	case V4L2_PIX_FMT_YUV48_12:	descr =3D "12-bit YUV 4:4:4 Packed"; break;
>  	case V4L2_PIX_FMT_NV12:		descr =3D "Y/UV 4:2:0"; break;
>  	case V4L2_PIX_FMT_NV21:		descr =3D "Y/VU 4:2:0"; break;
> +	case V4L2_PIX_FMT_NV15:		descr =3D "10-bit Y/UV 4:2:0 (Packed)"; break;
>  	case V4L2_PIX_FMT_NV16:		descr =3D "Y/UV 4:2:2"; break;
>  	case V4L2_PIX_FMT_NV61:		descr =3D "Y/VU 4:2:2"; break;
> +	case V4L2_PIX_FMT_NV20:		descr =3D "10-bit Y/UV 4:2:2 (Packed)"; break;
>  	case V4L2_PIX_FMT_NV24:		descr =3D "Y/UV 4:4:4"; break;
>  	case V4L2_PIX_FMT_NV42:		descr =3D "Y/VU 4:4:4"; break;
>  	case V4L2_PIX_FMT_P010:		descr =3D "10-bit Y/UV 4:2:0"; break;
> diff --git a/include/uapi/linux/videodev2.h b/include/uapi/linux/videodev=
2.h
> index c3d4e490ce7c..617340c43e40 100644
> --- a/include/uapi/linux/videodev2.h
> +++ b/include/uapi/linux/videodev2.h
> @@ -638,8 +638,10 @@ struct v4l2_pix_format {
>  /* two planes -- one Y, one Cr + Cb interleaved  */
>  #define V4L2_PIX_FMT_NV12    v4l2_fourcc('N', 'V', '1', '2') /* 12  Y/Cb=
Cr 4:2:0  */
>  #define V4L2_PIX_FMT_NV21    v4l2_fourcc('N', 'V', '2', '1') /* 12  Y/Cr=
Cb 4:2:0  */
> +#define V4L2_PIX_FMT_NV15    v4l2_fourcc('N', 'V', '1', '5') /* 15  Y/Cb=
Cr 4:2:0 10-bit packed */
>  #define V4L2_PIX_FMT_NV16    v4l2_fourcc('N', 'V', '1', '6') /* 16  Y/Cb=
Cr 4:2:2  */
>  #define V4L2_PIX_FMT_NV61    v4l2_fourcc('N', 'V', '6', '1') /* 16  Y/Cr=
Cb 4:2:2  */
> +#define V4L2_PIX_FMT_NV20    v4l2_fourcc('N', 'V', '2', '0') /* 20  Y/Cb=
Cr 4:2:2 10-bit packed */

Would make sense to group all semi planar 10bit together.

>  #define V4L2_PIX_FMT_NV24    v4l2_fourcc('N', 'V', '2', '4') /* 24  Y/Cb=
Cr 4:4:4  */
>  #define V4L2_PIX_FMT_NV42    v4l2_fourcc('N', 'V', '4', '2') /* 24  Y/Cr=
Cb 4:4:4  */
>  #define V4L2_PIX_FMT_P010    v4l2_fourcc('P', '0', '1', '0') /* 24  Y/Cb=
Cr 4:2:0 10-bit per component */

regards,
Nicolas
