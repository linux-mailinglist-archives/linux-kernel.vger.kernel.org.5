Return-Path: <linux-kernel+bounces-158814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE3708B2538
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 17:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2F01C218E5
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 15:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2476614B092;
	Thu, 25 Apr 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKLqiPgj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C9B7FBB0;
	Thu, 25 Apr 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714059383; cv=none; b=S5RBXioIq7LtTAaMi/ZSL09bn/G7Vcnh26LYHSpfK5ng2I+z7wqczrBzAJkC+FJIxNbDBnlBS7kMhF5FxeeCw0dKfZqQ+KeJulGTYB34km1qjPS4qxNzIFmjNjjlxE6k/1B9JEx+KZu+TRpix7MEZTVjbqSEZ15Ke/390udjvwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714059383; c=relaxed/simple;
	bh=oiLQAN95u8wHE9d/PcfcEXC3op1EES65QUSwsxn6SZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+aiQ9MEfDh6Pk6M1ZUQIgn2+AhYEl728xuXtkW2Nhj/UUOVU0XrhonLqTnnjjxEmvWotezrfxk4yPvuYgX2/zV8dRIfS1Pgn2Qp5PE8XXr4Fq6AcwRkNVZVlFN7Kn95fC3NCfTTy2HeAMuTUyovwWNEbjUNw97UmruDtsx1l3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKLqiPgj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 184B4C113CC;
	Thu, 25 Apr 2024 15:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714059383;
	bh=oiLQAN95u8wHE9d/PcfcEXC3op1EES65QUSwsxn6SZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oKLqiPgju7T8z0EiXfAs1oRfeJSjOWqcDuM+qiZC/VqRLhnLwS4vb5ymcNBH7UGAe
	 hiYrRwev5vi00rusSe0PmlRplzqVGucXujI4TsrwwbHLgHICL2wQcK/lKZZiZL7iEd
	 f9hIh9azY3KmtJbLsiNBjt/20J6NVzLvNZI5rReLZiaTI+ywNfJIREbfbwIkkU6QUH
	 qIcQBfvIANnedtXLJhaZSbC4cOW+s0d6306GXVd3kno3EGsKYsohA9MV0pHVevrJSD
	 1f1S/6zGCaRUk0DY6W3LkUfgLfJQmCasscUaRmanjDFEeeAct4vtadG895NYymbTeZ
	 U+YDTs/OyRSNQ==
Date: Thu, 25 Apr 2024 16:36:19 +0100
From: Conor Dooley <conor@kernel.org>
To: Conor Dooley <conor.dooley@microchip.com>
Cc: marius.cristea@microchip.com, jic23@kernel.org, lars@metafoo.de,
	lgirdwood@gmail.com, broonie@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v1] iio: adc: PAC1934: fix accessing out of bounds array
 index
Message-ID: <20240425-vastly-salad-e56b9225e662@spud>
References: <20240425114232.81390-1-marius.cristea@microchip.com>
 <20240425-canteen-alias-5a907b1deecc@wendy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="M4AyjKAjLs9Ns3jd"
Content-Disposition: inline
In-Reply-To: <20240425-canteen-alias-5a907b1deecc@wendy>


--M4AyjKAjLs9Ns3jd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 25, 2024 at 01:22:45PM +0100, Conor Dooley wrote:
> On Thu, Apr 25, 2024 at 02:42:32PM +0300, marius.cristea@microchip.com wr=
ote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> >=20
> > Fix accessing out of bounds array index for average
> > current and voltage measurements. The device itself has
> > only 4 channels, but in sysfs there are "fake"
> > channels for the average voltages and currents too.
> >=20
> > Fixes: 0fb528c8255b: "iio: adc: adding support for PAC193x"
> > Reported-by: Conor Dooley <conor.dooley@microchip.com>
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>


Huh, this is an empty message. I intended to send some tags, but must
not have saved the buffer.

Closes: https://lore.kernel.org/linux-iio/20240405-embellish-bonnet-ab5f105=
60d93@wendy/
Tested-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

> > ---
> >  drivers/iio/adc/pac1934.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/iio/adc/pac1934.c b/drivers/iio/adc/pac1934.c
> > index f751260605e4..456f12faa348 100644
> > --- a/drivers/iio/adc/pac1934.c
> > +++ b/drivers/iio/adc/pac1934.c
> > @@ -787,6 +787,15 @@ static int pac1934_read_raw(struct iio_dev *indio_=
dev,
> >  	s64 curr_energy;
> >  	int ret, channel =3D chan->channel - 1;
> > =20
> > +	/*
> > +	 * For AVG the index should be between 5 to 8.
> > +	 * To calculate PAC1934_CH_VOLTAGE_AVERAGE,
> > +	 * respectively PAC1934_CH_CURRENT real index, we need
> > +	 * to remove the added offset (PAC1934_MAX_NUM_CHANNELS).
> > +	 */
> > +	if (channel >=3D PAC1934_MAX_NUM_CHANNELS)
> > +		channel =3D channel - PAC1934_MAX_NUM_CHANNELS;
> > +
> >  	ret =3D pac1934_retrieve_data(info, PAC1934_MIN_UPDATE_WAIT_TIME_US);
> >  	if (ret < 0)
> >  		return ret;
> >=20
> > base-commit: b80ad8e3cd2712b78b98804d1f59199680d8ed91
> > --=20
> > 2.34.1
> >=20



--M4AyjKAjLs9Ns3jd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZip4cgAKCRB4tDGHoIJi
0mHPAQCwPscxxdp0iUJ3vOyfhjjtaJ1mNh5Cm8R8/GsCcFznZQD+Ptu6tlhKrd9l
epAaKawJi6jP3BjS/BYYF+/1gFlywww=
=Bku/
-----END PGP SIGNATURE-----

--M4AyjKAjLs9Ns3jd--

