Return-Path: <linux-kernel+bounces-87848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B886D9EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 04:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA59BB230E0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 03:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9804C40BE0;
	Fri,  1 Mar 2024 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="FpWGLPCa"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2064.outbound.protection.outlook.com [40.107.21.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1683224;
	Fri,  1 Mar 2024 03:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709262289; cv=fail; b=BiUcyYyXK1W18nEU8U5aRQRux7AKOHsjf91f+ACCFlHRdsNNBad4DJc3IUkJD6L1MttpIgjjA5kNaTfJrldok9txP25CUskw+NQcec4Nqmv8nPJCTPJ754b4oUgZObOTtf7wjOeard/CXOqxzZCLasvuMhczYkpCpOpqmKygJmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709262289; c=relaxed/simple;
	bh=srH0q435sLy9sK6PjMZ3UWMzEV0f8QUd8Ah0cf5TDo0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YsnG2H9GzzybqhOR7MctraN4JcoaV8ebyuUfiShxJLcRfI8z+uGq8f8Jm4l5RK+0+mTcsXv3FmdtZrjMFKw5aMb7nya2Zkg6THHeDNzikLoLmErsJ9Ke3zgRAxACU4cHuwrZVFYZmVPi6XTNzt5E0VsxONF4abkhDSyw+ZA3pzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=FpWGLPCa; arc=fail smtp.client-ip=40.107.21.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J05hgEZ86QtSbTDYdExihQdrt67IubvyAsfatAqXUIyLETGdSV/bFFiYMFEJwl897+kdIszLSG+tlHvBAS6YOgqBqMVPXvKwIAeGPpY0syxtEZpUsgpBGM9VFYMGk7STUNU+89/bDqRDPAaVWIVU4HhBCio/Mo7GNMJHBP0HvScG+iwL1//J+YRII+/1JoUp3fCiGYLVkHXT+UbKm3A8TkKE2N572+3XM3G7mYadaOne8Tjcj2boBgovYPjl8ODqV+oxFhnEDSG+8odLESfMLY7PhbTHXMMD3LlFcQ21ixmQhJMLjSzRcl2E2IH4Z3JnISYTM+DzqpEb1KpU+hJstw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srH0q435sLy9sK6PjMZ3UWMzEV0f8QUd8Ah0cf5TDo0=;
 b=hpju50ZFj7eI0DxSHa+vi7bQ+U0BYKNsaEpZkv603qNE/8vnvU86YsjSYeekUlLRbh2fGG0rThkehV9TsW7va9aYryBJGnmCD639/FGnkyXC0fPk/DsJVBFZ4iJygQclAb/qywUT5AZPnB+czmOOr3YOMBv2ffiJjyQOFSkgmpQVPxBkdC8FqdOkvzeWZAn2cEOWwK1xbzaYIKS5+LYxbb2lt5DAjXF5PJhA7bxauYroTtmRbeYFLxz306EbwkjkXRn1+H3UZXk86WtfP8b29tT3EM/u4SCeKmJIAoZE55W7SQWq4B2T+uw9q46bYIyqbkZpCj0OzS5s1lzdT3+O6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=srH0q435sLy9sK6PjMZ3UWMzEV0f8QUd8Ah0cf5TDo0=;
 b=FpWGLPCaHoPdeeYktiXYwHoC6ETcR5/rRzMrqHEWQd7kysJMOWTX/Wmeno8UeiHn6tYyOeG/GJs5TnnqQudp7R6SrOzh0Vr8wxZiDVYv+PX1/loXEa4ipepKyWJT0iOQS5HKXNkNUWCsxJE/S5PGpp5kE7F59bOhE5xTCbU2zfE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8437.eurprd04.prod.outlook.com (2603:10a6:20b:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32; Fri, 1 Mar
 2024 03:04:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::1232:ed97:118f:72fd%4]) with mapi id 15.20.7316.034; Fri, 1 Mar 2024
 03:04:44 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Rob Herring <robh@kernel.org>
CC: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, "saravanak@google.com"
	<saravanak@google.com>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"pali@kernel.org" <pali@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] of: dynamic: notify before revert
