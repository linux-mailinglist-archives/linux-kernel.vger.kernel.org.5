Return-Path: <linux-kernel+bounces-88819-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6290286E723
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:24:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B4541C230CD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABF28BE3;
	Fri,  1 Mar 2024 17:24:46 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02315228
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 17:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709313885; cv=none; b=LymygdJtmWgr9JLnY7VrVVeZ2C9QhGj3d9971RZvCc1ireFbUFJW2T7j76DBF5abTZhxBob8B+yLmct3vrhWooMBds8NPknqNweAa0U242QQGNCQ+K7cke79IRbJ/uC4Hr0TTq0rIX9mObLykjGnZDlfcCwImW1xR31XF/m4XdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709313885; c=relaxed/simple;
	bh=h58DFjaPojLEK3fLX4+ixq3XIVk5I8uJifwq7HQg9ig=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=IPkCSVSMePBErOX3jer5HpzKH4ket3RQQ8oATQj20hYNdudNDbmQJ0regcP0fSGHSYEhyJECcxX/lorwCYgDc1FmVb4U/DAgyw1jpENNosfiYS+75/tF2U5quUdV9Bn0WAu9nNvC8oZWyDgh4IBExfs2wqsBpVpvyxnADX6Gs9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-208-tXp_pUJVPlyy9kGWfCrWjw-1; Fri, 01 Mar 2024 17:24:41 +0000
X-MC-Unique: tXp_pUJVPlyy9kGWfCrWjw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 1 Mar
 2024 17:24:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 1 Mar 2024 17:24:39 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Charlie Jenkins' <charlie@rivosinc.com>, Christophe Leroy
	<christophe.leroy@csgroup.eu>
CC: Guenter Roeck <linux@roeck-us.net>, Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Morton <akpm@linux-foundation.org>, Helge Deller <deller@gmx.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Parisc List
	<linux-parisc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Geert
 Uytterhoeven" <geert@linux-m68k.org>, Russell King <linux@armlinux.org.uk>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Palmer Dabbelt
	<palmer@rivosinc.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Topic: [PATCH v11] lib: checksum: Use aligned accesses for ip_fast_csum
 and csum_ipv6_magic tests
Thread-Index: AQHaa/sz2G6zh0QEYUOonhCQoX0NCrEjHqIg
Date: Fri, 1 Mar 2024 17:24:39 +0000
Message-ID: <3e0e2b25ea2d4ab99e78aff04af94b69@AcuMS.aculab.com>
References: <20240229-fix_sparse_errors_checksum_tests-v11-1-f608d9ec7574@rivosinc.com>
 <41a5d1e8-6f30-4907-ba63-8a7526e71e04@csgroup.eu> <ZeILu9x+/STqWVy+@ghost>
In-Reply-To: <ZeILu9x+/STqWVy+@ghost>
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

From: Charlie Jenkins
> Sent: 01 March 2024 17:09
>=20
> On Fri, Mar 01, 2024 at 07:17:38AM +0000, Christophe Leroy wrote:
> > +CC netdev ARM Russell
> >
> > Le 29/02/2024 =C3=A0 23:46, Charlie Jenkins a =C3=A9crit=C2=A0:
> > > The test cases for ip_fast_csum and csum_ipv6_magic were not properly
> > > aligning the IP header, which were causing failures on architectures
> > > that do not support misaligned accesses like some ARM platforms. To
> > > solve this, align the data along (14 + NET_IP_ALIGN) bytes which is t=
he
> > > standard alignment of an IP header and must be supported by the
> > > architecture.
> >
> > In your description, please provide more details on platforms that have
> > a problem, what the problem is exactly (Failed calculation, slowliness,
> > kernel Oops, panic, ....) on each platform.
> >
> > And please copy maintainers and lists of platforms your are specificall=
y
> > addressing with this change. And as this is network related, netdev lis=
t
> > should have been copied as well.
> >
> > I still think that your patch is not the good approach, it looks like
> > you are ignoring all the discussion. Below is a quote of what Geert sai=
d
> > and I fully agree with that:
> >
> > =09IMHO the tests should validate the expected functionality.  If a tes=
t
> > =09fails, either functionality is missing or behaves wrong, or the test
> > =09is wrong.
> >
> > =09What is the point of writing tests for a core functionality like net=
work
> > =09checksumming that do not match the expected functionality?
> >
> >
> > So we all agree that there is something to fix, because today's test
> > does odd-address accesses which is unexpected for those functions, but
> > 2-byte alignments should be supported hence tested by the test. Limitin=
g
> > the test to a 16-bytes alignment deeply reduces the usefullness of the =
test.
> >
>=20
> Maybe I am lost in the conversations. This isn't limited to 16-bytes
> alignment? It aligns along 14 + NET_IP_ALIGN. That is 16 on some
> platforms and 14 on platforms where unaligned accesses are desired.
> These functions are expected to be called with this offset. Testing with
> any other alignment is not the expected behavior. These tests are
> testing the expected functionality.

Aligned received frames can have a 4 byte VLAN header (or two) removed.
So the alignment of the IP header is either 4n or 4n+2.
If the cpu fault misaligned accesses you really want the alignment
to be 4n.

You pretty much never want to trap and fixup a misaligned access.
Especially in the network stack.
I suspect it is better to do a realignment copy of the entire frame.
At some point the data will be copied again, although you may want
a CBU (crystal ball unit) to decide whether to align on an 8n
or 8n+4 boundary to optimise a later copy.

CPU that support misaligned transfers just make coders sloppy :-)

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


