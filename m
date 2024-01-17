Return-Path: <linux-kernel+bounces-29250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0003A830B9A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFCF81C25C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 17:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D88225AD;
	Wed, 17 Jan 2024 17:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qcEixryU"
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DFA622627;
	Wed, 17 Jan 2024 17:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705510826; cv=none; b=LalbWFJPGNasmeZDd/HI2q+Wg15p3x5Ozodh//e3+aVX1BoJ0VUXHCd2OGmHgsKYy598SOxxzEhZhbDryTv80D50fANnuoD7fa5wClyl+PGKK/ixY1Xft97iIRu8N0ppv4wjfPIaG+9wDI647rWmGs1B+3ZOSfhuWojmtwcgHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705510826; c=relaxed/simple;
	bh=ftV4SQ2prRssSQxwJUeB+ZsSruvbFuQg7jiOaRpceoU=;
	h=DKIM-Signature:X-IronPort-AV:Received:Received:Received:
	 X-Farcaster-Flow-ID:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:Content-Language:To:CC:References:From:
	 In-Reply-To:X-Originating-IP:X-ClientProxiedBy:Content-Type:
	 Content-Transfer-Encoding; b=AwvgW0+5MdrBnsRA5gSqldWtieRpEU0FHige46WKb6Aw6xoiX6iKNVLygQCH4rVz3n0KG8oikgcI9logXBOJCT/BJwOS6kUe1hL44Lgz8mvfwEAsFc3p8S0JFfyQBG+ire5KzX8jqEPjhax4B4Fvs3bOiy8z/96bPTOVNxf0bvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qcEixryU; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1705510824; x=1737046824;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ftV4SQ2prRssSQxwJUeB+ZsSruvbFuQg7jiOaRpceoU=;
  b=qcEixryU9pvtopmY18UYlT99QPUeIqmkOptdPpnLix3Bn1hU80marFq2
   afiJJbIkRZr85iwnKW6SW2FCs/uAxUtTreUuDuIx7qHudLTPenOl30gQa
   qyX0gSWL8usJ5B5lZcCR9Su+hRQD1VQLqrnOwwZV54+5bmn5C728ADi+K
   k=;
X-IronPort-AV: E=Sophos;i="6.05,200,1701129600"; 
   d="scan'208";a="698431866"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2024 17:00:17 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan2.pdx.amazon.com [10.39.38.66])
	by email-inbound-relay-pdx-2b-m6i4x-f323d91c.us-west-2.amazon.com (Postfix) with ESMTPS id EA2EA40D6F;
	Wed, 17 Jan 2024 17:00:15 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:38269]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.60:2525] with esmtp (Farcaster)
 id dba4c50c-4c22-4d9f-b9b6-2eab979612a9; Wed, 17 Jan 2024 17:00:15 +0000 (UTC)
X-Farcaster-Flow-ID: dba4c50c-4c22-4d9f-b9b6-2eab979612a9
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 17 Jan 2024 17:00:15 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 17 Jan
 2024 17:00:10 +0000
