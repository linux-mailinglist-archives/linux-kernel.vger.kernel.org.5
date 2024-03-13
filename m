Return-Path: <linux-kernel+bounces-101173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B327687A362
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 875A928345B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063F6171C1;
	Wed, 13 Mar 2024 07:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="S3PtZ2Sg"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1510171A3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 07:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710314564; cv=fail; b=tz6HVqmNTvurth23M7NMg5Hxw20f5huic5nHR2oexcAYyNTY/RID86ewp4ZlO30Zg4yiGHqIoOqoiWHh2UBLVCLgcx3eqVnrA6OtMkGsDMxC/bwXqb11Uq/BrvrtGbH/4QDujkE5pMKsKyLXfzSmDa1NSNNfob95lxQ6XR2BbyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710314564; c=relaxed/simple;
	bh=Y91ala/UrWwNWaD4hgq+/WDEu4aWeejTLADHp/AKYLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n5XMThFDiDL+k9PQQ9tGFUJdlI77PbMzBeRBtYgbOoohszMF69JWavONq/zQ/ta4sZELMlP2cDDelngemInFcnBbw9XSgy63TCPvJ5AfS6dHvEaHzqkqypzTjUZVlJwOvRYD7DxGPjXizMTeImeMvuDm5obwl1fSVVe8G4zVGy4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=S3PtZ2Sg; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zy9PwmoAe521VcmXcpKSfX2AUaFaR++o4vb4EYyh1g8931JJB+Ja1VB4VUcVXnw0wcgAyi1Vk/cs6eETvjlOiGGq7Voja8+SnIbxVJZZmo7UM+5cMfB83hlBfYbH2Iff0siwsIS43bDCVXFW1gie03Yk7BNkcg1ClxhT8AkeljW0zI3yqemo1NlI3VMvWVgIm/FJE2v8fR++kNaW3+Kq7EoF0tDMf71Oi6hu6m4fTDZl2gOhKgRgTZI+rlMAcLUFLk+9pwAR4ECgWQRk6Pr01cRYs4ZAWsnz0xZ3QYYzrmlwyPHAu0eCPgtL4ZPHJmpShHyXuXaITyNivCar7gBhBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y91ala/UrWwNWaD4hgq+/WDEu4aWeejTLADHp/AKYLQ=;
 b=n1Yc+hE1VR0pH1rBbwu+SuXz4y1ZfGzMXqyecLTypCXJlWom0dOPXEeDaE0Oit4KUlMrYCN0V6f58XMI1rIMj9w4u+x9CZ8WPEHW2E7MvLPx9Lq4RUOcBQKwf0UyyOPATGuMzqIijDmRGzfzunsZWVQoQn+3Tr5sjfIPX8bEt5LU8KpvKwh4RbCCYoX3mUJBtApb3jyXe187epCd6XmYcG1/SNmF4RMOnv2/gG/GwMgmy8X2RBX5OzcQ78h1eYNZ2UGDabVnA2Qq2MJ1YZFO0b3CZQ0KKaQc4M5vVFThKLr76uXw8fUPy9Bk5eLFV/fUhV1Kx7LpDOpGHjRDzpQ8CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y91ala/UrWwNWaD4hgq+/WDEu4aWeejTLADHp/AKYLQ=;
 b=S3PtZ2SgwM9CFX6b3jJQiLC7U2kIC70wk1/UihHbSH8g2gwErC2VDwMZNr0kljzaKfAWMhhXVgJZYzXRGgr8oV9ZgRt9eRmITy0EYVPi4wwykelrrkNERVLSYr2dHBmLq95TVU8q3O/DrIS08Y1rv78GhU3qVLNSScVsZZdpCs4QVrW/ZwHHhEmd/FU9lt32dyw6w1P0WmL+i7Sdallnkezrp954Cu1ez+RyFqXMQA07MLY5Y4wzoPpFaGWilVQfV22ixVBimOhASXGf7kQ5K8UtF6fiINsTh3+dQpOjy1fzvdVrzgseQ4kd0m6r1Cd2kVPaCPGpeoMDfF5ft9UnbA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR1P264MB1536.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1b6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 07:22:38 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 07:22:38 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH v3 02/12] mm: Introduce arch_get_unmapped_area_vmflags()
