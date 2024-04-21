Return-Path: <linux-kernel+bounces-152607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2138A8AC11B
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 21:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 182511C203AC
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 19:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5924205B;
	Sun, 21 Apr 2024 19:49:15 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD5F111AD
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713728955; cv=none; b=Dd+RlKbl8LzniH0jboPdNlViLl83j7+G1UjvIyIO+HvuBarRno1n+wlrhZ3YlknvtpeAxllAeW8KOy6yXF+WfWX065VZHfcKQDS+ruALT41B8DADUo4kGXfw9AfGcTxEQNP6ORqgwvGXp8aVsm/gxog+Yx8gHO7Pj5TmZRMoDgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713728955; c=relaxed/simple;
	bh=XVrdJNCwjV5XsshVzY0DRpd9wE21Xz7TPWmPa1IjLQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=uzA5blAqtgYJjNsJBpf0qveHqsZbivBiNyghs6aNyIDWKDeOAB79iJBnlzjx+sQcCaXosmK2CchoB0ijyxAljP+2Q0EJQXQTcFztcCf4C85fD8EgSMF4QHAaCbuoeb9AQ51cBwXP1X23s1sgONFUm5q3I6pw8Ltp3RqSjmT5/Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-164-pDWScEKQPoKLxWOdv2fT2Q-1; Sun, 21 Apr 2024 20:49:05 +0100
X-MC-Unique: pDWScEKQPoKLxWOdv2fT2Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 21 Apr
 2024 20:48:31 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 21 Apr 2024 20:48:31 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alice Ryhl' <aliceryhl@google.com>
CC: "boqun.feng@gmail.com" <boqun.feng@gmail.com>, "a.hindborg@samsung.com"
	<a.hindborg@samsung.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "alex.gaynor@gmail.com" <alex.gaynor@gmail.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "arve@android.com" <arve@android.com>,
	"benno.lossin@proton.me" <benno.lossin@proton.me>, "bjorn3_gh@protonmail.com"
	<bjorn3_gh@protonmail.com>, "brauner@kernel.org" <brauner@kernel.org>,
	"cmllamas@google.com" <cmllamas@google.com>, "gary@garyguo.net"
	<gary@garyguo.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "joel@joelfernandes.org"
	<joel@joelfernandes.org>, "keescook@chromium.org" <keescook@chromium.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "maco@android.com"
	<maco@android.com>, "ojeda@kernel.org" <ojeda@kernel.org>,
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>,
	"surenb@google.com" <surenb@google.com>, "tkjos@android.com"
	<tkjos@android.com>, "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
	"wedsonaf@gmail.com" <wedsonaf@gmail.com>, "willy@infradead.org"
	<willy@infradead.org>
Subject: RE: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Thread-Topic: [PATCH v5 1/4] rust: uaccess: add userspace pointers
Thread-Index: AQHaj+PoXR+cvvbs7Um8Z9suLdW8qbFzDUqQ///4IgCAACQQAA==
Date: Sun, 21 Apr 2024 19:48:31 +0000
Message-ID: <98d51251e0dc470983b3fae339e0f3bf@AcuMS.aculab.com>
References: <Zh2hw0uQrkN5yVVA@boqun-archlinux>
 <20240416095323.1107928-1-aliceryhl@google.com>
 <5a45ccc04cae4976900d031989104737@AcuMS.aculab.com>
 <CAH5fLgj9xt9RnohE1fbLfWBAHv47AgwzrMf8cWZO4hEYC2Mnkw@mail.gmail.com>
In-Reply-To: <CAH5fLgj9xt9RnohE1fbLfWBAHv47AgwzrMf8cWZO4hEYC2Mnkw@mail.gmail.com>
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

RnJvbTogQWxpY2UgUnlobA0KPiBTZW50OiAyMSBBcHJpbCAyMDI0IDE5OjM4DQo+IA0KPiBPbiBT
dW4sIEFwciAyMSwgMjAyNCBhdCA4OjA44oCvUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBTaG91bGQgeW91IGJlIGltcGxlbWVudGluZyAn
c3RydWN0IGlvdl9pdGVyJyA/DQo+ID4NCj4gPiBFdmVuIGlmIGl0IG1lYW5zIGNyZWF0aW5nIGFu
IElPX1VCVUYgZm9yIGlvY3Rscz8NCj4gPiAoQWx0aG91Z2ggdGhhdCBtaWdodCB0YWtlIHNvbWUg
J2ZldHRsaW5nJyBmb3IgcmVhZCt3cml0ZSBmb3IgaW9jdGxzLikNCj4gDQo+IFRoYXQgc2VlbXMg
dG8gYmUgaW50ZW5kZWQgZm9yIHdoZW4geW91IGhhdmUgc2V2ZXJhbCBjaHVua3Mgb2YgbWVtb3J5
DQo+IGluIHVzZXJzcGFjZSB0aGF0IHlvdSB3YW50IHRvIHRyZWF0IGFzIG9uZSBjb250aWd1b3Vz
IGNodW5rLiBUaGF0J3MNCj4gbm90IHNvbWV0aGluZyBJIG5lZWQgaW4gdGhlIEFuZHJvaWQgQmlu
ZGVyIGRyaXZlci4NCg0KSXQgYWxzbyB0cmFuc3BhcmVudGx5IHN1cHBvcnRzIGluLWtlcm5lbCB1
c2VycyBhbmQgc29tZSBvdGhlciBjYXNlcy4NCg0KSSB0aGluayB0aGVyZSBpcyBhIHBhdGNoIGlu
dGVuZGVkIGZvciA2LjEwIHRoYXQgcmVtb3ZlcyB0aGUgJ3JlYWQnDQphbmQgJ3dyaXRlJyBkcml2
ZXIgJ29wcycgYW5kIHJlcXVpcmVzIHRoYXQgZHJpdmVycyBzdXBwb3J0ICdyZWFkX2l0ZXInDQph
bmQgJ3dyaXRlX2l0ZXInLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


