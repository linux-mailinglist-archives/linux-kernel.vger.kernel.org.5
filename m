Return-Path: <linux-kernel+bounces-32213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F0835846
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 23:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EA041F21A9E
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 22:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EE838392;
	Sun, 21 Jan 2024 22:37:01 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B88364CC
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jan 2024 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705876621; cv=none; b=VPK+RzJBWn/Hmj4YKk/ciybtkM4YVuIi9GPlkcCzuCrYVAtUzNDu932k3PTf2UWmwbFo5yyf6s6W31ENd/TWW5IYcGtynjgcF61yo4Y4XJDUlrENNy1CPEKUNv6ID6fRKkQzUYFcm8HPrA1V9yKsE6hK4raleVtQwRwsYbcD6mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705876621; c=relaxed/simple;
	bh=O16/aqlNrhAUy0Rn/zSc/JnlHLjEK/zg8j64i3+6dB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=NAWIu2FPKWdcWiHFAjx4xYpwPUlYXLaFQT+685OtGfS2SDetHdj21wWms7llMj9iU17wFr5Y8oFmmIfx/EvlMVwB3XaB9suztZWA+vCap88s07yCGtpM1B0l9gnJG4IqthKPRZxPNFSgi0VxBR+3c9qb9/YLDAZOljKNLEO3SDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-401-MNGqcb9rMUKaTXBdA2fv9g-1; Sun, 21 Jan 2024 22:36:56 +0000
X-MC-Unique: MNGqcb9rMUKaTXBdA2fv9g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Jan
 2024 22:36:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Jan 2024 22:36:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linuxfoundation.org>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: Thorsten Glaser <tg@debian.org>, Peter Zijlstra <peterz@infradead.org>,
	"x86@kernel.org" <x86@kernel.org>, "rostedt@goodmis.org"
	<rostedt@goodmis.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-toolchains@vger.kernel.org"
	<linux-toolchains@vger.kernel.org>, "jpoimboe@redhat.com"
	<jpoimboe@redhat.com>, "alexei.starovoitov@gmail.com"
	<alexei.starovoitov@gmail.com>, "mhiramat@kernel.org" <mhiramat@kernel.org>
Subject: RE: [PATCH 1/2] x86: Remove dynamic NOP selection
Thread-Topic: [PATCH 1/2] x86: Remove dynamic NOP selection
Thread-Index: AQHaS8IuwT69O5ELs0iiEbIHzsHfJbDk29wg
Date: Sun, 21 Jan 2024 22:36:32 +0000
Message-ID: <c911eadd249d4e4cbc8c247ed677b56a@AcuMS.aculab.com>
References: <20210312113253.305040674@infradead.org>
 <20210312115749.065275711@infradead.org>
 <Pine.BSM.4.64L.2401200654480.19429@herc.mirbsd.org>
 <CE53F232-3D2D-4910-94B4-A4304F5990C7@zytor.com>
 <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
In-Reply-To: <CAHk-=whtFk2DoO8WhtmsbU9nGXUd8sKShV1Dk71krFLBjPUSeg@mail.gmail.com>
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
Content-Transfer-Encoding: base64

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjAgSmFudWFyeSAyMDI0IDE3OjAwDQouLi4N
Cj4gQW5kIGlmIEkgYWRkICItciIgdG8gZ2V0IHJlbG9jYXRpb24gaW5mbywgSSBnZXQNCj4gDQo+
ICAgICAgICAgY2FsbCAgIDxkZWxheWVkX3B1dF90YXNrX3N0cnVjdCsweDFhPg0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICBSX1g4Nl82NF9QTFQzMiAgcmV0aG9va19mbHVzaF90YXNrLTB4NA0K
PiANCj4gd2hpY2ggc2hvd3MgdGhlIHJhdyByZWxvY2F0aW9uIGRhdGEsIGJ1dCB3aXRoIHRydWx5
IG1pbmQtYm9nZ2xpbmdseQ0KPiBob3JyZW5kb3VzIHN5bnRheC4NCj4gDQo+IElzIHRoZXJlIHNv
bWUgc2FuZSB0b29sIHRoYXQganVzdCBkb2VzIHRoZSBzYW5lIHRoaW5nIGFuZCBzaG93cyB0aGlz
IGFzDQo+IA0KPiAgICAgICAgIGNhbGwgICByZXRob29rX2ZsdXNoX3Rhc2sNCj4gDQo+IHdoaWNo
IGlzIHdoYXQgdGhlIHRoaW5nIGFjdHVhbGx5IG1lYW5zPw0KDQpXaGlsZSB5b3UgYXJlIHJlLXdy
aXRpbmcgYSBkaXNhc3NlbWJsZXIsIHJlbWVtYmVyIHRvIHByaW50IHRoZQ0KY29udGVudHMgb2Yg
c3RyaW5nIHdoZW4geW91IGdldCBhIHJlZmVyZW5jZSBpbnRvIC5yb2RhdGEuc3RyIDotKQ0KDQpI
b3cgbWFueSB0aW1lcyBoYXZlIHlvdSBoYWQgdG8gZGlnIG91dCBhIHByaW50ZiBmb3JtYXQgc3Ry
aW5nIGluDQpvcmRlciB0byBsb2NhdGUgdGhlIHNvdXJjZSBhc3NvY2lhdGVkIHdpdGggc29tZSBv
YmplY3QgY29kZT8NCkl0IGlzIHNvIG11Y2ggZWFzaWVyIGlmIHRoZSBkaXNhc3NlbWJsZXIgZG9l
cyBpdCBmb3IgeW91Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRl
LCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpS
ZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


