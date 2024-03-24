Return-Path: <linux-kernel+bounces-112818-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21F1887E8B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 20:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BD461F211C9
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D267DDAB;
	Sun, 24 Mar 2024 19:10:18 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236AD502
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 19:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711307417; cv=none; b=aHacmDCvitV3Ntymxn8V/hyl/8sdYRfhCBTULjw3dw9B/7bubag0bGF9g/F5FPPTnpJbOKwWXekQmlYvdC80VNWXi7VgFHkcTKr9TtKu5/Mb9zXq3uzzT0UjjCg3LVHYA6NZFEKtmMzHVWEGEFGtEZkvvxNo3hGtmxmAeMtO7WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711307417; c=relaxed/simple;
	bh=QQn+cIvEmBO4o8vTjpZedIrnDv3/6Tg4R+naKA3Vu8w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=c+UhZjrQZvK+lWhe0kOfftNFbrOaYUawjGQSSROdWcNvOnMQ4W621tw3Xc9I+28VJxDITHsoyK8v5oqBVGOSB4aNhWxD7Y3QkKysq5KD/XGotFpeBqKvZhGfkHP1RRqiNXzH8QDtjEJ3bw4tMrOTclirjRln36Q3OmgyBej0wpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-266-IUaun0wbNxGAZPkSh5SrAg-1; Sun, 24 Mar 2024 19:10:03 +0000
X-MC-Unique: IUaun0wbNxGAZPkSh5SrAg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Mar
 2024 19:09:33 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Mar 2024 19:09:33 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Brian Gerst
	<brgerst@gmail.com>, Arnd Bergmann <arnd@arndb.de>
CC: Uros Bizjak <ubizjak@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, "Ingo
 Molnar" <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, "Borislav
 Petkov" <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>
Subject: RE: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Thread-Topic: [PATCH v4 00/16] x86-64: Stack protector and percpu improvements
Thread-Index: AQHafURxjmFHQpAFoUSiH4Xge0D4zLFHQm2g
Date: Sun, 24 Mar 2024 19:09:33 +0000
Message-ID: <c2a929227bc146e9bc244baeb7b89151@AcuMS.aculab.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
 <CAFULd4bCufzKjaUyOcJ5MfsPBcVTj1zQiP3+FFCGo6SbxTpK2A@mail.gmail.com>
 <CAMzpN2gOZEddWUgncaLutVDihcEK-oEUdSVxsgaaX9xiMWfqPw@mail.gmail.com>
 <CAHk-=wi0arqxMFFdM+jGv1YXXhY+ehxsmcfv+iAndD_dmpYjMA@mail.gmail.com>
 <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
In-Reply-To: <CAHk-=wg0cMa6B6OeTtXjx4R-kqxWVHSJ=6y=stRuzk8WduJTsQ@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMjMgTWFyY2ggMjAyNCAxNzowNw0KPiANCj4g
T24gU2F0LCAyMyBNYXIgMjAyNCBhdCAwOToxNiwgTGludXMgVG9ydmFsZHMNCj4gPHRvcnZhbGRz
QGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IEFuZCB3ZSBtaWdodCBhcyB3
ZWxsIGFsc28gZG8gdGhlIHNlbWkteWVhcmx5IGNvbXBpbGVyIHZlcnNpb24gcmV2aWV3Lg0KPiA+
IFdlIHJhaXNlZCB0aGUgbWluaW11bSB0byA0LjkgYWxtb3N0IGZvdXIgeWVhcnMgYWdvLCBhbmQg
dGhlbiB0aGUganVtcA0KPiA+IHRvIDUuMSB3YXMgZmlyc3QgZm9yIGFybTY0IGR1ZSB0byBhIHNl
cmlvdXMgZ2NjIGNvZGUgZ2VuZXJhdGlvbiBidWcNCj4gPiBhbmQgdGhlbiBnbG9iYWxseSBpbiBT
ZXB0IDIwMjEuDQo+IA0KPiBMb29raW5nIGF0IFJIRUwsIEkgZmluZCBhIHBhZ2UgdGhhdCBjbGFp
bXMNCj4gDQo+ICAgUkhFTDkgOiBnY2MgMTEueCBpbiBhcHAgc3RyZWFtDQo+ICAgUkhFTDggOiBn
Y2MgOC54IG9yIGdjYyA5LnggaW4gYXBwIHN0cmVhbS4NCj4gICBSSEVMNyA6IGdjYyA0LjgueA0K
DQpJJ20gcnVubmluZyBVYnVudHUgMTguMDQgTFRTIChhbmQgc3RpbGwgZ2V0dGluZyB1cGRhdGVz
KSBhbmQgdGhhdA0KaGFzIGdjYyA3LjMuMC4NCkNsZWFybHkgaXQgbWlnaHQgYmUgdGltZSB0byB1
cGRhdGUvcmVpbnN0YWxsIHRoYXQgc3lzdGVtIDotKQ0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


