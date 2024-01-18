Return-Path: <linux-kernel+bounces-30120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B0348319AB
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 13:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6AD71F23A79
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 12:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87FAA250E4;
	Thu, 18 Jan 2024 12:55:33 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C9213AFB;
	Thu, 18 Jan 2024 12:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705582533; cv=none; b=dK47J+gNDnG+6GcQI8L+gmBqcAoilDqQVKf7lK6NRnUPBcHuqJG+sndLIVZYLe3xT/sKUjAdepY89OjWrRV2dBb8unVs59Pe3oK3MmWZptPHm2hht1ECrKZ31JRzy9+HHx3H+SE4WitWv+VFnxM3JmcDBF2UYUl8knEPUNNP2Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705582533; c=relaxed/simple;
	bh=JMIsJtQBX6kLyKtnYaMFEzQtsIApPm45z17ASci53Wo=;
	h=Received:Received:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:
	 X-MS-TNEF-Correlator:x-originating-ip:Content-Type:
	 Content-Transfer-Encoding:MIME-Version; b=J2zHAmwzgzk+xUM6lYtNu4lsb0ZP37UAglJpazSImv8Zd/h5I+ehllMVks+BC6Erlleu794hHnLd/QrxjAfF/17C3yfiysSfMinWT6Dk+kK3qwmAoEtBNAGYhry3bJEzZPkN9p69m7WldwFVuOoxTcg5upCVDrqQoVCdIHfTWGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TG2kw08YhzsVws;
	Thu, 18 Jan 2024 20:54:32 +0800 (CST)
Received: from kwepemd200003.china.huawei.com (unknown [7.221.188.150])
	by mail.maildlp.com (Postfix) with ESMTPS id 231D318005B;
	Thu, 18 Jan 2024 20:55:27 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 kwepemd200003.china.huawei.com (7.221.188.150) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Thu, 18 Jan 2024 20:55:26 +0800
Received: from dggpemm500008.china.huawei.com ([7.185.36.136]) by
 dggpemm500008.china.huawei.com ([7.185.36.136]) with mapi id 15.01.2507.035;
 Thu, 18 Jan 2024 20:55:26 +0800
From: wangyunjian <wangyunjian@huawei.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xudingke
	<xudingke@huawei.com>
Subject: RE: [PATCH net v3] tun: add missing rx stats accounting in
 tun_xdp_act
Thread-Topic: [PATCH net v3] tun: add missing rx stats accounting in
 tun_xdp_act
Thread-Index: AQHaSTdaoh49U62FKkOqzRq1lENoTbDdnv0AgAHaJdA=
Date: Thu, 18 Jan 2024 12:55:26 +0000
Message-ID: <ed6fd9c514ae4a449580d11c9c6ba8e7@huawei.com>
References: <1705490503-28844-1-git-send-email-wangyunjian@huawei.com>
 <65a7f560a4643_6ba59294a7@willemb.c.googlers.com.notmuch>
