Return-Path: <linux-kernel+bounces-148161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5699D8A7E7F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 797CE1C20D3B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622B212836B;
	Wed, 17 Apr 2024 08:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="DHrzR7is"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291A31EB40;
	Wed, 17 Apr 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343301; cv=none; b=kG/e0FEpIBzffRYcnnjo+rfdAg6Hc60QHRFTanNKSnR5z+E0OBE0M0fMoNtDwAr3H0IJTCRqelZmFoSnee+RR5jRwnfssUMVcw4jFNr2nZdMeuZ3a3BFppzfX59M/+73qCZ3P6VJ0FIZuHB6VcqU3MtjqCSX+mrnyuTQ3LrSMCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343301; c=relaxed/simple;
	bh=WNL7edicChusUZPfeo0gpF75EN9nkKjkx/kJWPaau1k=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Xd6GMIjRxlysstS3j2LHDXbXSPpKw4cNq7wpPKU1WAuZbvEK2zYODpbRKDTo/dzSv+Zzio/K2yGinZRSSyoswBjFQV3jhk8Xjmkndvau3z391HUokFuF9uFGdBwDun/QnhTZlsjb5v6jzVYnAcrqDYMEAa0a6GHa4YMqCMSdGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=DHrzR7is; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1713343301; x=1744879301;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WNL7edicChusUZPfeo0gpF75EN9nkKjkx/kJWPaau1k=;
  b=DHrzR7isbavITP42X82JiNg8wUZSclEGKU1LUBckNumplO8vJ2iqa1dE
   qQFCCTQGnPWGjCuYmaXq4AALcXe+elNkxZwYTo6Tz98zU14Pest+K6Nu/
   tM5UqIBV7Ihme4au5RElzaIhi/vGbPoRBVzjR8gtmK75K/yCsXgd2YorQ
   g=;
X-IronPort-AV: E=Sophos;i="6.07,208,1708387200"; 
   d="scan'208";a="289390224"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 08:41:39 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:15035]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.244:2525] with esmtp (Farcaster)
 id 8e05b225-33da-4e6a-9fb4-520891d729d3; Wed, 17 Apr 2024 08:41:37 +0000 (UTC)
X-Farcaster-Flow-ID: 8e05b225-33da-4e6a-9fb4-520891d729d3
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 08:41:35 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Wed, 17 Apr
 2024 08:41:31 +0000
