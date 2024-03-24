Return-Path: <linux-kernel+bounces-112879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD97887F75
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC0651C2110D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00E3EA95;
	Sun, 24 Mar 2024 22:30:25 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A0933F7
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 22:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319424; cv=none; b=N+W31PWcHWfJp5/maWqKtkUjp1Eb7G4jzrKi2kJ9CYjUxf2I3WwP6rYVHLs83AkRj1kjU582Zvbok0+We6FKjsLNh8zWoOCrfLiE5YCPpZe1SOkcNeY3+NWkCgVkfuTT9oNNrJsFLREJKX3nzmsXtZ9AIFA4s7jXaM4NHsS4yuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319424; c=relaxed/simple;
	bh=XN/b84E1fN88I7UISctQ3MOJIhEnzz6w5cJNphmYJYc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=UBbizTXyAr5y5Wj65SsFqU8FJIU05JUqWvRBNL0gzbdE7hpcLCuFqI2+RG6TSQdvYJWFl1le1THFeNt28CNY8Ar8vF/mqUYm2bMDkNUB5Z7grtpcqp5nxed67Zv1pts9504yT3lclxPsvNFr8YPu7wzM5y2qlOlYJBq+xp8tes0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-26-FBwm8NwCNmyzjd2yhbJJSw-1; Sun, 24 Mar 2024 22:30:18 +0000
X-MC-Unique: FBwm8NwCNmyzjd2yhbJJSw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 24 Mar
 2024 22:29:47 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 24 Mar 2024 22:29:47 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexei Starovoitov' <alexei.starovoitov@gmail.com>
CC: Puranjay Mohan <puranjay12@gmail.com>, Ilya Leoshkevich
	<iii@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, David Ahern
	<dsahern@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
	<martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
	<song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
	<john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav Fomichev
	<sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, "Jean-Philippe
 Brucker" <jean-philippe@linaro.org>, Network Development
	<netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>, LKML
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH bpf] bpf: verifier: prevent userspace memory access
Thread-Topic: [PATCH bpf] bpf: verifier: prevent userspace memory access
Thread-Index: AQHae1YhECDY/uuUVEW0JBnf8hxKG7FHVPhwgAAMGgCAABvX8A==
Date: Sun, 24 Mar 2024 22:29:47 +0000
Message-ID: <c73258ae8425470f90ad31c424cebe3a@AcuMS.aculab.com>
References: <20240320105436.4781-1-puranjay12@gmail.com>
 <CAADnVQJ3o6DsURi=N_KXx+mbW9r7__3LrwYLyYwuoMOsqFHPkw@mail.gmail.com>
 <1686adb401b34adaa3b703ec1a8ffe49@AcuMS.aculab.com>
 <CAADnVQJzfnK0Mv6HVKZ38VDuAemzbmSMeYscf77YoEy0SgWw+A@mail.gmail.com>
In-Reply-To: <CAADnVQJzfnK0Mv6HVKZ38VDuAemzbmSMeYscf77YoEy0SgWw+A@mail.gmail.com>
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

