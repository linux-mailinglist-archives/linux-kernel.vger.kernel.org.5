Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C88879F0EB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 20:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbjIMSLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 14:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjIMSLq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 14:11:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE919B6;
        Wed, 13 Sep 2023 11:11:42 -0700 (PDT)
Received: from nicolas-tpx395.localdomain (unknown [IPv6:2606:6d00:15:bae9::7a9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nicolas)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B64436607326;
        Wed, 13 Sep 2023 19:11:40 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1694628701;
        bh=Q/2ZVzOmXtoAMeegoI61slO6Pby1hty1OaYRm6U4jXM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Er+xidLBZUBl72WOavOGxCKhHkb/opmoEzMz17i1GTrySEswEijS3/uZ2cZT6h3Im
         ucMoUlhMU4XbbhXdv9GwKjlt6nDMCXMyKbdFXnuaqgyb671At+2sDXiM7w6OB+LLy+
         SQAuwiAqONuMPm2081DPlne0r3fhXE1zLacOBB3y/y0djPy5APoRQvwKS8D3n0GqQw
         cF1crmk2DyGFVPi44gGAXnUSjCkvMs+LnVv7YAtqOOqixOBWDNeahb8oE2HFFKUR/L
         jaZbxe+XxKdNWActhudY0Q4PDxdfPou5z05aygqA1us7f2/aEZIWcqcPa1soO7FXnB
         1L3/wLnkIJ3sg==
Message-ID: <847cf170d56d5590a7aa46b80f63de6ee27690ec.camel@collabora.com>
Subject: Re: [PATCH 3/5] docs: uapi: media: Add common documentation of
 tiled NV15
From:   Nicolas Dufresne <nicolas.dufresne@collabora.com>
To:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     kernel@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 13 Sep 2023 14:11:32 -0400
In-Reply-To: <f5ede7a6-66ee-cf69-e1c9-2d75d8f37a02@collabora.com>
References: <20230804192737.19016-1-nicolas.dufresne@collabora.com>
         <20230804192737.19016-4-nicolas.dufresne@collabora.com>
         <f5ede7a6-66ee-cf69-e1c9-2d75d8f37a02@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 07 ao=C3=BBt 2023 =C3=A0 13:37 +0200, Andrzej Pietrasiewicz a =C3=
=A9crit=C2=A0:
> Hi Nicolas,
>=20
> W dniu 4.08.2023 o=C2=A021:27, Nicolas Dufresne pisze:
> > This way we don't have to repeat over and over how the pixels are
> > packed in NV15.
> >=20
> > Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> > ---
> >   .../media/v4l/pixfmt-yuv-planar.rst           | 79 ++++++++++++++++--=
-
> >   1 file changed, 68 insertions(+), 11 deletions(-)
> >=20
> > diff --git a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rs=
t b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > index 1d43532095c0..052927bd9396 100644
> > --- a/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > +++ b/Documentation/userspace-api/media/v4l/pixfmt-yuv-planar.rst
> > @@ -373,10 +373,74 @@ two non-contiguous planes.
> >   Tiled NV15
> >   ----------
> >  =20
> > -``V4L2_PIX_FMT_NV15_4L4`` Semi-planar 10-bit YUV 4:2:0 formats, using =
4x4 tiling.
> > -All components are packed without any padding between each other.
> > -As a side-effect, each group of 4 components are stored over 5 bytes
> > -(YYYY or UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes).
> > +Semi-planar 10-bit YUV 4:2:0 formats. All components are packed
> > +without any padding between each other. Each pixels occupy 15 bits
>=20
> Maybe "Each pixel group"?

ack.

>=20
>=20
>=20
> > +and are usually stored in group of 4 components stored over 5 bytes
> > +(YYYY or UVUV =3D 4 * 10 bits =3D 40 bits =3D 5 bytes) or partitioned =
into
> > +upper 8 bit and lower 2 bits.
> > +
> > +.. flat-table:: Sample of 4 NV15 luma pixels
> > +    :header-rows:  2
> > +    :stub-columns: 0
> > +
> > +    * -
> > +      - 8
> > +      - 7
> > +      - 6
> > +      - 5
> > +      - 4
> > +      - 3
> > +      - 2
> > +      - 1
> > +      - 0
> > +    * - byte 0
> > +      - Y'\ :sub:`0:0`
> > +      - Y'\ :sub:`0:1`
> > +      - Y'\ :sub:`0:2`
> > +      - Y'\ :sub:`0:3`
> > +      - Y'\ :sub:`0:4`
> > +      - Y'\ :sub:`0:5`
> > +      - Y'\ :sub:`0:6`
> > +      - Y'\ :sub:`0:7`
>=20
> So byte 0 contains Y0, bits 0..7 but then...
>=20
> > +    * - byte 1
> > +      - Y'\ :sub:`0:8`
> > +      - Y'\ :sub:`0:9`
> > +      - Y'\ :sub:`1:0`
> > +      - Y'\ :sub:`1:1`
> > +      - Y'\ :sub:`1:2`
> > +      - Y'\ :sub:`1:3`
> > +      - Y'\ :sub:`1:4`
> > +      - Y'\ :sub:`1:5`
> > +    * - byte 2
> > +      - Y'\ :sub:`1:6`
> > +      - Y'\ :sub:`1:7`
> > +      - Y'\ :sub:`1:8`
> > +      - Y'\ :sub:`1:9`
> > +      - Y'\ :sub:`2:0`
> > +      - Y'\ :sub:`2:1`
> > +      - Y'\ :sub:`2:2`
> > +      - Y'\ :sub:`2:3`
> > +    * - byte 3
> > +      - Y'\ :sub:`2:4`
> > +      - Y'\ :sub:`2:5`
> > +      - Y'\ :sub:`2:6`
> > +      - Y'\ :sub:`2:7`
> > +      - Y'\ :sub:`2:8`
> > +      - Y'\ :sub:`2:9`
> > +      - Y'\ :sub:`3:0`
> > +      - Y'\ :sub:`3:1`
> > +    * - byte 4
> > +      - Y'\ :sub:`3:2`
> > +      - Y'\ :sub:`3:3`
> > +      - Y'\ :sub:`3:4`
> > +      - Y'\ :sub:`3:5`
> > +      - Y'\ :sub:`3:6`
> > +      - Y'\ :sub:`3:7`
> > +      - Y'\ :sub:`3:8`
> > +      - Y'\ :sub:`3:9`
> > +
> > +``V4L2_PIX_FMT_NV15_4L4`` stores pixels in 4x4 tiles, and stores tiles=
 linearly
> > +in memory.
> >  =20
> >   ``V4L2_PIX_FMT_NV12M_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M`=
` but stores
> >   10 bits pixels in 2D 8x128 tiles, and stores tiles linearly in memory=
.
> > @@ -385,13 +449,6 @@ The image height must be aligned to a multiple of =
128.
> >   The layouts of the luma and chroma planes are identical.
> >   Note the tile size is 8bytes multiplied by 128 bytes,
> >   it means that the low bits and high bits of one pixel may be in diffe=
rent tiles.
> > -The 10 bit pixels are packed, so 5 bytes contain 4 10-bit pixels layou=
t like
> > -this (for luma):
> > -byte 0: Y0(bits 9-2)
>=20
> ...here it says byts 9-2? Is it a mistake or are you cleaning up the doc
> and the table above is the correct version?

Thanks a lot for spotting. I did miss the endianess aspect and just assumed=
 all
NV15 implementation was the same. So digging further, Hantro/RK version of =
NV15
is  using a little endian representation form. So you have in memory:

Byte 0: Y0 bits 7-0
Byte 1: Y1 bits 5-0 in MSB | Y0 bits 9-8 in LSB
Byte 3: Y2 bits 3-0 in MSB | Y1 bits 9-6 in LSB
Byte 4: Y3 bits 1-0 in MSB | Y2 bits 9-4 in LSB
Byte 5: Y3 bits 9-2

If we represent the reads in 16bits words (as an illustration), you'd read =
Y0
with:

Y0: 0x[Byte 1][Byte 0] & 0x3ff
Y1: 0x[Byte 2][Byte 1] >> 2 & 0x3ff
Y2: 0x[Byte 3][Byte 2] >> 4 & 0x3ff
Y3: 0x[Byte 4][Byte 3] >> 6

Which makes the 10 bits of data always adjacent (of course not that practic=
al
for a CPU since its unaligned, but let's not bother ;-P).=20

I can see now that Amphion is big endian, as the bytes get pushed into the =
MSB.
So with the originally documented bit placement we'd have:

Y0: 0x[Byte 0][Byte 1] >> 6
Y1: 0x[Byte 1][Byte 2] >> 4 & 0x3ff
Y2: 0x[Byte 2][Byte 3] >> 2 & 0x3ff
Y3: 0x[Byte 3][Byte 4] & 0x3ff
=20
I'll drop the generalization here, and only introduce NV15 family as fully
packed 10 bit semi-planar formats, which often stores 4 pixel per 5 bytes, =
but
may partition lower bits (aka MT2110).

>=20
> Regards,
>=20
> Andrzej
>=20
> > -byte 1: Y0(bits 1-0) Y1(bits 9-4)
> > -byte 2: Y1(bits 3-0) Y2(bits 9-6)
> > -byte 3: Y2(bits 5-0) Y3(bits 9-8)
> > -byte 4: Y3(bits 7-0)
> >  =20
> >   ``V4L2_PIX_FMT_NV12_10BE_8L128`` is similar to ``V4L2_PIX_FMT_NV12M_1=
0BE_8L128`` but stores
> >   two planes in one memory.
>=20

