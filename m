Return-Path: <linux-kernel+bounces-73968-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A8E85CE25
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:40:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5182B1C22846
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DFC282F9;
	Wed, 21 Feb 2024 02:40:16 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F362554B;
	Wed, 21 Feb 2024 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708483215; cv=none; b=mhjASLOaMXQsG2R/mkmaxXvL+aL8ykLkHRsxjXJwHZJP3pNcQk1VOVw/+2xXU51JnKFR4JkHylLPrwhVAtokef4DhXo0aZJV9XzdZImGE7hb51/R3kxmpdxrLh9ToNbAgue93DFRx7xaTyKrz6Sr10JHm8Jn/tNkTJhbDYMC9X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708483215; c=relaxed/simple;
	bh=huQBhc4YHl3eGuZLk1rpaJes8758crbomsUCrYGNCLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sHRZD6l3Vca/WPTHEk8VMfpr4Zj8ygAhG0skaXQ5uBG+va3ihdrjX+4iE7N4HLovblCxnDKN8d/gWKzdsV8kCagv34UnAWxZB7riIvckIonI4YnC7oU9bplLWm+lfDLEfAyvqYY6T1jdi4Ex+nrG1IKWfXLcErHMK1k3eFP1IeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TfgRs0SvXz1h0LC;
	Wed, 21 Feb 2024 10:38:01 +0800 (CST)
Received: from kwepemd100002.china.huawei.com (unknown [7.221.188.184])
	by mail.maildlp.com (Postfix) with ESMTPS id 6C784140157;
	Wed, 21 Feb 2024 10:40:09 +0800 (CST)
Received: from kwepemd100010.china.huawei.com (7.221.188.107) by
 kwepemd100002.china.huawei.com (7.221.188.184) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 21 Feb 2024 10:40:09 +0800
