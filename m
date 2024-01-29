Return-Path: <linux-kernel+bounces-42127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 691F283FCBB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2601F2837DA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5796B101CF;
	Mon, 29 Jan 2024 03:28:15 +0000 (UTC)
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144C818E25
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.36.163.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706498894; cv=none; b=iRlul6K/U3ri12DVTDFI/BF/2G3dnZQjSpKmu2iTXypy/K2izZuac8P9zS1sAZUwJmCTXiuk3Nd5FZYKIjCWUWKCgG2EM37MsngXO8qMMT9vQlSnIoejxXo49OZNE+i67itxpWmKLNX68d3usi/zekitRmfuk7VcgYinKG3H3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706498894; c=relaxed/simple;
	bh=KWCHUJoh8IiYfejTXfjkt9Z9W02ztrWXN4doyhLMwao=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=suObErQl8cCeYRizNmo0coAluof7cIVJsv43jWxX7slWFTOBwmvpHN4NK1u7lkIVjJyzdXNPCAQw3OthPsFrCqU8A5cAZbhhY7b+eJQzgqwWaNuw8hJSRokEJ5mer5QODUj9Ei3C7HY9FBbltPBMcHlL9hYR/n77yJD8aWDu05g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; spf=pass smtp.mailfrom=alliedtelesis.co.nz; arc=none smtp.client-ip=202.36.163.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Received: from svr-chch-seg1.atlnz.lc (unknown [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 9A6A32C0191;
	Mon, 29 Jan 2024 16:28:03 +1300 (NZDT)
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B65b71b430001>; Mon, 29 Jan 2024 16:28:03 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8:f753:6de:11c0:a008) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 16:28:03 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 29 Jan 2024 16:28:03 +1300
From: Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To: =?utf-8?B?TnVubyBTw6E=?= <noname.nuno@gmail.com>, "a.zummo@towertech.it"
	<a.zummo@towertech.it>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "jdelvare@suse.com" <jdelvare@suse.com>,
	"linux@roeck-us.net" <linux@roeck-us.net>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Topic: [PATCH v5 0/2] drivers: rtc: add max313xx series rtc driver
Thread-Index: AQHaT/57pfs9+wriS028zs2/xPWJR7Dq3xGAgARtWAA=
Date: Mon, 29 Jan 2024 03:28:03 +0000
Message-ID: <170c8d6b-3246-493f-8cd9-6ac580cabc28@alliedtelesis.co.nz>
References: <20230403154342.3108-1-Ibrahim.Tilki@analog.com>
 <147c92f9-b42b-4a51-a6f9-2d90bfe63aa0@alliedtelesis.co.nz>
 <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
In-Reply-To: <1b42866bb6f05b7d68e9b8304e42359fccdf2bad.camel@gmail.com>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-ID: <52903D981EE19B4C887AAA6F5E877544@atlnz.lc>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=LZFCFQXi c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=75chYTbOgJ0A:10 a=IkcTkHD0fZMA:10 a=dEuoMetlWLkA:10 a=QyXUC8HyAAAA:8 a=y8u1kND1RjNfctyeU1UA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0

DQpPbiAyNi8wMS8yNCAyMDo1MSwgTnVubyBTw6Egd3JvdGU6DQo+IE9uIEZyaSwgMjAyNC0wMS0y
NiBhdCAwMjoyMiArMDAwMCwgQ2hyaXMgUGFja2hhbSB3cm90ZToNCj4+IEhpIEFsbCwNCj4+DQo+
PiBPbiA0LzA0LzIzIDAzOjQzLCBJYnJhaGltIFRpbGtpIHdyb3RlOg0KPj4+IGNoYW5nZWxvZzoN
Cj4+PiBzaW5jZSB2NToNCj4+PiAgwqDCoCAtIGR0LWJpbmRpbmc6IGFkZCBlbnVtIHZhbHVlICIy
IiB0byBhdXgtdm9sdGFnZS1jaGFyZ2FibGUNCj4+PiAgwqDCoCAtIGR0LWJpbmRpbmc6IHJlbW92
ZSBhZGksdHJpY2tsZS1kaW9kZS1lbmFibGUNCj4+PiAgwqDCoCAtIGR0LWJpbmRpbmc6IGNoYW5n
ZSBkZXNjcmlwdGlvbiBvZiB0cmlja2xlLXJlc2lzdG9yLW9obXMNCj4+PiAgwqDCoCAtIGR0LWJp
bmRpbmc6IHJlb3JkZXIgYXMgaW4gZXhhbXBsZSBzY2hlbWENCj4+PiAgwqDCoCAtIHBhcnNlICJ3
YWtldXAtc291cmNlIiB3aGVuIGlycSBub3QgcmVxdWVzdGVkDQo+Pj4gIMKgwqAgLSByZW1vdmUg
bGltaXRhdGlvbiBvbiBtYXgzMTMyOCBpcnEgYW5kIGNsb2tvdXQNCj4+PiAgwqDCoCAtIHJlbW92
ZSBlcnJvciBhbmQgd2FybmluZyBtZXNzYWdlcyBkdXJpbmcgdHJpY2tsZSBjaGFyZ2VyIHNldHVw
DQo+Pj4NCj4+PiBzaW5jZSB2NDoNCj4+PiAgwqDCoCAtIGR0LWJpbmRpbmc6IHJlbW92ZSBpbnRl
cnJ1cHQgbmFtZXMuDQo+Pj4gIMKgwqAgLSBkdC1iaW5kaW5nOiBhZGQgZGVzY3JpcHRpb24gZm9y
ICJpbnRlcnJ1cHRzIiBwcm9wZXJ0eQ0KPj4+ICDCoMKgIC0gZHQtYmluZGluZzogcmVwbGFjZSBk
ZXByZWNhdGVkIHByb3BlcnR5ICJ0cmlja2xlLWRpb2RlLWRpc2FibGUiDQo+Pj4gIMKgwqDCoMKg
wqDCoCBieSAiYXV4LXZvbHRhZ2UtY2hhcmdlYWJsZSINCj4+PiAgwqDCoCAtIGR0LWJpbmRpbmc6
IGFkZCBuZXcgcHJvcGVydHkgImFkaSx0cmlja2xlLWRpb2RlLWVuYWJsZSINCj4+PiAgwqDCoCAt
IGR0LWJpbmRpbmc6IHJlbW92ZSAid2FrZXVwLXNvdXJjZSINCj4+PiAgwqDCoCAtIHVzZSBjbGVh
cl9iaXQgaW5zdGVhZCBvZiBfX2NsZWFyX2JpdA0KPj4+ICDCoMKgIC0gdXNlIGRldm1fb2ZfY2xr
X2FkZF9od19wcm92aWRlciBpbnN0ZWFkIG9mIG9mX2Nsa19hZGRfcHJvdmlkZXINCj4+PiAgwqDC
oCAtIHVzZSBjaGlwX2Rlc2MgcG9pbnRlciBhcyBkcml2ZXIgZGF0YSBpbnN0ZWFkIG9mIGVudW0u
DQo+Pj4NCj4+PiBzaW5jZSB2MzoNCj4+PiAgwqDCoCAtIGFkZCAiYnJlYWsiIHRvIGZpeCB3YXJu
aW5nOiB1bmFubm90YXRlZCBmYWxsLXRocm91Z2gNCj4+PiAgwqDCoMKgwqAgUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxsa3BAaW50ZWwuY29tPg0KPj4+DQo+Pj4gc2luY2UgdjI6DQo+
Pj4gIMKgwqAgLSBkdC1iaW5kaW5nOiB1cGRhdGUgdGl0bGUgYW5kIGRlc2NyaXB0aW9uDQo+Pj4g
IMKgwqAgLSBkdC1iaW5kaW5nOiByZW1vdmUgbGFzdCBleGFtcGxlDQo+Pj4gIMKgwqAgLSBkcm9w
IHdhdGNoZG9nIHN1cHBvcnQNCj4+PiAgwqDCoCAtIHN1cHBvcnQgcmVhZGluZyAxMkhyIGZvcm1h
dCBpbnN0ZWFkIG9mIGZvcmNpbmcgMjRociBhdCBwcm9iZSB0aW1lDQo+Pj4gIMKgwqAgLSB1c2Ug
InRtX3llYXIgJSAxMDAiIGluc3RlYWQgb2YgcmFuZ2UgY2hlY2sNCj4+PiAgwqDCoCAtIHJlZmFj
dG9yIG1heDMxM3h4X2luaXQgZm9yIHJlYWRhYmlsaXR5DQo+Pj4NCj4+PiBJYnJhaGltIFRpbGtp
ICgyKToNCj4+PiAgwqDCoCBkcml2ZXJzOiBydGM6IGFkZCBtYXgzMTN4eCBzZXJpZXMgcnRjIGRy
aXZlcg0KPj4+ICDCoMKgIGR0LWJpbmRpbmdzOiBydGM6IGFkZCBtYXgzMTN4eCBSVENzDQo+Pj4N
Cj4+PiAgwqAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2FkaSxtYXgzMTN4eC55YW1sIHzC
oCAxNDQgKysrDQo+Pj4gIMKgIGRyaXZlcnMvcnRjL0tjb25maWfCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDExICsNCj4+PiAgwqAgZHJp
dmVycy9ydGMvTWFrZWZpbGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCB8wqDCoMKgIDEgKw0KPj4+ICDCoCBkcml2ZXJzL3J0Yy9ydGMtbWF4MzEzeHgu
Y8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHwgMTA1MyArKysrKysrKysr
KysrKysrKw0KPj4+ICDCoCA0IGZpbGVzIGNoYW5nZWQsIDEyMDkgaW5zZXJ0aW9ucygrKQ0KPj4+
ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3J0Yy9hZGksbWF4MzEzeHgueWFtbA0KPj4+ICDCoCBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVy
cy9ydGMvcnRjLW1heDMxM3h4LmMNCj4+IFdoYXQgaGFwcGVuZWQgdG8gdGhpcyBzZXJpZXMgaW4g
dGhlIGVuZD8gSXQga2luZCBvZiB3ZW50IG9mZiBteSByYWRhcg0KPj4gYW5kIEkgZm9yZ290IGFi
b3V0IGl0Lg0KPj4NCj4+IFdlJ3ZlIGJlZW4gY2FycnlpbmcgYSB2ZXJzaW9uIG9mIHRoZXNlIGNo
YW5nZXMgaW4gb3VyIGxvY2FsIHRyZWUgZm9yIGENCj4+IHdoaWxlIChhbmQgdXNpbmcgaXQgcXVp
dGUgaGFwcGlseSBJIHNob3VsZCBhZGQpLg0KPj4NCj4gSGkgQ2hyaXMsDQo+DQo+IEFsc28gbm90
IHN1cmUuLi4uIEluIHRoZSBtZWFudGltZSBJYnJhaGltIGxlZnQgQURJIHNvIGlmIHRoaXMgaXMg
bm90IGluIHNoYXBlIHRvDQo+IGJlIG1lcmdlZCBoZSB3b24ndCBiZSBhYmxlIHRvIHJlLXNwaW4u
IElmIHRoZXJlJ3MgYSBuZWVkIGZvciBhIHJlLXNwaW4sIHBsZWFzZQ0KPiBsZXQgbWUga25vdyBz
byBJIGNhbiBzZWUgaW50ZXJuYWxseSBpZiB0aGVyZSdzIHNvbWVvbmUgd2hvIGNhbiBjb250aW51
ZSB0aGlzDQo+IHdvcmsuIEkgd291bGQgZG8gaXQgbXlzZWxmIGlmIEkgaGFkIHRoZSBIVy4NCkkn
dmUgZ290IGEgYm9hcmQgd2l0aCBhIG1heDMxMzMxIHNvIEkgY2FuIHRlc3QgdGhhdC4gSSBkb24n
dCBoYXZlIGFueSBvZiANCnRoZSBpbnRlcnJ1cHRzIGhvb2tlZCB1cCBzbyBJIHdvbid0IGJlIGFi
bGUgdG8gdGVzdCB0aGF0LiBMb29rcyBsaWtlIA0KdGhlcmUgd2FzIHNvbWUgb3V0c3RhbmRpbmcg
ZGlzY3Vzc2lvbiBhcm91bmQgdGhlIHRyaWNrbGUtY2hhcmdlIA0KZGV2aWNldHJlZSBwcm9wZXJ0
aWVzIHNvIEknZCBuZWVkIHRvIGZpZ3VyZSBvdXQgd2hhdCB3YXMgd2FudGVkIHRoZXJlLiANCkkn
bGwgdHJ5IHRvIHBpY2sgdXAgdGhlIGxhc3Qgc2VyaWVzIGZyb20gdGhlIG1haWxpbmcgbGlzdCBh
bmQgZ28gZnJvbSB0aGVyZS4NCg==

