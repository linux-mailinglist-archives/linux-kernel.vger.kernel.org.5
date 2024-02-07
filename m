Return-Path: <linux-kernel+bounces-56253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BD284C7F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2551F25ED6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7D923776;
	Wed,  7 Feb 2024 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FBqN7qxN"
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF63023745;
	Wed,  7 Feb 2024 09:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299504; cv=none; b=Rp9VLBch3TO/Fbp5eEVLTB1cjUWue6oONTf7E8YTdaOFPqPGFtnJJa6ZUN5xRcIX4n3WNJJKW/g2ZOPg8wFzUF8CimT0VNz9clVCfCCK7yeOxDWuzuPZJii5oksJGMx1L675mjVmCeQaOsDXd1hgnMqmIk0bfjthCLmrYUPeVq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299504; c=relaxed/simple;
	bh=nxBqeWL0d1U1qVe7h+N5GcZWZBAxhmQuqYyK6pjO2bQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bno/xNcYhIOgonSLYIhh+yQzvSdSLn+L46jWD5casKs+VMkcxPNC1czRqMwHsdWGJgapzLqlhhxzPizI8Pw3enCb1F0bXzBnXyDr1H3icGC+50RacepmHH5cx09iAQHR2YUiREUCW4jn99mDuUR9opZxWcCSK8ro5KRGvIcaa6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=FBqN7qxN; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179oqUD014863;
	Wed, 7 Feb 2024 03:50:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707299452;
	bh=nxBqeWL0d1U1qVe7h+N5GcZWZBAxhmQuqYyK6pjO2bQ=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=FBqN7qxNgtUXypruSROzFl0cIEBMTPJyy/LpyyfykjW2X2YJLjAvD3TSgm0W813a2
	 npjkBPis8AJVVnIQ9vjQfAsay9S3HPw1a+wcvWVCfEBzdqveFLBCByHan9JdiJSwKY
	 dXNBQPKr/ePE0smKIflhpgKEox1wFqgNXJdHk1pQ=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179oqVQ015094
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:50:52 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:50:52 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 7 Feb 2024 03:50:52 -0600
From: "Ding, Shenghao" <shenghao-ding@ti.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
	<praneeth@ti.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>,
        "linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
        "liam.r.girdwood@intel.com" <liam.r.girdwood@intel.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Topic: [EXTERNAL] Re: [PATCH v3 4/4] ASoc: dt-bindings: PCM6240: Add
 initial DT binding
Thread-Index: AQHaVk3kv2C9l+KpeUSliV0WealeY7D9v3qAgADk+SCAAAT5YA==
Date: Wed, 7 Feb 2024 09:50:51 +0000
Message-ID: <0a1f20ae254746b1adbfbdf7b4027518@ti.com>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
 <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
 <8fe0b2d1990346efa056d6c2245412c3@ti.com>
