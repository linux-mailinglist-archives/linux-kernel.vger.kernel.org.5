Return-Path: <linux-kernel+bounces-37716-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4664C83B453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC566289C02
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F021135406;
	Wed, 24 Jan 2024 21:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="VMq1xbHg"
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3969B134743;
	Wed, 24 Jan 2024 21:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.107.74.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133382; cv=none; b=HqKH6XFBQSVW9Kg1modoNHeODKhJFA66fPMtfonUow5gu7LudNhOnbejGJFo9iws59CxblS1t7isQNsYgujWSCHOw9ZRPi4OChnUHQOcugEicQuvHB3yKwPnJjdBk3NzvhP8TCwwNRnb97asg8aosRioY7d+yA7fwft/d9FrU9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133382; c=relaxed/simple;
	bh=WZZ8Nj8txsejMqxZrzwHTQyuaWzKN0XJM7J8Ki/5nu8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KdbSJwtqrd/E6IvOBpqMU/vPjtJ3myTzqEB3OTXOWbGBE9pX2HCAHXQLB5WI1XCbFqgoVfQ3FFb5/qdBusBwN1j+F8NWFnUbiZOmVBa7e11PgzRrJfciYsrOvagMZ0aJgtWlwlqwl8jcyQ0WXedc/i73Y4LULtej5v8m8Q8sunI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au; spf=pass smtp.mailfrom=canb.auug.org.au; dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b=VMq1xbHg; arc=none smtp.client-ip=150.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
	s=201702; t=1706133378;
	bh=F6LfXeYpI9/QDoGYpZBbglp6gqzi9Qth5mg3ENYkJfs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VMq1xbHgywaKbK2+jzej1Xe5mWK+0p2m6DCjoV9TKB5HRu1Yeg4A4LeAjxPuvgumC
	 TTzCdz/ZLMnrYYotDYuWzDmBdO1cFtcoB3YrtdJ4TmmRkuMoIcG3YRUGfTrf2/qjGK
	 ijxr6pmsFTzz9i+Q3802NoyORZlzZblDdg84ZtgHwg6msLO/PKKc/osinTDd0nWBjw
	 yKons/Tl9fm0VXLaPJgMd4cHgRchzKAm5ocsL0S9DpBBRRE6wppn4eAR6aWhtwlNaE
	 AMlRawCDw7nl43PgTYH6EG1eLE52VChGKneAq/b5B/89xyZXPn3EvIXTjr1kgn5R3t
	 OrZ8gJdW6J6aA==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4TKyTD0f91z4x2T;
	Thu, 25 Jan 2024 08:56:16 +1100 (AEDT)
Date: Thu, 25 Jan 2024 08:56:15 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Lee Jones <lee@kernel.org>
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, David Miller
 <davem@davemloft.net>, "Eric W. Biederman" <ebiederm@xmission.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Hector Martin <marcan@marcan.st>, "Jason
 A. Donenfeld" <Jason@zx2c4.com>, Jean Delvare <jdelvare@suse.de>, Micah
 Morton <mortonm@chromium.org>, Mike Marshall <hubcap@omnibond.com>, Pavel
 Machek <pavel@ucw.cz>, Theodore Ts'o <tytso@mit.edu>
Subject: Re: linux-next: trees being removed
Message-ID: <20240125085615.3cf579c4@canb.auug.org.au>
In-Reply-To: <20240124155046.GB74950@google.com>
References: <20240124130101.428c09a3@canb.auug.org.au>
	<20240124155046.GB74950@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vacaS5r54qcPnQDB8jXOInP";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/vacaS5r54qcPnQDB8jXOInP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Wed, 24 Jan 2024 15:50:46 +0000 Lee Jones <lee@kernel.org> wrote:
>
> > backlight-fixes		2023-01-01 13:53:16 -0800
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git#for-b=
acklight-fixes =20
>=20
> This is still active, when it's needed.
>=20
> > mfd-fixes		2023-01-01 13:53:16 -0800
> >   git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git#for-mfd-fix=
es =20
>=20
> As is this one.

Both restored.

> I'll update them both now if it helps.

That will keep them off my radar for a year :-)

--=20
Cheers,
Stephen Rothwell

--Sig_/vacaS5r54qcPnQDB8jXOInP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmWxh38ACgkQAVBC80lX
0Gwglwf+K0XyEY8ZpZJWp1i+RKTJqnEg+S/ahENZmmWP1Tp/wXIHLIsydnJmqpJE
QP1Ds1NpLCXgwJRFboFO/sraDTTODnwAEooIdAhbfBAOYUqd0THb7aMHM7XGdLcc
wVpTVcb/YvwUPVNgiUZhQxBvebwx9QQnLCWgM4qNo20/sblt/Hf8eJDT+HRvkECJ
CXyz+WYcjGBjr/LhnKxnXcPN7Tvq8N+ST4iWcuTlsq4eY7kAV5n23TMbXEUCgx7b
Maak9fWVJm774GLc2MQflLHO37Gcpr7Kj0L3BDiq3cVZeqUJUQjoCpAg0uU2DvN5
dv8gVq5suw5CaOIjMqRnGmPZisCqdg==
=raVj
-----END PGP SIGNATURE-----

--Sig_/vacaS5r54qcPnQDB8jXOInP--

