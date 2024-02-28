Return-Path: <linux-kernel+bounces-84805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF5786ABD0
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D7C28A84B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0151364AE;
	Wed, 28 Feb 2024 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="sPPi9LaU"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2114.outbound.protection.outlook.com [40.107.215.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D33613E
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 10:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709114529; cv=fail; b=EPk/ksfiNnKo38XUu/Q355mzWCC8b21fpFouY1l+EJG+621Bd5NkubRGI3P8jtLTTszdaxj+ERBdlP7tTx9ZqpjleluS2fjEsaxO3822SJ88H63cCIxPi4nnf7VRmHdA6TH4p1DTPQnCdWL4zFAxg6/qdgtWazhZOnutJsuONWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709114529; c=relaxed/simple;
	bh=qZJdAVjmnkm8/6h9d3vgNjL+OiImwWCwbzl3be0TxNM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jawa0rzeRzcDbGsBb68h3z9zoYkeaJ4jIpkHb6LUoqAQwXvAueCANLoMyQiljVPc8jbrqTEkU8Qa6sdVlgZQHnGceKEXu3Uygwiv/7Imag6pU2W5SwU7cR/dnS5A+56IPmkB11nkU7nqDeTqvRTbl3w0d12jlidvumsmoyVh1HA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=sPPi9LaU; arc=fail smtp.client-ip=40.107.215.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jm4XIPMU0H+mJZb2cnTHKmD7w+DnvVffZ76+ZsZti4ie7KFUY+P26PJ/Fq9phSdd1M16lZl3mDOzsu1z7NIFAejw0KBwF6N44odNwNEHOsimBeI9DJz6cB9RHv0mf/wqm+5uiTdaVDyRPQbOZyVJemUOtA/J9dQN/cSUr8Zy5kzxgAY5EcWl4ytaJvkguqHyYzKU//8ieykBU2VEc73p2LzhSDCImHNR/N3YfxCkdr+5SgKyAjIHsex4DibMiQgT60msq1sOy1WR2CMyHqPFoe/1NkUkcCrROMLAPQuEPBkqjpbQlcfW5tLdHq8IZomSLWF5z4WYYmv8cFl7Px5lWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZJdAVjmnkm8/6h9d3vgNjL+OiImwWCwbzl3be0TxNM=;
 b=nZ1T07g3HnlMIrFIX+7bQTgJsSWU7/ylfd/dLhbVBnJt2KlsB3j9vmogdbHlQ2BV4rZPXKmvTl7zIgfazRAR7TEBBmJTBuUVnwu0cqptmXZ0exoN/s/PpVeL8qZveZJDlJm/eywA6PI3EUGyTtg9Bn19k+dQjwZhv04FSdlE7mEf6xioPSPMAUSCI3cVYcjfrla/uSjM4zp7IkIXU4qIOltrn9pwy17NTrP+SOB7HGcVK0YEMlbvlrJhKiRUduooyIE840psA3LH1rayF9gIoZhH4uH26MprG8h52lcu8CHUKXsqBQuYKn/A86vVhT3dSj/TaDkhLxWk4pa4OU//CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZJdAVjmnkm8/6h9d3vgNjL+OiImwWCwbzl3be0TxNM=;
 b=sPPi9LaUd0/5nJJnR25mGupRswGFSiK//DnOmgP7uOA/VkQdtr+GbLX50sGAH3SvQ3AzAiORf4G8U2Ur0GJZiGGsR4DPx+Ay0BvBEKw4g/WcIiTAU5VTHaNHf6jih6QsSN4kHJViaP0DlBHa6eaLpclzu7AkYBBAtVsDOCcFpuw=
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com (2603:1096:101:194::8)
 by PUZPR02MB6308.apcprd02.prod.outlook.com (2603:1096:301:f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 10:02:03 +0000
Received: from SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::c54f:7115:e36a:591d]) by SEZPR02MB7164.apcprd02.prod.outlook.com
 ([fe80::c54f:7115:e36a:591d%3]) with mapi id 15.20.7316.035; Wed, 28 Feb 2024
 10:02:02 +0000
