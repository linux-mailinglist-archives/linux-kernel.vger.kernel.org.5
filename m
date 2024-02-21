Return-Path: <linux-kernel+bounces-75609-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D2085EBEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F46DB24089
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E11E126F0B;
	Wed, 21 Feb 2024 22:44:45 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF93E468
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 22:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708555485; cv=none; b=Ta6hwSyjVEGbe1eMJuqrex2hCRVEjLFnqMLKuk2ck8LytcROTJRN707tvI2kF1KbiPkL6Aq0tW9OCBFQmSv9sSxshbUUeN29pGNZKP6WwbWeS3DjUrDPb39RR08Rx6sqh2eUc/g+8+hWnnn58qtvOwpybHL714Dd5lSAa6gLFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708555485; c=relaxed/simple;
	bh=ynCx5dbHJXM1OpyJSTDx7N02mIROGTc1mkWbCs5RUpo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=p9G1PtFZafNEy93cdaR/+GAJvbgJaBtfrtP8hZQqRcH9b9dDDOlhqIebov8NFTD5AyC5CVOMazB/KZ7wO+ZKxpkp6hRYj4OUdLXhw8Qu8/bEjx4JdMp80qJZN2l5jm3R4MxEaR6aEj+56HnSklkxYmms6yHjFF1ilutsWutgeNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-65-DfNQ66gKM92OtrzTRaJzOg-1; Wed, 21 Feb 2024 22:44:33 +0000
X-MC-Unique: DfNQ66gKM92OtrzTRaJzOg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 21 Feb
 2024 22:44:32 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 21 Feb 2024 22:44:32 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Marc Kleine-Budde' <mkl@pengutronix.de>, Oliver Hartkopp
	<socketcan@hartkopp.net>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
Thread-Topic: [PATCH] can: raw: raw_getsockopt(): reduce scope of err
Thread-Index: AQHaY9Ug246GnPh9DUCq0NoOfILROLEVZS4g
Date: Wed, 21 Feb 2024 22:44:32 +0000
Message-ID: <7bb0474bad834a7c9f810c70e959ef12@AcuMS.aculab.com>
References: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
In-Reply-To: <20240220-raw-setsockopt-v1-1-7d34cb1377fc@pengutronix.de>
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

