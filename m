Return-Path: <linux-kernel+bounces-119063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84A888C38C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A49B12E1658
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B1E763E5;
	Tue, 26 Mar 2024 13:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BJy7hmsC"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7774420;
	Tue, 26 Mar 2024 13:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460076; cv=none; b=b8ZcNvCB6mBdNfL1m+/MV5im06u99u4AmoAb0tgUpEDkdF9AFo0Jd/iUADK7BK0aX4PGNQKqShe20RAAVs3LHqyDyY4BzYfEBy3YapH3wEnisDXiWHlJ2UaYxZrT79VW3xXb/0cc/JhLDeZgWFmqV8yBVf46clbqqQFF0ocDyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460076; c=relaxed/simple;
	bh=saMpjGv+bQgBnCl480rcaDTB14OCyzHI+ihNLlTUD1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7DUNHLHEe0MHfKM01/yKHKZVxw7dOP7te8to2MuaroEdN1oNCN0+XTTGwzSUowpcEaDPVyhJ8VHqcrXEsT13LlrQ0CfGGcl0zX0h+tTHfggDlUI1963dZMvPcOjISsbkrKW9IKSkQ1OkkEQerUS8yCjoSi6HiY7ntTCXEKAz/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BJy7hmsC; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1711460072;
	bh=saMpjGv+bQgBnCl480rcaDTB14OCyzHI+ihNLlTUD1Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJy7hmsC8MJyBaldIPgB7UZTyxmjYuG4IPIFWTYnAv5l6Moo7qW4JrO7MOKxpa7dl
	 onGwEGzqN+iIxhhuq3sxQFrhU6F/Uoz7heDYjAmaS8YtPW8ruygCWELc1Ivb1wPnxR
	 FZ3QIIxFL9531ejCSHR1t8lHqQ/k9VyBjJVhjiO/k6LLZcd1pTBgtI0PleB5CoMo/T
	 U8ibggsWKF+2dkWUp6gcTuD2UrQTCOgzvYle5ffapu99MzKpQDl3XlroWcq7QgDMfw
	 PsrmBv/3HdG8JoIwgpeWI9Jrje7tVEy6/Ofm1ji9SCs2Krvn1ITMF2I0vxyFkrZqgc
	 CtJRV06cpZOYA==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id B09533782087;
	Tue, 26 Mar 2024 13:34:32 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 4ADB71060700; Tue, 26 Mar 2024 14:34:32 +0100 (CET)
Date: Tue, 26 Mar 2024 14:34:32 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: hsi: omap-ssi: convert to YAML
Message-ID: <64js2unmngyzluullyos6ylkvgvdgn26zgnkku2guozynervpy@tkniifdrklyi>
References: <20240325-hsi-dt-binding-v1-0-88e8e97c3aae@collabora.com>
 <20240325-hsi-dt-binding-v1-3-88e8e97c3aae@collabora.com>
 <8cd3158b-ed51-4a1f-a626-fa58c85d4aeb@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="njs5f5dqoav63mx4"
Content-Disposition: inline
In-Reply-To: <8cd3158b-ed51-4a1f-a626-fa58c85d4aeb@linaro.org>


--njs5f5dqoav63mx4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Mar 26, 2024 at 08:26:54AM +0100, Krzysztof Kozlowski wrote:
> On 25/03/2024 22:45, Sebastian Reichel wrote:
> > Convert the legacy txt binding to modern YAML.
> > No semantic change.
>=20
> You deprecated a property: ti,hwmods. Also will be one more change:
> ti,ssi-cawake-gpio->gpios

and I will introduce a simple bus binding for referencing the
peripheral. I added a list to the commit message for v2.

> >  Documentation/devicetree/bindings/hsi/omap-ssi.txt | 102 -----------
> >  .../devicetree/bindings/hsi/ti,omap-ssi.yaml       | 196 +++++++++++++=
++++++++
> >  2 files changed, 196 insertions(+), 102 deletions(-)

[...]

> > +patternProperties:
> > +  "[hs]si-port@[0-9a-f]+":
>=20
> Does anything actually depends on the name? Can these be "port@[0-9a-f]+"?

That should work. The Linux driver is looping over all child nodes
and checking the compatible.

[...]

> > +      ti,ssi-cawake-gpio:
>=20
> ti,ssi-cawake-gpios

mh, the kernel supports the extra s since 2016. I guess that should
be good enough. I will fix it in v2.

All other comments will be fixed in v2.

Thanks for the review,

-- Sebastian

--njs5f5dqoav63mx4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmYCzuMACgkQ2O7X88g7
+pqxjA//TjV4yyHewGmF+3gOtEjdCKdzJEQuAWEQDolYEEUDF/bk9rGKfJ8YQ0vC
vcHGnK/7UC99dnuBoHDSaQONXuuBdl+Hnyv8OxkGCb+glkdoXAkBcwkGZQf0EBXw
oPnmdXZhEdC9wt/HoGaF8gB9ojbrAV1Tw18ypKL5WkKK/mczFBMZUHhZXY0AzIJ8
KMQ4+sc0S/cRhq1ilRXsqY6omLDuHVX5zyBRZS+QqiNGtI6xZc5SIhNXlmLua6/Q
DXaaag+TbMoFfjtqvp5xfCPtc3hlCuImnBKoS/nJHTcoIHAEvA6/VuxNYbKJ26gX
7U/vfz8hOaZqQvdVmwGXkYBUpqO/++ksWXgYPvzJJ/8UJ1YlkwI1/eS1USbM7Qdz
P+D5hWRjQRa0D6Vw6D8R78cz3/joX1SjYWfEA8Cwe0KYt55mH2hOQ2l0828u9Fve
RIDy/193hRUeKFHMvB4yLAFtRJsYkuXPiIFp2VSeeGGgq9GXBcTZEBXBOQ6prHzy
zslwKiBHZQ/RUfuc8WjHPmM1RcwL+iuqCfRsOQp2oQZ93di6yCsJg4CQv9RkmmZo
KlhLt/Mk4tsKljYdskxDjQSb2Aic0ByhpmLEd7+zUAftDfWgBz6mTNTlX6jKGwuF
2UUGzH2PKf6pTpISgBHJNYUKrMQOb0LlHxUi1hPTgtnU1dyC4NU=
=Rttd
-----END PGP SIGNATURE-----

--njs5f5dqoav63mx4--

