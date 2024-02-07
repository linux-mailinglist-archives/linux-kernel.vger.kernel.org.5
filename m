Return-Path: <linux-kernel+bounces-56246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2312E84C7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:49:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B338D282787
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AA4C21107;
	Wed,  7 Feb 2024 09:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ETnJVvk/"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCF420B14;
	Wed,  7 Feb 2024 09:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299333; cv=none; b=JjJG3ar6Xh6yRdS1pUaFP+v5G/CTiyQq6pjrNezf7Ae7RlFzYma2STk4kQwnzqYDcnEHqvfnEEFv0nOy6NWyGCeA6Ss7TA/AMmUk70g9+guBtcih39oJPoHWFrcRnUWuLPAJrxrkuFV3geBoQfNCBqXDXqNYHDhwKOnnYi+vRd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299333; c=relaxed/simple;
	bh=Bw3nI1352z8vEjNQFvPE2329jopo2oNYApt9B+Y/sBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iQgBmcjPR2uIGHxqlQ+ZgTl2tXresFV3/a69CbaeSPnFSdxaBM0GzpwcdEiLZPjNz6vO2k94ylGwa0zwzIwZAflNASIHPaV1Fb30hQUDhetGd5kkHWTNkEKVOrLp+R3f1gilerHJYZ/2FL5SHyrBqslU3Fr5WYl6CZLfQqB4714=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ETnJVvk/; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179luKJ079147;
	Wed, 7 Feb 2024 03:47:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707299276;
	bh=Bw3nI1352z8vEjNQFvPE2329jopo2oNYApt9B+Y/sBs=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=ETnJVvk/JSVn7cLGEuOgOct9lVTPP5BMQM54MxjcUKEuq+eX4l+rSjUVBLr7U3IQn
	 G3/GS4bxrWK4nwvgjY2R732bqJgQ+EFUzQUHgdiA8GxgucMRxlUlEdfBygjvoO5j0i
	 jJij99Gb5JJrZWPQmAnKuV9XvdBPgw+QKTq8nE0k=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179luor026981
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:47:56 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:47:55 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 7 Feb 2024 03:47:55 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "broonie@kernel.org"
	<broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "Lu, Kevin" <kevin-lu@ti.com>, "Xu, Baojun" <baojun.xu@ti.com>,
        "P O,
 Vijeth" <v-po@ti.com>, "Navada Kanyana, Mukund" <navada@ti.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "McPherson, Jeff" <j-mcpherson@ti.com>,
        "pierre-louis.bossart@linux.intel.com"
	<pierre-louis.bossart@linux.intel.com>,
        "13916275206@139.com"
	<13916275206@139.com>,
        "Chawla, Mohit" <mohit.chawla@ti.com>, "soyer@irl.hu"
	<soyer@irl.hu>,
        "Huang, Jonathan" <jkhuang3@ti.com>, "tiwai@suse.de"
	<tiwai@suse.de>,
        "Djuandi, Peter" <pdjuandi@ti.com>,
        "Agrawal, Manisha"
	<manisha.agrawal@ti.com>,
        "Hari, Raj" <s-hari@ti.com>, "Yashar, Avi"
	<aviel@ti.com>,
        "Nagalla, Hari" <hnagalla@ti.com>,
        "Bajjuri, Praneeth"
	<praneeth@ti.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Index: AQHaVk3kv2C9l+KpeUSliV0WealeY7D9v3qAgADk+SA=
Date: Wed, 7 Feb 2024 09:47:55 +0000
Message-ID: <8fe0b2d1990346efa056d6c2245412c3@ti.com>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
 <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
