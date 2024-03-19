Return-Path: <linux-kernel+bounces-107269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 614A687FA2D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26335B21695
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 08:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E507C093;
	Tue, 19 Mar 2024 08:53:01 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB39A64CF7;
	Tue, 19 Mar 2024 08:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710838381; cv=none; b=B5h1wrRXDufF1gbpzMv/gSmDOpkC5YnwXx+m7H274pg/iKI86wNPx6UsszxJX+yJpxsImXGDjN0dMYg8GC2SmKBJ1sffPVoAS/zY4Gfd3zYis7YUoX/OztwKfDjPPK+DHp12GMjgclMT8qnKTls7GY5D/nKZ8vYWm5VbOW6WOTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710838381; c=relaxed/simple;
	bh=dRo4GmUb2CpgkVklfQFqQDwVG9vwNuWtJN6hgdDy7AE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ukr1n6eTqZii7ndp99k+eTa98i8WbfCblDdQuEaf/cXuWs6Ip5ZL0F43E4TTP1HGUWzLVePO8DWcXMP1qPe/511ndEDRavmcb/EJpxwKsh2TLyQfcBc7tvl4zhHD9vOxjeQ2jQ7fC8OWoLteQTxrhE+mtg0n+kx46F+QNsrAKVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 19 Mar
 2024 09:37:45 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.037; Tue, 19 Mar 2024 09:37:45 +0100
From: John Ernberg <john.ernberg@actia.se>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, "Clark
 Wang" <xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Topic: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Index: AQHab8t46xO1JP3Hxke5Lu7SCFbkbbEq8XCAgBPPogA=
