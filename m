Return-Path: <linux-kernel+bounces-9773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 143CF81CB32
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 15:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FBF51F268F3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 14:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273101CF98;
	Fri, 22 Dec 2023 14:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hmEV0ezI"
X-Original-To: linux-kernel@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC11C6B6;
	Fri, 22 Dec 2023 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1703254545;
	bh=FrU3ISAPB5G4x/zyDmO5HSQ9A88VViR/RKJd01B4NXY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=hmEV0ezIb+aJsCxvAEH1O7CkypH3NzUHt/w8AMsQlBS/qfRa1GGYvqzX8we4Jw4/a
	 ES7lmj1W6I62olCklvZ+2YNCBkElyAnmWPwtyIL0rSATV5vriV09kJlM0UDcwAz7FF
	 HTRg2J4H3At2mTEIMF1UUMkOZSumsol85X99wJav6WhhMSpqnsLPQGIybMgnBck2PG
	 J0fkLzXdPOWWr3bfq/zmIKGkIolwmjLnjJ+QFaC0x0arl2jgBmnTifsGR+s0Gu+HuW
	 Vvh/784GDJYF3P9AzUBlYEC6tvssfZb8dBY92p8rTBNxJtKnS/MNxCQckA0zRUWuUp
	 Qso3o+x/QHckQ==
Received: from [100.77.12.232] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: obbardc)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 848BE37804B2;
	Fri, 22 Dec 2023 14:15:44 +0000 (UTC)
Message-ID: <b33811925a6e3ff116fe2c019bc6b6066cf5bf7a.camel@collabora.com>
Subject: Re: [PATCH v3 00/10] media: rkvdec: Add H.264 High 10 and 4:2:2
 profile support
From: Christopher Obbard <chris.obbard@collabora.com>
To: Jonas Karlman <jonas@kwiboo.se>, Ezequiel Garcia
 <ezequiel@vanguardiasur.com.ar>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Alex Bee <knaerzche@gmail.com>, Nicolas Dufresne
	 <nicolas.dufresne@collabora.com>, Benjamin Gaignard
	 <benjamin.gaignard@collabora.com>, Sebastian Fricke
	 <sebastian.fricke@collabora.com>, linux-media@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Date: Fri, 22 Dec 2023 14:15:28 +0000
In-Reply-To: <20231029183427.1781554-1-jonas@kwiboo.se>
References: <20231029183427.1781554-1-jonas@kwiboo.se>
Autocrypt: addr=chris.obbard@collabora.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Jonas,

On Sun, 2023-10-29 at 18:34 +0000, Jonas Karlman wrote:
> This is a revival of a 3 year old series [1] now that NV15/NV20/NV30 supp=
ort
> for display driver have landed in drm-misc tree.
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
> Patch 6-9 refactor code to support validation and filtering of CAPUTRE
> formats based on codec ops.
>=20
> Patch 10 adds final bits to support H.264 High 10 and 4:2:2 profiles.
>=20
> Changes in v3:
> - Drop merged patches
> - Use bpp and bpp_div instead of prior misuse of block_w/block_h
> - New patch to use values from SPS/PPS control to configure the HW
> - New patch to remove an unnecessary call to validate sps at streaming st=
art
> - Reworked pixel format validation
>=20
> Changes in v2:
> - Collect r-b tags
> - SPS pic width and height in mbs validation moved to rkvdec_try_ctrl
> - New patch to not override output buffer sizeimage
> - Reworked pixel format validation
> - Only align decoded buffer instead of changing frmsize step_width
>=20
> Following drm-misc commits adds support for NV15/NV20/NV30 to VOP driver:
> 728c15b4b5f3 ("drm/fourcc: Add NV20 and NV30 YUV formats")
> d4b384228562 ("drm/rockchip: vop: Add NV15, NV20 and NV30 support")
>=20
> To fully runtime test this series you may need above drm commits and ffmp=
eg
> patches from [2], this series and drm patches is also available at [3].
>=20
> [1]
> https://lore.kernel.org/linux-media/20200706215430.22859-1-jonas@kwiboo.s=
e/
> [2] https://github.com/jernejsk/FFmpeg/commits/v4l2-request-n6.0/
> [3]
> https://github.com/Kwiboo/linux-rockchip/commits/linuxtv-rkvdec-high-10-v=
3/


For this whole series:

Tested-by: Christopher Obbard <chris.obbard@collabora.com>

>=20
> Regards,
> Jonas
>=20
> Alex Bee (1):
> =C2=A0 media: rkvdec: h264: Don't hardcode SPS/PPS parameters
>=20
> Jonas Karlman (9):
> =C2=A0 media: v4l2-common: Add helpers to calculate bytesperline and
> =C2=A0=C2=A0=C2=A0 sizeimage
> =C2=A0 media: v4l2: Add NV15 and NV20 pixel formats
> =C2=A0 media: rkvdec: h264: Use bytesperline and buffer height as virstri=
de
> =C2=A0 media: rkvdec: h264: Remove SPS validation at streaming start
> =C2=A0 media: rkvdec: Extract rkvdec_fill_decoded_pixfmt helper method
> =C2=A0 media: rkvdec: Move rkvdec_reset_decoded_fmt() function
> =C2=A0 media: rkvdec: Prepare for adding format validation ops
> =C2=A0 media: rkvdec: Add get_fmt_opaque and valid_fmt ops
> =C2=A0 media: rkvdec: h264: Support High 10 and 4:2:2 profiles
>=20
> =C2=A0.../media/v4l/pixfmt-yuv-planar.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 128 ++++++++++++
> =C2=A0drivers/media/v4l2-core/v4l2-common.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 80 ++++----
> =C2=A0drivers/media/v4l2-core/v4l2-ioctl.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0drivers/staging/media/rkvdec/rkvdec-h264.c=C2=A0=C2=A0=C2=A0 |=C2=
=A0 91 ++++----
> =C2=A0drivers/staging/media/rkvdec/rkvdec.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 | 194 +++++++++++++-----
> =C2=A0drivers/staging/media/rkvdec/rkvdec.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 +
> =C2=A0include/uapi/linux/videodev2.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A07 files changed, 367 insertions(+), 133 deletions(-)
>=20
> --
> 2.42.0
>=20

