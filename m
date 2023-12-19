Return-Path: <linux-kernel+bounces-5553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC68818C24
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 17:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2B41F2584D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDFA11F93E;
	Tue, 19 Dec 2023 16:24:44 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4F320323
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 16:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-62-glSPhPVcMzuzOWwj_68aXA-1; Tue, 19 Dec 2023 16:24:32 +0000
X-MC-Unique: glSPhPVcMzuzOWwj_68aXA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 19 Dec
 2023 16:24:17 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 19 Dec 2023 16:24:17 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bo Ye' <bo.ye@mediatek.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>
CC: "yongdong.zhang@mediatek.com" <yongdong.zhang@mediatek.com>, C Cheng
	<C.Cheng@mediatek.com>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH v2] fix overflow in idle exit_latency
Thread-Topic: [PATCH v2] fix overflow in idle exit_latency
Thread-Index: AQHaMimXVH0RYY21AUO99y9pfKPzPrCwyXhw
Date: Tue, 19 Dec 2023 16:24:17 +0000
Message-ID: <e807b180b074419ba4f1d1ff8a4c1a80@AcuMS.aculab.com>
References: <20231219031444.91752-1-bo.ye@mediatek.com>
In-Reply-To: <20231219031444.91752-1-bo.ye@mediatek.com>
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

From: Bo Ye=20
> Sent: 19 December 2023 03:15
>=20
> From: C Cheng <C.Cheng@mediatek.com>
>=20
> In detail:
>=20
> In C language, when you perform a multiplication operation, if
> both operands are of int type, the multiplication operation is
> performed on the int type, and then the result is converted to
> the target type. This means that if the product of int type
> multiplication exceeds the range that int type can represent,
>  an overflow will occur even if you store the result in a
> variable of int64_t type.
>=20
> For a multiplication of two int values, it is better to use
> mul_u32_u32() rather than s->exit_latency_ns =3D s->exit_latency *
> NSEC_PER_USEC to avoid potential overflow happenning.
>=20
> Signed-off-by: C Cheng <C.Cheng@mediatek.com>
> Signed-off-by: Bo Ye <bo.ye@mediatek.com>
> ---
> Change in v2:
> -remove Change-ID
> -correct patch author name
> -replace multiplication of two int values with mul_u32_u32
> -refine commit message
> ---
>  drivers/cpuidle/driver.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cpuidle/driver.c b/drivers/cpuidle/driver.c
> index d9cda7f6ccb9..cf5873cc45dc 100644
> --- a/drivers/cpuidle/driver.c
> +++ b/drivers/cpuidle/driver.c
> @@ -16,6 +16,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/tick.h>
>  #include <linux/cpu.h>
> +#include <linux/math64.h>
>=20
>  #include "cpuidle.h"
>=20
> @@ -187,7 +188,7 @@ static void __cpuidle_driver_init(struct cpuidle_driv=
er *drv)
>  =09=09=09s->target_residency =3D div_u64(s->target_residency_ns, NSEC_PE=
R_USEC);
>=20
>  =09=09if (s->exit_latency > 0)
> -=09=09=09s->exit_latency_ns =3D s->exit_latency * NSEC_PER_USEC;
> +=09=09=09s->exit_latency_ns =3D mul_u32_u32(s->exit_latency, NSEC_PER_US=
EC);

Just force either side of the multiply to a 64bit unsigned type.
The compiler will then DTRT which is likely to be better code than
whatever mul_u32_u32() generates.

In any case is the 'exit_latency' ever going to be greater than 4 seconds?
In which case the 32bit multiply will never overflow.

=09David

>  =09=09else if (s->exit_latency_ns < 0)
>  =09=09=09s->exit_latency_ns =3D  0;
>  =09=09else
> --
> 2.18.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


