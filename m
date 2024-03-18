Return-Path: <linux-kernel+bounces-106316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7634E87EC4B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321D4281CB0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DB6524B5;
	Mon, 18 Mar 2024 15:39:11 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C0252F79
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 15:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710776350; cv=none; b=X2ljvV+lLY/IzhKRqF9OGuoiNoSowRCpb8hVRPVfUABkbDUk6qhftssItWwkTR/rh/4vKDIGiflVDiJRjPdFO3TwCcW8mChP51h29hrMY3BM4wuVv1PKWEpo/3Z7fe+J8b2e3jW9yNRMlgfD2tkkwZfrdICBeG2IWyHk6CiuKuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710776350; c=relaxed/simple;
	bh=Gvu8dnFAnEHni20ihzX3JsZz/u9pi9EJVtJMF0uInvg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=B2SSUuBVJbnaHzabUelzKnyCqZ0M6Azcp0Qael8eqYQgen0fb2autO41y7dpncJEP81aJb+7kc4LfL5/D+PorBb6i1J37jNmWcrOnc+A0xBdA5JHhbdfKAfDC5m1tU5yk41ZYTLCW+FCsdF4aUyCMN9OKkMcUYnQIs9gU1Nwhkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-1qHIhjo7NAe4MMzwaZccqA-1; Mon, 18 Mar 2024 15:38:59 +0000
X-MC-Unique: 1qHIhjo7NAe4MMzwaZccqA-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 18 Mar
 2024 15:38:36 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 18 Mar 2024 15:38:36 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pasha Tatashin' <pasha.tatashin@soleen.com>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: Matthew Wilcox <willy@infradead.org>, Kent Overstreet
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
Thread-Index: AQHad9a+Y5/0t6VtDk+hhnG+kSJKOLE9nqig
Date: Mon, 18 Mar 2024 15:38:36 +0000
Message-ID: <74c82d8a6b5f490784cc8f16fa7d2c12@AcuMS.aculab.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <ZfNTSjfE_w50Otnz@casper.infradead.org>
 <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42>
 <ZfNWojLB7qjjB0Zw@casper.infradead.org>
 <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
 <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
 <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
In-Reply-To: <CA+CK2bDothmwdJ86K1LiKWDKdWdYDjg5WCwdbapL9c3Y_Sf+kg@mail.gmail.com>
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

Li4uDQo+IC0gZXhpdF90b191c2VyX21vZGUoKTogVW5tYXAgdGhlIGV4dHJhIHRocmVlIHBhZ2Vz
IGFuZCByZXR1cm4gdGhlbSB0bw0KPiB0aGUgcGVyLUNQVSBjYWNoZS4gVGhpcyBmdW5jdGlvbiBp
cyBjYWxsZWQgbGF0ZSBpbiB0aGUga2VybmVsIGV4aXQNCj4gcGF0aC4NCg0KV2h5IGJvdGhlcj8N
ClRoZSBudW1iZXIgb2YgdGFza3MgcnVubmluZyBpbiB1c2VyX21vZGUgaXMgbGltaXRlZCB0byB0
aGUgbnVtYmVyDQpvZiBjcHUuIFNvIHRoZSBtb3N0IHlvdSBzYXZlIGlzIGEgZmV3IHBhZ2VzIHBl
ciBjcHUuDQoNClBsYXVzaWJseSBhIGNvbnRleHQgc3dpdGNoIGZyb20gYW4gaW50ZXJydXB0IChl
ZyB0aW1lciB0aWNrKQ0KY291bGQgc3VzcGVuZCBhIHRhc2sgd2l0aG91dCBzYXZpbmcgYW55dGhp
bmcgb24gaXRzIGtlcm5lbCBzdGFjay4NCkJ1dCBob3cgY29tbW9uIGlzIHRoYXQgaW4gcmVhbGl0
eT8NCkluIGEgd2VsbCBiZWhhdmVkIHN5c3RlbSBtb3N0IHVzZXIgdGhyZWFkcyB3aWxsIGJlIHNs
ZWVwaW5nIG9uDQpzb21lIGV2ZW50IC0gc28gd2l0aCBhbiBhY3RpdmUga2VybmVsIHN0YWNrLg0K
DQpJIGNhbiBhbHNvIGltYWdpbmUgdGhhdCBzb21ldGhpbmcgbGlrZSBzeXNfZXBvbGwoKSBhY3R1
YWxseQ0Kc2xlZXBzIHdpdGggbm90ICh0aGF0IG11Y2gpIHN0YWNrIGFsbG9jYXRlZC4NCkJ1dCB0
aGUgY2FsbHMgaW50byBhbGwgdGhlIGRyaXZlcnMgdG8gY2hlY2sgdGhlIHN0YXR1cw0KY291bGQg
ZWFzaWx5IGdvIGludG8gYW5vdGhlciBwYWdlLg0KWW91IHJlYWxseSB3b3VsZG4ndCB0byBrZWVw
IGFsbG9jYXRpbmcgYW5kIGRlYWxsb2NhdGluZw0KcGh5c2ljYWwgcGFnZXMgKHdoaWNoIEknbSBz
dXJlIGhhcyBUTEIgZmx1c2hpbmcgY29zdHMpDQphbGwgdGhlIHRpbWUgZm9yIHRob3NlIHByb2Nl
c3Nlcy4NCg0KUGVyaGFwcyBhICdnYXJiYWdlIGNvbGxlY3Rpb24nIGFjdGl2aXR5IHRoYXQgcmVj
bGFpbXMgc3RhY2sNCnBhZ2VzIGZyb20gcHJvY2Vzc2VzIHRoYXQgaGF2ZSBiZWVuIGFzbGVlcCAn
Zm9yIGEgd2hpbGUnIG9yDQpoYXZlbid0IHVzZWQgYSBsb3Qgb2Ygc3RhY2sgcmVjZW50bHkgKGlm
IGh3ICdwYWdlIGFjY2Vzc2VkJw0KYml0IGNhbiBiZSB1c2VkKSBtaWdodCBtYWtlIG1vcmUgc2Vu
c2UuDQoNCkhhdmUgeW91IGRvbmUgYW55IGluc3RydW1lbnRhdGlvbiB0byBzZWUgd2hpY2ggc3lz
dGVtIGNhbGxzDQphcmUgYWN0dWFsbHkgdXNpbmcgbW9yZSB0aGFuIChzYXkpIDhrIG9mIHN0YWNr
Pw0KQW5kIGhvdyBvZnRlbiB0aGUgdXNlciB0aHJlYWRzIHRoYXQgbWFrZSB0aG9zZSBjYWxscyBk
byBzbz8NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxl
eSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0
aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==


