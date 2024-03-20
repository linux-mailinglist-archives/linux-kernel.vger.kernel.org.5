Return-Path: <linux-kernel+bounces-109091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC40B881485
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 16:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A7EE5282159
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA6252F72;
	Wed, 20 Mar 2024 15:26:09 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD74453E31;
	Wed, 20 Mar 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710948369; cv=none; b=DAkcayd1hNomYtsyBeb93SX8RuYPs2VvV77rHDLo3VJfEV4NgfVUQoxcwqBPLRTGrBOnS4N6U6qsAXxynMcl2t30rX+QVjHv+ZhGlHVP8ZMHKaZm5Gt/FWh/XGVWA9daA9U6Lgfpg89XA1fT00fV+C2zTBZ41O/dB2DSODVUk9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710948369; c=relaxed/simple;
	bh=+uAsyfOj24pfCzz6PstZDCpbRt+0wQJHGildU+NO1X0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Wfu3xuusSxUgd1pG09cwX8HhIZkr8LMOqWdU9YIfLNR6EzQ4JaZYd6MN3oyAvwjUXHTdGpYxJDIM13UdP5eZJ4TfyQ4U8IVUkeCBCfvnxWbs+BC4s8HjI5qIyr0n5J54Y9IsPr9N0xU+zNyyDDw0gPyAtXAYijazDqsLjCL52AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S036ANL.actianordic.se
 (10.12.31.117) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Wed, 20 Mar
 2024 16:25:54 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.037; Wed, 20 Mar 2024 16:25:54 +0100
From: John Ernberg <john.ernberg@actia.se>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, Wei Fang
	<wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, NXP Linux Team <linux-imx@nxp.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Heiner Kallweit
	<hkallweit1@gmail.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andrew Lunn
	<andrew@lunn.ch>
Subject: Re: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Topic: [PATCH net v3 2/2] net: fec: Suspend the PHY on probe
Thread-Index: AQHab8t46xO1JP3Hxke5Lu7SCFbkbbEq8XCAgBPPogCAAAPagIACAISA
Date: Wed, 20 Mar 2024 15:25:54 +0000
Message-ID: <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
 <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
