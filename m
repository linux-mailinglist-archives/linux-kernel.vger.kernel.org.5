Return-Path: <linux-kernel+bounces-35516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 949CD839242
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9AF91C223B5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21F65FBB3;
	Tue, 23 Jan 2024 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="IVmJ0OBM"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2087.outbound.protection.outlook.com [40.107.6.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018DE5FEEE;
	Tue, 23 Jan 2024 15:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022821; cv=fail; b=XkzwkINSqgpoPjKXz7HO0QRHJzBqh8kgAAkzV8dcW1zKEX2NOlppmkrRnKuhjcwftDaWn/zZ7jaFRRKDcQfGFhhFpZxD6Kv6D6bKameQkztE4BLI4jdIb46U+pe7GfjCPN8jMuBiKUmAc0zPP19PcjjiTwEYI2XtXn5c1ygiK4M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022821; c=relaxed/simple;
	bh=VQpZnMujnDpuGYssG/gsmbhMQLDUmhC8EfSfhxA0w1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=edMmCDvoCwDH3lzJSD/Ja4IRr3wc2ate5xmqQmob2149dvCPHicQI8I4HZDeOkuggq75DaF4XWFJsnDkrHp+5H8F1mm3zUWZpjWmPj9IIYQPMQ+GChXuT5f7aHzh7BHwRy2UX0rI3jUJBB331XU84NCm5WIerdF2+y8HHNKcRTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=IVmJ0OBM; arc=fail smtp.client-ip=40.107.6.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z84kBzj9R0WkOnrIjNURaB7Dgg36XVB+667Eq08CQ2osvTh1Vs/HNDE0bVJTuW0tq2dIOPsIpigbbA6e0dWSnA3TCxyV1VlcfCKuJuemi/yEPJFFZZPymnfP5TnA4GbstiqkAxtAWJjdypxJX+KSvFfxJiyT5H0KPEY4Iv8S40Mu3dZmSEIJ/JlsmQQGyZwNfZmt8DoHWSg4v0MlEl30ZzODDAYEXqkrC032wbGMQ8J0uD2V4DYLv8cJicQjwKtVDfvXahg5qq9mLFLQPjcZThsU1+M5eNe+GkBZPncqLUeurcHFxGNykcIouRaXw8ONObpmgKVCOGtfrm5Jh0p7aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VQpZnMujnDpuGYssG/gsmbhMQLDUmhC8EfSfhxA0w1k=;
 b=TrTDcqxAUPS8wxrW3MhiQMWahz+FBwXOccGv1v4+/8G/rmRgAJaxrH5MJbhgyuYHecm/7gSrgG5sEkHm12cKszJU2h6Ha+pa+psMf/XO3eXMvzMM6yTzvm7pbJQDsmSmmtayArAndt5RzCdufmFcIgpST/7kapPPdlAHp3+JlJFldP5bD6KJT2YBsrbk8yyMbWHCTeeCEKo8pn5NeQ5SOcIMnB3tcsSU1dW8lasRjgAFfEaqpWJcpMI0tS8LgPIivkLPx5OxTgXTxKxJYNYk8RkSa2QBQ20aDe5EDJxl2awr2pi4SnhhL72kN9Ucj/Whny0oQWgK7d1wlvqkbZv80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VQpZnMujnDpuGYssG/gsmbhMQLDUmhC8EfSfhxA0w1k=;
 b=IVmJ0OBM4aDEuyqIkpmnOJ81xd+n+UffFLxKjyL3xZUguG5XGk90hMsR8cGaC0PsF6NcFbVTKybtXzabWw/d63nYKFVcbm5MxI4y8N7X5u4uyZPYEHMf1xMo45M8AEP49L9EXfMqgc+uwJkmRhfcaMD+OgaNeJbKwHbOrH1pUNk=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB8018.eurprd04.prod.outlook.com (2603:10a6:20b:236::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.36; Tue, 23 Jan
 2024 15:13:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Tue, 23 Jan 2024
 15:13:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "abelvesa@kernel.org"
	<abelvesa@kernel.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>,
	"sboyd@kernel.org" <sboyd@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Topic: [PATCH] dt-bindings: clock: support NXP i.MX95
Thread-Index:
 AQHaTF7dbf3fZzQpTkKKhWtWHavxlrDlm5UAgAHFORCAAA4YAIAAANswgAATS4CAAAD3kA==
Date: Tue, 23 Jan 2024 15:13:35 +0000
Message-ID:
 <DU0PR04MB9417187117429F7C7BE856F188742@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240121114623.1418597-1-peng.fan@oss.nxp.com>
 <273a80a7-2a60-4490-9c3c-c33dc14be9e7@linaro.org>
 <DU0PR04MB9417A8F4230D2C7C76D1550988742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <78e296fb-a3dc-4e00-94bc-91dab7294887@linaro.org>
 <DU0PR04MB94173B34D426181D285B995088742@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <7afbabca-e0bb-48a9-8c5a-7582f7ae3a6e@linaro.org>
In-Reply-To: <7afbabca-e0bb-48a9-8c5a-7582f7ae3a6e@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM8PR04MB8018:EE_
x-ms-office365-filtering-correlation-id: fcd1be46-990c-423d-1040-08dc1c25debb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 baStbsMSXwR0GihR3Iucdnpo5/s32xFNJ/F446iQUFiTMx8USS7Rm8ZNjUaBL1LNVYYAX+yCM2Juksa6R3EtqgGpM4opaX2JcvYIXOqqt6Rnf9eP7Z41j3cw1lWznlxg+Z7Dzq0jxd4GXOSvhabJGqbu4wZiVbrUP+AopjqnpQXfwEhOlvB1JfhgBgEg3+KOB39HL4ImQVq4v3dvGElnvpUaVkkbIHgg4slHzlsPqc4NqJEMN8pFs3zlOogR56d6cDJ9F2BnEJhJ8BypTtOoHcTXB3vV1LHpliLrbXndi82C1+Dd25CX/pvLxU3sP8e0ybFGTcThsjnwb73HjCS5j0Hb8BVw9JiuQ7lgP5ktzIPj0nURR5gJOumhhURXrjrEBaNM6I2sP7VIf7Pz/KWbk/3jPMdjRuHOgws37jC0FDtsr79PlYEa6k4kPK9kYmP2BM6R3Mc4mTBMPxw8gmRpjZtw7h2BPFi3kFZ7L9nFChcuVEzX5Gf4zG34dC2XpGZ5GetveEFlHvr+w9SwvBaD95fQ0M/oadP16HsA/Lmu8kRz++lNtCvzCaBHOBAh0yqS7mh4nTSVQ4jj7Sn7I/vQSfY+9yg7II23JzxuaNw9/Wg7B0ww/LcRJuRpYU8MuDRRS8NdPP0RrgLDP7pyHFDoZw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(346002)(39860400002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(5660300002)(66946007)(66476007)(64756008)(76116006)(66446008)(54906003)(66556008)(110136005)(316002)(26005)(7696005)(6506007)(9686003)(53546011)(71200400001)(478600001)(52536014)(83380400001)(4326008)(44832011)(38070700009)(2906002)(86362001)(38100700002)(122000001)(41300700001)(8936002)(8676002)(33656002)(921011)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U0tzZlZGcCs3NnF3dXlyQllrRWdXeVN2Szc0ekt1Vnowd083UldPdThzVVFy?=
 =?utf-8?B?UEJ3VlpRYU9IMGwvNjNQMmZ2eGVQbEl5WFl4WTIzaFRGUkh2blpBSW56NVdD?=
 =?utf-8?B?WnlkandGelVtRVltdjcwOWJjUnJoZGhqMGNqYjdFS3c1VklkUitEVGV5N1M2?=
 =?utf-8?B?cmdSL1JaOFMxdnVaZlhwOG8vYWlJbVFmZk5ZTFAvMkxBeGZaMk0rdlpza1c2?=
 =?utf-8?B?T1lqbzNjenRoL3pWUTVjaUcxaWFSNU40SVJkalZ6Y2Z2L1h1a2RKV0xTY1p4?=
 =?utf-8?B?UGxTTDYzaHBGK04xS2dXUDdQMEZIQTQzZEZLNzRrSXU4WmxQK1NCdkh6V1VP?=
 =?utf-8?B?azNmbkx3N25adEtKUkVOSGJCck1JRXJGRnRRc1lMMzB0SW5iUSsxT3NkTktI?=
 =?utf-8?B?NlRNVDRMbitIanpPSkgyamhMa3BaZHNleDVQZ0VzVHNtZTRNNGlOSFd3Y2hk?=
 =?utf-8?B?a3ZSZG1zcVJQa1NzN3o4YUVaSlVGQk16ODdVOXBOOExEamdjU2dxZEplS1Ev?=
 =?utf-8?B?NFBLK0U4SlJ5UWcrQVdNS0tPeWcxQW5NVENzOHlTT3Q5eFBQS1N4VmVoUTBp?=
 =?utf-8?B?Q2NneUhtTldqekxtM25rdDBLZGxjV2ZnUXlFOFlGemhQV2hUempERGlpa0d4?=
 =?utf-8?B?Vjg2L1JBNGpscEFkR0RqNTlqZGlWQnowV1hyemVNQWs0YWU3VGx4bCs1ZVFl?=
 =?utf-8?B?Q1lYd3BKTEIxVnB2aGhEenlzSWlQdllYaHBJK1lWRTNac1RRdmxTa21RVEdC?=
 =?utf-8?B?TnVTT28rWVpvbnYySG8zSlZrNjFSQi9Zd1ptcGk1UnpYbVRxYm1UeHZsZzFG?=
 =?utf-8?B?YUxWWFZIQ3lkeDdyRjNPTkYrMEVRbUV0bklCTVl5M2xvdnFNRlZVeVNDc3ly?=
 =?utf-8?B?R1VheUJkT3dMVy81VWMyY0FCM0JjbW9VK3dqajIySmE4NFN1eVFCWEYxRi92?=
 =?utf-8?B?L2VYY1hrRDVNN3VZcDRCRkNxaWhIK01LVVJKSzRzQ2JpQXgveks4eHN3bmcz?=
 =?utf-8?B?NW01TmFKWDlwc09xTEtKRXAwcHdSU0NHN2hneGNoR2Q3UnRYSTlnQ0NNc2ZQ?=
 =?utf-8?B?REd6MTdMS2dvaU9yUkh3NlVLd3hXWmlmbHBEalRZTHpleVhoRWpvNzNHaThn?=
 =?utf-8?B?WG5pOC9jR3g1dkJvNm9SUEVUM0FDSjcxdWRvQkk3bWVzR2ZHMUFnWXc1VTNu?=
 =?utf-8?B?RmdjOTFDYlY2S3ArVzNmUHhZdW5jandPaHQ5UGhyLzR1YUhydmQxM0pkWjE2?=
 =?utf-8?B?aGw5ZVRHeVBESU9XRkZjc2FuRWhuTTN5UWpRcmJzU01UajRxZG0vdWpYMU5X?=
 =?utf-8?B?V1YrZ2pDRDI0UkszMG1HU1p2anZyRWgrN05GU2U1MC95TWFwbm1WTFZ4UXFE?=
 =?utf-8?B?QzFVbVoydHFUTGw4Y2FKQzZhYkJvQnloNDNLN3RtdS91dzBKQk16bE9ENXU0?=
 =?utf-8?B?WmpneThNdUlsQUdudXJaTmV6eGNkMVluaXRwNCtsN3loclM0Sm1JakJ4b2t6?=
 =?utf-8?B?YlU4S01HVlFHTGUxY0ZQdCtBVnJUdVgwd3pPUTkyR0lUVzkzUVFvU1N4akxJ?=
 =?utf-8?B?WUVPaVFrVzFvZW5wbElPTGNCaEFMUGJYMEUycVM0bDJCSis0bmh6MGpCUE4v?=
 =?utf-8?B?YnBLc3UycUR1Z1pScklCeXR4NTQ5RlZtUmdtUDhjR20wV1F0TkFDOUY3d1pI?=
 =?utf-8?B?S3FyeUxmbGwzdUxRZFRjMzV3Qi81cGxOOWRoOENUdXVJeHlWblVVVUtPeEdC?=
 =?utf-8?B?SFZ3WEJsWkdEK2VnYTFGUHV0VXZRa2poSTBacGdOazlVbDBxWGdtcDg5clFh?=
 =?utf-8?B?bFlzT3J3SDI3bUxLOEovbnpuOWtXTThKbXErTzRFcGtHbzh1cTI1ZmtLMGRn?=
 =?utf-8?B?RkFSVXNOUStWRlpLRXJBZjF1S0pvZlFFckdGbk03eDNaaEJudUc5Vm1mSGV3?=
 =?utf-8?B?Sm9Qd1Awb2NNMmE5MnQrRVE4SVU4SGRDQjNEcUxXMW14eDYrMG5JT0MyaTY5?=
 =?utf-8?B?S0htTTIrZXJzR1gyWGkxQW1rVHBVLyt4eFJMa1RoYUVpclF4dGFrR0JTOTlB?=
 =?utf-8?B?OXlFdmxJRUp1QUFFbmIwS3dCbXAxRDBTcTZEUU0yaXhKbVpqNUtza1NBS2x0?=
 =?utf-8?Q?u3/E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fcd1be46-990c-423d-1040-08dc1c25debb
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2024 15:13:35.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fP1ZiOPvEnpj5C5IDIx4/jG5jQRXLUPjXtDXOh8VhnGpkzaPeXMGgX/51XKfJU+DBwG8QNqpgia7U1dKjG0C6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8018

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogY2xvY2s6IHN1cHBvcnQgTlhQIGku
TVg5NQ0KPiANCj4gT24gMjMvMDEvMjAyNCAxNDo1OSwgUGVuZyBGYW4gd3JvdGU6DQo+ID4+IFN1
YmplY3Q6IFJlOiBbUEFUQ0hdIGR0LWJpbmRpbmdzOiBjbG9jazogc3VwcG9ydCBOWFAgaS5NWDk1
DQo+ID4+DQo+ID4+IE9uIDIzLzAxLzIwMjQgMTQ6MDgsIFBlbmcgRmFuIHdyb3RlOg0KPiA+Pj4g
SGkgQ29ub3IsIEtyenlzenRvZg0KPiA+Pj4NCj4gPj4+IEkgcmVwbGllZCB5b3UgYm90aCBoZXJl
Lg0KPiA+Pj4NCj4gPj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSBkdC1iaW5kaW5nczogY2xvY2s6
IHN1cHBvcnQgTlhQIGkuTVg5NQ0KPiA+Pj4+DQo+ID4+Pj4gT24gMjEvMDEvMjAyNCAxMjo0Niwg
UGVuZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4+Pj4+IEZyb206IFBlbmcgRmFuIDxwZW5nLmZhbkBu
eHAuY29tPg0KPiA+Pj4+Pg0KPiA+Pj4+PiBBZGQgaS5NWDk1IGNsb2NrIGR0LWJpbmRpbmcgaGVh
ZGVyIGZpbGUNCj4gPj4+Pj4NCj4gPj4+Pj4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcu
ZmFuQG54cC5jb20+DQo+ID4+Pj4NCj4gPj4+PiBUaGlzIHNob3VsZCBiZSBzcXVhc2hlZCB3aXRo
IHJlc3BlY3RpdmUgYmluZGluZyBwYXRjaC4NCj4gPj4+DQo+ID4+PiBpLk1YOTUgdXNlIFNDTUkg
ZmlybXdhcmUsIHRoZSBTQ1AgcHJvY2Vzc29yIGhhbmRsZXMNCj4gPj4+IGNsb2NrL3Bvd2VyL3Bp
bm11eC9yZXNldC9wZXJmb3JtYW5jZSBhbmQgZXRjLg0KPiA+Pj4NCj4gPj4+IEkganVzdCBhZGQg
dGhlIGluZGV4IHRoYXQgU0NNSSBleHBvcnRzLCBhbmQgTGludXgvVUJvb3Qgd2lsbCB1c2UgdGhl
DQo+ID4+PiBpbmRleCBhbmQgZ28gdGhyb3VnaCBTQ01JIHRvIGRvIHJlYWwgSFcgY29uZmlndXJh
dGlvbi4NCj4gPj4+DQo+ID4+PiBJbiBzdWNoIGNhc2UsIHNob3VsZCBJIHN0aWxsIGFkZCBIVyBp
bmZvcm1hdGlvbiBpbiBhIHlhbWwgYmluZGluZyBkb2M/DQo+ID4+PiBJIGFtIG5vdCBzdXJlIHdo
YXQgc2hvdWxkIGJlIGFkZGVkIGlmIHllcy4NCj4gPj4NCj4gPj4gVGhlbiB3aHkgZG8geW91IG5l
ZWQgaXQgaW4gdGhlIGJpbmRpbmc/IEkgZG9uJ3Qgc2VlIGFueSB1c2Ugb2YgdGhpcy4NCj4gPg0K
PiA+IG9rLCBzaG91bGQgSSBqdXN0IGFkZCB0aGUgY2xrIGluZGV4IGhlYWRlciBpbiBzYW1lIGZv
bGRlciBhcyBzb2MgZHRzaT8NCj4gDQo+IEkgZG9uJ3Qga25vdyB5ZXQuIEhvdyBhcmUgdGhlc2Ug
YmVpbmcgdXNlZCwgZXhjZXB0IFNDTUkgZmlybXdhcmU/DQoNClllYWguIFRoZSBjbG9jayBtb2R1
bGUgaXMgbWFuYWdlZCBieSBTQ01JIGZpcm13YXJlLCBvdGhlcnMgYXJlDQpub3QgYWJsZSB0byBh
Y2Nlc3MgYmVjYXVzZSBvZiBUcnVzdGVkIFJlc291cmNlIERvbWFpbiBjb250cm9sbGVyDQpibG9j
a2VkIHRoZSBhY2Nlc3MgZnJvbSBsaW51eCBvciBlbHNlLg0KDQpUaGUgbGludXggc2lkZSB1c2Ug
c3VjaCBhIG5vZGUsIGFuZCBwYXNzIGNsayBpbmRleCB0byBsZXQgU0NNSSBjb25maWd1cmUuDQog
ICAgICAgICAgICAgICAgICAgICAgICBzY21pX2NsazogcHJvdG9jb2xAMTQgeyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDE0PjsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgICAgICAgICB9Ow0KDQpUaGFua3Ms
DQpQZW5nLg0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRvZg0KDQo=

