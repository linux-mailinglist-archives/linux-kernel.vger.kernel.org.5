Return-Path: <linux-kernel+bounces-126059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED48B89318D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 14:01:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AE1EB2163C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 12:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D7D1448C3;
	Sun, 31 Mar 2024 12:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JTL8Gjmv"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2119.outbound.protection.outlook.com [40.107.104.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF3B290A;
	Sun, 31 Mar 2024 12:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711886508; cv=fail; b=Lvi53HUIqes+EBNx85BEBxc8F8FHwvtyh4QWuWY9mQhDuvxt+OnTepAPi+BXoeYfcm0R8nnDCUHvBmSIz1AwJ0HIsyX7aZNQw+F63uHaqifXOMCt/NsO3nyi1dbtwQzuEYxhKeYxdFhhEbrJTguX49yK0vfdnvSJSjM8xZ+NrtM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711886508; c=relaxed/simple;
	bh=8U970gqcEZAoyQdbKC43hqGB8wfAC90zoeWELHfY9GI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=flSn0z2JonLFCbAkjNBuh8kkSI7czatzEzGWGFIW1KzdaB2+1QF5RMBJS3bKgYasuiTenQfyPj+te021bIvyWJ4y7aRzmTVOw9TjETSGPGCt8wyXIuSN94J/gySZ12FPKc+axY1K+ZD/Q2Yf5865DXJ4do9aMm/ybM3DkXUlpxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JTL8Gjmv; arc=fail smtp.client-ip=40.107.104.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mXGzhz5wYM26EQWjBISqa1iTPOaLm7cBJIL5f2TnvW0yHkFJ52gueNu7GW3oDuGdImVAdBU6QhZufSknnY8Y8VJisVwl0LlETtD3zIqIwEgmRr7eSpdIFh/ovVhgbAIKfxZslctj9EtGia/UPNcOoDF1hDjlXtX3P1Unnk0XrDP6EoYAF1u1PRPOgays2zxTpbMV92pQPQaxacwWglJ2js9p/Ky+JDETagE8bQkfX9N7BY22eNa60G4A/FT10JZTVI8sHH2nsEOwuFm8BkpfO4+uYxe79dxNmbJC+KouY/Laufumkkskaf2spWDLyjaUtiNwPeqm6jTci8iiJ7qQbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8U970gqcEZAoyQdbKC43hqGB8wfAC90zoeWELHfY9GI=;
 b=arOqx2fgIkjSHmFfpCRy/Hn54KYKDkPXHZfhot88OlYnRGWYkYURNoKO6NMIftEaeBeF8YjfJGh2UhwDBTTxa/5igOckPjquvkn+PVlB1eAbhnrzIpLNavOSQNpwe2pmXGCIcdNEPEwp8iK+fDv8tUN4E2spqye8xMUimhTHKXzzVpDKKnO5XTvpr79oM2cNKdlxdhZS548Ytj4yshCmPXDvENGRnZQB9IDKbb/o8rRj8/5GCq2H7ja0mF+gnUnvrRQPEXMA4yAh/FrOQKic9wBx0kf/bNbmnfiq7uUQqjh0XJ27nTMRafES3Tvo5Jmk/2lQlzHL1oQgWgidzeEX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8U970gqcEZAoyQdbKC43hqGB8wfAC90zoeWELHfY9GI=;
 b=JTL8GjmvWl72xPoH6tKqdOMu3ZoTJPXaVOjOFaf0LpUdikwuoi1eFijppuQNpNzLuvDGjtB3br3EhZIKURwo2mVgJ4D6IgubKOHrZPOffgAHcYAh20jxfpyAe9zXSb0OxRLoDDSjnLfpKeDZy+L7EVJl7dDuIAROS/QKucL/BW4=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6875.eurprd04.prod.outlook.com (2603:10a6:10:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Sun, 31 Mar
 2024 12:01:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Sun, 31 Mar 2024
 12:01:44 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Michael Turquette <mturquette@baylibre.com>, Stephen
 Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam
	<festevam@gmail.com>, Abel Vesa <abelvesa@kernel.org>
CC: "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
Thread-Topic: [PATCH v5 4/4] clk: imx: add i.MX95 BLK CTL clk driver
Thread-Index: AQHafb8P7Z/0BgtsqUOmutQIflELULFI2PwAgAjxd8A=
Date: Sun, 31 Mar 2024 12:01:44 +0000
Message-ID:
 <DU0PR04MB941774D0A1CD037AB7108AAF88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240324-imx95-blk-ctl-v5-0-7a706174078a@nxp.com>
 <20240324-imx95-blk-ctl-v5-4-7a706174078a@nxp.com>
 <d3770f5e-f3cc-40fd-a211-b229be46d974@linaro.org>
In-Reply-To: <d3770f5e-f3cc-40fd-a211-b229be46d974@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|DB8PR04MB6875:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 HIl4CoAQ0AZ//Gmpnu1reo85VG320aMEIbcz6YNH+U3KBTpav8KdOb8mIvXe22SrO3hiylG5n+RSdVgtspiZ6Eq7WZMFpRjYPJ3z2DZr7LkHkyDtvY5uvCdRquCvXmKfHD0IhWxk9Kuf6JIeHWVS3YcIw7iV15uJjAcjRaceIHvLV2+Soei47ycoOeQoLoKIUcFGZSwZ+PiWyC1Gc1Sp5UAnbljs7yW3TPEw7BU4+MvPzC5NCPEoXwEdNdy/NqkAkELLb/4sjMkLsxlEGZ+vuvgzzj9m0/ZMFrc2g4ptY9hSUlbjWMckoGWKFofqMCZ9+7jhz5bihF3Q+oz/DLttxxjkjzt0T+PXNEEHtnqMDDxaZ8VZ5xWMEaHhHmNLorub8X1foHpMQp3lY/1+fNaJo/j+KdumsgUwmxBSj2dsvvxPBowBSGMdaArc7ub6qI/UNdHhIDJg2qknZJSugNUL9PDjIFU0Xn8Nz4yAdgZyiSkDrDegfqkiKezbCf/fbZ30Xvk/TA9iU29nWtdeK8NZQTs8DinalZe5oMGavszsga65EsNWuMpSiXvK8lXdaoKomwBLQfOPCANWpJuUARTfXAroNy9EESTwjy4ClY/Yu/iRN8vEp6ZnqeBmvT4ViWytBVt8Jds6R12qoP+9pvvIkhL2yJ2jBPVfbfdr40p03zSB5Ox4RSNdxz9qnYqtSf7Z2V7f7Gnr9aGxrA6f+8qQUg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YmZIcmJtdU1oZzk3czBoYjA4ckpwZGNDV0l0cGNKdldybDN4bEZkOXo0bXcr?=
 =?utf-8?B?SUhHa1J5UUxyYllBZlpUR24vam1XdlIwTDU0VVI0V2h2ZGIxSHJMK3Q4bHAv?=
 =?utf-8?B?MVJQTmNhc1ZqdVZjeERQWmc3aWhDSytQdnV0R0dFcnFsdUl1Y3c2VVRVVEhL?=
 =?utf-8?B?dVlsd0Y0QzFwa0lDWGt6MWxGVk5yTEpoSEQydGZtT0FzY0dObDdGT3VjK3Jr?=
 =?utf-8?B?QTB2S084SWVDNDRvcFlNcFoveHlURmR6MEFLcnNqa3VZWHN0U0hUWmlxWDhP?=
 =?utf-8?B?Mnhka200d0lqbUJjdjdMNkxiSmdVODdpdlFrTUw1dC9WcGlYK3M3NHVjaFoz?=
 =?utf-8?B?UEllQTkwd3o3VW5BSWxVVFV6alE5TUpSR0UrUnA1aGFEK0JuTDc0SUdRSzlM?=
 =?utf-8?B?LzJDU1NvbzNKQ1N2ZFhTbEFOOHZ0eDZvWk5Jdm5yQk1sUWlrbXJOTW03SWtU?=
 =?utf-8?B?WmcvS2VtMFZlMmEvZkkzanNyektYWWhDVFdHa2pMdFlIckFxR3F6UnJzMGpQ?=
 =?utf-8?B?OElkalhsenZQajlJMkpTSHlWSnJQb1VmZDlYNnZsaWw1U2U4eW0xdXlUYitW?=
 =?utf-8?B?L0FWZ3J0b1Y5am55SVlLRk5LRnNVd2RCRUxjVXBzRDJaWGluMVRUd29qODBF?=
 =?utf-8?B?TVU1dHdjQ0dWTE9Uc2N3MnRwUDZwZlJkNTBMSEI3K0RQWWRrRXpJb3RBQmdh?=
 =?utf-8?B?MHNlU1phZ3EycXpJY1Z0UFkrUXRpU1F0ZTEvYmRkeHJNVmkySTMrNGsvRjdC?=
 =?utf-8?B?SjRCTk9SYWJTYUdDaTNLMW9YKys1bmpUeFdsVFhIaEtGWVdzcGNIT25ieUtl?=
 =?utf-8?B?RDE1VEZqc29RbDROQ2dqbXh4dmN1TFk4bDhTcEY5cVNQOW1zeXYwVVhhcFha?=
 =?utf-8?B?cE94bkoyRUgwT3VWOUdjZ25UNDJqbEVzNzJIOU14RWR4Z0Z5anFCb3NRVnhK?=
 =?utf-8?B?cGFMbU50eVIvbGFRbGF0QWprbmgwVjB2d1pib1RMeWRtTm9weldYMmVXMmNX?=
 =?utf-8?B?cHVkWEtkYTZEMFpQK0RWUFUzRGpicGpxSWtOWVVoZmdRQ2wrSVJPV0xacHRa?=
 =?utf-8?B?aGpyV3ZzcG5oUC9sTmJTQXgydUNtejA4cndrZHJpZ1c2QlY1VmkyZXdzT2s5?=
 =?utf-8?B?UkZzQWRoTDNWTE5IWksyTkFpQ3lRbkdjcnZoSHZOODNsYVNub0d4T1FaRHZv?=
 =?utf-8?B?N3k4NFZiSjNaYitTaFpwQlhWNUxUSXZGVnBCMzM2aGVGTkpCZUw1aUMvbDVP?=
 =?utf-8?B?d2hjY25YMUtGQzQwWWFsb0s4bUcvYW1yeUwydk9jdzRxM3FNY01BS05qSEIw?=
 =?utf-8?B?c3Zsc2lHdmxhbWNjTDM5S3JBQzNLRTBOTmozYWtKRld2U1hYZ3M4VUJwd21r?=
 =?utf-8?B?b3hsWHBWcm1HNEY3T2JnSTlsblZVcDJKWXE0WUpWSzBDU1AyZXRXL1k5bUxl?=
 =?utf-8?B?eThRZXUzUmlPU3Y3aWRrVEdmcEZLN2ZoNmdqbVRFS0Rva3pnWC9obUsxeXdt?=
 =?utf-8?B?dXp3dkxTNTJQOW12SUpTb2lFYzJ4ZGxkaERyMUVBamJCVmhUWU1wVkNVMFRE?=
 =?utf-8?B?Q3RXeURPMUg1NEx4VzJjSWFxOGNFWHpFRU1rdDJXWTdyQ21rZE5PcW9tdUVS?=
 =?utf-8?B?enRwb0sxQ3VUeVovcG1xdHJ1dWVIcWhoSENPQjdGeWgvU3g5NktTWWFiVTRt?=
 =?utf-8?B?QlN5a0FSYkExMjJ4TTBBc2JTMW80R002NUYwVGNTQlI3T1BnOGtqeXJiZUNh?=
 =?utf-8?B?U0JLQzVEcUlncnNMSVFiVFZPd29LdVBDSkU1R3FyMFNXcnFzajdJRmIyVzM1?=
 =?utf-8?B?R0RtRFhiaDJqY1lmWTA2bFQ1Yy9kYXJCdFZFRXJrYVBFSDVVSVRyUEJNT2pC?=
 =?utf-8?B?bjRKYUU3U0cxYlgwQ3hrcXdRQlVBblpKK2FwWUxEcUpJSmxBd2ZWUzNMM05B?=
 =?utf-8?B?TVY1QTlXNFRrZWlMUkJuZnlyQkZXU01MVUw2dWdld21Hd3ZuRFFVeXU1UlY0?=
 =?utf-8?B?dmZhZzRxMjNTTFhiWUVvVVJNVFVtaUtaRmpjKzZEc29MOEYraloyRnBhLzBQ?=
 =?utf-8?B?dTR3Wm5IRGJrU1dkdHRYTG8wMlBCUWU3TlRPOWQxLzkxOElwQ2U5a1ArUzYr?=
 =?utf-8?Q?rhxA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 556a98c1-6d46-4aec-9b55-08dc517a55a3
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2024 12:01:44.4365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wR3/kHrLl+lOSlKfnamf/v5JuulTee/2DaUSo9AikEHT/Sfto+TO0qIi2RBig4iphdi8GUp0B8wdMPFwBlGCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6875

PiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDQvNF0gY2xrOiBpbXg6IGFkZCBpLk1YOTUgQkxLIENU
TCBjbGsgZHJpdmVyDQo+IA0KPiBPbiAyNC8wMy8yMDI0IDA4OjUyLCBQZW5nIEZhbiAoT1NTKSB3
cm90ZToNCj4gPiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gPg0KPiANCj4g
Li4uDQo+IA0KPiA+ICsNCj4gPiArc3RhdGljIGNvbnN0IHN0cnVjdCBvZl9kZXZpY2VfaWQgaW14
OTVfYmNfb2ZfbWF0Y2hbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibnhwLGlteDk1LWNh
bWVyYS1jc3IiLCAuZGF0YSA9ICZjYW1ibGtfZGV2X2RhdGEgfSwNCj4gPiArCXsgLmNvbXBhdGli
bGUgPSAibnhwLGlteDk1LWRpc3BsYXktbWFzdGVyLWNzciIsIH0sDQo+ID4gKwl7IC5jb21wYXRp
YmxlID0gIm54cCxpbXg5NS1sdmRzLWNzciIsIC5kYXRhID0gJmx2ZHNfY3NyX2Rldl9kYXRhIH0s
DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm54cCxpbXg5NS1kaXNwbGF5LWNzciIsIC5kYXRhID0N
Cj4gJmRpc3BtaXhfY3NyX2Rldl9kYXRhIH0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm54cCxp
bXg5NS12cHUtY3NyIiwgLmRhdGEgPSAmdnB1YmxrX2Rldl9kYXRhIH0sDQo+ID4gKwl7IC8qIFNl
bnRpbmVsICovIH0sDQo+ID4gK307DQo+ID4gK01PRFVMRV9ERVZJQ0VfVEFCTEUob2YsIGlteDk1
X2JjX29mX21hdGNoKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZHJpdmVy
IGlteDk1X2JjX2RyaXZlciA9IHsNCj4gPiArCS5wcm9iZSA9IGlteDk1X2JjX3Byb2JlLA0KPiA+
ICsJLmRyaXZlciA9IHsNCj4gPiArCQkubmFtZSA9ICJpbXg5NS1ibGstY3RsIiwNCj4gPiArCQku
b2ZfbWF0Y2hfdGFibGUgPSBvZl9tYXRjaF9wdHIoaW14OTVfYmNfb2ZfbWF0Y2gpLA0KPiANCj4g
RHJvcCBvZl9tYXRjaF9wdHIoKSwgY2F1c2VzIHdhcm5pbmdzLiBGcm9tIHdoZXJlIGRpZCB5b3Ug
Y29weSBzdWNoIGNvZGU/DQo+IFdoaWNoIG1haW5saW5lIGRyaXZlciBoYXMgc3VjaCBwYXR0ZXJu
Pw0KDQpJIHJlY2FsbCB0aGF0IHdoZW4gQ09NUElMRV9URVNUIGlzIHNlbGVjdGVkLCBPRiBpcyBu
b3Qgc2VsZWN0ZWQsIGtlcm5lbA0Kcm9ib3QgcmVwb3J0cyB3YXJuaW5nLiBUaGlzIG1heSBub3Qg
YmUgdHJ1ZSBub3cuDQoNCkkgY291bGQgZHJvcCBpdCBpbiB2Ni4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0K

