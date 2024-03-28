Return-Path: <linux-kernel+bounces-123237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CD7A8904F7
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3671298D7D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7852D131734;
	Thu, 28 Mar 2024 16:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="Fpy4hmIJ"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2104.outbound.protection.outlook.com [40.107.104.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EA354773;
	Thu, 28 Mar 2024 16:22:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642926; cv=fail; b=BwELDZ6QnEOQgABGoA4QXJq56iPHOe6lqvKYAWNz3CzXoRQudauPY9FFLGB0ByC1ZNQ98KzpGF2EOUIdhSNRArcxdI6ZStJslDXrbizdjFN+PhP597VyX8jNhkvPWZZrsPheDNe+ohvSVbFHxZu3NIi6mZ6JihgOciLGAQI0F0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642926; c=relaxed/simple;
	bh=tgNYBkUoFCUxrstCEeAZodG/OWURZjWielWnxGGtpsk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gxW8gbsftd4limpRrVqGfY0fVAtBztKoa8G/YIFWPIbr7IjUnfSxJQq3DUffh2bz8lAW3VeHo+Pfa9TYA8eADn1FgPEnoiIw9CM+4nzI+CH0wB5F1e72/Fw1lINNbduAh3kscppCJ/0joYQFuu088iFMZUR69G4YH8JP/hbUMRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=Fpy4hmIJ; arc=fail smtp.client-ip=40.107.104.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgtgSdK292my2mn0XlUgCbTro2nNsL8pgmkEk+CSa2B/vBHyhCnV1+jiq1IbAaY3XnmDR5n2i2VJt6XWiRdeNVYyCo00mocv7bS0r0RvcWFeR2ID15Mp1p3WOv3rk0R2JepjEc4X/k3EtTO/n9n35rTidV9JlFxzskPFDy1s4kegIZlQkH2KRzFg4prhMW7MELoJ4JQZI5YiDmGIO8Y+amaTCYAHARsKoo4eGVGT4EnBh2Py0/tiyIKV2JxnOCBtvOGCOHQv/7kUZgqOpCoWvOeuzwpTUtctWsGZfujV3aRqeVmAhT5AZKSsabTgwJeVWaIl4rjpQq2cD5XMrKIq+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tgNYBkUoFCUxrstCEeAZodG/OWURZjWielWnxGGtpsk=;
 b=fsQT8AoZujvwenmwJhPnuvcGU2VjCo5zYKWmGGBEGVhri5aCzViE5m2sLKWt/2oAmQFa/3fz49RCJief/B7IBeNrPUCCrTvIQcTvks8V2Uph8d6CMfbOnbJQvDRwFe5GqU8C+7Eksq4Dgrh9Eu/jnY9TxSIRBQM62AWDVFGglTpy3ZxKiv6qlPowVQLGv2vgsyoxH0HXxbsmbpBRl2LuofmIuB1Mu3Wv2pTsK5Hopcg+9ot+3b6ESmsg++cKdtNi5z5zFRrkcgotd5Zfuh4kZN9yGcJrwimsNYD2IAyIjhMFACyHqP7ISYaKq1IRJkh72a3gr99JanWq+gsfa1dAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tgNYBkUoFCUxrstCEeAZodG/OWURZjWielWnxGGtpsk=;
 b=Fpy4hmIJSK57jXrFvh+6PaoWLzV6J9FvKcq5ZD7hcGnsoMf6ZQBDc+OYli9ygyrz7zKXyh/1Z4FTK0alH7ztmtz4ydV/N/6oUlCmtlKFaSFQ0Yx9N2CIi1Aozdm4trRkfEQouEZmtw8jFEGTUGS5v2wEnW4SBCzo78fplCXi8wM=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB8PR04MB6794.eurprd04.prod.outlook.com (2603:10a6:10:11b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 16:22:01 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:22:01 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Topic: [PATCH 1/2] dt-bindings: arm64: marvell: add solidrun cn9130
 clearfog boards
Thread-Index: AQHae9lZw/gIYk6zDE+73DiBF+lb+bFNYG2A
Date: Thu, 28 Mar 2024 16:22:01 +0000
Message-ID: <c4c4b7c7-fe89-4671-97c3-36c8bb416af1@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
In-Reply-To: <20240321-cn9130-som-v1-1-711127a409ae@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DB8PR04MB6794:EE_
x-ms-office365-filtering-correlation-id: ee1b9259-dae0-4abe-a356-08dc4f4332da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tQTYfXa0Fj2jc/+jgkWympgJCIFAFZI7q46rhyOhU2Tck78OBUIO4ysYC6FDxno87ZgxKuUd1+uNek1ClNY2I8XbhgtICq16/1x+TQLA1MC4BTBwMj8JX/wjHgI2ZY/8xu6lvpo4+fifWNGPDiyK/dUm7M/AlHVDPBYbb2ZcN6RbS2rInLGC14Ze3Y1FnHBgmRf7XTTNS6NBsuJ6FOkHzJFW26uRGgl9X3feB5vpKuZxESL8xEc2hG4KwpdDmmOeqQSI8r1VfUy1RXiTU4GLHeYBrRHH9BjsZGb3u7Xo74MZd5tPArIpqEshk9n2x75m1VrHWrb6hWlO5tTjsN0puSby2695IFNOA78miL/exEHogBZ/JYywlsPMADf2x2qBB2sU2qDwjmAQyrcE3RC8p0QtQZgk5bQUCC0d1iy6//JAtt+W7+dFAI4rvnfbhBY+HIeUV5RmgzNLZ63UI9t4DZ+VC8dRq+qu2hUZ5EtwGxVMdtWH5zU4tbFZHsKP6dUZdkUm0z6qg08bxFOqphyl5vTgUzw7nFnDAO0CSXwE0bR7z9npqN8Cc1s6XaVYwd+vFkQ4Wa8t/CGDvpoElGJJEqJb5U676QQPE1CAtpnpJBQPXgs1e8+uv+OVCF56YQVr4ffabmjGeOfEl2ypTIY73oLFPaUNu50px9qIrdNJA01lazr89BMd+cnPwpAxEnVQ0eVSg/xsEVMvoplT96/3Gw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dE5WQnN4Q0dyQlVCbUtkQVMxM1Jham4yZzk3ZFFIZ1Q4NFNZZlBBUjV4b3hh?=
 =?utf-8?B?T2pQSG42R25mMGFrMWhPYlFxUlR2SHpHUkVJNldOR1FnNWlOUUMvSDJaTW0y?=
 =?utf-8?B?ZjFkYm9kc0RJdmw2c1BPUTRPN0t5NWw2dFlaTWZtMHNKZndzeUZvcHVSd0FT?=
 =?utf-8?B?anZKQmxuTWRHbUE1SU1OS2Q0QnNhQ2VsYm9sUS8wNUs1UDE2QWFHNzJWcjNE?=
 =?utf-8?B?VWwyRk5BQmRnaWIzOXNBc1ZocXFtYk0zV0tZcHBvQ1oxL1AwdndjK3MvNVZv?=
 =?utf-8?B?bkQxREFaT3Z0d21OMmZTaXlGQUxNaEhyNTQ4STdXbktPYTl5eTZ3Q0JkdjVp?=
 =?utf-8?B?Z09vTU9mQ0xjelNFTDB3SFB3WFUzQm5HU0prUFFINjJJazVxeFYvR2o3WUli?=
 =?utf-8?B?Y1JNeHFlOEg1OTN5MXpKajZaN1RYOUVTTTYwZXp3cGRPVStOQktOOEhIUEc4?=
 =?utf-8?B?cjJ6Z3U4cmJQaXJja1JuanNSdFJHYzM3TklnZ3JGRWJudTJtamJDYjF6aDJN?=
 =?utf-8?B?LzZNWGNnQVgvcG16N0wwdGZKdHJmYUZ2aGxxa1pnY3B5VWl4Z0pWdzdCbG9l?=
 =?utf-8?B?UURoSE9Od3JzblhWM2x2cWVCLzllVWJiK05CbHduVzB0RExDaGZtY1pSOGFP?=
 =?utf-8?B?WndFWXBDU2tDaWFQd3hDREZUeWVQQjBoelhMWE53c0hyZ0l0RmMwY2dseGxE?=
 =?utf-8?B?dzZQVm9vU0RtdmdVOW41dUN4MUJiN3FZYUx2Q0pGZFcySkE3UTYxRXRFVkI5?=
 =?utf-8?B?UExVYkNnUEpTR00rZndLTllyZ3V2bGFxbWV5VkI3cURjZGNqb1d6UTExc2tv?=
 =?utf-8?B?TjdRbCtCa2NZaW13OHBNZkhmRnhxL24ySXFTUlRPN1FZT3A2aHhRa1JibmFk?=
 =?utf-8?B?R01HMjBZOEdyYnNqZCtTSEtYRlVidHdUMmRyVTVBVW9qNXc1NFNhRVg0Zk1W?=
 =?utf-8?B?aUNPNmJRWGpDQTVKN0dJa0w2OWg5ZjZWdjZ0cUxtdFk1a2ZSRFVKTW5zNHgz?=
 =?utf-8?B?SVpIK0wzaWFmYmhlSVFHY2pPdk45dWJ3RVVVZ3hNTmNKUXlGR0pNNWhKMUJH?=
 =?utf-8?B?UGFWM2s1NzVZa2c5V3FRUG16S0QwVjZtUkFtZmFLckpuZTJoOGw3cDhnYUQ3?=
 =?utf-8?B?amQ5TVg2U0tEM1FBUnNhZVN6VmZQK1JyOXpJK1hPZnVSczBHSEY4MEp2MFdP?=
 =?utf-8?B?V0FyYTBVZy9XVWYxUjUyMDFkR1dCcUc5aGJ6NndGeHJVTHJUNDRmZlg2R05k?=
 =?utf-8?B?NkRxaEFLdldyenFxTkZYQUdvNTdqdUg1NUVZVUlEVEZrLzBlclVOK3Fuc09X?=
 =?utf-8?B?NW5zQithblgxbUFtMHpGTHJSVmxMR2lGMVlpTHBvTXRIVE5RQm92ZkZ5MUdH?=
 =?utf-8?B?RDVXUVArMEw3NE05Vk5sQ1Q5SWpUV0tmM3lOSzBHS3dya3FpRXhKNE5nNGNN?=
 =?utf-8?B?eTNzRk96UVdRM1JaN21LYk9tTnRGczdFV2pmcVdCUGhZUFladjVZaWZObUNJ?=
 =?utf-8?B?dFNiaWY2S2c0aWQ5Zi9nTkVrN0VTK2tRVGdFRVdHd2pRa2ZtdWd2L3BMVjhS?=
 =?utf-8?B?YVdUNncyL01Mbzk2QzZ4bHJ5aVNNTW5YbHlmVEpzU0h5SkdPb1dpQUdpdWRk?=
 =?utf-8?B?UXNsMHdocDErU3Zqb1RPTTZoRmRLdWh2TEpXd0trRUllN3JGMTVXWVNyVmJ2?=
 =?utf-8?B?OU5GbDRZRXFDcXRxTk1HV1JYSUFFNHJnOEx1UHNVUkp6YSt5RUJqSnEvZm1N?=
 =?utf-8?B?TlFLeUc2bHAydkhSWFg3bFhLZkRMQW1TVkpvWll1M2xtK0FsbXNuNCtUWUdp?=
 =?utf-8?B?WlYxOWJjdDhndHJMM3l4WjFjOUhSdDlZc3RPWW9jaS9rVXZQcG9DQTFjM2Vu?=
 =?utf-8?B?YUJuRWNkSS9xcHp2dVZ5VUtYcXE0bTFnYmZRMGkvQXZzZXQxeDAxTHJZV0VU?=
 =?utf-8?B?dGViZXRlcXdyeEdHZjJiTjgzTGgvSDZzejBRTHpNb2RKZXBMUEJsNkVQRFYy?=
 =?utf-8?B?ZG9KcGgvQTdYMzJXVE1pUzdXeFJlK3pKcGxpejU2ZGlkSEJMNlRpak9TdmVV?=
 =?utf-8?B?bHhCZUFURDIrSWdVelJacnZsVVh5bVprT1NlTVFBRGdjWldJcmlueUFOSVZa?=
 =?utf-8?Q?u7RcDXucasGHjOrI5ciWLnIik?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDCF3F9B31E0CF4AAC257967C02CE96A@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee1b9259-dae0-4abe-a356-08dc4f4332da
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 16:22:01.3910
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZLD6DFy9L4BfN2QSz+YWj98Ty6Nz2DQ98rTL8GOWtsILohaZuw1fmvZtkcspiTJNbVlgi2MM9mEb7L2g5BRlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6794

SGkgYWxsLA0KDQpBbSAyMS4wMy4yNCB1bSAyMjo0NyBzY2hyaWViIEpvc3VhIE1heWVyOg0KPiBB
ZGQgYmluZGluZ3MgZm9yIFNvbGlkUnVuIENsZWFyZm9nIGJvYXJkcywgdXNpbmcgYSBuZXcgU29N
IGJhc2VkIG9uDQo+IENOOTEzMCBTb0MuDQo+IFRoZSBjYXJyaWVyIGJvYXJkcyBhcmUgaWRlbnRp
Y2FsIHRvIHRoZSBvbGRlciBBcm1hZGEgMzg4IGJhc2VkIENsZWFyZm9nDQo+IGJvYXJkcy4gRm9y
IGNvbnNpc3RlbmN5IHRoZSBjYXJyaWVyIHBhcnQgb2YgY29tcGF0aWJsZSBzdHJpbmdzIGFyZQ0K
PiBjb3BpZWQsIGluY2x1ZGluZyB0aGUgZXN0YWJsaXNoZWQgIi1hMSIgc3VmZml4Lg0KPg0KPiBT
aWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+
ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbCAg
ICAgICAgfCAxMiArKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25z
KCspDQo+DQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
YXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwNCj4gaW5kZXggMTZkMmUxMzJk
M2QxLi4zNmJkZmQxYmVkZDkgMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9hcm0vbWFydmVsbC9hcm1hZGEtN2stOGsueWFtbA0KPiArKysgYi9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvYXJtL21hcnZlbGwvYXJtYWRhLTdrLThrLnlhbWwN
Cj4gQEAgLTgyLDQgKzgyLDE2IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgICAgICAgLSBjb25zdDog
bWFydmVsbCxhcm1hZGEtYXA4MDctcXVhZA0KPiAgICAgICAgICAgIC0gY29uc3Q6IG1hcnZlbGws
YXJtYWRhLWFwODA3DQo+ICANCj4gKyAgICAgIC0gZGVzY3JpcHRpb246DQo+ICsgICAgICAgICAg
U29saWRSdW4gQ045MTMwIGNsZWFyZm9nIGZhbWlseSBzaW5nbGUtYm9hcmQgY29tcHV0ZXJzDQo+
ICsgICAgICAgIGl0ZW1zOg0KdnZ2DQo+ICsgICAgICAgICAgLSBlbnVtOg0KPiArICAgICAgICAg
ICAgICAtIHNvbGlkcnVuLGNsZWFyZm9nLWJhc2UtYTENCj4gKyAgICAgICAgICAgICAgLSBzb2xp
ZHJ1bixjbGVhcmZvZy1wcm8tYTENCj4gKyAgICAgICAgICAtIGNvbnN0OiBzb2xpZHJ1bixjbGVh
cmZvZy1hMQ0KXl5eDQpBZnRlciBzb21lIHRob3VnaHQsIHRoaXMgbm8gbG9uZ2VyIG1ha2VzIGFu
eSBzZW5zZSB0byBtZS4NCkV2ZW4gaWRlbnRpY2FsIGNhcnJpZXIgYm9hcmQgY29tYmluZWQgd2l0
aCBkaWZmZXJlbnQgU29DDQp3aWxsIGhhdmUgZGlmZmVyZW50IGNoYXJhY3RlcmlzdGljcy4NCg0K
QW55IHJlYXNvbiB0byByZXBlYXQgYXJtYWRhIDM4OCBib2FyZCBjb21wYXRpYmxlcz8NCk90aGVy
d2lzZSBJIG1heSBjaG9vc2Ugb25seSBzb2xpZHJ1bixjbjkxMzAtY2xlYXJmb2ctYmFzZS9wcm8u
DQoNCj4gKyAgICAgICAgICAtIGNvbnN0OiBzb2xpZHJ1bixjbjkxMzAtc3Itc29tDQo+ICsgICAg
ICAgICAgLSBjb25zdDogbWFydmVsbCxjbjkxMzANCj4gKyAgICAgICAgICAtIGNvbnN0OiBtYXJ2
ZWxsLGFybWFkYS1hcDgwNy1xdWFkDQo+ICsgICAgICAgICAgLSBjb25zdDogbWFydmVsbCxhcm1h
ZGEtYXA4MDcNCj4gKw0KPiAgYWRkaXRpb25hbFByb3BlcnRpZXM6IHRydWUNCj4NCg==

