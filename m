Return-Path: <linux-kernel+bounces-130713-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A5FD6897BEB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 01:15:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34723B213B4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 23:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BE6156985;
	Wed,  3 Apr 2024 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qpy/c9+x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE915099C;
	Wed,  3 Apr 2024 23:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712186122; cv=none; b=BFBSsOCmAwlzUo+t139xVk9pMYv+dQTGsnxz5vqcmKmKprhzyE+ACQ7enq6bXmE59p06drBrFv3kxZEK+LG4YBNnrjcpBhruPqIBSlHMhgCIs5tkIh2fdcdQ1v7fzsZ7Wr7DS03iXB6vKC6zYjALaX0VZoUOm4Nh7V3V1PbwyWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712186122; c=relaxed/simple;
	bh=7YP3abqizRPoAPL8obPaJDqiuw0+wj9ZdRKndmVtWO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FJyNIUPvmWJ5WvaQ11GERLNy50CBnTMk8E5vXxw6U5LJj+PAxR4dJ7avG/VMUIv4sN88ZXsPITVOZklBz5X3jD48eBK+6SVfeWsd/Q8oTLqnfH9GQUGti2f3XV8tT2iTtX1B/hMzGf7D4nVVc3vHexiLXsbb/uPp72QPElLDPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qpy/c9+x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C237C433F1;
	Wed,  3 Apr 2024 23:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712186121;
	bh=7YP3abqizRPoAPL8obPaJDqiuw0+wj9ZdRKndmVtWO8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qpy/c9+xzO52cbTnZVZQNwr/ma8IJrDqRf3Q1uoZRVZmSfrqidlLNOhkIHDPJoJC3
	 utFvpj8ghJVowSGnlB57QR1V4M1W22XOEbU7wvl5FUztrdxLuN1L322EH5QQE49ofX
	 o9Ivk8XkN/SvXzSVGclTvJ1n+egjPz0eCLHWQAuPwOFkxO4exu1cUikXCF5rrB8dLr
	 t5nkXMVBzwJWvik/+k4/P+XMb95SyH37eT4p+tA1xIO7RPtZFAhDkfjRVLf8RNVQUv
	 hyfxyhBY1oZHJacBmfWXTlfmMHlxdpP7ZxBAoUumEoFhYMY661Nhllx8IX9KCHK8qs
	 7MPUrns95zUPA==
Date: Thu, 4 Apr 2024 00:15:12 +0100
From: Mark Brown <broonie@kernel.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Jani Nikula <jani.nikula@intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Robert Foss <rfoss@kernel.org>,
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
	Jonas Karlman <jonas@kwiboo.se>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Chen-Yu Tsai <wens@csie.org>,
	Samuel Holland <samuel@sholland.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-mips@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/7] drm/display: Fix display helpers depends on fallouts
Message-ID: <b0ac6a85-d40c-4360-a164-ef7f2518a508@sirena.org.uk>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="t5XS027i4Mgf+9A4"
Content-Disposition: inline
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
X-Cookie: Knowledge is power.


--t5XS027i4Mgf+9A4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:56:18PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here's a series addressing the various regressions that were reported
> after the Kconfig rework for the DRM display helpers.

This makes sense to me and looks like it does the right thing for
multi_v7_defconfig so

Reviewed-by: Mark Brown <broonie@kernel.org>

Between the arm64 defconfig update not applying on -next and unrelated
breakage on arm I didn't actually do a proper test.

--t5XS027i4Mgf+9A4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYN4v8ACgkQJNaLcl1U
h9APkgf+MD+F72G2etxjJQQnDLLpAUSedXzD9qG7v6PJcIYiQhEHyncENGiWMsro
JNXG/Uiuu7sJtoW9VqjSHeZynUGV610eWCnRx7iXGEzVWCsQwMsHgOZOXPMi/ygx
DHV5IEHQy9NXNdT5a+36vbujPacH1sJspLJ0b2Yp6blws16L4rbwk/jpKRckQA90
ZDtMRrlyWvK7/7gVjAfnHnu3bVFF2ZgQ6m7iP8wJOCVEd8U9T3tqAweFBREyNECn
HME9N5UtA1Ee3V1X2SVlvkC9HKEtky4u6ysnULdlNB2DF3i3VtopCMwrcT1AAOrA
SkNkR/WHG8F9KFz2/dh84C0Oug43EA==
=0WKT
-----END PGP SIGNATURE-----

--t5XS027i4Mgf+9A4--

