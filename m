Return-Path: <linux-kernel+bounces-63544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E09853109
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D193EB24A61
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3684C482FB;
	Tue, 13 Feb 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="PC2o7VK+"
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E633C490;
	Tue, 13 Feb 2024 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707829123; cv=none; b=DGop41xxoSyjLUpQ08XiigcijyOXf3AuccJJfPNONse6QeMCWlJq5euedc4mmemEdhcxfni0tMrViUYAf2ifh/sTporE9mifavgBgata4d0H6uZudoLf9DdrKVw482LszkL+C5fFq3dSMHnIj5INTM98fd5D4VEnnOheEdF03eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707829123; c=relaxed/simple;
	bh=8aKCQmHWe7W7w4cdBjfprF7BEjuAl+nGvi4s02wY+14=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mK321rivEIN3QWHnppUqXcfFBcT6S6OeKmncIj3A5t/rfS5WIXe5kp30G6lfw8QDCBfjhS54a3acfyLjGjuO6kI8WmgNtpjbRr1JQzilAen2F4lo8yYPlJWnOpd3tpjY7rou/dhk2ql1LhXIPqBHqf2177qY6AxOZkZvq/BfvUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=PC2o7VK+; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from localhost (unknown [IPv6:2a02:8012:909b:0:eaae:9bde:cb7b:6924])
	(Authenticated sender: tom)
	by mail.katalix.com (Postfix) with ESMTPSA id B20027D5C1;
	Tue, 13 Feb 2024 12:58:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1707829120; bh=8aKCQmHWe7W7w4cdBjfprF7BEjuAl+nGvi4s02wY+14=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Disposition:In-Reply-To:From;
	z=Date:=20Tue,=2013=20Feb=202024=2012:58:40=20+0000|From:=20Tom=20P
	 arkin=20<tparkin@katalix.com>|To:=20Samuel=20Thibault=20<samuel.th
	 ibault@ens-lyon.org>,=0D=0A=09James=20Chapman=20<jchapman@katalix.
	 com>,=20edumazet@google.com,=0D=0A=09gnault@redhat.com,=20davem@da
	 vemloft.net,=20kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=20corbe
	 t@lwn.net,=20netdev@vger.kernel.org,=0D=0A=09linux-doc@vger.kernel
	 .org,=20linux-kernel@vger.kernel.org|Subject:=20Re:=20[PATCHv4]=20
	 PPPoL2TP:=20Add=20more=20code=20snippets|Message-ID:=20<ZctngNzLYe
	 /+Iman@katalix.com>|References:=20<20240212222344.xtv233r5sixme32h
	 @begin>=0D=0A=20<ZctJnCeUCANJvxGj@katalix.com>=0D=0A=20<2024021311
	 5304.3oyqkvkb3oqkauwd@begin>|MIME-Version:=201.0|Content-Dispositi
	 on:=20inline|In-Reply-To:=20<20240213115304.3oyqkvkb3oqkauwd@begin
	 >;
	b=PC2o7VK+pdQcwYecedvvUXAqJZqbT1Wyw9PKS4f0OmBIKD3C7N9R35HH7t49gQ3TU
	 NLMHjXHfYjIIm1YCRVW/wsW8flkgJ0hVUMF4bUTyCGQ9I9DSR4Wtw1zHEOXGCoqhuQ
	 vzBQAr9FtNFrLQkSHydEFMam5O2Q9xvRWUbazeGk6GpV6c2SNG0+w9WmDpZPJlBtNG
	 vXa0l5930XvXIC04ii8Nir67n2h5sE6FrR86GusTELOD1ofTCsYz365csyKsKwTz8e
	 pK2x9mTlxCtcdH9i3zsfCG0DR6tGeU7jPyn9Sh9gyhgo/ft3lyOrVrsi0gDdW+xyfz
	 Dzf2FbwYktyeA==
Date: Tue, 13 Feb 2024 12:58:40 +0000
From: Tom Parkin <tparkin@katalix.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	James Chapman <jchapman@katalix.com>, edumazet@google.com,
	gnault@redhat.com, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, corbet@lwn.net, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] PPPoL2TP: Add more code snippets
