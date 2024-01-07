Return-Path: <linux-kernel+bounces-18848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BBE598263EF
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 12:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F28E1F2191D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 11:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7EF812E5C;
	Sun,  7 Jan 2024 11:44:50 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298412E4A
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 11:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-315-3rmU9uLGNsK9_7Ue5NSFgQ-1; Sun, 07 Jan 2024 11:44:39 +0000
X-MC-Unique: 3rmU9uLGNsK9_7Ue5NSFgQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 7 Jan
 2024 11:44:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 7 Jan 2024 11:44:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: "'H. Peter Anvin'" <hpa@zytor.com>, 'Linus Torvalds'
	<torvalds@linux-foundation.org>
CC: Noah Goldstein <goldstein.w.n@gmail.com>, "x86@kernel.org"
	<x86@kernel.org>, "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "edumazet@google.com" <edumazet@google.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRAgKIYy6qAAJmVUIAAjHgAgAHC99CAAEWrgIAArarg
Date: Sun, 7 Jan 2024 11:44:19 +0000
Message-ID: <5dd4c01e4337455b9b2c0f5635d7f6f9@AcuMS.aculab.com>
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
 <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
 <124b21857fe44e499e29800cbf4f63f8@AcuMS.aculab.com>
 <4313F9BB-DE2E-448F-A366-A68CAEA2BFE0@zytor.com>
In-Reply-To: <4313F9BB-DE2E-448F-A366-A68CAEA2BFE0@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4NCj4gU2VudDogMDcgSmFudWFyeSAyMDI0IDAxOjA5DQo+IA0K
PiBPbiBKYW51YXJ5IDYsIDIwMjQgMjowODo0OCBQTSBQU1QsIERhdmlkIExhaWdodCA8RGF2aWQu
TGFpZ2h0QEFDVUxBQi5DT00+IHdyb3RlOg0KLi4uDQo+ID5UaGUgYmVzdCBsb29wIGZvciAyNTYr
IGJ5dGVzIGlzIGFuIGFkeGMvYWR4byBvbmUuDQo+ID5Ib3dldmVyIHRoYXQgcmVxdWlyZXMgdGhl
IHJ1bi10aW1lIHBhdGNoaW5nLg0KLi4uDQo+IFJhdGhlciB0aGFuIHJ1bnRpbWUgcGF0Y2hpbmcg
cGVyaGFwcyBzZXBhcmF0ZSBwYXRocy4uLg0KDQpJdCB3aWxsIG5lZWQgdG8gZGV0ZWN0IHRoZSBj
cHUgdHlwZSBlYXJsaWVyLCBzbyBhIHN0YXRpYw0KYnJhbmNoIGlzIHByb2JhYmx5IGVub3VnaC4N
CkVhc2llciB0aGFuIHN1YnN0aXR1dGluZyB0aGUgZW50aXJlIGNvZGUgYmxvY2suDQoNCkkgdGhp
bmsgaXQgaXMgc2lsdmVybW9udCBhbmQga25pZ2h0J3MgbGFuZGluZyB0aGF0IGhhdmUNCmEgNCBj
bG9jayBwZW5hbHR5IGZvciA2NGJpdCBhZHhjIChJbnRlbCBhdG9tIGZhbWlseSkuDQpUaGF0IG1p
Z2h0IG9ubHkgYmUgYSBkZWNvZGUgcGVuYWx0eSwgc28gZG9lc24ndCBhZmZlY3QNCnRoZSBsb29w
ICd0aGF0IG11Y2gnIChhZGMgaXMgMiBjbG9ja3Mgb24gdGhvc2UgY3B1KS4NClNvIHByb2JhYmx5
IG5vdCBhY3R1YWxseSB3b3J0aCBkb2luZyBhIHJ1bi10aW1lDQpwZXJmb3JtYW5jZSBjaGVjay4N
Cg0KSSBtaWdodCAnY29vayB1cCcgYSBmdWxsIGNoZWNrc3VtIGZ1bmN0aW9uIGxhdGVyLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


