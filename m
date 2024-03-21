Return-Path: <linux-kernel+bounces-110294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8B4E885CD8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B3B1C23014
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5094212BF2E;
	Thu, 21 Mar 2024 16:02:53 +0000 (UTC)
Received: from mail.actia.se (mail.actia.se [212.181.117.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872D112BF1C;
	Thu, 21 Mar 2024 16:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.181.117.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036972; cv=none; b=F6kMHweQvOnprhxvCFj+77LtA8q1TDxj2tQCWRVUDAa4bAaBwT0vsREyynn/mwKd2zPWu44apFlBBZE55qaXTFcVxOTDh8YsUEDGHa0Ft/oXXoYZL00E6F66z78Zt1N5zTNobgaeCAPiqDzFLSzPraRDc8wPzklFbLAPnzoper8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036972; c=relaxed/simple;
	bh=2Ks+dD7cG1dnGL5UrQukFgbkoYn599x/zQ+ZH8cjQ/g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxYS//Nhg23Vhy6sgFpeOOKDkC/i3fwG20bc0VhHnxVw2+HNA9AU5PAAQ/6IoFTWRXldY39LBLi2+kHMvB4pHZ6ZYqRwfABfYJDYhyMwKaPJ8izcTRVVlJhUcyp/Tjnb2sSPomV82fvuw0ZzjzBMIxmWL1urBYs8NR2KLub/DRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se; spf=pass smtp.mailfrom=actia.se; arc=none smtp.client-ip=212.181.117.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=actia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=actia.se
Received: from S036ANL.actianordic.se (10.12.31.117) by S035ANL.actianordic.se
 (10.12.31.116) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Thu, 21 Mar
 2024 17:02:38 +0100
Received: from S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69]) by
 S036ANL.actianordic.se ([fe80::e13e:1feb:4ea6:ec69%4]) with mapi id
 15.01.2507.037; Thu, 21 Mar 2024 17:02:38 +0100
From: John Ernberg <john.ernberg@actia.se>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, Florian Fainelli
	<f.fainelli@gmail.com>
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
Thread-Index: AQHab8t46xO1JP3Hxke5Lu7SCFbkbbEq8XCAgBPPogCAAAPagIACAISAgAAYuQCAAAV2gIAAKfWAgAFUdIA=
Date: Thu, 21 Mar 2024 16:02:38 +0000
Message-ID: <efffa6e6-f519-4424-8d58-0951e7c68f27@actia.se>
References: <20240306133734.4144808-1-john.ernberg@actia.se>
 <20240306133734.4144808-3-john.ernberg@actia.se>
 <20240306190539.4ab9f369@device-28.home>
 <9490ed31-dede-4a14-9c62-5ef83e30593a@actia.se>
 <ZflSE8AaYLE3Ri8L@shell.armlinux.org.uk>
 <f89bec78-0dae-4518-a461-2e64a3dfb9fc@actia.se>
 <ZfsUvm9YC5O7il3h@shell.armlinux.org.uk>
 <7f0e5f8b-fb85-4f2b-8d77-4170366a1b55@gmail.com>
 <Zfs8hWo/aVbvuAgm@shell.armlinux.org.uk>
In-Reply-To: <Zfs8hWo/aVbvuAgm@shell.armlinux.org.uk>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-esetresult: clean, is OK
x-esetid: 37303A2921D729556C7564
Content-Type: text/plain; charset="utf-8"
Content-ID: <952F03D0A4E8F244916405646E13840A@actia.se>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

