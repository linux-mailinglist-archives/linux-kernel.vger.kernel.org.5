Return-Path: <linux-kernel+bounces-18425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A428825D41
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 00:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 902D31F240C3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 23:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8DAD364A1;
	Fri,  5 Jan 2024 23:53:12 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBB3360A4
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 23:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-101-_D_FY1bAOYGSrnkXmJhLlA-1; Fri, 05 Jan 2024 23:53:00 +0000
X-MC-Unique: _D_FY1bAOYGSrnkXmJhLlA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 5 Jan
 2024 23:52:45 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 5 Jan 2024 23:52:45 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>
CC: Noah Goldstein <goldstein.w.n@gmail.com>, kernel test robot
	<lkp@intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"oe-kbuild-all@lists.linux.dev" <oe-kbuild-all@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>
Subject: RE: x86/csum: Remove unnecessary odd handling
Thread-Topic: x86/csum: Remove unnecessary odd handling
Thread-Index: AQHZ7ib2fs4a8+P0bkWBCjHsrqR0abAo6HRAgKIYy6qAAJmVUIAAjHgAgABZ3tA=
Date: Fri, 5 Jan 2024 23:52:45 +0000
Message-ID: <204bf145e6ad47219c005e9a4407ebdc@AcuMS.aculab.com>
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
In-Reply-To: <CAHk-=wg8vssPVO68_qH_BHBCj6_DDawKQHBOgZh4gw5YFmpCKA@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDUgSmFudWFyeSAyMDI0IDE4OjA2DQo+IA0K
PiBPbiBGcmksIDUgSmFuIDIwMjQgYXQgMDI6NDEsIERhdmlkIExhaWdodCA8RGF2aWQuTGFpZ2h0
QGFjdWxhYi5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSW50ZXJlc3RpbmcsIEknbSBwcmV0dHkgc3Vy
ZSB0cnlpbmcgdG8gZ2V0IHR3byBibG9ja3Mgb2YNCj4gPiAgJ2FkYycgc2NoZWR1bGVkIGluIHBh
cmFsbGVsIGxpa2UgdGhhdCBkb2Vzbid0IHdvcmsuDQo+IA0KPiBZb3Ugc2hvdWxkIGNoZWNrIG91
dCB0aGUgYmVuY2htYXJrIGF0DQo+IA0KPiAgICAgICAgaHR0cHM6Ly9naXRodWIuY29tL2ZlbnJ1
czc1L2NzdW1fcGFydGlhbA0KPiANCj4gYW5kIHNlZSBpZiB5b3UgY2FuIGltcHJvdmUgb24gaXQu
IEknbSBpbmNsdWRpbmcgdGhlIHBhdGNoIChvbiB0b3Agb2YNCj4gdGhhdCBjb2RlIGJ5IEFyamFu
KSB0byBpbXBsZW1lbnQgdGhlIGFjdHVhbCBjdXJyZW50IGtlcm5lbCB2ZXJzaW9uIGFzDQo+ICJO
ZXcgdmVyc2lvbiIuDQoNCkknZCBoYXZlIHRvIGZpeCBoaXMgYmVuY2htYXJrIGNvZGUgZmlyc3Qg
Oi0pDQpZb3UgY2FuJ3QgdXNlIHRoZSBUU0MgdW5sZXNzIHlvdSBsb2NrIHRoZSBjcHUgZnJlcXVl
bmN5Lg0KVGhlIGxvbmdlciB0aGUgdGVzdCBydW5zIGZvciB0aGUgZmFzdGVyIHRoZSBjcHUgd2ls
bCBydW4uDQpJJ3ZlIGhhZCB0byB1c2UgdGhlIHBlcmZvcm1hbmNlIGNvdW50ZXJzIHRvIGdldCBh
Y2N1cmF0ZSBjeWNsZSBjb3VudHMuDQoNCkknbSBhbHNvIHN1cmUgSSB0cmllZCB0d28gc2VwYXJh
dGUgJ2FkYycgY2hhaW5zIGFuZCBmYWlsZWQNCnRvIGdldCBhbnkgb3ZlcmxhcHBlZCBpbnN0cmlj
dGlvbnMuDQpCdXQgSSdsbCB0cnkgaGlzIGxvb3AgaW4gbXkgZnJhbWV3b3JrLg0KDQpUaGUgJ2xm
ZW5jZScgdmVyc2lvbiBhbHNvIHJlYWxseSBkb2VzIG1hdHRlci4NCkluIHNvbWUgc2Vuc2UgaXQg
ZG9lc24ndCBtYXR0ZXIgaWYgeW91IGFkZCAxMCBjbG9ja3MgdG8gdGhlDQpJUCBoZWFkZXIgY2hl
Y2tzdW0gLSB0aGV5J2xsIGJlIGR3YXJmZWQgYnkgZXZlcnl0aGluZyBlbHNlLg0KQnV0IGlmIHlv
dSBkbyBoYXZlIHRvIGNoZWNrc3VtIGFuIDhrIE5GUyBVRFAgZGF0YWdyYW0gdGhlDQpsb29wIGNv
dW50IG1hdHRlcnMuDQoNClRoZSBPT08gZW5naW5lIGlzIHZlcnkgZ29vZCBhIGp1c3QgcGlsaW5n
IHVwIGluc3RydWN0aW9ucw0KdGhhdCBhcmUgd2FpdGluZyBmb3IgcHJldmlvdXMgaW5zdHJ1Y3Rp
b25zIGluIGEgYmlnIHF1ZXVlDQphbmQgZXhlY3V0aW5nIGluc3RydWN0aW9uIGZvciB3aGljaCB0
aGUgZGF0YSBpcyBhdmFpbGFibGUuDQpTbyB0aGUgY29udHJvbCBmbG93IGZvciB0aGUgY2hlY2tz
dW0gY29kZSBjYW4gZmluaXNoIHdlbGwNCmJlZm9yZSB0aGUgY2hlY2tzdW0gaXMgYXZhaWxhYmxl
Lg0KDQpPbiBhIHJlbGF0ZWQgcG9pbnQsIGRvIHlvdSByZW1lbWJlciB3aGF0IHRoZSAna2lsbGVy
IGFwcCcNCndhcyBmb3IgZG9pbmcgdGhlIGNoZWNrc3VtIGluIGNvcHlfdG8vZnJvbV91c2VyPw0K
DQpUaGUgY2hhbmdlIHByZS1kYXRlcyBnaXQgYW5kIEkgY2FuJ3QgZmluZCB0aGUgY29tbWl0IG1l
c3NhZ2UuDQpUaGUgb25seSBwbGFjZSBpdCBpcyBkb25lIGluIHRoZSByZWNlaXZlIHBhdGggaXMg
Zm9yIFVEUC4NCkF0IGEgZ3Vlc3MgdGhhdCBoZWxwZWQgOGsgVURQIGRhdGFncmFtcyBnb2luZyBp
bnRvIGEgdXNlcnNwYWNlIG5mc2Q/DQpJIGJldCBub3RoaW5nIHJlYWxseSBkZXBlbmRzIG9uIFJY
IFVEUCBwZXJmb3JtYW5jZSB0byB1c2Vyc3BhY2UNCm9uIHN5c3RlbXMgdGhhdCBkb24ndCBkbyBo
dyBjaGVja3N1bT8NCg0KVGhlIHR4IHNpZGUgaXMgZG9uZSBjb3B5aW5nIGRhdGEgaW50byBhbiBz
a2IsIEknbSBub3Qgc3VyZSBpZg0KdGhhdCBpcyBhbGwgY29waWVzIC0geW91IHJlYWxseSBkb24n
dCB3YW50IHRvIGRvIGl0IGlmIHRoZQ0KaGFyZHdhcmUgc3VwcG9ydHMgdHggY2hlY2tzdW0gb2Zm
bG9hZC4NClVzaW5nICdyZXAgbW92c2InIGZvciBjb3B5X2Zyb21fdXNlcigpIGhhcyAgdG8gYmUg
ZmFzdGVyIHRoYW4NCnRoZSBJLWNhY2hlIGJ1c3RpbmcgJ2NvcHkgYW5kIGNoZWNrc3VtJyBjb2Rl
IC0gZXZlbiBpZiB5b3UNCmVuZCB1cCBkb2luZyBhIGNoZWNrc3VtIG5vdCBtdWNoIGxhdGVyIG9u
Lg0KDQpJSVJDIChJIGxvb2tlZCBhIGNvdXBsZSBvZiB3ZWVrcyBhZ28pIG9ubHkgeDg2LCBzcGFy
YzMyIGFuZCBtNjhrDQphY3R1YWxseSBoYXZlICdjb3B5IGFuZCBjaGVja3N1bScgKGFuZCB0aGUg
bTY4ayBkaWRuJ3Qgc2VlbSB0bw0KaGF2ZSB0aGUgbWFya2VycyBmb3IgZmF1bHRzISkuDQooQWxs
IG9mIHRoZW0gYXJlIEktY2FjaGUga2lsbGVycykNClRoZSBkZWZhdWx0IGlvdmVjW10gdmVyc2lv
biBjaGVja3N1bXMgZXZlcnkgZnJhZ21lbnQgLSB3aGljaA0KZ2l2ZXMgZ3JpZWYgdHJ5aW5nIHRv
IHJlcG9ydCBhIDMyYml0IGNoZWNrc3VtIGFuZCBFRkFVTFQuDQpPVE9IIGl0IGNvdWxkIHN1bSB0
aGUgbGluZWFyIGtlcm5lbCBidWZmZXIgYWZ0ZXIgdGhlIGNvcHkuDQpUaGF0IHdvdWxkIGxldCBp
dCBmb2xkIHRoZSBjaGVja3N1bSB0byAxN2JpdHMgYW5kIHJlcG9ydCAtMQ0KZm9yIEVGQVVMVC4N
Cg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2Fk
LCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCg==