In-Reply-To: <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-exclaimer-md-config: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBG
ZWJydWFyeSA2LCAyMDI0IDk6NTMgUE0NCj4gVG86IERpbmcsIFNoZW5naGFvIDxzaGVuZ2hhby1k
aW5nQHRpLmNvbT47IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVsLm9yZzsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4gYW5kcml5
LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7
DQo+IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207IGxnaXJkd29vZEBnbWFpbC5jb207IGxpbnV4
LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENjOiBMdSwgS2V2aW4gPGtldmluLWx1QHRp
LmNvbT47IFh1LCBCYW9qdW4gPGJhb2p1bi54dUB0aS5jb20+OyBQIE8sIFZpamV0aA0KPiA8di1w
b0B0aS5jb20+OyBOYXZhZGEgS2FueWFuYSwgTXVrdW5kIDxuYXZhZGFAdGkuY29tPjsNCj4gcGVy
ZXhAcGVyZXguY3o7IE1jUGhlcnNvbiwgSmVmZiA8ai1tY3BoZXJzb25AdGkuY29tPjsgcGllcnJl
LQ0KPiBsb3Vpcy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsg
Q2hhd2xhLCBNb2hpdA0KPiA8bW9oaXQuY2hhd2xhQHRpLmNvbT47IHNveWVyQGlybC5odTsgSHVh
bmcsIEpvbmF0aGFuDQo+IDxqa2h1YW5nM0B0aS5jb20+OyB0aXdhaUBzdXNlLmRlOyBEanVhbmRp
LCBQZXRlciA8cGRqdWFuZGlAdGkuY29tPjsNCj4gQWdyYXdhbCwgTWFuaXNoYSA8bWFuaXNoYS5h
Z3Jhd2FsQHRpLmNvbT47IEhhcmksIFJhaiA8cy1oYXJpQHRpLmNvbT47DQo+IFlhc2hhciwgQXZp
IDxhdmllbEB0aS5jb20+OyBOYWdhbGxhLCBIYXJpIDxobmFnYWxsYUB0aS5jb20+OyBCYWpqdXJp
LA0KPiBQcmFuZWV0aCA8cHJhbmVldGhAdGkuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxdIFJl
OiBbUEFUQ0ggdjMgNC80XSBBU29jOiBkdC1iaW5kaW5nczogUENNNjI0MDogQWRkDQo+IGluaXRp
YWwgRFQgYmluZGluZw0KPiANCj4gT24gMDMvMDIvMjAyNCAwNDrigIowNSwgU2hlbmdoYW8gRGlu
ZyB3cm90ZTogPiArID4gKyB0aSx0YWQ1MjEyOiBMb3ctcG93ZXINCj4gc3RlcmVvIGF1ZGlvIERB
QyB3aXRoIDEyMC1kQiBkeW5hbWljIHJhbmdlLiA+ICsgb25lT2Y6ID4gKyAtIGl0ZW1zOiA+ICsg
LQ0KPiBlbnVtOiA+ICsgLSB0aSxhZGMzMTIwID4gKyAtIHRpLGFkYzUxMjAgPiArIC0gdGkscGNt
MzEyMCA+ICsgLSB0aSxwY201MTIwDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBUaGlzIG1l
c3NhZ2Ugd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFRleGFzDQo+IEluc3RydW1lbnRzLg0KPiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29nbml6
ZSB0aGUgc291cmNlIG9mDQo+IHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2Fm
ZS4NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gT24gMDMvMDIvMjAyNCAwNDowNSwg
U2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPiArDQo+ID4gKyAgICAgIHRpLHRhZDUyMTI6IExvdy1w
b3dlciBzdGVyZW8gYXVkaW8gREFDIHdpdGggMTIwLWRCIGR5bmFtaWMgcmFuZ2UuDQo+ID4gKyAg
ICBvbmVPZjoNCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4g
PiArICAgICAgICAgICAgICAtIHRpLGFkYzMxMjANCj4gPiArICAgICAgICAgICAgICAtIHRpLGFk
YzUxMjANCj4gPiArICAgICAgICAgICAgICAtIHRpLHBjbTMxMjANCj4gPiArICAgICAgICAgICAg
ICAtIHRpLHBjbTUxMjANCj4gPiArICAgICAgICAgICAgICAtIHRpLHBjbTYxMjANCj4gPiArICAg
ICAgICAgIC0gY29uc3Q6IHRpLGFkYzYxMjANCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAg
ICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHRpLHBjbTYyNjANCj4gPiArICAg
ICAgICAgICAgICAtIHRpLHBjbTYxNDANCj4gPiArICAgICAgICAgICAgICAtIHRpLHBjbTMxNDAN
Cj4gPiArICAgICAgICAgICAgICAtIHRpLHBjbTUxNDANCj4gPiArICAgICAgICAgIC0gY29uc3Q6
IHRpLHBjbTYyNDANCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAgICAgIC0gY29uc3Q6
IHRpLGRpeDQxOTINCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHRpLHBjbTYyNDANCj4gDQo+IFdo
eSBkaXg0MTkyIGlzIG5vdCBwYXJ0IG9mIHByZXZpb3VzIGVudW0/DQoNCmRpeDQxOTIgaXMgbm90
IHRyYWRpdGlvbmFsIEFEQyBvciBEQUMsIGJ1dCBhbiBJbnRlZ3JhdGVkIERpZ2l0YWwgQXVkaW8g
SW50ZXJmYWNlIA0KUmVjZWl2ZXIgYW5kIFRyYW5zbWl0dGVyLCBsaWtlIGFuIGF1ZGlvIGJyaWRn
ZSB0byBjb25uZWN0IGRpZmZlcmVudCBkaWdpdGFsIGF1ZGlvIA0KcHJvdG9jb2wsIGNvbXBhdGli
bGUgd2l0aCB0aGUgQUVTMywgUy9QRElGLCBJRUMgNjA5NTgsIGFuZCBFSUFKIENQLTEyMDEgDQpp
bnRlcmZhY2Ugc3RhbmRhcmRzLCBMZWZ0LUp1c3RpZmllZCwgUmlnaHQtSnVzdGlmaWVkLCBhbmQg
UGhpbGlwcyBJMlPihKIgRGF0YSBGb3JtYXRzLiANClNvIGtlZXAgaXQgYWxvbmUgZm9yIHByb2Zl
c3Npb25hbCBwdXJwb3NlLiANCg0KPiANCj4gPiArICAgICAgLSBpdGVtczoNCj4gPiArICAgICAg
ICAgIC0gY29uc3Q6IHRpLGFkYzYxMjANCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHRpLHBjbWQ1
MTJ4DQo+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiB0aSxwY20x
NjkwDQo+ID4gKyAgICAgICAgICAtIGNvbnN0OiB0aSxwY205MjExDQo+ID4gKyAgICAgIC0gaXRl
bXM6DQo+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gKyAgICAgICAgICAgICAgLSB0aSxwY21k
MzE4MA0KPiA+ICsgICAgICAgICAgLSBjb25zdDogdGkscGNtZDMxNDANCj4gPiArICAgICAgLSBp
dGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHRpLHRh
YTU0MTINCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHRpLHRhYTUyMTINCj4gPiArICAgICAgLSBp
dGVtczoNCj4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiArICAgICAgICAgICAgICAtIHRpLHRh
ZDU0MTINCj4gPiArICAgICAgICAgIC0gY29uc3Q6IHRpLHRhZDUyMTINCj4gPiArICAgICAgLSBl
bnVtOg0KPiA+ICsgICAgICAgICAgLSB0aSxwY202MjQwDQo+ID4gKyAgICAgICAgICAtIHRpLHBj
bWQzMTQwDQo+ID4gKyAgICAgICAgICAtIHRpLHRhYTUyMTINCj4gPiArICAgICAgICAgIC0gdGks
dGFkNTIxMg0KPiA+ICsgICAgICAgICAgLSB0aSxwY21kMzE4MA0KPiANCj4gVGhpcyBvbmUgaXMg
ZHVwbGljYXRlZC4NCmFjY2VwdA0KPiANCj4gPiArDQo+IA0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K

