Return-Path: <linux-kernel+bounces-24014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFF3C82B560
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905DF2837C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 19:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E5456B69;
	Thu, 11 Jan 2024 19:41:30 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B360E56B63
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 19:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-pj7-twXmO1a0C0jMic4vcg-1; Thu, 11 Jan 2024 19:41:15 +0000
X-MC-Unique: pj7-twXmO1a0C0jMic4vcg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 11 Jan
 2024 19:40:57 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 11 Jan 2024 19:40:57 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Chris Down' <chris@chrisdown.name>, "H. Peter Anvin" <hpa@zytor.com>
CC: Peter Zijlstra <peterz@infradead.org>, David Howells
	<dhowells@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "pinskia@gmail.com" <pinskia@gmail.com>
Subject: RE: [PATCH 00/45] C++: Convert the kernel to C++
Thread-Topic: [PATCH 00/45] C++: Convert the kernel to C++
Thread-Index: AQHaRIs8ZglmPXooXEql0bLLyUbXRbDU/wpw
Date: Thu, 11 Jan 2024 19:40:56 +0000
Message-ID: <d1e780dcb9854bd3be3699751272e077@AcuMS.aculab.com>
References: <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
 <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
 <ZZ_hhT6N9tqKuB2c@chrisdown.name>
In-Reply-To: <ZZ_hhT6N9tqKuB2c@chrisdown.name>
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

From: Chris Down
> Sent: 11 January 2024 12:40
>=20
> H. Peter Anvin writes:
> >We already *do* use constructors and *especially* destructors for a
> >lot of objects, we just call them out.
> >
> >Note that modern C++ also has the ability to construct and destruct
> >objects in-place, so allocation and construction/destruction aren't
> >necessarily related.
> >
> >There is no reason you can't do static initialization where possible;
> >even constructors can be evaluated at compile time if they are
> >constexpr.

But the compiler often doesn't - look at the generated code and marvel
at all the constructors for static items.
Oh yes, and all the destructors that pretty much always get called
in the wrong order leading to SIGSEGV on exit().
C++ programs pretty much have close all files and use _exit().

> Side note for the constructor and destructor discussion: should we be mor=
e
> widely marketing the __cleanup() infrastructure that Peter added a year o=
r so
> ago? It likely helps a lot with at least some of these cases. In systemd =
we use
> __attribute__((cleanup)) pretty widely and my experience is that it's mad=
e the
> code a lot easier to both create and consume.

And harder for us 'old fogies' to quickly read for correctness.

IIRC some bugs got committed during some 'simple applications'
because of the real hoops you have to go through to correctly
tidy up a malloc()ed buffer that might be passed on.

I've seen the same issue with some C++ code that was like:
(Pardon my C++ :-)
=09foo =3D new();
=09try {
=09=09add_foo_to_list(foo);
=09} except {
=09=09free(foo);
=09}
The problem is that you have no idea whether the exception was
thrown before or after 'foo' was saved.
Since pretty much everything can 'throw' you really can't tell.
OTOH if add_foo_to_list() returns an error code you can know
(and check) that zero is returned iff the pointer has been saved.

Then there is function and class member overloading.
How may times have you renamed a structure member (etc) and used
the compiler to find out where it is used?
I'm pretty sure that is hard work in C++.

And don't forget the default copy constructor...

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


