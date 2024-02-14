Return-Path: <linux-kernel+bounces-65456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3911854D51
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85AE1F2974B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:49:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EDFA5DF1A;
	Wed, 14 Feb 2024 15:49:49 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7655D910;
	Wed, 14 Feb 2024 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925788; cv=none; b=gaxulNYdxTfJdWjokUxFliy1VYs2xI2XizcYu4O0phPYbrw+AxBdfDCSE4pPUdVYjIbi64oD4T5PtMYq1roPYnPBcrxWr0/uDuaA2vAubi4xZIrswaB5Q+h+JoRch2jeWOGoXjucQvzuOwBQy4KkXkFVrSPhwQ9S2Cm6nUZV4oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925788; c=relaxed/simple;
	bh=FE3FLIyR5j8MemxSxaeAFQdc9r47s2aQ8K9ooV4Nn8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MH9dQASs+J9mbEbFGVtw2HVJMCJnhy6lBRrZb8YZ9ASKQWrUcFnr6uFcqsfwaei771BRprENy9hTpLVrSaS8KVcEHGhrV4uHA+5qR/9OakH3pT14Kv3tkMsUX0fc9masL1567JI9/BHchquElSWTALaCU5A2fsiGPs/4cXL5HZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 14 Feb
 2024 16:49:40 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Wed, 14 Feb 2024 16:49:40 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Jakub Kicinski <kuba@kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Paolo
 Abeni" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Thread-Topic: [PATCH net-next] net: fec: Always call fec_restart() in resume
 path
Thread-Index: AQHaXaFLRIYd45z3UU+7Sl3MRdVj/bEJE22AgABftoCAAGuqgIAAEAKA
Date: Wed, 14 Feb 2024 15:49:40 +0000
Message-ID: <e0641509-e18f-48d6-acba-6b649496782e@actia.se>
References: <20240212105010.2258421-1-john.ernberg@actia.se>
 <20240213184427.5af2d7eb@kernel.org>
 <5aba2c2b-b712-4827-acb2-d586508a3bd6@actia.se>
 <20240214065221.26d71ed0@kernel.org>
