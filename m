Return-Path: <linux-kernel+bounces-63331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3411852DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 11:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D75A61C217F5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D071D22626;
	Tue, 13 Feb 2024 10:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JRVCi3uI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52FBA2260B
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707819535; cv=none; b=c8DS7amWe8eSfdhTGblYQoo84WJ2qsXdMu5DMtjhL+VNv9fp1f3tU9mQuXjgj+k6BzmUCKae79Hb8cNROzxhjub7/UBBgb1UlVwyjawMJXd4FLHXgszmUFPYbuyxi8UxFj7V2NRfPHDCzUpevtSEG/HtnPBLd6jeZnqrXanmBlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707819535; c=relaxed/simple;
	bh=StklY9GQgTyfKW893Zzxys7ZaOQiy/wW6C5F5B1HAzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d17FfIlObowCoJZxh/OXlyzSP9ijSTwm5jdC8PvkX1iwCFCH/kNRqetUD0lwuYiB/ZZwDkbklDFBrtQiBxZGQbLHG6Jmy/Jm67NWZVDjQ/Q2lxcfwqrKfkOBoJAIG4bo17CEx4y/oS4MJsoT7p69UbRy1Pi7F91oPEr98RIgRfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JRVCi3uI; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707819530;
	bh=StklY9GQgTyfKW893Zzxys7ZaOQiy/wW6C5F5B1HAzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JRVCi3uILc/NPa2Fgaz/x3/o1PT1nqEieFW21W35P8lIxP7pl9kUQ/dOlFwm9dgST
	 jimn91maOgHuAWD0AWL9eQte7zWkWID2VnLb44Y2d1JRg1T9bZAMOz7qhIuLzQkITk
	 bOEcmprhPVBp0bM/tTKBumFnIrBG6GWWMm7IDwoHz9qetBavYMjyAfZXF6EqO9Bdk2
	 +4T8qdFNR9kSyakdzjTV0lMo++2Zfh6y6IoJ9d7+xjA9UEmQjlvSb+KFAwj+/BAa6c
	 NpyJTHhFtMkOxexr0XL53AHreXJy+BewR6atoKCpdm/rob39sysDiZoci6LbyqBbp0
	 qOM3NFUlxL4rw==
Received: from xpredator (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mvlad)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 5D4A937810EF;
	Tue, 13 Feb 2024 10:18:49 +0000 (UTC)
Date: Tue, 13 Feb 2024 12:18:48 +0200
From: Marius Vlad <marius.vlad@collabora.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Pekka Paalanen <pekka.paalanen@haloniitty.fi>,
	Jyri Sarha <jyri.sarha@iki.fi>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Sam Ravnborg <sam@ravnborg.org>, Devarsh Thakkar <devarsht@ti.com>,
	Aradhya Bhatia <a-bhatia1@ti.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	Tomi Valkeinen <tomi.valkeinen@ti.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	"wayland-devel@lists.freedesktop.org" <wayland-devel@lists.freedesktop.org>,
	Randolph Sapp <rs@ti.com>
Subject: Re: [PATCH 1/2] drm/tidss: Fix initial plane zpos values
Message-ID: <ZctCCCJORdDEaDl1@xpredator>
References: <20240213-tidss-fixes-v1-0-d709e8dfa505@ideasonboard.com>
 <20240213-tidss-fixes-v1-1-d709e8dfa505@ideasonboard.com>
 <20240213110440.13af335a@eldfell>
 <bb8089cd-2a57-4ed0-a8bd-2140a89b0887@ideasonboard.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="wbkGuanwajvS8wQb"
Content-Disposition: inline
In-Reply-To: <bb8089cd-2a57-4ed0-a8bd-2140a89b0887@ideasonboard.com>


