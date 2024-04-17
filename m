Return-Path: <linux-kernel+bounces-148166-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A978A7E93
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DB351F224CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D41B127E17;
	Wed, 17 Apr 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="pzk1R/cE"
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7779512B145;
	Wed, 17 Apr 2024 08:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343507; cv=none; b=gZfULfUQifGGZdSloxPHZU9UuaBrKYEGASDwZMJb8mgcXnoWcGNPWUcRpVVgjDn4bvT5XVuXnZUsRao+PHQerdVLElcogeIkvMb1ItJi3SRM22ToQ+6PfRV+8aGHSYzn/N/E8MxBR1Z1x88MsMnqfdW1wKw29wMDXgh/hx/kT2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343507; c=relaxed/simple;
	bh=YwBgnKtOSSbWewXAV3n0sS4ChLJ8VOl84gycm24fyQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p6hQNzFtGnw+bifGhCHVD/SFoz0dUBvY9M2SxUvoAxJCYw5/EZswQQyFMceHWMqtQp9DFj4IYXFq6kInj73HVPZySPBPCx1FjBgGPyCDPfZpDEQQEpbxP/B6L591w/IFwKwRr5+Hbbpa6HcB+yTofb+lrQTHyYblcWVs8N8c24k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=pzk1R/cE; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1713343505; x=1744879505;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YwBgnKtOSSbWewXAV3n0sS4ChLJ8VOl84gycm24fyQo=;
  b=pzk1R/cE0xJ9flQq4avQWUKixDUNWwPsT4ARosVOmeGqzN7rSdIjQwDA
   MXlnisWFBPkAEJ/Uuk0iqSXnSsXQ0Tvni0ZwiuvqjcxRZu7xJYT0jGykX
   fa9j8SaaWORN1qUsEypDQWTxkZua11ZrEpIszYKfRLOM9D5HzZKYhJMwK
   E=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="648282139"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:45:01 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:33881]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.40:2525] with esmtp (Farcaster)
 id cd1f4840-37f5-4b04-8bbc-619d4e585a76; Wed, 17 Apr 2024 08:45:01 +0000 (UTC)
