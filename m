Return-Path: <linux-kernel+bounces-106340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C756087ECB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E573B21899
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB5C5338C;
	Mon, 18 Mar 2024 15:53:36 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB3352F98
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710777216; cv=none; b=AXtyLv8JComkHQjUv2kiJPgbb+KKQR6t0abEiMTnfLOK8EmKHLDeAulJvUOY89NRY3dil/D5Me4d1C1/sVRPzZamU8UOM97b3mbQWf7N6iY43KcLWj1WSOs4sCN0TXojVFJ7Ns/yJWYV9mIFhqgQYVLwlMDFKvsArjCjIDC8nxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710777216; c=relaxed/simple;
	bh=6yHPtiZr5s5iZVtQG9zezLLM5+W/VbCy3wugNSS5C60=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=mQu+Kxs+4pUt1b3SAM4neEFbR+Kdaf41cjhVrXGliFA5RYMTyxbo2PkzB96PYMDgPcVSkskH9y8KoM3MkBo2YRJTciKHvrL5LppCL/g9ymDrdo6Wwq9lHqCmNx9Av04c/wFWpfGM2SB5+hojc5KSZm74CI7YZRTr+9N6mD4Vgpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-405-90CltE0wP0GC-d-_5R-oxQ-1; Mon, 18 Mar 2024 15:53:30 +0000
X-MC-Unique: 90CltE0wP0GC-d-_5R-oxQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Mar
 2024 15:53:07 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Mar 2024 15:53:07 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pasha Tatashin' <pasha.tatashin@soleen.com>, Matthew Wilcox
	<willy@infradead.org>
CC: "H. Peter Anvin" <hpa@zytor.com>, Kent Overstreet
	<kent.overstreet@linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "x86@kernel.org"
	<x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org"
	<brauner@kernel.org>, "bristot@redhat.com" <bristot@redhat.com>,
	"bsegall@google.com" <bsegall@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "eric.devolder@oracle.com"
	<eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hch@infradead.org" <hch@infradead.org>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de"
	<jroedel@suse.de>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"kinseyho@google.com" <kinseyho@google.com>,
	"kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "luto@kernel.org"
	<luto@kernel.org>, "mgorman@suse.de" <mgorman@suse.de>, "mic@digikod.net"
	<mic@digikod.net>, "michael.christie@oracle.com"
	<michael.christie@oracle.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"mjguzik@gmail.com" <mjguzik@gmail.com>, "mst@redhat.com" <mst@redhat.com>,
	"npiggin@gmail.com" <npiggin@gmail.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "pmladek@suse.com" <pmladek@suse.com>,
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>,
	"rostedt@goodmis.org" <rostedt@goodmis.org>, "surenb@google.com"
	<surenb@google.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"urezki@gmail.com" <urezki@gmail.com>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "vschneid@redhat.com" <vschneid@redhat.com>
Subject: RE: [RFC 00/14] Dynamic Kernel Stacks
Thread-Topic: [RFC 00/14] Dynamic Kernel Stacks
Thread-Index: AQHad9a+Y5/0t6VtDk+hhnG+kSJKOLE8RdQAgAFdD22AAAN3IA==
Date: Mon, 18 Mar 2024 15:53:07 +0000
Message-ID: <4b542b49b2994c9d8c4c73b9e3b42dde@AcuMS.aculab.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
 <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
 <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
 <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com>
 <CA+CK2bAuNLXq4p8pjwAatuw2KuadhKjD6JRwJN8ZvSEd1d7ntA@mail.gmail.com>
 <Zfhblk609XJn5clL@casper.infradead.org>
 <CA+CK2bDFUekHnh=XqLcLJS-VgTMrTRWPm4xgmXHWgFCd9JXYmw@mail.gmail.com>
In-Reply-To: <CA+CK2bDFUekHnh=XqLcLJS-VgTMrTRWPm4xgmXHWgFCd9JXYmw@mail.gmail.com>
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

