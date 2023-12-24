Return-Path: <linux-kernel+bounces-10732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43EFD81DAFB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 15:38:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DACFE1F217D3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F02345695;
	Sun, 24 Dec 2023 14:38:24 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998905663
	for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-270-G_GBy4ibM22dzQOYQeJs3A-1; Sun, 24 Dec 2023 14:38:13 +0000
X-MC-Unique: G_GBy4ibM22dzQOYQeJs3A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Dec
 2023 14:37:54 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Dec 2023 14:37:54 +0000
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
Thread-Index: AQHaNMmXQnV6P1CryUOzF1IfQQ8rsbC1Lv+wgAD9mACAAH0Z4IAA/HsAgADbDKA=
Date: Sun, 24 Dec 2023 14:37:54 +0000
Message-ID: <794c14d6c979495e869d7ba03a935e3b@AcuMS.aculab.com>
References: <20231221154702.2267684-1-guoren@kernel.org>
 <20231221154702.2267684-5-guoren@kernel.org> <ZYUZ8QUJxCL93Fgv@LeoBras>
 <CAJF2gTTX7AjexoRUw=ZS34HEWno7H3zvnXA+Q7TYsztNU=k2cg@mail.gmail.com>
 <e3f1521a9f04463587d07d0c99534d5a@AcuMS.aculab.com>
 <CAJF2gTRD827Fbs_2FxBP=Z8yudfAAqG6dA+a9eq74RMOz2WDnw@mail.gmail.com>
 <9d4d15e8e3e944b8bd18e8bc1d54f59c@AcuMS.aculab.com>
 <CAJF2gTQjixePmc8qNJZB+kfyzjVb+NqFHR6GOow-aNhN883CQA@mail.gmail.com>
In-Reply-To: <CAJF2gTQjixePmc8qNJZB+kfyzjVb+NqFHR6GOow-aNhN883CQA@mail.gmail.com>
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

RnJvbTogR3VvIFJlbg0KPiBTZW50OiAyNCBEZWNlbWJlciAyMDIzIDAxOjI0DQouLi4NCj4gPiBP
bmUgcG9zc2liaWxpdHkgd291bGQgYmUgdG8gc2F2ZSB0aGUgdGFzaydzIG1heCB1c2VyIGFkZHJl
c3MNCj4gPiBpbiB0aGUgdGFzayBzdHJ1Y3R1cmUgaXRzZWxmIC0gdGhhdCB3b3VsZCBzYXZlIGFs
bCB0aGUgY29uZGl0aW9uYWxzDQo+ID4gYXQgYSBjb3N0IG9mIGFuIGV4dHJhIHZhbHVlIGluIHRo
ZSB0YXNrIHN0cnVjdHVyZS4NCg0KPiBJdCB3b3VsZCBzdGlsbCBjYXVzZSBtZW1vcnkgbG9hZCBv
cGVyYXRpb24sIGFsdGhvdWdoIGl0IGlzICR0cC0+eHh4Lg0KDQpBbGwgdGhlIChtaXNwcmVkaWN0
ZWQpIGJyYW5jaGVzIGFyZSBsaWtlbHkgdG8gY2F1c2UgbW9yZSBvZiBhDQpwcm9ibGVtIHRoYW4g
YSBsb2FkIGZyb20gdGhlIGN1cnJlbnQgdGFzayBzdHJ1Y3R1cmUuDQoNCj4gSWYgd2Ugd2FudCB0
byBnYWluIG9ic2VydmFiaWxpdHkgYmVuZWZpdHMsICJqdXN0IGNoZWNrIChwdHIgfCAocHRyICsN
Cj4gbGVuKSkgPCAwKSIgaXMgYmV0dGVyLg0KDQpJZiB5b3UgY2FuIGd1YXJhbnRlZSBhIGZhdWx0
aW5nIHBhZ2UgYmV0d2VlbiB1c2VyIGFuZCBrZXJuZWwgYWRkcmVzc2VzDQphbmQgYXNzdW1lIChj
aGVjaykgdGhhdCB0aGUgYWNjZXNzZXMgYXJlICdyZWFzb25hYmx5IHNlcXVlbnRpYWwnDQp0aGVu
IHlvdSBvbmx5IG5lZWQgdG8gY2hlY2sgdGhlIGJhc2UgYWRkcmVzcy4NClRoYXQgaXMgbGlrZWx5
IGhhcmQgZm9yIDMyYml0IGJ1dCBlYXNpZXIgZm9yIDY0Yml0IChleGNlcHQgYXJtNjQpDQpiZWNh
dXNlIEE2MyBhbmQgQTYyIGhhdmUgdG8gbWF0Y2guDQpVbmxlc3MgeW91IGhhdmUgc29tZSBoYXJk
d2FyZSBhZGRyZXNzIG1hc2tpbmcgd2hpY2ggbWFrZXMgaXQgbXVjaA0KbW9yZSBsaWtlbHkgdGhh
dCAncmFuZG9tIHZhbHVlcycgd2lsbCBiZSB2YWxpZCBhZGRyZXNzZXMuDQooU29tZW9uZSByZW1p
bmQgbWUgd2h5IHRoYXQgaXMgYSBnb29kIGlkZWEgdW5sZXNzIHRoZSBoaWdoIGJpdHMNCmFyZSB2
YWxpZGF0ZWQgYnkgdGhlIGhhcmR3YXJlLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRk
cmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBN
SzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


