Return-Path: <linux-kernel+bounces-117304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA69B88A9D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:44:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEAE91C21B57
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 16:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D37E1703B7;
	Mon, 25 Mar 2024 14:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YiAxN5CO"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6ABA1703AB
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 14:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711378605; cv=none; b=h5N+K6uYAjYFFpSesn38lbMeLnbCrPW+aDiA4HZO9v4EiNg1bvnz6vhSZ6PVGW+l1L+xnXuvf4w31lvcYrmXTZQw3Yi3eYSSV8BV9Q0WUCRb9LXnPXU1mnfzfcY6Z9ci//9nGbeDL/boBxBirOVKL57JphaskeDai8ZDVePbFqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711378605; c=relaxed/simple;
	bh=W001AFt7sODG/Tc/2JlSqu3+m3IKpZoo2XTEUmOez6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P28NyoRa6DiXUmYbMEbpQUDv2wabVpDygsOSYH2NNW1zADCXiMUr3EO2MlUomDkTU4aEUiD9nJnb5E4tJh0xIfc+YlcsBiZl0lFt3GdM0szXjOsQl5XPh0SxwB4YkjxSpzd2eba3YlOyIehyZSdoPil34pc2jKcKmG0ZezCLvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=YiAxN5CO; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711378601;
	bh=W001AFt7sODG/Tc/2JlSqu3+m3IKpZoo2XTEUmOez6Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YiAxN5CO+jBpgG0mzyzVLDqRS+zBh/gWuaWUAdi+VKpgw+6YyH2fvVD0L6subOWwF
	 4G457LTWuQK+TbeATvF+b0necHh/ve3PDjLZxuw4LOEKo6pbuJnvCH+YR/PWKJ0YWU
	 H/oN7aM3AM+hQWpr6IamA1HGRn6KaF/nxLv879TNlVuGMDqsJXkK4a60QtenPHGy+A
	 UU24POcEHE4L6uNAH7+6LDM6fGjSGpG1suvFy6qXJyrelOT+c84mW1k2hcX8MwOsjA
	 hpSSIjkBqKtysl+rEhWbV2K84FHN66h9P9hIz89bwuWCyIp7BgvvBmhJxbdtHWWqUL
	 JnZ6e0S2+uLgQ==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id A36F03780EC6;
	Mon, 25 Mar 2024 14:56:40 +0000 (UTC)
Date: Mon, 25 Mar 2024 16:56:31 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: =?UTF-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, Rodrigo Siqueira
 <rodrigosiqueiramelo@gmail.com>, Melissa Wen <melissa.srw@gmail.com>,
 Haneen Mohammed <hamohammed.sa@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, arthurgrillo@riseup.net, Jonathan Corbet
 <corbet@lwn.net>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, jeremie.dautheribes@bootlin.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com
Subject: Re: [PATCH v5 10/16] drm/vkms: Re-introduce line-per-line
 composition algorithm
Message-ID: <20240325165631.6953ad01.pekka.paalanen@collabora.com>
In-Reply-To: <b661b8c2-552c-4256-ad0b-b8a7b9bbed34@igalia.com>
References: <20240313-yuv-v5-0-e610cbd03f52@bootlin.com>
	<20240313-yuv-v5-10-e610cbd03f52@bootlin.com>
	<b661b8c2-552c-4256-ad0b-b8a7b9bbed34@igalia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GfCtEZXpb23dLFOhosWDRQd";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/GfCtEZXpb23dLFOhosWDRQd
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 Mar 2024 11:15:13 -0300
Ma=C3=ADra Canal <mcanal@igalia.com> wrote:

