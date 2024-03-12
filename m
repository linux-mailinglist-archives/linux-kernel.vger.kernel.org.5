Return-Path: <linux-kernel+bounces-99893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 605F6878EE0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 07:38:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4618B21495
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 06:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4927446BD;
	Tue, 12 Mar 2024 06:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="cL+6GKh/"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E1F42A9E;
	Tue, 12 Mar 2024 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710225510; cv=fail; b=C7UYgQteoEoWb4F1LIO13bcgwOggTzy2J3ZcrmLC2OciYr5PixRooGq2lNs8mwRzenYktjUnamStLR51FDFnV29+ArQvkq+xSbKyvUp/TfpBEfc973sUy7kj6NuoJ3zM541mCL0MY9KVUtejhfLOEV6rn4IAe2fpv6SMCPhJlEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710225510; c=relaxed/simple;
	bh=Z2kyutkNWgxZKMMLZG1y8h91oBmsbOzESf+l5TtiETU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aXyMLHc0yW6AF0lbPRBv9zj9PcdXNGBjFwyMIikPOt4oK6tcb8qnOLsP1kUHJWDjUEXTdp3OuV0xO1VPouWYl1Y+lP8vNbugOJk0pU+wPloJMSmiK7Yfmu5vI7Dp7JXtMHXpMADDkYEaxsetUU93HA732vSy5kyWXE79Vm/B5TY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=cL+6GKh/; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EnOewFn4P8FowhKoq6WSYIkdtln6NhjovmBJhu/kK4jxZyRNtuTcMm3G/9r6qvIa9tGEOuhM2d6Zd90bYKSekxUHmL4n7Ztl54aBA5b7h6UzY43miodGLukSLpLZDbyOd9MilAR+o4tZnFO1imHLJDIo4F+VSjWsFQD874eL0M18uIbx0MEjhitiFpqNDNFPzKnWWuDjEjvMNZmWpqslGrykatGJxvoiZHtB/UryERWxG0Gkm79g6YxvCnt2wW83F/Hsd2utkidIor9O0HSGxJlIGAFnGpAY2B9rEDGClOTid6bCZ/2kMNeRqn+KdNGwunGcKJ7ugtjJHCE0pfimaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z2kyutkNWgxZKMMLZG1y8h91oBmsbOzESf+l5TtiETU=;
 b=HCK2w5NeKAcfisyXDRImm1KPSCQxfbbegYVk9m9SvRgy6aa3IyOlcIjqfxIRbkpNfJeGxMEBVkjxfu0c8M/VC4aeNgNpppwnho0J2satGN7o6S6KNFP3X9g1LwOiuNNT8AuOZdBqXwygvtUH20r8oQnaojkED/n2J5V+RO7oVgH2/4v9OTk3XOiG40X1ycpIZDVta2opiWWN1fumQKFvt8lelqXZQr2BmuMVqvRcQ7Iac/ICcJS1OvjGudNts/gBIWSnLLdRVi4hehYHQ/6fACi+F0sWZT952WOK95fp+CK/zooyVaHcLlDcQkmWjbCgVwwdEl5zK2ihCJZmmXB4lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z2kyutkNWgxZKMMLZG1y8h91oBmsbOzESf+l5TtiETU=;
 b=cL+6GKh/tGGE8hOVfMMM+3sv4oyUdh0gLXF2kc5a/y4o/DLi0ixH7FNBhxud/iz3WjeDqYx24vzYnZqaa4JNYeoqvadahDL2AcNlWYbs0u8U2pmI6sEjTz/ZATtHx4SxcqaIZdk0Xbg47qYEx3QGIs4mDMlGGrbn3mBB6izn1ts=
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8934.eurprd04.prod.outlook.com (2603:10a6:10:2e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.36; Tue, 12 Mar
 2024 06:38:24 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7362.035; Tue, 12 Mar 2024
 06:38:24 +0000
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
Subject: RE: [EXT] Re: [PATCH v7 07/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 remove fsl,anatop property
Thread-Topic: [EXT] Re: [PATCH v7 07/11] dt-bindings: usb: ci-hdrc-usb2-imx:
 remove fsl,anatop property
Thread-Index: AQHaajmLJLcsQfIKqUCdzFhUQUq+f7Ehb9aAgBJLMsA=
Date: Tue, 12 Mar 2024 06:38:24 +0000
Message-ID:
 <DU2PR04MB8822DBDC83FA7BF04FD271558C2B2@DU2PR04MB8822.eurprd04.prod.outlook.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
 <20240228113004.918205-7-xu.yang_2@nxp.com>
 <32a5605a-c810-4b3d-bb72-4d413d9f9bb9@linaro.org>
In-Reply-To: <32a5605a-c810-4b3d-bb72-4d413d9f9bb9@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU2PR04MB8822:EE_|DU2PR04MB8934:EE_
x-ms-office365-filtering-correlation-id: 7253e11e-323d-43f7-7361-08dc425f0487
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KjmgesrXhrG54Iv+e1Qkes8rr68vktYX3nLmsrFL7Q55dxqF0wdZslTZ1nxq/Q2HzbH1ITpj+HoCxSGxD/7uRJioB5iQ44VuYsRsKWOH/LoPvrBJ9/IJpdaqTbxXKjn48O3PcUd7QDruG4ReAkOtP8Vuo3++do6Nl/bl8RvJLTAPiWIrENNJmraiQ2wB3WRCInBC/AAg/dT8+W5tBsjsEhLHFKN1hVmCqX43QfFUAtyiFgktl7i5T4M3d6uC7bfm/6ZdK+mwmz9QQAh03wOIxTQFqNYXxPcLzWBKOkPYuuvrZcLjLaOwm3IhD98oxFF7OdVGQMzAAzVfg2V+Kjxfa80K90B0zXMT2wPcB83tgDPPgE7TX4wc6BHPVhsDaSXVPux5K2km991WKnP3nOd5agqRNwWc/m/ejXvs+IA6p7cgOuXYMamo4JVG7B0GPxawehOA8QV+/7FMxqNqJQt5Elsj0vFdvyoeyoexKRryR/clsfzYqAvnO3uRrqhY0ATDu4vV3Gv0/rE0tq3dUp+J+SPAa81+NxIpGsC4hragT6uPsgRj6Sl+411kd7PE2iDiw5g8bGUqKXBVOLgssjyYIMdqXUy8zJ6B4QsYVrSqo88DDM99PXOePUgjwwYM8Ht4sCTvzO2FHWfaq3lcX0mjkyZ0gTaWtBpIj0lHKDihJ+LFpXjmqy+HH0ZzKSQkNCXnakvhs9AXYrAmTqFg31cJWa/BHmQJGwWPbzPUpbuihRc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azlobGtQRWRMRlVPZk95Qzh0SGlpZUdsenRTTnZvUUlyMkdMNnVIZ2dQN0Yz?=
 =?utf-8?B?Zytxa2VvUjdsaXluQk90Zy9NSUl5SzZOZW5mWG5EbHpvVVNHUWxwdmo0MVgy?=
 =?utf-8?B?enczSFNPVHV1VE9kRTF0b1dNRlZWbW1YTVRVOVVrYTBtS2lKUEROMGlqeFBs?=
 =?utf-8?B?SzNjWXdXdDlsMVZJUFk0eUQ5VW1lcURNb2ROaW56KzVFNEY0RWJOYXVIQjUv?=
 =?utf-8?B?R2F3VW50QjN0S0RJUjNYUDNWZlo5cC9iUnFoWkE1ZmlHdDA3Zld6MEdJZTFP?=
 =?utf-8?B?cG45eFp4VXo4RWdMSUg4NUtTUUd1aCtHVmFzbEVpRXdiRXA5U2VtNnNqM3Y4?=
 =?utf-8?B?dzlEZ2tMZU9tQzR1VFRleVNRR2dNcWxQWXZpaWZzaC9VdVFaenpxRDFQc3U1?=
 =?utf-8?B?Z2g0UWt4NVMzaWlabXNPbmtja25HS2J1blRLUkVPT0hHS0o2aEE2R3N5bjM4?=
 =?utf-8?B?b0gzUlpGQ241V1BrNTkzNU9LWEpaSlVTcURUVXFrTHIyV05KamZkNjhBdGJy?=
 =?utf-8?B?VDFDRC92QjRXWm56dFM5OXVWYjVpc2l0b3d1VkdmTEtSajVVUU5FNjRrdXdJ?=
 =?utf-8?B?amtUdERhdnBLUWlXSWZSWEpiWUZwZUNjQk9JeUdwTFVEYVd1Q1J2THJ4N0pR?=
 =?utf-8?B?TDV1dGZ2NkxSRy9idWRiWjlHaDdqM3lBKy9weHdlNzU3WGlrYm0ySlQvSDNi?=
 =?utf-8?B?RVNobEFZdFVuN0hvRlNYN0F1ZCtLOHNRMzhYNWN4VUNUTS82VDBFZ3EwUG1p?=
 =?utf-8?B?UnRISEJIWDQxNlI2aFBBZUhaTnlnczd4U2FFL1RTYkEwV2F3VmM2NlVuRTB3?=
 =?utf-8?B?TXpvaXA5eU4xRW4ybUtjZFkxS0ZPbm1NVk1LN3llSDdydW83blhadVhNQndP?=
 =?utf-8?B?b2xBYmUydUpMeDJERmdTSUtQWWJMNVhwNHNjMlFkNCtpaGtBYy9RdFh6aGFY?=
 =?utf-8?B?cXh4UUlDeWQ4VGFSYVVpeUphaEhqdVM4QkFoYXkvaGxDYkZOZml4ZVVRWVRq?=
 =?utf-8?B?R3hMK3J1elc0cS8ySkkxNXJxRTg5V29jbGdla1JGVVgrOXhSdG85akRCMlNY?=
 =?utf-8?B?Z3VEeFJiQndleWhCWlF5OFNuSHIySHV6UlJmejFKc2dKOS9uVmVKK3pMeVBl?=
 =?utf-8?B?SFNjaWN1TE5iNHVqc0szazBvaFMyS1VCVzJzaTUyK1hRV05hWmlxM21UMmxj?=
 =?utf-8?B?aEh3aitvZjlSaVFtSFRxaE50ZUNwMGRrRXVCei8rQWZrUVh5VGJxVGtWVWYv?=
 =?utf-8?B?VU55YTMzTGErM2EzMG52UkcwUkt0QU8vWllEK2UxK3ZmdUlhYVlycUZMYmhU?=
 =?utf-8?B?Z3NqZVIvbjdXVGg3NVNpQTlLSmY5UjJSTGZqUEpNdFUvV1pMUnVDak5Td1Nr?=
 =?utf-8?B?RU1tWmpKTW9RaWF6MHZ0TktCdnZ3MlRoUGpNTWdkRTVNRkgvZmZlNWpCU25X?=
 =?utf-8?B?QjY0bkFTVk8rVHgvZmU5RjFyazZDMzl0Ym9ONmtRYXFmeFBHaUxEV28xSlQ2?=
 =?utf-8?B?aEVYazdldThZblE4bFlyRjlYM2RDYTdkZUtZdmVtRlExVERyT0FXbU1yRGF5?=
 =?utf-8?B?N2pqZFJLUzRvc3pyTzZLMzRkTytQV215bks4ZTlCREpqUGV4eElmcS9DRWVi?=
 =?utf-8?B?ek9qblBSSWdnTlZGN09sRUEreU82RGgvNVM5eWxSakEwenFTRWJDYm12ckF1?=
 =?utf-8?B?elBCTEJ5U1pQSE9uWDJwcGx2V1pNMXl0aXNLSTAyaEJIb0JTQmovamRkYlBM?=
 =?utf-8?B?cXVNWXB1UlkyT3YxVkRudTh4THQrbnU1MFQ0MHQ4ZXB0QndRRnV4SUp5SE9S?=
 =?utf-8?B?UWRxQ0gxRWNIU25iSENublZPVnIzU0VSMGRLZHhFNVpKVWxMM1MyN3FtUkhB?=
 =?utf-8?B?dEg2TnkwbVplZm9oRWt6VmhKOXdEMGFqczVmRjMzNmdraGlWQkJmYlcxQi9Y?=
 =?utf-8?B?ek5KTVpuUTVoaEJUQ2FURDdxcnpKK0ViUGZHMS94TVE3bFRJSE51OTVJQys4?=
 =?utf-8?B?aFlZejRSUHlLTGVhTzRhLzFxTlpHSlNMSXIyUVA0THhmZTNhc0gwS3BKWHRk?=
 =?utf-8?B?bkJhWmpBaW4zallpbGFoV29EMWtGNktVaElCejZvT2pnV3oyY1pBcW5LamFs?=
 =?utf-8?Q?6nMg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7253e11e-323d-43f7-7361-08dc425f0487
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 06:38:24.4730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 891SQaSPTtoyzDVHBXYrbbcsEWruSs6HC0jE2VpUZuMjDQczKqfKliFUexo0HUdJ0T/CwWyLVOBPt4ZBcEv98A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8934

DQo+IA0KPiBPbiAyOC8wMi8yMDI0IDEyOjMwLCBYdSBZYW5nIHdyb3RlOg0KPiA+IFByb3BlcnR5
ICJmc2wsYW5hdG9wIiBpcyBuZWVkZWQgYnkgdXNiIHBoeSByYXRoZXIgdXNiIGNvbnRyb2xsZXIu
DQo+ID4gVGhpcyB3aWxsIHJlbW92ZSBpdCBmcm9tIGNpLWhkcmMtdXNiMi1pbXggc2NoZW1hLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogWHUgWWFuZyA8eHUueWFuZ18yQG54cC5jb20+DQo+ID4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY3Og0KPiA+ICAtIG5ldyBwYXRjaA0KPiA+IC0tLQ0K
PiA+ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi1p
bXgueWFtbCB8IDQgLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNi
L2NpLWhkcmMtdXNiMi1pbXgueWFtbA0KPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy91c2IvY2ktaGRyYy11c2IyLWlteC55YW1sDQo+ID4gaW5kZXggYTI5MzJhZjJjMDliLi4w
YTZlYmI0MjcxMzAgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3VzYi9jaS1oZHJjLXVzYjItaW14LnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvdXNiL2NpLWhkcmMtdXNiMi1pbXgueWFtbA0KPiA+IEBAIC03
NCwxMCArNzQsNiBAQCBwcm9wZXJ0aWVzOg0KPiA+ICAgICAgICAgICAgLSBkZXNjcmlwdGlvbjog
cGhhbmRsZSB0byB1c2JtaXNjIG5vZGUNCj4gPiAgICAgICAgICAgIC0gZGVzY3JpcHRpb246IGlu
ZGV4IG9mIHVzYiBjb250cm9sbGVyDQo+ID4NCj4gPiAtICBmc2wsYW5hdG9wOg0KPiA+IC0gICAg
ZGVzY3JpcHRpb246IHBoYW5kbGUgZm9yIHRoZSBhbmF0b3Agbm9kZS4NCj4gPiAtICAgICRyZWY6
IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3BoYW5kbGUNCj4gDQo+IFRoZW4gd2h5
IGRpZCB5b3UgY29weSBpdCBmcm9tIG9yaWdpbmFsIHNjaGVtYT8gSnVzdCByZW1vdmUgaXQgYmVm
b3JlIGFsbA0KPiB0aGlzIHdvcmsuDQo+IA0KPiBBZ2FpbjogRG8gbm90IGFkZCBsaW5lcyBpbiBv
bmUgcGF0Y2ggd2hpY2ggaW1tZWRpYXRlbHkgbGF0ZXIgYXJlIGJlaW5nDQo+IHJlbW92ZWQuIFN1
Y2ggcGF0Y2hzZXQgaGFzIG5vIGVmZmVjdCBhbmQgaXMgb25seSBjb25mdXNpbmcuIFRoaXMNCj4g
c3VnZ2VzdHMgeW91ciBvcmRlciBpcyBpbmNvcnJlY3QuDQoNCk9rYXkuIEkgZ2V0IGl0Lg0KDQpU
aGFua3MsDQpYdSBZYW5nDQoNCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg==

