Return-Path: <linux-kernel+bounces-83402-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D8B869854
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A4E1295261
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7E31474C9;
	Tue, 27 Feb 2024 14:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="h+ug88L3"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2087.outbound.protection.outlook.com [40.92.21.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1C714533F
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 14:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.21.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709044221; cv=fail; b=TBZWDewmSMZZG8Ss5MXDB4pal4P2Cg3OOlnSuujLdOsH/Di1NeJTR7lbu7nI5CwjMOIEI8ldQylFWfCEFuTiJr64sO5NiBFthSGuCybyqZlBpDy9EU5dzbv6cmDH6sOF1m0+rjded0tPZU57sc5/psVbTbKPXMb2+PwHetnC0VI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709044221; c=relaxed/simple;
	bh=G8Rcgak9gskVtPUPxLOP7MCt22rTz15JRyLmMleQ7YM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fhFp4kFV3kBsMEjM6JTHJOwjgS+JiBuJjrMDtG19j3PXZUDr2OOahHgr+koROdjNAHhJr/ukopc4fVV8IG1PZuBin7RGIbAVckcwhzujm3PzKlA6tYOEHvuTIupxeqAuA9P8YL7klx/j5gQx7mrUrT/AGyuT35KjDqUU6BgZAqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=h+ug88L3; arc=fail smtp.client-ip=40.92.21.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S7oHLy9ZbNWQpQ7/z5JNQV195r0jTPsvZyvB2IoncS9qVHmhEQbggAI+9HrBoFoqy7COVQ74z5CdUxc3ffSLFGnfheh11gqLYrpwchPbQq1JuyYV9PH/hwTxwHJgjt33NBK0CTk60pcPmDi3lgxaNd5kJ7UkFtod6kRQsLac754u9feORmBIwQJdtaQjuqQPvof+QdOIDphdmdHZsl4gFfnEYwoA3m4N3nyoiGzcBXb/aL6xLeYFy0NYEZbHsp6Zh3Sf0gDpBBnBnGJ/m8s9TBtxOAkA2ZlLHlI77PM6+wdustTC/FlFnZSQrFPaOoqr2zon9df/u3QFzUycThiLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8Rcgak9gskVtPUPxLOP7MCt22rTz15JRyLmMleQ7YM=;
 b=ac4Rk1nQ8SdRK6ml5LlS3b78eeFvpjSQn3FC323yh3/UZF/tHx57di37lgM/dlhPl3aR7hbLlCFlmwz31E/Y/9cpIFMkxcxwGfwVJ08l5fGIHqeqdOpl2c4PHGDYL6EKNHFmcbLkamuxHb2NJ5+KEVMURCvl+dEN9um91lttdUBNYdmNn7JjbDseFRy6Iy0j7L9xOqWGGC0VCM/AAlAD/o3VVh3W2iO8lQfUozQDO8CK1H9guBn28z/BXX8FwwVgju2G9UugH4yjCkHIKynAa3c2/K5cVLwWCJ6KPXU3HPcUQKCOgrgFf+n/yR8WjAioKvx3ff/47ZxpomF56N7VWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8Rcgak9gskVtPUPxLOP7MCt22rTz15JRyLmMleQ7YM=;
 b=h+ug88L3s+E44GX+h8dxEMC1kK5XvqqXWa63U8Pr5mmXIABb/ypFZ2hpmqktMnsUezSAzMCZpY/I4Tc+1BUy5qr5654XgRVG8dIHWFzfsCgy0lz08wIagW7BRLd3+R7jP6/nIMlXUsu15Pgm33Ai6+PClYWaLYsfF2VMdBIv37PvptrCpcTl29sDdMJgyvglomOTm5RZU7pgszw11+iVNCOu6zLPFC4vT0xtaMwjoRBlC78mGcgdv2t+GhZbLV5WWlazlfG360itqRJ00wx+2/rP59+0M95dndXsX0e50hdk9j/ZW7mjyKAYnHrthZc9X48mvuTO6wWuMTEDZuWj4A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB7092.namprd02.prod.outlook.com (2603:10b6:a03:21f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 14:30:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7316.035; Tue, 27 Feb 2024
 14:30:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "kernel-team@android.com" <kernel-team@android.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, Christoph Hellwig
	<hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, Dexuan Cui <decui@microsoft.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Topic: [PATCH v4 5/5] iommu/dma: Force swiotlb_max_mapping_size on an
 untrusted device
Thread-Index: AQHaZLoRyKgMK9jLMUWPn0GpqcfvobEdDJiAgAAUxOCAARVMAIAAEk5w
Date: Tue, 27 Feb 2024 14:30:16 +0000
Message-ID:
 <SN6PR02MB41570BBF2A3401BD35994CC7D4592@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240221113504.7161-1-will@kernel.org>
 <20240221113504.7161-6-will@kernel.org>
 <6be819d8-f1f9-4833-81c3-32220617f0c5@arm.com>
 <SN6PR02MB4157CD26C1D9BAC64208D9D8D45A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <5a94049b-5527-4c05-bce5-e15edebd1b81@arm.com>
In-Reply-To: <5a94049b-5527-4c05-bce5-e15edebd1b81@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [EARN6ji3kiPGcJMPk11/mdizM5AsOexu]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB7092:EE_
x-ms-office365-filtering-correlation-id: 3cf4815a-6adc-4870-b715-08dc37a09e30
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uvh4d74t33al13kV+TNIJ0C+H4dplY71yRr0lt1uB6nrUPpQG1rhHNF6t3lrFATj6YrTkcy+FwogRxkmb2J+V0mppLa4NLIjwEjgutTIjfd89EKtvkUdhpGJqBgvIOO9Lyw91/6ZOQpc4ZzAmlCafW1WBkcjGTi0nWzmFF1i0B2Lxh5idKRbhiDM3WAZRFlZ3wWzW8AktfmFkTyzOD7P4iKYCkWZMYRw+3VbaqxEUQrpxnFxBoIO742Q6qZlkVjtzexy7iHfHsalz7WMaiwhUldx7Bq2RkoyLXWVs2J/FwVJBd3lesD0rnjyWtMEqkelDyFEXwnNUdvmhApl8y/U+1/l+PUHTKcsk5iEfQubOW69B5cfcNQXziSx16PTTGzgrMwaGIxpE7SFioltl9d8BwUTrwV7ID5gCqoy6bP/2Xpt7kawmbA4cdffLe6Q/exmVKvijOK7CO40qSDROPUuZR8Wp4yE8eRI5aVD7PVaLpl5LEQpR03E/YaX2w+AucUJAEu8hKe2p3ZdGTcEsxGPLV56aZ94WwmE8dRPWVugoHJHV1Om7pcxVASrSyYecshg
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dkJyMFVQV21Wd0tyUEYrVTRKQlVoanNaYUYrRm5zNDVEVTFndVFKWDBpZHVG?=
 =?utf-8?B?eTNYc3ZVOE1rSXV0NnhZRkxnVmJQN3FlYWN0ZUhUK28vLytXcGhQRXhSQlJo?=
 =?utf-8?B?VjFyY09xSnh5bkQ2Nk40RlQwL2ZXZzRzNU1yODg3d1N1Ri9md1UzUWlZdFJk?=
 =?utf-8?B?SWRQa0x1MTVWQzEyUk8vczB6Ly9SOFFRNnRLOXNlYldJWHVQYjRJMG8wbXRs?=
 =?utf-8?B?OFh6RGZDelVaNkQrUHlxUGNOanNaUmp6UmRaMFhjdTN1dE03UVA5azhvNEo4?=
 =?utf-8?B?YzVReDZnMlZZWFUyME90aHZCSnlSNkRDbHB2aldxRVNHZW8yNUtkQkVlN28z?=
 =?utf-8?B?TFdHOU5pay9MQjRSYjVvZzVsSHltVXkrRlNZVzFjWmRNTStKNHY3dC9qVjB3?=
 =?utf-8?B?WFB5M0c4ZzAwWUswcDNZSW0vbExsUC9HRkh3eVZwOFpscHVDZGUvb1kwTWRR?=
 =?utf-8?B?UXJQUDMyTUtWa3BOT0cvRHRhSGtOVjg1Q3Nza044RjZ2aUZEN2RVUGdaNUxQ?=
 =?utf-8?B?aVloNlZZQm5TL0ZSWlJ4ZVR1VUVzY290SkM0bXROUTJIY3BPc0FWK3d0UGU5?=
 =?utf-8?B?eEtNQmQ4M3JPZUdmdURQZXU0cXNIR0Q4dEw5N2ZMeGN6SFFRNXYxMkY5QnJC?=
 =?utf-8?B?RGs0bjdBY25kZktQYWFseS9qb20zWUZIMENhYWl5Ny9jRWJIY2x1MDBIZHdi?=
 =?utf-8?B?NlczN3p3MzRGelpOSHJ2R2IzK0cvcXFpdGhGQXQvbFloRTcvQm9paVRvTktU?=
 =?utf-8?B?dE9xaUNwSkQreFIwOHVaNGZka2grQk50eFNsZ2FKNzdVbDJDbS9ja1MwSzJF?=
 =?utf-8?B?SmQ5SHpsclduWWNndmRUOVUweS9PVmhNNWtpWTR3cFJmajY1dkpSVi94RXFO?=
 =?utf-8?B?OTFQWG9HclB3QkpYMFlTUDZ4Q1hpRWNiRlhGeGh0eGJDQUVHeno2cU9ER3Ni?=
 =?utf-8?B?M1puZHV5K3lYVWkzSExFU1RpSE5hdmw3alQyckdFVmZBWStaRGY1dXgrYVBx?=
 =?utf-8?B?QTNQa3NaeExzTUJRYlVVbEJyVVdKUGtNM0JiUWhXamJrNzh5NnUxVExsUWsx?=
 =?utf-8?B?cDcySWdJL0V6Njl3MStDWkp6Mmx2UExFQ2ZraURoRjhoaFdyTzhIeW82TXNB?=
 =?utf-8?B?TjRuK0cvY0t2YnpmeW81UkVtb3Z4ZTlDTW8vdGhGelZKM0Z6d25Uby85MC9u?=
 =?utf-8?B?T1hKUkFIOE13UmF5Ykl1Zzl4b0V2OHhqM1oySWtLaC9qejAwU3k3Q1piWjkx?=
 =?utf-8?B?eFgrQXRxUThiLzE2d1czUjRaZ2lJVms1MGZ0Yy8zU0NUczB6M01SQ1o2Qkw5?=
 =?utf-8?B?S0MyQ3M3d0xUZis3R1lUdGF2RWJBeFRXMStmNm5rU252SWJ2M3VQQ1VhbVpn?=
 =?utf-8?B?UTk2QVBEdjBDNENIOHM5MUFPWFEwcW9oK200N2JLMFNYMTdEVzJaZXJaSEla?=
 =?utf-8?B?ekVHa1VzU1U2aXhscnZ0UjRmaXZaZE92QmJTbjlLM1U4ZmhkeEUrTHNZS3J3?=
 =?utf-8?B?N0F0end6US9wQkdKR3Q1eC9yZG83NloxbDgxcmhtZ3UvZHozV09YRDdUNGJm?=
 =?utf-8?B?Nm1jVTdyNnpFd0pzNWE1Y1ZrK3VoUTQzZndjZyt2V0ZnSHFpdzdQV3d5MFNM?=
 =?utf-8?B?T1JKZWRiczd0clhFSDV6alp2cXpjMmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cf4815a-6adc-4870-b715-08dc37a09e30
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 14:30:16.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB7092

RnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4gU2VudDogVHVlc2RheSwg
RmVicnVhcnkgMjcsIDIwMjQgNToyMyBBTQ0KPiANCj4gT24gMjYvMDIvMjAyNCA5OjExIHBtLCBN
aWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBo
eUBhcm0uY29tPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5DQo+IDI2LCAyMDI0IDExOjM2IEFNDQo+
ID4+DQo+ID4+IE9uIDIxLzAyLzIwMjQgMTE6MzUgYW0sIFdpbGwgRGVhY29uIHdyb3RlOg0KPiA+
Pj4gRnJvbTogTmljb2xpbiBDaGVuIDxuaWNvbGluY0BudmlkaWEuY29tPg0KPiA+Pj4NCj4gPj4+
IFRoZSBzd2lvdGxiIGRvZXMgbm90IHN1cHBvcnQgYSBtYXBwaW5nIHNpemUgPiBzd2lvdGxiX21h
eF9tYXBwaW5nX3NpemUoKS4NCj4gPj4+IE9uIHRoZSBvdGhlciBoYW5kLCB3aXRoIGEgNjRLQiBQ
QUdFX1NJWkUgY29uZmlndXJhdGlvbiwgaXQncyBvYnNlcnZlZCB0aGF0DQo+ID4+PiBhbiBOVk1F
IGRldmljZSBjYW4gbWFwIGEgc2l6ZSBiZXR3ZWVuIDMwMEtCfjUxMktCLCB3aGljaCBjZXJ0YWlu
bHkgZmFpbGVkDQo+ID4+PiB0aGUgc3dpb3RsYiBtYXBwaW5ncywgdGhvdWdoIHRoZSBkZWZhdWx0
IHBvb2wgb2Ygc3dpb3RsYiBoYXMgbWFueSBzbG90czoNCj4gPj4+ICAgICAgIHN5c3RlbWRbMV06
IFN0YXJ0ZWQgSm91cm5hbCBTZXJ2aWNlLg0KPiA+Pj4gICAgPT4gbnZtZSAwMDAwOjAwOjAxLjA6
IHN3aW90bGIgYnVmZmVyIGlzIGZ1bGwgKHN6OiAzMjc2ODAgYnl0ZXMpLCB0b3RhbCAzMjc2OCAo
c2xvdHMpLCB1c2VkIDMyIChzbG90cykNCj4gPj4+ICAgICAgIG5vdGU6IGpvdXJuYWwtb2ZmbGlu
ZVszOTJdIGV4aXRlZCB3aXRoIGlycXMgZGlzYWJsZWQNCj4gPj4+ICAgICAgIG5vdGU6IGpvdXJu
YWwtb2ZmbGluZVszOTJdIGV4aXRlZCB3aXRoIHByZWVtcHRfY291bnQgMQ0KPiA+Pj4NCj4gPj4+
IENhbGwgdHJhY2U6DQo+ID4+PiBbICAgIDMuMDk5OTE4XSAgc3dpb3RsYl90YmxfbWFwX3Npbmds
ZSsweDIxNC8weDI0MA0KPiA+Pj4gWyAgICAzLjA5OTkyMV0gIGlvbW11X2RtYV9tYXBfcGFnZSsw
eDIxOC8weDMyOA0KPiA+Pj4gWyAgICAzLjA5OTkyOF0gIGRtYV9tYXBfcGFnZV9hdHRycysweDJl
OC8weDNhMA0KPiA+Pj4gWyAgICAzLjEwMTk4NV0gIG52bWVfcHJlcF9ycS5wYXJ0LjArMHg0MDgv
MHg4NzggW252bWVdDQo+ID4+PiBbICAgIDMuMTAyMzA4XSAgbnZtZV9xdWV1ZV9ycXMrMHhjMC8w
eDMwMCBbbnZtZV0NCj4gPj4+IFsgICAgMy4xMDIzMTNdICBibGtfbXFfZmx1c2hfcGx1Z19saXN0
LnBhcnQuMCsweDU3Yy8weDYwMA0KPiA+Pj4gWyAgICAzLjEwMjMyMV0gIGJsa19hZGRfcnFfdG9f
cGx1ZysweDE4MC8weDJhMA0KPiA+Pj4gWyAgICAzLjEwMjMyM10gIGJsa19tcV9zdWJtaXRfYmlv
KzB4NGM4LzB4NmI4DQo+ID4+PiBbICAgIDMuMTAzNDYzXSAgX19zdWJtaXRfYmlvKzB4NDQvMHgy
MjANCj4gPj4+IFsgICAgMy4xMDM0NjhdICBzdWJtaXRfYmlvX25vYWNjdF9ub2NoZWNrKzB4MmI4
LzB4MzYwDQo+ID4+PiBbICAgIDMuMTAzNDcwXSAgc3VibWl0X2Jpb19ub2FjY3QrMHgxODAvMHg2
YzgNCj4gPj4+IFsgICAgMy4xMDM0NzFdICBzdWJtaXRfYmlvKzB4MzQvMHgxMzANCj4gPj4+IFsg
ICAgMy4xMDM0NzNdICBleHQ0X2Jpb193cml0ZV9mb2xpbysweDVhNC8weDhjOA0KPiA+Pj4gWyAg
ICAzLjEwNDc2Nl0gIG1wYWdlX3N1Ym1pdF9mb2xpbysweGEwLzB4MTAwDQo+ID4+PiBbICAgIDMu
MTA0NzY5XSAgbXBhZ2VfbWFwX2FuZF9zdWJtaXRfYnVmZmVycysweDFhNC8weDQwMA0KPiA+Pj4g
WyAgICAzLjEwNDc3MV0gIGV4dDRfZG9fd3JpdGVwYWdlcysweDZhMC8weGQ3OA0KPiA+Pj4gWyAg
ICAzLjEwNTYxNV0gIGV4dDRfd3JpdGVwYWdlcysweDgwLzB4MTE4DQo+ID4+PiBbICAgIDMuMTA1
NjE2XSAgZG9fd3JpdGVwYWdlcysweDkwLzB4MWU4DQo+ID4+PiBbICAgIDMuMTA1NjE5XSAgZmls
ZW1hcF9mZGF0YXdyaXRlX3diYysweDk0LzB4ZTANCj4gPj4+IFsgICAgMy4xMDU2MjJdICBfX2Zp
bGVtYXBfZmRhdGF3cml0ZV9yYW5nZSsweDY4LzB4YjgNCj4gPj4+IFsgICAgMy4xMDY2NTZdICBm
aWxlX3dyaXRlX2FuZF93YWl0X3JhbmdlKzB4ODQvMHgxMjANCj4gPj4+IFsgICAgMy4xMDY2NThd
ICBleHQ0X3N5bmNfZmlsZSsweDdjLzB4NGMwDQo+ID4+PiBbICAgIDMuMTA2NjYwXSAgdmZzX2Zz
eW5jX3JhbmdlKzB4M2MvMHhhOA0KPiA+Pj4gWyAgICAzLjEwNjY2M10gIGRvX2ZzeW5jKzB4NDQv
MHhjMA0KPiA+Pj4NCj4gPj4+IFNpbmNlIHVudHJ1c3RlZCBkZXZpY2VzIG1pZ2h0IGdvIGRvd24g
dGhlIHN3aW90bGIgcGF0aHdheSB3aXRoIGRtYS1pb21tdSwNCj4gPj4+IHRoZXNlIGRldmljZXMg
c2hvdWxkIG5vdCBtYXAgYSBzaXplIGxhcmdlciB0aGFuIHN3aW90bGJfbWF4X21hcHBpbmdfc2l6
ZS4NCj4gPj4+DQo+ID4+PiBUbyBmaXggdGhpcyBidWcsIGFkZCBpb21tdV9kbWFfbWF4X21hcHBp
bmdfc2l6ZSgpIGZvciB1bnRydXN0ZWQgZGV2aWNlcyB0bw0KPiA+Pj4gdGFrZSBpbnRvIGFjY291
bnQgc3dpb3RsYl9tYXhfbWFwcGluZ19zaXplKCkgdi5zLiBpb3ZhX3JjYWNoZV9yYW5nZSgpIGZy
b20NCj4gPj4+IHRoZSBpb21tdV9kbWFfb3B0X21hcHBpbmdfc2l6ZSgpLg0KPiA+Pg0KPiA+PiBP
biB0aGUgYmFzaXMgdGhhdCB0aGlzIGlzIGF0IGxlYXN0IGZhciBjbG9zZXIgdG8gY29ycmVjdCB0
aGFuIGRvaW5nIG5vdGhpbmcsDQo+ID4+DQo+ID4+IEFja2VkLWJ5OiBSb2JpbiBNdXJwaHkgPHJv
YmluLm11cnBoeUBhcm0uY29tPg0KPiA+Pg0KPiA+PiBUQkggSSdtIHNjYXJlZCB0byB0aGluayBh
Ym91dCB0aGVvcmV0aWNhbCBjb3JyZWN0bmVzcyBmb3IgYWxsIHRoZQ0KPiA+PiBpbnRlcmFjdGlv
bnMgYmV0d2VlbiB0aGUgSU9WQSBncmFudWxlIGFuZCBtaW5fYWxpZ25fbWFzaywgc2luY2UganVz
dCB0aGUNCj4gPj4gU1dJT1RMQiBzdHVmZiBpcyBiYWQgZW5vdWdoLCBldmVuIGJlZm9yZSB5b3Ug
cmVhbGlzZSB0aGUgd2F5cyB0aGF0IHRoZQ0KPiA+PiBJT1ZBIGFsbG9jYXRpb24gaXNuJ3QgbmVj
ZXNzYXJpbHkgcmlnaHQgZWl0aGVyLiBIb3dldmVyIEkgcmVja29uIGFzIGxvbmcNCj4gPj4gYXMg
d2UgZG9uJ3QgZXZlciBzZWUgYSBncmFudWxlIHNtYWxsZXIgdGhhbiBJT19UTEJfU0laRSwgYW5k
L29yIGENCj4gPj4gbWluX2FsaWduX21hc2sgbGFyZ2VyIHRoYW4gYSBncmFudWxlLCB0aGVuIHRo
aXMgc2hvdWxkIHByb2JhYmx5IHdvcmsNCj4gPj4gd2VsbCBlbm91Z2ggYXMtaXMuDQo+ID4+DQo+
ID4NCj4gPiBJJ20gbm90IGNvbnZpbmNlZC4gIFRoZSBjb25kaXRpb25zIHlvdSBkZXNjcmliZSBh
cmUgcmVhc29uYWJsZQ0KPiA+IGFuZCByZWZsZWN0IHVwc3RyZWFtIGNvZGUgdG9kYXkuIEJ1dCB0
aGVyZSBjYW4gc3RpbGwgYmUgYSBmYWlsdXJlDQo+ID4gZHVlIHRvIGF0dGVtcHRpbmcgdG8gYWxs
b2NhdGUgYSAidG9vIGxhcmdlIiBzd2lvdGxiIGJ1ZmZlci4gSXQNCj4gPiBoYXBwZW5zIHdpdGgg
YSBncmFudWxlIG9mIDY0SyBhbmQgbWluX2FsaWduX21hc2sgb2YgNEsgLSAxICh0aGUNCj4gPiBO
Vk1lIGNhc2UpIHdoZW4gdGhlIG9mZnNldCBwYXNzZWQgdG8gaW9tbXVfZG1hX21hcF9wYWdlKCkN
Cj4gPiBpcyBub24temVybyBtb2R1bG8gNEsuICBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBzaXplIHBh
c3NlZCBpbnRvDQo+ID4gaW9tbXVfZG1hX21hcF9wYWdlKCkgaXMgbGltaXRlZCB0byAyNTJLLCBi
dXQgaXQgZ2V0cyByb3VuZGVkDQo+ID4gdXAgdG8gMjU2Sy4gIFRoZW4gc3dpb3RsYl90YmxfbWFw
X3NpbmdsZSgpIGFkZHMgdGhlIG9mZnNldA0KPiA+IG1vZHVsbyA0Sy4gIFRoZSByZXN1bHQgZXhj
ZWVkcyB0aGUgMjU2SyBsaW1pdCBpbiBzd2lvdGxiIGFuZA0KPiA+IHRoZSBtYXBwaW5nIGZhaWxz
Lg0KPiA+DQo+ID4gVGhlIGNhc2UgSSBkZXNjcmliZSBpcyBhIHJlYXNvbmFibGUgY2FzZSB0aGF0
IGhhcHBlbnMgaW4gdGhlIHJlYWwNCj4gPiB3b3JsZC4gIEFzIGlzLCB0aGlzIHBhdGNoIHdpbGwg
d29yayBtb3N0IG9mIHRoZSB0aW1lIGJlY2F1c2UgZm9yDQo+ID4gbGFyZ2UgeGZlcnMgdGhlIG9m
ZnNldCBpcyB0eXBpY2FsbHkgYXQgbGVhc3QgNEsgYWxpZ25lZC4gQnV0IG5vdCBhbHdheXMuDQo+
IA0KPiBJbmRlZWQgdGhhdCdzIHdoYXQgbXkgInByb2JhYmx5IFsuLi5dIHdlbGwgZW5vdWdoIiBt
ZWFudCB0byBpbXBseS4NCj4gDQo+IEkgdGhpbmsgdGhlcmUncyBwcm92aW5nIHRvIGJlIHN1ZmZp
Y2llbnQgY29tcGxleGl0eSBoZXJlIHRoYXQgaWYgaXQNCj4gdHVybnMgb3V0IHdlIGRvIG1hbmFn
ZSB0byBzdGlsbCBoaXQgcmVhbC13b3JsZCBpc3N1ZXMgd2l0aCB0aGUgY29hcnNlDQo+IGFwcHJv
eGltYXRpb24sIHRoYXQgd2lsbCBiZSB0aGUgcG9pbnQgd2hlbiBhbnkgZnVydGhlciBlZmZvcnQg
d291bGQgYmUNCj4gYmV0dGVyIHNwZW50IG9uIGZpbmFsbHkgdGFja2xpbmcgdGhlIHRoaW5nIHRo
YXQncyBhbHdheXMgYmVlbiBvbiB0aGUNCj4gdG8tZG8gbGlzdCwgd2hlcmUgd2UnZCBvbmx5IGJv
dW5jZSB0aGUgdW5hbGlnbmVkIHN0YXJ0IGFuZC9vciBlbmQNCj4gZ3JhbnVsZXMgd2hpbGUgbWFw
cGluZyB0aGUgcmVzdCBvZiB0aGUgYnVmZmVyIGluIHBsYWNlLg0KPiANCg0KRmFpciBlbm91Z2gu
ICBJdCdzIHlvdXIgY2FsbCB0byBtYWtlLiA6LSkNCg0KTWljaGFlbA0K

