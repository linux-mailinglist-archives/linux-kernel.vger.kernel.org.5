Return-Path: <linux-kernel+bounces-2692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898FF816099
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7994CB21753
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 17:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5310845BFE;
	Sun, 17 Dec 2023 17:01:21 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147A044C9B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 17:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-91-vRzNanjRPfeqkSuhywGmvQ-1; Sun, 17 Dec 2023 17:01:07 +0000
X-MC-Unique: vRzNanjRPfeqkSuhywGmvQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Dec
 2023 17:00:48 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Dec 2023 17:00:48 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Ivan Orlov' <ivan.orlov0322@gmail.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>
CC: "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"ajones@ventanamicro.com" <ajones@ventanamicro.com>, "samuel@sholland.org"
	<samuel@sholland.org>, "alexghiti@rivosinc.com" <alexghiti@rivosinc.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"skhan@linuxfoundation.org" <skhan@linuxfoundation.org>
Subject: RE: [PATCH] riscv: lib: Optimize 'strlen' function
Thread-Topic: [PATCH] riscv: lib: Optimize 'strlen' function
Thread-Index: AQHaLduBo9lhsHug1EOTPi9OJpSM+LCttqAA
Date: Sun, 17 Dec 2023 17:00:48 +0000
Message-ID: <86d3947bce1f49c395224998e7d65dc2@AcuMS.aculab.com>
References: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
In-Reply-To: <20231213154530.1970216-1-ivan.orlov0322@gmail.com>
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

From: Ivan Orlov
> Sent: 13 December 2023 15:46
>=20
> The current non-ZBB implementation of 'strlen' function iterates the
> memory bytewise, looking for a zero byte. It could be optimized to use
> the wordwise iteration instead, so we will process 4/8 bytes of memory
> at a time.
...
> 1. If the address is unaligned, iterate SZREG - (address % SZREG) bytes
> to align it.

An alternative is to mask the address and 'or' in non-zero bytes
into the first word - might be faster.

...
> Here you can find the benchmarking results for the VisionFive2 board
> comparing the old and new implementations of the strlen function.
>=20
> Size: 1 (+-0), mean_old: 673, mean_new: 666
> Size: 2 (+-0), mean_old: 672, mean_new: 676
> Size: 4 (+-0), mean_old: 685, mean_new: 659
> Size: 8 (+-0), mean_old: 682, mean_new: 673
> Size: 16 (+-0), mean_old: 718, mean_new: 694
...

Is that 32bit or 64bit?
The word-at-a-time strlen() is typically not worth it for 32bit.

I'd also guess that pretty much all the calls in-kernel are short.
You might try counting as: histogram[ilog2(strlen_result)]++
and seeing what it shows for some workload.
I bet you (a beer if I see you!) that you won't see many over 1k.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


