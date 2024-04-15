Return-Path: <linux-kernel+bounces-145216-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DD38A50ED
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBB5B2479B
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66B1127E38;
	Mon, 15 Apr 2024 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Gj9VEGc2"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2098.outbound.protection.outlook.com [40.92.42.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18543127E25
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 13:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713186214; cv=fail; b=GTEOhlXcP8vd+PK+x4VFZZft3nePwYNJC1DRNwGL+aUrzlvpPe7HRm23nIzTCHd0uMkPGEjVkIdLEPb85qjXa7NiavIF/Fo+XRLNgVRO3b3+OjqW6GQwhBhn7cGS1ctTkahdREbP3nrch6wKe/gpRL897tTzue4fSyQ274rok78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713186214; c=relaxed/simple;
	bh=1t+W7Vt5bnNO8ImQcb2CUq9SL1UfLTfsaSOeTUQsNrQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ffw8ZjHVKv0Zv7Rp9gprcmZNNrTJ+AGDD0y4kJMUSe7iE5Tcgyp1xXgFhg6vTk7VHJ0CU70ODt82ynZDYSDPx+LT6hGQU/3Dw1Z917ZREZcaVEj1wp3MmRFh0kVMXGnK51BK+JlInrND1Tbz3UwUf6lU8Jug9DvPai02Ha8iK7c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Gj9VEGc2; arc=fail smtp.client-ip=40.92.42.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mEe/EQTqGz62BxAS6Y24hwE6D7xzSoVxN25b8pU750NSFQwFl9ILn5YMJbLrRAhfxPCDzTNYS8Ny1iot9wKwqqW2mpayuoEdLgCttS+hWAoxGmwPuIEzYvuvgSnob79m5jOAFilvpQlcu9nAvmYGXKR3UDcIuphi6iBFFeIDMvcHQX0+K3YDu3WYW5ouRA37RCZf0MZ50DE5OR7EMluhBtDBpWj+v4iqh/Zh9/bJbRUlQj6Mna3jhu4vxReeTDkzYGIpVnHDLBqGKccZwQPPWDjEnQZs8IZyd1pkn1wthMbS6dMt4bhC6Qw/5nmjcdIDcXlu9kgPD2sATW7c6gnCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1t+W7Vt5bnNO8ImQcb2CUq9SL1UfLTfsaSOeTUQsNrQ=;
 b=DsV0RKzTag2UMAUQajO0Z8IavVthxdxElKmSFGxA0BJVMp6Z7do/tz0605jbHUq/qaGf2/UeZ27SkyERAxlAclw8GM9DyQjBj0CLvTihTKPUz40k4V3Tk8+gttnd2+o7OeU6qF5KJ34A/7AdNiD7DCu/+5xLFYigWUxAfLCdmJqHrlg1UMrYzwtVGJGDyKOwtS9DpQbAQRitnmfslX+gjfx81KrWi8v4whS7atpWqjUPBoB+qZ+0tZwQT+9Kbv9lky5yHo/EVrUW5/++kqEhQtvsAKah+h9otNluKSVwU3ZNysaP6ruRVuyIsxgkK1O/CvlUyCoB1YmVj523W3wK8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1t+W7Vt5bnNO8ImQcb2CUq9SL1UfLTfsaSOeTUQsNrQ=;
 b=Gj9VEGc26nWRH2/0OtOQPiSsIXboFCWnKTTs2TbYFPu1mjza7cDFEKq8iVOjB0UyK73BJ137OwpzgZ5YIwL3TUET0u5Np1uWcQf2HF3lk5qAHCnv9Bwd5Z15m3iJ4Wl7GhAiJ6yJKzAAkr6VrkayxzetsMKNgm9QqRMU9Izz9pmDNBBWbzrQgzOdhXxYh3UODp0dWSqLkNMDbeSzkXXZdL9kiP3L8ed09GWlUCxMG1oJ/5gImneoB6now577+u7QjlSxx48dGRrJU7ep0Y+EjWYtCctRrmqTTUk69WS94DeAQFDyiI8cuOk8Z19shOWQ0P8XkXUIjFxrCNRzl6tEyw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8685.namprd02.prod.outlook.com (2603:10b6:a03:3e5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Mon, 15 Apr
 2024 13:03:30 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.053; Mon, 15 Apr 2024
 13:03:30 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "jgross@suse.com" <jgross@suse.com>,
	"sstabellini@kernel.org" <sstabellini@kernel.org>,
	"oleksandr_tyshchenko@epam.com" <oleksandr_tyshchenko@epam.com>, "hch@lst.de"
	<hch@lst.de>, "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Thread-Topic: [PATCH 1/2] swiotlb: Remove alloc_size argument to
 swiotlb_tbl_map_single()
Thread-Index: AQHaiWsCp8JQSGA74EyasRMxVkBb5LFpQj8AgAAIqdCAAAk3gIAAAjWw
Date: Mon, 15 Apr 2024 13:03:30 +0000
Message-ID:
 <SN6PR02MB415749D379BFCC0749B44900D4092@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240408041142.665563-1-mhklinux@outlook.com>
	<20240415134624.22092bb0@meshulam.tesarici.cz>
	<SN6PR02MB4157C8206FE193B2C5B2A93FD4092@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240415145023.78e7ce97@meshulam.tesarici.cz>
In-Reply-To: <20240415145023.78e7ce97@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn:
 [pVRsuOJEq9Y5eF/MgqRfCNUe2UqvDHU0OuKkM8evoBccCsYlPFzXCga30KDd97OLufF8iXw7ds0=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8685:EE_
x-ms-office365-filtering-correlation-id: cc6f5e38-edd4-4128-7043-08dc5d4c72a6
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jXQaIJWl7DK90Ty53pwK+9Fsmgr8BzTRHxNCwWVp4/Df/XcIwcvO9kGRaa/FVG8//zkTVg+yppzjiU0uNiOClp3YVdAehuURhUWJmkuE0G6CDMRjrHcDbgqMwXWQAsCdY2ZPxex5hxY2H0Yw+3u9nYBiwG97MiZiwY+DW4fWgW408CXADDFffUG8qmK0VIdcw8Ze6XRORKMwHRwPRbhZzVzX6O52nJuFVW9kBi5mVo/kZ/wzKVxbwOkOPZz1k/BNWiC5uhVKfp1CwxKWm1MTJuvRtxjhzgTzwFTB7Z59y6t06WxGWLAu2zRRapVXIGbTRNedW6Eel77rOkySzyf3W2WENJtGOHeHcq3NOpuIGCy8iLHzenyIh8uHcNsXVdU4E+1M+FiN9UI4Ibzbasq6a4Vnf54B5yx33vWNcJaTEvGkfGciW217VukFOT5IBGfWhkyhfeAnqLoPJbkuBVO/fuk9RfypsvZHzEU41ucs581wlRlFnxvSTHf3n9meModmEI/JWAJ7OO+2r4YpGvuNSB2ecRdgsmJ222ciD+yIm/b9ZBU/F0JXPjFOtjjoBYdB
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eldyZ1Fwa1R4NEVlSjhGcTNpSndTWFlndkVLVGRWMWI3a1JKMjNEWkpwb0pZ?=
 =?utf-8?B?eVZjL1pxN2N6a2h0WFZaYk1KUXgrNDAxSFRVbWREQnB4b3d0TG9xTHpkaXN3?=
 =?utf-8?B?VzdyWG1zUzhvMmViSC9tZlltYkI3QUl5b2d6YUg1ejByc3pEbTFBL2o5R3hj?=
 =?utf-8?B?a3FlcDhKUTBlOUFQQVlLZ0F2Y0V3WEV0aXRNZlpRK0hJMk8yM0ZZODA0Z1d4?=
 =?utf-8?B?bzhFSXpXS2RTZXlFbTNqNmo5a2xKOFI4ZjFLTnhWOXRSSFdxcHU5SWNiVWM2?=
 =?utf-8?B?SVhJRmpXL2FYWkFiVHZzL0wvaStESE5NMEp5U0ZjZnBtN25RbXlmNzZyUnZz?=
 =?utf-8?B?ckM4WmhIaVZiLzBFQmhTZlUvbG1qdjBxREY4S2hlZlp3WGFHNHNva1EwMWVP?=
 =?utf-8?B?d2dJVWQ0Vi9mWmViQXowZHJleVZoNmJmdjR4cEtYSHZIMks2MUh0SlByVG9w?=
 =?utf-8?B?eVpqamtUNHlrVDJRbzM1Tm84TlplaEVhOWlOdzlGMVN0Z01DMEpHWnBIeWQy?=
 =?utf-8?B?UGUvWXROSWdYOTVNV041QzErMmpUY1VGdjlmckYwL25MQmV1L0o2QXhFLzVC?=
 =?utf-8?B?NUJISXN6RzlqRVdOK09xazFDRzlDcGJlSXZUSEJhNFJ3c2N4N0ZtdGZBWEwv?=
 =?utf-8?B?ZkxId1BEQzBMd0piVHBYQlBnR1FNYWF3dGN5UXBGb2pRdGZBSlpPSjIxQVdt?=
 =?utf-8?B?YTdaWnQ2bU1pZjVDUTFmZHpXVERhYkxCUFV3ZlRnYW42dFo1UFVVdWdsd3lJ?=
 =?utf-8?B?MXEwS1pIaGh6c21DSVpiaGJCVnd6TnYzNFg0TFJwMHhSZy95NVB1WUVJSUw4?=
 =?utf-8?B?L2xRK1AvT21PQ09JZzhQQThsVFYxZ0Z5VHQrN3Y3cEtNeXIvY2JONzlFNU5M?=
 =?utf-8?B?N1l1ejBNN2VobENWUloxbEN5RFlWQ3VBcUlJVEw2a0VvOVhWT0w3MENKV0dS?=
 =?utf-8?B?eFBQbW8wRjhhQlBKNkVUbVY4MWV6QXJCNmIrTktZZitDVHB4M1I5emxZVFpN?=
 =?utf-8?B?MkJjdE9RQmRvcmE0SHFJZTJQQnlPRzE1UVJyT1FQZEtTcjIrODJTT2wwYkw0?=
 =?utf-8?B?ampqY2JiK29tbngvUHJ2c3hBMEpoMlZ3Y05ZZ0Z1ZlpRcVRzZnh3ZkV4UldS?=
 =?utf-8?B?SXFZTUNoTU9WMU9XRzhyOWhRMDBmKzdHb0I3SFVibW5rMmRvK0VySDQwdEIy?=
 =?utf-8?B?RG01V3FydGJ0OFBmYlAxYVdNb2twQnlvcFl5S1dFZ1VlU094RUJEc3pCdmFN?=
 =?utf-8?B?T0R6eGZOY2VVN2VvdkVHYUM1WEpQd1dzRi9pN21MK1h2ZURWd3RMUjQ0ZERT?=
 =?utf-8?B?QVZpOUpNSXJDV1ovZ1ord0Myc1lRQWFuVSszbWNpVk1BbWV0STJhSkd6c0ps?=
 =?utf-8?B?eDA4ZlRORlBQbFlXWEJncXFCTktmYmh3M052anA4K0dpa2FKNFJpQktHOWZ0?=
 =?utf-8?B?RC9XMUFNY1YzKy9zSGtVTXdHNTFISHBvMGE1d1hFN2RqWXpPMG4rcTJLUnVv?=
 =?utf-8?B?VWJpNzgvNVFyMFZNYTNZODRTUzhGQUFiRlhac2tEemtkTnlQZ1BQUHNnbTM1?=
 =?utf-8?B?T05DTXh6RmczeHdVQm1QSGVvQ2tST3hwN1luTzdpMVpvSTlVVzJnTy9IVlFU?=
 =?utf-8?B?bDhnMk9JQ0gxUFJhVmVkQ25XS21MM1lNTDRpQjN1R2VqYTJZOGEwNlpsTEkx?=
 =?utf-8?B?akdPTUxaalRqV29IY0JaSEszcXNHWmVJN1MzMDU3REd1dWluRCtqYTRYMldv?=
 =?utf-8?Q?y7Jl5llyyKXPdb4JIg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: cc6f5e38-edd4-4128-7043-08dc5d4c72a6
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 13:03:30.1879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8685

RnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IE1vbmRheSwgQXBy
aWwgMTUsIDIwMjQgNTo1MCBBTQ0KPiANCj4gT24gTW9uLCAxNSBBcHIgMjAyNCAxMjoyMzoyMiAr
MDAwMA0KPiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+IHdyb3RlOg0KPiAN
Cj4gPiBGcm9tOiBQZXRyIFRlc2HFmcOtayA8cGV0ckB0ZXNhcmljaS5jej4gU2VudDogTW9uZGF5
LCBBcHJpbCAxNSwgMjAyNCA0OjQ2IEFNDQo+ID4gPg0KPiA+ID4gSGkgTWljaGFlbCwNCj4gPiA+
DQo+ID4gPiBzb3JyeSBmb3IgdGFraW5nIHNvIGxvbmcgdG8gYW5zd2VyLiBZZXMsIHRoZXJlIHdh
cyBubyBhZ3JlZW1lbnQgb24gdGhlDQo+ID4gPiByZW1vdmFsIG9mIHRoZSAiZGlyIiBwYXJhbWV0
ZXIsIGJ1dCBJJ20gbm90IHN1cmUgaXQncyBiZWNhdXNlIG9mDQo+ID4gPiBzeW1tZXRyeSB3aXRo
IHN3aW90bGJfc3luY18qKCksIGJlY2F1c2UgdGhlIHRvcGljIHdhcyBub3QgcmVhbGx5DQo+ID4g
PiBkaXNjdXNzZWQuDQo+ID4gPg0KPiA+ID4gVGhlIGRpc2N1c3Npb24gd2FzIGFib3V0IHRoZSBL
VW5pdCB0ZXN0IHN1aXRlIGFuZCB3aGV0aGVyIGRpcmVjdGlvbiBpcw0KPiA+ID4gYSBwcm9wZXJ0
eSBvZiB0aGUgYm91bmNlIGJ1ZmZlciBvciBvZiBlYWNoIHN5bmMgb3BlcmF0aW9uLiBTaW5jZSBE
TUEgQVBJDQo+ID4gPiBkZWZpbmVzIGFzc29jaWF0ZXMgZWFjaCBETUEgYnVmZmVyIHdpdGggYSBk
aXJlY3Rpb24sIHRoZSBkaXJlY3Rpb24NCj4gPiA+IHBhcmFtZXRlciBwYXNzZWQgdG8gc3dpb3Rs
Yl9zeW5jXyooKSBzaG91bGQgbWF0Y2ggd2hhdCB3YXMgcGFzc2VkIHRvDQo+ID4gPiBzd2lvdGxi
X3RibF9tYXBfc2luZ2xlKCksIGJlY2F1c2UgdGhhdCdzIGhvdyBpdCBpcyB1c2VkIGJ5IHRoZSBn
ZW5lcmljDQo+ID4gPiBETUEgY29kZS4gSW4gb3RoZXIgd29yZHMsIGlmIHRoZSBwYXJhbWV0ZXIg
aXMga2VwdCwgaXQgc2hvdWxkIGJlIGtlcHQNCj4gPiA+IHRvIG1hdGNoIGRtYV9tYXBfKigpLg0K
PiA+ID4NCj4gPiA+IEhvd2V2ZXIsIHRoZXJlIGlzIGFsc28gc3ltbWV0cnkgd2l0aCBzd2lvdGxi
X3RibF91bm1hcF9zaW5nbGUoKS4gVGhpcw0KPiA+ID4gZnVuY3Rpb24gZG9lcyB1c2UgdGhlIHBh
cmFtZXRlciBmb3IgdGhlIGZpbmFsIHN5bmMuIEkgYmVsaWV2ZSB0aGVyZQ0KPiA+ID4gc2hvdWxk
IGJlIGEgbWF0Y2hpbmcgaW5pdGlhbCBzeW5jIGluIHN3aW90bGJfdGJsX21hcF9zaW5nbGUoKS4g
SW4NCj4gPiA+IHNob3J0LCB0aGUgYnVmZmVyIHN5bmMgZm9yIERNQSBub24tY29oZXJlbnQgZGV2
aWNlcyBzaG91bGQgYmUgbW92ZWQgZnJvbQ0KPiA+ID4gc3dpb3RsYl9tYXAoKSB0byBzd2lvdGxi
X3RibF9tYXBfc2luZ2xlKCkuIElmIHRoaXMgc3luYyBpcyBub3QgbmVlZGVkLA0KPiA+ID4gdGhl
biB0aGUgY2FsbGVyIGNhbiAoYW5kIHNob3VsZCkgaW5jbHVkZSBETUFfQVRUUl9TS0lQX0NQVV9T
WU5DIGluDQo+ID4gPiB0aGUgZmxhZ3MgcGFyYW1ldGVyLg0KPiA+ID4NCj4gPiA+IFRvIHN1bSBp
dCB1cDoNCj4gPiA+DQo+ID4gPiAqIERvICpOT1QqIHJlbW92ZSB0aGUgImRpciIgcGFyYW1ldGVy
Lg0KPiA+ID4gKiBMZXQgbWUgc2VuZCBhIHBhdGNoIHdoaWNoIG1vdmVzIHRoZSBpbml0aWFsIGJ1
ZmZlciBzeW5jLg0KPiA+ID4NCj4gPg0KPiA+IEknbSBub3Qgc2VlaW5nIHRoZSBuZWVkIHRvIG1v
dmUgdGhlIGluaXRpYWwgYnVmZmVyIHN5bmMuICBBbGwNCj4gPiBjYWxsZXJzIG9mIHN3aW90bGJf
dGJsX21hcF9zaW5nbGUoKSBhbHJlYWR5IGhhdmUgYSBzdWJzZXF1ZW50DQo+ID4gY2hlY2sgZm9y
IGEgbm9uLWNvaGVyZW50IGRldmljZSwgYW5kIGEgY2FsbCB0bw0KPiA+IGFyY2hfc3luY19kbWFf
Zm9yX2RldmljZSgpLiAgQW5kIHRoZSBYZW4gY29kZSBoYXMgc29tZQ0KPiA+IHNwZWNpYWwgaGFu
ZGxpbmcgdGhhdCBwcm9iYWJseSBzaG91bGRuJ3QgZ28gaW4NCj4gPiBzd2lvdGxiX3RibF9tYXBf
c2luZ2xlKCkuICBPciBhbSBJIG1pc3Npbmcgc29tZXRoaW5nPw0KPiANCj4gT2gsIHN1cmUsIHRo
ZXJlJ3Mgbm90aGluZyBicm9rZW4gQVRNLiBJdCdzIG1lcmVseSBhIGNsZWFudXAuIFRoZSBBUEkg
aXMNCj4gYXN5bW1ldHJpYyBhbmQgdGh1cyBjb25mdXNpbmcuIFlvdSBnZXQgYSBmaW5hbCBzeW5j
IGJ5IGRlZmF1bHQgaWYgeW91DQo+IGNhbGwgc3dpb3RsYl90YmxfdW5tYXBfc2luZ2xlKCksIA0K
DQpJIGRvbid0IHNlZSB0aGF0IGZpbmFsIHN5bmMgaW4gc3dpb3RsYl90YmxfdW5tYXBfc2luZ2xl
KCkuICBJdCBjYWxscw0Kc3dpb3RsYl9ib3VuY2UoKSB0byBjb3B5IHRoZSBkYXRhLCBidXQgaXQg
ZG9lc24ndCBkZWFsIHdpdGgNCm5vbi1jb2hlcmVudCBkZXZpY2VzIG9yIGNhbGwgYXJjaF9zeW5j
X2RtYV9mb3JfY3B1KCkuDQoNCj4gYnV0IHlvdSBkb24ndCBnZXQgYW4gaW5pdGlhbCBzeW5jIGJ5
DQo+IGRlZmF1bHQgaWYgeW91IGNhbGwgc3dpb3RsYl90YmxfbWFwX3NpbmdsZSgpLiBUaGlzIGlz
IGRpZmZpY3VsdCB0bw0KPiByZW1lbWJlciwgc28gcG90ZW50aWFsIG5ldyB1c2VycyBvZiB0aGUg
QVBJIG1heSBpbmNvcnJlY3RseSBhc3N1bWUgdGhhdA0KPiBhbiBpbml0aWFsIHN5bmMgaXMgZG9u
ZSwgb3IgdGhhdCBhIGZpbmFsIHN5bmMgaXMgbm90IGRvbmUuDQo+IA0KPiBBbmQgeWVzLCB3aGVu
IG1vdmluZyB0aGUgY29kZSwgYWxsIGN1cnJlbnQgdXNlcnMgb2YNCj4gc3dpb3RsYl90YmxfbWFw
X3NpbmdsZSgpIHNob3VsZCBzcGVjaWZ5IERNQV9BVFRSX1NLSVBfQ1BVX1NZTkMuDQo+IA0KPiBQ
ZXRyIFQNCg==

