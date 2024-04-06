Return-Path: <linux-kernel+bounces-133886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 219B489AA4C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 12:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F4241F21D60
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 10:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C2E27459;
	Sat,  6 Apr 2024 10:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G14m6W7u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4123200DB;
	Sat,  6 Apr 2024 10:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712398535; cv=none; b=nsp5scr4/RSTdqbASnYYj4li24lb0pbNKK7/r5z9dd2m/9Y8au74u4FUDsl+vwUw+EyqbUeKO9JTAkG0vr5Y5PKH8GUaOGhB459TsYdA4luXZsD9fXSQEwMnyJ56w63VZZA/XEoihfHymOoYgIsLcgungLlms3/yVrfF67+dnf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712398535; c=relaxed/simple;
	bh=xJ1+0Fa2k2C98ioPBGDRMa7CBjVxnUYjOxLC/5rVTEA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H8QJQPgM1r5xz5yErWqcExn6P6RQO3vRrmYwU2dfhs5T4fqaAnXXxauwH24jWJ0/HR/GLKvKk9N/nwg1RbNmEZgfmQE5IHT4HluL4RKi7mD842BpwlCiQH5eZh4fCfzWcFWMv86ER7uZFUsFA5NAn7FfU0UOFdGYCq7m5wYJa3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G14m6W7u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35582C433C7;
	Sat,  6 Apr 2024 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712398535;
	bh=xJ1+0Fa2k2C98ioPBGDRMa7CBjVxnUYjOxLC/5rVTEA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=G14m6W7u3iamnDFwBAW+iS1kqjG9Tc1+/NkQku/Y73hnQHgxxUjBP0KybeI8FCoTO
	 iTqkej/lHd0r/DUlDXtAvnCatoten9cxBWePQDvQ/I15R9MVvVC+PfvSc4UByOY6Sb
	 z3wOyG77AC0ER1js4Ti82fPj8K2Karc6mZPonCzTf/k4rb64S0rdZ8N9rDMi7tFLAO
	 cOpLSsau78mAZHpCvGn/mHOz2RRi1vc4+TETwalDlJKyinx5v70HcV2LVlFmIC2Bm1
	 xRAn4MfKsMR0fVrtzxrRUpowzS+pvxBM1Qm01pq8JB02mnysOMk95aHRiVcnkOakqO
	 IMXXxohbaLBvg==
Date: Sat, 6 Apr 2024 11:15:20 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, lars@metafoo.de,
 Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 7/7] iio: accel: adxl345: Add spi-3wire option
