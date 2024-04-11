Return-Path: <linux-kernel+bounces-140240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61E428A0FD7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 12:28:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18675282BC5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 10:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072E7146A8D;
	Thu, 11 Apr 2024 10:28:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDA914600E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 10:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712831286; cv=none; b=Lul7SuzViZXvEjaR1v8h+uJqxDDFpN2NfAk75j+8BFGDtvXFE6pPhF6f0rXcv3t0Ju8N37xXxKOywgNoNsZYCgkxRJfEXbHqGAz4x4ZV/oh6ucR1n3Wc5lcxdc7Z9hOvinQguZ/a/71e9l/nBRfzyfVqrzdt9P2p3k+4gldJffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712831286; c=relaxed/simple;
	bh=S8CuP0uAJf1JsvKaTi8HzyGFRr5zKo+GObz4MF1+pT8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=ssnc45VSGaO3zL1kl6b2DS+PbDkdA4E5Fytt40PHbpmgJUjsyehRzpcIMib1/UuU4i/bcClMMYPw44XT87CNz5Vw1RjTrnVRTz19Li4FyIGg3oApEJdKPlCmMIIx2bhj8EP8UNF/Ll1h4tz2gP0sZjMqsAdhELFsDr4nafwADa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-37-dtAk8lfNPqaLMtFIigBSZg-1; Thu, 11 Apr 2024 11:27:51 +0100
X-MC-Unique: dtAk8lfNPqaLMtFIigBSZg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 11 Apr
 2024 11:27:23 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 11 Apr 2024 11:27:23 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Adrian Hunter' <adrian.hunter@intel.com>, Arnd Bergmann <arnd@arndb.de>
CC: Peter Zijlstra <peterz@infradead.org>, Dave Hansen
	<dave.hansen@linux.intel.com>, John Stultz <jstultz@google.com>, "H. Peter
 Anvin" <hpa@zytor.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Vincenzo
 Frascino" <vincenzo.frascino@arm.com>, "linux-s390@vger.kernel.org"
	<linux-s390@vger.kernel.org>, Naresh Kamboju <naresh.kamboju@linaro.org>,
	"x86@kernel.org" <x86@kernel.org>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Naveen N. Rao"
	<naveen.n.rao@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>, "Borislav
 Petkov" <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Thomas Gleixner <tglx@linutronix.de>, "Anna-Maria
 Gleixner" <anna-maria@linutronix.de>, Stephen Boyd <sboyd@kernel.org>, "Randy
 Dunlap" <rdunlap@infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Thread-Topic: [PATCH] bug: Fix no-return-statement warning with !CONFIG_BUG
Thread-Index: AQHai+8rQSO3zfnELkWMcaajEoNC87Fi2ofw
Date: Thu, 11 Apr 2024 10:27:23 +0000
Message-ID: <a0776e05c5074da2b8394926b2f787a2@AcuMS.aculab.com>
References: <20240410153212.127477-1-adrian.hunter@intel.com>
 <87be83da-6102-483d-b1dc-a77eecc9f780@app.fastmail.com>
 <c9f382b2-cd96-4ee3-ad68-95381d9e09c0@intel.com>
 <cac3f357-0dc2-46ba-9ea0-7b1f4278e8ff@app.fastmail.com>
 <0fd5e869-720f-41bb-9f0f-c0f3925ffc1b@intel.com>
In-Reply-To: <0fd5e869-720f-41bb-9f0f-c0f3925ffc1b@intel.com>
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

