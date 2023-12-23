Return-Path: <linux-kernel+bounces-10380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E15CD81D387
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 11:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C8CB1F21FE9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 10:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DEFC14B;
	Sat, 23 Dec 2023 10:31:46 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB8E946D
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-228-U5G35-zWOAaFHs2mKPMClw-1; Sat, 23 Dec 2023 10:31:31 +0000
X-MC-Unique: U5G35-zWOAaFHs2mKPMClw-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sat, 23 Dec
 2023 10:31:16 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sat, 23 Dec 2023 10:31:16 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Guo Ren' <guoren@kernel.org>
CC: Leonardo Bras <leobras@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "palmer@dabbelt.com" <palmer@dabbelt.com>,
	"alexghiti@rivosinc.com" <alexghiti@rivosinc.com>, "charlie@rivosinc.com"
	<charlie@rivosinc.com>, "xiao.w.wang@intel.com" <xiao.w.wang@intel.com>,
	"david@redhat.com" <david@redhat.com>, "panqinglin2020@iscas.ac.cn"
	<panqinglin2020@iscas.ac.cn>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "willy@infradead.org" <willy@infradead.org>,
	"bjorn@rivosinc.com" <bjorn@rivosinc.com>, "conor.dooley@microchip.com"
	<conor.dooley@microchip.com>, "cleger@rivosinc.com" <cleger@rivosinc.com>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Guo Ren
	<guoren@linux.alibaba.com>
Subject: RE: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Thread-Topic: [PATCH V2 4/4] riscv: mm: Optimize TASK_SIZE definition
Thread-Index: AQHaNMmXQnV6P1CryUOzF1IfQQ8rsbC1Lv+wgAD9mACAAH0Z4A==
Date: Sat, 23 Dec 2023 10:31:15 +0000
Message-ID: <9d4d15e8e3e944b8bd18e8bc1d54f59c@AcuMS.aculab.com>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-5-guoren@kernel.org> <ZYUZ8QUJxCL93Fgv@LeoBras>
 <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
 <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com>
 <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
In-Reply-To: <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
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

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAyMyBEZWNlbWJlciAyMDIzIDAyOjUzDQo+IA0KPiBPbiBG
cmksIERlYyAyMiwgMjAyMyBhdCA3OjUy4oCvUE0gRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBHdW8gUmVuDQo+ID4gPiBTZW50OiAy
MiBEZWNlbWJlciAyMDIzIDExOjI1DQo+ID4gLi4uDQo+ID4gPiA+ID4gKyNkZWZpbmUgVEFTS19T
SVpFICAgIChpc19jb21wYXRfdGFzaygpID8gXA0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgVEFTS19TSVpFXzMyIDogVEFTS19TSVpFXzY0KQ0KPiA+ID4gSSB3b3VsZCByZW1vdmUg
aXNfY29tcGF0X3Rhc2soKSBpbiB0aGUgbmV4dCB2ZXJzaW9uIGJlY2F1c2UgeW91ciBwYXRjaA0K
PiA+ID4gY29udGFpbnMgdGhhdC4NCj4gPg0KPiA+IERvZXMgVEFTS19TSVpFIGdldCB1c2VkIGlu
IGFjY2Vzc19vaygpID8NCj4gPiBJZiBzbyB0aGUgcmVwZWF0ZWQgZXhwYW5zaW9uIG9mIHRoYXQg
J21lc3MnIHdpbGwgc2xvdyB0aGluZ3MgZG93bi4NCj4gPg0KPiA+IE9UT0ggYWNjZXNzX29rKHB0
ciwgbGVuKSBjYW4ganVzdCBjaGVjayAocHRyIHwgKHB0ciArIGxlbikpIDwgMCkNCj4gPiBhbmQg
cmVseSBvbiB0aGUgcGFnZSBmYXVsdHMgZm9yIGV2ZXJ5dGhpbmcgZWxzZS4NCj4gT3IgZG8geW91
IHdhbnQgdG8gZGlzY3VzcyB0aGUgYmFkIHNpZGUgZWZmZWN0IG9mIGlzX2NvbXBhdF90YXNrKCk/
DQo+IA0KPiBZZXMsIHRlc3RfdGhyZWFkX2ZsYWcoVElGXzMyQklUKSB3b3VsZCBzbG93IGRvd24g
YWNjZXNzX29rKCkuIEJ1dCBpZg0KPiB3ZSB1c2UgVEFTS19TSVpFX01BWCwgVkFfQklUUyBzdGls
bCBuZWVkcyBwZ3RhYmxlX2w1X2VuYWJsZWQsDQo+IHBndGFibGVfbDRfZW5hYmxlZCBkZXRlY3Rh
dGlvbiBmb3IgcmlzY3YuDQo+IA0KPiBJdCdzIG5vdCBvbmx5IGZvciBjb21wYXQgbW9kZSwgYnV0
IGFsc28gU3YzOSwgU3Y0OCwgU3Y1Ny4gQWxsIHRyZWF0DQo+IFRBU0tfU0laRV9NQVggYXMgMHg4
MDAwMDAwMDAwMDAwMDAwLCByaWdodD8gVGhlbjoNCj4gYWNjZXNzX29rKHB0ciwgbGVuKSBjYW4g
anVzdCBjaGVjayAocHRyIHwgKHB0ciArIGxlbikpIDwgMCkNCj4gDQo+IEl0J3MgYW5vdGhlciBm
ZWF0dXJlIGFuZCBkb2VzIG5vdCByZWxhdGUgdG8gY29tcGF0IG1vZGUuDQoNCkNvbXBhdCBtb2Rl
IGp1c3QgbWFrZXMgaXQgd29yc2UuLi4NCg0KT25lIHBvc3NpYmlsaXR5IHdvdWxkIGJlIHRvIHNh
dmUgdGhlIHRhc2sncyBtYXggdXNlciBhZGRyZXNzDQppbiB0aGUgdGFzayBzdHJ1Y3R1cmUgaXRz
ZWxmIC0gdGhhdCB3b3VsZCBzYXZlIGFsbCB0aGUgY29uZGl0aW9uYWxzDQphdCBhIGNvc3Qgb2Yg
YW4gZXh0cmEgdmFsdWUgaW4gdGhlIHRhc2sgc3RydWN0dXJlLg0KDQpUaGVyZSBpcyBhbHNvIHRo
ZSBxdWVzdGlvbiBvZiB3aGV0aGVyIGEgbm9ybWFsbHkgNjQtYml0IHRhc2sNCmNhbiBhY3R1YWxs
eSBtYWtlIHRoZSBjb21wYXQgbW1hcCgpIHN5c3RlbSBjYWxsPw0KT24geDg2IHRoYXQgaXMgY2Vy
dGFpbmx5IHBvc3NpYmxlIChJSVJDIHdpbmUgZG9lcyBpdCksIHg4Ng0KdXNlcnNwYWNlIGNhbiBm
bGlwIGJldHdlZW4gMzJiaXQgYW5kIDYzYml0IG1vZGUgd2l0aG91dCBhDQpzeXN0ZW0gY2FsbC4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


