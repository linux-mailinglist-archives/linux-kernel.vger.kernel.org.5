Return-Path: <linux-kernel+bounces-44552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B506084241E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 468D01F219CF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE86F679E4;
	Tue, 30 Jan 2024 11:51:34 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 932D066B5F
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 11:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706615494; cv=none; b=EM0iuNleMeBkUHGFkRnVmy/WUMZiEf5WMTmjySC0gloV21Z5VGzw7lsxQWuwvV+xx/Bv/dP1GdXqOKLJp7+4ItGPre3Snqm+7IQWCKv2M368xcQgVXOMMpxsHO50XJlytvj/Y/sInc034pa6rsYIkSXTK6dwVf7a1J/ptKBNdqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706615494; c=relaxed/simple;
	bh=30nEctjwaKxxAswJg2GaQfi9q6VRb2fckRavbZGSWPk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=TcIcv0KD/QoF6GLw7tq8aSDVBXs+oEInvZ61H5TZsQJwGaVSlrIlf4vX/8l1+o46/k9k7GwIPxYYbLDINvch6+np8OJRd0P7Fdih+i7FLzIDlHoQ94OJ60UDAbbopI40BgsIZavDmDCiYT8raH5x6Kp2NVpmXghnKBGW+OJxifU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-241-VzaTdC0ENPqj-j_pQMBvdA-1; Tue, 30 Jan 2024 11:51:24 +0000
X-MC-Unique: VzaTdC0ENPqj-j_pQMBvdA-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 30 Jan
 2024 11:51:05 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 30 Jan 2024 11:51:05 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jisheng Zhang' <jszhang@kernel.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matteo Croce
	<mcroce@microsoft.com>, kernel test robot <lkp@intel.com>
Subject: RE: [PATCH 2/3] riscv: optimized memmove
Thread-Topic: [PATCH 2/3] riscv: optimized memmove
Thread-Index: AQHaUdxjAvIJPrdYsUmtWfJZGIT/drDvKbzwgAMSEICAAAQ2IA==
Date: Tue, 30 Jan 2024 11:51:05 +0000
Message-ID: <2391e924440d4e59b7859b8ede8f0954@AcuMS.aculab.com>
References: <20240128111013.2450-1-jszhang@kernel.org>
 <20240128111013.2450-3-jszhang@kernel.org>
 <59bed43df37b4361a8a1cb31b8582e9b@AcuMS.aculab.com>
 <Zbjd43y3s6PDfQE0@xhacker>
In-Reply-To: <Zbjd43y3s6PDfQE0@xhacker>
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

RnJvbTogSmlzaGVuZyBaaGFuZw0KPiBTZW50OiAzMCBKYW51YXJ5IDIwMjQgMTE6MzENCj4gDQo+
IE9uIFN1biwgSmFuIDI4LCAyMDI0IGF0IDEyOjQ3OjAwUE0gKzAwMDAsIERhdmlkIExhaWdodCB3
cm90ZToNCj4gPiBGcm9tOiBKaXNoZW5nIFpoYW5nDQo+ID4gPiBTZW50OiAyOCBKYW51YXJ5IDIw
MjQgMTE6MTANCj4gPiA+DQo+ID4gPiBXaGVuIHRoZSBkZXN0aW5hdGlvbiBidWZmZXIgaXMgYmVm
b3JlIHRoZSBzb3VyY2Ugb25lLCBvciB3aGVuIHRoZQ0KPiA+ID4gYnVmZmVycyBkb2Vzbid0IG92
ZXJsYXAsIGl0J3Mgc2FmZSB0byB1c2UgbWVtY3B5KCkgaW5zdGVhZCwgd2hpY2ggaXMNCj4gPiA+
IG9wdGltaXplZCB0byB1c2UgYSBiaWdnZXIgZGF0YSBzaXplIHBvc3NpYmxlLg0KPiA+ID4NCj4g
PiAuLi4NCj4gPiA+ICsgKiBTaW1wbHkgY2hlY2sgaWYgdGhlIGJ1ZmZlciBvdmVybGFwcyBhbiBj
YWxsIG1lbWNweSgpIGluIGNhc2UsDQo+ID4gPiArICogb3RoZXJ3aXNlIGRvIGEgc2ltcGxlIG9u
ZSBieXRlIGF0IHRpbWUgYmFja3dhcmQgY29weS4NCj4gPg0KPiA+IEknZCBhdCBsZWFzdCBkbyBh
IDY0Yml0IGNvcHkgbG9vcCBpZiB0aGUgYWRkcmVzc2VzIGFyZSBhbGlnbmVkLg0KPiA+DQo+ID4g
VGhpbmtzIGEgYml0IG1vcmUuLi4uDQo+ID4NCj4gPiBQdXQgdGhlIGNvcHkgNjQgYnl0ZXMgY29k
ZSAodGhlIGJvZHkgb2YgdGhlIG1lbWNweSgpIGxvb3ApDQo+ID4gaW50byBpdCBhbiBpbmxpbmUg
ZnVuY3Rpb24gYW5kIGNhbGwgaXQgd2l0aCBpbmNyZWFzaW5nIGFkZHJlc3Nlcw0KPiA+IGluIG1l
bWNweSgpIGFyZSBkZWNyZW1lbnRpbmcgYWRkcmVzc2VzIGluIG1lbW1vdmUuDQo+IA0KPiBIaSBE
YXZpZCwNCj4gDQo+IEJlc2lkZXMgdGhlIDY0IGJ5dGVzIGNvcHksIHRoZXJlJ3MgYW5vdGhlciBv
cHRpbWl6YXRpb24gaW4gX19tZW1jcHk6DQo+IHdvcmQtYnktd29yZCBjb3B5IGV2ZW4gaWYgcyBh
bmQgZCBhcmUgbm90IGFsaWduZWQuDQo+IFNvIGlmIHdlIG1ha2UgdGhlIHR3byBvcHRpbWl6ZCBj
b3B5IGFzIGlubGluZSBmdW5jdGlvbnMgYW5kIGNhbGwgdGhlbQ0KPiBpbiBtZW1tb3ZlKCksIHdl
IGFsbW9zdCBkdXBsaWNhdGUgdGhlIF9fbWVtY3B5IGNvZGUsIHNvIEkgdGhpbmsNCj4gZGlyZWN0
bHkgY2FsbGluZyBfX21lbWNweSBpcyBhIGJpdCBiZXR0ZXIuDQoNCklmIGEgZm9yd2FyZHMgY29w
eSBpcyB2YWxpZCBjYWxsIG1lbWNweSgpIC0gd2hpY2ggSSB0aGluayB5b3UgZG8uDQpJZiBub3Qg
eW91IGNhbiBzdGlsbCB1c2UgdGhlIHNhbWUgJ2NvcHkgOCByZWdpc3RlcicgY29kZQ0KdGhhdCBt
ZW1jcHkoKSB1c2VzIC0ganVzdCB3aXRoIGEgZGVjcmVtZW50aW5nIGJsb2NrIGFkZHJlc3MuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=


