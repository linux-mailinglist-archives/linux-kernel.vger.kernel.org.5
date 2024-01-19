Return-Path: <linux-kernel+bounces-30942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275B783265C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 10:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFDC1C2308B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C3F24B57;
	Fri, 19 Jan 2024 09:14:43 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE32B1D690
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 09:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705655683; cv=none; b=O7NxUtIFKmMmlLkgqjeqJC0TEeeIRfmIRn4XZXM4Zul+W7llw+mPVCfe14Xxag8vSobjOc1a1+yeGnA7C8dsjrCj/wYdtHFdNlhdMUgruRTS4QreOkZKEj++tCv5dILXOFOJ2HKqSiYq0y1eJ2lf3Eodq5LuHC7774o989vGFS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705655683; c=relaxed/simple;
	bh=J51B7dgcwpPBLX98Aj0mu1Uqkrp2X/ral2zBAKpdgmw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=hKl/3OIFyMYORSoJnF3ACiOrGQrzVPo0tkGfzWfIaZlCjVLi6JBtOBRLr5RJvK7Xb5UPZFq5p/3khmIGorucn2PSyMwWI6cjzfmEUJP3CsLNLkw2M3K/fsJ+Ciz2Tn+Tz3B6TwyueOVWRtUR82BhFnz7VBQy5V3yM6SkKQenORg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-323-jRim0v_hOfeEj-x0fPXa7Q-1; Fri, 19 Jan 2024 09:14:32 +0000
X-MC-Unique: jRim0v_hOfeEj-x0fPXa7Q-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Fri, 19 Jan
 2024 09:14:15 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Fri, 19 Jan 2024 09:14:15 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Jiri Slaby' <jirislaby@kernel.org>, Linus Torvalds
	<torvalds@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Andy
 Shevchenko" <andriy.shevchenko@linux.intel.com>, Andrew Morton
	<akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>, "Jason A. Donenfeld"
	<Jason@zx2c4.com>, linux-media <linux-media@vger.kernel.org>, Hans Verkuil
	<hverkuil@xs4all.nl>
Subject: RE: [PATCH next v4 0/5] minmax: Relax type checks in min() and max().
Thread-Topic: [PATCH next v4 0/5] minmax: Relax type checks in min() and
 max().
Thread-Index: AdnqB/CwAvMQ3gkdSO607JUF4aSKdhgnyQvbAAPuGSA=
Date: Fri, 19 Jan 2024 09:14:15 +0000
Message-ID: <27f7643d1e64430ab7e265565e87d88e@AcuMS.aculab.com>
References: <b97faef60ad24922b530241c5d7c933c@AcuMS.aculab.com>
 <18c6df0d-45ed-450c-9eda-95160a2bbb8e@gmail.com>
 <CAHk-=wjvM5KiQFpbPMPXH-DcvheNcPGj+ThNEJVm+QL6n05A8A@mail.gmail.com>
 <650bdb23-0875-4e19-9e3e-82337da6da00@kernel.org>
In-Reply-To: <650bdb23-0875-4e19-9e3e-82337da6da00@kernel.org>
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

