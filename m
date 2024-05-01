Return-Path: <linux-kernel+bounces-165677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A22F88B8F5F
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 20:06:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4CC6B231CE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 18:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456CD146D60;
	Wed,  1 May 2024 18:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="K5YkeYGY"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2091.outbound.protection.outlook.com [40.92.40.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78913147C7E;
	Wed,  1 May 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714586760; cv=fail; b=g6AZn73MIWx6UmtC9z1MGsrZr1lTCnoNZoEGdMSxWKQRuqyeMgE6h8nTLkgwAzLxy9YZiuiQ6bmZEzZh3FOMJzLuabeE9/SFmLKd16Yact91qUCvPW8z1umOc2b8vDhZUn1TfOJQcyxaieqAZlij2Hm9QjXSp26hEZXiMpbSvbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714586760; c=relaxed/simple;
	bh=u+xVEnrMXNgyM7GDeLQifnJbt3fQSP3jfWvrMqMowKc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L/+2ppH+CQwnGf04LsOKs4wynf/+unWRFiFLDxe8T74lX5T1NI5z8NNDV5rDcIjSto2V9gf3RTRdA36gFRIDuEvX6RiOCNHO58qEEkgCJIOITSzUHP4keKjSFQAzC8Jl3BZuyRe0vriwz8D0LEOfFN5FS5WN+5WMSD6L9ZkcLqI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=K5YkeYGY; arc=fail smtp.client-ip=40.92.40.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoaaNPjyVkoUa/vbKEyziwdEPgiVnrUIXOQfzKny/6bCBaq2D/jEJnFv1QuixoecAMEsCUHfGsKk3wo58cNLNvrm+TY5NBIHs1XPJ72tM7GkNdO4f4t3r3SPP9d7pNVkzNNVXCVw7ikEGctqZqVB1irAAbODrjcgygTFyELlfTT4c8Izjb1gfWBUuD7/xeq0uQi6CLdAMjnBsYBspg7UwGr4pb1M8sA/bbws8mqcOexjXbS7KHQxNy9vJtejiyKUFm75mRDJwAVD8IMfsYJlyuh4yGg/wsK4frMsU5Xk4UyXqSVXHAlwS+eUmr0tGQOekvw3hQq1aAILVEtclQOXYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+xVEnrMXNgyM7GDeLQifnJbt3fQSP3jfWvrMqMowKc=;
 b=EfYxgjq6wa1u6n91Zcg3NWjtTkM4jd+3UL6J7UCTjCc1Zeof12QPTZxN5oFfH5hgj/thISBKcbmV0bsGJMLCWrWaXJDX9UtTDmIUu+VnYwV6XcDrs5jPHjfnTv66G4JP7Wno4Q/Bm0oIhWJcIyuUrqWUuSQfM3xbEj9fjTP3j9DvPtkZsN5THFJ+cYwmZj3sC6w6CMLlwRGNkHFXg2wSrJd9KleK59Rsk0qWDEOgRMmj3THF3dD9dPVSNmBTIUSoHjXeQ49q1bIBwTu31vUkRAgqoICowDS71X07xpKQYmrbglbZAQam8tN0qdMbf3ogmftiFOGcicIRqHu2Y5kw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u+xVEnrMXNgyM7GDeLQifnJbt3fQSP3jfWvrMqMowKc=;
 b=K5YkeYGYMayGXy0O2nipwqUKVKOL32AZzytswq3ZcR/VpNaIFWp8tpY9GX5wBVDJntqZCu2NUPGUs0dxf9GHE+2Jwx8dTrqAnh+u+/cAaIGnVhBBFdT/OhsBHoZACp+yB1JztVJwymlPrcmx7ZrsX8CGuTfXNsZpQ88X+dWl6aupMLkcGzyB46mSh94DWuihvFgCI8wvsIjGsiaxc5dhXpUMJQHVtPQOZ7rtbgimPGuPHJy4wrZ6maUi4rPPRL0dKYlz5/i3CTX12H5w6TjmYecVh1WgePM42ShghaPm4srU23MCYf/opv2XYvSSq3D+1jbSBBMujVUM00gxUo3bhg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7253.namprd02.prod.outlook.com (2603:10b6:510:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 18:05:55 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 18:05:55 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "petr@tesarici.cz"
	<petr@tesarici.cz>, "roberto.sassu@huaweicloud.com"
	<roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHamkkjbWfDkycKIE6vEiaFEPOMJrGCAO2AgACueAA=
Date: Wed, 1 May 2024 18:05:53 +0000
Message-ID:
 <SN6PR02MB41574D7C31507EA7AD10FAA5D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
 <ZjHxxzRb-63ARo6Z@archie.me>
In-Reply-To: <ZjHxxzRb-63ARo6Z@archie.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [79ELTPKoueVHdG848RtJe4R9zJq1NQ8m]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7253:EE_
x-ms-office365-filtering-correlation-id: d6ba9b0b-6327-4f9c-f2e5-08dc6a09577d
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|3412199016|440099019;
x-microsoft-antispam-message-info:
 7Ji2Ek6BGn1nq/OGQZLMoIrdg1Fp2z/yNe9wY4L1xFPkGZBeEWO/TU4rnm7ekkB4ni+6YYPaVhc5do4Rz/LvIwLHFIxzCOuZZBhf0auD2Kxe4vJR6iFGy3FnqzMLrCBBAsqbVid1QNydG53VMmk6EB5cGXLMS15Izt39rHtnU+tl91Ig0Nc9LbmmzUzFuxvM6kvrAjB64lMkwi1GieZEq9y8xFd7jhZ+kVAKf6iSstvWVM3pTRfELLE4DaXv/K2OybZJjoy/xKl+KE9PNQ+Va27ZHKTV2lp3/CBTrjLeGqLEXfaHUzrevoB8P+v0+tK4mztvx1TGCZqDOQaIAlaWr8SFzlumg3/VZFkxbdHDguB0ukoNi392okkVyZmH4avQaUpKy9Z5cBIHkDcY/DxvtvKQtIuGCAeaTBZQ4TxqGsvIfbM6fqro4HXtmbOGwdoTbXLOvVP53UNYRh3jHTPM7NVbqFTV3i4rjmFJ/3onFniU+0OUdjH4Ynnh4oFb1EIry8+3azPWqjjWa18o4Wt/e8mjKLFoipviFkzAy27usK6OIDDGDM6kBsnwGah6cTqJ
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmlyNXh0V21hM096TzlkOVg1ZXVOOEtpMXJNRVlLTEo1a09RT3JSckQrZWF4?=
 =?utf-8?B?Q1lycU45VTRuQ0dxSFF0bXZyTFQ0eGJLS2x0WXNiQVhidHN6RnlVZlg4U3U5?=
 =?utf-8?B?R1dsY3JDWFo2VkpnMlpnT2FCRHF1MjAzbmhJZVFVSm1LQ0JYdjgwYVczdWRr?=
 =?utf-8?B?enpWa0ZYbmtOcjVSM1QwOW5Gc2ZQMmdJbkxBa1ZTeTV4cVpURlNoMng1Vkl2?=
 =?utf-8?B?T0ZVN1o2cnIzM3p0bkxjQTREbVZhM2dMNDJnVDRlTDFESGRLdlVOR1p2bUNp?=
 =?utf-8?B?azd4YWQxcUYydjQzTHlDYmU3ak9LSHhWY1dybUpCbUlxRjk3WW90ZVlVZ2s0?=
 =?utf-8?B?YlprQTAwc0FITDFJaTdWZHdlcTNYak96MGU3Qm9DaCtlcndQaUVCVlNIbCsr?=
 =?utf-8?B?K2laYkliTml1Y2JGeUJjOXF2SWF4dHcwMzhUKy9BaStUUTZIZmJSZkhvKzQy?=
 =?utf-8?B?SytaZkNHaEZLM2creXZiVWE5dENuOGtFd0VINFhUZEdEWnhmVVU2NDRETGxM?=
 =?utf-8?B?MStxTDdTNDMwUE15bkt4VHZWRXhyVTFlTGFyN3BYNU1EQ2VPTlZaeW1vSWY5?=
 =?utf-8?B?NVF1M25SMzhDSERsVWMyOXljSWRlSElpcVNZbXNMZ1VlSHFtKy9HWVNDTUl4?=
 =?utf-8?B?Um1GMTdtcUYvMDRMWWJqVVV6Rk8zcytCV0pBSjN0eXNsREVTUWRqcGlKN3JW?=
 =?utf-8?B?TXYzdFlaRzUvMDZFY3FaQ3crVUxHQThMMVNhUmxMUUF3bm56MlBZNzFja1dq?=
 =?utf-8?B?amNJVVVzNm5ML3ZqR25XUXFITVhzNG8yYW9xcUF5TlRDeXpPc0Y5dWlxbE8z?=
 =?utf-8?B?cXBCVEtyVHBuUHN5VmpMeGJYMmdqQW5BUEtoWCs2MEJEc3Rwd0x2NlVlaVoy?=
 =?utf-8?B?VFNWQ0I5UGVUeDRwcllqNC8wRmJNd29OWU95d3F1UFdDdHgrR2Z2cklWTXYw?=
 =?utf-8?B?OHIreSsvWDA3dXFBNG16bWlQK3VjRkZUUURUbEEwV1JBUU0vMEZBQ29DV2h1?=
 =?utf-8?B?SGkxN3BqZktFMFFqZkNhd01VbmlKVHJ2OWcrdjJYZG5zL0hPdUxCait3WFN2?=
 =?utf-8?B?OG1zZHpLMm9Oam9BZnB3UVRwMW5QcUswc0F3eGIyVmhyNDVNR3pDaGszNzhr?=
 =?utf-8?B?NDU1elZTL3pndlA4Y3pobjB4NnZjZHcvRkVhOEd4RXQvTUEyQ2VFVjNYVlB6?=
 =?utf-8?B?SWI1UGdDV0dObDZiV2FMMHZzaklteUVUVmRjRXQzYUU0TTQrdDJoSENSVEF1?=
 =?utf-8?B?Qm8yanduS29BR0o3VXZzTERRSHFUN0lqRHkxMW01bjVkRDJ2ZmhvblRiSkJI?=
 =?utf-8?B?QmFJdUUvcElhbVhkcU9zUXVOblQ4cEpmWFVqaVJ6RVh4N3lodTYxdkxIWHdY?=
 =?utf-8?B?UUtzTVUrWE5iUDBxUzhDWnkrZnhMd090NE5WdXZPUk01OUQrYjBEMFNoaHgy?=
 =?utf-8?B?VzFHVmNuMzdkNFc2Uys0Q1ZhM1FiNjJ0TFFzYm4wUXZubHg0RU1aMTVBazRw?=
 =?utf-8?B?SHc5RmtndDU0ZVRZdG94QUhueHkydFZ2NUdaQlNGUmNWVWgxRXl6RWRKRkUv?=
 =?utf-8?B?NWJYTkZUZ0tjL0NydFhLelduSTlXY0VLbWNHOEY5MVVtc0kvMGw3ZkhlUHZy?=
 =?utf-8?Q?5qujpewdfTsZlTjvhTmv73QtY1GEPXUMz8cCWjfm058A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ba9b0b-6327-4f9c-f2e5-08dc6a09577d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 18:05:53.4832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7253

RnJvbTogQmFnYXMgU2FuamF5YSA8YmFnYXNkb3RtZUBnbWFpbC5jb20+IFNlbnQ6IFdlZG5lc2Rh
eSwgTWF5IDEsIDIwMjQgMTI6NDAgQU0NCj4gDQo+IE9uIE1vbiwgQXByIDI5LCAyMDI0IGF0IDA4
OjEzOjM3QU0gLTA3MDAsIG1oa2VsbGV5NThAZ21haWwuY29tIHdyb3RlOg0KPiA+IEZyb206IE1p
Y2hhZWwgS2VsbGV5IDxtaGtsaW51eEBvdXRsb29rLmNvbT4NCj4gPg0KPiA+IFRoZXJlJ3MgY3Vy
cmVudGx5IG5vIGRvY3VtZW50YXRpb24gZm9yIHRoZSBzd2lvdGxiLiBBZGQgZG9jdW1lbnRhdGlv
bg0KPiA+IGRlc2NyaWJpbmcgdXNhZ2Ugc2NlbmFyaW9zLCB0aGUga2V5IEFQSXMsIGFuZCBpbXBs
ZW1lbnRhdGlvbiBkZXRhaWxzLg0KPiA+IEdyb3VwIHRoZSBuZXcgZG9jdW1lbnRhdGlvbiB3aXRo
IG90aGVyIERNQS1yZWxhdGVkIGRvY3VtZW50YXRpb24uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBNaWNoYWVsIEtlbGxleSA8bWhrbGludXhAb3V0bG9vay5jb20+DQo+IA0KPiBPdGhlciB0aGFu
IG91dHN0YW5kaW5nIHJldmlld3MsIHRoZSBkb2MgTEdUTS4gVGhhbmtzIQ0KPiANCj4gUmV2aWV3
ZWQtYnk6IEJhZ2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPg0KPiANCg0KVGhhbmtz
IGZvciB5b3VyIHJldmlldyEgIEkgcmVhbGl6ZSB0aGF0IEkgZm9yZ290IHRvIGNhcnJ5IHlvdXIg
UmV2aWV3ZWQtYnkNCmZvcndhcmQgdG8gdjQuICAgSWYgeW91IGNhcmUgdG8gZG8gaXQgYWdhaW4g
Zm9yIHY0LCB0aGF0IHdvdWxkIGJlIGdyZWF0Lg0KDQpNaWNoYWVsDQo=