Date: Tue, 19 Mar 2024 08:37:44 +0000
Message-ID: <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
In-Reply-To: <20240306190539.4ab9f369@device-28.home>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2958D729556D726A
Content-Type: text/plain; charset="utf-8"
Content-ID: <337EC15ED87FD94C94F790B11765AE40@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgTWF4aW1lLA0KDQpBcG9sb2dpZXMgZm9yIHRoZSBkZWxheSBpbiBteSByZXNwb25zZS4NCg0K
T24gMy82LzI0IDE5OjA1LCBNYXhpbWUgQ2hldmFsbGllciB3cm90ZToNCj4gSGVsbG8gSm9obiwN
Cj4gDQo+IEknbSBhZGRpbmcgQW5kcmV3IGFuZCBSdXNzZWxsIHRvIHRoZSB0aHJlYWQgYXMgUEhZ
IG1haW50YWluZXJzIGFuZA0KPiByZXZpZXdlcnMuDQo+IA0KPiBPbiBXZWQsIDYgTWFyIDIwMjQg
MTM6Mzc6NDUgKzAwMDANCj4gSm9obiBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+IHdy
b3RlOg0KPiANCj4+IFNpbmNlIHRoZSBwb3dlciBtYW5hZ2VtZW50IGlzIG5vdyBwZXJmb3JtZWQg
YnkgdGhlIEZFQyBpbnN0ZWFkIG9mIGdlbmVyaWMNCj4+IHBtIHRoZSBQSFkgd2lsbCBub3Qgc3Vz
cGVuZCB1bnRpbCB0aGUgbGluayBoYXMgYmVlbiB1cC4NCj4+DQo+PiBUaGVyZWZvciBzdXNwZW5k
IGl0IG9uIHByb2JlLiBJdCB3aWxsIGJlIHJlc3VtZWQgYnkge29mXyx9cGh5X2Nvbm5lY3QoKQ0K
Pj4gd2hlbiB0aGUgbGluayBpcyBicm91Z2h0IHVwLg0KPj4NCj4+IFNpbmNlIHtvZl8sfXBoeV9j
b25uZWN0KCkgYW5kIHBoeV9kaXNjb25uZWN0KCkgd2lsbCByZXN1bWUgYW5kIHN1c3BlbmQgdGhl
DQo+PiBQSFkgd2hlbiB0aGUgbGluayBpcyBicm91Z2h0IHVwIGFuZCBkb3duIHJlc3BlY3RpdmVs
eSwgYW5kIHBoeV9zdG9wKCkgYW5kDQo+PiBwaHlfc3RhcnQoKSB3aWxsIHJlc3VtZSBhbmQgc3Vz
cGVuZCB0aGUgUEhZIGluIHRoZSBzdXNwZW5kLXJlc3VtZSBwYXRocw0KPj4gdGhlcmUgaXMgbm8g
bmVlZCBmb3IgYW55IGFkZGl0aW9uYWwgY2FsbHMgYW55d2hlcmUuDQo+Pg0KPj4gU2lnbmVkLW9m
Zi1ieTogSm9obiBFcm5iZXJnIDxqb2huLmVybmJlcmdAYWN0aWEuc2U+DQo+IA0KPiBbLi4uXQ0K
PiANCj4+IEBAIC0yNTM5LDggKzI1MzksMTAgQEAgc3RhdGljIGludCBmZWNfZW5ldF9taWlfaW5p
dChzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPj4gICAJLyogZmluZCBhbGwgdGhlIFBI
WSBkZXZpY2VzIG9uIHRoZSBidXMgYW5kIHNldCBtYWNfbWFuYWdlZF9wbSB0byB0cnVlICovDQo+
PiAgIAlmb3IgKGFkZHIgPSAwOyBhZGRyIDwgUEhZX01BWF9BRERSOyBhZGRyKyspIHsNCj4+ICAg
CQlwaHlkZXYgPSBtZGlvYnVzX2dldF9waHkoZmVwLT5taWlfYnVzLCBhZGRyKTsNCj4+IC0JCWlm
IChwaHlkZXYpDQo+PiArCQlpZiAocGh5ZGV2KSB7DQo+PiAgIAkJCXBoeWRldi0+bWFjX21hbmFn
ZWRfcG0gPSB0cnVlOw0KPj4gKwkJCXBoeV9zdXNwZW5kKHBoeWRldik7DQo+PiArCQl9DQo+IA0K
PiBJIGRvbid0IHRoaW5rIHRoYXQncyBjb3JyZWN0LiBoZXJlIHBoeV9zdXNwZW5kKCkgaXMgYmVp
bmcgY2FsbGVkIGJlZm9yZQ0KPiB0aGUgUEhZIGdvdCBhdHRhY2hlZCwgc28gdGhlIFBIWSB3YXNu
J3QgaW5pdGlhbGl6ZWQgYXQgYWxsIGF0IHRoYXQNCj4gcG9pbnQgKHdoaWNoIEkgZ3Vlc3MgaXMg
eW91ciBpc3N1ZSBhcyB0aGUgUEhZIGlzIHN0aWxsIGluIHRoZSBzdGF0ZSBpdA0KPiB3YXMgY29u
ZmlndXJlZCBpbnRvIGJ5IHRoZSBib290bG9hZGVyKQ0KPiANCj4gRm9sbG93aW5nIHRoZSBjb2Rl
IHBhdGhzLCBpdCBsb29rcyBsaWtlIHRoaXMgd29ya3MgZm9yIHlvdSBiZWNhdXNlIHRoZQ0KPiBQ
SFkgeW91J3JlIHVzaW5nIGhhcyBhIC5zdXNwZW5kIGNhbGxiYWNrIHBvcHVsYXRlZCwgYnV0IGZv
ciBhbnkgUEhZDQo+IHRoYXQgdXNlcyB0aGUgZ2VucGh5IGRyaXZlciwgdGhpcyB3aWxsIGRvIG5v
dGhpbmcgYXQgYWxsICh0aGUgUEhZIGlzbid0DQo+IHlldCBhdHRhY2hlZCB0byB0aGUgZ2VucGh5
IG9wcywgdGhlcmVmb3JlIGdlbnBoeV9zdXNwZW5kIHdvbid0IGJlDQo+IGNhbGxlZCkuDQoNClRo
YW5rcyBmb3IgaGlnaGxpZ2h0aW5nIHRoaXMuDQoNClllcywgaXQncyBhIHByb2JsZW0gZm9yIGdl
bnBoeSwgYWx0aG91Z2ggZHVlIHRvIHdoZW4gZ2VucGh5IGlzIHByb2JlZCwgDQppdCdzIGFsd2F5
cyBiZWVuIGEgcHJvYmxlbSBmb3IgZ2VucGh5LCBldmVuIGJlZm9yZSB0aGlzIHBhdGNoLiBXaGVy
ZWFzIA0KUEhZcyB3aXRoIHNwZWNpZmljIGRyaXZlcnMgd29ya2VkIGJlZm9yZSBkdWUgdG8gTURJ
TyBidXMgUE0uDQoNClRoZXJlIGlzIGFsc28gYSBjYXNlIHdoZXJlIHRoZSBwaHkgZHJpdmVyIG1v
ZHVsZSBpcyBub3QgYXV0b21hdGljYWxseSANCmxvYWRlZCwgaW4gY2FzZXMgd2hlcmUgcmVxdWVz
dF9tb2R1bGUoKSBmYWlscywgZWl0aGVyIGR1ZSB0byB0aGUgDQp1c2Vyc3BhY2UgaGVscGVyIGZl
YXR1cmUgYmVpbmcgY29tcGlsZWQgb3V0IG9yIG90aGVyIHJlYXNvbnMsIGFuZCB0aGUgDQptb2R1
bGUgaXMgbG9hZGVkIG1hbnVhbGx5IGxhdGVyLiBJIHN1c3BlY3QgZm9yIHJlYXNvbnMgbGlrZSB0
aGVzZSB0aGUgDQpnZW5waHkgcHJvYmUgaGFwcGVucyBzbyBsYXRlLiBNeSBzb2x1dGlvbiBoZXJl
IGRvZXNuJ3QgY292ZXIgbm9uLWxvYWRlZCANCm1vZHVsZXMgZWl0aGVyLCBidXQgdGhpcyBjb3Vs
ZCBtYXliZSBiZSBjb3ZlcmVkIGJ5IG1vdmluZyBwaHlfc3VzcGVuZCgpIA0KdG8gcGh5X3Byb2Jl
KCkuIFVubGVzcyB0aGVyZSBpcyBhbiBldmVuIG1vcmUgY2xldmVyIHdheSB0byBnbyBhYm91dCBp
dCANCndoaWNoIEkgY2FuJ3Qgc2VlIGZyb20gaW5leHBlcmllbmNlLg0KDQpJZiBhIFBIWSBkcml2
ZXIgZG9lc24ndCBwb3B1bGF0ZSAuc3VzcGVuZCB0aGVyZSdzIHByb2JhYmx5IGEgZ29vZCByZWFz
b24gDQpmb3IgaXQgYW5kIGl0IG1ha2VzIHNlbnNlIHRvIG5vdCBzdXNwZW5kIHN1Y2ggYSBQSFks
IHNvICBJJ20gbm90IA0KY29uY2VybmVkIGFib3V0IGFuIHVucG9wdWxhdGVkIC5zdXNwZW5kLg0K
DQpCZXN0IHJlZ2FyZHMgLy8gSm9obiBFcm5iZXJnDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4g
DQo+IE1heGltZQ0K

