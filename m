Return-Path: <linux-kernel+bounces-106958-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C0F87F601
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80D9F1F224F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34D07BB07;
	Tue, 19 Mar 2024 03:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FbZSYoMJ"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2107.outbound.protection.outlook.com [40.107.13.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEC97317D;
	Tue, 19 Mar 2024 03:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710818430; cv=fail; b=D3BhLKe6WS5kVvm7IiN/qKeTGEfePhvIdfHtu5mZZe4Bu5l9v7CqNm7pxH9QcT5KBlmBryQBGPGEnexl6ufTReEDliOGPhnI24/f7Y3IlU1P+9OeswFkMqgxGLd33tDS8odR+QuuWlE/mMPAjBYsFSw2Bb3LSEe4TQyTeSPxPMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710818430; c=relaxed/simple;
	bh=+uMuNXxkvZUDysJib0ossJ1e0A8y/4aFH0S0qYwo5PQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mRyJEWfLCYZMZPl670SfzRJiEa8lZDnGz6uUa6Y6mEgzJLr+7ZJzj5x31GdKgG9kdMB89s7WYXtq35fFNraZL2chN0r7q1xofzXgXRcOah4M1MeZjYsDLQG3h68a4SVf7xRAFCeUgeb9Qz6LISk/eVn3fKXO2zx2l3UpC8m7/wk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FbZSYoMJ; arc=fail smtp.client-ip=40.107.13.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZAVrQUr8b1Nsq5aNMXcwoeis9qT6CfWS8pNCJv/R79W5HjZH4HMpyOJ27csdlAgXccoZMOOZk3gwpmClXr6tyLcNE6/OxKgfqk8/7+WowRCAc67V5NRvMWtTKpMbihrmfROqNzUTfXcTDChKdkPLE1x+3ON1lJSAL6XbOwLIGctM3JOwXbPfXyvkgHfa2cvADNQHIhGIobYL+2LOSJQlLjRhe8fwTt7l3TvwGHjYRzddkJxsm0YRc6ACzNUZDQ8Qr/KbM4Aqp+04YbiQk1A8e2MLgZwYdbmF1M5ImhAIrrUO94OtmQUvU7eUVV2RXKstS/Gh/cVjrb1bxdl31rHhkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uMuNXxkvZUDysJib0ossJ1e0A8y/4aFH0S0qYwo5PQ=;
 b=QyL/lwHLcbRYiNqAIOW0IlnnA/3QcRSwUXB4AK4tuzaxOUcmqfHAU0+rLRneS+C7ZkwKcc3HIuN5vRFqFjN4CI498nbDV+Y8fdWKukmpx7v1cUvgfYm8VHUT1XAjfQfqYb8iRGk5504eHEAqi44C2usa0yutXApc/2+XLEMaox/a8M6rccEpxGVLrUQlUlyjaUwczIJwsQfohmo7ON9bJ+b8zr22ZtB1a45P2vXQRLHmNIX/F0ywFNbJ+8C78DH7UUpncQxHjHD3gs1q5OzRAhcFltucyc5my3i4r0yOiONwNKwZMMXkTocG7lAuMR+Z0xT/ptu6S6GDxgpa+uDTDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uMuNXxkvZUDysJib0ossJ1e0A8y/4aFH0S0qYwo5PQ=;
 b=FbZSYoMJwStjKhvP0UVv9mPh92x920B6jcJfnx+NzxUXKikEf+SI6a324wYdCp8q5V6Q82nGwdl2KmgNDUYJ0l6uccfxzh9quSlBuCWHlUBAjaT2hgnlU5K2+yNIUGbsUVcIjSOd49CdZo+z4qheigiehYS5JJD7i5urCOCiUYw=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by AM9PR04MB8810.eurprd04.prod.outlook.com (2603:10a6:20b:409::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.25; Tue, 19 Mar
 2024 03:20:24 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:20:24 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Frank Li
	<frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, "lgirdwood@gmail.com"
	<lgirdwood@gmail.com>, "broonie@kernel.org" <broonie@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v5 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v5 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Index: AQHaeRl/wdW/K6byHEaK3s8IhdQw47E92DKAgACN5sA=
Date: Tue, 19 Mar 2024 03:20:24 +0000
Message-ID:
 <DB9PR04MB9377B0418D90EE2FCA3414A9E12C2@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240318095633.4079027-1-joy.zou@nxp.com>
 <20240318095633.4079027-4-joy.zou@nxp.com>
 <7f601f5e-98af-4a78-a3eb-04d814669973@linaro.org>
In-Reply-To: <7f601f5e-98af-4a78-a3eb-04d814669973@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|AM9PR04MB8810:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qi0fxLjzpDvPRrioB9sC8DpJ5ykLxHIhRsa5t4sqYCU2n8M1+V5rMhOLHQr+ZiGkwriDLOb6B1mNB6qkayud/Idb8ZEyftbfjpDa0+LfiBGFqrUCExc2/A3a8mMF/6AF8pMmAmwqr5C66YIpdp+oq1Tawc2TIHxa/G4EDw8ZDImxme+J0NRVfupcZ29wkoWI/RY/0ACI9TO4Cl+JkrsLq/+CEWKokeJ5dipmUjfsM/enHgQCG/O7pFnfnOuGM6mJjxWMuZoHaTr1+GsRNaKC9evH+5SZFjB+bC1Q0BDIjXmXHQ5cijrd9nCceWbuKh+a368iLU8ly97XUQPg6ABNV6uo1Lig5AMgGo6tv4kZkGXRvVRu1iFFnzccuRRFS+lbC0bbjllNrr6K7uHpE74qUdbfzEQ9EQqjNBu42VwgJ3ECPOdkb7nX4LA2Gt29xF6flvJo9UDyv5ZxPE+rJLYJFeRci7p87PM1jppk9taY4DYrR7SkaehtXCWLLtjoevarYaf3by5R7Mti27IiXE/bXHv8LNp6E7zRNDs+6bIfi9hDVPR0TxtJGhHV4SDYx0Z8jWUVPUdoQ1viw84h1gLkp8GHWD/gbxeJrdQvR5JkVROYt/zk2M8nimeOPz0MR20d2ngnBQwZA09o0D5EBiK4hgsovNKDlBgtR/YuT6LwyHP+7Mcdah7NJHCskeEBQAWW6SRxQHAUn2vf6z1VjAHkUQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N1NrR0FVa25aUEhhTTBmaENJSmJtUjhWaXVSc1hGZnZRWndnNHZNNW1VTlRx?=
 =?utf-8?B?bG8xaE1CRStFNCtCM3ZFRUFvWEFDVk1jNVl1TkU0VFF6QlhXVm13bVRRUU9T?=
 =?utf-8?B?Q1JpcTRVTXg3U0FTajc3MWtEbGxyMGtNV0F6RU84VzE4aFUySzlQNnhKWFBt?=
 =?utf-8?B?cE01MW00TmZKR3E0a1BNR2hwOXZldGlnWEdhTUQvem14Q1dGZ1NoZFI1ZGRj?=
 =?utf-8?B?TXpEeHZMUmRmTTNkOEdhODh0dHkxTGNBQ0pBM2pXWC9GK1g1UmZkUFVzTzl2?=
 =?utf-8?B?dWJGWGR1bkhZK0t4Tm01N2FFZjNtbFAraGV5Q0V3V0FpWkQ5ZkpuVEFkdGNv?=
 =?utf-8?B?RlJCQWhTREdsWTVOUTBRNGR6R1pLTnV4c1RDK05LUGZBZ0VpZyt5VjJ5Ykdv?=
 =?utf-8?B?cU03YjBVVGQyS0dlOW40WXdkejN5VC9CYWl6OFZ1OGxzMFJ0aWtaMFhyUmd3?=
 =?utf-8?B?enQyVlp2cnljZVJISmZzOE55bmlZbW12SWREVUFtZFZHRkhoRi82UnZoSzdB?=
 =?utf-8?B?eElQd1ozOGpZUFhZTjhveVFvK1NLZ0dRbHl2ZDYvN0toK3JkS0hSZk1JbVBI?=
 =?utf-8?B?RWtHRGloRzFQV2pDdGZrd1UzQVlGS0hSRlU1UHJYRlNzOXhDalhaYWszT2JL?=
 =?utf-8?B?L2d5SjBrQ1lYNU1XdytRbGhzY3NaYmN5V2ZWVUttQXFCR3lGNkxlWVA0UzE0?=
 =?utf-8?B?UWluVklLRFdrYTZHU0ZLcHY4N0NjOENSVEVJUUltZnVqbWdzVVpMZmFvRjc1?=
 =?utf-8?B?SUo5bTYreGpzOUEzMTE0THZ5UU5oa1BmRmRQRCtCZUFqczV5VEJBRHdEN1Jt?=
 =?utf-8?B?U0FvdXdpazRtRVRiSFhyTGxzWkZWOW0xQzA1dTM2TWdhbXM3b3BOYlAxYk1B?=
 =?utf-8?B?d1o1RUFDU3g4aVNmeEx4S0VHQWJrcmV4cGZ5MmhWQi96ZzY3RDRxbGV0SkFL?=
 =?utf-8?B?d3lzbENaazBDZzdSRGZueVoyK2IwSVJJdlhQTktPL2wrTkR6anhjTUtxb1N4?=
 =?utf-8?B?Wnd4UFdLRkQ0TVMzcDIxb1NTc2NZL1pNZmk2WnU4RGZVcEVVbXRsazlVQks5?=
 =?utf-8?B?MlgraUttSThWcWdvenhqV3lXUzMxRmd6ZnVPMkpKdU52WHhKV1c4Q1gxTUlK?=
 =?utf-8?B?VW45NjVSWWxoMTJIUHVYR2o5SUhzeEVrMDFIWmYwQ1lJV1VLeHlONy9paENt?=
 =?utf-8?B?UjhQamxFRFRBZFkrdU1oNC90VytmbWF4b2RNL09OeDZGODlSQTY4QUQ0V0Zl?=
 =?utf-8?B?V3RpTFJYVW1IRTBjaVQxZ2Jqb04rUnFmWW8ySjcyTG1JMkxWNHdrN1I1cGNC?=
 =?utf-8?B?K01iYlVWaVI5OUEzditpbDgvbkc3dW5Cb3o3ekdld2twVnpERUVETi95U0dS?=
 =?utf-8?B?Nk1yVWh2Rk5lcGJ0ZlBjZW9CREc5WkJsREJRcUNSYSsrR1JuU1lzbzY1ZHBw?=
 =?utf-8?B?UW1ZUy9kdjBNTlIzWG9BYUZGU2tYcStGQnV1MHBzVmpGYS9KY0UxV3MrOERY?=
 =?utf-8?B?Ymt2UmhLclBHaEN4dy9aYktieStBOWZVOXE1V0gwZVhxaW9oRUhXNjVNTzR6?=
 =?utf-8?B?L1puVmVoN3YrMkJlTit6S0ZjLzBkck8xTnBZUmpVdzlaWDEvSkdLVkhxaE9R?=
 =?utf-8?B?MFlITG5SS0dvSnBmN0Z4NmZXUkplbGN2TXF6b0h5YkpSbWNqOEcvb0tWdG93?=
 =?utf-8?B?Q1oyRWpUaksvQlVjaGozajY4Q1AwQ1VwVlhlVytnTENBaGVCMlZZQmxodTdE?=
 =?utf-8?B?ZWdhTGNsRTh3ZjR3dUc2azBJWEZyMFBVMkV6TmZSbVVhZXNoT3NlajdVZXlU?=
 =?utf-8?B?OFd3Y2Voc25wUEswdjdQSUptczVYdzlxZGY3WDFZejNNdkFsVDI5YTNLc3RM?=
 =?utf-8?B?SDE2MDNrT3gzekxmclNFbXB3UDkwSzVUZ1dpUDhCTUovVGRFaTRhSDMzT3kx?=
 =?utf-8?B?SVdMaTNxSUNiMm56THY5N2FJMmFsbWQ4enM1c3NwVnpMTy9xQXFpanc3Qklj?=
 =?utf-8?B?M0ZXdTk0TEk5Nm9DUXBieVRyU0FxZXgwWExETEJ2K3hiL1o0M0krNGcyTVps?=
 =?utf-8?B?c0hLYmdoQ1ZVUGJCVTE0d2N3dzNzaTFZMTMvV0wvcHRFRnNIR3pCaGFYc3Zz?=
 =?utf-8?Q?Vgzk=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a847e62-002f-4d56-1898-08dc47c38434
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:20:24.1911
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lXTUpcwWOoaAS2QE0H1U+tTGLBPVX9vzHyHFav6BAdDeCJ7JDrJlUdeMWuMgX+XR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8810

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEtyenlzenRvZiBLb3psb3dz
a2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCj4gU2VudDogMjAyNOW5tDPmnIgx
OeaXpSAyOjUxDQo+IFRvOiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+OyBGcmFuayBMaSA8ZnJh
bmsubGlAbnhwLmNvbT47IEphY2t5IEJhaQ0KPiA8cGluZy5iYWlAbnhwLmNvbT47IGxnaXJkd29v
ZEBnbWFpbC5jb207IGJyb29uaWVAa2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IHNoYXduZ3VvQGtlcm5lbC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGUNCj4gQ2M6IGtlcm5l
bEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXgNCj4gPGxp
bnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gaW14QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHY1
IDMvM10gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQNCj4gcGNhOTQ1MWEgc3VwcG9y
dA0KPiANCj4gQ2F1dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2Ug
Y2FyZSB3aGVuIGNsaWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4g
aW4gZG91YnQsIHJlcG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVt
YWlsJyBidXR0b24NCj4gDQo+IA0KPiBPbiAxOC8wMy8yMDI0IDEwOjU2LCBKb3kgWm91IHdyb3Rl
Og0KPiA+IFN1cHBvcnQgcGNhOTQ1MWEgb24gaW14OTMtMTF4MTEtZXZrLg0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogSm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5n
ZXMgaW4gdjU6DQo+ID4gMS5hZGp1c3QgZ3Bpb0AyMiB0byB0aGUgZnJvbnQgb2YgcG1pY0AyNS4N
Cj4gPg0KPiA+IENoYW5nZXMgaW4gdjQ6DQo+ID4gMS4gbW9kaWZ5IHRoZSBjb21tZW50IGZvciB1
U0RIQyBidXQgbm90IGkyYy4NCj4gPg0KPiA+IENoYW5nZXMgaW4gdjM6DQo+ID4gMS4gbW9kaWZ5
IHRoZSB2b2x0YWdlcyBjb25zdHJhaW50cyBhY2NvcmRpbmcgdG8gdGhlIGlteDkzIGRhdGFzaGVl
dC4NCj4gPiAtLS0NCj4gPiAgLi4uL2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsu
ZHRzICAgIHwgMTExDQo+ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MTExIGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3Qv
ZHRzL2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+IGIvYXJjaC9hcm02NC9ib290L2R0
cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+IGluZGV4IDk5MjFlYTEzYWI0OC4u
NDc4YTEzNGQ0NDE2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJlZXNj
YWxlL2lteDkzLTExeDExLWV2ay5kdHMNCj4gPiArKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2Zy
ZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gQEAgLTE4Myw2ICsxODMsMTA0IEBAICZ3
ZG9nMyB7DQo+ID4gICAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZs
cGkyYzIgew0KPiA+ICsgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICNzaXpl
LWNlbGxzID0gPDA+Ow0KPiA+ICsgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+
ICsgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ID4gKyAgICAgcGlu
Y3RybC0wID0gPCZwaW5jdHJsX2xwaTJjMj47DQo+ID4gKyAgICAgcGluY3RybC0xID0gPCZwaW5j
dHJsX2xwaTJjMj47DQo+ID4gKyAgICAgc3RhdHVzID0gIm9rYXkiOw0KPiA+ICsNCj4gPiArICAg
ICBwY2FsNjUyNDogZ3Bpb0AyMiB7DQo+ID4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm54
cCxwY2FsNjUyNCI7DQo+ID4gKyAgICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQi
Ow0KPiA+ICsgICAgICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3BjYWw2NTI0PjsNCj4g
PiArICAgICAgICAgICAgIHJlZyA9IDwweDIyPjsNCj4gDQo+IHJlZyBpcyB0aGUgc2Vjb25kIHBy
b3BlcnR5LiBQbGVhc2UgZG8gbm90IGludHJvZHVjZSBzb21lIG90aGVyIGNvZGluZyBzdHlsZS4N
Clllcywgd2lsbCBjaGFuZ2UgdGhlIHJlZyB0byB0aGUgc2Vjb25kIHByb3BlcnR5Lg0KVGhhbmtz
IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQpCUg0KSm95IFpvdQ0KPiANCj4gQmVzdCByZWdhcmRzLA0K
PiBLcnp5c3p0b2YNCg0K