In-Reply-To: <65a7f560a4643_6ba59294a7@willemb.c.googlers.com.notmuch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXaWxsZW0gZGUgQnJ1aWpuIFtt
YWlsdG86d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbV0NCj4gU2VudDogV2VkbmVzZGF5
LCBKYW51YXJ5IDE3LCAyMDI0IDExOjQyIFBNDQo+IFRvOiB3YW5neXVuamlhbiA8d2FuZ3l1bmpp
YW5AaHVhd2VpLmNvbT47DQo+IHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb207IGphc293
YW5nQHJlZGhhdC5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5ldA0K
PiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsgeHVkaW5na2UNCj4gPHh1ZGluZ2tlQGh1YXdlaS5jb20+OyB3YW5neXVuamlhbiA8d2FuZ3l1
bmppYW5AaHVhd2VpLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBuZXQgdjNdIHR1bjogYWRk
IG1pc3Npbmcgcnggc3RhdHMgYWNjb3VudGluZyBpbiB0dW5feGRwX2FjdA0KPiANCj4gWXVuamlh
biBXYW5nIHdyb3RlOg0KPiA+IFRoZSBUVU4gY2FuIGJlIHVzZWQgYXMgdmhvc3QtbmV0IGJhY2tl
bmQsIGFuZCBpdCBpcyBuZWNlc3NhcnkgdG8gY291bnQNCj4gPiB0aGUgcGFja2V0cyB0cmFuc21p
dHRlZCBmcm9tIFRVTiB0byB2aG9zdC1uZXQvdmlydGlvLW5ldC4gSG93ZXZlciwNCj4gPiB0aGVy
ZSBhcmUgc29tZSBwbGFjZXMgaW4gdGhlIHJlY2VpdmUgcGF0aCB0aGF0IHdlcmUgbm90IHRha2Vu
IGludG8NCj4gPiBhY2NvdW50IHdoZW4gdXNpbmcgWERQLiBUaGUgY29tbWl0IDhhZTFhZmYwYjMz
MSAoInR1bnRhcDogc3BsaXQgb3V0DQo+ID4gWERQIGxvZ2ljIikgb25seSBpbmNsdWRlcyBkcm9w
cGVkIGNvdW50ZXIgZm9yIFhEUF9EUk9QLCBYRFBfQUJPUlRFRCwNCj4gPiBhbmQgaW52YWxpZCBY
RFAgYWN0aW9ucy4gSXQgd291bGQgYmUgYmVuZWZpY2lhbCB0byBhbHNvIGluY2x1ZGUgbmV3DQo+
ID4gYWNjb3VudGluZyBmb3Igc3VjY2Vzc2Z1bGx5IHJlY2VpdmVkIGJ5dGVzIHVzaW5nDQo+ID4g
ZGV2X3N3X25ldHN0YXRzX3J4X2FkZCBhbmQgaW50cm9kdWNlIG5ldyBkcm9wcGVkIGNvdW50ZXIg
Zm9yIFhEUCBlcnJvcnMNCj4gb24gWERQX1RYIGFuZCBYRFBfUkVESVJFQ1QuDQo+IA0KPiBGcm9t
IHRoZSBkZXNjcmlwdGlvbiBpdCBpcyBjbGVhciB0aGF0IHRoZXNlIGFyZSB0d28gc2VwYXJhdGUg
Y2hhbmdlcyB3cmFwcGVkDQo+IGludG8gb25lIHBhdGNoLiBJIHNob3VsZCBoYXZlIGZsYWdnZWQg
dGhpcyBwcmV2aW91c2x5Lg0KDQpEbyBJIG5lZWQgdG8gc3BsaXQgdGhlc2UgdHdvIG1vZGlmaWNh
dGlvbnMgaW50byAyIHBhdGNoZXM/DQoxLiBvbmx5IGZpeCBkcm9wcGVkIGNvdW50ZXINCjIuIGFk
ZCBuZXcgYWNjb3VudGluZyBmb3Igc3VjY2Vzc2Z1bGx5IHJlY2VpdmVkIGJ5dGVzDQpPcjoNCk9u
bHkgZml4IGRyb3BwZWQgY291bnRlcj8NCg0KPiANCj4gQWNrIG9uIHJldHVybmluZyB0aGUgZXJy
b3IgY291bnRlciB0aGF0IHdhcyBwcmV2aW91c2x5IHByZXNlbnQgYW5kIG1hdGNoZXMNCj4gdGhl
IEZpeGVzIHRhZy4NCj4gDQo+IEZvciB0aGUgc2Vjb25kIGNoYW5nZSwgSSBoYWQgdG8gY2hlY2sg
YSBmZXcgb3RoZXIgWERQIGNhcGFibGUgZHJpdmVycyB0byB2ZXJpZnkNCj4gdGhhdCBpdCBpcyBp
bmRlZWQgY29tbW9uIHRvIGNvdW50IHN1Y2ggcGFja2V0cy4NCj4gDQo+ID4gRml4ZXM6IDhhZTFh
ZmYwYjMzMSAoInR1bnRhcDogc3BsaXQgb3V0IFhEUCBsb2dpYyIpDQo+ID4gU2lnbmVkLW9mZi1i
eTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWkuY29tPg0KPiA+IC0tLQ0KPiA+IHYz
OiB1cGRhdGUgY29tbWl0IGxvZyBhbmQgY29kZQ0KPiA+IHYyOiBhZGQgRml4ZXMgdGFnDQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvbmV0L3R1bi5jIHwgMTQgKysrKysrKysrLS0tLS0NCj4gPiAgMSBm
aWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jIGluZGV4DQo+
ID4gYWZhNTQ5N2Y3YzM1Li4wNzA0YTE3ZTc0ZTEgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9u
ZXQvdHVuLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC90dW4uYw0KPiA+IEBAIC0xNjI1LDE4ICsx
NjI1LDE1IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqX190dW5fYnVpbGRfc2tiKHN0cnVjdA0K
PiA+IHR1bl9maWxlICp0ZmlsZSwgIHN0YXRpYyBpbnQgdHVuX3hkcF9hY3Qoc3RydWN0IHR1bl9z
dHJ1Y3QgKnR1biwgc3RydWN0DQo+IGJwZl9wcm9nICp4ZHBfcHJvZywNCj4gPiAgCQkgICAgICAg
c3RydWN0IHhkcF9idWZmICp4ZHAsIHUzMiBhY3QpICB7DQo+ID4gLQlpbnQgZXJyOw0KPiA+ICsJ
dW5zaWduZWQgaW50IGRhdGFzaXplID0geGRwLT5kYXRhX2VuZCAtIHhkcC0+ZGF0YTsNCj4gPiAr
CWludCBlcnIgPSAwOw0KPiA+DQo+ID4gIAlzd2l0Y2ggKGFjdCkgew0KPiA+ICAJY2FzZSBYRFBf
UkVESVJFQ1Q6DQo+ID4gIAkJZXJyID0geGRwX2RvX3JlZGlyZWN0KHR1bi0+ZGV2LCB4ZHAsIHhk
cF9wcm9nKTsNCj4gPiAtCQlpZiAoZXJyKQ0KPiA+IC0JCQlyZXR1cm4gZXJyOw0KPiA+ICAJCWJy
ZWFrOw0KPiA+ICAJY2FzZSBYRFBfVFg6DQo+ID4gIAkJZXJyID0gdHVuX3hkcF90eCh0dW4tPmRl
diwgeGRwKTsNCj4gPiAtCQlpZiAoZXJyIDwgMCkNCj4gPiAtCQkJcmV0dXJuIGVycjsNCj4gPiAg
CQlicmVhazsNCj4gPiAgCWNhc2UgWERQX1BBU1M6DQo+ID4gIAkJYnJlYWs7DQo+ID4gQEAgLTE2
NTEsNiArMTY0OCwxMyBAQCBzdGF0aWMgaW50IHR1bl94ZHBfYWN0KHN0cnVjdCB0dW5fc3RydWN0
ICp0dW4sDQo+IHN0cnVjdCBicGZfcHJvZyAqeGRwX3Byb2csDQo+ID4gIAkJYnJlYWs7DQo+ID4g
IAl9DQo+ID4NCj4gPiArCWlmIChlcnIgPCAwKSB7DQo+ID4gKwkJYWN0ID0gZXJyOw0KPiA+ICsJ
CWRldl9jb3JlX3N0YXRzX3J4X2Ryb3BwZWRfaW5jKHR1bi0+ZGV2KTsNCj4gPiArCX0gZWxzZSBp
ZiAoYWN0ID09IFhEUF9SRURJUkVDVCB8fCBhY3QgPT0gWERQX1RYKSB7DQo+ID4gKwkJZGV2X3N3
X25ldHN0YXRzX3J4X2FkZCh0dW4tPmRldiwgZGF0YXNpemUpOw0KPiA+ICsJfQ0KPiA+ICsNCj4g
DQo+IExldCdzIGF2b2lkIGFkZGluZyB5ZXQgYW5vdGhlciBicmFuY2ggYW5kIGp1c3QgZG8gdGhl
c2Ugb3BlcmF0aW9ucyBpbiB0aGUgY2FzZQ0KPiBzdGF0ZW1lbnRzLCBsaWtlIFhEUF9EUk9QLg0K
DQpGaXggaXQgbGlrZSB0aGlzPw0KLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMNCisrKyBiL2RyaXZl
cnMvbmV0L3R1bi5jDQpAQCAtMTYyNSwxOCArMTYyNSwyNSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKl9fdHVuX2J1aWxkX3NrYihzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLA0KIHN0YXRpYyBpbnQg
dHVuX3hkcF9hY3Qoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgc3RydWN0IGJwZl9wcm9nICp4ZHBf
cHJvZywNCiAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHhkcF9idWZmICp4ZHAsIHUzMiBh
Y3QpDQogew0KKyAgICAgICB1bnNpZ25lZCBpbnQgZGF0YXNpemUgPSB4ZHAtPmRhdGFfZW5kIC0g
eGRwLT5kYXRhOw0KICAgICAgICBpbnQgZXJyOw0KIA0KICAgICAgICBzd2l0Y2ggKGFjdCkgew0K
ICAgICAgICBjYXNlIFhEUF9SRURJUkVDVDoNCiAgICAgICAgICAgICAgICBlcnIgPSB4ZHBfZG9f
cmVkaXJlY3QodHVuLT5kZXYsIHhkcCwgeGRwX3Byb2cpOw0KLSAgICAgICAgICAgICAgIGlmIChl
cnIpDQorICAgICAgICAgICAgICAgaWYgKGVycikgew0KKyAgICAgICAgICAgICAgICAgICAgICAg
ZGV2X2NvcmVfc3RhdHNfcnhfZHJvcHBlZF9pbmModHVuLT5kZXYpOw0KICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGVycjsNCisgICAgICAgICAgICAgICB9DQorICAgICAgICAgICAgICAg
ZGV2X3N3X25ldHN0YXRzX3J4X2FkZCh0dW4tPmRldiwgZGF0YXNpemUpOw0KICAgICAgICAgICAg
ICAgIGJyZWFrOw0KICAgICAgICBjYXNlIFhEUF9UWDoNCiAgICAgICAgICAgICAgICBlcnIgPSB0
dW5feGRwX3R4KHR1bi0+ZGV2LCB4ZHApOw0KLSAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKQ0K
KyAgICAgICAgICAgICAgIGlmIChlcnIgPCAwKSB7DQorICAgICAgICAgICAgICAgICAgICAgICBk
ZXZfY29yZV9zdGF0c19yeF9kcm9wcGVkX2luYyh0dW4tPmRldik7DQogICAgICAgICAgICAgICAg
ICAgICAgICByZXR1cm4gZXJyOw0KKyAgICAgICAgICAgICAgIH0NCisgICAgICAgICAgICAgICBk
ZXZfc3dfbmV0c3RhdHNfcnhfYWRkKHR1bi0+ZGV2LCBkYXRhc2l6ZSk7DQogICAgICAgICAgICAg
ICAgYnJlYWs7DQogICAgICAgIGNhc2UgWERQX1BBU1M6DQoNCj4gDQo+ID4gIAlyZXR1cm4gYWN0
Ow0KPiA+ICB9DQo+ID4NCj4gPiAtLQ0KPiA+IDIuNDEuMA0KPiA+DQo+IA0KPiANCg0K

