Return-Path: <linux-kernel+bounces-105646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4543B87E206
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 03:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F01A72820BC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 02:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B554F1E868;
	Mon, 18 Mar 2024 02:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Gd8bUvZI"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2085.outbound.protection.outlook.com [40.107.22.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C6122087;
	Mon, 18 Mar 2024 02:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710727396; cv=fail; b=YGuokZZd/7SJ/qzeF5WzKqFpmxMUEAeX9CroeJPYN2Ogo9/PKsTBUbaZFwJ2r7Lwz3z7RqSKPu6cy4maSOkrA4QIBEroBGfiNsOIHvyyQMjAlnci2OusUB53739aSLt+WOH5LlHEKeb2ybxi1E97OMcdTUXG9vFwoFfVWE1kXow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710727396; c=relaxed/simple;
	bh=oKw1AS6dwkhVySMYVe/4bBJN5PrDjbHtDu4rsnTqYII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NudYousHC3QKRnQ1x4Wu8ICgWKbavilfAbCgvmimgOIxEj1ymkBAxxlThdv9Bv0Lsq8uFBBA9f5nnOnU1vQdNFCUp77eM+Fl+y/kUieAuLE7ENzhiGLUFz/NK8JibOvaU+j6ySv+1hwoqh3Ey88BCQKhZOQzyiZlMwlAlwZVFPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Gd8bUvZI; arc=fail smtp.client-ip=40.107.22.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3KeKhmROvhEy9D4123uYX5KAunbBG+TgKYC4mt6OPjJSbicpZl/cuxh9+tla8HEWO0acnZY9CJ2tUO/z9r5BacYFYmtqVigEdmRVL1ZGwJ4frLDhVkxlfbS3+ySbir5P33UP9+uw6DsFOb9NDvqzJSIpGrs63G0JbBmwYIbMsfYlCdvdYmzQYvKLTkZU94aof01N9tX5VHB59FCWznu9NSaieOqkmunPGgyeaK2T1cOZ4AW7wWj9bNDLOM6CvN1GxW3XisJtn/Fwp0j+HbuGYVsO8GTt/TOt0TZSifJTI2+sfazzFh2EcJ05NupnPMSjNLcYdwqdCp3TTA81LuwbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oKw1AS6dwkhVySMYVe/4bBJN5PrDjbHtDu4rsnTqYII=;
 b=UHEZtj01debL7cygu6Ja1w2fQC7fIaPl0sO2v4B3xXEfGtO+d1KU8OAyC2nsj1hqh2k+hEw7YN7VuJ8kpDEFJu+UzH/FeyrCOUh226zlzM5wulLw4kDGOMDeRQPlNKMLbhrLwgdRTx89SpdNDavNW+WXX8NlNHhu9/azfGBZqhtO4BLaUcJ/IzojiRiHVohOqp4cU21UuKmAWygbptz+37fpaQw7sEWFgQBj/grqxWXmZdFM7UO1nbjbkzRtIWhtBRAYDH191X+E1ZJo8mtis/TKOVPHIwV3KPVywCYWfIkAF3Lhknw0K8aZrNXoDSCPYe5YMMz4mXdMk1zonSIJ/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oKw1AS6dwkhVySMYVe/4bBJN5PrDjbHtDu4rsnTqYII=;
 b=Gd8bUvZI0sfD5I5+ecIDbYukrWiDGjQSlQIza7cGS57LmOFpC1Gse5/xQh8NFS2gASXHkxDfdM1ubdqjyPicTT7+UZFsufKZSkMbilf8Ph+T3Kwd7BSXUMLfedY5b0QYHxQThcCC3O0zL/CpwBDiCB2NtMIhe+YIqTDI/XnBfo0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PAXPR04MB8224.eurprd04.prod.outlook.com (2603:10a6:102:1cb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Mon, 18 Mar
 2024 02:03:12 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Mon, 18 Mar 2024
 02:03:12 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>, "Peng Fan (OSS)"
	<peng.fan@oss.nxp.com>
CC: "linus.walleij@linaro.org" <linus.walleij@linaro.org>, "brgl@bgdev.pl"
	<brgl@bgdev.pl>, "andy@kernel.org" <andy@kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
Thread-Topic: [PATCH] gpiolib: use dev_err when gpiod_configure_flags failed
Thread-Index: AQHadnRqgo6ODiGIj0KTeN2TlhUMHbE4pmqAgAQc42A=
Date: Mon, 18 Mar 2024 02:03:12 +0000
Message-ID:
 <DU0PR04MB94177BC9D193116C9B4435D0882D2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240315011015.3106272-1-peng.fan@oss.nxp.com>
 <CAHp75Vf42b8uo+7c+WEQj5Kj8LRf3PxXeEpwEJScyw-PMeYn9A@mail.gmail.com>
In-Reply-To:
 <CAHp75Vf42b8uo+7c+WEQj5Kj8LRf3PxXeEpwEJScyw-PMeYn9A@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|PAXPR04MB8224:EE_
x-ms-office365-filtering-correlation-id: 88d24e28-6b76-4d73-1078-08dc46ef90da
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 E5uoEjC0m1Lq0hFYzFYZFK1zFzMICLqMEBWO1tAh6khICAI8rhaU5ZZRxtoEKTeIiPiorOL89fbamB5cEg6FkXqPiKQIHiCpxpqodEzhGk25C7HiSx48Nta9yLeYpMsxUK2LVl3ISqryrZq0rRt7B9ZKxgmAdbXp55Of1pf2h1NefSjoK4ycMVBbRtoEePRAVfyaV8iiJHTU79lVFyhxPAKCkLxwoyKAwQr1oDnVCuUFMIDB7+HrB9H8eLKPsOb2oqncAQbM13IVR3dGxlQIGjVvImybbE3FO55TH9Jta7rXp2AQx1J37b5n0RcoT7Rr2i9DBjvSTwMLaIpUE4Jo5aDDSvaZ1kueWrAMAM1ieH7uGhjZrC4N6OveN556iojqvX1Dv4Wwzr4COtFbVyt2VW7YeYR89q1qpx10IX1GjemBxwFobosmqN3+8OlUj2rWK/ggoeZFD9SVSXhAJpnC1f4yENjRxqSITK03JplJDjx+EPxQKDJrz9Ag8Nr1ES9THREy3RTD1J5RRboAJcWEfpKM6uNTWGwkAnzDkxg+kCdNp17h9rNDjEraE9rR2NR68lXodZn7+owyXOsHt0Kzb1Rgob5d1FmBKjTFsKRoAg7EfIt1K4jOuM5NyfKR9COdbM6BFtRwjvsn/uy3J4ifRpR8La9aPW1r3CQaGJh3udO2PbWxfEPc6J7q4eVyM/cXI4B9KolMvh4agUv9Cej67F9em12DiTom8Y6VlE0m0g4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N2NXVitxQlc0aGs3NWE4aDd4Ly8xUVovM3JmWVBJSnloc01JUnBPdXJHQ3la?=
 =?utf-8?B?c1RVeHI3UzI3MDZkZ0xUR1M5b1lvaFJZZlNaNlNZTUoyeC9lb2NHVU00d3ls?=
 =?utf-8?B?cWtUWm9SOXo4MUpzbXAxWWdqN1BnVkp6VnlJUVcwMFhKYVVkOHEwWjFBQ1hI?=
 =?utf-8?B?R3JLaWRWdDFrYmJHaFV3UldvemRUYjlrQ0xMMXVnOGptVGR0RFNBc0c3enVo?=
 =?utf-8?B?d01HR2l1NnhKV1VjOG5iSXEwcmxrdUZZb3FvdnNMMVdhT0MyYlFFZUR6cEE3?=
 =?utf-8?B?MlU1bkpwZmhJK244ZFVOaEd6UzNROVJONUxvS3piZHlDWE1veFZlWmtUdzJF?=
 =?utf-8?B?c042M29QT2VYbGtkWVJzR3k5dkhUTzVQM0lGZ1VrRWJhMHV0WXVDL0RHSzEy?=
 =?utf-8?B?Q3BaVzZLRkVVSkFWQ1VJN2RtamgwOWF1Y2k2OG1SSFYyUFRaTHYwaWNDWnlo?=
 =?utf-8?B?UHlSZkJKUUF4c2Vjcmt5RHNwMUhCRjhrNW1TVkhRRjdTb0Y0Z1J0MFdkQmZW?=
 =?utf-8?B?RTJJeERFamJ1MUFsa25SL3BnK2JDL25nUmNLbTYvMEZaSnBrVENxWENYcy9F?=
 =?utf-8?B?ZnQzTzU4cnBRZHEvMzd5eWNTM25iakhhWThVS1ZLTkhpWFVRWU52Q1p5ZnlW?=
 =?utf-8?B?L3JxbW4zTTFXbXRBSnVCOUcxVHdWSXVvcU5KclNvSHovT2VONlZnNWY5Y1hF?=
 =?utf-8?B?aEgyZGZaMDNQK1Jzd1pOWTNUbkFpcnlENkJOTFBvZm9SRVRlSXpkd2ZqUFdC?=
 =?utf-8?B?SnQ5ZzNaZ2VIMXJUQ2tIOFhWWVVBUDdUaGNXVWR3RHRlV0xOR2JHeHRhejQ2?=
 =?utf-8?B?djF4ZzdHazRjVWtxbzNiVElFckluM1k0Ly9LN3BXL1RtSnlNMUJOTk5lZW1Y?=
 =?utf-8?B?ak4xRTlISHVsanRTZlUvTUJacVZqTG12NWNSOVBxS1NQZWZNajI5dDBLRG5t?=
 =?utf-8?B?T05Xd3pxMnpLdDMyaU9adzZKTHVXMWF3VDRBWTVKNlZkMHBhdmRnZlpBZ1lk?=
 =?utf-8?B?UDUvLzYvRGxjdHhHTC9JdmI4Q3Q0S0VNOWZnZXZGdjI3V3JJTzNlMW9KcVU3?=
 =?utf-8?B?QWZOc2EyK2c4U0ZKQm1JTzU3WXVnc3Y0V1hNVGdCZ0RNQ0NMWE93TW9FZlRs?=
 =?utf-8?B?K0MwUkNKdUZxOE12RWVRQjVTRmhTcU1jZVF5a0pMRGY2eGY2R00zaDBtdGV4?=
 =?utf-8?B?U3YrbVNWajRwYjBhdFFMa3ppQlEwb3JuS1ZWUEoxTnVvc3hEM3dVOGJwejNw?=
 =?utf-8?B?WkdDNkFXZDNkdmZLVmJPc2ErTC9QT2s4b01menhiZ1FOdGRtR1dNbHVYZUlV?=
 =?utf-8?B?UUV5RzRyY0lob1Z0T3hUZmNWOFZ4SnBJSXV1V3NiUytRM2NsYUlGUXFwa0lZ?=
 =?utf-8?B?T3NxSDlUOTBvZEFvdThySVBkbThkdTcwSTh6WTFqaU4wbXdGM2s3cTlTRVIr?=
 =?utf-8?B?UVUrTEdYWDhyb2RRMG5KVnQ2YjdRcUhZeFBiQUliMVNRTU9ZTXhGeUkwUXA1?=
 =?utf-8?B?UHo4WldRcnhRSXEvVm5DNVBWMXNXSnJ6NitXQmx0enNzSnFMVFVmSFVZc2xw?=
 =?utf-8?B?c1FwaWRwbEszb0RzUytZSEgxVXNaYi9xRVRuVnBhU2JVMTU3THl4SXJtZjFX?=
 =?utf-8?B?T0Y1NjB5QU1WbW91S0hybUY0ajhyMlh3aGN6Mk9oQWVKNnI2bzB2ay9nLzV3?=
 =?utf-8?B?RzcrMlBSTFVISHRreHg3UHRGZytUM3k2djJGeTFEa3hMZEFOa0piT2Z6VmM4?=
 =?utf-8?B?V2RvdDlVYURWSlEvblNnM3AvNmVKM2hpZS9QT3A1N2Zhb2VRbDFXam1EQ1F0?=
 =?utf-8?B?djZNTjc4T1NVRWZ0VXFCdExUcmF1eGFKTG55TjFCd2tCK3JxTWdMQW1lNmJj?=
 =?utf-8?B?NEVtMTZ5NlhPSlNmdnBXZllqYUsvN0YvYmJDSlUvL0U3ZXRlemFxMzI4anh3?=
 =?utf-8?B?eTRkSFNSWE1zY0xqWGlsRnAydjQydmNlVEtnSVA3YnF2TXp1Y3BXV3Erdnpk?=
 =?utf-8?B?QjA3NVYrZkpqTlJ0cnZhQWFjTVZ2UnpWU0pvZXlTV04xeGx1Vkx4Y0duWS9t?=
 =?utf-8?B?M0tLU0tHd2tsWVpiQ1dGRzJESEw1UGtLemh5aUhEd2FYaDQrK2VpY2Fualpp?=
 =?utf-8?Q?bfCE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d24e28-6b76-4d73-1078-08dc46ef90da
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2024 02:03:12.0729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tAU6QSDnQX7ESxwJFAFAwdlWtlgwSjswIgyimcshjqJBDpjc0C9Fp/pfiJ90SovHe7p2jv4UELTsMbFd7IkHPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8224

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBncGlvbGliOiB1c2UgZGV2X2VyciB3aGVuIGdwaW9kX2Nv
bmZpZ3VyZV9mbGFncyBmYWlsZWQNCj4gDQo+IE9uIEZyaSwgTWFyIDE1LCAyMDI0IGF0IDM6MDLi
gK9BTSBQZW5nIEZhbiAoT1NTKSA8cGVuZy5mYW5Ab3NzLm54cC5jb20+DQo+IHdyb3RlOg0KPiA+
DQo+ID4gRnJvbTogUGVuZyBGYW4gPHBlbmcuZmFuQG54cC5jb20+DQo+ID4NCj4gPiBVc2luZyBk
ZXZfZXJyIHRvIHNob3cgZXJyb3IgbWVzc2FnZSB3aWxsIG1ha2UgbGlmZSBlYXNpZXIuDQo+IA0K
PiBkZXZfZXJyKCkNCj4gDQo+IGFuIGVycm9yDQo+IA0KPiAuLi4NCj4gDQo+IEl0J3MgdW5jbGVh
ciB3aGF0IHRoZSB1c2UgY2FzZSBpcyBhbmQgaG93IHRoaXMgZG9lcyBtYWtlIGxpZmUgZWFzaWVy
Lg0KPiBXZSBuZWVkIHRvIGtub3cgbW9yZSENCg0KSSBmb3Jnb3QgdG8gYWRkIGdwaW8tcmFuZ2Vz
IGluIGdwaW8gbm9kZSwgdGhlbiBpdCBhbHdheXMgZmFpbCBpbiBteSBkcml2ZXINCnByb2JlIHRv
IGNvbmZpZ3VyZSBwaW5jdHJsLiBTbyBpZiB1c2luZyBkZXZfZXJyKCksIGl0IHdpbGwgYmUgZWFz
aWVyIGZvcg0KbWUgdG8gbG9jYXRlIHRoZSBlcnJvciBwb2ludC4NCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gLS0NCj4gV2l0aCBCZXN0IFJlZ2FyZHMsDQo+IEFuZHkgU2hldmNoZW5rbw0K

