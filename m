Return-Path: <linux-kernel+bounces-13474-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AACF9820706
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 16:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D26AC1C21325
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 15:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87999947F;
	Sat, 30 Dec 2023 15:50:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336389463
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 15:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-306-jwZb9lA4P3CsjZZsKkovPg-1; Sat, 30 Dec 2023 15:50:09 +0000
X-MC-Unique: jwZb9lA4P3CsjZZsKkovPg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Dec
 2023 15:49:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Dec 2023 15:49:53 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, "'linux-kernel@vger.kernel.org'"
	<linux-kernel@vger.kernel.org>, "'peterz@infradead.org'"
	<peterz@infradead.org>
CC: "'mingo@redhat.com'" <mingo@redhat.com>, "'will@kernel.org'"
	<will@kernel.org>, "'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, "'Linus
 Torvalds'" <torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local cpu's
 'node' in the osq_lock() fast path.
Thread-Topic: [PATCH next 2/5] locking/osq_lock: Avoid dirtying the local
 cpu's 'node' in the osq_lock() fast path.
Thread-Index: Ado6o/zBb4T2uRNuSTy7E9ZX7SDa6wAKyRqAABQrXQA=
Date: Sat, 30 Dec 2023 15:49:52 +0000
Message-ID: <fedbf107b9344e7b85711c0de59ae0a3@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <fbb1f9ed42b2460c93eeac43a92157c8@AcuMS.aculab.com>
 <835f65d9-a041-4956-b89d-7cd3660c3ab8@redhat.com>
