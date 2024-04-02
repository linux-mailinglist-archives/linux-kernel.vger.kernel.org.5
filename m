Return-Path: <linux-kernel+bounces-127916-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 856AA8952C0
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:18:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCFACB26A31
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD217764E;
	Tue,  2 Apr 2024 12:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="RA9qqHZW"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEDA7A13A;
	Tue,  2 Apr 2024 12:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060249; cv=none; b=iAovvF0so57buiGulWg++mWsTxPo9DL4b9PTWhsYN+uqjg1y59GGUCKDvY4SCIedaysmxCoXMpB4TwGrOxSSwZF0V9wSrPUvkdA+9Gl7aq0iXBlgKAc3Afdk3Z/ILaHUxZwqlegHH9irRj6wkLNT2FBvqgXu4ZUOpRcyZY8gTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060249; c=relaxed/simple;
	bh=4hEjMOf/NYnnalU9LSz9bSigo7540Wp8lxyJZKstsSo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=njyIFMgUSdfD++xirUo0qP9W06FR1qmFDwIkPVxngokMODipcLbiJvZk6GgQd/cO5tw4hss0RmC+cLD+VLPIbgztxk2SnQwp6kz1JAmE0vZfFULne5u9DkBB2dHf6VQ55jfsV2YUMSXqDF32mnXsP5RKJPV+ZrnWKPiVXTAMUg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=RA9qqHZW; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1712060248; x=1743596248;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:mime-version:content-transfer-encoding:subject;
  bh=4hEjMOf/NYnnalU9LSz9bSigo7540Wp8lxyJZKstsSo=;
  b=RA9qqHZWl1mPWK1/JrGV5LrOA/1gwaf4bQ+ysY/HJkeJaRfZwc1puM8b
   U7CLGoKKjUlkMmKqLdRyUD2MF2tSgJVChjJZgmgUDKfuXWxJX96i9PWcy
   63CEUXF3eymCnsWt4+5tVhlJzzYMRKhFttI1ylQWk4qSRRm2jKKkQER8f
   o=;
X-IronPort-AV: E=Sophos;i="6.07,174,1708387200"; 
   d="scan'208";a="285550647"
Subject: Re: [PATCH 2/2] arm64: acpi: Honour firmware_signature field of FACS,
 if it exists
Thread-Topic: [PATCH 2/2] arm64: acpi: Honour firmware_signature field of FACS,
 if it exists
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2024 12:17:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:39814]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.222:2525] with esmtp (Farcaster)
 id 5e1056fb-976d-4441-9bbb-62d2328f612c; Tue, 2 Apr 2024 12:17:25 +0000 (UTC)
X-Farcaster-Flow-ID: 5e1056fb-976d-4441-9bbb-62d2328f612c
Received: from EX19D002UWA004.ant.amazon.com (10.13.138.230) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 12:17:24 +0000
Received: from EX19D026EUB001.ant.amazon.com (10.252.61.12) by
 EX19D002UWA004.ant.amazon.com (10.13.138.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 2 Apr 2024 12:17:23 +0000
Received: from EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1]) by
 EX19D026EUB001.ant.amazon.com ([fe80::461a:a9c3:6352:d9d1%4]) with mapi id
 15.02.1258.028; Tue, 2 Apr 2024 12:17:22 +0000
From: "Mediouni, Mohamed" <mediou@amazon.de>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: David Woodhouse <dwmw2@infradead.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Robert Moore
	<robert.moore@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>, "Saidi, Ali" <alisaidi@amazon.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"acpica-devel@lists.linux.dev" <acpica-devel@lists.linux.dev>, Saket Dumbre
	<saket.dumbre@intel.com>
Thread-Index: AQHadIMiZU/jJeIGnU6Fy/VUAgcff7FU16CAgAAQqoCAAB4RAA==
Date: Tue, 2 Apr 2024 12:17:22 +0000
Message-ID: <70B4B352-08A5-4922-93A0-7F420374A831@amazon.de>
References: <20240312134148.727454-1-dwmw2@infradead.org>
 <20240312134148.727454-2-dwmw2@infradead.org>
 <dbd60df4632e5ea9cef13cdc1a406b47bd8629da.camel@infradead.org>
 <ZgveD6Hb2HbTNYNO@bogus>
In-Reply-To: <ZgveD6Hb2HbTNYNO@bogus>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Content-Type: text/plain; charset="utf-8"
Content-ID: <78F138E12F3542458D20E71B702575CD@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: base64

