Return-Path: <linux-kernel+bounces-122714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E475188FBF4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13CAF1C2EB1F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFA8657B9;
	Thu, 28 Mar 2024 09:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="A1mvl4ZR"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2125.outbound.protection.outlook.com [40.107.20.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DC1535C2;
	Thu, 28 Mar 2024 09:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711619169; cv=fail; b=uHOuA95RJpRK9nBsavRD2uyLFgR2VD97dO1dtye6rPZ8UeZFr6oyL7nnWPMc/t3G+9FxkGLyDjW62le91vOFba0foNVxkcYeifecw7vafpBrLYYaSTKdxYSz2r2zhWuXIT80ZvnJpxYzXVznd2mYxJvCXQzoXJTE6J2VzzFfGTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711619169; c=relaxed/simple;
	bh=t7WV2TO2jjFS+As+jezKdzOkXrM5wQ2qr4WSlPjWNdc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cMaDn23W5EA5DFnRZEDjA33/M8Dz2RP6geiWZsZn9YPjacJCCbhIHyoUEvCjrhwykMfTyDWjTNN9f0Fh5/ix/YilWM3FjWAO48CbcHYGVz6rAR3qBqlXuFYsg5j31BlfsjO1pfTNmomn4YS14p0yxeeUXDxeG4EbLMj2f/+HCIc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=A1mvl4ZR; arc=fail smtp.client-ip=40.107.20.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxTU6iioYUaiVK7iPyu6A4Gn0av51M1QRltyQK+x/wJjb/5BSoTAulfIwS2kUiz7beBzd4Is5uorSuqn3ruf89VuyCOxe+Khh079lZdWgbE3gcFUY4QPHMrdI8qnmYRKzHXPaxyPChkf04ZhwnNH25nsPK4qo4sBiJL1157W4L6t72PsB5EFODqk2eA/ZedMPeEbgt9InsS0YHsnnetBTVASoJqI0i0uvIarKqxZI/f83mSVSepUlSwK3J4Z6k5OM9rAP/SFkOL18s/QbEB2oiR+v8Tdermv6dp2gt3HviE6wFpcbW6pj9CcwmI03x01ArxyrvCEoSw8iCB2nJJzLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t7WV2TO2jjFS+As+jezKdzOkXrM5wQ2qr4WSlPjWNdc=;
 b=ko+Dz27TAfm5Yc2Xosa21I/dtT58d+AiQ45a8cxajl3dAPHPgD3+Q5Cg44gfb/A/MzLhmMTO9+fE37SifwVzHL0XWuOTFudtLr39w5Ef6jRUsEi49OX2RImkBMNOqw9WhNUZpa0+LWHg5dOCfaq8vp83RNDCAvU3hbNA8zQ++mlpr099uuCAAGe5A2DGO32qb7cbYPAsQG4U6YX11d50GrpPZLWRlb+HT7oe91Xf3lDrTZ4PXYc31uX/s1wUzwp0HTYDxdMLF7QnFfNDY2bwb6iVwo+Nr7mYwslHmWCUVwNM5sYJG5Wff3CSN3YYdRbuKDu07T4H646//ctvoDGSzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t7WV2TO2jjFS+As+jezKdzOkXrM5wQ2qr4WSlPjWNdc=;
 b=A1mvl4ZRcTVWa5x3EsgMG+d/xJzvsNMekdVvz3mHp0g/SO4zv2Nnhb0fAWNlOmRVHXFMApDRbPgjz7uv0J33APtkTeUnXz9/m2HNhJp5Bjh8zEUYUolb0QZsrW6v+2EAwtTK9p6EmYZ7JezsRUOwpTpv5jAAnlj+OoXI6aEkdtc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AS8PR04MB9192.eurprd04.prod.outlook.com (2603:10a6:20b:44f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 09:46:04 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 09:46:04 +0000
From: Josua Mayer <josua@solid-run.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Andrew Lunn
	<andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>, Sebastian
 Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index:
 AQHae9lZw/gIYk6zDE+73DiBF+lb+bFDiiAAgAVVLYCAAAp+AIAAr8GAgADVrQCAAPl+AIAACiwAgAF2C4CAAAVTgIAAAl0AgAABLYA=
Date: Thu, 28 Mar 2024 09:46:04 +0000
Message-ID: <7ec0a9bf-d721-478d-839f-3c1433892588@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
 <0f7ca0ed-a1c1-41d2-a1fa-27431d14c056@solid-run.com>
 <e1836cb6-64cd-4866-9c0a-f0dda096aa18@linaro.org>
 <6a6e7c4d-d5fd-42ae-bc3d-a3978d65e8e4@solid-run.com>
 <b086a02c-624f-4225-a9fb-164095742ce9@linaro.org>
 <6af08a38-5239-4f5f-9e87-108e3400a6e6@solid-run.com>
 <62242f04-c18d-4da0-bd40-1be26886e41a@linaro.org>
 <1153cdd4-ed86-4a1f-ae4d-d9da1161f763@solid-run.com>
 <539eaf79-cff5-4bb7-84c8-7c9943c6d8ae@linaro.org>
 <5ea0feb4-4d7e-4a10-9254-b034e368e8ad@solid-run.com>
 <68fd00b8-d6f1-463b-9d0d-b77bf9364f7f@linaro.org>
In-Reply-To: <68fd00b8-d6f1-463b-9d0d-b77bf9364f7f@linaro.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AS8PR04MB9192:EE_
x-ms-office365-filtering-correlation-id: 4ce1fd07-b18c-42e0-8374-08dc4f0be266
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dVgcqqCW/uo5snLJJ3EYnV4FhLSreOqCVhL6BFtS9Cbj8APygCcPeU5YMZ/5dKjj3G4m4ndvwH/cReEqlhXvnAx+FzmRGtXbpbfbe9gAkcZEKZsnIUFjynX6pGk/2ACSG65M0/OQeMqUyyfdEArpQ6wXmhINT7Xowt6W/ccfREe1i0MfbMiLUFAahc9Af/HC2LMLvukNWklmqBftO3tjVO78WPlPyoi30dCj+Zg7sFgNs6+3rfxPC6lei7yXY6pCe2VpueDl5ml3osqu8VITZBG2LVjHXmU30fTt4Sl+qe/XXN5ZI5yeHxT4i7/d5HV2ARr+b/7vXlZ8CSjES1bXEuCPnoqvzXLhCtaBBqpboY5exjnXld1K6tA3Y4/E8XljntzU/rN7xkNpKMoKoaq2qiMXL5evPthas3oTT4LZbUu17Hhm7yfYIAAE1lPpajdPcHnKE8Zo5QQcZSoHPB80UUOQu/iSkB6paSiChWJUGR4nmJ6rYm8qE+5kIV6G26/r1tU/9SGcw1SEEUtlTKK5oMej0/cei88qFCJfMTFcl9KeNntR29QI5B2UK8At6mxuyqVgKNO56ft7z1BjA9J2kwNCrxSLLLO9tIkXOiQYzcwyRu/skCNXNdWnmhUkXt4Dx5MG37hCrWJN1RJdZJk5eAB1xwdMet+VOL0FGLcFnkpgY+YlDg6r174yMYzU27ODfZw0WuFFdJXt0UbR4Aqp/w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VkhPbzU5cVRaSUtaNnBXYkxSbjNYSU1qaTRRSmdmajBpR2cvRXZWaittK0V5?=
 =?utf-8?B?UFlvbHdhVkNzZ3hkL0dSYlZ5SlMxNnNlU3YvQzJacWVMUE1JdVdRMWRvaGxh?=
 =?utf-8?B?WTk0eThsczNKNmFjbEJqR05wQklPcTYrZjZjQUEwb09GeGU1VGdIemhhRVhY?=
 =?utf-8?B?RVVaZ0Z5SzArWmdpY3pGSks5L0tnZnNZZ2lZZXczTzhmRS9kMCsxdmx5cXdF?=
 =?utf-8?B?VEw1R0dCRUo4MmNiV3htMTN6aHEwUTJCc2I0OGZZb1E1SnN1SjgwTUdpczlj?=
 =?utf-8?B?NjRZV2JodkkyOVJWN0x4cGduNkMzbHNVWUdRMnBxZVNKUUlvN3M1RnZtbDcx?=
 =?utf-8?B?ejBuS2VtMTdLditZUVZlYW5lK0tRZ2RwdEZwRnRsM2JKSm5Xb1U4aUtLMkx3?=
 =?utf-8?B?RTlJNW9YT0FWUXRZQmg1anM0UE1MTUlsZDdPblNtQ09zN3VrVjYySVRtSi9H?=
 =?utf-8?B?bnlkb3IzZWRsQ3M1TDRmQTR5b3k1SDF5MC9lcHVKdUZrL3NLNiswcEtISGpm?=
 =?utf-8?B?NmFZc2dkTUFTWXQ2ajBWNGRzTE8wRWFwSGN0SWVjcEZ6aGM0NHdwOFlLWXFR?=
 =?utf-8?B?UEYwVDg1MTF4WHlHYVMxMjBBdlZ2SVlQVHk2c3BxdEpBMTQrZllIRVF4UzFs?=
 =?utf-8?B?NjVYNEsyekZTWXVlSk5NWFhVNkx5dEQxYlY4OWVKMjB5ejc5SVluUEhJT1RE?=
 =?utf-8?B?UTdsQThmbjFEVmJTdHBxMUNvS2RsRUlGOGRpTnNwZ1RyUThaaHBzcjg5dGNt?=
 =?utf-8?B?cHpHeGd4eG5PbFBPcG5aaXluZ0loNUVCY29RNkRhM2tjRDFnb1lUTHlqV24w?=
 =?utf-8?B?ZHFwTTRWUUViZFNGclJGNTVlMmhVVTloMEszbUdRNFJ3cXI4RjRGQ2FVZGk3?=
 =?utf-8?B?bWV6dHZSSEFHN2xkS0htdEJ0YUVCY0tlLzFMM0JMZ25JTUl3ckRoSzVNZFpO?=
 =?utf-8?B?a3I2Z0poUWxwQXZsQmVNOWlyYk1neTJwMmhpcFdaendia0F6SkRZN0ZEd2FX?=
 =?utf-8?B?K2Q2bkUzNEppRWR2b2VOVVA2NFNsci9xZnIraEplN2k4bVlEdHdkQzdHSkdY?=
 =?utf-8?B?TmFrc1hYdHZnc0dZOFR2ZW92eVk4dy9pOUI1RjJSbmNBUnRyektoUGEvZS95?=
 =?utf-8?B?cHNROURXenVDaWFhcHF0b3Z6WUlPNTZYNVdLQUV2Ujk5MWlKMCszdXFlN3J4?=
 =?utf-8?B?Q2pmS1N6aUd3NWhUOTkrd0ZoTkFVdWdVV290bmtPRVNXdTdrc3VkYnM5QmhB?=
 =?utf-8?B?TlYyZVlPZlBsZ0VCTWNhMTJnWWpDeGtVTXExdUU3aXY2TU0zUXpJQ05GeElx?=
 =?utf-8?B?OFZqUmpEb25BY3pBdUlxdnU3Wks1a2NJd1pSaEo0ZnVoTEFJU3QxYnNJV2Rw?=
 =?utf-8?B?S3FqWHFORTlKSFE4aEM1R2xuaXNKcWdsaVVWQzc4RVNiT1ViNE5vRTU0MWwy?=
 =?utf-8?B?TTRzcG41QWVWNmQwZE12REFWTzBGeFg1NUlCZmlCRFpXRUIxWmlVV2I0cUpl?=
 =?utf-8?B?dlp3VWZaQ0lRckw4S0xJV3BxNURJTzhlUHdlNXQ5UnNURVlma3o2bktpeGNC?=
 =?utf-8?B?STN1V1c2M21kMXhiUGo1dlBTZTg0NCt1MjVDU2NQVEJERkx3SE14TUloQm80?=
 =?utf-8?B?REVIcG1FcFdhdUYwZER4UUJIMFREaGNyV2xEblU5TWNpOGdtcTVxL21BUVpl?=
 =?utf-8?B?cHNLa1dkSXQraFIrb2UzMHNGWXNTUm9VN3gycEIzQ0J3WU9mZWFtT2c3VnRP?=
 =?utf-8?B?ZEprclpiUXc3RnB4eWdZY3oreWlxMlowSU85b05jdWdEOW9qRnNVV0JZT1Fs?=
 =?utf-8?B?bjcwb0o3eUJqV1lNUmRFTnhpSTNqcWl2OEFlaTBYdEZKQ3FqN3hCUERhUnc4?=
 =?utf-8?B?STVRd0t1NXQrZnlnYUprcDkyaW9wRWNYdHRNRGNlazdFc205T0x5NGVudHZH?=
 =?utf-8?B?N2hVUE1kNVFVQi9TdXNTQ05QYUJ1YXRXMkx3cENucUJsNXMyV2x5c1pUYndZ?=
 =?utf-8?B?U3R1MWpvNmZBQ1hjUWxabE81ZUJFWlhuQmEwTWp5VVpUUmxPWGdGZURGQ1J1?=
 =?utf-8?B?dXJTTEJ0MnREYmQxQmVScnRZd0hDSVBxajFqNDd4N1VkK1dJcTAyeW9ZS2dH?=
 =?utf-8?Q?nKyDMFNEQr2HnmnPNKiZHUQfm?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DD7978EA874C8A4FA32439EC5C10B255@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ce1fd07-b18c-42e0-8374-08dc4f0be266
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 09:46:04.0769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzHtX//lDgqYy2YUKOAZ5xkjKiwLOTQOvSWTnk5E7NzRnby+gtv72kBwH5inCkcUHq/2hfuY6LpQUoNq2HzHJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9192

QW0gMjguMDMuMjQgdW0gMTA6NDEgc2NocmllYiBLcnp5c3p0b2YgS296bG93c2tpOg0KPiBPbiAy
OC8wMy8yMDI0IDEwOjMzLCBKb3N1YSBNYXllciB3cm90ZToNCj4+Pj4gMi4gODhGODIxNSwgU291
dGhCcmlkZ2UgQ29tbXVuaWNhdGlvbiBQcm9jZXNzb3IsIFN5c3RlbSBvbiBDaGlwDQo+Pj4+IChv
bmx5IHVzYWJsZSBpbiBjb21iaW5hdGlvbiB3aXRoIGEgQ045MTMwKQ0KPj4+Pg0KPj4+PiBOb3cs
IGluIHRlcm1zIG9mIGNvbXBhdGlibGUgc3RyaW5nLCB3aGF0IGhhcHBlbnMgd2hlbiBhIGJvYXJk
DQo+Pj4+IGhhcyBtdWx0aXBsZXMgb2YgdGhlc2U/DQo+Pj4gTXVsdGlwbGUgb2YgQ045MTMwPyAy
eCBDTjkxMzA/DQo+PiB0aGlzIHNwZWNpZmljYWxseSBpcyBhbiBhY2FkZW1pYyBxdWVzdGlvbiwN
Cj4+IHRoZSBtYWluIHBvaW50IGlzIG11bHRpcGxlIHNvdXRoYnJpZGdlcyB0byBvbmUgQ045MTMw
Lg0KPiBJIGRpZCBub3Qga25vdyB0byB3aGF0IHlvdSByZWZlci4NCj4NCj4+PiBZb3UgPGN1dD4g
c2hvdWxkIGtub3cgd2hhdCBpcyB0aGlzIGFib3V0IGFuZCBjb21lDQo+Pj4gd2l0aCBleHBsYW5h
dGlvbiB0byB0aGUgY29tbXVuaXR5Lg0KPj4gSWYgSSB3YXMgdG8gY29tZSB1cCB3aXRoIHNvbWV0
aGluZyBuZXcsIHdpdGhvdXQgbG9va2luZyBhdCBleGlzdGluZw0KPj4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2FybS9tYXJ2ZWxsL2FybWFkYS03ay04ay55YW1sDQo+PiBJIHdv
dWxkIGRlc2NyaWJlIHRoZSBoYXJkd2FyZSBsaWtlIHRoaXM6DQo+Pg0KPj4gU29saWRSdW4gIkNO
OTEzMSIgU29saWRXQU4gYm9hcmQgaXMgY29tcHRpYmxlIHdpdGg6DQo+PiAtIHNvbGlkcnVuLGNu
OTEzMS1zb2xpZHdhbjoNCj4+IMKgIG5hbWUgb2YgdGhlIGNhcnJpZXIgYm9hcmQsIGFuZCBuYW1l
IG9mIHRoZSBjb21wbGV0ZSBwcm9kdWN0DQo+PiDCoCBpbmNsdWRlcyBvbmUgc291dGhicmlkZ2Ug
Y2hpcCwgYnV0IEkgZG9uJ3QgbmVlZCB0byBtZW50aW9uIGl0Pw0KPj4gLSBzb2xpZHJ1bixjbjkx
MzAtc3Itc29tOg0KPj4gwqAganVzdCB0aGUgc29tLCBpbmNsdWRpbmcgMXggQ045MTMwIFNvQw0K
Pj4gLSBtYXJ2ZWxsLGNuOTEzMDoNCj4+IMKgIHRoaXMgaXMgdGhlIFNvQywgaW50ZXJuYWxseSBj
b21iaW5pbmcgQVArQ1ANCj4+IMKgIEFQICpjb3VsZCogYmUgbWVudGlvbmVkLCBidXQgSSBkb24n
dCBzZWUgYSByZWFzb24NCj4gV2l0aCBhbiBleHBsYW5hdGlvbiBpbiBjb21taXQgbXNnIGFib3V0
IG5vdCB1c2luZyBvdGhlciBjb21wYXRpYmxlDQo+IGZhbGxiYWNrcywgdGhpcyBsb29rcyBnb29k
IHRvIG1lLg0KR3JlYXQuIFNvIHBlcmhhcHMgbXkgbmV4dCBzdGVwIHdpbGwgYmUgYSB2MiB3aXRo
IGV4cGxhbmF0aW9ucy4NCj4NCj4+PiBZb3U8Y3V0PnIgcGxhdGZvcm0gbWFpbnRhaW5lcnMgc2hv
dWxkIGtub3cgd2hhdCBpcyB0aGlzIGFib3V0IGFuZCBjb21lDQo+Pj4gd2l0aCBleHBsYW5hdGlv
biB0byB0aGUgY29tbXVuaXR5Lg0KPj4gSXMgdGhlcmUgYSB3YXkgZm9yd2FyZD8NCj4+IFdvdWxk
IGl0IGJlIHdvcnRoIGNoYWxsZW5naW5nIHRoZSBleGlzdGluZyBiaW5kaW5ncyBieSBwcm9wb3Np
bmcgKFJGQykNCj4+IHNwZWNpZmljIGNoYW5nZXMgaW4gbGluZSB3aXRoIHdoYXQgSSBkZXNjcmli
ZWQgYWJvdmU/DQo+IEl0IGFsbCBkZXBlbmRzIG9uICJ3aGF0IiBhbmQgIndoeSIgeW91IHdhbnQg
dG8gZG8uIEkgZG9uJ3Qga25vdy4NCkZpcnN0IHByaW9yaXR5IGlzIHN1cHBvcnRpbmcgdGhlIHNv
bGlkcnVuIGJvYXJkcyBiYXNlZCBvbiBjbjkxMzAgc29jLA0Kd2hpY2ggcmVxdWlyZXMgZ2V0dGlu
ZyB0aGUgYmluZGluZ3MgcmlnaHQgKGF0IGxlYXN0IGZvciB0aGVzZSBib2FyZHMpLg0KDQpDaGFu
Z2luZyB0aGUgb3RoZXIgYmluZGluZ3Mgd291bGQgb25seSBzYXRpc2Z5IG15IGRlc2lyZSBmb3Ig
b3JkZXIsDQpidXQgY291bGQgZ2V0IGF0dGVudGlvbiBmcm9tIG90aGVyIGNvbnRyaWJ1dG9ycyB0
byB0aGVzZSBwbGF0Zm9ybXMuDQoNCg==