Thread-Topic: [PATCH v3 02/12] mm: Introduce arch_get_unmapped_area_vmflags()
Thread-Index: AQHadMy07Ta/tB3/dUK1hKbQtRce+7E1RNoA
Date: Wed, 13 Mar 2024 07:22:38 +0000
Message-ID: <d8af66d6-4ba7-45f6-877c-e89627506551@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-3-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-3-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PR1P264MB1536:EE_
x-ms-office365-filtering-correlation-id: d47c1b4f-339c-4b00-3533-08dc432e5d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 LccVYXeN3UKB5GS7IurzhsrD7GahpAmAdxhtvsdvyM+0rYd/pxaEN83ZbnCqeN2GRO/51LQ5th9Z1y3a5WjN3ycJrjPEgz5aWwR4NYL0piyS8iZUQr2SmzjIDMHohYKpc3aqQ7ovwKxgFDCGrCASrexGO8jUn9nSTseIHZPP4QHdqd3SuQgNDbC3JEqMCNeOLGYB97Ft/iXCJvSpL6LSFMZ/f0V8eZcMwL8/WN1RpOCuIO7bbD65j60FS42BYPSoLZR2swjFVu8+0lT/oyw9HpnRclyoQ1c7g6HOgu7gPDafhnVRVsUiltXofmT2rzMjEPpOFZWu8+fltqpTVabm4kFBtMUM84ISGXpOgavXYe62vF9JCc8f+e1A7NipFz+hDk4exbo390Hx4ZmFSuuxBy6F7r5ZZAIay+QMrxfIYKjuqJc/kMYNh80vt+qfCHBw6JR3nKJpqgHp3P8/Dgepqqbxilndl5rG56BSzq1je6mVQzd/uijAn8muje1SmVjsdZz0bDnUWz0pvyE+YUATdOTcDsxHcq7xrCrzqdjSz8Y4NZL3D5ngprbHXrB6My7ypfTkTt+Lh5cuznlDmzG52IibiD5tVpWK6OY81Ensw8/OlrCsypw6XBET8BS5XAauvLaR2yG5Nb41FSKSNtu/9bbUg9O+hMHG8taYwlhqQfpVEKk+zLz9L2sxQqaRv9LwwElURAAZbvXyGFvzTyBFrrkkxgzx9aafkqvgg3zOJyw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(921011)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cENpazU4SzZJZGNWdTZQeDdPclY0dkdWU2dFcWRKWm5ZTDk4clZBK3F4TktG?=
 =?utf-8?B?STA0ZjRuallZc0FpT3lFL09uNzJhdXNScVpPOHBhUFUyeCtDbmg3Z0d3QjVx?=
 =?utf-8?B?c0lmSnAzTmFYT0djREszWEs1cUlhejlXT3lzR0o5eTlYYlVpQ0o4eURJTGhG?=
 =?utf-8?B?cVJSL3l5Q1k3UG8rMzVIZFBCSkNIbkhCT2lzNVp1TmordElQNlNmaEcwQ0VG?=
 =?utf-8?B?RXBsNlo0MXZ6ZmFHcVJHdEtHZmZ1WklNMlVndy9YT3I5MytjU0VCelorRExU?=
 =?utf-8?B?eDRJZWF0WnZYZGhxQXBMUVQraFQrWFpzaTk3Z3BiT2JmSVdlYmRUUzRCekZU?=
 =?utf-8?B?cjJINVVCWDAvbG5EakhBVzd4cDd0bFZWcFhRWkdDSzVsbGRWTTBDbjRzbmlQ?=
 =?utf-8?B?cU5ZdlEzdUtabnMzQUg4ZHZyank0R1l3U3puYi9JTnc4dFBSYkhTMkkveE0z?=
 =?utf-8?B?dWlheFpVeE1GTGRHZ29LblJRdndGbFo2UmpnY2ZoQmlybTJnMzJGVUlpTzNW?=
 =?utf-8?B?elNvb1ZMUTZFeXBwMUZMQi9CcVFQaW1LQWJvb0xsTkYzQ1ZLMnZ3TlZMUWpi?=
 =?utf-8?B?SDRFS2lrbXJnZjRVclpDSUpBdW93cnpuVWpyMUpJaUNnZHlrZFN6eXVBQjRD?=
 =?utf-8?B?RkluczlqUUxhekhSZ1pZY1ZvTG1DY2hLRDVCbS9RcnJsN0tod2lrV0xKUDVM?=
 =?utf-8?B?S2hBa2dGdXVvMDRVcE5jem5ZTDdnenlkK0VOT3JkVlQ5VGJqd2pEK1ZmZWR2?=
 =?utf-8?B?TGpUNHRlL1J6VDNiMnBTTGg0MW1nQ1grMkNpcjk1RzgyOXp4TFB3RUlPUlZq?=
 =?utf-8?B?QUQrY3RNd0hkWHlrUmtEUER2SFY5RS9aUUxacStOQ0JvWkc0U0FkUmVSUERt?=
 =?utf-8?B?M05yRmJ4OWd2ZEhyRmh3bTZ5WFNHK0c0U2VhblNKWkJIUTZPU1dGeTJ3YU5H?=
 =?utf-8?B?Rm04bjFrOGdNNkdocEd3Ykxwb3llSEk4N0Y3d1ZWRjFJV2R4VDJyeUxtZkVZ?=
 =?utf-8?B?akRQbC9OZEpBTWJBNHhZaHRmZ3lvUE5QQUJLOVJ4MFdiNlZ6NmJuM1FQcS9o?=
 =?utf-8?B?UkVpa3o5WFQ3ZWlZQ25YNG9PMk55ZzRBUllBWi9QUFZRZ1llMFdBSDM1ZVBN?=
 =?utf-8?B?L3JLSXBSZm8xemtjem1JekQxYWtmaHlMNzk3bXBZbUxJQTgveHBPZmw0SFhH?=
 =?utf-8?B?YTlOU2d2RXphampPVFkwbmpDN3hsbW5vV3RRUmpIYS9tNHpuMHVwMHRGWXdU?=
 =?utf-8?B?OVNOR3J0N2haZ0ZsSjd1Z2tGZFpKbXJSOUxOcUJxQUFzUjloeEhubGw4cXRp?=
 =?utf-8?B?a3VrL25JMU9ob1gzeWpXYk1QUXRGUHI2SWtndXdhVXFuWGcwcithb0VZMU5C?=
 =?utf-8?B?Q1N1b0JEcS81eVNuR0Jja0dvTTRKK2RGN2p1M01Fd2FqSi8rVmtkenpvZUlI?=
 =?utf-8?B?RXpKbTlEUTdGTkhJZG5nSWFLTXJXVWpTNXE4RU5rN3liN1NYVnNsVmNyeVpC?=
 =?utf-8?B?K3BMOUk0TDJNQmtjNEgyblpULzlleUVZNUhWU3ZpWTdJMkRaeXlUTUQ5Vk9S?=
 =?utf-8?B?N3JhdnRGUFNhQmx3WFNpQU9aRlUvaERXdzZxaFNoaERITFdVMUg4TnpmWU5j?=
 =?utf-8?B?a3Fud2NnK2hEWnB4K3VIdlpBbEpHdVhpdTNJT3gzcURzUzk5d2lKaUlZWURk?=
 =?utf-8?B?bWtObVhSRnZROXByUk9BK2dIY1FpblYxNk1BNzB4N2JNTzJTU29hclRRWGdZ?=
 =?utf-8?B?VzJObkRwbUNtU2h0cG54c29MWENTVW1sa2E0RXhEQm9KUHBON05JMWNwZVFw?=
 =?utf-8?B?LzY4RkIxNFNPYzFXQVhQNXBPb1lvVmNLUGRuQzBwbW44b1hqNGdsTGxxQmtM?=
 =?utf-8?B?YkdGdkdsTWN5ZnRnNlQ3aWpqa255aGtPZk5mZExacjBYaW1MRlVtTytrTjFy?=
 =?utf-8?B?ZkdaRmpZQkprbU9uWUdTUnQ4OHZld0JwbWsyYUxrbWNnNXQyVHdzOWNqS3Rq?=
 =?utf-8?B?RjFid3FjY25Ya3k0WkR6LzFydlFucFYwTm40Q2ViT2EvK0laU3V4ODdHcjZX?=
 =?utf-8?B?b3l1WmpBbUY1MTYyNDdjMzdMV3pHc0VmeWZiRElVMm51WFhxSW1tVk5GdTVF?=
 =?utf-8?Q?AN8K+HclIfPkL45qmcvM0dfmW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B646FF959A29144AADDDB96955EF53B0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: d47c1b4f-339c-4b00-3533-08dc432e5d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 07:22:38.7340
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0ZgHaPIo0r2s30pLyDxhymNTEAIGGjo4QPL/NQD3OEH6o96/vu5J1zlX88akUOucMN18uFJT8mFY8NJ6w4OAOPhO86ppivS5/e1khMTWr8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR1P264MB1536

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IFdoZW4gbWVtb3J5IGlzIGJlaW5nIHBsYWNlZCwgbW1hcCgpIHdpbGwgdGFrZSBjYXJlIHRvIHJl
c3BlY3QgdGhlIGd1YXJkDQo+IGdhcHMgb2YgY2VydGFpbiB0eXBlcyBvZiBtZW1vcnkgKFZNX1NI
QURPV1NUQUNLLCBWTV9HUk9XU1VQIGFuZA0KPiBWTV9HUk9XU0RPV04pLiBJbiBvcmRlciB0byBl
bnN1cmUgZ3VhcmQgZ2FwcyBiZXR3ZWVuIG1hcHBpbmdzLCBtbWFwKCkNCj4gbmVlZHMgdG8gY29u
c2lkZXIgdHdvIHRoaW5nczoNCj4gICAxLiBUaGF0IHRoZSBuZXcgbWFwcGluZyBpc27igJl0IHBs
YWNlZCBpbiBhbiBhbnkgZXhpc3RpbmcgbWFwcGluZ3MgZ3VhcmQNCj4gICAgICBnYXBzLg0KPiAg
IDIuIFRoYXQgdGhlIG5ldyBtYXBwaW5nIGlzbuKAmXQgcGxhY2VkIHN1Y2ggdGhhdCBhbnkgZXhp
c3RpbmcgbWFwcGluZ3MNCj4gICAgICBhcmUgbm90IGluICppdHMqIGd1YXJkIGdhcHMuDQo+IA0K
PiBUaGUgbG9uZyBzdGFuZGluZyBiZWhhdmlvciBvZiBtbWFwKCkgaXMgdG8gZW5zdXJlIDEsIGJ1
dCBub3QgdGFrZSBhbnkgY2FyZQ0KPiBhcm91bmQgMi4gU28gZm9yIGV4YW1wbGUsIGlmIHRoZXJl
IGlzIGEgUEFHRV9TSVpFIGZyZWUgYXJlYSwgYW5kIGENCj4gbW1hcCgpIHdpdGggYSBQQUdFX1NJ
WkUgc2l6ZSwgYW5kIGEgdHlwZSB0aGF0IGhhcyBhIGd1YXJkIGdhcCBpcyBiZWluZw0KPiBwbGFj
ZWQsIG1tYXAoKSBtYXkgcGxhY2UgdGhlIHNoYWRvdyBzdGFjayBpbiB0aGUgUEFHRV9TSVpFIGZy
ZWUgYXJlYS4gVGhlbg0KPiB0aGUgbWFwcGluZyB0aGF0IGlzIHN1cHBvc2VkIHRvIGhhdmUgYSBn
dWFyZCBnYXAgd2lsbCBub3QgaGF2ZSBhIGdhcCB0bw0KPiB0aGUgYWRqYWNlbnQgVk1BLg0KPiAN
Cj4gSW4gb3JkZXIgdG8gdGFrZSB0aGUgc3RhcnQgZ2FwIGludG8gYWNjb3VudCwgdGhlIG1hcGxl
IHRyZWUgc2VhcmNoIG5lZWRzDQo+IHRvIGtub3cgdGhlIHNpemUgb2Ygc3RhcnQgZ2FwIHRoZSBu
ZXcgbWFwcGluZyB3aWxsIG5lZWQuIFRoZSBjYWxsIGNoYWluDQo+IGZyb20gZG9fbW1hcCgpIHRv
IHRoZSBhY3R1YWwgbWFwbGUgdHJlZSBzZWFyY2ggbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gZG9f
bW1hcChzaXplLCB2bV9mbGFncywgbWFwX2ZsYWdzLCAuLikNCj4gCW1tL21tYXAuYzpnZXRfdW5t
YXBwZWRfYXJlYShzaXplLCBtYXBfZmxhZ3MsIC4uLikNCj4gCQlhcmNoX2dldF91bm1hcHBlZF9h
cmVhKHNpemUsIG1hcF9mbGFncywgLi4uKQ0KPiAJCQl2bV91bm1hcHBlZF9hcmVhKHN0cnVjdCB2
bV91bm1hcHBlZF9hcmVhX2luZm8pDQo+IA0KPiBPbmUgb3B0aW9uIHdvdWxkIGJlIHRvIGFkZCBh
bm90aGVyIE1BUF8gZmxhZyB0byBtZWFuIGEgb25lIHBhZ2Ugc3RhcnQgZ2FwDQo+IChhcyBpcyBm
b3Igc2hhZG93IHN0YWNrKSwgYnV0IHRoaXMgY29uc3VtZXMgYSBmbGFnIHVubmVjZXNzYXJpbHku
IEFub3RoZXINCj4gb3B0aW9uIGNvdWxkIGJlIHRvIHNpbXBseSBpbmNyZWFzZSB0aGUgc2l6ZSBw
YXNzZWQgaW4gZG9fbW1hcCgpIGJ5IHRoZQ0KPiBzdGFydCBnYXAgc2l6ZSwgYW5kIGFkanVzdCBh
ZnRlciB0aGUgZmFjdCwgYnV0IHRoaXMgd2lsbCBpbnRlcmZlcmUgd2l0aA0KPiB0aGUgYWxpZ25t
ZW50IHJlcXVpcmVtZW50cyBwYXNzZWQgaW4gc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbywg
YW5kDQo+IHVua25vd24gdG8gbW1hcC5jLiBJbnN0ZWFkLCBpbnRyb2R1Y2UgdmFyaWFudHMgb2YN
Cj4gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYS9fdG9wZG93bigpIHRoYXQgdGFrZSB2bV9mbGFncy4g
SW4gZnV0dXJlIGNoYW5nZXMsDQo+IHRoZXNlIHZhcmlhbnRzIGNhbiBiZSB1c2VkIGluIG1tYXAu
YzpnZXRfdW5tYXBwZWRfYXJlYSgpIHRvIGFsbG93IHRoZQ0KPiB2bV9mbGFncyB0byBiZSBwYXNz
ZWQgdGhyb3VnaCB0byB2bV91bm1hcHBlZF9hcmVhKCksIHdoaWxlIHByZXNlcnZpbmcgdGhlDQo+
IG5vcm1hbCBhcmNoX2dldF91bm1hcHBlZF9hcmVhL190b3Bkb3duKCkgZm9yIHRoZSBleGlzdGlu
ZyBjYWxsZXJzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogUmljayBFZGdlY29tYmUgPHJpY2sucC5l
ZGdlY29tYmVAaW50ZWwuY29tPg0KPiAtLS0NCj4gICBpbmNsdWRlL2xpbnV4L3NjaGVkL21tLmgg
fCAxNyArKysrKysrKysrKysrKysrKw0KPiAgIG1tL21tYXAuYyAgICAgICAgICAgICAgICB8IDI4
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAyIGZpbGVzIGNoYW5nZWQsIDQ1IGlu
c2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3NjaGVkL21tLmgg
Yi9pbmNsdWRlL2xpbnV4L3NjaGVkL21tLmgNCj4gaW5kZXggY2RlOTQ2ZTkyNmQ4Li43YjQ0NDQx
ODY1YzUgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbGludXgvc2NoZWQvbW0uaA0KPiArKysgYi9p
bmNsdWRlL2xpbnV4L3NjaGVkL21tLmgNCj4gQEAgLTE5MSw2ICsxOTEsMjMgQEAgdW5zaWduZWQg
bG9uZyBtbV9nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgbW1fc3RydWN0ICptbSwgc3RydWN0IGZp
bGUgKmZpbHAsDQo+ICAgCQkJCSAgIHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBs
ZW4sDQo+ICAgCQkJCSAgIHVuc2lnbmVkIGxvbmcgcGdvZmYsIHVuc2lnbmVkIGxvbmcgZmxhZ3Mp
Ow0KPiAgIA0KPiArZXh0ZXJuIHVuc2lnbmVkIGxvbmcNCj4gK2FyY2hfZ2V0X3VubWFwcGVkX2Fy
ZWFfdm1mbGFncyhzdHJ1Y3QgZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiArCQkJ
ICAgICAgIHVuc2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIHBnb2ZmLA0KPiArCQkJICAg
ICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIHZtX2ZsYWdzX3Qgdm1fZmxhZ3MpOw0KPiArZXh0ZXJu
IHVuc2lnbmVkIGxvbmcNCj4gK2FyY2hfZ2V0X3VubWFwcGVkX2FyZWFfdG9wZG93bl92bWZsYWdz
KHN0cnVjdCBmaWxlICpmaWxwLCB1bnNpZ25lZCBsb25nIGFkZHIsDQo+ICsJCQkJICAgICAgIHVu
c2lnbmVkIGxvbmcgbGVuLCB1bnNpZ25lZCBsb25nIHBnb2ZmLA0KPiArCQkJCSAgICAgICB1bnNp
Z25lZCBsb25nIGZsYWdzLCB2bV9mbGFnc190KTsNCg0KUGxlYXNlLCBubyBuZXcgImV4dGVybiIs
IHRoYXQncyBwb2ludGxlc3MgZm9yIGZ1bmN0aW9uIHByb3RvdHlwZXMgYW5kIA0Kb3V0ZGF0ZSBj
b2Rpbmcgc3R5bGUuIENoZWNrcGF0Y2ggLS1zdHJpY3QgaXMgbGlrZWx5IHByb3Rlc3RpbmcgYWJv
dXQgaXQuDQoNCj4gKw0KPiArdW5zaWduZWQgbG9uZyBtbV9nZXRfdW5tYXBwZWRfYXJlYV92bWZs
YWdzKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPiArCQkJCQkgICBzdHJ1Y3QgZmlsZSAqZmlscCwN
Cj4gKwkJCQkJICAgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiArCQkJCQkgICB1bnNpZ25lZCBsb25n
IGxlbiwNCj4gKwkJCQkJICAgdW5zaWduZWQgbG9uZyBwZ29mZiwNCj4gKwkJCQkJICAgdW5zaWdu
ZWQgbG9uZyBmbGFncywNCj4gKwkJCQkJICAgdm1fZmxhZ3NfdCB2bV9mbGFncyk7DQo+ICsNCj4g
ICB1bnNpZ25lZCBsb25nDQo+ICAgZ2VuZXJpY19nZXRfdW5tYXBwZWRfYXJlYShzdHJ1Y3QgZmls
ZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiAgIAkJCSAgdW5zaWduZWQgbG9uZyBsZW4s
IHVuc2lnbmVkIGxvbmcgcGdvZmYsDQo+IGRpZmYgLS1naXQgYS9tbS9tbWFwLmMgYi9tbS9tbWFw
LmMNCj4gaW5kZXggMzllOWEzYWUzY2E1Li5lMjNjZThjYTI0YzkgMTAwNjQ0DQo+IC0tLSBhL21t
L21tYXAuYw0KPiArKysgYi9tbS9tbWFwLmMNCj4gQEAgLTE4MTAsNiArMTgxMCwzNCBAQCBhcmNo
X2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd24oc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGxv
bmcgYWRkciwNCj4gICB9DQo+ICAgI2VuZGlmDQo+ICAgDQo+ICsjaWZuZGVmIEhBVkVfQVJDSF9V
Tk1BUFBFRF9BUkVBX1ZNRkxBR1MNCj4gK2V4dGVybiB1bnNpZ25lZCBsb25nDQo+ICthcmNoX2dl
dF91bm1hcHBlZF9hcmVhX3ZtZmxhZ3Moc3RydWN0IGZpbGUgKmZpbHAsIHVuc2lnbmVkIGxvbmcg
YWRkciwgdW5zaWduZWQgbG9uZyBsZW4sDQo+ICsJCQkgICAgICAgdW5zaWduZWQgbG9uZyBwZ29m
ZiwgdW5zaWduZWQgbG9uZyBmbGFncywgdm1fZmxhZ3NfdCB2bV9mbGFncykNCj4gK3sNCj4gKwly
ZXR1cm4gYXJjaF9nZXRfdW5tYXBwZWRfYXJlYShmaWxwLCBhZGRyLCBsZW4sIHBnb2ZmLCBmbGFn
cyk7DQo+ICt9DQoNClNhbWUsIHdoYXQgaXMgdGhlIHBvaW50IHdpdGggdGhhdCAiZXh0ZXJuIiBr
ZXl3b3JkIGluIGZ1bmN0aW9uIGRlZmluaXRpb24gPw0KDQo+ICsNCj4gK2V4dGVybiB1bnNpZ25l
ZCBsb25nDQo+ICthcmNoX2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd25fdm1mbGFncyhzdHJ1Y3Qg
ZmlsZSAqZmlscCwgdW5zaWduZWQgbG9uZyBhZGRyLA0KPiArCQkJCSAgICAgICB1bnNpZ25lZCBs
b25nIGxlbiwgdW5zaWduZWQgbG9uZyBwZ29mZiwNCj4gKwkJCQkgICAgICAgdW5zaWduZWQgbG9u
ZyBmbGFncywgdm1fZmxhZ3NfdCB2bV9mbGFncykNCj4gK3sNCj4gKwlyZXR1cm4gYXJjaF9nZXRf
dW5tYXBwZWRfYXJlYV90b3Bkb3duKGZpbHAsIGFkZHIsIGxlbiwgcGdvZmYsIGZsYWdzKTsNCj4g
K30NCj4gKyNlbmRpZg0KPiArDQo+ICt1bnNpZ25lZCBsb25nIG1tX2dldF91bm1hcHBlZF9hcmVh
X3ZtZmxhZ3Moc3RydWN0IG1tX3N0cnVjdCAqbW0sIHN0cnVjdCBmaWxlICpmaWxwLA0KPiArCQkJ
CQkgICB1bnNpZ25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0KPiArCQkJCQkgICB1
bnNpZ25lZCBsb25nIHBnb2ZmLCB1bnNpZ25lZCBsb25nIGZsYWdzLA0KPiArCQkJCQkgICB2bV9m
bGFnc190IHZtX2ZsYWdzKQ0KPiArew0KPiArCWlmICh0ZXN0X2JpdChNTUZfVE9QRE9XTiwgJm1t
LT5mbGFncykpDQo+ICsJCXJldHVybiBhcmNoX2dldF91bm1hcHBlZF9hcmVhX3RvcGRvd25fdm1m
bGFncyhmaWxwLCBhZGRyLCBsZW4sIHBnb2ZmLA0KPiArCQkJCQkJCSAgICAgIGZsYWdzLCB2bV9m
bGFncyk7DQo+ICsJcmV0dXJuIGFyY2hfZ2V0X3VubWFwcGVkX2FyZWFfdm1mbGFncyhmaWxwLCBh
ZGRyLCBsZW4sIHBnb2ZmLCBmbGFncywgdm1fZmxhZ3MpOw0KPiArfQ0KPiArDQo+ICAgdW5zaWdu
ZWQgbG9uZw0KPiAgIGdldF91bm1hcHBlZF9hcmVhKHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25l
ZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgbGVuLA0KPiAgIAkJdW5zaWduZWQgbG9uZyBwZ29m
ZiwgdW5zaWduZWQgbG9uZyBmbGFncykNCg==

