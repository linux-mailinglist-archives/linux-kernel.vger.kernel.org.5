Return-Path: <linux-kernel+bounces-144984-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC28E8A4D9C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914051F23152
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A8585FB93;
	Mon, 15 Apr 2024 11:23:26 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B83657A3
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 11:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713180205; cv=none; b=egzuErBBZ5YNER0u98hn/HOT6t3cHu1QKLA7aV5GiJh/rKXHUc1uqfc87K14CiyHWLPG+q8qTkXX8IIi/L4uRisF3JN7n8rAlKrpyKtopZYNVIU2qTUYzNqPM6S56o8LBLyXL7Ue/ipc3JpowQBbtHTxO4U3Jc7rgrcFka1qcoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713180205; c=relaxed/simple;
	bh=CziQs7aMhj9OpqRoP90aag71n2YIwOeug3nO8I1cP8g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=D1g8uDZJXy4agd8PRuA2F7SyN/KO/pdu6NWAR6ck7Gky5+iVTUchhIopF6ExbT0W2LohDgTT6veAzdZ4gBbiRMsEbHTzZ5yHAccCuYS7xh9lA3/65UbVoRYyfGdGWVAJrEP8fxad4dswpDTRDtOrv5gMHYPGeJfQpKLblY2zQo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-tjcp8qf9PhOVYCuOrOzRpw-1; Mon, 15 Apr 2024 12:23:17 +0100
X-MC-Unique: tjcp8qf9PhOVYCuOrOzRpw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 15 Apr
 2024 12:22:41 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 15 Apr 2024 12:22:41 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kees Cook' <keescook@chromium.org>, Justin Stitt <justinstitt@google.com>
CC: Chandan Babu R <chandan.babu@oracle.com>, "Darrick J. Wong"
	<djwong@kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
Thread-Topic: [PATCH] xfs: replace deprecated strncpy with strscpy_pad
Thread-Index: AQHajCVvxad4w+xafUuF+MG1sYW+JbFpNItw
Date: Mon, 15 Apr 2024 11:22:41 +0000
Message-ID: <1a75240d27bb4f2abe3cfae49b2f7605@AcuMS.aculab.com>
References: <20240405-strncpy-xfs-split1-v1-1-3e3df465adb9@google.com>
 <202404090921.A203626A@keescook>
 <CAFhGd8pr5XycTH1iCUgBodCOV8_WY_da=aH+WZGPXfuOY5_Zgg@mail.gmail.com>
 <202404110829.D3A5A56@keescook>
In-Reply-To: <202404110829.D3A5A56@keescook>
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

RnJvbTogS2VlcyBDb29rDQo+IFNlbnQ6IDExIEFwcmlsIDIwMjQgMTY6MzINCj4gDQo+IE9uIFdl
ZCwgQXByIDEwLCAyMDI0IGF0IDAxOjQ1OjIxUE0gLTA3MDAsIEp1c3RpbiBTdGl0dCB3cm90ZToN
Cj4gPiBPbiBUdWUsIEFwciA5LCAyMDI0IGF0IDk6MjLigK9BTSBLZWVzIENvb2sgPGtlZXNjb29r
QGNocm9taXVtLm9yZz4gd3JvdGU6DQo+ID4gPiA+DQo+ID4gPiA+IC0gICAgIC8qIDEgbGFyZ2Vy
IHRoYW4gc2JfZm5hbWUsIHNvIHRoaXMgZW5zdXJlcyBhIHRyYWlsaW5nIE5VTCBjaGFyICovDQo+
ID4gPiA+IC0gICAgIG1lbXNldChsYWJlbCwgMCwgc2l6ZW9mKGxhYmVsKSk7DQo+ID4gPiA+ICAg
ICAgIHNwaW5fbG9jaygmbXAtPm1fc2JfbG9jayk7DQo+ID4gPiA+IC0gICAgIHN0cm5jcHkobGFi
ZWwsIHNicC0+c2JfZm5hbWUsIFhGU0xBQkVMX01BWCk7DQo+ID4gPiA+ICsgICAgIHN0cnNjcHlf
cGFkKGxhYmVsLCBzYnAtPnNiX2ZuYW1lKTsNCj4gPiA+DQo+ID4gPiBJcyBzYnAtPnNiX2ZuYW1l
IGl0c2VsZiBOVUwtdGVybWluYXRlZD8gVGhpcyBsb29rcyBsaWtlIGFub3RoZXIgY2FzZSBvZg0K
PiA+ID4gbmVlZGluZyB0aGUgbWVtdG9zdHIoKSBoZWxwZXI/DQo+ID4gPg0KPiA+DQo+ID4gSSBz
ZW50IGEgcGF0Y2ggWzFdLg0KPiA+DQo+ID4gT2J2aW91c2x5IGl0IGRlcGVuZHMgb24geW91ciBp
bXBsZW1lbnRhdGlvbiBwYXRjaCBsYW5kaW5nIGZpcnN0OyB3aGF0DQo+ID4gdHJlZSBzaG91bGQg
aXQgZ28gdG8/DQo+IA0KPiBUaGlzICJmbGF2b3IiIG9mIGNvbnZlcnNpb24gbWF5IG5lZWQgdG8g
d2FpdCBhIHJlbGVhc2U/IFRoZXJlJ3Mgbm8NCj4gdXJnZW5jeSBvbiB0aGUgY29udmVyc2lvbiwg
YW5kIHRoZXJlIGFyZSBwbGVudHkgbW9yZSB0byBkbyBmb3IgdGhpcw0KPiBjeWNsZS4gOykNCg0K
SW4gdGhpcyBjYXNlOg0KCWNoYXIgbGFiZWxbc2l6ZW9mIChzYnAtPmZiX2ZuYW1lKSArIDFdOw0K
CW1lbWNweShsYWJlbCwgc2JwLT5zYl9mbmFtZSwgc2l6ZW9mIChzYnAtPnNiX2ZuYW1lKSk7DQoJ
bGFiZWxbc2l6ZW9mIChzYnAtPmZuYW1lKV0gPSAwOw0KaXMgcHJvYmFibHkgdGhlIGNsZWFyZXN0
IGNvZGUuDQooaXQgaXMgWzEyXSAtIHNvIG5vIHBvaW50IGZhZmZpbmcgd2l0aCB0aGUgY29weS4p
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