X-Farcaster-Flow-ID: cd1f4840-37f5-4b04-8bbc-619d4e585a76
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:45:01 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 08:44:57 +0000
Message-ID: <43ca9c32-2938-4998-b823-ccdb6452ad84@amazon.de>
Date: Wed, 17 Apr 2024 10:44:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/5] virt: vmgenid: Add devicetree bindings support
Content-Language: en-US
To: Babis Chalios <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
References: <20240417081212.99657-1-bchalios@amazon.es>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20240417081212.99657-1-bchalios@amazon.es>
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjA0LjI0IDEwOjEyLCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+IFRoaXMgc21hbGwgc2Vy
aWVzIG9mIHBhdGNoZXMgYWltcyB0byBhZGQgZGV2aWNldHJlZSBiaW5kaW5ncyBzdXBwb3J0IGZv
cgo+IHRoZSBWaXJ0dWFsIE1hY2hpbmUgR2VuZXJhdGlvbiBJRCAodm1nZW5pZCkuCj4KPiBWaXJ0
dWFsIE1hY2hpbmUgR2VuZXJhdGlvbiBJRCB3YXMgaW50cm9kdWNlZCBpbiBjb21taXQgYWY2YjU0
ZTJiNWJhCj4gKCJ2aXJ0OiB2bWdlbmlkOiBub3RpZnkgUk5HIG9mIFZNIGZvcmsgYW5kIHN1cHBs
eSBnZW5lcmF0aW9uIElEIikgYXMgYW4KPiBBQ1BJIG9ubHkgZGV2aWNlLgo+Cj4gVk1HZW5JRCBz
cGVjaWZpY2F0aW9uIGh0dHA6Ly9nby5taWNyb3NvZnQuY29tL2Z3bGluay8/TGlua0lkPTI2MDcw
OSBkZWZpbmVzCj4gYSBtZWNoYW5pc20gZm9yIHRoZSBCSU9TL2h5cGVydmlzb3JzIHRvIGNvbW11
bmljYXRlIHRvIHRoZSB2aXJ0dWFsIG1hY2hpbmUKPiB0aGF0IGl0IGlzIGV4ZWN1dGVkIHdpdGgg
YSBkaWZmZXJlbnQgY29uZmlndXJhdGlvbiAoZS5nLiBzbmFwc2hvdCBleGVjdXRpb24KPiBvciBj
cmVhdGlvbiBmcm9tIGEgdGVtcGxhdGUpLgo+IFRoZSBndWVzdCBvcGVyYXRpbmcgc3lzdGVtIGNh
biB1c2UgdGhlIG5vdGlmaWNhdGlvbiBmb3IgdmFyaW91cyBwdXJwb3Nlcwo+IHN1Y2ggYXMgcmUt
aW5pdGlhbGl6aW5nIGl0cyByYW5kb20gbnVtYmVyIGdlbmVyYXRvciBldGMuCj4KPiBNb3JlIHJl
ZmVyZW5jZXMgdG8gdm1nZW5pZCBzcGVjczoKPiAgIC0gaHR0cHM6Ly93d3cucWVtdS5vcmcvZG9j
cy9tYXN0ZXIvc3BlY3Mvdm1nZW5pZC5odG1sCj4gICAtIGh0dHBzOi8vbGVhcm4ubWljcm9zb2Z0
LmNvbS9lbi11cy93aW5kb3dzL3dpbjMyL2h5cGVydl92Mi8KPiAgIHZpcnR1YWwtbWFjaGluZS1n
ZW5lcmF0aW9uLWlkZW50aWZpZXIKPgo+ICpSZWFzb24gZm9yIHRoaXMgY2hhbmdlKjoKPiBDaG9z
aW5nIEFDUEkgb3IgZGV2aWNldHJlZSBpcyBhbiBpbnRyaW5zaWMgcGFydCBvZiBhbiBoeXBlcnZp
c29yIGRlc2lnbi4KPiBXaXRob3V0IGdvaW5nIGludG8gZGV0YWlscyBvZiB3aHkgYSBoeXBlcnZp
c29yIHdvdWxkIGNob29zZSBEVCBvdmVyIEFDUEksCj4gd2Ugd291bGQgbGlrZSB0byBoaWdobGln
aHQgdGhhdCB0aGUgaHlwZXJ2aXNvcnMgdGhhdCBoYXZlIGNob3NlbiBkZXZpY2V0cmVlCj4gYW5k
IG5vdyB3YW50IHRvIG1ha2UgdXNlIG9mIHRoZSB2bWdlbmlkIGZ1bmN0aW9uYWxpdHkgY2Fubm90
IGRvIHNvIHRvZGF5Cj4gYmVjYXVzZSB2bWdlbmlkIGlzIGFuIEFDUEkgb25seSBkZXZpY2UuCj4g
VGhpcyBmb3JjZXMgdGhlc2UgaHlwZXJ2aXNvcnMgdG8gY2hhbmdlIHRoZWlyIGRlc2lnbiB3aGlj
aCBjb3VsZCBoYXZlCj4gdW5kZXNpcmFibGUgaW1wYWN0cyBvbiB0aGVpciB1c2UtY2FzZXMsIHRl
c3Qtc2NlbmFyaW9zIGV0Yy4KPgo+IHZtZ2VuaWQgZXhwb3NlcyB0byB0aGUgZ3Vlc3QgYSAxNi1i
eXRlIGNyeXB0b2dyYXBoaWNhbGx5IHJhbmRvbSBudW1iZXIsCj4gdGhlIHZhbHVlIG9mIHdoaWNo
IGNoYW5nZXMgZXZlcnkgdGltZSBpdCBzdGFydHMgZXhlY3V0aW5nIGZyb20gYSBuZXcKPiBjb25m
aWd1cmF0aW9uIChzbmFwc2hvdCwgYmFja3VwLCBldGMuKS4gRHVyaW5nIGluaXRpYWxpemF0aW9u
LCB0aGUgZGV2aWNlCj4gZXhwb3NlcyB0byB0aGUgZ3Vlc3QgdGhlIGFkZHJlc3Mgb2YgdGhlIGdl
bmVyYXRpb24gSUQgYW5kCj4gYW4gaW50ZXJydXB0IG51bWJlciwgd2hpY2ggdGhlIGRldmljZSB3
aWxsIHVzZSB0byBub3RpZnkgdGhlIGd1ZXN0IHdoZW4KPiB0aGUgZ2VuZXJhdGlvbiBJRCBjaGFu
Z2VzLgo+IFRoZXNlIGF0dHJpYnV0ZXMgY2FuIGJlIHRyaXZpYWxseSBjb21tdW5pY2F0ZWQgdmlh
IGRldmljZSB0cmVlIGJpbmRpbmdzLgo+Cj4gV2UgYmVsaWV2ZSB0aGF0IGFkZGluZyBhIGRldmlj
ZXRyZWUgYmluZGluZyBmb3Igdm1nZW5pZCBpcyBhIHNpbXBsZXIKPiBhbHRlcm5hdGl2ZSB3YXkg
dG8gZXhwb3NlIHRoZSBkZXZpY2UgdG8gdGhlIGd1ZXN0IHRoYW4gZm9yY2luZyB0aGUKPiBoeXBl
cnZpc29ycyB0byBpbXBsZW1lbnQgQUNQSS4KPgo+IEFkZHRpb25hbCBub3RlczoKPiBXaGlsZSBh
ZGRpbmcgdGhlIGRldmljZXRyZWUgc3VwcG9ydCB3ZSBjb25zaWRlcmVkIHJlLXVzaW5nIGV4aXN0
aW5nCj4gc3RydWN0dXJlcy9jb2RlIHRvIGF2b2lkIGR1cGxpY2F0aW5nIGNvZGUgYW5kIHJlZHVj
ZSBtYWludGVuYW5jZTsgc28sCj4gd2UgdXNlZCB0aGUgc2FtZSBkcml2ZXIgdG8gYmUgY29uZmln
dXJlZCBlaXRoZXIgYnkgQUNQSSBvciBieSBEVC4KPiBUaGlzIGFsc28gbWVhbnQgcmVpbXBsZW1l
bnRpbmcgdGhlIGV4aXN0aW5nIHZtZ2VuaWQgQUNQSSBidXMgZHJpdmVyIGFzIGEKPiBwbGF0Zm9y
bSBkcml2ZXIgYW5kIG1ha2luZyBpdCBkaXNjb3ZlcmFibGUgdXNpbmcgYGRyaXZlci5vZl9tYXRj
aF90YWJsZWAKPiBhbmQgYGRyaXZlci5hY3BpX21hdGNoX3RhYmxlYC4KPgo+IFRoZXJlIGlzIG5v
IHVzZXIgaW1wYWN0IG9yIGNoYW5nZSBpbiB2bWdlbmlkIGZ1bmN0aW9uYWxpdHkgd2hlbiB1c2Vk
Cj4gd2l0aCBBQ1BJLiBXZSB2ZXJpZmllZCBBQ1BJIHN1cHBvcnQgb2YgdGhlc2UgcGF0Y2hlcyBv
biBYODYgYW5kIERUCj4gc3VwcG9ydCBvbiBBUk0gdXNpbmcgRmlyZWNyYWNrZXIgaHlwZXJ2aXNv
cgo+IGh0dHBzOi8vZ2l0aHViLmNvbS9maXJlY3JhY2tlci1taWNyb3ZtL2ZpcmVjcmFja2VyLgo+
Cj4gVG8gY2hlY2sgc2NoZW1hIGFuZCBzeW50YXggZXJyb3JzLCB0aGUgYmluZGluZ3MgZmlsZSBp
cyB2ZXJpZmllZCB3aXRoOgo+IGBgYAo+ICAgIG1ha2UgZHRfYmluZGluZ19jaGVjayBcCj4gICAg
RFRfU0NIRU1BX0ZJTEVTPVwKPiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cm5nL21pY3Jvc29mdCx2bWdlbmlkLnlhbWwKPiBgYGAKPiBhbmQgdGhlIHBhdGNoZXMgd2VyZSB2
ZXJpZmllZCB3aXRoOgo+IGBzY3JpcHRzL2NoZWNrcGF0Y2gucGwgLS1zdHJpY3QgdjUtMDAwKmAu
Cj4KPiBDaGFuZ2Vsb2cgd2l0aCByZXNwZWN0IHRvIHZlcnNpb24gNDoKPiAtIFJlbW92ZWQgX19t
YXliZV91bnVzZWQgYXR0cmlidXRlIGZyb20gdm1nZW5pZF9vZl9pcnFfaGFuZGxlciBzaW5jZSBp
dAo+ICAgIGlzIGFsd2F5cyBjb21waWxlZCBpbiAodXNlZCBieSB2bWdlbmlkX2FkZF9vZikuCj4K
PiBDaGFuZ2Vsb2cgd2l0aCByZXNwZWN0IHRvIHZlcnNpb24gMzoKPiAtIENoYW5nZWQgdGhlIGNv
bXBhdGlibGUgc3RyaW5nIGZyb20gInZpcnR1YWwsdm1nZW5jdHIiIHRvCj4gICAgIm1pY3Jvc29m
dCx2bWdlbmlkIiBhcyBwZXIgcmV2aWV3IGNvbW1lbnRzLgo+IC0gUmVuYW1lZCB2bWdlbmlkLnlh
bWwgdG8gZm9sbG93IERUIGZpbGUgbmFtaW5nIGNvbnZlbnRpb24uCj4gLSBVcGRhdGVkIHRoZSBk
ZXNjcmlwdGlvbiBvZiBwcm9wZXJ0aWVzIGFuZCBleGFtcGxlIGluIHZtZ2VuaWQgeWFtbCBmaWxl
Lgo+IC0gQWRkcmVzc2VkIHRoZSByZXZpZXcgY29tbWVudHMgdG8gcmVtb3ZlIGFsbCBpZmRlZnMg
aW4gdm1nZW5pZC5jIHdpdGggb25lCj4gICAgZXhjZXB0aW9uIHdoaWNoIHN0aWxsIG5lZWRzIHRv
IGJlIHVuZGVyIENPTkZJR19BQ1BJLgo+IC0gcmVmb3JtYXRlZCB0aGUgY29kZSB3aXRoIGNsYW5n
LWZvcm1hdC4KPiAtIFRlc3RlZCBjb2RlIHdpdGggVz0xLCBTcGFyc2UsIFNtYXRjaCBhbmQgQ29j
Y2luZWxsZSB0b29scy4KPgo+IENoYW5nZWxvZyB3aXRoIHJlc3BlY3QgdG8gdmVyc2lvbiAyOgo+
IC0gQXMgcGVyIHJldmlldyBjb21tZW50cywgdXNlZCBwbGF0Zm9ybSBhcGlzIGluc3RlYWQgb2Yg
Im9mXyoiIEFQSXMsCj4gICAgcmVtb3ZlZCB1bm5lY2Vzc2FyeSAjaW5jbHVkZSBhbmQgdXNlZCBJ
Rl9FTkFCTEVEIGluc3RlYWQgb2YgaWZkZWYuCj4gLSBBZGRlZCBtb3JlIGluZm8gZm9yIHZtZ2Vu
aWQgYnVmZmVyIGFkZHJlc3MgYW5kIGNvcnJlY3RlZCB0aGUgZm9ybWF0dGluZy4KPiAtIFJlcGxh
Y2VkIHRoZSBjb21wYXRpYmxlIHN0cmluZyBmcm9tICJsaW51eCwqIiB0byAidmlydHVhbCwqIiBi
ZWNhdXNlLAo+ICAgIHRoZSBkZXZpY2UgZG9lcyBub3QgaGF2ZSBhIHZlbmRvci4KPgo+IENoYW5n
ZWxvZyB3aXRoIHJlc3BlY3QgdG8gdmVyc2lvbiAxOgo+IC0gTW92ZWQgdm1nZW5pZC55YW1sIGJp
bmRpbmdzIHRvIHRoZSBtb3JlIHJlbGF0ZWQgInJuZyIgZm9sZGVyLgo+IC0gUmVtb3ZlZCBgdm1n
ZW5pZF9yZW1vdmVgIHRvIHNpbmNlIGl0IGlzIHVucmVsYXRlZCB0byB0aGUKPiAgICBjdXJyZW50
IGdvYWwgb2YgdGhlIHBhdGNoLgo+IC0gVXBkYXRlZCB0aGUgY292ZXIgbGV0dGVyIGFuZCBiaW5k
aW5ncyBjb21taXQKPiAgICAiW1BBVENIIHYyIDMvNF0gZHQtYmluZGluZ3M6IHJuZzogQWRkIHZt
Z2VuaWQgc3VwcG9ydCIgdG8KPiAgICBwcm92aWRlIG1vcmUgaW5mb3JtYXRpb24gb24gdm1nZW5p
ZC4KPiAtIENvbXBpbGVkIHdpdGggYW5kIHdpdGhvdXQgQ09ORklHX09GL0NPTkZJR19BQ1BJIGFu
ZCBmaXhlZAo+ICAgIGNvbXBpbGVycyBlcnJvcnMvd2FybmluZ3MuCj4KPiBTdWRhbiBMYW5kZ2Ug
KDUpOgo+ICAgIHZpcnQ6IHZtZ2VuaWQ6IHJlYXJyYW5nZSBjb2RlIHRvIG1ha2UgcmV2aWV3IGVh
c2llcgo+ICAgIHZpcnQ6IHZtZ2VuaWQ6IGNoYW5nZSBpbXBsZW1lbnRhdGlvbiB0byB1c2UgYSBw
bGF0Zm9ybSBkcml2ZXIKPiAgICB2aXJ0OiB2bWdlbmlkOiBlbmFibGUgZHJpdmVyIHJlZ2FyZGxl
c3Mgb2YgQUNQSSBjb25maWcKPiAgICBkdC1iaW5kaW5nczogcm5nOiBBZGQgdm1nZW5pZCBzdXBw
b3J0Cj4gICAgdmlydDogdm1nZW5pZDogYWRkIHN1cHBvcnQgZm9yIGRldmljZXRyZWUgYmluZGlu
Z3MKPgo+ICAgLi4uL2JpbmRpbmdzL3JuZy9taWNyb3NvZnQsdm1nZW5pZC55YW1sICAgICAgIHwg
IDQ5ICsrKysrCj4gICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDEgKwo+ICAgZHJpdmVycy92aXJ0L0tjb25maWcgICAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAxIC0KPiAgIGRyaXZlcnMvdmlydC92bWdlbmlkLmMgICAgICAgICAgICAgICAgICAg
ICAgICB8IDE2OCArKysrKysrKysrKysrKy0tLS0KPiAgIDQgZmlsZXMgY2hhbmdlZCwgMTgwIGlu
c2VydGlvbnMoKyksIDM5IGRlbGV0aW9ucygtKQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9ybmcvbWljcm9zb2Z0LHZtZ2VuaWQueWFtbAoK
CklmIHlvdSBmaXggdGhlIGF1dGhvcnNoaXAgYW5kIHRhZyBpc3N1ZXMgSSBtZW50aW9uZWQ6CgpS
ZXZpZXdlZC1ieTogQWxleGFuZGVyIEdyYWYgPGdyYWZAYW1hem9uLmNvbT4KCgpBbGV4CgoKCgpB
bWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDEx
NyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhh
biBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRzZ2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBI
UkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVzdC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