In-Reply-To: <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2958D729556D7C66
Content-Type: text/plain; charset="utf-8"
Content-ID: <2BB5AB19795F52459FDDF45DB426B3FB@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUnVzc2VsLA0KDQpPbiAzLzE5LzI0IDA5OjUxLCBSdXNzZWxsIEtpbmcgKE9yYWNsZSkgd3Jv
dGU6DQo+IE9uIFR1ZSwgTWFyIDE5LCAyMDI0IGF0IDA4OjM3OjQ0QU0gKzAwMDAsIEpvaG4gRXJu
YmVyZyB3cm90ZToNCj4+IFRoZXJlIGlzIGFsc28gYSBjYXNlIHdoZXJlIHRoZSBwaHkgZHJpdmVy
IG1vZHVsZSBpcyBub3QgYXV0b21hdGljYWxseQ0KPj4gbG9hZGVkLCBpbiBjYXNlcyB3aGVyZSBy
ZXF1ZXN0X21vZHVsZSgpIGZhaWxzLCBlaXRoZXIgZHVlIHRvIHRoZQ0KPj4gdXNlcnNwYWNlIGhl
bHBlciBmZWF0dXJlIGJlaW5nIGNvbXBpbGVkIG91dCBvciBvdGhlciByZWFzb25zLCBhbmQgdGhl
DQo+PiBtb2R1bGUgaXMgbG9hZGVkIG1hbnVhbGx5IGxhdGVyLiBJIHN1c3BlY3QgZm9yIHJlYXNv
bnMgbGlrZSB0aGVzZSB0aGUNCj4+IGdlbnBoeSBwcm9iZSBoYXBwZW5zIHNvIGxhdGUuIE15IHNv
bHV0aW9uIGhlcmUgZG9lc24ndCBjb3ZlciBub24tbG9hZGVkDQo+PiBtb2R1bGVzIGVpdGhlciwg
YnV0IHRoaXMgY291bGQgbWF5YmUgYmUgY292ZXJlZCBieSBtb3ZpbmcgcGh5X3N1c3BlbmQoKQ0K
Pj4gdG8gcGh5X3Byb2JlKCkuIFVubGVzcyB0aGVyZSBpcyBhbiBldmVuIG1vcmUgY2xldmVyIHdh
eSB0byBnbyBhYm91dCBpdA0KPj4gd2hpY2ggSSBjYW4ndCBzZWUgZnJvbSBpbmV4cGVyaWVuY2Uu
DQo+IA0KPiBOb3RlIHRoYXQgaW4gdGhlIGNhc2Ugd2hlcmUgdGhlIFBIWSBkcml2ZXIgbW9kdWxl
IGlzIGxvYWRlZCBsYXRlLA0KPiBwaHlfcHJvYmUoKSB3b24ndCBiZSBjYWxsZWQgZm9yIHRoZSBQ
SFkgdW50aWwgdGhhdCBoYXBwZW5zLg0KPiANCj4gSSB3b3VsZCBzYXkgaWYgb25lIHdhbnRzIGEg
cGxhdGZvcm0gdG8gYmVoYXZlIHdpdGggbWluaW1hbCBwb3dlcg0KPiBjb25zdW1wdGlvbiwgdGhh
dCBpcyBzb21ldGhpbmcgdGhhdCBoYXMgdG8gYmUgZG9uZSBhY3Jvc3MgdGhlDQo+IHNvZnR3YXJl
IHN0YWNrLCBhbmQgdGhhdCBpbmNsdWRlcyB0aGUgYm9vdCBmaXJtd2FyZS4gU28sIGlmIG9uZQ0K
PiB3YW50cyB0aGUgUEhZIHRvIGJlIGluIGEgbG93IHBvd2VyIHN0YXRlIGF0IGJvb3QgdGltZSwg
dGhlbg0KPiBmaXJtd2FyZSBuZWVkcyB0byBlbnN1cmUgdGhhdCBoYXBwZW5zLg0KPiANCj4gVHJ5
aW5nIHRvIHNob2UtaG9ybiB0aGF0IGludG8gdGhlIGtlcm5lbCBpc24ndCBnb2luZyB0byB3b3Jr
DQo+IGJlY2F1c2Ugd2UgZ2V0IHRvIGRlY2lkZSB3aGF0IHRvIGRvIHdpdGggdGhlIFBIWSB3YXkg
dG9vIGxhdGUNCj4gKGR1ZSB0byBQSFkgZHJpdmVycyBiZWluZyBtb2R1bGFyIGFuZCBvbiB0aGUg
cm9vdGZzLikNCj4gDQoNCldoYXQgd2UgcmVhbGx5IHdhbnQgaXMgdGhlIFBIWSB0byBiZSBzdXNw
ZW5kZWQgb24gc3VzcGVuZCB0byBSQU0gDQpyZWdhcmRsZXNzIG9mDQp1cyBoYXZpbmcgaGFkIGFu
IGluaXRpYWwgbGluayB1cCBvciBub3QuDQoNClRoaXMgd29ya2VkIHByaW9yIHRvIDRjMGQyZTk2
YmEwNSAoIm5ldDogcGh5OiBjb25zaWRlciB0aGF0IHN1c3BlbmQycmFtIA0KbWF5IGN1dA0Kb2Zm
IFBIWSBwb3dlciIpIHdoaWNoIHdhcyBhZGRlZCBpbiBMaW51eCA1LjExLCBhbmQgNTU3ZDVkYzgz
ZjY4ICgibmV0OiANCmZlYzogdXNlDQptYWMtbWFuYWdlZCBQSFkgUE0iKSB3aGljaCB3YXMgYWRk
ZWQgaW4gTGludXggNS4xMi4NCg0KU2luY2UgRkVDIHJlcXVpcmVzIG1hY19tYW5hZ2VkX3BtIHRo
ZSBnZW5lcmljIFBNIHN1c3BlbmQtcmVzdW1lIHBhdGhzIA0KYXJlIG5vdA0KdGFrZW4uIFRoZSBy
ZXN1bWUgc2VxdWVuY2luZyB3aXRoIGdlbmVyaWMgUE0gaGFzIGJlZW4gYnJva2VuIHdpdGggdGhl
IA0KRkVDIHNpbmNlDQpnZW5lcmljIFBNIG9mIHRoZSBtZGlvIGJ1cyB3YXMgYWRkZWQsIGFzIHRo
ZSBGRUMgd2lsbCBkbyBwaHlfc3RhcnQoKSANCih2aWEgRkVDDQpyZXN1bWUpIGFuZCB0aGVuIGdl
bmVyaWMgUE0gcnVucyBwaHlfaW5pdF9odygpIHZpYSBtZGlvIGJ1cyByZXN1bWUgDQoocHJldmlv
dXNseToNCmxlc3MgZGFtYWdpbmcgcGh5X3Jlc3VtZSgpKSBkdWUgdG8gaG93IHRoZSBGRUMgSVAg
YmxvY2sgd29ya3MuDQoNClNvbWUgYmFja2dyb3VuZCBjb250ZXh0IHRvIG91ciB1c2VjYXNlIHdo
aWNoIG1pZ2h0IGhhdmUgYmVlbiBsb3N0IGlzIA0KdGhhdCBvdXINCnN5c3RlbSBicmluZyB0aGUg
bGluayB1cCBiYXNlZCBvbiBvdXRzaWRlIGlucHV0IGFuZCB0byBjb25zZXJ2ZSBwb3dlciB3ZSAN
CnN1c3BlbmQNCnJlZ3VsYXJseSwgYW5kIHRoaXMgaXMgdGhlIG9ubHkgc2l0dWF0aW9uIHdoZXJl
IHdlIGNhcmUgYWJvdXQgdGhlIHBvd2VyDQpjb25zdW1wdGlvbi4gU2luY2Ugd2UgY2Fubm90IGRl
Y2lkZSBpZiBsaW5rIHNoYWxsIGJlIHVwIG91cnNlbHZlcyB3ZSBjYW4gZ28NCnRocm91Z2ggbnVt
ZXJvdXMgc3VzcGVuZCBjeWNsZXMgYmVmb3JlIHRoZSBmaXJzdCBsaW5rIHVwLiBXZSBjb3VsZCBp
biB0aGVvcnkNCndvcmsgYXJvdW5kIGl0IGluIHVzZXJzcGFjZSBieSBkb2luZyAiaXAgbGluayBz
ZXQgPGV0aD4gdXAgJiYgaXAgbGluayANCnNldCA8ZXRoPg0KZG93biIsIGJ1dCBpdCB3YXNuJ3Qg
cmVxdWlyZWQgYmVmb3JlLg0KDQpUaGFua3MhIC8vIEpvaG4gRXJuYmVyZw==

