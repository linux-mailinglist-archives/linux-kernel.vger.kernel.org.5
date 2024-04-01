Return-Path: <linux-kernel+bounces-126405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 249EE8936DC
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 04:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC0892810A2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 02:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6304322E;
	Mon,  1 Apr 2024 02:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J0j0wUSF"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2119.outbound.protection.outlook.com [40.107.14.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CD5A59;
	Mon,  1 Apr 2024 02:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711937614; cv=fail; b=fJQJgWd53Yl2t7DmCDpk0NA51AtdIVi5paFJ1PsgDK6ci8G5pakggCt7cHvnOjSNXTMUd9Y08WpMkn7gSp90Sq9Gcciv+kN+55FIvGfSBSeaBHU/MovDdFDLaX3Z4RdszMQooxxZqF54XlX6tRFuO7TYrqxjfUJ27cjVZzfgCnA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711937614; c=relaxed/simple;
	bh=LMsZY4AD1ZvGai+xToJ8HfAK5oAaZ6Xorcx5NX2+JG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vf948T7Jx0MoN+4Z17Agrs559MYQwk0F44shJUvURLDUe4RJw8XKPZ6DbzNVwBmYONMUT4JSPlMUlNXvAvCef2IZjJZbRHzO1FeWfMXQiBUownHLi7G4JpraVqb+vB1TTt1zP7KedTsXkvMtLqQMq/xg1ijE7aGliVk2NslKKLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J0j0wUSF; arc=fail smtp.client-ip=40.107.14.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bY5JY+fJmwZP7ZlxCPD9UB4aApUWCla2RufrqS44S4U8oEcLoyLDkCYI9NuN7f7VXdZJm31K8tuGlo7jOOFav36mtiEO2qaY+o64wz12tJuhow49mPfrA0FFnEFTxq9+t6iC6AUsn41OqvuMANSIbA4jDzKAvnBFFILwrvyin7kUbT1iDDEDKqy9w7YIQ2Xn32rxGUXGLhvtctXR9mFafnMPQ/XxwNACW6rCcm7TKKnpzBlzPjJd5LnO8B7OAWYwa+uzBSssvy0zPdKLZ7Q5rNPAU8jH8n7YkdZLGhP2XeR/VUYBrJYMqKlr+EfLEB4tNHjMsgnIApO6EMV1Ks5AnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LMsZY4AD1ZvGai+xToJ8HfAK5oAaZ6Xorcx5NX2+JG4=;
 b=FXTPutBJJhqJuIuDxQBbL0aXQSWHNDMUR6CK/PGsxd3lQ6DusO277dmgOebDbZIDVtmAd+k7Le/dCUlBOkeorivcoic+bZ/yM43cGk3bA7LgsgT0qS81ScWbc0eWXE3aPFsgFXXs1EmN531rc7Euf2+3cOe0cfeG9YKeiPTws1vRUyzRkdnihiUA2t+fdwWTl2eCjrvrwY7lhvCKrkFWcanNUScL5mMlmgJHYgUrskAOKfgHoCT/YcGnFcH+CzwKzILAHe3w8+/I94TmIdb9zqOQcRC6qSIRolG2InMD2dAeLjpDsr7YquDRyTlXfSR4PZWYeeKqRA7U0vHv7GWKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LMsZY4AD1ZvGai+xToJ8HfAK5oAaZ6Xorcx5NX2+JG4=;
 b=J0j0wUSFl7yxAd+AUJ1GdiP1hwqIBXXlpzb6szX1fiR91hF/Bu2miwIim0/rsBFsZDqZPTLoumpo8Pknf8HCU4jeCW+ZJVEkTfFLSepFELWMXcVuP3Djyj9rau/eM3Yhfh+DVbT2D5u9hIzuGb0qN9mvbGpFri+472fFrGJjgKM=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7414.eurprd04.prod.outlook.com (2603:10a6:10:1a0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 02:13:30 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::5dad:f991:ed59:3123%5]) with mapi id 15.20.7409.042; Mon, 1 Apr 2024
 02:13:30 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, "vkoul@kernel.org"
	<vkoul@kernel.org>, "kishon@kernel.org" <kishon@kernel.org>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, Frank Li <frank.li@nxp.com>
CC: "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [v1 0/3] Add i.MX8Q HSIO PHY driver support
Thread-Topic: [v1 0/3] Add i.MX8Q HSIO PHY driver support
Thread-Index: AQHagbLY3navoPljxESuLsicYqwT8LFQLsqAgAJ1/iA=
Date: Mon, 1 Apr 2024 02:13:30 +0000
Message-ID:
 <AS8PR04MB8676285A0B87F499E95155698C3F2@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1711699790-16494-1-git-send-email-hongxing.zhu@nxp.com>
 <0b5997e9-97b3-4863-87d0-b70e9d051d42@linaro.org>
