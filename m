Return-Path: <linux-kernel+bounces-128156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E853F895703
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15A4F1C2245D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5112BF21;
	Tue,  2 Apr 2024 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="fWguYj1O"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2134.outbound.protection.outlook.com [40.107.21.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4C93398A;
	Tue,  2 Apr 2024 14:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068530; cv=fail; b=pSPqR4IOV0+D2KMly4t6jhud5wi3Nw3KJ4dGJHIv/+PXF4kW/5rx7Wvgg5HXNUMNCgcpJHvbn4lZGzUuqdDNoLp12klsuoBqX/j2JOT3kqc9Hon8TzHh3wfh1omzVKyDaYpzwp+cHVbnenAzCI9PRgtW/g/PriCtqQlyml7nuOM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068530; c=relaxed/simple;
	bh=Dp/TDxAupL9LqTNjG0dbXvfcJQxLgsvm/s9y0u8MPGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ugtqy11gsij7BWYtLMVbxeRv/iUAY6Pi8nmPXIg8YeizEi15KIb1IfcFAS0zufltI0AO7nMaMmj4TorjUURp5qVVieQWDwtg+MbxVDqbXSNr2cOcxx5eQ6wm6NGOueC2RXWFR4mnkfDqc/fhS9JWWFYO5LpBjArEP4aawG3MeCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=fWguYj1O; arc=fail smtp.client-ip=40.107.21.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=miJWY1vDkItu3WpbkK6KCHWBahuiapBJN+LBbMC76MvKY/raAEkvZeTbAfiJvaa2h3QYQfP7typPQETz7YHu2JDri711Qditc89XZU8mTtNUNKpsXQuwNf1AtWuyr/67gJyJ8WtrF3vB1hLdo3TtSRkPoLxVsNi2W8t5q/q6eiYYPEb5RkgitkVkuuVfmx5YTDmkM4TCeRGF6rLiiXDghiVeaWp4fEnw3wXYbYanfas5iskrOQjUITNw5O+uWdNFZRvOoRdxGATMSARVzX4bffVhdoIIO08T+fkvmT5VkLl1/SpWClMjrkelGrxDSKAKkgAQp02UjQHGosNXFdGEpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dp/TDxAupL9LqTNjG0dbXvfcJQxLgsvm/s9y0u8MPGw=;
 b=NmFVQXGoQHDq0GOzMzxKjJCPrEBETkNmv0DwiYD7Nqai/IBr+wqV0fHR9OQl9bopy3WR9pgfcEIMZUqK6d03HZorVJ7SZfHgBRFgvEhgLbN91AbvCZkzVaH9QKmBl0FWNCHXUzDJUjYxI1AfaDHU6xfRfNEDZ18P7oJYhkxTiloEv8JzXlOtq0siSIF8fN3ccV6fh9IC2bcsIYmuQHhrxTJVJywaMkjArd+2L3z6Q0eDngdFAnSCvatMIhF56ivwu9/VZ0mbJTNUijQR1i9S2m9kBigxrUw6AONMf1nfe17h6WDZfQOdAn3mDeSzk1nh8SA7vnl7j2U4F8xwQA6TZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dp/TDxAupL9LqTNjG0dbXvfcJQxLgsvm/s9y0u8MPGw=;
 b=fWguYj1OTfqld2ZYlTsS1yrZTX4qCnQwhWrCtNZKvvftA+ql9YfCAXsBhi/C2v0CaPc2WzV6J1IRBhHZEsjx6nuPG+x12gpsoQvxToZ2tkVMvISh5sMYBunWtOubefPjoNRnS4ki8mTnVEtDITSryJFtPaBxRoE3hijynhLNxE8=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by GV1PR04MB10393.eurprd04.prod.outlook.com (2603:10a6:150:1c9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:35:25 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Tue, 2 Apr 2024
 14:35:25 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, Cristian Marussi
	<cristian.marussi@arm.com>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, Sudeep Holla
	<sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, Oleksii Moisieiev <oleksii_moisieiev@epam.com>
Subject: RE: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Topic: [PATCH v6 3/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Thread-Index:
 AQHafRqyofu9Mu9OLUiaociI+9q/i7FPHJwAgALIoZCAAsTtAIAAWKsAgAAO4RCAAAhmoA==
Date: Tue, 2 Apr 2024 14:35:25 +0000
Message-ID:
 <DU0PR04MB9417577359D12842852CF88B883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240323-pinctrl-scmi-v6-0-a895243257c0@nxp.com>
 <20240323-pinctrl-scmi-v6-3-a895243257c0@nxp.com>
 <ZgcP4IkTQGks9ehH@surfacebook.localdomain>
 <DU0PR04MB9417E797F4E0F7BB6154B3BE88382@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Zgu4Tok43W5t8KM0@pluto>
 <CAHp75VdAaTeQ_Ag3gd0s9UfT=kAT2hwibeJ9-YFXJx4z=R3e+g@mail.gmail.com>
 <DU0PR04MB94172B29B33AC0002CF6991B883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB94172B29B33AC0002CF6991B883E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|GV1PR04MB10393:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1hbQ/x1OmMaRPQ3OyU3YRXOSXsgs1CN3Znmom+75mbfuGLNz6G5csljnkEWOUS+eclgVwzVDes8NJFcdueI4hMQdezl0riMFBxHFn9WnM9GJonXN99jdiYbQd8pgdoY8E303YYq+yuA/KYeLw5dvG77Hrg+wXXNrinO5bkO/Y4+xpqMbIkxvc6xJ0hDfVVfgPha3tIOmZCXT1rarlt1Xg/igcK4xBy2fUIJKpBZD3zkAEO0KRV1lSmV9kIX7CWEwC0ymGKhl/Wad3VzF8Nf04gmkO17Ts5NCDxtm7sLObKBrtynNK/H7IopdoYHnNOsXn3RQ7K1T+3vn2IBOyF5Oow1AaouieZcrTgAfj20saCiRrNRs+NtqyG3mG9Oikz7+5nXBxFShDNYexYIYtvpeGwOkjz2qoHNyIfPtXRqBIxhr9jK7pEBUaIP06UOGDO8HdN5/aw44kn2gKv3k0Fu4AfKzpUZVupf91ZC2V/p7uvnsocb4+ENTtqK+vfY/F5NqvuuTm38nCUxrwusyXeu7foYSCyJYqvrbCEPobghArK4emtWhSlAOqziiIqC2rXrlk/lCKwMcQzZ2Zvt0h3aUh+HyCdWEUa03oFIY/WZaJvqRbg3g5LeXHnOzE8AUceVq8i+w/jdYEwxtWkz0Au+bPvu0PSb3Xxa/Jc715XVmg3o=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TmRKb3ROTFFJaWdXVHFWWmM2b2NQWTV3NCtrK1paMmtUTzBKenBJOENSR0FU?=
 =?utf-8?B?NFQ5MS9ISUZVa2daUGt5aS9zaTNINUo4STErSU5keW9aNW9tWHFwUG5nNS9B?=
 =?utf-8?B?b04vMC9qclIzVitLVUpqN1FQa1dHVlhzOTFIbldVWXVicVp4OGFvbUV2bVN2?=
 =?utf-8?B?eWU0Y0hPME53VUFHTlBDYUlZcjdjMXBkTW1JUHhpYzR0TWRXMEZmcjlZTWw2?=
 =?utf-8?B?VEpZdUEwZUFMUW41Szk4bm5kTjNpNFR2ZUFoUisyWXo5Y2x2YlNxSFVKMkcz?=
 =?utf-8?B?MFZENXZ6b0RmK3kwWjU4NXFYNTI3cW5kNjUyUzB6bUxyZDNaR0tlUExKbkhC?=
 =?utf-8?B?ZUJiL2NGNlVqR0prVlRRaDZ6dFY1YjFsY2JzMnkwL3ZLMTZwR1k4ekV1NHhX?=
 =?utf-8?B?OVNiRUc1RlB4Z0VqaGFrSFFETTExWDFaeVQxRDY3dkRPNUx5T2pGT2U2dGpn?=
 =?utf-8?B?WHBGeWM2Ty9HbVVSenRMRUxpTTZKamRkaFVzNWJ0MWFhZm9SVVhtWTJ2YmpG?=
 =?utf-8?B?OG1Zamo1VWRhdUMzL2VYKzZqMkV2SDNQU1k4RDY4OXI0RkNDeUFBa1U5bHM3?=
 =?utf-8?B?QWJEby96alZZTmtqUW1CdHZ5Q2JNYWswMDl1dXhuNEgyQzUzL2d1Q1RlR09z?=
 =?utf-8?B?VVRxdTBpMnNwbU1neXBhUjdiOEdaQ0hwakpNZFhxZWJ3eDUzVUEzUEVtdFgr?=
 =?utf-8?B?R0ZBN0FPbnk0ZENiME9MNkRWbHlLNkl4M2p6dnNhWWRiaXNiL3NtbDYraFRY?=
 =?utf-8?B?UWErNGd4QmxqaC9PMUJ1eitkWnFKU0s5UlVUQXlUVEgxNkRRMkZGd2pBUHcz?=
 =?utf-8?B?VXZrQjR4OStkRjJWQnV1c3JkSW1UeUc1K1ROa3h3ZzVqMmt4YWJGOXpNN2JF?=
 =?utf-8?B?RG1PUVVqOEZ3V2NnOFM5NFg4ODZraW5xY2FLL0tqeHplTldFcDIwR2k3akQ1?=
 =?utf-8?B?VUxvNHVUbVVRZUx1SG9POG1rT1FGcGtTaU1qUGFMdmVYOFpyaEVneTU2Smln?=
 =?utf-8?B?Z3RMMFd4NlBPWHdPeXJOakgzS1NibGQ5L29NV1VBOVo2d2ZCUjdmbWI0WUVl?=
 =?utf-8?B?TnB6alU3dTlaZGxZRXYwV2RUWXM3bGc3ZmdxYU9iSG1SQm1KcE1tUDhLc20y?=
 =?utf-8?B?MkNEUzdsUFRhelJ6Qm1WWU9sdnV0Nzk4MDFOZUc5Y0NJYjlDdklEMzRGdUph?=
 =?utf-8?B?QjBHMFVpdFJHNWVLVllzVmExbldWUzBKY3NFNENsODEvRXZKY0lDUS90K29R?=
 =?utf-8?B?cEJ3ampoSUlrVzZxcERYTENRM1Ard2FMeFhDeCs3NHR3SXBvd0JOcUVCcS82?=
 =?utf-8?B?U1dNRGg1RGZKNVN4ZzdjRXZmNmRDbHZKemFqc3diRnlzT1pabFl3dlNwRW80?=
 =?utf-8?B?SncwRU4vZmhPS3B0Q0ovUDVBSUp0Mk55SXFSYXRjc1JSWDgxTVQ3enFtd3pJ?=
 =?utf-8?B?ZlRONFppeUxuUk00OVM3MWRPRDA2NDRYWVhzOG40S21nR0NZaVFkRVQ5Njc2?=
 =?utf-8?B?ODYzNFNiY1dDaWMxd1ZKQkxaeStlMit2VkNmVXRNeW9DOU9UTjJSQ1dYZGU5?=
 =?utf-8?B?YTUvRlo0ZGFMaGwzYzR6dmhJdVV2SW5vaEZYMTk4MktVaFpMeU9DZWpQWG90?=
 =?utf-8?B?M0llZU11eGttWFdqVG9CTlJud0t3cFZ6cktNWDI0SWNXdklPT21UYTB5VEF2?=
 =?utf-8?B?eFU1NDdtdWRDWGt0ZG02VG84WWE2OEVPNkFpSWVWQmNJMFpNYmFKSnNPYnpu?=
 =?utf-8?B?RXNJdVpvV3FBRDFpb1ZwU0hRbC9XUHJydUpPcTlhYm5yZWNmTlNQaDk1SFA3?=
 =?utf-8?B?L2xQcGluVmljTDBFT0JjNDBYWnNCY1I2U2RuYnNGZWI5blhMVDMrY0RtZElX?=
 =?utf-8?B?N3hwR0YwRGFtSlduRGI2d3Bjbll2dHVJNS9iZVFTNnFvNUZ3TmNJNHFWWHZ3?=
 =?utf-8?B?OGtFT25jZ1cwMHBRY1plN3U2dTBqdkljTkc3S0J1c2FqbitNM3VIUGdLaG1x?=
 =?utf-8?B?cGNBRi81UXdES29oSjc4Wk11dFQwSS96VzB2MjdVZG5NMm9TcEEwNnBNMEpq?=
 =?utf-8?B?NkdLMW03Q1BFQ0RlUjQ2YWJZZVZOeHBzNUIvYVhOUEJJM1NSQmRDM1JIdkdX?=
 =?utf-8?Q?zb4A=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ea9eb4-08c3-4db0-8eb6-08dc532222a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 14:35:25.4277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p7KTOkdIzCHEnex6AkEwDgGDSexfImpnP4QSfteGgP01anOVJG7CiVto5N26LdO/xYnVB2z5pcGmFwXWHlp5KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10393

SGkgQW5keSwNCg0KPiBTdWJqZWN0OiBSRTogW1BBVENIIHY2IDMvNF0gZmlybXdhcmU6IGFybV9z
Y21pOiBBZGQgU0NNSSB2My4yIHBpbmNvbnRyb2wNCj4gcHJvdG9jb2wgYmFzaWMgc3VwcG9ydA0K
PiANCj4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY2IDMvNF0gZmlybXdhcmU6IGFybV9zY21pOiBB
ZGQgU0NNSSB2My4yDQo+ID4gcGluY29udHJvbCBwcm90b2NvbCBiYXNpYyBzdXBwb3J0DQo+ID4N
Cj4gPiBPbiBUdWUsIEFwciAyLCAyMDI0IGF0IDEwOjQ44oCvQU0gQ3Jpc3RpYW4gTWFydXNzaQ0K
PiA+IDxjcmlzdGlhbi5tYXJ1c3NpQGFybS5jb20+IHdyb3RlOg0KPiA+ID4gT24gU3VuLCBNYXIg
MzEsIDIwMjQgYXQgMDE6NDQ6MjhQTSArMDAwMCwgUGVuZyBGYW4gd3JvdGU6DQo+ID4gPiA+ID4g
U2F0LCBNYXIgMjMsIDIwMjQgYXQgMDg6MTU6MTZQTSArMDgwMCwgUGVuZyBGYW4gKE9TUykga2ly
am9pdHRpOg0KPiA+DQo+ID4gLi4uDQo+ID4NCj4gPiA+ID4gPiA+ICsjaW5jbHVkZSA8bGludXgv
bW9kdWxlLmg+DQo+ID4gPiA+ID4gPiArI2luY2x1ZGUgPGxpbnV4L3NjbWlfcHJvdG9jb2wuaD4g
I2luY2x1ZGUgPGxpbnV4L3NsYWIuaD4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoaXMgaXMgc2Vt
aS1yYW5kb20gbGlzdCBvZiBoZWFkZXJzLiBQbGVhc2UsIGZvbGxvdyBJV1lVDQo+ID4gPiA+ID4g
cHJpbmNpcGxlIChpbmNsdWRlIHdoYXQgeW91IHVzZSkuIFRoZXJlIGFyZSBhIGxvdCBvZiBpbmNs
dXNpb25zDQo+ID4gPiA+ID4gSSBzZWUgbWlzc2luZyAoanVzdCBpbiB0aGUgY29udGV4dCBvZiB0
aGlzIHBhZ2UgSSBzZWUgYml0cy5oLA0KPiA+ID4gPiA+IHR5cGVzLmgsIGFuZA0KPiA+IGFzbS9i
eXRlb3JkZXIuaCkuDQo+ID4gPiA+DQo+ID4gPiA+IElzIHRoZXJlIGFueSBkb2N1bWVudGF0aW9u
IGFib3V0IHRoaXMgcmVxdWlyZW1lbnQ/DQo+ID4gPiA+IFNvbWUgaGVhZGVycyBhcmUgYWxyZWFk
eSBpbmNsdWRlZCBieSBvdGhlcnMuDQo+ID4NCj4gPiBUaGUgZG9jdW1lbnRhdGlvbiBoZXJlIGlz
IGNhbGxlZCAiYSBjb21tb24gc2Vuc2UiLg0KPiA+IFRoZSBDIGxhbmd1YWdlIGlzIGJ1aWx0IGxp
a2UgdGhpcyBhbmQgd2UgZXhwZWN0IHRoYXQgbm9ib2R5IHdpbGwNCj4gPiBpbnZlc3QgaW50byB0
aGUgZGVwZW5kZW5jeSBoZWxsIHRoYXQgd2UgaGF2ZSBhbHJlYWR5LCB0aGF0J3Mgd2h5IElXWVUN
Cj4gPiBwcmluY2lwbGUsIHBsZWFzZSBmb2xsb3cgaXQuDQo+ID4NCj4gPiA+IEFuZHkgbWFkZSAo
bW9zdGx5KSB0aGUgc2FtZSByZW1hcmtzIG9uIHRoaXMgc2FtZSBwYXRjaCB+MS15ZWFyIGFnbw0K
PiA+ID4gb24gdGhpcyBzYW1lIHBhdGNoIHdoaWxlIGl0IHdhcyBwb3N0ZWQgYnkgT2xla3NpaS4N
Cj4gPiA+DQo+ID4gPiBBbmQgSSB0b2xkIHRoYXQgdGltZSB0aGF0IG1vc3Qgb2YgdGhlIHJlbWFy
a3MgYXJvdW5kIGRldm1fIHVzYWdlDQo+ID4gPiB3ZXJlIHdyb25nIGR1ZSB0byBob3cgdGhlIFND
TUkgY29yZSBoYW5kbGVzIHByb3RvY29sIGluaXRpYWxpemF0aW9uDQo+ID4gPiAodXNpbmcgYSBk
ZXZyZXMgZ3JvdXAgdHJhbnNwYXJlbnRseSkuDQo+ID4gPg0KPiA+ID4gVGhpcyBpcyB3aGF0IEkg
YW5zd2VyZWQgdGhhdCB0aW1lLg0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtz
LnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1odHRwcyUzQSUyRiUyRmxvDQo+ID4gPiByZQ0K
PiA+ID4gLmtlcm5lbC5vcmclMkZsaW51eC1hcm0ta2VybmVsJTJGWko3OGhCY2pBaGlVJTJCWkJP
JTQwZTEyMDkzNy0NCj4gPiBsaW4lMkYlMg0KPiA+ID4NCj4gPg0KPiAzdCZkYXRhPTA1JTdDMDIl
N0NwZW5nLmZhbiU0MG54cC5jb20lN0MzZjhjMTIwNjJkYjA0ODYwOGUyYTA4ZA0KPiA+IGM1MzE1
YmVkDQo+ID4gPg0KPiA+DQo+IDAlN0M2ODZlYTFkM2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3
QzAlN0MwJTdDNjM4NDc2NjAwMDU4Mw0KPiA+IDQwNDMwJTdDVW4NCj4gPiA+DQo+ID4NCj4ga25v
d24lN0NUV0ZwYkdac2IzZDhleUpXSWpvaU1DNHdMakF3TURBaUxDSlFJam9pVjJsdU16SWlMQ0pC
VGlJNkkNCj4gPiBrMWhhVw0KPiA+ID4NCj4gPg0KPiB3aUxDSlhWQ0k2TW4wJTNEJTdDMCU3QyU3
QyU3QyZzZGF0YT1XaG4zZWhaalh5JTJCY0tHNGlybFdqUTYNCj4gPiBLM0hGJTJGb2ZEDQo+ID4g
PiBZdTdqMExybThkTjVrJTNEJnJlc2VydmVkPTANCj4gPiA+DQo+ID4gPiBJIHdvbnQgcmVwZWF0
IG15c2VsZiwgYnV0LCBpbiBhIG51dHNoZWxsIHRoZSBtZW1vcnkgYWxsb2NhdGlvbiBsaWtlDQo+
ID4gPiBpdCBpcyBub3cgaXMgZmluZTogYSBiaXQgaGFwcGVucyB2aWEgZGV2bV8gYXQgcHJvdG9j
b2wNCj4gPiA+IGluaXRpYWxpemF0aW9uLCB0aGUgb3RoZXIgaXMgZG9lIHZpYSBleHBsaWNpdCBr
bWFsbG9jIGF0IHJ1bnRpbWUgYW5kDQo+ID4gPiBmcmVlZCB2aWEga2ZyZWUgYXQgcmVtb3ZlIHRp
bWUgKGlmIG5lZWRlZC4uLmkuZS4gY2hlY2tpbmcgdGhlDQo+ID4gPiBwcmVzZW50IGZsYWcgb2Yg
c29tZQ0KPiA+ID4gc3RydWN0cykNCj4gPg0KPiA+IFRoaXMgc291bmRzIGxpa2UgYSBtZXNzLiBk
ZXZtXyBpcyBleHBlY3RlZCB0byBiZSB1c2VkIG9ubHkgZm9yIHRoZQ0KPiA+IC0+cHJvYmUoKSBz
dGFnZSwgb3RoZXJ3aXNlIHlvdSBtYXkgY29uc2lkZXIgY2xlYW51cC5oIChfX2ZyZWUoKSBtYWNy
bykNCj4gPiB0byBoYXZlIGF1dG9tYXRpYyBmcmVlIGF0IHRoZSBwYXRocyB3aGVyZSBtZW1vcnkg
aXMgbm90IG5lZWRlZC4NCj4gPg0KPiA+IEFuZCB0aGUgZnVuY3Rpb24gbmFtaW5nIGRvZXNuJ3Qg
c3VnZ2VzdCB0aGF0IHlvdSBoYXZlIGEgcHJvYmUtcmVtb3ZlDQo+IHBhaXIuDQo+ID4gTW9yZW92
ZXIsIGlmIHRoZSBpbml0LWRlaW5pdCBwYXJ0IGlzIGNhbGxlZCBpbiB0aGUgcHJvYmUtcmVtb3Zl
LCB0aGUNCj4gPiBkZXZtXyBtdXN0IG5vdCBiZSBtaXhlZCB3aXRoIG5vbi1kZXZtIG9uZXMsIGFz
IGl0IGJyZWFrcyB0aGUgb3JkZXIgYW5kDQo+ID4gbGVhZHMgdG8gc3VidGxlIG1pc3Rha2VzLg0K
PiANCj4gSSBhbSBuZXcgdG8gX19mcmVlKCkgaG9uZXN0bHkuIEknbGwgbGV0IENyaXN0aWFuIGFu
ZCBTdWRlZXAgdG8gY29tbWVudCBvbg0KPiB3aGF0IHNob3VsZCBJIGRvIGZvciB2OC4NCg0KSnVz
dCBnaXZlIGEgbG9vay4gQnV0IHNpbmNlIG1vc3Qgc2NtaSBmaXJtd2FyZSBkcml2ZXJzIGFyZSB1
c2luZw0KZGV2bV94IEFQSXMgaW4gcHJvdG9jb2wgaW5pdC4gSSB3b3VsZCBmb2xsb3cgdGhlIHN0
eWxlIHRvIHVzZQ0KZGV2bV94IGFzIG9mIG5vdy4NCg0KQW5kIGZvciBwaW5jdHJsIHByb3RvY29s
IGRlaW5pdCBwaGFzZSwgSSB3aWxsIGFkZCBhIGNvbW1lbnQgb24gd2h5DQp1c2Uga2ZyZWUgYW5k
IHdoYXQgaXQgaXMgdG8gZnJlZS4NCg0KRm9yIHRoZSBfX2ZyZWUgbWFjcm8sIHBlb3BsZSBkcm9w
IGFsbCB0aGUgc2NtaSBmaXJtd2FyZSBkcml2ZXJzDQp1c2luZyBkZXZtX3ggQVBJcyBpbiBpbml0
IHBoYXNlIGluIGEgZnV0dXJlIHBhdGNoLg0KDQpJcyB0aGlzIG9rPw0KDQpUaGFua3MsDQpQZW5n
Lg0KDQo+IA0KPiBUaGFua3MsDQo+IFBlbmcuDQo+IA0KPiA+DQo+ID4gPiBJJ2xsIG1hZGUgZnVy
dGhlciByZW1hcmtzIG9uIHY3IHRoYXQgeW91IGp1c3QgcG9zdGVkLg0KPiA+DQo+ID4gLS0NCj4g
PiBXaXRoIEJlc3QgUmVnYXJkcywNCj4gPiBBbmR5IFNoZXZjaGVua28NCg==

