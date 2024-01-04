Return-Path: <linux-kernel+bounces-17320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28848824BBF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 00:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04621F23701
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 458202D05E;
	Thu,  4 Jan 2024 23:14:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8732D048
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 23:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-Q0Nc1G6uNYuMYDt9Dh6ZJw-1; Thu, 04 Jan 2024 23:14:29 +0000
X-MC-Unique: Q0Nc1G6uNYuMYDt9Dh6ZJw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 23:14:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 4 Jan 2024 23:14:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Himanshu Bhavani' <himanshu.bhavani@siliconsignals.io>,
	"stanimir.k.varbanov@gmail.com" <stanimir.k.varbanov@gmail.com>,
	"quic_vgarodia@quicinc.com" <quic_vgarodia@quicinc.com>, "agross@kernel.org"
	<agross@kernel.org>, "andersson@kernel.org" <andersson@kernel.org>,
	"konrad.dybcio@linaro.org" <konrad.dybcio@linaro.org>, "mchehab@kernel.org"
	<mchehab@kernel.org>, "quic_dikshita@quicinc.com" <quic_dikshita@quicinc.com>
CC: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
	"linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] media: venus: use div64_u64() instead of do_div()
Thread-Topic: [PATCH v2] media: venus: use div64_u64() instead of do_div()
Thread-Index: AQHaPX3MVaPvWYJT1EKa8MVl4SEFLrDKSxLA
Date: Thu, 4 Jan 2024 23:14:15 +0000
Message-ID: <a2baa3220f0e4f64b402f549f13b0671@AcuMS.aculab.com>
References: <20240102131509.1733215-1-himanshu.bhavani@siliconsignals.io>
In-Reply-To: <20240102131509.1733215-1-himanshu.bhavani@siliconsignals.io>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Himanshu Bhavani
> Sent: 02 January 2024 13:15
>=20
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits,
> this means it can test non-zero and be truncated to zero for
> division.
>=20
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64
> instead.

That message is really wrong, it should ask you to check the domains
of the divisor and dividend to ensure the quotient won't exceed 32bits.

I'm not sure about this code, but it looks like the second do_div()
could just be a divide, it is USEC_PER_SEC/n which is well inside 32bits.
The 'n' is the result of the first divide - so that is small as well.

64-by-64 divides are horribly slow on 32bit.
They are even about twice as slow as 64-by-32 on intel x64-64 chips.

=09David

>=20
> Signed-off-by: Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
> ---
>  drivers/media/platform/qcom/venus/venc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/media/platform/qcom/venus/venc.c b/drivers/media/pla=
tform/qcom/venus/venc.c
> index 44b13696cf82..ad6c31c272ac 100644
> --- a/drivers/media/platform/qcom/venus/venc.c
> +++ b/drivers/media/platform/qcom/venus/venc.c
> @@ -409,13 +409,13 @@ static int venc_s_parm(struct file *file, void *fh,=
 struct v4l2_streamparm *a)
>  =09out->capability =3D V4L2_CAP_TIMEPERFRAME;
>=20
>  =09us_per_frame =3D timeperframe->numerator * (u64)USEC_PER_SEC;
> -=09do_div(us_per_frame, timeperframe->denominator);
> +=09us_per_frame =3D div64_u64(us_per_frame, timeperframe->denominator);
>=20
>  =09if (!us_per_frame)
>  =09=09return -EINVAL;
>=20
>  =09fps =3D (u64)USEC_PER_SEC;
> -=09do_div(fps, us_per_frame);
> +=09fps =3D div64_u64(fps, us_per_frame);
>=20
>  =09inst->timeperframe =3D *timeperframe;
>  =09inst->fps =3D fps;
> --
> 2.25.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


