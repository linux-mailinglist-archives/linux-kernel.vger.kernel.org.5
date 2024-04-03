Return-Path: <linux-kernel+bounces-129052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3712E8963E7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF791F243B9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68444655D;
	Wed,  3 Apr 2024 05:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Fi3gkNy6"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2124.outbound.protection.outlook.com [40.107.249.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAE6AD7;
	Wed,  3 Apr 2024 05:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121407; cv=fail; b=Zg7Mvx1SJLO/hUGaraddWI7VY1WTr11kOsA985MrpwgGpQX7Gb45EyNcrgePfewBR2b5YuN54DF3AhFySCXPWp8RcZC+QAwWxdy4myz/PZu+/g4+X6WmLHvIu6W2cUpyYedX5IbSc2WU5urZw1T/JO4tytaVeQzO2Y3flAZRPMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121407; c=relaxed/simple;
	bh=O/vT2qhpKNfeABUbxxV2IQBdT7nTGQmIlPXOVI0gHC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=P3d/2gE+H0WjfCjOckO4haM+wMCboqr5lkIf80kO5JQLzhh6LYXRQrmIepH2bGAvDAUcWIGcC7cfJRhjK8C9Jwu1F3lQ4xdTetsb8ne4WAzpSTTeEiU2lC9ptvsVSQlet745bZ8ZzG+mkPrE7RRWh3oGoQ3ush5KWDMLvG+pkD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Fi3gkNy6; arc=fail smtp.client-ip=40.107.249.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DJm+e9i18ybxqB8+EvJVKMqoqRZGboJYFhFssbrxPE5PrijNEJVKtl+vquuID7J6s5v4IDhcG7w0uAaSbmOYKlXKC1EIlI0kXiI+EhqA7bpRjeq3TSkg1rlQU0nr9Iwcv3Q1i8F6nes1EqS+G2lOj9nUqnxy6JSmyZXHTgPEZMCPo1DwzB3soUsdJdp9oAkk04oeToPEp9sOmmz83uiHkdctV4XQDxn5ZjPws9cprHno7j6yKa5Q31knBPdcOblnnbvDl3+CwKWX6uwo5RGMlkFOe3N5FVdlYq/hCEJyWLqvVjMYCwWdzA2RPb1IzcisP8EVfoiwgKWiVlAN/fRqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O/vT2qhpKNfeABUbxxV2IQBdT7nTGQmIlPXOVI0gHC8=;
 b=KYSSKYSSg2PI2U2q6+7lAE2FpIsQk/UAvcyPYpjPlnKMpGYepNyC8w/gMJGWLTQnRZKW9q3m/pGavSIsqL5MxHKiceXCtrmRqT4EIHK+4v1D6fHkkEaCM1W6aRVf9Zh8LrksADIMochXneGxqYjscPnBVaQVgwPbPt1NImhZVjfUaKBYLW7qneiDC+phMgQ8unz+HYWfvuvoVUKW77IqZi0n3uKoykPp7YTrQEwCl2ALJnJyeWmAf5cwTgXqe8tzoSCAfgvTCAgze29KXlVsMu5BQ8U9g0PHYwBaMvrMauunWFbIhm7o6miksFscZao0oA+Er0mRJtuoAptfTsVLkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O/vT2qhpKNfeABUbxxV2IQBdT7nTGQmIlPXOVI0gHC8=;
 b=Fi3gkNy6xmYLZptiQn4Mc6BgdhraqfBMuFp/nBuCQVSjXPhEdglbIHyc6XTgu6rnZFdEiuBCJz3lC56qwkPhGrV3O3rGWYvYDv1JIfH1eZbXG0B3gfcx9nITPTzb4vu47+7fc2QCoiaE7lCzXC6RHsCZYbwQkaN1jO5Ix6Gy4zI=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB9397.eurprd04.prod.outlook.com (2603:10a6:102:2b5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.39; Wed, 3 Apr
 2024 05:16:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 05:16:41 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Conor Dooley <conor@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "vkoul@kernel.org" <vkoul@kernel.org>, "kishon@kernel.org"
	<kishon@kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "linux-phy@lists.infradead.org"
	<linux-phy@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Topic: [PATCH v2 2/3] dt-bindings: phy: Add i.MX8Q HSIO SerDes PHY
 binding
Thread-Index: AQHahMNS+JRzvfynb0y9Z2TWbFSapbFVCTaAgABBFACAALduwA==
Date: Wed, 3 Apr 2024 05:16:41 +0000
Message-ID:
 <AS8PR04MB867680B7904F3E14B94783EE8C3D2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1712036704-21064-1-git-send-email-hongxing.zhu@nxp.com>
 <1712036704-21064-3-git-send-email-hongxing.zhu@nxp.com>
 <ZgwU8edE3VFYngWR@lizhi-Precision-Tower-5810>
 <20240402-anemic-aerospace-bc428fff280c@spud>
In-Reply-To: <20240402-anemic-aerospace-bc428fff280c@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PAXPR04MB9397:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4OVE8D7N1FLnmna6EokZoxt13sseEuzz3A8rNMFzbPFGGY8BUpZAhYpK8aXRefUzE2ZTm21Q2IHKdTKdR8bKJbHgUGwQnlVg2xrqQiSEpVc9g0JCWon1fjA3WyH3z0TUQnuB52ZfAJxkW46dLhpe1/46SNmY0fLBznY14U7vVpPkVwoQ9JZzee06HTyzI0SLYkDVXgqZsyoZb67nqxciqDEwCl031sA5T9K9F9ETug8upz8aTYI8ua34vCz24Qzl+LyQbsCVBRD1+x9kwsUPuildqsxm4mHAu9+9reXXAcxz07vQNnCFYoyVvZVkKCNWjlDiQl6fUUQ+TgJPkBHj6i48Tu4YJbptVKVMQ7MiaVQRGjAf7OKwrfojxYo/R5yrU8GaOvUT9vwTmQNStvmmoEylz8Vl4RzishZajYTNufEbXvGdHXur5/RnYdxXY5M7vecH97RWn/BEv5u441y6lPYH8A1TVu3LqKCp20EAwaKCzOq8Qv6A4RtEMnQdoeN0SKzOqKdYrOPR+/bdK23CXUZG1HB0cR2lw/tf82JoiFDBI5Ev/UarvRH3XNNtOEWNGqd/pGZAuZ/5Wg04AcbrezlR56fVWEGsdPr2HupwuTfoOAJzsAYefX2TZEv8HQSoAIJeF96fWxHo2syETVWWL2f4AhK5EGQxOE6MrSlpB94=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?OGNDTWZrS09ueUNhamVnbkNVYTBCMDEwM1NSSTNhUithZ002b0o5bXQzS3RM?=
 =?gb2312?B?WStQc1RRdFhpdW1KaHpHYmxtRFczYXd2MVVjRk1uaHQxcHUyTVlSUW0yd2xG?=
 =?gb2312?B?dVk2K2sySjcyVnJmSkl1RHpJMmJiZVhCSWxNZFpiN2lmbllLTUxucG45dU43?=
 =?gb2312?B?eWJFZ3IydGphL3c5SW9qNUhlQ3pBUDltcTVOQnpiMmVlUWZUWXRSWXFreFp2?=
 =?gb2312?B?VjlPUGkySFA4TjEwdjdKYXQyNkdWRnpBRUJiRFdzQ3hQQm5iMWh4dEZ3SXRL?=
 =?gb2312?B?VkRGRmlLb1lDMEtaOE56UjFZSTRNdDZmQWk0K0N4QkdZRDFXalMyL2hUcXd2?=
 =?gb2312?B?VHVxdHA0am50MGltQW5uZ2thbUVwbXBvZnJickpSVitNTktJWjcydlk3SWE5?=
 =?gb2312?B?eElnKzVMczJVMFB3cFpBaE5lZmw1RkVqSzNoUUJyNW5LUzRWY0gxU1B2VWJP?=
 =?gb2312?B?VHd5Z0E4K1ZYeEpwQy9tT3FqV3U0TjdjZ0VXZTdCeXZrOTVwdjhOY3A3bkFM?=
 =?gb2312?B?Tmx5TWlkUklkc0ZSV1JyaStJZ2dWRzNtcm82RmF2QkRtZzF3KzJQVjR2VlFr?=
 =?gb2312?B?eHFxY3hhMEFDSWNXNmt2SmNMTlczWUNwcnlDNmhUeVV3NlFtdnJTMTNRUkN2?=
 =?gb2312?B?d2RoZjU1VFFnckVKajBzR1V0TXU3NEVjNkRJWkJjajVHZmljYkZSMXJCVmRs?=
 =?gb2312?B?SWJhdkpzK0haUzJ4VDlzOUxxMzQyNFQ1enF4eks0Y2N0U2FPV3NSclBOOFhK?=
 =?gb2312?B?L1Z4RzZ1bDJNRjFuMTNIRFRFMjluZnoyME05WmYzQzhHTHJ2czNKbFBvelY2?=
 =?gb2312?B?WXBCelBjSWNlb25KYWhGdGZ3WHRmeTA5aU10UmR1SExoci9GaHloM2VpVDYw?=
 =?gb2312?B?aFNxdVRiOTh4SW1ReS9CVFJlbDZhdFEvdlpoZmRoTUVzUlZHZ3R5TlVIemor?=
 =?gb2312?B?K0x3TnpSTG1pUW1yd2lMejF6ZVFZM2V4bDRIcm5PWlV1bDJUT2daM3RXWDRT?=
 =?gb2312?B?dGxaRUYvaC9tQWJPRzdrbWlzdkRPMWFXUy95MzE5OWhHMjYxalVsMVVvRUdK?=
 =?gb2312?B?NkxsN3ZpWGJPekZwc0szVDJndzBXUzA0TGNydEdzSUQzbmlEb3lnNVNUaTZP?=
 =?gb2312?B?cW91S2xnYzJNNHcya2xDQ3BxZ0k3VThwYjJkS2Z3Ukw5MVFrYVJZeTdraFNm?=
 =?gb2312?B?MEdsd05UR2xVTkhic3ZvTFIwTTZQdU9RaFQ2OW9zSXlpRGh3VUJaZk4xTzNo?=
 =?gb2312?B?QUxSWDVldkIrT0pTV1NBWkhhcTY4N2hGSVU1V1BmcGM1NlpwSlBHQUpuRzFl?=
 =?gb2312?B?NkpkQ3dEQnhDL0RrVm9KWm1meTRVRUNkbWduUER6cDJrNzBSNGJuaks5UG1v?=
 =?gb2312?B?YXlDeGZkc3RYOGNHYzlOVUxkcEF6RE5sT1NMczhVazFQVkdvMzhWaXRxNWds?=
 =?gb2312?B?Z1E2L1orZEZiNTJZdUthdHhHd1VBYVV4L1lXTXl6STQveExoWHM4dkxXSHlD?=
 =?gb2312?B?Q2JiWXJQVEU0WnFLQm5LYml1a1MyUi9BTlI5bk5vaDhBYlFpR0pOSmg3OVZ4?=
 =?gb2312?B?aEt5elZFUXdlUG9jUW1ITDh2cFRxOC9VU2k3cmxqM0dCcVhaUUtqRlEzbkpr?=
 =?gb2312?B?QUJRNUN2N2FkSE9ZcU1Ob01YbVNiaU9GSGpTOGZjVFlxSm1neUFQUVZqbnUr?=
 =?gb2312?B?RWVFTmRPaXNtZ29oSEtMQzNUVWNMeFQyNldOTGdWSFB1S0E0d1JNL1VaeW1H?=
 =?gb2312?B?dWhLdDl4QXQxaUxTaDVNTk9wOEhuUXMxRGxXU3p2QzM4aVNHbU45c3Mwbm5J?=
 =?gb2312?B?ZTkxQ24xeHFjcmZKKzdKeTZ1elBHd1dGdkgyUW1INi9yVUk4WTI0cjdUQVhi?=
 =?gb2312?B?Q3hXbVZ1THlaREtWMkJhbFdySU1RZmJlR1BLSVVuQVl4anhTOElWeEV3UFlF?=
 =?gb2312?B?R3VYS1Q4TEVGWkxYWDU3dDBsNWZSekNxd2NRdHNObHd2SURoOStURXIzeS9P?=
 =?gb2312?B?aGV0QXJTbkRqb1JQaGc0b0xqT3Z4L3JFTnVKbTF4WjRKTy9WMmlCbFoyb3VI?=
 =?gb2312?B?eCt4NnJxOXBqVWcvM1BhL013KytmQndmM01HMUFxV2ZVa0R4dkxIUjJiN3Vz?=
 =?gb2312?Q?Nn3pMNOVghkfd+ku511U1vZCQ?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492b427a-e6ed-4df6-b243-08dc539d3f15
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 05:16:41.2780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gpZb6HJso67KFuKX17FRBoVLQKoPAg0oG1OFCHtE3zY7MrFdiNGndGeDxMzbJ3LW3EJm/lbbc1cNIXbfi6c6EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9397

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENvbm9yIERvb2xleSA8Y29u
b3JAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNMTqNNTCM8jVIDI6MTcNCj4gVG86IEZyYW5rIExp
IDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhw
LmNvbT47IHZrb3VsQGtlcm5lbC5vcmc7DQo+IGtpc2hvbkBrZXJuZWwub3JnOyByb2JoK2R0QGtl
cm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3IrZHRA
a2VybmVsLm9yZzsgbGludXgtcGh5QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdl
ci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgaW14
QGxpc3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDIvM10gZHQtYmluZGlu
Z3M6IHBoeTogQWRkIGkuTVg4USBIU0lPIFNlckRlcyBQSFkNCj4gYmluZGluZw0KPiANCj4gT24g
VHVlLCBBcHIgMDIsIDIwMjQgYXQgMTA6MjM6NDVBTSAtMDQwMCwgRnJhbmsgTGkgd3JvdGU6DQo+
ID4gT24gVHVlLCBBcHIgMDIsIDIwMjQgYXQgMDE6NDU6MDNQTSArMDgwMCwgUmljaGFyZCBaaHUg
d3JvdGU6DQo+ID4gPiBBZGQgaS5NWDhRTSBhbmQgaS5NWDhRWFAgSFNJTyBTZXJEZXMgUEhZIGJp
bmRpbmcuDQo+ID4gPiAtIFVzZSB0aGUgY29udHJvbGxlciBJRCB0byBzcGVjaWZ5IHdoaWNoIGNv
bnRyb2xsZXIgaXMgYmluZGVkIHRvIHRoZQ0KPiA+ID4gUEhZLg0KPiA+ID4gLSBJbnRyb2R1Y2Ug
b25lIEhTSU8gY29uZmlndXJhdGlvbiwgbWFuZGF0b3J5IHJlcXVpcmVkIHRvIHNldA0KPiA+ID4g
IlBDSUVfQUJfU0VMRUNUIiBhbmQgIlBIWV9YMV9FUENTX1NFTCIgZHVyaW5nIHRoZSBpbml0aWFs
aXphdGlvbi4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hp
bmcuemh1QG54cC5jb20+DQo+ID4NCj4gPiBZb3UgbWlzc2VkIGFsbCBjb25vcidzIGNvbW1lbnRz
Lg0KPiA+IFBsZWFzZSBkb3VibGUgY2hlY2sgdjEncyBjb21tZW50cy4NCj4gDQpIaSBGcmFuazoN
ClRoYW5rcyBhIGxvdCBmb3IgeW91ciByZW1pbmRlci4NCkl0J3MgbXkgZmF1bHQgdGhhdCBJIG1p
c3NlZCB0aGlzIGVtYWlsLg0KDQo+ID4gPiArICBmc2wscmVmY2xrLXBhZC1tb2RlOg0KPiA+ID4g
KyAgICBkZXNjcmlwdGlvbjogfA0KPiA+ID4gKyAgICAgIFNwZWNpZmllcyB0aGUgbW9kZSBvZiB0
aGUgcmVmY2xrIHBhZCB1c2VkLiBJdCBjYW4gYmUgVU5VU0VEKFBIWQ0KPiA+ID4gKyAgICAgIHJl
ZmNsb2NrIGlzIGRlcml2ZWQgZnJvbSBTb0MgaW50ZXJuYWwgc291cmNlKSwgSU5QVVQoUEhZIHJl
ZmNsb2NrDQo+ID4gPiArICAgICAgaXMgcHJvdmlkZWQgZXh0ZXJuYWxseSB2aWEgdGhlIHJlZmNs
ayBwYWQpIG9yIE9VVFBVVChQSFkgcmVmY2xvY2sNCj4gPiA+ICsgICAgICBpcyBkZXJpdmVkIGZy
b20gU29DIGludGVybmFsIHNvdXJjZSBhbmQgcHJvdmlkZWQgb24gdGhlIHJlZmNsayBwYWQpLg0K
PiA+ID4gKyAgICAgIFJlZmVyIGluY2x1ZGUvZHQtYmluZGluZ3MvcGh5L3BoeS1pbXg4LXBjaWUu
aCBmb3IgdGhlIGNvbnN0YW50cw0KPiA+ID4gKyAgICAgIHRvIGJlIHVzZWQuDQo+ID4gPiArICAg
ICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQzMg0KPiA+ID4gKyAg
ICBlbnVtOiBbIDAsIDEsIDIgXQ0KPiA+DQo+ID4gSSByZW1lbWJlciBuZWVkbid0IGVudW0gYmVj
YXVzZSB0aGVyZSBhcmUgaGVhZGVyIGZpbGUuDQo+IA0KPiBZYWgsIHNwZWNpZmljYWxseSBteSBj
b21tZW50cyBhYm91dCB0aGlzIHByb3BlcnR5IHdlcmUgbWlzc2VkIGFuZCB3ZXJlDQo+IHByb2Jh
Ymx5IHRoZSBtb3N0IG1lYW5pbmdmdWwgY29tbWVudHMgSSBsZWZ0Lg0KSGkgQ29ub3I6DQpJJ20g
c28gc29ycnkgYWJvdXQgaXQuDQpJIG1hZGUgdGhlIG1pc3Rha2UgbWlzc2luZyB5b3VyIGxhc3Qg
cmV2aWV3IGVtYWlsLg0KV291bGQgZm9sbG93IHlvdXIgY29tbWVudHMgaW4gbmV4dCByZXZpZXcg
Y3ljbGUuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+IFRoYW5rcyBmb3IgdGhl
IHJlbWluZGVyIEZyYW5rLg0K

