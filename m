Return-Path: <linux-kernel+bounces-138149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D25C589ED52
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CC88B21302
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4BF13D535;
	Wed, 10 Apr 2024 08:12:29 +0000 (UTC)
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEC213D529
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 08:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712736749; cv=none; b=DBakl4BRUWNiUQ0bbOoQfLPI7NF9lsBh0i4B5kwhDqwVlkCq/SU/mP+fIee4oFpDVB8yyiB64Jha9jIW6g5sUjvcF/YpYY4Nao+oRflZR4clV9PdlKMie/g5zTcgT4v5hTSxVnZOOSPeBTgbUKq6zCFV9wXBbVwmi6BmEvyYlew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712736749; c=relaxed/simple;
	bh=jUl7NdspJnPzcxAq4yP4b6rVXJDYu/DJPXI19kcZ8Ek=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=qzumvM9F1RIu6pObO7s4ipOlWxcuzb6667mtkSeUeiwkBNvjpy7+60iG5f5OSEhWCIR7WOjo+2JEjrhlNucJWAhpxIKrSAzXwOwqFNomHM0zBrDybrNn+/8xSuiJHKoTwo+l4tw3CpNxOql+VoVzcDoq5HfQ1PuuP2hoDwq7A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-107-GtXNn_s8PJOtOBg1m9tY-w-1; Wed, 10 Apr 2024 09:12:18 +0100
X-MC-Unique: GtXNn_s8PJOtOBg1m9tY-w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 10 Apr
 2024 09:11:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 10 Apr 2024 09:11:52 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Linus Torvalds' <torvalds@linux-foundation.org>, Peter Zijlstra
	<peterz@infradead.org>
CC: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Peter Anvin <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>,
	"Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: More annoying code generation by clang
Thread-Topic: More annoying code generation by clang
Thread-Index: AQHaiezqJJWKEs8Cm02dt8s+rWFdD7FhJifw
Date: Wed, 10 Apr 2024 08:11:52 +0000
Message-ID: <d355ad8cbf3f4f00be4be76e38c47889@AcuMS.aculab.com>
References: <CAHk-=whHWjKK1TOMT1XvxFj8e-_uctJnXPxM=SyWHmW63B_EDw@mail.gmail.com>
 <20240408084934.GC21904@noisy.programming.kicks-ass.net>
 <CAHk-=witEwVvJ6Wh4xdP-sUkLQSwcRTtg_NSuGMMgvYmcs3teQ@mail.gmail.com>
 <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
