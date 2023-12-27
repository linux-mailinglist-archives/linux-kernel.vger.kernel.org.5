Return-Path: <linux-kernel+bounces-11964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B9B481EE46
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 11:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DBDF1C2184B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 10:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292C844373;
	Wed, 27 Dec 2023 10:42:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F229844362
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-50-QI0vpALcOICqpEAYQ6T2Mw-1; Wed, 27 Dec 2023 10:42:11 +0000
X-MC-Unique: QI0vpALcOICqpEAYQ6T2Mw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 27 Dec
 2023 10:41:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 27 Dec 2023 10:41:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jisheng Zhang' <jszhang@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>
CC: "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Biggers
	<ebiggers@kernel.org>, Conor Dooley <conor.dooley@microchip.com>, "Qingfang
 DENG" <dqfext@gmail.com>, Charlie Jenkins <charlie@rivosinc.com>
Subject: RE: [PATCH v4 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Thread-Topic: [PATCH v4 1/2] riscv: introduce RISCV_EFFICIENT_UNALIGNED_ACCESS
Thread-Index: AQHaNu5/tgkH4SyC6kWXjxrDsB1U3bC88TvA
Date: Wed, 27 Dec 2023 10:41:53 +0000
Message-ID: <b289d77481724391ad75c585b82506d7@AcuMS.aculab.com>
References: <20231225044207.3821-1-jszhang@kernel.org>
 <20231225044207.3821-2-jszhang@kernel.org>
In-Reply-To: <20231225044207.3821-2-jszhang@kernel.org>
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
> Sent: 25 December 2023 04:42
>=20
> Some riscv implementations such as T-HEAD's C906, C908, C910 and C920
> support efficient unaligned access, for performance reason we want
> to enable HAVE_EFFICIENT_UNALIGNED_ACCESS on these platforms. To
> avoid performance regressions on other non efficient unaligned access
> platforms, HAVE_EFFICIENT_UNALIGNED_ACCESS can't be globally selected.

How efficient are these EFFICIENT_UNALIGNED_ACCESS ?

For single word accesses it doesn't matter much (since they don't fault).
But for memcpy() (and similar) if they are slightly slow (eg the same
as two aligned accesses) it is likely still worth doing misaligned
transfers for both ends and aligned transfers for the middle.

For example, on modern x86 it really isn't worth worrying about
misaligned transfers of 64bit registers.
AFAICT accesses within a cacheline just use byte enables - so are zero
cost. Accesses that cross cache line boundaries do get split - but the
out-of-order execute, store-buffer and the ability to do two reads in
each clock cycle make the overall cost only just measurable.

Not sure how the various RISC-V cpu compare though.
You might get an extra clock delay a lot more often.
So, while mostly you 'don't care' about the alignment, there may
still be a few places where it does matter.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


