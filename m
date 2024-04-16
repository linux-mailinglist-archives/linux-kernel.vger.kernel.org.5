Return-Path: <linux-kernel+bounces-147454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8498A746D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:14:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157051F22DDB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9174D137C23;
	Tue, 16 Apr 2024 19:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Xhwo7TmB"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489C0137915;
	Tue, 16 Apr 2024 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713294873; cv=none; b=Sh44W3YeSzeSzDOmbLWO3u5A5HIbTRRvF9Uyf61o0zgpIFaZ8qq3ARBN5RcUjvSk4peEIWMt0omy+azva9w9UVnsNAKmXb3TkHidb6arJ2L4S6HujJbOF/Y+j+04q/aXBRPedH7lcD8IdS1zOdFgoEvuhN3IimyVi9GQQ5PbKD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713294873; c=relaxed/simple;
	bh=1nkP3jzirDPuZivulqvFVuWDtWufC3zC80rCDpDu/40=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZO/5jeeCpFtHEuVmORuDJf+4f9O0WVLG6WYq6IAmsX6hwSuXmqwVZ3cce72/jJCoCkaoTUXYxJLPEDa1OtF3RjwbLugD0wG9955rDc9WAAkiMkxCskaZg/gXB6swK+WbCicsaN0t1SNsWsBT1jH2Iy1xlLi76bAtWowvGlG3uSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Xhwo7TmB; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713294873; x=1744830873;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=1nkP3jzirDPuZivulqvFVuWDtWufC3zC80rCDpDu/40=;
  b=Xhwo7TmBgoBqYe5V5YPPjUWZVs/Y4CvYLMZWHVG3U/c1LS4k/mx8eElC
   g9VbmRsZL6tXDhGUhzRqltu6fJ2pEXjkc3T/KC588cIWKbCLgK0T57E3g
   C5yWeAi3p0Tjpr1UGuGxKfB1WqrN1hplbbBIgRTS72C9OpRcVGdNLi8uc
   0=;
X-IronPort-AV: E=Sophos;i="6.07,206,1708387200"; 
   d="scan'208";a="648147521"
Subject: Re: [PATCH v2 2/2] crypto: aead, cipher - zeroize key buffer after use
Thread-Topic: [PATCH v2 2/2] crypto: aead, cipher - zeroize key buffer after use
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 19:14:30 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:3725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.230:2525] with esmtp (Farcaster)
 id b938786c-ce13-4085-bd4b-0b91c454d9f1; Tue, 16 Apr 2024 19:14:28 +0000 (UTC)
