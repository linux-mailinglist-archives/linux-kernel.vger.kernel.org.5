Return-Path: <linux-kernel+bounces-132321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AA7899305
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 04:13:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D35288CD7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 758B5FC1D;
	Fri,  5 Apr 2024 02:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="j425rqY0"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2117.outbound.protection.outlook.com [40.107.21.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB3828EC;
	Fri,  5 Apr 2024 02:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712283213; cv=fail; b=srlSW3KFbeqbdjGNJ8Ikku2lMMpGnP315oWl6AoohGr2a2CIXrmV0m6QbWAHsEwzA6+o31BW4+GUVJFTFbve74cvdQGbmY/hL9Yuu/vyTsWs8RJ2ttvlSUWw7YO3RNuCGBrozJkY7WkeXPdhPJ42+9yuzUen/zDEha5piWR9yAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712283213; c=relaxed/simple;
	bh=i1TnuTQaLbwpjTIKQA8lOAaHcWxetg07Sa+kRzqdUhk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ROwwKvmJ/vxcyIF9/RIqEvvU2SitDjnAnP8e1w7NRR8/kJl7ndIZaop+yZSPaEiCMX0sUsHrHtXfPffqjrSPKeaut5ip37ygrfEXK83mnTdbqnJr8zg/ZBYZ0Hk/kfgFs0F7DhWEgZARobuWFDYU9pRgoCnxGn3Jp//wbaMU/GQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=j425rqY0; arc=fail smtp.client-ip=40.107.21.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8HIcKCaa7dvXjpsArxuir3m+4MZmZ6DrQlBBHbXscR8LUkw21DJg2MqjEnHnJtH0NiHMc7Vrun2fAOBEuPGHjZJF/QuFmzrM57HR+59MwQXIP5s8u9KrgGwrUe3x4yTbS6F5kDHiAtFWvovIVZeADVspBZLZPQ598u7bDdb0Zdh/K7mgauDFWPQI7X7EqUvDVxNizqTE/2rKx0YGaSHuJ88T9dtvtEnCktK6+3G4zaT3F4TnB794mahb2fLwYl8mR2kIKIloaVZ4ILRRH+ApNrIFtM6lSSz7Utb9Y3yEob7X91YGyMA9w7//Y15gIRkeyjo6F83i6eKfcD+TG6uXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i1TnuTQaLbwpjTIKQA8lOAaHcWxetg07Sa+kRzqdUhk=;
 b=TXDFBqiw46jc/lA9h8ULg0qxfDKEk8/yzLHwdwDC/vpd5Tyh7qfZnvasTwQ2thmRNcjd4XnIp66HDE84xF/psoMPDv3fA6XMykOak/HSqxgzpbPgKnDHqBkcAoT1tBS07sejZASE5kR3gqYx0mPxzR/Y7RZ0bZ6FpGOxgFDJBE+8jQwcGnC0WzoWNiJfeXCN1A9qFb6hCikJAL7Qf6DhMVuiQYLa5Y+7b5aHvkJwalf7v+mH0SBJVO5OikrJNh3DF17f+91OiQ6jsH9Yvcm1LKYncqcBg4TC7pCujvYlmtiex/bqnLZizcQ6zVbAMT2AISc8F+YFVgND+yvgXSt/kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i1TnuTQaLbwpjTIKQA8lOAaHcWxetg07Sa+kRzqdUhk=;
 b=j425rqY0vPuQvOVeqkyoJOYulsxXfQ7xzKhrq1/nqLSrBJO7yMZQwhuTzM44RGnqku97qFRC7fWHFffS9dAGU3JYjVaihv2aKP+kD+D6c35CKeF4elmRCM5+wmM05RuEloY5GPdwyd79jWB8F95KaOFLkaTBl5wb6u8Il0ld5OY=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS5PR04MB9944.eurprd04.prod.outlook.com (2603:10a6:20b:682::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 02:13:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 02:13:28 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Linus Walleij
	<linus.walleij@linaro.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "brgl@bgdev.pl" <brgl@bgdev.pl>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"cristian.marussi@arm.com" <cristian.marussi@arm.com>, "sudeep.holla@arm.com"
	<sudeep.holla@arm.com>
Subject: RE: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Thread-Topic: [PATCH] pinctrl: pinconf-generic: check error value EOPNOTSUPP
Thread-Index: AQHahD061iAgiLB8lEGowmwPJFPUgbFYAoUAgABZeoCAAJiwoA==
Date: Fri, 5 Apr 2024 02:13:28 +0000
Message-ID:
 <DU0PR04MB941777DA29D70013342721A788032@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
In-Reply-To: <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AS5PR04MB9944:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6x8Izo2MAuz4PIoCsZEE6SIl8D/k6+GuRRQoI6V8uVcLy6RnqJZVFMpkCeDFwLuFGgLpfxkYUA+hORoZaUSA2mYA6O67ye0UF04d/fg2HDjQo+b79DjUJ/4Cjc1/lOkVfOqkaR4muAPfhoCRaiocFVmMcOJuK5GGFBLhmw8rnIeocvFymVpa2Vi+mCG6MUasapS1E8jUHeEY4EIYPDD/qwo/EVzWJMMZPU1lgowznP1hWrXM9QwX+kDHijevlpEpKDnIaI9Pc+roN3/tbzuo0WkCwZnxi3Q4vYbZwP3v9kbnohc3BUSdQvasuV4RTq8AiJjgXMnDYju5A740fNcoNtGYEOGXtPM6Ex3kyGhqofY7Es9d0M49XFPHWQ+zdD4OOo49d17IlZO9iC4o2r3nZ3mxpZ5zM71hUNkEU39syE/uZWXc3QyV+9zhIN96VyusW01VjiRfVcEYjOwZSM8MTxmTo1vnKcp320wiKDMjPXIYjG9+mrtF2PR2TQX0P8pjCbISLaoHUeO5xHaLpCsBLSCMYf2wb6CjpbUSHk0ey8XSJsi36DhIeOEYa4+9DKNLPpdN+PGxUlNMZZfLAW8hNg5knR6cr5UBRJ+V/vHnMBQycTLXboOxs6Ovz576TFahgfnXlKbzIfYGfIfr0wUmWb7aEaDNNhp1SjD7Gz0sjSU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MktxazI2eTZod3hrMHM1eGVpNUgxUTFHNGsvVjM2d3lzdDd6NncwemovOExY?=
 =?utf-8?B?M29Vdm5lcVNNNWdEMTBlVGY5eHI2TDZWMGw2ditROEt1RWlJeldkZkw4Qjl5?=
 =?utf-8?B?a3lqWGdQaHNYOUkxbXdVUmZsU0tDa0VaVi9sMUhHemtnc3hZUkxsSzlrN0tJ?=
 =?utf-8?B?REw1Y2hxNHhyMmR6YnN1cDN2L3FyeE5uZFN0OWZubHAvVGJDeVpDWGV6MFRC?=
 =?utf-8?B?ZDRFQU5TK25BaUlHTXBDN3VFcHUyM04xRlovZHA2amdLRFRQVXpPYVo2d3B4?=
 =?utf-8?B?dG9jb3lRUmR3R0hrR0lPSlc5dXdCdFlqb3Y3UTB6U1VwRGwrN21Fd0hmbURm?=
 =?utf-8?B?S1k2dXdjMkVJN3Axak5XcmNQUCs0Wm0yVVhpU2s1Skh4VGUva2Nuc0pwRGdk?=
 =?utf-8?B?QU1oaGJHaktyd0Zia1pRQW5uTmoxRmlyaWxJR0xrOU5DcW15U1QrRUU0SExx?=
 =?utf-8?B?RnhNZ3NOUmJpSnl0ZHJ3TkRzTGFmY3ZuQUFPbXUwcGxQbVpKRVk0eGh2dkdy?=
 =?utf-8?B?SVVVZHJFdHpjZFg5aVRwSTlIODBGMTNGV2Y3SVJnWnpFRnFJNDVUaUM5aXFv?=
 =?utf-8?B?UjBUZDY0bnVBVXZrQktFeWNtcEZjSkJSQjNTTDYrZjFnS0FWODd2QnZVRHkz?=
 =?utf-8?B?bVk2Qmt0YmljN2JCU2NuZnJtOUNZZUtQczVKQ20rajJDcEw4Nm9PekhPNk9Y?=
 =?utf-8?B?YW5FcnhGQXZ6WXZjUEUzVDNIQ3pjU01zNEQ1K0pJWXR4cGRudEs0MnM5ZXhu?=
 =?utf-8?B?aW9CV3FnTXRJNWcwbnQ3VWJsajhlK3dLemdFT04yZytNeG9sS3JCOHZmMkVJ?=
 =?utf-8?B?ZXhjeC9vWFM1aVBBNnJEdjBYcVo5YjBrWnd1RVQ3UGw3UnlqNjVFWVN3Mk1K?=
 =?utf-8?B?bEpCRnd3OGNIUC9NUUJ1cXBYOFNza0lJVURhamE3WFh2V2xqb3k4U2w1a3Vp?=
 =?utf-8?B?M3dzT2VaRnR4YU9GTUljYkNVSGxMRDZyOG5CK3RzdG1VZHBOblJwdVF6YzVG?=
 =?utf-8?B?WGh4TUhSN3VxRnBDeGljbFV2ZncvMHR3aXNMRFQxNTJZMlIzdS9XUG5vU2FC?=
 =?utf-8?B?L1Y3WXpOL2hreVBOUE15MVI1V2J5Ny9ya1pkdDhrc1JyeGt6eGFWRjFPY1Vx?=
 =?utf-8?B?M3V0cHBXaFNubmkwTVF1aEFiMnJlWDc0Mkh0UWdHNVJlaFZHUnZZeXRGUUhh?=
 =?utf-8?B?M3pGNEJsTmlrdmliZ1BDeFNFUVNUb3BPNUNMT05RWHh6eEtjUlBEQnhVVkJF?=
 =?utf-8?B?TE8vM2xjKzQ3RG9mUUtOdnRIemRhYVdMbHhCRFY1eXFBdHdUbmppMmZNamdR?=
 =?utf-8?B?WkhyVzh5dEdmZmxyaDlLV2ZBK2Qydk1HMVZKbHFBbmhkNEpOeWdSbUMzQWd2?=
 =?utf-8?B?TUtUUE5oYUZpTnpzYjlaeXhuK0dsZXg3MCs0YThYaEZsaWxTSDBQKzJIcHly?=
 =?utf-8?B?a0kxSCtENTRTRUl3V2poaWtnTysxWjVLVytkT3JhbG91QmE5UGRxUmU3V01Z?=
 =?utf-8?B?a3dFWXZBQXNzTDlRZGRyekJ3QzhTcVgyUnRiNDJIU0ZhaE9ObVRCaEk1cTlZ?=
 =?utf-8?B?bGVPT0YwQm9wL05KTm5oMHJsQWlWZURkZmJwSjF4VjN3U1UwdnJnd2gwYjJR?=
 =?utf-8?B?LzE3SmNmNU16ZnlJUUN6SHpLdU9tYXkwVHpnTVg1WDgybjIyOTVsS0xNL3lW?=
 =?utf-8?B?K091dFlvb1JweHVYaThVaHNmWVpvVFdNaitjVFkwKzdsaWZsS1dNUnhxelVQ?=
 =?utf-8?B?N21ndGp5cVlCdmQzTFpzVldzeFcrY2JTVXhqMUQ1Y2JnV3hQVWRsS0R4NlpJ?=
 =?utf-8?B?Yi9JeXBRNXZIRmJpemlKRi94SlhpWHFHSnlkQVAyaXRIWWtiMWNhdmFxeG1V?=
 =?utf-8?B?c0QzVlgyTHgrbDFGUWxvaTVSSUFGVlhrYVNSTUV3YzhoemhjWGNxc0hVYmo4?=
 =?utf-8?B?T3R3dGl3d1hjTHdqY2pLWStjRm9RYTlXemxGTWhqRDdFRy9Bckx0MXYxdDB3?=
 =?utf-8?B?azQxdHNEZVB6czBpMk9WR1RVNlBmWHN6NFNUdGg3UE1kKzVTbzg5dVBXbTFs?=
 =?utf-8?B?ZFdwYS9uZng1RGJBRUhPWS9QMGhqNUtha1dhMnFNMkpXWnRJeG9MQ2k4MWRi?=
 =?utf-8?Q?B2vs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 120eb20e-c588-4df5-dcd8-08dc5515fba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 02:13:28.4216
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GOOupHmSH+3+OhkMU1nkZttQYel4MU1bTmJR8kwEWuj1xSpDXYmmQo5AIwYqRlk8WO2uGTo5lUrn8x3RW3DLBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR04MB9944

SGkgQW5keSwNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwaW5jdHJsOiBwaW5jb25mLWdlbmVy
aWM6IGNoZWNrIGVycm9yIHZhbHVlIEVPUE5PVFNVUFANCj4gDQo+IE9uIFRodSwgQXByIDA0LCAy
MDI0IGF0IDAxOjQ0OjUwUE0gKzAyMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4gT24gTW9u
LCBBcHIgMSwgMjAyNCBhdCA0OjAy4oCvUE0gUGVuZyBGYW4gKE9TUykgPHBlbmcuZmFuQG9zcy5u
eHAuY29tPg0KPiB3cm90ZToNCj4gPg0KPiA+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54
cC5jb20+DQo+ID4gPg0KPiA+ID4gVGhlIFNDTUkgZXJyb3IgdmFsdWUgU0NNSV9FUlJfU1VQUE9S
VCBtYXBzIHRvIGxpbnV4IGVycm9yIHZhbHVlDQo+ID4gPiAnLUVPUE5PVFNVUFAnLCBzbyB3aGVu
IGR1bXAgY29uZmlncywgbmVlZCBjaGVjayB0aGUgZXJyb3IgdmFsdWUNCj4gPiA+IEVPUE5PVFNV
UFAsIG90aGVyd2lzZSB0aGVyZSB3aWxsIGJlIGxvZyAiRVJST1IgUkVBRElORyBDT05GSUcNCj4g
U0VUVElORyIuDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUGVuZyBGYW4gPHBlbmcuZmFu
QG54cC5jb20+DQo+ID4gKC4uLikNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9
IHBpbl9jb25maWdfZ2V0X2Zvcl9waW4ocGN0bGRldiwgcGluLCAmY29uZmlnKTsNCj4gPiA+ICAg
ICAgICAgICAgICAgICAvKiBUaGVzZSBhcmUgbGVnYWwgZXJyb3JzICovDQo+ID4gPiAtICAgICAg
ICAgICAgICAgaWYgKHJldCA9PSAtRUlOVkFMIHx8IHJldCA9PSAtRU5PVFNVUFApDQo+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRUlOVkFMIHx8IHJldCA9PSAtRU5PVFNVUFAgfHwg
cmV0ID09DQo+ID4gPiArIC1FT1BOT1RTVVBQKQ0KPiA+DQo+ID4gVEJIIGl0J3MgYSBiaXQgb2Rk
IHRvIGNhbGwgYW4gaW4ta2VybmVsIEFQSSBzdWNoIGFzDQo+ID4gcGluX2NvbmZpZ19nZXRfZm9y
X3BpbigpIGFuZCBnZXQgLUVPUE5PVFNVUFAgYmFjay4gQnV0IGl0J3Mgbm90IGxpa2UgSSBjYXJl
DQo+IGEgbG90LCBzbyBwYXRjaCBhcHBsaWVkLg0KPiANCj4gSG1tLi4uIEkgd291bGQgbGlrZSBh
Y3R1YWxseSB0byBnZXQgdGhpcyBiZWluZyBjb25zaXN0ZW50LiBUaGUgZG9jdW1lbnRhdGlvbg0K
PiBleHBsaWNpdGx5IHNheXMgdGhhdCBpbi1rZXJuZWwgQVBJcyB1c2VzIExpbnV4IGVycm9yIGNv
ZGUgYW5kIG5vdCBQT1NJWCBvbmUuDQoNCldvdWxkIHlvdSBwbGVhc2Ugc2hhcmUgbWUgdGhlIGRv
Y3VtZW50YXRpb24/DQoNCj4gDQo+IFRoaXMgY2hlY2sgb3BlbnMgYSBQYW5kb3JhIGJveC4NCj4g
DQo+IEZXSVcsIGl0IGp1c3QgbGlrZSBkb3plbiBvciBzbyBkcml2ZXJzIHRoYXQgbmVlZHMgdG8g
YmUgZml4ZWQsIEkgcHJlZmVyIHRvIGhhdmUNCj4gdGhlbSBiZWluZyBtb3ZlZCB0byBFTk9UU1VQ
UCwgcmF0aGVyIHRoaXMgcGF0Y2guDQoNCkkgc2VlIG1hbnkgcGF0Y2hlcyBjb252ZXJ0IHRvIHVz
ZSBFT1BOT1RTVVBQIGJ5IGNoZWNraW5nIGdpdCBsb2cuDQoNCkFuZCBjaGVja3BhdGNoLnBsIHJl
cG9ydHMgd2FybmluZyBmb3IgdXNpbmcgRU5PVFNVUFAuDQoNCkJUVzogaXMgdGhlcmUgYW55IGlz
c3VlIGlmIHVzaW5nIEVPUE5PVFNVUFAgaGVyZT8NCg0KVGhhbmtzLA0KUGVuZy4NCj4gDQo+IC0t
DQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQoNCg==

