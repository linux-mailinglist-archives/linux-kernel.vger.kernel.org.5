Return-Path: <linux-kernel+bounces-13602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB278208AE
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C7751F224A5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09AB125DA;
	Sat, 30 Dec 2023 22:39:30 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3AB11C94
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 22:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-56-J9DeA6IWNj20ulVSrrgVVg-1; Sat, 30 Dec 2023 22:39:20 +0000
X-MC-Unique: J9DeA6IWNj20ulVSrrgVVg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Dec
 2023 22:39:02 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Dec 2023 22:39:02 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com"
	<longman@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "xinhui.pan@linux.vnet.ibm.com"
	<xinhui.pan@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, Zeng Heng <zengheng4@huawei.com>
Subject: RE: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock code
Thread-Topic: [PATCH next 0/5] locking/osq_lock: Optimisations to osq_lock
 code
Thread-Index: Ado6lJ8STYITmewCRxaK5t3V4duzKgAw3MqAAAYz05A=
Date: Sat, 30 Dec 2023 22:39:02 +0000
Message-ID: <1015f066d717465191c7b7599257f683@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
In-Reply-To: <CAHk-=wg7PKm+9tv+60DTfZuu-Kh00uR8zKAGtTdUkSOXaLO1_g@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgRGVjZW1iZXIgMjAyMyAxOTo0MQ0KPiAN
Cj4gT24gRnJpLCAyOSBEZWMgMjAyMyBhdCAxMjo1MiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWln
aHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBEYXZpZCBMYWlnaHQgKDUpOg0KPiA+ICAg
TW92ZSB0aGUgZGVmaW5pdGlvbiBvZiBvcHRpbWlzdGljX3NwaW5fbm9kZSBpbnRvIG9zZl9sb2Nr
LmMNCj4gPiAgIENsYXJpZnkgb3NxX3dhaXRfbmV4dCgpDQo+IA0KPiBJIHRvb2sgdGhlc2UgdHdv
IGFzIHByZXBhcmF0b3J5IGluZGVwZW5kZW50IHBhdGNoZXMsIHdpdGggdGhhdA0KPiBvc3Ffd2Fp
dF9uZXh0KCkgY2xhcmlmaWNhdGlvbiBzcGxpdCBpbnRvIHR3by4NCj4gDQo+IEkgYWxzbyBkaWQg
dGhlIHJlbmFtaW5nIHRoYXQgV2FpbWFuIGFza2VkIGZvci4NCg0KT2ssIEknbGwgdHJ5IHRvIHJl
bW92ZSB0aGVtIGZyb20gYW55IHJlc3Bpbi4NCihPciBhdCBsZWFzdCBwdXQgdGhlbSBmaXJzdCEp
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