RnJvbTogQWRyaWFuIEh1bnRlcg0KPiBTZW50OiAxMSBBcHJpbCAyMDI0IDEwOjA0DQo+IA0KPiBP
biAxMS8wNC8yNCAxMDo1NiwgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gPiBPbiBUaHUsIEFwciAx
MSwgMjAyNCwgYXQgMDk6MTYsIEFkcmlhbiBIdW50ZXIgd3JvdGU6DQo+ID4+IE9uIDExLzA0LzI0
IDEwOjA0LCBBcm5kIEJlcmdtYW5uIHdyb3RlOg0KPiA+Pj4gT24gV2VkLCBBcHIgMTAsIDIwMjQs
IGF0IDE3OjMyLCBBZHJpYW4gSHVudGVyIHdyb3RlOg0KPiA+Pj4+IEJVRygpIGRvZXMgbm90IHJl
dHVybiwgYW5kIGFyY2ggaW1wbGVtZW50YXRpb25zIG9mIEJVRygpIHVzZSB1bnJlYWNoYWJsZSgp
DQo+ID4+Pj4gb3Igb3RoZXIgbm9uLXJldHVybmluZyBjb2RlLiBIb3dldmVyIHdpdGggIUNPTkZJ
R19CVUcsIHRoZSBkZWZhdWx0DQo+ID4+Pj4gaW1wbGVtZW50YXRpb24gaXMgb2Z0ZW4gdXNlZCBp
bnN0ZWFkLCBhbmQgdGhhdCBkb2VzIG5vdCBkbyB0aGF0LiB4ODYgYWx3YXlzDQo+ID4+Pj4gdXNl
cyBpdHMgb3duIGltcGxlbWVudGF0aW9uLCBidXQgcG93ZXJwYyB3aXRoICFDT05GSUdfQlVHIGdp
dmVzIGEgYnVpbGQNCj4gPj4+PiBlcnJvcjoNCj4gPj4+Pg0KPiA+Pj4+ICAga2VybmVsL3RpbWUv
dGltZWtlZXBpbmcuYzogSW4gZnVuY3Rpb24g4oCYdGltZWtlZXBpbmdfZGVidWdfZ2V0X25z4oCZ
Og0KPiA+Pj4+ICAga2VybmVsL3RpbWUvdGltZWtlZXBpbmcuYzoyODY6MTogZXJyb3I6IG5vIHJl
dHVybiBzdGF0ZW1lbnQgaW4gZnVuY3Rpb24NCj4gPj4+PiAgIHJldHVybmluZyBub24tdm9pZCBb
LVdlcnJvcj1yZXR1cm4tdHlwZV0NCj4gPj4+Pg0KPiA+Pj4+IEFkZCB1bnJlYWNoYWJsZSgpIHRv
IGRlZmF1bHQgIUNPTkZJR19CVUcgQlVHKCkgaW1wbGVtZW50YXRpb24uDQo+ID4+Pg0KPiA+Pj4g
SSdtIGEgYml0IHdvcnJpZWQgYWJvdXQgdGhpcyBwYXRjaCwgc2luY2Ugd2UgaGF2ZSBoYWQgcHJv
YmxlbXMNCj4gPj4+IHdpdGggdW5yZWFjaGFibGUoKSBpbnNpZGUgb2YgQlVHKCkgaW4gdGhlIHBh
c3QsIGFuZCBhcyBmYXIgYXMgSQ0KPiA+Pj4gY2FuIHJlbWVtYmVyLCB0aGUgY3VycmVudCB2ZXJz
aW9uIHdhcyB0aGUgb25seSBvbmUgdGhhdA0KPiA+Pj4gYWN0dWFsbHkgZGlkIHRoZSByaWdodCB0
aGluZyBvbiBhbGwgY29tcGlsZXJzLg0KPiA+Pj4NCj4gPj4+IE9uZSBwcm9ibGVtIHdpdGggYW4g
dW5yZWFjaGFibGUoKSBhbm5vdGF0aW9uIGhlcmUgaXMgdGhhdCBpZg0KPiA+Pj4gYSBjb21waWxl
ciBtaXNhbmFseXNlcyB0aGUgZW5kbGVzcyBsb29wLCBpdCBjYW4gZGVjaWRlIHRvDQo+ID4+PiB0
aHJvdyBvdXQgdGhlIGVudGlyZSBjb2RlIHBhdGggbGVhZGluZyB1cCB0byBpdCBhbmQganVzdA0K
PiA+Pj4gcnVuIGludG8gdW5kZWZpbmVkIGJlaGF2aW9yIGluc3RlYWQgb2YgcHJpbnRpbmcgYSBC
VUcoKQ0KPiA+Pj4gbWVzc2FnZS4NCj4gPj4+DQo+ID4+PiBEbyB5b3Uga25vdyB3aGljaCBjb21w
aWxlciB2ZXJzaW9uIHNob3cgdGhlIHdhcm5pbmcgYWJvdmU/DQo+ID4+DQo+ID4+IE9yaWdpbmFs
IHJlcG9ydCBoYXMgYSBsaXN0DQo+ID4+DQo+ID4NCj4gPiBJdCBsb29rcyBsaWtlIGl0J3MgYWxs
IHZlcnNpb25zIG9mIGdjYywgdGhvdWdoIG5vIHZlcnNpb25zDQo+ID4gb2YgY2xhbmcgc2hvdyB0
aGUgd2FybmluZ3MuIEkgZGlkIGEgZmV3IG1vcmUgdGVzdHMgYW5kIGNvdWxkDQo+ID4gbm90IGZp
bmQgYW55IGRpZmZlcmVuY2VzIG9uIGFjdHVhbCBjb2RlIGdlbmVyYXRpb24sIGJ1dA0KPiA+IEkn
ZCBzdGlsbCBmZWVsIG1vcmUgY29tZm9ydGFibGUgY2hhbmdpbmcgdGhlIGNhbGxlciB0aGFuDQo+
ID4gdGhlIEJVRygpIG1hY3JvLiBJdCdzIHRyaXZpYWwgdG8gYWRkIGEgJ3JldHVybiAwJyB0aGVy
ZS4NCj4gDQo+IEFGQUlDVCBldmVyeSBpbXBsZW1lbnRhdGlvbiBvZiBCVUcoKSBleGNlcHQgdGhp
cyBvbmUgaGFzDQo+IHVucmVhY2hhYmxlKCkgb3IgZXF1aXZhbGVudCwgc28gdGhhdCBpbmNvbnNp
c3RlbmN5IHNlZW1zDQo+IHdyb25nLg0KPiANCj4gQ291bGQgYWRkICdyZXR1cm4gMCcsIGJ1dCBJ
IGRvIG5vdGljZSBvdGhlciBjYXNlcw0KPiB3aGVyZSBhIGZ1bmN0aW9uIGRvZXMgbm90IGhhdmUg
YSByZXR1cm4gdmFsdWUsIHN1Y2ggYXMNCj4gY3B1c19oYXZlX2ZpbmFsX2Jvb3RfY2FwKCksIHNv
IHRoZXJlIGlzIGFscmVhZHkgYW4gZXhwZWN0YXRpb24NCj4gdGhhdCB0aGF0IGlzIE9LLg0KDQpJ
c24ndCB0aGF0IGxpa2VseSB0byBnZW5lcmF0ZSBhbiAndW5yZWFjaGFibGUgY29kZScgd2Fybmlu
Zz8NCkkgYW55IGNhc2UgdGhlIGNvbXBpbGVyIGNhbiBnZW5lcmF0ZSBiZXR0ZXIgY29kZSBmb3Ig
dGhlIG5vbi1CVUcoKQ0KcGF0aCBpZiBpdCBrbm93cyBCVUcoKSBkb2Vzbid0IHJldHVybi4NCihB
bmQgY29uZnVzZSBzdGFjayBiYWNrLXRyYWNlIGNvZGUgaW4gdGhlIHByb2Nlc3MuKQ0KDQo+IA0K
PiA+IEFub3RoZXIgaW50ZXJlc3Rpbmcgb2JzZXJ2YXRpb24gaXMgdGhhdCBjbGFuZy0xMSBhbmQg
ZWFybGllcg0KPiA+IHZlcnNpb25zIGVuZCB1cCBza2lwcGluZyB0aGUgZW5kbGVzcyBsb29wLCBi
b3RoIHdpdGggYW5kDQo+ID4gd2l0aG91dCB0aGUgX19idWlsdGluX3VucmVhY2hhYmxlLCBzZWUN
Cj4gPiBodHRwczovL2dvZGJvbHQub3JnL3ovYXFhOXpxejh4DQo+IA0KPiBBZGRpbmcgdm9sYXRp
bGUgYXNtKCIiKSB0byB0aGUgbG9vcCB3b3VsZCBwcm9iYWJseSBmaXggdGhhdCwNCj4gYnV0IGl0
IHNlZW1zIGxpa2UgYSBzZXBhcmF0ZSBpc3N1ZS4NCg0KSSdkIGd1ZXNzIGJhcnJpZXIoKSB3b3Vs
ZCBiZSBiZXR0ZXIuDQpJdCBtaWdodCBiZSBuZWVkZWQgYmVmb3JlIHRoZSBsb29wc3RvcCBmb3Ig
b3RoZXIgcmVhc29ucy4NClRoZSBjb21waWxlciBtaWdodCBiZSBqdXN0IG1vdmluZyBjb2RlIGJl
bG93IHRoZSBsb29wIGFuZCB0aGVuDQpkaXNjYXJkaW5nIGl0IGFzIHVucmVhY2hhYmxlLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


