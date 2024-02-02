Return-Path: <linux-kernel+bounces-49079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D90A684659D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60E12B2235B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 02:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90DB8824;
	Fri,  2 Feb 2024 02:03:19 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E658BE1;
	Fri,  2 Feb 2024 02:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706839399; cv=none; b=etbZL//NVoBePHmcOKpP1I5UoeVDRTApiMznHC0yDblf1o0rsxdPfYSz+fOwYsD6Wwk3vIy2yztKspuLRAYTTEfRiA83A/6KQ73/WZE45ZoqTYq3hoSeRhFfTlCq2+S0nciDa1Bm5JaZ5UNOxr8wkQPWaacRYme65RTrbpeXhfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706839399; c=relaxed/simple;
	bh=ItYWq6QxmvvUtDMVmlQ0TWqNO6QqpjeFMchh79E+LbU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bcNWy9RO9klbXadkuHBQJG8tXUiv4zYxdIzdk6DvqWZpYjQoINDM0BZBsMjQEYL1b9hymp/w5FdTPncDS+yHYT5DJ5JG9X9dD72rMhXtq5o0zWMS/4La9MiGRwXpyfrCG9Jn7kewRmeudrmMk/CraJQNADUOHTUmbH7zIDbbzyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TQzY93CxMzNlgQ;
	Fri,  2 Feb 2024 10:02:05 +0800 (CST)
