Return-Path: <linux-kernel+bounces-151094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2D28AA906
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 09:21:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87DBC2821F8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 07:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314183F8F4;
	Fri, 19 Apr 2024 07:21:16 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2AC3F8D0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 07:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713511275; cv=none; b=JpmJwb94HJC65Ma5LES3qBcqFOf+eCkyzjqhLfLBEKXsoOkdbCGvwvSUycCZeXHAOF6iveypEC1Hk75okPHaqZrO0IsKAh9tW61q99fuSdxI2+p0v8f+lT+UcL7vILXrjEwon4XjlAPr7wNqCaz1nxWHDhI9uCHt/b2duPQXhcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713511275; c=relaxed/simple;
	bh=mWDtogvZLAf/AlEynocjUm/6fKyp2NK1loMWsuL/Gpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jc1UL93AJIu2vefX1sorLuO5Ioyf9nCjyYmtYIvcCrZySrRHKwNKYbmldk7sREdIZ+LLU1yCXmteTbSlAT8MVOKFANgv5xjB3vkdHtPMrjHocq/BdelhbrK2QVXzMeXVRwftAh/5m+dt5/l2LwO/bQedao/nioC6S3ADyismrV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxiYB-0005ps-9Y; Fri, 19 Apr 2024 09:20:47 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxiY9-00D7BW-2B; Fri, 19 Apr 2024 09:20:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ukl@pengutronix.de>)
	id 1rxiY8-003uPa-36;
	Fri, 19 Apr 2024 09:20:44 +0200
Date: Fri, 19 Apr 2024 09:20:44 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To: David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: Frank Binns <frank.binns@imgtec.com>, 
	Matt Coster <matt.coster@imgtec.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	Chun-Kuang Hu <chunkuang.hu@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, Thierry Reding <thierry.reding@gmail.com>, 
	Mikko Perttunen <mperttunen@nvidia.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH 0/4] gpu: Convert to platform remove callback returning
 void
Message-ID: <xqwcrxfrg3ogplh35c5etl6nbzw6zueilm4h6euh7bnpszyir4@6dtn5qdvijv3>
References: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zqtl7cbpfineoepn"
Content-Disposition: inline
In-Reply-To: <cover.1712681770.git.u.kleine-koenig@pengutronix.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org


--zqtl7cbpfineoepn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Tue, Apr 09, 2024 at 07:02:47PM +0200, Uwe Kleine-K=F6nig wrote:
> with some patches sent earlier[1], this series converts all platform
> drivers below drivers/gpu to not use struct platform_device::remove()
> any more.
>=20
> See commit 5c5a7680e67b ("platform: Provide a remove callback that
> returns no value") for an extended explanation and the eventual goal.
>=20
> All conversations are trivial, because the driver's .remove() callbacks
> returned zero unconditionally.
>=20
> There are no interdependencies between these patches. This is merge
> window material.

I wonder how this series will make it in. While I would prefer these
patches to go in together (that I can consider this thread completed in
one go), I think with how drm maintenace works, it's best if the patches
are picked up by their individual maintainers. I guess that's:

 - Frank Binns + Matt Coster for imagination

 - Chun-Kuang Hu + Philipp Zabel for mediatek

 - Thierry Reding + Mikko Perttunen for the host1x driver
   (Note there is another patch for this driver set at
    20240409165043.105137-2-u.kleine-koenig@pengutronix.de that is
    relevant for the same quest.)

 - Philipp Zabel for ipu-v3

I plan to send a patch changing struct platform_driver::remove after the
end of the merge window leading to 6.10-rc1 for inclusion in next via
Greg's driver core. So please either care the patches land in 6.10-rc1
or ack that I include them in the submission to Greg.

Thanks for your cooperation,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--zqtl7cbpfineoepn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmYiG0sACgkQj4D7WH0S
/k5uYwf/bmP6h2EDhf4HeD6t6iH04mtOMqGj0P+x7unUIW9fwa+06Vtnjj0TW/DR
WgWu8rFS3I02j3D51b14SGZRNrIEXwSkNNVQLPZbe8pu9akVVYtymL7xxNM4ksLk
83PrwKdtdx2khdWfc7kOWM+zu2IkKTkHvRQqrx/jCrz9OpAA+2DJpqtt0CnYOMgu
eF4ev9d7wG7VdP8jks1/anWuqbDAIVStCnA1MaCISsXl2e2ZGZfSE99Mg1h94eLd
AX2IRPASplCkOA1L2Klfkye65Pqyfi1gnxnawcUbhkcZ4ffdg7jFAEaCXPqfHEKP
w+LYkIVZlBBGdz0EuoGrVlGwPo7Ixg==
=stkl
-----END PGP SIGNATURE-----

--zqtl7cbpfineoepn--

