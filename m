Return-Path: <linux-kernel+bounces-4235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EC2817972
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:14:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014581F24C32
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49945D74A;
	Mon, 18 Dec 2023 18:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3bW0+VZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D153A1A8;
	Mon, 18 Dec 2023 18:14:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5398CC433C8;
	Mon, 18 Dec 2023 18:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702923282;
	bh=IAcbyWh2VcqOIOQ3rTJ3BbMr4aaM/6S9Do49CCQkemo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l3bW0+VZkzMl3rOqtt1pnAVTExQMgJpy0rtXcGPBSJjfdg8IQcSavbRLAcOhD8Lv4
	 rpl3CyECQA31elgyTURlcCPxzd8nwLgJK5ngbJputFmt05Sh3bnEuF7oJR2lRMg4Ye
	 KYWAmFwpJTTbc59t+b+xuav1vGnB3d/L4OCZ/UJ1SPJzItgTUwSZ33sMWrLI3IJpNZ
	 jnt9AZBa6x9YXMeAVhZMVXsKuNju2M892qzTRLDFxEz2uXsKlXuK41w5T4MW84DcPt
	 AwYQF70F69llYB5nT9QcYtY+NlploonaIahAKyJyZkSyZuozc6XwesIzpLiCtxuJHY
	 18ZMCZ5keYD5Q==
Date: Mon, 18 Dec 2023 18:14:30 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: =?UTF-8?B?TcOlcnRlbg==?= Lindahl <martenli@axis.com>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
 kernel@axis.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: vcnl4000: Add ps high definition for
 vcnl4040
Message-ID: <20231218181430.0ed55749@jic23-huawei>
In-Reply-To: <9469ccaa-d05a-1c9d-4350-841de7c03ae0@axis.com>
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
	<20231212-vcnl4000-ps-hd-v1-2-1c62a95828c0@axis.com>
	<20231217141554.04c8863d@jic23-huawei>
	<45bb38c9-63f9-101e-60e5-36037699f11e@axis.com>
	<9469ccaa-d05a-1c9d-4350-841de7c03ae0@axis.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 18 Dec 2023 17:00:10 +0100
M=C3=A5rten Lindahl <martenli@axis.com> wrote:

> On 12/18/23 16:19, M=C3=A5rten Lindahl wrote:
> > On 12/17/23 15:15, Jonathan Cameron wrote: =20
> >> On Fri, 15 Dec 2023 13:43:05 +0100
> >> M=C3=A5rten Lindahl <marten.lindahl@axis.com> wrote:
> >> =20
> >>> The vcnl4040 proximity sensor defaults to 12 bit data resolution, but
> >>> the chip also supports 16 bit data resolution, which is called=20
> >>> proximity
> >>> high definition (PS_HD).
> >>>
> >>> Add read/write attribute for proximity resolution, and read attribute
> >>> for available proximity resolution values for the vcnl4040 chip.
> >>>
> >>> Signed-off-by: M=C3=A5rten Lindahl <marten.lindahl@axis.com> =20
> > Hi Jonathan! =20
> >> I'll review this on basis the usecase is clear (see reply to cover=20
> >> letter) =20
> >
> > I'll skip this patch (see reply to cover letter comment)
> >
> > Your are right about the paired register manipulation. Better to=20
> > read/write byte instead of word. =20
>=20
> Hi Jonathan!
>=20
> I now remember why the register is read as a word (CONF1/CONF2). It is=20
> addressed as one 16 bit register where CONF1 is the low 8 bit field and=20
> CONF2 is the high bit field. It is the same address/code for both:
>=20
> Register PS_CONF1 - COMMAND CODE: 0x03_L (0x03 DATA BYTE LOW)
>=20
> Register PS_CONF2 - COMMAND CODE: 0x03_H (0x03 DATA BYTE HIGH)
>=20
> Where in my case (PS_CONF2->PS_HD[3] is the same as PS_CONF1[11])
Ouch. That's a horrible way to define a register map.

Jonathan