Message-ID: <ZctngNzLYe/+Iman@katalix.com>
References: <20240212222344.xtv233r5sixme32h@begin>
 <ZctJnCeUCANJvxGj@katalix.com>
 <20240213115304.3oyqkvkb3oqkauwd@begin>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="G2qaJ+yw4/XCnyb6"
Content-Disposition: inline
In-Reply-To: <20240213115304.3oyqkvkb3oqkauwd@begin>


--G2qaJ+yw4/XCnyb6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On  Tue, Feb 13, 2024 at 12:53:04 +0100, Samuel Thibault wrote:
> Tom Parkin, le mar. 13 f=E9vr. 2024 10:51:08 +0000, a ecrit:
> > > +        ret =3D ioctl(session_fd1, PPPIOCGCHAN, &chindx1);
> > > +        if (ret < 0)
> > > +                return -errno;
> > > +
> > > +        ret =3D ioctl(session_fd2, PPPIOCGCHAN, &chindx2);
> > > +        if (ret < 0)
> > > +                return -errno;
> > > +
> > > +        ppp_chan_fd =3D open("/dev/ppp", O_RDWR);
> > > +        if (ppp_chan_fd < 0) {
> > > +                return -errno;
> > > +        }
> > > +
> > > +        ret =3D ioctl(ppp_chan_fd, PPPIOCATTCHAN, &chindx1);
> > > +        if (ret < 0) {
> > > +                close(ppp_chan_fd);
> > > +                return -errno;
> > > +        }
> >=20
> > I think we should drop the PPPIOCATTCHAN ioctl call here.
> >=20
> > The input file descriptors are called out as being PPPoX sockets
> > created as described earlier, in which case they should both
> > already be attached to a channel.
> >=20
> > It would make more sense IMO to call out the two ppp_chan_fd file
> > descriptors as being input parameters alongside the PPPoX session file
> > descriptors.
> >=20
> > > +
> > > +        ret =3D ioctl(ppp_chan_fd, PPPIOCBRIDGECHAN, &chindx2);
> > > +        close(ppp_chan_fd);
> > > +        if (ret < 0)
> > > +                return -errno;
> > > +
> > > +It can be noted that in this case no PPP interface is needed, and th=
e PPP
> > > +channel does not need to be kept open.  Only the session PPPoX data =
sockets need
> > > +to be kept open.
> >=20
> > Is it true to say that the PPP channel file descriptors can be closed
> > by userspace?
>=20
> In our code we do it
> https://code.ffdn.org/sthibaul/l2tpns/-/blob/kernel/l2tpns.c?ref_type=3Dh=
eads#L1295
> and it works all fine indeed (and avoids that fd per session).
>=20
> That's actually one of the reason why I made the snipped only take the
> pppox sockets, and make it create the ppp chan fd only temporarily. AIUI
> the pppox socket already has a ppp chan (returned by PPPIOCGCHAN), and
> the ppp chan fd is there only for performing the bridging ioctl.

Thanks for the code reference -- that makes it clearer.  And I'm glad
someone (else) is using PPPIOCBRIDGECHAN :-)

It's a while since I was looking in ppp_generic.c and you're right
about the ppp channel fd.
--=20
Tom Parkin
Katalix Systems Ltd
https://katalix.com
Catalysts for your Embedded Linux software development

--G2qaJ+yw4/XCnyb6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEsUkgyDzMwrj81nq0lIwGZQq6i9AFAmXLZ30ACgkQlIwGZQq6
i9DYkAf9GOhgqPlIofeqsI0xOlcmwUwi/8tE99f4HV85ghT242yIB66IYVCyGijG
L5llsSOJ+d3cjw1/FrDAOFWuPira89FijTidj5ZgXApkGpHZo6Uomq/jYjNLXMh/
cWqbMo53t2EMrwUgl804vkGAXQ5H9mIkuDGMegjO/Ld3pTDWstwwQWcZZBmUb33f
116FyZcPNDzXmLvSDi7EBQBoXdZOXcXEaJl9XZZXgGjWrBzcKvs2Ed/emRKUUGRI
ItlC1udf1eJ4RijloRzOUykwwigd/DdNEqb2xocrhQPnhFLBc2/Qj1iHYJYsMj24
+U6BGaqqzeVjSqLucUAjj0zKFsOeOg==
=+am9
-----END PGP SIGNATURE-----

--G2qaJ+yw4/XCnyb6--

