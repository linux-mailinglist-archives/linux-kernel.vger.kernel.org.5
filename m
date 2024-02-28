Return-Path: <linux-kernel+bounces-84507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDBF086A79C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 05:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A684B26559
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C243B208CF;
	Wed, 28 Feb 2024 04:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="drHBtIM7"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2051.outbound.protection.outlook.com [40.107.21.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA74208A8;
	Wed, 28 Feb 2024 04:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709094254; cv=fail; b=boqskjZZg4zDC6Dlza0FMREuQFUCv75JiiLRYUhxc6pYs9wSL9a/WvVX+0a37OdJ5mVOZBfC5IAqO9nYA3746MogU2/dAKOZqRSamyCwKgjoP6KmSh7AL3Yl5bCx2ysQt+2Asr8j1OUhFnK2d6phXuZs+w2Mat60PzZ2UfAbG28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709094254; c=relaxed/simple;
	bh=IAtaOg9fuMtzoG94/9wAQ51f2yhx3D1wHkFJGNPuNTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ejKmSgbD3txlYURxvnoZfObmBuuR3/7O01Fl7TNUw42ph2cqUv3fzzmtIQhGlYCKgUeSL+vuLOvQCffU882iyam8/llnKNdPXfjyy5jXZzHRZGYfkj0utzzhpPyZEz8O64tnpJBsnXnn8b230tAmdF/Q3u8jxD1JztD0HNpAL1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=drHBtIM7; arc=fail smtp.client-ip=40.107.21.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRURwF0iNyoyWS48YJvduOu8425tmP5B9aPxOTUpOlCf7HVijSEP6L6yzB/OR5SojcyY9NxiSEMNRLVUibFgeCxj+Xby+lF5km9khM0aSd2RMhwMV0NvMsXw02WPxtSbxRC2vp+WpghPADft75N1kHPlED80k2S4afIQDhvIzp+hlmpmItAibipK4JEQzOEBUqatgAhtZwmlulZbAvsIhBfAx29vP6LiFI1w/yVSIY0tkSzfetmPttDuy+9veFsNEYh8AMI+SBR0EIhLzLFdBu84pEsJZ0rHnynOWRdehdpOJoYUyyXlXhybhXuGHahDtdIljv/NBrQ4VVOYlWnCpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IAtaOg9fuMtzoG94/9wAQ51f2yhx3D1wHkFJGNPuNTE=;
 b=cWQWroZ7V0r0YTL4gU8LIPuYVyZoHQ1WJVPdPbMxoVw+7xRZ/rtORMGb26C9aJe5BWxvgR2IRMowSVfT2rI/tUR+aTvAf1751oFMwk5zCBuTXdPZeNbT27Nl8G6RaHdHzg+6JQGNP0TCz8v/VJc6pP94FlCZorVIVvNdtb9XvhpWnnuA3TXSVU7V0zaZJkhsmrjnZPypSed/yGFhnYxunAuDT5OatZwyTtP+DwcvwWcSGOR3ZIR5pUUIgmsd6Zf5zqtbymMxFhuzcgwxiZ1Aj4qgXZEpw483Gvlt9cWUfXMcz3fDPBO4U03mtexGkrM/NUq4Dk41JK+9vngRgmr/gA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IAtaOg9fuMtzoG94/9wAQ51f2yhx3D1wHkFJGNPuNTE=;
 b=drHBtIM7PyYRiBBlbSZsYKtjDgesf3JX9v3eqYLJrEtks1cf9mrDgRUTO/45t7aCK1iguXNRzf2nrsfyi4EJCoax/pDYC8oBA+lP1/bzDTG7GZi6bUOtPGacODuC2ekUD6y0r25lHgUnYNnglUxDJyBvxzwBYxp1I1wrmbuS9+Q=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GVXPR04MB10071.eurprd04.prod.outlook.com (2603:10a6:150:11a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Wed, 28 Feb
 2024 04:24:09 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 04:24:09 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Jassi Brar
	<jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Conor Dooley
	<conor.dooley@microchip.com>
Subject: RE: [PATCH v8 0/5] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH v8 0/5] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaYvJ+W018hrrRyEeLvyiF5Ukb+rEfNgww
Date: Wed, 28 Feb 2024 04:24:09 +0000
Message-ID:
 <DU0PR04MB9417C49D8168FC905AC6FF8E88582@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
In-Reply-To: <20240219-imx-mailbox-v8-0-75535a87794e@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GVXPR04MB10071:EE_
x-ms-office365-filtering-correlation-id: 075b0a9f-c86c-4f94-0ad1-08dc38151bfe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PxjmZ/1mVCTLhe9GK4q8VAnJ6aiSFOsJTTkkZxaV+b7q1oizA21TCkQKk3O8vrdfHRyuh0fjfFD9SKSaG4EO+Db/4BO2DvVozx9ZRsiKP+bPZkp4khH2Q7Y9x/hgoAcPSERAPGBJTMduZlY+U9xk6SJrGB6yieRPfWjeDeoG72biNNmQXfE5LSGOEfvWesX0M7RaAV5YP3xPifE4Ga9pfyGfMrBtWJoyBegZW4oEop+gwe3Nvp+bm5Qjad+4A8RyIczSDBWorUsNfHsTYyQC2w0XbW3UcYTwTXfDFMl+YZn+bGDvq+EF7wrAEDyQ9fNrCZalrVw+0oq0dpYzLkliTV5zS2M1352Y/4/2rrZjvkQlVjA7iucySXGfws2mFw+y7ZzKZJf8XhMb2FIVtU4RCNZnUfRsLmhIAYALXhTYBeeIZ2nzXDltB1kDarpCeerCktUYCeucbALY9gHudeBxDnIdGHucb9TR46GIlWD4AIA0N0AMJHIlCLs1nfp6ePW+7sb7WHM+pH5d6KZttt95XHgyhL1IljlEdAAHnQCnSKqaxptJGFpVXYehgrt9xSOQ020qsENYBm7aWmWLKPuAXZlo96MUykH2ahCGjYNGS8ypQDzlmshVIvt5usPHRNnkaOAeUURS+fpK4w4/BwImH9DqQUCuHombQ5tcnKUEkXTsu/+cbp1LoPM+0vxkqEOknnZMSknbPZS5lCfbdyohp+aqpmWCIaBtbAOX58SaCFw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UDdYZXJzY0lJZk9kWHEya2tzR2NuT3pXSUpnM3lUb0JZd2gyTnBFTDRMQW5x?=
 =?utf-8?B?K2tseGJmdk91RjViejJENVlaY3IyZmpndHZXak5sYSt2MTBGMzNVQWpCVkVK?=
 =?utf-8?B?MWsvY042eXNzWUhtajJadnRpaTIyL2lrRmpzdlRHL2UrZEwvQjNpaXJ1VC9v?=
 =?utf-8?B?YlJYamFyVnFyQ1BDVFJUbjNnR1FlSUZLTlhjU1FtTlh0a1ArblcycW5vcDA0?=
 =?utf-8?B?QmhqOXdsNEdlejF1T0J4T3M4Rkd5Q2s0dnVVRFlUZVdpR0pmOTJMbEY3Vyt2?=
 =?utf-8?B?anVaUEFYb3NZUE1hSWpZYU82YVJXOFMvaitQNUxXRUFJMU1mN0tobllTVWMy?=
 =?utf-8?B?TjBZc3NncUQwL2RjVUw4ZDc4RkkvQlFlakEzRkRDY05XaUhqTlN2UjduNG1i?=
 =?utf-8?B?aTVCbm01c1hMbzlGM1J6QXlLcHp2RXlDVkNxZU1weXBtRzJ5QlhBZVhEcWNn?=
 =?utf-8?B?bGk2T1R3TlFhMUYzQnp6V1hocTFXd3NBcEVVclZBSXF0bjljK1g4eFc2R2tX?=
 =?utf-8?B?aEpIUTNCWnJCUWUrTXVteWxWL0s1T2tMakc5dGl2U1NvSkpaMmN0dUV1RW5I?=
 =?utf-8?B?UTlhcDVjalExay9nN0ppYjhxYnF1bDlIQStYNFdBZUIxeW9HRi9wQUk4djAx?=
 =?utf-8?B?dlc3RXQweWJQQjlHTlBsM1B3TmR5UGg3em84Q2h3b3B0dG90THl3NG9XdXJI?=
 =?utf-8?B?MDlzNkZ5THJWV1NXK29ueFdiZjJHL0JIN1hPS1gwenNzSGJJb3hGQTdyaXli?=
 =?utf-8?B?TFl6bnBoSU1ybjJNQTlwWmhJYnByN213YzhmTUpWVzdUSWJUcUl1RmsycnVJ?=
 =?utf-8?B?SzMvcU52OHpyazFqa2NDTitPdE9ndXRiTlhFcUVDUWczWmM4ZmV1bGszTlFy?=
 =?utf-8?B?UmZhQnhPSnBNZnhkVGEzWW1KL2FKSWs3NDk5cDZTaHUyMG14alVpSWF4c29u?=
 =?utf-8?B?ZlFUOFNzT01Wd3lmbmdVNXdOU3h3UElLSzNvczNRUGlmcWJMZ2VTbnFFUito?=
 =?utf-8?B?emVTakZ6RnRpdFMydi9KZ1dyYXZXWk5uSXFTcW1uaGVXeERvZ1M0MU14MVBz?=
 =?utf-8?B?STB5REJKK1JMSVlYQ05ucDBENkZxeWYreVBjTTYvR0lTR2cyeGMrMDkyZDBS?=
 =?utf-8?B?YXdoZ2Foc01lOHVmdkRuT04yNjlDRnlyT1A3T3hLdW1iNndGVVZadUYrUkp5?=
 =?utf-8?B?Zlh6ZmhuVVpWd2Rya3R0S1piUjdyb1YxeHA1RENGTGJPK3VWTVZwZExZcEV4?=
 =?utf-8?B?eHFxcEtwdjB0K3QwQkQ2ZUxLdGdrR0VXVm4wZG8xeW5CeTl0VUZwcHVRN2Jp?=
 =?utf-8?B?WDdEdW5paDZoSDQ3dndBSWdoYVFBcmtWMUJSdFBiMXdqbExwYURpemp3b05s?=
 =?utf-8?B?dmJqN2tNUDhrVVplakVva25HZzY4NzVCUWJKOE5LMXhBc1hvWUhKQjhPY2JL?=
 =?utf-8?B?NDkxZlhPK3ZBeUxDd2VvN1doZ3YvVnREMjlTWkpDTnpHbVhkNHZJS3BmbVAv?=
 =?utf-8?B?K21iek83aW5CbHZGVVJ2OUxOUm5tbGMxTVFJNFFIcXJGNS9Jd1VHRXFQL1Q3?=
 =?utf-8?B?dmFPdmFVbDk2cHZvZ2NuaTNuMzNseTJDcXJiWUIxVWVReGdKOEdxVmZENTRJ?=
 =?utf-8?B?NGpHWEJkMFY3eHNxY1YyZzgrRHNTVUFkWWdKTkxLeEVMZ0djdnF5Z3ZibUxS?=
 =?utf-8?B?OURyT3hGNEgzQkZjZzFMN1E5Vy9FZUVhQlJKRG40TG92U0NoeDZDR2xQRW9D?=
 =?utf-8?B?S01BTEFSZllwc3JhNUxNVlp1amZpdmtQNngzYzFKVlV3S2dsb3ZjUVVwMDMz?=
 =?utf-8?B?bStZSzVSRnU5U3crYUxPUlBqdnpMZ1RnR0gvTkl1ZjlnU0RaTDFBdFVwTVpm?=
 =?utf-8?B?amwxZGhEcld4UU5ZS2srNU92Z1BtdWxXNndRaG5CV2VPZjNqL2ZHcElxZ3Yy?=
 =?utf-8?B?c3pFTUlKZm8yYTN4SG42TjVXSVFaU0NMZ2d4cUVpc0U5bGNpeDF4emJFajBJ?=
 =?utf-8?B?VmZtNUpPVFNCZW45TFRnUHo3OVFFM1J5R2NWVFQ1K3I3VEdaazJGNkE2c25H?=
 =?utf-8?B?bFVFVzduT1FSamZMaGJXU0RWS2tqSHk3VXFpaDM2YkdubEs0amY5bG1lQU5p?=
 =?utf-8?Q?PxqU=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 075b0a9f-c86c-4f94-0ad1-08dc38151bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 04:24:09.4739
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bBar4hIVx+xUCeiLdi+7p5cgNUzNz2wid3S1kDwGtqwUMlR54uG0KFgiUaTLtNR5rMvzSFyUjZNBwHeDAwXykw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB10071

SGkgSmFzc2ksDQoNCj4gU3ViamVjdDogW1BBVENIIHY4IDAvNV0gbWFpbGJveDogaW14OiBzdXBw
b3J0IGkuTVg5NSBFTEUvVjJYIE1VDQoNCklzIHRoaXMgcGF0Y2hzZXQgb2sgZm9yIHlvdSB0byBw
aWNrIHVwPw0KDQpUaGFua3MsDQpQZW5nLg0KDQo+IA0KPiAtIEFkZCBkdC1iaW5kaW5ncw0KPiAt
IGkuTVg5NSBFTEUvVjJYIHVzZSBzYW1lIHJlZ2lzdGVyIGxheW91dCBhcyBpLk1YOFVMUCBTNCBN
VSwgYnV0DQo+ICAgdGhlIFRSL1JSIG51bSBpcyBkaWZmZXJlbnQuIFRvIG1ha2UgY29kZSByZXVz
YWJsZSBhbmQgbm90IGFkZCB0b28gbXVjaA0KPiAgIG1hY3JvcywgYWRkIHJ1bnRpbWUgZGV0ZWN0
IG51bWJlciBvZiBUUiBhbmQgUlIgYnkgcmVhZGluZyBQQVJfT0ZGDQo+ICAgcmVnaXN0ZXJzLg0K
PiAtIEFkZCBpLk1YOTUgRUxFL1YyWCBNVSBlbnRyeSBpbiBkcml2ZXINCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
ODoNCj4gLSBEcm9wIFtwYXRjaCB2NyA0LzZdIHdoaWNoIGlzIHdyb25nbHkgaW5jbHVkZWQgd2hl
biBkb2luZyBjbGVhbnVwLg0KPiAtIExpbmsgdG8gdjc6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L3IvMjAyNDAyMTgtaW14LW1haWxib3gtdjctMC0NCj4gOGZiNjY1ZWVhZTQwQG54cC5jb20NCj4g
DQo+IENoYW5nZXMgaW4gdjc6DQo+IC0gUGVyIEphc3NpLCBzZXBhcmF0ZSB0aGUgcGF0Y2ggdG8g
YWRkIG9mX3BsYXRmb3JtX3BvcHVsYXRlLg0KPiAtIExpbmsgdG8gdjY6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNDAyMDEtaW14LW1haWxib3gtdjYtMC0NCj4gNzZmNGYzNWI0MDNlQG54
cC5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjY6DQo+IC0gRHJvcCBub2RlIGxhYmVscyBhbmQgYWRk
IENvbm9yJ3MgUi1iDQo+IC0gTGluayB0byB2NTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8y
MDI0MDEyNi1pbXgtbWFpbGJveC12NS0wLQ0KPiA3ZmYzYTNkNTM1MjlAbnhwLmNvbQ0KPiANCj4g
Q2hhbmdlcyBpbiB2NToNCj4gLSBQZXIgQ29ub3IsIGFkZCByZXN0cmljdGlvbiB0byBzcmFtIHBy
b3BlcnR5Lg0KPiAtIFNpbmNlIGkuTVg5NSBNVSBoYXMgU1JBTSwgd2UgbWF5IG5vdCBzZWUgaXQg
aXMgY29tcGF0aWJsZSB3aXRoIGkuTVg4VUxQDQo+IE1VLCBzbyBkcm9wIHRoZSBmYWxsYmFjayBj
b21wYXRpYmxlDQo+IC0gQWRkIFItYiBmb3IgcGF0Y2ggMiYzDQo+IC0gTGluayB0byB2NDogaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDEyNS1pbXgtbWFpbGJveC12NC0wLQ0KPiA4MDBi
ZTUzODNjMjBAbnhwLmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2NDoNCj4gLSBBZGRyZXNzIGR0LWJp
bmRpbmcgY29tbWVudHMgaW4gVjIgZnJvbSBLcnp5c3p0b2YNCj4gLSBMaW5rIHRvIHYzOiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTIzLWlteC1tYWlsYm94LXYzLTAtDQo+IGVkOTMy
OTQ1ZTBiZkBueHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYzOg0KPiAtIEZvbGxvd2luZyBkdHMg
Y29kaW5nIHN0eWxlIFBlciBLcnp5c3p0b2YNCj4gLSBBZGQgcmV0dXJuIHR5cGUgZm9yIGluaXQg
ZnVuY3Rpb24sIHBhdGNoIDIgaXMgbmV3DQo+IC0gQ2hlY2sgcmV0dXJuIHZhbHVlIHdoZW4gdHIv
cnIgaXMgbGFyZ2VyIHRoYW4gNCBhbmQgcmV0dXJuIGVycm9yLg0KPiAtIExpbmsgdG8gdjI6IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjItaW14LW1haWxib3gtdjItMC0NCj4gN2Iz
YzgwMzMzYjkyQG54cC5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjI6DQo+IC0gU3VwcG9ydCBzcmFt
IHByb3BlcnR5IGFuZCBhZGQgZXhhbXBsZQ0KPiAtIFBvcHVsYXRlIHRoZSBzcmFtIG5vZGUgaW4g
ZHJpdmVyDQo+IC0gTGluayB0byB2MTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDI0MDEy
Mi1pbXgtbWFpbGJveC12MS0wLQ0KPiA4MTQxM2Y2NTUyMTBAbnhwLmNvbQ0KPiANCj4gLS0tDQo+
IFBlbmcgRmFuICg1KToNCj4gICAgICAgZHQtYmluZGluZ3M6IG1haWxib3g6IGZzbCxtdTogYWRk
IGkuTVg5NSBHZW5lcmljL0VMRS9WMlggTVUgY29tcGF0aWJsZQ0KPiAgICAgICBtYWlsYm94OiBp
bXg6IHN1cHBvcnQgcmV0dXJuIHZhbHVlIG9mIGluaXQNCj4gICAgICAgbWFpbGJveDogaW14OiBn
ZXQgUlIvVFIgcmVnaXN0ZXJzIG51bSBmcm9tIFBhcmFtZXRlciByZWdpc3Rlcg0KPiAgICAgICBt
YWlsYm94OiBpbXg6IHBvcHVsYXRlIHN1Yi1ub2Rlcw0KPiAgICAgICBtYWlsYm94OiBpbXg6IHN1
cHBvcnQgaS5NWDk1IEdlbmVyaWMvRUxFL1YyWCBNVQ0KPiANCj4gIC4uLi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21haWxib3gvZnNsLG11LnlhbWwgICAgICAgIHwgNTggKysrKysrKysrKysrKy0NCj4g
IGRyaXZlcnMvbWFpbGJveC9pbXgtbWFpbGJveC5jICAgICAgICAgICAgICAgICAgICAgIHwgODgg
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0aW9u
cygrKSwgMjMgZGVsZXRpb25zKC0pDQo+IC0tLQ0KPiBiYXNlLWNvbW1pdDogYWQ1YzYwZDY2MDE2
ZTU0NGM1MWVkOTg2MzVhNzQwNzNmNzYxZjQ1ZA0KPiBjaGFuZ2UtaWQ6IDIwMjQwMTIyLWlteC1t
YWlsYm94LTI0MzAyMWQxMjAzMA0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBQZW5nIEZh
biA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K

