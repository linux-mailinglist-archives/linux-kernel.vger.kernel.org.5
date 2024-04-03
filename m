Return-Path: <linux-kernel+bounces-129887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178FB8971A6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0F502832E4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6750A1494C8;
	Wed,  3 Apr 2024 13:52:11 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77479148318;
	Wed,  3 Apr 2024 13:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712152330; cv=none; b=JYrQHtA0ZF7569RwdDW/zC+h7lQ2EgD9pdAEPK1TwnFt8gV3jb3LeKcz+kgD3YXJaAuXs89oR9oSfiff9H7yks/JEALISo4HM7aNDoqA9a2AUpuGX1VXQqpoAdI5nBeJTqX6A+J4aZgcMoJGh/GiORo42yCFrtvgfD43vLF4VWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712152330; c=relaxed/simple;
	bh=HMEfWzbSwWAN8nTimw2mnfhX0tvSQNkY41MOF5tayJ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CguXoz+RSkLdnsjxXz5RT0JVWjXd+pVCQ88kZW/P6uSLJPZDDFJsgtThmli8JHw9u1vPGQ/1V08bdzoXYiwOen3jrIGNxSte839yH6AdIMRu2nwFH8RyLjy/+mgstJ9gcQ1W/9TTKAR9PtGtq5OmyY4C5V+rm9VJEqfBkgp+5aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4V8mJs5NVGz6D9Rl;
	Wed,  3 Apr 2024 21:47:25 +0800 (CST)