In-Reply-To: <0b5997e9-97b3-4863-87d0-b70e9d051d42@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|DBAPR04MB7414:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 W3ikWBDisIedIRwbjPNC7bo34KkNUx2u/BETjPZ8s2c1COgZM5E/uhWO4zRy7dWIpUyVcKnCEnDbgBGs8x06rL/YloafWWv1yrggT2PDOhmbvu3myyFpJKUOIkKH/ey7Ug87gMWua3TV+P0oSDFJBsQ3qzoYmEhNfRBHzLXh3AGCX/774njREX9Zq0meszD0iqpSsb0gtNCtQGNTjqfAnDZ7RGy0LhweyIPVfME17aEY79mLKRVyEFRZkJIRprXn+VqCToyf6g2kcUAqr07cQMhHzR5ZDhPHi+Uc2cwdqtG9zWN+7Jz7pUpkzU1RkYRxChcmaaOUBON/+wM/S6iwKIT5wbzpE49OwJkgOS07WnJxwrkmjY7Ad8e6racmpbwOer+zo9YX+wPisVzwKrlgUdqPHob9gzpfwhbzh/RixzTWG8MJ1FCxhN+aLQ/FLQBH2VRJzpeXIImTZVKpsb9Xyf/rRc5veLbY7woCKXRSH7tKjVU4wapT6Zhw0a/LdBBZ33fevPGwxHe5Ynt1vK5J7jvVxkEyZ0/TRPOt+nJz6ZlrVhR7GvdlW6Ji4Scu4Ya+VQ/tBUuNYuU5mVULowyjlPyL9ZdHhy9i66bhiFl/vibR+CSCqT/vOEvJ6SMG56fwMRtgf8wWphCaHt3NDg5ENxQQY83irmQr8XrEr5ShjbI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXdVMnc2dFVOaW9JWlR3bkNPVCtiT05Yc29ob0ZUWndKOTdQRDcwU09NTWUx?=
 =?utf-8?B?ZHZNR0Rjb1U4eHE0RmtXNlBOMHNHdUlwRFlpUVhkcTRvcGk4VTZsYnlBdHht?=
 =?utf-8?B?VjRWZStNV0JsUjBZaS9kcTB5cXh0cHZWK2xaQ2toWm0yK05scW1EK3FuY0ww?=
 =?utf-8?B?OTYxVzQwbVNXa0JTdFdRTzEvazRoR2lzckFiRUQvYkF4SE8yb3hhTnI1a0Vn?=
 =?utf-8?B?dVp6bGk4aXphd2xEZENRQ2FXK2tSaXFKb1NZbEkzeGRVM0JLckttRlhGaGNV?=
 =?utf-8?B?dmt4dS8vc3p4Ym41NmZ0WGFoc0wvTGE1dW5ja0VmYllIQUlkNzBaakdZYm05?=
 =?utf-8?B?ZUVTWkFrN2lQblpzUm5yR0xLckhkYVBOb3FOR3lrWkxnNU5pZjhsM0R2OUt5?=
 =?utf-8?B?STV2SGRrT0hyOUhoMUVuajFhVWxyVUk2SGlxWnRkaHA3YlFQaVJpeWNnNFh0?=
 =?utf-8?B?T0VLbC9CUzNveGNpbWZKakFWWG43VmFxcVMzZkR0WVRUSDlBdHRHdkpLM2ly?=
 =?utf-8?B?cDhRZjRzL2JJZW8zM21CUkh5anR0VlNHYVR2RktaN0x2b2wrZFlMMGZweFNR?=
 =?utf-8?B?TndBV3YzSDFRWTFha09SL0wvUEE5NWdCcUJ4bDE1VWwvaGlZMXA5MnRsN0Fp?=
 =?utf-8?B?WTBaNytVMWZOL29pa2NaYUkveWJ1YlQwdk9pODhwaTFpeXRPMW1QUTFBeWNL?=
 =?utf-8?B?b2FtcXZCUVRiUUlKZVY4ZVhSZkRROHhZeGppOUhiYmI5MlEyR2czeEd1Njkw?=
 =?utf-8?B?eTROalZMbFNWc3lJS2h5Q2M0OEtoZVVSOUw0SXhWdHIrMTJTYTExRklGMlN0?=
 =?utf-8?B?WlIrZWIzWjdReEtlWDdERXQvSVZwL0tkNmJFdGlmYTdtWlhMRGRHU0JPNjNu?=
 =?utf-8?B?dU9UV0JJNmRFcHJtWVF1S3YwUUFsSzJoZ1BGSWNURVBxdGc4R29QdER1Mnh0?=
 =?utf-8?B?RlQ1T1BYaDdMMFZSZGl6V3V6Wmo1Sk5FNXd0bVp6ZFJtNGRFTTZUYTlIN1Jz?=
 =?utf-8?B?c05UNGRNKy92WGdOTkw3R1NOZk5Edml4VFpYcFl3RkxqN2dGSkV0Q24xRDla?=
 =?utf-8?B?a0lSclRJUDYzTUVjYkRmYlVsZGdPZ3RBUjF0bklPNHRvYW1BS2FmR1hUbmps?=
 =?utf-8?B?cjk4MTM0TzZua1lvd0VHbWNVOGlkbDhEbU4wVVVuT2xuZTFBek9WYk1oVXVx?=
 =?utf-8?B?Zlp1SVU5ZXEwU25xakVoNjlZVENEeS82eXU3bG9FekozZTlnaXpYdmtETDAw?=
 =?utf-8?B?ckdwcytwVXRqcEowanlnUjJPY0UwUUJjQmVDS3A5VEljWno2RzFMcDhQNGJV?=
 =?utf-8?B?dTk1VmVUd2Z4aW9lZlpld3RMaFc5SkNsRlhvZk9JRzA5MTFwN3hJYW81cUpo?=
 =?utf-8?B?eVpiVDkwZ01zelR0ZERjNGduY05YM2t0YS9xbE5ldCthbkEvQVEvWTZSQ0Jl?=
 =?utf-8?B?VldrVk51TG5oRmgvSDlJTGVIa2lzT0IvdXd3ZXdWMWpUbTVQbnhmTmsyNjJR?=
 =?utf-8?B?VTQ1ZUFhSnBBRjJBemloVWpzRzZ0NmNuYzBHTjMwWXZ2VmlhVkExMzR5Sk0r?=
 =?utf-8?B?T2NTNDZNdlRGN0JONmxBcnlPbi84bHpveWRQMGZrUFRYeVNhTGJPU092Tyt1?=
 =?utf-8?B?ZlVpVDlZRGwrMUQyb3RpNzFYQ2EyT000VWlBaXF3a0Y1L3ZaYmtCSXN3WWJD?=
 =?utf-8?B?S3NtMmcrUUlaVlRDLzBpRzZWSm4reGxiWllDQTM5cFFrNVFIZ0hLb2ZwYlRv?=
 =?utf-8?B?RDJIaDZpT2pYeDMvVUJrMDJWZ3FqMHBrVkhkOWh3RjJqK0J0RERIaGJjNUZ3?=
 =?utf-8?B?QnZobVR1L2JXemY3eTBEVDhQYXpyeXloK0wxU3ZkYnVmRy9pUjZnSkRzdHVU?=
 =?utf-8?B?SU83MWYwNDF3UWUwTU5QYm0vVnp1V1lOUGw0SkVLTkpVcXFEWEFIMmo0NFZy?=
 =?utf-8?B?MmF1UkhYNFdoT0wwWUtNYy9oZ2c1d1lrY0YzOFVZRzZIVE9JMEZvaXAwL3RV?=
 =?utf-8?B?UThOSVRtQjlnQlBHZnN1QmNibzg4L1VyNGs0QnZ3c3lJRUlZOTRMMENkbGpT?=
 =?utf-8?B?eVkycFNsWTgrT2FtQ250ek1jbHEzS3FHWThpNENvVHRQSjZBdTE3c1pSVGl1?=
 =?utf-8?Q?d4I99k/tfna7lYBp5Dg8b5x8J?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 431b0b73-ca49-4118-c04f-08dc51f152f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2024 02:13:30.0469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Z0UwpwRoL8p1hdyxve8S1hEjJnA4Y3CmzRsux+79IAJihhM8dNqcEWNknf/WMKoPVch72fHaAEyOBXdCvS7xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7414

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296bG93c2tp
IDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+IFNlbnQ6IDIwMjTlubQz5pyIMzDm
l6UgMTk6NTUNCj4gVG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyB2a291
bEBrZXJuZWwub3JnOw0KPiBraXNob25Aa2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBr
cnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7
IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPg0KPiBDYzogbGludXgtcGh5QGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGtl
cm5lbEBwZW5ndXRyb25peC5kZTsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT4NCj4g
U3ViamVjdDogUmU6IFt2MSAwLzNdIEFkZCBpLk1YOFEgSFNJTyBQSFkgZHJpdmVyIHN1cHBvcnQN
Cj4gDQo+IE9uIDI5LzAzLzIwMjQgMDk6MDksIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+IHYxIGNo
YW5nZXM6DQo+ID4gLSBSZWJhc2UgdG8gdGhlIDYuOS1yYzEsIGFuZCBjb25zdGlmeSBvZl9waGFu
ZGxlX2FyZ3MgaW4geGxhdGUuDQo+ID4gTm8gb3RoZXIgY2hhbmdlcy4NCj4gPg0KPiANCj4gSSBm
b3VuZCBzb21lIFJGQyBvZiB0aGlzLi4uIGNvbmZ1c2luZyBzbzoNCj4gMS4gdjEgaXMgdGhlIGZp
cnN0IHZlcnNpb24uIElmIHlvdSBzZW5kIFJGQywgdGhhdCBSRkMgaXMgdjEsIHNvIGFueXRoaW5n
IG5ld2VyIGlzIHYyIG9yDQo+IHdoYXRldmVyLg0KPiANCj4gMi4gT25lIHBhdGNoc2V0IHBlciAy
NGguIEdpdmUgcGVvcGxlIGNoYW5jZSB0byBhY3R1YWxseSByZXZpZXcgeW91ciBjb2RlLg0KT2th
eSwgZ290IHRoYXQuDQpUaGFua3MgZm9yIHlvdXIgY29tbWVudHMgYW5kIHN1Z2dlc3RzLg0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0KDQo=

