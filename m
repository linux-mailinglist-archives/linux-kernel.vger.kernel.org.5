Return-Path: <linux-kernel+bounces-70138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF73B8593DF
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 02:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61E7C1F21845
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 01:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C747136A;
	Sun, 18 Feb 2024 01:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="NjkXoIFc"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2068.outbound.protection.outlook.com [40.107.22.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C707FA;
	Sun, 18 Feb 2024 01:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708220251; cv=fail; b=iDHs6ij89WAr+wDS1vGqeGi1iq2TesLMI5M4nyjduytatRtrlcWa0Z3fh3Pok8LA9CXNJSGpM2/bX25nv25LjwBceJqeUajSYyvblNvR2SfpP3HQJjB6Gv4rhNhlYUtknx1KXrT02dQ/q+6yJnlhNnOMKyjaAZgILb97AqVo3io=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708220251; c=relaxed/simple;
	bh=oLps8rVUfg8pnkEVBDv92VZ7jyeQtd6UAefDI5NeMwo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M5M3sLEivg9bUGRv9HPqM/O1yHxfat8YpgLQfb6U01g21WZva2fRVTiYm9ibhpMS1vfUyCY2te3UJGIpQiQtweGzgAcFhoHwTDn42UKOBDJCsHpTrK84kYxysoE/zwiZTop1WzctpB5LPsugLI/wpkmEDvtcMMhAnI1AQqjF+Fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=NjkXoIFc; arc=fail smtp.client-ip=40.107.22.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0LF78K1HDdgXRbCz9zD6Jf8XgV2//HlrByCP9A6Oay6FKof5EQ+9TKX3udFw/3RfVQWN5N5PeSSMphBEcEnzMVCeKL08joydsapQBmGvQAKYvcLmoMZR/e+ORlzfhCNdMrbQCYJ7AIWnLZU+XGhe1+Ow6y5fUrQ7frfHcnyA7+/w0GDVYERbGPa0Hy0FLlgZ2rc/IOMGKtZrT3jJzixmeeRUhazgPUzLo5ERF6hS7KT17eUcSHhmf+GcLHzO7wl9MEL4NhmacBtCw8e4sIBeG1RDqdCzBCEQcQCETNWcwLvpuniabVoJ5+MruouTtmgma4+HqRSzdbTORLmtKe/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oLps8rVUfg8pnkEVBDv92VZ7jyeQtd6UAefDI5NeMwo=;
 b=cLuiqamGVvnqq/5HzAOGi2AFF1nUYCcZoyiSofgoH3bIuWe0HBHOkc1aw/uJ3nyEWhhuyQTIiiJcqofyNbg9ahsZHTdUwE4SQN6Cyt3x+FS2fjfMqcZWVIkAKVKdUwmyOTd1Oco5r04QvidNSLmbGdgESNb9tmNg/Bb4SH8+WPquN0BHEoC7cKNAA8DhJaNoXgSQAnpR+PCXFIy2BPtuxoSg2A3OEUn3fe1GDCWepFoN2SYhUOIOKgfRG/98VhbMrmazJ5Vk6Aw8ebWD+jV7EY8Xd0jR/Z7qtzG02viCpZxGmlSqND921h2tQWJgyH6octA8QVxsvrnQIXfrXrYVvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLps8rVUfg8pnkEVBDv92VZ7jyeQtd6UAefDI5NeMwo=;
 b=NjkXoIFc8mymA1zS5oQa0vp73Yppo/LUNErPZeOO7xUL0hm8dTZ92cDiy32hV/CEpJV8Y7HWscSUxP0YO6we3cGjCzMeNcaBHPmjPm6cYRPO6yxD5wyvj07fZ/KIUwu/dMTx+uGsOJRjzbeJe3qLA4AmoMjqzPlbeUXkFwjwh0I=
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AS4PR04MB9715.eurprd04.prod.outlook.com (2603:10a6:20b:4f9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.32; Sun, 18 Feb
 2024 01:37:25 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::d487:212c:8d0e:727]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::d487:212c:8d0e:727%4]) with mapi id 15.20.7292.033; Sun, 18 Feb 2024
 01:37:24 +0000
From: Peng Fan <peng.fan@nxp.com>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Daniel Lezcano
	<daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Jacky Bai <ping.bai@nxp.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
	<s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>, Marco
 Felsch <m.felsch@pengutronix.de>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>