Thread-Topic: [PATCH] of: dynamic: notify before revert
Thread-Index: AQHaag0+AypznpRalEW8qnCECxwD0bEfv9QAgAEz1RCAAOq9AIAAVxHA
Date: Fri, 1 Mar 2024 03:04:44 +0000
Message-ID:
 <DU0PR04MB9417003D9DA15FAD08084894885E2@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20240228062138.1275542-1-peng.fan@oss.nxp.com>
 <CAL_JsqJktYv+sSfwtT6ExsES5+HqB2BStnEMMRKVqTO3dFJm2Q@mail.gmail.com>
 <DU0PR04MB94177FFE211711E9DE4E9E51885F2@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <CAL_JsqL4cb8NVOV9QF5__PtjyDUQd-MnuhJhbTHmUF3qr3x47w@mail.gmail.com>
In-Reply-To:
 <CAL_JsqL4cb8NVOV9QF5__PtjyDUQd-MnuhJhbTHmUF3qr3x47w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9417:EE_|AM9PR04MB8437:EE_
x-ms-office365-filtering-correlation-id: 08954f52-f3c4-4b22-c318-08dc399c58a2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GvDx8UwtVhTG2O2Jf4ZybOXMybSMECzc6QvR4o4vVFPyeMP/kDXHl3hsheTlXwWqzBiES5XlkcoWQ9WkRqNLHgEY/PVL0ANVwJBcv6f8SxFENwLL4AXNFqx3uSbN//GPTzXFhzfYDrUA0RVIQHOoS2K1xigXjWIvHsOwv56sTXqhLUCGsUh3/o3LaIzic4lCkIWiSp30/m2YchswMFu71M161TvMlDpKJ0nFWPKgLMEALpc9i8UHk1JFT4YgQy5IRnDS1jf53cTO2UVs2j+d0u2J+xW2cPoBF/0WQ3YI8GTckWH8jXu16IITHSDcqEt54HcRVrWNct1vkGFHV7zxexirE+u2fcwg7SDiJvckl6vSl1rXmynlF2vk/7RT93TqoYlC7Ww9uBybgj4jllW5WJDGjiySUxh9TXO+QHoezBltgeqqj5fRYLfi55uYCBN+OYvfTvVATeszW5MLzSRPtMrwdYJsg7X+1yaQBt12RAAFmPTJcPXNpR/YnPLHAWOzSeh2E2Soqtb30VAscW7kKMSqMOCxvWi5Je55/5rWoO8o7LXg741p1TeggjUVji3QGgyP+dx4/0YQUN9aFxBxBDoFZnahmluCguQHJOoqMarifQu1qaKJAfxDrPB3d/K3xBvrGVlbS/KqLy3RmH2xAKR4bfYhVqyjGopod5ACYhc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZzBTSGhGeGtWeGxiTUc0eXp4Y2dFclRzbEFlOTA1cFRDWWF1dTBrbkswa0Uz?=
 =?utf-8?B?VW5wdHZUWSt0NHV4WFRqTWoxWDdlOGdwZWh0eVpBSFVpVC9CSllmczhWNGZE?=
 =?utf-8?B?V2hTc3VFSjB4SktwNXgvd040YkN6WVVxN0k3OGpaMGtIeXQ5MjhjcXZIelEv?=
 =?utf-8?B?MGpBMTIxTlFhbm1HUXRhTGJJZ0VDWTVjUzJDSzJrWjRyWFJHN2cvbk9vSlFB?=
 =?utf-8?B?SFllNWU3U3JVV3R0dm8vbUVWTHErRDBXM3lRc2s2dzlXUVVGZU5acHlvTU9z?=
 =?utf-8?B?RTdTbllJOWkzSkJGVlNNUW42ZVRHNkdJdERhY1RsTVFHc2Z2M3d1OGRJV3pz?=
 =?utf-8?B?N0NyWDZzajk4ZGs5NVQveEV4NWxhZ21xaUtZS05FUzVCQTA3ZFN2NmNvTjQ4?=
 =?utf-8?B?Yi9xTFRNSG1udlZJa0NGWU1hTzlJZlBpdGM3S2FBN2R0S096THRqSUJTbnJu?=
 =?utf-8?B?cG9lOWpOblRQQ0ZlZWhkbzFjTllDdE05dHhCdWEwenVxS2N0K1BqWHJvQ0dr?=
 =?utf-8?B?SUFiVWxpaUJLK2k4VG1WYXRnSlcxOVM5OC9waWFGTEZkSklJMWdRSENkRWln?=
 =?utf-8?B?Y0tkUkVOdm9ZbDVUMWxzeERVWC9XUXVxczB6clQrdzRmalRPRzhJajNKSUd0?=
 =?utf-8?B?dXFISXh5RzBnQ3pWNE5NMTkzZ0FpL0dVRGNWdGg3NWpydk82SmZ3RlZHT1Z4?=
 =?utf-8?B?eW90OHJGYTFRQzlienJsd0pBVVh1TkxoVk4vakxOeUoyZm9aa21hK1VGaW85?=
 =?utf-8?B?NmxIY2VwcmVDdEYydnRObHdUa2ozcGRNMVBkZkdNZlZYK05OV1U1Ry9GTEFK?=
 =?utf-8?B?emVtNHBROXY0V3M1N2hNWjRqL08vVlZpN2wrQ08waytPK2crUWVJQVlZOWdu?=
 =?utf-8?B?ZUp3MXZMR3dITkxram5MYWpKOEswZWlxSkhUc0ozTTNQaUZ5dXYrcGN1MUVv?=
 =?utf-8?B?VW43NWR3TUZ5WHVZS2IxTm9zQ2ZZVEZ4bXdFZ1VqQWRuMldkZG4rdmJKVTdt?=
 =?utf-8?B?QmJpQXFzYVduL2YxVllLSnRFUExuUWxHWE85MCtHenZYMjJQYzZBZDRyQmxo?=
 =?utf-8?B?Zy9BV2UyZStyLzNsa0VrdkNLQUFqcnRqSlZsMUpESnhTNlVqQnhNWm1MVFk1?=
 =?utf-8?B?WmlmQXZpL2xWeGlCM1RFQU81Q0VlZlFVM3RrOFRHZk1uaDJJTXRuVTBFRkVs?=
 =?utf-8?B?T0ZRcTdKazVJa2lBV0p1MVhuUGNsK05SSXNXa1kyZlpVbjZZa3RlaFpvWEVM?=
 =?utf-8?B?S0JOUFFUR1NkaTlHZGpkRWxJUFVvK3ZCRmlLcjY5YmNjT1R5SDh0MlcwMWRT?=
 =?utf-8?B?cHMwbDNkbS9JQnhUUHJJRkpXdFhqYXByUWdJYmVoeGIxL3YzVzJCNDQwODNE?=
 =?utf-8?B?d29BbEFUc1ltU0tycXVldDNGNlR0WUo5dW1uYTREMWpjZUxlb081Z0NNekFt?=
 =?utf-8?B?TjFCZmUyLzNOaTlnRGdVRFpicUJ2bXhobGhLeGxISU1iTjlqZzV0UEdEWS9k?=
 =?utf-8?B?bGpDZFZUdWQ2dkdsZVpQNTlENW5IWkRVOGJsdHdKS1JDUEd4L1JYVGZodEJM?=
 =?utf-8?B?VHFhS0wrMmJOa3BKTExjK3dtVU4yTmFqUVREeTFCRG5FUXh5NDhaYXhhQmgw?=
 =?utf-8?B?RDdaK2R4RWtxZXNvMmRIT2JMaUlMOGpYUkxPdDN1STFnVEZFdEdkSlFkR2la?=
 =?utf-8?B?TTNlMi9mazNNd2ZqRVo0UUYwbVdVRzRRY2R4bDhjMmxqNld5dk1OVmJJeWpU?=
 =?utf-8?B?dVBKemFucjFYT1JYMm5xYUpFSGpiWFpXR3BmMVA2Ulo0cTBMUWN5YUxSdDd1?=
 =?utf-8?B?V2JZczFQbjhmeGxwOGdGZW9oMjVhd2dOWmpSeTExV2JHbTY1TUVNelY3ZS9n?=
 =?utf-8?B?c2d1RERGUmJ0MXhySlNtWHpmR0Z6aUU0bk5DeituVWY0NXZHZzlNU2ZYSHd0?=
 =?utf-8?B?b1pGUE92Vm4xWk84ek12QWhNbjV5OEd0Qzh3aXFTcHV6UkhaZXlITUYwV0oy?=
 =?utf-8?B?QWEwTnlhVDF2bXkvQnllWGViLzNTOWlMd1h6Wmh4cTFwTEJHemZmOTV0ZlU5?=
 =?utf-8?B?enBWREpYdmowYXlORitVMmdHTE9Uai9aSWR2RWZ0eGEzcGxleEhKSGhnNlRK?=
 =?utf-8?Q?vGms=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 08954f52-f3c4-4b22-c318-08dc399c58a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2024 03:04:44.3936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqLTjVRM91atTy/PIH+rr8ySLfGzqUyCS6gsFeqYJAhtG9GNKWDuLhQGuJT4CXOdaYaeYagBE0FoVaHQDJb6VQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8437

