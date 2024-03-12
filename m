Return-Path: <linux-kernel+bounces-100861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC9879E55
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 23:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C8F5B23AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 22:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A401143C67;
	Tue, 12 Mar 2024 22:18:54 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70BE142636
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 22:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710281933; cv=none; b=U39aGv5QfpWLGX2Q7k9x0/+N5ampz1g+xvqTOIse2HzClj7yMox80lrOygd2grcW+0yFP8M+X0UbcUtAAFNQAPgasFlv/jTDwACQ2ni+Fvoyv+OYh/2FxJ4MpIeaiJ8Tlkk69E0y1VIPXweRUTnHjDdtX8rKjOfIFHDdiBFuivg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710281933; c=relaxed/simple;
	bh=DB0NP+6RaWIb4j+WqcnBBaMZdI0vXoKD8AOtv1qnpjE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=DzrEzL3+Ap4nQFm85R6dL7s4hx7dPdGtN7QShjWkM4/oZJYHkqR5YLgwKuem7ZO5YU8cS0/lDlphoKrWmaPmU/l4v0/GGNCf4KD+HPBbcMNYJ5TH8Hk9bm0txxzocEOK0XxnR6ZJyAwIE2H4+eD2dAvkODSZMa0/8JDReIBsxAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-232-H9lG9RwBO_iiT9WO8XAUZQ-1; Tue, 12 Mar 2024 22:18:38 +0000
X-MC-Unique: H9lG9RwBO_iiT9WO8XAUZQ-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 12 Mar
 2024 22:18:39 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Tue, 12 Mar 2024 22:18:39 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Pasha Tatashin' <pasha.tatashin@soleen.com>, "H. Peter Anvin"
	<hpa@zytor.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "x86@kernel.org" <x86@kernel.org>,
	"bp@alien8.de" <bp@alien8.de>, "brauner@kernel.org" <brauner@kernel.org>,
	"bristot@redhat.com" <bristot@redhat.com>, "bsegall@google.com"
	<bsegall@google.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "dianders@chromium.org"
	<dianders@chromium.org>, "dietmar.eggemann@arm.com"
	<dietmar.eggemann@arm.com>, "eric.devolder@oracle.com"
	<eric.devolder@oracle.com>, "hca@linux.ibm.com" <hca@linux.ibm.com>,
	"hch@infradead.org" <hch@infradead.org>, "jacob.jun.pan@linux.intel.com"
	<jacob.jun.pan@linux.intel.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jpoimboe@kernel.org" <jpoimboe@kernel.org>, "jroedel@suse.de"
	<jroedel@suse.de>, "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
	"kent.overstreet@linux.dev" <kent.overstreet@linux.dev>,
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
Thread-Index: AQHadLYCAhDItuNbYkuiZHzHZ11K+bE0pxog
Date: Tue, 12 Mar 2024 22:18:39 +0000
Message-ID: <e0e7e253412240b3b427624a984642e6@AcuMS.aculab.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com>
 <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
In-Reply-To: <CA+CK2bC+bgOfohCEEW7nwAdakVmzg=RhUjjw=+Rw3wFALnOq-Q@mail.gmail.com>
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