X-Farcaster-Flow-ID: b938786c-ce13-4085-bd4b-0b91c454d9f1
Received: from EX19D046UWB002.ant.amazon.com (10.13.139.181) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 19:14:28 +0000
Received: from EX19D046UWB002.ant.amazon.com (10.13.139.181) by
 EX19D046UWB002.ant.amazon.com (10.13.139.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 19:14:28 +0000
Received: from EX19D046UWB002.ant.amazon.com ([fe80::e2af:1ce5:cdf0:ef59]) by
 EX19D046UWB002.ant.amazon.com ([fe80::e2af:1ce5:cdf0:ef59%5]) with mapi id
 15.02.1258.028; Tue, 16 Apr 2024 19:14:28 +0000
From: "Mothershead, Hailey" <hailmo@amazon.com>
To: Eric Biggers <ebiggers@kernel.org>
CC: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
	"davem@davemloft.net" <davem@davemloft.net>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Thread-Index: AQHaj4dVfqxBh2c63kW0MktdVQuTXbFq0DMA
Date: Tue, 16 Apr 2024 19:14:28 +0000
Message-ID: <45EEAC43-DC21-4B79-BE9A-9876A8C59269@amazon.com>
References: <20240415221915.20701-1-hailmo@amazon.com>
 <20240415224942.GC5206@sol.localdomain>
In-Reply-To: <20240415224942.GC5206@sol.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <25E6FC61F029FA42A4F6C624E89FAAEA@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBPbiA0LzE1LzI0LCAzOjUwIFBNLCAiRXJpYyBCaWdnZXJzIiA8ZWJpZ2dlcnNAa2VybmVsLm9y
ZyA8bWFpbHRvOmViaWdnZXJzQGtlcm5lbC5vcmc+PiB3cm90ZToNCj4NCj4gT24gTW9uLCBBcHIg
MTUsIDIwMjQgYXQgMTA6MTk6MTVQTSArMDAwMCwgSGFpbGV5IE1vdGhlcnNoZWFkIHdyb3RlOg0K
PiA+IEkuRyA5LjcuQiBmb3IgRklQUyAxNDAtMyBzcGVjaWZpZXMgdGhhdCB2YXJpYWJsZXMgdGVt
cG9yYXJpbHkgaG9sZGluZw0KPiA+IGNyeXB0b2dyYXBoaWMgaW5mb3JtYXRpb24gc2hvdWxkIGJl
IHplcm9pemVkIG9uY2UgdGhleSBhcmUgbm8gbG9uZ2VyDQo+ID4gbmVlZGVkLiBBY2NvbXBsaXNo
IHRoaXMgYnkgdXNpbmcga2ZyZWVfc2Vuc2l0aXZlIGZvciBidWZmZXJzIHRoYXQNCj4gPiBwcmV2
aW91c2x5IGhlbGQgdGhlIHByaXZhdGUga2V5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSGFp
bGV5IE1vdGhlcnNoZWFkIDxoYWlsbW9AYW1hem9uLmNvbSA8bWFpbHRvOmhhaWxtb0BhbWF6b24u
Y29tPj4NCj4gPiAtLS0NCj4gPiBjcnlwdG8vYWVhZC5jIHwgMyArLS0NCj4gPiBjcnlwdG8vY2lw
aGVyLmMgfCAzICstLQ0KPiA+IDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2NyeXB0by9hZWFkLmMgYi9jcnlwdG8v
YWVhZC5jDQo+ID4gaW5kZXggMTY5OTEwOTUyNzBkLi5jNGVjZTg2YzQ1YmMgMTAwNjQ0DQo+ID4g
LS0tIGEvY3J5cHRvL2FlYWQuYw0KPiA+ICsrKyBiL2NyeXB0by9hZWFkLmMNCj4gPiBAQCAtMzUs
OCArMzUsNyBAQCBzdGF0aWMgaW50IHNldGtleV91bmFsaWduZWQoc3RydWN0IGNyeXB0b19hZWFk
ICp0Zm0sIGNvbnN0IHU4ICprZXksDQo+ID4gYWxpZ25idWZmZXIgPSAodTggKilBTElHTigodW5z
aWduZWQgbG9uZylidWZmZXIsIGFsaWdubWFzayArIDEpOw0KPiA+IG1lbWNweShhbGlnbmJ1ZmZl
ciwga2V5LCBrZXlsZW4pOw0KPiA+IHJldCA9IGNyeXB0b19hZWFkX2FsZyh0Zm0pLT5zZXRrZXko
dGZtLCBhbGlnbmJ1ZmZlciwga2V5bGVuKTsNCj4gPiAtIG1lbXNldChhbGlnbmJ1ZmZlciwgMCwg
a2V5bGVuKTsNCj4gPiAtIGtmcmVlKGJ1ZmZlcik7DQo+ID4gKyBrZnJlZV9zZW5zaXRpdmUoYnVm
ZmVyKTsNCj4gPiByZXR1cm4gcmV0Ow0KPiA+IH0NCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9jcnlw
dG8vY2lwaGVyLmMgYi9jcnlwdG8vY2lwaGVyLmMNCj4gPiBpbmRleCBiNDcxNDFlZDRhOWYuLjM5
NWYwYzJmYmI5ZiAxMDA2NDQNCj4gPiAtLS0gYS9jcnlwdG8vY2lwaGVyLmMNCj4gPiArKysgYi9j
cnlwdG8vY2lwaGVyLmMNCj4gPiBAQCAtMzQsOCArMzQsNyBAQCBzdGF0aWMgaW50IHNldGtleV91
bmFsaWduZWQoc3RydWN0IGNyeXB0b19jaXBoZXIgKnRmbSwgY29uc3QgdTggKmtleSwNCj4gPiBh
bGlnbmJ1ZmZlciA9ICh1OCAqKUFMSUdOKCh1bnNpZ25lZCBsb25nKWJ1ZmZlciwgYWxpZ25tYXNr
ICsgMSk7DQo+ID4gbWVtY3B5KGFsaWduYnVmZmVyLCBrZXksIGtleWxlbik7DQo+ID4gcmV0ID0g
Y2lhLT5jaWFfc2V0a2V5KGNyeXB0b19jaXBoZXJfdGZtKHRmbSksIGFsaWduYnVmZmVyLCBrZXls
ZW4pOw0KPiA+IC0gbWVtc2V0KGFsaWduYnVmZmVyLCAwLCBrZXlsZW4pOw0KPiA+IC0ga2ZyZWUo
YnVmZmVyKTsNCj4gPiArIGtmcmVlX3NlbnNpdGl2ZShidWZmZXIpOw0KPiA+IHJldHVybiByZXQ7
DQo+DQo+DQo+IFdlbGwsIHRoZSBtZW1zZXQoKXMgdGhhdCB5b3UncmUgcmVtb3ZpbmcgYWxyZWFk
eSBkaWQgdGhlIHplcm9pemF0aW9uLiBUaGlzDQo+IHBhdGNoIHNlZW1zIHdvcnRod2hpbGUgYXMg
YSBjb2RlIHNpbXBsaWZpY2F0aW9uLCBidXQgcGxlYXNlIGRvbid0IGNoYXJhY3Rlcml6ZQ0KPiBp
dCBhcyBhIGJ1ZyBmaXgsIGJlY2F1c2UgaXQncyBub3QuDQo+DQo+DQo+IC0gRXJpYw0KDQprZnJl
ZV9zZW5zaXRpdmUgdXNlcyBtZW16ZXJvX2V4cGxpY2l0KCkgaW5zdGVhZCBvZiB0aGUgbWVtc2V0
KClzIHVzZWQNCmFib3ZlLiBUaGUgbWVtemVyb19leHBsaWNpdCBoZWFkZXIgc3RhdGVzIC0NCg0K
KiBOb3RlOiB1c3VhbGx5IHVzaW5nIG1lbXNldCgpIGlzIGp1c3QgZmluZSAoISksIGJ1dCBpbiBj
YXNlcw0KKiB3aGVyZSBjbGVhcmluZyBvdXQgX2xvY2FsXyBkYXRhIGF0IHRoZSBlbmQgb2YgYSBz
Y29wZSBpcw0KKiBuZWNlc3NhcnksIG1lbXplcm9fZXhwbGljaXQoKSBzaG91bGQgYmUgdXNlZCBp
bnN0ZWFkIGluDQoqIG9yZGVyIHRvIHByZXZlbnQgdGhlIGNvbXBpbGVyIGZyb20gb3B0aW1pc2lu
ZyBhd2F5IHplcm9pbmcuDQoNCkl0IGFjY29tcGxpc2hlcyB0aGlzIGJ5IGNhbGxpbmcgbWVtc2V0
KCkgYW5kIHRoZW4gYWRkaW5nIGEgYmFycmllci4gU2luY2UNCkZJUFMgcmVxdWlyZXMgdGhpcyBk
YXRhIGJlIHplcm9lZCBvdXQsIGFuZCB0aGUgY3VycmVudCBtZW1zZXQoKSBhbmQNCmtmcmVlKCkg
ZG9uJ3QgZ3VhcmFudGVlIHRoaXMsIEkgZG8gbm90IHRoaW5rIHRoZSBjb21taXQgbWVzc2FnZSBp
cw0KbWlzbGVhZGluZy4gSSBjYW4gY2xhcmlmeSB0aGUgbWVzc2FnZSB3aXRoIHRoZSBhYm92ZSBp
bmZvcm1hdGlvbiBpZiB0aGF0DQppcyBwcmVmZXJyZWQuDQoNCg==

