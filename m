Return-Path: <linux-kernel+bounces-129908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D808971E9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 16:04:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B9D5E28EF1D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 14:04:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA325148FF8;
	Wed,  3 Apr 2024 14:04:06 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A84148305;
	Wed,  3 Apr 2024 14:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712153046; cv=none; b=SU/mats1M0BJqS5OaXgGYtN1H8+5J+A6zXH+Q2PrJ9n53TqB5sZcmaWPwvCD1Snrc8+DqefDcvF4gtEiC+NuDyTfZisY+dDHIaxkC9FsUpA4lfxvjMcNAj/IbBsJ30fXq6flBvzHL6jvGUPHQd0y2I1Kl2MFLJEaG7krlr6xbdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712153046; c=relaxed/simple;
	bh=anWldCiKGwnM3Qr2FBojle4TG/sM3U26csId4sUVpiA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qKRhDScXu5TFpUtVbdLrWQETdKentmLtqoMEMfF1UtcmVgq7EWmxhFFxeMC9PoCjC3jOyS1ILBCk7rFxb3EwRX87FGpxffawmUy488mi20sNcwhn6SdniNeOxKOxsjcMQdZayf3fclEV+cqkdxsXjuwrcMqFwp+mnxnizO7wbfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8mfS0nqpz6D8W0;
	Wed,  3 Apr 2024 22:02:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 95D1B140D30;
	Wed,  3 Apr 2024 22:03:59 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 15:03:59 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Wed, 3 Apr 2024 15:03:59 +0100
From: Shiju Jose <shiju.jose@huawei.com>
To: Daniel Ferguson <danielf@os.amperecomputing.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"Jonathan Cameron" <jonathan.cameron@huawei.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>
CC: "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"david@redhat.com" <david@redhat.com>, "Vilas.Sridharan@amd.com"
	<Vilas.Sridharan@amd.com>, "leo.duran@amd.com" <leo.duran@amd.com>,
	"Yazen.Ghannam@amd.com" <Yazen.Ghannam@amd.com>, "rientjes@google.com"
	<rientjes@google.com>, "jiaqiyan@google.com" <jiaqiyan@google.com>,
	"tony.luck@intel.com" <tony.luck@intel.com>, "Jon.Grimm@amd.com"
	<Jon.Grimm@amd.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "naoya.horiguchi@nec.com"
	<naoya.horiguchi@nec.com>, "james.morse@arm.com" <james.morse@arm.com>,
	"jthoughton@google.com" <jthoughton@google.com>, "somasundaram.a@hpe.com"
	<somasundaram.a@hpe.com>, "erdemaktas@google.com" <erdemaktas@google.com>,
	"pgonda@google.com" <pgonda@google.com>, "duenwen@google.com"
	<duenwen@google.com>, "mike.malvestuto@intel.com"
	<mike.malvestuto@intel.com>, "gthelen@google.com" <gthelen@google.com>,
	"wschwartz@amperecomputing.com" <wschwartz@amperecomputing.com>,
	"dferguson@amperecomputing.com" <dferguson@amperecomputing.com>, tanxiaofei
	<tanxiaofei@huawei.com>, "Zengtao (B)" <prime.zeng@hisilicon.com>,
	"kangkang.shen@futurewei.com" <kangkang.shen@futurewei.com>, wanghuiqiang
	<wanghuiqiang@huawei.com>, Linuxarm <linuxarm@huawei.com>,
	"wbs@os.amperecomputing.com" <wbs@os.amperecomputing.com>
Subject: RE: [RFC PATCH v7 12/12] memory: RAS2: Add memory RAS2 driver
Thread-Topic: [RFC PATCH v7 12/12] memory: RAS2: Add memory RAS2 driver
Thread-Index: AQHaZmXf7yKhv06+EU6o6xtLiEJk9LFOBiUAgAjJRxA=
Date: Wed, 3 Apr 2024 14:03:58 +0000
Message-ID: <32c348a0a61d4c6585b1b58e923a7f79@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <20240223143723.1574-13-shiju.jose@huawei.com>
 <78d11760-bb43-42a1-a302-3e2d3bf40c48@os.amperecomputing.com>
In-Reply-To: <78d11760-bb43-42a1-a302-3e2d3bf40c48@os.amperecomputing.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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

