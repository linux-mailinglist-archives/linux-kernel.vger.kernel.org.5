Return-Path: <linux-kernel+bounces-21898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 434C682963D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E892B1F25F9D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 151A83EA6D;
	Wed, 10 Jan 2024 09:24:05 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B12210B;
	Wed, 10 Jan 2024 09:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T92Nh0wG2z6K8yL;
	Wed, 10 Jan 2024 17:21:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BED65140DEC;
	Wed, 10 Jan 2024 17:23:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 10 Jan
 2024 09:23:41 +0000
Date: Wed, 10 Jan 2024 09:23:40 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: =?ISO-8859-1?Q?M=E5rten?= Lindahl <martenli@axis.com>
CC: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>
Subject: Re: [PATCH] iio: light: vcnl4000: Set ps high definition for
 4040/4200
Message-ID: <20240110092340.00003540@Huawei.com>
In-Reply-To: <58319706-dbc5-4ee9-b894-cecbbd23fc1b@axis.com>
References: <20231221-vcnl4000-ps-hd-v1-1-a024bfb28896@axis.com>
	<20231226161934.52c8d801@jic23-huawei>
	<58319706-dbc5-4ee9-b894-cecbbd23fc1b@axis.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 9 Jan 2024 19:25:25 +0100
M=E5rten Lindahl <martenli@axis.com> wrote:

> On 12/26/23 17:19, Jonathan Cameron wrote:
> > On Thu, 21 Dec 2023 17:33:09 +0100
> > M=E5rten Lindahl<marten.lindahl@axis.com>  wrote:
> > =20
> >> The vcnl4040/vcnl4200 proximity sensor defaults to 12 bit data
> >> resolution, but the chip also supports 16 bit data resolution, which is
> >> called proximity high definition (PS_HD).
> >>
> >> Make the vcnl4040/vcnl4200 proximity sensor use the high definition for
> >> all data readings.
> >>
> >> Signed-off-by: M=E5rten Lindahl<marten.lindahl@axis.com> =20
> Hi Jonathan!
> > Hmm. Was about to apply this and had a nasty thought.  Whilst proximity=
 isn't
> > 'scaled' as such because there is no absolute scale applied, I assume t=
his change
> > divides the effective scale (so what someone may be applying in userspa=
ce) by 16?
> >
> > So this might cause someone a visible userspace regression?
> >
> > If so we may have to report it IIO_VAL_FRACTIONAL with the bottom set t=
o 16
> > so we end up with a suitable fixed point value from sysfs.
> >
> > Jonathan =20
>=20
> Yes, your assumption is correct. And I found that this can easily pass=20
> unnoticed, at least on our HW. To get full 16 bit data width the sensor=20
> needs higher proximity integration time, current, and sample rate, or=20
> else it will give a raw output very close to the 12 bit steps with a=20
> maximum around 4150 compared to 12 bit max 4095. With our HW only few=20
> would notice the difference.
>=20
> Increasing integration time/current/sample rate is already supported=20
> from sysfs, and to get the proper scaling I can use the=20
> IIO_VAL_FRACTIONAL as you suggest, but then I also need to set these=20
> higher values from the beginning (where PS_HD is set) or else sysfs=20
> in_proximity_raw will give output "259.375000000" for 4150, instead of=20
> "4095.937500000" for 65535. If not, userspace will have to change the=20
> values manually before first read can be done.

Ok. Then I think we are fine.

>=20
> Regarding the changed output format, is it ok to change it from "4095"=20
> to "4095.937500000", without making users upset?

Should be fine.  Generic userspace code already has to deal with
fixed point values (treating them as if they were fp) as other drivers will
produce this anyway.   We 'might' break a flakey script, but this is
in the category of hoping no one notices!

Jonathan

>=20
> Kind regards
>=20
> M=E5rten
>=20
> >> ---
> >>   drivers/iio/light/vcnl4000.c | 13 +++++++++++++
> >>   1 file changed, 13 insertions(+)
> >>
> >> diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000=
c
> >> index fdf763a04b0b..4846f3b698b5 100644
> >> --- a/drivers/iio/light/vcnl4000.c
> >> +++ b/drivers/iio/light/vcnl4000.c
> >> @@ -90,6 +90,7 @@
> >>   #define VCNL4040_PS_CONF1_PS_SHUTDOWN	BIT(0)
> >>   #define VCNL4040_PS_CONF2_PS_IT	GENMASK(3, 1) /* Proximity integrati=
on time */
> >>   #define VCNL4040_CONF1_PS_PERS	GENMASK(5, 4) /* Proximity interrupt =
persistence setting */
> >> +#define VCNL4040_PS_CONF2_PS_HD		BIT(11)	/* Proximity high definition=
 */
> >>   #define VCNL4040_PS_CONF2_PS_INT	GENMASK(9, 8) /* Proximity interrup=
t mode */
> >>   #define VCNL4040_PS_CONF3_MPS		GENMASK(6, 5) /* Proximity multi puls=
e number */
> >>   #define VCNL4040_PS_MS_LED_I		GENMASK(10, 8) /* Proximity current */
> >> @@ -345,6 +346,7 @@ static int vcnl4200_set_power_state(struct vcnl400=
0_data *data, bool on)
> >>   static int vcnl4200_init(struct vcnl4000_data *data)
> >>   {
> >>   	int ret, id;
> >> +	u16 regval;
> >>  =20
> >>   	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_DEV_ID);
> >>   	if (ret < 0)
> >> @@ -389,6 +391,17 @@ static int vcnl4200_init(struct vcnl4000_data *da=
ta)
> >>   	mutex_init(&data->vcnl4200_al.lock);
> >>   	mutex_init(&data->vcnl4200_ps.lock);
> >>  =20
> >> +	/* Use 16 bits proximity sensor readings */
> >> +	ret =3D i2c_smbus_read_word_data(data->client, VCNL4200_PS_CONF1);
> >> +	if (ret >=3D 0) {
> >> +		regval =3D (ret | VCNL4040_PS_CONF2_PS_HD);
> >> +		ret =3D i2c_smbus_write_word_data(data->client, VCNL4200_PS_CONF1,
> >> +						regval);
> >> +	}
> >> +
> >> +	if (ret < 0)
> >> +		dev_info(&data->client->dev, "Default to 12 bits sensor data");
> >> +
> >>   	ret =3D data->chip_spec->set_power_state(data, true);
> >>   	if (ret < 0)
> >>   		return ret;
> >>
> >> ---
> >> base-commit: a39b6ac3781d46ba18193c9dbb2110f31e9bffe9
> >> change-id: 20231221-vcnl4000-ps-hd-863f4f8fcea7
> >>
> >> Best regards, =20
>=20


