Return-Path: <linux-kernel+bounces-147896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A159D8A7B11
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 572BC281E63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 971578BFD;
	Wed, 17 Apr 2024 03:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="CTOD0jvN"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2067.outbound.protection.outlook.com [40.107.241.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D4EF507;
	Wed, 17 Apr 2024 03:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713324401; cv=fail; b=DHKHHfDJfnXgnMCIaOg32N/A/9bMnWp6qRljz3F+upLbGofcgBKmT4cs+crK8IPtGE2vbn/ajDhhXIwCJeRvD5jBRjVel6bepi3L7hjYC5lbys83hk5hi/CegxLE6/oL6tyxTAgxtoLoSC8dNfQJWSkMzteUZ1/5D6Vmb9Z+DFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713324401; c=relaxed/simple;
	bh=iKM2hem/22eK5dqSuVN2j90G+x4nfercj/V3+hzgld0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=W5soZ2wrfJ/h+so6sqW6kjkgL4uvmm6f8UCP7eEz93mwFhLv998rIzEe2g0uR38YOcoBW1rOjfwN8D3pxAX4A5DUdCvxhpWH29j/ncMJdVR564yo9mUiCxORrURxOhUoSzhfdHo6OuBcITiZ3TWRnCykS46DTqrHatHGJKmn+D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=CTOD0jvN; arc=fail smtp.client-ip=40.107.241.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RebySNQY/lAI68rXKpAIvtMTk3UHGNJyzIpJJpcNZth+SCuPJCPv1rJ+KJpVkZvJJJoZVPDdWzWtHYeT4delN/U/aA8z3bkg7X+3P1DAqcZAk8uRT60VgZXi7LTHnHrx2PoPA7LIoDmTaxNxmLT08cIGQUoBmnQb76+obukZIcZo8sVg+lwx9vQBODm4zy8M0sd5sUAvaR7MS55x86PVEZ9vvO2FDtbVjBUSxs3TX6dMb+ZfE2NzscbfPr/rEMhOEEG+DG3ZzPks0VdN80coczT0bDbeIPUJyPR7KDvunRrjIdSu6n51hF6xUJxE6g/0ysnojBtLMPCFRJXXf1DvRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iKM2hem/22eK5dqSuVN2j90G+x4nfercj/V3+hzgld0=;
 b=CjYRyRpGeBKzs4fKI/K0m5wL/5uSqQLGw7Kx6zH9d8NR26yMyQnVJXgOv7scgY1HbzWg6ly2wrxrelUngG9cMTy9j7WL6NKuuGzXQ2TnAmPA7lenGXg6xDHPhK7R4H37t8dqklstX1DIib2JlZBC9Bl8vSd0Wf9xz2t1uLYafN9JiWC63mh4izBNP1lFtJ+ykpQgECPCVeAGaZU0QlPOgurS7qGO8IMqeE1TdfidQbzQlBu5yWj33McjAb0hgm8z9WUKT2F+8ZuHLrjkYst9KNuUMIoTlGnm90nxW0Y53xmOCD5gJFCAniWu4TeRJ3LSIPtdFRwX2AYVCS/tBHLv1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iKM2hem/22eK5dqSuVN2j90G+x4nfercj/V3+hzgld0=;
 b=CTOD0jvN2U9OIQlin2EQLYy9hPZa0U3Luv+wzsalze9Ml6NuoW+RtZUyO+7FbxyGhp9m65kQftRwl/KRdqisQ9wxGNuJxgBCsYo5i/k8x+t0s04gDp02d458AXE7UF5SLA90DEXZ9pWC/yYDcj9OKMDuR6BpmEm36a22BhUchlI=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS1PR04MB9630.eurprd04.prod.outlook.com (2603:10a6:20b:475::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 03:26:36 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 03:26:35 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: "m.felsch@pengutronix.de" <m.felsch@pengutronix.de>, Frank Li
	<frank.li@nxp.com>, Jacky Bai <ping.bai@nxp.com>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v4 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHakHRamlisSS/egUua3Va84we6KrFryHkAgAADpwA=
Date: Wed, 17 Apr 2024 03:26:35 +0000
Message-ID:
 <AS4PR04MB9386A5FCB8258FED886E4088E10F2@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240417031455.3177778-1-joy.zou@nxp.com>
 <20240417031455.3177778-2-joy.zou@nxp.com>
 <CAOMZO5BGNcbxA4gH0r_AsoAHNVAcCAAo8JFshzxd86naOaOYhg@mail.gmail.com>
In-Reply-To:
 <CAOMZO5BGNcbxA4gH0r_AsoAHNVAcCAAo8JFshzxd86naOaOYhg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS1PR04MB9630:EE_
x-ms-office365-filtering-correlation-id: 8ba640c9-f7ae-474e-211d-08dc5e8e2f84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4QiNg3mbmtDGHUZWNtZ5vMD4oQXobavJ/NZa2qdFpBZRqQ+1kAjY6bTZzeT1uxng2/5wHRnKOp6y+YPwZeE91rWb7dOx2ARSa06h4JpMIFTBWw0kZVeqQqZUlDnYwVGjgKPJlJQTYS3ygbIbzPdkB/TmSR+YjZGgb4VgpK3ggsh5mDaIlikSzfafjtx3jnl4UQNhq7hTREeAItofANNgLm3KnzVFoAhjQgI0M3037AnTQ46RD4FDqWn2wx597WUKxccx69E5mGYJHeK8TPvHSsuLdYq2mfd+Gc+ulPKmKU92s8Gj/s7/zcRhgB5O87F+JUb0eoE1YUeGGtCl/+2cnfibPSHKZ645CPeJSP46PinGm7G8n4OFwD0PyptX9i8vQAPEirqHlCzzZ1QjjHyAX6lXX6J8WA/cmJOhmramD4gB/r0jqn7SlhFWew7FNqqdtB7xr6mS17xDcqrkAiwdoWbgjQMf+pdUHDeMfakh32l+F8gixU9RUpm+9kfy9mhwuarYwhY3N6qQnN1hBgNH5UVc9GofYcjxP3+KJTzZo9eLcsg+cwoNo7wpHfbeNzCrWX1lw+C/UA3/lUxzfk4lL0Zf4MJOB0N6Mk6xMchB5QZvp5S5GgKDItnRYoFJZnwtWBN3mxd2AVr3KbXRPfKPryQHNaLCN0n068o9iEkn7ZOskq9fwrcXGCxlgytvLu2lIPRLs32EaFSs/xlN5Vx+LQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VTN5SEZPc2JHR2hhR01TMjhudnBNaFVlYnJDUUZic1I4RndaTFBsVDczNmtv?=
 =?utf-8?B?MjZVUHplZU4rcUpVdTZaSzJYc3VpNE9FdHB5Wm11clpORVRwdlY3S09IWlhN?=
 =?utf-8?B?WGNpamFYdGVXb2dkWkV1K1JOZFQyQnRyTmhnNXN1TjIvWUY4NTBIc21XdDJC?=
 =?utf-8?B?L2RoMWNweDVIR0tNck1Bd29rRVJGYS8wcUttcFU2L3ZYOFNpcXBiOUdiTTVz?=
 =?utf-8?B?ZkRYZjNrdDc5U3I5c3UvdE9COEVzUy9zOTRoc0dHaEczd1BYNjJHWGRTRUNF?=
 =?utf-8?B?TXBxN3ZCaS9sMjFnbEZzT3F5NTUvSUVlaEpJelJOcGZHcTJWTjIyRXU0L0Mz?=
 =?utf-8?B?MjhPc1JDYVk1NDZaZUE0UHRsWDFsVDhwRk9iZTZpYjY4bHhPQW1hTUc3ZHhs?=
 =?utf-8?B?NnM3dUd2S0pCV29yYzJMZTNuTVVHRWNsU21WZ1NpY09WWGNxL2plaEV1bXlV?=
 =?utf-8?B?bkxmVUhLZWtxb1lwVFYyTWw3RldzdVM4UTJRUS9oZUVmampHY2gzTC9QQlI4?=
 =?utf-8?B?WkpuZ3hRRFl1bnNBTndLWVJ2b1ZnUkRySTFRTG5pQy9tVXdBMnpWWldoN3Vr?=
 =?utf-8?B?OU9QQ3QwYjJISVZEU2N6MmtSdmhpQVBEWTdxMmVTa0JaNjZSdVM2MmpyRDFr?=
 =?utf-8?B?YkdHTmo2SVhtdHRZM0tRSXZOQlh3clJGUGNoMTRScDN3UHk3ckpBYit5SXNi?=
 =?utf-8?B?ZjV0TFJIMjFvc1dJSmg4SUNsNzlxazRuM05HTnlSc0c4Rk1Fb0M5RlZnYnhJ?=
 =?utf-8?B?MU1qelp5OGo1SlE0NTQ1VG0yTEVySEFKM0dyZEJtMXpkbytGc29Cc3psSWYz?=
 =?utf-8?B?ZkdiNElHazhWMzU0UVNkbmI0c3FsOGhkWmFaYVl0TExsVnFSZ25YRkxpMUF3?=
 =?utf-8?B?eDg3L3pIL0haTElSeUR3L3QzaFRnWnNCcFM5U05kbUxDdWlxWkI0b3cvUFZE?=
 =?utf-8?B?b0FnVUNmUi9jTy9ySDJJWWdSRTZmcUluaUwrRWxSQ296am1GTjZrMUU2aDhw?=
 =?utf-8?B?c3MxT2l4NjZZV1lDY3JEdW0zUDc5Z0V3UW9Ga3FWMGZoRmZoWEZjQnE1MnpU?=
 =?utf-8?B?Zy94dmtVNTMyelBwVmY2ZzU1eGtkelFmUU50L1lUTlhWWTBybE9EQjZBWU9E?=
 =?utf-8?B?cXEwT1BLQ2pjWk5jMmdaNkp1dUJLVTlBU0pOUVpzT1Jhc1NCaVlsRGg4c3Va?=
 =?utf-8?B?N0t4R2xlUTM1NDMxM2U1QWN1a2Fnd0I4V0VKN3NuTzV5dW9wMStFOFIvb1dw?=
 =?utf-8?B?bHE2T0s2RkViNnlYYm12b3VxRTJidlZRREcrbWhoZXZFNkRRQXdiTEkreUIx?=
 =?utf-8?B?YWVNTFBxamJBK2lFeDJ0NXI4SThTTmtxaThkOXhGK283WUFyN2RzT0RGdDFx?=
 =?utf-8?B?M1FCNlBBenZuUEI5YnNJQUgydVFqOXYxV3BjcTlWSVR5QTUyV3ZnZVJjdXdL?=
 =?utf-8?B?ZnFySnFKUlNjbFB0d1ZJNUptQkxKQ1lCWXhUNjNXYmhlQzA3eGhvUjBhNk5K?=
 =?utf-8?B?SyszdjgxTkZ3WlFTL0VXbDN0VDNVeWpDQ0xtTkNTQUVacS90WXNzY0c0ZWJH?=
 =?utf-8?B?ZWIwdTNwR0ZvUHNZa2Q1MTZQZXkyczk1b1VrNnFvdWtBeUI5QnpkWHJqWFVD?=
 =?utf-8?B?UzBYZ2lhRkdwbmtGd1RJNllmdG1jaThYZlR6a0doaVBZcmNLL1NTLy9WY2lk?=
 =?utf-8?B?Z1VLZXJMZDJUSVNKVW9qRFY5NzdiYllCR09ETkgzZ3ZuV25FTmhqQlhwdEtv?=
 =?utf-8?B?S2lOeTYzQ3l0VVBHSEp3NzdQdjg3c014ZjJDcmxvMVdjMExwSXFLS042cHB0?=
 =?utf-8?B?Q0ZBek9ZSmRmZkRyMjk4T1pXSGR1UTltRGhIUkJlblBLOGpLZzN0ZG13bmRk?=
 =?utf-8?B?UVRoNFRSejd4QXphMUtoNzUyaERUc2xHNngrdEg3UXJvKzB6bWZic0d3bkxT?=
 =?utf-8?B?NDJ1OVdjclhSZGhHSXdwcEhKbENocXcrNDVjTEZzakF2MXp3R0cwdG1NTXh6?=
 =?utf-8?B?WG8yR1pPa1VrUG5VZWZhZ0pQL3Nrd3ZyZ2Y5V041UlVNTUZkTzJaVWVJLzJ5?=
 =?utf-8?B?ZHRCVzdTR0doQUFxTE1QRTIxTzZBWEpTMGJIUVhsTjROczhSYldsTHFhak5z?=
 =?utf-8?Q?/CeA=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba640c9-f7ae-474e-211d-08dc5e8e2f84
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 03:26:35.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w7Db3GuqnkumZ5MXLi1OFwcBmDaa604X3p0GyixS9V1uCDIa1yPJvEfw3PaSf11/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9630

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmFiaW8gRXN0ZXZhbSA8
ZmVzdGV2YW1AZ21haWwuY29tPg0KPiBTZW50OiAyMDI05bm0NOaciDE35pelIDExOjEwDQo+IFRv
OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+IENjOiBtLmZlbHNjaEBwZW5ndXRyb25peC5k
ZTsgRnJhbmsgTGkgPGZyYW5rLmxpQG54cC5jb20+OyBKYWNreSBCYWkNCj4gPHBpbmcuYmFpQG54
cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGtyenlzenRvZi5rb3psb3dza2krZHRAbGlu
YXJvLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5o
YXVlckBwZW5ndXRyb25peC5kZTsga2VybmVsQHBlbmd1dHJvbml4LmRlOw0KPiBkbC1saW51eC1p
bXggPGxpbnV4LWlteEBueHAuY29tPjsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlt
eEBsaXN0cy5saW51eC5kZXY7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsN
Cj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BB
VENIIHY0IDEvMV0gYXJtNjQ6IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQgcnRjDQo+IFBDRjIx
MzEgc3VwcG9ydA0KPiANCj4gDQo+IE9uIFdlZCwgQXByIDE3LCAyMDI0IGF0IDEyOjA34oCvQU0g
Sm95IFpvdSA8am95LnpvdUBueHAuY29tPiB3cm90ZToNCj4gPg0KPiA+IFN1cHBvcnQgcnRjIFBD
RjIxMzEgb24gaW14OTMtMTF4MTEtZXZrLg0KPiANCj4gcy9ydGMvUlRDDQpUaGFua3MgZm9yIHlv
dXIgY29tbWVudHMhDQpXaWxsIGNoYW5nZSB0aGUgZm9ybWF0IGluIG5leHQgdmVyc2lvbi4NCj4g
DQo+ID4gKyZscGkyYzMgew0KPiA+ICsgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4g
KyAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gPiArICAgICAgIGNsb2NrLWZyZXF1ZW5jeSA9
IDw0MDAwMDA+Ow0KPiA+ICsgICAgICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiAr
ICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9scGkyYzM+Ow0KPiA+ICsgICAgICAgcGluY3Ry
bC0xID0gPCZwaW5jdHJsX2xwaTJjMz47DQo+IA0KPiBXaHkgaXMgdGhlIHBpbmN0cmwtMSBzdGls
bCBoZXJlPw0KWWVhaCwgU29ycnkgZm9yIGZvcmdldHRpbmcgdG8gZGVsZXRlIHRoZSBwaW5jdHJs
LTEsIHdpbGwgZGVsZXRlIGluIG5leHQgdmVyc2lvbi4gDQoNCkJSDQpKb3kgWm91DQo=

