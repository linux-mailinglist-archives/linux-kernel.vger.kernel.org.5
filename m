Return-Path: <linux-kernel+bounces-13905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B662E821477
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 17:34:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB06D1C20BC5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 16:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C926AD7;
	Mon,  1 Jan 2024 16:34:10 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6784A8BF7
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-203-kjforqtyMaePgnFYa79FrA-1; Mon, 01 Jan 2024 16:33:58 +0000
X-MC-Unique: kjforqtyMaePgnFYa79FrA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 1 Jan
 2024 16:33:34 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 1 Jan 2024 16:33:34 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Willem de Bruijn' <willemdebruijn.kernel@gmail.com>, Markus Elfring
	<Markus.Elfring@web.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Stephen
 Hemminger" <stephen@networkplumber.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: RE: packet: Improve exception handling in fanout_add()
Thread-Topic: packet: Improve exception handling in fanout_add()
Thread-Index: AQHaPMdEXQvPcsiVWUu1iBz3bxTbObDFHIww
Date: Mon, 1 Jan 2024 16:33:34 +0000
Message-ID: <25b3322081b64bd2a610f76f71de30f7@AcuMS.aculab.com>
References: <828bb442-29d0-4bb8-b90d-f200bdd4faf6@web.de>
 <6591e0fcb089f_21410c2946c@willemb.c.googlers.com.notmuch>
 <a69fce11-68c2-446c-9da8-b959bb3ba70f@web.de>
 <6592da5178589_238b0d2943a@willemb.c.googlers.com.notmuch>
In-Reply-To: <6592da5178589_238b0d2943a@willemb.c.googlers.com.notmuch>
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

