Return-Path: <linux-kernel+bounces-110334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF49B885D5B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:25:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD7871C216D8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160D912CD8F;
	Thu, 21 Mar 2024 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zwl1hCY/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567BD23778;
	Thu, 21 Mar 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711038301; cv=none; b=pHwkvX5zLcQPoyTXtnOKqUqbAywZm2p1p+XGfV2E4vw9IOGzbgcnAM4YS+bVgjkfN7V97yAgqdjsivmVmzwP9g9XPL3v7Zg1k/pRP+RqbpB944wPQtYXAVgl+x48sKApiuP8WKKstknOWe2NpJaLaVNojj3YDrktSn32lLzfct8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711038301; c=relaxed/simple;
	bh=ogc/U6YBTmcb0BC3PL0tlRW7N+zLZ+qmeYO8A+GuUJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMjffJUqm7y3uxIiTQUx36oe8BfEBdzGdf+6Ek4fdlXYHISWs5gobBMVjsRKqVPLcSYuY8fgC65ptygGywMw6u5uh4T61YheJZznthK8IJfvKfRumsSQGeY87MgqTJNAoZBC15meuiZu1MH8FJBUBFps/CkdOJN9dKKKnT6BA+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zwl1hCY/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAFBCC433C7;
	Thu, 21 Mar 2024 16:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711038301;
	bh=ogc/U6YBTmcb0BC3PL0tlRW7N+zLZ+qmeYO8A+GuUJM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Zwl1hCY/3Q5C+aesvtYbUBMjYMpGrWG/uiQCilI8ysGe6Q/8ZcAZzpetMacQ991U8
	 Y9IC0utl6SJMnak51fdEygBjIYUYms3VR2ZFBnd3kDNj2KHGdXfInl3iTgb7LIMOst
	 CCnNgUpOyLR+dUY4jHk1sfltTr1cGdMSmUNhTUcVBe33L+5a8jU4hbypPJT8Atf6JJ
	 EQi8g0MKwBv0lp9+oDpTUemckCfhBqTvzni+6aObQtIMME9QFk0VuH6r6DDjBQjMqi
	 Dv5OzsKp9siW1+GYB1AbC+4npmqz802j2LIUmk7DcLf5HUNw+aLpwRWfVXurIGZzJ5
	 Bgaya0n5FikcQ==
Date: Thu, 21 Mar 2024 17:24:58 +0100
From: Maxime Ripard <mripard@kernel.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Frank Oltmanns <frank@oltmanns.dev>, Chen-Yu Tsai <wens@csie.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Samuel Holland <samuel@sholland.org>, Icenowy Zheng <uwu@icenowy.me>, Ondrej Jirman <x@xnux.eu>, 
	dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: tcon: Support keeping dclk rate upon ancestor
 clock changes
Message-ID: <20240321-faithful-caterpillar-of-health-52d87f@houat>
References: <20240310-tcon_keep_stable_rate-v1-1-0296b0a85c02@oltmanns.dev>
 <20240314-careful-silky-bear-8ee43f@houat>
 <5448341.Sb9uPGUboI@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5hh7c6ibu6zg4s6a"
Content-Disposition: inline
In-Reply-To: <5448341.Sb9uPGUboI@jernej-laptop>


--5hh7c6ibu6zg4s6a
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 06:20:58PM +0100, Jernej =C5=A0krabec wrote:
> Dne =C4=8Detrtek, 14. marec 2024 ob 15:42:24 CET je Maxime Ripard napisal=
(a):
> > On Sun, Mar 10, 2024 at 02:32:29PM +0100, Frank Oltmanns wrote:
> > > Allow the dclk to reset its rate when a rate change is initiated from=
 an
> > > ancestor clock. This makes it possible to no longer to get an exclusi=
ve
> > > lock. As a consequence, it is now possible to set new rates if
> > > necessary, e.g. when an external display is connected.
> > >=20
> > > The first user of this functionality is the A64 because PLL-VIDEO0 is=
 an
> > > ancestor for both HDMI and TCON0. This allows to select an optimal ra=
te
> > > for TCON0 as long as there is no external HDMI connection. Once a cha=
nge
> > > in PLL-VIDEO0 is performed when an HDMI connection is established, TC=
ON0
> > > can react gracefully and select an optimal rate based on this the new
> > > constraint.
> > >=20
> > > Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> > > ---
> > > I would like to make the Allwinner A64's data-clock keep its rate
> > > when its ancestor's (pll-video0) rate changes. Keeping data-clock's r=
ate
> > > is required, to let the A64 drive both an LCD and HDMI display at the
> > > same time, because both have pll-video0 as an ancestor.
> > >=20
> > > TCONs that use this flag store the ideal rate for their data-clock and
> > > subscribe to be notified when data-clock changes. When rate setting h=
as
> > > finished (indicated by a POST_RATE_CHANGE event) the call back functi=
on
> > > schedules delayed work to set the data-clock's rate to the initial va=
lue
> > > after 100 ms. Using delayed work maks sure that the clock setting is
> > > finished.
> > >=20
> > > I've implemented this functionality as a quirk, so that it is possible
> > > to use it only for the A64.
> > >=20
> > > This patch supersedes [1].
> > >=20
> > > This work is inspired by an out-of-tree patchset [2] [3] [4].
> > > Unfortunately, the patchset uses clk_set_rate() directly in a notifier
> > > callback, which the following comment on clk_notifier_register()
> > > forbids: "The callbacks associated with the notifier must not re-enter
> > > into the clk framework by calling any top-level clk APIs." [5]
> > > Furthermore, that out-of-tree patchset no longer works since 6.6,
> > > because setting pll-mipi is now also resetting pll-video0 and therefo=
re
> > > causes a race condition.
> >=20
> > Workqueues don't have an upper boundary on when they execute. As we
> > discussed multiple times, this should be solved in the clock framework
> > itself, not bypassing it.
>=20
> I think TCON code still needs to be touched due to clk_rate_exclusive_get=
()
> calls which effectively lock whole chain. You can't have both TCONs locki=
ng
> rate on A64 for this to work correctly.
>=20
> What was original reason for clk_rate_exclusive_get()? I forgot already.

IIRC, it was because the D-PHY and DSI controller derive from the same
clock, and we needed to make sure setting one wouldn't affect the other
one.

Maxime

--5hh7c6ibu6zg4s6a
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZfxfWgAKCRDj7w1vZxhR
xfv3AQDxIiMi1g+0nI7JKGoqxMzWuC13RajfFCHNbQGYsy0IBQD/XJHBNS4oJzSG
eOlBThbUoxtCgz90wXUf/Plufp64XAE=
=F9E+
-----END PGP SIGNATURE-----

--5hh7c6ibu6zg4s6a--

