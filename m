Return-Path: <linux-kernel+bounces-134895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DAEA89B85A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 09:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E262834DB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7747125619;
	Mon,  8 Apr 2024 07:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bx2x5ClP"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2121.outbound.protection.outlook.com [40.107.6.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA982260A;
	Mon,  8 Apr 2024 07:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712561020; cv=fail; b=ECgzvFnLddmu96+jIRxU1yx1fTquhD9mtEpvH/ywlIcl1mnOx/76iCEGItJUTjZufywjwgjj1/lHgmYjgg9KxS0TcU8xP3mXCAWGIoe3weBl20DPlSr99gRqG/XLH7KW5aAx2aBOqqEUaqQUV5Wsj5ey9RoG/wvlVTPex09wBgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712561020; c=relaxed/simple;
	bh=vqPK/q8CC4FwKazOmewiIbcg8+LsoXGgjJ8hpoGukkM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UYj0ivLa0UqU4wZFZEGF4IxqAhgF0zsybbg5Tnn3+UhPoK7jRKmzixBs1hYQu6BZkGx2qigJDXyU85j1KbjEAIMGuRmuZ4cQPJEUy6RespEaFSkTDtijjhibVV0WZmzHY19lce/2mdSN2WY9Eh6z2ZtnpqZocFEkqefA6fKc5fs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bx2x5ClP; arc=fail smtp.client-ip=40.107.6.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E6UcAZa3R8OWVt6XY+WcdF1gm5rpKdyd2x6kJ0GViCqM/CSQw5n0QbsNdKjgLyjcv51126A3LsqHjBZjlGYDsac3nwOad/+Mt3dOGBdQJpdwonx6GVsH2A2ccgR1aDKJ7s2dFVyVR8q+9MCAiVbJrJ2Y/Y29P5/33VKk1Yiu1nyKybYhIz6oaz3TZbK8EulM9TWUkU9PnjjSiIgMvMdxw1T8sw7CEwzbXUfXkdXJgnqF4hybJGvq22zNivSuGl/m2Yj8n37FAUk/3yQs3FR2AoZIhCvNAkup9nov9/FXetuNWfoW+amn7G7i9yIP3mLO8MGbyCCLEDtXVCIZg0zwGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqPK/q8CC4FwKazOmewiIbcg8+LsoXGgjJ8hpoGukkM=;
 b=RIdlgfTkD7lybgadZb2wJbIWql6fyt+jvB6KKTigRyP7ojD0/m7XOCAQVLDvrQNTTBZ15cNUKWZzljAEPqGiuyxAIPg4Yp7mPks+iGHhaMCSJu6MqAKW17fUTmI8Rog8iLNR83CV6BvXvnJytntBXpX+OgM1FWXsXukCc1kDNBrr3QOGE6zlcoE5TAmlUVyB0/9vLOLYfOsOQ1s+JYGX682KUm0Tr7l9waOizoZXS6jZJ4WGxASY6bxBxOJFx2dGTtZc6R3WwIZuJAvB6sxTR6Dem+cfSNcDMk0rvHWOAKXsO/IyKVnQDSpEW0Qxt5LKCswJVl/O8OYIkxCVHPkBuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqPK/q8CC4FwKazOmewiIbcg8+LsoXGgjJ8hpoGukkM=;
 b=bx2x5ClPAhxh/ukp2X85+isv3qRgnQ7ovqo7X7UZm7UXHdgsUhYBIGlzRB76fVvFJUkMQPPs0FZJFSEdIFmvTVWl7snFpVGmXtBtZs3JIvfwqK4DdPIDNK54cmQBnf7cApeE9jLEJpAWGtrZKtDKsfqHvLPOxbAvlftKc3xXCfA=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB7855.eurprd04.prod.outlook.com (2603:10a6:102:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.53; Mon, 8 Apr
 2024 07:23:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Mon, 8 Apr 2024
 07:23:35 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Shawn Guo
	<shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
	Sudeep Holla <sudeep.holla@arm.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Topic: [PATCH v2 1/6] dt-bindings: firmware: arm,scmi: set
 additionalProperties to true
Thread-Index:
 AQHah1U2hf+AkPhDj02wsn9yNtLUjbFbE9+AgADkvNCAAItFAIAAEwgggABoGYCAAH0iQIAAaICAgAAAQWCAABZPAIAAAHjw
Date: Mon, 8 Apr 2024 07:23:35 +0000
Message-ID:
 <DU0PR04MB9417C8C5013C72AB1F61F1C588002@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240405-imx95-bbm-misc-v2-v2-0-9fc9186856c2@nxp.com>
 <20240405-imx95-bbm-misc-v2-v2-1-9fc9186856c2@nxp.com>
 <614b5107-656d-4d41-99c1-77941c48342c@kernel.org>
 <DU0PR04MB9417932A6208128FBBB22C4188012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <09f6b752-6b72-49d7-b248-6faba2fd13a7@kernel.org>
 <DU0PR04MB9417C5B9BDD9E0B47E7494C088012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <5b9e0e44-0b9c-44fc-9d18-21c47b46dc63@kernel.org>
 <DU0PR04MB9417839C42681F57366003EF88012@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <ba4c9f20-0391-4ac2-a236-d6930285cd7e@kernel.org>
 <DU0PR04MB94176D02B90528913842B76A88002@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <e6333665-8051-43b1-9e98-f76262ddbc35@kernel.org>
In-Reply-To: <e6333665-8051-43b1-9e98-f76262ddbc35@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PA4PR04MB7855:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 zeWbk04Z9zApS+kNd6YCQALNSLPAbPubQ2+MhzZw4b8vwiS5mD8b3vXbnSJI5WbyBeCC5Sy2ODwQ4YiZ5y1bWiihBQXNY88dv5pwU+JsGG1aKUI2vC7zNWbtMXxzZAQt8M1+pEvnDkNgf4XKXYtyD0ae3Hjf4NqnaT24GgntJyMF8NPUkPzdOeCvtlUA5yUo8RQEwx8V8SuSxw5sq9Ak0kUSRG+z7PNyTMrsWII5Ed0d+KrkcqBt2yAKtU5LtdZCw+coOU/RJogZBCkf6xm1IyoH/0MHhJBp6VrYoGlnyMvbvhlS4WdzXtfYtvesw+cF40F4XCmOXsU84ZL/MScno8ptVqd3z2bp0hyIFeIRx+dEWDE+xU0n/l33v4xDRkJf8lxQ6go0JyqCyOlWbrbK2ozQCUw7BJUFC+jcGY8+0EiKgz50wYwNdKeI0V6lnMjyco9xJhE9N/BJ1WwVrUZji2ss7GFPz2aB+QIvfMni9931piYNfyVx1hzkoFW2MF/zVR/zHPAxsEP/2QoadZr8rVAi4FzgS5JIGnagoKsDKAFBJbnC6W8gxtwHlDpfFWSh1edqxwCwqRr1ALWvXBHaHCtGn9C0uTXLEH0g5A8QjWOOO5Gu4HQalOn1kzkUZkrg4lLVHI4fT9K8J1+NkC9nsQZ/0/h1XWGfPdH5q3NBcDchjfReWfakPKiYm7buvyl1GwShWcAcGMUAReUaTHiXEg==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UnhsMTd4M0xMOFVnT1h2UVIxY0UrNXBZLzhCVWx4dTJkRXQreDU5QTNJSDlm?=
 =?utf-8?B?Y1RhR1dFcFh0SmRQQXM1MGRPK3RCTm9BT3hrVUJ3QkdEdlhsUWpLNWIrdTlL?=
 =?utf-8?B?TG1yZVo3SGNuMW00TDhnVmw5eTVFekx3dzVjNDJmU25xbjV1aHYxK0JhZkxU?=
 =?utf-8?B?ZjVOS2NWdlQraHdDNmc0cHc4ZlZVdkFvYndBQzJWekFtem1KVE5aQkh0MnVP?=
 =?utf-8?B?Njg3dzI2bnVxZ0I5NW54b0RsVTdFWk83ZTdjajlON0psdWZkMkhxR0xDZTRS?=
 =?utf-8?B?T0wydDBZM0UvZ2NNZEo0UUdYS0hrY1Z6ajRWY0JGQmwxL0dBdnU0RXZOZWtJ?=
 =?utf-8?B?SlZYZFUwd2hzeG4wUCtJbVM3WENNVTVMSm5EeENXdEdic2pvQ0d1ejFMSEla?=
 =?utf-8?B?Yml4bWZBbU9NNjVPN05OSDFzODRtWE9aSk1LYUJ3Q3gwVk1DL2JzcnlXMHRJ?=
 =?utf-8?B?OWtZU1NzcERJMFJsQWw5WCtJSjNySXRtai9kR25LZ1BpN0dSRUpsZlhKVjJu?=
 =?utf-8?B?ekgyckdqV0QyNDF4enZ4VlJ3VGYrUWpaMmtob0QyeFBpa3dtMmpBU2tkczdF?=
 =?utf-8?B?bTNFcktnSUl3NnRDV0dwSXFNdllFSm9lSXBBcFZuejNvclFqTUszbjhoRmdp?=
 =?utf-8?B?YmxSWnV5UlVrWm5NTlFwQnlPbVJBRytqdHZJWUwrZzEzeC9HOFVZakEyNWJ3?=
 =?utf-8?B?dmh2Z3c3SVIyQzRwOUZYZjhHMWJ4NEhYRE5Ec0dPa0h3Zms2ZThzcG5EajdK?=
 =?utf-8?B?UkJHckhsYUt6Y0NZMk4xdHRGT2dUNlZvSmxiV05PU3FhUGMyN3pPVXkxaDR2?=
 =?utf-8?B?SW1CWTVKQm1pcTNsektoaGwwVExCSFFaZ0NHTjJOSEFKVEMyRjNLeTBIc3pt?=
 =?utf-8?B?R25scDBEYWpsZUd6TUVwME9xU01KOHF3OWNESllKVk0veGdubnFUQWN3am1m?=
 =?utf-8?B?YjJRalhUbEZNcXBnN3NXSDBHZlN4TC96N2Y3ajR2Unoxcnc2bEtYTkhZQ29l?=
 =?utf-8?B?Ymp0QTBMNGFwVEEvMWl1Wk9icVRIWmJoTmNMVFNyaXBjYWNnbGtTeWx0Q29J?=
 =?utf-8?B?Nk0zYWttYzlsaERMK3ZyZFd2WHRNRXVpRmdkZE1iUE80eXFKRmVPUUVkbTgr?=
 =?utf-8?B?aXJ1WjlPRTZNbzlIUllieW1mS2xjRjZQWmhIbTdPemlCeTAzOWVuTE9BcTJO?=
 =?utf-8?B?U005VFFzb3FodFI4aXVuYTdReTNhTk9wRVJGeEVqcWNYaThrRzluaVJpTnFS?=
 =?utf-8?B?Y0ZYNHN4aVkrcWxDZC90OFg0R0ZRWE9zUFdIVGdVcWt1RURodmUyd2ZKYjFZ?=
 =?utf-8?B?eitrR3dFOWdnclhGQnhNTDFrWENaUDBMeHdTUmNWKzRVNHAyOFVGMXJzZGtm?=
 =?utf-8?B?OUNqM0VCclJNS09IUzg0QXpMUHJIdVBIV29MQThqWU1ibDYraS9JeGdtaGFs?=
 =?utf-8?B?RllhdUgrZG91SXhFeTlKY2ZrZzNmYWNIM2dZdXJvdDJOR1RCWllvakNEWmYr?=
 =?utf-8?B?R3lSaHIzaHloQStYSTU0T3lRZ0hRdTVCVW1FMmhlVjZYNzRKNGU4cnYwRkNo?=
 =?utf-8?B?dStLdHViZElGQTRNTXp3TkNPNmQwRzhSUVUxVUFJRDl5V21Yc2ZZcmJUdnkz?=
 =?utf-8?B?NldiMHVjU2k1eEFuVUt4UkkwNVRkMTFGaWlLR092eUtDbUZnSWorSmNyd0Mr?=
 =?utf-8?B?NEVWb0JSOG9kSzBEMlUxTzczT3ZHcW1yYnM4TUlCSGNqU2V2KzBIbnNhOU5t?=
 =?utf-8?B?VEdpZkRSQTRwenRXQjV3NWR3QmNLTXFrUGVxWUNCTGNsc0lhWGRYM1ltajF3?=
 =?utf-8?B?clFhVEgwSE91bElsV1FnY01Zd0xDZmw2cjVQdU5ra1lUQVZkK2g4NVgyNnZx?=
 =?utf-8?B?TzlCN1p3am9vMmFaNlp3bDNQM214UHgwcFJZWU1wdnlDNFF4bEt0bUFkbkZQ?=
 =?utf-8?B?UGFHaWViSk9mazZPVElrREJsajBXUyttM2ZydTZZU0VPQkNTeVQxZmEwckhx?=
 =?utf-8?B?VEFLTU9DekQ2VUR5dkMrb0lKU2IwaGdyZ3pyUUYwNFNjNTN3OFprL0VwcGxn?=
 =?utf-8?B?dlVTaHd4VE9KYlF6dWlkV0R5aENQWkJzTCtjS0RQcmRuZ3g1a2VxVFJUdldU?=
 =?utf-8?Q?+pHY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e6576b5-4845-4a9f-c224-08dc579ccd72
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 07:23:35.3087
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +L/s2RjQG5hNzFizjIlOW9FU1DSLduRTUIL005Vo3ABIKQoOc1eQFfwGqse2tjdJtZbt8gHOJN7bQksO8MmCyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7855

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0s
c2NtaTogc2V0DQo+IGFkZGl0aW9uYWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gDQo+IE9uIDA4LzA0
LzIwMjQgMDg6MDgsIFBlbmcgRmFuIHdyb3RlOg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYy
IDEvNl0gZHQtYmluZGluZ3M6IGZpcm13YXJlOiBhcm0sc2NtaTogc2V0DQo+ID4+IGFkZGl0aW9u
YWxQcm9wZXJ0aWVzIHRvIHRydWUNCj4gPj4NCj4gPj4gT24gMDgvMDQvMjAyNCAwMTo1MCwgUGVu
ZyBGYW4gd3JvdGU6DQo+ID4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRp
bmdzOiBmaXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+Pj4+IGFkZGl0aW9uYWxQcm9wZXJ0aWVz
IHRvIHRydWUNCj4gPj4+Pg0KPiA+Pj4+IE9uIDA3LzA0LzIwMjQgMTI6MDQsIFBlbmcgRmFuIHdy
b3RlOg0KPiA+Pj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzZdIGR0LWJpbmRpbmdzOiBm
aXJtd2FyZTogYXJtLHNjbWk6IHNldA0KPiA+Pj4+Pj4gYWRkaXRpb25hbFByb3BlcnRpZXMgdG8g
dHJ1ZQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IE9uIDA3LzA0LzIwMjQgMDI6MzcsIFBlbmcgRmFuIHdy
b3RlOg0KPiA+Pj4+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvNl0gZHQtYmluZGluZ3M6
IGZpcm13YXJlOiBhcm0sc2NtaToNCj4gPj4+Pj4+Pj4gc2V0IGFkZGl0aW9uYWxQcm9wZXJ0aWVz
IHRvIHRydWUNCj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gT24gMDUvMDQvMjAyNCAxNDozOSwgUGVu
ZyBGYW4gKE9TUykgd3JvdGU6DQo+ID4+Pj4+Pj4+PiBGcm9tOiBQZW5nIEZhbiA8cGVuZy5mYW5A
bnhwLmNvbT4NCj4gPj4+Pj4+Pj4+DQo+ID4+Pj4+Pj4+PiBXaGVuIGFkZGluZyB2ZW5kb3IgZXh0
ZW5zaW9uIHByb3RvY29scywgdGhlcmUgaXMgZHQtc2NoZW1hDQo+ID4+IHdhcm5pbmc6DQo+ID4+
Pj4+Pj4+PiAiDQo+ID4+Pj4+Pj4+PiBpbXgsc2NtaS5leGFtcGxlLmR0Yjogc2NtaTogJ3Byb3Rv
Y29sQDgxJywgJ3Byb3RvY29sQDg0JyBkbw0KPiA+Pj4+Pj4+Pj4gbm90IG1hdGNoIGFueSBvZiB0
aGUgcmVnZXhlczogJ3BpbmN0cmwtWzAtOV0rJw0KPiA+Pj4+Pj4+Pj4gIg0KPiA+Pj4+Pj4+Pj4N
Cj4gPj4+Pj4+Pj4+IFNldCBhZGRpdGlvbmFsUHJvcGVydGllcyB0byB0cnVlIHRvIGFkZHJlc3Mg
dGhlIGlzc3VlLg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBJIGRvIG5vdCBzZWUgYW55dGhpbmcg
YWRkcmVzc2VkIGhlcmUsIGV4Y2VwdCBtYWtpbmcgdGhlIGJpbmRpbmcNCj4gPj4+Pj4+Pj4gYWNj
ZXB0aW5nIGFueXRoaW5nIGFueXdoZXJlLi4uDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBJIG5vdCB3
YW5uYSBhZGQgdmVuZG9yIHByb3RvY29scyBpbiBhcm0sc2NtaS55YW1sLCBzbyB3aWxsDQo+ID4+
Pj4+Pj4gaW50cm9kdWNlIGEgbmV3IHlhbWwgaW14LnNjbWkueWFtbCB3aGljaCBhZGQgaS5NWCBT
Q01JIHByb3RvY29sDQo+ID4+IGV4dGVuc2lvbi4NCj4gPj4+Pj4+Pg0KPiA+Pj4+Pj4+IFdpdGgg
YWRkaXRpb25hbFByb3BlcnRpZXMgc2V0IHRvIGZhbHNlLCBJIG5vdCBrbm93IGhvdywgcGxlYXNl
DQo+IHN1Z2dlc3QuDQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gRmlyc3Qgb2YgYWxsLCB5b3UgY2Fubm90
IGFmZmVjdCBuZWdhdGl2ZWx5IGV4aXN0aW5nIGRldmljZXMNCj4gPj4+Pj4+ICh0aGVpcg0KPiA+
Pj4+Pj4gYmluZGluZ3MpIGFuZCB5b3VyIHBhdGNoIGRvZXMgZXhhY3RseSB0aGF0LiBUaGlzIHNo
b3VsZCBtYWtlIHlvdQ0KPiA+Pj4+Pj4gdGhpbmcgd2hhdCBpcyB0aGUgY29ycmVjdCBhcHByb2Fj
aC4uLg0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IFJvYiBnYXZlIHlvdSB0aGUgY29tbWVudCBhYm91dCBt
aXNzaW5nIGNvbXBhdGlibGUgLSB5b3Ugc3RpbGwgZGlkDQo+ID4+Pj4+PiBub3QgYWRkcmVzcyB0
aGF0Lg0KPiA+Pj4+Pg0KPiA+Pj4+PiBJIGFkZGVkIHRoZSBjb21wYXRpYmxlIGluIHBhdGNoIDIv
NiBpbiB0aGUgZXhhbXBsZXMgImNvbXBhdGlibGUgPQ0KPiA+Pj4+ICJhcm0sc2NtaSI7Ig0KPiA+
Pj4+DQo+ID4+Pj4gU28geW91IGNsYWltIHRoYXQgeW91ciB2ZW5kb3IgZXh0ZW5zaW9ucyBhcmUg
dGhlIHNhbWUgb3IgZnVsbHkNCj4gPj4+PiBjb21wYXRpYmxlIHdpdGggYXJtLHNjbWkgYW5kIHlv
dSBhZGQgbm90aGluZy4uLiBBcmUgeW91cg0KPiA+Pj4+IGV4dGVuc2lvbnMvcHJvdG9jb2wgdmFs
aWQgZm9yIGFybSxzY21pPw0KPiA+Pj4NCj4gPj4+IFllcy4gVGhleSBhcmUgdmFsaWQgZm9yIGFy
bSxzY21pLg0KPiA+Pj4NCj4gPj4+ICBJZiB5ZXMsIHdoeSBpcyB0aGlzIGluIHNlcGFyYXRlIGJp
bmRpbmcuIElmIG5vLCB3aHkgeW91IHVzZSBzb21lb25lDQo+ID4+Pj4gZWxzZSdzIGNvbXBhdGli
bGU/DQo+ID4+Pg0KPiA+Pj4gUGVyIFNDTUkgU3BlYw0KPiA+Pj4gMHg4MC0weEZGOiBSZXNlcnZl
ZCBmb3IgdmVuZG9yIG9yIHBsYXRmb3JtLXNwZWNpZmljIGV4dGVuc2lvbnMgdG8NCj4gPj4+IHRo
aXMgaW50ZXJmYWNlDQo+ID4+Pg0KPiA+Pj4gaS5NWCB1c2UgMHg4MSBmb3IgQkJNLCAweDg0IGZv
ciBNSVNDLiBCdXQgb3RoZXIgdmVuZG9ycyB3aWxsIHVzZSB0aGUNCj4gPj4+IGlkIGZvciB0aGVp
ciBvd24gcHJvdG9jb2wuDQo+ID4+DQo+ID4+IFNvIGhvdyBhcmUgdGhleSB2YWxpZCBmb3IgYXJt
LHNjbWk/IEkgZG9uJ3QgdW5kZXJzdGFuZC4NCj4gPg0KPiA+IGFybSxzY21pIGlzIGEgZmlybXdh
cmUgY29tcGF0aWJsZSBzdHJpbmcuIFRoZSBwcm90b2NvbCBub2RlIGlzIGEgc3ViLW5vZGUuDQo+
ID4gSSB0aGluayB0aGUgYXJtLHNjbWkgaXMgdGhhdCBzYXlpbmcgdGhlIGZpcm13YXJlIGZvbGxv
d2luZyBTQ01JIHNwZWMNCj4gPiB0byBpbXBsZW1lbnQgdGhlIHByb3RvY29scy4NCj4gPg0KPiA+
IEZvciB2ZW5kb3IgcmVzZXJ2ZWQgSUQsIGZpcm13YXJlIGFsc28gZm9sbG93IHRoZSBTQ01JIHNw
ZWMgdG8NCj4gPiBpbXBsZW1lbnQgdGhlaXIgb3duIHVzYWdlLCBzbyBmcm9tIGZpcm13YXJlIGxl
dmVsLCBpdCBpcyBBUk0gU0NNSSBzcGVjDQo+IGNvbXBhdGlibGUuDQo+IA0KPiBUaGF0J3Mgbm90
IHRoZSBwb2ludC4gSXQgaXMgb2J2aW91cyB0aGF0IHlvdXIgZmlybXdhcmUgaXMgY29tcGF0aWJs
ZSB3aXRoDQo+IGFybSxzY21pLCBidXQgd2hhdCB5b3UgdHJ5IHRvIHNheSBpbiB0aGlzIGFuZCBy
ZXZpc2VkIHBhdGNoIGlzIHRoYXQgZXZlcnkNCj4gYXJtLHNjbWkgaXMgY29tcGF0aWJsZSB3aXRo
IHlvdXIgaW1wbGVtZW50YXRpb24uIFdoYXQgeW91IGFyZSBzYXlpbmcgaXMNCj4gdGhhdCAweDg0
IGlzIE1JU0MgcHJvdG9jb2wgZm9yIGV2ZXJ5IGZpcm13YXJlLCBRdWFsY29tbSwgTlhQLCBTYW1z
dW5nLCBUSSwNCj4gTWVkaWF0ZWsgZXRjLg0KPiANCj4gSSBjbGFpbSBpdCBpcyBub3QgdHJ1ZS4g
MHg4NCBpcyBub3QgTUlTQyBmb3IgUXVhbGNvbW0sIGZvciBleGFtcGxlLg0KDQpZb3UgYXJlIHJp
Z2h0LiBJIGFtIGxvc3Qgbm93IG9uIGhvdyB0byBhZGQgdmVuZG9yIElEIHN1cHBvcnQsIHVzaW5n
DQphcm0sc2NtaS55YW1sIG9yIGFkZGluZyBhIG5ldyBpbXgsc2NtaS55YW1sIG9yIGVsc2UuDQoN
ClBsZWFzZSBzdWdnZXN0Lg0KDQpUaGFua3MsDQpQZW5nDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQo=