RnJvbTogV2lsbGVtIGRlIEJydWlqbg0KPiBTZW50OiAwMSBKYW51YXJ5IDIwMjQgMTU6MjkNCj4g
DQo+IE1hcmt1cyBFbGZyaW5nIHdyb3RlOg0KPiA+ID4gSXQgaXMgZmluZSB0byBjYWxsIGtmcmVl
IHdpdGggYSBwb3NzaWJsZSBOVUxMIHBvaW50ZXI6DQo+ID4g4oCmDQo+ID4gPiAJICogSWYgQG9i
amVjdCBpcyBOVUxMLCBubyBvcGVyYXRpb24gaXMgcGVyZm9ybWVkLg0KPiA+ID4gCSAqLw0KPiA+
ID4gCXZvaWQga2ZyZWUoY29uc3Qgdm9pZCAqb2JqZWN0KQ0KPiA+DQo+ID4gU3VjaCBhIGZ1bmN0
aW9uIGNhbGwgdHJpZ2dlcnMgYW4gaW5wdXQgcGFyYW1ldGVyIHZhbGlkYXRpb24NCj4gPiB3aXRo
IGEgY29ycmVzcG9uZGluZyBpbW1lZGlhdGUgcmV0dXJuLCBkb2Vzbid0IGl0Pw0KPiA+IERvIHlv
dSBmaW5kIHN1Y2ggZGF0YSBwcm9jZXNzaW5nIHJlYWxseSBoZWxwZnVsIGZvciB0aGUgZGVzaXJl
ZCBlcnJvci9leGNlcHRpb24gaGFuZGxpbmc/DQo+IA0KPiBJdCdzIG5vdCBqdXN0IHBlcnNvbmFs
IHByZWZlcmVuY2UuIEl0IGlzIGFuIGVzdGFibGlzaGVkIHBhdHRlcm4gdG8NCj4gYXZvaWQgZXh0
cmEgTlVMTCB0ZXN0cyBhcm91bmQga2ZyZWUuDQo+IA0KPiBBIHF1aWNrIGdpdCBsb2cgdG8gc2hv
dyBhIGZldyByZWNlbnQgZXhhbXBsZXMgb2YgcGF0Y2hlcyB0aGF0IGV4cHJlc3NseQ0KPiByZW1v
dmUgc3VjaCBicmFuY2hlcywgZS5nLiwNCj4gDQo+IGNvbW1pdCBkMDExMDQ0M2NmNGEgKCJhbWQv
cGRzX2NvcmU6IGNvcmU6IE5vIG5lZWQgZm9yIE51bGwgcG9pbnRlciBjaGVjayBiZWZvcmUga2Zy
ZWUiKQ0KPiBjb21taXQgZWZkOWQwNjVkZTY3ICgiZHJtL3JhZGVvbjogUmVtb3ZlIHVubmVjZXNz
YXJ5IE5VTEwgdGVzdCBiZWZvcmUga2ZyZWUgaW4NCj4gJ3JhZGVvbl9jb25uZWN0b3JfZnJlZV9l
ZGlkJyIpDQo+IA0KPiBBbiBpbnRlcmVzdGluZyBvbGRlciB0aHJlYWQgb24gdGhlIHRvcGljOg0K
PiANCj4gaHR0cHM6Ly9saW51eC1rZXJuZWwudmdlci5rZXJuZWwubmFya2l2ZS5jb20vS1ZqbERz
VG8va2ZyZWUtbnVsbA0KDQpUaGF0IGFjdHVhbGx5IGZhaWxzIHRvIG5vdGUgdGhhdCBpZiB0aGUg
Y2FsbCBzaXRlIGNvbnRhaW5zIHRoZQ0KY29uZGl0aW9uYWwgKGV4cGxpY2l0bHkgb3IgZnJvbSBh
ICNkZWZpbmUvc3RhdGljIGlubGluZSkgdGhlbiBnY2MNCndpbGwgb3B0aW1pc2UgdGhlIHRlc3Qg
YXdheSBpZiBpdCBjYW4gZGV0ZXJtaW5lIHRoYXQgdGhlIHBvaW50ZXINCmlzIE5VTEwgKGZyb20g
YW4gZWFybGllciB0ZXN0KSBvciBub24tTlVMTCAoaGFzIGJlZW4gZGVyZWZlcmVuY2VkKS4NClBv
c3NpYmx5IGJlY2F1c2UgZ2NjIGRpZG4ndCBkbyB0aGF0IDE4IHllYXJzIGFnby4NCg0KPiBNeSBz
dW1tYXJ5LCB0aGUgbWFueSBicmFuY2hlcyBzY2F0dGVyZWQgdGhyb3VnaG91dCB0aGUga2VybmVs
IGxpa2VseQ0KPiBhcmUgbW9yZSBleHBlbnNpdmUgdGhhbiB0aGUgb2NjYXNpb25hbCBzYXZlIGZy
b20gc2VlaW5nIHRoZSByYXJlIE5VTEwNCj4gcG9pbnRlci4NCg0KRXNwZWNpYWxseSBpbiBlcnJv
ciBwYXRocyBvciB3aGVyZSB0aGUgbm9ybWFsIGNhc2UgaXMgdGhhdCB0aGUgcG9pbnRlcg0KaXMg
YWxsb2NhdGVkLg0KDQpBYm91dCB0aGUgb25seSBwbGFjZSB3aGVyZSBhIGNoZWNrIGluIHRoZSBj
YWxsZXIgbWF5IG1ha2Ugc2Vuc2UgaXMNCmZvciBmcmVxdWVudGx5IHVzZWQgY29kZSBwYXRocyB3
aGVyZSB0aGUgcG9pbnRlciBpcyBub3JtYWxseSBOVUxMLg0KT25lIGV4YW1wbGUgd291bGQgYmUg
dGhlIGNvZGUgdGhhdCByZWFkcyBhbiBpb3ZlY1tdIGZyb20gdXNlciBzcGFjZS4NCkFuIG9uLXN0
YWNrIGFycmF5IGlzIHVzZWQgZm9yIHNtYWxsIChzYW5lKSBmcmFnbWVudCBjb3VudHMgd2l0aA0K
a21hbGxvYygpIGJlaW5nIGNhbGxlZCBmb3IgbGFyZ2UgY291bnRzLg0KSW4gdGhhdCBjYXNlIGhh
dmluZyAnaWYgKHVubGlrZWx5KHB0cikpIGtmcmVlKHB0cik7JyB3aWxsIHByb2JhYmx5DQpnZW5l
cmF0ZSBjb2RlIHRoYXQgaXMgbWVhc3VyYWJseSBmYXN0ZXIuDQooRXNwZWNpYWxseSBpZiB0aGVy
ZSBhcmUgbWl0aWdhdGlvbnMgZm9yICdyZXQnLikNCg0KSSBhbHNvIGJlbGlldmUgdGhhdCBsaWtl
bHkvdW5saWtlbHkgaGF2ZSBhbG1vc3Qgbm8gZWZmZWN0IG9uIG1vZGVybiB4ODYuDQood2FzIGl0
IHRoZSBQLVBybyB0aGF0IHVzZWQgcHJlZml4IGZvciBzdGF0aWMgcHJlZGljdGlvbj8pDQpJSVJD
IHRoZXJlIGlzIG5vICdzdGF0aWMgcHJlZGljdGlvbicgLSBwcmVkaWN0aW9uIGlzIGJhc2VkIG9u
IHdoYXRldmVyDQonc2V0IG9mIGJyYW5jaGVzJyB0aGUgY3VycmVudCBicmFuY2ggYWxhc2VzIHRv
Lg0KVGhlIG9ubHkgc2xpZ2h0IGdhaW4gaXMgdGhhdCB0aGUgJ2ZhbGwgdGhyb3VnaCcgcGF0aCBp
cyBsZXNzIGxpa2VseQ0KdG8gc3RhbGwgZHVlIHRvIGEgY2FjaGUgbWlzcy4gQnV0IGV2ZW4gdGhh
dCBjYW4gYmUgZmFyIGVub3VnaCBhaGVhZA0Kb2YgdGhlIG5vbi1zcGVjdWxhdGl2ZSBleGVjdXRp
b24gcG9pbnQgdGhhdCB0aGUgYWN0dWFsIHN0YWxsIGlzIHNtYWxsLg0KDQpPZiBjb3Vyc2Ugb3Ro
ZXIgc2ltcGxlciBjcHUgZG8gaGF2ZSBzdGF0aWMgcHJlZGljdGlvbiBydWxlcy4NCkNvbW1vbiB3
b3VsZCBiZSB0byBwcmVkaWN0IGJhY2t3YXJkcyBicmFuY2hlcyB0YWtlbiAoZWcgbG9vcHMpDQph
bmQgZm9yd2FyZHMgb25lcyBub3QtdGFrZW4uDQpJZiB5b3UgcmVhbGx5IGRvIGNhcmUgKGVzcGVj
aWFsbHkgaWYgeW91J3ZlIGRpc2FibGVkIGFueSBkeW5hbWljIHByZWRpY3Rpb24NCmluIG9yZGVy
IHRvIGdldCBtZWFzdXJhYmxlIGV4ZWN1dGlvbiB0aW1lcykgdGhlbiB5b3UgY2FuIG5lZWQgdG8g
YWRkDQooZWcpIGFzbSBjb21tZW50cyB0byBmb3JjZSBhIHByZWRpY3RlZCBub3QtdGFrZW4gZm9y
d2FyZHMgYnJhbmNoIHRvDQphbiB1bmNvbmRpdGlvbmFsIGJhY2t3YXJkcyBicmFuY2ggdG8gYXZv
aWQgYSAncHJlZGljdGVkIHRha2VuJyBiYWNrd2FyZA0KYnJhbmNoLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K


