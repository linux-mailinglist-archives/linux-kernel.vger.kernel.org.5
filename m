Return-Path: <linux-kernel+bounces-79504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D40486235A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 08:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B68CFB238FC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 07:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26386171CD;
	Sat, 24 Feb 2024 07:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="gZW4Rs7K"
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-mr2fra01on2113.outbound.protection.outlook.com [40.107.9.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B810A28;
	Sat, 24 Feb 2024 07:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.9.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708760447; cv=fail; b=VY8nVZKVt9OhaIgiLxFN2dWI40bvL2/dW+t1ScA+FOkj3Ki8DzOOGC9J/KmAEhTMOLBzaAoxL5q+mQIlqoH7Eyi5agte9GZnklJk3cQrGhGnoBM5FI8e3xRR4pHExDEKJRlN4f6epYBdOqlqSpWN5rERHpCWHvGqnvdIapIRHTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708760447; c=relaxed/simple;
	bh=IQGIem9nCKK/IplvGYsbij2aClTpB2owU8QJSpgjX4E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h5a/55u+USEsKoxeNMK4vGR7EyQbLxN06Z+17NI2uyJ+WMj+MAgmNuxPL06UUeW6JiNmOFJf4LPHxKv6/x7p8PskY56UxxcWsbGAMI3fOZo+8wIfdSz16bGy+AnwUrFdwObBC3EzgRfDWBTr4wqz6YGD4zpR/AZXw+H8iRDQ+fM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=gZW4Rs7K; arc=fail smtp.client-ip=40.107.9.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9Yn7cHaem1GOrnyWb1fzLZ/a/xOCZcwW1jAg4Vm135PNiCFloJe4N8HYR318SdN/MGOATvFZmVNI+akqbXzP8zq+CY10jMRbLUO03tx8pytqQKasrqJIgrB2wH0ox/Vv4ql7sgLqXcfZog4YW+mk34Wx3B8K8VmDuv6oHJ94XQClPLpi9Q3hTXpcLvV1IQt5VfH5ycKaBBnW+Nwgprduy087Mwnw1OIazwT6sVNXdJDLFYsoDJmGBUGibOlIa0hwYSgZHJ1HY4seHkU9DvA/QVNvxSkI/JySi4VWAhDA6bO+p+m0i+LC3ERhlNNZ2uFZ9HfOL2at/QhOhTFTg2Gcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IQGIem9nCKK/IplvGYsbij2aClTpB2owU8QJSpgjX4E=;
 b=Fq6HeGKe3Aqbqy7eAM0+8Nu6U4nVTaBzQL6YcfgHt+IFRtZNCsIgX40NHkM+w4ZNP2OO/uWqKUWyLqyGVOUitycEQqdgx6xmUzXi8ZFjiDwf9XUy/pV4FA3scz6qm03L1YQDmznUeVE/3ENs0BacTWPlTxAxhCk4Vv+Zt8mxsggCKXsS5HeoTi51xC/O8/ARds8wwIdaUue1mGJmYyHRdF9E+ZY9Q8f+AM2BczQDnTR5T4gA6Q3eunxR9xZs8AqwFPxen7PkZcvPprAqX1y/zeEs3hcfyAqk1pZsObF52jkuIJV2jR/vyfRJY1Hnquy2/2qPjqsBdX2dYENTUzeKYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IQGIem9nCKK/IplvGYsbij2aClTpB2owU8QJSpgjX4E=;
 b=gZW4Rs7KSyXkXU2968MOBKcceXLa1UaY/+oLVHBVRsJl5wz/j/VMkCpuKXUXDr69jWmtsa+u6mt+u3wQWiSIYiSHHzJ4VUkEBY0eT1Zmfg2r1puFvFO6Hrj6fnxMQJDum9gyJ9t7EhbsMrvNybAC1K4biZvTnpkMhkEkcSpYg+DCI85TUN7R5sRLmHbWXMEDlbE+c+48VTH9aX+35dCwPzUWGqiCRJbohvFOaK4n93g/gHWzjwKIgb4oqyQ14tqO4KSFrE2ZS9Hp5Y9CxG2jfaZ1HQPhbZo/SNakvyjrTMtDa0C6m7bf32MmQbavRUs/w+Z/s3tsXZeF2tBy1Ki93w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3396.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:21::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.27; Sat, 24 Feb
 2024 07:40:41 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::46af:917d:3bb2:167e%6]) with mapi id 15.20.7316.023; Sat, 24 Feb 2024
 07:40:41 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Charlie Jenkins <charlie@rivosinc.com>
