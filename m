Return-Path: <linux-kernel+bounces-96690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1DE876009
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:47:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFC71C227A6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 08:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A341331759;
	Fri,  8 Mar 2024 08:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cmbwjc6p"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2079.outbound.protection.outlook.com [40.107.6.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9A8208B4;
	Fri,  8 Mar 2024 08:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709887598; cv=fail; b=lqpE8PsPl2zxcMMib7X/f9qkx9h7Fj/qgWB4rJI0850FndkHqDvw2U/izwMMA+m2toAdqHgmFJGLo3/R04qLnV912MwmG/KUV4jvNaNtRWiTX7Qu91VIKtKXDFKuzgGHDJ2I2rautKlTl1zgS5gft2Ullvqc3orV9qFFlly1Bhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709887598; c=relaxed/simple;
	bh=l/vW8SqfvsRY2Fsdbya68njewDeAKIS1N6njwYtvjgM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgqqzzNW7RxsF6wxd8x8CQXgKYYNOeSWd/cll7Krs0JHRPnwiNYiRQgXi4qicrhBGC6607FYetxS7DE7MKL2nmGq1QMTDP3v28orCn5EQUX15ja4qT6AoahwotXKjlD67dnlrcnjdRsJsQ924abhP0eUSpgZdmi8VKaRj3KrEAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cmbwjc6p; arc=fail smtp.client-ip=40.107.6.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEQLboBKWRqxBHWePIEN/1bQR+uxBd6yS9Y9dZncL4ezuYZJ5NtytXYKzBinozQ6F7VPhEVd/HFZGXgX/3vMQ0MfdgOXTvBw3UjGC0P8ndlC4zAzKLlwHK0rzBGJH2790RpMVpYKYqOwJRatxVncjD8X9cFwrLooDxODx8TxsqPiDc5vtl2aFkhTBUrgKIhaz6RxnG0QxwtI5uLnPGE4bLcE/lk4z67PjfPBd75IlVIOp9UTcuwdPUQkCfU3EKCXI/Ydo7fUP4mUagFAW49ko2dLtQse4AimDASUWA79I81wXCNXS/R9EDZSPhUzfXpOX0leXJkr0lYCe95MB1zUeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/vW8SqfvsRY2Fsdbya68njewDeAKIS1N6njwYtvjgM=;
 b=WphiFBXN8EsdG2Ox9EO/UBv1UcINch2+oRD3cvixF5yk0pEyj/Lr+is+6Naed9ouZDLlWN4FBL0s1VnoYu6NNE1C9q8jw2hCuw9IPITwXkJMmvmLjVG2WO2zyH2dJYRfwMtMowo8xZju9L9ZVipmSB6KiJfbWVh/QUxRxTMyEtkXdNhDyPA1uYUuvejiEEen1w6SbI/QHGh+Cd0UpALfQDTrrCdYdvpPPwtGb8FnIkqPHO3ZGNKjdnzoaybK2eQqEgStLkm2+bwxRzTf7TQxiU11jUh73gkw7+PQ0USLiLP9AwusrZvvP0AeOaW4Ad6UlY44aVO2q4ypxKrgW3SJUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/vW8SqfvsRY2Fsdbya68njewDeAKIS1N6njwYtvjgM=;
 b=cmbwjc6pLTpXt8+1nuQAxieOZ2lRbGxjXTrLx7jU9wIFW0AzvobsgclyiRlk1l3yoM6O7p78ynU1CBa8RiZoIysWpcaixWx/SZ2oUz+jedBuSXP2+b/GNWjNTppS9K2mBUTlwy4ucUu/Nto0JI/TWRyDmDWvrMQ3pMLPtb4iKvY=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PAXPR04MB9707.eurprd04.prod.outlook.com (2603:10a6:102:24d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.31; Fri, 8 Mar
 2024 08:46:33 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Fri, 8 Mar 2024
 08:46:33 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>
CC: "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "peter.chen@kernel.org"
	<peter.chen@kernel.org>, Jun Li <jun.li@nxp.com>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXT] Re: [PATCH v7 05/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Topic: [EXT] Re: [PATCH v7 05/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 add restrictions for reg, interrupts, clock and clock-names properties
Thread-Index: AQHaajmFtr8IuedvJEyC/C5NSwmdObEhbysAgAwlWUA=
Date: Fri, 8 Mar 2024 08:46:33 +0000
Message-ID:
 <DU2PR04MB88229479088989ECABB8968E8C272@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-5-xu.yang_2@nxp.com>
 <6bc065ac-81e1-47ab-9e3f-d03283e2a207@linaro.org>
In-Reply-To: <6bc065ac-81e1-47ab-9e3f-d03283e2a207@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|PAXPR04MB9707:EE_
x-ms-office365-filtering-correlation-id: 8402e8bd-35af-4608-5a14-08dc3f4c4201
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Edce4XeOxfqEqLugJ5tgRmDS/xenNyuY40mb/7AhfpuxRDDYCwILuTbaiAWgiN2E+ksNPYQosqw1atEYD47wNcxffgBtYEElH254bE7LEEO0xIYKORFJFoecvrTyzpwGGLlqXKt5CnHT8IOCtu7vrVIUd/O9a4WmHMDueOdwTo/TId+XibdrxgZQiTbNhg5oaa9hnPKayvwlAQ/NMelJTelQyDE6zebPI3iELpvHI3GnxQ3IjvqzF3A6D91AE2UCQf/xxhthXFF66g4VyX9meLX9qy9tIueTK/OHTRxkAAbfUFSlSAGaLcRKjrc4FObI5n4cQXZtPkmM0A/Wmx/hngih1NJCgcVhU6RbGYd3+aG6CfANP3mo9JB9hhuirBvaVWHUYLkgOAIpIDDGspjusxi4axWNIPhS1EpeHvP3ghnIci2/kpwMB5/ZP9bJlZElZxelprOmYC7s1tLe8dj2FBDHL4BV9FSenpKSgDzGcsS59342m+1X+vqWak0DY3IzQmDZn63A49tJs8D1NN6LTUZ61eK7lB7JuiZnLs/VzhYTDrgW6aGMPAx/r7jwwKxRkaXU1VOSylW+poaC4mi/ZTy3YL5/bC0ZKPCUmsjGj2xrCMbKXN45pOyFn9omSasRNRSwELtvKpXm9ZPiphBYW6RDAJWATb1VJVlg3o0wYsxubEeC+35zknwQhTEmyC6ogxbzcCxfyzhOC6sRNInzDfY9z5qwy4djz7wZg1YYKAQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UFJmZnEvSFRRSXR2UUZtWkJGbmhHWTJsNWVrV3RMSVg5bkxndVNSbjRUTkRr?=
 =?utf-8?B?SmlNNkpaQ2VlNUUvcHpFQytOM0oxREtPYmZuMVJJK29Qd2NvdUs3SWQ4WDZT?=
 =?utf-8?B?cXJnMDVrU3FtalVxcFM2ZHh5OFR3elorQU1zemNMK3BHSk9LRm83VGFvRCtR?=
 =?utf-8?B?OE5zSlh2alBsN1c2UXZyeVdaS2VqcTV0MDI1YUFuUStHSzZrb2ZZV1pDWGJM?=
 =?utf-8?B?Y3U3dFRTRTA2QmcraHA0Tld6Z2pJVHpVUlp4djIxdlNnOVE3RVJMYXhKVTRO?=
 =?utf-8?B?TFMxWWp2Y3V5YVhtTllMWlluNGt6YlJXN2dpMDJPU09kaStWWmIvNjlmL2tH?=
 =?utf-8?B?VXZZcFQ2SzFkcmJtbTM5ZHhpOXkreVFWMG5EN0UwelZ2V2dEdHI2L3FmNjhB?=
 =?utf-8?B?MWpMc3V4Q0JOdlN2NTkxRm9QQ0J4dTl4RXgzT1BDQVdCWVljaHdCZ1BuMTk0?=
 =?utf-8?B?Sk0vdHU0SHNOaWM5ZzE5WS9FY3Z0MkpqTkVtdk5QNjh2NzlsU0dOZURndXVP?=
 =?utf-8?B?ZDJlYnRLdllxR0NIaDBOd2xZZHlqNHpwOE5MVDg1SHFrRFhYaTVFRE5hcnNp?=
 =?utf-8?B?dzFvRE1SbU1JeTBqaXZoVWFWdnlIVFR0N1VvaDRuOHdWL2xieGVnR1Y1dkU3?=
 =?utf-8?B?UWhNR3p3VW03cTRVTE8wQjNMcnB0ZzFlNHBveDRjcCt2UkpxS0cxeTJFZEkz?=
 =?utf-8?B?ZVdQSnVDK3NmR2pLSHBoeElQS0RwNVEvdElUQjR5MmczL0RLN1FwaURCWms1?=
 =?utf-8?B?bXR0RFRyNXMzUkk3VHY5WWlJeG96ckI0dTZKZ0duaU1mdHllakw5Z01USXV0?=
 =?utf-8?B?b2tOSUJqcjhKVzBpYUwyU3FVdzFoUFBOblVhSnJNbnB2WnNhNis2K3V1OFJz?=
 =?utf-8?B?VWlEeFNDVUhzL2NqdXNXZnUwaW9pOGd0MTRpQWV5cmp4eFlWbVlnK2ZSZ216?=
 =?utf-8?B?SUhMQVhRQzJmYnQzSG8wdnZaL0g3bktVdG1NcW9OWWJoZWVkTExiSVl5MUdr?=
 =?utf-8?B?RERiYTExMEJ0WUl3bC9qQXZ6OUZLRURIWEhQd3FGYkNGZ1pZT05YZ0d1NHp5?=
 =?utf-8?B?WVI1MUR6RU1NYUhiTkJDbDVMbm55eE9EVUlVT3dlR0F4T0Vkd1g5OXI0Q0lW?=
 =?utf-8?B?ZjVkRjhOZy9Nc2NDcXVhTXk5N0hFQTArMEFWMENQbGNaMnpmVWR5VjVsZ3E0?=
 =?utf-8?B?Njg3U0NlQksycDM5YnZFdDl2am5ta2JyZWhQZjdodFVsaFVVdU5QaXBMdmY5?=
 =?utf-8?B?N0wzRnZSZ1R2bUNJb0dHWGdGL0ptZitVaEpVMEVKWTZSblpJbHdmd0Nld3dv?=
 =?utf-8?B?RDEvZjJ2eTFxbHFVU3dpbTlmUDg5aGRvZklhdER3ZFV0SnFSa0s2MXdjRjls?=
 =?utf-8?B?eDFTb0h4RGJsYUxuNlA5OXZCKzFWM25wcEY5Tnc5MUlvUGZNM1gvQkxnYlBR?=
 =?utf-8?B?eDhCMHU5aERWYnErWjQzdHh1OThKVE5UaDNlRlJCM3l2dGcyMTc0WTBUTjhS?=
 =?utf-8?B?Sm5LUHZkbGR2ZmI0UGZaK0lUY0JvUEJnaXpGQTNsSGhka1FJZUs4RUcxRjA0?=
 =?utf-8?B?cUx5dWNmMm45VGF2Yk1BbXBnd2IrRUkzMTY3QWlQVC94RlNZeU1ka245WmFn?=
 =?utf-8?B?bUQvR1RjR3FXelJzc2hHR0grUXVObEFKY01ObVAzRStFaDdXbGRQK0ZuUmJL?=
 =?utf-8?B?Yll0SkRleWRZSGJ5Rkp5TUdyRlJQVnQvZ2xDaFllMTBlOHIxRU1tTnNTQ2li?=
 =?utf-8?B?a2VBbHFCM0pHVU5teWdNOWgyREJCcm8wWkZ1d2I5UDJHelpobFl5YXdBOURy?=
 =?utf-8?B?UXhQSng3R29yUHNoTGVTbGt0ajJRNU9nbXM0RVFVbVNhbTVjcnRDQ2N1VHZu?=
 =?utf-8?B?WUROeTVGQW81MGJqSWhNa2xwYWF0aHRPVnNjcS9vbGVha0c4STR1em15eDZN?=
 =?utf-8?B?czRmd1Zla0x1SjlVZUdVNC9ickJmQTE0R1A1YUFOSjNzMG5nOVlpNENMYW9z?=
 =?utf-8?B?Y01TWGljcTRneTdXeWVBNEd2QnJqRUZrVUdvZjBNOG85NktMK005RHY0MFFn?=
 =?utf-8?B?K0duZDRxSUtLaWIwQWIvQzJLWEp1cW81S0pJK0pzOWI4eXU1bTRzNnNlWGw2?=
 =?utf-8?Q?m+p0=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402e8bd-35af-4608-5a14-08dc3f4c4201
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 08:46:33.6959
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lbQP+5N+Dy6EANcnvQpx0JDL/P+cTH23zM5r7AkMgBLs5Ork4emOXWn7ruF+ROkB/aqaMAP7Mmas2gNDiJD81A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9707

DQo+IA0KPiANCj4gT24gMjgvMDIvMjAyNCAxMjoyOSwgWHUgWWFuZyB3cm90ZToNCj4gPiBBZGQg
cmVzdHJpY3Rpb25zIGZvciByZWcsIGludGVycnVwdHMsIGNsb2NrIGFuZCBjbG9jay1uYW1lcyBw
cm9wZXJ0aWVzDQo+ID4gZm9yIGlteCBTb2NzLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWHUg
WWFuZyA8eHUueWFuZ18yQG54cC5jb20+DQo+ID4NCj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY0
Og0KPiA+ICAtIG5ldyBwYXRjaCBzaW5jZSB2MydzIGRpc2N1c3Npb24NCj4gPiAgLSBzcGxpdCB0
aGUgcmVnLCBpbnRlcnJ1cHRzLCBjbG9jayBhbmQgY2xvY2stbmFtZXMgcHJvcGVydGllcyBpbnRv
DQo+ID4gICAgY29tbW9uIHBhcnQgYW5kIGRldmljZS1zcGVjaWZpYw0KPiA+IENoYW5nZXMgaW4g
djU6DQo+ID4gIC0ga2VlcCBjb21tb24gcHJvcGVydHkgdW5jaGFuZ2VkDQo+ID4gIC0gbWFrZSBp
Zi10aGVuIG1vcmUgcmVhZGFibGUNCj4gPiAgLSByZW1vdmUgbm9uIGlteCBwYXJ0DQo+ID4gQ2hh
bmdlcyBpbiB2NjoNCj4gPiAgLSBuZXcgcGF0Y2ggYmFzZWQgb24gY2ktaGRyYy11c2IyLWlteC55
YW1sDQo+ID4gQ2hhbmdlcyBpbiB2NzoNCj4gPiAgLSBubyBjaGFuZ2VzDQo+ID4gLS0tDQo+ID4g
IC4uLi9iaW5kaW5ncy91c2IvY2ktaGRyYy11c2IyLWlteC55YW1sICAgICAgICB8IDUyICsrKysr
KysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKykNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2NpLWhkcmMtdXNiMi1pbXgueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvY2ktaGRyYy11c2IyLWlteC55YW1sDQo+ID4gaW5kZXggNTA0OTRjZTA2ZDA3Li5h
NDczMGEyMzkzZTYgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9jaS1oZHJjLXVzYjItaW14LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi1pbXgueWFtbA0KPiA+IEBAIC00
OSw2ICs0OSwxMiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgLSBjb25zdDogZnNsLGlt
eDZ1bC11c2INCj4gPiAgICAgICAgICAgIC0gY29uc3Q6IGZzbCxpbXgyNy11c2INCj4gPg0KPiA+
ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6
DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiANCj4gVGhpcyBraW5kIG9mIHByb3ZlcyB0aGF0IHlv
dXIgcHJldmlvdXMgcGF0Y2ggZG9lcyBub3QgbWFrZSBzZW5zZS4gV2h5DQo+IGNvbW1vbiBJTVgg
c2NoZW1hIGFsbG93cyB0d28gaXRlbXMsIGJ1dCBJTVggYWxsb3dzIG9ubHkgb25lPyBTbyB0aGUN
Cj4gY29tbW9uIGlzIG5vdCBvbmx5IGZvciBJTVgsIHJpZ2h0Pw0KDQpZZXMsIHRoZSBjb21tb24g
eWFtbCBpcyBub3Qgb25seSBmb3IgSU1YLiBJbiBuZXh0IHZlcnNpb24sIHRoZSBvbGQgY2ktaGRy
Yy11c2IyLnlhbWwNCndpbGwgYWxzbyByZWZlciB0byBjaGlwaWRlYSx1c2IyLWNvbW1vbi55YW1s
LiBTbyBjaGlwaWRlYSx1c2IyLWlteC55YW1sIG5lZWRzIHRvDQpjb25zdHJhaW4gdGhlc2UgcHJv
cGVydGllcy4NCg0KVGhhbmtzLA0KWHUgWWFuZyANCg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBL
cnp5c3p0b2YNCg0K

