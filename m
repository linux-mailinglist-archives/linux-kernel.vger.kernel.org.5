Return-Path: <linux-kernel+bounces-88055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2761986DCC2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 09:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5908D1C23FF0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 08:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7062A69D20;
	Fri,  1 Mar 2024 08:10:43 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9887A6996C;
	Fri,  1 Mar 2024 08:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709280643; cv=none; b=dG77kF18ml2QeV1alMkbt+iEIWJ9Hn6BQCReWSrG4WJcH4aGcv+Ap7Ues+PF6aZgTFfRNcNpWq4WA3ONfKdip6pQvI3XySW7YYtyLpAcqHkPDqGYbo/yahFWssWidvj1rZToaq2ngpsZEb5gAiKj+GD6fKVBP5VozrNGfsU0/QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709280643; c=relaxed/simple;
	bh=S8/J6+YHq56KnBE4b4E6WPfyDyd+FRbl9UMTwvu0hdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H5BRKGEkIp+pSRDODRSy420N81kNKMxdKa0S7CWl9IiBo+25d+X58oulXkrAV7Zq/DpjkHytNqQzuXBDdiIjuTM9QBre7EY2ESJX0mL7xBJcUbohqfOlvArU98eNiWBKL57jqijiPcPf5MXeRXguJiY66uZWaALZUjskaWW25DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 1 Mar
 2024 09:10:34 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 09:10:34 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Wei Fang <wei.fang@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	dl-linux-imx <linux-imx@nxp.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Heiner Kallweit <hkallweit1@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: Re: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Topic: [PATCH net v2 2/2] net: fec: Suspend and resume the PHY
Thread-Index: AQHaav1/Ffv5x8jH7kmxx77YLYL/oLEiG6+ggABdcQA=
Date: Fri, 1 Mar 2024 08:10:34 +0000
Message-ID: <8b667fc6-27e6-4c14-8e76-346371cf9eec@actia.se>
References: <20240229105256.2903095-1-john.ernberg@actia.se>
 <20240229105256.2903095-3-john.ernberg@actia.se>
 <DB6PR04MB314117D7D5473B31FCA47495885E2@DB6PR04MB3141.eurprd04.prod.outlook.com>
