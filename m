Return-Path: <linux-kernel+bounces-146669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D47DF8A68FF
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037931C2080D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 10:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEBC012838C;
	Tue, 16 Apr 2024 10:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="OXoFCQEv"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D5A1E87F;
	Tue, 16 Apr 2024 10:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713264561; cv=none; b=A/eo5WtTgS4YpxrAd71A+w+tfCyVXU3u/4PVez63Mqal51mQSe465L1uKKEebr06vhK4bJnvN7x7fdbEfRtT/uueOQ/x3bRuuAS4AtbN/h8NTK8e05v5t+Ip9QgKvgFvBTzVUquebqRBBvbDXmJYaDi0UIa1bVlCuVPfWRZK6hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713264561; c=relaxed/simple;
	bh=dvJcRkDcOYvTOPU0mGAQp2V/Y335Vt6tbDSC/X9K+h0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=N4c0/XGC0SoGpcexNJ2ChF/loFg0yBxJL6Huejt3ADTn4Ui6kPwQiKlbsZAmh1cr/M5y+7Ep3+/7Yv0xn3jks0ruCxlUy6K79Mt7AJcGKcuXyTQ3nRKWCXdPfNVExJq0N+2kQ3c6lIquBjrMrb95CdkIe0fz1NI6aQ1VtH3Iy8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=OXoFCQEv; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1713264559; x=1744800559;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dvJcRkDcOYvTOPU0mGAQp2V/Y335Vt6tbDSC/X9K+h0=;
  b=OXoFCQEvnSVvJ6hfrNW1DGlX5fRgv2Vyxf9HhYw0B/exH6gwKBD13gTZ
   gTsFRywKEX8ilRUBbFZauxrLRd7i07jCd7c+4y8QliMuueTbk0j8mUMlo
   F8k5IjkS0WdvD9aQRNYEh4kYPL0eqjiXsBrkGJE32TKQ2sS17kXjEnMx0
   Q=;
X-IronPort-AV: E=Sophos;i="6.07,205,1708387200"; 
   d="scan'208";a="289063697"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2024 10:49:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:55795]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.158:2525] with esmtp (Farcaster)
 id f4860a70-a43f-467b-ad02-f419effe1c13; Tue, 16 Apr 2024 10:49:17 +0000 (UTC)
X-Farcaster-Flow-ID: f4860a70-a43f-467b-ad02-f419effe1c13
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 16 Apr 2024 10:49:16 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 16 Apr
 2024 10:49:13 +0000
Message-ID: <1e4fad99-76d4-4c45-a924-b78b597c7cd6@amazon.de>
Date: Tue, 16 Apr 2024 12:49:11 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] virt: vmgenid: add support for devicetree bindings
Content-Language: en-US
To: Sudan Landge <sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <dwmw@amazon.co.uk>, <bchalios@amazon.es>, <xmarcalx@amazon.co.uk>
References: <20240409181154.9962-1-sudanl@amazon.com>
 <20240409181154.9962-6-sudanl@amazon.com>
From: Alexander Graf <graf@amazon.de>
In-Reply-To: <20240409181154.9962-6-sudanl@amazon.com>
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

