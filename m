Return-Path: <linux-kernel+bounces-99752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76406878CAF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 03:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24083281CBE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 02:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17067494;
	Tue, 12 Mar 2024 02:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="TiMvZ23y"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2088.outbound.protection.outlook.com [40.107.8.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91915CB0;
	Tue, 12 Mar 2024 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710208958; cv=fail; b=uF0ajdXwfL0uLLtdEbIUw2dyPhroZyXoTjFz1x9U2TQMhe+GcukhdOe4dxIlecAP0XO1IdCxXcuB0WTrfAU2U94rteyT6GbwZcNvP52JC/II0UAIi/wT3HxFUwxz1kJGoAkPfV3nXsx+NJAzoV8B4PXJp3PrjBVQLullrxtmuA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710208958; c=relaxed/simple;
	bh=wIRRWCiz60dLIlOimCVurk4Lo/wqdhrtlE89S4OQv+Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G4ilbHIJoODeM5BkSIv/+SWdNTFp6SQkXuWEEG5ddjSWiAkA03fYForr7t6x3dCVwzL5vtWoNxSMuRlOLYJmfTMNGr3VtWiQ+PIUoTarLAIBT4FYhiIiFlhUZkdQUP4W7ghhZPGt2I1rzdR13WjIxrwQxXbbK8dyRmWN4eVNsBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=TiMvZ23y; arc=fail smtp.client-ip=40.107.8.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BvR7VPfYTsi012ALwSvh8wLNEj5joRyODzuhNfdy7nLl7KW5rp1S973IwV+0mFcSGzeIj/yCvtvkWjW9WAxWKui/wuiJEZB0NuZE/QrFWZgqNBoE9EXiX2T9bWQUZqdbldoqzQM6zat/udq1QRiqjUQ70iffXgiEaRBvsHMBiqf7DBGCOuttd++OQXRjNJSuHxSYOCKuJG/kskTH3Wq5yvh0fehOQSUkm/nava0q4itvGbTnHqvDxXgQ2cjcCTiFJ+VcyuuHPtcjHUCMKeJHnbEec+ZqMulnMXppzD7jfW7nA98XlHHMonHtRICRyC1EjJbXxENCRHy1iSqnaGPSGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIRRWCiz60dLIlOimCVurk4Lo/wqdhrtlE89S4OQv+Q=;
 b=Vh3nZZiZNxjy+5fX7Mc+jAVdRMDhDQx8Dtpw9kMGerUQEGepukbQRUc7+/zs3d5lXDGeXHa4jtpcMX/wKm4AGGaUo/q/oi3p+1GUpXp/UkukjOoJ3jEczacD+9XWQex3O1pxLyOE4oNDhQO5ehAevkwN3O2LAL3RpVibHzFJAYzI3x75WXKcu7+oNyniPOz4yyYKLPQmpY1g/X1a5GUuGNZZu3XxuZJx1ssBlvgj/SJpjgwSxEjchjPPn3cEZSRWefVuJ2JVSgycqLcDiipET22ER4Om0kwRX07jBEI+PQJ/KJh6odVavNgtWMZhj3qkkpsuy1RZEpEMDodxxPLnLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wIRRWCiz60dLIlOimCVurk4Lo/wqdhrtlE89S4OQv+Q=;
 b=TiMvZ23yMeU5ukW1k+bH83PVW1v//Vb8x1Hss1sGJRMjFFZAJdgRU8bniosEWBjnXHOJEN9N/6NWb/mlzJFPyw03sWKRriT02aa7ap/FuH0eOI9uDU1dHY6XZDtiQqsHb1QIuM/9yGFChFCvFiz1KLuxTcHFJfcEVtF4LNuBbUo=
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com (2603:10a6:10:36b::13)
 by VI1PR04MB6941.eurprd04.prod.outlook.com (2603:10a6:803:12e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Tue, 12 Mar
 2024 02:02:33 +0000
Received: from DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d]) by DB9PR04MB9377.eurprd04.prod.outlook.com
 ([fe80::b3d4:17c4:91b7:101d%5]) with mapi id 15.20.7362.024; Tue, 12 Mar 2024
 02:02:27 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Jacky Bai <ping.bai@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
	"broonie@kernel.org" <broonie@kernel.org>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v3 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Topic: [EXT] Re: [PATCH v3 3/3] arm64: dts: imx93-11x11-evk: add
 pca9451a support
