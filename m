Return-Path: <linux-kernel+bounces-116752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92FB588A355
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C436A1C38E4C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5CC5337A;
	Mon, 25 Mar 2024 10:37:07 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975F16E887
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 09:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.85.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711359060; cv=none; b=jdnbYfIPmOpcS/3kAnjf3MFnFH07e3cfaqYjSqlpZcqljNkfOkm8Be/avEDUHT1/gFe5zWuRXJYpODmmtUZpZKF0bz/exU6zsRmZ0xEL38nL0/dYkDmBNTYssBvsrOJStVYqlMjFAxiLLCszBtnBY5kTl30mrR0ryPnxJL5pu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711359060; c=relaxed/simple;
	bh=6MCJQoh3AEDiIGV9Lu8V8DTDxHy6tYRCy/3KwuPvlLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qr3CTa7jiOO+RkXp0SHgYitfoF6ZNKNEowGe2tkneRPVIwNUKPVh3lCvszejS/tfajMZh7Qa2a3NJ+etvgtRz4CgOAeLYcVSY2S5LcqWeKpXNLQPzL3tv0iQ2A5R6YOTaLziCMVdCp7wfUAyWWAHJ94g+sLzDr1WHvzcfJh1c5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.85.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-198-vdeQgxrwP92fV7WlkXqR2A-1; Mon, 25 Mar 2024 09:30:56 +0000
X-MC-Unique: vdeQgxrwP92fV7WlkXqR2A-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Mon, 25 Mar
 2024 09:30:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Mon, 25 Mar 2024 09:30:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Alexandre Ghiti' <alex@ghiti.fr>, Samuel Holland
	<samuel.holland@sifive.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Albert Ou <aou@eecs.berkeley.edu>, "Andrew
 Morton" <akpm@linux-foundation.org>, Charlie Jenkins <charlie@rivosinc.com>,
	Guo Ren <guoren@kernel.org>, Jisheng Zhang <jszhang@kernel.org>, Kemeng Shi
	<shikemeng@huaweicloud.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Xiao Wang <xiao.w.wang@intel.com>, Yangyu Chen
	<cyy@cyyself.name>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Topic: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Thread-Index: AQHaeh3F9DUQSIkEB0u5Xt52XMTyX7FHT0cAgADJJoCAAB400A==
Date: Mon, 25 Mar 2024 09:30:23 +0000
Message-ID: <5c027cbf6b8741e4a8147963b07a8ac4@AcuMS.aculab.com>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <f786e02245424e02b38f55ae6b29d14a@AcuMS.aculab.com>
 <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
In-Reply-To: <d323eb10-c79b-49cb-94db-9b135e6fd280@ghiti.fr>
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

