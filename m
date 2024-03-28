Return-Path: <linux-kernel+bounces-122942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BA88FFE4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19B61C288A0
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07FE80025;
	Thu, 28 Mar 2024 13:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="McOYBOmO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A00847C;
	Thu, 28 Mar 2024 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711631718; cv=none; b=VsBr2rD2oSdTdMxypNXwavpD5lWguNvzsM/LVDGapD8nblXp0wnRwefkXXph90ZC6ZtoInSAkXK0onBntJ6U5M0sjGIOpiSzrQwRFKG+r2/eYpcrQ9wkrQk0Ts4dTzogH72l6QFuak125c1P3HxcgdUVexenneSa+s0qcHhDhkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711631718; c=relaxed/simple;
	bh=6TWeWcjSh/g81Ig8RxxLjk0o2Q11JmZ1utPGtly2dYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bIMK8AaKTmDhj7g8kbK0XTvsw33ChoGfl6UvU+C4kN4g8RElIBw2ETSwZvGaY2YqCHpqTOJBP2EDgugq/LiCKt9AiINundAY9wWmRK6q+DTbgQzJXQpSZsdVYFx/ZVXlqgvpFFsAL/3OE9PNxAG4xe+7Qm/VC06lJ9F1cU1v8Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=McOYBOmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C906C433C7;
	Thu, 28 Mar 2024 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711631717;
	bh=6TWeWcjSh/g81Ig8RxxLjk0o2Q11JmZ1utPGtly2dYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=McOYBOmOxr/4SJ6wInhGNN/Dwf766g0iIc7OaU4hNurqwBGkOrkfPACbNRk6uwwGn
	 JJb8eZuQo2YKEcHgQY9Z0l0qEvHQ/lSne2WjHvKhsZhJD4d8b+MGgk0+AUhkkTQjh5
	 Dy6iokvGsIvTrkA/+pK6GPSLcxeJ5oSOmVFWgwhUVHduxJjW8r9QbKTVpIDES3YFDa
	 lD7OWQVY33gb+DDQVc5fgBP65U7mc523IqlWbkuYlC8T4tUNz/slrT/e4+J07mv6tB
	 cx0Rx9t4M4PeGOnGZMRr6mgNhiEjZasUWEvB/+ZX/CQ6UcN3EX0EddKMRaVcTbXJd3
	 HN/TqpYU+QzRA==
Date: Thu, 28 Mar 2024 13:15:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v4 1/7] iio: accel: adxl345: Make data_range obsolete
Message-ID: <20240328131500.068c82c3@jic23-huawei>
In-Reply-To: <CAFXKEHaQLu9WFJe4r4+QaWO-wjM0hpYkWF_s8NOSh2Hoo5w8FQ@mail.gmail.com>
References: <20240325153356.46112-1-l.rubusch@gmail.com>
	<20240325153356.46112-2-l.rubusch@gmail.com>
	<20240325203155.23ddfe3d@jic23-huawei>
	<CAFXKEHaQLu9WFJe4r4+QaWO-wjM0hpYkWF_s8NOSh2Hoo5w8FQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 26 Mar 2024 21:59:34 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Mar 25, 2024 at 9:32=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Mon, 25 Mar 2024 15:33:50 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Replace write() data_format by regmap_update_bits(), because
> > > bus specific pre-configuration may have happened before on
> > > the same register. Changes then need to be masked.
> > >
> > > Remove the data_range field from the struct adxl345_data,
> > > because it is not used anymore.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 9 ++++-----
> > >  1 file changed, 4 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 8bd30a23e..be6758015 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -42,13 +42,13 @@
> > >  #define ADXL345_DATA_FORMAT_4G               1
> > >  #define ADXL345_DATA_FORMAT_8G               2
> > >  #define ADXL345_DATA_FORMAT_16G              3
> > > +#define ADXL345_DATA_FORMAT_MSK              ~((u8) BIT(6)) /* ignor=
e spi-3wire */ =20
> >
> > I'm not keen on seeing masking of a bit we don't yet
> > handle done by value.  Can we instead build this up by what we 'want' to
> > write rather than don't. Will need a few more defines perhaps to cover
> > the masks of SELF_TEST, INT_INVERT, FULL_RES, Justify and Range.
> > =20
>=20
> Good point. Anyway, there is also an input driver implementation for
> the adxl345, mainly dealing with the interrupt feature as input
> device. Thus, for the iio implementation I would suggest to reduce the
> mask just to cover SELF_TEST and FULL_RES and leave INT_INVERT out. Is
> this ok?
yes, that sounds fine
>=20
> > >
> > >  #define ADXL345_DEVID                        0xE5
> > >
> > >  struct adxl345_data {
> > >       const struct adxl345_chip_info *info;
> > >       struct regmap *regmap;
> > > -     u8 data_range;
> > >  };
> > >
> > >  #define ADXL345_CHANNEL(index, axis) {                              =
         \
> > > @@ -219,14 +219,13 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap)
> > >       data =3D iio_priv(indio_dev);
> > >       data->regmap =3D regmap;
> > >       /* Enable full-resolution mode */
> > > -     data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> > >       data->info =3D device_get_match_data(dev);
> > >       if (!data->info)
> > >               return -ENODEV;
> > >
> > > -     ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > > -                        data->data_range);
> > > -     if (ret < 0)
> > > +     ret =3D regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> > > +                              ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_=
FORMAT_FULL_RES);
> > > +     if (ret)
> > >               return dev_err_probe(dev, ret, "Failed to set data rang=
e\n");
> > >
> > >       indio_dev->name =3D data->info->name; =20
> > =20


