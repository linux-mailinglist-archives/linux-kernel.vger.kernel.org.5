Return-Path: <linux-kernel+bounces-162452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E43C98B5B79
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FAB24F3F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F2A7E0E9;
	Mon, 29 Apr 2024 14:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="T7ETfgio"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6217D414
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714401422; cv=none; b=RM1OJb5ibaBmNNIzSl/wRtFKq4OzBzYfA+4o4HFUTzKzmp5ZOYdyEotBr4yO3tXuYJvHySIhB/b745C5Oxgxq+LBnOZ7RaJQ0qNGl41D8g756b86CwyiJSlUWpudgFwUT34MI6ilOZmtAMG5q2Vw739C6MS7NYY1KGYzyiyhEIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714401422; c=relaxed/simple;
	bh=9AULpUPIsEI9vEbi6mqgK7op1H+nSt0H9BX16IiOSdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=arSxmuCQ6rwwvjz9P9y3uTfbiW4WysWJxF5EJeqVoOzKqETpXicV5oyGYDM35geRa9mamyJyuvezazfquZf5qCojifzvg9fMjBTJO8OxrsSof2xs9MoLmmif+qp0q1WpCDWFbgFEU5IiH6OyY/E4zhzz+YzzBtXDXD7zRZXdezk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=T7ETfgio; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=nsQ7
	wKeF/2+xzlzkg0zHsYh2TpvzB0TAt40g2qK/i3w=; b=T7ETfgiokiFpTz4I7/xn
	0vwPUK9UYzBEMzAS9Xz5Pne+zxkHNyBIkF0yK+9OwNXrjEcaADFV1vnPg0mLQTxk
	gtsIONiH2Y+dVL0BEHKFuh3Gg/+0Y3NZqAIXEKzgpkuo5VLP0rbv8ojGDz28M4WK
	7K+mic9e9yy4/8AUO+YcERK8+SfGbANFYPkFVBouudrowOxV6QtblLFw/ERl6N7q
	UU5OVb6/3eO7FD+9IMpNE1U3NNIQyKBlKn7n9KgXE9ukBj7YqhdmxpVJiZJRIEac
	aRK2rESbBkQ5x2MyNQR8rAxfFEE5WN2KUp5Chd6pSzz4BnaULOkXvnUIylM6ZgbS
	mQ==
Received: (qmail 2333844 invoked from network); 29 Apr 2024 16:36:54 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 29 Apr 2024 16:36:54 +0200
X-UD-Smtp-Session: l3s3148p1@Q39CLz0Xrttehhrb
Date: Mon, 29 Apr 2024 16:36:53 +0200
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Andre Przywara <andre.przywara@arm.com>
Cc: linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/8] spi: sun6i: use 'time_left' variable with
 wait_for_completion_timeout()
Message-ID: <2zdjok2qbu7rdltcx3mrjkmjypa5o6erhz2oehyn7eos2xplfq@zqiz55622isk>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>, 
	Andre Przywara <andre.przywara@arm.com>, linux-spi@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
	Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240429112843.67628-1-wsa+renesas@sang-engineering.com>
 <20240429112843.67628-8-wsa+renesas@sang-engineering.com>
 <20240429131600.4e910d8a@donnerap.manchester.arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="owbjl32fqgyjxt4w"
Content-Disposition: inline
In-Reply-To: <20240429131600.4e910d8a@donnerap.manchester.arm.com>


--owbjl32fqgyjxt4w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


> > -			if (!timeout)
> > +			time_left =3D wait_for_completion_timeout(&sspi->dma_rx_done,
> > +							      time_left);
>=20
> Nit: indentation is off here. Regardless:

Oh, right. Thanks, will fix!


--owbjl32fqgyjxt4w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmYvsIEACgkQFA3kzBSg
KbYu7g//cv4x7o5ryGJXj5UGdhNGshJvdxNFzAzasbQ2VEWDuyOMcaFWjDR55E7b
3aBQ97CN1ebQ8P066My5KsF9et/gCbuf4roQMStm1h+Gg6opjflWed4AD6R26GYe
Q0vioSFZI54unsRnpqzu+x8opHmong1Ll7Zqo0KBumRhjnWEvICt4qi+Cbvp2CEI
JyhEbSzPwzYq5z/gZD/sQ0tZ04N5HoVJq6PDQcYB3fqWJelnogSV+zXmGB9V9QOs
Su3mGR67avBDyBXZDJ3kgYjFxgANA6MHA/0rJ8RzZuJ47T1Ym0nwQszInKluvDZ6
lJeYzxQp+2763zHavhh0t3WXCkpjlUIHjDpvI3V+27Ajel1jQZUNj92WnXASV/Ax
J4Zu6QvUrFRpyVH/EBoXHKkgtLyw7ZxKCHssGcIjvX8NhuPL0w7Cf7nlSQgC/ZGW
fyRSGTUivCXkEkkEdfiU15JQAMl28YQdp/pWFxweufb6bo2iZpxICRECI+oERt1x
iRh5R7wOWBPf/9eN45oM9rEyHfUM4Dlgxc+190s11KZ7jgLPju8jvVdjWS93qeGK
wUorjuIZpYkGZhZ18eTDpbHQ6t7rxRQNGvP+ZYFOiUx/8X5wAoDieM6hhlUDovzE
u24n2dh+GNqlzY+6pZM8N/fnf1yhBkIsU0srbGd52SyKWoFdJ8Y=
=kx7a
-----END PGP SIGNATURE-----

--owbjl32fqgyjxt4w--

