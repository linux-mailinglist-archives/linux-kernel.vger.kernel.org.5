Return-Path: <linux-kernel+bounces-125759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445DD892BC4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB61C282F2B
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 15:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340DD38FA5;
	Sat, 30 Mar 2024 15:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrmX2loK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6170C381B1;
	Sat, 30 Mar 2024 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711811912; cv=none; b=TVgt+GPdBnHR0xK60bBg2Hc+FSkOIZ/xDdxNvMwbYhGAgBhzNCcmYSa0beepjdPdGoS3idmnNGeepBSYZTpjI6f06MdH3eC2xD4x+etq4+zfbsa7cjPfGf3ltC8gRwPziPMN18uCygJyWajIyfAiUQZS9hGgRF6kC7rIeVfzTso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711811912; c=relaxed/simple;
	bh=xeYmStBqD5EyQ428GGaiyigQwLaLHFrZUspwncdiUjo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sMCWW58fTI3/gflEeOA6tenujFn7b2ptGEDIPGc1Wt6PuRnrRFUgfvrXpu1glOelaMIQMeWE8Zsecy2jc/mViVi/rjxz+VIG5uiqQh56dgXYWO3PoziNnIcgkMginhDX6eaR/k/dahflPSDMiBwRz/yv164U81sVBYOOwRhbXCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrmX2loK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87709C433F1;
	Sat, 30 Mar 2024 15:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711811911;
	bh=xeYmStBqD5EyQ428GGaiyigQwLaLHFrZUspwncdiUjo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jrmX2loKIXLlb+YHC/rU0NWrqfAhBGvDvJqcY311c+9szJJfd9jFNGRQEz+x40OYL
	 gAgO6zmeGBTHIjm1sxp0XIrmlBzmbpOSM1PFQVMtF5OC7et+d9UffSl0DqP+KMSKFe
	 YJL8hwGAPgzW9uG5sW11yDt0OPKqHzLOfHmanhKyjTwkhx8d2s6fb9qN59JsUlAc+V
	 oML9ZWsqRQJPIf5LXvv/RwJq/GDGiW+P8OysYXtzbSN0m/nJ+BA4DrqP2dNEOtqnZP
	 Cmirp/FcaG5UNAblC79OdQzcLBpGEolp8oFjZPNSnprrDY88o93uV+hKj+wIgz00fW
	 JOgfM97jkJcyg==
Date: Sat, 30 Mar 2024 15:18:17 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, eraretuya@gmail.com
Subject: Re: [PATCH v5 1/7] iio: accel: adxl345: Make data_range obsolete
Message-ID: <20240330151817.25c11a5f@jic23-huawei>
In-Reply-To: <CAFXKEHaPcbRMVJTWW0Atg37jqb97JBdPoSmm3gAZEO1Q=SZm9w@mail.gmail.com>
References: <20240327220320.15509-1-l.rubusch@gmail.com>
	<20240327220320.15509-2-l.rubusch@gmail.com>
	<20240328133720.7dfd46b0@jic23-huawei>
	<CAFXKEHaPcbRMVJTWW0Atg37jqb97JBdPoSmm3gAZEO1Q=SZm9w@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 29 Mar 2024 01:03:29 +0100
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> On Thu, Mar 28, 2024 at 2:37=E2=80=AFPM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Wed, 27 Mar 2024 22:03:14 +0000
> > Lothar Rubusch <l.rubusch@gmail.com> wrote:
> > =20
> > > Replace write() data_format by regmap_update_bits(), because bus spec=
ific
> > > pre-configuration may have happened before on the same register. For
> > > further updates to the data_format register then bus pre-configuration
> > > needs to be masked out.
> > >
> > > Remove the data_range field from the struct adxl345_data, because it =
is
> > > not used anymore.
> > >
> > > Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> > > ---
> > >  drivers/iio/accel/adxl345_core.c | 18 ++++++++++++------
> > >  1 file changed, 12 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adx=
l345_core.c
> > > index 8bd30a23e..35df5e372 100644
> > > --- a/drivers/iio/accel/adxl345_core.c
> > > +++ b/drivers/iio/accel/adxl345_core.c
> > > @@ -37,7 +37,15 @@
> > >  #define ADXL345_POWER_CTL_MEASURE    BIT(3)
> > >  #define ADXL345_POWER_CTL_STANDBY    0x00
> > >
> > > +#define ADXL345_DATA_FORMAT_RANGE    GENMASK(1, 0) /* Set the g rang=
e */
> > > +#define ADXL345_DATA_FORMAT_JUSTIFY  BIT(2) /* Left-justified (MSB) =
mode */
> > >  #define ADXL345_DATA_FORMAT_FULL_RES BIT(3) /* Up to 13-bits resolut=
ion */
> > > +#define ADXL345_DATA_FORMAT_SELF_TEST        BIT(7) /* Enable a self=
 test */
