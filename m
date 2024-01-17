Return-Path: <linux-kernel+bounces-29024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC79830721
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 182FD288628
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 13:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCF31F602;
	Wed, 17 Jan 2024 13:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="WqG/cYfy"
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D091F93E
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705498437; cv=none; b=qGF0IC9LoY5EQb+dgI6XgM+/Is0Kb80KXMkkzR7rZfpZsYvnaClJ3EGokfaIRAnfrakx8nU/NrYbeyZM1KAt3T4TjIdg8fh1ykCueo6L9waYGuk/S7krrOVNGHMt3n/UMv9wZLr4kINLuGTjlK/eG0PY0cqxh5C32kOSIAEB3Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705498437; c=relaxed/simple;
	bh=UuGDO1lyqxltJpJigP1D6FUEJ5ufFBGRIcN6zcBWCBg=;
	h=DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:From:To:
	 Cc:Subject:Message-ID:Mail-Followup-To:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z04CrbKKYFvj8Dqa7iAPuYTf3R8zOZqWcw9SfQ9SRg+i34VdIwayiypIcBhFhZD/K3ORMTrpUZPuxmQSmpHvZXGoZroKcO8rFmogqEAPUU5qoIsqNM6IsfWhlISMve0cTZuSWa9ETj5f2M4wZMndAUYALl5NsBQ4D1rxIuvMDr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=WqG/cYfy; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=j+/z
	k1oyP0DIGmWY/Ymmxrp820m0TdG3XCUMKbXxxXc=; b=WqG/cYfyYiWDoJerc38f
	w67UvjoDvt2U+wI0Tg39bNYR40H5zIxwqr8tEog2Sa2xZLYraYvNLeZ2ojmDB0dl
	7m0/X/OHalyQuLSfugnq/GcTQWXwyrGKjVoqtvVZ+KfPWUqjxNtda/mcRx2UWMrW
	1jjCVyGQ6NRvI/TUO7vqkEtDzzWL4JTa+hi2x5jVHoZwhx0ptcmgPruMBBptUYiA
	AiF/ttuCJ7iT1ySbANmXoRr5p+g/91AGJgMTbwws3R1+6VHsHjAZmtEtT4rK/pgF
	zj33HtTcKmQ7ROlePpk7z0OAld39pGUY3EYEnQAB9H9Z1Yqqcli0kLMeq/ei1IKc
	pg==
Received: (qmail 2759525 invoked from network); 17 Jan 2024 14:33:53 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 17 Jan 2024 14:33:53 +0100
X-UD-Smtp-Session: l3s3148p1@cRVKTCQPsM5ehhtJ
Date: Wed, 17 Jan 2024 14:33:53 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] net: phy: micrel: reset KSZ9x31 when resuming
Message-ID: <ZafXQS1_4fHpEzL0@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Francesco Dolcini <francesco@dolcini.it>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
References: <20240109205223.40219-1-wsa+renesas@sang-engineering.com>
 <20240109232838.GA3626@francesco-nb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="o+uq2DgmSJF8bKpv"
Content-Disposition: inline
In-Reply-To: <20240109232838.GA3626@francesco-nb>


--o+uq2DgmSJF8bKpv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Francesco,

> - Philippe, email address is no longer valid.

OK, thanks for the heads up.

> Therefore is not straightforward to provide valuable feedback to you
> now.

Thanks for answering anyhow.

> > +static int ksz9x31_resume(struct phy_device *phydev)
> > +{
> > +	phy_device_reset(phydev, 1);
> > +	phy_device_reset(phydev, 0);
>=20
> Is something like that fine?
> Don't we need to reconfigure the ethernet phy completely on resume
> if we do reset it? kszphy_config_reset() is taking care of something,
> but I think that the phy being reset on resume is not handled
> correctly.

If the interface is up before suspending, then suspend will assert the
reset-line. If the interface is disabled before suspending, then close
will assert the reset line. Deassertion will happen on resume/open.

So, unless I am overlooking something, my code does not really add
something new. It only makes sure that the reset line always gets
asserted before deasserting. Because in the case that the interface has
never been up before, there is no instance which could assert reset. Or,
at least, I could not find one.

Makes sense? Tests work fine here, at least.

All the best,

   Wolfram


--o+uq2DgmSJF8bKpv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmWn1z0ACgkQFA3kzBSg
KbYxJQ//YiEtiH+Msn59O98tHTnBrLaLiXG4UvgPdri2v9taDZJrHBkzfAxINtfE
58YzOaveDxfCs3Q+YdwsyhwTNaBlHe3jeMQjeiS6xABJIjlmYcuqcfdt+03xvFdV
zjMwnR8jH2wjDVbDBuzz2cQhQOaY9atsluMBe4z5tyKDecYs1WzH+/rLEmgjMdxU
zmPIGa8+XawTh7PCEn1448VsakTrSTOIRBlfkh0ppXV5C5t0wU4gdVd7aEPLb46o
8vmcbEFX6+uICU2yoUqKx++GGswWo5QF//wYTCwX6xhF9QoK5db9YnD30vp3I3re
x2hkuFMA3BNWLLLuPV8T7rr6sj2/c1d8Lby3drQhSrSHV6S2ffH8iYZWDP67syyr
Ar7xgImw/WLM4RQLrzlzY4vR10WQXNw23B3z4s5jPj1r0gegJAOdj3DC7pAVGByu
SOAy5LwITRqliE8B/+nLoJRF/DQqnoenk5RO2vwgkUoxGsdjHJ20NX9NJnw3u6g6
ceGEME6+smxdqgOj5UYCoQAP2puwNTo0V9eAFvQhouHg+3vPQjmwdhxpSPINaXbr
Kgm0ykfq3c5vGagWTKvhqnPhAt80ekDYBR9neIh0KdHj8I/hDugvydxGZKHpajQ3
z9RG2jjFbthPfnRKvegAafK49LkiOPcqjwQf6IalIkB3zf0foIA=
=MOoA
-----END PGP SIGNATURE-----

--o+uq2DgmSJF8bKpv--

