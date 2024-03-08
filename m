Return-Path: <linux-kernel+bounces-97227-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB02876753
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0CF72840F5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7590A1EEFD;
	Fri,  8 Mar 2024 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="CaJUNgBh"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E36524A;
	Fri,  8 Mar 2024 15:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709911589; cv=none; b=WFt1EwHHnrEFc/iS2aXfBEEmxn/n5EsJx4CbYdGDpDtMWUtrG1HhrE+eBfWgNBRYsbV87e0dZAWApHtlPSAB6pDm5OBovI+t3Frp1//CHkYPEcYrclcO0MCpIVkYJUJ6Ssu8nbl5qIhySHyy+p1DaZtyv99PAWtvdn9yKRtEpz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709911589; c=relaxed/simple;
	bh=6DC78vJKP4bef9pNZHj5COm941gdKspq9AeeVyGC8ws=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OHaM+zLstHYzv8ndpd5PZ3AOZ7V1zHrMlTAJXXM7IEuqtAuHFsl5W5ZIzxdbxjuZgthNHH2vnECwa6e3sZHzuX9cKQ69AgDWcA4KtJMtufKzPhdJtwEM/eRCEWuACvYmNF0AF6J/LGjBw6bngCMvytc4UW3599K9AUMpEfAmmac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=CaJUNgBh; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709911586;
	bh=6DC78vJKP4bef9pNZHj5COm941gdKspq9AeeVyGC8ws=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CaJUNgBhVBBtKwKyU1eg2qeTLTAf8PatkzvYxsSzvyA4grXZfATZBhUiGguaWJu6d
	 LHPmLGHvUEufBNWvRQdnYEncKBpolIIR2dYfrpi//G14XSbZ8Q2hZfcvhiRvLloxpl
	 oXbzqhgDrEMwPuCIsICgcX23J1+9CTl2Nq53sHR3TpBOjZ/z8o+lNx6QuTHr605xgd
	 Z9AbY/se8B1vkywbenh2YOB28PxU+v5qtQRHQc9GvDEbu8zQEn51Zt0bw4lrwfpNFx
	 uDudYrNoifqnjB7c03LXVgZrlUzq9XkFrY7e1h43Mo6aKLHp3SsA4lEKciC3N40c2z
	 qz83sNCiXyYQw==
Received: from eldfell (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pq)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id C084D3780B5F;
	Fri,  8 Mar 2024 15:26:24 +0000 (UTC)
Date: Fri, 8 Mar 2024 17:26:23 +0200
From: Pekka Paalanen <pekka.paalanen@collabora.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, Sandy Huang
 <hjc@rock-chips.com>, Heiko =?UTF-8?B?U3TDvGJuZXI=?= <heiko@sntech.de>,
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, dri-devel@lists.freedesktop.org, Hans
 Verkuil <hverkuil@xs4all.nl>, Sebastian Wick <sebastian.wick@redhat.com>,
 Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, Maxime
 Ripard <mripard@kernel.org>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v8 16/27] drm/connector: hdmi: Add Broadcast RGB
 property
Message-ID: <20240308172623.37663eb6.pekka.paalanen@collabora.com>
In-Reply-To: <2599919.Lt9SDvczpP@steina-w>
References: <20240307-kms-hdmi-connector-state-v8-0-ef6a6f31964b@kernel.org>
	<20240307-kms-hdmi-connector-state-v8-16-ef6a6f31964b@kernel.org>
	<2599919.Lt9SDvczpP@steina-w>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cnPglAFz2UjDZ1=A=78DBbG";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/cnPglAFz2UjDZ1=A=78DBbG
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 08 Mar 2024 12:26:14 +0100
Alexander Stein <alexander.stein@ew.tq-group.com> wrote:

> Hi Maxime,
>=20
> Am Donnerstag, 7. M=C3=A4rz 2024, 14:38:43 CET schrieb Maxime Ripard:
> > The i915 driver has a property to force the RGB range of an HDMI output.
> > The vc4 driver then implemented the same property with the same
> > semantics. KWin has support for it, and a PR for mutter is also there to
> > support it.
> >=20
> > Both drivers implementing the same property with the same semantics,
> > plus the userspace having support for it, is proof enough that it's
> > pretty much a de-facto standard now and we can provide helpers for it.
> >=20
> > Let's plumb it into the newly created HDMI connector.
> >=20
> > Reviewed-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
> > Acked-by: Pekka Paalanen <pekka.paalanen@collabora.com>
> > Reviewed-by: Sebastian Wick <sebastian.wick@redhat.com>
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >  Documentation/gpu/kms-properties.csv      |  1 -
> >  drivers/gpu/drm/drm_atomic.c              |  2 +
> >  drivers/gpu/drm/drm_atomic_state_helper.c |  4 +-
> >  drivers/gpu/drm/drm_atomic_uapi.c         |  4 ++
> >  drivers/gpu/drm/drm_connector.c           | 88 +++++++++++++++++++++++=
++++++++
> >  include/drm/drm_connector.h               | 36 +++++++++++++
> >  6 files changed, 133 insertions(+), 2 deletions(-)