RnJvbTogQWxleGVpIFN0YXJvdm9pdG92DQo+IFNlbnQ6IDI0IE1hcmNoIDIwMjQgMjA6NDMNCj4g
DQo+IE9uIFN1biwgTWFyIDI0LCAyMDI0IGF0IDE6MDXigK9QTSBEYXZpZCBMYWlnaHQgPERhdmlk
LkxhaWdodEBhY3VsYWIuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZyb206IEFsZXhlaSBTdGFyb3Zv
aXRvdg0KPiA+ID4gU2VudDogMjEgTWFyY2ggMjAyNCAwNjowOA0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgTWFyIDIwLCAyMDI0IGF0IDM6NTXigK9BTSBQdXJhbmpheSBNb2hhbiA8cHVyYW5qYXkxMkBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUgSklUcyBuZWVkIHRvIGltcGxl
bWVudCBicGZfYXJjaF91YWRkcmVzc19saW1pdCgpIHRvIGRlZmluZSB3aGVyZQ0KPiA+ID4gPiB0
aGUgdXNlcnNwYWNlIGFkZHJlc3NlcyBlbmQgZm9yIHRoYXQgYXJjaGl0ZWN0dXJlIG9yIFRBU0tf
U0laRSBpcyB0YWtlbg0KPiA+ID4gPiBhcyBkZWZhdWx0Lg0KPiA+ID4gPg0KPiA+ID4gPiBUaGUg
aW1wbGVtZW50YXRpb24gaXMgYXMgZm9sbG93czoNCj4gPiA+ID4NCj4gPiA+ID4gUkVHX0FYID0g
IFNSQ19SRUcNCj4gPiA+ID4gaWYob2Zmc2V0KQ0KPiA+ID4gPiAgICAgICAgIFJFR19BWCArPSBv
ZmZzZXQ7DQo+ID4gPiA+IFJFR19BWCA+Pj0gMzI7DQo+ID4gPiA+IGlmIChSRUdfQVggPD0gKHVh
ZGRyZXNzX2xpbWl0ID4+IDMyKSkNCj4gPiA+ID4gICAgICAgICBEU1RfUkVHID0gMDsNCj4gPiA+
ID4gZWxzZQ0KPiA+ID4gPiAgICAgICAgIERTVF9SRUcgPSAqKHNpemUgKikoU1JDX1JFRyArIG9m
ZnNldCk7DQo+ID4gPg0KPiA+ID4gVGhlIHBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBpdCBzZWVtcyB0
byBiZSBjYXVzaW5nIHMzOTAgQ0kgZmFpbHVyZXMuDQo+ID4NCj4gPiBJJ20gY29uZnVzZWQgYnkg
dGhlIG5lZWQgZm9yIHRoaXMgY2hlY2sgKGFuZCwgSUlSQywgc29tZSBvdGhlciBicGYNCj4gPiBj
b2RlIHRoYXQgZG9lcyBrZXJuZWwgY29waWVzIHRoYXQgY2FuIGZhdWx0IC0gYW5kIHJldHVybiBh
biBlcnJvcikuDQo+ID4NCj4gPiBJIHRob3VnaCB0aGF0IHRoZSBlbnRpcmUgcG9pbnQgb2YgYnBm
IHdhcyB0aGF0IGlzIHNhbml0aXNlZCBhbmQNCj4gPiB2ZXJpZmllZCBldmVyeXRoaW5nIHRvIGxp
bWl0IHdoYXQgdGhlICdwcm9ncmFtJyBjb3VsZCBkbyBpbiBvcmRlcg0KPiA+IHRvIHN0b3AgaXQg
b3ZlcndyaXRpbmcgKG9yIGV2ZW4gcmVhZGluZykga2VybmVsIHN0cnVjdHVyZXMgdGhhdA0KPiA+
IGlzIHdhc24ndCBzdXBwb3NlZCB0byBhY2Nlc3MuDQo+ID4NCj4gPiBTbyBpdCBqdXN0IHNob3Vs
ZG4ndCBoYXZlIGEgYWRkcmVzcyB0aGF0IG1pZ2h0IGJlIChpbiBhbnkgd2F5KQ0KPiA+IGludmFs
aWQuDQo+IA0KPiBicGYgdHJhY2luZyBwcm9ncyBjYW4gY2FsbCBicGZfcHJvYmVfcmVhZF9rZXJu
ZWwoKSB3aGljaA0KPiBjYW4gcmVhZCBhbnkga2VybmVsIG1lbW9yeS4NCj4gVGhpcyBpcyBub3Ro
aW5nIGJ1dCBhbiBpbmxpbmVkIHZlcnNpb24gb2YgaXQuDQoNCkl0IHdhcyB0aGUgZ2V0c29ja29w
dCgpIGNvZGUgd2VyZSBJIHNhdyB0aGUgY29weV9ub2NoZWNrKCkgY2FsbHMuDQpUaG9zZSBoYXZl
IHRvIGJlIGJyb2tlbi4NCkFsdGhvdWdoIHRoZSB3YXkgc29tZSBvZiB0aGUgb3B0aW9ucyB1c2Ug
dGhlIHB0cjpsZW4gc3VwcGxpZWQgYnkNCnRoZSBhcHBsaWNhdGlvbiB5b3Ugc3RhbmQgbm8gY2hh
bmNlIG9mIGRvIGFuIGluLWtlcm5lbCBjYWxsDQp3aXRob3V0IGEgcHJvcGVyIGJ1ZmZlciBkZXNj
cmlwdG9yIGFyZ3VtZW50ICh3aXRoIHNlcGFyYXRlIG9wdGxlbg0KYW5kIGJ1ZmZlcmxlbiBmaWVs
ZHMuKQ0KDQo+IA0KPiA+IFRoZSBvbmx5IHBvc3NpYmxlIGFkZHJlc3MgdmVyaWZ5IGlzIGFjY2Vz
c19vaygpIHRvIGVuc3VyZSB0aGF0DQo+ID4gYSB1c2VzIGFkZHJlc3MgcmVhbGx5IGlzIGEgdXNl
ciBhZGRyZXNzLg0KPiANCj4gYWNjZXNzX29rKCkgY29uc2lkZXJhdGlvbnMgZG9uJ3QgYXBwbHku
DQo+IFdlJ3JlIG5vdCBkZWFsaW5nIHdpdGggdXNlciBtZW1vcnkgYWNjZXNzLg0KDQpJZiB5b3Ug
ZG8gbmVlZCBhIGNoZWNrIGZvciAnbm90IGEgdXNlciBhZGRyZXNzJyBkb24ndCB5b3Ugd2FudCB0
byBqdXN0DQpyZXF1aXJlIGFjY2Vzc19vaygpIGZhaWw/DQpUaGF0IHdvdWxkIGJlIGFyY2hpdGVj
dHVyZSBpbmRlcGVuZGVudC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtl
c2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBV
Sw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