SGkgUnVzc2VsbCwNCg0KT24gMy8yMC8yNCAyMDo0NCwgUnVzc2VsbCBLaW5nIChPcmFjbGUpIHdy
b3RlOg0KPiBPbiBXZWQsIE1hciAyMCwgMjAyNCBhdCAxMDoxMzo1NUFNIC0wNzAwLCBGbG9yaWFu
IEZhaW5lbGxpIHdyb3RlOg0KPj4NCj4+DQo+PiBPbiAzLzIwLzIwMjQgOTo1NCBBTSwgUnVzc2Vs
bCBLaW5nIChPcmFjbGUpIHdyb3RlOg0KPj4+IE9uIFdlZCwgTWFyIDIwLCAyMDI0IGF0IDAzOjI1
OjU0UE0gKzAwMDAsIEpvaG4gRXJuYmVyZyB3cm90ZToNCj4+Pj4gSGkgUnVzc2VsLA0KPj4+DQo+
Pj4gR3Jvd2wuIEhpIFBldGVyLg0KPj4+DQo+Pj4+IFdoYXQgd2UgcmVhbGx5IHdhbnQgaXMgdGhl
IFBIWSB0byBiZSBzdXNwZW5kZWQgb24gc3VzcGVuZCB0byBSQU0NCj4+Pj4gcmVnYXJkbGVzcyBv
ZiB1cyBoYXZpbmcgaGFkIGFuIGluaXRpYWwgbGluayB1cCBvciBub3QuDQo+Pj4NCj4+PiBTbyB3
aGF0IHlvdSdyZSBhc2tpbmcgaXMgZm9yIHRoZSBQSFkgdG8gYmUgc3VzcGVuZGVkIHdoZW4gdGhl
IHN5c3RlbQ0KPj4+IGlzIGVudGVyaW5nIHN1c3BlbmQsIHdoaWNoIGlzIGEgbG9uZyB0aW1lIGFm
dGVyIHRoZSBzeXN0ZW0gYm9vdGVkIGFuZA0KPj4+IHRodXMgcGh5X3Byb2JlKCkgd2FzIGNhbGxl
ZCwgYW5kIGNvdWxkIGJlIHNvbWUgdGltZSBiZWZvcmUgdGhlIHN5c3RlbQ0KPj4+IHJlc3VtZXMu
DQo+Pj4NCj4+PiBJJ20gbm90IHN1cmUgd2hhdCB0aGUgcmVsZXZhbmNlIGlzIG9mIHBoeV9wcm9i
ZSgpIHRoYXQgd2FzIGJyb3VnaHQgdXANCj4+PiBwcmV2aW91c2x5IHRoZW4uDQo+Pj4NCj4+Pj4g
VGhpcyB3b3JrZWQgcHJpb3IgdG8gNGMwZDJlOTZiYTA1ICgibmV0OiBwaHk6IGNvbnNpZGVyIHRo
YXQgc3VzcGVuZDJyYW0NCj4+Pj4gbWF5IGN1dA0KPj4+PiBvZmYgUEhZIHBvd2VyIikgd2hpY2gg
d2FzIGFkZGVkIGluIExpbnV4IDUuMTEsIGFuZCA1NTdkNWRjODNmNjggKCJuZXQ6DQo+Pj4+IGZl
YzogdXNlDQo+Pj4+IG1hYy1tYW5hZ2VkIFBIWSBQTSIpIHdoaWNoIHdhcyBhZGRlZCBpbiBMaW51
eCA1LjEyLg0KPj4+DQo+Pj4gTG9va2luZyBhdCB0aGUgZm9ybWVyIGNvbW1pdCwgdGhhdCBsb29r
cyB0byBtZSBsaWtlIGl0IGlzIG9ubHkNCj4+PiBhZmZlY3RpbmcgdGhlIHJlc3VtZSBwYXRocywg
bm90IHRoZSBzdXNwZW5kIHBhdGhzLCBzbyB3b3VsZG4ndCBoYXZlDQo+Pj4gYW55IGltcGFjdCBp
dHNlbGYgb24gd2hhdCBoYXBwZW5zIHdoZW4gc3VzcGVuZCBoYXBwZW5zLg0KPj4+DQo+Pj4gVGhl
IGxhdHRlciBjb21taXQgc3RhdGVzIHRoYXQgaXQgaXMgYSB3b3JrIGFyb3VuZCBmb3IgYW4gaXNz
dWUgd2l0aCBhDQo+Pj4gcGFydGljdWxhciBQSFkuIFdoYXQgaGFwcGVucyBpZiB5b3UgcmV2ZXJ0
IGp1c3QgdGhpcyBjb21taXQsIGRvZXMgeW91cg0KPj4+IHByb2JsZW0gdGhlbiBnbyBhd2F5Pw0K
DQpPdXIgUEhZIGRvZXMgbm90IGJlZ2luIHdvcmtpbmcgYWdhaW4gd2l0aG91dCByZXZlcnRpbmcg
Ym90aC4gcGh5X2luaXRfaHcoKQ0Kd2lsbCByZW1haW4gYW4gaXNzdWUgaWYgaXQgb2NjdXJzIGFm
dGVyIHBoeV9zdGFydCgpLg0KDQpUaGUgY29tbWl0IG1lc3NhZ2UgaW4gNTU3ZDVkYzgzZjY4IGlz
IG5vdCBleHBsYWluaW5nIG5lYXJseSBlbm91Z2gsIEkgDQpzcGVudCBhDQpmZXcgZGF5cyBvbiBp
dCBiZWZvcmUgSSBwcm92ZWQgdGhhdCBjb21taXQgdG8gYmUgbmVhcmx5IGNvcnJlY3QgKFNlZSB3
aG9sZQ0KdGhyZWFkIGF0IFsxXSksIGl0IGhhcHBlbmVkIHRvIGp1c3QgZXhwbG9kZSB3aXRoIHRo
YXQgUEhZLiBUaGUgaXNzdWUgaXMgYQ0Kc2VxdWVuY2luZyBpc3N1ZSB0aGF0IHdhcyBtYWRlIG1v
cmUgcHJvbWluZW50IGJ5IDRjMGQyZTk2YmEwNSwgYnV0IGl0IA0KZXhpc3RlZA0Kc2luY2UgYXJv
dW5kIDIwMDguIEJlY2F1c2UgRkVDIGlzIGJvdGggTURJTyBjb250cm9sbGVyIGFuZCBNQUMsIG1l
YW5pbmcgdGhlDQpyZXN1bWUgb2YgdGhlIGxpbmsgaW4gYSBsaW5rIHVwIGNhc2UgcnVucyBwaHlf
c3RhcnQoKSBpbiB0aGUgRkVDIHJlc3VtZQ0KZnVuY3Rpb24sIHdoaWNoIHdpbGwgdHJpZ2dlciBh
IG1kaW8gYnVzIHJlc3VtZSB3aGVuIGl0IGNvbXBsZXRlcywgaW4gdHVybg0KY2FsbGluZyBwaHlf
aW5pdF9odygpIChiZWZvcmUgNGMwZDJlOTZiYTA1IGl0IHdhcyBwaHlfcmVzdW1lKCkgd2hpY2gg
DQp3YXNuJ3QgYQ0KcHJvYmxlbSBidXQgc3RpbGwgd3Jvbmcgc2VxdWVuY2Ugd2lzZSkuDQoNCj4+
Pg0KPj4+IEFsc28sIHBsZWFzZSBjbGFyaWZ5LiBJdCBzZWVtcyB0aGF0IHlvdSBhcmUgcmVwb3J0
aW5nIGEgcmVncmVzc2lvbiAtDQo+Pj4gaXQgdXNlZCB0byB3b3JrIGZvciB5b3UgcHJpb3IgdG8g
NTU3ZDVkYzgzZjY4LCBidXQgNTU3ZDVkYzgzZjY4IHN0b3BzDQo+Pj4gaXQgd29ya2luZyBmb3Ig
eW91Pw0KPj4+DQo+Pj4+IFNpbmNlIEZFQyByZXF1aXJlcyBtYWNfbWFuYWdlZF9wbSB0aGUgZ2Vu
ZXJpYyBQTSBzdXNwZW5kLXJlc3VtZSBwYXRocw0KPj4+PiBhcmUgbm90DQo+Pj4+IHRha2VuLiBU
aGUgcmVzdW1lIHNlcXVlbmNpbmcgd2l0aCBnZW5lcmljIFBNIGhhcyBiZWVuIGJyb2tlbiB3aXRo
IHRoZQ0KPj4+PiBGRUMgc2luY2UNCj4+Pj4gZ2VuZXJpYyBQTSBvZiB0aGUgbWRpbyBidXMgd2Fz
IGFkZGVkLCBhcyB0aGUgRkVDIHdpbGwgZG8gcGh5X3N0YXJ0KCkNCj4+Pj4gKHZpYSBGRUMNCj4+
Pj4gcmVzdW1lKSBhbmQgdGhlbiBnZW5lcmljIFBNIHJ1bnMgcGh5X2luaXRfaHcoKSB2aWEgbWRp
byBidXMgcmVzdW1lDQo+Pj4+IChwcmV2aW91c2x5Og0KPj4+PiBsZXNzIGRhbWFnaW5nIHBoeV9y
ZXN1bWUoKSkgZHVlIHRvIGhvdyB0aGUgRkVDIElQIGJsb2NrIHdvcmtzLg0KPj4+DQo+Pj4gVGhh
dCBzdWdnZXN0cyB0aGF0IGV2ZW4gd2l0aCA1NTdkNWRjODNmNjggcmV2ZXJ0ZWQsIGl0J3MgYnJv
a2VuLg0KPj4+IERpZ2dpbmcgaW50byB0aGUgaGlzdG9yeSwgd2hhdCB5b3UncmUgcmVmZXJyaW5n
IHRvIGRhdGVzIGZyb20gSmFudWFyeQ0KPj4+IDIwMTYsIHNvIGFyZSB5b3UgcmVwb3J0aW5nIGEg
cmVncmVzc2lvbiB0aGF0IG9jY3VyZWQgOCBfeWVhcnNfIGFnbywNCj4+PiBhdCB3aGljaCBwb2lu
dCBJJ2QgcXVlc3Rpb24gd2h5IGl0J3MgdGFrZW4gOCB5ZWFycy4NCg0KQSByZXZlcnQgb2YgdGhv
c2UgaXMgYWJzb2x1dGVseSB3cm9uZy4gVGhvc2UgY29tbWl0cyBhcmUgZml4aW5nIGJpZ2dlcg0K
aXNzdWVzLg0KDQo+Pj4NCj4+PiBHaXZlbiB0aGUgdGltZSB0aGF0IGhhcyBwYXNzZWQsIEkgZG9u
J3QgdGhpbmsgcmV2ZXJ0aW5nIGNvbW1pdHMgaXMNCj4+PiBhIHNhbmUgYXBwcm9hY2guIFF1aXRl
IHdoYXQgdGhlIHJpZ2h0IHNvbHV0aW9uIGlzIHRob3VnaCwgSSdtIG5vdA0KPj4+IHN1cmUuDQo+
Pj4NCj4+PiAgIEZyb20gdGhlIGRlc2NyaXB0aW9uIGFuZCB0aGUgY29tbWl0cyBwb2ludGVkIHRv
LCBJIGp1c3QgZG9uJ3Qgc2VlDQo+Pj4gdGhhdCB0aGVyZSBpcyBhbnl0aGluZyB0aGF0IGNvdWxk
J3ZlIGNoYW5nZWQgd2l0aCByZXNwZWN0IHRvIHRoZSBmaXJzdA0KPj4+IGJvb3QgLSBpZiB0aGF0
IGhhcyBjaGFuZ2VkLCB0aGVuIEkgdGhpbmsgbW9yZSByZXNlYXJjaCBpbnRvIHdoYXQgY2F1c2Vk
DQo+Pj4gaXQgaXMgbmVlZGVkLg0KPj4+DQo+Pj4gSWYgaXQncyB0aGUgc3Vic2VxdWVudCBzdGF0
ZSBhZnRlciBhIHN1c3BlbmQtcmVzdW1lIGN5Y2xlLCB0aGVuIHllcywNCj4+PiBJIHdvdWxkIGFn
cmVlIHRoYXQgaXRzIHBvc3NpYmxlIHRoYXQgdGhlc2UgY2hhbmdlcyBicm9rZSB0aGlzIGZvciB5
b3UuDQo+Pj4gV291bGQgY2xlYXJpbmcgbmRldi0+cGh5ZGV2LT5tYWNfbWFuYWdlZF9wbSBqdXN0
IGJlZm9yZQ0KPj4+IHBoeV9kaXNjb25uZWN0KCkgaW4gZmVjX2VuZXRfY2xvc2UoKSBmaXggaXQg
Zm9yIHlvdSwgc28gdGhlIHN1c3BlbmQvDQo+Pj4gcmVzdW1lIHBhdGhzIGZvciB0aGUgUEhZIGdl
dCB1c2VkIHdoZW4gdGhlIG5ldHdvcmsgaW50ZXJmYWNlIGlzIGRvd24/DQo+Pj4NCj4+PiBNYXli
ZSwgaG93ZXZlciwgdGhhdCdzIHNvbWV0aGluZyB0aGF0IHNob3VsZCBoYXBwZW4gaW4gYW55IGNh
c2UgaW5zaWRlDQo+Pj4gcGh5bGliIG9uIHBoeV9kaXNjb25uZWN0KCkgYXMgYSBtYXR0ZXIgb2Yg
Y291cnNlLCBzaW5jZSB0aGUgUEhZIHdpbGwNCj4+PiBhdCB0aGF0IHBvaW50IGJlIG5vIGxvbmdl
ciB1bmRlciB0aGUgY29udHJvbCBvZiB0aGUgbmV0d29yayBkcml2ZXIgZm9yDQo+Pj4gUE0gcHVy
cG9zZXMuIENvdWxkIHlvdSBnaXZlIHRoaXMgaWRlYSBhIHRyeSBwbGVhc2U/DQo+Pj4NCj4+DQo+
PiBPbiBwaHlfZGlzY29ubmVjdCgpIHdlIHdpbGwgZG8gYSBwaHlfZGV0YWNoKCkgd2hpY2ggY2Fs
bHMgcGh5X3N1c3BlbmQoKS4NCj4+IEdpdmVuIHRoYXQgcGh5X2Rpc2Nvbm5lY3QoKSBpcyBjYWxs
ZWQgZnJvbSBmZWNfZW5ldF9jbG9zZSgpLCB3ZSBzdGlsbCBoYXZlIGENCj4+IE1ESU8gYnVzIHJl
Z2lzdGVyZWQgYW5kIHdlIGFyZSBub3QgdHJ5aW5nIHRvIHN1c3BlbmQgdGhlIE1ESU8gYnVzLCBz
byB3ZQ0KPj4gc2hvdWxkIGhhdmUgYW4gZWZmZWN0aXZlIHBoeV9zdXNwZW5kKCkgY2FsbCBoZXJl
LCB3aGF0IGFtIEkgbWlzc2luZz8NCj4gDQo+IEkgZGlkbid0IGxvb2sgdGhlcmUsIGJ1dCBpZiB0
aGF0IGlzIHRoZSBjYXNlLCB0aGVuIHdoYXQgaXMgSm9obidzDQo+IHByb2JsZW0gLSBJIGNhbid0
IGZpZ3VyZSBpdCBvdXQsIHNvbWV0aGluZyBpc24ndCBhZGRpbmcgdXAgaGVyZS4NCj4gDQoNCkkg
Y291bGQgaW5zdGVhZCBhZGQgZXh0cmEgcGh5X3N1c3BlbmQoKSBpbiB0aGUgc3VzcGVuZCBwYXRo
IGlmIHRoZSBsaW5rIGlzDQpkb3duIGFuZCB0aGUgRkVDIGlzIHVwIGFuZCBydW5uaW5nLiBJIHJl
amVjdGVkIGl0IG9yaWdpbmFsbHkgdGhpbmtpbmcgaXQgd2FzDQphIG11Y2ggZGlydGllciBmaXgs
IGJ1dCBtYXliZSB0aGF0IGlzIHRoZSBtb3JlIGNvcnJlY3QgdGhpbmcgdG8gZG8/DQoNClRoYW5r
cyEgLy8gSm9obiBFcm5iZXJnDQoNClsxXTogDQpodHRwczovL2xvcmUua2VybmVsLm9yZy9uZXRk
ZXYvMjAyNDAzMDYxMzM3MzQuNDE0NDgwOC0xLWpvaG4uZXJuYmVyZ0BhY3RpYS5zZS8=