Subject: RE: [PATCH v4 0/3] clocksource: imx-sysctr: support i.MX95
Thread-Topic: [PATCH v4 0/3] clocksource: imx-sysctr: support i.MX95
Thread-Index: AQHaV+FQDyU/g8Nl5UOUjyuVhpOCy7EPZh7A
Date: Sun, 18 Feb 2024 01:37:23 +0000
Message-ID:
 <PA4PR04MB941660F5ABD35C8715A1656E88522@PA4PR04MB9416.eurprd04.prod.outlook.com>
References: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
In-Reply-To: <20240205-imx-sysctr-v4-0-ca5a6e1552e7@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PA4PR04MB9416:EE_|AS4PR04MB9715:EE_
x-ms-office365-filtering-correlation-id: d15fa0e6-d367-47fa-04aa-08dc3022281f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 e2G2oRIrIZuGtll0UkL/pTRCjeVrFYGDA6oTDCWXpfgcyk8YI7JzM8rB99D/L1jMXK24zsTjoyM0tN8bRcvLH3XX80OuA0YkArqfYUjMEweQvn9QydP5ORGzzlm29F2dGW7nO8X6cd70Gryp+chEEe1oQ87U82Iif7i5GNmFN2BTdtlRXkuQd/HQ1x7u5IxfiG+P54kJ7kCLJR9TaZTsMxyq7ojeh0rmjctFGFVyQgT6YtLx5GtYMdJg4NZ/0E3ENC2Sft2ndQ0sb5j+wLZuBzwW8UkuYCtV1PGkYGv2VFNOeaM6+yf2QDSuvQVNiaJTXPEbsPq9Z5OjjBqlo5W2uHZv2eBerrUYCcvIZ92/cOhYSdcS5GevcwcKhq1T9/VA0H7yYM2s1jX0liRgZApMvR4JTdEliqTa/rROn3AUqyPbPU2hiPTnX8YjIzpEDz181Bi8xqaHB28mtyjK+qqe20ml8lYQgVBv+sFtfRZ/8NxJ8G5LNiLwnpTt7QUumWUiM+l/KAmtN6bDpcajwNi8tjfNMLdmzzbea3VaWNkaCy3DMq930MOMmDOo0J/KUl23DPLTQEHDcjL6yrBwmGqyZza6SSj0Q+yy1WrwaH3fUCkAI1spYzJJDcK4rIigGZo+
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(66446008)(921011)(64756008)(83380400001)(26005)(66946007)(41300700001)(316002)(8936002)(54906003)(8676002)(66476007)(52536014)(110136005)(66556008)(76116006)(4326008)(478600001)(966005)(6506007)(7696005)(71200400001)(9686003)(33656002)(38100700002)(122000001)(86362001)(38070700009)(5660300002)(7416002)(55016003)(2906002)(44832011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2FDWVhQeTFHREl6ZThValAxczc4c0pTQXRSU0MvOVdHMWZ5a1B0N2pxbmhq?=
 =?utf-8?B?ci94L2Q0UGJzRHpkc3lTTDlsQVFtZWxIMU1oU2Q2TnFVeW10U0tNdVRiRkQ0?=
 =?utf-8?B?cmpSSW1OQlBDbEdmU2tadkFTQncybGlZVmpEbDhtaGRBQU1iK3REdHdTZWhh?=
 =?utf-8?B?SmxSeVhCU3lrUmtSSmpwQ1poSExiM2VvMGFITXNvaG1LK3pSRVdVTGd0VDNE?=
 =?utf-8?B?cUQ4R3BKK0ZibFU4Q09aamlTM1JEay9iSm0xYzZFZjBSMnFvYU9DSUtxN3NB?=
 =?utf-8?B?cWE3WkxZT09OcGczbWNFWWpUZUVQb2ZwcDZMNW5mOWVIamFWdjRtTjAzR2dW?=
 =?utf-8?B?ZlR0RVhUbTc5bEVQM0g0QTdxbCtEY0xYS0hjSkl3bHpsZGUvN0VYWDI1OUdr?=
 =?utf-8?B?Zmw3bldEYkhOSGlpcHlkWTEveFRNK2tLMDk5N3hURmw3MmlIZTMwUnpyS0I5?=
 =?utf-8?B?NmpiUXVSd0dkeW9xdWc3bGtPYUtueFN1Wml2Q3dlL3dEQUlsanVFME0vZVRC?=
 =?utf-8?B?cXljOE9JcnFaR0lwb1BySnhSbUpibVhvWWpKaW9jQTE4ZHpEZUorRkV1Y2Zm?=
 =?utf-8?B?VWJrYWQ1SjFsa3VuTmQ0TkdWbzFIMUh0YWUvZW9ob2c5NUNydnJrNS9YMnU1?=
 =?utf-8?B?SU5UV3ZoNWI2bTlBUTI5UXNmd0xvV1VBcGJkclQ0UzJ3M0VzM1kzbmp6N3JF?=
 =?utf-8?B?M29yUFYxQ2NqNU5IS21tZXVpVXlZWC80elpPLzFNQjlpMFlZbytJSTFBaUpE?=
 =?utf-8?B?U1FrbFZBQTN2cTFmM1lmRkFIMWNpelBwZVdKZ1BBVnpuSGFPSXQwQkV6OU13?=
 =?utf-8?B?Q04yVVJSR1hyVytndUFTbUM5aWxKbmREYnQxaEhoWDM0VkxnZDMyaVlrZGFz?=
 =?utf-8?B?SThvNXZQNEFQZEorNWFmS294b2I3UE1mZDhMNjRSZGw2UFQxQWw5bXFCVE8r?=
 =?utf-8?B?Slp2YzN3SWdUaXdXajJyZjBKY0UzbExrSzNKU2pjSFVHT2dtcXE3YTNaeGNN?=
 =?utf-8?B?dmVFM25sQkdBUkNtMGdpL3k1THY5d2k1ZkNOSnNzbFRTRGdhRm05NmtSZGpO?=
 =?utf-8?B?aFV4V3c0eUlCbDF4alJSbWJheHN4dTZRdEM1bkFidnI4WnRBQUdyZTJwWEZF?=
 =?utf-8?B?NVI2SWZkSmhIcU9YVVp2MzBDY0twRHNKUFFBM0FHQ1VjR2hhTkF4MHRtTE93?=
 =?utf-8?B?NFBOUjlFcWs5TGhvUlllU1BGeGlkZWRGSGxsWUMxV0Q1d0RIQ0ZUOHliUnhP?=
 =?utf-8?B?UDdYdkpISEJCVTRQRW9aRzNxZEM2VzUzVitNVmx0YXJlOFdDRzJmaUxnYjFx?=
 =?utf-8?B?UHFIdWxNSVA0eHdTViswQjdxbFVwRG5QSDZaSXc0ZkxOTU9aU1MyR3JRemYw?=
 =?utf-8?B?TTBSN2tKS1JHcnVxYlUxd1RRL1NZU0V5TEJON29xQ09aVi9aU2Z6Q2daWldn?=
 =?utf-8?B?RERJSmhSblp4czJCeDhiMUtCWlkyZjJlMDdBWXBwME0xVWtoRDUwRml4ZTZm?=
 =?utf-8?B?ZDVzbVdnZ3JuWEpvMXJURC9aZFVKUEk4WENTeFR2bXQ1Z2YwZUJyd25ocTRt?=
 =?utf-8?B?c2ZMSEZJa3Ryand0dGl0UzBmdExOcmN6SkpYREM3ZndKeVZSYVB1N2FTZHkz?=
 =?utf-8?B?RVN5dDkrTVlqNnJwR3c5QjFOb3NmbmlyNHdFckxQcE9lMTZmamVzNlgwTjBO?=
 =?utf-8?B?UVJoQzZFL2lRQzEzTEJkQUdLbkVkNzBmU2VZOGxpdzIwSU4xSVdOVkZuQzF2?=
 =?utf-8?B?VUpaZkcwTDhzcW5aQWVzem9US1BJV25qN2tBKzNRb2publludXhoSFZPTmlF?=
 =?utf-8?B?QlIwQUlraTNYUmtsdmFML3NjQ0JMNERiaEtpbVA5U2QvSS9PeG5oWllkV3ZG?=
 =?utf-8?B?eWRaajg0eURJalo2bkU0MHE3emZrQmxjWEwrRTF2N01WMmhlTXd6S3FBUS9p?=
 =?utf-8?B?Z0cwdlhENDc1WHlhdk42R1FVVGkxN3VjTXlBek5ySE5reGRVbjcxYWFsN1E2?=
 =?utf-8?B?aGJOZm1Qd1Rzdm5iMjAxcS8wWkhqTVJIbWFsR0RjUzQvdldCOGRnQndBK2Jq?=
 =?utf-8?B?ZlNVV0xZeUxXVVljYlJWdnkxcFdwS2FEYU50a3JSRGpFSHZBWHpMYUpvaytw?=
 =?utf-8?Q?J+T8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d15fa0e6-d367-47fa-04aa-08dc3022281f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2024 01:37:23.9359
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qZY5M2OVoeNg70z9YtK/WyXKBF4W6O33XeWH6nYjCOVrtsBXwnpTy72DNF10CEzInlrv8M1+GQO8SAozGNDNdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9715

SGkgRGFuaWVsLA0KDQo+IFN1YmplY3Q6IFtQQVRDSCB2NCAwLzNdIGNsb2Nrc291cmNlOiBpbXgt
c3lzY3RyOiBzdXBwb3J0IGkuTVg5NQ0KPiANCj4gaS5NWDk1IFN5c3RlbSBDb3VudGVyIG1vZHVs
ZSBjb250cm9sIHJlZ2lzdGVyIHNwYWNlIGlzIGJsb2NrZWQgYnkgU0NNSQ0KPiBmaXJtd2FyZSwg
c28gd2UgdXNlIFJlYWQgUmVnaXN0ZXIgc3BhY2UgdG8gZ2V0IHRoZSBjb3VudGVyLg0KDQpQaW5n
Li4NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IFYyOg0KPiAgIC0gaW14OTUgaXMgbm90IGNvbXBh
dGlibGUgd2l0aCB0aGUgZXhpc3RpbmcgaGFyZHdhcmUsIHNvIGFkZCBhDQo+ICAgICBzZXBlcmF0
ZSBlbnRyeSBmb3IgaS5NWDk1IGluIGR0LWJpbmRpbmcuDQo+ICAgLSBQZXIgTWFyY28ncyBjb21t
ZW50cywgdGhlIGdsb2JhbCB2YXJpYWJsZXMgd2FzIHJlbW92ZWQgZXhjZXB0DQo+ICAgICB0b19z
eXNjdHIuIEFuZCBhZGQgYSBuZXcgVElNRVJfT0ZfREVDTEFSRSBlbnRyeSBmb3IgaS5NWDk1DQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCj4gLS0tDQo+
IENoYW5nZXMgaW4gdjQ6DQo+IC0gQWRkIEEtYiBpbiBwYXRjaCAxDQo+IC0gSW5jbHVkZSBzbGFi
LmggaW4gcGF0Y2ggMiB0byBmaXgga2VybmVsIGJ1aWxkIGZhaWx1cmUgZm9yIGkzODYgY29tcGls
ZSB0ZXN0Lg0KPiAtIExpbmsgdG8gdjM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3IvMjAyNDAx
MjYtaW14LXN5c2N0ci12My0wLQ0KPiAzM2ZlODAxZDVmMzFAbnhwLmNvbQ0KPiANCj4gQ2hhbmdl
cyBpbiB2MzoNCj4gLSBEcm9wIGl0ZW1zIGluIHBhdGNoIDEgcGVyIENvbm9yJ3MgY29tbWVudHMN
Cj4gLSBMaW5rIHRvIHYyOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjQwMTI1LWlteC1z
eXNjdHItdjItMC0NCj4gNzMzMjQ3MGNkN2FlQG54cC5jb20NCj4gDQo+IC0tLQ0KPiBQZW5nIEZh
biAoMyk6DQo+ICAgICAgIGR0LWJpbmRpbmdzOiB0aW1lcjogbnhwLHN5c2N0ci10aW1lcjogc3Vw
cG9ydCBpLk1YOTUNCj4gICAgICAgY2xvY2tzb3VyY2UvZHJpdmVycy9pbXgtc3lzY3RyOiBkcm9w
IHVzZSBnbG9iYWwgdmFyaWFibGVzDQo+ICAgICAgIGNsb2Nrc291cmNlL2RyaXZlcnMvaW14LXN5
c2N0cjogc3VwcG9ydCBpLk1YOTUNCj4gDQo+ICAuLi4vYmluZGluZ3MvdGltZXIvbnhwLHN5c2N0
ci10aW1lci55YW1sICAgICAgICAgICB8ICAgNCArLQ0KPiAgZHJpdmVycy9jbG9ja3NvdXJjZS90
aW1lci1pbXgtc3lzY3RyLmMgICAgICAgICAgICAgfCAxMTcgKysrKysrKysrKysrKysrLS0tLS0t
DQo+ICAyIGZpbGVzIGNoYW5nZWQsIDkwIGluc2VydGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0K
PiAtLS0NCj4gYmFzZS1jb21taXQ6IDAxYWYzM2NjOTg5NGI0NDg5ZmI2OGZhMzVjNDBlOWZlODVk
ZjYzZGMNCj4gY2hhbmdlLWlkOiAyMDI0MDEyNS1pbXgtc3lzY3RyLTNhODlhMDg1MjM3Ng0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0KPiBQZW5nIEZhbiA8cGVuZy5mYW5AbnhwLmNvbT4NCg0K

