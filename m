Return-Path: <linux-kernel+bounces-29042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF5A830774
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 15:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6BB81F2493C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0942031A;
	Wed, 17 Jan 2024 14:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ngg0ERDa"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E93B200C9;
	Wed, 17 Jan 2024 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705500131; cv=none; b=nGDByBAw5vlxEslL756Ql5GeZ64pFGuT+9tdbxJ5lrBsWL2J59nDOHVUu2cZOeRRdNoP0Ukkyuts/zpILEtfFKHaC1GJpX7YGoHm/qDXG8BJTRTUFlDdg854VNJNsNzFjBIA9dK0IpFai0KT5aWt9ep4HOq8PxY9iOM24taZ23w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705500131; c=relaxed/simple;
	bh=R+N96ZQEAfDbhmqKJeIs5t/qX5hk250eLM+kCzB/5uc=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:CC:References:From:
	 In-Reply-To:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=ePIWMg92TyWC+sJwEkV/OAcgBIKt4zJ9kD0b8l5WUbTGr0mUu8kBEUimhT8VyCkMd+OvEL/ZfEHM3uI3QfJnJ7BvGWENgGYQSbFVArOTYLNQmZPSriOkdGnrr5slBwRf2DtDmAhRF8/JCr9yybJDEwMrsL2s3oN9y+mkl4J73Hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ngg0ERDa; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705500130; x=1737036130;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R+N96ZQEAfDbhmqKJeIs5t/qX5hk250eLM+kCzB/5uc=;
  b=ngg0ERDacrxyeq9DqzaSjO5gGkJyhaXM7MoZHLdekPWpCMMFgCIXRBCN
   mLObZHAKGT2xnC2eBpEjvMEk7NgOktZptiFPSuug75QODcQIRbXKkX6Gm
   0vbyF2GKGwNcz6ud8v3+gTwYAN2NUOXhvP8p01NeeaA1YhZ0E0fdPZOzG
   g=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="628159042"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 14:02:08 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan2.iad.amazon.com [10.32.235.34])
	by email-inbound-relay-iad-1e-m6i4x-6e7a78d7.us-east-1.amazon.com (Postfix) with ESMTPS id 6DBC280774;
	Wed, 17 Jan 2024 14:02:00 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:42529]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.57:2525] with esmtp (Farcaster)
 id e65f03f2-b86e-47d1-8655-6702971ecda1; Wed, 17 Jan 2024 14:01:59 +0000 (UTC)
X-Farcaster-Flow-ID: e65f03f2-b86e-47d1-8655-6702971ecda1
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 14:01:59 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 14:01:53 +0000
Message-ID: <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
Date: Wed, 17 Jan 2024 15:01:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/17] kexec: Add documentation for KHO
Content-Language: en-US
To: Rob Herring <robh+dt@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-mm@kvack.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kexec@lists.infradead.org>,
	<linux-doc@vger.kernel.org>, <x86@kernel.org>, Eric Biederman
	<ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski
	<luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Steven Rostedt
	<rostedt@goodmis.org>, Andrew Morton <akpm@linux-foundation.org>, "Mark
 Rutland" <mark.rutland@arm.com>, Tom Lendacky <thomas.lendacky@amd.com>,
	Ashish Kalra <ashish.kalra@amd.com>, James Gowans <jgowans@amazon.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>, <arnd@arndb.de>,
	<pbonzini@redhat.com>, <madvenka@linux.microsoft.com>, Anthony Yznaga
	<anthony.yznaga@oracle.com>, Usama Arif <usama.arif@bytedance.com>, "David
 Woodhouse" <dwmw@amazon.co.uk>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>
References: <20231222193607.15474-1-graf@amazon.com>
 <20231222195144.24532-1-graf@amazon.com>
 <20231222195144.24532-2-graf@amazon.com>
 <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAL_JsqJSYgq7BJnSxwKebEX8e9tL-FG74rT+eLJ4e32kKZC30g@mail.gmail.com>
