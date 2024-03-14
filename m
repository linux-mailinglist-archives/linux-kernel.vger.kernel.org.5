Return-Path: <linux-kernel+bounces-102706-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9633B87B63E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 03:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B35CA1C21EFD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 02:01:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A211C4A1B;
	Thu, 14 Mar 2024 02:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="L7EJXppf"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBCD3211;
	Thu, 14 Mar 2024 02:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710381684; cv=fail; b=u7XefkAUr07ZsSG6sueajH0i1rwqKaWwXFf8/GAtKWxah3LyE0W5NnUx4UhhO71G/wLQq3BqBzLhEwg/9wPRL+anGdry/LSUMQ7XfxIzoY1FLkxF+ipekjc7fyuWQBhWt/qI8nG+x9PWXnlPaJ0rSfC7aIzOW7pHVbWCuLMbuj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710381684; c=relaxed/simple;
	bh=EwzdlX4aaqkS3Lpm3/tA2n6DrcK3hlcmsrecqcszJnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uH7xM8E/Y0nXOv1tu7FeQv6XrZfysuYRHQCZM7CzJSlvsfyztfAxDMjrJphGaH7eHjMGhIkBMLlf8zYk3kwhbfni6qtb5N3DVFl0e+WD5u3ZjU7vlLoVML2yDsTVJc6cdBwYfeRde81j7kwhP18Oh/+B9Da/2F9q3gC/kBf3xeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=L7EJXppf; arc=fail smtp.client-ip=40.107.13.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrnMa6mPBYT00PDIOV1bN5LYwBak2fXUCkdj/rEtU6AZdJMz1+ifPrT23nrqEnNU+V3QcrBMlZELBPEbj7s7sT9+B3ePxRRu4Cpd+XguWpolKn0AkiT5nxjN8c1gotz7bNtBRDWabGLmlNif+kKyfC5QG47s00oevI2aWz0hdzd0NC57HJCzeuO+8M9IfNIBUCZNv7evSZsuYACSteyN3sTzdQywPNmysJor8TYrJaHLIJKhiOyj4Pka2zLwrWZTRwHqT+gMyVrq+6uSWbdlxIA2Or/wAeicyd3c8/0LJVkM7Qdyc4B82ykkfMOUGsoCc4B9ceYv6TDKIhQq383U8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwzdlX4aaqkS3Lpm3/tA2n6DrcK3hlcmsrecqcszJnI=;
 b=gedszlb/Ue9bwXcK78VQwQxFn3ONQjl61jL42H59sLQk9k5mxii7Qt550Olxruea2ViXVCmjoRObYoQyHZ1886/DdnjpUeRbXKYdFAk+iiB1QRQIqyeI8CXG3tqwZUO1UOb12akCowOW6/Yg5rTHuRohLp7v7VwKHS3kA4Z9JBuPSo8/urU7ickc3OERh3/U4Pe+hDwMK75opM6XtBSKqqoD4UelhEZs7WnO7z/PUvxmo2UPLtRBBrNrVZ+DlgRx4mz6c6A/10HiY3PvmnyZ0r0u4uppv1mBuEJX4s4lx8HFHPkW01cbSN1zWHaVY9OH8Y8bxrG2zgmujBupCFNjcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwzdlX4aaqkS3Lpm3/tA2n6DrcK3hlcmsrecqcszJnI=;
 b=L7EJXppf1ajUheMI7O5nD6XJBk8KvqjWKV5kIB1j9dsLqdTEGYtNd+kC/eLXhZVaolM3B/qMfyKZBSMl9XAEvrS8JOsAFF5USYpIWd3pEwp8FeY8Yz430PUVPQyKVqbgu9LMiCFDkFgXxIuiN/nr1GCyDxNOrTEMVOc3em8NMHA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VE1PR04MB7376.eurprd04.prod.outlook.com (2603:10a6:800:1a0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Thu, 14 Mar
 2024 02:01:18 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Thu, 14 Mar 2024
 02:01:18 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Sascha Hauer <kernel@pengutronix.de>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "cristian.marussi@arm.com"
	<cristian.marussi@arm.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Aisheng Dong <aisheng.dong@nxp.com>, Nitin Garg
	<nitin.garg_3@nxp.com>, Ranjani Vaidyanathan <ranjani.vaidyanathan@nxp.com>,
	Ye Li <ye.li@nxp.com>
Subject: RE: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Topic: [PATCH] pinctrl: scmi: support i.MX OEM pin configuration type
Thread-Index: AQHaZicCkH+tvBnis0Gt2w9aePsLUbEhYGwAgBU2HXA=
Date: Thu, 14 Mar 2024 02:01:18 +0000
Message-ID:
 <DU0PR04MB94176F24A0C11C1A8C4B35D288292@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240223071557.2681316-1-peng.fan@oss.nxp.com>
 <CACRpkdYX1CtmOkDhyfCAcbY2yHHfjjRhTg0r=sW3iA6dvxvmdw@mail.gmail.com>
In-Reply-To:
 <CACRpkdYX1CtmOkDhyfCAcbY2yHHfjjRhTg0r=sW3iA6dvxvmdw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|VE1PR04MB7376:EE_
x-ms-office365-filtering-correlation-id: c8f2946b-8f73-4161-b816-08dc43caa379
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 tyfQKhDIueLv4X/e1xOZRIielB4oJVJUpyGTY91gesmA/HRHunkPD6wbtiYaHRbYHQ/ztqKnoxCFK3iYCxkkUNSJRsCd0BtanFjGfl5VIhTSOq/H2YpAxFHjObcBjmyJu1ymd+mu7+BbJh1PnfviPoL8gDBfp2mPF8Zu3zXh0dMYVcPQAQtl1uqMQP885a2yG0HSgoMRIzGsym/1WC2OWYSLr/VQSvsK/207rjyokNyS48RsluSZKBoY5c0lyXVbJ9VFgghEKf1WaTeNUuhyWw+U7Pt0NLbzdW/aJHtsxACCvf0hBec53U4LNUoSxYtfPWLlKXSJPU8nNK1wKDWRRazQjBYZayTrIGRKUcNLMv4tjXahU9F+IOptme8wd/V3leohgLlZmm3i2ctbT34MRoCbknwlxX3gwqT7xuotDN75f+MlVunJ5w4pnEywHtIHkKeTqy7dd0sg01wlbWsS9MUKyy2EEtgRHOOX0tn4rKnpmWo8nG+SQic6BgSuleA2PAnJIdhotiFZS+6XD9d9/bsN8RVBpLujVyx4YoWhgwNcjs+C4Dgx9e9+0GhnK7Uea+n/4NqoOviDfv3wTi02iw8JHOTnF83y19nQipq6mlGQ7/ZDuVbJAiB4eJEuPa0qDL977RQVxATpAbdNI5qIy/SG+6BTfT6mVY2ifCM4nMoKrbHXn4wSbSnjVwBFDuRt5P3YV3qFPNer8lz0qaSqRA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cm9POFd3cWVOdUFuSlR0UDFJcGgxem5qTThWNjVEbHVnQ1dYeGdacWhpZXpq?=
 =?utf-8?B?NTJidFgxSm1xQzUyaXlwMG53Wkc3Y3BSTTdOdzFZeHY5S29wb2RtZit0UUVH?=
 =?utf-8?B?TVFoU3RZaDdMcGc0MXhnSEZTbldTR3RYNnBBMk9PZnpHUlVhUHNXcEJBTGRq?=
 =?utf-8?B?TlBGL0N1blJDU1pBUHltQXNoWFpoYjZQWVhNNnVocTRBZzQvUHlpZVlpL3dD?=
 =?utf-8?B?LzRrZDhXdFhwQUw4Y2dyd0J0Zlkzc3FYZHl3eFFZMFJuQ3NPTXRVYnJZTWNx?=
 =?utf-8?B?SEs5TUgrZjY3RFJJQmNIMDRkbUNTSU54TVBvK2twbkNTeWZYdXU0allEaytL?=
 =?utf-8?B?YlNJNGJEK1lTT2hIOTRSZkZpOTk1ZDM3UEFTY2Z2UmZjWkRrMFpVRXBVbUxp?=
 =?utf-8?B?SGdmZmwrd01xZzVOUWxTQXpycXNuU1B0QmUwMkd4NW9QZHEwUEhCOFE3aWhC?=
 =?utf-8?B?ZmVoRmpiZmNPbk16NmRxVFhxcmtBTy9qTVdyaW95NE5JUnhiK3ROY2dJMk5T?=
 =?utf-8?B?akZCcWlUOGUwT3BQOVdmQlRxSmw3NkpqaEhhRjRvb25UYzZ5MWpHQXJLREZN?=
 =?utf-8?B?TEVZU2FQTk4rRERLb2EybTNuOW5MRnNnOEFpOElqdUZDeE5KTjhIZXNIMFlM?=
 =?utf-8?B?YU9HZ0E1eUt2YTg2eTdRNXJudXZic0dyTXZCeW9HcGJjVjJqMmdSbHFjRm1T?=
 =?utf-8?B?TnhVVkhBQ0VXQjhIS2srcnFUd3V1Q2lvVUhvS0JQczU5Sk1wNGd5anFIa2xs?=
 =?utf-8?B?aFhXanFwS2VTN1FBdFQzTnZnODBvLzl1K0RkVFpTMjZMRUNaQWVHV0Z3emha?=
 =?utf-8?B?WjUycmdMY2VnUjljZFFNOFVlb0lxVzlvVStTL3M5RjR5MFNkR1MweHhsNDR3?=
 =?utf-8?B?OElFUWx2YlZFbWFzREo1M0d1L1F4NHhpeE05K1puWFVEWk9ucTNvRWNlR2I3?=
 =?utf-8?B?dDhjQXV0WERtZDdJT3VvNUh3Tm0xOE9LUEVsOGZGNXZ0akFFMEE3dzhDWHlJ?=
 =?utf-8?B?SVlVR1hSM2p0c1ZjSGtnRW5aSlphNnNPNCt5TUFzRlU5S2Zia0s5M1ZYdjBH?=
 =?utf-8?B?SXpENkNJWDU4VGdTU1VXeTdiSkx4bmVxbWJJbjJ3T0oxMnU2d0dlSVhVUHdw?=
 =?utf-8?B?RWJwcVlHWDRaTjdBRWtqRW5IREdkMlNObDQ0TGk2SU5MaVJuTEl5TnBZTFRG?=
 =?utf-8?B?K3l5TFBaNFVvNERpZktMamhnOXV4RUx1WU1mcjZCcWY0RWNkU1IveXVxZmNq?=
 =?utf-8?B?TFZWdnhaZkU0MDJCOU9rZFphcEw2aGdCSjJrSFpwZGhhRWhKeTF2ZWZyaSsz?=
 =?utf-8?B?ektqYThSMTR0M05Tb0RCWm9jYTMzY1psSnFXZ2FjODU3VnlxZXVPMlZIRGt0?=
 =?utf-8?B?R3VRcDFiY29yRTYyb1VzL2M4SXJJdTgyQVA1ZE5DT2dCZXhnNHZiVGlGc20z?=
 =?utf-8?B?ZEdIODRka0lldkc0WXFmMFA1c0FoaC9wSWNLUFVmWHFaR2RBelhZa3R6OWY5?=
 =?utf-8?B?bFU0NjdUSkk3UFRHTHJFeVhRY2pVM2NiZFhOVjFiNEdxT0k0dmpaVXVrNVc0?=
 =?utf-8?B?Mm1xTE5ZRmRUakUyT3hLTkdtVEYxTHlSYmt6b3JPQkhCbER3THhHbG1WZ3ZD?=
 =?utf-8?B?R2twNFdBZzhMWUNYRzgyZE40Sm1VZE9Tdzl2ZUFpa0RjSG1ObmM4S040SFhZ?=
 =?utf-8?B?QzVreHJUTGVmRlVOVTB1ZXFlYzBzb2dvSDkyZkNQVWFlV2ZEU3RRSVBER2g2?=
 =?utf-8?B?M0F4ZldMdnQrNkkrOXdHdjRHbGxHYXoxV2h3YmhIc1pvWUhCQkM4QXVJVmNk?=
 =?utf-8?B?ZGRGS3hNMmVOQzl1TmM2QkdzTGIyeDg0ZHpsTFpZZGFxUkJ1cVk5OE5KSDVF?=
 =?utf-8?B?K3pzTkIrYUQxSXN0SnFkYUhBSjliREc5OTJHc3hoTkNrSW1ta3VZT2NXTHdV?=
 =?utf-8?B?bTZ1WlhCeVJKd2NSRExpeThQWHgvbmdwcDRMWUU1S29MaTlOZXFhRGNEYzlr?=
 =?utf-8?B?WW91Ky9DTVZEbEhaSVVKeThpUk1sTmxRalZ4bWNoU3N0SlJkSUwxV2lOaDJz?=
 =?utf-8?B?U3lGUEU4UDE0UjhpcVF2LzJGQWlqQmlUWFZHVjQ0YjZIdGJNb0JTR29JalRS?=
 =?utf-8?Q?+Xvg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c8f2946b-8f73-4161-b816-08dc43caa379
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2024 02:01:18.4447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ClhrFZedFhv4uSLiYG9ALIjfdlZQIyjLe0Lnz9T8xF3xHZuM/9gok5Pt9rUY6fhnDLDL3EHVRrz67A8aJ0puhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7376

SGkgTGludXMsDQoNClNvcnJ5IGZvciBsYXRlIHJlcGx5Lg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0hdIHBpbmN0cmw6IHNjbWk6IHN1cHBvcnQgaS5NWCBPRU0gcGluIGNvbmZpZ3VyYXRpb24gdHlw
ZQ0KPiANCj4gT24gRnJpLCBGZWIgMjMsIDIwMjQgYXQgODowN+KAr0FNIFBlbmcgRmFuIChPU1Mp
IDxwZW5nLmZhbkBvc3MubnhwLmNvbT4NCj4gd3JvdGU6DQo+IA0KPiA+IEZyb206IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+DQo+ID4gaS5NWDk1IFN5c3RlbSBNYW5hZ2VyIEZXIHN1
cHBvcnRzIFNDTUkgUElOQ1RSTCBwcm90b2NvbCwgYnV0IHVzZXMNCj4gT0VNDQo+ID4gUGluIENv
bmZpZ3VyYXRpb24gdHlwZSwgc28gZXh0ZW5kIHRoZSBkcml2ZXIgdG8gc3VwcG9ydCBjdXN0b20g
cGFyYW1zLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5j
b20+DQo+IA0KPiBJIGNhbid0IHJlYWxseSBzYXkgbXVjaCBhYm91dCB0aGlzIGFzIHBpbmN0cmwg
bWFpbnRhaW5lciBvdGhlciB0aGFuIHRoYXQgaXQNCj4gbWFrZXMgbWUgYSBiaXQgdW5oYXBweSB0
aGF0IGkuTVg5NSBpcyBub3QgdXNpbmcgdGhlICJkZWZhdWx0Ig0KPiBTQ01JIHBpbmN0cmwgYmlu
ZGluZ3MuDQoNClNvcnJ5IGFib3V0IHRoYXQuIEkgY2hlY2sgd2l0aCBvdXIgU0NNSSBmaXJtd2Fy
ZSBvd25lciwgd2UgY291bGQNCm5vdCBhZmZvcmQgdGhlIG1lbW9yeSBzaXplLCBpdCB3b3VsZCBy
ZXF1aXJlIGEgbWFzc2l2ZSBhbW91bnQgb2YNCmRhdGEgaW4gYXJyYXlzIHRvIG1hdGNoIHBpbnMg
d2l0aCBmdW5jdGlvbnMgYW5kIHRoZW4gZmlndXJlIG91dCB0aGUNCm11eCB2YWx1ZSBmb3IgdGhh
dCBwaW4NCj4gDQo+IElmIHRoZSBzcGVjIGFsbG93cyBmb3IgdGhpcywgYW5kIE5YUCBGcmVlc2Nh
bGUgaXMgdXNpbmcgaXQsIEkgd2lsbCBqdXN0IGhhdmUgdG8NCj4gYWNjZXB0IGl0Lg0KDQpJbiB0
aGUgc3BlYywgVGFibGUgMjQgUGluIENvbmZpZ3VyYXRpb24gVHlwZSBhbmQgRW51bWVyYXRpb25z
LCAxOTIgLTI1NQ0KaXMgZm9yIE9FTSBzcGVjaWZpYyB1bml0cw0KDQo+IA0KPiBJdCBmZWVscyBs
aWtlIHRoYXQncyB0aGUgb2xkIE5YUCBGcmVlc2NhbGUgcGluIGNvbnRyb2xsZXIgbGl2aW5nIG9u
IGp1c3QgaGlkZGVuDQo+IGJlaGluZCBTQ01JLCBzbyBwb3RlbnRpYWxseSBpdCBzaG91bGQgYWxz
byBzaGFyZSBjb2RlIHdpdGggdGhlIG9sZCBpLk1YIHBpbg0KPiBjb250cm9sbGVyIGRyaXZlci4g
QnV0IEkgdGhpbmsgeW91IHdyb3RlIHBhcnQgb2YgdGhhdCBkcml2ZXIgc28geW91IHdvdWxkIGJl
IHRoZQ0KPiBiZXN0IHRvIGFzayBhYm91dCB0aGF0IGluIGFueSBjYXNlIEkgdGhpbms/DQoNClRo
ZSBzY21pIGlteCBleHRlbnNpb24gY29kZSBub3QgYWJsZSB0byBzaGFyZSBjb2RlIHdpdGggdGhl
IG5vbi1zY21pIGNvZGUsDQpUaGUgc2NtaSBwcm90b2NvbCByZXF1aXJlcyBjb25maWcgdHlwZSBh
bmQgY29uZmlnIHZhbHVlLCBzbyB3ZSBuZWVkIG5ldw0Kd2F5IHRvIHBhY2sgdGhlIGRhdGEuDQoN
ClRoYW5rcywNClBlbmcuDQogDQo+IA0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0K