CC: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Guenter Roeck
	<linux@roeck-us.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Erhard Furtner
	<erhard_f@mailbox.org>
Subject: Re: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Topic: [PATCH net] kunit: Fix again checksum tests on big endian CPUs
Thread-Index: AQHaZkTy9Xv+fOXXx0O2ApyFNqZzw7EYNxcAgAAE3wCAAB7egIAAwikA
Date: Sat, 24 Feb 2024 07:40:41 +0000
Message-ID: <8eed6488-87c0-49a9-b030-d22b4a698356@csgroup.eu>
References:
 <73df3a9e95c2179119398ad1b4c84cdacbd8dfb6.1708684443.git.christophe.leroy@csgroup.eu>
 <Zdjcnp324nIRuyUI@ghost> <66402663-98dd-42a2-aa04-5f04cb76b147@csgroup.eu>
 <Zdj6mebHlbIq8u2o@ghost>
In-Reply-To: <Zdj6mebHlbIq8u2o@ghost>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3396:EE_
x-ms-office365-filtering-correlation-id: aa41703f-7080-4fcb-9b2e-08dc350be6da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3JbPNgTO1UCrydzMH1mszW76vprJJnyTRxGyehRd/LHEft4IZDyx3t1+9lOuoc2rN96k9Qc0JqfqFkn9wMvjGcFmuBV4U3UVuwWDlnwseaxBhhrplQupUyGR3XWVDLXR7Zjnjxti/xbGKrhk4DyuKmYmOTQivbafgGDiQ6i5nYAF/YoJ/QfBME93dlnrjndeTHKglpnTn9bOVFODIRUDf8Gm9DoyVVawHRGRN+7ijQBdy5PUesDZbVGS/skRBa6QP0dfRjdgqHpJirnz6yL/eUMvGuhoqEsvH4FdK7ltK4RFC4+/0LLA+LUT2VtgKM9DSZ33Um7m/pC8zVt6JsObvIVF43g6DxjUEGXAqaIdCnnwROGpRc0HPxNTJh6I/RhLqB8CwG0Ixk83meRAmuVkV4NF640HqaS/Rat4eD0OlaemZjLpEvABeu4wCUZ4exkuYG7gg35vJnMcMtD0veYTCUq1qiLKn+e+/2DSy4ZvZY/SwbsL/a9JKIcH6HPwVrwHBkAhnNp9oOPCKviQ/qQ+sChXbLJAOV2S6Xkpj6NFurVc6Da4okN7sm5bOBdp0hVkFO1S8jl+Yay6njtkgafUeBuIrzBu7EcsZq8Sq1XdhUE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Z2dCWDBoZ2ltbHY5alVpL25vdEh5M3hVWkNVSVczQ09CdE53Q2Q1NEZJRTNO?=
 =?utf-8?B?R05zV0lpU21SN2U2aE5hMlFXenhub2JHOGlFUHJjY0JMSmFmelRKeEVlUHZH?=
 =?utf-8?B?NUlpbm9zdlJXV29zYW56VStkdTNiVDA0YlBJZS9YdkhKK2dsbGE1U0RNaE96?=
 =?utf-8?B?c0VRcWhoblJoWWZNclpDaFZlbkMwc1EzcVVsaTdhdzNjNS9aV1pIYWFzTzVp?=
 =?utf-8?B?UENRN0s1QWtkWUJxNWtzZUY1Q0FoR0tCNHdYei96NGZKMmZYbnIxRmJFTkhM?=
 =?utf-8?B?UW00S0VtcEwra3U4K1NXWjFpM0QrNFBNUXlUaCtJcUVOcXgyNlp5NVZYT0N0?=
 =?utf-8?B?ekt1bVJhOXNGbUJzaUdCdWx2STRjSUQvSEtLSEhCZUNlcHNGdURzalRTU1Z3?=
 =?utf-8?B?VWNSbWl5ZDlCV0t5c1FBYWZKeDVFRy8xMTRtQ2hGRUhNWVptMFZ1Q052bEYx?=
 =?utf-8?B?Q1MwMkpZbWxQak1kOU0rbGdyY0huWFdqTGFmSW55a0lJMCtCV1VKdENnc2NP?=
 =?utf-8?B?QTg5Y3pDOEFIUU9SRVczTkE2MEJnN2hmY29NZWlpamhJUlJSaUdXUkJsZzdk?=
 =?utf-8?B?Q3pKOFhCQzVMTkhGbW1UR0dteWljTTgrUkRpcGJhaFZwbE43MVdFNFdnVDVt?=
 =?utf-8?B?d1BJQzNlSGFDREF3ZElDV2JvRkg0VnlXZ2JmV0hJZk5yZm9TWmlCRnlacjky?=
 =?utf-8?B?TVZha3haSWhsK1prYXYrQlZWNk9xZ3lxY1h5ZWM2MDNWU0ZIdUlQTGdQVVln?=
 =?utf-8?B?cG9rRlJHODdXa1lzYjNqakUrZE1FUHRSdVd0dmc3alFyMXlpUmg1Qkt0N2lG?=
 =?utf-8?B?QnlYNHpqS0pqVWhtS3FiSHUrbllHaTA1OHZ4UFhDem9yWVJEWHZYRUo3VDhY?=
 =?utf-8?B?aHVQLzVMYThWRkNQbElWSytBQ1dkZzZHMHlLMVpTVEV0b2Z0Z0FJUnR4ajZa?=
 =?utf-8?B?YjhvaVlzN2ZSSU8ybGpITnQ0MlpzMTBXZE0zTitJWUZ2eU5yMWUwK05VQ2xt?=
 =?utf-8?B?Nk96SzZWenQ2emJkYnlHd2gxUVVtVk5TSW42UnpZMG51MllPMER4NUlxRDhG?=
 =?utf-8?B?WDFyV3YwWmM1QVVqMWZPbHU2Sjd5ejRMMFg1NFIzWVdSdmRHSUhpQk9LUXFw?=
 =?utf-8?B?VmRSdW5SaDM1OVphQXRoVHZZSUNGS2U4YklCVit6M2hhWTdZT2dnSVQ0UXFx?=
 =?utf-8?B?VjVyRDZjVWJSbE10Tk5jL1I2UEpuZXg0dmwvcjZ0Rk5FRW14QU5tMTBIRGlk?=
 =?utf-8?B?WlNKTHFTTzlMNzFaUDgwSGdqUjQ3c2ZySElYWVBtdEJROUdhTURSOUtZQVdL?=
 =?utf-8?B?UG9qVHVKajh0L3RoVkg3N1NvVUdNN0toU3ZGcStwRjNUaUpIUFZ3UzAzUEhG?=
 =?utf-8?B?VFFEYklVdnVnaUhlRU83TmY3MW9xOEFONjVSV1NzUkZ5ODZ2MzB4SkFZM0Vx?=
 =?utf-8?B?elF3WEpRVGtpWFBVUU9CNC85YjhYNU54M3htM3MxR3k4VkFlOEhOU1MveDdx?=
 =?utf-8?B?b3BUbU1udG5jd3pzSWVSVWhnaFFhN2t5Y0t0ZlFoYjRSR2dzdzVMd1NnWGNl?=
 =?utf-8?B?YzFMWCthdFZzeWlVaEFzci83ZnFrN3NFbmxVL0RzRkVaUWNJYll6YTJkOUtR?=
 =?utf-8?B?dGRKR3d3clo3QUJpSWI0OHZvdGp0NE5zZU9TbCtDaEg3dUU4cWZZd2Z1WTVJ?=
 =?utf-8?B?cVhsT2ZYQkJJc2t5VlhFR1NHL3NMTlBBVXJQaWNjdS80V3AyYmhmTTZCeGxs?=
 =?utf-8?B?MUJsQTZISXdUUHVsbU9EajRETENMcWZ5Y0EwWGhpSWJhajIrZUFHajY4VkIv?=
 =?utf-8?B?Rnc2cUk2V0ZXdDVNK2RobUp5bzZtKzc3VFM1WnZFdzJqTitMMUMrQmVVcW1U?=
 =?utf-8?B?SndQY09xU1dlN2VuWDM2bnZFTHpibEJGVFFxRGgzQlJxK1FhVEIzOGF2bStE?=
 =?utf-8?B?SXdPbUdzcUE5K1FvaHFVK005UHpNeXQ1Z3FNTXAyREJUWjBOOGZmRmhveVdT?=
 =?utf-8?B?MUhhNG9GSDMwM2tTWFpaZmc3SHZCS0NLWVpzVEVyL1lpb050UU1KOFU3N3pX?=
 =?utf-8?B?L2lwV2R0K0lLamU3M0tTSmtmdGtXK05UUmFLV2ZDb1FrWXJaV0RpUG1DQUpq?=
 =?utf-8?B?R0JBV2wxampGQVJVKzBrM1g1UTlpSzQ2YXFKOERUWURxVkVSdTFsTlNNeW5T?=
 =?utf-8?B?Zk5nNTF1d2lHN25sVldFNmlmSEVWcW1YNmtuNWUyRUhqNXRJSlBBWWxCNmV6?=
 =?utf-8?B?MThsYitiOE5EYUI4WVlGamYwMktnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E468E35D75CEEC4DA3FE3B9704953FFB@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: aa41703f-7080-4fcb-9b2e-08dc350be6da
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2024 07:40:41.3380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlGXF0RgcoMY5BxCCw1GYkrb6l0kQhq6Ed/fVkwXcE/+85Sa1nyOPx/DWubIpWxAGY3zR2ZdUphrKo/uzHqKHVhaMPfz+v0hVQCnSxPx/xo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3396

