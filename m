Return-Path: <linux-kernel+bounces-18050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 698478257D2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 17:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14EE61F215F8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 16:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B3F2E846;
	Fri,  5 Jan 2024 16:12:32 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5907D2E828
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 16:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-6-G_ku7WGkPReF8qM7yUdfXg-1; Fri, 05 Jan 2024 16:12:24 +0000
X-MC-Unique: G_ku7WGkPReF8qM7yUdfXg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 16:12:06 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 5 Jan 2024 16:12:06 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, 'Noah Goldstein'
	<goldstein.w.n@gmail.com>
CC: 'kernel test robot' <lkp@intel.com>, "'x86@kernel.org'" <x86@kernel.org>,
	"'oe-kbuild-all@lists.linux.dev'" <oe-kbuild-all@lists.linux.dev>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'edumazet@google.com'" <edumazet@google.com>, "'tglx@linutronix.de'"
	<tglx@linutronix.de>, "'mingo@redhat.com'" <mingo@redhat.com>,
	"'bp@alien8.de'" <bp@alien8.de>, "'dave.hansen@linux.intel.com'"
	<dave.hansen@linux.intel.com>, "'hpa@zytor.com'" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRAgKIYy6qAAJmVUIAAZ8Eg
Date: Fri, 5 Jan 2024 16:12:05 +0000
Message-ID: <8ff2151323cd440da25fd49061d9cc44@AcuMS.aculab.com>
References: <20230920192300.3772199-1-goldstein.w.n@gmail.com>
 <202309231130.ZI5MdlDc-lkp@intel.com>
 <CAFUsyfKDRiX9kKOhHcA4PLqqT6Q5faHF0eRGiKN+9NSbvrUfDw@mail.gmail.com>
 <d02bd4f823534a00ae4915ead3d92773@AcuMS.aculab.com>
 <CAFUsyfL0M5P4+4s_b1kvJ_fE-ax8YBK0ammbKfoy7yKs1obzrA@mail.gmail.com>
 <CAFUsyfJduB29c6=BNmTtgoWcHAWA1AZ-sdbhyp02JVhvA6Gp0w@mail.gmail.com>
 <CAFUsyfLuo0_Sm91mqbM8Sbo-ncwnM4RaRq=GxQXDmkAN-nQ3uw@mail.gmail.com>
 <CAHk-=wgv6h4ru=z8UR5XyutoRKveOetNpwovHburvRgG9NSa3g@mail.gmail.com>
 <CAHk-=wiNUucmvTKGmveWzXXe99SpOwU65nFtH-A2_aUpPsAPJQ@mail.gmail.com>
 <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
In-Reply-To: <5354eeec562345f6a1de84f0b2081b75@AcuMS.aculab.com>
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

