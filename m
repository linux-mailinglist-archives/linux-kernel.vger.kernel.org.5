Return-Path: <linux-kernel+bounces-147502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CD68A7559
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 22:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52D961C21490
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 20:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FCD13A3F1;
	Tue, 16 Apr 2024 20:15:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171BF13A268
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 20:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713298511; cv=none; b=m2Ta6kGZ3tWOAWKzOAzuvsWeoMBd4xng6j7SvuNa0JMVW1OcoGVwAylFVDDdQSh1g7t5DmPBILeIwwIw514cK86Q42tmZKca+awC52ES40S4J9M1mJP+ENf9EXryXzTvAgDmjUGchFDsdrQwBEA5hBPqm9ZYP7Ji9AM6zW94FzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713298511; c=relaxed/simple;
	bh=QHDQvpmFVQmHfJ2aNgRHZis+P6sH6L/hgIndKA5ZuZc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=eSdBiVX8XWk8tiYUlESWmIDYsOuJZtUgIYFNf1uLWcVGPYe2qQw+Wh4wzwMF19Ku/ADQxe0ixrx9w59IrUocUPhlMzz7I4BrcOOPULdJ12pb/Z8+7FI1RBWGOXP/nY3tS1UxJSwI6xROvomSOZnqTdWnszBTJccjX5/7UnCV3s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-75-YNCqmdABMIS6_gAQ64gZww-1; Tue, 16 Apr 2024 21:15:06 +0100
X-MC-Unique: YNCqmdABMIS6_gAQ64gZww-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 16 Apr
 2024 21:14:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 16 Apr 2024 21:14:37 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Al Viro' <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 002/437] fs: add generic read/write iterator helpers
Thread-Topic: [PATCH 002/437] fs: add generic read/write iterator helpers
Thread-Index: AQHaj28btiR/XG2LCk2zcJQBF8Y/qLFrUuuQ
Date: Tue, 16 Apr 2024 20:14:37 +0000
Message-ID: <72c1e82b9f274b4f8f217bdd624a1c88@AcuMS.aculab.com>
References: <20240411153126.16201-1-axboe@kernel.dk>
 <20240411153126.16201-3-axboe@kernel.dk> <20240415195504.GU2118490@ZenIV>
In-Reply-To: <20240415195504.GU2118490@ZenIV>
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

From: Al Viro
> Sent: 15 April 2024 20:55
>=20
> On Thu, Apr 11, 2024 at 09:12:22AM -0600, Jens Axboe wrote:
>=20
> > +/* generic read side helper for drivers converting to ->read_iter() */
> > +ssize_t vfs_read_iter(struct kiocb *iocb, struct iov_iter *to,
> > +=09=09      ssize_t (*read)(struct file *, char __user *,
> > +=09=09=09=09     size_t, loff_t *))
> > +{
> > +=09return do_loop_readv(iocb->ki_filp, to, &iocb->ki_pos, 0, read);
> > +}
> > +EXPORT_SYMBOL(vfs_read_iter);
> > +
> > +/* generic write side helper for drivers converting to ->write_iter() =
*/
> > +ssize_t vfs_write_iter(struct kiocb *iocb, struct iov_iter *from,
> > +=09=09       ssize_t (*write)(struct file *, const char __user *,
> > +=09=09=09=09       size_t, loff_t *))
> > +{
> > +=09return do_loop_writev(iocb->ki_filp, from, &iocb->ki_pos, 0, write)=
;
> > +}
> > +EXPORT_SYMBOL(vfs_write_iter);
>=20
> Wait a minute; just what do you expect to happen if that ever gets called
> for ITER_BVEC or ITER_XARRAY?

The extra indirect call is also going to be noticeable.
You need a code loop with a direct call.
That probably requires the loop to be a #define.

I was also thinking about drivers that only handle 'user' buffers and
where there really isn't a requirement to do anything else.

I've a driver that basically does:
=09if (!access_ok(....))
=09=09return -EFAULT;
=09for (off =3D 0; off < len; off +=3D 8) {
=09=09if (__put_user(readq(io_addr + off), uaddr + off))
=09=09=09return -EFAULT;
=09}

Any non-trivial change requires a function that return the first/only
user buffer address/length and an error for a non-user address.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