In-Reply-To: <DB6PR04MB314117D7D5473B31FCA47495885E2@DB6PR04MB3141.eurprd04.prod.outlook.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2921D72955637D64
Content-Type: text/plain; charset="utf-8"
Content-ID: <150CA7A1B7BFA94889AEA6A159AACCA4@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgV2VpLA0KDQpPbiAzLzEvMjQgMDI6NDksIFdlaSBGYW5nIHdyb3RlOg0KPj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206IEpvaG4gRXJuYmVyZyA8am9obi5lcm5iZXJnQGFj
dGlhLnNlPg0KPj4gU2VudDogMjAyNOW5tDLmnIgyOeaXpSAxODo1Mw0KPj4gVG86IFdlaSBGYW5n
IDx3ZWkuZmFuZ0BueHAuY29tPg0KPj4gQ2M6IFNoZW53ZWkgV2FuZyA8c2hlbndlaS53YW5nQG54
cC5jb20+OyBDbGFyayBXYW5nDQo+PiA8eGlhb25pbmcud2FuZ0BueHAuY29tPjsgZGwtbGludXgt
aW14IDxsaW51eC1pbXhAbnhwLmNvbT47IERhdmlkIFMuDQo+PiBNaWxsZXIgPGRhdmVtQGRhdmVt
bG9mdC5uZXQ+OyBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+Ow0KPj4gSmFrdWIg
S2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz47IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT47DQo+PiBIZWluZXIgS2FsbHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPjsgbmV0ZGV2QHZn
ZXIua2VybmVsLm9yZzsNCj4+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEpvaG4gRXJu
YmVyZyA8am9obi5lcm5iZXJnQGFjdGlhLnNlPg0KPj4gU3ViamVjdDogW1BBVENIIG5ldCB2MiAy
LzJdIG5ldDogZmVjOiBTdXNwZW5kIGFuZCByZXN1bWUgdGhlIFBIWQ0KPj4NCj4+IFBIWXMgdGhh
dCBhcmUgYWx3YXlzLW9uIHdpbGwgbm90IGVudGVyIHRoZWlyIGxvdyBwb3dlciBtb2RlcyBvdGhl
cndpc2UgYXMNCj4+IHRoZXkgaGF2ZSBubyByZWd1bGF0b3IgdG8gYmUgcG93ZXJlZCBvZmYgd2l0
aC4NCj4+DQo+PiBTaW5jZSB0aGUgUEhZIGlzIHBpY2tlZCB1cCB2aWEge29mXyx9cGh5X2Nvbm5l
Y3QoKSBhbmQgZHJvcHBlZCB3aXRoDQo+PiBwaHlfZGlzY29ubmVjdCgpIHdoZW4gdGhlIGxpbmsg
aXMgYnJvdWdodCB1cCBhbmQgZG93biByZXNwZWN0aXZlbHkgdGhlIG9ubHkNCj4+IGNhc2VzIHdl
cmUgcG0gaXMgbmVlZGVkIGlzIHdoZW4gdGhlIG5ldGlmIGlzIHJ1bm5pbmcgb3Igb3Igd2hlbiB0
aGUgbGluaw0KPiBuaXQ6IHdoZXJlDQo+IA0KPj4gaGFzIG5ldmVyIGJlZW4gdXAuDQo+Pg0KPj4g
VG8gZGVhbCB3aXRoIHRoZSBsYXR0ZXIgY2FzZSB0aGUgUEhZIGlzIHN1c3BlbmRlZCBvbiBkaXNj
b3ZlcnkgaW4gcHJvYmUsDQo+PiBzaW5jZSBpdCB3b24ndCBiZSBuZWVkZWQgdW50aWwgbGluayB1
cC4NCj4+DQo+PiBGaXhlczogNTU3ZDVkYzgzZjY4ICgibmV0OiBmZWM6IHVzZSBtYWMtbWFuYWdl
ZCBQSFkgUE0iKQ0KPiBJJ20gbm90IHN1cmUgd2hldGhlciB0aGlzIGNvbW1pdCBzaG91bGQgYmUg
YmxhbWVkLiBBZnRlciBjaGVja2luZyBteSBsb2NhbA0KPiBjb2RlIChub3QgdGhlIHJlY2VudCB1
cHN0cmVhbSBjb2RlKSwgZmVjX3N1c3BlbmQoKSB3aWxsIG1ha2UgdGhlIFBIWSBlbnRlcg0KPiBz
dXNwZW5kIG1vZGUgd2hlbiBjYWxsaW5nIHBoeV9zdG9wKCksIHRoZSBzcGVjaWZpYyBsb2dpYyBp
cyBmZWNfc3VzcGVuZCgpIC0tPg0KPiBwaHlfc3RvcCgpIC0tPiBwaHlfc3RhdGVfbWFjaGluZSgp
IC0tPiBwaHlfc3VzcGVuZCAoKS4gQnV0IHRoZSBsYXRlc3QgdXBzdHJlYW0NCj4gY29kZSBtYXkg
aGF2ZSBjaGFuZ2VkIHRoaXMgbG9naWMuIEknbSBzb3JyeSB0aGF0IEkgZG9uJ3QgaGF2ZSB0aW1l
IHRvIHNpdCBkb3duDQo+IGFuZCBsb29rIGF0IHRoZSBsYXRlc3QgY29kZS4NCg0KSSBtaXNzZWQg
dGhpcyBmbG93LCBhbmQgYWxzbyBkaWRuJ3Qgc2VlIGl0IHRha2UgcGxhY2Ugd2hlbiBJIGxvb2sg
YXQgdGhlIA0KTURJTyB0cmFmZmljLiBCdXQgdGhlIGNvZGUgaGFzIGJlZW4gdGhlcmUgc2luY2Ug
MjAxMy4NCg0KSSB3aWxsIGNoZWNrIHdoeSB0aGF0IGlzbid0IGhhcHBlbmluZy4NCg0KVGhhbmtz
ISAvLyBKb2huIEVybmJlcmc=

