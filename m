Return-Path: <linux-kernel+bounces-13686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E96820B12
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 11:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8DE43B21281
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6B68F60;
	Sun, 31 Dec 2023 10:37:08 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3998F42
	for <linux-kernel@vger.kernel.org>; Sun, 31 Dec 2023 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-167-hl52G5dpPUiy9gyuEPsLjw-1; Sun, 31 Dec 2023 10:37:02 +0000
X-MC-Unique: hl52G5dpPUiy9gyuEPsLjw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 31 Dec
 2023 10:36:43 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 31 Dec 2023 10:36:42 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Waiman Long' <longman@redhat.com>, 'Ingo Molnar' <mingo@kernel.org>
CC: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'peterz@infradead.org'" <peterz@infradead.org>, "'mingo@redhat.com'"
	<mingo@redhat.com>, "'will@kernel.org'" <will@kernel.org>,
	"'boqun.feng@gmail.com'" <boqun.feng@gmail.com>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>, "'xinhui.pan@linux.vnet.ibm.com'"
	<xinhui.pan@linux.vnet.ibm.com>,
	"'virtualization@lists.linux-foundation.org'"
	<virtualization@lists.linux-foundation.org>, 'Zeng Heng'
	<zengheng4@huawei.com>
Subject: RE: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Topic: [PATCH next 4/5] locking/osq_lock: Optimise per-cpu data
 accesses.
Thread-Index: Ado6mZUJWFdx4PkETd+mn/PWVjPd0AAdwkAdAABoNTAAIPHkAAAPh8wQ
Date: Sun, 31 Dec 2023 10:36:42 +0000
Message-ID: <2241a2a53f48448c9fb435f893444cd7@AcuMS.aculab.com>
References: <73a4b31c9c874081baabad9e5f2e5204@AcuMS.aculab.com>
 <bddb6b00434d4492abca4725c10f8d5a@AcuMS.aculab.com>
 <346c40b5-686f-461e-a1e3-9f255418efb2@redhat.com>
 <ZY/6YCNJ7tSCmiGo@gmail.com>
 <4b9da867c24f4ff990851050c8f61515@AcuMS.aculab.com>
 <910ac70a-5503-4594-b5b2-b2ba86bf8435@redhat.com>
In-Reply-To: <910ac70a-5503-4594-b5b2-b2ba86bf8435@redhat.com>
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

RnJvbTogV2FpbWFuIExvbmcNCj4gU2VudDogMzEgRGVjZW1iZXIgMjAyMyAwMzowNA0KLi4uLg0K
PiBUaGUgcHJlc2VuY2Ugb2YgZGVidWdfc21wX3Byb2Nlc3Nvcl9pZCBpbiB5b3VyIGNvbXBpbGVk
IGNvZGUgaXMgbGlrZWx5DQo+IGR1ZSB0byB0aGUgc2V0dGluZyBvZiBDT05GSUdfREVCVUdfUFJF
RU1QVCBpbiB5b3VyIGtlcm5lbCBjb25maWcuDQo+IA0KPiAjaWZkZWYgQ09ORklHX0RFQlVHX1BS
RUVNUFQNCj4gIMKgIGV4dGVybiB1bnNpZ25lZCBpbnQgZGVidWdfc21wX3Byb2Nlc3Nvcl9pZCh2
b2lkKTsNCj4gIyBkZWZpbmUgc21wX3Byb2Nlc3Nvcl9pZCgpIGRlYnVnX3NtcF9wcm9jZXNzb3Jf
aWQoKQ0KPiAjZWxzZQ0KPiAjIGRlZmluZSBzbXBfcHJvY2Vzc29yX2lkKCkgX19zbXBfcHJvY2Vz
c29yX2lkKCkNCj4gI2VuZGlmDQo+IA0KPiBJIGRvbid0IGhhdmUgdGhhdCBjb25maWcgZW50cnkg
aW4gbXkga2VybmVsIGNvbmZpZyBhbmQgc28gSSBvbmx5IGdldCAyDQo+IGluc3RydWN0aW9ucyBm
b3IgdGhpc19jcHVfcHRyKCkuIFdlIGFyZSBub3QgZ29pbmcgdG8gb3B0aW1pemUgdGhlIGNvZGUN
Cj4gc3BlY2lmaWNhbGx5IGZvciBDT05GSUdfREVCVUdfUFJFRU1QVCBhbmQgc28gdGhpcyBwYXRj
aCBzaG91bGQgYmUgZHJvcHBlZC4NCg0KWWVzLCBJIGRpc2NvdmVyZWQgdGhhdCBsYXRlIGxhc3Qg
bmlnaHQuDQpJJ3ZlIG5vIGlkZWEgd2h5IGl0IGlzIHNldC4NCkl0IG1pZ2h0IGV2ZW4gYmUgaW5o
ZXJpdGVkIGZyb20gdGhlIHVidW50dSAxOC4wNCAoSSB0aGluaykgLmNvbmZpZw0KSSBzdGFydGVk
IHdpdGggKG1vc3RseSByZW1vdmluZyBleHRyYSBtb2R1bGVzIHRvIHJlZHVjZSBjb21waWxlDQp0
aW1lIGFuZCB0aGUgc2l6ZSBvZiB1cmFtZGlzaykuDQoNCkknbGwgbG9vayBhdCB0aGUgcGF0Y2hl
cyBhZ2Fpbi4NClNhdmluZyBub2RlLT5wcmV2LT5jcHUgYXMgbm9kZS0+cHJldl9jcHUgd2lsbCBk
ZWZpbml0ZWx5IHNhdmUNCnRoZSBjYWNoZS1saW5lIGJvdW5jZS4NCg0KCURhdmlkDQoNCi0NClJl
Z2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0
b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykN
Cg==


