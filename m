Return-Path: <linux-kernel+bounces-164200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A418B7A94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD3F28484B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 14:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59877770F6;
	Tue, 30 Apr 2024 14:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GgzQV106"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B391527B9;
	Tue, 30 Apr 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714488706; cv=none; b=fFf+uOLyCFxXhdZWIdNG1dXbm43cn/LI5Uqrm5j6ENW54ygcV0wtyMjft+99zx08OFRzDhMAOg6bjFvudDiFOgA9Af3RFtbFEa49gZE9YeNYnUnQZ5F2hXGCr7zJWvMbTDzrKTR+SpoJOQ97g/l1/24OrBkowj5mHV0OergfRhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714488706; c=relaxed/simple;
	bh=VkBczN6vc3cL1DqDdpVd8so2a0Z4qxdElkNqtL0YXM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUgQd81Vzwcg+SLjBfK+IwFd28MX+p3W2NvIJSrP3Y8TmkKQMuB03C+n4+vFB2M8bRM6eQwcTODLnafsbfrAknStLd2xaRA2y8BfS7yvu3qkqkPw+JGQdLTZ2Mv9Cxf1zkdgfMc0Pjmsa0CMLibXnAORvYDZ1SMlev0ey6zYvmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GgzQV106; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714488703;
	bh=VkBczN6vc3cL1DqDdpVd8so2a0Z4qxdElkNqtL0YXM8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GgzQV106tzQb9rf4l28TmhiSbBG1PrGtNKpm77lmHW9JAAciI+Uizwmz/54aWCzi9
	 DRW4s4pUhSlAdBlRYJc2WYPylyZRxnfQIhMjmsEJlmfsCHVxT9nbrNmGM7HU+c9Ebu
	 qTnTyZUNnBPfXtA6MMvfqekwS01qcSvltG1gB+V03Y5v3W4IXUsUv1Tb+IVCLBJKfF
	 tWHv/Wrors7Zlqc1up87IL1Az9tmloF/0aNRA2ejNydP0ti7wGzFHy3XlGGurzBvMv
	 bB4Lv1jgBqZZHRyivpxD1/eQy6pzn0W8E119CHeakpzuXwAWYuJW/lvLHbp3sQ9EBW
	 MAHUyVPNZN3ag==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4F5E93781116;
	Tue, 30 Apr 2024 14:51:43 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id E4459106074C; Tue, 30 Apr 2024 16:51:42 +0200 (CEST)
Date: Tue, 30 Apr 2024 16:51:42 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Conor Dooley <conor@kernel.org>
Cc: Herman van Hazendonk <github.com@herrie.org>, benwolsieffer@gmail.com, 
	chris.chapuis@gmail.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: max8903: specify
 flt-gpios as input
Message-ID: <n7mahydeipds3zwynt73gpfrujsu54yo7xwztesqrxem7eumqk@7wa6nhm6iyfc>
References: <20240415151645.1986014-1-github.com@herrie.org>
 <20240415-pretty-recite-127842ed9a10@spud>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kbkpobocfrmnoio4"
Content-Disposition: inline
In-Reply-To: <20240415-pretty-recite-127842ed9a10@spud>


--kbkpobocfrmnoio4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Apr 15, 2024 at 05:28:22PM +0100, Conor Dooley wrote:
> On Mon, Apr 15, 2024 at 05:16:45PM +0200, Herman van Hazendonk wrote:
> > The FLT pin was incorrected documented as an output. The MAX8903 uses i=
t to
> > signal to the processor that a charging fault has occurred.
>=20
> I guess this is just a matter of framing? Input to the hardware running
> the OS but an output from the max8903?
>=20
> I'm okay with whatever wording causing less confusion, which may mean
> something that specifics what this is relative to?

well, this definitely improves things, since the other GPIOs
=66rom the same file are all described with the hardware running
the OS being the reference. So this makes things at least
uniform.

> >=20
> > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
>=20
> The SoB email should match the from email fyi.

It does for this patch, so I took it.

Greetings,

-- Sebastian

> Cheers,
> Conor.
>=20
> > ---
> >  .../devicetree/bindings/power/supply/maxim,max8903.yaml         | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/power/supply/maxim,max89=
03.yaml b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> > index a8d625f285f1..86af38378999 100644
> > --- a/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> > +++ b/Documentation/devicetree/bindings/power/supply/maxim,max8903.yaml
> > @@ -34,7 +34,7 @@ properties:
> > =20
> >    flt-gpios:
> >      maxItems: 1
> > -    description: Fault pin (active low, output)
> > +    description: Fault pin (active low, input)
> > =20
> >    dcm-gpios:
> >      maxItems: 1



--kbkpobocfrmnoio4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYxBXkACgkQ2O7X88g7
+przphAAmaIqDY/WTyoDrG4eVz+4nPwkoXsmLn5DcsIDmsxgNosLseuOK0xOP35a
FyUdDJ9M7gaEMBtfDUdaByTH6hyluAFh3ke5ty8xFKz2PkTXXbnWwApkr3tNWdvB
b9ZwUrrf+8KnJGkZ1WI9vCUIkI6ZKD6++4QIquf2TCBTo8cII1V3czpFw/6yze5O
NJRqK3FOnNLpNqxmJPiohSF0kgQo0gS1qLx2E7lEaxYPMgA9W3OAEQ1gyUOgrgvV
IA0XCvy4diimF9dnkxSHVNU1mxEamisSzPNaV3EPAUEbgVvGNwbmnDnYNrYaRN8Y
Gr+YjQm33HomVAi6oSNr4qx5S2wH52ukCZ2adUdx7tG3vWsl/uMfXYGIKQo+5/Hu
7yQq144WSD4tDv/63yrc9lBQAx8BWvrDjY2iqHworUY+Jqp+57k7teXiCbmhlKCp
bNF6PN//mcdQRjc3JTqavWftaqMOqaGF/WewCu4Ea6a2nWcCY4CDdY5hgVceRVF6
2f0B1qzuMxTpB8X1LQpqXzn6UJZyNlIwDxgh9mXZFXWeA2KjtSOcKS5Z7ilH8iSw
f/BUFqdDXPyWNazhcdvATxLACqftxybTnb6kAYLY1xETjikCQmqfbtQIV6jUKFXm
uaehvHjIFWHiOlED4XKK9s+ymuJVcbidKzpHK8Jpq+lPJItsqPk=
=82dK
-----END PGP SIGNATURE-----

--kbkpobocfrmnoio4--