SGkgRGFuaWVsLA0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBEYW5pZWwg
RmVyZ3Vzb24gPGRhbmllbGZAb3MuYW1wZXJlY29tcHV0aW5nLmNvbT4NCj5TZW50OiAyOCBNYXJj
aCAyMDI0IDIzOjQyDQo+VG86IFNoaWp1IEpvc2UgPHNoaWp1Lmpvc2VAaHVhd2VpLmNvbT47IGxp
bnV4LWN4bEB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPmFjcGlAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1tbUBrdmFjay5vcmc7IGRhbi5qLndpbGxpYW1zQGludGVsLmNvbTsNCj5kYXZlQHN0Z29s
YWJzLm5ldDsgSm9uYXRoYW4gQ2FtZXJvbiA8am9uYXRoYW4uY2FtZXJvbkBodWF3ZWkuY29tPjsN
Cj5kYXZlLmppYW5nQGludGVsLmNvbTsgYWxpc29uLnNjaG9maWVsZEBpbnRlbC5jb207IHZpc2hh
bC5sLnZlcm1hQGludGVsLmNvbTsNCj5pcmEud2VpbnlAaW50ZWwuY29tDQo+Q2M6IGxpbnV4LWVk
YWNAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPmRhdmlk
QHJlZGhhdC5jb207IFZpbGFzLlNyaWRoYXJhbkBhbWQuY29tOyBsZW8uZHVyYW5AYW1kLmNvbTsN
Cj5ZYXplbi5HaGFubmFtQGFtZC5jb207IHJpZW50amVzQGdvb2dsZS5jb207IGppYXFpeWFuQGdv
b2dsZS5jb207DQo+dG9ueS5sdWNrQGludGVsLmNvbTsgSm9uLkdyaW1tQGFtZC5jb207IGRhdmUu
aGFuc2VuQGxpbnV4LmludGVsLmNvbTsNCj5yYWZhZWxAa2VybmVsLm9yZzsgbGVuYkBrZXJuZWwu
b3JnOyBuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbTsNCj5qYW1lcy5tb3JzZUBhcm0uY29tOyBqdGhv
dWdodG9uQGdvb2dsZS5jb207IHNvbWFzdW5kYXJhbS5hQGhwZS5jb207DQo+ZXJkZW1ha3Rhc0Bn
b29nbGUuY29tOyBwZ29uZGFAZ29vZ2xlLmNvbTsgZHVlbndlbkBnb29nbGUuY29tOw0KPm1pa2Uu
bWFsdmVzdHV0b0BpbnRlbC5jb207IGd0aGVsZW5AZ29vZ2xlLmNvbTsNCj53c2Nod2FydHpAYW1w
ZXJlY29tcHV0aW5nLmNvbTsgZGZlcmd1c29uQGFtcGVyZWNvbXB1dGluZy5jb207DQo+dGFueGlh
b2ZlaSA8dGFueGlhb2ZlaUBodWF3ZWkuY29tPjsgWmVuZ3RhbyAoQikgPHByaW1lLnplbmdAaGlz
aWxpY29uLmNvbT47DQo+a2FuZ2thbmcuc2hlbkBmdXR1cmV3ZWkuY29tOyB3YW5naHVpcWlhbmcg
PHdhbmdodWlxaWFuZ0BodWF3ZWkuY29tPjsNCj5MaW51eGFybSA8bGludXhhcm1AaHVhd2VpLmNv
bT47IHdic0Bvcy5hbXBlcmVjb21wdXRpbmcuY29tDQo+U3ViamVjdDogUmU6IFtSRkMgUEFUQ0gg
djcgMTIvMTJdIG1lbW9yeTogUkFTMjogQWRkIG1lbW9yeSBSQVMyIGRyaXZlcg0KPg0KPj4gKy8q
DQouLi4NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHJhczJfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikgew0KPj4gKwlpbnQgcmV0LCBpZDsNCj4+ICsJc3RydWN0IG1ib3hfY2xpZW50
ICpjbDsNCj4+ICsJc3RydWN0IGRldmljZSAqaHdfc2NydWJfZGV2Ow0KPj4gKwlzdHJ1Y3QgcmFz
Ml9jb250ZXh0ICpyYXMyX2N0eDsNCj4+ICsJY2hhciBzY3J1Yl9uYW1lW1JBUzJfTUFYX05BTUVf
TEVOR1RIXTsNCj4+ICsNCj4+ICsJcmFzMl9jdHggPSBkZXZtX2t6YWxsb2MoJnBkZXYtPmRldiwg
c2l6ZW9mKCpyYXMyX2N0eCksIEdGUF9LRVJORUwpOw0KPj4gKwlpZiAoIXJhczJfY3R4KQ0KPj4g
KwkJcmV0dXJuIC1FTk9NRU07DQo+PiArDQo+PiArCXJhczJfY3R4LT5kZXYgPSAmcGRldi0+ZGV2
Ow0KPj4gKwlyYXMyX2N0eC0+b3BzID0gJnJhczJfaHdfb3BzOw0KPj4gKwlzcGluX2xvY2tfaW5p
dCgmcmFzMl9jdHgtPnNwaW5sb2NrKTsNCj4+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwg
cmFzMl9jdHgpOw0KPj4gKw0KPj4gKwljbCA9ICZyYXMyX2N0eC0+bWJveF9jbGllbnQ7DQo+PiAr
CS8qIFJlcXVlc3QgbWFpbGJveCBjaGFubmVsICovDQo+PiArCWNsLT5kZXYgPSAmcGRldi0+ZGV2
Ow0KPj4gKwljbC0+dHhfZG9uZSA9IHJhczJfdHhfZG9uZTsNCj4+ICsJY2wtPmtub3dzX3R4ZG9u
ZSA9IHRydWU7DQo+PiArCXJhczJfY3R4LT5wY2Nfc3Vic3BhY2VfaWR4ID0gKigoaW50ICopcGRl
di0+ZGV2LnBsYXRmb3JtX2RhdGEpOw0KPj4gKwlkZXZfZGJnKCZwZGV2LT5kZXYsICJwY2Mtc3Vi
c3BhY2UtaWQ9JWRcbiIsIHJhczJfY3R4LQ0KPj5wY2Nfc3Vic3BhY2VfaWR4KTsNCj4+ICsJcmV0
ID0gcmFzMl9yZWdpc3Rlcl9wY2NfY2hhbm5lbChyYXMyX2N0eCk7DQo+DQo+SW4gb3VyIGVuYWJs
aW5nIGFjdGl2aXRpZXMsIHdlIGhhdmUgZm91bmQgYSBjaGFsbGVuZ2UgaGVyZS4NCj5PdXIgaGFy
ZHdhcmUgaGFzIGEgc2luZ2xlIFBDQyBjaGFubmVsIGNvcnJlc3BvbmRpbmcgdG8gYSBzaW5nbGUg
cGxhdGZvcm0td2lkZQ0KPnNjcnViIGludGVyZmFjZS4gVGhpcyBkcml2ZXIsIGZvbGxvd2luZyB0
aGUgQUNQSSBzcGVjLCB3aWxsIGNyZWF0ZSBhIG5ldyBzY3J1Yg0KPm5vZGUgZm9yIGVhY2ggTlVN
QSBub2RlLiBIb3dldmVyLCBmb3IgdXMsIHRoaXMgbWVhbnMgdGhhdCBlYWNoIHNjcnViIGRldmlj
ZQ0KPndpbGwgdHJ5IHRvIG1hcCB0aGUgc2FtZSBQQ0MgY2hhbm5lbCwgYW5kIHRoaXMgY2F1c2Vz
IGFuIGVycm9yLg0KDQpJcyBmYWlsaW5nIHRvIHByb2JlIGNsZWFubHkgaXMgZW5vdWdoIGZvciB5
b3VyIHBsYXRmb3JtPyAgaS5lLiBwdXQgYW55IGVycm9yIG1lc3NhZ2VzIGFzIGRldl9kYmcoKQ0K
b3Igd2hpY2hldmVyIG9uZSBjYXVzZXMgdGhpcyBwcm9ibGVtLg0KPj4gKwlpZiAocmV0IDwgMCkN
Cj4+ICsJCXJldHVybiByZXQ7DQo+PiArDQo+PiArCXJldCA9IGRldm1fYWRkX2FjdGlvbl9vcl9y
ZXNldCgmcGRldi0+ZGV2LCBkZXZtX3JhczJfcmVsZWFzZSwNCj5yYXMyX2N0eCk7DQo+PiArCWlm
IChyZXQgPCAwKQ0KPj4gKwkJcmV0dXJuIHJldDsNCj4+ICsNCj4+ICsJaWYgKHJhczJfaXNfcGF0
cm9sX3NjcnViX3N1cHBvcnQocmFzMl9jdHgpKSB7DQo+PiArCQlpZCA9IGlkYV9hbGxvYygmcmFz
Ml9pZGEsIEdGUF9LRVJORUwpOw0KPj4gKwkJaWYgKGlkIDwgMCkNCj4+ICsJCQlyZXR1cm4gaWQ7
DQo+PiArCQlyYXMyX2N0eC0+aWQgPSBpZDsNCj4+ICsJCXNucHJpbnRmKHNjcnViX25hbWUsIHNp
emVvZihzY3J1Yl9uYW1lKSwgIiVzJWQiLA0KPlJBUzJfU0NSVUIsIGlkKTsNCj4+ICsJCWRldl9z
ZXRfbmFtZSgmcGRldi0+ZGV2LCBSQVMyX0lEX0ZPUk1BVCwgaWQpOw0KPj4gKwkJaHdfc2NydWJf
ZGV2ID0gZGV2bV9zY3J1Yl9kZXZpY2VfcmVnaXN0ZXIoJnBkZXYtPmRldiwNCj5zY3J1Yl9uYW1l
LA0KPj4gKwkJCQkJCQkgIHJhczJfY3R4LA0KPiZyYXMyX3NjcnViX29wcywNCj4+ICsJCQkJCQkJ
ICAwLCBOVUxMKTsNCj4+ICsJCWlmIChQVFJfRVJSX09SX1pFUk8oaHdfc2NydWJfZGV2KSkNCj4+
ICsJCQlyZXR1cm4gUFRSX0VSUl9PUl9aRVJPKGh3X3NjcnViX2Rldik7DQo+PiArCX0NCj4+ICsJ
cmFzMl9jdHgtPnNjcnViX2RldiA9IGh3X3NjcnViX2RldjsNCj4+ICsNCj4+ICsJcmV0dXJuIDA7
DQo+PiArfQ0KPg0KVGhhbmtzLA0KU2hpanUNCg==

