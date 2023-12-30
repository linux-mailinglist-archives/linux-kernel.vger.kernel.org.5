Return-Path: <linux-kernel+bounces-13600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 747CD8208AA
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 23:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25D641F224BB
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 22:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CEBD309;
	Sat, 30 Dec 2023 22:38:19 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2A06D6E0
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 22:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-225-rooaNgzzMKyamPFKEtCO9g-1; Sat, 30 Dec 2023 22:38:08 +0000
X-MC-Unique: rooaNgzzMKyamPFKEtCO9g-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 30 Dec
 2023 22:37:49 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 30 Dec 2023 22:37:49 +0000
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
Subject: RE: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Thread-Topic: [PATCH next 5/5] locking/osq_lock: Optimise vcpu_is_preempted()
 check.
Thread-Index: Ado6mcFsTi5k8LaETrKavOOIB4in0QAnx9ObAA2GvrA=
Date: Sat, 30 Dec 2023 22:37:49 +0000
Message-ID: <d5b2f1ed1fa3473fb8b73a0836f9b3b1@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <23cef5ac49494b9087953f529ae5df16@AcuMS.aculab.com>
 <e7cf4154-294e-40bd-a485-0b23220d4b7a@redhat.com>
 <3b5c5cf3-1b8b-4815-8d19-2e28c9751305@redhat.com>
