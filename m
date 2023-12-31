Return-Path: <linux-kernel+bounces-13699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B473A820B56
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 12:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61725281BEE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5529C8F5A;
	Sun, 31 Dec 2023 11:56:31 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2838F8F40
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-281-aBBp7YTVPSWzhyLiFTN6yg-1; Sun, 31 Dec 2023 11:56:25 +0000
X-MC-Unique: aBBp7YTVPSWzhyLiFTN6yg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 11:56:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 11:56:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"peterz@infradead.org" <peterz@infradead.org>, "longman@redhat.com"
	<longman@redhat.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "boqun.feng@gmail.com"
	<boqun.feng@gmail.com>, "xinhui.pan@linux.vnet.ibm.com"
	<xinhui.pan@linux.vnet.ibm.com>, "virtualization@lists.linux-foundation.org"
	<virtualization@lists.linux-foundation.org>, Zeng Heng <zengheng4@huawei.com>
Subject: RE: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Topic: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Index: Ado6mZUJWFdx4PkETd+mn/PWVjPd0AAyXXgoAB7ieYA=
Date: Sun, 31 Dec 2023 11:56:05 +0000
Message-ID: <5cff1ac6581142228886f78d54d836cf@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <CAHk-=wjbWTbRKDP=Yb9VWBGjSBEGB3dJ0=--+7-4oA2n1=1FKw@mail.gmail.com>
 <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