RnJvbTogSmlyaSBTbGFieQ0KPiBTZW50OiAxOSBKYW51YXJ5IDIwMjQgMDc6MTQNCj4gDQo+IE9u
IDA4LiAwMS4gMjQsIDE5OjE5LCBMaW51cyBUb3J2YWxkcyB3cm90ZToNCj4gPiBPbiBNb24sIDgg
SmFuIDIwMjQgYXQgMDM6NDYsIEppcmkgU2xhYnkgPGppcmlzbGFieUBnbWFpbC5jb20+IHdyb3Rl
Og0KPiA+Pg0KPiA+PiAgICAgQ1BQIFtNXSBkcml2ZXJzL21lZGlhL3BjaS9zb2xvNngxMC9zb2xv
NngxMC1wMm0uaQ0KPiA+PiByZWFsICAgIDBtNDUsMDAycw0KPiA+Pg0KPiA+PiAkIGdpdCByZXZl
cnQgODY3MDQ2Y2M3MDI3NzAzZjYwYTQ2MzM5ZmZkZTkxYTE5NzBmMjkwMQ0KPiA+PiAgICAgQ1BQ
IFtNXSBkcml2ZXJzL21lZGlhL3BjaS9zb2xvNngxMC9zb2xvNngxMC1wMm0uaQ0KPiA+PiByZWFs
ICAgIDBtMTEsMTMycw0KPiA+Pg0KPiA+PiAkIGdpdCByZXZlcnQgNGVhZDUzNGZiYTQyZmM0ZmQ0
MTE2MzI5NzUyOGQyYWE3MzFjZDEyMQ0KPiA+PiAgICAgQ1BQIFtNXSBkcml2ZXJzL21lZGlhL3Bj
aS9zb2xvNngxMC9zb2xvNngxMC1wMm0uaQ0KPiA+PiByZWFsICAgIDBtMyw3MTFzDQo+ID4NCj4g
PiBPdWNoLiBZZWFoLCB0aGF0J3MgdW5mb3J0dW5hdGUuIFRoZXJlJ3MgYSBsb3Qgb2YgbmVzdGVk
IG5hc3R5IG1hY3JvDQo+ID4gZXhwYW5zaW9uIHRoZXJlLCBidXQgdGhhdCB0aW1pbmcgaXMgZXhj
ZXNzaXZlLg0KDQpBcyBhIG1hdHRlciBvZiBpbnRlcmVzdCB3aGF0IGFyZSB5b3UgY29tcGlsaW5n
IG9uPw0KSSd2ZSBzaW5jZSB0ZXN0IGNvbXBpbGVkIHRoYXQgZmlsZSBhbmQgZG9uJ3QgZXZlbiBz
ZWUgYSBwYXVzZQ0KaW4gdGhlIG1ha2VmaWxlIG91dHB1dCAtIHNvIHdlbGwgdW5kZXIgYSBzZWNv
bmQgdG8gY29tcGlsZS4NCg0KLi4uDQo+ID4gVGhhdCBzYWlkLCBJJ20gc3VyZSB0aGlzIHRoaW5n
IGV4aXN0cyB0byBhIHNtYWxsZXIgZGVncmVlIGVsc2V3aGVyZS4gSQ0KPiA+IHdvbmRlciBpZiB3
ZSBjb3VsZCBzaW1wbGlmeSBvdXIgbWluL21heCB0eXBlIHRlc3RzLg0KPiBJIGFzc3VtZSB3ZSBk
b24ndCBjYXJlIHdpdGggc29sbyBmaXhlZD8gSGFucyBwb2ludGVkIG91dCBhdGgxMWsgdG9vLg0K
PiBFdmVuIGlmIHRoZXJlIGlzIHNpemUgaW5jcmVhc2UgaW4gdGhlIHByZXByb2MgZmlsZSwgSSBk
b24ndCBzZWUgbXVjaCBvZg0KPiBjb21waWxlIHRpbWUgaW5jcmVhc2UgdGhlcmUuDQoNCkkgaGF2
ZSBnb3QgYSBmZXcgcGF0Y2hlcyB0aGF0IHJlZHVjZSB0aGUgY3BwIG91dHB1dCBzaXplLg0KSSds
bCBwb3N0IHRoZW0gYWZ0ZXIgLXJjMSBpcyBvdXQuDQoNCkxpbnVzIG1pZ2h0IG5lZWQgdG8gdGFr
ZSB0aGVtIGRpcmVjdGx5IHNpbmNlIEkndmUgYWRkZWQgbWluX2NvbnN0KCkNCmFuZCByZW1vdmVk
IHRoZSBsb2dpYyB0aGF0IGdlbmVyYXRlcyAnY29uc3QgZnJvbSBjb25zdCcuDQpUaGF0IHJlcXVp
cmVzIGEgdHJpdmlhbCBjaGFuZ2UgdG8gdGhlIDggZmlsZXMgKEkndmUgZm91bmQpIHRoYXQNCnVz
ZSBtaW4vbWF4IGZvciBzaXppbmcgb24tc3RhY2sgYXJyYXlzIGJldHdlZW4gdHdvIHBhdGNoZXMu
DQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9h
ZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBO
bzogMTM5NzM4NiAoV2FsZXMpDQo=