In-Reply-To: <8fe0b2d1990346efa056d6c2245412c3@ti.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGluZywgU2hlbmdoYW8g
PHNoZW5naGFvLWRpbmdAdGkuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIw
MjQgNTo0OCBQTQ0KPiBUbzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3Nr
aUBsaW5hcm8ub3JnPjsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyBjb25vcitkdEBrZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IGxpbnV4LQ0KPiBzb3VuZEB2Z2VyLmtlcm5l
bC5vcmc7IGxpYW0uci5naXJkd29vZEBpbnRlbC5jb207IGxnaXJkd29vZEBnbWFpbC5jb207DQo+
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEx1LCBLZXZpbiA8a2V2aW4tbHVA
dGkuY29tPjsgWHUsIEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47IFAgTywgVmlqZXRoDQo+IDx2
LXBvQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+Ow0KPiBw
ZXJleEBwZXJleC5jejsgTWNQaGVyc29uLCBKZWZmIDxqLW1jcGhlcnNvbkB0aS5jb20+OyBwaWVy
cmUtDQo+IGxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tOyAxMzkxNjI3NTIwNkAxMzkuY29t
OyBDaGF3bGEsIE1vaGl0DQo+IDxtb2hpdC5jaGF3bGFAdGkuY29tPjsgc295ZXJAaXJsLmh1OyBI
dWFuZywgSm9uYXRoYW4NCj4gPGpraHVhbmczQHRpLmNvbT47IHRpd2FpQHN1c2UuZGU7IERqdWFu
ZGksIFBldGVyIDxwZGp1YW5kaUB0aS5jb20+Ow0KPiBBZ3Jhd2FsLCBNYW5pc2hhIDxtYW5pc2hh
LmFncmF3YWxAdGkuY29tPjsgSGFyaSwgUmFqIDxzLWhhcmlAdGkuY29tPjsNCj4gWWFzaGFyLCBB
dmkgPGF2aWVsQHRpLmNvbT47IE5hZ2FsbGEsIEhhcmkgPGhuYWdhbGxhQHRpLmNvbT47IEJhamp1
cmksDQo+IFByYW5lZXRoIDxwcmFuZWV0aEB0aS5jb20+DQo+IFN1YmplY3Q6IFJFOiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0ggdjMgNC80XSBBU29jOiBkdC1iaW5kaW5nczogUENNNjI0MDoNCj4gQWRk
IGluaXRpYWwgRFQgYmluZGluZw0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLSA+
IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi7igIoNCj4gPiBrb3psb3dza2lA
4oCKbGluYXJvLuKAim9yZz4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA2LCAyMDI0IDk64oCK
NTMgUE0gPg0KPiA+IFRvOiBEaW5nLCBTaGVuZ2hhbyA8c2hlbmdoYW8tZGluZ0DigIp0aS7igIpj
b20+OyBicm9vbmllQOKAimtlcm5lbC7igIpvcmc7ID4NCj4gPiBjb25vcitkdEDigIprZXJuZWwu
4oCKb3JnOw0KPiBaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQNCj4gVGhpcyBtZXNzYWdlIHdhcyBz
ZW50IGZyb20gb3V0c2lkZSBvZiBUZXhhcyBJbnN0cnVtZW50cy4NCj4gRG8gbm90IGNsaWNrIGxp
bmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25pemUgdGhlIHNvdXJjZSBv
Zg0KPiB0aGlzIGVtYWlsIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiBaalFj
bVFSWUZwZnB0QmFubmVyRW5kDQo+IA0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0t
LQ0KPiA+IEZyb206IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGlu
YXJvLm9yZz4NCj4gPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSA2LCAyMDI0IDk6NTMgUE0NCj4g
PiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdAdGkuY29tPjsgYnJvb25pZUBrZXJu
ZWwub3JnOw0KPiA+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4gYW5kcml5LnNoZXZjaGVua29AbGludXguaW50
ZWwuY29tOyBsaW51eC1zb3VuZEB2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gbGlhbS5yLmdpcmR3b29k
QGludGVsLmNvbTsgbGdpcmR3b29kQGdtYWlsLmNvbTsgbGludXgtDQo+ID4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiA+IENjOiBMdSwgS2V2aW4gPGtldmluLWx1QHRpLmNvbT47IFh1LCBCYW9q
dW4gPGJhb2p1bi54dUB0aS5jb20+OyBQIE8sDQo+ID4gVmlqZXRoIDx2LXBvQHRpLmNvbT47IE5h
dmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+Ow0KPiA+IHBlcmV4QHBlcmV4LmN6
OyBNY1BoZXJzb24sIEplZmYgPGotbWNwaGVyc29uQHRpLmNvbT47IHBpZXJyZS0NCj4gPiBsb3Vp
cy5ib3NzYXJ0QGxpbnV4LmludGVsLmNvbTsgMTM5MTYyNzUyMDZAMTM5LmNvbTsgQ2hhd2xhLCBN
b2hpdA0KPiA+IDxtb2hpdC5jaGF3bGFAdGkuY29tPjsgc295ZXJAaXJsLmh1OyBIdWFuZywgSm9u
YXRoYW4NCj4gPiA8amtodWFuZzNAdGkuY29tPjsgdGl3YWlAc3VzZS5kZTsgRGp1YW5kaSwgUGV0
ZXIgPHBkanVhbmRpQHRpLmNvbT47DQo+ID4gQWdyYXdhbCwgTWFuaXNoYSA8bWFuaXNoYS5hZ3Jh
d2FsQHRpLmNvbT47IEhhcmksIFJhaiA8cy1oYXJpQHRpLmNvbT47DQo+ID4gWWFzaGFyLCBBdmkg
PGF2aWVsQHRpLmNvbT47IE5hZ2FsbGEsIEhhcmkgPGhuYWdhbGxhQHRpLmNvbT47IEJhamp1cmks
DQo+ID4gUHJhbmVldGggPHByYW5lZXRoQHRpLmNvbT4NCj4gPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbUEFUQ0ggdjMgNC80XSBBU29jOiBkdC1iaW5kaW5nczogUENNNjI0MDogQWRkDQo+ID4g
aW5pdGlhbCBEVCBiaW5kaW5nDQo+ID4NCj4gPiBPbiAwMy8wMi8yMDI0IDA0OuKAijA1LCBTaGVu
Z2hhbyBEaW5nIHdyb3RlOiA+ICsgPiArIHRpLHRhZDUyMTI6DQo+ID4gTG93LXBvd2VyIHN0ZXJl
byBhdWRpbyBEQUMgd2l0aCAxMjAtZEIgZHluYW1pYyByYW5nZS4gPiArIG9uZU9mOiA+ICsgLQ0K
PiA+IGl0ZW1zOiA+ICsgLQ0KPiA+IGVudW06ID4gKyAtIHRpLGFkYzMxMjAgPiArIC0gdGksYWRj
NTEyMCA+ICsgLSB0aSxwY20zMTIwID4gKyAtDQo+ID4gdGkscGNtNTEyMCBaalFjbVFSWUZwZnB0
QmFubmVyU3RhcnQgVGhpcyBtZXNzYWdlIHdhcyBzZW50IGZyb20NCj4gb3V0c2lkZQ0KPiA+IG9m
IFRleGFzIEluc3RydW1lbnRzLg0KPiA+IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzb3VyY2UNCj4gPiBvZiB0aGlzIGVtYWls
IGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+ID4NCj4gPiBaalFjbVFSWUZwZnB0QmFu
bmVyRW5kDQo+ID4gT24gMDMvMDIvMjAyNCAwNDowNSwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4g
PiA+ICsNCj4gPiA+ICsgICAgICB0aSx0YWQ1MjEyOiBMb3ctcG93ZXIgc3RlcmVvIGF1ZGlvIERB
QyB3aXRoIDEyMC1kQiBkeW5hbWljIHJhbmdlLg0KPiA+ID4gKyAgICBvbmVPZjoNCj4gPiA+ICsg
ICAgICAtIGl0ZW1zOg0KPiA+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gPiArICAgICAgICAg
ICAgICAtIHRpLGFkYzMxMjANCj4gPiA+ICsgICAgICAgICAgICAgIC0gdGksYWRjNTEyMA0KPiA+
ID4gKyAgICAgICAgICAgICAgLSB0aSxwY20zMTIwDQo+ID4gPiArICAgICAgICAgICAgICAtIHRp
LHBjbTUxMjANCj4gPiA+ICsgICAgICAgICAgICAgIC0gdGkscGNtNjEyMA0KPiA+ID4gKyAgICAg
ICAgICAtIGNvbnN0OiB0aSxhZGM2MTIwDQo+ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+ICsg
ICAgICAgICAgLSBlbnVtOg0KPiA+ID4gKyAgICAgICAgICAgICAgLSB0aSxwY202MjYwDQo+ID4g
PiArICAgICAgICAgICAgICAtIHRpLHBjbTYxNDANCj4gPiA+ICsgICAgICAgICAgICAgIC0gdGks
cGNtMzE0MA0KPiA+ID4gKyAgICAgICAgICAgICAgLSB0aSxwY201MTQwDQo+ID4gPiArICAgICAg
ICAgIC0gY29uc3Q6IHRpLHBjbTYyNDANCj4gPiA+ICsgICAgICAtIGl0ZW1zOg0KPiA+ID4gKyAg
ICAgICAgICAtIGNvbnN0OiB0aSxkaXg0MTkyDQo+ID4gPiArICAgICAgICAgIC0gY29uc3Q6IHRp
LHBjbTYyNDANCj4gPg0KPiA+IFdoeSBkaXg0MTkyIGlzIG5vdCBwYXJ0IG9mIHByZXZpb3VzIGVu
dW0/DQo+IA0KPiBkaXg0MTkyIGlzIG5vdCB0cmFkaXRpb25hbCBBREMgb3IgREFDLCBidXQgYW4g
SW50ZWdyYXRlZCBEaWdpdGFsIEF1ZGlvDQo+IEludGVyZmFjZSBSZWNlaXZlciBhbmQgVHJhbnNt
aXR0ZXIsIGxpa2UgYW4gYXVkaW8gYnJpZGdlIHRvIGNvbm5lY3QgZGlmZmVyZW50DQo+IGRpZ2l0
YWwgYXVkaW8gcHJvdG9jb2wsIGNvbXBhdGlibGUgd2l0aCB0aGUgQUVTMywgUy9QRElGLCBJRUMg
NjA5NTgsIGFuZCBFSUFKDQo+IENQLTEyMDEgaW50ZXJmYWNlIHN0YW5kYXJkcywgTGVmdC1KdXN0
aWZpZWQsIFJpZ2h0LUp1c3RpZmllZCwgYW5kIFBoaWxpcHMgSTJT4oSiDQo+IERhdGEgRm9ybWF0
cy4NCj4gU28ga2VlcCBpdCBhbG9uZSBmb3IgcHJvZmVzc2lvbmFsIHB1cnBvc2UuDQpJIHdpbGwg
YWRkIGRldGFpbCBkaXg0MTkxIGRlc2NyaXB0aW9uIGluIG5leHQgcGF0Y2guDQo+IA0KPiA+DQo+
ID4gPiArICAgICAgLSBpdGVtczoNCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogdGksYWRjNjEy
MA0KPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiB0aSxwY21kNTEyeA0KPiA+ID4gKyAgICAgIC0g
aXRlbXM6DQo+ID4gPiArICAgICAgICAgIC0gY29uc3Q6IHRpLHBjbTE2OTANCj4gPiA+ICsgICAg
ICAgICAgLSBjb25zdDogdGkscGNtOTIxMQ0KPiA+ID4gKyAgICAgIC0gaXRlbXM6DQo+ID4gPiAr
ICAgICAgICAgIC0gZW51bToNCj4gPiA+ICsgICAgICAgICAgICAgIC0gdGkscGNtZDMxODANCj4g
PiA+ICsgICAgICAgICAgLSBjb25zdDogdGkscGNtZDMxNDANCj4gPiA+ICsgICAgICAtIGl0ZW1z
Og0KPiA+ID4gKyAgICAgICAgICAtIGVudW06DQo+ID4gPiArICAgICAgICAgICAgICAtIHRpLHRh
YTU0MTINCj4gPiA+ICsgICAgICAgICAgLSBjb25zdDogdGksdGFhNTIxMg0KPiA+ID4gKyAgICAg
IC0gaXRlbXM6DQo+ID4gPiArICAgICAgICAgIC0gZW51bToNCj4gPiA+ICsgICAgICAgICAgICAg
IC0gdGksdGFkNTQxMg0KPiA+ID4gKyAgICAgICAgICAtIGNvbnN0OiB0aSx0YWQ1MjEyDQo+ID4g
PiArICAgICAgLSBlbnVtOg0KPiA+ID4gKyAgICAgICAgICAtIHRpLHBjbTYyNDANCj4gPiA+ICsg
ICAgICAgICAgLSB0aSxwY21kMzE0MA0KPiA+ID4gKyAgICAgICAgICAtIHRpLHRhYTUyMTINCj4g
PiA+ICsgICAgICAgICAgLSB0aSx0YWQ1MjEyDQo+ID4gPiArICAgICAgICAgIC0gdGkscGNtZDMx
ODANCj4gPg0KPiA+IFRoaXMgb25lIGlzIGR1cGxpY2F0ZWQuDQo+IGFjY2VwdA0KPiA+DQo+ID4g
PiArDQo+ID4NCj4gPg0KPiA+IEJlc3QgcmVnYXJkcywNCj4gPiBLcnp5c3p0b2YNCg0K