..

> > diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_conn=
ector.c
> > index 591d2d500f61..0272e1d05cc6 100644
> > --- a/drivers/gpu/drm/drm_connector.c
> > +++ b/drivers/gpu/drm/drm_connector.c
> > @@ -1210,10 +1210,33 @@ static const u32 dp_colorspaces =3D
> >  	BIT(DRM_MODE_COLORIMETRY_SYCC_601) |
> >  	BIT(DRM_MODE_COLORIMETRY_OPYCC_601) |
> >  	BIT(DRM_MODE_COLORIMETRY_BT2020_CYCC) |
> >  	BIT(DRM_MODE_COLORIMETRY_BT2020_YCC);
> > =20
> > +static const struct drm_prop_enum_list broadcast_rgb_names[] =3D {
> > +	{ DRM_HDMI_BROADCAST_RGB_AUTO, "Automatic" },
> > +	{ DRM_HDMI_BROADCAST_RGB_FULL, "Full" },
> > +	{ DRM_HDMI_BROADCAST_RGB_LIMITED, "Limited 16:235" },
> > +};
> > +
> > +/*
> > + * drm_hdmi_connector_get_broadcast_rgb_name - Return a string for HDM=
I connector RGB broadcast selection
> > + * @broadcast_rgb: Broadcast RGB selection to compute name of
> > + *
> > + * Returns: the name of the Broadcast RGB selection, or NULL if the ty=
pe
> > + * is not valid.
> > + */
> > +const char *
> > +drm_hdmi_connector_get_broadcast_rgb_name(enum drm_hdmi_broadcast_rgb =
broadcast_rgb)
> > +{
> > +	if (broadcast_rgb > DRM_HDMI_BROADCAST_RGB_LIMITED) =20
>=20
> I don't know if this was brought up before. IMHO it's easier to read chec=
king:
>  if (broadcast_rgb > ARRAY_SIZE(broadcast_rgb_names)

You have an off-by-one bug in that suggestion. ;-)


Thanks,
pq

>=20
> Best regards,
> Alexander
>=20
> > +		return NULL;
> > +
> > +	return broadcast_rgb_names[broadcast_rgb].name;
> > +}
> > +EXPORT_SYMBOL(drm_hdmi_connector_get_broadcast_rgb_name);

--Sig_/cnPglAFz2UjDZ1=A=78DBbG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEJQjwWQChkWOYOIONI1/ltBGqqqcFAmXrLh8ACgkQI1/ltBGq
qqdLBg//WajUtBqhYeUOZE3qGTS947fI7FHecuVL9+bEwFWN4IXJP/QP8I8lYHud
AhB2e5IQ0KisC91nq8FnE6gL64X6lvW5+ezRUsqyezKl4tEXFxg99dhbVW2ozgD3
9ZXWlyIldM989o3eGDBdAPRPWh9CUTWCQbhI/chyJ4GtpWpBnicbNf+sNnzOGUbw
bGrP6vSL3PQVlV0GA95gvGKD8xvRwObQc3/qHHAaNTFvwXRbEi6y7rTkCB3OqzRT
OoEfi2KzYHwsZ7p4My064ppTBH9+APe+FWBQEsxPLR3NVdwHArQLmT5Do9DnfS/9
LWBLBUXms3fUr0DXzGPpCyUHFlMXJSoRQao/n2D64SNmLRBx1V++ktTf2TUpk2qr
J1JCZ6gHXP/LYl/lVAkBXi++7wh//ytHmB8KHUINuRjxVHTedofibScVkAyx6h8P
YO3Ykq00HrgtcePPgKdCrrYGmkXYp151NNq0h0OUsSuykMx3LzMSqneR0bjwPjOx
5Mq7VT9gecqIsEMBLL3uTlgKAnBqbVH5r1HnbAVOgv/8b6SRoYUlTzfapCW9HVso
akzQp9SLe6oiPiU66vlOT8M2cgUjgQlloPIdox885vMiWR4TfV3T0VS6wEpHrvWW
RwjlgAyZaWXQ/2Al3lJGjp/DDZQ5ud7bfHxS6QnVS8Sl1eIdlGQ=
=Nq7z
-----END PGP SIGNATURE-----

--Sig_/cnPglAFz2UjDZ1=A=78DBbG--

