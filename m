Return-Path: <linux-kernel+bounces-12051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D293E81EF75
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 15:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EF4D2829B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 14:33:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A793A45033;
	Wed, 27 Dec 2023 14:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="RszUSlTc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F421245948;
	Wed, 27 Dec 2023 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id AC12F28B50B;
	Wed, 27 Dec 2023 14:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1703687618;
	bh=nMlEOJ0m80IN9YaTBtl4QoQb2lTcrUVxOt1bWvxMAog=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RszUSlTcXRuK7P4nTNrIdnBCsYK/SdJut5rEKwJAcm/bvt/FFcI7v238xLzuFXiWL
	 g/unPuzo7RdeUhWHwVspRufDPlCskTCEEhfaFGUc2jMTUZk0cvvHN4WKvauHZGSlcb
	 UlQDf0AscwzEOg7Cfj736anQMeFBu9Q3umLq+KNU=
Date: Wed, 27 Dec 2023 16:33:37 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andreas Klinger <ak@it-klinger.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Angel Iglesias <ang.iglesiasg@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 08/10] iio: pressure: mprls0025pa.c refactor
Message-ID: <ZYw1wbvYQqqCr5C2@sunspire>
References: <20231224143500.10940-1-petre.rodan@subdimension.ro>
 <20231224143500.10940-9-petre.rodan@subdimension.ro>
 <20231226164922.6d7132c1@jic23-huawei>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="e0TuRtiQxORaMcZa"
Content-Disposition: inline
In-Reply-To: <20231226164922.6d7132c1@jic23-huawei>


--e0TuRtiQxORaMcZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Tue, Dec 26, 2023 at 04:49:22PM +0000, Jonathan Cameron wrote:
> >  	if (data->irq > 0) {
> >  		ret =3D devm_request_irq(dev, data->irq, mpr_eoc_handler,
> > -				IRQF_TRIGGER_RISING, client->name, data);
> > +				      IRQF_TRIGGER_RISING, dev_name(dev), data);
>=20
> Even though you'll change it again here, would have been nice to have
> the alignment fixed in the earlier patch then the code update here.

I tried this, but due to the fact that the line has to be right-aligned to
column 80 we will still see a whitespace difference due to the length diff =
of
the name-related argument.

> > +++ b/drivers/iio/pressure/mprls0025pa_i2c.c
> > +
> > +#include <linux/iio/iio.h>
>=20
> Why include this?  Can't see an IIO specific stuff in here.

tried to remove it and

  CC [M]  mprls0025pa_i2c.o
mprls0025pa.h:89:63: error: 'IIO_DMA_MINALIGN' undeclared here (not in a fu=
nction); did you mean 'ARCH_DMA_MINALIGN'?
   89 |         u8          buffer[MPR_MEASUREMENT_RD_SIZE] __aligned(IIO_D=
MA_MINALIGN);

I guess it makes more sense to move it to the .h file, where buffer[] is de=
fined.

everything else will be fixed as per your feedback.

thanks,
peter

--=20
petre rodan

--e0TuRtiQxORaMcZa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWMNb0ACgkQzyaZmYRO
fzAqfxAAg/X+re8H1a+LxaiQf+e+JiiEVRO7dlbRJ7HLpwTk7K9yI1URwlQLKXfn
sPUPhBTAjIc7A4Xox/lpO0NyKBHKVMTDAy3oBcINAlnn+5KmMdjKHdyI61Qloy/u
ariah7GaV/4P4vOviB7+sQiL3VsdOmp6iw9VaJEeZIiLFEZBq1DSwqcIAK7GWiRP
ZbNLX87toqArjNaU8uXJ4XK5Gg8VOdUBS0EpGOaV2pAzVBUgmWgJ3kWm5VT40RjX
oQFo+0rXlYnZ5hYngP+j7HmPXFSv2fHBa/UJevm/JZBAz3Be/Oj6Uj2S+vBkT7QY
xsWm342gOz+EzG9RTJ44peyrfWVo1LEc9jf0Yi616oVNo3QawOlVBDGrVe1olULf
TGeuPaK+FYMEM3RS6aFytBsTeIS3llMMLo75GqkQE6XZkJ913gkk45RLt9i8W1YJ
Qo6JxGQkvxMFOlng7QWudOvINixOVdT6rXgsHok6WJUE9GlZpV2fQWGFVc3e3DCg
9uEnFS+cBbFJTnJEfjFgKcE4w6xHJwb5Fa1GOD/uGTHD+0NGhC4wqKGGj0yV1bUf
v8DbfT0QQoUGGlqvbs/pJNW2NTlI/Q0mEmz803MI6DXpCiW1W7FqODXNdz+bFHVp
q0BN13+Y/nUISPY/r0ErnuLamCVXwQTsbWUFkoyi89pnVyTKnY8=
=xAMn
-----END PGP SIGNATURE-----

--e0TuRtiQxORaMcZa--

