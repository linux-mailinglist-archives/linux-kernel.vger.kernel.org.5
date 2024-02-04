Return-Path: <linux-kernel+bounces-51558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B011848C79
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBF6B1F21B41
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562D818AE8;
	Sun,  4 Feb 2024 09:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JjY/KGyK"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124CB18AF9;
	Sun,  4 Feb 2024 09:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707038974; cv=fail; b=np1DaE+FulOvGChqKKkO8pJUgPdRF3QVMryOl7VyG53es1uwizRtMW/dbMRQwdyCr0Gsjt9YfbGaaGOkWW969fo7apEt26cFckvLcurzRtlB77WUKxNaYB6yiDsy2GV+heOaHfqfdGzlesPv0w1eD6+Dw7fGIHKGoGbF1FPpZGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707038974; c=relaxed/simple;
	bh=MW7IdcxE2fMqzdiBywVeAI3ZhNilcROKFs60fUTQtBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lDsTVWUbx7nsLDUtEWyV4JQstXczRK8km6D/rZDUXVi7pV/X1srgycSVqgQIFRRpinbsNPXM8lAQ0fVTNzGXzafT7cGAbTuahkkkxBu7w/LL0/CR1Wy1rRPJ7IRu6z5ZqfQE2A33U4VAEZLiQoC0Bw8l6+B2iqNV8uzcXCPY+fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JjY/KGyK; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO5gOKMCqm3IHwXQfQYmNA5IxZ5jNXjRrcFD9VcfFE92d0k2eOD8iYbbYWQ/xcp+rlYqVoPhed3IIyer4LJC7p+h+L031zklbXtjAohQMgCZns011WWJM55GxfpVwTjG+AnsDp6Tz6bjsS1NABps7I95tUhlfV8Yo2uSwyUNHYsYDvEG+SAo/tZHXzmqDNWCla7naN1dCBviDgyO/OuVGR4CHvhCVIdbzX5Q+YnGvaKYBejchf1xTuYI7MbtNH9yrTQT/qFpwu3XgOKyFAC+h/hGoj4GRDbWPTKEdC8eUyI26anVZ4aYKYxFA4GCQcoMCv3Q/LjVetNmgGPxS+3rbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MW7IdcxE2fMqzdiBywVeAI3ZhNilcROKFs60fUTQtBs=;
 b=MBRc3LB+FdWL/5WUth/YNLDSnJaKvCPziq1mSTDlpiNLY85gjEj07UfU8UodW/D3ibpnpv3hXVXQUiPZh6tkCg/R0jULsUKrP8GnVoLkS6fwjO5ha3LIHyKY0g2t9pxlMef4VCT78Bjgrp+gFgf3S4hB7aBq5kewH57coRltjrVLIbUA/ZqBG9HQbGdL0ZBfr3W0MZW7deJjZCI0McbzxYCnGnalzBpqb9iihkDjEs4VctTc3iHU0IFu367owl6zjiskFG1sRq748Pw+En0t8Z/rOisk5i09QvMfkMkYUGcSLJOtzxnVRihpKXrRgu1wK/Bf36tRH8WOrW09Cm2awA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MW7IdcxE2fMqzdiBywVeAI3ZhNilcROKFs60fUTQtBs=;
 b=JjY/KGyKxtGOugL3xS4iqaRltWxzFHZz65NH8l1BpBar+UyBXxt3AeqaFfJWrPL4OHZLAd3nf3kD+xRKtYTIfSwkzZ9iQge4vlLczlrs2bicdzXdJnA1DxfV/2rmeXksnk6KrVQ6xe2igSg/Qmp6+wtVBg2Fttp8bSxh+zwRW+8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7248.eurprd04.prod.outlook.com (2603:10a6:800:1aa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.33; Sun, 4 Feb
 2024 09:29:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7249.032; Sun, 4 Feb 2024
 09:29:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Cristian Marussi <cristian.marussi@arm.com>, Sudeep Holla
	<sudeep.holla@arm.com>
CC: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "souvik.chakravarty@arm.com"
	<Souvik.Chakravarty@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Oleksii Moisieiev <oleksii_moisieiev@epam.com>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, AKASHI Takahiro <takahiro.akashi@linaro.org>,
	Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v3 0/6] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index: AQHaTFMXfSW/KLMkFECgD1P261LWWrDwxwIAgAAQxgCABEqJkIAARhUAgASMwWA=