From: =?utf-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
To: Barry Song <21cnbao@gmail.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"urezki@gmail.com" <urezki@gmail.com>, "hch@infradead.org"
	<hch@infradead.org>, "lstoakes@gmail.com" <lstoakes@gmail.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
Thread-Topic: [PATCH] mm/vmalloc: Fix return value check for vb_alloc
Thread-Index: AQHaaiMl8QnJO9uKn0+vgW8C5UzmZrEffkUAgAAHzgA=
Date: Wed, 28 Feb 2024 10:02:02 +0000
Message-ID: <fd71a174-e4cf-425c-a619-0d7c15cd91f7@oppo.com>
References: <84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com>
 <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com>
In-Reply-To:
 <CAGsJ_4w_itxmZR7ytu7HnptQNZQzM-vAJhE_zSZrTAH1iqBV6g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR02MB7164:EE_|PUZPR02MB6308:EE_
x-ms-office365-filtering-correlation-id: 0747efdb-53fc-4e74-1a24-08dc38444fdb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 EFGfnDt1b03C9I/1niNbRlIrNuLljh3XQPxZ7gzpxSduUpaT7o9H4dzmqZV37NXJqJXPAYr6vRhu8W7AUA+QEjjMpp1z2gJXMoliCdFInHsjAn86hwNKhPZ6QELhN39UPxsa9oOVJprxz28ajfBWveEFE4ro5Y+gX1Nw2ZxTeiBw/GrFlfqfeuhPqp6z2OL+TkeTmd9V5QYuUlo0OX0OXKz688QyWeBBLxBA1eD/2o5Vt+4PJB6ukaEk1Y2vNMbmt4DEInGfvllHEdrPSahxOFPE82NwhN3WrN9F3L+JPb3g2DE49EuHp9ekafz38TrfnYqUpknqNIH1tuOtjKvUdGRzzynJFwKjfzlCfXQ7E83IKAgPChfIFonMz5s/W5Fkj9Mff5pE/iD0NYy0ZB7v70P0mEhJTRhtR/hRR2HoBIwMSoqkTKSH5VW0cndEZ53XkqrnqeVzRCAyu75n77/yXwwNFpdSm9gFz8k9hAh66hrsPcy3H29XGLMM5IV2n1TyMZDzkvw3I8jlXe/L4npTAGJ/TDxgfi6qyf3WzmzAch32snGKJnUyoNzUYzDZviWYqIQWSnMclcQcJw2sTwN9GsqdkxBT9cHlE45yQ11VxZ+vUyoCYuqpcUyjbFL715QvFLqmsgMf6iT2dZfgnNz+SufkXIhIoF521SHJFnb1gwybIP7zn0k/DiobLV55ccPtKCqojl00vfeYDyPh7CWLIVORfYeT0OFDd6juwz4SU/Q=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR02MB7164.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L2xHckhsK28wNnQxVXRWY3Z0ZERRbk1KV3JSdlc1d1NLNGlRRHhEYjVLUk9T?=
 =?utf-8?B?UkNOeVlEV2N5MVE1QW9WZXNSKzRrUXMwVCtJa0JKK3VhcTYvYVdPbEo3bzBZ?=
 =?utf-8?B?RkRHOGp5M3FPZFpLSHYvK3lCRVdXczNpMmhJVUovQVlscFNPRm9xVFFURDU1?=
 =?utf-8?B?ZkFUb0lrS1Y3UUxRV3NIMTJRZnY2dVI5Kzg5R3lMYWxoZGRCelZ0bzNiTGRV?=
 =?utf-8?B?eENGYXpkaDhVWjZialdGWEhGMGR1K0FlbTdOQTdzNFpLL1ZvN2JrcmlZOVJZ?=
 =?utf-8?B?M1ZXdFRXVTVzd0ZncGVSeEw5R25rTVdSNy9yeDBiellKUng3VEJkeUVDUXVz?=
 =?utf-8?B?UnpHMkNEVWF3NkYrTVJoUFZwYVZVaEY2V3FVak4xdEtnZWJzK0JTaVJpbzdq?=
 =?utf-8?B?NzRjZ2h0K3RqQjUwMFowbHc4SG83WjF2NXpxQ3ZOazkzaTVoOURQQlNRUkho?=
 =?utf-8?B?MU5BSFo5S0JPUXJiRnJKNWM2ajFXRUlubzIxUyttYTBTRGJEK1BGUEpNV1c1?=
 =?utf-8?B?UnRPQXhjaGlmZVY5SXkvbXJETUdBZC94RG1Ia2ZUSmNmL0JvaCtJc1VvMDNa?=
 =?utf-8?B?Q1YrTWZXdHJ5MDVJc0VTWkZNajkwZzlaTUZpWjdncXRIZXIxRUs1S2poMktS?=
 =?utf-8?B?VWZpYUlvNjUxN2V6bXVvdVpBUWMwQTkxUllNdmN4a0RENzF3Ulo2d1pjVXlq?=
 =?utf-8?B?RjFuellFRFlWZTNnOXE5MGxNcXFJbnMwMGFzTmZhYSsyNHRUU1VIa2h5WXZU?=
 =?utf-8?B?Q2tzU0ZXSGRGU05uY3dmdmV0SDFkdEpsbGVQOC9rbURTUnlxR1h5clJRWlRy?=
 =?utf-8?B?VVUvUTd3L1FFNnRrRk1rNzZkeVBOMVNONUtwVUtBRWNKZHZRZythOFRHcVJW?=
 =?utf-8?B?TFNGZktSM2NkR0ZEUWd1WS9DZ2pLL25RWXBvRHVwRU05OGwzNjN4SVRPREVh?=
 =?utf-8?B?Szl3QVNwS3VXSC9KK1RVb0pLYVpHMVYwaFozL0FkUllwbVAxL2dwQ1VLWjdT?=
 =?utf-8?B?NTU4aDZ3enRUTDF5QVlIS2UvbUpITlliTjVoajNMVUlDSzN5UkE0azkrTlcy?=
 =?utf-8?B?NUs3UzZJTHBoSWgxOXBZd0w5cVBOOFFIVkhITUgzYit0dm9rRVVJcFVoYTNG?=
 =?utf-8?B?ckc5emVxeWMyK3Jac0pIQmV0a3g4cjJxRmxZNlR3M1hDVyttK0x1ZnYyc0o4?=
 =?utf-8?B?MGNEcndwMVNTWms2Y3lHWXEvNnd5M3R2ZWhrd0VwOHo4MU4rdnJUeWNPWWJa?=
 =?utf-8?B?ZVh0aUkvM3NINFJoaWZKcDNpVUZicXRLRXV3MHkzTjhGM0J5eVJ2Q3AzejFM?=
 =?utf-8?B?bDNkL09iM084L05ydTFnNlh6U2xBczF6V3hVbXV4Q0svdnp2WGprUGxLWFhx?=
 =?utf-8?B?RVgrNmNuS3k2Qm4yYkFjME5oanFQcUxHN09YSmdndUZqZlcrcDRHTjU2SmZW?=
 =?utf-8?B?Z3lrU2V4RzdrQzVVK0tickZzVE1LYjVGTnlpSGNTaDJXRXVCZWVsV2xrMHo5?=
 =?utf-8?B?V3JOazg2ZkovcjJCbjFieFZxbStVUXRQWlpoZ0orbElSUFNyTW9rUnJiQ1Vs?=
 =?utf-8?B?Y29zWVNZVHJ3Y2lrMTgxTDg1ejEwMkh0NEtJYVhXVnQ4aUs5ck55SEhFN2lP?=
 =?utf-8?B?cHlzOUFRSWYreE8vT05qay9UMVZNc0xCWXRtdHJXWDM3clZ3L0lnNkREUnpE?=
 =?utf-8?B?QjZ4THMrQkF0UHl6OW9qZXc5eXZ0cEd1L1RzeTRuRjltKzEzeGUxWGFFQk9R?=
 =?utf-8?B?Q1Ewa0w0dGpyRlhxK2t0UERNNC9zR2tNWitTSVdsWHJrYTNTRHBSc3FYTEhF?=
 =?utf-8?B?QTNZMzJNcHc2dGZyTURlVGIrTDFoVlR2THVRWWdzakxwVEZRNGNTMnFtMVBT?=
 =?utf-8?B?Q3grZThTdSt4RDZEWGNlOWxVRkNITDdxM3hENEVocXBkTzlIU2N2cjZqU1lw?=
 =?utf-8?B?NjdJYnAyS0NPREozWjkxOVgxRFlyaDRFVktBVjg3WG50aUk2NnFOMi9LcVpF?=
 =?utf-8?B?cjlEOE45aVFtN0p2QzgvelpiMkkrZFpRcFpZdVFnQ09XNm9Oa3VOVEp6ekZJ?=
 =?utf-8?B?cy8rMllyb3hXdnc1dGUvMmFlekdaUGR6UWV3YTROSkQrSWVnVFRYTmtiWWZ3?=
 =?utf-8?Q?fwtLDbRg5WuT0XZo11sibHxsd?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <48AFC8679D35B04EB03EE7689684DCAA@apcprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR02MB7164.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0747efdb-53fc-4e74-1a24-08dc38444fdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 10:02:02.7895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k4skWA8Bo/qYa5+8VfevFeHyqKkLeKhpp3EjMoqlw5KHQq9J8y5imN0C+vI9efunZNUzaHZMeNpvhq85q3h+9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR02MB6308

