Return-Path: <linux-kernel+bounces-144835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112E48A4B74
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32F331C20FBB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7C63FB2F;
	Mon, 15 Apr 2024 09:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="nmnsP4t6"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2053.outbound.protection.outlook.com [40.107.8.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8F72C848;
	Mon, 15 Apr 2024 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173402; cv=fail; b=Rb3r9+Q5XTnx92QiDpGh12Zp6A38KEXIowklbDC0hsOv/YmcO91zW3pIqc1riwaeHksMkR8mwmj18lggErGuKQL2QKt4ADO5gqoDwTExsm90xrxLwadr7SSSfhvju5ho/xgFA4Z1t4vQCc/RN/aj4TE+9ssIx2YiM6YIcCMxnmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173402; c=relaxed/simple;
	bh=cVJwTLiM1jDPdNMdlw79DSa/zxfSFNXbPHMlcYjN0sg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eRon/5ERK2Il/h5Da7sZeiEI24BFomJCDNYibtWlGT2EyU03JO4WvtUDMyQwfNYY1E0gDqV6fJ9eoNTQ7FyIEm1bt1IIklcCkU/eZ0zfZgKjXT5qDxFUy1eaoFx+sF4tJReUZem7h4rCH670pV/1qJevOaJkVUXgelNTr6Ret4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=nmnsP4t6; arc=fail smtp.client-ip=40.107.8.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UPv4t6FW+6ncYpQK+azm8QyvEXCbHJNzn6E4fcTFcKBKSN59VAvMUG464EaX/9u1gE/S89aUepHDaD/1muudqUrIL5/5uJl/jw/LACW9w3jcFoIsPPwUDWczKj1N2uJWvHeYkeGHwTV1TPBocDJOdsbsv0wo360XUtS3c8k/6oSNGUK1Fjw6cOtbA9r9eG/GqFQxjpApf1LW8AQxumnpg/01YDq9ZaRbLHeJdZS9WNSF0NoupzloUBf8ugbz1iy32K3yPazIrBkDXdiGiDTKvrRgfrQ3M1hpP0sSApYHJLWr9YMqROeQuelOM1KdLWNuxSr8jr7B5OLUsdShYnIjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cVJwTLiM1jDPdNMdlw79DSa/zxfSFNXbPHMlcYjN0sg=;
 b=R2s8cI2O18wGZVk/eqJiccycyki5N3phcNBr46jqTAq9Fr9EEczGjBuid+MRXwwJ8E9SmakdK12zMuoWUf+76rvN8kJIAc8FTuSDXol9HcGQ0JMEV9N8idstiiVpk7xEWGXThpVhSljbxYqSEtQo5L/jonKgS89PDrkhFRj9LDg+DxG5ubKOetNgpRP6Itg6iL2F1GDhZ5a70G4bt1hduGJRbG4van5o75TSL0lJkHBHvXdsUdMUwktE10N27Zm3v7kCs6k6UMjhGtp3gMIrtNfSLmHRioqlG/L+1lKxW9Qo7Xs3RFcpDqTbOu5HyjBaPC+5nmHblDzeeVZcDHVMXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cVJwTLiM1jDPdNMdlw79DSa/zxfSFNXbPHMlcYjN0sg=;
 b=nmnsP4t6TQbNbL8NQ6iF4aIVlJUvIFCoxEmCLdwpfAOPYDWLzoo19Izb6iEKu2Of8zFBx5B4UgEXe3vDv4V+FxQ6ZERc/gEKtxGkWKfdwPSasOJvzTcszNXHbuCQYKFPSOsbUutVmu/qEHxGo/9Al956LsdsSDxYB1PtwxIyJIw=
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com (2603:10a6:20b:43b::21)
 by DBBPR04MB7786.eurprd04.prod.outlook.com (2603:10a6:10:1e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.49; Mon, 15 Apr
 2024 09:29:56 +0000
Received: from AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4]) by AM9PR04MB8604.eurprd04.prod.outlook.com
 ([fe80::33cc:db75:c850:63a4%2]) with mapi id 15.20.7409.042; Mon, 15 Apr 2024
 09:29:56 +0000
From: Pankaj Gupta <pankaj.gupta@nxp.com>
To: Horia Geanta <horia.geanta@nxp.com>, Gaurav Jain <gaurav.jain@nxp.com>,
	Varun Sethi <V.Sethi@nxp.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	Iuliana Prodan <iuliana.prodan@nxp.com>, "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Francesco
 Dolcini <francesco@dolcini.it>
