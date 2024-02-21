Return-Path: <linux-kernel+bounces-74819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9095085DBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C34F285D40
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A86578B70;
	Wed, 21 Feb 2024 13:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9yvpKAH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B37BAFB;
	Wed, 21 Feb 2024 13:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708523123; cv=none; b=usxLFZ9yAi+Vg1q43zLtdeGbb70XdHcZgIv+oF/wkhL4yoE9EVJZs0f0JHizfJm7xSSJ0iZ5sj2aLijmPgGGZxmteS5vcgmWEgluT5udKKxtGkrFizR97qcoyvuDrKylOKg29Xu3ovc5pC+qn3Z48xBUP+TB3KJN/oQvgbeh6Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708523123; c=relaxed/simple;
	bh=BJHfR2bAYcqfGE3I7jpnJmREd+wIkIHX/KEdFxdNxEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gUzAlIddXvhNnpP3ZcPuSiLugHi9yElprxPmCuH13fZRmzgJpUU4fmKXlMyR7wJgzAPSlcr75P+53L2cUIJxUkvKuSFCqbUdOZnffmPRt0tdQ9Zp9AnpPTmeIsZoULY6b7N4yPp+7S5yInGsriDhyvLYUTajFf8RDfubgSRthP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9yvpKAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F00DC433B1;
	Wed, 21 Feb 2024 13:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708523122;
	bh=BJHfR2bAYcqfGE3I7jpnJmREd+wIkIHX/KEdFxdNxEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V9yvpKAHKX1WltEJ2II938p0AA1QC7vXzKkuglhObkdmrkGI5z3dEVYrLqvzXRS5q
	 ZxvKUYAvry0BC6AUZ/fEdagJZBM6RSkLGSv73vgr/VMTXBeQj10kx3ErKew8sQTHdH
	 OvtsBrQfIesfTbfzEmKe12ho/3+QVunU9VSGoLQIxz6Tio6jI3zflXXIZmkBGCbTjM
	 dAdvonYr1+9buy8TNKH8cGh0bl8fO+m8whFR+tNkFViUy9R/fTyNfNboTCPjSAmHau
	 2EGNIX6DOvb7Hl1UCKzNQAygYCtlgA9Ywyt8vbdQDwIThTHuMb18oPwkW/Rc9F7EYs
	 o8ax3Vj4mLX3w==
Date: Wed, 21 Feb 2024 14:45:20 +0100
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
Cc: Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] drm/sun4i: Fix layer zpos change/atomic modesetting
Message-ID: <inuhwnlexpt6dpre4uailtvytjhms4uqeerzehbntczurhcxol@fc4nvkdwffdd>
References: <20240216190430.1374132-1-megi@xff.cz>
 <20240216190430.1374132-4-megi@xff.cz>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="xizgahp2qebktux3"
Content-Disposition: inline
In-Reply-To: <20240216190430.1374132-4-megi@xff.cz>


--xizgahp2qebktux3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 16, 2024 at 08:04:26PM +0100, Ond=C5=99ej Jirman wrote:
> From: Ondrej Jirman <megi@xff.cz>
>=20
> Identical configurations of planes can lead to different (and wrong)
> layer -> pipe routing at HW level, depending on the order of atomic
> plane changes.
>=20
> For example:
>=20
> - Layer 1 is configured to zpos 0 and thus uses pipe 0. No other layer
>   is enabled. This is a typical situation at boot.
>=20
> - When a compositor takes over and layer 3 is enabled,
>   sun8i_ui_layer_enable() will get called with old_zpos=3D0 zpos=3D1, whi=
ch
>   will lead to incorrect disabling of pipe 0 and enabling of pipe 1.
>=20
> What happens is that sun8i_ui_layer_enable() function may disable
> blender pipes even if it is no longer assigned to its layer.
>=20
> To correct this, move the routing setup out of individual plane's
> atomic_update into crtc's atomic_update, where it can be calculated
> and updated all at once.
>=20
> Remove the atomic_disable callback because it is no longer needed.
>=20
> Signed-off-by: Ondrej Jirman <megi@xff.cz>

I don't have enough knowledge about the mixers code to comment on your
patch, so I'll let Jernej review it. However, this feels to me like the
pipe assignment is typically the sort of things that should be dealt
with device-wide, and in atomic_check.

If I'm talking non-sense, it would be great to mention at least why that
can't be an option in the commit log.

Maxime

--xizgahp2qebktux3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZdX+bwAKCRDj7w1vZxhR
xZNgAP0a4L6Azcg9V6BM/jsiHiwH17jM+P8Er1XqzO57EQIFCQD/WAIto3Vlp7l6
KwBXVWBIRLqnsTHnduB8s/JicR+nIgU=
=6/Lk
-----END PGP SIGNATURE-----

--xizgahp2qebktux3--

