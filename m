Return-Path: <linux-kernel+bounces-111295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62FE1886A56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:31:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 190B91F23D99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3C0C3C699;
	Fri, 22 Mar 2024 10:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pebyrOqZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5A51E522;
	Fri, 22 Mar 2024 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711103470; cv=none; b=JlTr2e6DKeC+eTwvbrted2zrQNNfXHo/JanpyYyguCFnm+PvGrDcm12X5ngRcml2XaPUcUMH9H8tBaBHzNvLXKCPBuHU2pK0garDWCsIL6iUyLuZk2Ah70A1L8gyQqQmOUM/2GIYoNakmAr14OhF/+LNFXhFFo3NwGNWEBB9+XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711103470; c=relaxed/simple;
	bh=UUEqLZY926OzvcyM4AzY60Au8Cf9w6FnpcBoTROOC0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W/Agb8BPv83M8grVRxbe8XYNFkxzqZxpdgedYyyTOpTw67COn57ZNwH5kURZQiCxezxpZhwQVAbKREQi/qHheTjGeew9aeWgKZLuoxoUAz44NvaFrzpT8tVx2xi+aSEDnOWssSyuNtNtgwM+iZy8aTt1WAreQVxzY2k515/gHhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pebyrOqZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D14AC433F1;
	Fri, 22 Mar 2024 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711103469;
	bh=UUEqLZY926OzvcyM4AzY60Au8Cf9w6FnpcBoTROOC0k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pebyrOqZ/kkpqhT9lPzfQtwwYMJZXvaiMu1gMatvg2tgMHJx9IioiiVWvx6uypQmY
	 G/+r7pU9Jgs3J0a7YPe+2veMpKADZtPs21Zw/oM9KFcS6Dcsgs/7ttzl3fMUxNa8Pr
	 dO8CrMuq+3EZ8rX1bSbqZlMQJwziz0ZsoPM8awtnIUckF0VzJVI9/BgUGId1UxPm88
	 gZ+Y9bPzhqklJGCKQ+I+JqI1RTFiwE9WRYQvFkqi6h7gaSgzxPQG2JqiPslpfJvebj
	 DF69NSp5qjQsF1r5o0lmY15dZuZGOCb8c5XIrewVUOfZA+1A5oWDhfnhAuYEYw1DOL
	 u81rcgOIJaHGg==
Date: Fri, 22 Mar 2024 11:31:06 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Sui Jingfeng <sui.jingfeng@linux.dev>
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
Subject: Re: [v10,20/27] drm/connector: hdmi: Add Infoframes generation
Message-ID: <20240322-loose-resourceful-bullmastiff-92cfaf@houat>
References: <20240321-kms-hdmi-connector-state-v10-20-e6c178361898@kernel.org>
 <07125064-2a78-4515-bb48-655f2aec140f@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5rd3vuyyvq3awglq"
Content-Disposition: inline
In-Reply-To: <07125064-2a78-4515-bb48-655f2aec140f@linux.dev>


--5rd3vuyyvq3awglq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 22, 2024 at 05:53:07AM +0800, Sui Jingfeng wrote:
> Hi,
>=20
>=20
> On 2024/3/21 23:29, Maxime Ripard wrote:
> > Infoframes in KMS is usually handled by a bunch of low-level helpers
> > that require quite some boilerplate for drivers. This leads to
> > discrepancies with how drivers generate them, and which are actually
> > sent.
> >=20
> > Now that we have everything needed to generate them in the HDMI
> > connector state, we can generate them in our common logic so that
> > drivers can simply reuse what we precomputed.
> >=20
> > Signed-off-by: Maxime Ripard <mripard@kernel.org>
> > ---
> >   drivers/gpu/drm/Kconfig                            |   1 +
> >   drivers/gpu/drm/drm_atomic_state_helper.c          | 338 ++++++++++++=
+++++++++
> >   drivers/gpu/drm/drm_connector.c                    |  14 +
> >   .../gpu/drm/tests/drm_atomic_state_helper_test.c   |   1 +
> >   drivers/gpu/drm/tests/drm_connector_test.c         |  12 +
> >   include/drm/drm_atomic_state_helper.h              |   8 +
> >   include/drm/drm_connector.h                        | 109 +++++++
> >   7 files changed, 483 insertions(+)
> >=20
> > diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> > index 16029435b750..3d3193c7aa5f 100644
> > --- a/drivers/gpu/drm/Kconfig
> > +++ b/drivers/gpu/drm/Kconfig
> > @@ -97,10 +97,11 @@ config DRM_KUNIT_TEST
> >   	  If in doubt, say "N".
> >   config DRM_KMS_HELPER
> >   	tristate
> >   	depends on DRM
> > +	select DRM_DISPLAY_HDMI_HELPER
>=20
> Should we select DRM_DISPLAY_HELPER here? Otherwise there will have
> some compile error emerged with default config.

Which default config are you talking about? This compiles fine with all
drm-misc defconfig, x86 defconfig and allmodconfig.

Maxime

--5rd3vuyyvq3awglq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZf1d6QAKCRDj7w1vZxhR
xfhQAQCu0NBIAdBH+cxZxEu6wIBjCqIn1oD+nTHDxOSsluuItwEA9Oy60mNpP4Om
Xu9L4CIP02hqE9XIyC9VujJM0cW/LQA=
=XSYZ
-----END PGP SIGNATURE-----

--5rd3vuyyvq3awglq--