>=20
> Kind regards
>=20
> M=C3=A5rten
>=20
> >
> > Kind regards
> >
> > M=C3=A5rten
> > =20
> >>
> >> The manipulation of the CONF1 and CONF2 registers in a pair is rather=
=20
> >> odd given you
> >> only want to change one bit here.
> >>
> >> Why is that done? =20
> >>> ---
> >>> =C2=A0 drivers/iio/light/vcnl4000.c | 87=20
> >>> +++++++++++++++++++++++++++++++++++++++++++-
> >>> =C2=A0 1 file changed, 85 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iio/light/vcnl4000.c=20
> >>> b/drivers/iio/light/vcnl4000.c
> >>> index fdf763a04b0b..2addff635b79 100644
> >>> --- a/drivers/iio/light/vcnl4000.c
> >>> +++ b/drivers/iio/light/vcnl4000.c
> >>> @@ -90,6 +90,7 @@
> >>> =C2=A0 #define VCNL4040_PS_CONF1_PS_SHUTDOWN=C2=A0=C2=A0=C2=A0 BIT(0)
> >>> =C2=A0 #define VCNL4040_PS_CONF2_PS_IT=C2=A0=C2=A0=C2=A0 GENMASK(3, 1=
) /* Proximity=20
> >>> integration time */
> >>> =C2=A0 #define VCNL4040_CONF1_PS_PERS=C2=A0=C2=A0=C2=A0 GENMASK(5, 4)=
 /* Proximity=20
> >>> interrupt persistence setting */
> >>> +#define VCNL4040_PS_CONF2_PS_HD=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 BIT(11)=C2=A0=C2=A0=C2=A0 /* Proximity high=20
> >>> definition */
> >>> =C2=A0 #define VCNL4040_PS_CONF2_PS_INT=C2=A0=C2=A0=C2=A0 GENMASK(9, =
8) /* Proximity=20
> >>> interrupt mode */
> >>> =C2=A0 #define VCNL4040_PS_CONF3_MPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 GENMASK(6, 5) /* Proximity=20
> >>> multi pulse number */
> >>> =C2=A0 #define VCNL4040_PS_MS_LED_I=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 GENMASK(10, 8) /* Proximity=20
> >>> current */
> >>> @@ -170,6 +171,11 @@ static const int vcnl4040_ps_calibbias_ua[][2] =
=3D {
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {0, 200000},
> >>> =C2=A0 };
> >>> =C2=A0 +static const int vcnl4040_ps_resolutions[2] =3D {
> >>> +=C2=A0=C2=A0=C2=A0 12,
> >>> +=C2=A0=C2=A0=C2=A0 16
> >>> +};
> >>> +
> >>> =C2=A0 static const int vcnl4040_als_persistence[] =3D {1, 2, 4, 8};
> >>> =C2=A0 static const int vcnl4040_ps_persistence[] =3D {1, 2, 3, 4};
> >>> =C2=A0 static const int vcnl4040_ps_oversampling_ratio[] =3D {1, 2, 4=
, 8};
> >>> @@ -880,6 +886,54 @@ static ssize_t=20
> >>> vcnl4040_write_ps_calibbias(struct vcnl4000_data *data, int val)
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> =C2=A0 }
> >>> =C2=A0 +static ssize_t vcnl4040_read_ps_resolution(struct vcnl4000_da=
ta=20
> >>> *data, int *val, int *val2)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 int ret;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_word_data(data->client, VC=
NL4200_PS_CONF1); =20
> >> The field seems to be in PS_CONF2.=C2=A0 So you are reading a word and=
 I=20
> >> guess that
> >> gets you two registers.=C2=A0 Can we not do a byte read to get just CO=
NF2? =20
> >>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D FIELD_GET(VCNL4040_PS_CONF2_PS_HD, ret);
> >>> +=C2=A0=C2=A0=C2=A0 if (ret >=3D ARRAY_SIZE(vcnl4040_ps_resolutions))
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 *val =3D vcnl4040_ps_resolutions[ret];
> >>> +=C2=A0=C2=A0=C2=A0 *val2 =3D 0;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 return ret;
> >>> +}
> >>> +
> >>> +static ssize_t vcnl4040_write_ps_resolution(struct vcnl4000_data=20
> >>> *data, int val)
> >>> +{
> >>> +=C2=A0=C2=A0=C2=A0 unsigned int i;
> >>> +=C2=A0=C2=A0=C2=A0 int ret;
> >>> +=C2=A0=C2=A0=C2=A0 u16 regval;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < ARRAY_SIZE(vcnl4040_ps_resoluti=
ons); i++) {
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (val =3D=3D vcnl4040_p=
s_resolutions[i])
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 b=
reak;
> >>> +=C2=A0=C2=A0=C2=A0 }
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 if (i >=3D ARRAY_SIZE(vcnl4040_ps_resolutions))
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 mutex_lock(&data->vcnl4000_lock);
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_read_word_data(data->client, VC=
NL4200_PS_CONF1);
> >>> +=C2=A0=C2=A0=C2=A0 if (ret < 0)
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unlock;
> >>> +
> >>> +=C2=A0=C2=A0=C2=A0 regval =3D (ret & ~VCNL4040_PS_CONF2_PS_HD);
> >>> +=C2=A0=C2=A0=C2=A0 regval |=3D FIELD_PREP(VCNL4040_PS_CONF2_PS_HD, i=
);
> >>> +=C2=A0=C2=A0=C2=A0 ret =3D i2c_smbus_write_word_data(data->client, V=
CNL4200_PS_CONF1,
> >>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 regval);
> >>> +
> >>> +out_unlock:
> >>> +=C2=A0=C2=A0=C2=A0 mutex_unlock(&data->vcnl4000_lock);
> >>> +=C2=A0=C2=A0=C2=A0 return ret;
> >>> +} =20
> >> c), =20