RnJvbTogQWxleGFuZHJlIEdoaXRpDQo+IFNlbnQ6IDI1IE1hcmNoIDIwMjQgMDc6MzENCj4gDQo+
IEhpIERhdmlkLA0KPiANCj4gT24gMjQvMDMvMjAyNCAyMDo0MiwgRGF2aWQgTGFpZ2h0IHdyb3Rl
Og0KPiA+IC4uLg0KPiA+PiBUaGUgdXNlIG9mIGFsdGVybmF0aXZlcyBhbGxvd3MgdG8gcmV0dXJu
IHJpZ2h0IGF3YXkgaWYgdGhlIGJ1ZmZlciBpcw0KPiA+PiBiZXlvbmQgdGhlIHVzYWJsZSB1c2Vy
IGFkZHJlc3Mgc3BhY2UsIGFuZCBpdCdzIG5vdCBqdXN0ICJzbGlnaHRseQ0KPiA+PiBmYXN0ZXIi
IGZvciBzb21lIGNhc2VzIChhIHZlcnkgbGFyZ2UgYnVmZmVyIHdpdGggb25seSBhIGZldyBieXRl
cyBiZWluZw0KPiA+PiBiZXlvbmQgdGhlIGxpbWl0IG9yIHNvbWVvbmUgY291bGQgZmF1bHQtaW4g
YWxsIHRoZSB1c2VyIHBhZ2VzIGFuZCBmYWlsDQo+ID4+IHZlcnkgbGF0ZS4uLmV0YykuIGFjY2Vz
c19vaygpIGlzIGhlcmUgdG8gZ3VhcmFudGVlIHRoYXQgc3VjaCBzaXR1YXRpb25zDQo+ID4+IGRv
bid0IGhhcHBlbiwgc28gYWN0dWFsbHkgaXQgbWFrZXMgbW9yZSBzZW5zZSB0byB1c2UgYW4gYWx0
ZXJuYXRpdmUgdG8NCj4gPj4gYXZvaWQgdGhhdC4NCj4gPg0KPiA+IElzIGl0IHJlYWxseSB3b3J0
aCBkb2luZyBBTlkgb3B0aW1pc2F0aW9ucyBmb3IgdGhlIC1FRkFVTFQgcGF0aD8NCj4gPiBUaGV5
IHJlYWxseSBkb24ndCBoYXBwZW4uDQo+ID4NCj4gPiBUaGUgb25seSBmYXVsdCBwYXRoIHRoYXQg
bWF0dGVycyBpcyB0aGUgb25lIHRoYXQgaGFzIHRvIHBhZ2UgaW4NCj4gPiBkYXRhIGZyb20gc29t
ZXdoZXJlLg0KPiANCj4gDQo+IFdoaWNoIGlzIGNvbXBsZXRlbHkgYXZvaWRlZCB3aXRoIGEgc3Ry
aWN0IGRlZmluaXRpb24gb2YgYWNjZXNzX29rKCkuIEkNCj4gc2VlIGFjY2Vzc19vaygpIGFzIGFu
IGFscmVhZHkgZXhpc3Rpbmcgb3B0aW1pemF0aW9uIG9mIGZhdWx0IHBhdGhzIGJ5DQo+IGF2b2lk
aW5nIHRoZW0gZW50aXJlbHkgd2hlbiB0aGV5IGFyZSBib3VuZCB0byBoYXBwZW4uDQoNCk5vLCBh
Y2Nlc3Nfb2soKSBleGlzdHMgYmVjYXVzZSBhY2Nlc3NlcyB0byBrZXJuZWwgYWRkcmVzc2VzIGRv
bid0IGZhdWx0Lg0KUG9zc2libHkgaW4gbGludXggMC4wMSBpdCB0cmllZCB0byBlbnN1cmUgdGhh
dCB0aGUgYWNjZXNzIHdhcyB2YWxpZA0KKGJ5IGNoZWNraW5nIHRoZSBwcm9jZXNzJ3MgcGFnZSB0
YWJsZXMgKGV0YykgYnV0IHRoYXQgdGhhdCBoYXNuJ3QgYmVlbg0KdHJ1ZSBmb3IgYSBsb25nIHRp
bWUuDQoNCllvdSBkb24ndCB3YW50IHRvIGFkZCBhIHNpbmdsZSBpbnN0cnVjdGlvbiAobmV2ZXIg
bWluZCBhIGNvbmRpdGlvbmFsKQ0KdG8gYWNjZXNzX29rKCkgdG8gYXZvaWQgYSBwYWdlIGZhdWx0
IG9uIGFuIGFkZHJlc3MgdGhhdCB3aWxsIGZhdWx0Lg0KDQpCYXNpY2FsbHkgcmVhbCBwcm9ncmFt
cyBkb24ndCBwYXNzIGJhZCBhZGRyZXNzZXMgaW50byB0aGUga2VybmVsDQpvciBhY2Nlc3MgdGhl
bSBpbiB1c2Vyc3BhY2UuIEVGQVVMVCBhbmQgU0lHU0VHViBhcmUgcHJldHR5IGZhdGFsLg0KKE5v
dGhpbmcgY2FsbCBzYnJrKCkgZnJvbSBpdHMgU0lHU0VHViBoYW5kbGVyIGFueSBtb3JlISkNCg0K
CURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBN
b3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAx
Mzk3Mzg2IChXYWxlcykNCg==


