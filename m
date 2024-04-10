Return-Path: <linux-kernel+bounces-139167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C5B89FF65
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 15366285EAF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 18:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0066717F395;
	Wed, 10 Apr 2024 18:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lu35qvDv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D81168DC;
	Wed, 10 Apr 2024 18:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712772409; cv=none; b=cvVhkt10WA5E3n8qKxX3rqMgOO4Bj3zTqjq9auucAgElsxEt8UaaV8rC8ndsFiSUxeR1BuL+B2NOJKKKkJaa38RCpFG9gZXhniZeyTLxAWK2qD6p5y1aECBaBTWJjnu6rpBPdJXCW5eBMYKW/uw1tOAyVjta13wN/WjEITaT4oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712772409; c=relaxed/simple;
	bh=9mHUvsMCvHI/lEf3R28H/lWIRLZtajg6D7uHi+gu8Xc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r8twqME6l/et37TLPfTs6QuxMvdt9P7kS9QlHkHZQK5g3sTCXs18LZdJCpCm1C9ZsnC+Z7yMWO6hrVQ94ALN3IGiPd0ZragT3bzos3XeOIH9i7FJdO7olABbuziAvCSPq9TXbf+QPPnyMeuAnC6lht+uRU2wkN3nUb2HVeARjZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lu35qvDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55443C433C7;
	Wed, 10 Apr 2024 18:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712772408;
	bh=9mHUvsMCvHI/lEf3R28H/lWIRLZtajg6D7uHi+gu8Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Lu35qvDvmqNkvq1o9nxg+w5hL5Uh7lDNWfNvkA5+kkFTIkp1zcQ2dCvhQ7Bmyxiky
	 srIkPzXyQsbllzfitfQ3qBA04frMons8w+N3qunJ0qiyagfuyd8VP3Wuf7DsDyJCX4
	 sADFRrR0lpwBWt2T/VQjb2jupa0lm1/2y1SDR5He9xfnB53rtkenMoKQxAXzpQxaIg
	 g/QgpMxZFgNPTpg/nPfDmiJRljqUaN2o19G9m8w1lUwu/8qPu2foYaJ0CJBQaut8gi
	 mhsGnnBNyndkfB8TLRrdqBenQDhN1PWT6Wo8fCofnQbnBcmDG7c1G0chPGnp2afnGE
	 5WTuil65Gnjfg==
Date: Wed, 10 Apr 2024 19:06:39 +0100
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
Message-ID: <117b0d3b-a60b-4bc0-9f2c-f0e4fffe634a@sirena.org.uk>
References: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m8uHuXe8Pt8zgPJR"
Content-Disposition: inline
In-Reply-To: <20240403-fix-dw-hdmi-kconfig-v1-0-afbc4a835c38@kernel.org>
X-Cookie: A bachelor is an unaltared male.


--m8uHuXe8Pt8zgPJR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:56:18PM +0200, Maxime Ripard wrote:
> Hi,
>=20
> Here's a series addressing the various regressions that were reported
> after the Kconfig rework for the DRM display helpers.
>=20
> Let me know what you think,
> Maxime

Is there any news on getting the rest of this merged?  It's been more
than a week now and the Designware display controllers are all still
broken in -next, causing widespread breakage in CI.  For bisection
purposes it probably makes sense for the defconfig updates to go along
with the changes to the Kconfig for the driver...

--m8uHuXe8Pt8zgPJR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmYW1S4ACgkQJNaLcl1U
h9DOSwf/cU2i83arQzeCO07s0n4/uba3xhNrWfvc7xN0GLO+Z8KtAnVQfRMhXF5j
ayRYwyjGMYcJmGugvdeX68HEbnVSq3PF1F0CSIjX4ElPZ9S7Wbiik4vnL45HJP6c
IveEkj+HqtAvILP5/07YrflUuqawBsUKDiELWs2p8AqwcpiDy4j6sMJpPZd6n9gf
9GzlZ5KCvzOua+GmCz9skxnIsXwSIB2HQ2y2zA0hyBbte7XjFFBUE36JW/kSt4z5
eRZ8AW4MG2hO6f/x965L+SShk1aLPhnYQXx/683Eu5MhYCGzGW7XPuGQDJJ1rAZU
YkvZX/nVERJeD10LMsjYYPcH/8N8Cw==
=swV+
-----END PGP SIGNATURE-----

--m8uHuXe8Pt8zgPJR--

