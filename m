Return-Path: <linux-kernel+bounces-33714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A26836D9A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3A981C27ACB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AACC58228;
	Mon, 22 Jan 2024 16:46:03 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D83FB37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941962; cv=none; b=s2b8znyXaHgsQGMJK5CI/dlKTpkxZdSifH7D6ACGu1sX4sZVvqFQ4r86Paxhska30ZxfigT7gNiQYlv+qrtDdJSrmEi5P39vmJuYadSXGhXJKX42bS7A/pYsvWA5uy2QenxWWBZrqVUzWeEM6tlQWHVcFw5MEgZLzOgwpwDMRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941962; c=relaxed/simple;
	bh=gcPAmJ/o9zUtdqLsY/Tjlmu+cUIHMU0vi/3Ay7F7shM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=rkmcry5cTjnU8Ip6hRxqor9bOC7qccLi/C8Cw7AnF3/7Psyg9rKJrdFqTJX1dhsCzPunrEnXpSAomI1toYcV96HRkUiUZ+w2KTfHx/tEKGGSDEG8G5RxG7VhbWnqV8I6TZn8GHsutdX0TYo88sJ/Xns5BKu99gvAK4PdqlJTp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-116-5Q1bPtriN321TrRrMxTU7w-1; Mon, 22 Jan 2024 16:45:58 +0000
X-MC-Unique: 5Q1bPtriN321TrRrMxTU7w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 22 Jan
 2024 16:45:31 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 22 Jan 2024 16:45:31 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Sebastian Andrzej Siewior' <bigeasy@linutronix.de>, Masahiro Yamada
	<masahiroy@kernel.org>
CC: "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, "Nicolas
 Schier" <n.schier@avm.de>, Nathan Chancellor <nathan@kernel.org>, "Nick
 Desaulniers" <ndesaulniers@google.com>, Nicolas Schier <nicolas@fjasle.eu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] kbuild: resolve symlinks for O= properly
Thread-Topic: [PATCH v2] kbuild: resolve symlinks for O= properly
Thread-Index: AQHaTTz0QSoqy4Fux0m2l+xPqKe3drDmCgHw
Date: Mon, 22 Jan 2024 16:45:31 +0000
Message-ID: <6c9e46e44215461b83e9e351cd1c760a@AcuMS.aculab.com>
References: <20231215160637.842748-1-masahiroy@kernel.org>
 <20240122141203.CWe3n5rG@linutronix.de>
In-Reply-To: <20240122141203.CWe3n5rG@linutronix.de>
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

RnJvbTogU2ViYXN0aWFuIEFuZHJ6ZWogU2lld2lvcg0KPiBTZW50OiAyMiBKYW51YXJ5IDIwMjQg
MTQ6MTINCj4gDQo+IE9uIDIwMjMtMTItMTYgMDE6MDY6MzcgWyswOTAwXSwgTWFzYWhpcm8gWWFt
YWRhIHdyb3RlOg0KPiDigKYNCj4gPiBVc2luZyB0aGUgcGh5c2ljYWwgZGlyZWN0b3J5IHN0cnVj
dHVyZSBmb3IgdGhlIE89IG9wdGlvbiBzZWVtcyBtb3JlDQo+ID4gcmVhc29uYWJsZS4NCj4gPg0K
PiA+IFRoZSBjb21tZW50IHNheXMgImV4cGFuZCBhIHNoZWxsIHNwZWNpYWwgY2hhcmFjdGVyICd+
JyIsIGJ1dCBpdCBoYXMNCj4gPiBhbHJlYWR5IGJlZW4gZXhwYW5kZWQgdG8gdGhlIGhvbWUgZGly
ZWN0b3J5IGluIHRoZSBjb21tYW5kIGxpbmUuDQo+IA0KPiBJdCBtaWdodCBoYXZlIGJlZW4gZXhw
YW5kZWQsIGl0IG1pZ2h0IGhhdmUgbm90IGJlZW4gZXhwYW5kZWQuIEhhdmluZyBhDQo+IHNoZWxs
IHNjcmlwdDoNCj4gfCAjIS9iaW4vc2gNCj4gfA0KPiB8IGV4ZWMgbWFrZSBPPX4vc2NyYXRjaC9t
ay1jaGVjayBkZWZjb25maWcNCj4gDQo+IHdpdGggYmluL3NoID0gZGFzaCByZXN1bHRzIGluOg0K
PiANCj4gfCBtYWtlWzFdOiBFbnRlcmluZyBkaXJlY3RvcnkgJy9ob21lL2JpZ2Vhc3kvbGludXgv
fi9zY3JhdGNoL21rLWNoZWNrJw0KPiANCj4gd2hpbGUgYmluL3NoID0gYmFzaCBleHBhbmRzIHRo
ZSB+IHByb3Blcmx5IGJlZm9yZSBmb3IgTz0uIFdvdWxkIGl0IGJlDQo+IHRvbyBtdWNoIHRvIGFz
aywgdG8gZXhwYW5kIHRoZSB+Pw0KDQpSYWlzZSBhIGJ1ZyBvbiBkYXNoLi4uDQoNCk9yIHNwbGl0
IHRoZSBsaW5lczoNCk89fi94eHh4DQptYWtlIE89IiRPIiAuLi4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


