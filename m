Return-Path: <linux-kernel+bounces-56270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212384C828
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:58:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E589B2777F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 495D6250EC;
	Wed,  7 Feb 2024 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TsYAe1Wh"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE25C241E1;
	Wed,  7 Feb 2024 09:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707299915; cv=none; b=lzyKxSfEobBbVJRnrjbSGo/PeflOPK6Rt8UTmh9se2rvES2SEs8kvN8wSKfA5dvyTotXLHm52YWUAOW9tC7gU5TSGgWpo6Fy68+p/ru45sZxJ9epS0z/4g+Iwjc9DoiTTAFrMmr2lrHcG4mad9Z+c+8NWACgMUyrvFfsS9qirvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707299915; c=relaxed/simple;
	bh=w5InQTVqNAi1Z7yh4NV2mISyn8tksak6yySNsCaWsQc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t/Ipd7B4zoyR5EKBgRKHUyE8/mSHVwcJOFhllgjwGG9FGiY1iPLwugm4TGJGwy/EYGckF18wg7GAGQUHXPlXry3ilgmxOBEWbLUUxoMLDYEbG4HAkGjAOHMguOaIOodx4WokwaCIedhjZRqp7AEOIKu3H3SrxBXu+Dceiu2w5ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=TsYAe1Wh; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4179vhZF080933;
	Wed, 7 Feb 2024 03:57:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707299863;
	bh=w5InQTVqNAi1Z7yh4NV2mISyn8tksak6yySNsCaWsQc=;
	h=From:To:CC:Subject:Date:References:In-Reply-To;
	b=TsYAe1WhQcHpn8RU3Jdavn3Zk5k5CPuAzCYIjHZ7Bg8jm9ybfM2xfqeGd6byecD00
	 WEuZAthKzItmzhkzZJNKbN5yMIrSik6hcOmWOoWsEB44XdMx2bqrL772BwUAd6ErVK
	 rb5QcFjtDfqKddCnru7owMjUI72gDES2bjcImAcs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4179vhxZ014896
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Feb 2024 03:57:43 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 7
 Feb 2024 03:57:43 -0600
Received: from DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c]) by
 DLEE101.ent.ti.com ([fe80::91ee:60bc:bfb7:851c%18]) with mapi id
 15.01.2507.023; Wed, 7 Feb 2024 03:57:43 -0600
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
Thread-Index: AQHaVk3kv2C9l+KpeUSliV0WealeY7D9v3qAgADk+SCAAGqGAP//nAJA
Date: Wed, 7 Feb 2024 09:57:43 +0000
Message-ID: <c79d6930117f42e7b6e8d05b0ae3877e@ti.com>
References: <20240203030504.1724-1-shenghao-ding@ti.com>
 <20240203030504.1724-4-shenghao-ding@ti.com>
 <ac4b73f6-0c2c-4586-98d6-e97c575b3df7@linaro.org>
 <8fe0b2d1990346efa056d6c2245412c3@ti.com>
 <e61999e6-8c82-40a2-a2b9-e19d636364f5@linaro.org>
