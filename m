Return-Path: <linux-kernel+bounces-165361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22ED88B8BBD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 16:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCB032843CA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 14:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330F212F364;
	Wed,  1 May 2024 14:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="JapnPLzf"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2022.outbound.protection.outlook.com [40.92.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B5212DDBD;
	Wed,  1 May 2024 14:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714572954; cv=fail; b=fSYaKmRp+2at3KtD8A+9xVz7aq0Z5651BBdPF2N3YizfEutkyxUo5nizBqrl1deww+zHsEf3i5sLJsMyrRJxHpBxKv12zfMI9fgifRP9tqFJkJZJaOITShoCUbRqLkjYmpPqvzLqP8xd9LhI/4+IDQ/G4+FBT5hFtgbO81s6SSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714572954; c=relaxed/simple;
	bh=MTvR/cSzVAo6k+/dq4+HKs5/lwvU2CZ5QqhMI28ib9I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JmnGjO976AReBOiosEV8UUt/J3lYjUpngyCQydf8FXEQJOc7nsl0bYnZjYhRoAN70MlGuQ9HC/PwoP81mv5HpjxlyTEl79j+SPfo4d3SCoeh2XHUsxq0Fhtkw8RGeLpcRJgS7tfI6w/lKf6q1UcbuQRpMnNcFlnyBSvmSnsqRNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=JapnPLzf; arc=fail smtp.client-ip=40.92.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLgSwcT3bPEJJx8kb9I95uoovgSkX2DjpZ2SWmJP/hdtF+gV8AW9cMYGJY2ie09UoebWnczgZiFUJn1C6uWYOcU/LO6gTjQj3afLRw3//toP+VxcKrRMmxLN/++/lonKOJ2arxB2mQhAuy49Nw1C9BQRXaFIUfw/6nUb/63WC6udn1gweFsPFXtxQ9f8IJE11MuZY5op5oYVBm1DmBs5AdtjDFhQletVwNPtazhZp/OWNjWk0aw6TfaQFgHhyHYhdPcFkwr8MgfZBmbiNigpHl4KVLypsTgTcOCFT/s1YFm9XHIxO6Hlc88s+Fm1fR4FvSFlKGwpWTB2SlhAOyIhZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTvR/cSzVAo6k+/dq4+HKs5/lwvU2CZ5QqhMI28ib9I=;
 b=MbXtf/pCkjz45jXOBEdO0c0zgrUwdjA0dv1w1OJ4pxExOxL2ySkVuZx1ErY3gyKXZ5Z5/BPpVCANcRIENbkGN2bS0qsTYa6wkaZUK4TIcERauxqSJ34z7EPl3Wd4fZLp13ltymBi9CJq9A8FODu1sDtIpH+tHEmlxfggYXzrMKIeycr80gOCocD+TCgJuLRQ5nLH52D+bFGmY1/3Jr/qKNXAUwVvJszZcs//AKJD+gnxjAiO9j8onxFU5R3G5X6bBIre6miSgwR8OTRm55NJbj6qItgU2BDy8CSlXi2RLEFOpdS7+LVqTT3aYmX8qTVorgoVOXKjZWJBeMTBdLooNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTvR/cSzVAo6k+/dq4+HKs5/lwvU2CZ5QqhMI28ib9I=;
 b=JapnPLzf++pHFkpd4EdseV0GeoWPG3wQiMD07ulhG00M8FEvj14bc9ih3BctSr8LjEN7wNAS0RKIeMZwlT71WFwwg/rVSza64WazuIc4QIKOPB8bTv8kA1pf4IqwuYu3os41xtO2ZBG4PJcbWofRGVLW4i3hwttalkCp7gmMvHM3+COKmDa3M4Zu4E4kt8H8LdxbERnpDhU6vX16QsgMJQYtPxkt/9O1vu1qWovbw+CUkMF1UrGjOS4eo5sEkYnsu8rNn62B6jktg1sx62356uAH+9Rs5bPOL3dm+64sOVv6rpqBOxTuVij5l9BIbWsiePEvsiZs/tbB5zhBBvvNWA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8209.namprd02.prod.outlook.com (2603:10b6:610:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Wed, 1 May
 2024 14:15:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 14:15:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: =?utf-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
CC: "mhkelley58@gmail.com" <mhkelley58@gmail.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"will@kernel.org" <will@kernel.org>, "hch@lst.de" <hch@lst.de>,
	"m.szyprowski@samsung.com" <m.szyprowski@samsung.com>, "corbet@lwn.net"
	<corbet@lwn.net>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"roberto.sassu@huaweicloud.com" <roberto.sassu@huaweicloud.com>
Subject: RE: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Topic: [PATCH v3 1/1] Documentation/core-api: Add swiotlb documentation
Thread-Index: AQHamkkjbWfDkycKIE6vEiaFEPOMJrGArUiAgABBPQCAAFF/AIABLs6A
Date: Wed, 1 May 2024 14:15:50 +0000
Message-ID:
 <SN6PR02MB4157DC5A657541B4DE3B33B7D4192@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240429151337.1069470-1-mhklinux@outlook.com>
	<20240430132413.69797af1@mordecai>
	<SN6PR02MB41579F43DD1ACB401EEC9E7AD41A2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <20240430220924.3d0446f7@meshulam.tesarici.cz>
In-Reply-To: <20240430220924.3d0446f7@meshulam.tesarici.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [Wd2kfkvsP+spwk9FvvC+PrYnqpI90usV]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8209:EE_
x-ms-office365-filtering-correlation-id: 4e78f91d-587b-41b5-7b80-08dc69e93432
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199019|102099023|440099019|3412199016|56899024;
x-microsoft-antispam-message-info:
 Vi1yE2/htY4lu7oRgtS9Ul+E/Wa43d3+8qoDy4AKYFTAWFECmUfzE0iispd2geIYo0v/3MjxEkPO0rKAkq4xbMbCJe10CKzXaqd06qBLWvYpZuQX3vHbkD6VfVnjd9p3ESNYf4MCUnv+gfHkyp4baVyxwbxP1nXtS29ve3v470oWRdrr8BmnMiR86Z66Uou1XpxvAQ0eSFnk7WO1kFcrj+MDnCRxVxYifacF0zPQMe3PkU6xFrsxCGyMAg9RDYpVKv2IuCwhkdAgVbttSFqEYT8r8t+LdD3P0iIcdIV54cK7NGq7p6dCSo1fo4LGi09w/vcqh+UTvV4vDEAqxE3Uprs7IvJqmA/jj5A9AdNCPPShf94oH6foAeobzjuKYzljnpMjkJ02iiLKTz0GFqsx8u3W4eRkyYr9k3SobBr2YuizlnSROIANYYEUKh2D1oXdQP/l8sLWhEH3WnW/Y3HwHUEtAguFwU5J6OAhFBPR9LWAXTbpzmbsT2lo+prSxCRcv8oHTuLC+mLOsQY+GoEA6ltKwZ6YB4IZRTreCtzftCBQX71eJOIratUWKzvICKyI
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eEdRVnBrZXZBY0JpM3VKa1hyby9ld01UVTUvOHZkU2F0YnRXcDQxUVVIWGJx?=
 =?utf-8?B?aGJzVktrTUFrTTBldkU4b2xtRnBLQmdFcFFNV3FCaG1SYmUyZXdQUmVQdkxu?=
 =?utf-8?B?RXM0WklJakNZMGlEK2ZKUW5XOHNNSGNFZm1USzJveXpzR2wyOE9hY2dMYXEv?=
 =?utf-8?B?cGZDSUFKc3NBWTZGOGNhZzJpQytZMFV2d3pNdzl0a0lWMHNhbmNPcUJoMHNJ?=
 =?utf-8?B?WUhkZk5XOFRwbzdlSlpnT2VpWFdtOXArMFE1bmhLSWU5b3BZMDcxNXJNYVE4?=
 =?utf-8?B?SW9vNUNHbXVOUkVKcSs5UVJIZExGUklVWnJleXdtRVRscDB4MlVEVGppV1BX?=
 =?utf-8?B?T2VvQVVQem1yT1lyZ1o1MElvSUxVaUZkWWtZT2ROUWRKaDAyaUdkUnZEZ2tE?=
 =?utf-8?B?YkJPY3pSdzlSMTVtajRKQXpxUVlkQXJIOE9hOW1pcmNMSC9OcEc1MU1UUXRE?=
 =?utf-8?B?clVYTnF1TFNLSDExakZhRU9YR2xVU1hTR1ZkRXNMUS9GREZNZ3RIQXN6MUlE?=
 =?utf-8?B?eGlLTHM0SzV2WWJyd2NidmdySXV1Q2tPbVhGKzVoZWhOODlYMkluR0xlcDl6?=
 =?utf-8?B?M3NETkNJS2NtZDVzT2g0MitqdjR4Vk9lN1NGL0hXZWdibGk5KzdyT1p6eWtw?=
 =?utf-8?B?OEE1TldkVG5qODM1bHgxcXVUL3owcVBkY2pSaFU4SXFlbWZHeno2Vm9hQ0tI?=
 =?utf-8?B?SUg5UklWd0pyeG5kaUd0eWZrdi82YWgrampmWWlHVFpKQW1vcEFaUnhIUzRE?=
 =?utf-8?B?OW9XVlhjcVNqa1BHdGVwcWI3U1hYbDF1RnN5RGQyWTZNaC9rOWNlNTlPM3M3?=
 =?utf-8?B?QVhuYkJMMk9GRUJUVnd6aU1wL3BWUkxxTDhSUHNBOFMxY1NVKzM2a20wSjJl?=
 =?utf-8?B?U0Rzc1NoZUtmc3J0Y1JCL1BSS1lRaXRMVmFPb1VqRXUwK1Iwd1ZjL1RJWU1T?=
 =?utf-8?B?MGNqVExMdXMySnFkeGtaQjZiR0NiUTVyUVJHOVlLMTJkZVVJSVZ3NWt5azls?=
 =?utf-8?B?USs3dGVLNUw0QUdQRmN2cG1DUUVOTG8rOHcrN3pCNE1QcGVuODRnNTNWNkhQ?=
 =?utf-8?B?MnlSVzdUN0lEczBCandOdVQ0bk1qb2JwY3JWdEFJdXRrVjIwS2xEVkhZVmdD?=
 =?utf-8?B?ZE5LdlZhYWNtNkE3MFBWNTFzcmNxd3JpWThidDFKZ3NoK2NyajJiTThsSXNn?=
 =?utf-8?B?eGxMTFg4S2ZyTkYrcmNxeis2WERDRFdKTDhSMWl5MXNXdVM5bktPQXZYZDhm?=
 =?utf-8?B?WjRBVEg0Sklsay9Sc0YxZDhnajZxTWlJZ2YzRFFtdWdORFF4ZStKdHZXRHNx?=
 =?utf-8?B?ZEtmMHRZY2tmRGxLajg1anhzZmFFUFhKNjF5RVJTeFZrWmFCMHg4WEFvTzk0?=
 =?utf-8?B?b2U2Z0NmdnF6WW1kQTNUa1VCQjUyMGVXOGtrR2FEMkxvby9Pazl2cFoyRWZD?=
 =?utf-8?B?aFJyMUd1ZzdBVW9OeG94YTZ1TG5FZUptMWJJaWtrZjNvSEVZdjNtRDNpTHFU?=
 =?utf-8?B?ajJaRWZPNzhaUFNrVlZRQStsMGZYNkxaMHdEM2JyeVhZenAyaVd4M2VSM0xR?=
 =?utf-8?B?MzdUU05mcHpmcStCQXJWRUFUbTEvQXA1cmhhOXdYYnljaEpJWEtUYWFqaFBI?=
 =?utf-8?B?bDRyMEtYaWt3MVpQd2tyTmswcmhLdmc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e78f91d-587b-41b5-7b80-08dc69e93432
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 May 2024 14:15:50.3491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8209

RnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IFR1ZXNkYXksIEFw
cmlsIDMwLCAyMDI0IDE6MDkgUE0NCj4gDQo+IE9uIFR1ZSwgMzAgQXByIDIwMjQgMTU6NDg6NDIg
KzAwMDANCj4gTWljaGFlbCBLZWxsZXkgPG1oa2xpbnV4QG91dGxvb2suY29tPiB3cm90ZToNCj4g
DQo+ID4gRnJvbTogUGV0ciBUZXNhxZnDrWsgPHBldHJAdGVzYXJpY2kuY3o+IFNlbnQ6IFR1ZXNk
YXksIEFwcmlsIDMwLCAyMDI0IDQ6MjQgQU0NCj4gPiA+ID4NCj4gPiA+ID4gK1VzYWdlIFNjZW5h
cmlvcw0KPiA+ID4gPiArLS0tLS0tLS0tLS0tLS0tDQo+ID4gPiA+ICtzd2lvdGxiIHdhcyBvcmln
aW5hbGx5IGNyZWF0ZWQgdG8gaGFuZGxlIERNQSBmb3IgZGV2aWNlcyB3aXRoIGFkZHJlc3NpbmcN
Cj4gPiA+ID4gK2xpbWl0YXRpb25zLiBBcyBwaHlzaWNhbCBtZW1vcnkgc2l6ZXMgZ3JldyBiZXlv
bmQgNCBHaUIsIHNvbWUgZGV2aWNlcyBjb3VsZA0KPiA+ID4gPiArb25seSBwcm92aWRlIDMyLWJp
dCBETUEgYWRkcmVzc2VzLiBCeSBhbGxvY2F0aW5nIGJvdW5jZSBidWZmZXIgbWVtb3J5IGJlbG93
DQo+ID4gPiA+ICt0aGUgNCBHaUIgbGluZSwgdGhlc2UgZGV2aWNlcyB3aXRoIGFkZHJlc3Npbmcg
bGltaXRhdGlvbnMgY291bGQgc3RpbGwgd29yayBhbmQNCj4gPiA+ID4gK2RvIERNQS4NCj4gPiA+
DQo+ID4gPiBJSVJDIHRoZSBvcmlnaW5zIGFyZSBldmVuIG9sZGVyIGFuZCBib3VuY2UgYnVmZmVy
cyB3ZXJlIHVzZWQgdG8NCj4gPiA+IG92ZXJjb21lIHRoZSBkZXNpZ24gZmxhd3MgaW5oZXJpdGVk
IGFsbCB0aGUgd2F5IGZyb20gdGhlIG9yaWdpbmFsIElCTQ0KPiA+ID4gUEMuIFRoZXNlIGNvbXB1
dGVycyB1c2VkIGFuIEludGVsIDgyMzcgZm9yIERNQS4gVGhpcyBjaGlwIGhhcyBhIDE2LWJpdA0K
PiA+ID4gYWRkcmVzcyByZWdpc3RlciwgYnV0IGV2ZW4gdGhlIGVhcmx5IDgwODggQ1BVcyBoYWQg
YSAyMC1iaXQgYnVzLiBTbyBJQk0NCj4gPiA+IGFkZGVkIGEgc2VwYXJhdGUgNzRMUzY3MCA0LWJ5
LTQgcmVnaXN0ZXIgZmlsZSBjaGlwIHRvIHByb3ZpZGUgdGhlIGhpZ2ggNA0KPiA+ID4gYml0cyBm
b3IgZWFjaCBvZiB0aGUgNCBETUEgY2hhbm5lbHMuIEFzIGEgc2lkZSBub3RlLCB0aGVzZSBiaXRz
IHdlcmUgbm90DQo+ID4gPiB1cGRhdGVkIHdoZW4gdGhlIDgyMzcgYWRkcmVzcyByZWdpc3RlciB3
YXMgaW5jcmVtZW50aW5nIGZyb20gMHhmZmZmLCBzbw0KPiA+ID4gRE1BIHdvdWxkIG92ZXJmbG93
IGF0IGV2ZXJ5IDY0SyBhZGRyZXNzIGJvdW5kYXJ5LiBQQyBBVCB0aGVuIHJlcGxhY2VkDQo+ID4g
PiB0aGVzZSA0IGJpdHMgd2l0aCBhbiA4LWJpdCBETUEgInBhZ2UiIHJlZ2lzdGVyIHRvIG1hdGNo
IHRoZSAyNC1iaXQNCj4gPiA+IGFkZHJlc3MgYnVzIG9mIGFuIDgwMjg2LiBUaGlzIGRlc2lnbiB3
YXMgbm90IGNoYW5nZWQgZm9yIDMyLWJpdCBDUFVzDQo+ID4gPiAoaS5lLiA4MDM4NikuDQo+ID4g
Pg0KPiA+ID4gSW4gc2hvcnQsIGJvdW5jZSBidWZmZXJzIHdlcmUgbm90IGludHJvZHVjZWQgYmVj
YXVzZSBvZiA2NC1iaXQgQ1BVcy4NCj4gPiA+IFRoZXkgd2VyZSBhbHJlYWR5IG5lZWRlZCBvbiAz
ODYgc3lzdGVtcy4NCj4gPiA+DQo+ID4gPiBPVE9IIHRoaXMgcGFydCBvZiB0aGUgaGlzdG9yeSBu
ZWVkIG5vdCBiZSBtZW50aW9uZWQgaW4gdGhlDQo+ID4gPiBkb2N1bWVudGF0aW9uICh1bmxlc3Mg
eW91IFdBTlQgaXQpLg0KPiA+DQo+ID4gSSBrbmV3IHRoZXJlIHdhcyBzb21lIGV2ZW4gZWFybGll
ciBoaXN0b3J5LCBidXQgSSBkaWRuJ3Qga25vdyB0aGUNCj4gPiBkZXRhaWxzLiA6LSggIEknbGwg
YWRkIHNvbWUgcXVhbGlmeWluZyB3b3JkaW5nIGFib3V0IHRoZXJlIGJlaW5nIG11bHRpcGxlDQo+
ID4gRE1BIGFkZHJlc3NpbmcgbGltaXRhdGlvbnMgZHVyaW5nIHRoZSBoaXN0b3J5IG9mIHRoZSB4
ODYgUENzLCB3aXRoDQo+ID4gdGhlIDMyLWJpdCBhZGRyZXNzaW5nIGFzIGEgbW9yZSByZWNlbnQg
ZXhhbXBsZS4gIEJ1dCBJIHdvbid0IHRyeSB0bw0KPiA+IGNvdmVyIHRoZSBkZXRhaWxzIG9mIHdo
YXQgeW91IGRlc2NyaWJlLg0KPiANCj4gWWVzLCB0aGlzIHNvdW5kcyBsaWtlIGEgZ29vZCBsZXZl
bCBvZiBkZXRhaWwuDQoNCkJhc2VkIG9uIHRoZSBmb2xsb3ctdXAgY29udmVyc2F0aW9uIHdpdGgg
Q2hyaXN0b3BoLCBJIHRoaW5rIGl0J3MgY29ycmVjdA0KdG8ganVzdCBsZWF2ZSB0aGlzIHBhcnQg
dW5jaGFuZ2VkLg0KDQo+IA0KPiA+ID4gPiArDQo+ID4gPiA+ICtNb3JlIHJlY2VudGx5LCBDb25m
aWRlbnRpYWwgQ29tcHV0aW5nIChDb0NvKSBWTXMgaGF2ZSB0aGUgZ3Vlc3QgVk0ncyBtZW1vcnkN
Cj4gPiA+ID4gK2VuY3J5cHRlZCBieSBkZWZhdWx0LCBhbmQgdGhlIG1lbW9yeSBpcyBub3QgYWNj
ZXNzaWJsZSBieSB0aGUgaG9zdCBoeXBlcnZpc29yDQo+ID4gPiA+ICthbmQgVk1NLiBGb3IgdGhl
IGhvc3QgdG8gZG8gSS9PIG9uIGJlaGFsZiBvZiB0aGUgZ3Vlc3QsIHRoZSBJL08gbXVzdCBiZQ0K
PiA+ID4gPiArZGlyZWN0ZWQgdG8gZ3Vlc3QgbWVtb3J5IHRoYXQgaXMgdW5lbmNyeXB0ZWQuIENv
Q28gVk1zIHNldCBhIGtlcm5lbC13aWRlIG9wdGlvbg0KPiA+ID4gPiArdG8gZm9yY2UgYWxsIERN
QSBJL08gdG8gdXNlIGJvdW5jZSBidWZmZXJzLCBhbmQgdGhlIGJvdW5jZSBidWZmZXIgbWVtb3J5
IGlzIHNldA0KPiA+ID4gPiArdXAgYXMgdW5lbmNyeXB0ZWQuIFRoZSBob3N0IGRvZXMgRE1BIEkv
TyB0by9mcm9tIHRoZSBib3VuY2UgYnVmZmVyIG1lbW9yeSwgYW5kDQo+ID4gPiA+ICt0aGUgTGlu
dXgga2VybmVsIERNQSBsYXllciBkb2VzICJzeW5jIiBvcGVyYXRpb25zIHRvIGNhdXNlIHRoZSBD
UFUgdG8gY29weSB0aGUNCj4gPiA+ID4gK2RhdGEgdG8vZnJvbSB0aGUgb3JpZ2luYWwgdGFyZ2V0
IG1lbW9yeSBidWZmZXIuIFRoZSBDUFUgY29weWluZyBicmlkZ2VzIGJldHdlZW4NCj4gPiA+ID4g
K3RoZSB1bmVuY3J5cHRlZCBhbmQgdGhlIGVuY3J5cHRlZCBtZW1vcnkuIFRoaXMgdXNlIG9mIGJv
dW5jZSBidWZmZXJzIGFsbG93cw0KPiA+ID4gPiArZXhpc3RpbmcgZGV2aWNlIGRyaXZlcnMgdG8g
Imp1c3Qgd29yayIgaW4gYSBDb0NvIFZNLCB3aXRoIG5vIG1vZGlmaWNhdGlvbnMNCj4gPiA+ID4g
K25lZWRlZCB0byBoYW5kbGUgdGhlIG1lbW9yeSBlbmNyeXB0aW9uIGNvbXBsZXhpdHkuDQo+ID4g
Pg0KPiA+ID4gVGhpcyBwYXJ0IG1pZ2h0IGJlIG1pc2xlYWRpbmcuIEl0IHNvdW5kcyBhcyBpZiBT
V0lPVExCIHdvdWxkIG5vdCBiZQ0KPiA+ID4gbmVlZGVkIGlmIGRyaXZlcnMgd2VyZSBzbWFydGVy
Lg0KPiA+DQo+ID4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcG9pbnQgeW91IGFyZSBt
YWtpbmcuIEl0IGlzIHBvc3NpYmxlIGZvciBhDQo+ID4gZHJpdmVyIHRvIGRvIGl0cyBvd24gbWFu
dWFsIGJvdW5jZSBidWZmZXJpbmcgdG8gaGFuZGxlIGVuY3J5cHRlZCBtZW1vcnkuDQo+ID4gRm9y
IGV4YW1wbGUsIGluIGFkZGluZyBzdXBwb3J0IGZvciBDb0NvIFZNcywgd2UgZW5jb3VudGVyZWQg
c3VjaCBhDQo+ID4gZHJpdmVyL2RldmljZSB3aXRoIGNvbXBsZXggRE1BIGFuZCBtZW1vcnkgcmVx
dWlyZW1lbnRzIHRoYXQgYWxyZWFkeQ0KPiA+IGRpZCBzb21lIG1hbnVhbCBib3VuY2UgYnVmZmVy
aW5nLiBXaGVuIHVzZWQgaW4gYSBDb0NvIFZNLCBkcml2ZXINCj4gPiBtb2RpZmljYXRpb25zIHdl
cmUgbmVlZGVkIHRvIGhhbmRsZSBlbmNyeXB0ZWQgbWVtb3J5LCBidXQgdGhhdCB3YXMNCj4gPiB0
aGUgcHJlZmVycmVkIGFwcHJvYWNoIGJlY2F1c2Ugb2YgdGhlIHByZS1leGlzdGluZyBtYW51YWwg
Ym91bmNlDQo+ID4gYnVmZmVyaW5nLiBJbiB0aGF0IGNhc2UsIGluZGVlZCBzd2lvdGxiIHdhcyBu
b3QgbmVlZGVkIGJ5IHRoYXQgZHJpdmVyL2RldmljZS4NCj4gPiBCdXQgaW4gdGhlIGdlbmVyYWwg
Y2FzZSwgd2UgZG9uJ3Qgd2FudCB0byByZXF1aXJlIGRyaXZlciBtb2RpZmljYXRpb25zIGZvcg0K
PiA+IENvQ28gVk1zLiBzd2lvdGxiIGJvdW5jZSBidWZmZXJpbmcgbWFrZXMgaXQgYWxsIHdvcmsg
aW4gdGhlIGV4YWN0bHkgdGhlDQo+ID4gc2l0dWF0aW9uIHlvdSBkZXNjcmliZSB3aGVyZSB0aGUg
YnVmZmVyIG1lbW9yeSBjb3VsZCBoYXZlIG9yaWdpbmF0ZWQNCj4gPiBpbiBhIHZhcmlldHkgb2Yg
cGxhY2VzLg0KPiA+DQo+ID4gQ291bGQgeW91IGNsYXJpZnkgeW91ciBwb2ludD8gIE9yIHBlcmhh
cHMgc3VnZ2VzdCBhbHRlcm5hdGUgd29yZGluZw0KPiA+IHRoYXQgd291bGQgaGVscCBhdm9pZCBh
bnkgY29uZnVzaW9uPw0KPiANCj4gQWgsIEkgd2Fzbid0IGF3YXJlIHRoYXQgc29tZSBkcml2ZXJz
IGltcGxlbWVudCB0aGVpciBvd24gYm91bmNlDQo+IGJ1ZmZlcnMuIEkgY2FuJ3Qgc2F5IEknbSBy
ZWFsbHkgaGFwcHkgYWJvdXQgaXQsIGJlY2F1c2Ugc3VjaCBkcml2ZXJzDQo+IG11c3QgaW5ldml0
YWJseSBkZWFsIHdpdGggYWxsIHRoZSBjb21wbGV4aXRpZXMgbGlrZSBJT01NVSwgZGVjcnlwdGlu
ZywNCj4gZXRjLiBCdXQgeW91J3JlIHJpZ2h0IC0gYm91bmNlIGJ1ZmZlcnMgY2FuIGJlIGltcGxl
bWVudGVkIGJ5IGluZGl2aWR1YWwNCj4gZHJpdmVycy4NCj4gDQo+IEkgaGF2ZSBub3cgcmVhZCB0
aGUgc2VudGVuY2UgYWdhaW4sIGFuZCB0aGUgcHJvYmxlbWF0aWMgd29yZGluZyBpcw0KPiAiZXhp
c3RpbmcgZGV2aWNlIGRyaXZlcnMiLiBJIGtub3cgaXQncyBub3QgdGhlIHNhbWUgYXMgImxlZ2Fj
eSBkZXZpY2UNCj4gZHJpdmVycyIsIGJ1dCBpdCBzdGlsbCBsZWF2ZXMgc29tZSBkb3VidCB3aGV0
aGVyICJmdXR1cmUgZGV2aWNlIGRyaXZlcnMiDQo+IHNob3VsZCBtYWtlIHVzZSBvZiBTV0lPVExC
LiBTbyBlaXRoZXIgcmVtb3ZlICJleGlzdGluZyIgb3IgYmUgbW9yZQ0KPiBleHBsaWNpdCBhbmQg
c2F5ICJleGlzdGluZyBhbmQgZnV0dXJlIGRldmljZSBkcml2ZXJzIi4gVGhlbiBpdCBzb3VuZHMN
Cj4gZmluZSB0byBtZS4NCj4gDQoNCkknbGwgcmVtb3ZlIHRoZSAiZXhpc3RpbmciIHF1YWxpZmll
ci4NCg0KTWljaGFlbA0K

