Return-Path: <linux-kernel+bounces-127308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1C1894978
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B66E91F2426F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE4861171A;
	Tue,  2 Apr 2024 02:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="h1uzAWgw"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A788A7E6;
	Tue,  2 Apr 2024 02:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025040; cv=none; b=Vdx6e9uxaSrPz6YJ27DJ1YUv2KWjNsoXqspR3cAWm/krsBkgC1Jm18zRQR8Uhbv7G4Zn3RNNQhMrJszX/lRDMps7qZNmrB7qEDOuO81z2GR303lom6tk4eAoMTmL/0gOyNrOIHdGify/9/TaN+4im6W62AYpoVNrdbjftbvDPaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025040; c=relaxed/simple;
	bh=PpSXo1QhcMevwm7I+K7iRFo96h88oIV/8+9o9/wUcnU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nV5gSzlyiCxLTPW78rXLDGTTNT09MgeiynIkgDCoAFnHBKvbCRnolYxdO26C7CUouGk3C2kVoyuO2vq9kTfcdy1w9C4xUJpSPXShFGSSw2jrdt+68VP41/MCOmxsZR3cLTEXU3qRs46jpUvsIkTPBKYbr7EkfrcP5d/6rfUQkSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=h1uzAWgw; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712025039; x=1743561039;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PpSXo1QhcMevwm7I+K7iRFo96h88oIV/8+9o9/wUcnU=;
  b=h1uzAWgwI7ITpOhT1CRD4wRPpUbXcgkHo67+ubu1QKQHgMiWTMjBtnxM
   Y2dOnwtdyoTycs2mj/ikSs+6sutqF/WoAlbuAEkBf3UoE+2YkD546Amca
   EI61fL54lysqTAWIxOqK6vzbhqMKrN/4/5cQizBPZXCX07906zIkheJ59
   M=;
X-IronPort-AV: E=Sophos;i="6.07,173,1708387200"; 
   d="scan'208";a="284455721"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 02:30:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:38275]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.56.234:2525] with esmtp (Farcaster)
 id b76e8157-aec4-494c-8c62-9b3ebbe5bb57; Tue, 2 Apr 2024 02:30:24 +0000 (UTC)
X-Farcaster-Flow-ID: b76e8157-aec4-494c-8c62-9b3ebbe5bb57
Received: from EX19D002UWA002.ant.amazon.com (10.13.138.246) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 02:30:24 +0000
Received: from EX19D001UWA003.ant.amazon.com (10.13.138.211) by
 EX19D002UWA002.ant.amazon.com (10.13.138.246) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 2 Apr 2024 02:30:24 +0000
Received: from EX19D001UWA003.ant.amazon.com ([fe80::256a:26de:3ee6:48a2]) by
 EX19D001UWA003.ant.amazon.com ([fe80::256a:26de:3ee6:48a2%7]) with mapi id
 15.02.1258.028; Tue, 2 Apr 2024 02:30:24 +0000
From: "Okanovic, Haris" <harisokn@amazon.com>
To: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-assembly@vger.kernel.org" <linux-assembly@vger.kernel.org>
CC: "peterz@infradead.org" <peterz@infradead.org>, "Saidi, Ali"
	<alisaidi@amazon.com>, "Blake, Geoff" <blakgeof@amazon.com>, "Silver, Brian"
	<silverbr@amazon.com>
Subject: Re: [PATCH 3/3] arm64: cpuidle: Add arm_poll_idle
Thread-Topic: [PATCH 3/3] arm64: cpuidle: Add arm_poll_idle
Thread-Index: AQHahJ/D8+a2/m+FEk+Q2bqBNHXo/LFUQbcA
Date: Tue, 2 Apr 2024 02:30:23 +0000
Message-ID: <738769693c52ed23e35850325ee414ab131a06ea.camel@amazon.com>
References: <20240402014706.3969151-1-harisokn@amazon.com>
	 <20240402014706.3969151-3-harisokn@amazon.com>
In-Reply-To: <20240402014706.3969151-3-harisokn@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <A5B816E60B1093468C4B39A6876BD3EC@amazon.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gTW9uLCAyMDI0LTA0LTAxIGF0IDIwOjQ3IC0wNTAwLCBIYXJpcyBPa2Fub3ZpYyB3cm90ZToK
PiArc3RhdGljIGludCBfX2NwdWlkbGUgYXJtX2lkbGVfd2ZlX3BvbGwoc3RydWN0IGNwdWlkbGVf
ZGV2aWNlICpkZXYsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IGNwdWlkbGVfZHJpdmVyICpkcnYsIGludCBpZHgp
Cj4gK3sKPiArwqDCoMKgwqDCoMKgwqB1NjQgdGltZV9zdGFydCwgdGltZV9saW1pdDsKPiArCj4g
K8KgwqDCoMKgwqDCoMKgdGltZV9zdGFydCA9IGxvY2FsX2Nsb2NrKCk7Cj4gK8KgwqDCoMKgwqDC
oMKgZGV2LT5wb2xsX3RpbWVfbGltaXQgPSBmYWxzZTsKPiArCj4gK8KgwqDCoMKgwqDCoMKgbG9j
YWxfaXJxX2VuYWJsZSgpOwoKUmUgdGhpcyBjb21tZW50IGZyb20gUGV0ZXIgWmlqbHN0cmEgWzFd
LCBzaG91bGQgSSB1c2UKcmF3X2xvY2FsX2lycV9lbmFibGUoKSBpbnN0ZWFkPyBJIHNlZSBleGFt
cGxlcyBvZiBib3RoIHVuZGVyCmRyaXZlcnMvY3B1aWRsZS8uCgpbMV0KaHR0cHM6Ly9lbGl4aXIu
Ym9vdGxpbi5jb20vbGludXgvdjYuOS1yYzIvc291cmNlL2luY2x1ZGUvbGludXgvY3B1aWRsZS5o
I0wxMTkKCj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChjdXJyZW50X3NldF9wb2xsaW5nX2FuZF90
ZXN0KCkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gZW5kOwo+ICsKPiAr
wqDCoMKgwqDCoMKgwqB0aW1lX2xpbWl0ID0gY3B1aWRsZV9wb2xsX3RpbWUoZHJ2LCBkZXYpOwo+
ICsKPiArwqDCoMKgwqDCoMKgwqBkbyB7Cj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oC8vIGV4Y2x1c2l2ZSByZWFkIGFybXMgdGhlIG1vbml0b3IgZm9yIHdmZQo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAoX19SRUFEX09OQ0VfRVgoY3VycmVudF90aHJlYWRfaW5m
bygpLT5mbGFncykgJgo+IF9USUZfTkVFRF9SRVNDSEVEKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZ290byBlbmQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAvLyBtYXkgZXhpdCBwcmVtYXR1cmVseSwgc2VlIEFSTV9BUkNIX1RJ
TUVSX0VWVFNUUkVBTQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB3ZmUoKTsKPiAr
wqDCoMKgwqDCoMKgwqB9IHdoaWxlIChsb2NhbF9jbG9jaygpIC0gdGltZV9zdGFydCA8IHRpbWVf
bGltaXQpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBkZXYtPnBvbGxfdGltZV9saW1pdCA9IHRydWU7
Cj4gKwo+ICtlbmQ6Cj4gK8KgwqDCoMKgwqDCoMKgY3VycmVudF9jbHJfcG9sbGluZygpOwo+ICvC
oMKgwqDCoMKgwqDCoHJldHVybiBpZHg7Cj4gK30KPiArCgpUaGFua3MsCkhhcmlzIE9rYW5vdmlj
Cgo=

