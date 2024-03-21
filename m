Return-Path: <linux-kernel+bounces-109659-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B3D881C23
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 06:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFB111C210CF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 05:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80A1A374C2;
	Thu, 21 Mar 2024 05:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="O6/YTU8x"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2053.outbound.protection.outlook.com [40.107.249.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F612E41C;
	Thu, 21 Mar 2024 05:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710999614; cv=fail; b=gAB2evy0hG6/iOhrVzp15JcenZ3FMT7Eh5sD4+zOSwLrCb+J3eUaalvDGpfac+hDMebheYlwRZYdfHssNXqDh7qjAp5NnZ7+FU8Piz3wYdAm11okiDuax4YijJpmH2HCyJab05mT/W5PnDYp6ewN0Ap14wPMKh0EiY+EFSAeeqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710999614; c=relaxed/simple;
	bh=kHhsgcH6njXDZVtzTZYfzy0EzB71nONHcSPut6/Impo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qBvObWfOrSgF2bLf7sj7oHgbCvFNKJ+NvflAExIkg8J3tcCPi9+a7DZijbIH1t72anQtbGPeRt33qt8bmneJiMUr1mHKhTWdnKo73N/YfoYHMhWGYCLtQhIOJ7mcqccUEurChkDEPs5T6IDTdkL5TP7JWMl7C/AzHcji10K2B0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=O6/YTU8x; arc=fail smtp.client-ip=40.107.249.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=liAgRC0UZCBi38D+XW3Og8bj97bjQFFIxCJqtVnspMNwguLSI9LQFQDFFB8uAIY3AjverDSOhxhrM7DCr9uRvWO++1hUyNXm9M3hvXwXFF2ChYEwa981c2zmAAzEhAmoyS8qHrLvjQEMZbXL/58xS1VujgaHun3Y3Ng1B/kzBnezPXjKnuFe1H3/qtOqHrc0BMD5HGJ4vAxJiNB5BNfZdw7T8xybDOupgRg0A4Th7/dbKwIwmMmCzh1HoA7dxHJOUqzkRlLijUpcrpaI7ACAWNUNuWH3/Iu/fjtC+kaoyyJFRHzyg7BxhIPPQ8tGWKqCz6vmLWvH09of6brFGbxjzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kHhsgcH6njXDZVtzTZYfzy0EzB71nONHcSPut6/Impo=;
 b=LPnOOm3mDM6i456p65lRBPBSVwiA1cnq5hjlFk4bw3AHaSZ4l+0uGmDq0QbOs8DMBG5l1X59mJPJnr/EI6siO0niLYJyb2YqYkyWtWf7hYiVd4ESD0C+Ulz+gIamqISJC0PyD59Qjiq/qFmGj34ZUr5l7yr5XZtA+naU9wDEKDWnV38gpuukSTW5nYLPafB1V2plfjH9ooq6A93tnZWYfOLBJMG9A/7zNiXGKMRibIOtNESKuMX553Vw3LCDv0pFk2cUI5h0DPe1y2NyvPd+0GAMQ855SxdsJifkjgNFvGsW/K2wiwS4Fn1dlNS16PSTeGO6VdF9joghRDNyOTk4ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kHhsgcH6njXDZVtzTZYfzy0EzB71nONHcSPut6/Impo=;
 b=O6/YTU8x9QCQPbQ7xeRUQ/5L9que7kYyHkSnbl29lWxqJj7CPZAigIyvCo/Pwe4eGfVCPfQ8dVQOmVdcqzrsrakICRM0Wi9lnNIvEMeQSr3Vc9gyiKuJ0hVtoZKgvt6X+EeFAagrzIwhylZIt3P8wy4cYWtA4uKMZw8LRDXNsFc=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6955.eurprd04.prod.outlook.com (2603:10a6:10:11d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Thu, 21 Mar
 2024 05:40:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 21 Mar 2024
 05:40:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Thread-Topic: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags
 failed
Thread-Index: AQHaepfOXR4y1taHxkika8xHrgrdvLFAbwWAgAAIxJCAAASQgIABMp6Q
Date: Thu, 21 Mar 2024 05:40:09 +0000
Message-ID:
 <DU0PR04MB94171BA7C2E35D6691B47BBC88322@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
 <CAHp75Vf1K8c+7O5Cga3t+WiiSkk-yk_gATGJrMZ8rnPPtWLkWQ@mail.gmail.com>
 <DU0PR04MB9417FEFA3DB02082D02A963F88332@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ZfrGvwV92a9Zzrg_@smile.fi.intel.com>
In-Reply-To: <ZfrGvwV92a9Zzrg_@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6955:EE_
x-ms-office365-filtering-correlation-id: 67db0876-1162-46c0-8793-08dc49695ee4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Z1+AoS21M8rGJZ+aVm9QpttbKG20RmrqX1aZd/NWHQpGyfMbW+UdwLOH4+BueHaOUQlsI001zdf4gU66FgpXnVfAdW5i6BfPN0blo3qa0arzlHIkvTmg6nkNhshFZW79yKoWaH0IkRXwjD0DjFLNEuymDbbkeRTwgmK/YoaiQ+lqjB+JRJjiG9t3g0XW9KxsReFaFHfAI2MupxApF+e0G4bzc7wSO/bJ6e8XRcbdLu//eP1ISNN7ThcxVyB50dlCGNMo+pxDUc+NFflsQDXhKanGQUSZRW2M1JKXYXFifEDj/KEzyCJfW18hi3cbjNZkfumxkoLnOo9J0CHq2cybrldubzJNnZ+yBThEUj7Hg3UbAxA0DJS2EuR5RAL+U569SCQojus4Qmi6VFmg2Gav55xB6yLWcE05u7FeDbTAAuyucWksHkc9H8ESr735p1dG6VtwGVBGfmaNPHbwoEMis7fgNohKHxgjQC7X5Fyk5E441xZQZ+0OcqDpsyRy9mu3OmblgdgNfF7Gx/LfAR1zM/+IjOd3rswAuZcwFZQ5DPxN/IR/FqTlpFPNwJq0DyRHvqJVylzB3kjkU5CR3h5oZJIgtIQgeJsV4d7ZRhpM+jsCYUVYK0BJCg8fTFQl7SQQgoL/PqtvYsdiaAr9EzJSOB5ABpbhTRP9FXdKc6JtbKdGR+xHaSJ/1dIEhMftXpEG0BAgeg7sEsVgg9JKRW3AQeoH3ptWAoMAhyhwxo5+73E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YzdFaXhFeFM1OUYzUWVYMVV2ZloyMzd4UExYOFErT0JlYmdkR3c2Q0ZnMTJh?=
 =?utf-8?B?Y0FkRWlEcmJPc0xMTkZSZ2dmMHZmWlVaY1IwRE1qbmRscXdWMW5hdmYwdXpo?=
 =?utf-8?B?V2RjcmozcXRZQ3JDbEFxRTlBL1hHUmZoZVlhemxsMFFqeUx4L1RUSkdJZFNu?=
 =?utf-8?B?L2NiNndoWGt2MTd3Y2tWMmM0Qk45RlhBUGVOMGFEUVlWVmdTaUJJSTI0djNF?=
 =?utf-8?B?ZkRYQmhlYXZVQnRicVhGa0Uxc255ZHBsTEZURkMvNC9DVEF6czRuU2VNL2ty?=
 =?utf-8?B?WW5FbDIrUXMyaGRHYmJONXErRXM1QzJTZk1zaEJjUWJOd3pFV1ZsVTlUMGk2?=
 =?utf-8?B?NGRlTmJCTUxBeUVzYWdodGZlbk44Y0oxeFNodTNjWjMvRTVkYWdsQUdrdDlw?=
 =?utf-8?B?K3R6cVk2NVdFbGdHWElyRHJBNVpHdk1pbmduWnZHZ1cwMkNzZ0ZiVit1TWM5?=
 =?utf-8?B?YWlNZDFyVUxwTk10ck42R2ZVeWFKN2FobDhoSWcrS21FaXVDK3FqZUNZTys5?=
 =?utf-8?B?MXY4QWl5YWNkOFoycmFrdC9TWnRmK3B5RHcrV0pXYjRLY0QxOWM1dmMvd2Nr?=
 =?utf-8?B?OUlucW1CNWZwZ1lZOG5LcUU2RGk2elV6OTBzdVUxVkx1VHkwNm1qdVg5cFdq?=
 =?utf-8?B?WXRGOUZOVXFMZjhxT2doRCsvVFVwSURkMWZPSHI1YXpPWlNnakIveVhaM05k?=
 =?utf-8?B?KzNhNnJRZlcyV09MYmVaNmh0aUtzOWx3dnZIVEpmWVhhNUFGN25LMkd1YWNE?=
 =?utf-8?B?TGhmTDFSUkVGRFR2N1ErNlVDbGFMZ0hRdkh4WSt2MWg4anJtUUowOEZVdVFp?=
 =?utf-8?B?Um9XakpiUStkWHhRaS8zSnpwYXF3bWVHa2ZoSURQaVpqZ0xEKzg5bDY4RkQy?=
 =?utf-8?B?V3JuVlVWYkZ0SmI2eVNRVGpwbUk1eXVOU3hjZWZnMlNqSlVFcnUzWEVRSnlE?=
 =?utf-8?B?NkpxSHJZM0R6R29QaTdseGxna2Ura0VBbmhkcUtlK3M4T2tHMmUrUUJFQ010?=
 =?utf-8?B?d1NaS2ZsZGphd24rcnIwWW1Ram5KWFFpVS9lK3JYL2wzbzhRYS9HWHM5K0Mw?=
 =?utf-8?B?V3ZpRjZiZ1I3azdobGN1RmU2OURCWko2UUljdzg5YTVGNXprWktOWWRLWVZ2?=
 =?utf-8?B?MGdBbFhHNXBxbjBZcHgxMjM1RUw5b3JsRlkza2pseVFJUjE0THNSK0RZQWtC?=
 =?utf-8?B?a09MeGhFUm1wUGNHSVJhWjh2RlUvMWQwQytkQXBZY05VNVNqdVIrcXFadkty?=
 =?utf-8?B?ZGVrV0VvU3ZpNkFRaG1lMGlqK205MDY1RURVTnlQbUx5YmFOdmd4Um4zL3RH?=
 =?utf-8?B?Q1poVkRURlpsSGxOS2p2bFNzV05ycGVnMDJMcEhtaU03TkNpdGFTc0xWZEcy?=
 =?utf-8?B?TGVFM0grV0M1N3l6L0xCTUtCY2p6c1k2WVp3RWRQeHVzdjdiMktvNjIvMXZH?=
 =?utf-8?B?OXBnc1RTN2c5RnhjQXhHZW1mWEh2b1FCR3FjRkJXSm5TU0FLUGZ1UndySjVW?=
 =?utf-8?B?Nzkrc1h5dTk4K0UvdTloRms5UzZ4VHQvTmM4MGt2YjgvYVh2cXdIc09wWEda?=
 =?utf-8?B?YUl1MjdkcGk1SGpISWJacW8ycUFrbjFFL2w1bG45cDFEd0ZMWXEya3IwMFAx?=
 =?utf-8?B?eXd1QWU2d1hlRDFLZ3NiZjRNdWtKaHh0dmdrUW1sWDN4QU03WkNjREc0SEVE?=
 =?utf-8?B?WS95MzVLcDM5NTBadVMzQjB5NEZjL25ScURMT0VXekJhLzhUZWlYdTR2VVNw?=
 =?utf-8?B?Z2VmUVRhMjFkK280VmtSZG1ZbUNuOFBnZHIzRHBYZjBMY1lzMmE2T1d0dnUw?=
 =?utf-8?B?MDNuS0JIZS9pNTBnSjVOcTVERy9xWHd5eHRTMGExdDVOWEFrdFd4Snd4RlFW?=
 =?utf-8?B?YjU0ZnI0VlA5cDRQUXhURTVycEdxb3VlTjZqU3czRmVqU0RaaEEyOFhPTkpq?=
 =?utf-8?B?VGdBN1BJTDVBWFNzY2I4Q1drZExrMmxJdUljSVUyOHhxNzlLMzhpVmYvcE5J?=
 =?utf-8?B?N254d0VzbDE4R0c5Z0hpR2tTemhTUjlDVDlzYUFwT25nRjA5V3hhRDczb09F?=
 =?utf-8?B?OGQvdEg3QlA3OEZNVldYSWNVQnhEUnBqbEhOWEl5Yzh6VnNnSW8wQTMwWlFB?=
 =?utf-8?Q?bc2Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67db0876-1162-46c0-8793-08dc49695ee4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 05:40:09.1895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9LpS7SfOq8wZkWz6NtXy+IATSs6M0nTyIM2F/v5gJq5DEhBe+7ymor7NvIdajF5dHgUPqzT7pNIVL6DoDLD8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6955

PiBTdWJqZWN0OiBSZTogW1BBVENIIFYyXSBncGlvbGliOiB1c2UgZGV2X2VycigpIHdoZW4gZ3Bp
b2RfY29uZmlndXJlX2ZsYWdzDQo+IGZhaWxlZA0KPiANCj4gT24gV2VkLCBNYXIgMjAsIDIwMjQg
YXQgMTE6MDc6NDBBTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiBPbiBXZWQsIE1hciAy
MCwgMjAyNCBhdCA5OjI14oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPiA+IDxwZW5nLmZhbkBvc3Mu
bnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiBXaGVuIGdwaW8t
cmFuZ2VzIHByb3BlcnR5IHdhcyBtaXNzZWQgdG8gYmUgYWRkZWQgaW4gdGhlIGdwaW8gbm9kZSwN
Cj4gPiA+ID4gdXNpbmcgZGV2X2VycigpIHRvIHNob3cgYW4gZXJyb3IgbWVzc2FnZSB3aWxsIGhl
bHBpbmcgdG8gbG9jYXRlDQo+ID4gPiA+IGlzc3VlcyBlYXNpZXIuDQo+ID4gPg0KPiA+ID4gSSdt
IG5vdCBjb252aW5jZWQsIHNvIG5vdCBteSBjYWxsIHRvIGFwcHJvdmUgLyByZWplY3QsIGJ1dCBz
ZWUgYSByZW1hcmsNCj4gYmVsb3cuDQo+ID4NCj4gPiBZb3UgbWVhbiBkZXZfZXJyIG5vdCBoZWxw
IG9yIGVsc2U/DQo+IA0KPiBNb3ZpbmcgaXQgdG8gZXJyb3IgbGV2ZWwuDQo+IFVzdWFsbHkgZGV2
ZWxvcGVycyBlbmFibGUgQ09ORklHX0RFQlVHX0dQSU8gZm9yIHRoZXNlIG1lc3NhZ2VzIHRvDQo+
IGFwcGVhci4NCg0KQnV0IHRoaXMgaXMgYSBlcnJvciBsb2cuIExldCdzIGxlYXZlIHRoaXMgdG8g
Z3BpbyBtYWludGFpbmVycy4NCg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gPiAgICAgICAgIHJldCA9
IGdwaW9kX2NvbmZpZ3VyZV9mbGFncyhkZXNjLCBjb25faWQsIGxvb2t1cGZsYWdzLCBmbGFncyk7
DQo+ID4gPiA+ICAgICAgICAgaWYgKHJldCA8IDApIHsNCj4gPiA+ID4gLSAgICAgICAgICAgICAg
IGRldl9kYmcoY29uc3VtZXIsICJzZXR1cCBvZiBHUElPICVzIGZhaWxlZFxuIiwgY29uX2lkKTsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICAgIGRldl9lcnIoY29uc3VtZXIsICJzZXR1cCBvZiBHUElP
ICVzIGZhaWxlZDogJWRcbiIsDQo+ID4gPiA+ICsgY29uX2lkLCByZXQpOw0KPiA+ID4gPiAgICAg
ICAgICAgICAgICAgZ3Bpb2RfcHV0KGRlc2MpOw0KPiA+ID4gPiAgICAgICAgICAgICAgICAgcmV0
dXJuIEVSUl9QVFIocmV0KTsNCj4gPiA+DQo+ID4gPiBXaGlsZSBhdCBpdCwgY2FuIHlvdSBtb3Zl
IGl0IHRvIGJlIGFmdGVyIHRoZSBncGlvZF9wdXQoKT8NCj4gPg0KPiA+IERvZXMgaXQgbWF0dGVy
Pw0KPiANCj4gWWVzLCB0aGUgc3lzdGVtIGdpdmVzIHJlc291cmNlIGJhY2sgYXMgc29vbiBhcyBw
b3NzaWJsZS4NCg0KR290IGl0Lg0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtLQ0KPiBXaXRo
IEJlc3QgUmVnYXJkcywNCj4gQW5keSBTaGV2Y2hlbmtvDQo+IA0KDQo=