PiBTdWJqZWN0OiBSZTogW1BBVENIXSBvZjogZHluYW1pYzogbm90aWZ5IGJlZm9yZSByZXZlcnQN
Cj4gDQo+IE9uIFRodSwgRmViIDI5LCAyMDI0IGF0IDI6MDHigK9BTSBQZW5nIEZhbiA8cGVuZy5m
YW5AbnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG9mOiBk
eW5hbWljOiBub3RpZnkgYmVmb3JlIHJldmVydA0KPiA+ID4NCj4gPiA+IE9uIFdlZCwgRmViIDI4
LCAyMDI0IGF0IDEyOjEz4oCvQU0gUGVuZyBGYW4gKE9TUykNCj4gPiA+IDxwZW5nLmZhbkBvc3Mu
bnhwLmNvbT4NCj4gPiA+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGcm9tOiBQZW5nIEZhbiA8
cGVuZy5mYW5AbnhwLmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gV2hlbiBQQ0kgbm9kZSB3YXMgY3Jl
YXRlZCB1c2luZyBhbiBvdmVybGF5IGFuZCB0aGUgb3ZlcmxheSBpcw0KPiA+ID4gPiByZXZlcnRl
ZC9kZXN0cm95ZWQsIHRoZSAibGludXgscGNpLWRvbWFpbiIgcHJvcGVydHkgbm8gbG9uZ2VyDQo+
ID4gPiA+IGV4aXN0cywgc28gb2ZfZ2V0X3BjaV9kb21haW5fbnIgd2lsbCByZXR1cm4gZmFpbHVy
ZS4gVGhlbg0KPiA+ID4gPiBvZl9wY2lfYnVzX3JlbGVhc2VfZG9tYWluX25yIHdpbGwgYWN0dWFs
bHkgdXNlIHRoZSBkeW5hbWljIElEQSwNCj4gPiA+ID4gZXZlbiBpZiB0aGUgSURBIHdhcyBhbGxv
Y2F0ZWQgaW4gc3RhdGljIElEQS4NCj4gPiA+DQo+ID4gPiBUaGF0IHVzYWdlIGlzIGJyb2tlbiB0
byBiZWdpbiB3aXRoIHVubGVzcyB0aGVyZSBpcyBhIGd1YXJhbnRlZSB0aGF0DQo+ID4gPiBzdGF0
aWMgYW5kIGR5bmFtaWMgZG9tYWluIG51bWJlcnMgZG9uJ3Qgb3ZlcmxhcC4gRm9yIGV4YW1wbGUs
IGENCj4gPiA+IGR5bmFtaWMgbnVtYmVyIGlzIGFzc2lnbmVkIGFuZCB0aGVuIHlvdSBsb2FkIGFu
IG92ZXJsYXkgd2l0aCB0aGUgc2FtZQ0KPiBudW1iZXIgZGVmaW5lZCBpbiBpdC4NCj4gPg0KPiA+
IEkgbWF5IG5vdCBkZXNjcmliZSBpdCBjbGVhciwgdGhlIGNvZGUgaXMgaGVyZSwgYmVjYXVzZSBv
dmVybGF5DQo+ID4gcHJvcGVydHkgcmVtb3ZlZCwgb2ZfZ2V0X3BjaV9kb21haW5fbnIgd2lsbCBy
ZXR1cm4gZmFpbHVyZSwgc28gdGhlDQo+ID4gY29kZSBwYXRoIHdpbGwgZ29lc3QgaW50byBmcmVl
IGEgZHluYW1pYyBpZGEuIEJ1dCBhY3R1YWxseSB0aGVyZSBpcyBubw0KPiA+IHN1Y2ggZHluYW1p
YyBpZGEsIHNvIGR1bXAuDQo+IA0KPiBJIHVuZGVyc3Rvb2QgdGhlIHByb2JsZW0uDQo+IA0KPiBZ
b3VyIHVzYWdlIG9mIHRoaXMgaXMgYnJva2VuIG9uIGFwcGx5aW5nIHlvdXIgb3ZlcmxheS4gWW91
IGp1c3QgZ290IGx1Y2t5Lg0KDQpXb3VsZCB5b3UgcGxlYXNlIHBvaW50IG1lIG91dCB3aGVyZSBp
cyBicm9rZW4gb24gdXNpbmcgb3ZlcmxheT8NCg0KaHR0cHM6Ly9naXRodWIuY29tL3NpZW1lbnMv
amFpbGhvdXNlL2Jsb2IvbWFzdGVyL2RyaXZlci9wY2kuYyNMNDU4DQoNCg0KPiANCj4gPiBTbyB0
aGUgcHJvYmxlbSBpcyBvdmVybGF5IHdhcyByZW1vdmVkLCBidXQgdGhlIG5vdGlmeSBjYWxsYmFj
ayBtYXkNCj4gPiBzdGlsbCB1c2UgdGhlIHByb3BlcnR5IHRvIGRvIHNvbWUgd29yay4NCj4gPg0K
PiA+IHN0YXRpYyB2b2lkIG9mX3BjaV9idXNfcmVsZWFzZV9kb21haW5fbnIoc3RydWN0IHBjaV9i
dXMgKmJ1cywgc3RydWN0DQo+ID4gZGV2aWNlICpwYXJlbnQpIHsNCj4gPiAgICAgICAgIGlmIChi
dXMtPmRvbWFpbl9uciA8IDApDQo+ID4gICAgICAgICAgICAgICAgIHJldHVybjsNCj4gPg0KPiA+
ICAgICAgICAgLyogUmVsZWFzZSBkb21haW4gZnJvbSBJREEgd2hlcmUgaXQgd2FzIGFsbG9jYXRl
ZC4gKi8NCj4gPiAgICAgICAgIGlmIChvZl9nZXRfcGNpX2RvbWFpbl9ucihwYXJlbnQtPm9mX25v
ZGUpID09IGJ1cy0+ZG9tYWluX25yKQ0KPiA+ICAgICAgICAgICAgICAgICBpZGFfZnJlZSgmcGNp
X2RvbWFpbl9ucl9zdGF0aWNfaWRhLCBidXMtPmRvbWFpbl9ucik7DQo+ID4gICAgICAgICBlbHNl
DQo+ID4gICAgICAgICAgICAgICAgIGlkYV9mcmVlKCZwY2lfZG9tYWluX25yX2R5bmFtaWNfaWRh
LCBidXMtPmRvbWFpbl9ucik7DQo+ID4gfQ0KPiA+ID4NCj4gPiA+ID4gU28gbW92ZSB0aGUgbm90
aWZ5IGJlZm9yZSByZXZlcnQgdG8gZml4IHRoZSBpc3N1ZS4NCj4gPiA+DQo+ID4gPiBZb3UgY2Fu
J3QganVzdCBjaGFuZ2UgdGhlIHRpbWluZy4gU29tZXRoaW5nIG1pZ2h0IHJlcXVpcmUgbm90aWZ5
IHRvDQo+ID4gPiBiZSBhZnRlciB0aGUgcmV2ZXJ0Lg0KPiANCj4gQWdhaW4gXl5eDQo+IA0KPiA+
ID4NCj4gPiA+ID4gRml4ZXM6IGMxNGY3Y2NjOWY1ZCAoIlBDSTogQXNzaWduIFBDSSBkb21haW4g
SURzIGJ5IGlkYV9hbGxvYygpIikNCj4gPiA+DQo+ID4gPiBJIGRvbid0IHNlZSB3aGVyZSB0aGUg
bm90aWZpZXIgaXMgZXZlbiB1c2VkLg0KPiA+DQo+ID4gVGhlIHN0YWNrIGlzIGFzIGJlbG93Og0K
PiA+DQo+ID4gIFsgIDU5NS4xNTA1MjldIENQVTogMSBQSUQ6IDU4MiBDb21tOiBqYWlsaG91c2Ug
VGFpbnRlZDogRyAgICAgICAgICAgTw0KPiA2LjUuMC1yYzQtbmV4dC0yMDIzMDgwNC0wNTAyMS1n
M2Q0Y2MxNGI0MmVmLWRpcnR5ICMzNTUNCj4gPiAgWyAgNTk1LjE2MTk5OF0gSGFyZHdhcmUgbmFt
ZTogTlhQIGkuTVg5MyAxMVgxMSBFVksgYm9hcmQgKERUKSAgWw0KPiA+IDU5NS4xNjc0NzVdIENh
bGwgdHJhY2U6DQo+ID4gIFsgIDU5NS4xNjk5MDhdICBkdW1wX2JhY2t0cmFjZSsweDk0LzB4ZWMg
IFsgIDU5NS4xNzM1NzNdDQo+ID4gc2hvd19zdGFjaysweDE4LzB4MjQgIFsgIDU5NS4xNzY4ODRd
ICBkdW1wX3N0YWNrX2x2bCsweDQ4LzB4NjAgIFsNCj4gPiA1OTUuMTgwNTQxXSAgZHVtcF9zdGFj
aysweDE4LzB4MjQgIFsgIDU5NS4xODM4NDNdDQo+ID4gcGNpX2J1c19yZWxlYXNlX2RvbWFpbl9u
cisweDM0LzB4ODQNCj4gPiAgWyAgNTk1LjE4ODQ1M10gIHBjaV9yZW1vdmVfcm9vdF9idXMrMHhh
MC8weGE0ICBbICA1OTUuMTkyNTQ0XQ0KPiA+IHBjaV9ob3N0X2NvbW1vbl9yZW1vdmUrMHgyOC8w
eDQwICBbICA1OTUuMTk2ODk1XQ0KPiA+IHBsYXRmb3JtX3JlbW92ZSsweDU0LzB4NmMgIFsgIDU5
NS4yMDA2NDFdICBkZXZpY2VfcmVtb3ZlKzB4NGMvMHg4MCAgWw0KPiA+IDU5NS4yMDQyMDldICBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHgxZDQvMHgyMzANCj4gPiAgWyAgNTk1LjIw
OTQzMF0gIGRldmljZV9yZWxlYXNlX2RyaXZlcisweDE4LzB4MjQgIFsgIDU5NS4yMTM2OTFdDQo+
ID4gYnVzX3JlbW92ZV9kZXZpY2UrMHhjYy8weDEwYyAgWyAgNTk1LjIxNzY4Nl0gIGRldmljZV9k
ZWwrMHgxNWMvMHg0MWMNCj4gPiBbICA1OTUuMjIxMTcwXSAgcGxhdGZvcm1fZGV2aWNlX2RlbC5w
YXJ0LjArMHgxYy8weDg4DQo+ID4gIFsgIDU5NS4yMjU4NjFdICBwbGF0Zm9ybV9kZXZpY2VfdW5y
ZWdpc3RlcisweDI0LzB4NDANCj4gPiAgWyAgNTk1LjIzMDU1N10gIG9mX3BsYXRmb3JtX2Rldmlj
ZV9kZXN0cm95KzB4ZmMvMHgxMGMNCj4gPiAgWyAgNTk1LjIzNTM0NF0gIG9mX3BsYXRmb3JtX25v
dGlmeSsweDEzYy8weDE3OCAgWyAgNTk1LjIzOTUxOF0NCj4gPiBibG9ja2luZ19ub3RpZmllcl9j
YWxsX2NoYWluKzB4NmMvMHhhMA0KPiA+ICBbICA1OTUuMjQ0Mzg5XSAgX19vZl9jaGFuZ2VzZXRf
ZW50cnlfbm90aWZ5KzB4MTQ4LzB4MTZjDQo+ID4gIFsgIDU5NS4yNDkzNDZdICBvZl9jaGFuZ2Vz
ZXRfcmV2ZXJ0KzB4YTgvMHhjYyAgWyAgNTk1LjI1MzQzN10NCj4gPiBqYWlsaG91c2VfcGNpX3Zp
cnR1YWxfcm9vdF9kZXZpY2VzX3JlbW92ZSsweDUwLzB4NzQgW2phaWxob3VzZV0NCj4gDQo+ICQg
Z2l0IGdyZXAgamFpbGhvdXNlX3BjaV92aXJ0dWFsX3Jvb3RfZGV2aWNlc19yZW1vdmUNCj4gKEVO
RCkNCj4gDQo+IEFub3RoZXIgb3V0IG9mIHRyZWUgb3ZlcmxheSB1c2VyLiBJIGhhdmUgbGl0dGxl
IGludGVyZXN0IGluIHdvcnJ5aW5nIGFib3V0IHRoZW0uDQo+IE5vIG9uZSB3YW50cyB0byBzdGVw
IHVwIGFuZCBzb2x2ZSB0aGUgcHJvYmxlbXMgd2l0aCBvdmVybGF5cywgc28gSSdtIG5vdA0KPiBn
b2luZyB0byB3b3JyeSBhYm91dCB0aGVtIGVpdGhlci4NCg0KT2ssIGJ1dCBJIHRoaW5rIHRoaXMg
aXMgaW5kZWVkIGFuIGlzc3VlLCBpZiBkcml2ZXIgYWNjZXNzaW5nIHByb3BlcnR5IGFmdGVyDQpw
cm9wZXJ0eSByZW1vdmVkIHdpdGggb3ZlcmxheSByZXZlcnQuDQoNCg0KVGhhbmtzLA0KUGVuZy4N
Cg0KPiANCj4gUm9iDQo=