In-Reply-To: <CAHk-=wjsO=ODvUcwi=SPSzvsxW7Gj+3OU8q4CfHa+zMcivF6Bw@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMzAgRGVjZW1iZXIgMjAyMyAyMDo1OQ0KPiAN
Cj4gT24gU2F0LCAzMCBEZWMgMjAyMyBhdCAxMjo0MSwgTGludXMgVG9ydmFsZHMNCj4gPHRvcnZh
bGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPg0KPiA+IFVOVEVTVEVEIHBhdGNo
IHRvIGp1c3QgZG8gdGhlICJ0aGlzX2NwdV93cml0ZSgpIiBwYXJ0cyBhdHRhY2hlZC4NCj4gPiBB
Z2Fpbiwgbm90ZSBob3cgd2UgZG8gZW5kIHVwIGRvaW5nIHRoYXQgdGhpc19jcHVfcHRyIGNvbnZl
cnNpb24gbGF0ZXINCj4gPiBhbnl3YXksIGJ1dCBhdCBsZWFzdCBpdCdzIG9mZiB0aGUgY3JpdGlj
YWwgcGF0aC4NCj4gDQo+IEFsc28gbm90ZSB0aGF0IHdoaWxlICd0aGlzX2NwdV9wdHIoKScgZG9l
c24ndCBleGFjdGx5IGdlbmVyYXRlIGxvdmVseQ0KPiBjb2RlLCBpdCByZWFsbHkgaXMgc3RpbGwg
YmV0dGVyIHRoYW4gY2FjaGluZyBhIHZhbHVlIGluIG1lbW9yeS4NCj4gDQo+IEF0IGxlYXN0IHRo
ZSBtZW1vcnkgbG9jYXRpb24gdGhhdCAndGhpc19jcHVfcHRyKCknIGFjY2Vzc2VzIGlzDQo+IHNs
aWdodGx5IG1vcmUgbGlrZWx5IHRvIGJlIGhvdCAoYW5kIGlzIHJpZ2h0IG5leHQgdG8gdGhlIGNw
dSBudW1iZXIsDQo+IGlpcmMpLg0KDQpJIHdhcyBvbmx5IGdvaW5nIHRvIGFjY2VzcyB0aGUgJ3Nl
bGYnIGZpZWxkIGluIGNvZGUgdGhhdCByZXF1aXJlZA0KdGhlICdub2RlJyBjYWNoZSBsaW5lIGJl
IHByZXNlbnQuDQoNCj4gDQo+IFRoYXQgc2FpZCwgSSB0aGluayB3ZSBzaG91bGQgZml4IHRoaXNf
Y3B1X3B0cigpIHRvIG5vdCBldmVyIGdlbmVyYXRlDQo+IHRoYXQgZGlzZ3VzdGluZyBjbHRxIGp1
c3QgYmVjYXVzZSB0aGUgY3B1IHBvaW50ZXIgaGFzIHRoZSB3cm9uZw0KPiBzaWduZWRuZXNzLiBJ
IGRvbid0IHF1aXRlIGtub3cgaG93IHRvIGRvIGl0LCBidXQgdGhpczoNCj4gDQo+ICAgLSNkZWZp
bmUgcGVyX2NwdV9vZmZzZXQoeCkgKF9fcGVyX2NwdV9vZmZzZXRbeF0pDQo+ICAgKyNkZWZpbmUg
cGVyX2NwdV9vZmZzZXQoeCkgKF9fcGVyX2NwdV9vZmZzZXRbKHVuc2lnbmVkKSh4KV0pDQo+IA0K
PiBhdCBsZWFzdCBoZWxwcyBhICpiaXQqLiBJdCBnZXRzIHJpZCBvZiB0aGUgY2x0cSwgYXQgbGVh
c3QsIGJ1dCBpZg0KPiBzb21lYm9keSBhY3R1YWxseSBwYXNzZXMgaW4gYW4gJ3Vuc2lnbmVkIGxv
bmcnIGNwdWlkLCBpdCB3b3VsZCBjYXVzZQ0KPiBhbiB1bm5lY2Vzc2FyeSB0cnVuY2F0aW9uLg0K
DQpEb2luZyB0aGUgY29udmVyc2lvbiB1c2luZyBhcml0aG1ldGljIG1pZ2h0IGhlbHAsIHNvOg0K
CQlfX3Blcl9jcHVfb2Zmc2V0Wyh4KSArIDB1XQ0KDQo+IEFuZCBnY2Mgc3RpbGwgZ2VuZXJhdGVz
DQo+IA0KPiAgICAgICAgIHN1YmwgICAgJDEsICVlYXggICAgICAgICMsIGNwdV9ucg0KPiAgICAg
ICAgIGFkZHEgICAgX19wZXJfY3B1X29mZnNldCgsJXJheCw4KSwgJXJjeA0KPiANCj4gaW5zdGVh
ZCBvZiBqdXN0IGRvaW5nDQo+IA0KPiAgICAgICAgIGFkZHEgICAgX19wZXJfY3B1X29mZnNldC04
KCwlcmF4LDgpLCAlcmN4DQo+IA0KPiBiZWNhdXNlIGl0IHN0aWxsIG5lZWRzIHRvIGNsZWFyIHRo
ZSB1cHBlciAzMiBiaXRzIGFuZCBkb2Vzbid0IGtub3cNCj4gdGhhdCB0aGUgJ3hjaGcoKScgYWxy
ZWFkeSBkaWQgdGhhdC4NCg0KTm90IG9ubHkgdGhhdCwgeW91IG5lZWQgdG8gZG8gdGhlICdzdWJs
JyBhZnRlciBjb252ZXJ0aW5nIHRvIDY0IGJpdHMuDQpPdGhlcndpc2UgdGhlIHdyb25nIGxvY2F0
aW9uIGlzIHJlYWQgd2VyZSBjcHVfbnIgdG8gYmUgemVyby4NCkkndmUgdHJpZWQgdGhhdCAtIGJ1
dCBpdCBzdGlsbCBmYWlsZWQuDQoNCj4gT2ggd2VsbC4gSSBndWVzcyBldmVuIHdpdGhvdXQgdGhl
IC0xLysxIGdhbWVzIGJ5IHRoZSBPU1EgY29kZSwgd2UNCj4gd291bGQgc3RpbGwgZW5kIHVwIHdp
dGggYSAibW92bCIganVzdCB0byBkbyB0aGF0IHVwcGVyIGJpdHMgY2xlYXJpbmcNCj4gdGhhdCB0
aGUgY29tcGlsZXIgZG9lc24ndCBrbm93IGlzIHVubmVjZXNzYXJ5Lg0KPiANCj4gSSBkb24ndCB0
aGluayB3ZSBoYXZlIGFueSByZWFzb25hYmxlIHdheSB0byB0ZWxsIHRoZSBjb21waWxlciB0aGF0
IHRoZQ0KPiByZWdpc3RlciBvdXRwdXQgb2Ygb3VyIHhjaGcoKSBpbmxpbmUgYXNtIGhhcyB0aGUg
dXBwZXIgMzIgYml0cyBjbGVhci4NCg0KSXQgY291bGQgYmUgZG9uZSBmb3IgYSAzMmJpdCB1bnNp
Z25lZCB4Y2hnKCkgLSBqdXN0IG1ha2UgdGhlIHJldHVybg0KdHlwZSB1bnNpZ25lZCA2NGJpdC4N
CkJ1dCB0aGF0IHdvbid0IHdvcmsgZm9yIHRoZSBzaWduZWQgZXhjaGFuZ2UgLSBhbmQgJ2F0b21p
Y190JyBpcyBzaWduZWQuDQpPVE9IIEknZCBndWVzcyB0aGlzIGNvZGUgY291bGQgdXNlICd1bnNp
Z25lZCBpbnQnIGluc3RlYWQgb2YgYXRvbWljX3Q/DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVk
IEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5l
cywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