DQoNCkxlIDIzLzAyLzIwMjQgw6AgMjE6MDUsIENoYXJsaWUgSmVua2lucyBhIMOpY3JpdMKgOg0K
PiBPbiBGcmksIEZlYiAyMywgMjAyNCBhdCAwNjoxNToxNlBNICswMDAwLCBDaHJpc3RvcGhlIExl
cm95IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAyMy8wMi8yMDI0IMOgIDE4OjU3LCBDaGFybGllIEpl
bmtpbnMgYSDDqWNyaXTCoDoNCj4+PiBPbiBGcmksIEZlYiAyMywgMjAyNCBhdCAxMTo0MTo1MkFN
ICswMTAwLCBDaHJpc3RvcGhlIExlcm95IHdyb3RlOg0KPj4+PiBDb21taXQgYjM4NDYwYmM0NjNj
ICgia3VuaXQ6IEZpeCBjaGVja3N1bSB0ZXN0cyBvbiBiaWcgZW5kaWFuIENQVXMiKQ0KPj4+PiBm
aXhlZCBlbmRpYW5uZXNzIGlzc3VlcyB3aXRoIGt1bml0IGNoZWNrc3VtIHRlc3RzLCBidXQgdGhl
bg0KPj4+PiBjb21taXQgNmY0YzQ1Y2JjYjAwICgia3VuaXQ6IEFkZCB0ZXN0cyBmb3IgY3N1bV9p
cHY2X21hZ2ljIGFuZA0KPj4+PiBpcF9mYXN0X2NzdW0iKSBpbnRyb2R1Y2VkIG5ldyBpc3N1ZXMg
b24gYmlnIGVuZGlhbiBDUFVzLiBUaG9zZSBpc3N1ZXMNCj4+Pj4gYXJlIG9uY2UgYWdhaW4gcmVm
bGVjdGVkIGJ5IHRoZSB3YXJuaW5ncyByZXBvcnRlZCBieSBzcGFyc2UuDQo+Pj4+DQo+Pj4+IFNv
LCBmaXggdGhlbSB3aXRoIHRoZSBzYW1lIGFwcHJvYWNoLCBwZXJmb3JtIHByb3BlciBjb252ZXJz
aW9uIGluDQo+Pj4+IG9yZGVyIHRvIHN1cHBvcnQgYm90aCBsaXR0bGUgYW5kIGJpZyBlbmRpYW4g
Q1BVcy4gT25jZSB0aGUgY29udmVyc2lvbnMNCj4+Pj4gYXJlIHByb3Blcmx5IGRvbmUgYW5kIHRo
ZSByaWdodCB0eXBlcyB1c2VkLCB0aGUgc3BhcnNlIHdhcm5pbmdzIGFyZQ0KPj4+PiBjbGVhcmVk
IGFzIHdlbGwuDQo+Pj4+DQo+Pj4+IFJlcG9ydGVkLWJ5OiBFcmhhcmQgRnVydG5lciA8ZXJoYXJk
X2ZAbWFpbGJveC5vcmc+DQo+Pj4+IEZpeGVzOiA2ZjRjNDVjYmNiMDAgKCJrdW5pdDogQWRkIHRl
c3RzIGZvciBjc3VtX2lwdjZfbWFnaWMgYW5kIGlwX2Zhc3RfY3N1bSIpDQo+Pj4+IFNpZ25lZC1v
ZmYtYnk6IENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldT4NCj4+
Pj4gLS0tDQo+Pj4+ICAgIGxpYi9jaGVja3N1bV9rdW5pdC5jIHwgMTcgKysrKysrKysrLS0tLS0t
LS0NCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkNCj4+Pj4NCj4+Pj4gZGlmZiAtLWdpdCBhL2xpYi9jaGVja3N1bV9rdW5pdC5jIGIvbGliL2No
ZWNrc3VtX2t1bml0LmMNCj4+Pj4gaW5kZXggMjI1YmI3NzAxNDYwLi5iZjcwODUwMDM1YzcgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2xpYi9jaGVja3N1bV9rdW5pdC5jDQo+Pj4+ICsrKyBiL2xpYi9jaGVj
a3N1bV9rdW5pdC5jDQo+Pj4+IEBAIC0yMTUsNyArMjE1LDcgQEAgc3RhdGljIGNvbnN0IHUzMiBp
bml0X3N1bXNfbm9fb3ZlcmZsb3dbXSA9IHsNCj4+Pj4gICAgCTB4ZmZmZjAwMDAsIDB4ZmZmZmZm
ZmIsDQo+Pj4+ICAgIH07DQo+Pj4+ICAgIA0KPj4+PiAtc3RhdGljIGNvbnN0IF9fc3VtMTYgZXhw
ZWN0ZWRfY3N1bV9pcHY2X21hZ2ljW10gPSB7DQo+Pj4+ICtzdGF0aWMgY29uc3QgdTE2IGV4cGVj
dGVkX2NzdW1faXB2Nl9tYWdpY1tdID0gew0KPj4+PiAgICAJMHgxOGQ0LCAweDMwODUsIDB4MmU0
YiwgMHhkOWY0LCAweGJkYzgsIDB4NzhmLAkweDEwMzQsIDB4ODQyMiwgMHg2ZmMwLA0KPj4+PiAg
ICAJMHhkMmY2LCAweGJlYjUsIDB4OWQzLAkweDdlMmEsIDB4MzEyZSwgMHg3NzhlLCAweGMxYmIs
IDB4N2NmMiwgMHg5ZDFlLA0KPj4+PiAgICAJMHhjYTIxLCAweGYzZmYsIDB4NzU2OSwgMHhiMDJl
LCAweGNhODYsIDB4N2U3NiwgMHg0NTM5LCAweDQ1ZTMsIDB4ZjI4ZCwNCj4+Pj4gQEAgLTI0MSw3
ICsyNDEsNyBAQCBzdGF0aWMgY29uc3QgX19zdW0xNiBleHBlY3RlZF9jc3VtX2lwdjZfbWFnaWNb
XSA9IHsNCj4+Pj4gICAgCTB4Mzg0NSwgMHgxMDE0DQo+Pj4+ICAgIH07DQo+Pj4+ICAgIA0KPj4+
PiAtc3RhdGljIGNvbnN0IF9fc3VtMTYgZXhwZWN0ZWRfZmFzdF9jc3VtW10gPSB7DQo+Pj4+ICtz
dGF0aWMgY29uc3QgdTE2IGV4cGVjdGVkX2Zhc3RfY3N1bVtdID0gew0KPj4+PiAgICAJMHhkYTgz
LCAweDQ1ZGEsIDB4NGY0NiwgMHg0ZTRmLCAweDM0ZSwJMHhlOTAyLCAweGE1ZTksIDB4ODdhNSwg
MHg3MTg3LA0KPj4+PiAgICAJMHg1NjcxLCAweGY1NTYsIDB4NmRmNSwgMHg4MTZkLCAweDhmODEs
IDB4YmI4ZiwgMHhmYmJhLCAweDVhZmIsIDB4YmU1YSwNCj4+Pj4gICAgCTB4ZWRiZSwgMHhhYmVl
LCAweDZhYWMsIDB4ZTZiLAkweGVhMGQsIDB4NjdlYSwgMHg3ZTY4LCAweDhhN2UsIDB4NmY4YSwN
Cj4+Pj4gQEAgLTU3Nyw3ICs1NzcsOCBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NzdW1fbm9fY2Fycnlf
aW5wdXRzKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+Pj4gICAgDQo+Pj4+ICAgIHN0YXRpYyB2b2lk
IHRlc3RfaXBfZmFzdF9jc3VtKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+Pj4gICAgew0KPj4+PiAt
CV9fc3VtMTYgY3N1bV9yZXN1bHQsIGV4cGVjdGVkOw0KPj4+PiArCV9fc3VtMTYgY3N1bV9yZXN1
bHQ7DQo+Pj4+ICsJdTE2IGV4cGVjdGVkOw0KPj4+PiAgICANCj4+Pj4gICAgCWZvciAoaW50IGxl
biA9IElQdjRfTUlOX1dPUkRTOyBsZW4gPCBJUHY0X01BWF9XT1JEUzsgbGVuKyspIHsNCj4+Pj4g
ICAgCQlmb3IgKGludCBpbmRleCA9IDA7IGluZGV4IDwgTlVNX0lQX0ZBU1RfQ1NVTV9URVNUUzsg
aW5kZXgrKykgew0KPj4+PiBAQCAtNTg2LDcgKzU4Nyw3IEBAIHN0YXRpYyB2b2lkIHRlc3RfaXBf
ZmFzdF9jc3VtKHN0cnVjdCBrdW5pdCAqdGVzdCkNCj4+Pj4gICAgCQkJCWV4cGVjdGVkX2Zhc3Rf
Y3N1bVsobGVuIC0gSVB2NF9NSU5fV09SRFMpICoNCj4+Pj4gICAgCQkJCQkJICAgTlVNX0lQX0ZB
U1RfQ1NVTV9URVNUUyArDQo+Pj4+ICAgIAkJCQkJCSAgIGluZGV4XTsNCj4+Pj4gLQkJCUNIRUNL
X0VRKGV4cGVjdGVkLCBjc3VtX3Jlc3VsdCk7DQo+Pj4+ICsJCQlDSEVDS19FUSh0b19zdW0xNihl
eHBlY3RlZCksIGNzdW1fcmVzdWx0KTsNCj4+Pj4gICAgCQl9DQo+Pj4+ICAgIAl9DQo+Pj4+ICAg
IH0NCj4+Pj4gQEAgLTU5OCw3ICs1OTksNyBAQCBzdGF0aWMgdm9pZCB0ZXN0X2NzdW1faXB2Nl9t
YWdpYyhzdHJ1Y3Qga3VuaXQgKnRlc3QpDQo+Pj4+ICAgIAljb25zdCBzdHJ1Y3QgaW42X2FkZHIg
KmRhZGRyOw0KPj4+PiAgICAJdW5zaWduZWQgaW50IGxlbjsNCj4+Pj4gICAgCXVuc2lnbmVkIGNo
YXIgcHJvdG87DQo+Pj4+IC0JdW5zaWduZWQgaW50IGNzdW07DQo+Pj4+ICsJX193c3VtIGNzdW07
DQo+Pj4+ICAgIA0KPj4+PiAgICAJY29uc3QgaW50IGRhZGRyX29mZnNldCA9IHNpemVvZihzdHJ1
Y3QgaW42X2FkZHIpOw0KPj4+PiAgICAJY29uc3QgaW50IGxlbl9vZmZzZXQgPSBzaXplb2Yoc3Ry
dWN0IGluNl9hZGRyKSArIHNpemVvZihzdHJ1Y3QgaW42X2FkZHIpOw0KPj4+PiBAQCAtNjExLDEw
ICs2MTIsMTAgQEAgc3RhdGljIHZvaWQgdGVzdF9jc3VtX2lwdjZfbWFnaWMoc3RydWN0IGt1bml0
ICp0ZXN0KQ0KPj4+PiAgICAJCXNhZGRyID0gKGNvbnN0IHN0cnVjdCBpbjZfYWRkciAqKShyYW5k
b21fYnVmICsgaSk7DQo+Pj4+ICAgIAkJZGFkZHIgPSAoY29uc3Qgc3RydWN0IGluNl9hZGRyICop
KHJhbmRvbV9idWYgKyBpICsNCj4+Pj4gICAgCQkJCQkJICBkYWRkcl9vZmZzZXQpOw0KPj4+PiAt
CQlsZW4gPSAqKHVuc2lnbmVkIGludCAqKShyYW5kb21fYnVmICsgaSArIGxlbl9vZmZzZXQpOw0K
Pj4+PiArCQlsZW4gPSBsZTMyX3RvX2NwdSgqKF9fbGUzMiAqKShyYW5kb21fYnVmICsgaSArIGxl
bl9vZmZzZXQpKTsNCj4+Pj4gICAgCQlwcm90byA9ICoocmFuZG9tX2J1ZiArIGkgKyBwcm90b19v
ZmZzZXQpOw0KPj4+PiAtCQljc3VtID0gKih1bnNpZ25lZCBpbnQgKikocmFuZG9tX2J1ZiArIGkg
KyBjc3VtX29mZnNldCk7DQo+Pj4+IC0JCUNIRUNLX0VRKGV4cGVjdGVkX2NzdW1faXB2Nl9tYWdp
Y1tpXSwNCj4+Pj4gKwkJY3N1bSA9ICooX193c3VtICopKHJhbmRvbV9idWYgKyBpICsgY3N1bV9v
ZmZzZXQpOw0KPj4+PiArCQlDSEVDS19FUSh0b19zdW0xNihleHBlY3RlZF9jc3VtX2lwdjZfbWFn
aWNbaV0pLA0KPj4+PiAgICAJCQkgY3N1bV9pcHY2X21hZ2ljKHNhZGRyLCBkYWRkciwgbGVuLCBw
cm90bywgY3N1bSkpOw0KPj4+PiAgICAJfQ0KPj4+PiAgICAjZW5kaWYgLyogIUNPTkZJR19ORVQg
Ki8NCj4+Pj4gLS0gDQo+Pj4+IDIuNDMuMA0KPj4+Pg0KPj4+DQo+Pj4gVGhlcmUgaXMgbm8gbmVl
ZCB0byBkdXBsaWNhdGUgZWZmb3J0cyBoZXJlLiBUaGlzIGhhcyBhbHJlYWR5IGJlZW4NCj4+PiBy
ZXNvbHZlZCBieQ0KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMjEtZml4
X3NwYXJzZV9lcnJvcnNfY2hlY2tzdW1fdGVzdHMtdjktMi1iZmY0ZDczYWI5ZDFAcml2b3NpbmMu
Y29tLy4NCj4+Pg0KPj4NCj4+IFRoZSBpZGVhIGhlcmUgaXMgdG8gcHJvdmlkZSBhIGZpeCB3aGlj
aCBpcyBzaW1pbGFyIHRvIHRoZSBvbmUgZG9uZQ0KPj4gcHJldmlvdXNseSBhbmQgdGhhdCB1c2Vz
IHRoZSBzYW1lIGFwcHJvYWNoIGFuZCByZXVzZXMgdGhlIHNhbWUgaGVscGVycy4NCj4+DQo+PiBU
aGlzIGlzIHRvIGtlZXAgdGhlIGNvZGUgaG9tb2dlbmVvdXMuDQo+Pg0KPj4gQ2hyaXN0b3BoZQ0K
PiANCj4gaHRvbnMgbWFrZXMgbW9yZSBzZW5zZSBoZXJlIHNpbmNlIHRoaXMgaXMgbmV0d29ya2lu
ZyBjb2RlLCBidXQgSSBkb24ndA0KPiBjYXJlIGVub3VnaCB0byBhcmd1ZSB0aGUgcG9pbnQuIEkg
dGVzdGVkIGl0IG9uIGJpZyBlbmRpYW4gU1BBUkMgYW5kIG9uDQo+IHJpc2N2LiBJJ2xsIGJhc2Ug
bXkgYWxpZ25tZW50IHBhdGNoIG9uIHRoaXMuDQoNCkkgYWdyZWUgd2l0aCB5b3UgdGhhdCBodG9u
cygpIHdvdWxkIGhhdmUgbWFkZSBtb3JlIHNlbnNlLCBidXQgdGhlIA0KZXhwZWN0ZWQgdmFsdWVz
IGFyZSBpbiBsaXR0bGUgZW5kaWFuIGFuZCB3aGVuIEkgZml4ZWQgdGhlIGlzc3VlIHRoZSANCmZp
cnN0IHRpbWUgSSB3YW50ZWQgdG8ga2VlcCBpdCBhcyBhIG1pbmltYWwgZml4IGFuZCBkaWRuJ3Qg
d2FudCB0byBjaHVybiANCnRoaW5ncyB0b28gbXVjaCBhbmQgY2hhbmdlIGFsbCBleHBlY3RlZCB2
YWx1ZXMuDQoNCklmIHdlIGdvIGZvciBodG9ucygpIHRoaXMgdGltZSB0aGlzIG1lYW5zIGFnYWlu
IGNoYW5naW5nIGV4cGVjdGVkIHZhbHVlcyANCnRvIG5hdHVyYWwgbmV0d29yayBieXRlIG9yZGVy
IChiaWcgZW5kaWFuKS4gRWl0aGVyIHdlIGRvIGl0IG9ubHkgZm9yIHRoZSANCnRlc3RzIHRvIGJl
IGZpeGVkIG5vdywgYW5kIHdlJ2xsIGhhdmUgc29tZSB0ZXN0cyBmb3Igd2l0aCB0aGUgcmVzdWx0
cyANCmFyZSBpbiBiaWcgZW5kaWFuIGFuZCBzb21lIHRoYXQgcmVtYWlucyBpbiBsaXR0bGUgZW5k
aWFuLiBUaGF0IGxvb2tzIA0KaW5jb25zaXN0YW50IHRvIG1lLiBPciB3ZSBkbyB0aGUgY2hhbmdl
IGZvciBhbGwgdGVzdHMuIEluIGJvdGggY2FzZSBpdCANCndvdWxkIGJlIGEgYnVsa3kgY2hhbmdl
LiBBcyB3ZSBhcmUgcmVsYXRpdmVseSBsYXRlIGluIDYuOCBjeWNsZSBteSANCnByZWZlcmVuY2Ug
Z29lcyBmb3IgYSBtaW5pbWFsIGZpeC4NCg0KV2h5IG5vdCB0aGVuIGNvbnZlcnQgX2FsbF8gdGVz
dHMgdG8gbmV0d29yayBieXRlIG9yZGVyIGV4cGVjdGF0aW9uIGluIGEgDQpmb2xsb3ctdXAgcGF0
Y2guDQoNCj4gDQo+IFRlc3RlZC1ieTogQ2hhcmxpZSBKZW5raW5zIDxjaGFybGllQHJpdm9zaW5j
LmNvbT4NCj4gDQoNClRoYW5rcw0KQ2hyaXN0b3BoZQ0K

