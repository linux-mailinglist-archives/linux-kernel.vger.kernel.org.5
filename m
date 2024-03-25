Return-Path: <linux-kernel+bounces-117887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5BD88B0DD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1871F61209
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 223CD3FE2E;
	Mon, 25 Mar 2024 20:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="XaRyDwJt"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2076.outbound.protection.outlook.com [40.92.19.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE9A2E3E0
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397214; cv=fail; b=shqSIHZzlrEnc10zu/aJFKbO9ozJkgZl32QH9fdREKat4ZZLiqzKStW75E73Eqrks5aynhZn8oW8+SdcmMqe+5qbyfNG1WiFKBMMOPoAJJHq4rVeKGO1Lb+o2liXEZe/UAdhnS3eWBezOsXSGHICUD1A7EbxrZs4aZVnTL8SmyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397214; c=relaxed/simple;
	bh=SUnwdSx/o7DsjDawa43e5SO98PkJTRyrmZvocziDx8U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gPaBDu8540gANfATTiAZ7fKotduMwjC422fgXluLLJLGf5ey+8MIHW0m+3bMPrkl7pkNW1D8PzcM4zlT1JlO+feQBEzJMySDPErGkBLBzaXipaDJYWG1FUG358qRKVbF7NunuEdlytUqGWh0+Un7fZft8Zcf2VnR0rhhkzD9USQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=XaRyDwJt; arc=fail smtp.client-ip=40.92.19.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DtQIkLOUSO4gh8UJlJB6HDpQF+MG0ovef2iDY58ENMkAg2hBW/qu+kYz2c+HcK7oOKhZc1tmZP3ETMBScjzvC3LoHK8h8+VAZ+gnUs0MAZb/QlfWA+wFrO0h8D0ZZFVnU7KGC++zPoZD+27RqQ+20YfAZZDbvyxrsw0a8zitL6GL5ERMMexC/YH8cLD3mhHBksG7GukzEZFk0vvsntRzM9zS0o9gEzmBlM+HIP2GjsSJVQ8eCvQ4iQ3ga92V/+34r/kjpDkq1EW+S7HDKlLFkR2TODQwe4cs4+OY0mcqvyF5LBlGJgCkbAbNQu5gFglKlg0nQvVIAQD2pvOMEKuqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUnwdSx/o7DsjDawa43e5SO98PkJTRyrmZvocziDx8U=;
 b=C8aP/sI64Ymm8ZmfYWaDKbfsFSOHHH5kr+LEoBkdtCHLiUxEAnj4pTg18dtEjb97j4/pm6zrb0gS5X0YGb7M7xoj5umXbgUIp4H9t4RQlAXSY1rEXV8NHS6jetQV6U5LYR+3SVzL0B2TRlsD91OTCTC3PSnjic/atlU0JDftXAgXRQ+m8pllAWCsXnbSpUai8ybwdlS5YvfI8xdiBRzKdFs2iJK8rg4/UzW+QqEcf7iqmF1HujJO+4YFOIgeRVXlROxsHKCqLpmCS5kMMofD6rMQyq6E3VVGdRDzNSsGyI33kcjjHwM/ERnzfAWZM00wgbIvl+yNn9Kc3UzQ66PLwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUnwdSx/o7DsjDawa43e5SO98PkJTRyrmZvocziDx8U=;
 b=XaRyDwJtB0z8QvZBylgHXgBRDQk4zqK92pyYRqbsy/j6I8gSBlBhB5lk3ob9bUC4kCtETSwvfb59WTE+irs1cDVl9boJRWXjCMgDRE8QmJfzgYjm5bKmA9/O6p4M90pCrIcUdfAF5CRWLC9ddsaD24T/UEeVoWDrktBG8Ex9Icv8bOd5aZW0A3Qq1DiCM0uLZmKt8xoV6PkZSFNmt45JraMukJrusQA3MmYsMp2wnMNmObw9HzPOIDFqwTQjN/In7jss6kCIHHN58I8EFu6xAqAYfl5meH+XN/su0JB9nQqgv9bfa4fNCcPKnF53dKqBYgDzhCqWsmO5M8Bm0LO7iA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BL3PR02MB8866.namprd02.prod.outlook.com (2603:10b6:208:3b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 20:06:50 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::1276:e87b:ae1:a596%5]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 20:06:50 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Xi Ruoyao <xry111@xry111.site>, Dave Hansen <dave.hansen@linux.intel.com>
CC: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
	"x86@kernel.org" <x86@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: RE: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Topic: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
Thread-Index: AQHafh5br9v5ziibjkOOzawG3mO/srFH4YWAgABehgCAAKA4MA==
Date: Mon, 25 Mar 2024 20:06:48 +0000
Message-ID:
 <SN6PR02MB4157E96FB6980EC52134C830D4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
	 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
 <c8dfca5f964701ce614d364ed7b18fa930aa2f61.camel@xry111.site>
In-Reply-To: <c8dfca5f964701ce614d364ed7b18fa930aa2f61.camel@xry111.site>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [2Yz8T+7gfZsq3jmZ/kTwOdke9UtN/ROE]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BL3PR02MB8866:EE_
x-ms-office365-filtering-correlation-id: 2660cfa3-3724-49f3-d31a-08dc4d071a99
x-ms-exchange-slblob-mailprops:
 WaIXnCbdHrNLYEJ5HghreUmTctoVX046w9EfOeOTF0wAI/HhF8c8nIjeuhb2swq71hDVP+TvcwAGBohrLqd1p0x2Sdxmh47D/ZH6nu0koBvTs3wgz6WiG/IHFgo+bLJMoILLWcRfnhM4nc8ldRoUv4XsPucrS8ZWEZQlwdm3rL8FkvYle/CMfMeImkfKl79hN0Fu2fc1c9e8z7akYtrMkaB2jcPXLR6e/3Z2mfwI2uCoujeiEyeifXBw4fn6TK9HDiutaz5c7DE+DgV7+AaKUHXcT4BEkutUw65km9klyRNpB5U8UNtw2+pgWPvwHn5Ew5zdXZ+5LEpclqjrr1QYouvqHoe6/4qibpERTGDEGNhEswF2zdyHqNXgOdXYQFFnsrG1Oy/2sKZHCBZsF/siWGb/LsnpNpfjJgU8TmMIsmmz1Nr9FFgbcMzNgqKy+IZmsusGqMn7STw3Cwz5iehKDXb9+9QsKo8av261J90rWDR5nh/bIMr2cUCFMBQujT/Xnh/nUh3ZWJ38+N15uYGVtR6Suw2V26/FKHIBxsQ//i/41gE3D5AIm8p7X90X/on4BKN+Cch8R5x+K8HFNterOsRN+mbMKdQsITgjwyWn1sCs5Wfp78VxHDIV8NO2r6bsckmnbAVHWjYpJ5cOOqixn30kHE6NJsyLpzbftc5VZp+qD2y54xAX1qgB6uM+gi1J3f81KLEDjrW8l92CAitUugh05SlPBZpIt8cqvq6dvi0ZjRq0bR0cLDzLWZ7v6opuKGK/GZF/y40=
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 CvtP69J8nbN0ilrt6yPyuxppHDUoYlzxakw2MBlzdhKztxDVZSCVJBqcy473YYcCO5vzjRlCkxr0irj0LGfnkJNugkVoIW2V3m/3lTJJwEn+ztCIUKfXvABVMfu7xBGlRYybhWdYz0Jc0qr6LaOrUXumpohd8t37H1gyuIXX02zKqqgPvJWoHODhv9H1XWhNpPZes3DQ8ycpxEvdTvPl9HC4wmsz2Wx0HTQAWPlKBkZhWItE8hiCejTN1XSuvksEayFD9nXx7DfomYRBrrY9xCe01lMQ/mcZz9oYknPQxH954/FSctuqi7UtCBLSKj5l+huwkejPn8N5Cjw8jge30UbHp0LQ40yfK6O8Kazle1iakwb6AhXWngqoB/NTo42c/0i8t50NYN8TQongyZ9ZDiLmpBwiEMqzengf8jCGHDIRxiZWZN294nGG3E0zTVhlKLkTWYwsf3X8HUqU3+ykodLwvjaeYX9YksGqg+5BSlUOFaBVU3vZ/XctorLKXDuUXC+2jMdsgDQ3qGXL6SvPRvdjJ66p/1fKD5V+NdPLtyslNLNOV7bw4CvfunOB6tXu
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?alVvOHNuUHlxQ2JuZnpOaVJYNUlsdXVkc3VxSTVUQ2hZUHdJQUNLK3VWTWha?=
 =?utf-8?B?b0ZoNGtOVkU0aWlYdk5ZcUtCWUdMejlsK1BJUHNncTZPMkRZYXRjUUJkNzRD?=
 =?utf-8?B?aEdqcDZraHlNekpLTWRnTnVQSEsyME1KL1ZXajEwSTNhUDdQS0x3MkI5Z3FX?=
 =?utf-8?B?SUhaQmRJakNJWjdvemtwUzBLcG1pOVZ3M09WZ2x1QWpvVDdGUkFCUm0yQTB5?=
 =?utf-8?B?OEZ6cDJ0V0pRM0luS0lmR2xsaDRxaWRoMy9nTDR0RWtDODlCTUF3RTVzMTVP?=
 =?utf-8?B?ZlhuMk9yRlFFd2R4UEs2NEhXdTdocXhyK0FHVzhYbEZBQWlDaXQreGZ3dkNY?=
 =?utf-8?B?b1pyU29nWkswaVFsZUxIcnVpN2Vzb1FIR0daV0tsWVdzMk9TeVl4NjBpeUI4?=
 =?utf-8?B?eWVLbzVGQzgzUlpRaGxCTmhERm8zcUJ3MXFWQkNJTHNqbHAxVkZvKzVySkgy?=
 =?utf-8?B?ZWdpcWZ0ZXArVUkxeG9LS3VFL3d4UVBRbWNkeGRDY05wMVZxdEJlU2YwckNO?=
 =?utf-8?B?WHJyenpLUlN0SEYzU21qV1ZUckc4L3p1Y0p2bGl6YjV6eE4zYlNZYW1iRG1Y?=
 =?utf-8?B?WjR2Z0hFR2NlTkdaWEIrVUhqMVN3Mi9hOG5USTFOREpEZEMxdmEvTWN2T2RZ?=
 =?utf-8?B?K1hGbzhBY1NDUW01blVmWWhyQmtNWGdCRE55Ukk3WkVxdHdqV1pzdlRmU1c2?=
 =?utf-8?B?clh1dU1DdklzVFIrTm16NUlUOVozN0ZqNElUMklpanY0dElUYm9IelRHYUlU?=
 =?utf-8?B?OUIvWHZpZFJpNWlJZEJmcHFyUFFUR3NOZjI0ZG8rMGNkTldqNTVENmtWbkNE?=
 =?utf-8?B?aHFnRkh2S0lzOHBDZlhUNDNFTDZUNXNQYkMwVHRiTFZpYU1lMHRwVEkxSVlE?=
 =?utf-8?B?YllWUFBtdDJXL0VCa2prSHdYQ2dVa2htYnpaZ0FTVDBUbmNQN21hZmxvdTd3?=
 =?utf-8?B?VWhkS1RBZ3EzRTF1N1VjaUhZN0tVbGp3aTdjUmNJaWpjclQ2dDNMdmd6Zk1s?=
 =?utf-8?B?eGlrS0Q0ajlSN2xxUTVBREhCZ2xCL0hsdTA1TjdUaFZaYmxCTDJLYUQyY0wz?=
 =?utf-8?B?MmIvMHQvbWQ5RGRPVm01b3duM3duTUozd2lOZmUwdW5UTzBCSElYTGZ4a1Nz?=
 =?utf-8?B?RUxqTjJGMTRGdjFqTkNYVXFwdXpoLytsQ2I1QUV5eElucm04VTRxMnM1RHo5?=
 =?utf-8?B?bTN5RW1MeFhuMkQ2NW8zSjVZanhqWncxNWdBZ3hvNGU2azROQTVDVU9DWCtU?=
 =?utf-8?B?Z3ZweFpHRGFQZTkrNHp2NFAxTGlIR1U1anhMV1FjUm5MdnpqbUZXR0VQT3JU?=
 =?utf-8?B?b1k3elE2UHNpZkdhSEUzOGNITUhGb2Y4dG4wZDNlN3V1RTh1alBxQWJtV0Jm?=
 =?utf-8?B?UEI0Ty9LVjNIQ21kZHZCSDhyN3FuYlBQV1RGYWVHSUs5bzY4MW84SjFERDVZ?=
 =?utf-8?B?ZytIZ2JZQkFsdEppUG9LSFkreVRYUExrdlVOSlZSSCtucnVJZXlpV284MVVE?=
 =?utf-8?B?blBRVi9SZklNRnFralBIcjlGcHcydjZQWkhYZkNiZXdJeVNZRHREMEFaSnRP?=
 =?utf-8?B?cCsvRlc5Rkl3VHkwM3BER0RYVnhkYmZ2UFlDTWhXV2Jodm4zLzNZMVZJMGJ5?=
 =?utf-8?B?Z0piaVdONU1KUEcxQzNFUkxlc3l2WFE9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2660cfa3-3724-49f3-d31a-08dc4d071a99
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 20:06:48.6052
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR02MB8866

RnJvbTogWGkgUnVveWFvIDx4cnkxMTFAeHJ5MTExLnNpdGU+IFNlbnQ6IE1vbmRheSwgTWFyY2gg
MjUsIDIwMjQgMzoyMSBBTQ0KPiANCj4gT24gTW9uLCAyMDI0LTAzLTI1IGF0IDA0OjU3ICswMDAw
LCBNaWNoYWVsIEtlbGxleSB3cm90ZToNCj4gPiBGcm9tOiBYaSBSdW95YW8gPHhyeTExMUB4cnkx
MTEuc2l0ZT4gU2VudDogU3VuZGF5LCBNYXJjaCAyNCwgMjAyNA0KPiAxMjowNSBQTQ0KPiA+ID4N
Cj4gPiA+IFBlciB0aGUgIlByb2Nlc3NvciBTcGVjaWZpY2F0aW9uIFVwZGF0ZSIgZG9jdW1lbnRh
dGlvbnMgcmVmZXJyZWQgYnkgdGhlDQo+ID4gPiBpbnRlbC1taWNyb2NvZGUtMjAyNDAzMTIgcmVs
ZWFzZSBub3RlLCB0aGlzIG1pY3JvY29kZSByZWxlYXNlIGhhcyBmaXhlZA0KPiA+ID4gdGhlIGlz
c3VlIGZvciBhbGwgYWZmZWN0ZWQgbW9kZWxzLg0KPiA+ID4NCj4gPiA+IFNvIGRvbid0IGRpc2Fi
bGUgSU5WTFBHIGlmIHRoZSBtaWNyb2NvZGUgaXMgbmV3IGVub3VnaC4NCj4gPiA+DQo+ID4gPiBD
YzogRGF2ZSBIYW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNpZ25l
ZC1vZmYtYnk6IFhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRlPg0KPiA+ID4gLS0tDQo+ID4g
PiDCoGFyY2gveDg2L21tL2luaXQuYyB8IDMyICsrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tDQo+ID4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAyMCBpbnNlcnRpb25zKCspLCAxMiBkZWxldGlv
bnMoLSkNCj4gPiA+DQo+ID4gPiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvbW0vaW5pdC5jIGIvYXJj
aC94ODYvbW0vaW5pdC5jDQo+ID4gPiBpbmRleCA2Nzk4OTNlYTVlNjguLmM1MmJlNGU2NmU0NCAx
MDA2NDQNCj4gPiA+IC0tLSBhL2FyY2gveDg2L21tL2luaXQuYw0KPiA+ID4gKysrIGIvYXJjaC94
ODYvbW0vaW5pdC5jDQo+ID4gPiBAQCAtMjYxLDMzICsyNjEsNDEgQEAgc3RhdGljIHZvaWQgX19p
bml0IHByb2JlX3BhZ2Vfc2l6ZV9tYXNrKHZvaWQpDQo+ID4gPiDCoAl9DQo+ID4gPiDCoH0NCj4g
PiA+DQo+ID4gPiAtI2RlZmluZSBJTlRFTF9NQVRDSChfbW9kZWwpIHsgLnZlbmRvcsKgID0gWDg2
X1ZFTkRPUl9JTlRFTCwJXA0KPiA+ID4gLQkJCcKgwqDCoMKgwqAgLmZhbWlsecKgID0gNiwJCQlc
DQo+ID4gPiAtCQkJwqDCoMKgwqDCoCAubW9kZWwgPSBfbW9kZWwsCQkJXA0KPiA+ID4gLQkJCcKg
wqDCoCB9DQo+ID4gPiArI2RlZmluZSBJTlRFTF9NQVRDSChfbW9kZWwsIF9maXhlZF9taWNyb2Nv
ZGUpCVwNCj4gPiA+ICvCoMKgwqAgeyAudmVuZG9yCQk9IFg4Nl9WRU5ET1JfSU5URUwsCVwNCj4g
PiA+ICvCoMKgwqDCoMKgIC5mYW1pbHkJCT0gNiwJCQlcDQo+ID4gPiArwqDCoMKgwqDCoCAubW9k
ZWwJCT0gX21vZGVsLAkJXA0KPiA+ID4gK8KgwqDCoMKgwqAgLmRyaXZlcl9kYXRhCT0gX2ZpeGVk
X21pY3JvY29kZSwJXA0KPiA+ID4gK8KgwqDCoCB9DQo+ID4gPiArDQo+ID4gPiDCoC8qDQo+ID4g
PiDCoCAqIElOVkxQRyBtYXkgbm90IHByb3Blcmx5IGZsdXNoIEdsb2JhbCBlbnRyaWVzDQo+ID4g
PiAtICogb24gdGhlc2UgQ1BVcyB3aGVuIFBDSURzIGFyZSBlbmFibGVkLg0KPiA+ID4gKyAqIG9u
IHRoZXNlIENQVXMgd2hlbiBQQ0lEcyBhcmUgZW5hYmxlZCBhbmQgdGhlDQo+ID4gPiArICogbWlj
cm9jb2RlIGlzIG5vdCB1cGRhdGVkIHRvIGZpeCB0aGUgaXNzdWUuDQo+ID4gPiDCoCAqLw0KPiA+
ID4gwqBzdGF0aWMgY29uc3Qgc3RydWN0IHg4Nl9jcHVfaWQgaW52bHBnX21pc3NfaWRzW10gPSB7
DQo+ID4gPiAtCUlOVEVMX01BVENIKElOVEVMX0ZBTTZfQUxERVJMQUtFwqDCoCApLA0KPiA+ID4g
LQlJTlRFTF9NQVRDSChJTlRFTF9GQU02X0FMREVSTEFLRV9MICksDQo+ID4gPiAtCUlOVEVMX01B
VENIKElOVEVMX0ZBTTZfQVRPTV9HUkFDRU1PTlQgKSwNCj4gPiA+IC0JSU5URUxfTUFUQ0goSU5U
RUxfRkFNNl9SQVBUT1JMQUtFwqAgKSwNCj4gPiA+IC0JSU5URUxfTUFUQ0goSU5URUxfRkFNNl9S
QVBUT1JMQUtFX1ApLA0KPiA+ID4gLQlJTlRFTF9NQVRDSChJTlRFTF9GQU02X1JBUFRPUkxBS0Vf
UyksDQo+ID4gPiArCUlOVEVMX01BVENIKElOVEVMX0ZBTTZfQUxERVJMQUtFLAkweDM0KSwNCj4g
PiA+ICsJSU5URUxfTUFUQ0goSU5URUxfRkFNNl9BTERFUkxBS0VfTCwJMHg0MzIpLA0KPiA+ID4g
KwlJTlRFTF9NQVRDSChJTlRFTF9GQU02X0FUT01fR1JBQ0VNT05ULAkweDE1KSwNCj4gPiA+ICsJ
SU5URUxfTUFUQ0goSU5URUxfRkFNNl9SQVBUT1JMQUtFLAkweDEyMiksDQo+ID4gPiArCUlOVEVM
X01BVENIKElOVEVMX0ZBTTZfUkFQVE9STEFLRV9QLAkweDQxMjEpLA0KPiA+ID4gKwlJTlRFTF9N
QVRDSChJTlRFTF9GQU02X1JBUFRPUkxBS0VfUywJMHgzNCksDQo+ID4gPiDCoAl7fQ0KPiA+ID4g
wqB9Ow0KPiA+ID4NCj4gPiA+IMKgc3RhdGljIHZvaWQgc2V0dXBfcGNpZCh2b2lkKQ0KPiA+ID4g
wqB7DQo+ID4gPiArCWNvbnN0IHN0cnVjdCB4ODZfY3B1X2lkICppbnZscGdfbWlzc19tYXRjaDsN
Cj4gPiA+ICsNCj4gPiA+IMKgCWlmICghSVNfRU5BQkxFRChDT05GSUdfWDg2XzY0KSkNCj4gPiA+
IMKgCQlyZXR1cm47DQo+ID4gPg0KPiA+ID4gwqAJaWYgKCFib290X2NwdV9oYXMoWDg2X0ZFQVRV
UkVfUENJRCkpDQo+ID4gPiDCoAkJcmV0dXJuOw0KPiA+ID4NCj4gPiA+IC0JaWYgKHg4Nl9tYXRj
aF9jcHUoaW52bHBnX21pc3NfaWRzKSkgew0KPiA+ID4gKwlpbnZscGdfbWlzc19tYXRjaCA9IHg4
Nl9tYXRjaF9jcHUoaW52bHBnX21pc3NfaWRzKTsNCj4gPiA+ICsJaWYgKGludmxwZ19taXNzX21h
dGNoICYmDQo+ID4gPiArCcKgwqDCoCBpbnZscGdfbWlzc19tYXRjaC0+ZHJpdmVyX2RhdGEgPiBi
b290X2NwdV9kYXRhLm1pY3JvY29kZSkgew0KPiA+ID4gwqAJCXByX2luZm8oIkluY29tcGxldGUg
Z2xvYmFsIGZsdXNoZXMsIGRpc2FibGluZyBQQ0lEIik7DQo+ID4gPiDCoAkJc2V0dXBfY2xlYXJf
Y3B1X2NhcChYODZfRkVBVFVSRV9QQ0lEKTsNCj4gPiA+IMKgCQlyZXR1cm47DQo+ID4NCj4gPiBB
cyBub3RlZCBpbiBzaW1pbGFyIHBsYWNlcyB3aGVyZSBtaWNyb2NvZGUgdmVyc2lvbnMgYXJlDQo+
ID4gY2hlY2tlZCwgaHlwZXJ2aXNvcnMgb2Z0ZW4gbGllIHRvIGd1ZXN0cyBhYm91dCBtaWNyb2Nv
ZGUgdmVyc2lvbnMuDQo+ID4gRm9yIGV4YW1wbGUsIHNlZSBjb21tZW50cyBpbiBiYWRfc3BlY3Ry
ZV9taWNyb2NvZGUoKS7CoCBJDQo+ID4ga25vdyBIeXBlci1WIGd1ZXN0cyBhbHdheXMgc2VlIHRo
ZSBtaWNyb2NvZGUgdmVyc2lvbiBhcw0KPiA+IDB4RkZGRkZGRkYgKG1heCB1MzIgdmFsdWUpLsKg
IFNvIGluIGEgSHlwZXItViBndWVzdCB0aGUgYWJvdmUNCj4gPiBjb2RlIHdpbGwgYWx3YXlzIGxl
YXZlIFBDSUQgZW5hYmxlZC4NCj4gPg0KPiA+IE1heWJlIHRoZSBhYm92ZSBzaG91bGQgaGF2ZSBh
IGNoZWNrIGZvciBydW5uaW5nIG9uIGENCj4gPiBoeXBlcnZpc29yIGFuZCBhbHdheXMgZGlzYWJs
ZSBQQ0lEIHdpdGhvdXQgY2hlY2tpbmcgdGhlDQo+ID4gbWljcm9jb2RlIHZlcnNpb24uwqAgVGhh
dCdzIHRoZSBzYWZlIGFwcHJvYWNoLCB0aG91Z2ggdGhlcmUgYXJlDQo+ID4gb3RoZXIgc2ltaWxh
ciBjYXNlcyBsaWtlIGJhZF9zcGVjdHJlX21pY3JvY29kZSgpIHRoYXQgdGFrZQ0KPiA+IHRoZSB1
bnNhZmUgYXBwcm9hY2ggd2hlbiBydW5uaW5nIGFzIGEgZ3Vlc3QuwqAgSSBkb24ndCBrbm93DQo+
ID4gd2hhdCdzIGJlc3QgaGVyZSAuLi4uLg0KPiANCj4gVGhlbiBnZW5lcmFsbHkgbWF5YmUgd2Ug
c2hvdWxkIHNldCBib290X2NwdV9kYXRhLm1pY3JvY29kZSB0byAwIGlmIGENCj4gaHlwZXJ2aXNv
ciBpcyBkZXRlY3RlZD8gIE9yIGNoZWNraW5nIGFnYWluc3QgaHlwZXJ2aXNvcnMgYXQgZXZlcnkg
cGxhY2UNCj4gd2hlcmUgd2UgY2hlY2sgdGhlIG1pY3JvY29kZSByZXZpc2lvbiB3aWxsIGJlIG5h
c3R5Lg0KDQpJIGhhdmVuJ3QgZG9uZSBhIGNvbXBsZXRlIGNlbnN1cywgYnV0IHRoZXJlIGRvbid0
IHNlZW0gdG8gYmUNCnRoYXQgbWFueSBwbGFjZXMgaW4geDg2IGNvZGUgd2hlcmUgdGhlIG1pY3Jv
Y29kZSB2ZXJzaW9uIGlzDQpjaGVja2VkLiBTZXZlcmFsIChtb3N0PykgYWxyZWFkeSBoYXZlIHNv
bWUga2luZCBvZiAib3V0IiB3aGVuDQpydW5uaW5nIG9uIGEgaHlwZXJ2aXNvciAtLSBsaWtlIGJh
ZF9zcGVjdHJlX21pY3JvY29kZSgpLCBhbmQNCmFwaWNfdmFsaWRhdGVfZGVhZGxpbmVfdGltZXIo
KS4NCg0KSSd2ZSBjb21tZW50ZWQgYWJvdmUgb24gd2hhdCBIeXBlci1WIGRvZXMsIGJ1dCBJIGRv
bid0IGtub3cNCndoYXQgb3RoZXIgaHlwZXJ2aXNvcnMgZG8uICBUaGUgY29tbWVudCBpbiBiYWRf
c3BlY3RyZV9taWNyb2NvZGUoKQ0Kc2VlbXMgdG8gaW1wbHkgdGhhdCB0aGUgcHJvYmxlbSBpcyB3
aWRlc3ByZWFkLCBhbmQgcGVyaGFwcw0Kbm90IGp1c3QgYSBIeXBlci1WIHRoaW5nLiAgQnV0IEkg
ZG9u4oCZdCBrbm93IHRoYXQgZm9yIHN1cmUuICBJZiB3ZQ0Kc2V0IGJvb3RfY3B1X2RhdGEubWlj
cm9jb2RlIHRvIDAsIHdlJ2xsIG5lZWQgdG8gcmVhc29uIGFib3V0DQp0aGUgaW1wbGljYXRpb25z
IGJlY2F1c2UgdGhhdCB3aWxsIGNlcnRhaW5seSBmbGlwIHRoZSBvdXRjb21lIG9mDQphbnkgY29t
cGFyaXNvbnMgZm9yIEh5cGVyLVYgZ3Vlc3RzIGFuZCBwZXJoYXBzIG90aGVyDQpoeXBlcnZpc29y
IGd1ZXN0cyBhcyB3ZWxsLg0KDQo+IA0KPiBBbmQgSSdkIHByZWZlciB0aGV5IHNheSAwIGluc3Rl
YWQgaWYgMHhmZmZmZmZmZnUgaWYgdGhleSBtdXN0IGxpZSBhYm91dA0KPiB0aGUgbWljcm9jb2Rl
IHJldmlzaW9uLg0KDQpJIGRvbid0IGtub3cuICBBdCBsZWFzdCBmb3IgSHlwZXItViwgdGhhdCBz
aGlwIGhhcyBzYWlsZWQuICBJIGRvbid0DQpoYXZlIGEgd2F5IHRvIGdldCBIeXBlci1WIHRvIG1h
a2UgYSBjaGFuZ2UuICBNYWtpbmcgYSBjaGFuZ2UNCndvdWxkIGFsc28gaW50cm9kdWNlIGEgYmFj
a3dhcmQgY29tcGF0aWJpbGl0eSBwcm9ibGVtIHRoYXQgY2FuJ3QNCmVhc2lseSBiZSBoYW5kbGVk
Lg0KDQpNaWNoYWVsDQoNCj4gDQo+IC0tDQo+IFhpIFJ1b3lhbyA8eHJ5MTExQHhyeTExMS5zaXRl
Pg0KPiBTY2hvb2wgb2YgQWVyb3NwYWNlIFNjaWVuY2UgYW5kIFRlY2hub2xvZ3ksIFhpZGlhbiBV
bml2ZXJzaXR5DQo=

