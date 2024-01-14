Return-Path: <linux-kernel+bounces-25500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 634E182D130
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 16:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F0828226F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73B3259C;
	Sun, 14 Jan 2024 15:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+NeV4Mb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D97F23CA;
	Sun, 14 Jan 2024 15:28:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF684C433C7;
	Sun, 14 Jan 2024 15:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705246085;
	bh=XqE4zwcpZP6BKmHgnhqMegwV+ZjrEakoNJeSEJ8lkmE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=H+NeV4MbLBHlJrpvQQZIIilEiBFq9JV4Wu5i8d+EdnOp26YkAsBN5g3rLyAlq03Fe
	 RTfyvyxn7VNjR9+aBvK5TS9GZF56w6MTNmTaA7vsREt/8PmlE7mHrLLQ6ud9sGc8lj
	 UEa8hHngUDPPvRfRZNpYXbdCGo+w5O3LxQYbDO7QnXudnZv4F4woYiKkL6lJDEjioZ
	 i8Ug9gaLtxdbvQaQwcDJ6TmWTAM0Ho8pnV1rFiRzbT+VzZl/SYS3tVsmocVljd5lUR
	 jdmh38U9zsAyODkhwhoOPfJgwxydIpxubp38WwEKev+lVUhNvIBPmr0IxQngqMOjkF
	 MerWYTN9eS3Tg==
Date: Sun, 14 Jan 2024 15:27:34 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter Clausen
 <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 6/6] iio: pressure: hsc030pa add sleep mode
Message-ID: <20240114152734.0ecdd090@jic23-huawei>
In-Reply-To: <ZaNue0JgTw-WEhCw@sunspire>
References: <20240110172306.31273-1-petre.rodan@subdimension.ro>
	<20240110172306.31273-7-petre.rodan@subdimension.ro>
	<20240112171356.00003e88@Huawei.com>
	<ZaNue0JgTw-WEhCw@sunspire>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 14 Jan 2024 07:17:47 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Hi Jonathan,
>=20
> On Fri, Jan 12, 2024 at 05:13:56PM +0000, Jonathan Cameron wrote:
> > On Wed, 10 Jan 2024 19:22:41 +0200
> > Petre Rodan <petre.rodan@subdimension.ro> wrote:
> >  =20
> > > Some custom chips from this series require a wakeup sequence before t=
he
> > > measurement cycle is started.
> > >  =20
> [..]
> > > +	if (data->capabilities & HSC_CAP_SLEEP) {
> > > +		/*
> > > +		 * Send the Full Measurement Request (FMR) command on the CS
> > > +		 * line in order to wake up the sensor as per
> > > +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> > > +		 * technical note (consult the datasheet link in the header).
> > > +		 *
> > > +		 * These specifications require a dummy packet comprised only by
> > > +		 * a single byte that contains the 7bit slave address and the
> > > +		 * READ bit followed by a STOP.
> > > +		 * Because the i2c API does not allow packets without a payload,
> > > +		 * the driver sends two bytes in this implementation.
> > > +		 */
> > > +		ret =3D i2c_master_recv(client, &buf, 1);
> > > +		if (ret < 0)
> > > +			return ret;
> > > +	}
> > > + =20
> [..]
> > > diff --git a/drivers/iio/pressure/hsc030pa_spi.c b/drivers/iio/pressu=
re/hsc030pa_spi.c
> > > index 737197eddff0..1c139cdfe856 100644
> > > --- a/drivers/iio/pressure/hsc030pa_spi.c
> > > +++ b/drivers/iio/pressure/hsc030pa_spi.c
> > > @@ -25,12 +25,40 @@ static int hsc_spi_recv(struct hsc_data *data)
> > >  	struct spi_device *spi =3D to_spi_device(data->dev);
> > >  	struct spi_transfer xfer =3D {
> > >  		.tx_buf =3D NULL,
> > > -		.rx_buf =3D data->buffer,
> > > -		.len =3D HSC_REG_MEASUREMENT_RD_SIZE,
> > > +		.rx_buf =3D NULL,
> > > +		.len =3D 0,
> > >  	};
> > > +	u16 orig_cs_setup_value;
> > > +	u8 orig_cs_setup_unit;
> > > +
> > > +	if (data->capabilities & HSC_CAP_SLEEP) {
> > > +		/*
> > > +		 * Send the Full Measurement Request (FMR) command on the CS
> > > +		 * line in order to wake up the sensor as per
> > > +		 * "Sleep Mode for Use with Honeywell Digital Pressure Sensors"
> > > +		 * technical note (consult the datasheet link in the header).
> > > +		 *
> > > +		 * These specifications require the CS line to be held asserted
> > > +		 * for at least 8=C2=B5s without any payload being generated.
> > > +		 */
> > > +		orig_cs_setup_value =3D spi->cs_setup.value;
> > > +		orig_cs_setup_unit =3D spi->cs_setup.unit;
> > > +		spi->cs_setup.value =3D 8;
> > > +		spi->cs_setup.unit =3D SPI_DELAY_UNIT_USECS;
> > > +		/*
> > > +		 * Send a dummy 0-size packet so that CS gets toggled.
> > > +		 * Trying to manually call spi->controller->set_cs() instead
> > > +		 * does not work as expected during the second call.
> > > +		 */ =20
> >
> > Do you have a reference that says the CS must be toggled on 0 length tr=
ansfer?
> > If that's not specified in the SPI core somewhere then you will need to=
 send
> > something...
> > =20
> > > +		spi_sync_transfer(spi, &xfer, 1);
> > > +		spi->cs_setup.value =3D orig_cs_setup_value;
> > > +		spi->cs_setup.unit =3D orig_cs_setup_unit;
> > > +	} =20
>=20
> first of all thank you for the review.
>=20
> I was afraid that this block will not be taken too well since I'm trying =
to
> achieve something that the SPI subsystem was not designed for.
>=20
> the code does exactly what the datasheet specs require on my SPI controll=
er, but
> indeed the API might change at some point making the code non-functional.
>=20
> by 'sending something' you mean on the SPI bus or are you pushing me towa=
rd a
> patch to SPI core?
Should have said receive 'something' - that means that we'd clock some data
whether or not the device had any to provide.

>=20
> unfortunately this chip feature is a special request only, there is no wa=
y for
> me to test what happens if the wakeup sequence also contains a payload (i=
n both
> i2c and spi cases). the i2c wakeup code was inspired from the abp060mg dr=
iver,
> but I can't reach its maintainer to ask for details. I also can't seem to=
 reach
> Honeywell. oh well.
>=20
+CC Mark.  Discussion is about whether a zero length SPI transfer is guaran=
teed
to pulse the chip select.

If this is something we need, I'd prefer to see it as something a given SPI
controller would opt in to supporting or some other way of knowing it would
actually happen such as some docs that say it will work for an SPI controll=
er
(which I doubt is the case)

Jonathan





> best regards,
> peter
>=20