Message-ID: <f844d0a6-f18e-4f0d-bfcb-80a5008b07a4@amazon.de>
Date: Wed, 17 Apr 2024 10:41:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] dt-bindings: rng: Add vmgenid support
Content-Language: en-US
To: Babis Chalios <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<olivia@selenic.com>, <herbert@gondor.apana.org.au>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>
References: <20240417081212.99657-1-bchalios@amazon.es>
 <20240417081212.99657-5-bchalios@amazon.es>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20240417081212.99657-5-bchalios@amazon.es>
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDE3LjA0LjI0IDEwOjEyLCBCYWJpcyBDaGFsaW9zIHdyb3RlOgo+IEZyb206IFN1ZGFuIExh
bmRnZSA8c3VkYW5sQGFtYXpvbi5jb20+Cj4KPiBWaXJ0dWFsIE1hY2hpbmUgR2VuZXJhdGlvbiBJ
RCBkcml2ZXIgd2FzIGludHJvZHVjZWQgaW4gY29tbWl0IGFmNmI1NGUyYjViYQo+ICgidmlydDog
dm1nZW5pZDogbm90aWZ5IFJORyBvZiBWTSBmb3JrIGFuZCBzdXBwbHkgZ2VuZXJhdGlvbiBJRCIp
LCBhcyBhbgo+IEFDUEkgb25seSBkZXZpY2UuCj4KPiBWTUdlbklEIHNwZWNpZmljYXRpb24gaHR0
cDovL2dvLm1pY3Jvc29mdC5jb20vZndsaW5rLz9MaW5rSWQ9MjYwNzA5IGRlZmluZXMKPiBhIG1l
Y2hhbmlzbSBmb3IgdGhlIEJJT1MvaHlwZXJ2aXNvcnMgdG8gY29tbXVuaWNhdGUgdG8gdGhlIHZp
cnR1YWwgbWFjaGluZQo+IHRoYXQgaXQgaXMgZXhlY3V0ZWQgd2l0aCBhIGRpZmZlcmVudCBjb25m
aWd1cmF0aW9uIChlLmcuIHNuYXBzaG90IGV4ZWN1dGlvbgo+IG9yIGNyZWF0aW9uIGZyb20gYSB0
ZW1wbGF0ZSkuCj4gVGhlIGd1ZXN0IG9wZXJhdGluZyBzeXN0ZW0gY2FuIHVzZSB0aGUgbm90aWZp
Y2F0aW9uIGZvciB2YXJpb3VzIHB1cnBvc2VzCj4gc3VjaCBhcyByZS1pbml0aWFsaXppbmcgaXRz
IHJhbmRvbSBudW1iZXIgZ2VuZXJhdG9yIGV0Yy4KPgo+IEFzIHBlciB0aGUgc3BlY3MsIGh5cGVy
dmlzb3Igc2hvdWxkIHByb3ZpZGUgYSBnbG9iYWxseSB1bmlxdWUgaWRlbnRpZmllZCwKPiBvciBH
VUlEIHZpYSBBQ1BJLgo+Cj4gVGhpcyBwYXRjaCB0cmllcyB0byBtaW1pYyB0aGUgbWVjaGFuaXNt
IHRvIHByb3ZpZGUgdGhlIHNhbWUgZnVuY3Rpb25hbGl0eQo+IHdoaWNoIGlzIGZvciBhIGh5cGVy
dmlzb3IvQklPUyB0byBub3RpZnkgdGhlIHZpcnR1YWwgbWFjaGluZSB3aGVuIGl0IGlzCj4gZXhl
Y3V0ZWQgd2l0aCBhIGRpZmZlcmVudCBjb25maWd1cmF0aW9uLgo+Cj4gQXMgcGFydCBvZiB0aGlz
IHN1cHBvcnQgdGhlIGRldmljZXRyZWUgYmluZGluZ3MgcmVxdWlyZXMgdGhlIGh5cGVydmlzb3Jz
IG9yCj4gQklPUyB0byBwcm92aWRlIGEgbWVtb3J5IGFkZHJlc3Mgd2hpY2ggaG9sZHMgdGhlIEdV
SUQgYW5kIGFuIElSUSB3aGljaCBpcwo+IHVzZWQgdG8gbm90aWZ5IHdoZW4gdGhlcmUgaXMgYSBj
aGFuZ2UgaW4gdGhlIEdVSUQuCj4gVGhlIG1lbW9yeSBleHBvc2VkIGluIHRoZSBEVCBzaG91bGQg
Zm9sbG93IHRoZSBydWxlcyBkZWZpbmVkIGluIHRoZQo+IHZtZ2VuaWQgc3BlYyBtZW50aW9uZWQg
YWJvdmUuCj4KPiAqUmVhc29uIGZvciB0aGlzIGNoYW5nZSo6Cj4gQ2hvc2luZyBBQ1BJIG9yIGRl
dmljZXRyZWUgaXMgYW4gaW50cmluc2ljIHBhcnQgb2YgYW4gaHlwZXJ2aXNvciBkZXNpZ24uCj4g
V2l0aG91dCBnb2luZyBpbnRvIGRldGFpbHMgb2Ygd2h5IGEgaHlwZXJ2aXNvciB3b3VsZCBjaG9z
ZSBEVCBvdmVyIEFDUEksCj4gd2Ugd291bGQgbGlrZSB0byBoaWdobGlnaHQgdGhhdCB0aGUgaHlw
ZXJ2aXNvcnMgdGhhdCBoYXZlIGNob3NlIGRldmljZXRyZWUKPiBhbmQgbm93IHdhbnQgdG8gbWFr
ZSB1c2Ugb2YgdGhlIHZtZ2VuaWQgZnVuY3Rpb25hbGl0eSBjYW5ub3QgZG8gc28gdG9kYXkKPiBi
ZWNhdXNlIHZtZ2VuaWQgaXMgYW4gQUNQSSBvbmx5IGRldmljZS4KPiBUaGlzIGZvcmNlcyB0aGVz
ZSBoeXBlcnZpc29ycyB0byBjaGFuZ2UgdGhlaXIgZGVzaWduIHdoaWNoIGNvdWxkIGhhdmUKPiB1
bmRlc2lyYWJsZSBpbXBhY3RzIG9uIHRoZWlyIHVzZS1jYXNlcywgdGVzdC1zY2VuYXJpb3MgZXRj
Lgo+Cj4gVGhlIHBvaW50IG9mIHZtZ2VuaWQgaXMgdG8gcHJvdmlkZSBhIG1lY2hhbmlzbSB0byBk
aXNjb3ZlciBhIEdVSUQgd2hlbgo+IHRoZSBleGVjdXRpb24gc3RhdGUgb2YgYSB2aXJ0dWFsIG1h
Y2hpbmUgY2hhbmdlcyBhbmQgdGhlIHNpbXBsZXN0Cj4gd2F5IHRvIGRvIGl0IGlzIHBhc3MgYSBt
ZW1vcnkgbG9jYXRpb24gYW5kIGFuIGludGVycnVwdCB2aWEgZGV2aWNldHJlZS4KPiBJdCB3b3Vs
ZCBjb21wbGljYXRlIHRoaW5ncyB1bm5lY2Vzc2FyaWx5IGlmIGluc3RlYWQgb2YgdXNpbmcgZGV2
aWNldHJlZSwKPiB3ZSB0cnkgdG8gaW1wbGVtZW50IGEgbmV3IHByb3RvY29sIG9yIG1vZGlmeSBv
dGhlciBwcm90b2NvbHMgdG8gc29tZWhvdwo+IHByb3ZpZGUgdGhlIHNhbWUgZnVuY3Rpb25pbGl0
eS4KPgo+IFdlIGJlbGlldmUgdGhhdCBhZGRpbmcgYSBkZXZpY2V0cmVlIGJpbmRpbmcgZm9yIHZt
Z2VuaWQgaXMgYSBzaW1wbGVyLAo+IGJldHRlciBhbHRlcm5hdGl2ZSB0byBwcm92aWRlIHRoZSBz
YW1lIGZ1bmN0aW9uYWxpdHkgYW5kIHdpbGwgYWxsb3cKPiBzdWNoIGh5cGVydmlzb3JzIGFzIG1l
bnRpb25lZCBhYm92ZSB0byBjb250aW51ZSB1c2luZyBkZXZpY2V0cmVlLgo+Cj4gTW9yZSByZWZl
cmVuY2VzIHRvIHZtZ2VuaWQgc3BlY3M6Cj4gICAtIGh0dHBzOi8vd3d3LnFlbXUub3JnL2RvY3Mv
bWFzdGVyL3NwZWNzL3ZtZ2VuaWQuaHRtbAo+ICAgLSBodHRwczovL2xlYXJuLm1pY3Jvc29mdC5j
b20vZW4tdXMvd2luZG93cy93aW4zMi9oeXBlcnZfdjIvdmlydHVhbC0KPiBtYWNoaW5lLWdlbmVy
YXRpb24taWRlbnRpZmllcgo+Cj4gU2lnbmVkLW9mZi1ieTogU3VkYW4gTGFuZGdlIDxzdWRhbmxA
YW1hem9uLmNvbT4KCgpUaGlzIHdhcyByZXZpZXdlZCBieSBSb2IgYmVmb3JlLiBNYWtlIHN1cmUg
dG8gcHJvcGFnYXRlIGhpcyBSZXZpZXdlZC1ieSAKaW50byBuZXcgdmVyc2lvbnMgb2YgdGhlIHBh
dGNoIHNldCB1bmxlc3MgeW91IGNoYW5nZSB0aGUgcGF0Y2ggaW4gCnF1ZXN0aW9uIHNpZ25pZmlj
YW50bHkgZW5vdWdoIHRoYXQgaXQgaW52YWxpZGF0ZXMgdGhlIHJldmlldy4KCgpBbGV4CgoKCgoK
QW1hem9uIERldmVsb3BtZW50IENlbnRlciBHZXJtYW55IEdtYkgKS3JhdXNlbnN0ci4gMzgKMTAx
MTcgQmVybGluCkdlc2NoYWVmdHNmdWVocnVuZzogQ2hyaXN0aWFuIFNjaGxhZWdlciwgSm9uYXRo
YW4gV2Vpc3MKRWluZ2V0cmFnZW4gYW0gQW10c2dlcmljaHQgQ2hhcmxvdHRlbmJ1cmcgdW50ZXIg
SFJCIDE0OTE3MyBCClNpdHo6IEJlcmxpbgpVc3QtSUQ6IERFIDI4OSAyMzcgODc5CgoK


