Return-Path: <linux-kernel+bounces-93997-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F09F2873810
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6CA51F24928
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14EB131749;
	Wed,  6 Mar 2024 13:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b="awCPkog/"
Received: from mx0.infotecs.ru (mx0.infotecs.ru [91.244.183.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E3F13172F;
	Wed,  6 Mar 2024 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.244.183.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709732773; cv=none; b=ebeua02FF5r9c5SCDJWlC8XBJVQ7W11/A9Nk/6uCnd2CH7dmmdiUfCb+0YVYWA+1aguJoy9mAnBr8XztvogC3ArGLaKNYdPYW5hdDQAkExHo/SdBWuzrwNAQ5cRc66e2t+p0gIp/sp6lYU/8H6blFaiVK1O3HHi67noMuAfNJZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709732773; c=relaxed/simple;
	bh=T4XufvKumvfjA/Mzi1v3U795CeS7EnqB34S1cub0C5Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n7FXG+CxzrSgHSgCMcVTmwQbzYQWDBXBX6XRLjBagtF9T8N2uX/yGjm1tRYFcZ2j/IvcXDy6yCjZOK/dWAx8CyUyDKDR+/1ir/0ty0ypJb369H88/4hKcSH0Q7iEUp1WAD+N0tdC9cHMTXjc6FCaBSBUsxepBqoihze2h0FC/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru; spf=pass smtp.mailfrom=infotecs.ru; dkim=pass (1024-bit key) header.d=infotecs.ru header.i=@infotecs.ru header.b=awCPkog/; arc=none smtp.client-ip=91.244.183.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=infotecs.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infotecs.ru
Received: from mx0.infotecs-nt (localhost [127.0.0.1])
	by mx0.infotecs.ru (Postfix) with ESMTP id BC12F148956B;
	Wed,  6 Mar 2024 16:46:07 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx0.infotecs.ru BC12F148956B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=infotecs.ru; s=mx;
	t=1709732768; bh=T4XufvKumvfjA/Mzi1v3U795CeS7EnqB34S1cub0C5Y=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=awCPkog/UsHiG65vXSzgTrIA/kznIAK7fWHki/jJb70Pt+LxTB10vD4pr6x1OHOk2
	 sTTeWLA2YHTUreG68xGwUFwlvW1HJScFim8N48ACrVjMhazmkHIRJTodV0YN61DYSV
	 97Czb+g/AJi389fBnDEPs6Wwk/aHOkPSRPakwT/U=
Received: from msk-exch-01.infotecs-nt (msk-exch-01.infotecs-nt [10.0.7.191])
	by mx0.infotecs-nt (Postfix) with ESMTP id B9582303407D;
	Wed,  6 Mar 2024 16:46:07 +0300 (MSK)
From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
To: Tom Parkin <tparkin@katalix.com>
CC: James Chapman <jchapman@katalix.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
	<lvc-project@linuxtesting.org>
Subject: Re: [PATCH net-next] l2tp: fix incorrect parameter validation in the
 pppol2tp_getsockopt() function
Thread-Topic: [PATCH net-next] l2tp: fix incorrect parameter validation in the
 pppol2tp_getsockopt() function
Thread-Index: AQHab8yjjDkKg7PSKU+NNTqnqRR+7g==
Date: Wed, 6 Mar 2024 13:46:07 +0000
Message-ID: <c9dd0486-aacc-4263-bcce-630fad445e72@infotecs.ru>
References: <20240306095449.1782369-1-Ilia.Gavrilov@infotecs.ru>
 <ZehsL8sHd3vgplv1@katalix.com>
In-Reply-To: <ZehsL8sHd3vgplv1@katalix.com>
Accept-Language: ru-RU, en-US
Content-Language: ru-RU
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: 208ac3cd-1ed4-4982-a353-bdefac89ac0a
Content-Type: text/plain; charset="utf-8"
Content-ID: <E8CDFB5F977CF94BB7781A0247BBE62D@infotecs.ru>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KLMS-Rule-ID: 5
X-KLMS-Message-Action: clean
X-KLMS-AntiSpam-Status: not scanned, disabled by settings
X-KLMS-AntiSpam-Interceptor-Info: not scanned
X-KLMS-AntiPhishing: Clean, bases: 2024/03/06 12:45:00
X-KLMS-AntiVirus: Kaspersky Security for Linux Mail Server, version 8.0.3.30, bases: 2024/03/06 11:20:00 #24013337
X-KLMS-AntiVirus-Status: Clean, skipped

T24gMy82LzI0IDE2OjE0LCBUb20gUGFya2luIHdyb3RlOg0KPiBPbiAgV2VkLCBNYXIgMDYsIDIw
MjQgYXQgMDk6NTg6MTAgKzAwMDAsIEdhdnJpbG92IElsaWEgd3JvdGU6DQo+PiBkaWZmIC0tZ2l0
IGEvbmV0L2wydHAvbDJ0cF9wcHAuYyBiL25ldC9sMnRwL2wydHBfcHBwLmMNCj4+IGluZGV4IGYw
MTFhZjY2MDFjOS4uNjE0NmU0ZTY3YmJiIDEwMDY0NA0KPj4gLS0tIGEvbmV0L2wydHAvbDJ0cF9w
cHAuYw0KPj4gKysrIGIvbmV0L2wydHAvbDJ0cF9wcHAuYw0KPj4gQEAgLTEzNTYsMTEgKzEzNTYs
MTEgQEAgc3RhdGljIGludCBwcHBvbDJ0cF9nZXRzb2Nrb3B0KHN0cnVjdCBzb2NrZXQgKnNvY2ss
IGludCBsZXZlbCwgaW50IG9wdG5hbWUsDQo+PiAgIAlpZiAoZ2V0X3VzZXIobGVuLCBvcHRsZW4p
KQ0KPj4gICAJCXJldHVybiAtRUZBVUxUOw0KPj4gICANCj4+IC0JbGVuID0gbWluX3QodW5zaWdu
ZWQgaW50LCBsZW4sIHNpemVvZihpbnQpKTsNCj4+IC0NCj4+ICAgCWlmIChsZW4gPCAwKQ0KPj4g
ICAJCXJldHVybiAtRUlOVkFMOw0KPj4gICANCj4+ICsJbGVuID0gbWluX3QodW5zaWduZWQgaW50
LCBsZW4sIHNpemVvZihpbnQpKTsNCj4+ICsNCj4+ICAgCWVyciA9IC1FTk9UQ09OTjsNCj4+ICAg
CWlmICghc2stPnNrX3VzZXJfZGF0YSkNCj4+ICAgCQlnb3RvIGVuZDsNCj4gDQo+IEkgdGhpbmsg
dGhpcyBjb2RlIGluIGwydHBfcHBwLmMgaGFzIHByb2JhYmx5IGJlZW4gaW5zcGlyZWQgYnkgYQ0K
PiBzaW1pbGFyIGltcGxlbWVudGF0aW9ucyBlbHNld2hlcmUgaW4gdGhlIGtlcm5lbCAtLSBmb3Ig
ZXhhbXBsZQ0KPiBuZXQvaXB2NC91ZHAuYyB1ZHBfbGliX2dldHNvY2tvcHQgZG9lcyB0aGUgc2Ft
ZSB0aGluZywgYW5kIGFwcGFyZW50bHkNCj4gaGFzIGJlZW4gdGhhdCB3YXkgc2luY2UgdGhlIGRh
d24gb2YgZ2l0IHRpbWUuDQo+IA0KPiBJIG5vdGUgaG93ZXZlciB0aGF0IHBsZW50eSBvZiBvdGhl
ciBnZXRzb2Nrb3B0IGltcGxlbWVudGF0aW9ucyB3aGljaA0KPiBhcmUgdXNpbmcgbWluX3QodW5z
aWduZWQgaW50LCBsZW4sIHNpemVvZihpbnQpKSBkb24ndCBjaGVjayB0aGUgbGVuZ3RoDQo+IHZh
bHVlIGF0IGFsbDogYXMgYW4gZXhhbXBsZSwgbmV0L2lwdjYvcmF3LmMgZG9fcmF3djZfZ2V0c29j
a29wdC4NCj4gDQo+IEFzIGl0IHN0YW5kcyByaWdodCBub3cgaW4gdGhlIGwydHBfcHBwLmMgY29k
ZSwgSSB0aGluayB0aGUgY2hlY2sgb24NCj4gbGVuIHdpbGwgZW5kIHVwIGRvaW5nIG5vdGhpbmcs
IGFzIHlvdSBwb2ludCBvdXQuDQo+IA0KPiBTbyBtb3ZpbmcgdGhlIGxlbiBjaGVjayB0byBiZWZv
cmUgdGhlIG1pbl90KCkgY2FsbCBtYXkgaW4gdGhlb3J5DQo+IHBvc3NpYmx5IGNhdGNoIG91dCAo
aW5zYW5lPykgdXNlcnNwYWNlIGNvZGUgcGFzc2luZyBpbiBuZWdhdGl2ZQ0KPiBudW1iZXJzIHdo
aWNoIG1heSAid29yayIgd2l0aCB0aGUgY3VycmVudCBrZXJuZWwgY29kZS4NCj4gDQo+IEkgd29u
ZGVyIHdoZXRoZXIgaXRzIHNhZmVyIHRoZXJlZm9yZSB0byByZW1vdmUgdGhlIGxlbiBjaGVjaw0K
PiBhbHRvZ2V0aGVyPw0KDQpUaGFuayB5b3UgZm9yIGFuc3dlci4NCg0KSW4gbXkgb3Bpbmlvbiwg
aXQgaXMgYmV0dGVyIHRvIGxlYXZlIHRoZSAnbGVuJyBjaGVjay4gVGhpcyB3YXkgaXQgd2lsbCAN
CmJlIGVhc2llciBmb3IgdGhlIHVzZXIgdG8gdW5kZXJzdGFuZCB3aGVyZSB0aGUgZXJyb3IgaXMu
DQo=

