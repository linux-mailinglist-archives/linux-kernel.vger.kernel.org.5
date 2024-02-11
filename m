Return-Path: <linux-kernel+bounces-60795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE04850986
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 14:57:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1ED7EB211F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6EC5B5BD;
	Sun, 11 Feb 2024 13:57:39 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887395B5AC
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 13:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707659859; cv=none; b=dnIxG4BEEwyxrTXRCv7GqZflaW6PGjWUAJXkbagCQNABS2fvWJuBog2g16ALmLjywGr2+bi7Bb62jU0bY3y5vI/qwc8rb4/99s/DZXVNP8L4lGKEI4dLHey9EG5a4Y5eh9zR9LwiVR9UK43G/145hxNU6LNT9jF4dZkoQzivGsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707659859; c=relaxed/simple;
	bh=WWvIqMIjphjCfTvYnHbPsiEseK6ecWXtq45WGP3iziI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=pZtkyiNtY/wWTdTcKtvD8Mbb6e4MgWYgyyPX0bPBQrOcx7BkyItuau7LcGHrkr+MytFRGkvVTYecNAc++iqArl2OJuswH/zJ5BrgQYqkVYwrix4rGO+pF7/plqoZbSQFaoiLLwKGxMBpXHsexrIlS3iW8vQzj/xf3W8yRRretUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-aNO8RYdFPpWbb_CKU1AkFQ-1; Sun, 11 Feb 2024 13:57:26 +0000
X-MC-Unique: aNO8RYdFPpWbb_CKU1AkFQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 11 Feb
 2024 13:57:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 11 Feb 2024 13:57:02 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guenter Roeck' <linux@roeck-us.net>, Helge Deller <deller@gmx.de>
CC: "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Charlie
 Jenkins" <charlie@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
Subject: RE: [PATCH] parisc: Fix csum_ipv6_magic on 32-bit systems
Thread-Topic: [PATCH] parisc: Fix csum_ipv6_magic on 32-bit systems
Thread-Index: AQHaXFWRp9eVLmaVBEGREYhx6VwfXbEFKwHA
Date: Sun, 11 Feb 2024 13:57:01 +0000
Message-ID: <dae9f9c428a242368d47ba29561e9455@AcuMS.aculab.com>
References: <20240210191556.3761064-1-linux@roeck-us.net>
In-Reply-To: <20240210191556.3761064-1-linux@roeck-us.net>
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

From: Guenter Roeck
> Sent: 10 February 2024 19:16
>=20
> Calculating the IPv6 checksum on 32-bit systems missed overflows when
> adding the proto+len fields into the checksum. This results in the
> following unit test failure.
>=20
>     # test_csum_ipv6_magic: ASSERTION FAILED at lib/checksum_kunit.c:506
>     Expected ( u64)csum_result =3D=3D ( u64)expected, but
>         ( u64)csum_result =3D=3D 46722 (0xb682)
>         ( u64)expected =3D=3D 46721 (0xb681)
>     not ok 5 test_csum_ipv6_magic
>=20
> This is probably rarely seen in the real world because proto+len are
> usually small values which will rarely result in overflows when calculati=
ng
> the checksum. However, the unit test code uses large values for the lengt=
h
> field, causing the test to fail.

Isn't length limited by the protocol encoding?
So this is really a bug in the unit tests for using a length that
it too large for the function?

=09David

>=20
> Fix the problem by adding the missing carry into the final checksum.
>=20
> Cc: Charlie Jenkins <charlie@rivosinc.com>
> Cc: Palmer Dabbelt <palmer@rivosinc.com>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  arch/parisc/include/asm/checksum.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/parisc/include/asm/checksum.h b/arch/parisc/include/asm=
/checksum.h
> index f705e5dd1074..e619e67440db 100644
> --- a/arch/parisc/include/asm/checksum.h
> +++ b/arch/parisc/include/asm/checksum.h
> @@ -163,7 +163,8 @@ static __inline__ __sum16 csum_ipv6_magic(const struc=
t in6_addr *saddr,
>  "=09ldw,ma=09=094(%2), %7\n"=09/* 4th daddr */
>  "=09addc=09=09%6, %0, %0\n"
>  "=09addc=09=09%7, %0, %0\n"
> -"=09addc=09=09%3, %0, %0\n"=09/* fold in proto+len, catch carry */
> +"=09addc=09=09%3, %0, %0\n"=09/* fold in proto+len */
> +"=09addc=09=090, %0, %0\n"=09/* add carry */
>=20
>  #endif
>  =09: "=3Dr" (sum), "=3Dr" (saddr), "=3Dr" (daddr), "=3Dr" (len),
> --
> 2.39.2
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


