Return-Path: <linux-kernel+bounces-25380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE4182CEEF
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 23:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C84A1283424
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 22:42:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD2C18049;
	Sat, 13 Jan 2024 22:42:40 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7060D297
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 22:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-200-4pJslHwgNHCML3gWKZRAUQ-1; Sat, 13 Jan 2024 22:42:29 +0000
X-MC-Unique: 4pJslHwgNHCML3gWKZRAUQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 13 Jan
 2024 22:42:10 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 13 Jan 2024 22:42:10 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Aurelien Jarno' <aurelien@aurel32.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Bluecherry Maintainers
	<maintainers@bluecherrydvr.com>, Anton Sviridenko
	<anton@corp.bluecherry.net>, Andrey Utkin <andrey_utkin@fastmail.com>,
	"Ismael Luceno" <ismael@iodev.co.uk>, Mauro Carvalho Chehab
	<mchehab@kernel.org>, "open list:SOFTLOGIC 6x10 MPEG CODEC"
	<linux-media@vger.kernel.org>
CC: Linus Torvalds <torvalds@linux-foundation.org>, Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, Andrew Morton'
	<akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>, "Christoph
 Hellwig'" <hch@infradead.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, "Jiri
 Slaby" <jirislaby@gmail.com>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b, a,
 c)
Thread-Topic: [PATCH] media: solo6x10: replace max(a, min(b, c)) by clamp(b,
 a, c)
Thread-Index: AQHaRlAJPCtLgor4JUmidOitnBK4/LDYVB2g
Date: Sat, 13 Jan 2024 22:42:10 +0000
Message-ID: <3c85f81d1b944d4c9ec1cd07504f45db@AcuMS.aculab.com>
References: <20240113183334.1690740-1-aurelien@aurel32.net>
In-Reply-To: <20240113183334.1690740-1-aurelien@aurel32.net>
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

From: Aurelien Jarno
> Sent: 13 January 2024 18:34
>=20
> This patch replaces max(a, min(b, c)) by clamp(b, a, c) in the solo6x10
> driver. This improves the readability and more importantly, for the
> solo6x10-p2m.c file, this reduces on my system (x86-64, gcc 13):
> - the preprocessed size from 121 MiB to 4.5 MiB;
> - the build CPU time from 46.8 s to 1.6 s;
> - the build memory from 2786 MiB to 98MiB.
>=20
> In fine, this allows this relatively simple C file to be built on a
> 32-bit system.
>=20
> Reported-by: Jiri Slaby <jirislaby@gmail.com>
> Closes: https://lore.kernel.org/lkml/18c6df0d-45ed-450c-9eda-95160a2bbb8e=
@gmail.com/
> Cc: stable@vger.kernel.org # v6.7+
> Suggested-by: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>

Reviewed-by: David Laight <David.Laight@ACULAB.COM>

I was about to send the same patch.
Although I'm not sure why the cpu time is so large.
It compiles pretty immediately on my system.
I do have some patches to minmax.h that reduce the .i for the nested
clamp() to around 200k.
Mostly obtained be adding min/max_const() for the few places
that need a constant and min/max_ptr() for pointer types.
Supporting both causes the expansion to be a lot larger.

=09David

> ---
>  drivers/media/pci/solo6x10/solo6x10-offsets.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/drivers/media/pci/solo6x10/solo6x10-offsets.h b/drivers/medi=
a/pci/solo6x10/solo6x10-
> offsets.h
> index f414ee1316f2..fdbb817e6360 100644
> --- a/drivers/media/pci/solo6x10/solo6x10-offsets.h
> +++ b/drivers/media/pci/solo6x10/solo6x10-offsets.h
> @@ -57,16 +57,16 @@
>  #define SOLO_MP4E_EXT_ADDR(__solo) \
>  =09(SOLO_EREF_EXT_ADDR(__solo) + SOLO_EREF_EXT_AREA(__solo))
>  #define SOLO_MP4E_EXT_SIZE(__solo) \
> -=09max((__solo->nr_chans * 0x00080000),=09=09=09=09\
> -=09    min(((__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo)) -=09\
> -=09=09 __SOLO_JPEG_MIN_SIZE(__solo)), 0x00ff0000))
> +=09clamp(__solo->sdram_size - SOLO_MP4E_EXT_ADDR(__solo) -=09\
> +=09      __SOLO_JPEG_MIN_SIZE(__solo),=09=09=09\
> +=09      __solo->nr_chans * 0x00080000, 0x00ff0000)
>=20
>  #define __SOLO_JPEG_MIN_SIZE(__solo)=09=09(__solo->nr_chans * 0x00080000=
)
>  #define SOLO_JPEG_EXT_ADDR(__solo) \
>  =09=09(SOLO_MP4E_EXT_ADDR(__solo) + SOLO_MP4E_EXT_SIZE(__solo))
>  #define SOLO_JPEG_EXT_SIZE(__solo) \
> -=09max(__SOLO_JPEG_MIN_SIZE(__solo),=09=09=09=09\
> -=09    min((__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo)), 0x00ff0000=
))
> +=09clamp(__solo->sdram_size - SOLO_JPEG_EXT_ADDR(__solo),=09\
> +=09      __SOLO_JPEG_MIN_SIZE(__solo), 0x00ff0000)
>=20
>  #define SOLO_SDRAM_END(__solo) \
>  =09(SOLO_JPEG_EXT_ADDR(__solo) + SOLO_JPEG_EXT_SIZE(__solo))
> --
> 2.42.0

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


