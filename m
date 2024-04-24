Return-Path: <linux-kernel+bounces-156624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CA88B05E4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 375ED1C22B3B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDBF158D88;
	Wed, 24 Apr 2024 09:18:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D300B158A2E
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950316; cv=none; b=Ux5/I5EwD6+sA05paMFrQ3q3m7rKW4wDYar9shmDpwCrMfLIQ46LxF2Y86PklI6+YVe6ISNdxgxcAoHOfDz28maPoT8YSlPhGhn2GrMTbmRIUxPjLsSqcMhW/uCyun6dYexBlSTzhnVYmssOE1oI6jha6ApZvXY2qzco0lKMMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950316; c=relaxed/simple;
	bh=KhTHcR7I5jCU4l8yeRDg/wvW4kgeyIkmektcoNJMinA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ZKwUgENwIqHnClsalDtsGefqWqFMpxiG5IetCAlzt29f+FJoNIdEBjO3mKY7VwAiFEO8GEdcyRDXqgZ2CMNicgAjuNS2qTQvl292OzhCBiWP0PSfNuuukJEBDRD7ZJZSAxYuQxadtW0+/xynpY8nxIN7SEeUsw9F99EwI3y6rd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-102-z5LuMkZlMxSOMqakJ5rlUg-1; Wed, 24 Apr 2024 10:18:25 +0100
X-MC-Unique: z5LuMkZlMxSOMqakJ5rlUg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 Apr
 2024 10:17:57 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 Apr 2024 10:17:57 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stas Sergeev' <stsp2@yandex.ru>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: Eric Biederman <ebiederm@xmission.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
	<jack@suse.cz>, Andy Lutomirski <luto@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH 1/2] fs: reorganize path_openat()
Thread-Topic: [PATCH 1/2] fs: reorganize path_openat()
Thread-Index: AQHalJJk8Yta93gecEuTWlpT1K4OxbF3JeNw
Date: Wed, 24 Apr 2024 09:17:57 +0000
Message-ID: <858f6fb6afcd450d85d1ff900f82d396@AcuMS.aculab.com>
References: <20240422084505.3465238-1-stsp2@yandex.ru>
In-Reply-To: <20240422084505.3465238-1-stsp2@yandex.ru>
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

From: Stas Sergeev
> Sent: 22 April 2024 09:45

I seem to have 5 copies of this patch.....

> This patch moves the call to alloc_empty_file() below the call to
> path_init(). That changes is needed for the next patch, which adds
> a cred override for alloc_empty_file(). The needed cred info is only
> available after the call to path_init().
>=20
> No functional changes are intended by that patch.
..
> ---
>  fs/namei.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/fs/namei.c b/fs/namei.c
> index c5b2a25be7d0..2fde2c320ae9 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3782,22 +3782,30 @@ static struct file *path_openat(struct nameidata =
*nd,
>  =09struct file *file;
>  =09int error;
>=20
> -=09file =3D alloc_empty_file(op->open_flag, current_cred());
> -=09if (IS_ERR(file))
> -=09=09return file;
> -
> -=09if (unlikely(file->f_flags & __O_TMPFILE)) {
> +=09if (unlikely(op->open_flag & __O_TMPFILE)) {
> +=09=09file =3D alloc_empty_file(op->open_flag, current_cred());
> +=09=09if (IS_ERR(file))
> +=09=09=09return file;
>  =09=09error =3D do_tmpfile(nd, flags, op, file);
> -=09} else if (unlikely(file->f_flags & O_PATH)) {
> +=09} else if (unlikely(op->open_flag & O_PATH)) {
> +=09=09file =3D alloc_empty_file(op->open_flag, current_cred());
> +=09=09if (IS_ERR(file))
> +=09=09=09return file;
>  =09=09error =3D do_o_path(nd, flags, file);

You probably ought to merge the two 'unlikely' tests.
Otherwise there'll be two conditionals in the 'hot path'.
(There probably always were.)
So something like:
=09if (unlikely(op->open_flag & (__O_TMPFILE | O_PATH))) {
=09=09file =3D alloc_empty_file(op->open_flag, current_cred());
=09=09if (IS_ERR(file))
=09=09=09return file;
=09=09if (op->open_flag & __O_TMFILE)
=09=09=09error =3D do_tmpfile(nd, flags, op, file);
=09=09else
=09=09=09error =3D do_o_path(nd, flags, file);
=09} else {
Copying op->open_flag to a local may also generate better code.

=09David
=09=09
>  =09} else {
>  =09=09const char *s =3D path_init(nd, flags);
> -=09=09while (!(error =3D link_path_walk(s, nd)) &&
> -=09=09       (s =3D open_last_lookups(nd, file, op)) !=3D NULL)
> -=09=09=09;
> +=09=09file =3D alloc_empty_file(op->open_flag, current_cred());
> +=09=09error =3D PTR_ERR_OR_ZERO(file);
> +=09=09if (!error) {
> +=09=09=09while (!(error =3D link_path_walk(s, nd)) &&
> +=09=09=09       (s =3D open_last_lookups(nd, file, op)) !=3D NULL)
> +=09=09=09=09;
> +=09=09}
>  =09=09if (!error)
>  =09=09=09error =3D do_open(nd, file, op);
>  =09=09terminate_walk(nd);
> +=09=09if (IS_ERR(file))
> +=09=09=09return file;
>  =09}
>  =09if (likely(!error)) {
>  =09=09if (likely(file->f_mode & FMODE_OPENED))
> --
> 2.44.0
>=20

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