X-ClientProxiedBy: EX19D035UWB001.ant.amazon.com (10.13.138.33) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDAzLjAxLjI0IDE5OjQ4LCBSb2IgSGVycmluZyB3cm90ZToKPgo+IE9uIEZyaSwgRGVjIDIy
LCAyMDIzIGF0IDEyOjUy4oCvUE0gQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gd3Jv
dGU6Cj4+IFdpdGggS0hPIGluIHBsYWNlLCBsZXQncyBhZGQgZG9jdW1lbnRhdGlvbiB0aGF0IGRl
c2NyaWJlcyB3aGF0IGl0IGlzIGFuZAo+PiBob3cgdG8gdXNlIGl0Lgo+Pgo+PiBTaWduZWQtb2Zm
LWJ5OiBBbGV4YW5kZXIgR3JhZiA8Z3JhZkBhbWF6b24uY29tPgo+PiAtLS0KPj4gICBEb2N1bWVu
dGF0aW9uL2toby9jb25jZXB0cy5yc3QgICB8IDg4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCj4+ICAgRG9jdW1lbnRhdGlvbi9raG8vaW5kZXgucnN0ICAgICAgfCAxOSArKysrKysr
Cj4+ICAgRG9jdW1lbnRhdGlvbi9raG8vdXNhZ2UucnN0ICAgICAgfCA1NyArKysrKysrKysrKysr
KysrKysrKysKPj4gICBEb2N1bWVudGF0aW9uL3N1YnN5c3RlbS1hcGlzLnJzdCB8ICAxICsKPj4g
ICA0IGZpbGVzIGNoYW5nZWQsIDE2NSBpbnNlcnRpb25zKCspCj4+ICAgY3JlYXRlIG1vZGUgMTAw
NjQ0IERvY3VtZW50YXRpb24va2hvL2NvbmNlcHRzLnJzdAo+PiAgIGNyZWF0ZSBtb2RlIDEwMDY0
NCBEb2N1bWVudGF0aW9uL2toby9pbmRleC5yc3QKPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9j
dW1lbnRhdGlvbi9raG8vdXNhZ2UucnN0Cj4+Cj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2toby9jb25jZXB0cy5yc3QgYi9Eb2N1bWVudGF0aW9uL2toby9jb25jZXB0cy5yc3QKPj4gbmV3
IGZpbGUgbW9kZSAxMDA2NDQKPj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZTRmZThjNTc4NjUKPj4g
LS0tIC9kZXYvbnVsbAo+PiArKysgYi9Eb2N1bWVudGF0aW9uL2toby9jb25jZXB0cy5yc3QKPj4g
QEAgLTAsMCArMSw4OCBAQAo+PiArLi4gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAt
b3ItbGF0ZXIKPj4gKwo+PiArPT09PT09PT09PT09PT09PT09PT09PT0KPj4gK0tleGVjIEhhbmRv
dmVyIENvbmNlcHRzCj4+ICs9PT09PT09PT09PT09PT09PT09PT09PQo+PiArCj4+ICtLZXhlYyBI
YW5kT3ZlciAoS0hPKSBpcyBhIG1lY2hhbmlzbSB0aGF0IGFsbG93cyBMaW51eCB0byBwcmVzZXJ2
ZSBzdGF0ZSAtCj4+ICthcmJpdHJhcnkgcHJvcGVydGllcyBhcyB3ZWxsIGFzIG1lbW9yeSBsb2Nh
dGlvbnMgLSBhY3Jvc3Mga2V4ZWMuCj4+ICsKPj4gK0l0IGludHJvZHVjZXMgbXVsdGlwbGUgY29u
Y2VwdHM6Cj4+ICsKPj4gK0tITyBEZXZpY2UgVHJlZQo+PiArLS0tLS0tLS0tLS0tLS0tCj4+ICsK
Pj4gK0V2ZXJ5IEtITyBrZXhlYyBjYXJyaWVzIGEgS0hPIHNwZWNpZmljIGZsYXR0ZW5lZCBkZXZp
Y2UgdHJlZSBibG9iIHRoYXQKPj4gK2Rlc2NyaWJlcyB0aGUgc3RhdGUgb2YgdGhlIHN5c3RlbS4g
RGV2aWNlIGRyaXZlcnMgY2FuIHJlZ2lzdGVyIHRvIEtITyB0bwo+PiArc2VyaWFsaXplIHRoZWly
IHN0YXRlIGJlZm9yZSBrZXhlYy4gQWZ0ZXIgS0hPLCBkZXZpY2UgZHJpdmVycyBjYW4gcmVhZAo+
PiArdGhlIGRldmljZSB0cmVlIGFuZCBleHRyYWN0IHByZXZpb3VzIHN0YXRlLgo+IEhvdyBkb2Vz
IHRoaXMgd29yayB3aXRoIGtleGVjIHdoZW4gdGhlcmUgaXMgYWxzbyB0aGUgRkRUIGZvciB0aGUg
aC93Pwo+IFRoZSBoL3cgRkRUIGhhcyBhIC9jaG9zZW4gcHJvcGVydHkgcG9pbnRpbmcgdG8gdGhp
cyBGRFQgYmxvYj8KCgpZZXAsIGV4YWN0bHkuCgoKPgo+PiArCj4+ICtLSE8gb25seSB1c2VzIHRo
ZSBmZHQgY29udGFpbmVyIGZvcm1hdCBhbmQgbGliZmR0IGxpYnJhcnksIGJ1dCBkb2VzIG5vdAo+
PiArYWRoZXJlIHRvIHRoZSBzYW1lIHByb3BlcnR5IHNlbWFudGljcyB0aGF0IG5vcm1hbCBkZXZp
Y2UgdHJlZXMgZG86IFByb3BlcnRpZXMKPj4gK2FyZSBwYXNzZWQgaW4gbmF0aXZlIGVuZGlhbm5l
c3MgYW5kIHN0YW5kYXJkaXplZCBwcm9wZXJ0aWVzIGxpa2UgYGByZWdzYGAgYW5kCj4+ICtgYHJh
bmdlc2BgIGRvIG5vdCBleGlzdCwgaGVuY2UgdGhlcmUgYXJlIG5vIGBgIy4uLi1jZWxsc2BgIHBy
b3BlcnRpZXMuCj4gSSB0aGluayBuYXRpdmUgZW5kaWFubmVzcyBpcyBhc2tpbmcgZm9yIHRyb3Vi
bGUuIGxpYmZkdCB3b3VsZCBuZWVkCj4gZGlmZmVyZW50IHN3YXAgZnVuY3Rpb25zIGhlcmUgdGhh
biBlbHNld2hlcmUgaW4gdGhlIGtlcm5lbCBmb3IgZXhhbXBsZQo+IHdoaWNoIHdvdWxkbid0IGV2
ZW4gd29yay4gU28geW91IGFyZSBqdXN0IGNyb3NzaW5nIHlvdXIgZmluZ2VycyB0aGF0Cj4geW91
IGFyZW4ndCB1c2luZyBhbnkgbGliZmR0IGZ1bmN0aW9ucyB0aGF0IHN3YXAuIEFuZCB3aGVuIEkg
c3luYwo+IGR0Yy9saWJmZHQgYW5kIHRoYXQgY2hhbmdlcywgSSBtaWdodCBicmVhayB5b3UuCj4K
PiBBbHNvLCBpZiB5b3Ugd2FudCB0byBkdW1wIHRoZSBGRFQgYW5kIGRvIGEgZHRjIERUQi0+RFRT
IHBhc3MsIGl0IGlzCj4gbm90IGdvaW5nIHRvIGJlIHRvbyByZWFkYWJsZSBnaXZlbiB0aGF0IG91
dHB1dHMgc3dhcHBlZCAzMi1iaXQgdmFsdWVzCj4gZm9yIGFueXRoaW5nIHRoYXQncyBhIDQgYnl0
ZSBtdWx0aXBsZS4KCgpZZWFoLCBidXQgYmlnIGVuZGlhbiB0aGVzZSBkYXlzIGlzIGp1c3QgYSBj
b21wbGV0ZSB3YXN0ZSBvZiBicmFpbiBhbmQgCmNwdSBjeWNsZXMgOikuIEFuZCB5ZXMsIEkgZG9u
J3QgcmVhbGx5IHdhbnQgdG8gdXNlIGFueSBsaWJmZHQgaGVscGVyIApmdW5jdGlvbnMgdG8gcmVh
ZCBkYXRhLiBJIHVzZSBpdCBvbmx5IHRvIGdpdmUgbWUgdGhlIHJhdyBkYXRhIGFuZCB0YWtlIApp
dCBmcm9tIHRoZXJlLgoKCj4KPj4gKwo+PiArS0hPIGludHJvZHVjZXMgYSBuZXcgY29uY2VwdCB0
byBpdHMgZGV2aWNlIHRyZWU6IGBgbWVtYGAgcHJvcGVydGllcy4gQQo+PiArYGBtZW1gYCBwcm9w
ZXJ0eSBjYW4gaW5zaWRlIGFueSBzdWJub2RlIGluIHRoZSBkZXZpY2UgdHJlZS4gV2hlbiBwcmVz
ZW50LAo+PiAraXQgY29udGFpbnMgYW4gYXJyYXkgb2YgcGh5c2ljYWwgbWVtb3J5IHJhbmdlcyB0
aGF0IHRoZSBuZXcga2VybmVsIG11c3QgbWFyawo+PiArYXMgcmVzZXJ2ZWQgb24gYm9vdC4gSXQg
aXMgcmVjb21tZW5kZWQsIGJ1dCBub3QgcmVxdWlyZWQsIHRvIG1ha2UgdGhlc2UgcmFuZ2VzCj4+
ICthcyBwaHlzaWNhbGx5IGNvbnRpZ3VvdXMgYXMgcG9zc2libGUgdG8gcmVkdWNlIHRoZSBudW1i
ZXIgb2YgYXJyYXkgZWxlbWVudHMgOjoKPj4gKwo+PiArICAgIHN0cnVjdCBraG9fbWVtIHsKPj4g
KyAgICAgICAgICAgIF9fdTY0IGFkZHI7Cj4+ICsgICAgICAgICAgICBfX3U2NCBsZW47Cj4+ICsg
ICAgfTsKPj4gKwo+PiArQWZ0ZXIgYm9vdCwgZHJpdmVycyBjYW4gY2FsbCB0aGUga2hvIHN1YnN5
c3RlbSB0byB0cmFuc2ZlciBvd25lcnNoaXAgb2YgbWVtb3J5Cj4+ICt0aGF0IHdhcyByZXNlcnZl
ZCB2aWEgYSBgYG1lbWBgIHByb3BlcnR5IHRvIHRoZW1zZWx2ZXMgdG8gY29udGludWUgdXNpbmcg
bWVtb3J5Cj4+ICtmcm9tIHRoZSBwcmV2aW91cyBleGVjdXRpb24uCj4+ICsKPj4gK1RoZSBLSE8g
ZGV2aWNlIHRyZWUgZm9sbG93cyB0aGUgaW4tTGludXggc2NoZW1hIHJlcXVpcmVtZW50cy4gQW55
IGVsZW1lbnQgaW4KPj4gK3RoZSBkZXZpY2UgdHJlZSBpcyBkb2N1bWVudGVkIHZpYSBkZXZpY2Ug
dHJlZSBzY2hlbWEgeWFtbHMgdGhhdCBleHBsYWluIHdoYXQKPj4gK2RhdGEgZ2V0cyB0cmFuc2Zl
cnJlZC4KPiBJZiB0aGlzIGlzIGFsbCBzZXBhcmF0ZSwgdGhlbiBJIHRoaW5rIHRoZSBzY2hlbWFz
IHNob3VsZCBiZSB0b28uIEFuZAo+IHRoZW4gZnJvbSBteSAoRFQgbWFpbnRhaW5lcikgcGVyc3Bl
Y3RpdmUsIHlvdSBjYW4gZG8gd2hhdGV2ZXIgeW91IHdhbnQKPiBoZXJlIChsaWtlIEZJVCBpbWFn
ZXMpLiBUaGUgZHRzY2hlbWEgdG9vbHMgYXJlIHByZXR0eSBtdWNoIG9ubHkgZ2VhcmVkCj4gZm9y
ICJub3JtYWwiIERUcy4gQSBjb3VwbGUgb2YgcHJvYmxlbXMgY29tZSB0byBtaW5kLiBZb3UgY2Fu
J3QgZXhjbHVkZQo+IG9yIGNoYW5nZSBzdGFuZGFyZCBwcm9wZXJ0aWVzLiBUaGUgZGVjb2Rpbmcg
b2YgdGhlIERUQiB0byBydW4KPiB2YWxpZGF0aW9uIGFzc3VtZXMgYmlnIGVuZGlhbi4gV2UgY291
bGQgcHJvYmFibHkgc3BsaXQgdGhpbmdzIHVwIGEKPiBiaXQsIGJ1dCB5b3UgbWF5IGJlIGJldHRl
ciBvZmYganVzdCB1c2luZyBqc29uc2NoZW1hIGRpcmVjdGx5LiBJJ20gbm90Cj4gZXZlbiBzdXJl
IHJ1bm5pbmcgdmFsaWRhdGlvbiBoZXJlIHdvdWxkIHRoYXQgdmFsdWFibGUuIFlvdSBoYXZlIDEK
PiBzb3VyY2Ugb2YgY29kZSBnZW5lcmF0aW5nIHRoZSBEVCBhbmQgMSBjb25zdW1lci4gWWVzLCB0
aGVyZSdzCj4gZGlmZmVyZW50IGtlcm5lbCB2ZXJzaW9ucyB0byBkZWFsIHdpdGgsIGJ1dCBpdCdz
IG5vdCAxMDBzIG9mIHBlb3BsZQo+IGNyZWF0aW5nIDEwMDBzIG9mIERUcyB3aXRoIDEwMHMgb2Yg
bm9kZXMuCj4KPiBZb3UgbWlnaHQgbG9vayBhdCB0aGUgbmV0bGluayBzdHVmZiB3aGljaCBpcyB1
c2luZyBpdHMgb3duIHlhbWwgc3ludGF4Cj4gdG8gZ2VuZXJhdGUgY29kZSBhbmQganNvbnNjaGVt
YSBpcyB1c2VkIHRvIHZhbGlkYXRlIHRoZSB5YW1sLgoKCkknbSBjdXJyZW50bHkgYSBsb3QgbW9y
ZSBpbnRlcmVzdGVkIGluIHRoZSBkb2N1bWVudGF0aW9uIGFzcGVjdCB0aGFuIGluIAp0aGUgdmFs
aWRhdGlvbiwgeWVhaC4gU28gSSB0aGluayBmb3IgdjMsIEknbGwganVzdCB0aHJvdyB0aGUgc2No
ZW1hcyAKaW50byB0aGUgRG9jdW1lbnRhdGlvbi9raG8gZGlyZWN0b3J5IHdpdGhvdXQgYW55IHZh
bGlkYXRpb24uIFdlIGNhbiAKd29ycnkgYWJvdXQgdGhhdCBsYXRlciA6KQoKVGhhbmtzIGEgbG90
IGFnYWluIGZvciB0aGUgcmV2aWV3IQoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2Vu
dGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1
ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBh
bSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVy
bGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


