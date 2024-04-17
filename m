Return-Path: <linux-kernel+bounces-148420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EE88A824B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3E601C21B33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784A13CAB7;
	Wed, 17 Apr 2024 11:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="v+zY0X//"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8E813CF85
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 11:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354252; cv=none; b=pzXldoFstBimk1oBxIcxN0fN1+cXjeK6bWRH/TG172hA7hNaE7eOf8P1MsrHw1LIDx//YlaW2Uew0oHs01u2yQ3+shX4rfy8URv8s2e5q/G0sJ2/n3h8DdM8IuYmeLO8uYYkqE9/28bd9jlaXRWF7OrmUrGWwAOyJO7ahxWqnXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354252; c=relaxed/simple;
	bh=bRyQj2GJcNbcJkYLFZw5uapb+DmVEQYziMDpedn3jFI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sPHt3NZb88Zel6VRIyHRNyN3HhnUTdIeq9R87x8djIXNg5t6NbVrfhucpQXEX70tEtmcoGuRXm+3RDtPhUts1uc9nbBZFUEaV7xW/d022NTZJUyqL9Pa9EOKYVepMjTRs+HyahpV6x/JjjJgJxlbO/ZGNKZRVQkKt5QrHLKr1/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=v+zY0X//; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713354249;
	bh=bRyQj2GJcNbcJkYLFZw5uapb+DmVEQYziMDpedn3jFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v+zY0X//NAcGnmJP1n9ADE5RxDR3RQIbhJUamc5bAFnXZtGt4PS2ztoMRGRQWFNgO
	 Ln1MD+UKjZTs6HZvwNyJugzCi/HeeG9spIqgZVz2xCaMo0CDCWkJC4r7hIyG7/1Y1U
	 rPwlmwYXxRXItMuwSi5p5ML/XgnnxPp/r2M6nonY+nOaUAFVUVTd2JKbFuEBOVn71W
	 5ZePO7J2GFatG1JiUE6T3ZKnE9YAkt97bJW+FjE8aWLlOBXh0GHFlljpfUPFRg/INZ
	 9XDFIG+tNT6TjYA+xgSjRhIrtJMjCzpPs08UJoWkS0SA3zdOWdXVe1v9rr5D5WrEEf
	 T6MyDGgN/cq0Q==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id AA47A378208C;
	Wed, 17 Apr 2024 11:44:08 +0000 (UTC)
Date: Wed, 17 Apr 2024 14:44:07 +0300
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 seanpaul@google.com, marcheu@google.com, nicolejadeyee@google.com,
 thomas.petazzoni@bootlin.com
Subject: Re: [PATCH 3/3] drm/fourcc: Add documentation around
 drm_format_info
Message-ID: <20240417144407.4d7d3eb8.pekka.paalanen@collabora.com>
In-Reply-To: <Zh78It5SLbSVZAd8@localhost.localdomain>
References: <20240409-google-drm-doc-v1-0-033d55cc8250@bootlin.com>
	<20240409-google-drm-doc-v1-3-033d55cc8250@bootlin.com>
	<20240415150021.13d9b637.pekka.paalanen@collabora.com>
	<Zh78It5SLbSVZAd8@localhost.localdomain>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rR9Kf+9TSUkAda/q4ChRKXC";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/rR9Kf+9TSUkAda/q4ChRKXC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Apr 2024 00:30:58 +0200
Louis Chauvet <louis.chauvet@bootlin.com> wrote:

