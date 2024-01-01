Return-Path: <linux-kernel+bounces-13949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 807AC82157B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 22:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C71F1F2146D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 21:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99F16E56A;
	Mon,  1 Jan 2024 21:47:54 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CE5E542
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 21:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-284-gOA7zgZwMQSLg4lQ6zD55Q-1; Mon, 01 Jan 2024 21:47:48 +0000
X-MC-Unique: gOA7zgZwMQSLg4lQ6zD55Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 1 Jan
 2024 21:47:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 1 Jan 2024 21:47:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guoxin Pu' <pugokushin@gmail.com>, "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] block: fix length of strscpy()
Thread-Topic: [PATCH] block: fix length of strscpy()
Thread-Index: AQHaPNtiMZZ0F2vqTUGoSDgTJCHi3bDFesXA
Date: Mon, 1 Jan 2024 21:47:23 +0000
Message-ID: <ed0b9dd45fca4f6e910a9e1ffa756180@AcuMS.aculab.com>
References: <20240101175051.38479-2-pugokushin@gmail.com>
In-Reply-To: <20240101175051.38479-2-pugokushin@gmail.com>
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

From: Guoxin Pu
> Sent: 01 January 2024 17:51
>=20
> In commit 146afeb235ccec10c17ad8ea26327c0c79dbd968 ("block: use strscpy()
> to instead of strncpy()") , the length that should now represent the leng=
th
> of the string with the terminating NULL was not updated alongside the
> change.
>=20
> This has caused blkdevparts=3D definition on kernel cmdline to be not
> correctly recognized and partitions not correctly initialized, breaking a=
ny
> device relying on such partitions to boot, on stable releases since 6.6
>=20
> This patch fixes the lengths to contain the terminating NULL.
>=20
> Cc: stable@vger.kernel.org # 6.6.x
> Signed-off-by: Guoxin Pu <pugokushin@gmail.com>
> ---
>  block/partitions/cmdline.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/block/partitions/cmdline.c b/block/partitions/cmdline.c
> index c03bc105e575..c2aac5f4ab82 100644
> --- a/block/partitions/cmdline.c
> +++ b/block/partitions/cmdline.c
> @@ -79,8 +79,8 @@ static int parse_subpart(struct cmdline_subpart **subpa=
rt, char *partdef)
>  =09=09=09goto fail;
>  =09=09}
>=20
> -=09=09length =3D min_t(int, next - partdef,
> -=09=09=09       sizeof(new_subpart->name) - 1);
> +=09=09length =3D min_t(int, next - partdef + 1,
> +=09=09=09       sizeof(new_subpart->name));
>  =09=09strscpy(new_subpart->name, partdef, length);

Shouldn't that be a memcpy() with the original length?
Since it looks as though there is something equivalent to:
=09=09next =3D strchr(partdef, ',');
just above?
Maybe with:
=09=09new_subpart->name[length] =3D '\0';
if the target isn't zero filled (which the strncpy() probably
relied on.)

> @@ -138,7 +138,7 @@ static int parse_parts(struct cmdline_parts **parts, =
const char *bdevdef)
>  =09=09goto fail;
>  =09}
>=20
> -=09length =3D min_t(int, next - bdevdef, sizeof(newparts->name) - 1);
> +=09length =3D min_t(int, next - bdevdef + 1, sizeof(newparts->name));
>  =09strscpy(newparts->name, bdevdef, length);

Same.

> @@ -148,8 +148,8 @@ static int parse_parts(struct cmdline_parts **parts, =
const char *bdevdef)
>  =09=09bdevdef =3D next;
>  =09=09next =3D strchr(bdevdef, ',');
>=20
> -=09=09length =3D (!next) ? (sizeof(buf) - 1) :
> -=09=09=09min_t(int, next - bdevdef, sizeof(buf) - 1);
> +=09=09length =3D (!next) ? sizeof(buf) :
> +=09=09=09min_t(int, next - bdevdef + 1, sizeof(buf));
>=20
>  =09=09strscpy(buf, bdevdef, length);

Same

> @@ -262,7 +262,7 @@ static int add_part(int slot, struct cmdline_subpart =
*subpart,
>=20
>  =09info =3D &state->parts[slot].info;
>=20
> -=09label_min =3D min_t(int, sizeof(info->volname) - 1,
> +=09label_min =3D min_t(int, sizeof(info->volname),
>  =09=09=09  sizeof(subpart->name));
>  =09strscpy(info->volname, subpart->name, label_min);

WTF?
That only makes any sense if subpart->name might not be '\0'
terminated - which strncpy() would have handled fine (with the -1).
Otherwise what is wrong with:
=09strscpy(info->volname, subpart->name, sizeof (info->volname));

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