Received: from lhrpeml500004.china.huawei.com (unknown [7.191.163.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 85C61140CB9;
	Wed,  3 Apr 2024 21:52:03 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (7.191.161.198) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 14:52:03 +0100
Received: from lhrpeml500006.china.huawei.com ([7.191.161.198]) by
 lhrpeml500006.china.huawei.com ([7.191.161.198]) with mapi id 15.01.2507.035;
 Wed, 3 Apr 2024 14:52:03 +0100
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
Subject: RE: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Thread-Topic: [RFC PATCH v7 00/12] memory: scrub: introduce subsystem +
 CXL/ACPI-RAS2 drivers
Thread-Index: AQHaZmXXQwZWLjPhY0S3rmfIb/nqxrFOBaAAgAie3mA=
Date: Wed, 3 Apr 2024 13:52:02 +0000
Message-ID: <341e8365816746f58bc8f5b270f91eef@huawei.com>
References: <20240223143723.1574-1-shiju.jose@huawei.com>
 <0309f5f9-9a95-485c-a442-e9fba603d676@os.amperecomputing.com>
In-Reply-To: <0309f5f9-9a95-485c-a442-e9fba603d676@os.amperecomputing.com>
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

SGkgRGFuaWVsLA0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFja3MuDQoNCj4tLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPkZyb206IERhbmllbCBGZXJndXNvbiA8ZGFuaWVsZkBvcy5hbXBlcmVj
b21wdXRpbmcuY29tPg0KPlNlbnQ6IDI4IE1hcmNoIDIwMjQgMjM6NDANCj5UbzogU2hpanUgSm9z
ZSA8c2hpanUuam9zZUBodWF3ZWkuY29tPjsgbGludXgtY3hsQHZnZXIua2VybmVsLm9yZzsgbGlu
dXgtDQo+YWNwaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LW1tQGt2YWNrLm9yZzsgZGFuLmoud2ls
bGlhbXNAaW50ZWwuY29tOw0KPmRhdmVAc3Rnb2xhYnMubmV0OyBKb25hdGhhbiBDYW1lcm9uIDxq
b25hdGhhbi5jYW1lcm9uQGh1YXdlaS5jb20+Ow0KPmRhdmUuamlhbmdAaW50ZWwuY29tOyBhbGlz
b24uc2Nob2ZpZWxkQGludGVsLmNvbTsgdmlzaGFsLmwudmVybWFAaW50ZWwuY29tOw0KPmlyYS53
ZWlueUBpbnRlbC5jb20NCj5DYzogbGludXgtZWRhY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+ZGF2aWRAcmVkaGF0LmNvbTsgVmlsYXMuU3JpZGhhcmFu
QGFtZC5jb207IGxlby5kdXJhbkBhbWQuY29tOw0KPllhemVuLkdoYW5uYW1AYW1kLmNvbTsgcmll
bnRqZXNAZ29vZ2xlLmNvbTsgamlhcWl5YW5AZ29vZ2xlLmNvbTsNCj50b255Lmx1Y2tAaW50ZWwu
Y29tOyBKb24uR3JpbW1AYW1kLmNvbTsgZGF2ZS5oYW5zZW5AbGludXguaW50ZWwuY29tOw0KPnJh
ZmFlbEBrZXJuZWwub3JnOyBsZW5iQGtlcm5lbC5vcmc7IG5hb3lhLmhvcmlndWNoaUBuZWMuY29t
Ow0KPmphbWVzLm1vcnNlQGFybS5jb207IGp0aG91Z2h0b25AZ29vZ2xlLmNvbTsgc29tYXN1bmRh
cmFtLmFAaHBlLmNvbTsNCj5lcmRlbWFrdGFzQGdvb2dsZS5jb207IHBnb25kYUBnb29nbGUuY29t
OyBkdWVud2VuQGdvb2dsZS5jb207DQo+bWlrZS5tYWx2ZXN0dXRvQGludGVsLmNvbTsgZ3RoZWxl
bkBnb29nbGUuY29tOw0KPndzY2h3YXJ0ekBhbXBlcmVjb21wdXRpbmcuY29tOyBkZmVyZ3Vzb25A
YW1wZXJlY29tcHV0aW5nLmNvbTsNCj50YW54aWFvZmVpIDx0YW54aWFvZmVpQGh1YXdlaS5jb20+
OyBaZW5ndGFvIChCKSA8cHJpbWUuemVuZ0BoaXNpbGljb24uY29tPjsNCj5rYW5na2FuZy5zaGVu
QGZ1dHVyZXdlaS5jb207IHdhbmdodWlxaWFuZyA8d2FuZ2h1aXFpYW5nQGh1YXdlaS5jb20+Ow0K
PkxpbnV4YXJtIDxsaW51eGFybUBodWF3ZWkuY29tPjsgd2JzQG9zLmFtcGVyZWNvbXB1dGluZy5j
b20NCj5TdWJqZWN0OiBSZTogW1JGQyBQQVRDSCB2NyAwMC8xMl0gbWVtb3J5OiBzY3J1YjogaW50
cm9kdWNlIHN1YnN5c3RlbSArDQo+Q1hML0FDUEktUkFTMiBkcml2ZXJzDQo+DQo+PiBSQVMyIEhX
IGJhc2VkIG1lbW9yeSBwYXRyb2wgc2NydWIgbmVlZHMgUkFTMiBQQ0MgaW50ZXJmYWNlcyBhbmQg
QUNQSQ0KPj4gUkFTMiBkcml2ZXIgZm9yIGNvbW11bmljYXRpb24gYi93IGtlcm5lbCBhbmQgZmly
bXdhcmUuDQo+PiBBQ1BJIFJBUzIgRHJpdmVyIGFkZHMgcGxhdGZvcm0gZGV2aWNlLCBmb3IgZWFj
aCBtZW1vcnkgZmVhdHVyZSwgd2hpY2gNCj4+IGJpbmRzIHRvIHRoZSBSQVMyIG1lbW9yeSBkcml2
ZXIuDQo+PiBNZW1vcnkgUkFTMiBkcml2ZXIgcmVnaXN0ZXJzIHdpdGggdGhlIG1lbW9yeSBzY3J1
YiBzdWJzeXN0ZW0gdG8gZXhwb3NlDQo+PiB0aGUgUkFTMiBzY3J1YiBjb250cm9scyB0byB0aGUg
dXNlci4NCj4NCj5IaSBTaGlqdSwNCj5UaGFua3MgZm9yIHRoaXMgd29yay4gVGhpcyBoYXMgYmVl
biB2ZXJ5IHVzZWZ1bCBmb3IgdXMsIGFzIHdlJ3ZlIGJlZW4gdXNpbmcgaXQgdG8NCj50ZXN0IGEg
UkFTMiBpbXBsZW1lbnRhdGlvbiBoZXJlIGF0IEFtcGVyZSBDb21wdXRpbmcuDQo+DQo+SW4gZ2Vu
ZXJhbCwgdGhlIHBpZWNlcyBpbXBsZW1lbnRpbmcgUkFTMiBhcmUgdXNlZnVsIGFuZCBmdW5jdGlv
bmFsLiBXZSBkaWQsDQo+aG93ZXZlciwgZW5jb3VudGVyIGEgZmV3IHBsYWNlcyB3aGVyZSB3ZSBo
YWQgdG8gbWFrZSBzb21lIGJ1ZyBmaXhlcy4NCj5JJ2xsIHJlcGx5IHRvIHNwZWNpZmljIHBhdGNo
ZXMgd2l0aCBjaGFuZ2VzIEkgY2FuIHJlY29tbWVuZC4gQWxzbywgdGhlcmUgYXJlIGENCj5mZXcg
aW1wbGVtZW50YXRpb24gY2hvaWNlcyB0aGF0IEkgd2lsbCBoYXZlIHF1ZXN0aW9ucyBhYm91dC4N
Cj4NCj5IZXJlIGlzIGFuIG91dGxpbmUgY29udGFpbmluZyB0aGUgZ2VuZXJhbGl6ZWQgY29tbWVu
dHMgSSBwbGFuIG9uIG1ha2luZw0KPndpdGhpbi9uZWFyIHJlbGV2YW50IHBhdGNoZXM6DQo+MSkg
Rm91bmQgYSBidWcgaW4gcmFzMi5jIGluIGhvdyB0aGUgcGNjX2Rlc2NfbGlzdCBwb2ludGVyIGlz
IGluY3JlbWVudGVkLg0KVGhpcyBidWcgd2FzIGZpeGVkIGluIHRoZSBsb2NhbCB2OCBjb2RlLg0K
DQo+MikgRXhlY3V0aW5nIGEgUkFTMiBjb21tYW5kIHNlZW1zIHVubmVjZXNzYXJ5IGZvciBmZWF0
dXJlIGRldGVjdGlvbi4NCj5zcGVjaWZpY2FsbHksIGluIHRoZSBmdW5jdGlvbnMgcmFzMl9pc19w
YXRyb2xfc2NydWJfc3VwcG9ydCgpIGFuZA0KPnJhczJfZ2V0X3BhdHJvbF9zY3J1Yl9wYXJhbXMo
KQ0KSSB3aWxsIGNoZWNrIGFuZCBtb2RpZnkgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPjMpIENv
bnNpZGVyIGFkZGluZyBtb3JlIGVycm9yIGRldGVjdGlvbi9yZXBvcnRpbmcgaW4gcmFzMl9jaGVj
a19wY2NfY2hhbigpDQpTdXJlLg0KDQo+NCkgQ29uY2VybnMgd2l0aCBtdWx0aXBsZSBzY3J1YiBk
ZXZpY2VzIGF0dGVtcHRpbmcgdG8gbWFwIHRoZSBzYW1lIFBDQw0KPmNoYW5uZWwuDQpJIHdpbGwg
cmVwbHkgaW4gdGhlIHBhdGNoLiANCj4NCj4tRGFuaWVsDQo+DQpUaGFua3MsDQpTaGlqdQ0KDQo=