RnJvbTogUGFzaGEgVGF0YXNoaW4NCj4gU2VudDogMTggTWFyY2ggMjAyNCAxNTozMQ0KPiANCj4g
T24gTW9uLCBNYXIgMTgsIDIwMjQgYXQgMTE6MTnigK9BTSBNYXR0aGV3IFdpbGNveCA8d2lsbHlA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIE1hciAxOCwgMjAyNCBhdCAx
MTowOTo0N0FNIC0wNDAwLCBQYXNoYSBUYXRhc2hpbiB3cm90ZToNCj4gPiA+IFRoZSBUTEIgbG9h
ZCBpcyBnb2luZyB0byBiZSBleGFjdGx5IHRoZSBzYW1lIGFzIHRvZGF5LCB3ZSBhbHJlYWR5IHVz
ZQ0KPiA+ID4gc21hbGwgcGFnZXMgZm9yIFZNQSBtYXBwZWQgc3RhY2tzLiBXZSB3b24ndCBuZWVk
IHRvIGhhdmUgZXh0cmENCj4gPiA+IGZsdXNoaW5nIGVpdGhlciwgdGhlIG1hcHBpbmdzIGFyZSBp
biB0aGUga2VybmVsIHNwYWNlLCBhbmQgb25jZSBwYWdlcw0KPiA+ID4gYXJlIHJlbW92ZWQgZnJv
bSB0aGUgcGFnZSB0YWJsZSwgbm8gb25lIGlzIGdvaW5nIHRvIGFjY2VzcyB0aGF0IFZBDQo+ID4g
PiBzcGFjZSB1bnRpbCB0aGF0IHRocmVhZCBlbnRlcnMgdGhlIGtlcm5lbCBhZ2Fpbi4gV2Ugd2ls
bCBuZWVkIHRvDQo+ID4gPiBpbnZhbGlkYXRlIHRoZSBWQSByYW5nZSBvbmx5IHdoZW4gdGhlIHBh
Z2VzIGFyZSBtYXBwZWQsIGFuZCBvbmx5IG9uDQo+ID4gPiB0aGUgbG9jYWwgY3B1Lg0KPiA+DQo+
ID4gTm87IHdlIGNhbiBwYXNzIHBvaW50ZXJzIHRvIG91ciBrZXJuZWwgc3RhY2sgdG8gb3RoZXIg
dGhyZWFkcy4gIFRoZQ0KPiA+IG9idmlvdXMgb25lIGlzIGEgbXV0ZXg7IHdlIHB1dCBhIG11dGV4
X3dhaXRlciBvbiBvdXIgb3duIHN0YWNrIGFuZA0KPiA+IGFkZCBpdHMgbGlzdF9oZWFkIHRvIHRo
ZSBtdXRleCdzIHdhaXRlciBsaXN0LiAgSSdtIHN1cmUgeW91IGNhbg0KPiA+IHRoaW5rIG9mIG1h
bnkgb3RoZXIgcGxhY2VzIHdlIGRvIHRoaXMgKGVnIHdhaXQgcXVldWVzLCBwb2xsKCksIHNlbGVj
dCgpLA0KPiA+IGV0YykuDQo+IA0KPiBIbSwgaXQgbWVhbnMgdGhhdCBzdGFjayBpcyBzbGVlcGlu
ZyBpbiB0aGUga2VybmVsIHNwYWNlLCBhbmQgaGFzIGl0cw0KPiBzdGFjayBwYWdlcyBtYXBwZWQg
YW5kIGludmFsaWRhdGVkIG9uIHRoZSBsb2NhbCBDUFUsIGJ1dCBhY2Nlc3MgZnJvbQ0KPiB0aGUg
cmVtb3RlIENQVSB0byB0aGF0IHN0YWNrIHBhZ2VzIHdvdWxkIGJlIHByb2JsZW1hdGljLg0KPiAN
Cj4gSSB0aGluayB3ZSBzdGlsbCB3b24ndCBuZWVkIElQSSwgYnV0IFZBLXJhbmdlIGludmFsaWRh
dGlvbiBpcyBhY3R1YWxseQ0KPiBuZWVkZWQgb24gdW5tYXBzLCBhbmQgc2hvdWxkIGhhcHBlbiBk
dXJpbmcgY29udGV4dCBzd2l0Y2ggc28gZXZlcnkNCj4gdGltZSB3ZSBnbyBvZmYtY3B1LiBUaGVy
ZWZvcmUsIHdoYXQgQnJpYW4vQW5keSBoYXZlIHN1Z2dlc3RlZCBtYWtlcw0KPiBtb3JlIHNlbnNl
IGluc3RlYWQgb2Yga2VybmVsL2VudGVyL2V4aXQgcGF0aHMuDQoNCkkgdGhpbmsgeW91J2xsIG5l
ZWQgdG8gYnJvYWRjYXN0IGFuIGludmFsaWRhdGUuDQpDb25zaWRlcjoNCkNQVSBBOiB0YXNrIGFs
bG9jYXRlcyBleHRyYSBwYWdlcyBhbmQgYWRkcyBzb21ldGhpbmcgdG8gc29tZSBsaXN0Lg0KQ1BV
IEI6IGFjY2Vzc2VzIHRoYXQgZGF0YSBhbmQgbWF5YmUgbW9kaWZpZXMgaXQuDQoJU29tZSBwYWdl
LXRhYmxlIHdhbGsgc2V0dXAgdXQgdGhlIFRMQi4NCkNQVSBBOiB0YXNrIGRldGVjdHMgdGhlIG1v
ZGlmeSwgcmVtb3ZlcyB0aGUgaXRlbSBmcm9tIHRoZSBsaXN0LA0KCWNvbGxhcHNlcyBiYWNrIHRo
ZSBzdGFjayBhbmQgc2xlZXBzLg0KCVN0YWNrIHBhZ2VzIGZyZWVkLg0KQ1BVIEE6IHRhc2sgd2Fr
ZXMgdXAgKG9uIHRoZSBzYW1lIGNwdSBmb3Igc2ltcGxpY2l0eSkuDQoJR29lcyBkb3duIGEgZGVl
cCBzdGFjayBhbmQgcHV0cyBhbiBpdGVtIG9uIGEgbGlzdC4NCglEaWZmZXJlbnQgcGh5c2ljYWwg
cGFnZXMgYXJlIGFsbG9jYXRlZC4NCkNQVSBCOiBhY2Nlc3NlcyB0aGUgYXNzb2NpYXRlZCBLVkEu
DQoJSXQgYmV0dGVyIG5vdCBoYXZlIGEgY2FjaGVkIFRMQi4NCg0KRG9lc24ndCB0aGF0IG5lZWQg
YW4gSVBJPw0KDQpGcmVlaW5nIHRoZSBwYWdlcyBpcyBtdWNoIGhhcmRlciB0aGFuIGFsbG9jYXRp
bmcgdGhlbS4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJh
bWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0
cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