In-Reply-To: <CAHk-=wg=Wdct5f9W2-tvwfRefv3xmw1-9Ko+RG+6=xjLu4ndFg@mail.gmail.com>
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

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMDggQXByaWwgMjAyNCAyMDo0Mw0KLi4uDQo+
IEkgdGhpbmsgaXQncyBtYWlubHkgc29tZSBvZiB0aGUgYml0b3AgY29kZSB0aGF0IHBlb3BsZSBo
YXZlIG5vdGljZWQNCj4gYmVmb3JlIC0gZmxzIGFuZCB2YXJpYWJsZV9mZnMoKSBhbmQgZnJpZW5k
cy4NCj4gDQo+IEkgc3VzcGVjdCBjbGFuZyBpcyBtb3JlIGNvbW1vbiBpbiB0aGUgYXJtNjQgd29y
bGQgdGhhbiBpdCBpcyBmb3INCj4geDg2LTY0IGtlcm5lbCBkZXZlbG9wZXJzLCBhbmQgYXJtNjQg
aW5saW5lIGFzbSBiYXNpY2FsbHkgbmV2ZXIgdXNlcw0KPiAicm0iIG9yICJnIiBzaW5jZSBhcm02
NCBkb2Vzbid0IGhhdmUgaW5zdHJ1Y3Rpb25zIHRoYXQgdGFrZSBlaXRoZXIgYQ0KPiByZWdpc3Rl
ciBvciBhIG1lbW9yeSBvcGVyYW5kLg0KPiANCj4gQW55d2F5LCB3aXRoIGdjYyB0aGlzIGdlbmVy
YXRlcw0KPiANCj4gICAgICAgICBjbXAgKCVyZHgpLCVlYng7IHNiYiAlcmF4LCVyYXggICMgXzct
Pm1heF9mZHMsIGZkLCBfX21hc2sNCj4gDQo+IElPVywgaXQgdXNlcyB0aGUgbWVtb3J5IGxvY2F0
aW9uIGZvciAibWF4X2ZkcyIuIEl0IGNvdWxkbid0IGRvIHRoYXQNCj4gYmVmb3JlLCBiZWNhdXNl
IGl0IHVzZWQgdG8gdGhpbmsgdGhhdCBpdCBhbHdheXMgaGFkIHRvIGRvIHRoZSBjb21wYXJlDQo+
IGluIDY0IGJpdHMsIGFuZCB0aGUgbWVtb3J5IGxvY2F0aW9uIGlzIG9ubHkgMzItYml0Lg0KPiAN
Cj4gV2l0aCBjbGFuZywgdGhpcyBnZW5lcmF0ZXMNCj4gDQo+ICAgICAgICAgbW92bCAgICAoJXJj
eCksICVlYXgNCj4gICAgICAgICBjbXBsICAgICVlYXgsICVlZGkNCj4gICAgICAgICBzYmJxICAg
ICVyZGksICVyZGkNCj4gDQo+IHdoaWNoIGhhcyB0aGF0IGV4dHJhIHJlZ2lzdGVyIHVzZSwgYnV0
IGlzIGF0IGxlYXN0IG11Y2ggYmV0dGVyIHRoYW4NCj4gd2hhdCBpdCB1c2VkIHRvIGdlbmVyYXRl
IHdpdGggY3JhenkgImxvYWQgaW50byByZWdpc3Rlciwgc3BpbGwgdG8NCj4gc3RhY2ssIHRoZW4g
Y29tcGFyZSBhZ2FpbnN0IHN0YWNrIGNvbnRlbnRzIi4NCg0KUHJvdmlkZWQgdGhlIGNvbXBpbGVy
IGNhbiBmaW5kIGEgcmVnaXN0ZXIgSSBkb3VidCB0aGUgZXh0cmENCmluc3RydWN0aW9uIG1ha2Vz
IG11Y2ggZGlmZmVyZW5jZS4NClRoZSAnY21wICglcmR4KSwlZWJ4KScgZW5kcyB1cCBiZWluZyAy
IHUtb3BzIHRoZSBzYW1lIGFzDQp0aGUgbW92bC9jbXBsIHBhaXIuDQpJbnN0cnVjdGlvbiBkZWNv
ZGUgYW5kIHJldGlyZW1lbnQgYXJlbid0IG9mdGVuIGJvdHRsZW5lY2tzIG9uIHJlY2VudCBjcHUu
DQpTbyBJIHN1c3BlY3QgdGhlIG1haW4gZGlmZmVyZW5jZSBpcyBjYWNoZSBmb290cHJpbnQuDQoN
ClRyeWluZyB0byBtZWFzdXJlIHRoZSBkaWZmZXJlbmNlIGlzIHByb2JhYmx5IGltcG9zc2libGUu
Li4NCg0KWW91J2xsIHByb2JhYmx5IGdldCBhIGJpZ2dlciBkaWZmZXJlbmNlIGJ5IGNoYW5naW5n
IGEgbG90IG9mDQpmdW5jdGlvbiByZXN1bHRzIGFuZCBwYXJhbWV0ZXJzIHRvICd1bnNpZ25lZCBs
b25nJyB0byByZW1vdmUNCmFsbCB0aGUgemVyby1leHRlbmRpbmcgdGhhdCBoYXBwZW5zLg0KDQoJ
RGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1v
dW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEz
OTczODYgKFdhbGVzKQ0K