Thread-Index: AQHac6auC+/zOyKfB0WUQXcyqrEuC7EyfCSAgADcr0A=
Date: Tue, 12 Mar 2024 02:02:26 +0000
Message-ID:
 <DB9PR04MB9377E66EA24C364229E1AA92E12B2@DB9PR04MB9377.eurprd04.prod.outlook.com>
References: <20240311113201.664252-1-joy.zou@nxp.com>
 <20240311113201.664252-4-joy.zou@nxp.com>
 <CAOMZO5A_5mUgEL6MvO=D1RS9aT-DFc8eGiF7VDCZqeSkYtGYcQ@mail.gmail.com>
In-Reply-To:
 <CAOMZO5A_5mUgEL6MvO=D1RS9aT-DFc8eGiF7VDCZqeSkYtGYcQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB9PR04MB9377:EE_|VI1PR04MB6941:EE_
x-ms-office365-filtering-correlation-id: 5b49616e-468f-4e5a-40d8-08dc4238777c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 l75jgRYQfg57M8vtNSYEH5lISl67GkQ8YQ7zDn1B79jhJ9ju4Yd1y/yHrkHi4sCPmwkIEjXMyITpjQxtZGsfzOAheUG1xWYC0QyM0e9EPDGdiIeQAkvZSVQpoRRjj1sBpIpP3vlzWKS6ckzpgJcYVUruFztqWXro9sZH9jDrkxHQjwhAMcLTN4T1sQfURIm40HZRwU6nWjORbCjVrNnuTphDMK1Ps6wH6KqoyofUcndTzNLXOTeTQ4EVz7JWcY1DSxdOtBqtL8GPxcWGxGutL0vfU8xe7X0gM59rviuUExZE/Ypt4SRqIl6qbhTPLilWZsV23vOdgVTHt4Xvynt1atR0ePJhFbCuNILGsIHN5ZO8TWPofj87tD/96Eg0iER+LNsRBi0SZxGblBZMl2KUGTl1ruaKUM2twZ5jnUhUd3p7YPK54m8L8f2PCm5dYTYa38HSO4QbbhVLbrBKxJ3wxa6RP7DX2JkOAFJF+pF5y3xGbw/To/+apmvHFKurq833Nz+q3nbEGjV9rc8jjb9I+DDSdDz/qSBHI0zIVmhw3+J2MkJ82VBBg0dy7LCEq6MfWEiZWu4r2fatgcsRoNCOrlHLGpC0872olyXQyN1QZOowpEz/x2Rmiwyf87lErvWDRi/L2gJzL3bvX5XUHTeFe8/HP2ZY3fiBRD2OtOq3VchhDry53ZaPMit+M/on7NK16vCAJMzLR4Eg7dj6PAODOA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9377.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q2gwQ3dGS0J2SlJZK1RldzJIUzNwV2ZhNHRLcm1YK2kyWXNrN1htM25KTlIr?=
 =?utf-8?B?SUluYkxJc2NuZFcwNnNWbWhrRmZFdDJDL3dnZi9oWnZjenpTV2tsN2duTllj?=
 =?utf-8?B?bnovRTFibkY4VmtBdllyV202SXhzYzk4YmtJcENmdlU0R0dxSkRZV3V2NUxZ?=
 =?utf-8?B?a0dZUE9KT0dXL2xUUjQwb2ZFSlk0aHh2MFQvQVNCR0xyYnlrVzduUXZxdXNl?=
 =?utf-8?B?M0FHTWVlSmQ5Y2VYZmpTZFF6VFhSQnd4TVJYSkdvdm9iR2poY1dXY2VnTnZB?=
 =?utf-8?B?RUs4ejY0SnJnMGc2SGxMdkNnNW1KT0lRYlQ3aTlHOHUzTHdqN2ZFbGE3NU42?=
 =?utf-8?B?Y3hHQ0NERXQ0emVVVUw4WXU0aXM4dERqTlRJbC81dUF3LytURUhNRy9WTkY3?=
 =?utf-8?B?ZUM1azZlK2VncVdSb3JBMGg0Rm5QM1kyNFhMVGpWUTdUK2lPRksyUk1IenVF?=
 =?utf-8?B?RzErc3RmMFFaSC9vekh6NnVoTXdyQnpiT1U2UndwdHVaYXViajNvSXBJYUlt?=
 =?utf-8?B?Tm1reHVsSGx6dmxXbVcwdHVzSVR4bHoyaEdGeFNxZGtqL3F1cy9JZ0xzUkNZ?=
 =?utf-8?B?VHRsVGpIZnpiWU1IR2Fjbkp3VlYzWW9yMmYvSFkzazFCNkhaL1VqTXpSQlZo?=
 =?utf-8?B?c0xhQlQ4M2diZCs3Z3I1ajhtM1RaMFZGejFUL0paci9qcS9OVFlJVE52cGZZ?=
 =?utf-8?B?cGh4VGRJQVVnQmFjV0VmMjQwTnV5VUdWZGVidFJDTzFQSWJybzUvaC9LRUw5?=
 =?utf-8?B?YlJLZnZURkp1UWRrU1VBQnNDcmZjOStiNnRMcHZybTBCU21kZDgzd1Q0K0Jv?=
 =?utf-8?B?L0ppTTREeFhPei9YSm85eXowVDljVGF3RCs4MnBkZGppblU4RVhSNkpTa0cr?=
 =?utf-8?B?NGZ2YmZMUWpNczFTUkp0TnRKdm5oM1VXSzZybFVmd3FleDgvczFwTUJtVGs2?=
 =?utf-8?B?d0RJRG1mMUdDcytmd0hDKytCeVNUb2FIbC84cTRsWEJFQytZcXBHak5oaURp?=
 =?utf-8?B?akwzbzVMblNpTWdhckcwZ2xDV0RaTDlON0tLQmJHMzFWRThxVEgxTDh3Zi94?=
 =?utf-8?B?dlcrczBNRzduV2U1UlF6K2l1NmdsWjBGNHJ4b1hSVWxVWHNJeWJvTnUvaU91?=
 =?utf-8?B?VlAvUHNNV3E1K1VsaXB2ZkcycExJQzNQVWRWYlRWMlBlQzB6R3pzT1hHTGtv?=
 =?utf-8?B?M0p3L0g5YmJuWk9IYXJhZVRNTUZTdkc5QmY4WEZtK3NReFJDdjg5YkZCZ2RW?=
 =?utf-8?B?RUZ5c2dxTGcyeHplcXJHL0syQWFsUzU5MnpUWXA2SGNWUnVmUFdWbXMzZ0Y2?=
 =?utf-8?B?VzRoMHJ3bFVIMXRja1hrZXlqYnpvZ25BV0NjYVE0YU85c1ZXamtHRUMyblF5?=
 =?utf-8?B?ODhPb1kvVXR4T1BnODlkbWtidWMxRUJRY3dvZjQzTVg0bitHODdwOGYwUndV?=
 =?utf-8?B?d1huSGxmbGxIenBsd0h5QmZzRFNjY2tCNnlTbzBOVU42enA1bURvY0dIUDN4?=
 =?utf-8?B?NnVaR2wrblJyT25YUDh6WktWSFRWdzdFNmhBcG5hWVJVWWRJNjgrUitEZEpB?=
 =?utf-8?B?bFl5Z3k3S1VXYVhDRTQ0UjZJL2x2azBJcWdBUENoTFg3ZlowTEFTNnJuOHJs?=
 =?utf-8?B?dU10SmQ0TXdvQWlXM21tUEE2dXhrZFgxNnBHMkFHNjFZK0NLay9ndDFLS3FN?=
 =?utf-8?B?Q09kVDMyTDFDd1JTQ3dLR2JhRnFkSGNFUHRiMlg5ZUI0L1B1VU56cUFHVEIz?=
 =?utf-8?B?NHZxQnFzOEFieU9XbmJTRUJkTy9KNjNaQ0wwOVZzcnhMdWxST29yTkhtemZs?=
 =?utf-8?B?ajJCMFVHNkNPMFRodGRyNDIvWm10OVhvcUFYRHRFU3IrVks4L2tmdDFPUXpy?=
 =?utf-8?B?UE1zenpNYU9PLytVWmxqMlhGbWZTd1pVZHRhNGZwMVFJY3FyWSt5aEM0bDJJ?=
 =?utf-8?B?MEF1K2dVYlZyY3huUnVkYjU3a1djcm5BMDB2ODVPelRyYjBnY29WS0RZVGk4?=
 =?utf-8?B?NFUrbnFIbllVZ3h5VjR1QXhXQXZkWXBZVEMvUkZtdlNsRkRmM3RXUHltaHFI?=
 =?utf-8?B?T0pDaXRXdzZBQ2lLV0psT0s0dU9CbjFMdWtrMnpHaG1pbWtOajBaZ3Z3akVy?=
 =?utf-8?Q?ENmw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9377.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b49616e-468f-4e5a-40d8-08dc4238777c
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2024 02:02:26.9942
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9//uGRSREky3vJg44Gcdu5zuf37f5NPBqCyLWnIjvFTGC7w2ZXSF0xJVkti++o+O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6941

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEZhYmlvIEVzdGV2YW0gPGZl
c3RldmFtQGdtYWlsLmNvbT4NCj4gU2VudDogMjAyNOW5tDPmnIgxMeaXpSAyMDo0NA0KPiBUbzog
Sm95IFpvdSA8am95LnpvdUBueHAuY29tPg0KPiBDYzogSmFja3kgQmFpIDxwaW5nLmJhaUBueHAu
Y29tPjsgbGdpcmR3b29kQGdtYWlsLmNvbTsNCj4gYnJvb25pZUBrZXJuZWwub3JnOyByb2JoK2R0
QGtlcm5lbC5vcmc7IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsNCj4gY29ub3Ir
ZHRAa2VybmVsLm9yZzsgc2hhd25ndW9Aa2VybmVsLm9yZzsgcy5oYXVlckBwZW5ndXRyb25peC5k
ZTsNCj4ga2VybmVsQHBlbmd1dHJvbml4LmRlOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAu
Y29tPjsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxp
c3RzLmxpbnV4LmRldg0KPiBTdWJqZWN0OiBbRVhUXSBSZTogW1BBVENIIHYzIDMvM10gYXJtNjQ6
IGR0czogaW14OTMtMTF4MTEtZXZrOiBhZGQNCj4gcGNhOTQ1MWEgc3VwcG9ydA0KPiANCj4gQ2F1
dGlvbjogVGhpcyBpcyBhbiBleHRlcm5hbCBlbWFpbC4gUGxlYXNlIHRha2UgY2FyZSB3aGVuIGNs
aWNraW5nIGxpbmtzIG9yDQo+IG9wZW5pbmcgYXR0YWNobWVudHMuIFdoZW4gaW4gZG91YnQsIHJl
cG9ydCB0aGUgbWVzc2FnZSB1c2luZyB0aGUgJ1JlcG9ydA0KPiB0aGlzIGVtYWlsJyBidXR0b24N
Cj4gDQo+IA0KPiBPbiBNb24sIE1hciAxMSwgMjAyNCBhdCA4OjI04oCvQU0gSm95IFpvdSA8am95
LnpvdUBueHAuY29tPiB3cm90ZToNCj4gDQo+ID4gICAgICAgICAvKiBuZWVkIHRvIGNvbmZpZyB0
aGUgU0lPTiBmb3IgZGF0YSBhbmQgY21kIHBhZCwgcmVmZXIgdG8NCj4gRVJSMDUyMDIxICovDQo+
IA0KPiBQbGVhc2UgcmVtb3ZlIHRoaXMgY29tbWVudC4gVGhlIFNJT04gYml0IGlzIHNldCBmb3Ig
STJDIHBpbnMuDQpUaGFua3MgRmFiaW8hDQpZZXMsIFRoaXMgY29tbWVudCBpcyBmb3IgdVNESEMg
YnV0IG5vdCBpMmMuIEkgd2lsbCBhZGp1c3QgbXkgcGF0Y2ggZm9ybWF0Lg0KQlINCkpveSBab3UN
Cj4gDQo+IEFsc28sIHRoaXMgZXJyYXR1bSBhZmZlY3RzIHVTREhDIGFjY29yZGluZyB0bzoNCj4g
aHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0dHBz
JTNBJTJGJTJGd3d3Lg0KPiBzcGluaWNzLm5ldCUyRmxpc3RzJTJGZGV2aWNldHJlZSUyRm1zZzY0
MTg0Ni5odG1sJmRhdGE9MDUlN0MwMiU3Q2oNCj4gb3kuem91JTQwbnhwLmNvbSU3QzlmZGE1Zjlk
OGJmYTQ0MTM5YzY5MDhkYzQxYzhlM2Y3JTdDNjg2ZWExZDNiDQo+IGMyYjRjNmZhOTJjZDk5YzVj
MzAxNjM1JTdDMCU3QzAlN0M2Mzg0NTc1NzgyNzQxNzg3MzYlN0NVbmtuDQo+IG93biU3Q1RXRnBi
R1pzYjNkOGV5SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsNCj4g
MWhhV3dpTENKWFZDSTZNbjAlM0QlN0MwJTdDJTdDJTdDJnNkYXRhPVklMkZXSDYlMkZKTzBUN2xB
DQo+IEdsTmdzekozR1JPTjFoWXZaSXgxQ0lpajUlMkJqS2pFJTNEJnJlc2VydmVkPTANCg==

