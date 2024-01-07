Return-Path: <linux-kernel+bounces-18983-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89CC58265FC
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 21:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A366A281B00
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 20:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D5E1171F;
	Sun,  7 Jan 2024 20:56:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23A3811717
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 20:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-113-rhjW_AtaOumXa1VZKDggBw-1; Sun, 07 Jan 2024 20:56:17 +0000
X-MC-Unique: rhjW_AtaOumXa1VZKDggBw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 7 Jan
 2024 20:55:55 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 7 Jan 2024 20:55:55 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Matt Jan' <zoo868e@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Herve Codina
	<herve.codina@bootlin.com>, Mark Brown <broonie@kernel.org>, "Matthew Wilcox
 (Oracle)" <willy@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] minmax: allow comparisons of 'long long int' against
 'unsigned char/short/int'
Thread-Topic: [PATCH] minmax: allow comparisons of 'long long int' against
 'unsigned char/short/int'
Thread-Index: AQHaQaWylpjHqQCA1U6JquNKFQXy47DO0q3Q
Date: Sun, 7 Jan 2024 20:55:55 +0000
Message-ID: <b9fcab5c9aa44964ba04ea1ff2b5de59@AcuMS.aculab.com>
References: <20240107201129.6106-1-zoo868e@gmail.com>
In-Reply-To: <20240107201129.6106-1-zoo868e@gmail.com>
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

From: Matt Jan
> Sent: 07 January 2024 20:11
>=20
> Since 'unsigned int' get promoted to 'signed long long int' it is safe
> to compare them against an 'long long int' value.

Yes, but not as below.
That change would allow pretty much everything through since everything
except 'unsigned long long' would be signed.

You'd need a much more complex check and the CPP bloat is pretty
horrid already.

That particular check is there to promote unsigned char/short to
signed int - which always happens.

=09David

>=20
> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> ---
>  include/linux/minmax.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/include/linux/minmax.h b/include/linux/minmax.h
> index 2ec559284a9f..61171286b468 100644
> --- a/include/linux/minmax.h
> +++ b/include/linux/minmax.h
> @@ -37,7 +37,7 @@
>=20
>  #define __types_ok(x, y) =09=09=09=09=09\
>  =09(__is_signed(x) =3D=3D __is_signed(y) ||=09=09=09\
> -=09=09__is_signed((x) + 0) =3D=3D __is_signed((y) + 0) ||=09\
> +=09=09__is_signed((x) + 0ll) =3D=3D __is_signed((y) + 0ll) ||=09\
>  =09=09__is_noneg_int(x) || __is_noneg_int(y))
>=20
>  #define __cmp_op_min <
> --
> 2.34.1
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