> Le 15/04/24 - 15:00, Pekka Paalanen a =C3=A9crit :
> > On Tue, 09 Apr 2024 12:04:07 +0200
> > Louis Chauvet <louis.chauvet@bootlin.com> wrote:
> >  =20
> > > Let's provide more details about the drm_format_info structure because
> > > its content may not be straightforward for someone not used to video
> > > formats and drm internals.
> > >=20
> > > Signed-off-by: Louis Chauvet <louis.chauvet@bootlin.com>
> > > ---
> > >  include/drm/drm_fourcc.h | 45 ++++++++++++++++++++++++++++++++++++++=
-------
> > >  1 file changed, 38 insertions(+), 7 deletions(-)
> > >=20
> > > diff --git a/include/drm/drm_fourcc.h b/include/drm/drm_fourcc.h
> > > index ccf91daa4307..66cc30e28f79 100644
> > > --- a/include/drm/drm_fourcc.h
> > > +++ b/include/drm/drm_fourcc.h
> > > @@ -58,6 +58,44 @@ struct drm_mode_fb_cmd2;
> > > =20
> > >  /**
> > >   * struct drm_format_info - information about a DRM format
> > > + *
> > > + * A drm_format_info describes how planes and pixels are stored in m=
emory.
> > > + *
> > > + * Some format like YUV can have multiple planes, counted in @num_pl=
anes. It
> > > + * means that a full pixel can be stored in multiple non-continuous =
buffers.
> > > + * For example, NV12 is a YUV format using two planes: one for the Y=
 values and
> > > + * one for the UV values.
> > > + *
> > > + * On each plane, the "pixel" unit can be different in case of subsa=
mpling. For
> > > + * example with the NV12 format, a pixel in the UV plane is used for=
 four pixels
> > > + * in the Y plane.
> > > + * The fields @hsub and @vsub are the relation between the size of t=
he main
> > > + * plane and the size of the subsampled planes in pixels:
> > > + *	plane[0] width =3D hsub * plane[1] width
> > > + *	plane[0] height =3D vsub * plane[1] height =20
> >=20
> > This makes it sound like plane[1] would be the one determining the
> > image size. It is plane[0] that determines the image size (I don't know
> > of a format that would have it otherwise), and vsub and hsub are used
> > as divisors. It's in their name, too: horizontal/vertical sub-sampling.
> >=20
> > This is important for images with odd dimensions. If plane[1]
> > determined the image size, it would be impossible to have odd sized
> > NV12 images, for instance.
> >=20
> > Odd dimensions also imply something about rounding the size of the
> > sub-sampled planes. I guess the rounding is up, not down? =20
>=20
> I will change the equation to:
>=20
> plane[1] =3D plane[0] / hsub (round up)
>=20
> Can a DRM maintainer confirm the rounding up?
> =20
> > > + *
> > > + * In some formats, pixels are not independent in memory. It can be =
a packed =20
> >=20
> > "Independent in memory" sounds to me like it describes sub-sampling:
> > some pixel components are shared between multiple pixels. Here you seem
> > to refer to just packing: one pixel's data may take a fractional number
> > of bytes. =20
>=20
>  * In some formats, pixels are not individually addressable. It ...
>=20
> > > + * representation to store more pixels per byte (for example P030 us=
es 4 bytes
> > > + * for three 10 bit pixels). It can also be used to represent tiled =
formats, =20
> >=20
> > s/tiled/block/
> >=20
> > Tiling is given by format modifiers rather than formats. =20
>=20
> Fixed in the v2.
>=20
> > > + * where a continuous buffer in memory can represent a rectangle of =
pixels (for
> > > + * example, in DRM_FORMAT_Y0L0, a buffer of 8 bytes represents a 2x2=
 pixel
> > > + * region of the picture).
> > > + *	The field @char_per_block is the size of a block on a specific pl=
ane, in
> > > + *	bytes.
> > > + *	The fields @block_w and @block_h are the size of a block in pixel=
s.
> > > + *
> > > + * The older format representation (which only uses @cpp, kept for h=
istorical =20
> >=20
> > Move the paren to: representation which only uses @cpp (kept
> >=20
> > so that the sentence is still understandable if one skips the
> > parenthesised part. =20
>=20
> Fixed in v2.
>=20
> > > + * reasons because there are a lot of places in drivers where it's u=
sed) is
> > > + * assuming that a block is always 1x1 pixel.
> > > + *
> > > + * To keep the compatibility with older format representations and t=
reat block
> > > + * and non-block formats in the same way one should use:
> > > + *	- @char_per_block to access the size of a block on a specific pla=
ne, in
> > > + *	bytes.
> > > + *	- drm_format_info_block_width() to access the width of a block of=
 a
> > > + *	specific plane, in pixels.
> > > + *	- drm_format_info_block_height() to access the height of a block =
of a
> > > + *	specific plane, in pixels.
> > >   */
> > >  struct drm_format_info {
> > >  	/** @format: 4CC format identifier (DRM_FORMAT_*) */
> > > @@ -97,13 +135,6 @@ struct drm_format_info {
> > >  		 * formats for which the memory needed for a single pixel is not
> > >  		 * byte aligned.
> > >  		 *
> > > -		 * @cpp has been kept for historical reasons because there are
> > > -		 * a lot of places in drivers where it's used. In drm core for
> > > -		 * generic code paths the preferred way is to use
> > > -		 * @char_per_block, drm_format_info_block_width() and
> > > -		 * drm_format_info_block_height() which allows handling both
> > > -		 * block and non-block formats in the same way.
> > > -		 *
> > >  		 * For formats that are intended to be used only with non-linear
> > >  		 * modifiers both @cpp and @char_per_block must be 0 in the
> > >  		 * generic format table. Drivers could supply accurate
> > >  =20
> >=20
> > Other than that, sounds fine to me.
> >=20
> > Perhaps one thing to clarify is that chroma sub-sampling and blocks are
> > two different things. Chroma sub-sampling is about the resolution of
> > the chroma (image). Blocks are about packing multiple pixels' components
> > into a contiguous addressable block of memory. Blocks could appear
> > inside a separate sub-sampled UV plane, for example. =20
>=20
> Is this clear? i will add it just before "In some formats,=20
> pixels...
>=20
>  * Chroma subsamping (hsub/vsub) must not be confused with pixel blocks. =
The
>  * first describe the relation between the resolution of each color compo=
nents
>  * (for YUV format, the relation between the "y" resolution and the "uv"
>  * resolution), the second describe the way to pack multiple pixels into =
one
>  * contiguous block of memory (for example, DRM_FORMAT_Y0L0, one block is=
 2x2
>  * pixels).

A different example would be better, e.g. DRM_FORMAT_R2, because chroma
sub-sampling too can share U and V for a 2x2 set of pixels. R2 is in
the RGB family, so chroma sub-sampling does not even apply.

Yes, sounds fine.


Thanks,
pq

--Sig_/rR9Kf+9TSUkAda/q4ChRKXC
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmYftgcACgkQI1/ltBGq
qqcmFw/9H2qBmE/pueElg5BnyyEAYJVtm1zyOmPSV300waWIB1p2S7oqBKrZVcu4
UAEKTA7vld4hpSfiRJi4YXEBzLFErBYCpCnv5kCtVahDT2bJ5F6qKXxWurfVG+aD
tMy03ehbLJVZ4zUcZASScTGSzS3Xb7omjFL9w5zR9s1q6y94l3y9jH1knWt/J5D9
aV3dF3uyWc18emvbX4g7AvBtK9zGfdVVrNgZvTMz3Kd0H4jDpRbxNY+Z0/tNBNtQ
LHoEuFk3UTgNPsGOBNpS2Te46+28mnEdfbEhhITbuU0NMcQE5HVnWqN0mhIgXIAW
B0/NoAyGPZ9Euqj166oMigp2lwm4CxI1gzn+o0mjPrDWkbT6i+NQtx6XSRpmp5Dn
jtRkWH1IqFKfrE0pa40hzIiKaxxfV1HNQSxxKB63UlTFGWCoYBfAPHWnrHVOJ8Bc
vVAWxNRqyiOCMC+FZqSZkice2cVgxoE3VKx8que1dGoAB5z4tFDAdsjJNO+OS9ZD
WYPtLzgxJvkOmAowki2znZbb/7nLBVU+lvUAXStvjGT8THO7eaAPqNeWkR73DKoe
XThjl8DceC7S5QWt5DW+oiZmBqiwm3ghM9S0B82yv9FQbbZHAo6ew0uC7jMJeQSP
pq3AokHX4Tsuayy1o4VnYGIb+lehUEF9HmJKIhfH/Bfhu2F1rDs=
=i05E
-----END PGP SIGNATURE-----

--Sig_/rR9Kf+9TSUkAda/q4ChRKXC--

