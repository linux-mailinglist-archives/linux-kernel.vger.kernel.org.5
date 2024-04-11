Return-Path: <linux-kernel+bounces-139863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 102BD8A0898
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 08:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA2522878E4
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 06:38:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3AD01C0DCE;
	Thu, 11 Apr 2024 06:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="eR3Zclez"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2052.outbound.protection.outlook.com [40.107.21.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D4110A11;
	Thu, 11 Apr 2024 06:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712817484; cv=fail; b=mS67J4TD38WxTHB27FamCjrYcKG1XeEBFME3plcBES5JPphirXW4wH9aFBsVdXNkaA8d38murdt9JgUkruUzyLKqiIQPpUSTzBK6hX4D67NDHboD/zuRLofP0IRdHwPrlLkUS0LIDR104iCjMJhJZxMwHcDh7wGVXqfQcXJ23Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712817484; c=relaxed/simple;
	bh=ZFECR5icShiK4ozszzvlN+Y+onpCO4VeavKp8yqQFCc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AvdCWIVmOLQMfYVHWB2TYqE4ldEVd7Wp4Cp3Lcve0cYJ9OopSBmOjDRpep+JJ4F0jauwYrMogjcjdpYn6q5DZq3F7gpFf0f40y7GJYZM7QCZWHywBTiOWenGTMgr6EhV81kdXzSvHIxdWpdbK2B8VPLDMEYsTaTz/7A7aToTb8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=eR3Zclez; arc=fail smtp.client-ip=40.107.21.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lzb7of6nHq1CyqVBwBDO9nercb5+f6zXY/wVcW2MLpdhJ36w7lVNIKiBOUswj/RHlQbQuAoaXRu/UQ1XPXgaqBZnpnOP/yRa9Jjl6Ds1khsH08MK6nD9huqJLdP3AMzlyu/yhR651eybGaODc4gc7VZJtZzkvS24Puc0ERe+BaVJ6LooQutfVzIYB/qQ4y1s/oXYJdBACfkZJtx62MYmNFoZ9s2B/RBj4ow5dbk5yRo9OpQRPmPPzaa57ud3UWmbEQqfIyRng7lHIELSC6uRMA8YBs7wgqSNGkogpXMglMytLmwkYN3z251LOFRXt70cG1W87V1Js0euYqJWM+WiNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFECR5icShiK4ozszzvlN+Y+onpCO4VeavKp8yqQFCc=;
 b=Uv3Yvo759HjpySJeSKBifp+fJPhhCpkknY4pFqRxe8ILa5KrGhkesfS18rDS3jHDmMEUtcXgTUvus3l2oIFqyNDh/UP+H4mdM40hjn/To2SaZCT7+5+dTGZYSsjWHo7O27m/7HRiQrr1DRy/AgmTgmd3g9TFPslIzACEzSpgYf6b3XahDCwZTzTDKb0YoWc7LRIkobGzZHpNoX9ESrK3svIFHaJlt8yHN1fpUpLaYtkfgWer8oPQwQDe+WpcPxK1nah2iSJyeMdpuPLIjKPmHEik4wOLDyZZ9HSU3nmykxOvIDMr+ouH8kK+PR0bpGedqptdGKnKqJE17AQwuo3BBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFECR5icShiK4ozszzvlN+Y+onpCO4VeavKp8yqQFCc=;
 b=eR3ZclezKPm4fnOpewgKbgZswJLSHPH7cWVnhC3PHAOoSKiPXVmh5dDkldJSKz+sb55DzCqDHVZqnAZPXsqQ6dvrc9W52A2cWShCI37W3Yb1tc6hfSUrn2OUfvf9yKP17e3HlZyB6Yw1/D/z34f/BR1m8shyeYsc02Ev0uckhmQ=
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com (2603:10a6:20b:4e9::8)
 by AS8PR04MB8625.eurprd04.prod.outlook.com (2603:10a6:20b:428::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 06:37:58 +0000
Received: from AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba]) by AS4PR04MB9386.eurprd04.prod.outlook.com
 ([fe80::4f24:3f44:d5b1:70ba%7]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 06:37:58 +0000
From: Joy Zou <joy.zou@nxp.com>
To: Marco Felsch <m.felsch@pengutronix.de>
CC: Jacky Bai <ping.bai@nxp.com>, Frank Li <frank.li@nxp.com>,
	"robh+dt@kernel.org" <robh+dt@kernel.org>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [EXT] Re: [PATCH v3 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Topic: [EXT] Re: [PATCH v3 1/1] arm64: dts: imx93-11x11-evk: add rtc
 PCF2131 support
Thread-Index: AQHaixPRjd2Zs0EJBEK7Vw+W12s2t7FhHowAgAF/agA=
Date: Thu, 11 Apr 2024 06:37:58 +0000
Message-ID:
 <AS4PR04MB9386603E175BED248574AE53E1052@AS4PR04MB9386.eurprd04.prod.outlook.com>
References: <20240410070128.1506555-1-joy.zou@nxp.com>
 <20240410070128.1506555-2-joy.zou@nxp.com>
 <20240410074026.qjpk3sjhtbb6sw7j@pengutronix.de>
In-Reply-To: <20240410074026.qjpk3sjhtbb6sw7j@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9386:EE_|AS8PR04MB8625:EE_
x-ms-office365-filtering-correlation-id: c47cd05e-6f03-479e-5042-08dc59f1ed65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Rov9iedSYiK8hxkxFagCJkH9BTSRjJtxmYyZQNdxn/bThIJ3R/D4vj4LX0KDKyRu9IetYycs2lpKv7VRuGT/6mI4ZrTJa46wUrzYWQFSXuWbzXnU9aZvs6ca2qGCzwfbnDIrukVxzWE916sNOCDYEjcz0xt6OkAb4nyvrxhJEbyI1qnTNuDdwiCjoe2Up1HwmDN5cXjXBvewmorm4IajtLD9xLGhXTEpHll2N/39iUbuO8fsJICr7pqUq9ef+XER+GDNwgWvGEQxxUg8GE3/x9+K8iBaELugfK68MuzAGjamqfWxI0Ela5LhCr3hKdKJcQzjD96y2FT8rboxuHCagwd+C0nXznWoE8VDl7nzlFLN435AsKhgfbjH3e4bdRFLtLHP6suyjw+c5+9zFAy8EowM+wUYQKb8pTp5Xcjy641Tpwmzm4ZY0Kj8mBf6JlMpzQDvMHHMATaH6gI2F0lxSW6vXk4Kd27DzFaWwCxbuAuENb9CyVCbhlOQPSO16Le+LgyknYE6D+6pZrc+pwEr4C+KoEaojqQQWBgSsBx4M87gNvDp0xTpZh0MtSzd+XNlw61VqKVR8DupvOzPjVIcKzNB1GvG4ZX7gWmdgJZhNZnpE+ldtpvS7ZwLivR3MePg7uk1qKoDtPYnMZ3Ynm0Rv1kaYFOQ/WRf7ECvqH4Ehju6T147UbveF+apdOE4o0z4B1zvnWMWSn/zrv+jqL2hBQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9386.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?R1UxVnFNVnY1bytXRmVQZWRoamJ6M3F0SU85aXY1UkRaUHQ5WFllRDcwNEVx?=
 =?gb2312?B?VzhFSTJETFA2UEd2OTQ0aXJza0JIRHYxVFhQOGJyL05mNnJ4M291OWRnU0Y5?=
 =?gb2312?B?YTN0endMUlRlSnI3ODNwaEVEOUlHMW1LNllocEFvQzFhU0psMHB6QUNjTXJy?=
 =?gb2312?B?UWUvNEFEWlA0VUpwaXkyOWU5STJtcDA5RWNKMllVVUhNSE5zQ0VrOXhDamFI?=
 =?gb2312?B?bUd0WnNyMUcvNzFlUDNRREx1UTIzZUZpV2U1a0pIMCtjZDEzeVIvak1Xc0xZ?=
 =?gb2312?B?Q1ZpTStlendwMndXcTZONFVVamtrMU5hcDAvVHV6M1BUSjREUllFdE9RckJZ?=
 =?gb2312?B?ZzRZQnBzZmlqV1YwdkFGakI4T1hrRDE3VzQrcXBxOXVoSmw1MjdPc0MxMWRi?=
 =?gb2312?B?RFluS1V4RmRNdWRyamVQLytvQmJrbHN1TjNLS0RmZk9VQ09OOXFYeXFiU09W?=
 =?gb2312?B?eVBiNEZFRmNhRk1HTUlyV3JPV0dva3h6UU44QlNxTmhWeHN5OFNCVDQwZFAv?=
 =?gb2312?B?VDBuSmxWdDFraFR1UEoybUZScExWdmh0UUZWQzJsRmxwVC9sWEpZNW5ONWNH?=
 =?gb2312?B?aU85MzVrSmwvNWlnVGFMc3pjTDBwVXVKZjN0TlUwNzE4RWVMazdoQlNrbXdu?=
 =?gb2312?B?dG9SUWpvMDRXaWwzVDVVbytmSVltWU1SMSthajRjQ3IvcTB5NCtwbnJJNXZz?=
 =?gb2312?B?UHRBMUMycVJ2OGFNZUtsWTNENUgrV1pOTGlwZmhsbWt4SU9XY3gvdHFkaGRo?=
 =?gb2312?B?WGRBRjYza0FXRVNnKzNyNi9KMWs5OVNtaTVOWGl2MjNIMHV4NStTMnlvaXpa?=
 =?gb2312?B?N0dVQUtoYk54RS9JRmZCMC9xR3BTUlB0dEVNcitTNTVuNFVHWnJHcXZsbURl?=
 =?gb2312?B?NmtjUG9sTTU3Qmpac3JHb3ZDK0RCeWdmcW10RXFLSytSdFlyYTNBMlQzb0w1?=
 =?gb2312?B?cHc0OVZVS0dwT05tM2lpbHk5NkdHZUVwRkhYc1lSRTllei8vNzhQZExiMEkw?=
 =?gb2312?B?djkzT1Y4MHVMVkhVcmFEV3o3bUk4eDZmbU5SaGwydGJMN1NhV1l3SEdZcURO?=
 =?gb2312?B?UXFZT1I0eXF1Qkk0M2dMN3QwSjZUd2tjdk1wcnpHRHh5MUNDamRHTy94ZlZz?=
 =?gb2312?B?ZHlBcTdrRjNvVTU2ajA0ZHluait5dnJyVDJQM2ZaK2Mxalc3ZVNSTVZ4Y0lD?=
 =?gb2312?B?dm9VUGhrMUUzUmliaUFtRU1KcmJrK1lXVUx3ZmhnSDI2YkdpZ2pRanZkMkJE?=
 =?gb2312?B?c09pV3JMdkYrQXBxZXg2a1NsM1U4am11OVQreWJtWlZ1L3ZFdzZjekhLK0pU?=
 =?gb2312?B?YkJPRGdpd2FhQXlMMFFXcUEyRmJqeUdwUTlXZlhJRDErMVltRW5mM2pnQkNa?=
 =?gb2312?B?VVZXUjhiWk5LWWQ0eEFxUHRvU2UrU1loZS96azJZVCtFZUZPVkhJNHBnd1pi?=
 =?gb2312?B?aG41MHoxeGJ4d1U5MktuQnlOcDJ1TEFuRFB0VGREZjZXRlBxeVdUbldEM05Q?=
 =?gb2312?B?UmRBRFZuSWZReFZJRldua0pQamYzeDVjcUNMUkt0QyszWm5NMmY0YWFBM1V5?=
 =?gb2312?B?Y3ZwTWFxODFWcUZJSERXV0RlcmZDbXFmOHRnUzRWMFo4cHloUDVQbnlWcmFn?=
 =?gb2312?B?SjdYT0RzdExQRUdEcjFPb1cxTkc2Q2pwNGlpVHZ3dURGay9qWFRVMEdjcW1U?=
 =?gb2312?B?S2UxL2k2WHdFWUxKVEV1eEFtYW9Cb2ZVb2FtY1BPT2ljLy9wbGlyZ1VkcGV0?=
 =?gb2312?B?a08zVVBzMy9KOHlKdjVqT0o5R3hGV1Vxbm02MU1TZGYya0dNTXV4S2g0azJv?=
 =?gb2312?B?dkEwZVRmM3FqbHNqNDRSVmVKakl6a3NwdWpDYzl0ekZHbXNBZ0VMa0xCcEhQ?=
 =?gb2312?B?bU82OVR4dE0vYWM4YWpwdldGcG1UaW8wWXJBbU9VTGYraTliME1KamU2RTJI?=
 =?gb2312?B?U084YXJ3dFVIanVRK3h5NUZiVDhUcXI1M2dDWTJtbitvZ1ZreXQzVjY3aGR3?=
 =?gb2312?B?M1F2a3JMc1JkcjhBVWJ5eHc3MnlueUV4KzIwOGJXbUZyUlNKWC9oTXBhQlhX?=
 =?gb2312?B?OXpiVWZuYjJldnorM2JqWnhYNHNWNkNIYmU3bXdJdFQzREJoL2k1UVJJeTV3?=
 =?gb2312?Q?ZtZk=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9386.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c47cd05e-6f03-479e-5042-08dc59f1ed65
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 06:37:58.4042
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pm7RSkCwiyxAp/OuippCgPWEEcY4fMy/1vxw5TssEaqAOgE07eMveeIWobY3O+Is
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8625

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IE1hcmNvIEZlbHNjaCA8bS5m
ZWxzY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjTE6jTUwjEwyNUgMTU6NDANCj4gVG86
IEpveSBab3UgPGpveS56b3VAbnhwLmNvbT4NCj4gQ2M6IEphY2t5IEJhaSA8cGluZy5iYWlAbnhw
LmNvbT47IHJvYmgrZHRAa2VybmVsLm9yZzsNCj4ga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5h
cm8ub3JnOyBjb25vcitkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhh
dWVyQHBlbmd1dHJvbml4LmRlOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gaW14QGxp
c3RzLmxpbnV4LmRldjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14
DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2YW1A
Z21haWwuY29tOw0KPiBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gU3Vi
amVjdDogW0VYVF0gUmU6IFtQQVRDSCB2MyAxLzFdIGFybTY0OiBkdHM6IGlteDkzLTExeDExLWV2
azogYWRkIHJ0Yw0KPiBQQ0YyMTMxIHN1cHBvcnQNCj4gT24gMjQtMDQtMTAsIEpveSBab3Ugd3Jv
dGU6DQo+ID4gU3VwcG9ydCBydGMgUENGMjEzMSBvbiBpbXg5My0xMXgxMS1ldmsuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBKb3kgWm91IDxqb3kuem91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
Q2hhbmdlcyBpbiB2MzoNCj4gPiAxLmFkanVzdCB0aGUgaW5kZW50YXRpb24uDQo+ID4NCj4gPiBD
aGFuZ2VzIGluIHYyOg0KPiA+IDEuIHJlbW92ZSB1bm5lY2Vzc2FyeSBzdGF0dXMgcHJvcGVydHku
DQo+ID4gLS0tDQo+ID4gIC4uLi9ib290L2R0cy9mcmVlc2NhbGUvaW14OTMtMTF4MTEtZXZrLmR0
cyAgICB8IDI0DQo+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI0
IGluc2VydGlvbnMoKykNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRz
L2ZyZWVzY2FsZS9pbXg5My0xMXgxMS1ldmsuZHRzDQo+ID4gaW5kZXggMDdlODVhMzBhMjVmLi43
M2UwYmNhMzZiODEgMTAwNjQ0DQo+ID4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2Nh
bGUvaW14OTMtMTF4MTEtZXZrLmR0cw0KPiA+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMvZnJl
ZXNjYWxlL2lteDkzLTExeDExLWV2ay5kdHMNCj4gPiBAQCAtMjgxLDYgKzI4MSwyMyBAQCBsZG81
OiBMRE81IHsNCj4gPiAgICAgICB9Ow0KPiA+ICB9Ow0KPiA+DQo+ID4gKyZscGkyYzMgew0KPiA+
ICsgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICNzaXplLWNlbGxzID0gPDA+
Ow0KPiA+ICsgICAgIGNsb2NrLWZyZXF1ZW5jeSA9IDw0MDAwMDA+Ow0KPiA+ICsgICAgIHBpbmN0
cmwtbmFtZXMgPSAiZGVmYXVsdCIsICJzbGVlcCI7DQo+ID4gKyAgICAgcGluY3RybC0wID0gPCZw
aW5jdHJsX2xwaTJjMz47DQo+ID4gKyAgICAgcGluY3RybC0xID0gPCZwaW5jdHJsX2xwaTJjMz47
DQo+IA0KPiBBcmUgYm90aCAiZGVmYXVsdCIgYW5kICJzbGVlcCIgcGluY3RybCdzIHJlcXVpcmVk
PyBJdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNlDQo+IHRvIHByb3ZkZSBhIHNsZWVwIHN0YXRlIHdo
aWNoIHVzZXMgdGhlIHNhbWUgcGluY3RybCBzdGF0ZS4NClRoYW5rcyBmb3IgeW91ciBjb21tZW50
cyENCkN1cnJlbnRseSwgV2Ugb25seSB1c2UgZGVmYXVsdC4gWWVhaCwgSXQncyBjb25mdXNlZCB0
aGF0IGEgc2xlZXAgc3RhdGUgd2hpY2ggdXNlcyB0aGUgc2FtZSBwaW5jdHJsIHN0YXRlLg0KU28g
d2lsbCByZW1vdmUgdGhlIHNsZWVwLg0KQlINCkpveSBab3UNCj4gDQo+IFJlZ2FyZHMsDQo+ICAg
TWFyY28NCj4gDQoNCg==

