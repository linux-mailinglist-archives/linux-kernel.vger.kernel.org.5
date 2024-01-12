Return-Path: <linux-kernel+bounces-24696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9631482C0FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 14:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCBA91C21FAA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0159C6D1AA;
	Fri, 12 Jan 2024 13:40:53 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1C422078
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 13:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-59-KMGKIIC8M1moeEv-VAPOQQ-1; Fri, 12 Jan 2024 13:40:47 +0000
X-MC-Unique: KMGKIIC8M1moeEv-VAPOQQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 12 Jan
 2024 13:40:30 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 12 Jan 2024 13:40:30 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Andrew Morton'
	<akpm@linux-foundation.org>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>, "'Jason A.
 Donenfeld'" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 1/5] minmax: Add umin(a, b) and umax(a, b)
Thread-Topic: [PATCH next v4 1/5] minmax: Add umin(a, b) and umax(a, b)
Thread-Index: AdnqCG3fyWBHnOXsRX2exERoRDa2+hbTWv2AAAC2xJA=
Date: Fri, 12 Jan 2024 13:40:30 +0000
Message-ID: <8e45b321c49b4c27a61b2db076ed5383@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <41d93ca827a248698ec64bf57e0c05a5@AcuMS.aculab.com>
 <737627fd-b68b-4c9d-8700-f0e0d6d9cec8@moroto.mountain>
In-Reply-To: <737627fd-b68b-4c9d-8700-f0e0d6d9cec8@moroto.mountain>
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

From: Dan Carpenter
> Sent: 12 January 2024 12:50
>=20
> On Mon, Sep 18, 2023 at 08:16:30AM +0000, David Laight wrote:
> > +/**
> > + * umin - return minimum of two non-negative values
> > + *   Signed types are zero extended to match a larger unsigned type.
> > + * @x: first value
> > + * @y: second value
> > + */
> > +#define umin(x, y)=09\
> > +=09__careful_cmp((x) + 0u + 0ul + 0ull, (y) + 0u + 0ul + 0ull, <)
>=20
> Why do we match "a larger unsigned type" instead of ULL_MAX?  Presumably
> it helps performance somehow...  I agree that it's probably fine but I
> would be more comfortable if it skipped UINT_MAX and jumped directly to
> ULONG_MAX.  These days 4 gigs is small potatoes.  The vmalloc() function
> can allocate 4G so we've had integer overflow bugs with this before.

The '+ 0ul*' carefully zero extend signed values without changing
unsigned values.
The compiler detects when it has zero-extended both sides and
uses the smaller compare.
In essence:
=09x + 0u converts 'int' to 'unsigned int'.
=09=09Avoids the sign extension adding 0ul on 64bit.
=09x + 0ul converts a 'long' to 'unsigned long'.
=09=09Avoids the sign extension adding 0ull on 32bit
=09x + 0ull converts a 'long long' to 'unsigned long long'.
You need all three to avoid sign extensions and get an unsigned
compare.
If the type is __int128 (signed or unsigned) then nothing happens.
(which means you can still get a signed v unsigned error.)
You could add in (__uint128)0 on 64bit systems that support it,
but it is so uncommon it really isn't worth the hassle.

Unlike any kind of cast the arithmetic cannot discard high bits.
I've found a few min_t() with dubious types.
One was a real bug found by someone else at much the same time.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