Li4uDQo+IEkgcmUtcmVhZCBteSBjb3ZlciBsZXR0ZXIsIGFuZCBJIGRvIG5vdCBzZWUgd2hlcmUg
Imtlcm5lbCBtZW1vcnkiIGlzDQo+IG1lbnRpb25lZC4gV2UgYXJlIHRhbGtpbmcgYWJvdXQga2Vy
bmVsIHN0YWNrcyBvdmVyaGVhZCB0aGF0IGlzDQo+IHByb3BvcnRpb25hbCB0byB0aGUgdXNlciB3
b3JrbG9hZCwgYXMgZXZlcnkgYWN0aXZlIHRocmVhZCBoYXMgYW4NCj4gYXNzb2NpYXRlZCBrZXJu
ZWwgc3RhY2suIFRoZSBpZGVhIGlzIHRvIHNhdmUgbWVtb3J5IGJ5IG5vdA0KPiBwcmUtYWxsb2Nh
dGluZyBhbGwgcGFnZXMgb2Yga2VybmVsLXN0YWNrcywgYnV0IGluc3RlYWQgdXNlIGl0IGFzIGEN
Cj4gc2FmZWd1YXJkIHdoZW4gYSBzdGFjayBhY3R1YWxseSBiZWNvbWVzIGRlZXAuIENvbWUtdXAg
d2l0aCBhIHNvbHV0aW9uDQo+IHRoYXQgY2FuIGhhbmRsZSByYXJlIGRlZXBlciBzdGFja3Mgb25s
eSB3aGVuIG5lZWRlZC4gVGhpcyBjb3VsZCBiZQ0KPiBkb25lIHRocm91Z2ggZmF1bHRpbmcgb24g
dGhlIHN1cHBvcnRlZCBoYXJkd2FyZSAoYXMgcHJvcG9zZWQgaW4gdGhpcw0KPiBzZXJpZXMpLCBv
ciB2aWEgcHJlLW1hcCBvbiBldmVyeSBzY2hlZHVsZSBldmVudCwgYW5kIGNoZWNraW5nIHRoZQ0K
PiBhY2Nlc3Mgd2hlbiB0aHJlYWQgZ29lcyBvZmYgY3B1IChhcyBwcm9wb3NlZCBieSBBbmR5IEx1
dG9taXJza2kgdG8NCj4gYXZvaWQgZG91YmxlIGZhdWx0cyBvbiB4ODYpIC4NCj4gDQo+IEluIG90
aGVyIHdvcmRzLCB0aGlzIGZlYXR1cmUgaXMgb25seSBhYm91dCBvbmUgdmVyeSBzcGVjaWZpYyB0
eXBlIG9mDQo+IGtlcm5lbCBtZW1vcnkgdGhhdCBpcyBub3QgZXZlbiBkaXJlY3RseSBtYXBwZWQg
KHRoZSBmZWF0dXJlIHJlcXVpcmVkDQo+IHZtYXBwZWQgc3RhY2tzKS4NCg0KSnVzdCBmb3IgaW50
ZXJlc3QgaG93IGJpZyBkb2VzIHRoZSByZWdpc3RlciBzYXZlIGFyZWEgZ2V0Pw0KSW4gdGhlICdn
b29kIG9sZCBkYXlzJyBpdCBjb3VsZCBiZSBhbGxvY2F0ZWQgZnJvbSB0aGUgbG93IGVuZCBvZiB0
aGUNCnN0YWNrIG1lbW9yeS4gQnV0IEFWWDUxMiBzdGFydHMgbWFraW5nIGl0IGxhcmdlIC0gbmV2
ZXIgbWluZCBzb21lDQpvdGhlciB0aGluZ3MgdGhhdCAoSUlSQykgbWlnaHQgZ2V0IHRvIDhrLg0K
RXZlbiB0aGUgdGFzayBhcmVhIGlzIHByb2JhYmx5IG5vbi10cml2aWFsIHNpbmNlIGZhciBmZXdl
ciB0aGluZ3MNCmNhbiBiZSBzaGFyZWQgdGhhbiBvbmUgbWlnaHQgaG9wZS4NCg0KSSdtIHN1cmUg
SSByZW1lbWJlciBzb21lb25lIGNvbnRlbXBsYXRpbmcgbm90IGFsbG9jYXRpbmcgc3RhY2tzIHRv
DQplYWNoIHRocmVhZC4gSSB0aGluayB0aGF0IHJlcXVpcmVzIHdha2luZyB1cCB3aXRoIGEgc3lz
dGVtIGNhbGwNCnJlc3RhcnQgZm9yIHNvbWUgc3lzdGVtIGNhbGxzIC0gcGxhdXNpYmx5IHBvc3Np
YmxlIGZvciBmdXRleCgpIGFuZCBwb2xsKCkuDQoNCkFub3RoZXIgb3B0aW9uIGlzIHRvIGRvIGEg
cHJvcGVyIHN0YXRpYyBhbmFseXNpcyBvZiBzdGFjayB1c2FnZQ0KYW5kIGZpeCB0aGUgcGF0aHMg
dGhhdCBoYXZlIGRlZXAgc3RhY2tzIGFuZCByZW1vdmUgYWxsIHJlY3Vyc2lvbi4NCkknbSBwcmV0
dHkgc3VyZSBvYmp0b29sIGtub3dzIHRoZSBzdGFjayBvZmZzZXRzIG9mIGV2ZXJ5IGNhbGwgaW5z
dHJ1Y3Rpb24uDQpUaGUgaW5kaXJlY3QgY2FsbCBoYXNoZXMgKGZpbmUgSUJUPykgc2hvdWxkIGFs
bG93IGluZGlyZWN0IGNhbGxzDQpiZSBoYW5kbGVkIGFzIHdlbGwgYXMgZGlyZWN0IGNhbGxzLg0K
UHJvY2Vzc2luZyB0aGUgJ0EgY2FsbHMgQiBhdCBvZmZzZXQgbicgdG8gZ2VuZXJhdGUgYSBtYXgg
ZGVwdGgNCmlzIGp1c3QgYSBTTU9QLg0KDQpBdCB0aGUgbW9tZW50IEkgdGhpbmsgYWxsICd2b2lk
ICgqKSh2b2lkICopJyBmdW5jdGlvbiBoYXZlIHRoZSBzYW1lIGhhc2g/DQpTbyB0aGUgY29tcGls
ZXIgd291bGQgbmVlZCBhIGZ1bmN0aW9uIGF0dHJpYnV0ZSB0byBzZWVkIHRoZSBoYXNoLg0KDQpX
aXRoIHRoYXQgeW91IG1pZ2h0IGJlIGFibGUgdG8gcmVtb3ZlIGFsbCB0aGUgY29kZSBwYXRocyB0
aGF0IGFjdHVhbGx5DQp1c2UgYSBsb3Qgb2Ygc3RhY2sgLSBpbnN0ZWFkIG9mIGp1c3QgZ3Vlc3Np
bmcgYW5kIGxpbWl0aW5nIGluZGl2aWR1YWwNCnN0YWNrIGZyYW1lcy4NCg0KTXkgJ2d1dCBmZWVs
JyBmcm9tIGNhbGN1bGF0aW5nIHRoZSBzdGFjayB1c2UgdGhhdCB3YXkgZm9yIGFuIGVtYmVkZGVk
DQpzeXN0ZW0gYmFjayBpbiB0aGUgZWFybHkgMTk4MHMgaXMgdGhhdCB0aGUgbWF4IHVzZSB3aWxs
IGJlIGluc2lkZQ0KcHJpbnRrKCkgaW5zaWRlIGFuIG9ic2N1cmUgZXJyb3IgcGF0aCBhbmQgaWYg
eW91IGFjdHVhbGx5IGhpdCBpdA0KdGhpbmdzIHdpbGwgZXhwbG9kZS4NCihXZSBkaWRuJ3QgaGF2
ZSBlbm91Z2ggbWVtb3J5IHRvIGFsbG9jYXRlIGJpZyBlbm91Z2ggc3RhY2tzISkNCg0KCURhdmlk
DQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBG
YXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2
IChXYWxlcykNCg==


