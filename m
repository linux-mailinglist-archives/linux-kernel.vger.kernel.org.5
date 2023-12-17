Return-Path: <linux-kernel+bounces-2771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE0681618F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 19:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406331F21DA5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 18:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFCEF47F51;
	Sun, 17 Dec 2023 18:11:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767A481BE
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 18:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mtapsc-8-8i7rSkpZMKS305nSrnFEhQ-1; Sun, 17 Dec 2023 18:11:13 +0000
X-MC-Unique: 8i7rSkpZMKS305nSrnFEhQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Dec
 2023 18:10:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Dec 2023 18:10:54 +0000
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
Thread-Index: AQHaLduBo9lhsHug1EOTPi9OJpSM+LCtyBWA
Date: Sun, 17 Dec 2023 18:10:54 +0000
Message-ID: <a210197c479e48778672aa13287eef88@AcuMS.aculab.com>
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

Looking at the old code...

>  1:
> -=09lbu=09t0, 0(t1)
> -=09beqz=09t0, 2f
> -=09addi=09t1, t1, 1
> -=09j=091b

I suspect there is (at least) a two clock stall between
the 'ldu' and 'beqz'.
Allowing for one clock for the 'predicted taken' branch
that is 7 clocks/byte.

Try this one - especially on 32bit:

=09mov=09t0, a0
=09and=09t1, t0, 1
=09sub=09t0, t0, t1
=09bnez=09t1, 2f
1:
=09ldb=09t1, 0(t0)
2:=09ldb=09t2, 1(t0)
=09add=09t0, t0, 2
=09beqz=09t1, 3f
=09bnez=09t2, 1b
=09add=09t0, t0, 1
3:=09sub=09t0, t0, 2
=09sub=09a0, t0, a0
=09ret

Might be 6 clocks for 2 bytes.
The much smaller cache footprint will also help.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