In-Reply-To: <835f65d9-a041-4956-b89d-7cd3660c3ab8@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMzAgRGVjZW1iZXIgMjAyMyAwMzoyMA0KPiANCj4g
T24gMTIvMjkvMjMgMTc6MTEsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPiBvc3FfbG9jaygpIHN0
YXJ0cyBieSBzZXR0aW5nIG5vZGUtPm5leHQgdG8gTlVMTCBhbmQgbm9kZS0+bG9ja2VkIHRvIDAu
DQo+ID4gQ2FyZWZ1bCBhbmFseXNpcyBzaG93cyB0aGF0IG5vZGUtPm5leHQgaXMgYWx3YXlzIE5V
TEwgb24gZW50cnkuDQo+ID4NCj4gPiBub2RlLT5sb2NrZWQgaXMgc2V0IG5vbi16ZXJvIGJ5IGFu
b3RoZXIgY3B1IHRvIGZvcmNlIGEgd2FrZXVwLg0KPiA+IFRoaXMgY2FuIG9ubHkgaGFwcGVuIGFm
dGVyIHRoZSAncHJldi0+bmV4dCA9IG5vZGUnIGFzc2lnbm1lbnQsDQo+ID4gc28gbG9ja2VkIGNh
biBiZSBzZXQgdG8gemVybyBqdXN0IGJlZm9yZSB0aGF0IChhbG9uZyB3aXRoIHRoZSBhc3NpZ25t
ZW50DQo+ID4gdG8gbm9kZS0+cHJldikuDQo+ID4NCj4gPiBPbmx5IGluaXRpYWxpc2Ugbm9kZS0+
Y3B1IG9uY2UsIGFmdGVyIHRoYXQgdXNlIGl0cyB2YWx1ZSBpbnN0ZWFkDQo+ID4gb2Ygc21wX3By
b2Nlc3Nvcl9pZCgpIC0gd2hpY2ggaXMgcHJvYmFibHkgYSByZWFsIGZ1bmN0aW9uIGNhbGwuDQo+
ID4NCj4gPiBTaG91bGQgcmVkdWNlIGNhY2hlLWxpbmUgYm91bmNpbmcgYSBsaXR0bGUuDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBEYXZpZCBMYWlnaHQgPGRhdmlkLmxhaWdodEBhY3VsYWIuY29t
Pg0KPiA+IC0tLQ0KPiA+DQo+ID4gUmUtc2VuZCB3aXRob3V0IHRoZSAnUkU6JyBvbiB0aGUgc3Vi
amVjdCBsaW5lLg0KPiA+ICAga2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYyB8IDEzICsrKysrKy0t
LS0tLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25z
KC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYyBiL2tl
cm5lbC9sb2NraW5nL29zcV9sb2NrLmMNCj4gPiBpbmRleCBkNDE0ZWVmNGJlYzYuLjU1ZjVkYjg5
NmMwMiAxMDA2NDQNCj4gPiAtLS0gYS9rZXJuZWwvbG9ja2luZy9vc3FfbG9jay5jDQo+ID4gKysr
IGIva2VybmVsL2xvY2tpbmcvb3NxX2xvY2suYw0KPiA+IEBAIC01MSw3ICs1MSw3IEBAIG9zcV93
YWl0X25leHQoc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9xdWV1ZSAqbG9jaywNCj4gPiAgIAkgICAg
ICBzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX25vZGUgKnByZXYpDQo+ID4gICB7DQo+ID4gICAJc3Ry
dWN0IG9wdGltaXN0aWNfc3Bpbl9ub2RlICpuZXh0ID0gTlVMTDsNCj4gPiAtCWludCBjdXJyID0g
ZW5jb2RlX2NwdShzbXBfcHJvY2Vzc29yX2lkKCkpOw0KPiA+ICsJaW50IGN1cnIgPSBub2RlLT5j
cHU7DQo+ID4gICAJaW50IG9sZDsNCj4gPg0KPiA+ICAgCS8qDQo+ID4gQEAgLTk4LDEyICs5OCwx
MCBAQCBib29sIG9zcV9sb2NrKHN0cnVjdCBvcHRpbWlzdGljX3NwaW5fcXVldWUgKmxvY2spDQo+
ID4gICB7DQo+ID4gICAJc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9ub2RlICpub2RlID0gdGhpc19j
cHVfcHRyKCZvc3Ffbm9kZSk7DQo+ID4gICAJc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9ub2RlICpw
cmV2LCAqbmV4dDsNCj4gPiAtCWludCBjdXJyID0gZW5jb2RlX2NwdShzbXBfcHJvY2Vzc29yX2lk
KCkpOw0KPiA+ICAgCWludCBvbGQ7DQo+ID4NCj4gPiAtCW5vZGUtPmxvY2tlZCA9IDA7DQo+ID4g
LQlub2RlLT5uZXh0ID0gTlVMTDsNCj4gDQo+IEkgaGF2ZSBzb21lIGNvbmNlcm4gYWJvdXQgbm90
IGNsZWFyaW5nIG5vZGUtPm5leHQgYXQgdGhlIGJlZ2lubmluZy4gSQ0KPiBrbm93IHRoYXQgbmV4
dCBpcyBzdXBwb3NlZCB0byBiZSBjbGVhcmVkIGF0IHRoZSBlbmQuIEkgZG8gaGF2ZSBzb21lDQo+
IHdvcnJ5IHRoYXQgdGhlcmUgbWF5IGV4aXN0IGEgcmFjZSBjb25kaXRpb24gdGhhdCBsZWF2ZXMg
bmV4dCBub3QgY2xlYXJlZA0KPiBiZWZvcmUgaXQgaXMgdXNlZCBhZ2Fpbi4gU28geW91IGVpdGhl
ciBoYXZlIHRvIHByb3ZlIHRoYXQgc3VjaCBhIHJhY2UNCj4gZG9lcyBub3QgZXhpc3QsIG9yIGlu
aXRpYWxpemluZyBpdCB0byBOVUxMIGF0IHRoZSBiZWdpbm5pbmcgbGlrZSBpdCBpcw0KPiB0b2Rh
eS4NCg0KSSd2ZSBzdGFyZWQgYXQgdGhlIGNvZGUgc29tZSBtb3JlIDotKQ0KDQpUaGVyZSBhcmUg
dHdvIHBsYWNlcyB3aGVyZSBub2RlLT5uZXh0IGlzIHdyaXR0ZW4gbm9uLU5VTEwsIGJvdGggaW4g
b3NxX2xvY2soKS4NClRoZSBmaXJzdCBpcyBhdCB0aGUgdG9wIG9mIHRoZSBzbG93LXBhdGggd2hl
cmUgcHJldi0+bmV4dCA9IG5vZGUNCih0aGlzIHNob3VsZCBiZSBvdmVyd3JpdGluZyB0aGUgTlVM
TCBzZXQgKG9yIG5vdCkgb24gZW50cnkpLg0KVGhlIHNlY29uZCBpcyBhdCB0aGUgYm90dG9tIG9m
IG9zcV9sb2NrKCkgcHJldi0+bmV4dCA9IG5leHQgKFN0ZXAgQykNCndoZXJlIHRoZSBOVUxMIHdy
aXR0ZW4gaW4gU3RlcCBBIGlzIHdyaXR0ZW4gd2l0aCB0aGUgY29ycmVjdCAnbmV4dCcgbm9kZS4N
CkFmdGVyIGVpdGhlciBvZiB0aG9zZSB0aGUgJ25vZGUnIGNwdSBtdXN0IGxhdGVyIGVpdGhlciB0
YWtlIHRoZSB1bnF1ZXVlDQpleGl0IGZyb20gb3NxX2xvY2soKSBvciBjYWxsIG9zcV91bmxvY2so
KS4NCkJvdGggcmVxdWlyZSBpdCB3YWl0IGZvciBub2RlLT5uZXh0IGJlIG5vbi1OVUxMIGFuZCBO
VUxMIGl0Lg0KDQpJZiBjb2RlIGNhbGxzIG9zcV9sb2NrKCkgdHdpY2UgYWxsIGJldHMgYXJlIG9m
ZiENCg0KRXZlbiBpZiAoc29tZWhvdykgbm9kZS0+bmV4dCB3YXMgbm9uLU5VTEwgb24gZW50cnkg
aXQgd2lsbCBiZSBzZXQgYnkgYW4NCm9zcV9sb2NrKCkgY2FsbCBmcm9tIGFub3RoZXIgY3B1Lg0K
VGhlIG9ubHkgcHJvYmxlbSB3b3VsZCBiZSBpZiBvc3FfdW5sb2NrKCkgd2VyZSBjYWxsZWQgYmVm
b3JlIHRoZSBxdWV1ZWluZw0KY3B1IHNldCBwcmV2LT5uZXh0ID0gbm9kZS4NClRoYXQgaW4gaXRz
ZWxmIGlzIHVubGlrZWx5IC0gYnV0IHdvdWxkIGhhcHBlbiBpZiBub2RlLT5uZXh0IHdlcmUgYWx3
YXlzIHNldC4NCg0KSSBkb24ndCBjb21wbGV0ZWx5IHVuZGVyc3RhbmQgdGhlICdhY3F1aXJlJy8n
cmVsZWFzZScgc2VtYW50aWNzICh0aGV5IGRpZG4ndA0KZXhpc3Qgd2hlbiBJIHN0YXJ0ZWQgZG9p
bmcgU01QIGtlcm5lbCBjb2RlIGluIHRoZSBsYXRlIDE5ODBzKS4NCkJ1dCBpdCBsb29rcyBvZGQg
dGhhdCBvc3FfdW5sb2NrKCkncyBmYXN0IHBhdGggdXNlcyBfcmVsZWFzZSBidXQgdGhlIHZlcnkN
CnNpbWlsYXIgY29kZSBpbiBvc3Ffd2FpdF9uZXh0KCkgdXNlcyBfYWNxdWlyZS4NCg0KSW5kZWVk
LCBhcGFydCBmcm9tIHNvbWUgKGFzc3VtZWQpIG9wdGltaXNhdGlvbnMsIEkgdGhpbmsgb3NxX3Vu
bG9jaygpDQpjb3VsZCBqdXN0IGJlOg0KCW5leHQgPSBvc3Ffd2FpdF9uZXh0KGxvY2ssIHRoaXNf
Y3B1X3B0cigmb3NxX25vZGUpLCAwKTsNCglpZiAobmV4dCkNCgkJbmV4dC0+bG9ja2VkID0gMTsN
Cg0KSSBkb24ndCB0aGluayB0aGUgb3JkZXIgb2YgdGhlIHRlc3RzIGZvciBsb2NrLT50YWlsIGFu
ZCBub2RlLT5uZXh0DQptYXR0ZXIgaW4gb3NxX3dhaXRfbmV4dCgpLg0KSWYgdGhleSB3ZXJlIHN3
YXBwZWQgdGhlICdTZWNvbmQgbW9zdCBsaWtlbHkgY2FzZScgY29kZSBmcm9tIG9zcV91bmxvY2so
KQ0KY291bGQgYmUgcmVtb3ZlZC4NCihUaGUgJ3VuY29udGVuZGVkIGNhc2UnIGRvZXNuJ3QgbmVl
ZCB0byBsb2FkIHRoZSBhZGRyZXNzIG9mICdub2RlJy4pDQoNCglEYXZpZA0KCQkNCg0KLQ0KUmVn
aXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRv
biBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