DQoNCj4gT24gMi4gQXByIDIwMjQsIGF0IDEyOjI5LCBTdWRlZXAgSG9sbGEgPHN1ZGVlcC5ob2xs
YUBhcm0uY29tPiB3cm90ZToNCj4gDQo+IA0KPiBPbiBUdWUsIEFwciAwMiwgMjAyNCBhdCAxMDoy
OTo1N0FNICswMTAwLCBEYXZpZCBXb29kaG91c2Ugd3JvdGU6DQo+PiBPbiBUdWUsIDIwMjQtMDMt
MTIgYXQgMTM6NDEgKzAwMDAsIERhdmlkIFdvb2Rob3VzZSB3cm90ZToNCj4+PiBGcm9tOiBEYXZp
ZCBXb29kaG91c2UgPGR3bXdAYW1hem9uLmNvLnVrPg0KPj4+IA0KPj4+IElmIHRoZSBmaXJtd2Fy
ZV9zaWduYXR1cmUgY2hhbmdlcyB0aGVuIE9TUE0gc2hvdWxkIG5vdCBhdHRlbXB0IHRvIHJlc3Vt
ZQ0KPj4+IGZyb20gaGliZXJuYXRlLCBidXQgc2hvdWxkIGluc3RlYWQgcGVyZm9ybSBhIGNsZWFu
IHJlYm9vdC4gU2V0IHRoZSBnbG9iYWwNCj4+PiBzd3N1c3BfaGFyZHdhcmVfc2lnbmF0dXJlIHRv
IGFsbG93IHRoZSBnZW5lcmljIGNvZGUgdG8gaW5jbHVkZSB0aGUgdmFsdWUNCj4+PiBpbiB0aGUg
c3dzdXNwIGhlYWRlciBvbiBkaXNrLCBhbmQgcGVyZm9ybSB0aGUgYXBwcm9wcmlhdGUgY2hlY2sg
b24gcmVzdW1lLg0KPj4+IA0KPj4+IFNpZ25lZC1vZmYtYnk6IERhdmlkIFdvb2Rob3VzZSA8ZHdt
d0BhbWF6b24uY28udWs+DQo+PiANCj4+IFBpbmc/DQo+PiANCj4+PiAtLS0NCj4+PiBhcmNoL2Fy
bTY0L2tlcm5lbC9hY3BpLmMgfCAxMCArKysrKysrKysrDQo+Pj4gMSBmaWxlIGNoYW5nZWQsIDEw
IGluc2VydGlvbnMoKykNCj4+PiANCj4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9rZXJuZWwv
YWNwaS5jIGIvYXJjaC9hcm02NC9rZXJuZWwvYWNwaS5jDQo+Pj4gaW5kZXggZGJhOGZjZWM3ZjMz
Li5lMGU3YjkzYzE2Y2MgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9hcm02NC9rZXJuZWwvYWNwaS5j
DQo+Pj4gKysrIGIvYXJjaC9hcm02NC9rZXJuZWwvYWNwaS5jDQo+Pj4gQEAgLTI2LDYgKzI2LDcg
QEANCj4+PiAjaW5jbHVkZSA8bGludXgvbGliZmR0Lmg+DQo+Pj4gI2luY2x1ZGUgPGxpbnV4L3Nt
cC5oPg0KPj4+ICNpbmNsdWRlIDxsaW51eC9zZXJpYWxfY29yZS5oPg0KPj4+ICsjaW5jbHVkZSA8
bGludXgvc3VzcGVuZC5oPg0KPj4+ICNpbmNsdWRlIDxsaW51eC9wZ3RhYmxlLmg+DQo+Pj4gDQo+
Pj4gI2luY2x1ZGUgPGFjcGkvZ2hlcy5oPg0KPj4+IEBAIC0yMjcsNiArMjI4LDE1IEBAIHZvaWQg
X19pbml0IGFjcGlfYm9vdF90YWJsZV9pbml0KHZvaWQpDQo+Pj4gICAgICAgICAgICAgICAgaWYg
KGVhcmx5Y29uX2FjcGlfc3Bjcl9lbmFibGUpDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICBl
YXJseV9pbml0X2R0X3NjYW5fY2hvc2VuX3N0ZG91dCgpOw0KPj4+ICAgICAgICB9IGVsc2Ugew0K
Pj4+ICsjaWZkZWYgQ09ORklHX0hJQkVSTkFUSU9ODQo+Pj4gKyAgICAgICAgICAgICAgIHN0cnVj
dCBhY3BpX3RhYmxlX2hlYWRlciAqZmFjcyA9IE5VTEw7DQo+Pj4gKyAgICAgICAgICAgICAgIGFj
cGlfZ2V0X3RhYmxlKEFDUElfU0lHX0ZBQ1MsIDEsICZmYWNzKTsNCj4+PiArICAgICAgICAgICAg
ICAgaWYgKGZhY3MpIHsNCj4+PiArICAgICAgICAgICAgICAgICAgICAgICBzd3N1c3BfaGFyZHdh
cmVfc2lnbmF0dXJlID0NCj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICgoc3Ry
dWN0IGFjcGlfdGFibGVfZmFjcyAqKWZhY3MpLT5oYXJkd2FyZV9zaWduYXR1cmU7DQo+Pj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgYWNwaV9wdXRfdGFibGUoZmFjcyk7DQo+Pj4gKyAgICAgICAg
ICAgICAgIH0NCj4+PiArI2VuZGlmDQo+IA0KPiBJIHRoaW5rIGl0IGlzIE9LIGFzIGEgdGVtcG9y
YXJ5IHNvbHV0aW9uIGZvciBub3cuIEJ1dCB0aGVyZSB3YXMgc29tZQ0KPiBpbnZlc3RpZ2F0aW9u
IGxhc3QgeWVhciBhcyBwYXJ0IG9mIHNvbWUgd29yayBpbiBMaW5hcm8gdG8gZW5hYmxlDQo+ICJk
cml2ZXJzL2FjcGkvc2xlZXAuYyIgaW50byB0aGUgYnVpbGQgY2xlYW5pbmcgdXAgc29tZSB4ODYt
bmVzcyBpbiB0aGVyZS4NCj4gYWNwaV9zbGVlcF9oaWJlcm5hdGVfc2V0dXAoKSBhbHJlYWR5IGRv
ZXMgdGhpcyBidXQgZW5hYmxpbmcgc2xlZXAuYyBuZWVkDQo+IHNvbWUgY2FyZWZ1bCBpbnZlc3Rp
Z2F0aW9uIHNvIHRoYXQgaXQgZG9lc24ndCBicmVhayBhbnkgZXhpc3RpbmcgYXJtNjQveDg2DQo+
IHBsYXRmb3JtcyBhbmQgbWFkZSBuZWVkIHNvbWUgd29yZGluZ3MgY2xhcmlmaWNhdGlvbiBpbiB0
aGUgQUNQSSBzcGVjLg0KPiBUb2RheSBzeXN0ZW0gc3VzcGVuZCB3b3JrIHZpYSBwc2NpIHN0ZCBw
YXRoIGJ5cGFzc2luZyB0aGUgQUNQSSBwYXRocyB3aGljaA0KPiBtYXkgbm90IGJlIGlkZWFsIGFz
IG5vbmUgb2YgdGhlIEFDUEkgbWV0aG9kcyBhcmUgaG9ub3VyZWQuIFNvbWUgYXJtNjQNCj4gcGxh
dGZvcm1zIG1heSBpbXBsZW1lbnQgdGhlbSBhbmQgZXhwZWN0IHRvIGJlIGV4ZWN1dGVkIGluIHRo
ZSBmdXR1cmUsDQo+IG1heWJlID8NCkN1cnJlbnQgV2luZG93cyBvbiBBcm0gcGxhdGZvcm1zIChz
ZWVuIG9uIFNDODI4MFhQKSBkb27igJl0IGhhdmUgX0dUUw0Kb3IgX1BUUyBtZXRob2RzLCBhbmQg
ZG9u4oCZdCBoYXZlIHNsZWVwaW5nIG9iamVjdHMgZWl0aGVyLg0KDQpBcyBzdWNoLCBJIGRvbuKA
mXQgZXhwZWN0IGFueSB1c2VycyBmb3IgdGhhdCBwb3RlbnRpYWwgZnVuY3Rpb25hbGl0eS4gQW0g
SSBtaXNzaW5nIHNvbWV0aGluZyANCm9yIGhpYmVybmF0aW9uIHNpZ25hbGxpbmcgdG8gZmlybXdh
cmUgKG9uIEFSTTY0KSBjYW4gYmUgbWFkZSBQU0NJIG9ubHkgaW5kZWZpbml0ZWx5Pw0KDQpUaGFu
ayB5b3UsDQotTW9oYW1lZA0KPiBTbywgdW50aWwgdGhhdCBoYXBwZW5zLCBJIHNlZSB0aGlzIGFz
IGFuIHBvc3NpYmxlIGFsdGVybmF0aXZlIGFuZA0KPiB0ZW1wb3Jhcnkgc29sdXRpb24uDQo+IA0K
PiBBY2tlZC1ieTogU3VkZWVwIEhvbGxhIDxzdWRlZXAuaG9sbGFAYXJtLmNvbT4NCj4gDQo+IC0t
DQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KDQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdl
cm1hbnkgR21iSApLcmF1c2Vuc3RyLiAzOAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5n
OiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBKb25hdGhhbiBXZWlzcwpFaW5nZXRyYWdlbiBhbSBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZyB1bnRlciBIUkIgMTQ5MTczIEIKU2l0ejogQmVybGluClVz
dC1JRDogREUgMjg5IDIzNyA4NzkKCgo=


