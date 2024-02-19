Return-Path: <linux-kernel+bounces-70729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEE7859B9A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 06:16:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D713A1C20FBC
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 05:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA1C9200D8;
	Mon, 19 Feb 2024 05:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NmFTFzLW"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2057.outbound.protection.outlook.com [40.107.13.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA7D200C3;
	Mon, 19 Feb 2024 05:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708319707; cv=fail; b=uYRB3aClLzlSLPrk8OLgPkgMj4zEOyfOnmxE7yoKmJdekQqm3BD7xFhnBC6o9m1s+zzYmVSb8TXQaAI7ePUkr2qnn42+4PbLcaPkJXie3kOMVB26IsGE02zc+Sbo/7HLDY7Ot7gIvB51ady2dUyIMfedy/ojPNX0GtO7AcxqeUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708319707; c=relaxed/simple;
	bh=d4W1dv7nmGL0v7ATNg2zXwKBOc5r2Cuxc8bsIW5WTjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lKGtQW4u85FxBEZWwEmwLA/aQ/ORl4IEbJcL1NavSUHtOJnk0xiacV8VlKu7HoIO50hgyNpNP4cgGXAfY8bg7feJFq6imOPkytjiZw6a0d5+GeWKHFKXlh6RCQHakGoRIWSVSCz6O/iJ73HP0i9tq/VhEx7h+4NKjjCZxyBXbXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NmFTFzLW; arc=fail smtp.client-ip=40.107.13.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NeOer+2/lR8H/kQvC0L/xsgotHZHGb/AV+DnAJuI2q4YEHHWXKBvOfqOTz950Utj/HOGxelL8lY2d8snRzkHIxDUC0JwMSTi4kjGYElECyB5nm3ezDPAAlCtcDYBV2IOI5YG2YPp52zB5KgDvTx4rSkPC1vkNt/D76Y0PbBf7D8SmPsEaczmvzIHtIvEvtWU54zpTI7ifW7gS3KLoAwPT7WeWmwJc99BBipL2fuiGnFVEOOkwCxQiHO2U9shJtg6UWpks+oYSPJtQ8TfOVfmKxi7Cm3dyVcszlQvpbfHdhyPe4heORAiOXlPOFSQ8MCiBP/7IoezTVXTt3DdtSCF1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d4W1dv7nmGL0v7ATNg2zXwKBOc5r2Cuxc8bsIW5WTjU=;
 b=h/hIPPjgyab1HKlOalwpkwOJ6aE79U1NkMoPCzpxg8fdEweQk8alpE2R7t2MSLruRQLDvQKpTxTf7t6uvCvPI1k2phFydN/djgy/jvmj38+eFjuYDpQLfYJgmkyBwQiYjelDLTpE5bBs6hFeITTmYdCOoSf/Ncvq/qTos4xlGxTlI6weyGBRWBaX215bvrQQVQzFbxiyqyPABEgoJchntRoEF0zLZmmGaxKUNIbqiTPJvTgi5M2p5RyBR8u0pyEnW2SIjTwVrtGOryOo9UPZv+DIHAZG3p7cfwOMD/v6o93V+gYY26MfEM6k7WPAY4Cc7Dl3r1xqjCcDM7yJ3hdmBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d4W1dv7nmGL0v7ATNg2zXwKBOc5r2Cuxc8bsIW5WTjU=;
 b=NmFTFzLW96T/Z1HKEG7/kXk5pEh3klwLhXAOYRrvEYm+X7YLbmcke4q0QeLYdutXvwQsy1pIifdv072feKo0+DqKK6Ev52oht7YdRYQy+K92LfV7a2ZoV75Ruwf69BRKDiEP/THlgzRm/WPTgvDGtiRXD4dJDArp4C/lvuRtf5M=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7228.eurprd04.prod.outlook.com (2603:10a6:102:8c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Mon, 19 Feb
 2024 05:15:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::4ac3:3559:4200:38e1%4]) with mapi id 15.20.7292.033; Mon, 19 Feb 2024
 05:15:03 +0000
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
Subject: RE: [PATCH v7 0/6] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Topic: [PATCH v7 0/6] mailbox: imx: support i.MX95 ELE/V2X MU
Thread-Index: AQHaYjZrdbhxDF4X+kmKvZZDrsGuI7ERIMAg
Date: Mon, 19 Feb 2024 05:15:02 +0000
Message-ID:
 <DU0PR04MB9417D8EF014B45F31E497B0988512@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