In-Reply-To: <20240214065221.26d71ed0@kernel.org>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2921D72955607464
Content-Type: text/plain; charset="utf-8"
Content-ID: <D63118CCB84A0C4884778A0867F5603D@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gMi8xNC8yNCAxNTo1MiwgSmFrdWIgS2ljaW5za2kgd3JvdGU6DQo+IE9uIFdlZCwgMTQgRmVi
IDIwMjQgMDg6Mjc6MDIgKzAwMDAgSm9obiBFcm5iZXJnIHdyb3RlOg0KPj4gWW91IGFyZSBjb3Jy
ZWN0LCB3ZSB0aG91Z2h0IHNvIHRvbyBhdCBbMV0sIGJ1dCBiaXNlY3Rpb24gaXMgcmVhbGx5IGhh
cmQNCj4+IGJlY2F1c2Ugd2UgbmVlZCBhIHdob2xlIGJ1bmNoIG9mIHBhdGNoZXMgb24gdG9wIHRv
IGV2ZW4gYm9vdCB0aGUgc3lzdGVtDQo+PiAoaW14OHF4cCBzcGVjaWZpYyBzdHVmZiBpbiB0aGUg
TlhQIHZlbmRvciB0cmVlIHRoYXQncyBkaWZmaWN1bHQgdG8NCj4+IHJlYmFzZSksIHdlIGxlZnQg
aXQgYSBiaXQgb3BlbiBlbmRlZC4NCj4+DQo+PiBPdmVyIHRoZSBjb3Vyc2Ugb2YgdGhlIHdlZWtl
bmQgSSBsb3N0IGFsbCBjb25maWRlbmNlIGluIG15IGJpc2VjdGlvbg0KPj4gYWZ0ZXIgYmVpbmcg
Y29uZmlkZW50IGZvciA0LTUgZGF5cywgYmVjYXVzZSB0aGUgbW9yZSBJIHRob3VnaHQgYWJvdXQg
aXQNCj4+IHRoZSBsZXNzIGl0IG1hZGUgc2Vuc2UgZm9yIHRoYXQgY29tbWl0IHRvIGJlIHRoZSBj
dWxwcml0Lg0KPj4NCj4+IEkgc2hvdWxkIHByb2JhYmx5IGhhdmUgYm90aCBmb2xsb3dlZCB1cCBv
biB0aGF0IG1haWwgd2l0aCB0aGF0LCBhbmQgYmVlbg0KPj4gY2xlYXJlciBoZXJlLiBJIGFwb2xv
Z2l6ZSBmb3IgZmFpbGluZyB0aGF0Lg0KPiANCj4gSXMgaXQgcGVyaGFwcyBwb3NzaWJsZSB0aGF0
IHVwc3RyZWFtIDUuMTAgYWxzbyBkaWRuJ3Qgd29yaz8NCj4gSSdtIG5vdCBzYXlpbmcgdGhlIGNo
YW5nZSBpdHNlbGYgaXMgaW5jb3JyZWN0LCBpbmRlZWQgdGhlcmUNCj4gaXMgZmVjX3Jlc3RhcnQo
KSBvbiBwcm9iZSBhbmQgb3BlbiBwYXRocywgYXMgeW91IHNheS4NCj4gRGlkIHlvdSB0cnkgcmV2
ZXJ0aW5nIGFzIG1hbnkgb2YgdGhlIGNoYW5nZXMgdGhhdCBoYXBwZW5lZA0KPiBpbiB0aGUgbWVh
bnRpbWUgYXMgcG9zc2libGUgKGluc3RlYWQgb2YgYmlzZWN0aW9uKT8NCj4gDQoNClRoYXQncyBh
IHJlYWxseSBnb29kIHBvaW50LiBJJ2xsIG1ha2Ugc29tZSB0aW1lIGZvciB0aGlzIGluIHRoZSBu
ZXh0IHdlZWtzLg0KUGxlYXNlIG1hcmsgaXQgd2l0aCBjaGFuZ2VzIHJlcXVlc3RlZCBpbiB0aGUg
bWVhbnRpbWUsIGFzIEkgZXhwZWN0IHRvIA0KbWFrZSBjaGFuZ2VzIHRvIHRoZSBwYXRjaCB3aGVu
IEkgaGF2ZSBhIHJlc3VsdC4NCg0KPiBUaGUgb3RoZXIgcXVlc3Rpb24gaXMgd2hldGhlciB3ZSBu
ZWVkIHRvIGVuYWJsZSBhbnkgb2YgdGhlDQo+IGNsb2NrcyBvciBydW50aW1lIHJlc3VtZSBiZWZv
cmUgY2FsbGluZyBmZWNfcmVzdGFydCgpPw0KDQpPbiBvdXIgYm9hcmQgaXQgd29ya3MgZmluZSB3
aXRob3V0IGl0LCBJIGRvbid0IGtub3cgZW5vdWdoIGFib3V0IHRoaXMgDQpTb0Mgb3Igb3RoZXIg
TlhQIFNvQ3MgdG8ga25vdyBpZiBpdCdzIG5lY2Vzc2FyeSBpbiBvdGhlciBzaXR1YXRpb25zLg0K
DQpUaGUgY2xvY2tzIGFyZSByZS1lbmFibGVkIGluIHRoZSBvcGVuIGNhbGwgd2hpY2ggYXBwZWFy
cyB0byBiZSBlbm91Z2ggdG8gDQpnZXQgdHJhZmZpYyBnb2luZyBhZ2FpbiB3aGVuIHRoZSBsaW5r
IGlzIGJyb3VnaHQgdXAuDQoNClBlcmhhcHMgTlhQIGNhbiBmaWxsIHVzIGluPw0KDQpUaGFua3Mh
IC8vIEpvaG4gRXJuYmVyZw==

