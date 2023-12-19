Return-Path: <linux-kernel+bounces-5602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 420C1818CEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF196288883
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E5D2032C;
	Tue, 19 Dec 2023 16:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="KwMAAjV4"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3833456E;
	Tue, 19 Dec 2023 16:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id 26CC728B50B;
	Tue, 19 Dec 2023 16:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703004668;
	bh=veNOinDTAb64HC+IDzgM+dbyIHOuQpU8BV5YLj+GHx0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KwMAAjV407nb8RnrE+LhyXpGclMA6l6DOcdztvli/nBs1bed3i9DgGAgWX3SRm4xV
	 1sK7lc2QWe4X98rdZM+LXzV1WNJ/it8XW2pUUyhcLGbjMaAZjQs+tkA9cWoqTyEsfK
	 pXcX297cHbBhww88CYT8tu8htglH9elFZiQTOsnY=
Date: Tue, 19 Dec 2023 18:51:06 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/2] iio: pressure: change driver for Honeywell MPR series
Message-ID: <ZYHJ-vkLEiN2sFxv@sunspire>
References: <20231219130230.32584-1-petre.rodan@subdimension.ro>
 <20231219130230.32584-3-petre.rodan@subdimension.ro>
 <ZYG5pZaDN11eht7A@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="OdreSIYuALwCjV8t"
Content-Disposition: inline
In-Reply-To: <ZYG5pZaDN11eht7A@smile.fi.intel.com>


--OdreSIYuALwCjV8t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 05:41:25PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 19, 2023 at 03:02:21PM +0200, Petre Rodan wrote:
> > ChangeLog
> >  - rewrite flow so that driver can use either i2c or spi as communicati=
on bus
> >  - add spi driver (tested on MPRLS0015PA0000SA)
> >  - add pressure-triplet property that automatically sets pmin, pmax
> >  - fix transfer-function enum typo based on previous review [1]
> >  - fix interrupt example in binding file (FALLING -> RISING edge)
> >  - indentation changes based on previous code reviews
> >  - renamed mpr_read_pressure to mpr_read_conversion since the sensor is
> >    supposed to also provide temperature measuremets
> >    (but I think mine is broken since the raw temperature value is always
> >    0x800000 - so temp reading not currently implemented)
>=20
> Changelog...
>=20
> > I've been told in the past that the use of mutexes is redundant in thes=
e cases
> > so please assess if the guard() from the driver code is required or sho=
uld be
> > removed.
>=20
> A comment...
>=20
> > patch uses device_property_match_property_string() from the 'togreg' br=
anch
>=20
> Another comment...
>=20
> > [1]: https://lore.kernel.org/lkml/20231116-grudge-hankering-b7a71d831b9=
3@squawk/T/
>=20
> Some Link: (should it be a tag?)...

it's a reference link that was pointed to within the text above.
it emulates `lynx --dump foo.html`. designed for human reading, sorry if it
broke some parsing script.

> Where is the commit message? Or is this just an intermediate change
> to show what will be in the next version? I'm confused.

the commit message is between the end of the mail header and before the act=
ual
patch. the two comments were also placed for human interaction.
they will be removed later on when we get close to acceptance and someone
replies to them. and yes, the entire patch is full and self-contained in th=
ese
3 messages.

very best regards,
peter

--OdreSIYuALwCjV8t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWByfYACgkQzyaZmYRO
fzCo7Q/+LgL4tQSgwiqKEzmiqz8GK0zTJch094QCkyCLUrjCJtbiBzEi3IvT6bz6
gOx2nO0H2ijjP1Rxxi7KWWCRzRMl82Oaf2ncj49uUjMrLBHFQmTVlsaJ4viCYUzU
IMG+JajAWnZkpMh/h/Nw8N9833g/g59nD/CuxxzIR7LsIh4xxa9jkIchbWpAzylI
pI3fP4HZapo0o/k9OOcF5ccOaS7jTpRCATqN3syDhT2fwq5T3lXIJyJ+V3gmgA08
r61eW0T3am9Y4/J9CUZtdKEWqEXsRGO6tHTUEQVhpuw41SIJ/mUVyfK45Em2KoYa
RRtPR3ra6KTFhi0UF7neMIzleVPd4vMU+dfKz6cuZTwf3e7KleN3tLbR0u+1TaYk
dw9P/oAd9Kl+Yk7mT9lIT85J52lP0rqoBgv5kyrDWe4ApzfUCp7DV/q4HGa9uZ6v
B/qnL0R+b4cyACRTDrAdP604O7NKaZalSb8jZifYmokq9zkEto8DCG+TgGRJOMzL
kiVuk8DrflalpXlqeU3SxbC3e63W0Qnpz5AWwcUM5z34TZY7XyyXZ0qzJ7brYhfl
9JI3y8pqIYDmzoi6j5LL504/CMlpeowAcK/VXhR3o1pm0DKtQ1TXKzFAmAsMC/5i
wcL7IfJZ9/y9WqNXTGz7LzxJgvbZobf5vDqJR8GA3JNsRRK7Gak=
=1KU9
-----END PGP SIGNATURE-----

--OdreSIYuALwCjV8t--

