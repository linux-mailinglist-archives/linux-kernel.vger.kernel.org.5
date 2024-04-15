Return-Path: <linux-kernel+bounces-146023-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE488A5EEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 01:54:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB812B220A4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 23:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DFE1598E7;
	Mon, 15 Apr 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZL1hpYiq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07F71591F9;
	Mon, 15 Apr 2024 23:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713225228; cv=none; b=aY50IK6GX+EVjIUf3TzZQNnv9bFKEQwO6OAqfLs+FifVEbrH5H4LUNP9JYRRHLPB6uI3n446sfnj5CITOvySxatlX99/upcXwoLMrnvBmpEBcVoitLYvsaBXXJXnwhwzkIXbt8Bmzc/Y9aiHuTUh+h3hpgb7rVR4uScAOc0W4dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713225228; c=relaxed/simple;
	bh=Glti5hmyaExB5aURz0ZlgjDbYGJVM7NX72vmMzXnptw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hwHMwN0a3mumtyZkBOu5QpmDRk+Yln1khT0rT/roY1rM8R1AYejYT7lsINYGNZUlhLwCaWWJESOcb0Y3dNJ1IPFd/JMJLJJnfrjWytyXGVXOq0/RJYjrv3MoA7kPSlsK4bID0pNuYz1BenEIsIF+gVS6wtDHEnnTwLFBnY8RJIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZL1hpYiq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CAEFC113CC;
	Mon, 15 Apr 2024 23:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713225228;
	bh=Glti5hmyaExB5aURz0ZlgjDbYGJVM7NX72vmMzXnptw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZL1hpYiqFFDqEGcnDjrAmsFrlATUjRRZYpTwcmizOz0LFIFtZNFdvRy1mN1IFPBfc
	 WKhjgFdNYyuXRRIP7E55JZ15scpBAphhvGyqy01JkbCkAqyPNjaq/Rb3zgvOCRtMtg
	 U+b0hvgvCsCHj48SPclceOQU2PaC/XQX/WOL9tjvJzR7xiIZ2Py7xfsQAvhKmjezyg
	 GBuxyh0pQMfR2gkRe2josr74QsPhHNKT8doEeokNaAHLhNRpPBHW+yEiZZDgGC0b3d
	 D59ME0/rdlohUULjuEmzYZJ/jw3jcaRhYSrYHTXKtYYSnM33E4eOw99zTY4n6Y9uyH
	 f+/I59nHzeKmg==
Date: Tue, 16 Apr 2024 08:53:45 +0900
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
Message-ID: <Zh2+CZ2G9UOxcUaf@finisterre.sirena.org.uk>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
 <117b0d3b-a60b-4bc0-9f2c-f0e4fffe634a@sirena.org.uk>
 <20240415-sloppy-invisible-crocodile-da4545@houat>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hvR5IVqVtFxbshiT"
Content-Disposition: inline
In-Reply-To: <20240415-sloppy-invisible-crocodile-da4545@houat>
X-Cookie: You might have mail.


--hvR5IVqVtFxbshiT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 15, 2024 at 01:21:47PM +0200, Maxime Ripard wrote:
> On Wed, Apr 10, 2024 at 07:06:39PM +0100, Mark Brown wrote:

> > Is there any news on getting the rest of this merged?  It's been more
> > than a week now and the Designware display controllers are all still
> > broken in -next, causing widespread breakage in CI.  For bisection
> > purposes it probably makes sense for the defconfig updates to go along
> > with the changes to the Kconfig for the driver...

> I was on holidays so I've admittedly hoped that it would be picked up /
> reviewed by the relevant maintainers.

> Aside from the changes on sunxi_defconfig, I haven't seen any review
> from the relevant maintainers so I'm not sure how to merge this. Should
> we get an Acked-by from Arnd, Olof, Catalin or Will and merge everything
> through drm-misc?

Sounds like a reasonable plan to me - usually it'd be the SoC
maintainers for stuff like this but they're not on the CC, though TBH it
seems sufficiently obvious that I doubt anyone would mind if you just
merged things without waiting.

--hvR5IVqVtFxbshiT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYdvggACgkQJNaLcl1U
h9AFegf/bZsYaXP8tRkdBSjyeRExVkNbru80uysU+lEbQYvxVG8vF5HBon4Llvvy
FRg2q45T55EjATaU7/f1FDFJ3TVDtXnQ4bWRlx4dvbk5S4Hcb5XaoGmwatO6eHmX
rQz/hduFIKhwU+82v3ND/kJYfR1f9+8dvnCdL5TblWBG4o/p21dMWJKoAOlDkAzQ
Ygt03tBG4O46UgmwS8aPVSbv0ShId3zR/L9lYdIVvtQaK6a0CK7+5EIoS5emLKlZ
zeXN2qxSfzaUNhhGtJ3aD0Fa76bGjFeXB54Io6f8fPawV/QkDfaxIGFf9FG/G2gq
D7fQ+Bg6302L5j6cebEC3qW3tmxzdg==
=U8FE
-----END PGP SIGNATURE-----

--hvR5IVqVtFxbshiT--

