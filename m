Return-Path: <linux-kernel+bounces-10415-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B67FC81D423
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64BE82833E0
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F242D2F9;
	Sat, 23 Dec 2023 13:06:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8A3D2E4
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-256--EFTXZL0NumCkVVWzBnsxQ-1; Sat, 23 Dec 2023 13:06:44 +0000
X-MC-Unique: -EFTXZL0NumCkVVWzBnsxQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Dec
 2023 13:06:29 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Dec 2023 13:06:29 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Zeng Heng' <zengheng4@huawei.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"will@kernel.org" <will@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "longman@redhat.com" <longman@redhat.com>,
	"boqun.feng@gmail.com" <boqun.feng@gmail.com>
CC: "xiexiuqi@huawei.com" <xiexiuqi@huawei.com>, "liwei391@huawei.com"
	<liwei391@huawei.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Thread-Topic: [PATCH v2] locking/osq_lock: Avoid false sharing in
 optimistic_spin_node
Thread-Index: AQHaNM91saK4G5Mya06aToQ2I11sa7C1Om0AgAFXRQCAABszwA==
Date: Sat, 23 Dec 2023 13:06:29 +0000
Message-ID: <1ae13bccdff74cdd9a7cd7fc9442e2ad@AcuMS.aculab.com>
References: <20231222121040.2635879-1-zengheng4@huawei.com>
 <9c48658677a6475eb4fe13baed798e97@AcuMS.aculab.com>
 <5ac8c272-6887-5406-50e3-7b87b302498d@huawei.com>
In-Reply-To: <5ac8c272-6887-5406-50e3-7b87b302498d@huawei.com>
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