In-Reply-To: <e61999e6-8c82-40a2-a2b9-e19d636364f5@linaro.org>
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
d3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTZW50OiBXZWRuZXNkYXks
IEZlYnJ1YXJ5IDcsIDIwMjQgNTo1MyBQTQ0KPiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFv
LWRpbmdAdGkuY29tPjsgYnJvb25pZUBrZXJuZWwub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiBhbmRy
aXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9y
ZzsNCj4gbGlhbS5yLmdpcmR3b29kQGludGVsLmNvbTsgbGdpcmR3b29kQGdtYWlsLmNvbTsgbGlu
dXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IEx1LCBLZXZpbiA8a2V2aW4tbHVA
dGkuY29tPjsgWHUsIEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47IFAgTywgVmlqZXRoDQo+IDx2
LXBvQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+Ow0KPiBw
ZXJleEBwZXJleC5jejsgTWNQaGVyc29uLCBKZWZmIDxqLW1jcGhlcnNvbkB0aS5jb20+OyBwaWVy
cmUtDQo+IGxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tOyAxMzkxNjI3NTIwNkAxMzkuY29t
OyBDaGF3bGEsIE1vaGl0DQo+IDxtb2hpdC5jaGF3bGFAdGkuY29tPjsgc295ZXJAaXJsLmh1OyBI
dWFuZywgSm9uYXRoYW4NCj4gPGpraHVhbmczQHRpLmNvbT47IHRpd2FpQHN1c2UuZGU7IERqdWFu
ZGksIFBldGVyIDxwZGp1YW5kaUB0aS5jb20+Ow0KPiBBZ3Jhd2FsLCBNYW5pc2hhIDxtYW5pc2hh
LmFncmF3YWxAdGkuY29tPjsgSGFyaSwgUmFqIDxzLWhhcmlAdGkuY29tPjsNCj4gWWFzaGFyLCBB
dmkgPGF2aWVsQHRpLmNvbT47IE5hZ2FsbGEsIEhhcmkgPGhuYWdhbGxhQHRpLmNvbT47IEJhamp1
cmksDQo+IFByYW5lZXRoIDxwcmFuZWV0aEB0aS5jb20+DQo+IFN1YmplY3Q6IFJlOiBbRVhURVJO
QUxdIFJlOiBbUEFUQ0ggdjMgNC80XSBBU29jOiBkdC1iaW5kaW5nczogUENNNjI0MDoNCj4gQWRk
IGluaXRpYWwgRFQgYmluZGluZw0KPiANCj4gT24gMDcvMDIvMjAyNCAxMDrigIo0NywgRGluZywg
U2hlbmdoYW8gd3JvdGU6ID4gPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0NCj4gLS0gPj4g
RnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLuKAimtvemxvd3NraUDigIpsaW5h
cm8u4oCKb3JnPiA+PiBTZW50Og0KPiBUdWVzZGF5LCBGZWJydWFyeSA2LCAyMDI0IDk64oCKNTMg
UE0gPj4gVG86IERpbmcsIFNoZW5naGFvDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJTdGFydCBUaGlz
IG1lc3NhZ2Ugd2FzIHNlbnQgZnJvbSBvdXRzaWRlIG9mIFRleGFzDQo+IEluc3RydW1lbnRzLg0K
PiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IHJlY29n
bml6ZSB0aGUgc291cmNlIG9mDQo+IHRoaXMgZW1haWwgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMg
c2FmZS4NCj4gDQo+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gT24gMDcvMDIvMjAyNCAxMDo0
NywgRGluZywgU2hlbmdoYW8gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1l
c3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296
bG93c2tpQGxpbmFyby5vcmc+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDYsIDIwMjQg
OTo1MyBQTQ0KPiA+PiBUbzogRGluZywgU2hlbmdoYW8gPHNoZW5naGFvLWRpbmdAdGkuY29tPjsg
YnJvb25pZUBrZXJuZWwub3JnOw0KPiA+PiBjb25vcitkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOw0KPiA+PiBhbmRyaXkuc2hldmNo
ZW5rb0BsaW51eC5pbnRlbC5jb207IGxpbnV4LXNvdW5kQHZnZXIua2VybmVsLm9yZzsNCj4gPj4g
bGlhbS5yLmdpcmR3b29kQGludGVsLmNvbTsgbGdpcmR3b29kQGdtYWlsLmNvbTsgbGludXgtDQo+
ID4+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gPj4gQ2M6IEx1LCBLZXZpbiA8a2V2aW4tbHVA
dGkuY29tPjsgWHUsIEJhb2p1biA8YmFvanVuLnh1QHRpLmNvbT47IFAgTywNCj4gPj4gVmlqZXRo
IDx2LXBvQHRpLmNvbT47IE5hdmFkYSBLYW55YW5hLCBNdWt1bmQgPG5hdmFkYUB0aS5jb20+Ow0K
PiA+PiBwZXJleEBwZXJleC5jejsgTWNQaGVyc29uLCBKZWZmIDxqLW1jcGhlcnNvbkB0aS5jb20+
OyBwaWVycmUtDQo+ID4+IGxvdWlzLmJvc3NhcnRAbGludXguaW50ZWwuY29tOyAxMzkxNjI3NTIw
NkAxMzkuY29tOyBDaGF3bGEsIE1vaGl0DQo+ID4+IDxtb2hpdC5jaGF3bGFAdGkuY29tPjsgc295
ZXJAaXJsLmh1OyBIdWFuZywgSm9uYXRoYW4NCj4gPj4gPGpraHVhbmczQHRpLmNvbT47IHRpd2Fp
QHN1c2UuZGU7IERqdWFuZGksIFBldGVyIDxwZGp1YW5kaUB0aS5jb20+Ow0KPiA+PiBBZ3Jhd2Fs
LCBNYW5pc2hhIDxtYW5pc2hhLmFncmF3YWxAdGkuY29tPjsgSGFyaSwgUmFqIDxzLWhhcmlAdGku
Y29tPjsNCj4gPj4gWWFzaGFyLCBBdmkgPGF2aWVsQHRpLmNvbT47IE5hZ2FsbGEsIEhhcmkgPGhu
YWdhbGxhQHRpLmNvbT47IEJhamp1cmksDQo+ID4+IFByYW5lZXRoIDxwcmFuZWV0aEB0aS5jb20+
DQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2MyA0LzRdIEFTb2M6IGR0LWJp
bmRpbmdzOiBQQ002MjQwOg0KPiA+PiBBZGQgaW5pdGlhbCBEVCBiaW5kaW5nDQo+ID4+DQo+ID4+
IE9uIDAzLzAyLzIwMjQgMDQ64oCKMDUsIFNoZW5naGFvIERpbmcgd3JvdGU6ID4gKyA+ICsgdGks
dGFkNTIxMjoNCj4gPj4gTG93LXBvd2VyIHN0ZXJlbyBhdWRpbyBEQUMgd2l0aCAxMjAtZEIgZHlu
YW1pYyByYW5nZS4gPiArIG9uZU9mOiA+ICsNCj4gPj4gLSBpdGVtczogPiArIC0NCj4gPj4gZW51
bTogPiArIC0gdGksYWRjMzEyMCA+ICsgLSB0aSxhZGM1MTIwID4gKyAtIHRpLHBjbTMxMjAgPiAr
IC0NCj4gPj4gdGkscGNtNTEyMCBaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQgVGhpcyBtZXNzYWdl
IHdhcyBzZW50IGZyb20NCj4gPj4gb3V0c2lkZSBvZiBUZXhhcyBJbnN0cnVtZW50cy4NCj4gPj4g
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSByZWNvZ25p
emUgdGhlDQo+ID4+IHNvdXJjZSBvZiB0aGlzIGVtYWlsIGFuZCBrbm93IHRoZSBjb250ZW50IGlz
IHNhZmUuDQo+ID4+DQo+ID4+IFpqUWNtUVJZRnBmcHRCYW5uZXJFbmQNCj4gPj4gT24gMDMvMDIv
MjAyNCAwNDowNSwgU2hlbmdoYW8gRGluZyB3cm90ZToNCj4gPj4+ICsNCj4gPj4+ICsgICAgICB0
aSx0YWQ1MjEyOiBMb3ctcG93ZXIgc3RlcmVvIGF1ZGlvIERBQyB3aXRoIDEyMC1kQiBkeW5hbWlj
DQo+IHJhbmdlLg0KPiA+Pj4gKyAgICBvbmVPZjoNCj4gPj4+ICsgICAgICAtIGl0ZW1zOg0KPiA+
Pj4gKyAgICAgICAgICAtIGVudW06DQo+ID4+PiArICAgICAgICAgICAgICAtIHRpLGFkYzMxMjAN
Cj4gPj4+ICsgICAgICAgICAgICAgIC0gdGksYWRjNTEyMA0KPiA+Pj4gKyAgICAgICAgICAgICAg
LSB0aSxwY20zMTIwDQo+ID4+PiArICAgICAgICAgICAgICAtIHRpLHBjbTUxMjANCj4gPj4+ICsg
ICAgICAgICAgICAgIC0gdGkscGNtNjEyMA0KPiA+Pj4gKyAgICAgICAgICAtIGNvbnN0OiB0aSxh
ZGM2MTIwDQo+ID4+PiArICAgICAgLSBpdGVtczoNCj4gPj4+ICsgICAgICAgICAgLSBlbnVtOg0K
PiA+Pj4gKyAgICAgICAgICAgICAgLSB0aSxwY202MjYwDQo+ID4+PiArICAgICAgICAgICAgICAt
IHRpLHBjbTYxNDANCj4gPj4+ICsgICAgICAgICAgICAgIC0gdGkscGNtMzE0MA0KPiA+Pj4gKyAg
ICAgICAgICAgICAgLSB0aSxwY201MTQwDQo+ID4+PiArICAgICAgICAgIC0gY29uc3Q6IHRpLHBj
bTYyNDANCj4gPj4+ICsgICAgICAtIGl0ZW1zOg0KPiA+Pj4gKyAgICAgICAgICAtIGNvbnN0OiB0
aSxkaXg0MTkyDQo+ID4+PiArICAgICAgICAgIC0gY29uc3Q6IHRpLHBjbTYyNDANCj4gPj4NCj4g
Pj4gV2h5IGRpeDQxOTIgaXMgbm90IHBhcnQgb2YgcHJldmlvdXMgZW51bT8NCj4gPg0KPiA+IGRp
eDQxOTIgaXMgbm90IHRyYWRpdGlvbmFsIEFEQyBvciBEQUMsIGJ1dCBhbiBJbnRlZ3JhdGVkIERp
Z2l0YWwgQXVkaW8NCj4gPiBJbnRlcmZhY2UgUmVjZWl2ZXIgYW5kIFRyYW5zbWl0dGVyLCBsaWtl
IGFuIGF1ZGlvIGJyaWRnZSB0byBjb25uZWN0DQo+ID4gZGlmZmVyZW50IGRpZ2l0YWwgYXVkaW8g
cHJvdG9jb2wsIGNvbXBhdGlibGUgd2l0aCB0aGUgQUVTMywgUy9QRElGLA0KPiA+IElFQyA2MDk1
OCwgYW5kIEVJQUogQ1AtMTIwMSBpbnRlcmZhY2Ugc3RhbmRhcmRzLCBMZWZ0LUp1c3RpZmllZCwg
UmlnaHQtDQo+IEp1c3RpZmllZCwgYW5kIFBoaWxpcHMgSTJT4oSiIERhdGEgRm9ybWF0cy4NCj4g
PiBTbyBrZWVwIGl0IGFsb25lIGZvciBwcm9mZXNzaW9uYWwgcHVycG9zZS4NCj4gDQo+IEhtLCBp
dCBpcyBhIGJpdCBzdXJwcmlzaW5nIHRvIHNlZSBzb21lIFBDTTYyNDAtY29tcGF0aWJsZSBkZXZp
Y2VzIDEwMCUNCj4gZGlmZmVyZW50IGZyb20gb3RoZXIgUENNNjI0MC1jb21wYXRpYmxlLiBQQ002
MjQwIGlzIEFEQy4gRElYNDE5MiBpcyBub3QNCj4gQURDLCBub3QgZXZlbiBEQUMuIEhvdyBjYW4g
aXQgYmUgY29tcGF0aWJsZSB3aXRoIFBDTTYyNDAgaW4gc3VjaCBjYXNlPw0KPiANClRoZXkgYWxs
IGJlbG9uZyB0byBhdWRpbyBjb252ZXJ0b3IgZmFtaWx5Lg0KPiBCZXN0IHJlZ2FyZHMsDQo+IEty
enlzenRvZg0KPiANCg0K