> > > +#define ADXL345_DATA_FORMAT_MSK              (ADXL345_DATA_FORMAT_RA=
NGE | \
> > > +                                      ADXL345_DATA_FORMAT_JUSTIFY | =
 \
> > > +                                      ADXL345_DATA_FORMAT_FULL_RES |=
 \
> > > +                                      ADXL345_DATA_FORMAT_SELF_TEST)=
 =20
> > This needs renaming.  It's not a mask of everything in the register, or
> > even just of everything related to format.
> >
> > Actually I'd just not have this definition.  Use the build up value
> > from all the submasks at the call site.  Then we are just making it cle=
ar
> > only a subset of fields are being cleared.
> > =20
> I understand this solution was not very useful. I'm not sure, I
> understood you correctly. Please have a look into v6 if this matches
> your comment.
> Now, I remove the mask, instead I use a local variable in core's
> probe() for the update mask. I added a comment. Nevertheless, I keep
> the used flags for FORMAT_DATA. Does this go into the direction of
> using the build up value from the submasks at the call site?
>=20
The new code looks good to me.  A local variable doesn't carry the
same implication of global applicability as the define did.
Thanks,

J
> > Jonathan
> > =20
> > > +
> > >  #define ADXL345_DATA_FORMAT_2G               0
> > >  #define ADXL345_DATA_FORMAT_4G               1
> > >  #define ADXL345_DATA_FORMAT_8G               2
> > > @@ -48,7 +56,6 @@
> > >  struct adxl345_data {
> > >       const struct adxl345_chip_info *info;
> > >       struct regmap *regmap;
> > > -     u8 data_range;
> > >  };
> > >
> > >  #define ADXL345_CHANNEL(index, axis) {                              =
         \
> > > @@ -218,15 +225,14 @@ int adxl345_core_probe(struct device *dev, stru=
ct regmap *regmap)
> > >
> > >       data =3D iio_priv(indio_dev);
> > >       data->regmap =3D regmap;
> > > -     /* Enable full-resolution mode */
> > > -     data->data_range =3D ADXL345_DATA_FORMAT_FULL_RES;
> > >       data->info =3D device_get_match_data(dev);
> > >       if (!data->info)
> > >               return -ENODEV;
> > >
> > > -     ret =3D regmap_write(data->regmap, ADXL345_REG_DATA_FORMAT,
> > > -                        data->data_range);
> > > -     if (ret < 0)
> > > +     /* Enable full-resolution mode */
> > > +     ret =3D regmap_update_bits(regmap, ADXL345_REG_DATA_FORMAT,
> > > +                              ADXL345_DATA_FORMAT_MSK, ADXL345_DATA_=
FORMAT_FULL_RES);
> > > +     if (ret)
> > >               return dev_err_probe(dev, ret, "Failed to set data rang=
e\n");
> > >
> > >       indio_dev->name =3D data->info->name; =20
> > =20


