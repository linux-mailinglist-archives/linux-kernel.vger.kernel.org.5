Return-Path: <linux-kernel+bounces-21872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6510D82959E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B421F2689F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958063A8C6;
	Wed, 10 Jan 2024 09:04:00 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234A63EA70
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 09:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-227-cvEqUs2ROQuHYMHfYB1cFg-1; Wed, 10 Jan 2024 09:03:46 +0000
X-MC-Unique: cvEqUs2ROQuHYMHfYB1cFg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 10 Jan
 2024 09:03:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 10 Jan 2024 09:03:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Stephen Rothwell' <sfr@canb.auug.org.au>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: Jiri Slaby <jirislaby@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AQHaQ4y2AvMQ3gkdSO607JUF4aSKdrDSvaPQ
Date: Wed, 10 Jan 2024 09:03:30 +0000
Message-ID: <ddd07dbe318d451db6897b277e37410f@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
	<18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
	<CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
	<CAHk-=wjE1eLMtkKqTt0XqNSnKAeDagV=WQU+vxHL_wsLuO8Gag@mail.gmail.com>
	<CAHk-=whkGHOmpM_1kNgzX1UDAs10+UuALcpeEWN29EE0m-my=w@mail.gmail.com>
 <20240110171739.2e2d9de0@canb.auug.org.au>
In-Reply-To: <20240110171739.2e2d9de0@canb.auug.org.au>
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

From: Stephen Rothwell
> Sent: 10 January 2024 06:18
>=20
> Hi Linus,
>=20
> On Mon, 8 Jan 2024 13:11:12 -0800 Linus Torvalds <torvalds@linux-foundati=
onorg> wrote:
> >
> > Whee.
>=20
> Yeah.
>=20
> > On my machine, that patch makes an "allmodconfig" build go from
> >
> >     10:41 elapsed
> >
> > to
> >
> >      8:46 elapsed
> >
> > so that min/max type checking is almost 20% of the build time.
> >
> > Yeah, I think we need to get rid of it.
> >
> > Can somebody else confirm similar time differences? Or is it just me?
>=20
> I was hopeful, but:
>=20
> no patch:
>=20
> $ /usr/bin/time make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- -j14=
0 -O -s
> 102460.07user 3710.56system 13:29.05elapsed 13122%CPU (0avgtext+0avgdata =
4023168maxresident)k
> 304inputs+7917056outputs (1998673major+120730959minor)pagefaults 0swaps
>=20
> with patch:
>=20
> $ /usr/bin/time make ARCH=3Dx86_64 CROSS_COMPILE=3Dx86_64-linux-gnu- -j14=
0 -O -s
> 99775.75user 3684.45system 13:12.89elapsed 13048%CPU (0avgtext+0avgdata 2=
217536maxresident)k
> 64inputs+7890304outputs (2104371major+119837267minor)pagefaults 0swaps

That looks like 2500 in 100000 (user) or about 2.5%
I did some rebuilds just changing minmax.h and got just over 1%
for changing __types_ok() to be 1.

I did try a few other things, got some marginal improvements.
But I'm not trying to compile the code with 4 nested calls.

One of the things that does explode it somewhat is the
'return constant for constant' path needed to avoid VLA.
That generates two copies of the expansion.
A separate define for that would help a bit.
Doesn't matter much until you get nested min/max they will hurt.
The other slight annoyance is an extra __builtin_choose_expr()
needed for pointer types - because (void *)1 isn't constant.

min3() was mentioned, but that seems to be a nested expansion.
It would need to be more like clamp() to get any benefit.
(And maybe removing the const-for-const option.)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