Date: Sun, 4 Feb 2024 09:29:25 +0000
Message-ID:
 <DU0PR04MB9417CA6CF089B264112C32A088402@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121-pinctrl-scmi-v3-0-8d94ba79dca8@nxp.com>
 <f88d07ef-83b2-4d14-976a-6dbbd71e036f@oss.nxp.com>
 <CACRpkdYV=qYQ9qDUWYTLDAV1niay30gYH5S=zjfi31GpeY5o-A@mail.gmail.com>
 <DU0PR04MB9417A9074C5DC49AE689E65288432@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zbt-QkWhz5d9P-v6@pluto>
In-Reply-To: <Zbt-QkWhz5d9P-v6@pluto>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7248:EE_
x-ms-office365-filtering-correlation-id: 2403ac45-a0e7-42eb-7f07-08dc2563c72d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cavfeyfeE/1ybGXFp3ugRvu5keH9Z+DHFeHGosL7eENRswn9TpaevZ6wWN9clUNCt+oRpmLTz/YXZ1nQZsuAjMe1JbNYt/E2mI2OYt1EVOBaqZ/46Jv2tTMNteUhu2L5Mn4QtzQc3ABCETTve8cn+3soF8GebgKbYxsiqq0Gavv2j+qT7p3Es96HO0e57/vg6dTv/URs1BMUizC5934uaTnexBlwnJu6yoetxvVCkR9PggAiJqLKYLL4m+Ns0vtuEw4cUJsNAJUJet5dKchgrfRLPhydWtVuXI7yzvtWfPY7tKIEl1Y5LHYRUgfVBk4rfw78c/ISqcutd1G5esMdxE1Llin1fMtDf1jBvBt9uH2sr937pzAg4dV1w3WsrEaKcyYsDVPUpv9W9RWrScxeVVKxXk0aYZuS1WgmToTB5ca6btR1Par9l9XL/ZdeqYVyDdjuXYCAah9/O236MWlRudDqQOjne5B6+gjI0WvxhOy6ZnqktscNnhHWZZxhHmQ6DmM2eazDRs96SaHA2tDwoWfgj3ujuoWcUMgzPDCA6Sq0GoPCz8ljAM5IgA/Gu/TYR7R5watBE1mVlk9M271NOZ+iEzkAevKjcJJTCNYvJjI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(376002)(136003)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(55016003)(33656002)(41300700001)(53546011)(9686003)(966005)(478600001)(38070700009)(86362001)(26005)(83380400001)(2906002)(5660300002)(7416002)(66556008)(66946007)(316002)(66476007)(54906003)(66446008)(64756008)(71200400001)(6506007)(52536014)(44832011)(38100700002)(8936002)(122000001)(4326008)(8676002)(110136005)(76116006)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmRZQk1qWEMwYU8vZUVoTUY2VXUrbnQ1WEFDektDVjZpeWFLbGNCeUNDYStG?=
 =?utf-8?B?c1N6eUhDa0p6RklXaXVZV0FySE5nMklFOVFkcXRUeXZQalNtV2V4dSs1bCsx?=
 =?utf-8?B?SVlTSjJjcDdvU2J6U2tXR20yemcrWk1yM2ZIa2ZwdEJ4d1lhOG82b2pMelhZ?=
 =?utf-8?B?ZnA3OTN3d1ViUXFmQlMwV3o5a215em9HQlVkeFdXOEE2WmJUZnY4SmxCdUpS?=
 =?utf-8?B?ZFRCSFluMkFYVHRQaHdJZ29pWEoxR0JOVElDQnpmSW1wMGV2UElkSGlQL0hS?=
 =?utf-8?B?R2YyV0xRN2xCUFZEeFlaeGNWenR4WUdoaEZJUnFYWi9rdDZTRTVGcUx2UlIx?=
 =?utf-8?B?RWhjd29DUzhNMGNVTzEzclZ5VjlieHYwc1pPd1FNc2orNmEvTEVTVHcwUFBH?=
 =?utf-8?B?MytwMGNWWGZyWEtxb3owejBzQmxFSk9JTGZDSStvWitydm5aQTRxcXQ5YjZp?=
 =?utf-8?B?VndubTJPSDVwcDRqVmZtb1Z0a0hjTmtNSzlDM1NPbHFHVmkxdlRnNlUvZ3hr?=
 =?utf-8?B?dFdtdkdyOFpDZFdZR3p2azBkUmtqZ3gwRnNhY3hIUkxzT0dFY0xkSkRzcWx6?=
 =?utf-8?B?QnpkZ1N5RWFSVUlIZGlHQXNidWZNTzdFakx4RFVNYWhSZlNNaDNKaXBSNHNK?=
 =?utf-8?B?RDRWRDdZQk5ra0tFc1ViYmlnY05SanBZd0Z4eUt0T3dpaXI4Q3plbDE3M3pa?=
 =?utf-8?B?QWh5ZTlNeS9CQUZNSUhPaGpSdDZmK1BHdHNtb2pqL1JhaW8vN280eTVoaWhv?=
 =?utf-8?B?NlViUVR5MVZzZGlPV2ZwT3VFbTdsVHRGNXBSTmxjeUI4c2NBNXh0YmpCNHli?=
 =?utf-8?B?ZFBpUHk5U3J2a1hzZmhHeWhWSU5wY3RLcEpmMkxpMFJBbGV0K2RxT0tZODMr?=
 =?utf-8?B?d25xd1lRU3FNa1lvSURmQ2wwQkNUa1JaeHI3UlM1aFcvQUFTQ0JhbWdqeDlq?=
 =?utf-8?B?OXFEbFltSGFiK01IcHZLNlEvQVdWUDE0RGprb0s2ck1GS0JLT01UaVgyK3ZI?=
 =?utf-8?B?a01WTU9NRU8xWk1XdzJZMzRLREVzMjA3UHU5QURUeHI1cVRxV3BPOXZZS0lS?=
 =?utf-8?B?RExrYjFtSmxFeCsxdEE3M2RHeG90aTk2ckd4UWNzUWg0M2JvS1dCY1gwYVdj?=
 =?utf-8?B?MFRCV2t4T1llTHZ6Q1B5Z3NYOXZEQUphZUY4aDQzNVcxbG9vc1BtMGRkT2ky?=
 =?utf-8?B?a0JxdmdRTGdCY3BBcWExelArZkdoZVUwSk5tQjd3S3NQcjgrMEtzMWszbjRJ?=
 =?utf-8?B?cHRLeDJtWkZ1Q2t0M0tSSkdLTnN1VzFnOEhvKy93MGlqd2srRHNtYzlFamxC?=
 =?utf-8?B?aWdmM1lXaWNZbUZZYWJNNzVocHZ6THRzTkdQN2VLUEY0YklQbWx3WHhKaXBT?=
 =?utf-8?B?V2VrZDZRdnZFT09RanVMdGQwb2h6TXZueGZnbjRkSDVPcVllY3ZPR0JqcU0y?=
 =?utf-8?B?bjI0MzhqSlZJOWkwVXplSzEyWWxwRDdYTUhZbVpHd1JIUGtiNWhQRVNjWHlh?=
 =?utf-8?B?SVQvVHlGb21ja1hEcEFTdUdZaFhXNVIrUXZqem9tN24zNlVTQ3I1QzhseTJI?=
 =?utf-8?B?cElsQ0lKMHdNNWJ6d2o1RjF5ZEtkdE5BdWlmK0ZweVhHNjVnRkFuOVpQWDZK?=
 =?utf-8?B?OW04OFpGWWxSTTg4ZGR0cE5PTFdHSm82QU5LVWQxY3lIakxhbHM3MjJMby9h?=
 =?utf-8?B?Q0c5LzR4RGJlSXIwdjNqdE1TYXF0SXVKK2g4am9SanZCa1F1RzNTQjdQOTE0?=
 =?utf-8?B?SVUzd20vSStITW5ZWEc5cThvamxrVkJsY2xoN01aSkx3dUFHSjIvZ3dtTS9X?=
 =?utf-8?B?bDU2R1EvUDBzS1VHbklUNFRFWWdXakV3ZEtUSVg5ME9YVUYzTnlrblhlV0VO?=
 =?utf-8?B?azRaRldLSHNtaEtiOWg1R21tV3Y4RFE3ZWt2Z2dXb09SbFh1dG8zeHlDV0JR?=
 =?utf-8?B?ZlBZQ1RUcnF6KzJWM0Q0OHpJSFhKS0dKaDJCOTJtb1poQUpQYTJRNm5MVFNS?=
 =?utf-8?B?R2lyQXRwRlpMenA4bHRvZFVwbFNFanJhMVVCc1pXZEM4Y3pNRVRqUUxlUTBm?=
 =?utf-8?B?cyt2SHk2UmhnenZ2UDVYZWFRb2VtbUtQZHg3dWdDMXRaY2xHYldpVHFBYlJZ?=
 =?utf-8?Q?EYcY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2403ac45-a0e7-42eb-7f07-08dc2563c72d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2024 09:29:25.3003
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: be0O9jk7/aM4iJ+5YhHvyGzYXjbQbsda/hgJsr6nKeycTylSerebefUCUS1abpzNGTFsPfZTbbs+pjx5HuNYqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7248

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0KPiANCj4gT24gVGh1
LCBGZWIgMDEsIDIwMjQgYXQgMDc6MTQ6MTdBTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4g
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDAvNl0gZmlybXdhcmU6IGFybV9zY21pOiBBZGQgU0NN
SSB2My4yDQo+ID4gPiBwaW5jb250cm9sIHByb3RvY29sIGJhc2ljIHN1cHBvcnQNCj4gPiA+DQo+
IA0KPiBIaSBQZW5nLA0KPiANCj4gPiA+IE9uIE1vbiwgSmFuIDI5LCAyMDI0IGF0IDE6MzfigK9Q
TSBQZW5nIEZhbiA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+ID4NCj4gPiA+
ID4gQW5kIGZvciBpLk1YOTUgT0VNIGV4dGVuc3Rpb24sIGRvIHlvdSBoYXZlIGFueSBzdWdnZXN0
aW9ucz8NCj4gPiA+ID4gSSBoYXZlIHR3byBwb2ludHM6DQo+ID4gPiA+IDEuIHVzZSB2ZW5kb3Ig
Y29tcGF0aWJsZS4gVGhpcyB3b3VsZCBhbHNvIGJlbmVmaXQgd2hlbiBzdXBwb3J0aW5nDQo+ID4g
PiA+IHZlbmRvciBwcm90b2NvbC4NCj4gPiA+ID4gMi4gSW50cm9kdWNlIGEgcHJvcGVydHkgc2F5
aW5nIHN1cHBvcnRpbmctZ2VuZXJpYy1waW5jb25mDQo+ID4gPiA+DQo+ID4gPiA+IEhvdyBkbyB5
b3UgdGhpbms/DQo+ID4gPg0KPiA+ID4gV2hpbGUgSSBkb24ndCBrbm93IGhvdyBPRU0gZXh0ZW5z
aW9ucyB0byBTQ01JIHdlcmUgZGVzaWduZWQsIHRoZSBwaW4NCj4gPiA+IGNvbnRyb2wgc3Vic3lz
dGVtIGhhcyB0aGUgcGhpbG9zb3BoeSB0aGF0IGV4dGVuc2lvbnMgYXJlIGZvciBtaW5vcg0KPiA+
ID4gZnJpbmdlIHN0dWZmLCBzdWNoIGFzIGEgcGluIGNvbmZpZyBvcHRpb24gdGhhdCBubyBvdGhl
ciBzaWxpY29uIGlzDQo+ID4gPiB1c2luZyBhbmQgdGh1cyBoYXZlIG5vIHVzZSBmb3IgYW55b25l
IGVsc2UuIFdlbGwgdGhhdCBpcyBhY3R1YWxseQ0KPiA+ID4gYWxsIHRoZSBjdXN0b20gZXh0ZW5z
aW9ucyB3ZSBoYXZlLg0KPiA+ID4gKFRoaXMgbm90aW9uIGlzIGV2ZW4gY2FycmllZCBvdmVyIHRv
IFNDTUkgcGluY3RybC4pDQo+ID4gPg0KPiA+ID4gVGhlIGkuTVg5NSBPRU0gZXh0ZW5zaW9uIGlz
IHJlYWxseSBvZGQgdG8gbWUsIGl0IGxvb2tzIGxpa2UgYQ0KPiA+ID4gcmVpbXBsZW1lbnRhdGlv
biBvZiB0aGUgY29yZSBhc3BlY3RzIG9mIFNDTUkgcGluIGNvbnRyb2wsIGFuZCBsb29rcw0KPiA+
ID4gbXVjaCBtb3JlIGxpa2UgdGhlIG9sZCBpLk1YIGRyaXZlcnMgdGhhbiBsaWtlIHRoZSBTQ01J
IGRyaXZlci4NCj4gPg0KPiA+IGkuTVggU0NNSSBwaW4gcHJvdG9jb2wgY29uZiBzZXR0aW5ncyBm
b2xsb3dzIG5vbi1TQ01JIHBpbiBjb25mIHNldHRpbmdzLg0KPiA+DQo+IA0KPiBJdCBpcyBub3Qg
anVzdCBhIG1hdHRlciBvZiB1c2luZyBjdXN0b20gU0NNSSBPRU0gdHlwZXMsIGl0IGlzIHRoZSB3
aG9sZQ0KPiBsYXlvdXQvZGVmaW5pdGlvbnMgb2YgdGhlIGkuTVggcGluL2dyb3Vwcy9mdW5jcyBE
VCBiaW5kaW5ncyB0aGF0IGRldmlhdGVzDQo+IGZyb20gdGhlIGdlbmVyaWMgRFQgYmluZGluZ3Mg
bGF5b3V0IGFzIGhhbmRsZWQgYW5kIGV4cGVjdGVkIGJ5IHRoZSBMaW51eA0KPiBQaW5jdHJsIHN1
YnN5c3RlbSAoQUZBSVUpLCB3aGlsZSB0aGUgU0NNSSBQaW5jdHJsIGRyaXZlciBhcyBpdCBzdGFu
ZHMgaW4gdGhpcw0KPiBzZXJpZXMsIHdhcyBjb25jZWl2ZWQsIGRlc2lnbmVkIGFuZCBpbXBsZW1l
bnRlZCBvcmlnaW5hbGx5IGJ5IE9sZWtzaWkgdG8ganVzdA0KPiB1c2UgdGhlIGdlbmVyaWMgZXhp
c3RpbmcgUGluY3RybCBEVCBiaW5kaW5nczsgYXMgYSBjb25zZXF1ZW5jZSwgaW4geW91ciBpLk1Y
DQo+IGV4dGVuc2lvbnMsIHlvdSBoYWQgdG8gYWRkIGEgZGVkaWNhdGVkIGkuTVggRFQgcGFyc2Vy
IHRvIGludGVycHJldCB0aGUNCj4gcHJvdG9jb2xAMTkgRFQgc25pcHBldCBpbiBhIGNvbXBsZXRl
bHkgZGlmZmVyZW50IHdheSwgdG8gdHJ5IHRvIHN0aWNrIHlvdXINCj4gY3VzdG9tIHNvbHV0aW9u
IG9uIHRvcCBvZiB0aGUgZ2VuZXJpYyBvbmUuDQoNClRoZSB0d28gbGlua3Mgc2hvd3MgdGhlIGRy
b3Agb2YgaS5NWCBnZW5lcmljIHBpbmNvbmYNCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcv
cHJvamVjdC9saW51eC1ncGlvL3BhdGNoLzE1NDExNDk2NjktMTA4NTctNy1naXQtc2VuZC1lbWFp
bC1haXNoZW5nLmRvbmdAbnhwLmNvbS8NCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIz
MDMwMjA3MjEzMi4xMDUxNTkwLTEtbGludXhAcmFzbXVzdmlsbGVtb2VzLmRrLw0KDQpGb3Igbm9u
LXNjbWkgcGxhdGZvcm1zLCB0aGUgZ2VuZXJpYyBwaW5jb25mIHdhcyBzdXBwb3J0ZWQNCmZvciBp
Lk1YN1VMUCBmb3IgYSB3aGlsZSwgYW5kIHRoZW4gZHJvcHBlZCBpbiB0aGUgZW5kIHBlciBpLk1Y
IG1haW50YWluZXJzDQphbmQgYWdyZWVkIGJ5IExpbnVzLg0KDQpGb3IgaS5NWDk1IFNDTUkgcGxh
dGZvcm1zLCB0aGUgZmlybXdhcmUgZGVzaWduIGlzIHNpbXBsZSBhbmQgdXNlIHNpbWlsYXINCnBy
b2dyYW1taW5nIG1vZGVsIHRvIHNpbXBsaWZ5IGZpcm13YXJlIGRlc2lnbi4NCg0KVXNpbmcgZ2Vu
ZXJpYyBwaW5jb25mIG1lYW5zIHRoZSBmaXJtd2FyZSBuZWVkcyBleHBvcnRpbmcgZ3JvdXBzL2Z1
bmN0aW9ucy9waW5zDQphbmQgZXRjLCB0aGUgZmlybXdhcmUgZGVzaWduIHdpbGwgYmUgY29tcGxp
Y2F0ZWQgYW5kIGNvZGUgc2l6ZSBlbmxhcmdlZC4NCg0KSSBoYXZlIG5vIGJldHRlciBpZGVhcyB3
aXRob3V0IGludHJvZHVjaW5nIGEgY29tcGF0aWJsZSBmb3IgZHQgbWFwIGhvb2suDQoNCkJ1aWxk
IGV4Y2x1c2l2ZSBpcyBub3QgYWNjZXB0YWJsZSBmb3IgZGlzdHJvIHN1cHBvcnQuDQoNClNvIHRo
ZSBsYXN0IG9wdGlvbnMgaXMgaS5NWDk1IHN3aXRjaCBiYWNrIHRvIFZFTkRPUiBwcm90b2NvbCBJ
RCBzYXlpbmcNCjB4ODIuIEJ1dCB0aGlzIG1lYW5zIHRvIGV4cG9ydHMgZnVuY3Rpb25zIG9mIHBp
bmN0cmwtc2NtaS5jIGFuZCByZXVzZWQNCmJ5IHBpbmN0cmwtc2NtaS1pbXguYy4gIElmIHlvdSBh
Z3JlZSwgSSB3aWxsIGFzayBmaXJtd2FyZSBkZXZlbG9wZXINCnN3aXRjaCBiYWNrIHRvIGEgbmV3
IFNDTUkgSUQsIGFuZCBJIHdpbGwgdXNlIG5ldyBJRCBmb3IgaS5teCBwaW5jdHJsDQpkcml2ZXIu
DQoNCkJ1dCBpbiB0aGUgZW5kIEkgd291bGQgdGhpbmsgd2hlbiBtb3JlIFNDTUkgdmVuZG9yIHBy
b3RvY29scw0KY29tZXMgaW4sIHNheWluZyB2ZW5kb3IgQSBhbmQgdmVuZG9yIEIgYm90aCB1c2Ug
SUQgMHg4MSwNCmJvdGggdXNlIDB4ODEgYXMgUlRDIGZ1bmN0aW9ucywgc2FtZSBpc3N1ZSB3aWxs
IGNvbWUgYmFjay4NCg0KVGhhbmtzLA0KUGVuZy4NCg0KPiANCj4gVGhhbmtzLA0KPiBDcmlzdGlh
bg0KPiANCj4gPiA+DQo+ID4gPiBCdXQgSSBzdXJlIGNhbm5vdCBzcGVhayBvZiB3aGF0IGlzIGFs
bG93ZWQgaW4gU0NNSSBPRU0gZXh0ZW5zaW9ucyBvciBub3QuDQo+ID4NCj4gPiArIFNQRUMgb3du
ZXIsIFNvdXZpay4gQW55IGNvbW1lbnRzPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFBlbmcuDQo+
ID4NCj4gPiA+DQo+ID4gPiBZb3VycywNCj4gPiA+IExpbnVzIFdhbGxlaWoNCg==

