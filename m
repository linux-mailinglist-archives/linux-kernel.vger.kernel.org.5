Return-Path: <linux-kernel+bounces-90908-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 892EC8706A0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DF441C21C72
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE2E48CD4;
	Mon,  4 Mar 2024 16:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="leERyG+a"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04olkn2082.outbound.protection.outlook.com [40.92.46.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987283CF40
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.46.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568651; cv=fail; b=W9+fkF8cTBvqlmsVluPwDfqw1nXGyRN6JljLuuBN5f3ZTzFjqlpwwuBVch4Lq+aF+5xhP+dbJeURifil4Yz8jTqhpJoHJUDyb8i8ds3oZS7olZihjexdQk8Az1qwThXOluB+7S4Z6rddi0CZkcRlV+XROj7SjesaV1q4beQ7O7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568651; c=relaxed/simple;
	bh=Iy/0ztNhzjXQ1iCuZIxHIIj9p6qXGJ954jw4RdNpwCw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PFwpd4ilLapB93KeeDU/Xq5/LuW5KWS1gQ5NhJ4ZfSb90VoNpiAv/c6s1sqlVqK69FKHQpUNSXIUSyA7/0l6HEWBbRQonwSNDk2CJ8Pj50CsgY7j5ITKcTVB2r66jePME1nBMZLF4oUPHgRfUOIAC3J9QoocVJpdboD1+TcrBKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=leERyG+a; arc=fail smtp.client-ip=40.92.46.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ioRVJEdIzHSONq+VblAQrs0yLu0RCZDcC+aRuJP3PBPy6KSXgrgMkj/wvU2jRO5ggPikGoVYoMd8j9sTGZLfK4r6ugxAh9PQjzyO3CkQJmRm6AaspZ5Cdq4+LsrpWTYshmWBWHkGBAZc6kCUbq+kftEEKH2ZYDoBcVVqilGMCmjQKD5wRkAT1iLMUMOUJtf0RcIwladCwHQVbTK+4IRK7PlMfxk6YbLYepL3IDyxQH/8s93ObyKJG3kcodqvUGPlt/yhYqL1KQHeiCzCr5KMras+qte30gODi1gQcUeanL04XpE5asEBz9rjaHIlCsAla679OhAXsWgCNpJ9Focp6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Iy/0ztNhzjXQ1iCuZIxHIIj9p6qXGJ954jw4RdNpwCw=;
 b=CO9IEz61TObsP9UP/9rLtwKkGabKxPbe4l9bxwSCxLB0VUhk1rjcJO3rPyg2wujOsZkd7DiDRSV7CUYseXfQCkGMdXQTXumFw1tmdNPpyfZg1SOeeh5vZDSIQWozx+xdctRl4ZZClPB3duVPpDYUK51OXNvSucnkzAn7ykszueExDBBiUv1t+6EVUbCCP3geOWjzRwKSf/uEAqBw8RaseS6MgpqDVTf/JoTq6F3O8tns4JH3VX3eb1MnsjnDbtDt2bxrnZhwmBc1/3pEGt2QQegyfphP7S6whdSBFUoA92BK+AyZFd+A5RBESU9blXDOwIOCEOx+Ki9VKdhiqM53xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Iy/0ztNhzjXQ1iCuZIxHIIj9p6qXGJ954jw4RdNpwCw=;
 b=leERyG+aFplBhq5nObO8HxBY4fIrPz7IB27avFFUZkQFbDbqVOnjNxJV95EP7+gwWZklFwniJgrTLhisnvoQi+yKFhLnbLF705sug2QGRw+Ygfr/P6XxgmVSfysj3d7qMIbrpYgp/rjDMyRBcNx5ghkil5RdFr39edE5LsnaxK2HXN9VQ04GERM6orRPexe/5aF9ltsCOeZ5SNHnSVye7YsOE+r8jy3cFX5KUzfuNGJJWKtR6xI/gf673RxQJYHFcPoJNZkuW5XvbzKA/5krVCaly57RyXuWuzO0KZTEjty/u2EQYt13ptD9a4SglynFRkTGH81ud9qrSn/7xhGDmA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SJ0PR02MB8403.namprd02.prod.outlook.com (2603:10b6:a03:3f3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 16:10:46 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::67a9:f3c0:f57b:86dd%5]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 16:10:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Will Deacon <will@kernel.org>, =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?=
	<petr@tesarici.cz>
CC: Robin Murphy <robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Petr Tesarik
	<petr.tesarik1@huawei-partners.com>, "kernel-team@android.com"
	<kernel-team@android.com>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	Marek Szyprowski <m.szyprowski@samsung.com>, Dexuan Cui
	<decui@microsoft.com>, Nicolin Chen <nicolinc@nvidia.com>
Subject: RE: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Topic: [PATCH v5 6/6] swiotlb: Remove pointless stride adjustment for
 allocations >= PAGE_SIZE
Thread-Index:
 AQHaakuep9s0mIf3eE+om+sQlmyZtbEg06/QgAAR1sCAAG26AIAAIlEwgAADLACAAY/2gIAAGPyAgAAMowCAAA1wAIADuADAgAB+HYCAACvfAIAAJlIAgAAB+gCAAAEkYA==
Date: Mon, 4 Mar 2024 16:10:46 +0000
Message-ID:
 <SN6PR02MB41571F68F8F9E003C4359948D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <SN6PR02MB4157314F142D05E279B7991ED45F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240229154756.GA10137@lst.de>
 <20240301163927.18358ee2@meshulam.tesarici.cz>
 <20240301180853.5ac20b27@meshulam.tesarici.cz>
 <8869c8b2-29c3-41e4-8f8a-5bcf9c0d22bb@arm.com>
 <20240301194212.3c64c9b2@meshulam.tesarici.cz>
 <SN6PR02MB41571DA1EE99BFAA65869024D4232@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240304120055.56035c21@meshulam.tesarici.cz>
 <ffd7646b-37b1-4cd2-822a-848b36b076c9@arm.com>
 <20240304165506.49e3b2d3@meshulam.tesarici.cz>
 <20240304160210.GB21077@willie-the-truck>
In-Reply-To: <20240304160210.GB21077@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [/RB6kmEp4uxIBVgU5cW17C9mHZAZr//H]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SJ0PR02MB8403:EE_
x-ms-office365-filtering-correlation-id: d5d41bf4-68bc-4f80-126c-08dc3c65a6c5
x-ms-exchange-slblob-mailprops:
 laRBL560oLTeY4B5Uu9VZYvGMTlNPOvpsrECZ3BciMY6cDnNp0A8hJ3fQJYECfhOU/0b7KcmyZVZa4EKw1xAeZnuNnWMmk14pHFdxSrCagr367CiepWJNyjr1LfC9pue12e2d0V/XL4Y8scUeK7BeyEYGVEePYqc2ChangMtbwebNjKH2QBoT1SZSmEWBhTeQxILTZGB0uQ4eulXOIxIgHlrIl3NLScnBUnsvNRazYEzZJmK9Z+E9Kv14ndllnuY0rCQZy8dO+3mb/gH94tv2nQdvEoH+ydpIDXw62PlafoLJ7kJUTjHEX4ixCFtRS1yS/mJyCGzYu9zQa/iXaZT7Sb5OdTKih4lNw+0so3ln/5Z/H95rTeLg0uCgMSUC5GpOnmETzvJG+1cYAsuuff0X0g+HHDPVhK+HO/979bBAHwJeM8QOaWVVzGAsPGpoU6SBWpwZncqc4uyJJatBYKZu0BqwuJdpjehKD5bPEDrm9b/Lt0ztqiYTQL7awWZCX6csB7od6ScxHjGqZrfYDFZG5ButZSNj1wJ6mnUb3rsLc4kk9QVlP6pfk3kHLkIYdCPUg+5Y2zJBO5e4fy3QPnOWbCqpS99e0OdurRwSbV7kqzsGkYy/Nx/tl+inauv91oeX+BucP1aUnYnq0Tg4T+xgg3mJbn34xCzDIYeAyU30+ITBq+Qw5MU0gYXoMvujB/TxtgBiFl/QtEwYi7E5tKT6+36VBVn8wAYiHi8Fjo3Sn9knejVUijBPIEAid6YkqOxreRCAJUog6WRowhz2DSOauHE781Q4Gpi
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 efSofm8LFoamZbVuw8OdKB9IPnf79Z34Wq5b3O7u6o1VnVLyjAmJtH9ojKJ63qymsmpgKusobo8SuYyasAGblz7JZPuL5HpoC+r9KKwhLEK1Erkgk+GxSHmHrKO8+p8rXoUaiR9RshheH0s2f6flKfHql6NcprHb9dMrBwUd9mFxJqBdPssCtRJ/4zidL5SFKTh1P9cxDE33JcF6szCEjzwKW7RL4wiul40AXK/lDOPkfyqaATcx60Wr3zIukloCPDmReJlLOQ7rWV3qouMCMBfMRDFCEssyZh2wTIc3x6E5FoAr7O+iG/getVI9QbMmGsdcoIYNAW13RYBJwuYfYOjioQqM4MBVTZQ3L/IPM4AijrzOohSaFR8AEM8aSFb5im9WU1X4aKpN1Z2bt2dPbTOKeNG4lY6vuBpK/h108tAGZULuzZ928/7S1V/VQeQC0Y+K61toci0kP1B/U0O2gNJGefifCzFJbDC5HbCeVMKmRODijZJHpaQsfkOfdyom5EqyY3iulKqbQ/NAYsJxdr5GXhKVXD9VDXO+91LDXY4YswHFg30xJdpbYguBovzU
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OWtjRnpvU0tBSWFEZHhiSi8wVWtLY0lSMVg2Q1hHSUdXTWN1RS9QVUJ3SEdW?=
 =?utf-8?B?UldPNkZKMGFuVENqdjU3STVEUVpWK2xaa3VyMlcxdS9JWXlBbTdtdmU1cTlz?=
 =?utf-8?B?aDh6bEl5YTJsYmhscHlVekp3WHhDSEU2Vnk0QTlKTURwTDdOaHhoWWVwQWJi?=
 =?utf-8?B?clFYelRwTVZjK0dENk8vYnFpaENRc2Y1T0RFOVViUXhyZWRNZjdtbUhNMXpI?=
 =?utf-8?B?ak1Ua2hUS0xqbFF4ckdhdFR1UWFkQ2dodzBCU0d4U1E5NUdMRzUwUkRuYmxh?=
 =?utf-8?B?dDF1N3VBbWhOVjFRb1ZJSlpQTUIrbTdhdE1DR1ZzWHRwbWtHeFRKbHNybzFy?=
 =?utf-8?B?a3ZjODEvVWErY05jUmpzcjM4MHV0Q1RLd3NBQmNVNFJ5V0E2VWhoWHhmLzNn?=
 =?utf-8?B?bEpoaS9SZy9SVjgrbWt4cStLdExJUU9VR3h3eWRyTTZYMHViNFlFY3lUcFZo?=
 =?utf-8?B?ZDBTTWk5NWsvOXVOWTdhRUlXbkt2M3FlQVBPV3MxaWtaR3grOUdtSGVyUEt2?=
 =?utf-8?B?c3VLaU95V0RCUXpnaThPSHVBbFpneXc5MVFSSHNqLzBIMDJqQjVzZDN1c3k0?=
 =?utf-8?B?ZWhUYkJ0enlPN1dDMFUxOHhWbkUxVnpISVl0dHBQU2pnUFI0UlZXd1FlLzRr?=
 =?utf-8?B?N1JsWFBnV2hCd0pYb1lRVkR3d3hXYWlBWUdTR3JPQ0VxejVHMWptbG5POEoy?=
 =?utf-8?B?WUZQTzBLbW93SGtRcjFzc2VyN0hORDJkTzBlUGRTNDFmMzUraDVYWG0ycmgy?=
 =?utf-8?B?T2pGcGFoMUhSYTlMUGs4RGx5UGl4R3ZXcEhtNkpCV09XUHF6R0lQZVNvcE1q?=
 =?utf-8?B?bW5HakRhS0dhZlMwbHREUmZDZFhUVTlxaDlWODN5VWE0MDB1SEJCbXpEZEdJ?=
 =?utf-8?B?VlFSdzlhUGFDWlpwajVIN3FjUXFjQk12N1g0RHhtMDhKVUxLNnJ0QVBLS2dV?=
 =?utf-8?B?UklCbW8vZ3RUcGVxZFpZbWhIS3c1ZUhuTXdmZjRZUGdiY2sxRzZCVFF5SU5l?=
 =?utf-8?B?amIzYk9SYVFGdFFVSTk2cStSK3JVZUltaFN6czBMOVJ4SWVZREJianYyeHE2?=
 =?utf-8?B?TG5lSzFwbjA0YjJKaWxzNnlBL285TGx6ZWl5YUZGYStad0U3dkpDbzB1QSs2?=
 =?utf-8?B?azRCNGdqNHNsOXE1Ymx0aC84cVJ6UE50N0l2ODEzK0o0K2IzVEN5SnJkR0pF?=
 =?utf-8?B?a1JOQk01Q1c5T1dxcUtud3d1bEdycE8zNXRUMUhNay96a0NFaTdJQldmVWpY?=
 =?utf-8?B?VFViVnFmNHU5OVF3cjhQQ2pZbzhSUEFyMG8yZmJCOGR1Q2E4eHREWUIxQk1q?=
 =?utf-8?B?cCtoZm5GQXU2cnRGK3RJZ2xwaG5Ea2dSUWdqa0hHTVRTeWIxWWZpYTJhZmlX?=
 =?utf-8?B?RU45cUxRcFBxQlBHNm9HRGp2V1VyZzREUTFxSHAwZEtKWmczVWdPc2lDMTJT?=
 =?utf-8?B?ZzduRXJNNE81L0pHLzFNRzdsZHlOalg4ZzJrMDBoeTQ3Z2F5VGthc0E0UWhv?=
 =?utf-8?B?ci9wbmlNNUpOWkdDaGZuUE1qaE16djF5bk5hcGNTMStqRmcwRHkrTCsyUWRh?=
 =?utf-8?B?ZmszZ055QzJXSkdnSHVDUS9lMEJKZ1VPVjhSeDZIbnpMWmsvTWNWWmdPU2Rz?=
 =?utf-8?B?RDZXa3NFQ0VHZE9FUTAvK0VXUDRTTmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d41bf4-68bc-4f80-126c-08dc3c65a6c5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 16:10:46.6776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8403

RnJvbTogV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4gU2VudDogTW9uZGF5LCBNYXJjaCA0
LCAyMDI0IDg6MDIgQU0NCj4gDQo+IEhpIGZvbGtzLA0KPiANCj4gT24gTW9uLCBNYXIgMDQsIDIw
MjQgYXQgMDQ6NTU6MDZQTSArMDEwMCwgUGV0ciBUZXNhxZnDrWsgd3JvdGU6DQo+ID4gT24gTW9u
LCA0IE1hciAyMDI0IDEzOjM3OjU2ICswMDAwDQo+ID4gUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJw
aHlAYXJtLmNvbT4gd3JvdGU6DQo+ID4gPiBPbiAwNC8wMy8yMDI0IDExOjAwIGFtLCBQZXRyIFRl
c2HFmcOtayB3cm90ZToNCj4gPiA+IFsuLi5dDQo+ID4gPiA+PiBIZXJlJ3MgbXkgdGFrZSBvbiB0
eWluZyBhbGwgdGhlIHRocmVhZHMgdG9nZXRoZXIuIFRoZXJlIGFyZQ0KPiA+ID4gPj4gZm91ciBh
bGlnbm1lbnQgY29tYmluYXRpb25zOg0KPiA+ID4gPj4NCj4gPiA+ID4+IDEuIGFsbG9jX2FsaWdu
X21hc2s6IHplcm87IG1pbl9hbGlnbl9tYXNrOiB6ZXJvDQo+IA0KPiBCYXNlZCBvbiB0aGlzIF5e
XiAuLi4NCj4gDQo+ID4gPiA+PiB4ZW5fc3dpb3RsYl9tYXBfcGFnZSgpIGFuZCBkbWFfZGlyZWN0
X21hcF9wYWdlKCkgYXJlICMxIG9yICMyDQo+ID4gPiA+PiB2aWEgc3dpb3RsYl9tYXAoKSBhbmQg
c3dpb3RsYl90YmxfbWFwX3NpbmdsZSgpDQo+ID4gPiA+Pg0KPiA+ID4gPj4gaW9tbXVfZG1hX21h
cF9wYWdlKCkgaXMgIzMgYW5kICM0IHZpYSBzd2lvdGxiX3RibF9tYXBfc2luZ2xlKCkNCj4gPiA+
ID4+DQo+ID4gPiA+PiBzd2lvdGxiX2FsbG9jKCkgaXMgIzMsIGRpcmVjdGx5IHRvIHN3aW90bGJf
ZmluZF9zbG90cygpDQo+ID4gPiA+Pg0KPiA+ID4gPj4gRm9yICMxLCB0aGUgcmV0dXJuZWQgcGh5
c2ljYWwgYWRkcmVzcyBoYXMgbm8gY29uc3RyYWludHMgaWYNCj4gPiA+ID4+IHRoZSByZXF1ZXN0
ZWQgc2l6ZSBpcyBsZXNzIHRoYW4gYSBwYWdlLiBGb3IgcGFnZSBzaXplIG9yDQo+ID4gPiA+PiBn
cmVhdGVyLCB0aGUgZGlzY3Vzc2VkIGhpc3RvcmljYWwgcmVxdWlyZW1lbnQgZm9yIHBhZ2UNCj4g
PiA+ID4+IGFsaWdubWVudCBhcHBsaWVzLg0KPiANCj4gLi4uIGFuZCB0aGlzIF5eXiAuLi4NCj4g
DQo+IA0KPiA+IEkgYmVsaWV2ZSB0aGlzIHBhdGNoIHNlcmllcyBpcyBub3cgZ29vZCBhcyBpcywg
ZXhjZXB0IHRoZSBjb21taXQNCj4gPiBtZXNzYWdlIHNob3VsZCBtYWtlIGl0IGNsZWFyIHRoYXQg
YWxsb2NfYWxpZ25fbWFzayBhbmQgbWluX2FsaWduX21hc2sNCj4gPiBjYW4gYm90aCBiZSB6ZXJv
LCBidXQgdGhhdCBzaW1wbHkgbWVhbnMgbm8gYWxpZ25tZW50IGNvbnN0cmFpbnRzLg0KPiANCj4g
Li4uIG15IChwb3NzaWJseSBpbmNvcnJlY3QhKSByZWFkaW5nIG9mIHRoZSB0aHJlYWQgc28gZmFy
IGlzIHRoYXQgd2UNCj4gc2hvdWxkIHByZXNlcnZlIHBhZ2UtYWxpZ25lZCBhbGxvY2F0aW9uIGlu
IHRoaXMgY2FzZSBpZiB0aGUgYWxsb2NhdGlvbg0KPiBzaXplIGlzID49IFBBR0VfU0laRS4NCj4g
DQo+IFNvbWV0aGluZyBsaWtlIHRoZSBkaWZmIGJlbG93LCB0byByZXBsYWNlIHRoaXMgZmluYWwg
cGF0Y2g/DQo+IA0KPiBXaWxsDQo+IA0KPiAtLS0+OA0KPiANCj4gZGlmZiAtLWdpdCBhL2tlcm5l
bC9kbWEvc3dpb3RsYi5jIGIva2VybmVsL2RtYS9zd2lvdGxiLmMNCj4gaW5kZXggYzM4MWE3ZWQ3
MThmLi42N2VhYzA1NzI4YzAgMTAwNjQ0DQo+IC0tLSBhL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+
ICsrKyBiL2tlcm5lbC9kbWEvc3dpb3RsYi5jDQo+IEBAIC05OTIsNiArOTkyLDE0IEBAIHN0YXRp
YyBpbnQgc3dpb3RsYl9zZWFyY2hfcG9vbF9hcmVhKHN0cnVjdCBkZXZpY2UNCj4gKmRldiwgc3Ry
dWN0IGlvX3RsYl9wb29sICpwb29sDQo+ICAgICAgICAgQlVHX09OKCFuc2xvdHMpOw0KPiAgICAg
ICAgIEJVR19PTihhcmVhX2luZGV4ID49IHBvb2wtPm5hcmVhcyk7DQo+IA0KPiArICAgICAgIC8q
DQo+ICsgICAgICAgICogSGlzdG9yaWNhbGx5LCBhbGxvY2F0aW9ucyA+PSBQQUdFX1NJWkUgd2Vy
ZSBndWFyYW50ZWVkIHRvIGJlDQo+ICsgICAgICAgICogcGFnZS1hbGlnbmVkIGluIHRoZSBhYnNl
bmNlIG9mIGFueSBvdGhlciBhbGlnbm1lbnQgcmVxdWlyZW1lbnRzLg0KPiArICAgICAgICAqIFNp
bmNlIGRyaXZlcnMgbWF5IGJlIHJlbHlpbmcgb24gdGhpcywgcHJlc2VydmUgdGhlIG9sZCBiZWhh
dmlvdXIuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgaWYgKCFhbGxvY19hbGlnbl9tYXNrICYm
ICFpb3RsYl9hbGlnbl9tYXNrICYmIGFsbG9jX3NpemUgPj0gUEFHRV9TSVpFKQ0KPiArICAgICAg
ICAgICAgICAgYWxsb2NfYWxpZ25fbWFzayA9IFBBR0VfU0laRSAtIDE7DQo+ICsNCg0KWWVzLCBJ
IHRoaW5rIHRoYXQgc2hvdWxkIGRvIGl0Lg0KDQpNaWNoYWVsDQoNCj4gICAgICAgICAvKg0KPiAg
ICAgICAgICAqIEVuc3VyZSB0aGF0IHRoZSBhbGxvY2F0aW9uIGlzIGF0IGxlYXN0IHNsb3QtYWxp
Z25lZCBhbmQgdXBkYXRlDQo+ICAgICAgICAgICogJ2lvdGxiX2FsaWduX21hc2snIHRvIGlnbm9y
ZSBiaXRzIHRoYXQgd2lsbCBiZSBwcmVzZXJ2ZWQgd2hlbg0KPiBAQCAtMTAwNiwxMyArMTAxNCw2
IEBAIHN0YXRpYyBpbnQgc3dpb3RsYl9zZWFyY2hfcG9vbF9hcmVhKHN0cnVjdCBkZXZpY2UgKmRl
diwgc3RydWN0IGlvX3RsYl9wb29sICpwb29sDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgc3Ry
aWRlID0gZ2V0X21heF9zbG90cyhtYXgoYWxsb2NfYWxpZ25fbWFzaywgaW90bGJfYWxpZ25fbWFz
aykpOw0KPiANCj4gLSAgICAgICAvKg0KPiAtICAgICAgICAqIEZvciBhbGxvY2F0aW9ucyBvZiBQ
QUdFX1NJWkUgb3IgbGFyZ2VyIG9ubHkgbG9vayBmb3IgcGFnZSBhbGlnbmVkDQo+IC0gICAgICAg
ICogYWxsb2NhdGlvbnMuDQo+IC0gICAgICAgICovDQo+IC0gICAgICAgaWYgKGFsbG9jX3NpemUg
Pj0gUEFHRV9TSVpFKQ0KPiAtICAgICAgICAgICAgICAgc3RyaWRlID0gdW1heChzdHJpZGUsIFBB
R0VfU0hJRlQgLSBJT19UTEJfU0hJRlQgKyAxKTsNCj4gLQ0KPiAgICAgICAgIHNwaW5fbG9ja19p
cnFzYXZlKCZhcmVhLT5sb2NrLCBmbGFncyk7DQo+ICAgICAgICAgaWYgKHVubGlrZWx5KG5zbG90
cyA+IHBvb2wtPmFyZWFfbnNsYWJzIC0gYXJlYS0+dXNlZCkpDQo+ICAgICAgICAgICAgICAgICBn
b3RvIG5vdF9mb3VuZDsNCg0K

