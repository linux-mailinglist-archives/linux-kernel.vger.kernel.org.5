Return-Path: <linux-kernel+bounces-105506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8976787DF74
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B69201C20996
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5329C1DA4C;
	Sun, 17 Mar 2024 19:00:12 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27C41DA20
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 19:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702011; cv=none; b=fbatPGSxfpP7X4MQ8uJWqBLXrdrOC7p2jj66AGpg45L+bWYk6DNPXg5g/xkJZTvIakPtblLLG5rTzfb1tp8KYhJ0DKlYVV4CCDPoYZ5io85zdlThILSsrZtxhaZGcBl3bn2aqH0YgS1PULaKQwnmIHXB+El7lAci6tdBr1JlPEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702011; c=relaxed/simple;
	bh=d8OJUYJVjE8pECyfQAlAmrTYXSbm1x7ebV4fNoLwkiQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=KUdnCFGcsUArEzMQ0Jy98gzb38dw5dP96mzpw4bEN5xRHSGt1MT6bE03U4yhc0beqUgCyxcuHG2KE8Ms35QuqRJFamSS1FYypdmna3Vh6vuHgRKLn71JVSLtoWBjc31OuGAh6Z194zRnzQLySLSiEUOeZf6hLwp3sIKH2/6CPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-252-VCyhCZN_Ms2dVYaZoH2Szg-1; Sun, 17 Mar 2024 18:58:10 +0000
X-MC-Unique: VCyhCZN_Ms2dVYaZoH2Szg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 17 Mar
 2024 18:57:51 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 17 Mar 2024 18:57:51 +0000
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
Thread-Index: AQHad9a+Y5/0t6VtDk+hhnG+kSJKOLE8RdQA
Date: Sun, 17 Mar 2024 18:57:51 +0000
Message-ID: <bb203717ab644362a8eafe78aff23947@AcuMS.aculab.com>
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

RnJvbTogUGFzaGEgVGF0YXNoaW4NCj4gU2VudDogMTYgTWFyY2ggMjAyNCAxOToxOA0KLi4uDQo+
IEV4cGFuZGluZyBvbiBNYXRoZXcncyBpZGVhIG9mIGFuIGludGVyZmFjZSBmb3IgZHluYW1pYyBr
ZXJuZWwgc3RhY2sNCj4gc2l6ZXMsIGhlcmUncyB3aGF0IEknbSB0aGlua2luZzoNCj4gDQo+IC0g
S2VybmVsIFRocmVhZHM6IENyZWF0ZSBhbGwga2VybmVsIHRocmVhZHMgd2l0aCBhIGZ1bGx5IHBv
cHVsYXRlZA0KPiBUSFJFQURfU0laRSBzdGFjay4gIChpLmUuIDE2SykNCj4gLSBVc2VyIFRocmVh
ZHM6IENyZWF0ZSBhbGwgdXNlciB0aHJlYWRzIHdpdGggVEhSRUFEX1NJWkUga2VybmVsIHN0YWNr
DQo+IGJ1dCBvbmx5IHRoZSB0b3AgcGFnZSBtYXBwZWQuIChpLmUuIDRLKQ0KPiAtIEluIGVudGVy
X2Zyb21fdXNlcl9tb2RlKCk6IEV4cGFuZCB0aGUgdGhyZWFkIHN0YWNrIHRvIDE2SyBieSBtYXBw
aW5nDQo+IHRocmVlIGFkZGl0aW9uYWwgcGFnZXMgZnJvbSB0aGUgcGVyLUNQVSBzdGFjayBjYWNo
ZS4gVGhpcyBmdW5jdGlvbiBpcw0KPiBjYWxsZWQgZWFybHkgaW4ga2VybmVsIGVudHJ5IHBvaW50
cy4NCj4gLSBleGl0X3RvX3VzZXJfbW9kZSgpOiBVbm1hcCB0aGUgZXh0cmEgdGhyZWUgcGFnZXMg
YW5kIHJldHVybiB0aGVtIHRvDQo+IHRoZSBwZXItQ1BVIGNhY2hlLiBUaGlzIGZ1bmN0aW9uIGlz
IGNhbGxlZCBsYXRlIGluIHRoZSBrZXJuZWwgZXhpdA0KPiBwYXRoLg0KDQpJc24ndCB0aGF0IGVu
dGlyZWx5IGhvcnJpZCBmb3IgVExCIHVzZSBhbmQgc28gd2lsbCByZXF1aXJlIGEgbG90IG9mIElQ
ST8NCg0KUmVtZW1iZXIsIGlmIGEgdGhyZWFkIHNsZWVwcyBpbiAnZXh0cmEgc3RhY2snIGFuZCBp
cyB0aGVuIHJlc2hlZHVsZWQNCm9uIGEgZGlmZmVyZW50IGNwdSB0aGUgZXh0cmEgcGFnZXMgZ2V0
ICdwdW1wZWQnIGZyb20gb25lIGNwdSB0bw0KYW5vdGhlci4NCg0KSSBhbHNvIHN1c3BlY3QgYSBz
dGFja19wcm9iZSgpIGlzIGxpa2VseSB0byBlbmQgdXAgYmVpbmcgYSBjYWNoZSBtaXNzDQphbmQg
YWxzbyBzbG93Pz8/DQpTbyB5b3Ugd291bGRuJ3Qgd2FudCBvbmUgb24gYWxsIGNhbGxzLg0KSSdt
IG5vdCBzdXJlIHlvdSdkIHdhbnQgYSBjb25kaXRpb25hbCBicmFuY2ggZWl0aGVyLg0KDQpUaGUg
ZXhwbGljaXQgcmVxdWVzdCBmb3IgJ21vcmUgc3RhY2snIGNhbiBiZSByZXF1aXJlZCB0byBiZSBh
bGxvd2VkDQp0byBzbGVlcCAtIHJlbW92aW5nIGEgbG90IG9mIGlzc3Vlcy4NCkl0IHdvdWxkIGFs
c28gYmUgcG9ydGFibGUgdG8gYWxsIGFyY2hpdGVjdHVyZXMuDQpJJ2QgYWxzbyBzdXNwZWN0IHRo
YXQgYW55IHRocmVhZCB0aGF0IG5lZWRzIGV4dHJhIHN0YWNrIGlzIGxpa2VseQ0KdG8gbmVlZCB0
byBhZ2Fpbi4NClNvIHdoaWxlIHRoZSBtZW1vcnkgY291bGQgYmUgcmVjb3ZlcmVkLCBJJ2QgYmV0
IGlzIGlzbid0IHdvcnRoDQpkb2luZyBleGNlcHQgdW5kZXIgbWVtb3J5IHByZXNzdXJlLg0KVGhl
IGNhbGwgY291bGQgYWxzbyByZXR1cm4gJ25vJyAtIHBlcmhhcHMgdXNlZnVsIGZvciAoYnJva2Vu
KSBjb2RlDQp0aGF0IGluc2lzdHMgb24gYmVpbmcgcmVjdXJzaXZlLg0KDQoJRGF2aWQNCg0KLQ0K
UmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1p
bHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVz
KQ0K


