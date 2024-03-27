Return-Path: <linux-kernel+bounces-120906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB9188E05F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 13:34:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 345D31C29333
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 12:34:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD3E31482E6;
	Wed, 27 Mar 2024 12:12:30 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1114147C8B
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711541550; cv=none; b=fhz50NPQkLHGzJje9RA6ovp7jUQkf6YaSDKx0FJHw0W2iXnOCvxsFAYT7fJWuGmvrqtqvnwHJgrJj7NFzqEplQGaNcPgAF0C8f3AA6tiSBI7hFqZL+YMUGkmBkH/NTxrXxSU4/OURP5y4Ij47abqMI4wtyf+wsJYXoZBjdfjGr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711541550; c=relaxed/simple;
	bh=DiOWFNV13xwUAoCXem0V1LNeUxUEOlVmeRbu6TsGaME=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GWzXhcZMCyTdFNdcLcYD+h4UI0743xySlunjNMGjsl2IK6RbIzNbKLo/eoTyReeWDEoqyYMrvjqe3vso5qx2Kuv3xuGnQ92phWPo2InU9h6Y3JPIH+wQ9x5Xk8XgVujaNjTKy8tYit9xbYTFN/kCQCWDnyZcgQ7WRHYds+bMbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rpS8K-0004ds-Ci; Wed, 27 Mar 2024 13:11:56 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rpS8I-008nwn-4g; Wed, 27 Mar 2024 13:11:54 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rpS8I-0007xg-0D;
	Wed, 27 Mar 2024 13:11:54 +0100
Message-ID: <5f6ab3804baa87f6e2299f668d2ab41be3a13f13.camel@pengutronix.de>
Subject: Re: [PATCH v5 11/16] drm/vkms: Add YUV support
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Louis Chauvet <louis.chauvet@bootlin.com>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>, 
 =?ISO-8859-1?Q?Ma=EDra?= Canal <mairacanal@riseup.net>, Haneen Mohammed
 <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, arthurgrillo@riseup.net, Jonathan Corbet
 <corbet@lwn.net>,  pekka.paalanen@haloniitty.fi
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	jeremie.dautheribes@bootlin.com, miquel.raynal@bootlin.com, 
	thomas.petazzoni@bootlin.com, seanpaul@google.com, marcheu@google.com, 
	nicolejadeyee@google.com
Date: Wed, 27 Mar 2024 13:11:53 +0100
In-Reply-To: <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
	 <20240313-yuv-v5-11-e610cbd03f52@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

Hi Louis,

On Mi, 2024-03-13 at 18:45 +0100, Louis Chauvet wrote:
> From: Arthur Grillo <arthurgrillo@riseup.net>
>=20
> Add support to the YUV formats bellow:
>=20
> - NV12/NV16/NV24
> - NV21/NV61/NV42
> - YUV420/YUV422/YUV444
> - YVU420/YVU422/YVU444
>=20
> The conversion from yuv to rgb is done with fixed-point arithmetic, using
> 32.32 floats and the drm_fixed helpers.

s/floats/fixed-point numbers/

Nothing floating here, the point is fixed.

[...]
> diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_=
drv.h
> index 23e1d247468d..f3116084de5a 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.h
> +++ b/drivers/gpu/drm/vkms/vkms_drv.h
> @@ -99,6 +99,27 @@ typedef void (*pixel_read_line_t)(const struct vkms_pl=
ane_state *plane, int x_st
>  				  int y_start, enum pixel_read_direction direction, int count,
>  				  struct pixel_argb_u16 out_pixel[]);
> =20
> +/**
> + * CONVERSION_MATRIX_FLOAT_DEPTH - Number of digits after the point for =
conversion matrix values

s/CONVERSION_MATRIX_FLOAT_DEPTH/CONVERSION_MATRIX_FRACTIONAL_BITS/

Just a suggestion, maybe there are better terms, but using "FLOAT" here
is confusing.

> + */
> +#define CONVERSION_MATRIX_FLOAT_DEPTH 32
> +
> +/**
> + * struct conversion_matrix - Matrix to use for a specific encoding and =
range
> + *
> + * @matrix: Conversion matrix from yuv to rgb. The matrix is stored in a=
 row-major manner and is
> + * used to compute rgb values from yuv values:
> + *     [[r],[g],[b]] =3D @matrix * [[y],[u],[v]]
> + *   OR for yvu formats:
> + *     [[r],[g],[b]] =3D @matrix * [[y],[v],[u]]
> + *  The values of the matrix are fixed floats, 32.CONVERSION_MATRIX_FLOA=
T_DEPTH

s/fixed floats/fixed-point numbers/

regards
Philipp