--wbkGuanwajvS8wQb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 11:57:59AM +0200, Tomi Valkeinen wrote:
> Hi,
Hi,
>=20
> On 13/02/2024 11:04, Pekka Paalanen wrote:
> > On Tue, 13 Feb 2024 10:16:36 +0200
> > Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> >=20
> > > When the driver sets up the zpos property it sets the default zpos va=
lue
> > > to the HW id of the plane. That is fine as such, but as on many DSS
> > > versions the driver arranges the DRM planes in a different order than
> > > the HW planes (to keep the non-scalable planes first), this leads to =
odd
> > > initial zpos values. An example is J721e, where the initial zpos valu=
es
> > > for DRM planes are 1, 3, 0, 2.
> > >=20
> > > In theory the userspace should configure the zpos values properly when
> > > using multiple planes, and in that sense the initial zpos values
> > > shouldn't matter, but there's really no reason not to fix this and he=
lp
> > > the userspace apps which don't handle zpos perfectly. In particular,
> > > Weston seems to have issues dealing with the planes with the current
> > > default zpos values.
> > >=20
> > > So let's change the zpos values for the DRM planes to 0, 1, 2, 3.
> > >=20
> > > Another option would be to configure the planes marked as primary pla=
nes
> > > to zpos 0. On a two display system this would give us plane zpos valu=
es
> > > of 0, 0, 1, 2. The end result and behavior would be very similar in t=
his
> > > option, and I'm not aware that this would actually help us in any way.
> > > So, to keep the code simple, I opted for the 0, 1, 2, 3 values.
> > >=20
> > > Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> > > Fixes: 32a1795f57ee ("drm/tidss: New driver for TI Keystone platform =
Display SubSystem")
> >=20
> > Hi Tomi,
> >=20
> > have you reported this to Weston? What exactly is the problem?
>=20
> I haven't. I'm quite unfamiliar with Weston, and Randolph from TI (cc'd) =
has
> been working on the Weston side of things. I also don't know if there's
> something TI specific here, as the use case is with non-mainline GPU driv=
ers
> and non-mainline Mesa. I should have been a bit clearer in the patch
> description, as I didn't mean that upstream Weston has a bug (maybe it ha=
s,
> maybe it has not).
>=20
> The issue seen is that when Weston decides to use DRM planes for
> composition, the plane zpositions are not configured correctly (or at all=
?).
> Afaics, this leads to e.g. weston showing a window with a DRM "overlay"
> plane that is behind the "primary" root plane, so the window is not visib=
le.
> And as Weston thinks that the area supposedly covered by the overlay plane
> does not need to be rendered on the root plane, there are also artifacts =
on
> that area.
>=20
> Also, the Weston I used is a bit older one (10.0.1), as I needed to go ba=
ck
> in my buildroot versions to get all that non-mainline GPU stuff compiled =
and
> working. A more recent Weston may behave differently.
Right after Weston 10, we had a few minor changes related to the
zpos-sorting list of planes and how we parse the plan list without having
a temporary zpos ordered list to pick planes from.

And there's another fix for missing out to set out the zpos for scanout
to the minimum available - which seems like a good candidate to explain
what happens in the issue described above. So if trying Weston again,
please try with at least Weston 12, which should have those changes
in.

>=20
> > It doesn't seem like a good idea to work around userspace bugs
> > (non-regression, I presume?) with kernel changes.
>=20
> Presuming this is not related to any TI specific code, I guess it's a
> regression in the sense that at some point Weston added the support to use
> planes for composition, so previously with only a single plane per display
> there was no issue.
>=20
> I agree with you, this patch shouldn't be merged to "fix" issues with tid=
ss
> + Weston. However, the current default zpos values really don't make sens=
e,
> so I think this patch can stand on its own, and should be merged just to
> make the tidss behavior a bit saner.
>=20
> But even if this patch merged, the issue with Weston should be looked at
> (*poke* Randolph =3D).
>=20
>  Tomi
>=20
> >=20
> >=20
> > Thanks,
> > pq
> >=20
> > > ---
> > >   drivers/gpu/drm/tidss/tidss_plane.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/gpu/drm/tidss/tidss_plane.c b/drivers/gpu/drm/ti=
dss/tidss_plane.c
> > > index e1c0ef0c3894..68fed531f6a7 100644
> > > --- a/drivers/gpu/drm/tidss/tidss_plane.c
> > > +++ b/drivers/gpu/drm/tidss/tidss_plane.c
> > > @@ -213,7 +213,7 @@ struct tidss_plane *tidss_plane_create(struct tid=
ss_device *tidss,
> > >   	drm_plane_helper_add(&tplane->plane, &tidss_plane_helper_funcs);
> > > -	drm_plane_create_zpos_property(&tplane->plane, hw_plane_id, 0,
> > > +	drm_plane_create_zpos_property(&tplane->plane, tidss->num_planes, 0,
> > >   				       num_planes - 1);
> > >   	ret =3D drm_plane_create_color_properties(&tplane->plane,
> > >=20
> >=20
>=20

--wbkGuanwajvS8wQb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEcDKHej6x6uPk3J379jQS5glH1u8FAmXLQgUACgkQ9jQS5glH
1u8hrA//WU67Tk3LFiBcWuQBLFMMspQZiLj1/QVeNAQB2qxlzsqNmrnt+JcqfbpL
icxevyasaeiALggRtbwNLrpHpViX4K/hmGz06ai7CE+Tv1WxbJS9JO8zL5aWykxI
Bw9miuwqJUYr3vxZBtMkI2Djo/mHmyxe3NobAYDvg8smUsW6+0r7o048HxUdExJ7
KyflLrH+C49pJuohkAlUBNRZ6o0hRTqEQd53px3pv3eV3NiTf/YzFQWwJFNVa1Mc
iVFXeOEcVo2JIKYso/3gn0rV+GAMZn6SBx8yWsQDYt25H9lPEhEmmXAEoPXd+rnU
vgkkjWAKu3tLXASBkTy3U2cgwo6TmBel/63IaAyclbfB3vprOM+RLSz0daYETeno
RpiI1Rn92t0b6YAUVIrVpWi9f9dNbYlEwHkP27fX7iu7giZ7S0TR01DDP3fA93eG
2JkQbRH8lhLxeSThrVvUi4xcXWZcm1AkjaP3iGzkET6uftRz9lTX1PpEJ3R/dD8C
uil2bgxKJxU19dd9UZURt8seAIu3BNEfyHu6uZL9GdRbnqu5WyG1W89f9Mmg7bpO
YIHmkeNj3+ItV1FUVahKb8yI7uR0mfsy+UHhhN92JJIZ6lFgqFpZ8UskoHNpw8iL
tqOBsFS1OAsQSfW3apZe24oq3hR25Gry7npJ76xo5mwCVUi+zpQ=
=NsvQ
-----END PGP SIGNATURE-----

--wbkGuanwajvS8wQb--

