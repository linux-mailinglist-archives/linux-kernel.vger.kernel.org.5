Return-Path: <linux-kernel+bounces-25403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0607F82CFCE
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 06:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C92DB21D41
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 05:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E51851;
	Sun, 14 Jan 2024 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=subdimension.ro header.i=@subdimension.ro header.b="SS2nx5Ka"
Received: from mail.subdimension.ro (skycaves.subdimension.ro [172.104.132.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67537E;
	Sun, 14 Jan 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=subdimension.ro
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=subdimension.ro
Received: from sunspire (unknown [188.24.94.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by mail.subdimension.ro (Postfix) with ESMTPSA id C1AA128B531;
	Sun, 14 Jan 2024 05:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=subdimension.ro;
	s=skycaves; t=1705209469;
	bh=m5rbK86AKeu5AdwO2INoRZbJcky2jWLDyHoyzlO++ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SS2nx5KavZNnMHqHVj1M93PQesX+sTVegFz/dIzoou7zUpmPaZ1Xab/B8BK2kVxP/
	 vlZAllkQK9xR2Z7eOm9vJgbXi4Q3WJxknI8jY/OqiEq8Bt6vI6VzJETWFJtD/qfWJ7
	 YJyI8hHE4UMfCfLZzTitTHLlOc5gGHSgo6PGXyoo=
Date: Sun, 14 Jan 2024 07:17:47 +0200
From: Petre Rodan <petre.rodan@subdimension.ro>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 6/6] iio: pressure: hsc030pa add sleep mode
Message-ID: <ZaNue0JgTw-WEhCw@sunspire>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
 <20240110172306.31273-7-petre.rodan@subdimension.ro>
 <20240112171356.00003e88@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="80EMe14M5nvbaxA/"
Content-Disposition: inline
In-Reply-To: <20240112171356.00003e88@Huawei.com>


--80EMe14M5nvbaxA/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Hi Jonathan,

On Fri, Jan 12, 2024 at 05:13:56PM +0000, Jonathan Cameron wrote:
> On Wed, 10 Jan 2024 19:22:41 +0200
> Petre Rodan <petre.rodan@subdimension.ro> wrote:
>=20
> > Some custom chips from this series require a wakeup sequence before the
> > measurement cycle is started.
> >=20
[..]
> > +	if (data->capabilities & HSC_CAP_SLEEP) {
> > +		/*
> > +		 * Send the Full Measurement Request (FMR) command on the CS
> > +		 * line in order to wake up the sensor as per
> > +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> > +		 * technical note (consult the datasheet link in the header).
> > +		 *
> > +		 * These specifications require a dummy packet comprised only by
> > +		 * a single byte that contains the 7bit slave address and the
> > +		 * READ bit followed by a STOP.
> > +		 * Because the i2c API does not allow packets without a payload,
> > +		 * the driver sends two bytes in this implementation.
> > +		 */
> > +		ret =3D i2c_master_recv(client, &buf, 1);
> > +		if (ret < 0)
> > +			return ret;
> > +	}
> > +
[..]
> > diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressure=
/hsc030pa_spi.c
> > index 737197eddff0..1c139cdfe856 100644
> > --- a/drivers/iio/pressure/hsc030pa_spi.c
> > +++ b/drivers/iio/pressure/hsc030pa_spi.c
> > @@ -25,12 +25,40 @@ static int hsc_spi_recv(struct hsc_data *data)
> >  	struct spi_device *spi =3D to_spi_device(data->dev);
> >  	struct spi_transfer xfer =3D {
> >  		.tx_buf =3D NULL,
> > -		.rx_buf =3D data->buffer,
> > -		.len =3D HSC_REG_MEASUREMENT_RD_SIZE,
> > +		.rx_buf =3D NULL,
> > +		.len =3D 0,
> >  	};
> > +	u16 orig_cs_setup_value;
> > +	u8 orig_cs_setup_unit;
> > +
> > +	if (data->capabilities & HSC_CAP_SLEEP) {
> > +		/*
> > +		 * Send the Full Measurement Request (FMR) command on the CS
> > +		 * line in order to wake up the sensor as per
> > +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> > +		 * technical note (consult the datasheet link in the header).
> > +		 *
> > +		 * These specifications require the CS line to be held asserted
> > +		 * for at least 8=B5s without any payload being generated.
> > +		 */
> > +		orig_cs_setup_value =3D spi->cs_setup.value;
> > +		orig_cs_setup_unit =3D spi->cs_setup.unit;
> > +		spi->cs_setup.value =3D 8;
> > +		spi->cs_setup.unit =3D SPI_DELAY_UNIT_USECS;
> > +		/*
> > +		 * Send a dummy 0-size packet so that CS gets toggled.
> > +		 * Trying to manually call spi->controller->set_cs() instead
> > +		 * does not work as expected during the second call.
> > +		 */
>
> Do you have a reference that says the CS must be toggled on 0 length tran=
sfer?
> If that's not specified in the SPI core somewhere then you will need to s=
end
> something...
>
> > +		spi_sync_transfer(spi, &xfer, 1);
> > +		spi->cs_setup.value =3D orig_cs_setup_value;
> > +		spi->cs_setup.unit =3D orig_cs_setup_unit;
> > +	}

first of all thank you for the review.

I was afraid that this block will not be taken too well since I'm trying to
achieve something that the SPI subsystem was not designed for.

the code does exactly what the datasheet specs require on my SPI controller=
, but
indeed the API might change at some point making the code non-functional.

by 'sending something' you mean on the SPI bus or are you pushing me toward=
 a
patch to SPI core?

unfortunately this chip feature is a special request only, there is no way =
for
me to test what happens if the wakeup sequence also contains a payload (in =
both
i2c and spi cases). the i2c wakeup code was inspired from the abp060mg driv=
er,
but I can't reach its maintainer to ask for details. I also can't seem to r=
each
Honeywell. oh well.

best regards,
peter

--=20
petre rodan

--80EMe14M5nvbaxA/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE2Ap/wXYVGTXsPl+pzyaZmYROfzAFAmWjbncACgkQzyaZmYRO
fzCTjQ//Xg/d2FKzXNqDpBObwUh3stVXaWNJtmitlauqLYiZaGx4H5ZtDGz5qZFM
c9Wd5yMvEYvLIg7x7Xm0vF+uBzS1CNtYm/OehqLvDtjnWndwb/53QpFj1dZgaPN5
/4Z6xmWmosrpcpwg1ANRNt070YQkvEOw0h5NUQs+fbWeLBhdYN1DfmKFYwhvrbqq
HyFftZUgSZQSo3z7BJ86fRBh/nuVz1fOiLIkvZ8Nm3tgeqBzGN4J4BD85rgrkjem
LoMKtm7MHqESunk9EaAmsd4pMkZjsuNCdwe8EIUAaV8i8jb0wiPqf+cbL+ijRVaH
Uq0jciKYX861rwyeeX8sOtQy5wTTshZTmGPG3tmJBUieWTAGxqxmdOr0rN+bic+Y
cP7aAy+pvo0qrjTeeRwUR2HWTJFX+tMQD+megFGZqnVgU+MKLvOAaV1Qq6SjPHZ7
aynEELrw4FaZhcp2R00+4g44oavjPTzdGErz2sc++mCet7SFNF+R4n0BdoOxSJJp
M5mHBLdyF+KfP7Nt+y/aaHxHHnkjznlFZOJwYDH3UuleUkt7dAxFVZjEozn/3L+i
nKlihMPThY3WBSQzTmK1Jnb8OZPiFgq2iZD7YvB842v/eGLFNhvh53v742z9ZMEz
VO/j6e8Xt4++gVewxv98Cayk3xB9qKdto6aLHe1f7iVvB4hS74c=
=tD9a
-----END PGP SIGNATURE-----

--80EMe14M5nvbaxA/--

