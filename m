Return-Path: <linux-kernel+bounces-166729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F818B9E97
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FE2BB2592E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D38CC16C6A1;
	Thu,  2 May 2024 16:30:58 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D472015F302
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667458; cv=none; b=iYKazIrkFWn5vLUulqhR0X8LyoB9WVg2SVBGdscsZpTIKcj/T5+X8bZ4ry1qXCQWrzcBcZ9Hsr7inASNJ8cc4hUKxOvmKSu/dGps80Dj/UdoDLACW/7JeQqHCDVF8PV9ek7/pddByQj/Sd09UeB5ukppPqXr61mMzRuuELFAz7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667458; c=relaxed/simple;
	bh=2SQoQi7JeUwE5gXSWzDNdMZbjikWJj8zunkdgMusgJE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=sRfrdpokqAJOssmjsyq5MMxAnxhzDCAyPWmWtrLld5fmClK3YuE1P8vpAnOnkvGc5CYu7PB9MKEzpIhoWQXhmFLKQLLRewKa/70ABErlMRQSNW7K/bBjrgCNtwSO7D3wbqnezn7OaYalCJZ+KxuHhG7b5A4xl6rtmGk3BVmgdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-209-5UzM5jnQMu62QQGL5yAXng-1; Thu, 02 May 2024 17:30:49 +0100
X-MC-Unique: 5UzM5jnQMu62QQGL5yAXng-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 2 May
 2024 17:30:18 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 2 May 2024 17:30:18 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: "'H. Peter Anvin'" <hpa@zytor.com>, Jules Irenge <jbi.octave@gmail.com>,
	"mingo@redhat.com" <mingo@redhat.com>
CC: "tglx@linutronix.de" <tglx@linutronix.de>, "bp@alien8.de" <bp@alien8.de>,
	"x86@kernel.org" <x86@kernel.org>, "peterz@infradead.org"
	<peterz@infradead.org>, "rdunlap@infradead.org" <rdunlap@infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/3] x86/tsc: Use div64_ul instead of do_div()
Thread-Topic: [PATCH 1/3] x86/tsc: Use div64_ul instead of do_div()
Thread-Index: AQHamaA+T554jBHA0E2zu7rxgunKsbGEKAzg
Date: Thu, 2 May 2024 16:30:18 +0000
Message-ID: <5f30cab9917d4d46b581b06e00b792e9@AcuMS.aculab.com>
References: <Zi6H5P_mc6DPR_v3@octinomon.home>
 <7EE9AB38-3103-4091-A558-BF0DEAF61E1D@zytor.com>
In-Reply-To: <7EE9AB38-3103-4091-A558-BF0DEAF61E1D@zytor.com>
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

RnJvbTogSC4gUGV0ZXIgQW52aW4gDQo+IFNlbnQ6IDI4IEFwcmlsIDIwMjQgMjA6MTMNCj4gDQo+
IE9uIEFwcmlsIDI4LCAyMDI0IDEwOjMxOjE2IEFNIFBEVCwgSnVsZXMgSXJlbmdlIDxqYmkub2N0
YXZlQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID5kb19kaXYoKSB0cnVuY2F0ZXMgYSB1NjQgZGl2aXNv
ciB0byAzMiBiaXQuDQo+ID5UaGlzIGNhbiBsZWFkIHRvIG5vbi16ZXJvIGJlaW5nIHRydW5jYXRl
ZCB0byB6ZXJvIGZvciBkaXZpc2lvbi4NCj4gPg0KPiA+Rml4IGNvY2NpbmVsbGUgd2FybmluZw0K
PiA+V0FSTklORzogZG9fZGl2KCkgZG9lcyBhIDY0LWJ5LTMyIGRpdmlzaW9uLCBwbGVhc2UgY29u
c2lkZXIgdXNpbmcgZGl2NjRfdWwgaW5zdGVhZA0KPiA+DQo+ID5TaWduZWQtb2ZmLWJ5OiBKdWxl
cyBJcmVuZ2UgPGpiaS5vY3RhdmVAZ21haWwuY29tPg0KPiA+LS0tDQo+ID4gYXJjaC94ODYva2Vy
bmVsL3RzYy5jIHwgMiArLQ0KPiA+IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+DQo+ID5kaWZmIC0tZ2l0IGEvYXJjaC94ODYva2VybmVsL3RzYy5jIGIv
YXJjaC94ODYva2VybmVsL3RzYy5jDQo+ID5pbmRleCA1YTY5YTQ5YWNjOTYuLjJkYTM3ZjMzZGQx
NyAxMDA2NDQNCj4gPi0tLSBhL2FyY2gveDg2L2tlcm5lbC90c2MuYw0KPiA+KysrIGIvYXJjaC94
ODYva2VybmVsL3RzYy5jDQo+ID5AQCAtNDg0LDcgKzQ4NCw3IEBAIHN0YXRpYyB1bnNpZ25lZCBs
b25nIHBpdF9jYWxpYnJhdGVfdHNjKHUzMiBsYXRjaCwgdW5zaWduZWQgbG9uZyBtcywgaW50IGxv
b3BtaW4pDQo+ID4NCj4gPiAJLyogQ2FsY3VsYXRlIHRoZSBQSVQgdmFsdWUgKi8NCj4gPiAJZGVs
dGEgPSB0MiAtIHQxOw0KPiA+LQlkb19kaXYoZGVsdGEsIG1zKTsNCj4gPisJZGl2NjRfdWwoZGVs
dGEsIG1zKTsNCj4gPiAJcmV0dXJuIGRlbHRhOw0KPiA+IH0NCj4gPg0KPiANCj4gQXJlIHlvdSBz
dXJlIHRoaXMgaXMgbm90IGEgZmFsc2UgcG9zaXRpdmU/IFRoaXMgaXMgYSAqbXVjaCogbW9yZSBl
eHBlbnNpdmUgb3BlcmF0aW9uIG9uIDMyIGJpdHMuDQoNCklJUkMgZG9fZGl2KCkgaXNuJ3QgdGhh
dCBncmVhdCBlaXRoZXIuDQpTb21ld2hlcmUgaXQgY2hhbmdlZCBmcm9tIGJlaW5nIGEgc2ltcGxl
IHdyYXBwZXIgb24gdGhlIHg4NiAnZGl2JyBpbnN0cnVjdGlvbg0KKGllIDY0IGJ5IDMyIGdpdmlu
ZyAzMiBhbmQgMzIpIHRvIGJlaW5nIGFibGUgdG8gZ2VuZXJhdGUgYSA2NGJpdCBxdW90ZW50Lg0K
DQpCdXQgdGhlIHBhdGNoIGlzIGVudGlyZWx5IGJyb2tlbiBhcyB3ZWxsLg0KDQoJRGF2aWQNCg0K
LQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0s
IE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdh
bGVzKQ0K