RnJvbTogTWFyYyBLbGVpbmUtQnVkZGUNCj4gU2VudDogMjAgRmVicnVhcnkgMjAyNCAwODoxNg0K
PiANCj4gUmVkdWNlIHRoZSBzY29wZSBvZiB0aGUgdmFyaWFibGUgImVyciIgdG8gdGhlIGluZGl2
aWR1YWwgY2FzZXMuIFRoaXMNCj4gaXMgdG8gYXZvaWQgdGhlIG1pc3Rha2Ugb2Ygc2V0dGluZyAi
ZXJyIiBpbiB0aGUgbWlzdGFrZW4gYmVsaWVmIHRoYXQNCj4gaXQgd2lsbCBiZSBldmFsdWF0ZWQg
bGF0ZXIuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBNYXJjIEtsZWluZS1CdWRkZSA8bWtsQHBlbmd1
dHJvbml4LmRlPg0KPiAtLS0NCj4gIG5ldC9jYW4vcmF3LmMgfCAxMiArKysrKysrKy0tLS0NCj4g
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvbmV0L2Nhbi9yYXcuYyBiL25ldC9jYW4vcmF3LmMNCj4gaW5kZXggODk3ZmZj
MTdkODUwLi4yYmIzZWFiOThhZjAgMTAwNjQ0DQo+IC0tLSBhL25ldC9jYW4vcmF3LmMNCj4gKysr
IGIvbmV0L2Nhbi9yYXcuYw0KPiBAQCAtNzU2LDcgKzc1Niw2IEBAIHN0YXRpYyBpbnQgcmF3X2dl
dHNvY2tvcHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50IGxldmVsLCBpbnQgb3B0bmFtZSwNCj4g
IAlzdHJ1Y3QgcmF3X3NvY2sgKnJvID0gcmF3X3NrKHNrKTsNCj4gIAlpbnQgbGVuOw0KPiAgCXZv
aWQgKnZhbDsNCj4gLQlpbnQgZXJyID0gMDsNCj4gDQo+ICAJaWYgKGxldmVsICE9IFNPTF9DQU5f
UkFXKQ0KPiAgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTc2Niw3ICs3NjUsOSBAQCBzdGF0aWMg
aW50IHJhd19nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ssIGludCBsZXZlbCwgaW50IG9w
dG5hbWUsDQo+ICAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gIAlzd2l0Y2ggKG9wdG5hbWUpIHsN
Cj4gLQljYXNlIENBTl9SQVdfRklMVEVSOg0KPiArCWNhc2UgQ0FOX1JBV19GSUxURVI6IHsNCj4g
KwkJaW50IGVyciA9IDA7DQo+ICsNCj4gIAkJbG9ja19zb2NrKHNrKTsNCj4gIAkJaWYgKHJvLT5j
b3VudCA+IDApIHsNCj4gIAkJCWludCBmc2l6ZSA9IHJvLT5jb3VudCAqIHNpemVvZihzdHJ1Y3Qg
Y2FuX2ZpbHRlcik7DQo+IEBAIC03OTEsNyArNzkyLDcgQEAgc3RhdGljIGludCByYXdfZ2V0c29j
a29wdChzdHJ1Y3Qgc29ja2V0ICpzb2NrLCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLA0KPiAgCQlp
ZiAoIWVycikNCj4gIAkJCWVyciA9IHB1dF91c2VyKGxlbiwgb3B0bGVuKTsNCj4gIAkJcmV0dXJu
IGVycjsNCj4gLQ0KPiArCX0NCj4gIAljYXNlIENBTl9SQVdfRVJSX0ZJTFRFUjoNCj4gIAkJaWYg
KGxlbiA+IHNpemVvZihjYW5fZXJyX21hc2tfdCkpDQo+ICAJCQlsZW4gPSBzaXplb2YoY2FuX2Vy
cl9tYXNrX3QpOw0KPiBAQCAtODIyLDcgKzgyMyw5IEBAIHN0YXRpYyBpbnQgcmF3X2dldHNvY2tv
cHQoc3RydWN0IHNvY2tldCAqc29jaywgaW50IGxldmVsLCBpbnQgb3B0bmFtZSwNCj4gIAkJdmFs
ID0gJnJvLT54bF9mcmFtZXM7DQo+ICAJCWJyZWFrOw0KPiANCj4gLQljYXNlIENBTl9SQVdfWExf
VkNJRF9PUFRTOg0KPiArCWNhc2UgQ0FOX1JBV19YTF9WQ0lEX09QVFM6IHsNCj4gKwkJaW50IGVy
ciA9IDA7DQo+ICsNCj4gIAkJLyogdXNlciBzcGFjZSBidWZmZXIgdG8gc21hbGwgZm9yIFZDSUQg
b3B0cz8gKi8NCj4gIAkJaWYgKGxlbiA8IHNpemVvZihyby0+cmF3X3ZjaWRfb3B0cykpIHsNCj4g
IAkJCS8qIHJldHVybiAtRVJBTkdFIGFuZCBuZWVkZWQgc3BhY2UgaW4gb3B0bGVuICovDQo+IEBA
IC04MzksNiArODQyLDcgQEAgc3RhdGljIGludCByYXdfZ2V0c29ja29wdChzdHJ1Y3Qgc29ja2V0
ICpzb2NrLCBpbnQgbGV2ZWwsIGludCBvcHRuYW1lLA0KPiAgCQkJZXJyID0gcHV0X3VzZXIobGVu
LCBvcHRsZW4pOw0KPiAgCQlyZXR1cm4gZXJyOw0KPiANCj4gKwl9DQo+ICAJY2FzZSBDQU5fUkFX
X0pPSU5fRklMVEVSUzoNCj4gIAkJaWYgKGxlbiA+IHNpemVvZihpbnQpKQ0KPiAgCQkJbGVuID0g
c2l6ZW9mKGludCk7DQoNCkknZCBiZSB2ZXJ5IHRlbXB0ZWQgdG8gY2hhbmdlIHRoZSBjb2RlIHNv
IHRoYXQgdGhlcmUgaXMgb25seSBvbmUNCnB1dF91c2VyKGxlbiwgb3B0bGVuKSByaWdodCBhdCB0
aGUgYm90dG9tLg0KDQpJZiB0aGUgY29kZSBpcyBvYmV5aW5nIHRoZSBub3JtYWwgJ3J1bGVzJyBm
b3IgZ2V0c29ja29wdCgpIHRoZSBmdW5jdGlvbg0KY2FuIGFjdHVhbGx5IHJldHVybiB0aGUgbGVu
Z3RoIG9yIGFuIGVycm9yIGFuZCB0aGUgY2FsbGVyIGNhbiBzb3J0DQpvdXQgd2hhdCB0byBkbyB3
aXRoIHRoZSBkYXRhLg0KVGhhdCBtYWtlcyB0aGUgY2hhbmdlcyByZXF1aXJlZCB0byBpbXBsZW1l
bnQga2VybmVsX2dldHNvY2tvcHQoKQ0KYSBsb3Qgc2ltcGxlci4NCkkgZGlkIHN0YXJ0IHdyaXRp
bmcgYSBwYXRjaHNldCB0byBkbyB0aGF0LCBidXQgc29tZSBvZiB0aGUgY29kZQ0KaXMgZW50aXJl
bHkgYnJhaW4tZGVhZC4NCkJ1dCBpdCB3b3VsZCBjZXJ0YWlubHkgbWFrZSBzZW5zZSBmb3IgdGhl
ICdvcHRsZW4nIHBhcmFtZXRlciB0bw0KYmUgYSBrZXJuZWwgYWRkcmVzcyBhbmQgaGF2ZSBiZWVu
IHZhbGlkYXRlZCB0byBiZSAnc2FuZScgKGVnIHBvc2l0aXZlKQ0KYW5kIGhhdmUgdGhlIHN5c2Nh
bGwgd3JhcHBlciBkbyB0aGUgdXNlciBjb3BpZXMuDQpJdCBjYW4ndCBiZSBkb25lIGZvciB0aGUg
YnVmZmVyIChpbiBhbGwgY2FzZXMpIGJlY2F1c2UgdGhlIHVzZXINCnN1cHBsaWVkIGxlbmd0aCBp
c24ndCBhbHdheXMgdGhlIGJ1ZmZlciBsZW5ndGguDQpCdXQgdGhlIGxlbmd0aCBmaWVsZCBpcyBk
ZWZpbmVkIHRvIGJlIGFuIGludGVnZXIuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJl
c3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsx
IDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