Message-ID: <20240406111520.6dbaa079@jic23-huawei>
In-Reply-To: <CAFXKEHYrqA2iaQJeMqPbQJYEu10xiRt92c-ySGcfH76MSriufw@mail.gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-8-l.rubusch@gmail.com>
	<20240328133927.7e49f3bf@jic23-huawei>
	<CAFXKEHZva5AE=sinx_i0Gec2FbB4ZfyEu8mWg52omzGBvr5uXw@mail.gmail.com>
	<20240330152401.034aedad@jic23-huawei>
	<CAFXKEHZJZU69udvM86rDSNU1J9o=v62BJcJfTrB=Y9Tgsjm4fw@mail.gmail.com>
	<20240401175304.000022ed@Huawei.com>
	<CAFXKEHYrqA2iaQJeMqPbQJYEu10xiRt92c-ySGcfH76MSriufw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 2 Apr 2024 12:11:43 +0200
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Mon, Apr 1, 2024 at 6:53=E2=80=AFPM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Mon, 1 Apr 2024 18:06:24 +0200
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > On Sat, Mar 30, 2024 at 4:24=E2=80=AFPM Jonathan Cameron <jic23@kerne=
l.org> wrote: =20
> > > >
> > > > On Fri, 29 Mar 2024 01:33:01 +0100
> > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > =20
> > > > > On Thu, Mar 28, 2024 at 2:39=E2=80=AFPM Jonathan Cameron <jic23@k=
ernel.org> wrote: =20
> > > > > >
> > > > > > On Wed, 27 Mar 2024 22:03:20 +0000
> > > > > > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > > > > > =20
> > > > > > > Add a setup function implementation to the spi module to enab=
le spi-3wire
> > > > > > > as option when specified in the device-tree.
> > > > > > >
> > > > > > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/iio/accel/adxl345.h     |  2 ++
> > > > > > >  drivers/iio/accel/adxl345_spi.c | 12 +++++++++++-
> > > > > > >  2 files changed, 13 insertions(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/=
adxl345.h
> > > > > > > index 4ea9341d4..e6bc3591c 100644
> > > > > > > --- a/drivers/iio/accel/adxl345.h
> > > > > > > +++ b/drivers/iio/accel/adxl345.h
> > > > > > > @@ -30,6 +30,8 @@
> > > > > > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > > > > > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > > > > > >
> > > > > > > +#define ADXL345_DATA_FORMAT_SPI_3WIRE        BIT(6) /* 3-wir=
e SPI mode */
> > > > > > > +
> > > > > > >  #define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set th=
e g range */
> > > > > > >  #define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justifie=
d (MSB) mode */
> > > > > > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits=
 resolution */
> > > > > > > diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/ac=
cel/adxl345_spi.c
> > > > > > > index 1c0513bd3..f145d5c1d 100644
> > > > > > > --- a/drivers/iio/accel/adxl345_spi.c
> > > > > > > +++ b/drivers/iio/accel/adxl345_spi.c
> > > > > > > @@ -20,6 +20,16 @@ static const struct regmap_config adxl345_=
spi_regmap_config =3D {
> > > > > > >       .read_flag_mask =3D BIT(7) | BIT(6),
> > > > > > >  };
> > > > > > >
> > > > > > > +static int adxl345_spi_setup(struct device *dev, struct regm=
ap *regmap)
> > > > > > > +{
> > > > > > > +     struct spi_device *spi =3D container_of(dev, struct spi=
_device, dev);
> > > > > > > +
> > > > > > > +     if (spi->mode & SPI_3WIRE)
> > > > > > > +             return regmap_write(regmap, ADXL345_REG_DATA_FO=
RMAT,
> > > > > > > +                                 ADXL345_DATA_FORMAT_SPI_3WI=
RE); =20
> > > > > > Your earlier patch carefully (I think) left one or two fields a=
lone, then
> > > > > > this write just comes in and changes them. In particular INT_IN=
VERT.
> > > > > > =20
> > > > > Why do you refer here to INT_INVERT? In this code above I try to =
set
> > > > > SPI to 3 lines. Since this is a SPI configuration, i.e. bus speci=
fic,
> > > > > it happens in adxl345_spi.c. Passing this function to the bus
> > > > > independent adxl345_core.c file allows to configure the bus first.
> > > > > Therefore, I'm using the update function in core masking out the =
SPI
> > > > > filag. =20
> > > >
> > > > Ah. Ok.  It was only intended to mask out the SPI3-wire bit, not the
> > > > other bits that you also masked out.  I thought intent was to leave
> > > > them untouched for some reason.  Given they don't matter in the dri=
ver
> > > > at the moment (no interrupt support) then no problem.
> > > > =20
> > > > >
> > > > > My reason why I try to keep INT_INVERT out is different. There is
> > > > > another driver for the same part in the kernel:
> > > > > ./drivers/input/misc/adxl34x.c - This is a input driver, using the
> > > > > interrupts of the adxl345 for the input device implementation. I
> > > > > assumed, that in the iio implementation there won't be interrupt
> > > > > handling for the adx345, since it is not an input device. Does th=
is
> > > > > make sense? =20
> > > >
> > > > No. You can't use these two drivers at the same time.  They will al=
most
> > > > certainly trample over each other in actually reading channels etc.
> > > >
> > > > Their is some legacy of old drivers in input from a long time back.
> > > > Given this driver clearly doesn't have full functionality yet in II=
O there
> > > > and the different userspace ABI, we've just left the input driver a=
lone.
> > > > =20
> > > Going by the git history gave this impression, too. But it was still a
> > > bit confusing to me.
> > >
> > > The IIO driver so far does not handle any of the interrupt features.
> > > The older driver also seems to support more of the chip's features.
> > > Would it make sense to continue implement/port what's missing -
> > > feature by feature - for the IIO driver in order to make the input
> > > driver obsolete (one day)? =20
> >
> > Yes, though it will be challenging because of the ABI differences.
> > We do have a few cross subsystem bridge drivers, but the few goes we've
> > had at an accel bridge driver haven't made it into the kernel.  In part=
icular
> > we don't have an in kernel interface for threshold events and similar i=
n IIO.
> > It would be easy enough to add one, but no one has ever cared enough to
> > do the work. :(
> > =20
> Perhaps there are easier things (precision, power saving measures,
> etc) of that particular accelerometer to port first. Open issues which
> even I could give a try here. Sounds really exciting to me, though,
> but before I definitely need a bit more experience with community and
> APIs.

That would be great.

>=20
> What do you mean with cross subsystem bridge drivers, or this accel
> bridge driver? I mean, can you provide me with a link to that driver
> to have a look into what direction that is going to?
The last go at this was probably this one.

https://lore.kernel.org/linux-iio/d52cf9ee5944c90c69f6e74a46d844cef51e487e.=
1555362312.git.hns@goldelico.com/

>=20
> Anyway, I really appreciate already your patience with my patches, the
> direct and helpful answers! I appreciate the support. Thinking and
> re-thinking over every particular line of code is really an
> experience. I don't want to go too much into off-topic discussions
> here, if this is not the forum for that, please let me know :)

People used to sometimes be on IRC but I'm not sure anyone is any more :(
I rarely joined because of network restrictions at work.

It's fine to ask questions on this mailing list though.
Nature of kernel development is that people need to get good at skipping
threads they aren't interested in!

Jonathan




>=20
> > Jonathan
> >
> > =20
> > > =20
> > > > > =20
> > > > > > If it doesn't makes sense to write it there, either write that =
bit
> > > > > > every time here, or leave it alone every time.  Not decide on w=
hether
> > > > > > to write the bit based on SPI_3WIRE or not.  As far as I know t=
hey
> > > > > > are unconnected features.
> > > > > > =20
> > > > > I think I did not understand. Could you please specify a bit more?
> > > > > When spi-3wire is configured in the DT it has to be parsed and ha=
ndled
> > > > > in the bus specific part, i.e. the adxl345_spi.c Therefore I conf=
igure
> > > > > SPI_3WIRE there. I don't want to place SPI specific code in the c=
ore
> > > > > file. =20
> > > >
> > > > My confusion was that you were deliberately not touching the other =
unused
> > > > flags.  In reality you are touching the but only if you enable 3wir=
e.
> > > > I would write them register to 0 in the !3wire case so all other va=
lues
> > > > are the same in both paths.
> > > > =20
> > > > > =20
> > > > > > > +     return 0;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static int adxl345_spi_probe(struct spi_device *spi)
> > > > > > >  {
> > > > > > >       struct regmap *regmap;
> > > > > > > @@ -33,7 +43,7 @@ static int adxl345_spi_probe(struct spi_dev=
ice *spi)
> > > > > > >       if (IS_ERR(regmap))
> > > > > > >               return dev_err_probe(&spi->dev, PTR_ERR(regmap)=
, "Error initializing regmap\n");
> > > > > > >
> > > > > > > -     return adxl345_core_probe(&spi->dev, regmap, NULL);
> > > > > > > +     return adxl345_core_probe(&spi->dev, regmap, adxl345_sp=
i_setup);
> > > > > > >  }
> > > > > > >
> > > > > > >  static const struct adxl345_chip_info adxl345_spi_info =3D {=
 =20
> > > > > > =20
> > > > =20
> > > =20
> > =20


