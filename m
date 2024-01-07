Return-Path: <linux-kernel+bounces-18927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D18826540
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 18:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29CFC2810F2
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 17:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBEB713AE4;
	Sun,  7 Jan 2024 17:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="L+WlE/vV"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E8F13ADE;
	Sun,  7 Jan 2024 17:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 6EAFC28B53B;
	Sun,  7 Jan 2024 17:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1704647080;
	bh=+D2bVZyjV2n3god9rjHq+Xi5S7UKeQSid5K8Mg1COlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L+WlE/vV3Dg0ITCIJA7gljoY5p+eBINLaJpK0DGCBNEX4LdoE/Sp0A2HsBAs5QDFq
	 +CaBmelB6NQu0+m553pGuh3HvvtENNsTz/qX/0CtWdJBegYK9q/Ktwyk+oJM3yrCLH
	 jPK1t65zDN0nBKJfPLMpaQHW2bosBjzx7g+Avk5w=
Date: Sun, 7 Jan 2024 19:04:39 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 1/1] tools: iio: fix iio_generic_buffer
Message-ID: <ZZrZp4VNdmBzA4lR@sunspire>
References: <20240104101253.25896-1-petre.rodan@subdimension.ro>
 <20240104101253.25896-2-petre.rodan@subdimension.ro>
 <20240107155333.0e43b041@jic23-huawei>
 <ZZrRRNTUbXaDIgRU@sunspire>
 <20240107170026.6baccc49@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="h7AGFP2sAjLPuOv5"
Content-Disposition: inline
In-Reply-To: <20240107170026.6baccc49@jic23-huawei>


--h7AGFP2sAjLPuOv5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Sun, Jan 07, 2024 at 05:00:26PM +0000, Jonathan Cameron wrote:
> > On Sun, Jan 07, 2024 at 03:53:33PM +0000, Jonathan Cameron wrote:
> > > On Thu,  4 Jan 2024 12:12:45 +0200
> > > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> > >  =20
> > > > Fix code flow problem and floating point exception caused by improp=
er
> > > > directory stream positioning.
> > > >=20
> > > > Fixes: <e58537ccce733> ("staging: iio: update example application.")
> > > > Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro> =20
> > > Hi Petre,
> > >=20
> > > This doesn't really explain 'why' seeekdir(dp, 0) is wrong.
> > > My assumption is that telldir() would not have returned 0 on this par=
ticular
> > > system?  Could you confirm that and update the message to explain why
> > > seekdir(dp, 0) is not equivalent to rewinddir(dp). =20
> >=20
> > it looks like there is a 32-bit specific bug in one of the glibc patche=
s that
> > the stable Gentoo Linux is using [1]. telldir returns (u32)(-1) if seek=
dir is
> > used which ends up in a floating point exception.
> >=20
> > it so happens that the rewinddir() function (which is equivalent) works
> > correctly. so it is a fix for Gentoo users and should not impact anyone=
 else.
> >=20
> > [1] https://sourceware.org/bugzilla/show_bug.cgi?id=3D31212
> >=20
> > my very best regards,
> > peter
>=20
> I'd be happy to take the same change as a cleanup if you want to resubmit=
 it
> with a different patch description.

sure, I will resubmit it, but tomorrow morning.

best regards,
peter

--h7AGFP2sAjLPuOv5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWa2acACgkQzyaZmYRO
fzBFIxAAkYFjUkr27o/sG18/liGK3WV9HqanIAI5hnU8vmBAyJhG50zekJX6Golc
6WXi4VLWHn1ZpItx6Bw+3+G3k0kPD6UvfcbQ5tyKcc46Klby7ZEuSASWQdSD6IVQ
XhBbyg4WQfrALh2EOdR5CnAZDMMDXU0zaGMcNEAUXoQPlWszZzCA9x+jYUR7B5l7
UCOTgPwlSgNN2T4kBjUFOKsCYR8SAueAHxh7tQnwBDmAAwD1Cd1yWXDEd1osA8kK
kibl3R6mNroH90jM0X8sW4++hx7sY4pZL5sHE+jyhtn/Um7jyFP2jrFq9eLirGFd
fUMiwJ5u4X+Op95ZnK6RTVFG5nKs5awJ7Pi1kj3HrcomDZsXMWDUfK/aOJWWGu8b
trJ2zlSgpQLJZgEvwNb97eIF3tyEWyFRehSegCbrwzJPs9HifTa/0nvkYLs7JPUo
mcEi14I+PnwqMVhVCmNbV8Q4hg+qgSY4tzG5HmH4qnjViZy6DeqQlLvgeeAUkeBl
y7L9mtZgRPq6RRJOj6dVmqVJDOedQEGZguUXqphN7v7LHJ8grzb1iooxA+PApkhM
hzlDsQfmzMhqq9Pkh1MiuQEArW8ZeKAuWz6RyFMKRyiUazlnby87WBFqgeTl0774
HhiB352idWW02TLWmgMGHBjlGuS/w5fr+XC9JiJ4D+JzJg2b3X0=
=d7Ch
-----END PGP SIGNATURE-----

--h7AGFP2sAjLPuOv5--

