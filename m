Return-Path: <linux-kernel+bounces-84645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF986A972
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:02:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A91F71C21098
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:02:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B82592563F;
	Wed, 28 Feb 2024 08:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="A7wRPO58"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2043.outbound.protection.outlook.com [40.107.104.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FC482561F;
	Wed, 28 Feb 2024 08:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709107321; cv=fail; b=Mr+3QLQzN4o1Ocs8ZFegp3DJaHIE6XyV5zkKMl0FjDnlZZtbQL80BRSHDISanbfcEbgPWRQTOxiv+8ECxPkTd4bF4jR+XdhvVZLcI7DoF7tezzWzedVLdgTgBn+guELsSzCyk5AOQG85DQ7hYXR0paQVwwYsxrvLcqPmPR6xAi0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709107321; c=relaxed/simple;
	bh=9biG4xvcUUOhp0u6lmh+7avHL0k5CYvFsAGWDfl4Wg0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NOaIS/MMmPRcbXHDJQJ5tIKXMOCzMl1fV12VjJUCg4jxF7JlhPYNcSLJOGP4XMkmvqBDLB2bYEFEvXsfC5/CQnTQVfCN/M5DPcmLNiXnw1dkPT9ZLGpPzllu8qHJIMG/428LtA/5tiFaS3GN6EGl16mEoYAXrs6/mzHYZzl57c0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=A7wRPO58; arc=fail smtp.client-ip=40.107.104.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeLC29TRL0QxgdYDeoHLJFYvPUUE0Z/yHfUwpLMVpbB3k8xzhf294t4JDamC3zZoBOsS/QSYq0PBsGbExG4CWpsfI9jEOhgPVfOtd6dtTMzLWZjS/eXCP/urlpCKzCvWsKpVKAbpKnKW8YNt7rlrHxDAP5Gr8/bRkQdJ3EaALJtaJgMWpizVovFUmuXM/NXDg6pySxLkY3RQ3NzfyVUZr8S9sq7CyTm4SjSX6AG7yJE5e8C1LV/hNdRDG91Lo8SbFps0ivw5yQ9ujchntTzuySBxFBuQgxSgQgqdZhSd2nlOyiH1oVBBqJTGOR8+b6O/WLuK55vTNiC2yGkTkopsXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9biG4xvcUUOhp0u6lmh+7avHL0k5CYvFsAGWDfl4Wg0=;
 b=hbH2WA2T9khqER1Tusoyd3lmlUoZ/0EPCuoGsaJPhqW4+KT10uVvOHJq8Caj5lvJ9m0aRl1nvTsH+Glp8jzgekDHP+KzTW9cAf8IFOCq3VMNEGME3VfeP1DGhuVY3p5fm4R2/A4/RwYGO8hof68aVgvwZ60lYb4cO84xTBcexmHPtZZUwC22xMeB5+9SW9PlDw8rfdk13nyDsPcSAw0BJV8j00TgMPvME4hBNjMP/54eCs4yKjhKgxNp6i8fT7bmqC/PuvqEDiqNcuJjRFPurJqJ4MswiQ1/rIgGiRBX96yJq4a5vovn5B7EFsSmLcYK6lqZugiZVW7R699x6LGAUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9biG4xvcUUOhp0u6lmh+7avHL0k5CYvFsAGWDfl4Wg0=;
 b=A7wRPO58N5czzyifzZ2OyZBITW9+7Sw60IxHqp8aerG+bgi8rnEtmBosU/x8vahm4ipXHTIgD5T+TH1KaR0ZKZ4mZFI6fLknhzYt02HvtfBotHyoY8NOSCKKC/z6R9vQix1vCzjXxi+nQThAAo84wahRuovaltJB47ICGlOn5JU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8511.eurprd04.prod.outlook.com (2603:10a6:102:212::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 08:01:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 08:01:57 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Abel Vesa <abelvesa@kernel.org>, Michael Turquette
	<mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha
 Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team
	<kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Topic: [PATCH v2 1/2] dt-bindindgs: clock: support NXP i.MX95 BLK CTL
 module
Thread-Index: AQHaagfdonzElS9QB0ar9CNUieP0DLEfYCWAgAABgsCAAAKDAIAAAEFA
Date: Wed, 28 Feb 2024 08:01:57 +0000
Message-ID:
 <DU0PR04MB94177A2CE11FFDE3C3E015AD88582@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228-imx95-blk-ctl-v2-0-ffb7eefb6dcd@nxp.com>
 <20240228-imx95-blk-ctl-v2-1-ffb7eefb6dcd@nxp.com>
 <1ad77c33-71de-4bc8-a53e-1e74a5096079@linaro.org>
 <DU0PR04MB9417459448EDB8A674827DD588582@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <44d0b0cb-e366-45bb-b24f-a8386cae21d8@linaro.org>
In-Reply-To: <44d0b0cb-e366-45bb-b24f-a8386cae21d8@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8511:EE_
x-ms-office365-filtering-correlation-id: cf2c77b6-b9a5-42db-f8ac-08dc38338905
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3bbI0IxF2609VoCNjb1lb4OhHJus6dbiG6TZEG1Zq7R+iGXNLvkjzLhDJlPMDY9udmjxlNPWtCGIIAPtkd6CfDvWBhlHeFR7TvDCCuJMYVJTSW1lG2ILP2YRU9Pr4hqRuQGK3esYCY1zFthM2/KA14ImKuOJpaDMTwXp2Bvzr9Ri2UD0t+NtcEopsYpe3/ekxh9KzrvhS0XL1AWzmrfHPhltkCqur6X9QwGPgc7f0FxHTOa+YwRsCSi51zAjJ999nI0yAgy1rI4mUeTJwqG5UqvqzaEDwuscvIx/QKqGCydIyI2MXMsTxAJ1flX7K4wG2MmTa95Y3pRLFwXoe0GLUDhWsDGgWUN0b/pfa4PAoaPvYo7UjXzHahHqXEyGd8/LhZK79+MUnVEg+h1YL0UQOhkBdpIMtI5peBJvuvW/Zg+mTUh91PLr8nee8Ku2XzwCgRpIPKWipCtTM0+0qv+BsnhDGyuTPw3RVV+L0jOc/GhVlnD5qDayoYe2eocjlfF/88BdR5Rz5FzbDz9hzhRUyo6EWjwr3qBy17mtm5KPEcIatWEIgX6108urmbZAK85tGbdCFiNGTcHgxTa7m1rJn86I1Wv7GD0Jml9OzG9qe81TXdJ8XoQgKhS0Ea+Zcsy3uAicC3iosjjhMF1a1defnw7U8LsuGT4xULyTC0pBgAmSHWAFZa0p6cZ8xpL+lNknBqW0ZPK7hyV3lKF3iuXF8baQeeRpLDkuVXPIf1eb88c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SE9lKzEydC9KT3BHZHp3WnI5SUxTZmM5S3dib2xBRVdVZEcwTy81UEVMSDdj?=
 =?utf-8?B?Z2VZQ3cvangwcENjSCtpRlNrMkt4ZzgvNUFObFM2QnJNblh5MWNmUXA1TzIz?=
 =?utf-8?B?bHMzOCtYdTNWMEVOd2luT0RiNXdjZUVxeTlXclV6V2d0T3puQWtqbndMYUJo?=
 =?utf-8?B?NVE1K1FCMXFqMlF3cVpkSGVkSE5lOHpsQUxDZnpZQmV5RXl2ai9yZEFWa0xl?=
 =?utf-8?B?WElFNjdOTDJEc0RHS2d0L2ZoWW9PK1g0eXNDbHdMVnZ2bjZ4NHJSVWVhMDBa?=
 =?utf-8?B?dkxlVU5XUmhCV2RYU21lSTRRdEVSSnhNSkdPWVJWN0xpU3NHZ1Y3dVlJVEZl?=
 =?utf-8?B?WndsZnNubkZ1eGk1Zk5OMGpLTjFtRGp2T2o0NE5Fb1dvdktMUm9MaGphTmxt?=
 =?utf-8?B?VThCR3N3K3dJOE9XUk1leUpLZXFFK081UTQzTkUrOFN3UFFPVnBHVGRUbmFD?=
 =?utf-8?B?Yk8rSjdBMzdCWS8xZGl0M3pDY0dwZ2NIZXV1eno4TThoaE5FK0lNNGdLeHV4?=
 =?utf-8?B?S0JxSmJRR1lrc3ZKNTY3MjZSVTBjTkhCcUdZbkhPSkxiZEVqMTg5c01KVzFS?=
 =?utf-8?B?RlNxWU5sS3ZZUFpQYWxxUFNzV09xRmlmZWVsem5oZVVndkhuZnVURXpUMExp?=
 =?utf-8?B?R0ZqU3hEZVUxQ3BGdTduVnRiVEdFTlVxQTlXKzhjQmdGWWV3SDRGNzVWaVZO?=
 =?utf-8?B?OEluNzBIS0FZR2dkVnRzOTFGdTJxbWo3SGQyTE13SmhvMmhkU1VxWHFVTmhw?=
 =?utf-8?B?NzcwQ1VDZFhnaFBGOUI1aVhUQ1A3Mm9TaWpWVDZ3b09vVTVveVIxd09zc1Z6?=
 =?utf-8?B?d0NOb3JUQ0J2YUxoenlUNllsa0dQZFJoWGViaGxxTTNZOFVIeHZBak04MTA5?=
 =?utf-8?B?NlJSejVIVGlZNXVpa25Qc0VTcXkwZXd0K2c3K3c3TVBwU2xJeTFWc2hueXFH?=
 =?utf-8?B?dVRtYnowb3hSVEFoVG9zb3dtd1Z6NFA1Ui9jRGpONmJGaEl4bTRYQWRGcmxC?=
 =?utf-8?B?SUtGcHdtYXF4SzEwajFHNFo2Y2ZYR1JMMlJVUXJ4MmdpMklTZ05CMTRiRlJM?=
 =?utf-8?B?UEVtMDY0VnFIZFUxTVI2U1lRcWxaVXd0V1NKcE9jRWtWd214ZTM0MnFJbCtE?=
 =?utf-8?B?MVl1N0hsbGR2MnBKS2dkaFBQZHF3VzdKWTRFOFJWaHA5QldPU09jRW40cFZi?=
 =?utf-8?B?aEQ3b0UxYjJsV2hidWVzZGpDMExnVUg1MGp3eGEzQWhiUUVaWW0zR2llVGhB?=
 =?utf-8?B?ZE42QWdJcDQrNGFDdTBpRmNOaGV0Rm1iRVBPalI4MHhLVytwNWRCRFc4UUdp?=
 =?utf-8?B?azBmekhaeUFsbEtmNHBKWi9aTW9VclBQYm9hZHFNWW9jbWV3SVJSUFd1ZGo5?=
 =?utf-8?B?NWRHSGIxVEwya1d6QXFkdmdtK0NyeDhaTnN5c3dDWUYxN0JJYnd6Ynd5eExG?=
 =?utf-8?B?YWF2V3BTdER6SlB2dVQxSmlxZjZmdzZrN0JwZDNTZWJoNEU2bGpHYkE0blgz?=
 =?utf-8?B?d3RFZkhFY0pMMVNRQnQ3MTM5RnFRUTk5THVUbFlDUlh1OCt1eG5BcEN2NkFK?=
 =?utf-8?B?dTJBUktUWENUYnhYZ3dVTll4cVBWK0w1clFyL0syUHN2NlNDL25FNjJBZU9N?=
 =?utf-8?B?Z1ZVczVvMU9ML3ZXYVJuQ0EvbmY3WFpHdXV1Q0VnYWRENWJOL20ra25POFlx?=
 =?utf-8?B?dHFMSDJzWldiN1hnOFBZRCtOQ1JJTDQzcUJwcG5PTVdsUUNsT2lOWXBSYnZw?=
 =?utf-8?B?TktJcklpalpOUjV2aDZtdmplZmVEUFNyZEU1OTBiYTA4SS9wQm80UXhjWDVy?=
 =?utf-8?B?UXBmZURYY3hOZU40WUNVcWdsRlZEdlFmdFpSOHlSUkhHL2FBWlNCd3J2RHN3?=
 =?utf-8?B?V2QzUnhUTVk5VTZ5UHMzWGwyWDE5M3FmSGhKeUltbDRIR0x0eWV5bHY4OWtn?=
 =?utf-8?B?T1psbUVJT3dFaC9JL1RERUNpMXFSQ3BFVzNMZzhZYmxRL1h6c0t3am9qOThq?=
 =?utf-8?B?WkIrK1NVWFpvQ0tETXh1bXVtQy9hdFRpSzIzcEo2Q3I2T0J1SnZTdXZTUUpj?=
 =?utf-8?B?WkhSTmRjWGJVRHFBejJ0d3VmYXY1ZHVpRjRzTXVxNnA2UEEvY2ovNzN3QmpD?=
 =?utf-8?Q?bOGk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cf2c77b6-b9a5-42db-f8ac-08dc38338905
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 08:01:57.2974
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqPexAWAKtcU8UmKmWfOnUVL3tYp0xMWTz6qWueouiZrsr9vHpu1SuOcoUegNRo3pUNYsYQy+enC5G7ECALGqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8511

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZHQtYmluZGluZGdzOiBjbG9jazogc3VwcG9y
dCBOWFAgaS5NWDk1IEJMSyBDVEwNCj4gbW9kdWxlDQo+IA0KPiBPbiAyOC8wMi8yMDI0IDA4OjU0
LCBQZW5nIEZhbiB3cm90ZToNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJp
bmRpbmRnczogY2xvY2s6IHN1cHBvcnQgTlhQIGkuTVg5NQ0KPiA+PiBCTEsgQ1RMIG1vZHVsZQ0K
PiA+Pg0KPiA+PiBPbiAyOC8wMi8yMDI0IDA2OjQzLCBQZW5nIEZhbiAoT1NTKSB3cm90ZToNCj4g
Pj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+Pj4NCj4gPj4+IGkuTVg5
NSBpbmNsdWRlcyBCTEsgQ1RMIG1vZHVsZSBpbiBzZXZlcmFsIE1JWGVzLCBzdWNoIGFzIFZQVV9D
U1IgaW4NCj4gPj4+IFZQVU1JWCwgQkxLX0NUUkxfTkVUQ01JWCBpbiBORVRDTUlYLCBDQU1FUkFf
Q1NSIGluIENBTUVSQU1JWA0KPiA+PiBhbmQgZXRjLg0KPiA+Pj4NCj4gPj4+IFRoZSBCTEsgQ1RM
IG1vZHVsZSBpcyB1c2VkIGZvciB2YXJpb3VzIHNldHRpbmdzIG9mIGEgc3BlY2lmaWMgTUlYLA0K
PiA+Pj4gc3VjaCBhcyBjbG9jaywgUW9TIGFuZCBldGMuDQo+ID4+Pg0KPiA+Pj4gVGhpcyBwYXRj
aCBpcyB0byBhZGQgc29tZSBCTEsgQ1RMIG1vZHVsZXMgdGhhdCBoYXMgY2xvY2sgZmVhdHVyZXMu
DQo+ID4+DQo+ID4+IFBsZWFzZSB1c2Ugc3ViamVjdCBwcmVmaXhlcyBtYXRjaGluZyB0aGUgc3Vi
c3lzdGVtLiBZb3UgY2FuIGdldCB0aGVtDQo+ID4+IGZvciBleGFtcGxlIHdpdGggYGdpdCBsb2cg
LS1vbmVsaW5lIC0tIERJUkVDVE9SWV9PUl9GSUxFYCBvbiB0aGUNCj4gPj4gZGlyZWN0b3J5IHlv
dXIgcGF0Y2ggaXMgdG91Y2hpbmcuDQo+ID4+DQo+ID4+IFRoZXJlIGFyZSBzb21lIHR5cG9zLCBz
byB5b3UgbWlzcyBteSBmaWx0ZXJzLi4uDQo+ID4NCj4gPiBBaC4uIG9rLCB3aWxsIGNoZWNrIG1v
cmUuIFBsZWFzZSBpZ25vcmUgVjMuDQo+IA0KPiBXaHkgZG8geW91IHNlbmQgdGhyZWUgdmVyc2lv
bnMgdGhlIHNhbWUgZGF5PyBHaXZlIHBlb3BsZSBjaGFuY2UgdG8gcmV2aWV3Lg0KPiBPbmUgdmVy
c2lvbiBwZXIgZGF5IGlzIHRoZSBtYXguDQoNCkp1c3Qgd2FubmEgdG8gcXVpY2sgZml4IHRoZSBk
dCBiaW5kaW5nIGNoZWNrIGVycm9yLCBidXQgSSBtYWRlIHN0dXBpZCBtaXN0YWtlICg6DQpTb3Jy
eSwgd2lsbCB0YWtlIGNhcmUgaW4gZnV0dXJlLg0KDQpUaGFua3MgZm9yIHJldmlld2luZy4NCg0K
VGhhbmtzLA0KUGVuZy4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