RnJvbTogWmVuZyBIZW5nDQo+IFNlbnQ6IDIzIERlY2VtYmVyIDIwMjMgMDg6NTUNCj4gDQo+IOWc
qCAyMDIzLzEyLzIyIDIwOjQwLCBEYXZpZCBMYWlnaHQg5YaZ6YGTOg0KPiA+IEZyb206IFplbmcg
SGVuZw0KPiA+PiBTZW50OiAyMiBEZWNlbWJlciAyMDIzIDEyOjExDQo+ID4+DQo+ID4+IFVzaW5n
IHRoZSBVbml4QmVuY2ggdGVzdCBzdWl0ZSwgd2UgY2xlYXJseSBmaW5kIHRoYXQgb3NxX2xvY2so
KSBjYXVzZQ0KPiA+PiBleHRyZW1lbHkgaGlnaCBvdmVyaGVhZHMgd2l0aCBwZXJmIHRvb2wgaW4g
dGhlIEZpbGUgQ29weSBpdGVtczoNCj4gPj4NCj4gPj4gT3ZlcmhlYWQgIFNoYXJlZCBPYmplY3Qg
ICAgICAgICAgICBTeW1ib2wNCj4gPj4gICAgOTQuMjUlICBba2VybmVsXSAgICAgICAgICAgICAg
ICAgW2tdIG9zcV9sb2NrDQo+ID4+ICAgICAwLjc0JSAgW2tlcm5lbF0gICAgICAgICAgICAgICAg
IFtrXSByd3NlbV9zcGluX29uX293bmVyDQo+ID4+ICAgICAwLjMyJSAgW2tlcm5lbF0gICAgICAg
ICAgICAgICAgIFtrXSBmaWxlbWFwX2dldF9yZWFkX2JhdGNoDQo+ID4+DQo+ID4+IEluIHJlc3Bv
bnNlIHRvIHRoaXMsIHdlIGNvbmR1Y3RlZCBhbiBhbmFseXNpcyBhbmQgbWFkZSBzb21lIGdhaW5z
Og0KPiA+Pg0KPiA+PiBJbiB0aGUgcHJvbG9ndWUgb2Ygb3NxX2xvY2soKSwgaXQgc2V0IGBjcHVg
IG1lbWJlciBvZiBwZXJjcHUgc3RydWN0DQo+ID4+IG9wdGltaXN0aWNfc3Bpbl9ub2RlIHdpdGgg
dGhlIGxvY2FsIGNwdSBpZCwgYWZ0ZXIgdGhhdCB0aGUgdmFsdWUgb2YgdGhlDQo+ID4+IHBlcmNw
dSBzdHJ1Y3Qgd291bGQgbmV2ZXIgY2hhbmdlIGluIGZhY3QuIEJhc2VkIG9uIHRoYXQsIHdlIGNh
biByZWdhcmQNCj4gPj4gdGhlIGBjcHVgIG1lbWJlciBhcyBhIGNvbnN0YW50IHZhcmlhYmxlLg0K
PiA+Pg0KPiA+IC4uLg0KPiA+PiBAQCAtOSw3ICsxMSwxMyBAQA0KPiA+PiAgIHN0cnVjdCBvcHRp
bWlzdGljX3NwaW5fbm9kZSB7DQo+ID4+ICAgCXN0cnVjdCBvcHRpbWlzdGljX3NwaW5fbm9kZSAq
bmV4dCwgKnByZXY7DQo+ID4+ICAgCWludCBsb2NrZWQ7IC8qIDEgaWYgbG9jayBhY3F1aXJlZCAq
Lw0KPiA+PiAtCWludCBjcHU7IC8qIGVuY29kZWQgQ1BVICMgKyAxIHZhbHVlICovDQo+ID4+ICsN
Cj4gPj4gKwlDQUNIRUxJTkVfUEFERElORyhfcGFkMV8pOw0KPiA+PiArCS8qDQo+ID4+ICsJICog
U3RvcmVzIGFuIGVuY29kZWQgQ1BVICMgKyAxIHZhbHVlLg0KPiA+PiArCSAqIE9ubHkgcmVhZCBi
eSBvdGhlciBjcHVzLCBzbyBzcGxpdCBpbnRvIGRpZmZlcmVudCBjYWNoZSBsaW5lcy4NCj4gPj4g
KwkgKi8NCj4gPj4gKwlpbnQgY3B1Ow0KPiA+PiAgIH07DQo+ID4gSXNuJ3QgdGhpcyBzdHJ1Y3R1
cmUgZW1iZWRkZWQgaW4gZXZlcnkgbXV0ZXggYW5kIHJ3c2VtIChldGMpPw0KPiA+IFNvIHRoYXQg
aXMgYSBzaWduaWZpY2FudCBibG9hdCBlc3BlY2lhbGx5IG9uIHN5c3RlbXMgd2l0aA0KPiA+IGxh
cmdlIGNhY2hlIGxpbmVzLg0KDQpUaGlzIGNvZGUgaXMgbWFraW5nIG15IGhlYWQgaHVydCA6LSkN
ClRoZSAnc3Bpbl9ub2RlJyBkb2VzIG9ubHkgZXhpc3QgcGVyLWNwdS4NCg0KPiA+IERpZCB5b3Ug
dHJ5IGp1c3QgbW92aW5nIHRoZSBpbml0aWFsaXNhdGlvbiBvZiB0aGUgcGVyLWNwdSAnbm9kZScN
Cj4gPiBiZWxvdyB0aGUgZmlyc3QgZmFzdC1wYXRoICh1bmNvbnRlbmRlZCkgdGVzdCBpbiBvc3Ff
bG9jaygpPw0KDQpSZWFkaW5nIG1vcmUgY2xvc2VseSB0aGV5IGRvIG5lZWQgdG8gYmUgdmFsaWQg
YmVmb3JlIHRoZSBmYXN0LXBhdGgNCmNtcHhjaGcuDQpCdXQgSSBzdXNwZWN0IHRoZSAnY2FjaGUg
bGluZSBkaXJ0eScgY291bGQgYmUgZG9uZSBjb25kaXRpb25hbGx5DQpvciBpbiB0aGUgdW5sb2Nr
L2ZhaWwgcGF0aC4NCg0KSSB0aGluayB0aGUgdW5sb2NrIGZhc3QtcGF0aCBhbHdheXMgaGFzIG5v
ZGUtPm5leHQgPT0gTlVMTCBhbmQgaXQgaXMNCnNldCB0byBOVUxMIGluIHRoZSBzbG93IHBhdGgu
DQpUaGUgbG9jay1mYWlsIHBhdGggY2FsbHMgb3NxX3dhaXRfbmV4dCgpIC0gd2hpY2ggYWxzbyBO
VUxMcyBpdC4NClNvIG1heWJlIGl0IGlzIGFsd2F5cyBOVUxMIG9uIGVudHJ5IGFueXdheT8NCg0K
bm9kZS0+bG9ja2VkIGlzIHNldCBieSB0aGUgc2xvdy1wYXRoIGxvY2sgY29kZS4NClNvIGNvdWxk
IGJlIGNsZWFyZWQgd2hlbiBjaGVja2VkIG9yIGFueSB0aW1lIGJlZm9yZSB0aGUgdW5sb2NrIHJl
dHVybnMuDQpQb3NzaWJseSB1bmNvbmRpdGlvbmFsbHkgaW4gdGhlIHVubG9jayBzbG93IHBhdGgg
YW5kIGNvbmRpdGlvbmFsbHkNCmluIHRoZSB1bmxvY2sgZmFzdCBwYXRoPw0KDQpJIHRoaW5rIHRo
YXQgd291bGQgbWVhbiB0aGUgYXNzaWdubWVudCB0byBub2RlIGluIG9zcV9sb2NrKCkgY291bGQN
CmJlIG1vdmVkIGJlbG93IHRoZSBmaXJzdCB4Y2hnKCkgKHByb3ZpZGVkICdub2RlJyBjYW4gYmUg
aW5pdGlhbGlzZWQpLg0KDQpJIGFsc28gd29uZGVyIHdoYXQgdGhlIHBlcmZvcm1hbmNlIGRpZmZl
cmVuY2UgaXMgYmV0d2Vlbg0Kc21wX3Byb2Nlc3Nvcl9pZCgpIGFuZCB0aGlzX2NwdV9wdHIoJm9z
cV9ub2RlKT8NCg0KQmxvYXRpbmcgYWxsIHRoZSBtdXRleC9yd3NlbSBieSA0IGJ5dGVzIChvbiA2
NGJpdCkgYW5kIGNoYW5naW5nDQpsb2NrLT50YWlsIHRvICdzdHJ1Y3Qgb3B0aW1pc3RpY19zcGlu
X25vZGUgKicgKGFuZCBtb3ZpbmcgaXQncw0KZGVmaW5pdGlvbiBpbnRvIHRoZSAuYyBmaWxlKSBt
YXkgd2VsbCBpbXByb3ZlIHBlcmZvcm1hbmNlPw0KDQoNCj4gPg0KPiA+IE9UT0ggaWYgeW91IHJl
YWxseSBoYXZlIG11bHRpcGxlIGNwdSBzcGlubmluZyBvbiB0aGUgc2FtZSByd3NlbQ0KPiA+IHBl
cmhhcHMgdGhlIHRlc3QgYW5kL29yIGZpbGVtYXAgY29kZSBhcmUgcmVhbGx5IGF0IGZhdWx0IQ0K
PiA+DQo+ID4gCURhdmlkDQo+IA0KPiBIae+8jA0KPiANCj4gVGhlIEZpbGUgQ29weSBpdGVtcyBv
ZiBVbml4QmVuY2ggdGVzdHN1aXRlIGFyZSB1c2luZyAxIHJlYWQgZmlsZSBhbmQgMQ0KPiB3cml0
ZSBmaWxlDQo+IA0KPiBmb3IgZmlsZSByZWFkL3dyaXRlL2NvcHkgdGVzdC4gSW4gbXVsdGktcGFy
YWxsZWwgc2NlbmFyaW8sIHRoYXQgd291bGQNCj4gbGVhZCB0byBoaWdoIGZpbGUgbG9jayBjb250
ZW50aW9uLg0KPiANCj4gVGhhdCBpcyBqdXN0IGEgcGVyZm9ybWFuY2UgdGVzdCBzdWl0ZSBhbmQg
aGFzIG5vdGhpbmcgdG8gZG8gd2l0aCB3aGV0aGVyDQo+IHRoZSB1c2VyIHByb2dyYW0gZGVzaWdu
IGlzIGNvcnJlY3Qgb3Igbm90Lg0KDQpCdXQgaXQgbWlnaHQgYmUgc3RyZXNzaW5nIHNvbWUgY29k
ZSBwYXRocyB0aGF0IGRvbid0IHVzdWFsbHkgaGFwcGVuLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0
ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBL
ZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