T24gMjAyNC8yLzI4IDE3OjM0LCBCYXJyeSBTb25nIHdyb3RlOg0KPiBPbiBXZWQsIEZlYiAyOCwg
MjAyNCBhdCA5OjUx4oCvUE0g5YiY5rW36b6ZKExhb0xpdSkgPGxpdWhhaWxvbmdAb3Bwby5jb20+
IHdyb3RlOg0KPj4NCj4+IElmIHZtX21hcF9yYW0ocGFnZSwgMCwgMCkgd291bGQgY2F1c2UgcGFu
aWMgYnkgdm1hcF9wYWdlc19yYW5nZV9ub2ZsdXNoLCBzbw0KPj4gY2hhbmdlIElTX0VSUiB0byBJ
U19FUlJfT1JfTlVMTCB0byBmaXggdGhpcy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIYWlsb25n
LkxpdSA8bGl1aGFpbG9uZ0BvcHBvLmNvbT4NCj4+IC0tLQ0KPj4gIG1tL3ZtYWxsb2MuYyB8IDIg
Ky0NCj4+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4+
DQo+PiBkaWZmIC0tZ2l0IGEvbW0vdm1hbGxvYy5jIGIvbW0vdm1hbGxvYy5jDQo+PiBpbmRleCBk
MTJhMTdmYzBjMTcuLjEwOTczMjAwNmNmNyAxMDA2NDQNCj4+IC0tLSBhL21tL3ZtYWxsb2MuYw0K
Pj4gKysrIGIvbW0vdm1hbGxvYy5jDQo+PiBAQCAtMjM4Nyw3ICsyMzg3LDcgQEAgdm9pZCAqdm1f
bWFwX3JhbShzdHJ1Y3QgcGFnZSAqKnBhZ2VzLCB1bnNpZ25lZCBpbnQNCj4+IGNvdW50LCBpbnQg
bm9kZSkNCj4+DQo+PiAgICAgICAgIGlmIChsaWtlbHkoY291bnQgPD0gVk1BUF9NQVhfQUxMT0Mp
KSB7DQo+PiAgICAgICAgICAgICAgICAgbWVtID0gdmJfYWxsb2Moc2l6ZSwgR0ZQX0tFUk5FTCk7
DQo+PiAtICAgICAgICAgICAgICAgaWYgKElTX0VSUihtZW0pKQ0KPj4gKyAgICAgICAgICAgICAg
IGlmIChJU19FUlJfT1JfTlVMTChtZW0pKQ0KPiANCj4gaXQgc2VlbXMgdGhlIG9ubHkgY2FzZSBm
b3IgdmJfYWxsb2MgdG8gcmV0dXJuIE5VTEwgaXMgc2l6ZSA9IDAsIGlzbid0DQo+IGl0IGEgYnVn
IG9mDQo+IGNhbGxlcj8NCnZiX2FsbG9jIGhhZCBhbHJlYWR5IGNoZWNrZWQgdGhlIHNpemUgPT0g
MCwgc28gaXQgc2hvdWxkIGJlIHJldHVybiBOVUxMDQp0byBjYWxsZXIgb3Igbm90IHBhbmljIGhl
cmUuDQoNCkluIGZhY3QsIHdlIGVuY291bnRlciB6X2Vyb2ZzX2x6NF9kZWNvbXByZXNzIGlzc3Vl
Lg0KDQpbNTQwMzIuMzgzNjMzXVtUMjUzOTJdICB2bWFwX3BhZ2VzX3JhbmdlX25vZmx1c2grMHg3
OTAvMHg4ZjgNCls1NDAzMi4zODM2MzddW1QyNTM5Ml0gIHZtX21hcF9yYW0rMHgxYzgvMHgxMGIw
DQpbNTQwMzIuMzgzNjQyXVtUMjUzOTJdICB6X2Vyb2ZzX2x6NF9kZWNvbXByZXNzKzB4NjAvMHgx
ZTgNCls1NDAzMi4zODM2NDhdW1QyNTM5Ml0gIHpfZXJvZnNfZGVjb21wcmVzc19wY2x1c3Rlcisw
eDYyNC8weDlmYw0KWzU0MDMyLjM4MzY1M11bVDI1MzkyXSAgel9lcm9mc19kZWNvbXByZXNzX2tp
Y2tvZmYrMHgxOGMvMHgyMjQNCls1NDAzMi4zODM2NThdW1QyNTM5Ml0gIHpfZXJvZnNfZGVjb21w
cmVzc3F1ZXVlX2VuZGlvKzB4MWE4LzB4MWUwDQpbNTQwMzIuMzgzNjYzXVtUMjUzOTJdICBiaW9f
ZW5kaW8rMHgxODgvMHg0N2MNCls1NDAzMi4zODM2NjddW1QyNTM5Ml0gIGNsb25lX2VuZGlvKzB4
MWEwLzB4NTUwDQpbNTQwMzIuMzgzNjc0XVtUMjUzOTJdICBiaW9fZW5kaW8rMHgxNGMvMHg0N2MN
Cls1NDAzMi4zODM2NzhdW1QyNTM5Ml0gIHZlcml0eV93b3JrLjYwMjU4KzB4N2MvMHgxM2MNCls1
NDAzMi4zODM2ODJdW1QyNTM5Ml0gIHByb2Nlc3Nfb25lX3dvcmsrMHgxYjgvMHhhOTgNCls1NDAz
Mi4zODM2ODddW1QyNTM5Ml0gIHdvcmtlcl90aHJlYWQrMHgxNjAvMHg2YzANCls1NDAzMi4zODM2
OTFdW1QyNTM5Ml0gIGt0aHJlYWQrMHgxNWMvMHgxZDANCls1NDAzMi4zODM2OTZdW1QyNTM5Ml0g
IHJldF9mcm9tX2ZvcmsrMHgxMC8weDIwDQoNCnpfZXJvZnNfbHo0X2RlY29tcHJlc3MgaGFzIGNo
ZWNrZWQgdGhlIHJldHVybiB2YWx1ZSwgc28gaXQncyByZWFzb25hYmxlDQp0byByZXR1cm4gTlVM
TCBpZiBzaXplID09IDAuDQoNCkJycywNCkhhaWxvbmcuDQo+IA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIE5VTEw7DQo+PiAgICAgICAgICAgICAgICAgYWRkciA9ICh1bnNpZ25l
ZCBsb25nKW1lbTsNCj4+ICAgICAgICAgfSBlbHNlIHsNCj4+IC0tDQo+PiAyLjM0LjENCj4gDQo+
IFRoYW5rcw0KPiBCYXJyeQ0K

