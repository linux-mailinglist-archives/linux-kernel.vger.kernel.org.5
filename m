Return-Path: <linux-kernel+bounces-134824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE489B77A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 08:08:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D48E1C21012
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 06:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4852EF9C1;
	Mon,  8 Apr 2024 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="H4t/5mLU"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2104.outbound.protection.outlook.com [40.107.20.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC56679FE;
	Mon,  8 Apr 2024 06:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712556518; cv=fail; b=iTjTQUupNhspYReiGQtKWV2tHP/hTP5UhC3RKtKwuHYUDWzwNNP75KtnIK+k19tCD2hyG2du4htpjLWiLkvMcMFWnvgYe5Rp2017vL12mRr4aqdZfy/6If94p6v0LzANRtCK0jvI2fXXJDIynPZjoCQKe4tIn9f0q6W+a8H6Xto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712556518; c=relaxed/simple;
	bh=F31JDJ9gYFfCZtLo41hF/ec6nkmC/FqK0+sTTseTauY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VUN5kGsGefzTL6PRQuwlLaYNBY02gqw+0F/bR0KtzcUm+p7XyqqkE8cH8Eh9hLrsrZQdh8p9uLfIkfoz7lPwTL52YjnmLwmIPVM2mELfLpcuwgWFgP3Z0+LnE6prXATKksuhzc1GBC/U19kbOLn+v5BLvULiCLTcD4CsriyMtpI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=H4t/5mLU; arc=fail smtp.client-ip=40.107.20.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QsnUVSVrXwHwCoYFnPgk5LuhudPEaKcQEvjWKlgBW4r1wzAJgrAfY+1Nx+9m0YUEjtcqVwGAqqrFvCu+5fVPD+jnTiNYEOiE798Irr/dkTjwMPC44VdqsIfdw95ujc1v9xndqm8dNRzOLgO8ByunzIo9rxITkAcfl81qAaxK8h0QX2IrTwbvZgBNtmLqhahtByNTZ65a4vrvoY37WcnTWu/ucXlKFSCgMl3G4qUb1eZEsPlgqcKXKyDCuo0+s29QaSV6RKh/y6zFMEhMShM/qoMpm03M8UvrhUGeRKncUJQlxlpwjGEwSEfPT/+z9ZbQe7BUDGgKeS+KgcOsQIpqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F31JDJ9gYFfCZtLo41hF/ec6nkmC/FqK0+sTTseTauY=;
 b=I0ox40kFrY9gmd/AEYvuXY+mtR83kz6yqjDk10EnR9ySjlWrRCnvryZwCumzqVw+g9M7wwbI520sIuSL/kzEfpOZCXKGaJ17GYbvTwr8jFMPmOVYTKdmuLhkwUEwzE/hBIr4tvGuy+hm5vt49nR2XX2vYTitgoKGJfWq/xG4bnBLQNjKDoLP8sbkKnByFArHUx7mhapgbOzjPvZbAyVt86Va7pZRzjYgbJEw+H/GZ734aXofkLazu7dGF6UhvppQWDRUk8YqyB1kIxZMq2XM0db06u0Asfko2B2adkNi2QWxi8pEo8imaSxypBKp6Gz5e0SpkEr9f9ecLXxCBir6yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F31JDJ9gYFfCZtLo41hF/ec6nkmC/FqK0+sTTseTauY=;
 b=H4t/5mLUUSp3T05LnTq2seVIpyprHodY5Lb2reUcPDf9vXokDzINNjgkZfdi7f+6/vil/eAUq40do9mNMyVWJeMnkEk7qlJ7U0PLvy5hX/UzgReOigx6Edm6RI/tdb21hy5pUaUiII1BPiSH8cZCENdKahQo05Cp1kGhdkv0qH8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9420.eurprd04.prod.outlook.com (2603:10a6:10:35b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.30; Mon, 8 Apr
 2024 06:08:33 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 8 Apr 2024
 06:08:33 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Topic: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Index:
 AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNCAAItFAIAAEwgggABoGYCAAH0iQIAAaICAgAAAQWA=
Date: Mon, 8 Apr 2024 06:08:33 +0000
Message-ID:
 <DU0PR04MB94176D02B90528913842B76A88002@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
 <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org>
In-Reply-To: <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DU0PR04MB9420:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9BslPDNMiivEFqPhlh5LOP0JVSarItKxqpkOB9K5EFkv4CO9YXgGKbWVyS4CKdEqtd62f5fw74qX/XtCSFDSZDX8qWsp3QxHQsTOY8LpIr7ELp/uNGyeVLKpU6HGqYunNb8PryB+9tZWNzcsyLRsHKgn+HuaTUbTrTb8cx05+F5OmzThTWQSXgih99vYDlQ2yZT+WWii3xvQ8iiWJF6vCUtj/AWcw6r2NIBXs6lKCOWdsOaeKemuwLmK+YC6x35FFf7medufg4U9j607y6r9ZChg02UsbdorTNiERQYQ1hetbC5CpmXblhxWr5FacAkHqfT21O11G/lGsfVm3+0+1cOHGgHTqKpHVGvVPhy+/nzR3uW5ubYi5wt/4pWXMxCw9dqbIKyRBE/rVnNqWEhucQvHwxFs8BX92P9w/8Ew6aDnO/oaPx7RCIKToehMgyQLi4R+fwzJRNQzRTARuikkKn2A/rzyQ6XKMNDBnZAdiRaR7sZN01LZc/xqsTnvp7c/YT5/xziHXVW2/v0fao0Dml9JPw+rOj29FgoauZz1rf+kejSy9H3n4E8t+H6i5NwTHlgwOoLTLd8iG8HBuczZpbc+aIelrbwNfQp8gTawm0OAMRij4saR8V2wQimZHTZS1FPSFU6hqtjbX/gaa/E73zFOiXKTEYHlImOVoj+XJr4L0QshcuUO3uoSDbNsXTJWHtAIVG9AzSLFmDb+mqbeEA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WFJBbVRtVWQ4ZXFGSGVXLys4dHJKakVnT0Nqbkl1R1BzanNjQ0l5TnVueXh5?=
 =?utf-8?B?aE5YZ05rNklNTmQ2RDUvN0pQbjJ3SGdQMVkvbVV2MENMQXNXVjQrNktwZk9D?=
 =?utf-8?B?Vk5mYTRKaitwREh6bjNZRm11L0o5ODlYbUVjWlh2N1VKVGt6M1YwZWJzNTJO?=
 =?utf-8?B?Qm5xNGpZSG5ZRHlDcERSQUhoYVRaeTZGNUV6MUpkb3FiSzVxTTdVZGFBd0xi?=
 =?utf-8?B?NnJFTjBMTHZpalBhUUhOaW9ldVhqcUR1MG9xdUdINDgvYzJqd1MvL3g0SHla?=
 =?utf-8?B?dXZtdkdPb2pWSFVSN2ppN2g2dlZ6UVJVWTVNcVZNSkFJanExbWVLR1Bub2hp?=
 =?utf-8?B?TzkyYmZ5ZURaVFJVTUxOdTVRS2xrMCtRYkZkWjdjeXFWRnlUNCtSZzJFRDlz?=
 =?utf-8?B?aFE3UDgrWksxMm53c3RwVjF2ZVQvclRUZE1FMjN2WmxVMDBYaldySmd0aFBK?=
 =?utf-8?B?L2hqcmgxcnZXVDJIN2N4SEg3R1dJeVBtSWdkQlI2emhvWmZCSkpmUEZveHlU?=
 =?utf-8?B?aWhEcld4S0pzN3J4RmFYY2RtMkVmUWoyZ2FaOVhWekVvUzVKUkNuU1gvUWda?=
 =?utf-8?B?Q0I2cTh5RXpqWGh4YVlnYTc3eW9KRDZxTDg5WG5uVUxydnloTnZuNENZOTNl?=
 =?utf-8?B?eWxBUlE5TGcwTHc5WktURzJhUWlRbE9RMEFRanl0YloyUkVWZm5KUi93Y2No?=
 =?utf-8?B?TndCaVFNWVpzejhKM1plbURqVlNrYWlCWFpnM292bDJhZmNlbUZZSXB0NDU5?=
 =?utf-8?B?TmJKSmNFQXNmckZMWlBZUi9UN0V3R2RWRHhuK1k3aFFld0MyMFBkajJHZDFN?=
 =?utf-8?B?ME9lWEVyczhhR1VPTGwvNGtzMkpHRDBvUUhzU0FPU3JGNDBvUXZiblJPdHpk?=
 =?utf-8?B?VHU0MjFpWGRVcWZCeGN6NVE4OStPRHdGVE9TNzRUVXkvRlY2ODMrSzJHN2RG?=
 =?utf-8?B?ZjNSN09LdmsvNHZjQjd6QjJEUFkxcHhvN2RqUWo2SGhZN01UV0hnbElSNkFP?=
 =?utf-8?B?V0FrZlc0WDFzTnlYWERveUp1b1RFNWtxQmdyR0lSNnZ3Zi9aNXVjeitsSVNs?=
 =?utf-8?B?WGx6Nm5weGJrdEdyc2syTjZrYzdKRUZJc21HL3JuRnJ0UUJFaEVFaHN2TCtO?=
 =?utf-8?B?L1ZlTHh0Y0VZNFd4WnFuQmxpaS8ycDhSa0pYYzRRRytNLzBGYnQ5cnMrQnFk?=
 =?utf-8?B?Uy9EVDdORmpXRE43d3NPQ25EUmNFamlHcmEzNzdieVRLZkdYelpwRGJieFNH?=
 =?utf-8?B?SllTMkMra3IrZmRyTThDS3VPVU1nT1VzS0pBb0xRbEc4ZUZPcm9oLzgxNFBT?=
 =?utf-8?B?bVNTWmlyV0QrZkY2NlF0aTFmMjh4R0tjOWllc1pyWnNBVCt1N0VZeTU1LzJY?=
 =?utf-8?B?QVg3Sk91alRWSmVVdTRFemxjN21QWjhLdE11c0xWeU04clpPNkJiQVFMTlJ1?=
 =?utf-8?B?T3BFS1hpUDN6N0Jrd1czS3R0Wi9DN1k3allqMUxxT09ZK3BObDBWZkxaVXov?=
 =?utf-8?B?Q2NOYjhoTTc0bDA0Uml5TmFZa1lzQW52Y0N3YXV0VEx5TW5xeUZ4ZVd3T1N5?=
 =?utf-8?B?VU01ajRDTzNVRFkvOHRhWDVHRjRuUWRqQmxjNjdicHIxRTVxQURLY0RLdjUw?=
 =?utf-8?B?Wkh5Y0U3QlNzc2FVZ2ZRemZYd3c4RUVxdmN1MjdGeGxQYVJSczRJdVFxbVhE?=
 =?utf-8?B?cXErMENieWFrNXVvdUhTdHYreERIQ0t2QW4wYllURWk3RTMvR1lyS2thLzJp?=
 =?utf-8?B?RWhQU1FzS1pScXA5MlZyaFcrMk9vSWFFSHpBbGtJT3NXc2o0cFVvNFYzTjNO?=
 =?utf-8?B?U0NFK1R3NGM3YUVzL0dnREVXYjQ4RnNmWlFBcTNxMHkxQ3k3aWFPbWU3OUNs?=
 =?utf-8?B?Y3FqbCtnVVAydFFOTmNWejRnZ1loc3pUNVEweUFCNElvZkRBSHl3MXdEVktE?=
 =?utf-8?B?cmpsY0s3Mk51TElxVk1mU0pKUm1HWXFSaERVdFVWaVp4eDllV3NHVkVRbUl1?=
 =?utf-8?B?andPU1M0NjZ5M3pRVENFaFZKbUMrWkVudU52UWJWWm5HaVBXbm4rZkNGMU5h?=
 =?utf-8?B?WEsxdEg2M09GdmVzQVNJdHZNcStIMFBXVVA1aU9wWXppdTB3ZmM3aU5RVk4z?=
 =?utf-8?Q?WbkA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 066243d9-1661-477c-12a1-08dc57925214
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 06:08:33.3572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ZElr8oMC0p7A9XTOLmd91+fFpI4esabofdT93hlTtS0iLHr/9LxxlJXxCP5dvu4wC1Ruah3OGHjum0TLvpAPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9420

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0s
c2NtaTogc2V0DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gDQo+IE9uIDA4LzA0
LzIwMjQgMDE6NTAsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0sc2NtaTogc2V0DQo+ID4+IGFkZGl0aW9u
YWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPj4NCj4gPj4gT24gMDcvMDQvMjAyNCAxMjowNCwgUGVu
ZyBGYW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRp
bmdzOiBmaXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+Pj4+IGFkZGl0aW9uYWxQcm9wZXJ0aWVz
IHRvIHRydWUNCj4gPj4+Pg0KPiA+Pj4+IE9uIDA3LzA0LzIwMjQgMDI6MzcsIFBlbmcgRmFuIHdy
b3RlOg0KPiA+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRpbmdzOiBm
aXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+Pj4+Pj4gYWRkaXRpb25hbFByb3BlcnRpZXMgdG8g
dHJ1ZQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDA1LzA0LzIwMjQgMTQ6MzksIFBlbmcgRmFuIChP
U1MpIHdyb3RlOg0KPiA+Pj4+Pj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0K
PiA+Pj4+Pj4+DQo+ID4+Pj4+Pj4gV2hlbiBhZGRpbmcgdmVuZG9yIGV4dGVuc2lvbiBwcm90b2Nv
bHMsIHRoZXJlIGlzIGR0LXNjaGVtYQ0KPiB3YXJuaW5nOg0KPiA+Pj4+Pj4+ICINCj4gPj4+Pj4+
PiBpbXgsc2NtaS5leGFtcGxlLmR0Yjogc2NtaTogJ3Byb3RvY29sQDgxJywgJ3Byb3RvY29sQDg0
JyBkbyBub3QNCj4gPj4+Pj4+PiBtYXRjaCBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVsw
LTldKycNCj4gPj4+Pj4+PiAiDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTZXQgYWRkaXRpb25hbFBy
b3BlcnRpZXMgdG8gdHJ1ZSB0byBhZGRyZXNzIHRoZSBpc3N1ZS4NCj4gPj4+Pj4+DQo+ID4+Pj4+
PiBJIGRvIG5vdCBzZWUgYW55dGhpbmcgYWRkcmVzc2VkIGhlcmUsIGV4Y2VwdCBtYWtpbmcgdGhl
IGJpbmRpbmcNCj4gPj4+Pj4+IGFjY2VwdGluZyBhbnl0aGluZyBhbnl3aGVyZS4uLg0KPiA+Pj4+
Pg0KPiA+Pj4+PiBJIG5vdCB3YW5uYSBhZGQgdmVuZG9yIHByb3RvY29scyBpbiBhcm0sc2NtaS55
YW1sLCBzbyB3aWxsDQo+ID4+Pj4+IGludHJvZHVjZSBhIG5ldyB5YW1sIGlteC5zY21pLnlhbWwg
d2hpY2ggYWRkIGkuTVggU0NNSSBwcm90b2NvbA0KPiBleHRlbnNpb24uDQo+ID4+Pj4+DQo+ID4+
Pj4+IFdpdGggYWRkaXRpb25hbFByb3BlcnRpZXMgc2V0IHRvIGZhbHNlLCBJIG5vdCBrbm93IGhv
dywgcGxlYXNlIHN1Z2dlc3QuDQo+ID4+Pj4NCj4gPj4+PiBGaXJzdCBvZiBhbGwsIHlvdSBjYW5u
b3QgYWZmZWN0IG5lZ2F0aXZlbHkgZXhpc3RpbmcgZGV2aWNlcyAodGhlaXINCj4gPj4+PiBiaW5k
aW5ncykgYW5kIHlvdXIgcGF0Y2ggZG9lcyBleGFjdGx5IHRoYXQuIFRoaXMgc2hvdWxkIG1ha2Ug
eW91DQo+ID4+Pj4gdGhpbmcgd2hhdCBpcyB0aGUgY29ycmVjdCBhcHByb2FjaC4uLg0KPiA+Pj4+
DQo+ID4+Pj4gUm9iIGdhdmUgeW91IHRoZSBjb21tZW50IGFib3V0IG1pc3NpbmcgY29tcGF0aWJs
ZSAtIHlvdSBzdGlsbCBkaWQNCj4gPj4+PiBub3QgYWRkcmVzcyB0aGF0Lg0KPiA+Pj4NCj4gPj4+
IEkgYWRkZWQgdGhlIGNvbXBhdGlibGUgaW4gcGF0Y2ggMi82IGluIHRoZSBleGFtcGxlcyAiY29t
cGF0aWJsZSA9DQo+ID4+ICJhcm0sc2NtaSI7Ig0KPiA+Pg0KPiA+PiBTbyB5b3UgY2xhaW0gdGhh
dCB5b3VyIHZlbmRvciBleHRlbnNpb25zIGFyZSB0aGUgc2FtZSBvciBmdWxseQ0KPiA+PiBjb21w
YXRpYmxlIHdpdGggYXJtLHNjbWkgYW5kIHlvdSBhZGQgbm90aGluZy4uLiBBcmUgeW91cg0KPiA+
PiBleHRlbnNpb25zL3Byb3RvY29sIHZhbGlkIGZvciBhcm0sc2NtaT8NCj4gPg0KPiA+IFllcy4g
VGhleSBhcmUgdmFsaWQgZm9yIGFybSxzY21pLg0KPiA+DQo+ID4gIElmIHllcywgd2h5IGlzIHRo
aXMgaW4gc2VwYXJhdGUgYmluZGluZy4gSWYgbm8sIHdoeSB5b3UgdXNlIHNvbWVvbmUNCj4gPj4g
ZWxzZSdzIGNvbXBhdGlibGU/DQo+ID4NCj4gPiBQZXIgU0NNSSBTcGVjDQo+ID4gMHg4MC0weEZG
OiBSZXNlcnZlZCBmb3IgdmVuZG9yIG9yIHBsYXRmb3JtLXNwZWNpZmljIGV4dGVuc2lvbnMgdG8g
dGhpcw0KPiA+IGludGVyZmFjZQ0KPiA+DQo+ID4gaS5NWCB1c2UgMHg4MSBmb3IgQkJNLCAweDg0
IGZvciBNSVNDLiBCdXQgb3RoZXIgdmVuZG9ycyB3aWxsIHVzZSB0aGUNCj4gPiBpZCBmb3IgdGhl
aXIgb3duIHByb3RvY29sLg0KPiANCj4gU28gaG93IGFyZSB0aGV5IHZhbGlkIGZvciBhcm0sc2Nt
aT8gSSBkb24ndCB1bmRlcnN0YW5kLg0KDQphcm0sc2NtaSBpcyBhIGZpcm13YXJlIGNvbXBhdGli
bGUgc3RyaW5nLiBUaGUgcHJvdG9jb2wgbm9kZSBpcyBhIHN1Yi1ub2RlLg0KSSB0aGluayB0aGUg
YXJtLHNjbWkgaXMgdGhhdCBzYXlpbmcgdGhlIGZpcm13YXJlIGZvbGxvd2luZw0KU0NNSSBzcGVj
IHRvIGltcGxlbWVudCB0aGUgcHJvdG9jb2xzLg0KDQpGb3IgdmVuZG9yIHJlc2VydmVkIElELCBm
aXJtd2FyZSBhbHNvIGZvbGxvdyB0aGUgU0NNSSBzcGVjIHRvIGltcGxlbWVudA0KdGhlaXIgb3du
IHVzYWdlLCBzbyBmcm9tIGZpcm13YXJlIGxldmVsLCBpdCBpcyBBUk0gU0NNSSBzcGVjIGNvbXBh
dGlibGUuDQoNCiANCiAgICAgICAgZmlybXdhcmUgeyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAN
CiAgICAgICAgICAgICAgICBzY21pIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAg
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXJtLHNjbWkiOyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAg
ICNhZGRyZXNzLWNlbGxzID0gPDE+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICNzaXplLWNlbGxz
ID0gPDA+OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAg
ICAgICAgICAgICAgICAgICAgICAgIHNjbWlfZGV2cGQ6IHByb3RvY29sQDExIHsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MTE+OyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgI3Bvd2VyLWRvbWFpbi1jZWxscyA9IDwxPjsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgIH07ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICANCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICBzY21pX3N5c19wb3dlcjogcHJvdG9jb2xA
MTIgeyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDEyPjsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAg
ICAgICAgICB9OyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICBzY21pX3BlcmY6IHByb3Rv
Y29sQDEzIHsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDEzPjsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICNwb3dlci1kb21haW4tY2VsbHMgPSA8MT47ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICB9OyANCg0K
ICAgICAgICAgICAgICAgICAgICAgICBTY21pX2JibTogcHJvdG9jb2xAODEgew0KICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4ODE+OyAgICAtPnZlbmRvciBpZA0KICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdmVuZG9yLHh5ejsgLS0tPiB2ZW5kb3IgcHJvcGVydGll
cy4NCiAgICAgICAgICAgICAgICAgICAgICB9ICAgICAgICAgICAgICAgICAgICAgICAgICANCg0K
VGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KDQo=

