Return-Path: <linux-kernel+bounces-26229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FE682DD13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 17:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10034B21A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 16:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8365717BA3;
	Mon, 15 Jan 2024 16:10:35 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BDA17BA4;
	Mon, 15 Jan 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TDH9R1xYwz67pnj;
	Tue, 16 Jan 2024 00:07:55 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D1F801400CD;
	Tue, 16 Jan 2024 00:10:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 15 Jan
 2024 16:10:29 +0000
Date: Mon, 15 Jan 2024 16:10:28 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
CC: Jonathan Cameron <jic23@kernel.org>, Matti Vaittinen
	<matti.vaittinen@fi.rohmeurope.com>, Lars-Peter Clausen <lars@metafoo.de>,
	<linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: test: test gain-time-scale helpers
Message-ID: <20240115161028.0000771b@Huawei.com>
In-Reply-To: <ff962e6a-5e2b-4a72-9043-80b8fc218642@gmail.com>
References: <cover.1704881096.git.mazziesaccount@gmail.com>
	<6b839dd533fd93b75c2e6f6a8f2286233d4901fb.1704881096.git.mazziesaccount@gmail.com>
	<20240113161229.48d63b54@jic23-huawei>
	<ff962e6a-5e2b-4a72-9043-80b8fc218642@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 15 Jan 2024 15:01:32 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 1/13/24 18:12, Jonathan Cameron wrote:
> > On Wed, 10 Jan 2024 12:12:55 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> Some light sensors can adjust both the HW-gain and integration time.
> >> There are cases where adjusting the integration time has similar impact
> >> to the scale of the reported values as gain setting has.
> >>
> >> IIO users do typically expect to handle scale by a single writable 'sc=
ale'
> >> entry. Driver should then adjust the gain/time accordingly.
> >>
> >> It however is difficult for a driver to know whether it should change
> >> gain or integration time to meet the requested scale. Usually it is
> >> preferred to have longer integration time which usually improves
> >> accuracy, but there may be use-cases where long measurement times can =
be
> >> an issue. Thus it can be preferable to allow also changing the
> >> integration time - but mitigate the scale impact by also changing the =
gain
> >> underneath. Eg, if integration time change doubles the measured values,
> >> the driver can reduce the HW-gain to half.
> >>
> >> The theory of the computations of gain-time-scale is simple. However,
> >> some people (undersigned) got that implemented wrong for more than onc=
e.
> >> Hence some gain-time-scale helpers were introduced.
> >>
> >> Add some simple tests to verify the most hairy functions.
> >>
> >> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> >> =20
>=20
> ...
>=20
> >> +static void test_iio_gts_chk_scales_all(struct kunit *test, struct ii=
o_gts *gts,
> >> +					const int *vals, int len)
> >> +{
> >> +	static const int gains[] =3D {1, 2, 4, 8, 16, 32, 64, 128, 256, 512,
> >> +				    1024, 2048, 4096, 4096 * 2, 4096 * 4,
> >> +				    4096 * 8};
> >> +
> >> +	int expected[ARRAY_SIZE(gains) * 2];
> >> +	int i, ret;
> >> +	int exp_len =3D ARRAY_SIZE(gains) * 2; =20
> >=20
> > Use this for expected[*] just above? =20
>=20
> Doing:
> const int exp_len =3D ARRAY_SIZE(gains) * 2;
> int expected[exp_len];
>=20
> gives me:
> warning: ISO C90 forbids variable length array =E2=80=98expected=E2=80=99=
 [-Wvla]

Huh.  That's a compiler being impressively stupid :(

Just leave it as it is - maybe add a comment to so no one tries to tidy this
up in future.

>=20
> I could drop the whole exp_len variable, but I prefer test code which is=
=20
> as obvious as it gets if any of the checks fails. For me the check:
>=20
> >> +	KUNIT_EXPECT_EQ(test, exp_len, len);
> >> +	if (len !=3D exp_len)
> >> +		return; =20
>=20
> is (very slightly) more obvious than:
> 	KUNIT_EXPECT_EQ(test, ARRAY_SIZE(gains) * 2, len);
> 	if (len !=3D ARRAY_SIZE(gains) * 2)
> 		return;
>=20
> I guess I'll leave this one as it is. Just kick me in v2 if I=20
> misunderstood you :)

yeah, leave it be. Annoying but such is life.

>=20
> Yours,
> 	-- Matti
>=20