RnJvbTogRGF2aWQgTGFpZ2h0DQo+IFNlbnQ6IDA1IEphbnVhcnkgMjAyNCAxMDo0MQ0KPiANCj4g
RnJvbTogTGludXMgVG9ydmFsZHMNCj4gPiBTZW50OiAwNSBKYW51YXJ5IDIwMjQgMDA6MzMNCj4g
Pg0KPiA+IE9uIFRodSwgNCBKYW4gMjAyNCBhdCAxNTozNiwgTGludXMgVG9ydmFsZHMNCj4gPiA8
dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IEFueXdh
eSwgc2luY2UgSSBsb29rZWQgYXQgdGhlIHRoaW5nIG9yaWdpbmFsbHksIGFuZCBmZWVsIGxpa2Ug
SSBrbm93DQo+ID4gPiB0aGUgeDg2IHNpZGUgYW5kIHVuZGVyc3RhbmQgdGhlIHN0cmFuZ2UgSVAg
Y3N1bSB0b28sIEkganVzdCBhcHBsaWVkIGl0DQo+ID4gPiBkaXJlY3RseS4NCj4gPg0KPiA+IEkg
ZW5kZWQgdXAganVzdCBhcHBseWluZyBteSA0MC1ieXRlIGNsZWFudXAgdGhpbmcgdG9vIHRoYXQg
SSd2ZSBiZWVuDQo+ID4ga2VlcGluZyBpbiBteSBvd24gdHJlZSBzaW5jZSBwb3N0aW5nIGl0IChh
cyB0aGUgIlNpbGx5IGNzdW0NCj4gPiBpbXByb3ZlbWVudC4gTWF5YmUiIHBhdGNoKS4NCj4gDQo+
IEludGVyZXN0aW5nLCBJJ20gcHJldHR5IHN1cmUgdHJ5aW5nIHRvIGdldCB0d28gYmxvY2tzIG9m
DQo+ICAnYWRjJyBzY2hlZHVsZWQgaW4gcGFyYWxsZWwgbGlrZSB0aGF0IGRvZXNuJ3Qgd29yay4N
Cj4gDQo+IEkgZ290IGFuIGFkYyBldmVyeSBjbG9jayBmcm9tIHRoaXMgJ2JlYXN0JzoNCj4gKyAg
ICAgICAvKg0KPiArICAgICAgICAqIEFsaWduIHRoZSBieXRlIGNvdW50IHRvIGEgbXVsdGlwbGUg
b2YgMTYgdGhlbg0KPiArICAgICAgICAqIGFkZCA2NCBiaXQgd29yZHMgdG8gYWx0ZXJuYXRpbmcg
cmVnaXN0ZXJzLg0KPiArICAgICAgICAqIEZpbmFsbHkgcmVkdWNlIHRvIDY0IGJpdHMuDQo+ICsg
ICAgICAgICovDQo+ICsgICAgICAgYXNtKCAgICAiICAgICAgIGJ0ICAgICQ0LCAlW2xlbl1cbiIN
Cj4gKyAgICAgICAgICAgICAgICIgICAgICAgam5jICAgMTBmXG4iDQo+ICsgICAgICAgICAgICAg
ICAiICAgICAgIGFkZCAgICglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8wXVxuIg0KPiArICAgICAg
ICAgICAgICAgIiAgICAgICBhZGMgICA4KCVbYnVmZl0sICVbbGVuXSksICVbc3VtXzFdXG4iDQo+
ICsgICAgICAgICAgICAgICAiICAgICAgIGxlYSAgIDE2KCVbbGVuXSksICVbbGVuXVxuIg0KPiAr
ICAgICAgICAgICAgICAgIjEwOiAgICBqZWN4eiAyMGZcbiINCj4gKyAgICAgICAgICAgICAgICIg
ICAgICAgYWRjICAgKCVbYnVmZl0sICVbbGVuXSksICVbc3VtXzBdXG4iDQo+ICsgICAgICAgICAg
ICAgICAiICAgICAgIGFkYyAgIDgoJVtidWZmXSwgJVtsZW5dKSwgJVtzdW1fMV1cbiINCj4gKyAg
ICAgICAgICAgICAgICIgICAgICAgbGVhICAgMzIoJVtsZW5dKSwgJVtsZW5fdG1wXVxuIg0KPiAr
ICAgICAgICAgICAgICAgIiAgICAgICBhZGMgICAxNiglW2J1ZmZdLCAlW2xlbl0pLCAlW3N1bV8w
XVxuIg0KPiArICAgICAgICAgICAgICAgIiAgICAgICBhZGMgICAyNCglW2J1ZmZdLCAlW2xlbl0p
LCAlW3N1bV8xXVxuIg0KPiArICAgICAgICAgICAgICAgIiAgICAgICBtb3YgICAlW2xlbl90bXBd
LCAlW2xlbl1cbiINCj4gKyAgICAgICAgICAgICAgICIgICAgICAgam1wICAgMTBiXG4iDQo+ICsg
ICAgICAgICAgICAgICAiMjA6ICAgIGFkYyAgICVbc3VtXzBdLCAlW3N1bV1cbiINCj4gKyAgICAg
ICAgICAgICAgICIgICAgICAgYWRjICAgJVtzdW1fMV0sICVbc3VtXVxuIg0KPiArICAgICAgICAg
ICAgICAgIiAgICAgICBhZGMgICAkMCwgJVtzdW1dXG4iDQo+ICsgICAgICAgICAgIDogW3N1bV0g
IismciIgKHN1bSksIFtzdW1fMF0gIismciIgKHN1bV8wKSwgW3N1bV8xXSAiKyZyIiAoc3VtXzEp
LA0KPiArICAgICAgICAgICAgICAgW2xlbl0gIismYyIgKGxlbiksIFtsZW5fdG1wXSAiPSZyIiAo
bGVuX3RtcCkNCj4gKyAgICAgICAgICAgOiBbYnVmZl0gInIiIChidWZmKQ0KPiArICAgICAgICAg
ICA6ICJtZW1vcnkiICk7DQoNCkkndmUgZ290IGZhciB0b28gbWFueSB4ODYgY2hlY2tzdW0gZnVu
Y3Rpb25zIGx5aW5nIGFyb3VuZC4NCg0KQWN0dWFsbHkgeW91IGRvbid0IG5lZWQgYWxsIHRoYXQu
DQpBbnl0aGluZyByZWNlbnQgKHByb2JhYmx5IEJyb2Fkd2VsbCBvbikgd2lsbCBleGVjdXRlOg0K
CSIxMDogICAgamVjeHogMjBmXG4iDQoJIiAgICAgICBhZGMgICAoJVtidWZmXSwgJVtsZW5dKSwg
JVtzdW1dXG4iDQoJIiAgICAgICBhZGMgICA4KCVbYnVmZl0sICVbbGVuXSksICVbc3VtXVxuIg0K
CSIgICAgICAgbGVhICAgMTYoJVtsZW5dKSwgJVtsZW5dXG4iDQoJIiAgICAgICBqbXAgICAxMGJc
biINCgkiMjA6ICAgIGFkYyAgICQwLCAlW3N1bV1cbiINCmluIHR3byBjbG9ja3MgcGVyIGl0ZXJh
dGlvbiAtIDggYnl0ZXMvY2xvY2suDQpTaW5jZSBpdCBpcyB0cml2aWFsIHRvIGhhbmRsZSA4bis0
IGJ1ZmZlcnMgKGVnIGFzIGFib3ZlKQ0KdGhhdCBvbmx5IGxlYXZlcyB0aGUgQyBjb2RlIHRvIGhh
bmRsZSB0aGUgZmluYWwgMC03IGJ5dGVzLg0KDQo+IE1heWJlIEknbGwgc29ydCBvdXQgYW5vdGhl
ciBwYXRjaC4uLg0KDQpQcm9iYWJseSBhZnRlciB0aGUgbmV4dCByYzEgaXMgb3V0Lg0KDQoJRGF2
aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50
IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTcz
ODYgKFdhbGVzKQ0K


