Return-Path: <linux-kernel+bounces-24645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C1F82BFA8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 13:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51B211F21C72
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 12:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808486A02E;
	Fri, 12 Jan 2024 12:16:27 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B08E6A026
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-237-4YI_s87pMKKZUk4f2e5Iig-1; Fri, 12 Jan 2024 12:16:17 +0000
X-MC-Unique: 4YI_s87pMKKZUk4f2e5Iig-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 12 Jan
 2024 12:16:00 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 12 Jan 2024 12:16:00 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Dan Carpenter' <dan.carpenter@linaro.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, 'Andy Shevchenko'
	<andriy.shevchenko@linux.intel.com>, 'Andrew Morton'
	<akpm@linux-foundation.org>, "'Matthew Wilcox (Oracle)'"
	<willy@infradead.org>, 'Christoph Hellwig' <hch@infradead.org>, "'Jason A.
 Donenfeld'" <Jason@zx2c4.com>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhbL6D2AAAV0aXA=
Date: Fri, 12 Jan 2024 12:16:00 +0000
Message-ID: <97e6fe43318b4cad865feadace402880@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <918545c4-0870-4ea5-ab11-53eaed91aec7@moroto.mountain>
In-Reply-To: <918545c4-0870-4ea5-ab11-53eaed91aec7@moroto.mountain>
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
> Sent: 12 January 2024 09:13
>=20
> I've often wondered why so many people use min_t(int, size, limit) when
> they really do not want negative sizes...  Is there a performance reason?
> git grep 'min_t(int,' says there are 872 instances of this.  Probably
> some do want negatives but it's a quite small percent.

But you really don't a negative 'size' converted to a large
unsigned value above the limit - that would be worse.
All the type checking is there to stop that happening.

Even with my changes min(int_var, sizeof()) is a compile error.
To do otherwise would really requite the sizeof() to be converted
to int - leaving the other type alone.
Easiest done by using 'int' instead of 'typeof(y)' for the
local variable inside cmp_once().

However Linus didn't like that change so I removed it from the
version that got committed.
It would also bloat the expansion even more.
That could be reduced by expecting min(var, const) not min(const, var)
and only doing all the constant checks on the second argument.

FWIW min_t() should really skip all the type checks.
Once both value have been cast the 'same type' test will pass.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