In-Reply-To: <20240218-imx-mailbox-v7-0-8fb665eeae40@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PR3PR04MB7228:EE_
x-ms-office365-filtering-correlation-id: e283fe79-0a88-4899-c536-08dc3109ba5a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 ZqF2gUKBszFIHyMsbOKtrAbq5YzX2Bn1BE+pHbETh7D3OXCQmW1Z0V1xr6uUkwu6JT59OXThPYNK2YOpnU/WoLqROKI+Fg1z4+ihsOg9+qbgIzVcYDeTfEgQsNJkZd14dlE2ORtJBlSkxeU8CNxiTIaoLwQvIyRB6wGlWR2waF/3j7E34dnNL+mnNbH2AODVOMzbyvJaHaJmzFITBdT1WiJIruckl0OS6L6wxPClbyykSWXG3Se0LOpr+iyBGhacUi2RJPv+gT2xTT0TpRBNPhctHDKAiXdhYoud91HsRzcLOHIYRhknMosx4LaPPOaNEFvFjdGPaF/seuRGCbaNFAcupaU/4nXJB40LTPVY7mcNpGwmkKwISoN7SQWjHtn0dSNfcUB8zze1hZm3tQ5GnFPzhz1aDgkBk3JtesPqm9bvkpM3v5rzLeouqnm4WPga9WRcraPTNsDRw9/VK1wI9qzb31v07QUzVDbp5m/9pLIAheyuOVQNqIat4EcqWGdmUYr4jt9eOHqEts5MsLO0pri7k/3qwVFeS1sSiZuvodmxxgjyEcz/G67c+E61piF7j6kS/aNEOdJxKi5qZ+IbUZecApP5QwTDBSPrNe+RfWyzcfnmzM043rPNe2o75wXk
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(136003)(366004)(39860400002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(41300700001)(71200400001)(55016003)(8676002)(4326008)(2906002)(52536014)(8936002)(66476007)(76116006)(66946007)(7416002)(66556008)(64756008)(66446008)(38100700002)(5660300002)(15650500001)(86362001)(44832011)(6636002)(316002)(122000001)(54906003)(6506007)(7696005)(9686003)(966005)(921011)(38070700009)(83380400001)(33656002)(110136005)(478600001)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WXJYcnFxNXJySEJFZkc0eTZYb2Z0bElDMVpVTDViV016ZFhDK2JUS3ZwU2xs?=
 =?utf-8?B?YlgrU3hOeDRYeW1tejR1WksrSXMyZnFUTTNHZFpJSVFBUjBkR1BCbWVZSDQ0?=
 =?utf-8?B?ZTRPK0JFNDdKZlNFSFBGTVZKN1pqZER6WG1ETlhMSnZodWFWM2V5SnpsZklJ?=
 =?utf-8?B?UXlyR25tcXRybnRESTZrd242N01OajVSZ2lSNktjMWRPYXJJcExTZERScEVm?=
 =?utf-8?B?S1NISkEwd0VTWENZc2lpcHlnOC84NnlrTlI0MHBSNVdhNlphTit2aUc4T1Mw?=
 =?utf-8?B?WGM2VUJIaSt6MnFCQWJ1a2lkdWlTRmNtYTV1RmxGWlRSVlB3bWpKMXcwc24x?=
 =?utf-8?B?MTFjU2pCNGo5VkptcGZiN1dkb0lyMlZLRHhUQ0hWd3ZZZ042bkJiT0pHQkI4?=
 =?utf-8?B?OWg4c01WWS9haFI3b25FWlo2TU16c2ZzNWcxaTZBL0hvUkFJckYyOUJKaDRF?=
 =?utf-8?B?Q21pTm9oaURNQlpSVVVtUzliOU91dmxmc1NOMUI3T3lnVXdyMEZnSUhzWUFB?=
 =?utf-8?B?bU9COTZUallQZHQvakYzTTlqZWUwanFPRERkUDVZcDE4ZmdrdmxSWUtyaVdG?=
 =?utf-8?B?RDVEazZSS1Z0bEQreERudll4akwzQ3MrQXdwT2VqaWdBeGt3Nk9kWWR0T2Uz?=
 =?utf-8?B?ZXZGVXhTNFRLMk03RFhldlhuaDZUWTh4OGVkckF6dk1ZMW9MY0hlWEhwSmZT?=
 =?utf-8?B?N0VwNld1OGkyYzNCc294eTdhN0NXTStBL3FBZzRzSVNXSWhtM0lMRnU5Wkth?=
 =?utf-8?B?MXRGQ2huWUdjWE10aG04d1RnRWJBaHpjeEoyZHlkeU9tMzE5VWE3VDlQdUZa?=
 =?utf-8?B?K0E5ZEFSNVVWTVlyRFJhZ2pCK3VlUWFNZ2EySkFEak5LVlFiMHRvM3J6eU9m?=
 =?utf-8?B?anFOOWMyVHB5VTAwVTlwY25XWG50eTlva2J1SmdoakxTK0lTVEJac29YUi9F?=
 =?utf-8?B?c2MxNThjTTRPemZOQ29zUGc4UEtEdGJFKzNPazhyWWNiWm0yOHRCSjJsZVhC?=
 =?utf-8?B?d1ZCS015MUVpb2tvWnl3NWZFckJkVTVhckc2TXRwME40aFdsSmNuNmNnNXBY?=
 =?utf-8?B?Z2cxbmhud0h4NFdwa2JWQm9wUEt2M0pUSEtWcG1ROGtQSWR2NTFmekN5TitE?=
 =?utf-8?B?QnZ4STFlY3lGRnF4WWFhaXNramlTTzMvaEVQY0dPelJvZ29MSmNDaEkzVVQv?=
 =?utf-8?B?QlF4c3djcXIwK2RnR0RHeVlSeFY2UElkdGoySjFyTWJ5Q3pnUlRWZHU2S1NS?=
 =?utf-8?B?RTdoYkpXVEZPVUZWcmx1azNBdk1uYU1oaVJRekNqMGd0amVybzhSSDRaQWxN?=
 =?utf-8?B?ay9aUnR3U0JDVUhkUXNqS3JjaGR4NG81dmNoeUJVOTlLWTZocHgyRkR4Y2Zq?=
 =?utf-8?B?MGpNemZFNExqOWFVYVdmQmNOQWY1YTVFY1lKWndCRUJKbkZJR04wV2xXYlZZ?=
 =?utf-8?B?OE5rdVc4emlnUDFIR0c1WVFTdng1SnVQRXVTUDFzWEUwVDk0MXdUK0ZMVmVx?=
 =?utf-8?B?TXZxZHZKelpjTmRxdG4xbHhBNzRKMEJ3N3JsQ1dIc1VCdTVYQThPK1lONGFa?=
 =?utf-8?B?UmplalZjenBvK2tiaHB2RHBkc2tMZ2oxWEZMdkgrSkVobWE2b1NPdE1CVjE1?=
 =?utf-8?B?ajBIbENUdHdDS1VXT3ZKNkxTSWVKWVozbjJ6R29tMzRDZFJwKzQ0RmU4VlJI?=
 =?utf-8?B?eTY0TkQ3VGdIR2lPSjhwNU5yVDBvWTJDTFdLeXQ4cWhPeDJOVEhacFJTeTVa?=
 =?utf-8?B?V2tXTEdzZDVzaEh5b2xWWUxQUjRVMitLYXBBazlveWRtZ1RFRTBOb2VuWkpp?=
 =?utf-8?B?RUJ3RjVRUWN2UTkrK2pJVnFSOGFlb0VxWHdQVzhNdTV4a0dkOUhEWmE3cHdY?=
 =?utf-8?B?RDdrL2YzVFErRnNWZWR3c1pRMC9zWjdUNy9MSlZpUXZNL0Nwc3RhTlB4eW1P?=
 =?utf-8?B?TlNQQmx4YURMR3lnUkdheUFYUUZpbytmc0ZsRm0xNWZyc3FWblRpSnB0bUxh?=
 =?utf-8?B?cnZOWlNsKzBPcjBNZEw4OGdNcUQzSFc2azBxb25Wc0QvZWNLR2l4NWkyMWE4?=
 =?utf-8?B?d0tPcUhHcWVhWmZQZjJsNkxlajhFeGRseDB3OHdzNHR3ZEt0SWI4YTJBUERa?=
 =?utf-8?Q?4BRc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e283fe79-0a88-4899-c536-08dc3109ba5a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Feb 2024 05:15:03.0274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HGSwb5r6lzADRlgtoGuung5e5ihizEYQysc2KUNJtrId+jOIl6gstT7apjnsIYPvS8R2iGXQ6cLw+0IqyzFdVw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7228

UGxlYXNlIGlnbm9yZSB0aGlzIFY3IHBhdGNoc2V0LCBhIHBhdGNoIHdhcyB3cm9uZ2x5IGluY2x1
ZGVkLg0KDQpUaGFua3MsDQpQZW5nLg0KPiBTdWJqZWN0OiBbUEFUQ0ggdjcgMC82XSBtYWlsYm94
OiBpbXg6IHN1cHBvcnQgaS5NWDk1IEVMRS9WMlggTVUNCj4gDQo+IC0gQWRkIGR0LWJpbmRpbmdz
DQo+IC0gaS5NWDk1IEVMRS9WMlggdXNlIHNhbWUgcmVnaXN0ZXIgbGF5b3V0IGFzIGkuTVg4VUxQ
IFM0IE1VLCBidXQNCj4gICB0aGUgVFIvUlIgbnVtIGlzIGRpZmZlcmVudC4gVG8gbWFrZSBjb2Rl
IHJldXNhYmxlIGFuZCBub3QgYWRkIHRvbyBtdWNoDQo+ICAgbWFjcm9zLCBhZGQgcnVudGltZSBk
ZXRlY3QgbnVtYmVyIG9mIFRSIGFuZCBSUiBieSByZWFkaW5nIFBBUl9PRkYNCj4gICByZWdpc3Rl
cnMuDQo+IC0gQWRkIGkuTVg5NSBFTEUvVjJYIE1VIGVudHJ5IGluIGRyaXZlcg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+IC0tLQ0KPiBDaGFuZ2Vz
IGluIHY3Og0KPiAtIFBlciBKYXNzaSwgc2VwYXJhdGUgdGhlIHBhdGNoIHRvIGFkZCBvZl9wbGF0
Zm9ybV9wb3B1bGF0ZS4NCj4gLSBMaW5rIHRvIHY2OiBodHRwczovL2xvcmUua2VybmVsLm9yZy9y
LzIwMjQwMjAxLWlteC1tYWlsYm94LXY2LTAtDQo+IDc2ZjRmMzViNDAzZUBueHAuY29tDQo+IA0K
PiBDaGFuZ2VzIGluIHY2Og0KPiAtIERyb3Agbm9kZSBsYWJlbHMgYW5kIGFkZCBDb25vcidzIFIt
Yg0KPiAtIExpbmsgdG8gdjU6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjYtaW14
LW1haWxib3gtdjUtMC0NCj4gN2ZmM2EzZDUzNTI5QG54cC5jb20NCj4gDQo+IENoYW5nZXMgaW4g
djU6DQo+IC0gUGVyIENvbm9yLCBhZGQgcmVzdHJpY3Rpb24gdG8gc3JhbSBwcm9wZXJ0eS4NCj4g
LSBTaW5jZSBpLk1YOTUgTVUgaGFzIFNSQU0sIHdlIG1heSBub3Qgc2VlIGl0IGlzIGNvbXBhdGli
bGUgd2l0aCBpLk1YOFVMUA0KPiBNVSwgc28gZHJvcCB0aGUgZmFsbGJhY2sgY29tcGF0aWJsZQ0K
PiAtIEFkZCBSLWIgZm9yIHBhdGNoIDImMw0KPiAtIExpbmsgdG8gdjQ6IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL3IvMjAyNDAxMjUtaW14LW1haWxib3gtdjQtMC0NCj4gODAwYmU1MzgzYzIwQG54
cC5jb20NCj4gDQo+IENoYW5nZXMgaW4gdjQ6DQo+IC0gQWRkcmVzcyBkdC1iaW5kaW5nIGNvbW1l
bnRzIGluIFYyIGZyb20gS3J6eXN6dG9mDQo+IC0gTGluayB0byB2MzogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvci8yMDI0MDEyMy1pbXgtbWFpbGJveC12My0wLQ0KPiBlZDkzMjk0NWUwYmZAbnhw
LmNvbQ0KPiANCj4gQ2hhbmdlcyBpbiB2MzoNCj4gLSBGb2xsb3dpbmcgZHRzIGNvZGluZyBzdHls
ZSBQZXIgS3J6eXN6dG9mDQo+IC0gQWRkIHJldHVybiB0eXBlIGZvciBpbml0IGZ1bmN0aW9uLCBw
YXRjaCAyIGlzIG5ldw0KPiAtIENoZWNrIHJldHVybiB2YWx1ZSB3aGVuIHRyL3JyIGlzIGxhcmdl
ciB0aGFuIDQgYW5kIHJldHVybiBlcnJvci4NCj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9yLzIwMjQwMTIyLWlteC1tYWlsYm94LXYyLTAtDQo+IDdiM2M4MDMzM2I5MkBu
eHAuY29tDQo+IA0KPiBDaGFuZ2VzIGluIHYyOg0KPiAtIFN1cHBvcnQgc3JhbSBwcm9wZXJ0eSBh
bmQgYWRkIGV4YW1wbGUNCj4gLSBQb3B1bGF0ZSB0aGUgc3JhbSBub2RlIGluIGRyaXZlcg0KPiAt
IExpbmsgdG8gdjE6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAxMjItaW14LW1haWxi
b3gtdjEtMC0NCj4gODE0MTNmNjU1MjEwQG54cC5jb20NCj4gDQo+IC0tLQ0KPiBQZW5nIEZhbiAo
Nik6DQo+ICAgICAgIGR0LWJpbmRpbmdzOiBtYWlsYm94OiBmc2wsbXU6IGFkZCBpLk1YOTUgR2Vu
ZXJpYy9FTEUvVjJYIE1VIGNvbXBhdGlibGUNCj4gICAgICAgbWFpbGJveDogaW14OiBzdXBwb3J0
IHJldHVybiB2YWx1ZSBvZiBpbml0DQo+ICAgICAgIG1haWxib3g6IGlteDogZ2V0IFJSL1RSIHJl
Z2lzdGVycyBudW0gZnJvbSBQYXJhbWV0ZXIgcmVnaXN0ZXINCj4gICAgICAgdHQNCj4gICAgICAg
bWFpbGJveDogaW14OiBwb3B1bGF0ZSBzdWItbm9kZXMNCj4gICAgICAgbWFpbGJveDogaW14OiBz
dXBwb3J0IGkuTVg5NSBHZW5lcmljL0VMRS9WMlggTVUNCj4gDQo+ICAuLi4vZGV2aWNldHJlZS9i
aW5kaW5ncy9tYWlsYm94L2ZzbCxtdS55YW1sICAgICAgICB8IDU4ICsrKysrKysrKysrKystDQo+
ICBkcml2ZXJzL21haWxib3gvaW14LW1haWxib3guYyAgICAgICAgICAgICAgICAgICAgICB8IDg4
ICsrKysrKysrKysrKysrKystLS0tLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTIzIGluc2VydGlv
bnMoKyksIDIzIGRlbGV0aW9ucygtKQ0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGFkNWM2MGQ2NjAx
NmU1NDRjNTFlZDk4NjM1YTc0MDczZjc2MWY0NWQNCj4gY2hhbmdlLWlkOiAyMDI0MDEyMi1pbXgt
bWFpbGJveC0yNDMwMjFkMTIwMzANCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gLS0NCj4gUGVuZyBG
YW4gPHBlbmcuZmFuQG54cC5jb20+DQoNCg==