Ck9uIDA5LjA0LjI0IDIwOjExLCBTdWRhbiBMYW5kZ2Ugd3JvdGU6Cj4gRXh0ZW5kIHRoZSB2bWdl
bmlkIHBsYXRmb3JtIGRyaXZlciB0byBzdXBwb3J0IGRldmljZXRyZWUgYmluZGluZ3MuCj4gV2l0
aCB0aGlzIHN1cHBvcnQsIGh5cGVydmlzb3JzIGNhbiBzZW5kIHZtZ2VuaWQgbm90aWZpY2F0aW9u
cyB0bwo+IHRoZSB2aXJ0dWFsIG1hY2hpbmUgd2l0aG91dCB0aGUgbmVlZCB0byBlbmFibGUgQUNQ
SS4KPiBUaGUgYmluZGluZ3MgYXJlIGxvY2F0ZWQgYXQ6Cj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3JuZy9taWNyb3NvZnQsdm1nZW5pZC55YW1sCj4KPiBTaWduZWQtb2ZmLWJ5
OiBTdWRhbiBMYW5kZ2UgPHN1ZGFubEBhbWF6b24uY29tPgo+IC0tLQo+ICAgZHJpdmVycy92aXJ0
L3ZtZ2VuaWQuYyB8IDUzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKyst
LQo+ICAgMSBmaWxlIGNoYW5nZWQsIDUxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYyBiL2RyaXZlcnMvdmlydC92bWdl
bmlkLmMKPiBpbmRleCAzZDkzZTNmYjk0YzQuLmUxYWQ3NDExNmMwYyAxMDA2NDQKPiAtLS0gYS9k
cml2ZXJzL3ZpcnQvdm1nZW5pZC5jCj4gKysrIGIvZHJpdmVycy92aXJ0L3ZtZ2VuaWQuYwo+IEBA
IC0yLDEyICsyLDEzIEBACj4gICAvKgo+ICAgICogQ29weXJpZ2h0IChDKSAyMDIyIEphc29uIEEu
IERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPi4gQWxsIFJpZ2h0cyBSZXNlcnZlZC4KPiAgICAq
Cj4gLSAqIFRoZSAiVmlydHVhbCBNYWNoaW5lIEdlbmVyYXRpb24gSUQiIGlzIGV4cG9zZWQgdmlh
IEFDUEkgYW5kIGNoYW5nZXMgd2hlbiBhCj4gKyAqIFRoZSAiVmlydHVhbCBNYWNoaW5lIEdlbmVy
YXRpb24gSUQiIGlzIGV4cG9zZWQgdmlhIEFDUEkgb3IgRFQgYW5kIGNoYW5nZXMgd2hlbiBhCj4g
ICAgKiB2aXJ0dWFsIG1hY2hpbmUgZm9ya3Mgb3IgaXMgY2xvbmVkLiBUaGlzIGRyaXZlciBleGlz
dHMgZm9yIHNoZXBoZXJkaW5nIHRoYXQKPiAgICAqIGluZm9ybWF0aW9uIHRvIHJhbmRvbS5jLgo+
ICAgICovCj4gICAKPiAgICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+Cj4gKyNpbmNsdWRlIDxsaW51
eC9pbnRlcnJ1cHQuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4KPiAgICNpbmNsdWRl
IDxsaW51eC9tb2R1bGUuaD4KPiAgICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4K
PiBAQCAtMjAsNiArMjEsNyBAQCBlbnVtIHsgVk1HRU5JRF9TSVpFID0gMTYgfTsKPiAgIHN0cnVj
dCB2bWdlbmlkX3N0YXRlIHsKPiAgIAl1OCAqbmV4dF9pZDsKPiAgIAl1OCB0aGlzX2lkW1ZNR0VO
SURfU0laRV07Cj4gKwlpbnQgaXJxOwo+ICAgfTsKPiAgIAo+ICAgc3RhdGljIHZvaWQgdm1nZW5p
ZF9ub3RpZnkoc3RydWN0IGRldmljZSAqZGV2aWNlKQo+IEBAIC00Myw2ICs0NSwxNCBAQCB2bWdl
bmlkX2FjcGlfaGFuZGxlcihhY3BpX2hhbmRsZSBfX2Fsd2F5c191bnVzZWQgaGFuZGxlLAo+ICAg
CXZtZ2VuaWRfbm90aWZ5KGRldik7Cj4gICB9Cj4gICAKPiArc3RhdGljIF9fbWF5YmVfdW51c2Vk
IGlycXJldHVybl90CgoKV2h5IGlzIHRoaXMgbWF5YmVfdW51c2VkPyBJdCBzZWVtcyB0byBiZSBh
bHdheXMgcmVmZXJlbmNlZCBieSAKdm1nZW5pZF9hZGRfb2YoKSwgbm8/CgoKPiArdm1nZW5pZF9v
Zl9pcnFfaGFuZGxlcihpbnQgX19hbHdheXNfdW51c2VkIGlycSwgdm9pZCAqZGV2KQo+ICt7Cj4g
Kwl2bWdlbmlkX25vdGlmeShkZXYpOwo+ICsKPiArCXJldHVybiBJUlFfSEFORExFRDsKPiArfQo+
ICsKPiAgIHN0YXRpYyBpbnQgX19tYXliZV91bnVzZWQKPiAgIHNldHVwX3ZtZ2VuaWRfc3RhdGUo
c3RydWN0IHZtZ2VuaWRfc3RhdGUgKnN0YXRlLCB1OCAqbmV4dF9pZCkKPiAgIHsKPiBAQCAtMTA2
LDYgKzExNiwzNSBAQCBzdGF0aWMgaW50IHZtZ2VuaWRfYWRkX2FjcGkoc3RydWN0IGRldmljZSBf
X21heWJlX3VudXNlZCAqZGV2LAo+ICAgI2VuZGlmCj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2
bWdlbmlkX2FkZF9vZihzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+ICsJCQkgIHN0cnVj
dCB2bWdlbmlkX3N0YXRlICpzdGF0ZSkKPiArewo+ICsJdTggKnZpcnRfYWRkcjsKPiArCWludCBy
ZXQgPSAwOwo+ICsKPiArCXZpcnRfYWRkciA9ICh1OCAqKWRldm1fcGxhdGZvcm1fZ2V0X2FuZF9p
b3JlbWFwX3Jlc291cmNlKHBkZXYsIDAsIE5VTEwpOwo+ICsJaWYgKElTX0VSUih2aXJ0X2FkZHIp
KQo+ICsJCXJldHVybiBQVFJfRVJSKHZpcnRfYWRkcik7Cj4gKwo+ICsJcmV0ID0gc2V0dXBfdm1n
ZW5pZF9zdGF0ZShzdGF0ZSwgdmlydF9hZGRyKTsKPiArCWlmIChyZXQpCj4gKwkJcmV0dXJuIHJl
dDsKPiArCj4gKwlyZXQgPSBwbGF0Zm9ybV9nZXRfaXJxKHBkZXYsIDApOwo+ICsJaWYgKHJldCA8
IDApCj4gKwkJcmV0dXJuIHJldDsKCgpEb2Vzbid0IHRoaXMgZXJyb3IgcGF0aCBuZWVkIHRvIGRv
IHNvbWV0aGluZyBhYm91dCB0aGUgaW9yZW1hcCdlZCAKcmVzb3VyY2U/IE9yIGRvZXMgZGV2bSBk
byB0aGF0IGF1dG9tYXRpY2FsbHkgZm9yIHlvdT8KCkFsZXgKCgo+ICsKPiArCXN0YXRlLT5pcnEg
PSByZXQ7Cj4gKwlwZGV2LT5kZXYuZHJpdmVyX2RhdGEgPSBzdGF0ZTsKPiArCj4gKwlyZXQgPSBk
ZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHN0YXRlLT5pcnEsIHZtZ2VuaWRfb2ZfaXJxX2hh
bmRsZXIsCj4gKwkJCSAgICAgICBJUlFGX1NIQVJFRCwgInZtZ2VuaWQiLCAmcGRldi0+ZGV2KTsK
PiArCWlmIChyZXQpCj4gKwkJcGRldi0+ZGV2LmRyaXZlcl9kYXRhID0gTlVMTDsKPiArCj4gKwly
ZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2bWdlbmlkX2FkZChzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2KQo+ICAgewo+ICAgCXN0cnVjdCB2bWdlbmlkX3N0YXRlICpzdGF0
ZTsKPiBAQCAtMTE2LDcgKzE1NSwxMCBAQCBzdGF0aWMgaW50IHZtZ2VuaWRfYWRkKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpCj4gICAJaWYgKCFzdGF0ZSkKPiAgIAkJcmV0dXJuIC1FTk9N
RU07Cj4gICAKPiAtCXJldCA9IHZtZ2VuaWRfYWRkX2FjcGkoZGV2LCBzdGF0ZSk7Cj4gKwlpZiAo
ZGV2LT5vZl9ub2RlKQo+ICsJCXJldCA9IHZtZ2VuaWRfYWRkX29mKHBkZXYsIHN0YXRlKTsKPiAr
CWVsc2UKPiArCQlyZXQgPSB2bWdlbmlkX2FkZF9hY3BpKGRldiwgc3RhdGUpOwo+ICAgCj4gICAJ
aWYgKHJldCkKPiAgIAkJZGV2bV9rZnJlZShkZXYsIHN0YXRlKTsKPiBAQCAtMTI0LDYgKzE2Niwx
MiBAQCBzdGF0aWMgaW50IHZtZ2VuaWRfYWRkKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
Cj4gICAJcmV0dXJuIHJldDsKPiAgIH0KPiAgIAo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2Rl
dmljZV9pZCB2bWdlbmlkX29mX2lkc1tdID0gewo+ICsJeyAuY29tcGF0aWJsZSA9ICJtaWNyb3Nv
ZnQsdm1nZW5pZCIsIH0sCj4gKwl7IH0sCj4gK307Cj4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2Ys
IHZtZ2VuaWRfb2ZfaWRzKTsKPiArCj4gICBzdGF0aWMgY29uc3Qgc3RydWN0IGFjcGlfZGV2aWNl
X2lkIHZtZ2VuaWRfYWNwaV9pZHNbXSA9IHsKPiAgIAl7ICJWTUdFTkNUUiIsIDAgfSwKPiAgIAl7
ICJWTV9HRU5fQ09VTlRFUiIsIDAgfSwKPiBAQCAtMTM2LDYgKzE4NCw3IEBAIHN0YXRpYyBzdHJ1
Y3QgcGxhdGZvcm1fZHJpdmVyIHZtZ2VuaWRfcGxhZm9ybV9kcml2ZXIgPSB7Cj4gICAJLmRyaXZl
ciAgICAgPSB7Cj4gICAJCS5uYW1lICAgPSAidm1nZW5pZCIsCj4gICAJCS5hY3BpX21hdGNoX3Rh
YmxlID0gdm1nZW5pZF9hY3BpX2lkcywKPiArCQkub2ZfbWF0Y2hfdGFibGUgPSB2bWdlbmlkX29m
X2lkcywKPiAgIAl9LAo+ICAgfTsKPiAgIAoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