> On 3/13/24 14:45, Louis Chauvet wrote:
> > Re-introduce a line-by-line composition algorithm for each pixel format.
> > This allows more performance by not requiring an indirection per pixel
> > read. This patch is focused on readability of the code.
> >=20
> > Line-by-line composition was introduced by [1] but rewritten back to
> > pixel-by-pixel algorithm in [2]. At this time, nobody noticed the impact
> > on performance, and it was merged.
> >=20
> > This patch is almost a revert of [2], but in addition efforts have been
> > made to increase readability and maintainability of the rotation handli=
ng.
> > The blend function is now divided in two parts:
> > - Transformation of coordinates from the output referential to the sour=
ce
> > referential
> > - Line conversion and blending
> >=20
> > Most of the complexity of the rotation management is avoided by using
> > drm_rect_* helpers. The remaining complexity is around the clipping, to
> > avoid reading/writing outside source/destination buffers.
> >=20
> > The pixel conversion is now done line-by-line, so the read_pixel_t was
> > replaced with read_pixel_line_t callback. This way the indirection is o=
nly
> > required once per line and per plane, instead of once per pixel and per
> > plane.
> >=20
> > The read_line_t callbacks are very similar for most pixel format, but it
> > is required to avoid performance impact. Some helpers for color
> > conversion were introduced to avoid code repetition:
> > - *_to_argb_u16: perform colors conversion. They should be inlined by t=
he
> >    compiler, and they are used to avoid repetition between multiple var=
iants
> >    of the same format (argb/xrgb and maybe in the future for formats li=
ke
> >    bgr formats).
> >=20
> > This new algorithm was tested with:
> > - kms_plane (for color conversions)
> > - kms_rotation_crc (for rotations of planes)
> > - kms_cursor_crc (for translations of planes)
> > - kms_rotation (for all rotations and formats combinations) [3]
> > The performance gain was mesured with:
> > - kms_fb_stress =20
>=20
> Could you tell us what was the performance gain?
>=20
> >=20
> > [1]: commit 8ba1648567e2 ("drm: vkms: Refactor the plane composer to ac=
cept
> >       new formats")
> >       https://lore.kernel.org/all/20220905190811.25024-7-igormtorrente@=
gmail.com/
> > [2]: commit 322d716a3e8a ("drm/vkms: isolate pixel conversion
> >       functionality")
> >       https://lore.kernel.org/all/20230418130525.128733-2-mcanal@igalia=
com/
> > [3]:
> >=20
> > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > ---
> >   drivers/gpu/drm/vkms/vkms_composer.c | 167 +++++++++++++++++++------
> >   drivers/gpu/drm/vkms/vkms_drv.h      |  27 ++--
> >   drivers/gpu/drm/vkms/vkms_formats.c  | 236 ++++++++++++++++++++++----=
---------
> >   drivers/gpu/drm/vkms/vkms_formats.h  |   2 +-
> >   drivers/gpu/drm/vkms/vkms_plane.c    |   5 +-
> >   5 files changed, 292 insertions(+), 145 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkm=
s/vkms_composer.c
> > index 989bcf59f375..5d78c33dbf41 100644
> > --- a/drivers/gpu/drm/vkms/vkms_composer.c
> > +++ b/drivers/gpu/drm/vkms/vkms_composer.c

..

> > @@ -215,34 +188,146 @@ static void blend(struct vkms_writeback_job *wb,
> >   {
> >   	struct vkms_plane_state **plane =3D crtc_state->active_planes;
> >   	u32 n_active_planes =3D crtc_state->num_active_planes;
> > -	int y_pos, x_dst, x_limit;
> >  =20
> >   	const struct pixel_argb_u16 background_color =3D { .a =3D 0xffff };
> >  =20
> > -	size_t crtc_y_limit =3D crtc_state->base.crtc->mode.vdisplay;
> > +	int crtc_y_limit =3D crtc_state->base.crtc->mode.vdisplay;
> > +	int crtc_x_limit =3D crtc_state->base.crtc->mode.hdisplay; =20
>=20
> Shouldn't it be `unsigned int`?

No. It's not good to mix signed and unsigned variables in computations.
I for sure would not remember all the implicit promotion rules that
apply, and you'd probably be forced to add explicit signedness casts to
get the correct behaviour. It causes much less surprises to "normalize"
all variables to the same signedness before computing with them. Some
values in this function can be negative.


Thanks,
pq

--Sig_/GfCtEZXpb23dLFOhosWDRQd
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYBkJ8ACgkQI1/ltBGq
qqfVyA//S0bMVVU0lfdlKghSq2BiGWy5B4acbSUlKhLXvQZnEtF60Y0XBvF8H9Z4
3+Kf/6fdE1NvGncaBTKHnfZ0OCgXoa07JhIIRLv4PcaDMtCTikFX/AX1e9IozB9/
ObWvtiXBMt2k4Q6DTz7bSG8Z9HjU8cBpqV9N1tKMXhIv8RTyMOKTRk8Duya99isU
PeIKbyvVYKvrfGu2Y7EWv8oljLsHTrOvvIRWzHTssO57EwxPjRTwkMn/JuB+QLTA
QBNeXoiztQmDiuTnrs5UyByncSICtORx1FLM6JAHSGwe9eecnixXW5orrWXtw2PD
fb7SfHkXQNYGUoDikdIaDeTqXZQuhsAUwcwaRuHJ1goiAENNjrnhWd8fUDpc2oNL
VJuYZmMlzSPFz3rbCIGXUlGYpl9BdP8SxGHUddVI/LvxeL/MQ8v5KaB0PZgcboMx
jcl6RmJLAco+1vWOBrjR0tTBxbLWBOa9gX4ncNvrC/saltohZ/FrMi1oQm9gVdeU
m3547QUfd8hvlhmAKy32tE9zizfs8dunLbQyWxGT6gqBW6O8dr5CD5MJ/k5CMdhj
U3G4BQ7kgN5Afc73JPHiJrGDrWCDQPiyeTMFpLPA3b4hBiRLs1RxheC37OyHdI0v
3cxf5ja6rFNLlGI4klBMr5R92gaes2wQkyUxk3v8IGxMaFefF9s=
=ep0Y
-----END PGP SIGNATURE-----

--Sig_/GfCtEZXpb23dLFOhosWDRQd--

