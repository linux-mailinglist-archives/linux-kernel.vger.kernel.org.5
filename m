Return-Path: <linux-kernel+bounces-83162-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B71E2868FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 13:08:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4096D1F21AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B95613A27E;
	Tue, 27 Feb 2024 12:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rPcOhAiN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8F137C20;
	Tue, 27 Feb 2024 12:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709035697; cv=none; b=lPT+vCSgt9jgAIKDWsF/JiM3Ytuh5wLCeh1BmAuF2uuVBlXPTJqu53lNgDWxUOPw8+nXLXBSnDnYhWWx/Wta8xxm+BOsDQe4KR1/VITF+ZrpvKWJxVL+AugbdE3MZ61w1w6X7uTcN64/Oxn2bSs9fF6ijMp2rpYKm+yaaq2AxQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709035697; c=relaxed/simple;
	bh=ACaz7oj5ReqFoIR72ebNJXl994t4BOU7shgO5K8CUjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIu6A+sgTD3lzGRrHUzM0ISvDwwTjbYh8FOPWO/DE8Gzj/srQGKcOrMeonvxYdty8sfpFq63jtpEyn8MxTqSHVHCKBOpdP/2CacP99dupwOi1Vq10PVcA2I86GLsEWhQuoSGG4xPcQmhztphDd55kiVPVD4vQA1y2gB8B5FSivE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rPcOhAiN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF9B4C43390;
	Tue, 27 Feb 2024 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709035697;
	bh=ACaz7oj5ReqFoIR72ebNJXl994t4BOU7shgO5K8CUjs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rPcOhAiN2PtkNLYRBMqmRiMbDR6p59SbOgdUHY6MdY/GfepvdtHrN4RR9v1sZYqf6
	 jGI2QQj99JWnXpmDj76LwUn5WOEnN2l8plI/Woy9JymhacQ8VopW5b3x8MDmW6BR3I
	 1mhXEPNwYTypLA8EvT5QrKq5WyQSqfjz/WuF4zmZbFCzvBEEroimeIedS523uwhWc0
	 uq2irP6Mmsab/1y0zyVOZI3iqcQ1Tt+elVYtsRMaL5qiHIHNgePfxDPrjcFVWcmbyP
	 nzPJdHwMz3keyVrdNrECnvtckEFIcLNcawWXousAOSunIXQ/sdzf7RMhsqiuz0ENoH
	 NKhxbGiV9gDEw==
Date: Tue, 27 Feb 2024 13:08:14 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Jonathan Corbet <corbet@lwn.net>, 
	Sandy Huang <hjc@rock-chips.com>, Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, Hans Verkuil <hverkuil@xs4all.nl>, 
	Sebastian Wick <sebastian.wick@redhat.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH v7 25/36] drm/connector: hdmi: Add Infoframes generation
Message-ID: <lxvyfigepzg4jhqub6lg6lmffen4puf477zjxmi766f3hu6trn@nnvg6htufsjn>
References: <20240222-kms-hdmi-connector-state-v7-0-8f4af575fce2@kernel.org>
 <20240222-kms-hdmi-connector-state-v7-25-8f4af575fce2@kernel.org>
 <CAA8EJpri_whY8YfX2BsBjMN_4JvFsU-ogfr1W-KUKrasRoH-WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ocit6yam46alzc5t"
Content-Disposition: inline
In-Reply-To: <CAA8EJpri_whY8YfX2BsBjMN_4JvFsU-ogfr1W-KUKrasRoH-WQ@mail.gmail.com>


--ocit6yam46alzc5t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 25, 2024 at 05:02:51PM +0200, Dmitry Baryshkov wrote:
> > @@ -476,6 +478,7 @@ EXPORT_SYMBOL(drmm_connector_init);
> >   */
> >  int drmm_connector_hdmi_init(struct drm_device *dev,
> >                              struct drm_connector *connector,
> > +                            const char *vendor, const char *product,
> >                              const struct drm_connector_funcs *funcs,
> >                              const struct drm_connector_hdmi_funcs *hdm=
i_funcs,
> >                              int connector_type,
> > @@ -485,6 +488,13 @@ int drmm_connector_hdmi_init(struct drm_device *de=
v,
> >  {
> >         int ret;
> >
> > +       if (!vendor || !product)
> > +               return -EINVAL;
> > +
> > +       if ((strlen(vendor) > DRM_CONNECTOR_HDMI_VENDOR_LEN) ||
> > +           (strlen(product) > DRM_CONNECTOR_HDMI_PRODUCT_LEN))
> > +               return -EINVAL;
> > +
> >         if (!(connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIA ||
> >               connector_type =3D=3D DRM_MODE_CONNECTOR_HDMIB))
> >                 return -EINVAL;
> > @@ -500,6 +510,12 @@ int drmm_connector_hdmi_init(struct drm_device *de=
v,
> >                 return ret;
> >
> >         connector->hdmi.supported_formats =3D supported_formats;
> > +       strtomem_pad(connector->hdmi.vendor, vendor, 0);
> > +       strtomem_pad(connector->hdmi.product, product, 0);
> > +
> > +       ret =3D drmm_mutex_init(dev, &connector->hdmi.infoframes.lock);
>=20
> I'd suggest moving this call to the generic __drm_connector_init().
> This way no matter how the rest of the drm code (mis)uses the
> connector, the lock is always present and valid.

Yeah, that makes sense, I'll change it.

Thanks!
Maxime

--ocit6yam46alzc5t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZd3QrgAKCRDj7w1vZxhR
xUw4AQDY/7kZ7wFpO+/Ak/W0YWywU3LNZ5pkN4Om9GBNtAUK6wD/YV9OiFjDhmlL
sW/aBGeDNa/yzjkkc0NKa5D6dGQe5Qc=
=FJc2
-----END PGP SIGNATURE-----

--ocit6yam46alzc5t--

