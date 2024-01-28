Return-Path: <linux-kernel+bounces-41622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AABF383F580
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6758328312D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D516B219FC;
	Sun, 28 Jan 2024 12:36:22 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E5A208AD
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706445382; cv=none; b=WAMXVNy7psDx1mdDNtDLQH32v7wEAUHNFp3ZXek7brWZFXPWe3PQt6qfVQ6jBEReE/mrxAtcJNyr0LhJ36zT1tcAlIopdJJ28lqRyDc9s7wYex8vbdxKQHzXnC/PWOGfUqIs3Latta6zN++v88ywK0qoT5DQJjEc43hA5Md5Ne8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706445382; c=relaxed/simple;
	bh=AO5e8HxcukgmlxCKaaT+Yy3hUdVZUwg2ySjru/JA0HM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=E2twj/pH7eENoA04x5bxj+Qm0nLTnh3bVeiCfIFQgVEjuzF90mbolLVml9hA4F9Ioam01ISaRz654EDQMTCegya24jE86qFMQ+sPbCxujV6obk7y3dGI0hEzxEQTxAmvi6rIcvy/sozwWDyY4kmEYj2j76liL8MSkJ8b3RpVvEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-317-Eq0wpz7mO1e21GBJ1oOirA-1; Sun, 28 Jan 2024 12:36:16 +0000
X-MC-Unique: Eq0wpz7mO1e21GBJ1oOirA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 28 Jan
 2024 12:35:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 28 Jan 2024 12:35:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jisheng Zhang' <jszhang@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matteo Croce
	<mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH 1/3] riscv: optimized memcpy
Thread-Topic: [PATCH 1/3] riscv: optimized memcpy
Thread-Index: AQHaUdxgc9Zy837AxkOiZhjgW4/PA7DvJZjg
Date: Sun, 28 Jan 2024 12:35:53 +0000
Message-ID: <dc1f54f90642401ca6135c75e399c06d@AcuMS.aculab.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-2-jszhang@kernel.org>
In-Reply-To: <20240128111013.2450-2-jszhang@kernel.org>
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

From: Jisheng Zhang
> Sent: 28 January 2024 11:10
>=20
> From: Matteo Croce <mcroce@microsoft.com>
>=20
> Write a C version of memcpy() which uses the biggest data size allowed,
> without generating unaligned accesses.
>=20
> The procedure is made of three steps:
> First copy data one byte at time until the destination buffer is aligned
> to a long boundary.
> Then copy the data one long at time shifting the current and the next u8
> to compose a long at every cycle.
> Finally, copy the remainder one byte at time.
>=20
> On a BeagleV, the TCP RX throughput increased by 45%:
..
> +static void __memcpy_aligned(unsigned long *dest, const unsigned long *s=
rc, size_t count)
> +{

You should be able to remove an instruction from the loop by using:
=09const unsigned long *src_lim =3D src + count;
=09for (; src < src_lim; ) {

> +=09for (; count > 0; count -=3D BYTES_LONG * 8) {
> +=09=09register unsigned long d0, d1, d2, d3, d4, d5, d6, d7;

register is completely ignored and pointless.
(More annoyingly auto is also ignored.)

> +=09=09d0 =3D src[0];
> +=09=09d1 =3D src[1];
> +=09=09d2 =3D src[2];
> +=09=09d3 =3D src[3];
> +=09=09d4 =3D src[4];
> +=09=09d5 =3D src[5];
> +=09=09d6 =3D src[6];
> +=09=09d7 =3D src[7];
> +=09=09dest[0] =3D d0;
> +=09=09dest[1] =3D d1;
> +=09=09dest[2] =3D d2;
> +=09=09dest[3] =3D d3;
> +=09=09dest[4] =3D d4;
> +=09=09dest[5] =3D d5;
> +=09=09dest[6] =3D d6;
> +=09=09dest[7] =3D d7;
> +=09=09dest +=3D 8;
> +=09=09src +=3D 8;

There two lines belong in the for (...) statement.

> +=09}
> +}

If you __always_inline the function you can pass &src and &dest
and use the updated pointers following the loop.

I don't believe that risc-v supports 'reg+reg+(imm5<<3)' addressing
(although there is probably space in the instruction for it.
Actually 'reg+reg' addressing could be supported for loads but
not stores - since the latter would require 3 registers be read.

We use the Nios-II cpu in some fpgas. Intel are removing support
in favour of Risc-V - we are thinking of re-implementing Nios-II
ourselves!
I don't think they understand what the cpu get used for!

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


