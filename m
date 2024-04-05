Return-Path: <linux-kernel+bounces-132291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE5B3899296
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 02:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F73B28AC40
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA71139B;
	Fri,  5 Apr 2024 00:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="XZoFbsjh"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2102.outbound.protection.outlook.com [40.107.21.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872B4393;
	Fri,  5 Apr 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712276824; cv=fail; b=QeN2UlwX8naoQXZIyoZbwnJVkKwLCBLFSUAf0oIiHOO/qZ4s2SjsN21ZvTf3TID+YBngg+4NmSD+W/eqO2GimhcqvTvbaG9QYjx62zmIwOW343LAo/3JysOBI2WjbNurqHFQE31ms5mIq895UhAaMATIgcBI0O70961r0CrjREM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712276824; c=relaxed/simple;
	bh=08LJR327lWQCFpqtQijbgfVAsctYrfF6YfHCCz/4G8I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hOZt9EzKAvO0I0rHVKPmVAfxI8KylvCtRyrc7SM4me0cLQcSFdaSUsGBp1qQOhRZ4ZhdfRxXevX9vPzA796E0O3wjRxGx36xvOKBL/DAXqzeyLRlH7c8bw7dgLkwUYMi/M9MRwFHexuJzWFhGMXAhRT4MWyO06DYOyXnFamNeNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=XZoFbsjh; arc=fail smtp.client-ip=40.107.21.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6uilmybeHH94E566WMQBAu0kdl4CQh9NolQf9aQEY4Bjq/L4Rq6tZP22rDTNIQLGpZauAExw3BW5CXl4HXCKXwul0ogkJram4Do58i6b8zNmbqw8c6EsrG+o2EVBkj6APUQT0kvWcuZHASaYYFRyfjN7Cl86cluKUNbk/w3VpL0aMlcMfT6PuQMvNWGZ+jtTmaSVg0jY97trwMexjiNwPQfR16MNaYpudOPvWIHrJJ4xvgdveodxEHHmDCz48K54GrPfKcTkNuiuHSU8gB+7zSleHjKi6QhIPNEf7WBCdVDPnEZnoxQYN/j+xQTY+mILIRoPe92hVmYppQyucBVZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=08LJR327lWQCFpqtQijbgfVAsctYrfF6YfHCCz/4G8I=;
 b=CiUSBYXSC965Fe7hQsQC1pBju9eA9akVDFcXTi8m2KZGZnev/sj/9vZAmwnaAt4rVk0H7J7/n7bxFxXelqbsl3PCsqtkdJl2pP+PJYR1aj1DhtS2u8dhuEQcH0KfizhGvYWv7LUThEJzVDicZnWs10nN2JVtXY4/v1CVmg5cK5+0io7rzFLjsPPEyq1ouO1O+j4i9MIvmZGuVyAZKFxQ/+A+yfPLIiL0M+Y0I/wyJcgS+ZoxeeCKPx8VLHuELbhfnkAcTW4ziDAA9RTWsIiLU2egBaDqR+FF5Cib/RIDcIIpPuHWV8x+ZcOYsSVZ9lo73NcfU0A0MOc01AqD//fIng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=08LJR327lWQCFpqtQijbgfVAsctYrfF6YfHCCz/4G8I=;
 b=XZoFbsjhIy2NSzBH2FRZUC6397+NhZof/Ihzl54n6tgfzyuXr7mH3yrzug7qJwPjNtDW6eQKBhqPoOmOwB1mDoX0p7D26XT9EVgxtT0sTRrxZBWkrbSpie+UkBHZYCzTrSR+1aGMk2hm8UBohqQKaWmaq7aFSZLCtfr0gseBGCQ=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB7105.eurprd04.prod.outlook.com (2603:10a6:208:19b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 00:26:59 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.037; Fri, 5 Apr 2024
 00:26:59 +0000
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
Thread-Index: AQHahD061iAgiLB8lEGowmwPJFPUgbFYAoUAgABZeoCAACD1AIAABbEAgABThpA=
Date: Fri, 5 Apr 2024 00:26:59 +0000
Message-ID:
 <DU0PR04MB94172267E1D7EF398D37008588032@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240401141031.3106216-1-peng.fan@oss.nxp.com>
 <CACRpkdZAuNXGyg2wwYcQG4oO9w7jPS6vj4Vt0=kqX5fJ+QpNmw@mail.gmail.com>
 <Zg7dwcFz5eD7Am2u@smile.fi.intel.com>
 <CACRpkdYLqO1XGMiWuGhZoM5wn8T7kFOvJ9LkiUp9W6zPufiP0w@mail.gmail.com>
 <Zg7-LOOf_021X2oP@smile.fi.intel.com>
In-Reply-To: <Zg7-LOOf_021X2oP@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM0PR04MB7105:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 rLbHNYQ42sjV+7XbxN6JaLKErA4Y2qMDg70X62BD8wLCLu8miM0s19oHsf8a7RJ2vLziMak9exQx67u0PM1PPtXo265J7px8v7nXNprjrTr3LCbirDy3OZqp4rsv/WQ9rWOg3TTZu9lWhYv5wBXTyA8D6v6L9D09qooRcyrVT1g01TrXpOuqWzJe26cce9XM3LQ4QdhzKzfrbgioZ32hKM2GlWVqv2Vz/Kymq+wWdzMG8gYkXEAV2pcL5IWznFXCz/ir/jgG7EH0zGUNVNxp91b3EO6vIi/o/JyHr/k2HHVcuVTzz+sUAR4Hj0y8UJ/WgdEecehXOZEwK6ToxNySMCFHdSISmx/OEvkdMEFgsdRTwwFvCrJwLcgKfBpGamvCXVgDOwGEPTX7WHKhTDusE752CxjTXy8UYWBTMWLxs2Ftapwzid80iPqP3LIICSetYqT1BSsWHEXWqRJ28A48f39RJHL7NRYpuBFbs0v6WXPjUN/CuLU9TWOWRPEgkiDRXAV+5kFaHwMSUnn0aFgZRUkLP7AQU6njI1WaSUTkzNJP3FWmZdOKxx5d5Nxko58zX1LNr9vdUPjedxv7kHtfBFl5HUSSgGEyf9jbcwhth6s8cv8mI24CDexITTVvt2AmkxF9LeeDZCeKtZmeXVRtZnzKdadgRYOvqivg/mEqdmc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Yzg2aHJhMmZMTVlYazN4TGxDQWExU0lzZ0JoaENtUDR2KzNTbEh4eHl2WktF?=
 =?utf-8?B?OG9ha1RSeE1uVHRGWHdvVG4xckdZRklKZkZIdDArMC8rRngxd0kzV05pLy9S?=
 =?utf-8?B?Qm1teGcvTm9HZjNUUTl0cnk3ak5IT013bHByYkZ1Q2ppR0psYlFwa1MyZ1Qw?=
 =?utf-8?B?NGllYTM5VjlRUm9rSVdEeDNxalVDeGJEdjNWeFhTVWtrN1BXWGhoU3BDUzJC?=
 =?utf-8?B?UDF4VmhmeUJSVElPNXpoNWJucVRQSkdudWVKdTRPYmk0SUtCREs0b3dUK0ZT?=
 =?utf-8?B?MGJFMDkxbVdzSWFtV3pPYkxwTnBLWC9KbW1WeE1WUHNsRWxYcTV3b2RqSDNo?=
 =?utf-8?B?WjEzc0ZXNC9STUJUOUhaYnoyRVdqQkR1ZUQ0TUdZNE9UUlZXcTU5M0hxOCtp?=
 =?utf-8?B?QlJGYjhNOHZLYWZlMDc0S2pHM1hGWW1XbEZkZGluaEw4WHVSVkVxRzdPMnFq?=
 =?utf-8?B?aUd6Mi9TZmdlN0l4ay8xR0ZRYjVDN2JZRDFjTG5vSXRvMXA0Rjhwc0hWZXdM?=
 =?utf-8?B?VjgxbzNNYWM0dk01TzgwV1kwd09vSXRydDdremZ3MTRVN240cGV1MGl1bDF0?=
 =?utf-8?B?YmVMYzdYVE4yOVBEVHdxWDNMdXBNUVNvdkVGVE1yQXEvQWtxb1B5TUxPQ2Fv?=
 =?utf-8?B?UlN4SktBc1g1cUloMkNWbTdRbGhTTEhtdnVvWnJPK3pCZkxEMFdCUDAwbWFS?=
 =?utf-8?B?Ymx3c1NMTUJENU0vaEF4THIzNUdNaXROdDUxMHE1S1dheUxJSXRDTWdZbFZ0?=
 =?utf-8?B?UTM0WXAzRktiNFR4WXlYQ3JocGQzT0JtV285dm9QbnAyaFVFZGxWSGpNWW81?=
 =?utf-8?B?a3VYd0kyamVqaVptS1BYUTE2MjVnUjN4RUpCQ2FRTHcvZ1JiWTZOQm5rbzl3?=
 =?utf-8?B?STJEVXMxQVFGblp2T3BKTWFhQmQxOXhFdFF5MEsvUGZlRmZURFg3aWt2ZlFF?=
 =?utf-8?B?UUpTbkpGNUUxS0Rlc0JhMG1sOExRdDNUL3lXTlhBK1krSVhFbGoya3JuWXpF?=
 =?utf-8?B?aHc5VXdWL2xqM2J5c1JOOUdVdEk1TkVlVHNLN1NXeWlVZTBiTG5KV2drRFk0?=
 =?utf-8?B?M2RjY2l0Yi84eVFMdGF1cCtsdGVuRXczZTNpaGw0d0t2UDRqMk5zNlpyaFBo?=
 =?utf-8?B?cDNrby9KenRtbVUrd3JvWVJZaSs2TDZ5aWlCSWtEaWhPRmlQRlhpYkpUVmhT?=
 =?utf-8?B?cTJqTWpnR0I3SUVYK01SQ0JjZ0FLZGFqem9aQUZaanpDV2FnOFIwUFUxWTdh?=
 =?utf-8?B?OVN6dUxoQ1N0VU5NZzhhd2xGVlBxenprcEJhVXdzRzFEM2NqSjlrNWJFOHJ3?=
 =?utf-8?B?dXhpNUtVaEd5eW5QcURjRFJNajM1d3BMbFdZS0h1OHp4dkhzRE5qSXdLTGJq?=
 =?utf-8?B?emhzMFhUMGhRVE5tYzA3alBRdHRzSmQ0aTkycTNBYkRJS0FnOHZXdU1MMWZD?=
 =?utf-8?B?OEk0NDFJRTBXNURMOW5GYjBacXJhdDVtaWpvSEJSSXlERmgxSzBxWmJvR1dG?=
 =?utf-8?B?RTJ2dS9IT1p1SzZ1NllmVFFGbktRZGZ0TDU2dzJCMFVaUHVEdkVkNHRHUXNZ?=
 =?utf-8?B?MjRLZTZFYm5sM2NzalJWaWFmUm1PallZbnN6dndwdExtQVJtU3hYa0NrWS9t?=
 =?utf-8?B?dlcrWFAxQlQ1THdUY1ZVNnIxRmg2MXRMdHp3NXdZa0V4TDBiNXJvaUJ1Ly9C?=
 =?utf-8?B?b2V0Mjcwc1Rqb1YzbzNrVUUzNTF5RkZTNmI1UFRPUGNFcmRySVhlNENpbHJI?=
 =?utf-8?B?NDh4SVpUN0wzVjZxbUxBK2RscTlteHdpblhNb2RXNWVYYmI0TDJvWmRUZnBx?=
 =?utf-8?B?aGQwYzNnRXRlZGdwaHYxcS81TFpTQWNNd1orU2tOWmRhTVY1R2ZoZHNKM0pC?=
 =?utf-8?B?TzBPSzlMbDBPUnFBUTNuUk8xV3o1NHVWeFgvcnVlR0xtRDY1N3lvSzVxdGxH?=
 =?utf-8?B?L1JaK1R2NWRyWkg5cVNxWDF0S3N1QS9SYUJkUXJoT1BKc2NaTStLS2FJcDVo?=
 =?utf-8?B?cUh2c21majM1NjYwM3JKcmJkYlFXa0VNQ3UvRHpxRlowZ3lHWWhaeTRWb25p?=
 =?utf-8?B?UVVWenlDUW9CZmRTU1lYTUJmYkRWZEw2RVBSWHRWNW4rczFPWWY1SEgxWVh2?=
 =?utf-8?Q?RKNs=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01475180-1861-42d4-34d0-08dc55071b76
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 00:26:59.3131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e8mezstUuvadZsfbwl3c478LM5rvw8MiegIyEroWepbRD+FY8wzWdcsgsEqJNO3eSAYuPPou56mAV9MW8FLejQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7105

SGkgTGludXMsIEFuZHkNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwaW5jdHJsOiBwaW5jb25m
LWdlbmVyaWM6IGNoZWNrIGVycm9yIHZhbHVlIEVPUE5PVFNVUFANCj4gDQo+IE9uIFRodSwgQXBy
IDA0LCAyMDI0IGF0IDA5OjAzOjAyUE0gKzAyMDAsIExpbnVzIFdhbGxlaWogd3JvdGU6DQo+ID4g
T24gVGh1LCBBcHIgNCwgMjAyNCBhdCA3OjA14oCvUE0gQW5keSBTaGV2Y2hlbmtvDQo+ID4gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gPiBPbiBUaHUsIEFwciAwNCwg
MjAyNCBhdCAwMTo0NDo1MFBNICswMjAwLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0KPiA+ID4gPiBP
biBNb24sIEFwciAxLCAyMDI0IGF0IDQ6MDLigK9QTSBQZW5nIEZhbiAoT1NTKQ0KPiA8cGVuZy5m
YW5Ab3NzLm54cC5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiA+IEZyb206IFBlbmcgRmFu
IDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhlIFNDTUkgZXJyb3Ig
dmFsdWUgU0NNSV9FUlJfU1VQUE9SVCBtYXBzIHRvIGxpbnV4IGVycm9yIHZhbHVlDQo+ID4gPiA+
ID4gJy1FT1BOT1RTVVBQJywgc28gd2hlbiBkdW1wIGNvbmZpZ3MsIG5lZWQgY2hlY2sgdGhlIGVy
cm9yIHZhbHVlDQo+ID4gPiA+ID4gRU9QTk9UU1VQUCwgb3RoZXJ3aXNlIHRoZXJlIHdpbGwgYmUg
bG9nICJFUlJPUiBSRUFESU5HIENPTkZJRw0KPiBTRVRUSU5HIi4NCj4gPiA+ID4gPg0KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFBlbmcgRmFuIDxwZW5nLmZhbkBueHAuY29tPg0KPiA+ID4gPiAo
Li4uKQ0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHJldCA9IHBpbl9jb25maWdf
Z2V0X2Zvcl9waW4ocGN0bGRldiwgcGluLCAmY29uZmlnKTsNCj4gPiA+ID4gPiAgICAgICAgICAg
ICAgICAgLyogVGhlc2UgYXJlIGxlZ2FsIGVycm9ycyAqLw0KPiA+ID4gPiA+IC0gICAgICAgICAg
ICAgICBpZiAocmV0ID09IC1FSU5WQUwgfHwgcmV0ID09IC1FTk9UU1VQUCkNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRUlOVkFMIHx8IHJldCA9PSAtRU5PVFNVUFAgfHwg
cmV0ID09DQo+ID4gPiA+ID4gKyAtRU9QTk9UU1VQUCkNCj4gPiA+ID4NCj4gPiA+ID4gVEJIIGl0
J3MgYSBiaXQgb2RkIHRvIGNhbGwgYW4gaW4ta2VybmVsIEFQSSBzdWNoIGFzDQo+ID4gPiA+IHBp
bl9jb25maWdfZ2V0X2Zvcl9waW4oKSBhbmQgZ2V0IC1FT1BOT1RTVVBQIGJhY2suIEJ1dCBpdCdz
IG5vdCBsaWtlIEkNCj4gY2FyZSBhIGxvdCwgc28gcGF0Y2ggYXBwbGllZC4NCj4gPiA+DQo+ID4g
PiBIbW0uLi4gSSB3b3VsZCBsaWtlIGFjdHVhbGx5IHRvIGdldCB0aGlzIGJlaW5nIGNvbnNpc3Rl
bnQuIFRoZQ0KPiA+ID4gZG9jdW1lbnRhdGlvbiBleHBsaWNpdGx5IHNheXMgdGhhdCBpbi1rZXJu
ZWwgQVBJcyB1c2VzIExpbnV4IGVycm9yIGNvZGUNCj4gYW5kIG5vdCBQT1NJWCBvbmUuDQoNCm9r
LiBHb3QgaXQuIA0KDQo+ID4gPg0KPiA+ID4gVGhpcyBjaGVjayBvcGVucyBhIFBhbmRvcmEgYm94
Lg0KPiA+ID4NCj4gPiA+IEZXSVcsIGl0IGp1c3QgbGlrZSBkb3plbiBvciBzbyBkcml2ZXJzIHRo
YXQgbmVlZHMgdG8gYmUgZml4ZWQsIEkNCj4gPiA+IHByZWZlciB0byBoYXZlIHRoZW0gYmVpbmcg
bW92ZWQgdG8gRU5PVFNVUFAsIHJhdGhlciB0aGlzIHBhdGNoLg0KPiANCj4gJCBnaXQgZ3JlcCAt
bHcgRU9QTk9UU1VQUCAtLSBkcml2ZXJzL3BpbmN0cmwvIGRyaXZlcnMvZ3Bpby8gZHJpdmVycy9n
cGlvL2dwaW8tDQo+IGNyeXN0YWxjb3ZlLmMgZHJpdmVycy9ncGlvL2dwaW8tcGNpZS1pZGlvLTI0
LmMgZHJpdmVycy9ncGlvL2dwaW8tcmVnbWFwLmMNCj4gZHJpdmVycy9ncGlvL2dwaW8td2NvdmUu
YyAvLyBkcml2ZXJzL2dwaW8vZ3Bpb2xpYi1jZGV2LmMgPDw8IEhlcmUgaXQgZ29lcyB0bw0KPiB1
c2VyIHNwYWNlLCBubyBuZWVkIHRvIGZpeCBkcml2ZXJzL3BpbmN0cmwvYWN0aW9ucy9waW5jdHJs
LXM1MDAuYw0KPiBkcml2ZXJzL3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuYw0KPiBkcml2ZXJz
L3BpbmN0cmwvbWVkaWF0ZWsvbXRrLWVpbnQuaA0KPiBkcml2ZXJzL3BpbmN0cmwvbnhwL3BpbmN0
cmwtczMyY2MuYw0KPiBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdDkxLXBpbzQuYw0KPiAvLyBk
cml2ZXJzL3BpbmN0cmwvcGluY3RybC1hdzk1MjMuYyA8PDwgU2hvdWxkIGJlIGZpeGVkIGluIExp
bnVzJyB0cmVlIGJ5IG1lDQo+IGRyaXZlcnMvcGluY3RybC9waW5jdHJsLW9jZWxvdC5jIGRyaXZl
cnMvcGluY3RybC9yZW5lc2FzL3BpbmN0cmwtcnpnMmwuYw0KPiBkcml2ZXJzL3BpbmN0cmwvcmVu
ZXNhcy9waW5jdHJsLXJ6djJtLmMNCj4gZHJpdmVycy9waW5jdHJsL3N1bnBsdXMvc3BwY3RsLmMN
Cj4gZHJpdmVycy9waW5jdHJsL3Zpc2NvbnRpL3BpbmN0cmwtY29tbW9uLmMNCj4gDQo+ID4gQW5k
eSBpcyBvbmUgb2YgdGhlIHdpc2VzdCBtZW4gSSBrbm93IHNvIEkgaGF2ZSB0YWtlbiBvdXQgdGhl
IHBhdGNoLg0KPiA+DQo+ID4gUGVuZywgd2hhdCBhYm91dCBmaXhpbmcgdGhlIHByb2JsZW0gYXQg
aXRzIHNvdXJjZT8gDQoNClN1cmUuDQpQYXRjaCBhd2F5LCB3ZSB3aWxsDQo+ID4gaGVscCB5b3Ug
aWYgbmVlZCBiZS4NCkxldCBtZSB0cnkgdG8gZml4IGl0IGJ5IG15c2VsZiwgdGhhdCB3b3VsZCBn
aXZlIG1lIG1vcmUgcHJhY3RpY2UuDQoNClRoYW5rcywNClBlbmcuDQoNCj4gDQo+IEluZGVlZC4N
Cj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNoZXZjaGVua28NCj4gDQoN
Cg==