Message-ID: <2ae688df-853f-43f2-97c4-109623d92f0e@amazon.com>
Date: Wed, 17 Jan 2024 18:00:07 +0100
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
 <c96203ba-a5b2-4765-9d30-0f4e66c82cd7@amazon.com>
 <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <CAL_JsqK2WaH+vWd-hcrCSzycMGTztX4i2p1wpECseD_M3EY0tA@mail.gmail.com>
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjAxLjI0IDE3OjU0LCBSb2IgSGVycmluZyB3cm90ZToKPiBPbiBXZWQsIEphbiAxNywg
MjAyNCBhdCA4OjAy4oCvQU0gQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4gd3JvdGU6
Cj4+Cj4+IE9uIDAzLjAxLjI0IDE5OjQ4LCBSb2IgSGVycmluZyB3cm90ZToKPj4+IE9uIEZyaSwg
RGVjIDIyLCAyMDIzIGF0IDEyOjUy4oCvUE0gQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNv
bT4gd3JvdGU6Cj4+Pj4gV2l0aCBLSE8gaW4gcGxhY2UsIGxldCdzIGFkZCBkb2N1bWVudGF0aW9u
IHRoYXQgZGVzY3JpYmVzIHdoYXQgaXQgaXMgYW5kCj4+Pj4gaG93IHRvIHVzZSBpdC4KPj4+Pgo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRlciBHcmFmIDxncmFmQGFtYXpvbi5jb20+Cj4+Pj4g
LS0tCj4+Pj4gICAgRG9jdW1lbnRhdGlvbi9raG8vY29uY2VwdHMucnN0ICAgfCA4OCArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+ICAgIERvY3VtZW50YXRpb24va2hvL2luZGV4
LnJzdCAgICAgIHwgMTkgKysrKysrKwo+Pj4+ICAgIERvY3VtZW50YXRpb24va2hvL3VzYWdlLnJz
dCAgICAgIHwgNTcgKysrKysrKysrKysrKysrKysrKysrCj4+Pj4gICAgRG9jdW1lbnRhdGlvbi9z
dWJzeXN0ZW0tYXBpcy5yc3QgfCAgMSArCj4+Pj4gICAgNCBmaWxlcyBjaGFuZ2VkLCAxNjUgaW5z
ZXJ0aW9ucygrKQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2toby9j
b25jZXB0cy5yc3QKPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9raG8v
aW5kZXgucnN0Cj4+Pj4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24va2hvL3Vz
YWdlLnJzdAo+Pj4+Cj4+Pj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24va2hvL2NvbmNlcHRz
LnJzdCBiL0RvY3VtZW50YXRpb24va2hvL2NvbmNlcHRzLnJzdAo+Pj4+IG5ldyBmaWxlIG1vZGUg
MTAwNjQ0Cj4+Pj4gaW5kZXggMDAwMDAwMDAwMDAwLi44ZTRmZThjNTc4NjUKPj4+PiAtLS0gL2Rl
di9udWxsCj4+Pj4gKysrIGIvRG9jdW1lbnRhdGlvbi9raG8vY29uY2VwdHMucnN0Cj4+Pj4gQEAg
LTAsMCArMSw4OCBAQAo+Pj4+ICsuLiBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1v
ci1sYXRlcgo+Pj4+ICsKPj4+PiArPT09PT09PT09PT09PT09PT09PT09PT0KPj4+PiArS2V4ZWMg
SGFuZG92ZXIgQ29uY2VwdHMKPj4+PiArPT09PT09PT09PT09PT09PT09PT09PT0KPj4+PiArCj4+
Pj4gK0tleGVjIEhhbmRPdmVyIChLSE8pIGlzIGEgbWVjaGFuaXNtIHRoYXQgYWxsb3dzIExpbnV4
IHRvIHByZXNlcnZlIHN0YXRlIC0KPj4+PiArYXJiaXRyYXJ5IHByb3BlcnRpZXMgYXMgd2VsbCBh
cyBtZW1vcnkgbG9jYXRpb25zIC0gYWNyb3NzIGtleGVjLgo+Pj4+ICsKPj4+PiArSXQgaW50cm9k
dWNlcyBtdWx0aXBsZSBjb25jZXB0czoKPj4+PiArCj4+Pj4gK0tITyBEZXZpY2UgVHJlZQo+Pj4+
ICstLS0tLS0tLS0tLS0tLS0KPj4+PiArCj4+Pj4gK0V2ZXJ5IEtITyBrZXhlYyBjYXJyaWVzIGEg
S0hPIHNwZWNpZmljIGZsYXR0ZW5lZCBkZXZpY2UgdHJlZSBibG9iIHRoYXQKPj4+PiArZGVzY3Jp
YmVzIHRoZSBzdGF0ZSBvZiB0aGUgc3lzdGVtLiBEZXZpY2UgZHJpdmVycyBjYW4gcmVnaXN0ZXIg
dG8gS0hPIHRvCj4+Pj4gK3NlcmlhbGl6ZSB0aGVpciBzdGF0ZSBiZWZvcmUga2V4ZWMuIEFmdGVy
IEtITywgZGV2aWNlIGRyaXZlcnMgY2FuIHJlYWQKPj4+PiArdGhlIGRldmljZSB0cmVlIGFuZCBl
eHRyYWN0IHByZXZpb3VzIHN0YXRlLgo+IENhbiB5b3UgYXZvaWQgY2FsbGluZyBhbnl0aGluZyAi
ZGV2aWNlIHRyZWUiIGFzIG11Y2ggYXMgcG9zc2libGUuIFdlCj4gY2FuJ3QgYXZvaWQgdGhlIGZv
cm1hdCBpcyBGRFQvRFRCLCBidXQgb3RoZXJ3aXNlIG5vbmUgb2YgdGhpcyBpcwo+IERldmljZXRy
ZWUgYXMgbW9zdCBmb2xrcyBrbm93IGl0LiBTdXJlLCB0aGVyZSBjYW4gYmUgdHJlZXMgb2YgZGV2
aWNlcwo+IHdoaWNoIGFyZSBub3QgRGV2aWNldHJlZSwgYnV0IHRoaXMgaXMgbmVpdGhlci4gWW91
IGNvdWxkIGhhdmUgdXNlZAo+IEJTT04gb3IgYW55IGhpZXJhcmNoaWNhbCBrZXktdmFsdWUgcGFp
ciBzZXJpYWxpemF0aW9uIGZvcm1hdCBqdXN0IGFzCj4gZWFzaWx5IChpZiB3ZSBhbHJlYWR5IGhh
ZCBhIHBhcnNlciBpbiB0aGUga2VybmVsKS4KCgpJIHVuZGVyc3RhbmQgYW5kIGFncmVlIC0gaXQn
cyBiZWVuIGNvbmZ1c2luZyB0byBwcmV0dHkgbXVjaCBldmVyeW9uZSB3aG8gCndhcyBsb29raW5n
IGF0IEtITyBzbyBmYXIuIFVuZm9ydHVuYXRlbHkgSSdtIHRlcnJpYmxlIGF0IG5hbWluZy4gRG8g
eW91IApoYXBwZW4gdG8gaGF2ZSBhIGdvb2Qgc3VnZ2VzdGlvbj8gOikKCgo+Cj4+PiBIb3cgZG9l
cyB0aGlzIHdvcmsgd2l0aCBrZXhlYyB3aGVuIHRoZXJlIGlzIGFsc28gdGhlIEZEVCBmb3IgdGhl
IGgvdz8KPj4+IFRoZSBoL3cgRkRUIGhhcyBhIC9jaG9zZW4gcHJvcGVydHkgcG9pbnRpbmcgdG8g
dGhpcyBGRFQgYmxvYj8KPj4KPj4gWWVwLCBleGFjdGx5Lgo+IFRob3NlIHByb3BlcnRpZXMgbmVl
ZCB0byBiZSBkb2N1bWVudGVkIGhlcmVbMV0uCgoKT29vaCwgdGhhbmtzIGEgbG90IGZvciB0aGUg
cG9pbnRlciEgSSdsbCBhZGQgdGhlbSA6KQoKCkFsZXgKCgoKCgpBbWF6b24gRGV2ZWxvcG1lbnQg
Q2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0
c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdl
biBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejog
QmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


