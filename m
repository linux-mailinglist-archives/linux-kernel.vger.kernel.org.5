Return-Path: <linux-kernel+bounces-134112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EBD89ADBD
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 02:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 342B1281F1D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 00:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04669136A;
	Sun,  7 Apr 2024 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="OXqYrmmF"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2095.outbound.protection.outlook.com [40.107.20.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD46A35;
	Sun,  7 Apr 2024 00:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712450284; cv=fail; b=j6mSevIkXwa7CuxXfFjqQvRKUvC9yi59AjNgUrm452vvxEkBpRV0Gk+mMKXL1XQzDduNzhz3MLI9UbeDb/vHyHNsn1ADo68joKhFa1h/5PE8dz5CReU3ChkgkELsuT8/oJyl6jaQbXaIbryE3MQLV31k00ERv2bUOEJuBgVeD9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712450284; c=relaxed/simple;
	bh=Vjy2zTenBB28wzW5/Bp9PsKuyYUYJybuc3Iz5AP4hr8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a8tN/T98/eUYy9rj8iNcndQNvvOBinpmfrY9yoWjnIfPWtlEIbN/10JgpMvSVOzqpNhCY2X2kI9KccVhW1aKACmvW8coY1PG1y383pvpY/zPz5qj95gswQ3yysu22sS/qzsNlwm5aG0Noj3URBoAFXBihJx6QPW2OKRVRF3tceA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=OXqYrmmF; arc=fail smtp.client-ip=40.107.20.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZTEOEeNiLK7bupCG3sxZVBiFXbZPaJBVjIxk7RF04PRyv7LKNEHkwA2JRm/FswgfWXmSRxY8ST4ZKgLRcQc2GpaVTdyOdT4P6w7F0O9PgFcnG+4Mfv9EhG7EupVB/WxLwU9vGFxVxxhPsBSRB9Ce8PBwL7RYlbwi7gwnCMj5QEEMIJ9X/FgJJztOc96YGaHoLmJAhvo2XLj/ckb1+uYNhMAntszAFjC5UIykbJ11eLtNYE9XTjst53V9ATtVmoYbBNJh/8Ds8R5bIqasnzE0CxMN+I0D5B/yEk1JQ9WtWWH8eBAObA44WxFpgMSjY/+jBi14M75USFeVPksM0p9yCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vjy2zTenBB28wzW5/Bp9PsKuyYUYJybuc3Iz5AP4hr8=;
 b=ZlEcR06og7rBhyy+FjC8P0QDl/lNe1OHZezcgq2yyEYeyVyKMsO9oj/TeMJXEdJtc/9XedvitFUnR3cZVYcazX/+RN4cL6QoG+rEaV0GUWYNSAro2X/IFHU4JGVq7cwNQ50BAy/+JPKWtWv0S6R2IRWXFBtaifQsK1CjIW1y4Lqf2nPqPe5wU72orxC0cLBC00XOCeYUZ8PAACPLb9ia3AudcDSmKCNieTbchu1qCQRHKR7YUWCSjTG5+kODMeLfLpK19uUTzHTThaeqCI1wZJMcLILg+i9oCGkwiXUenELpX8jhX2NKo2sd2sZ3u/dy7Q8sfjwTEA2I/yWlcVNklg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vjy2zTenBB28wzW5/Bp9PsKuyYUYJybuc3Iz5AP4hr8=;
 b=OXqYrmmFt1qcBzyJTVMpGQNvWvV8yLwB0zMgE5vZw6lf246bGr8EX6uk58RcqQ99dBrJ3TSsoT/52ApCmpTBrsOCJjwq2bq/u/VnBFMuV8S/gnq7AHjk0/9jlkJX/8ClKze2Tg5kZrcMU8zMb+utrd5fTCb8jO7Kiel2p34NgUs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8380.eurprd04.prod.outlook.com (2603:10a6:10:243::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 7 Apr
 2024 00:37:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 7 Apr 2024
 00:37:58 +0000
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
Thread-Index: AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNA=
Date: Sun, 7 Apr 2024 00:37:58 +0000
Message-ID:
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
In-Reply-To: <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB9PR04MB8380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 N+VkteGdXfPAoby1ZSGjKXntoYxufA5JguP3D/S3bKcF9qW+BvuqG7PrEyP/fk+yGTeRS9gztu4EFZZFrxoRcBoKpV8amsWKm8yIX5bOhNsPIneBCW+mF32CItWHQzsls4t0m3XpZzGhhh7iA+fmuc6EM1AeEhwpacxrACrF5BGN+mMmXgA9eExutygQkKMFP+lc4zVzZ8qldurc4LipIc7wyS73kV3t9v5MwfWuPTACuFnjoJR01+TogK50oSVNio1Qy1BvKsULJgJ/AeD+Q9qf938a9ezATdqzPFRuKS6PdL5S6lpgn/KazPOvB+I7Vb5mkS/k0V/vz00q544iWUKqz8SWJxwMRGGEQjrwW+Q5bZ5OfXbUo5cc/ne9drP8SICRQrzsgzbQGEQ0WCBUMvwsHC0ZwzFcgbGXd6C5QdL/Be2r4qvfjMDvsH3ElkV8r23ErlCGWK+iXSMZV9QgWgOwotZd1cSWeJW6jLg+7X7MGWqsKKog7nCyhspoKSGwWg+SKiOi7X6WfbRxASE8c37h4+hFQrsIrHgIDp17gRLuVRgdq2TMtrcyiZxrAe9fA7k9BGl7S20nViJE/xWL2MB3EQIlIW/tL0QwFZ4llW4XrixsntzCHs2m2qWOucSvTKw+78UcJuhIIE2LpBxlJs6yYvB4pSe8oRTJaEM/zf/WnU9bwqG1TxseDPoS0fjJUXpvJaLMjw9xnSXF49H65w==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QzJkQzU5Q05IaGZLekxDMkRGK1BzWC9GaWNQMk8vQjdFaG91UkpudjQ5dXNl?=
 =?utf-8?B?eVlOTHV3QTlvZWFCWWdLL29DRUdkcUdvSFY1eTE4d3BEMllUWHlhMVEvRmty?=
 =?utf-8?B?YU1mbEc2Y3l2anc5RndPQkc0VHBIQ2NLYy9RU2RTMWtYejlhdWkyVzgyVk5v?=
 =?utf-8?B?M0xnbFl0QmNKbklmZnhqRzllWEgxeHpLMmpzRmNuZkk4UWlucUtnRzV0dlZK?=
 =?utf-8?B?UUc0TUpqcjNFekQ3WDJRLzltdFhMZ2Y5d3Baa0lMWlBuQWpIQnl3MDNldmxt?=
 =?utf-8?B?NmI2TldSRW5yWjZ2djVsRi8wVFJ0anV3M2hpUWZLWXZFdzZOVS8weEVjUTJP?=
 =?utf-8?B?Snk0VDRkQzFQa1MwbWE2VVlhN3pZTmZ4UFJYOVBwOUNFNDY4dXhpMmNDdHA0?=
 =?utf-8?B?VlNtS3N2MnoyZHM2Z2ZlUE81QXAwZnJvT1UvUXo4NHRtNHc3MmtrN1kxdHQ5?=
 =?utf-8?B?T0M5U1JCZHNWbnR0dm9LMitjeEdXcHF0L1ZQc3hCNnRQRTU5WTE1RmtHN1BZ?=
 =?utf-8?B?Y2dJN3dxeXAxaFJ2a0FrSUhZZ2pNeE9ZLzh5WDVvYUhURVhoNThvNkVtWjBB?=
 =?utf-8?B?U2U3YVdQU1ptd01raWk4OHBRNFVBZTBYVE42ekU1cXBvMzIybDJQajk2QTlh?=
 =?utf-8?B?KzdKQjVXaDNMNnl2cU1IWE1NNnE1NkM5cFBPOGVCcTVLKzNkU2FhaDc5L1Iv?=
 =?utf-8?B?cTlNOVUzcWovMG1BSW1zZlhyOGpJOTVncFh6V054SGNNUkl6YjBJWE9zNml4?=
 =?utf-8?B?cEJtQ2c5V2xtcC91M25GblNSVG16ZmNudDdCUTVIVkpmcDNWWmh0Nk91Ynd3?=
 =?utf-8?B?SkZCQ3cvb2ZUcVlGdWJtQkVJUHo3TzY1TWF1VXNRa1pMSDVhVkUwc3RXVzRo?=
 =?utf-8?B?NzBnanZDWHVjY3plZ3VWVW5nWDlDd1JGOFJOWHgwYmZTVE4raHF1QVpXRE5X?=
 =?utf-8?B?WVBMbmZ5TklpQk5mUGtXclNCeGRCUEZFK3F6eE5sSlZkWVUzV1locFdmWG1H?=
 =?utf-8?B?WHE5YzMxUGhjTWhpZ015SmpMbnkzeCtCd0YrdzdVOUczdm51YzczeTlJbjRN?=
 =?utf-8?B?RHJpNGVSWGpwRlBJV2VvbGZXbDR1WGJ6UzZ6OEU2UTFYUzBKSnJBUWFqaDQ4?=
 =?utf-8?B?RWJBbnM4clF5eURmMDhZL1RKbEZFNkdrcmVjTGZZdzE2c2pSa1g0cGozZnM2?=
 =?utf-8?B?NUtnK281UlhqYXlVV2Z0YURuaGtzZVVSM1JCdEY1aGRnRytOWURXeDJlL3V4?=
 =?utf-8?B?NHRvWTJHUGllNHVNZDEzdHRqaWFRSDVxOER5OFdXNUhDN3RaMnp1cS9MN2pO?=
 =?utf-8?B?Q05Hdk5Wdk4zaFdxYkhVcUdpTnpXMERIREJ1c0g5MEpVa2FaVVhYb3Nqelkz?=
 =?utf-8?B?YkJ4Y04yRDhXcEk3TW5zMHFEZXlNVFprRjgxN3J3WmFtcjlRRXhRWEpxZ3ZC?=
 =?utf-8?B?c3pYYS9Db01sUllhaVpBdUgrdUVBZ1d0Rm93a2tqRHFTQ1laVnNxazE2aXVy?=
 =?utf-8?B?b0dMZlFoTTI5K3hidXZKL2xxaXo2cHV5eGcvbkxEdjdZZ2RoOHJwcUVJdVFs?=
 =?utf-8?B?S3BJRVZtVlBJbXdyMnc2a2tZRVNRTlR2SjYxdDE0R1p2UnVnaGt6Y1o5ZUFC?=
 =?utf-8?B?WittMHFlMUJDYVNkYlg2elFHdFo3OVNpUnFqT2pqWk5zVllnVFR1Q1dRR0dS?=
 =?utf-8?B?TUlCV2dCUGo0ZFE1QkdyNEhuQU45dyt3cUp3VGd5QkMrRldESG4zMzZIVEFo?=
 =?utf-8?B?dmpBOElRZTlZUlZha1VQMFNmL0VmWVo1TkZ2RjYzQmw2OWRudFE2V2E3NXlz?=
 =?utf-8?B?N29GUnBpUC83a2lSM05GMUhKREN5UDVHWjc4TG5aeDd6QTY4REk0L3FKMG1E?=
 =?utf-8?B?em03ai9oeElkMExlL0J4VUlFMW0ybU1nc3FLK0JwV1cwNDdTYWVZM2RzbFZv?=
 =?utf-8?B?NHM2NFhibERYTzFUTDlGbGxPL05PYytNYVRPVmVYR2h4UUp5RmVJU3BkWk5H?=
 =?utf-8?B?UTc2b3lyT1pIT0lVeTFmVzNQWWdwSlJFb0dPUDl4ZXFBL1pnM2Z5V3duWm5B?=
 =?utf-8?B?dVF2VXZnSTVpTWFtTzVVdHhCR1pNcGlURkpPYmV6RTBPbUJuQkljNktQRlQy?=
 =?utf-8?Q?YNQA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 002dbaf2-8333-404c-1aec-08dc569af91c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2024 00:37:58.4012
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xcYs1sLXEYlOnLQ3V7rEydLl4I7MSE5HSvortpjCfoNgicwBLdlTIV/CJ5/7oD8h0EVc9788LwQ2JVt63PJSvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8380

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0s
c2NtaTogc2V0DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gDQo+IE9uIDA1LzA0
LzIwMjQgMTQ6MzksIFBlbmcgRmFuIChPU1MpIHdyb3RlOg0KPiA+IEZyb206IFBlbmcgRmFuIDxw
ZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gV2hlbiBhZGRpbmcgdmVuZG9yIGV4dGVuc2lvbiBw
cm90b2NvbHMsIHRoZXJlIGlzIGR0LXNjaGVtYSB3YXJuaW5nOg0KPiA+ICINCj4gPiBpbXgsc2Nt
aS5leGFtcGxlLmR0Yjogc2NtaTogJ3Byb3RvY29sQDgxJywgJ3Byb3RvY29sQDg0JyBkbyBub3Qg
bWF0Y2gNCj4gPiBhbnkgb2YgdGhlIHJlZ2V4ZXM6ICdwaW5jdHJsLVswLTldKycNCj4gPiAiDQo+
ID4NCj4gPiBTZXQgYWRkaXRpb25hbFByb3BlcnRpZXMgdG8gdHJ1ZSB0byBhZGRyZXNzIHRoZSBp
c3N1ZS4NCj4gDQo+IEkgZG8gbm90IHNlZSBhbnl0aGluZyBhZGRyZXNzZWQgaGVyZSwgZXhjZXB0
IG1ha2luZyB0aGUgYmluZGluZyBhY2NlcHRpbmcNCj4gYW55dGhpbmcgYW55d2hlcmUuLi4NCg0K
SSBub3Qgd2FubmEgYWRkIHZlbmRvciBwcm90b2NvbHMgaW4gYXJtLHNjbWkueWFtbCwgc28gd2ls
bCBpbnRyb2R1Y2UNCmEgbmV3IHlhbWwgaW14LnNjbWkueWFtbCB3aGljaCBhZGQgaS5NWCBTQ01J
IHByb3RvY29sIGV4dGVuc2lvbi4NCg0KV2l0aCBhZGRpdGlvbmFsUHJvcGVydGllcyBzZXQgdG8g
ZmFsc2UsIEkgbm90IGtub3cgaG93LCBwbGVhc2Ugc3VnZ2VzdC4NCg0KVGhhbmtzLA0KUGVuZy4N
Cj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

