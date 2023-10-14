Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4736B7C953F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 18:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233033AbjJNQEJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 12:04:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjJNQEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 12:04:08 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A8A9;
        Sat, 14 Oct 2023 09:04:06 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E03C433C9;
        Sat, 14 Oct 2023 16:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697299446;
        bh=dwA3wJhJqf2VZhYG97S37gtePz/NR/a61GcE/DPC8Eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=i3O7siAfUpTpwULkNDTi8/8z++C4sDIkcJ1Z2Nj3tF8AHdzbgojSRUKeoB6kX0XYw
         CWU5F352MyHGvSDBveWnxzMX5CyDUkHK7MPNx4bOqVjczmceA/KzIEjuAL0bqk4XQX
         +/f+JkmQknWG61+caV9q3RWNtcBaQ9AzaBdlNUWqlE23XJKRY/Dvt9Y0gBH8a+C/CT
         7Y40tPvJbHmciuUoWEIs5pjnUQafYMUwNpuhaFbLnYMF8ihINZ3CTf7199f66xt2q4
         0eBl3377uuj1ZLja1d6ofR+6GxF7fvRLaalmR5blejZxSWeKHQMIy0L13HFR7PN59E
         IHiLDqgbf3Htg==
Date:   Sat, 14 Oct 2023 17:04:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Ramona Gradinariu <ramona.gradinariu@analog.com>,
        nuno.sa@analog.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] drivers: imu: adis16475.c: Remove scan index from
 delta channels
Message-ID: <20231014170421.77eb0bbe@jic23-huawei>
In-Reply-To: <1bbca62efe038e37a6a87f873d71d131d5ebdd2f.camel@gmail.com>
References: <20231012122456.765709-1-ramona.gradinariu@analog.com>
        <20231012122456.765709-2-ramona.gradinariu@analog.com>
        <fa310a081779e92a44756a0b561171e97b7cdbaf.camel@gmail.com>
        <1bbca62efe038e37a6a87f873d71d131d5ebdd2f.camel@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Oct 2023 17:35:02 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Thu, 2023-10-12 at 17:09 +0200, Nuno S=C3=A1 wrote:
> > Hi Ramona,
> >=20
> > There are some odd stuff...
> >=20
> > On Thu, 2023-10-12 at 15:24 +0300, Ramona Gradinariu wrote: =20
> > > Some devices do not support delta angle and delta velocity
> > > burst readings, which means there should be no buffer support
> > > for these types of channels.
> > > A new list of channels is created which contains the delta
> > > channels structures with the scan index equal to -1 to allow
> > > for raw register readings, without buffer support.
> > > This list of channels is assigned to the devices which
> > > do not support delta angle and delta velocity burst
> > > readings.
> > >=20
> > > Fixes: 8f6bc87d67c0 ("iio: imu: adis16475.c: Add delta angle and delt=
a velocity
> > > channels")
> > > Signed-off-by: Ramona Gradinariu <ramona.gradinariu@analog.com>
> > > ---
> > > =C2=A0drivers/iio/imu/adis16475.c | 67 +++++++++++++++++++++++++-----=
-------
> > > =C2=A01 file changed, 46 insertions(+), 21 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> > > index 9af07fec0d89..b7cbe1565aee 100644
> > > --- a/drivers/iio/imu/adis16475.c
> > > +++ b/drivers/iio/imu/adis16475.c
> > > @@ -604,7 +604,15 @@ static int adis16475_write_raw(struct iio_dev *i=
ndio_dev,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DE=
LTA(IIO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 ADIS16475_REG_ ## _mod ## _DELTVEL_L,
> > > ADIS16475_SCAN_DELTVEL_ ## _mod, 32, 32)
> > > =C2=A0
> > > -static const struct iio_chan_spec adis16475_channels[] =3D {
> > > +#define ADIS16475_DELTANG_CHAN_NO_SCAN(_mod) \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(I=
IO_DELTA_ANGL, IIO_MOD_ ## _mod, \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ADIS16475_REG_ ## _mod ## _DELTANG_L, -1, 32, 32)
> > > +
> > > +#define ADIS16475_DELTVEL_CHAN_NO_SCAN(_mod) \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_MOD_CHAN_DELTA(I=
IO_DELTA_VELOCITY, IIO_MOD_ ## _mod, \
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 ADIS16475_REG_ ## _mod ## _DELTVEL_L, -1, 32, 32)
> > > +
> > > +static const struct iio_chan_spec adis16477_channels[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNE=
L(X),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNE=
L(Y),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNE=
L(Z),
> > > @@ -621,6 +629,23 @@ static const struct iio_chan_spec adis16475_chan=
nels[] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_CHAN_SOFT_TIMESTA=
MP(13)
> > > =C2=A0};
> > > =C2=A0
> > > +static const struct iio_chan_spec adis16475_channels[] =3D { =20
> >=20
> > I guess you mean adis16477_channels?
> >  =20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(X),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(Y),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_GYRO_CHANNEL(Z),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(X),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(Y),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_ACCEL_CHANNEL(Z),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_TEMP_CHANNEL(),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_=
SCAN(X),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_=
SCAN(Y),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTANG_CHAN_NO_=
SCAN(Z),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_=
SCAN(X),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_=
SCAN(Y),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_DELTVEL_CHAN_NO_=
SCAN(Z),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0IIO_CHAN_SOFT_TIMESTAMP(7)
> > > +};
> > > +
> > > =C2=A0enum adis16475_variant {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16470,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ADIS16475_1,
> > > @@ -782,8 +807,8 @@ static const struct adis16475_chip_info adis16475=
_chip_info[]
> > > =3D
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16477_1] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "adis16477-1",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16475_channels),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16475_channels,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16477_channels),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16477_channels,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_val =3D 1,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_scale =3D IIO_RAD_TO_DEGREE(160 << 16),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.accel_max_val =3D 1,
> > > @@ -800,8 +825,8 @@ static const struct adis16475_chip_info adis16475=
_chip_info[]
> > > =3D
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16477_2] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "adis16477-2",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16475_channels),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16475_channels,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16477_channels),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16477_channels,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_val =3D 1,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_scale =3D IIO_RAD_TO_DEGREE(40 << 16),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.accel_max_val =3D 1,
> > > @@ -818,8 +843,8 @@ static const struct adis16475_chip_info adis16475=
_chip_info[]
> > > =3D
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16477_3] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "adis16477-3",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16475_channels),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16475_channels,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16477_channels),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16477_channels,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_val =3D 1,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.accel_max_val =3D 1,
> > > @@ -938,8 +963,8 @@ static const struct adis16475_chip_info adis16475=
_chip_info[]
> > > =3D
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16500] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "adis16500",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16475_channels),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16475_channels,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16477_channels),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16477_channels,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_val =3D 1,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.gyro_max_scale =3D IIO_RAD_TO_DEGREE(10 << 16),
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.accel_max_val =3D 392,
> > > @@ -957,8 +982,8 @@ static const struct adis16475_chip_info adis16475=
_chip_info[]
> > > =3D
> > > {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0},
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0[ADIS16505_1] =3D {
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0.name =3D "adis16505-1",
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16475_channels),
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16475_channels,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.num_channels =3D ARRAY_SIZE(adis16477_channels),
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0.channels =3D adis16477_channels, =20
> >=20
> > AFAICS, this supports delta channels in burst mode... right? Please mak=
e sure to go
> > again through the datasheets so we make this right...
> >  =20
>=20
> Alright, I just saw I missed the diff renaming adis16475_channels >
> adis16477_channels. MAybe you could state why you did it in the commit me=
ssage.
> Anyhow:
>=20
> Reviewed-by: Nuno Sa <nuno.sa@analog.com>
>=20
Applied.