Received: from dggpemm500008.china.huawei.com (7.185.36.136) by
 kwepemd100010.china.huawei.com (7.221.188.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1258.28; Wed, 21 Feb 2024 10:40:08 +0800
Received: from dggpemm500008.china.huawei.com ([7.185.36.136]) by
 dggpemm500008.china.huawei.com ([7.185.36.136]) with mapi id 15.01.2507.035;
 Wed, 21 Feb 2024 10:40:08 +0800
From: wangyunjian <wangyunjian@huawei.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "jasowang@redhat.com"
	<jasowang@redhat.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, xudingke
	<xudingke@huawei.com>
Subject: RE: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
Thread-Topic: [PATCH net] tun: Fix xdp_rxq_info's queue_index when detaching
Thread-Index: AQHaY6qX2CBy+Itti0yhEsLiFpBp4LES3gaAgAE1xQA=
Date: Wed, 21 Feb 2024 02:40:08 +0000
Message-ID: <3f175a5ef4e34a0394ae584a0b84523e@huawei.com>
References: <1708398727-46308-1-git-send-email-wangyunjian@huawei.com>
 <65d4cc4b88e56_23483829431@willemb.c.googlers.com.notmuch>
In-Reply-To: <65d4cc4b88e56_23483829431@willemb.c.googlers.com.notmuch>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV2lsbGVtIGRlIEJydWlq
biBbbWFpbHRvOndpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb21dDQo+IFNlbnQ6IFR1ZXNk
YXksIEZlYnJ1YXJ5IDIwLCAyMDI0IDExOjU5IFBNDQo+IFRvOiB3YW5neXVuamlhbiA8d2FuZ3l1
bmppYW5AaHVhd2VpLmNvbT47DQo+IHdpbGxlbWRlYnJ1aWpuLmtlcm5lbEBnbWFpbC5jb207IGph
c293YW5nQHJlZGhhdC5jb207IGt1YmFAa2VybmVsLm9yZzsNCj4gZGF2ZW1AZGF2ZW1sb2Z0Lm5l
dA0KPiBDYzogbmV0ZGV2QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gYnJvdWVyQHJlZGhhdC5jb207IHh1ZGluZ2tlIDx4dWRpbmdrZUBodWF3ZWkuY29t
Pjsgd2FuZ3l1bmppYW4NCj4gPHdhbmd5dW5qaWFuQGh1YXdlaS5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggbmV0XSB0dW46IEZpeCB4ZHBfcnhxX2luZm8ncyBxdWV1ZV9pbmRleCB3aGVuIGRl
dGFjaGluZw0KPiANCj4gWXVuamlhbiBXYW5nIHdyb3RlOg0KPiA+IFdoZW4gYSBxdWV1ZSh0Zmls
ZSkgaXMgZGV0YWNoZWQsIHdlIG9ubHkgdXBkYXRlIHRmaWxlJ3MgcXVldWVfaW5kZXgsDQo+ID4g
YnV0IGRvIG5vdCB1cGRhdGUgeGRwX3J4cV9pbmZvJ3MgcXVldWVfaW5kZXguIFRoaXMgcGF0Y2gg
Zml4ZXMgaXQuDQo+ID4NCj4gPiBGaXhlczogOGJmNWM0ZWUxODg5ICgidHVuOiBzZXR1cCB4ZHBf
cnhxX2luZm8iKQ0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1bmppYW4gV2FuZyA8d2FuZ3l1bmppYW5A
aHVhd2VpLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9uZXQvdHVuLmMgfCAxICsNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYyBpbmRleA0KPiA+IGJjODBmYzFkNTc2
ZS4uYmUzNzIzNWFmNTVkIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L3R1bi5jDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvdHVuLmMNCj4gPiBAQCAtNjUyLDYgKzY1Miw3IEBAIHN0YXRpYyB2
b2lkIF9fdHVuX2RldGFjaChzdHJ1Y3QgdHVuX2ZpbGUgKnRmaWxlLCBib29sDQo+IGNsZWFuKQ0K
PiA+ICAJCQkJICAgdHVuLT50ZmlsZXNbdHVuLT5udW1xdWV1ZXMgLSAxXSk7DQo+ID4gIAkJbnRm
aWxlID0gcnRubF9kZXJlZmVyZW5jZSh0dW4tPnRmaWxlc1tpbmRleF0pOw0KPiA+ICAJCW50Zmls
ZS0+cXVldWVfaW5kZXggPSBpbmRleDsNCj4gPiArCQludGZpbGUtPnhkcF9yeHEucXVldWVfaW5k
ZXggPSBpbmRleDsNCj4gPiAgCQlyY3VfYXNzaWduX3BvaW50ZXIodHVuLT50ZmlsZXNbdHVuLT5u
dW1xdWV1ZXMgLSAxXSwNCj4gPiAgCQkJCSAgIE5VTEwpOw0KPiANCj4gRG9lcyBpdCBtYXR0ZXIg
dGhhdCB0aGlzIHZhbHVlIGlzIHN0YWxlIHdoZW4gdW5kZXRhY2hlZD8NCg0KWWVzLCB0aGUgZGV0
YWNoIHRmaWxlJ3F1ZXVlX2luZGV4IGlzIG5vdCBpbXBvcnRhbnQgYmVjYXVzZSB0aGUgcmUtYXR0
YWNoIHdpbGwgdXBkYXRlLg0KQnV0IHRoaXMgcGF0Y2ggaXMgdG8gZml4IHRoZSAnbnRmaWxlJyh0
aGF0IHJlcGxhY2VzIHRoZSBkZXRhY2ggdGZpbGUpJ3MgcXVldWVfaW5kZXgsIGl0IGlzIHdyb25n
Lg0KDQpUaGFua3MNCj4gDQo+IEl0IGlzIHJlcGxhY2VkIGluIHR1bl9hdHRhY2ggaWYgcHJldmlv
dXNseSBhdHRhY2hlZDoNCj4gDQo+IAkJLyogUmUtYXR0YWNoIGRldGFjaGVkIHRmaWxlLCB1cGRh
dGluZyBYRFAgcXVldWVfaW5kZXggKi8NCj4gICAgICAgICAgICAgICAgIFdBUk5fT04oIXhkcF9y
eHFfaW5mb19pc19yZWcoJnRmaWxlLT54ZHBfcnhxKSk7DQo+IA0KPiAgICAgICAgICAgICAgICAg
aWYgKHRmaWxlLT54ZHBfcnhxLnF1ZXVlX2luZGV4ICAgICE9IHRmaWxlLT5xdWV1ZV9pbmRleCkN
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdGZpbGUtPnhkcF9yeHEucXVldWVfaW5kZXggPSB0
ZmlsZS0+cXVldWVfaW5kZXg7DQo=