Subject: RE: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Topic: [PATCH v2] caam: init-clk based on caam-page0-access
Thread-Index: AQHaix0m4ZYBWPX2WESQOX3rSooEPrFkmZUAgARIBCA=
Date: Mon, 15 Apr 2024 09:29:56 +0000
Message-ID:
 <AM9PR04MB86042D682CC2E411826020A595092@AM9PR04MB8604.eurprd04.prod.outlook.com>
References: <20240410075815.4030570-1-pankaj.gupta@nxp.com>
 <ab774af1-1599-46ff-843e-6333a55a97a3@nxp.com>
In-Reply-To: <ab774af1-1599-46ff-843e-6333a55a97a3@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8604:EE_|DBBPR04MB7786:EE_
x-ms-office365-filtering-correlation-id: 97b6cd95-2286-4cd4-973b-08dc5d2e9d24
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 PV+JO2ViyzDmuswqOq843TPLf3rQNZmXQvEMOKzxYQBdqWgNP+bxGNScJKDjfGBnsGvaXcfwTZlRiZdh9/hN6poSTdFhVWMr9BkCwvRhNstnoWat9f0KKUVoGrNokgpbMtm02GKX5n9aXPSSzWW+tDIog5b5uZbZHrPLUWuhlsG7kdRhPHFstinz08DpK9+82I1uy43Rx/FUpqQhdNSoW1hjBpilMeViJJcGN0XMusYA1vr2JLObUR/J9dYfC1ZQJXDLF2sXQihqPPeZBuXAt+DQpnhburqk8U3lTchGJEQxZIiELAQAxqWu20YNCWJmzokj3wz4rcwtByL8/mLE7c7BK2mJDe2NxJ5UbLMyqur19navMlD72EywT63tKB7Hm3AydlVtazBQQkcv1JJq8LlryIJ4tKPa8gihdAlg6CqNxgGUS+pDk/x5d2OcWDpTbqap6kD9qKAlAD6RkVxKznaPIZlhGaBuTKfcw5ecRgKFWCjbIrdvRA4vATZDh31wZ9KsPjZehlKSLnXRtbkotBr3qy6L/VoaZ8ZweACVDyG/p0uKx8O9EKgjnQ9wAGPZdRne5II4hnUq4Hmn6vCqdeL8kuOOu2X21CZlyhunhn4PHGwABAdjC3TVRAvnu3TjfuCh15zTyhj1YDqZ5WaQGla+BpzrQJMqImDi2qkKa/4sw9XfAuTFRlx07yOdPJwSIcv++QvykdaZSI8Ps33Z6JTqvlg+Wt1QR+LDkWKqCyQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8604.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WnBkditrbEF2SUpadVFnMXpaeUp4MFE1bVljSkV2djZvYm9xY0JRQXRobHBh?=
 =?utf-8?B?REx4Q28vM1hOWDMybkNNNHNMYy9kQUVwUHhRWVpmZ2s1b3FqWEpmNENyN2pl?=
 =?utf-8?B?YnQyQmNKK3FOM0NTZ1JsS3cwNmVTa1JtdkZ0cjB0bkFoWkFiVHJteDV6MGZ3?=
 =?utf-8?B?VnRUcENOckNpbjRLVFlqTEFycjdQQjhTUUtUKzBtdWllR0RPVXBseW85RUtl?=
 =?utf-8?B?WitLL2VKUEY1VkxybG1oT0pDZmVzUERqRmc2L083bVpkK0NuKzdDTUVoWnU0?=
 =?utf-8?B?R3FUdCsrenBWRTRHUmVZdFJOMExSYWxqM3ljU0dvdXptQll4bEI0WHM1Y0hS?=
 =?utf-8?B?c3Q4a0w2RUVYSmxnb0tuaUZHREVvUVIzRjJOcURWSEZIOEIyYXdBV016bFpO?=
 =?utf-8?B?d1RsTFZvZVd4ZUdWdHV0NFFJYTRJQ1JkVkdBVnpqdzR3VnBQTWFlVUZZWGhC?=
 =?utf-8?B?RHJYSnJHS0M2MVNoc3RwSlhvR1IwTGhnc3FQVHlsanZQVSt2VnJ4MlZYOVJU?=
 =?utf-8?B?S2dHYU5mNnJCNmo5cjJIUDl2ZzlTUS9qOXEyc2V5QXZsMmVJdXdOUDBzOExo?=
 =?utf-8?B?Mkx2c1lvZDVYNzh5OEZjMFhhaUIybm9EOHFJVzJmV1AwY2lLVWpReE1YaTVK?=
 =?utf-8?B?RWRMR04vVmkzY2tXUzdCUDdCWk1FSCs3a2NYN00yRGxlZHBwYVNDei9nQTNa?=
 =?utf-8?B?YkFOR2NrdkNvY1pzYmhDRGlBdG1LL0dYMUtsajR0cFJzODJzTThWdlN1dEJB?=
 =?utf-8?B?WVFZNlZNY1BFUFF5aldRRnQzQ3VycDFwa3M2VHhGQ3pXdmhBU1hIOFl0OUNV?=
 =?utf-8?B?V0E3bVh6ZnlFbkVaazFia0E5U3ZMWGtadWRKRFZ3Q3Vxb053SHhFRVZDcUor?=
 =?utf-8?B?YU9McVRURjFvdGVKOVJ5U1B3RXZKUTZVSHpHVU05NmF1cnNnbjd2ckMvTFFF?=
 =?utf-8?B?R2w1aWkzMGJBaERoaUc3YVlGTGVsWWVMMEZ0aWp3U21yZTJsUGdpR1BEd3Jl?=
 =?utf-8?B?SFJGMzRwbjBxdG81UEhhUDNrR0tmaUx2ZytOcCtoaVNEOUhKRjc3ZEFLVVhn?=
 =?utf-8?B?d1JuaTc1d0tKWi9FbU9HUDhtYUw5d1ZMNUJsK3dLR09QRGZQTHlPaElkL3dS?=
 =?utf-8?B?TzBBTlpQREV3M3FPbWZkRnlxbDlQb2dxVkplMHA1YTJVaUl2L2U4dDZSSE9U?=
 =?utf-8?B?ekF1WTdqZUVCemRJbmhlZkF2S1ZYY2d6N2FjQ05Zdy9pbnFCZXNtN1lZWC9Q?=
 =?utf-8?B?M1diQXE0b0RnMjB5MmJLdklqenZhUGhoNnN0TjFDQmxYaStUVjZUUjk1K29h?=
 =?utf-8?B?WnhsZ0U3WE12cm4rTVp2QUd3QVBpR0g3bldYZDFtNFhaSHgvM3JKb1diVW85?=
 =?utf-8?B?eExLOVROUXZOZ1Vmb1VQRkNuUkNkODUySC82N3hMa05BeVpYV2ZhZmt2YmNF?=
 =?utf-8?B?Q080MGt4QytLWGVrdHN4YlRTdzN1U1hWOW4vZCt6WDZtaW5RWjRVWHlDTXdj?=
 =?utf-8?B?UHlPbmxydktrckpXamlyeXVGbUR1SzhnYmdKeFR3TjJvazgzRmgvSkhWb1dp?=
 =?utf-8?B?UklwSjhzMnZ1SVZxdGhMMWZSQi9PVmhJOFlNRnNaZkEwWm9NOGQ2WmgybnpX?=
 =?utf-8?B?aTlVdlQzdFZDU3N2OHFtRzRBM1I1UnJPZXNnWlU1eFIySjc1bEp6M0FMUDVC?=
 =?utf-8?B?dmpwTzZldDlqZzJwYkdjeFBWUmxmWXozMnRwLzM3dzIxb0pua3RvdlQrRXdh?=
 =?utf-8?B?YlFwejBZUkRXVkNaSHF3eElwSTBvcHhWdkRZeS9xNDZ3b3BHbFUvSlErcXZV?=
 =?utf-8?B?aFRwNGJ4VnBVV0RXL0NuM2d5QlcrY1h5UUNxc09zM1JKd0UreXFiSTBNcno5?=
 =?utf-8?B?MTgrbGJWblZLS08vQlNjMXo1MEc3MVlFYW5ac3RKd096YmxOVk1LMk9rZmgr?=
 =?utf-8?B?VHV1Nit4SjRFMjRCQUcxYzNucEJkN0FBcS9GbUhGU2VaVk5HSUhiUnFVT1pu?=
 =?utf-8?B?OGNXenExMFVsOElDUmFKREJqM0lnYnZvcUdJQkZxbUVwdVpjWlFJWURnSnJr?=
 =?utf-8?B?aURFaGpVQWpWRVRnWldrTWFsWkJzRWhheWx6cWhUY29waVd1VG4wYXo5eEJN?=
 =?utf-8?Q?N+XZ5q59JDsLeXpz8zjy42c/d?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8604.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97b6cd95-2286-4cd4-973b-08dc5d2e9d24
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2024 09:29:56.5544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xXtBAELIDMmrhpz1zgVJgdMZ1sfmaKkkxOKbfXyUN9ca5X5IJ8Zfaa+CNM4V1KlSMKSXcbmcEPMffb3+7NeuVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7786

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSG9yaWEgR2VhbnRhIDxo
b3JpYS5nZWFudGFAbnhwLmNvbT4NCj4gU2VudDogRnJpZGF5LCBBcHJpbCAxMiwgMjAyNCA2OjIw
IFBNDQo+IFRvOiBQYW5rYWogR3VwdGEgPHBhbmthai5ndXB0YUBueHAuY29tPjsgR2F1cmF2IEph
aW4NCj4gPGdhdXJhdi5qYWluQG54cC5jb20+OyBWYXJ1biBTZXRoaSA8Vi5TZXRoaUBueHAuY29t
PjsNCj4gaGVyYmVydEBnb25kb3IuYXBhbmEub3JnLmF1OyBkYXZlbUBkYXZlbWxvZnQubmV0OyBJ
dWxpYW5hIFByb2Rhbg0KPiA8aXVsaWFuYS5wcm9kYW5AbnhwLmNvbT47IGxpbnV4LWNyeXB0b0B2
Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3JnOyBkbC1saW51
eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsgRnJhbmNlc2NvIERvbGNpbmkNCj4gPGZyYW5jZXNj
b0Bkb2xjaW5pLml0Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyXSBjYWFtOiBpbml0LWNsayBi
YXNlZCBvbiBjYWFtLXBhZ2UwLWFjY2Vzcw0KPiANCj4gT24gNC8xMC8yMDI0IDExOjAwIEFNLCBQ
YW5rYWogR3VwdGEgd3JvdGU6DQo+ID4gQ0FBTSBjbG9jayBpbml0aWFsaXphdGlvbiB0byBiZSBk
b25lIGJhc2VkIG9uLCBzb2Mgc3BlY2lmaWMgaW5mbw0KPiA+IHN0b3JlZCBpbiBzdHJ1Y3QgY2Fh
bV9pbXhfZGF0YToNCj4gPiAtIGNhYW0tcGFnZTAtYWNjZXNzIGZsYWcNCj4gPiAtIG51bV9jbGtz
DQo+ID4NCj4gWy4uLl0NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBjYWFtX2lteF9kYXRhIGNh
YW1faW14OHVscF9kYXRhID0gew0KPiA+ICsJLnBhZ2UwX2FjY2VzcyA9IGZhbHNlLA0KPiA+ICsJ
LmNsa3MgPSBOVUxMLA0KPiA+ICsJLm51bV9jbGtzID0gMCwNCj4gPiArfTsNCj4gTm90IG5lZWRl
ZCwgYW4gZW1wdHkgc3RhdGljIHN0cnVjdCB3b3VsZCBkby4NCkFjY2VwdGVkLg0KV2lsbCBhZGQg
dGhpcyBhcyBwYXJ0IG9mIHNlcGFyYXRlIHBhdGNoLCByZXF1ZXN0ZWQgYmVsb3cuDQoNCj4gDQo+
ID4gIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc29jX2RldmljZV9hdHRyaWJ1dGUgY2FhbV9pbXhfc29j
X3RhYmxlW10gPSB7DQo+ID4gIAl7IC5zb2NfaWQgPSAiaS5NWDZVTCIsIC5kYXRhID0gJmNhYW1f
aW14NnVsX2RhdGEgfSwNCj4gPiAgCXsgLnNvY19pZCA9ICJpLk1YNioiLCAgLmRhdGEgPSAmY2Fh
bV9pbXg2X2RhdGEgfSwNCj4gPiAgCXsgLnNvY19pZCA9ICJpLk1YNyoiLCAgLmRhdGEgPSAmY2Fh
bV9pbXg3X2RhdGEgfSwNCj4gPiAgCXsgLnNvY19pZCA9ICJpLk1YOE0qIiwgLmRhdGEgPSAmY2Fh
bV9pbXg3X2RhdGEgfSwNCj4gPiArCXsgLnNvY19pZCA9ICJpLk1YOFVMUCIsIC5kYXRhID0gJmNh
YW1faW14OHVscF9kYXRhIH0sDQo+ID4gIAl7IC5zb2NfaWQgPSAiVkYqIiwgICAgIC5kYXRhID0g
JmNhYW1fdmY2MTBfZGF0YSB9LA0KPiA+ICAJeyAuZmFtaWx5ID0gIkZyZWVzY2FsZSBpLk1YIiB9
LA0KPiA+ICAJeyAvKiBzZW50aW5lbCAqLyB9DQo+IEFzIEZyYW5jZXNjbyBwb2ludGVkIG91dCBp
biB2MSwgdGhpcyBjaGFuZ2UgaXMgbm90IHJlbGF0ZWQuDQo+IA0KPiBJZGVhbGx5LCBhZGRpbmcg
c3VwcG9ydCBmb3IgaS5NWDhVTFAgU29DIHNob3VsZCBiZSBkb25lIGluIGEgc2VwYXJhdGUgcGF0
Y2gsDQo+IGV4cGxhaW5pbmcgYSBiaXQgdGhlIHBhcnRpY3VsYXJpdGllcyAtIHNpbWlsYXIgdG8g
dGhlIGNvbW1pdCBtZXNzYWdlIGhlcmU6DQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9ueHAtaW14L2xp
bnV4LQ0KPiBpbXgvY29tbWl0L2Q0MjBmMjI0ZWUwMmMxNjRmNmJkYjNjOGJiYjVlYzU4MjdlYWJh
MzcNCg0KV2lsbCBjcmVhdGUgYSBzZXBhcmF0ZSBwYXRjaCBmb3IgdGhpcyBjaGFuZ2UuDQoNCj4g
DQo+ID4gQEAgLTg4OSw3ICs5MDIsMTUgQEAgc3RhdGljIGludCBjYWFtX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UNCj4gPiAqcGRldikNCj4gPg0KPiA+ICAJCXJlZ19hY2Nlc3MgPSAhY3Ry
bHByaXYtPm9wdGVlX2VuOw0KPiA+DQo+ID4gLQkJaWYgKCFpbXhfc29jX21hdGNoLT5kYXRhKSB7
DQo+ID4gKwkJaWYgKGlteF9zb2NfbWF0Y2gtPmRhdGEpIHsNCj4gPiArCQkJaW14X3NvY19kYXRh
ID0gaW14X3NvY19tYXRjaC0+ZGF0YTsNCj4gPiArCQkJcmVnX2FjY2VzcyA9IHJlZ19hY2Nlc3Mg
JiYgaW14X3NvY19kYXRhLQ0KPiA+cGFnZTBfYWNjZXNzOw0KPiA+ICsJCQkvKg0KPiA+ICsJCQkg
KiBDQUFNIGNsb2NrcyBjYW5ub3QgYmUgY29udHJvbGxlZCBmcm9tIGtlcm5lbC4NCj4gPiArCQkJ
ICovDQo+ID4gKwkJCWlmICghaW14X3NvY19kYXRhLT5udW1fY2xrcykNCj4gPiArCQkJCWdvdG8g
aW9tYXBfY3RybDsNCj4gPiArCQl9IGVsc2Ugew0KPiA+ICAJCQlkZXZfZXJyKGRldiwgIk5vIGNs
b2NrIGRhdGEgcHJvdmlkZWQgZm9yIGkuTVggU29DIik7DQo+ID4gIAkJCXJldHVybiAtRUlOVkFM
Ow0KPiA+ICAJCX0NCj4gaWYvZWxzZSBjb3VsZCBiZSBhdm9pZGVkLCBtYWtpbmcgY29kZSBzaW1w
bGVyOg0KPiANCj4gCWlmICghaW14X3NvY19tYXRjaC0+ZGF0YSkgew0KPiAJCWRldl9lcnIoZGV2
LCAiTm8gY2xvY2sgZGF0YSBwcm92aWRlZCBmb3IgaS5NWCBTb0MiKTsNCj4gCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gCX0NCj4gDQo+IAlpbXhfc29jX2RhdGEgPSBpbXhfc29jX21hdGNoLT5kYXRhOw0K
PiAJcmVnX2FjY2VzcyA9IHJlZ19hY2Nlc3MgJiYgaW14X3NvY19kYXRhLT5wYWdlMF9hY2Nlc3M7
DQo+IAkvKiBDQUFNIGNsb2NrcyBjYW5ub3QgYmUgY29udHJvbGxlZCBmcm9tIGtlcm5lbC4gKi8N
Cj4gCWlmICghaW14X3NvY19kYXRhLT5udW1fY2xrcykNCj4gCQlnb3RvIGlvbWFwX2N0cmw7DQo+
IA0KW0FjY2VwdGVkXQ0KDQo+IFJlZ2FyZHMsDQo+IEhvcmlhDQoNCg==