Received: from kwepemd500002.china.huawei.com (unknown [7.221.188.104])
	by mail.maildlp.com (Postfix) with ESMTPS id 965D7140499;
	Fri,  2 Feb 2024 10:03:07 +0800 (CST)
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 kwepemd500002.china.huawei.com (7.221.188.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Fri, 2 Feb 2024 10:03:07 +0800
Received: from dggpemm500008.china.huawei.com ([7.185.36.136]) by
 dggpemm500008.china.huawei.com ([7.185.36.136]) with mapi id 15.01.2507.035;
 Fri, 2 Feb 2024 10:03:06 +0800
From: wangyunjian <wangyunjian@huawei.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xudingke
	<xudingke@huawei.com>
Subject: RE: [PATCH net-next] tun: Implement ethtool's get_channels() callback
Thread-Topic: [PATCH net-next] tun: Implement ethtool's get_channels()
 callback
Thread-Index: AQHaVQbwnpDx30SF00Gz0GBhWRLXerD1Gp6AgAEizYA=
Date: Fri, 2 Feb 2024 02:03:06 +0000
Message-ID: <e8c1b2ab2dd346d2886eb5b010313974@huawei.com>
References: <1706789109-36556-1-git-send-email-wangyunjian@huawei.com>
 <65bbbc1d2e236_222699294f4@willemb.c.googlers.com.notmuch>
In-Reply-To: <65bbbc1d2e236_222699294f4@willemb.c.googlers.com.notmuch>
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
YWlsdG86d2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbV0NCj4gU2VudDogVGh1cnNkYXks
IEZlYnJ1YXJ5IDEsIDIwMjQgMTE6NDMgUE0NCj4gVG86IHdhbmd5dW5qaWFuIDx3YW5neXVuamlh
bkBodWF3ZWkuY29tPjsNCj4gd2lsbGVtZGVicnVpam4ua2VybmVsQGdtYWlsLmNvbTsgamFzb3dh
bmdAcmVkaGF0LmNvbTsga3ViYUBrZXJuZWwub3JnOw0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+
IENjOiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyB4dWRpbmdrZQ0KPiA8eHVkaW5na2VAaHVhd2VpLmNvbT47IHdhbmd5dW5qaWFuIDx3YW5neXVu
amlhbkBodWF3ZWkuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIG5ldC1uZXh0XSB0dW46IElt
cGxlbWVudCBldGh0b29sJ3MgZ2V0X2NoYW5uZWxzKCkgY2FsbGJhY2sNCj4gDQo+IFl1bmppYW4g
V2FuZyB3cm90ZToNCj4gPiBJbXBsZW1lbnQgdGhlIHR1biAuZ2V0X2NoYW5uZWxzIGZ1bmN0aW9u
YWxpdHkuIFRoaXMgZmVhdHVyZSBpcw0KPiA+IG5lY2Vzc2FyeSBmb3Igc29tZSB0b29scywgc3Vj
aCBhcyBsaWJ4ZHAsIHdoaWNoIG5lZWQgdG8gcmV0cmlldmUgdGhlIHF1ZXVlDQo+IGNvdW50Lg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWXVuamlhbiBXYW5nIDx3YW5neXVuamlhbkBodWF3ZWku
Y29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL25ldC90dW4uYyB8IDEwICsrKysrKysrKysNCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jIGluZGV4DQo+ID4gYWZhNTQ5
N2Y3YzM1Li43Y2Y0NDhmZjkzZWUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvdHVuLmMN
Cj4gPiArKysgYi9kcml2ZXJzL25ldC90dW4uYw0KPiA+IEBAIC0zNjM4LDEyICszNjM4LDIyIEBA
IHN0YXRpYyBpbnQgdHVuX3NldF9jb2FsZXNjZShzdHJ1Y3QgbmV0X2RldmljZQ0KPiAqZGV2LA0K
PiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCB0dW5fZ2V0X2No
YW5uZWxzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsDQo+ID4gKwkJCSAgICAgc3RydWN0IGV0aHRv
b2xfY2hhbm5lbHMgKmNoYW5uZWxzKSB7DQo+ID4gKwlzdHJ1Y3QgdHVuX3N0cnVjdCAqdHVuID0g
bmV0ZGV2X3ByaXYoZGV2KTsNCj4gPiArDQo+ID4gKwljaGFubmVscy0+Y29tYmluZWRfY291bnQg
PSB0dW4tPm51bXF1ZXVlczsNCj4gPiArCWNoYW5uZWxzLT5tYXhfY29tYmluZWQgPSBNQVhfVEFQ
X1FVRVVFUzsNCj4gDQo+IENvbmRpdGlvbmFsIG9uIElGRl9NVUxUSV9RVUVVRT8NCg0KT0ssIGxp
a2UgdGhpcz8NCiAgIGNoYW5uZWxzLT5jb21iaW5lZF9jb3VudCA9IHR1bi0+bnVtcXVldWVzOw0K
ICAgY2hhbm5lbHMtPm1heF9jb21iaW5lZCA9IHR1bi0+ZmxhZ3MgJiBJRkZfTVVMVElfUVVFVUUg
PyBNQVhfVEFQX1FVRVVFUyA6IDE7DQoNClRoYW5rcw0KDQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+
ICBzdGF0aWMgY29uc3Qgc3RydWN0IGV0aHRvb2xfb3BzIHR1bl9ldGh0b29sX29wcyA9IHsNCj4g
PiAgCS5zdXBwb3J0ZWRfY29hbGVzY2VfcGFyYW1zID0gRVRIVE9PTF9DT0FMRVNDRV9SWF9NQVhf
RlJBTUVTLA0KPiA+ICAJLmdldF9kcnZpbmZvCT0gdHVuX2dldF9kcnZpbmZvLA0KPiA+ICAJLmdl
dF9tc2dsZXZlbAk9IHR1bl9nZXRfbXNnbGV2ZWwsDQo+ID4gIAkuc2V0X21zZ2xldmVsCT0gdHVu
X3NldF9tc2dsZXZlbCwNCj4gPiAgCS5nZXRfbGluawk9IGV0aHRvb2xfb3BfZ2V0X2xpbmssDQo+
ID4gKwkuZ2V0X2NoYW5uZWxzICAgPSB0dW5fZ2V0X2NoYW5uZWxzLA0KPiA+ICAJLmdldF90c19p
bmZvCT0gZXRodG9vbF9vcF9nZXRfdHNfaW5mbywNCj4gPiAgCS5nZXRfY29hbGVzY2UgICA9IHR1
bl9nZXRfY29hbGVzY2UsDQo+ID4gIAkuc2V0X2NvYWxlc2NlICAgPSB0dW5fc2V0X2NvYWxlc2Nl
LA0KPiA+IC0tDQo+ID4gMi4zMy4wDQo+ID4NCj4gDQoNCg==