In-Reply-To: <3b5c5cf3-1b8b-4815-8d19-2e28c9751305@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMzAgRGVjZW1iZXIgMjAyMyAxNTo1Nw0KPiANCj4g
T24gMTIvMjkvMjMgMjI6MTMsIFdhaW1hbiBMb25nIHdyb3RlOg0KPiA+DQo+ID4gT24gMTIvMjkv
MjMgMTU6NTgsIERhdmlkIExhaWdodCB3cm90ZToNCj4gPj4gVGhlIHZjcHVfaXNfcHJlZW1wdGVk
KCkgdGVzdCBzdG9wcyBvc3FfbG9jaygpIHNwaW5uaW5nIGlmIGEgdmlydHVhbA0KPiA+PiDCoMKg
IGNwdSBpcyBubyBsb25nZXIgcnVubmluZy4NCj4gPj4gQWx0aG91Z2ggcGF0Y2hlZCBvdXQgZm9y
IGJhcmUtbWV0YWwgdGhlIGNvZGUgc3RpbGwgbmVlZHMgdGhlIGNwdSBudW1iZXIuDQo+ID4+IFJl
YWRpbmcgdGhpcyBmcm9tICdwcmV2LT5jcHUnIGlzIGEgcHJldHR5IG11Y2ggZ3VhcmFudGVlZCBo
YXZlIGENCj4gPj4gY2FjaGUgbWlzcw0KPiA+PiB3aGVuIG9zcV91bmxvY2soKSBpcyB3YWtpbmcg
dXAgdGhlIG5leHQgY3B1Lg0KPiA+Pg0KPiA+PiBJbnN0ZWFkIHNhdmUgJ3ByZXYtPmNwdScgaW4g
J25vZGUtPnByZXZfY3B1JyBhbmQgdXNlIHRoYXQgdmFsdWUgaW5zdGVhZC4NCj4gPj4gVXBkYXRl
IGluIHRoZSBvc3FfbG9jaygpICd1bnF1ZXVlJyBwYXRoIHdoZW4gJ25vZGUtPnByZXYnIGlzIGNo
YW5nZWQuDQo+ID4+DQo+ID4+IFRoaXMgaXMgc2ltcGxlciB0aGFuIGNoZWNraW5nIGZvciAnbm9k
ZS0+cHJldicgY2hhbmdpbmcgYW5kIGNhY2hpbmcNCj4gPj4gJ3ByZXYtPmNwdScuDQo+ID4+DQo+
ID4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIExhaWdodCA8ZGF2aWQubGFpZ2h0QGFjdWxhYi5jb20+
DQo+ID4+IC0tLQ0KPiA+PiDCoCBrZXJuZWwvbG9ja2luZy9vc3FfbG9jay5jIHwgMTQgKysrKysr
LS0tLS0tLS0NCj4gPj4gwqAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2tlcm5lbC9sb2NraW5nL29zcV9sb2Nr
LmMgYi9rZXJuZWwvbG9ja2luZy9vc3FfbG9jay5jDQo+ID4+IGluZGV4IGI2MGIwYWRkMDE2MS4u
ODliZTYzNjI3NDM0IDEwMDY0NA0KPiA+PiAtLS0gYS9rZXJuZWwvbG9ja2luZy9vc3FfbG9jay5j
DQo+ID4+ICsrKyBiL2tlcm5lbC9sb2NraW5nL29zcV9sb2NrLmMNCj4gPj4gQEAgLTE0LDggKzE0
LDkgQEANCj4gPj4gwqAgwqAgc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9ub2RlIHsNCj4gPj4gwqDC
oMKgwqDCoCBzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX25vZGUgKnNlbGYsICpuZXh0LCAqcHJldjsN
Cj4gPj4gLcKgwqDCoCBpbnQgbG9ja2VkOyAvKiAxIGlmIGxvY2sgYWNxdWlyZWQgKi8NCj4gPj4g
LcKgwqDCoCBpbnQgY3B1OyAvKiBlbmNvZGVkIENQVSAjICsgMSB2YWx1ZSAqLw0KPiA+PiArwqDC
oMKgIGludCBsb2NrZWQ7wqDCoMKgIC8qIDEgaWYgbG9jayBhY3F1aXJlZCAqLw0KPiA+PiArwqDC
oMKgIGludCBjcHU7wqDCoMKgwqDCoMKgIC8qIGVuY29kZWQgQ1BVICMgKyAxIHZhbHVlICovDQo+
ID4+ICvCoMKgwqAgaW50IHByZXZfY3B1O8KgIC8qIGFjdHVhbCBDUFUgIyBmb3IgdnBjdV9pc19w
cmVlbXB0ZWQoKSAqLw0KPiA+PiDCoCB9Ow0KPiA+PiDCoCDCoCBzdGF0aWMgREVGSU5FX1BFUl9D
UFVfU0hBUkVEX0FMSUdORUQoc3RydWN0IG9wdGltaXN0aWNfc3Bpbl9ub2RlLA0KPiA+PiBvc3Ff
bm9kZSk7DQo+ID4+IEBAIC0yOSwxMSArMzAsNiBAQCBzdGF0aWMgaW5saW5lIGludCBlbmNvZGVf
Y3B1KGludCBjcHVfbnIpDQo+ID4+IMKgwqDCoMKgwqAgcmV0dXJuIGNwdV9uciArIDE7DQo+ID4+
IMKgIH0NCj4gPj4gwqAgLXN0YXRpYyBpbmxpbmUgaW50IG5vZGVfY3B1KHN0cnVjdCBvcHRpbWlz
dGljX3NwaW5fbm9kZSAqbm9kZSkNCj4gPj4gLXsNCj4gPj4gLcKgwqDCoCByZXR1cm4gbm9kZS0+
Y3B1IC0gMTsNCj4gPj4gLX0NCj4gPj4gLQ0KPiA+PiDCoCBzdGF0aWMgaW5saW5lIHN0cnVjdCBv
cHRpbWlzdGljX3NwaW5fbm9kZSAqZGVjb2RlX2NwdShpbnQNCj4gPj4gZW5jb2RlZF9jcHVfdmFs
KQ0KPiA+PiDCoCB7DQo+ID4+IMKgwqDCoMKgwqAgaW50IGNwdV9uciA9IGVuY29kZWRfY3B1X3Zh
bCAtIDE7DQo+ID4+IEBAIC0xMTQsNiArMTEwLDcgQEAgYm9vbCBvc3FfbG9jayhzdHJ1Y3Qgb3B0
aW1pc3RpY19zcGluX3F1ZXVlICpsb2NrKQ0KPiA+PiDCoMKgwqDCoMKgIGlmIChvbGQgPT0gT1NR
X1VOTE9DS0VEX1ZBTCkNCj4gPj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPiA+
PiDCoCArwqDCoMKgIG5vZGUtPnByZXZfY3B1ID0gb2xkIC0gMTsNCj4gPj4gwqDCoMKgwqDCoCBw
cmV2ID0gZGVjb2RlX2NwdShvbGQpOw0KPiA+PiDCoMKgwqDCoMKgIG5vZGUtPnByZXYgPSBwcmV2
Ow0KPiA+PiDCoMKgwqDCoMKgIG5vZGUtPmxvY2tlZCA9IDA7DQo+ID4+IEBAIC0xNDgsNyArMTQ1
LDcgQEAgYm9vbCBvc3FfbG9jayhzdHJ1Y3Qgb3B0aW1pc3RpY19zcGluX3F1ZXVlICpsb2NrKQ0K
PiA+PiDCoMKgwqDCoMKgwqAgKiBwb2xsaW5nLCBiZSBjYXJlZnVsLg0KPiA+PiDCoMKgwqDCoMKg
wqAgKi8NCj4gPj4gwqDCoMKgwqDCoCBpZiAoc21wX2NvbmRfbG9hZF9yZWxheGVkKCZub2RlLT5s
b2NrZWQsIFZBTCB8fCBuZWVkX3Jlc2NoZWQoKSB8fA0KPiA+PiAtwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCB2Y3B1X2lzX3ByZWVtcHRlZChub2RlX2NwdShub2RlLT5wcmV2KSkp
KQ0KPiA+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2Y3B1X2lzX3ByZWVt
cHRlZChub2RlLT5wcmV2X2NwdSkpKQ0KPiANCj4gT24gc2Vjb25kIHRob3VnaHQsIEkgYmVsaWV2
ZSBpdCBpcyBtb3JlIGNvcnJlY3QgdG8gdXNlIFJFQURfT05DRSgpIHRvDQo+IGFjY2VzcyAibm9k
ZS0+cHJldl9jcHUiIGFzIHRoaXMgZmllbGQgaXMgc3ViamVjdGVkIHRvIGNoYW5nZSBieSBhDQo+
IFdSSVRFX09OQ0UoKS4NCg0KSXQgY2FuIGJlIGRvbmUuLi4NCg0KQXJlbid0IHByZXR0eSBtdWNo
IGFsbCB0aGUgJ25vZGUnIG1lbWJlcnMgYWNjZXNzZWQgbGlrZSB0aGF0Pw0KVGhlcmUgYXJlIGEg
c3ByaW5rbGluZyBvZiBSRUFEX09OQ0UoKSBhbmQgV1JJVEVfT05DRSgpIGJ1dCB0aGV5DQphcmUg
bm90IGFsd2F5cyB1c2VkLg0KDQpNYXliZSB0aGUgc3RydWN0dXJlIG1lbWJlcihzKSBzaG91bGQg
anVzdCBiZSBtYXJrZWQgJ3ZvbGF0aWxlJyA6LSkNClRoYXQgc2hvdWxkIGhhdmUgZXhhY3RseSB0
aGUgc2FtZSBlZmZlY3QgYXMgdGhlIHZvbGF0aWxlIGNhc3QNCmluc2lkZSBSRUFEL1dSSVRFX09O
Q0UoKS4NCihJIGtub3cgdGhlcmUgaXMgYSBkb2N1bWVudCBhYm91dCBub3QgdXNpbmcgdm9sYXRp
bGUuLi4pDQoNCkkndmUgbm90IGFjdHVhbGx5IGNoZWNrZWQgd2hldGhlciB0aGUgdHdvIGV4aXN0
aW5nIFdSSVRFX09OQ0UoKQ0KaW4gJ1N0ZXAgQycgbmVlZCB0byBiZSBvcmRlcmVkIC0gYW5kIHdo
ZXRoZXIgdGhhdCBpcyBndWFyYW50ZWVkDQpieSB0aGUgY29kZSwgZXNwZWNpYWxseSBvbiBvdXQg
Z29vZCBvbGQgZnJpZW5kICdBbHBoYScgKGlzIHRoYXQNCmhvcnJpZCBjYWNoZSBzeXN0ZW0gc3Rp
bGwgc3VwcG9ydGVkPykuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNp
ZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsN
ClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=


