Return-Path: <linux-kernel+bounces-138720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3558F89F9D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA967B34741
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCC415ECE1;
	Wed, 10 Apr 2024 14:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="QN0555IK"
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2123.outbound.protection.outlook.com [40.107.114.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30378156F4F;
	Wed, 10 Apr 2024 14:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712757936; cv=fail; b=LUYt2nZX1GyqBM9QwWosAitPEq42LjFr5iPieKiVbGSE2ixrJEM8kyd07/JjS3A7GZiyF0PyqHZylZBOQv555IIWCK2JPuDaAlfY7DHHO5WomhhXEmFTSsKHHxNBcVOIrStl8ca1Svu+HyXce1wRs14lQ2Xk497iyIIQkNLyd7w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712757936; c=relaxed/simple;
	bh=fD9OsHgNZ54xneKt3IQ7AVq/+F5Wadyr6nmDNz4rrl0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AO71TbKXHIZzHThJtM96NL3JGf1D1Cm2ADg6HvXxR3Oa7VyuKha3SDEg82sywu7t15wzKLCSFnSqPvlajLmZYVJgfU69a/c21o9XFuob6PYZWGiwwVH9dvzLZeu15blJDOzgSGNq1CbAz0AyqV1jC45Su7uH9rbll9NBStb6Poc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=QN0555IK; arc=fail smtp.client-ip=40.107.114.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXR3zE3hmELobT43athDeSBavThNcowVuW0FG2VeXdjmw+HbbYUhFFJ813JXYBqcEyrk1kfifSoIjrikhHW3/m2OmkB75CDwXcPjhE4DOhQoTmZJnpm5qeWJc2bYHP6B6i7KNnn21goh9dJ0IZ4JkmfZLfMbJgBBuBRI0oBzbexcu52pjJZjt0C3UnFWGUkZ54/htzaCrVy93EaeiZkSw9V2Jgjt+00erhBKckYUemcnhl+lXzDsxuZLmFWG7VFXPuX8xwZkI+fXMZrOdII7oUiFuM8AFfAxWvKEyUBS7LzshxghohQMFd+VYLZbDMUibXwgYxPuDmH+B2QgCTRO9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fD9OsHgNZ54xneKt3IQ7AVq/+F5Wadyr6nmDNz4rrl0=;
 b=d7Tq3o3RASe+heT6Yqz9GeuGVMx7is5DnIGQtqy1VOlgc16dJQWUGf2vzzNR/i1WxWMF3ahyWJO/q8lMdQjSQckXUkokAIhZsLSY9igKPmnzlKeAfqUr5l+hviHsTXdZe2ToU9Ob2Q8qk5WXJKmj7eDojeiUrlTmJJh5vY3Dp1jb2H+vdocjkn7hwq/QN/nfY7n+UDzQUuIFKSGXShzp+8szn4lhRMGpMkLNhC+9mDsrsw+FELV/bg6gxjtZOLqp/IG/Z/xzJmehj49qIn870X07A+yHFqxZiZMzUxjbtDnG+X+3K9CmT/UQlCPnGJ49qJTqzPDBmu/hXcdC2AOemg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fD9OsHgNZ54xneKt3IQ7AVq/+F5Wadyr6nmDNz4rrl0=;
 b=QN0555IK00tj8jv6p2bSqTYnk7g3sz+daqT3BbVvyQQnGj8Mfl+7MnRjJOJp6CU2zRdJ09ZZBY+nSIL/VJzVfgB+a78Dt9RXQrDKh8f2RcxgT1nHVKUi8dL+0/aZAWKp+Sj8jzIZF9WxZAWb/hVesKOh6ivmkhjn4sDcftjukHw=
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com (2603:1096:603:2e::16)
 by OS3PR01MB8368.jpnprd01.prod.outlook.com (2603:1096:604:193::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 10 Apr
 2024 14:05:30 +0000
Received: from OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce]) by OSAPR01MB1587.jpnprd01.prod.outlook.com
 ([fe80::fda5:45f9:f1b2:cbce%3]) with mapi id 15.20.7409.042; Wed, 10 Apr 2024
 14:05:30 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Claudiu.Beznea <claudiu.beznea@tuxon.dev>, "wim@linux-watchdog.org"
	<wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>, "geert+renesas@glider.be"
	<geert+renesas@glider.be>, "magnus.damm@gmail.com" <magnus.damm@gmail.com>
CC: "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: RE: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Topic: [PATCH RESEND v8 03/10] watchdog: rzg2l_wdt: Use
 pm_runtime_resume_and_get()
Thread-Index: AQHai0zBWu2V0gpeGk2Rf6eyLae+ArFhhK+wgAAD9ACAAAAqEA==
Date: Wed, 10 Apr 2024 14:05:30 +0000
Message-ID:
 <OSAPR01MB1587B13B2B452AA110CBD6E486062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
References: <20240410134044.2138310-1-claudiu.beznea.uj@bp.renesas.com>
 <20240410134044.2138310-4-claudiu.beznea.uj@bp.renesas.com>
 <OSAPR01MB15874891F67AAFAA955A186886062@OSAPR01MB1587.jpnprd01.prod.outlook.com>
 <11a371b5-f649-4dfb-94d1-9a01b15d5993@tuxon.dev>
In-Reply-To: <11a371b5-f649-4dfb-94d1-9a01b15d5993@tuxon.dev>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: OSAPR01MB1587:EE_|OS3PR01MB8368:EE_
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OAj0ZVdGVUPKDlbTJCrPIqndYMNJXh11Q762+/AQW46Ai/BrUXDhhhjSoUHmVWMhQ9qcxL/zC+5WEzIl5eJ11dvzT503aih66Lb5RQsYwTwhN3gYfYIkGpXWALEHZvPbNGR5+JD+4LX4KZaGUsCCGV6/G7Iz93L9RoThRBNqPz1QKfksZLO+WA35Q5iktFgv8FssWxl7Jyalt/swnmPN1vmICtIyFeCJHfLCWJ2p4aeHwoNNj5ttDMQKIZVXmG40iOwOG8EAwMcRN06+sSrCWwYr2aK1JPj7VrCN36LuACACT4yGk+S6hH5LcNO0Jg3wRckSLBDG5E4CHM/QvYPslW+66uApMqTUxMmK6khTEjcPzvQg8jkY5+fQ4d6ENi7KaCLuD9ShfHTkfSg/14lUatA0eco3PTrm9He/lNFnWojBkNqVDrc/PEFi87Hbyotg0QHToY8m4aaeevdERp6FZdweSC5/qqtGqWMWelWQ9bQFQXK6n1qHByYG22tYXc2SoVyucIulNmWlk+hkPRXkKbDP7iA+AukfeVkhqE+xOgdpSaHbGAHVfTazzTD2rM9UGftteTD7U3rtBdd/vqqmEc2skrGD3XkQFx/WemSXXWgZRJ6e11nx4rsjOBccHeANBc8I2iHB3bHfO/94vUcyQZntb71kgkp5Vu7Le6Vjx1M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSAPR01MB1587.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZENGM1RBQXZ6dTgxU3FmaW9wVEU2SmxjekFVbkREZXRWVWdqelRyUnVpUHdh?=
 =?utf-8?B?RjVIczNHZnlYQWxINHNPY3lZQm5JWTQ2Z1FyZXBEWTNSQmdJd3piUVdUV1dH?=
 =?utf-8?B?OEdxaFZxblY1YmhxNTdyYWpnNEtZRDRmN1h0Z3MxWXF6Uk1pekN5WWlHazhV?=
 =?utf-8?B?Q1dDSW4zZkhDNVplM25ndW4rdzZjWjFtUEgxcHV2SFpLVWhFSHN2ei9pQ2xv?=
 =?utf-8?B?bE9oNWJOZzBscTloSWNwQktYWDlEUHpTbDRZeVYybG5sN01XY0laRUk4dUNM?=
 =?utf-8?B?QUMweDJLTTFYTFdWNzNudjhwa20zM0thRHNzVVBVODRPcUpZQ1VBNG5JWnFv?=
 =?utf-8?B?Z1NvYzFpMmgyOWlHeDlaTXgwZk5Mc1JWeGlmRVpOSi84VGtjNCtiQzRIVEVk?=
 =?utf-8?B?SEFCVUdaSU5kNDV5ZzlocE9tTzhCWDhuZ1lXaU9LbnRxQUxMLzFKeG5xQTdi?=
 =?utf-8?B?YVVTb0FGSjhNQk5BTG4zQ0NEYWVSeGpQYzlpcTBRQk14OXJVaThtZU1uZU9Q?=
 =?utf-8?B?dmgyU3k0N3k0a2xSeFZjanFIeis5eUY2bGVRTlNhbEE1SWpib0U3QjZEWGMr?=
 =?utf-8?B?cDM2NUlqSVdwWlVKc3BiSXJ4cDhNRVZ0c091ZTdaZnB4L3l4ZUlmdmtrR2F5?=
 =?utf-8?B?Y0tXUUtSUmpYMUhtdFdocG5XY3kyRUR4eVkySWppVVZleXZaYTdPQVgvSFNp?=
 =?utf-8?B?eWtqV2pPb2xtc0hhbG9ydkdKSHhBZWN2L0tTa1Y5UXVKaS90MTk1M2pIOTF3?=
 =?utf-8?B?NitPZmpIY1lzemt2Z3dJdVhaK2krN1NOWUI1S0VJZ2VmanlrZ0JJODlLS09G?=
 =?utf-8?B?SVJqaTQ4MW9aWGNtUHRWbld4MGVuTTIxZWhVeTRUa3ZPSFVScTBNL1Nxdnhj?=
 =?utf-8?B?Nk9nMzVweUhsOURuV2tpTFBGcEs5VEtmeitaTnd3YXU4dDZWTTczdGFjYmJT?=
 =?utf-8?B?NlVqMy93ZnluaDlHN3dNWXd0NDZVdkF2YS9vb1ZCeFBGSjZMcVZLL1dSTFN3?=
 =?utf-8?B?NGd5Sk9MTWorUUowdTUwRDBFcDN3Wk9hTGlsUzZQeFpBaS9vSlU1b2JkbmNj?=
 =?utf-8?B?ZHNSU2xYamJZSnNOcmt1ZEswZ0puMXRYTFhaOFR5SDNWNEhkQmJWU3M2NUYr?=
 =?utf-8?B?ZUlXMVg5OG8waEg2ZTZ3blNwTzJ1MjliekJpN2duN2FMMndlenZSdWRESi9N?=
 =?utf-8?B?TVBLUXNQUEM0dC9nQVBuUTNoem9rN3duR0E5bXppc29ML1FZVytHTzRjWEVO?=
 =?utf-8?B?dlFMMVAzZlc0TGY0eGpKSS9GdnhHUzBuN01MLzZlSzErZzNBclA4YUxUK282?=
 =?utf-8?B?VHJteXVJcXZzdSttVm00UHFXUHE5Slk2ci9aV1NuN2Y2ZG5FaFNNK3ZuTUl3?=
 =?utf-8?B?cU1rTEwvVnNFVHNTbTZaZDVkMjZJUW81amJrVVVoRS9XeU04R2NWdU9Ub0Zs?=
 =?utf-8?B?N3FUd21LdzNVeEFjdHV3STNuMnJWczcrOHpIdXpFcllTVjlwR0JzeGd6MkdR?=
 =?utf-8?B?RllERnR4VldyUDBGeVk4U2RmL1pRL3B4Skt5UzZGRElLMFUwU3BqRTkrMXhY?=
 =?utf-8?B?UzFZbzRqTEJzLzlLWGY5enRxemNhTCs2V1Z1R3lCcDZPcnRtVEpwdEFoMzhu?=
 =?utf-8?B?c3NsVmJ1YzBrVmJlRGdydVpoODl4YVJxRVpPOXBrMkhxRis5TnlCbU13ZGlL?=
 =?utf-8?B?Wjh4QVFhRndaOERzZHN5YXltNHVxQUZRU1FwYVdweXhidlZoY3g1T3dTQmxO?=
 =?utf-8?B?TkNnWHB0aU05Z3Y1UFJ5bTFSRklqb1NENmRza0JzT0RhTEtLaTREYmlIVWxv?=
 =?utf-8?B?WkV0VDR3NnJHN3Bmc2U0OHlyQnJkNUcyaWJXazJubWpKdWQ3L2poQkpmQmhm?=
 =?utf-8?B?K2U3MU5IS0tFVXRIWnlRKzlUN2tzaitJdFhBVHUyYTRJb1RTeGpxaG9jdTUv?=
 =?utf-8?B?czB1KzE3SDcwTStTRW1iMFlLYnd5K1kxVkViTDJQUXBERmhzVnh4RFFyMGxj?=
 =?utf-8?B?M3hqdTVsdUZpa3IrbHU1VWdyVGVEVFN4RVFjYU4xZjdINUJnNGZYR09hN0VX?=
 =?utf-8?B?QXliNnJYNHBwTVBYVEtKTGdsL1JIRFo2cHFwUlZETSt0enJTWXloSFNpRVVx?=
 =?utf-8?B?RXhYMUhQUUZSK3VDV0hXZEh0K0JsMUZtMnVNZExGaGl2a1NqSVEvQXhoZkNL?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSAPR01MB1587.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc7b6c8-e897-4814-9a16-08dc596747f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2024 14:05:30.3284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iU6R0pqRj1EurSGtga8gizzb8teu716ADQF/gfRGJlbZ5vto0r+mM+2pbGjgQ5o2rjhOkrQ27huaou+NOfxdkIP2D/cDmy6JuHFpBFxxruo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8368

SGkgQ2xhdWRpdSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBjbGF1
ZGl1IGJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAdHV4b24uZGV2Pg0KPiBTZW50OiBXZWRuZXNkYXks
IEFwcmlsIDEwLCAyMDI0IDM6MDIgUE0NCj4gU3ViamVjdDogUmU6IFtQQVRDSCBSRVNFTkQgdjgg
MDMvMTBdIHdhdGNoZG9nOiByemcybF93ZHQ6IFVzZSBwbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0
KCkNCj4gDQo+IA0KPiANCj4gT24gMTAuMDQuMjAyNCAxNjo1MSwgQmlqdSBEYXMgd3JvdGU6DQo+
ID4gSGkgQ2xhdWRpdSwNCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBDbGF1ZGl1IDxjbGF1ZGl1LmJlem5lYUB0dXhvbi5kZXY+DQo+ID4+IFNlbnQ6IFdl
ZG5lc2RheSwgQXByaWwgMTAsIDIwMjQgMjo0MSBQTQ0KPiA+PiBTdWJqZWN0OiBbUEFUQ0ggUkVT
RU5EIHY4IDAzLzEwXSB3YXRjaGRvZzogcnpnMmxfd2R0OiBVc2UNCj4gPj4gcG1fcnVudGltZV9y
ZXN1bWVfYW5kX2dldCgpDQo+ID4+DQo+ID4+IEZyb206IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1
LmJlem5lYS51akBicC5yZW5lc2FzLmNvbT4NCj4gPj4NCj4gPj4gcG1fcnVudGltZV9nZXRfc3lu
YygpIG1heSByZXR1cm4gd2l0aCBlcnJvci4gSW4gY2FzZSBpdCByZXR1cm5zIHdpdGgNCj4gPj4g
ZXJyb3INCj4gPj4gZGV2LT5wb3dlci51c2FnZV9jb3VudCBuZWVkcyB0byBiZSBkZWNyZW1lbnRl
ZC4NCj4gPj4gZGV2LT5wbV9ydW50aW1lX3Jlc3VtZV9hbmRfZ2V0KCkNCj4gPj4gdGFrZXMgY2Fy
ZSBvZiB0aGlzLiBUaHVzIHVzZSBpdC4NCj4gPj4NCj4gPj4gQWxvbmcgd2l0aCBpdCB0aGUgcnpn
Mmxfd2R0X3NldF90aW1lb3V0KCkgZnVuY3Rpb24gd2FzIHVwZGF0ZWQgdG8NCj4gPj4gcHJvcGFn
YXRlIHRoZSByZXN1bHQgb2YNCj4gPj4gcnpnMmxfd2R0X3N0YXJ0KCkgdG8gaXRzIGNhbGxlci4N
Cj4gPj4NCj4gPj4gRml4ZXM6IDJjYmM1Y2QwYjU1ZiAoIndhdGNoZG9nOiBBZGQgV2F0Y2hkb2cg
VGltZXIgZHJpdmVyIGZvcg0KPiA+PiBSWi9HMkwiKQ0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1
ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWEudWpAYnAucmVuZXNhcy5jb20+DQo+ID4+IC0tLQ0K
PiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY4Og0KPiA+PiAtIG5vbmUNCj4gPj4NCj4gPj4gQ2hhbmdl
cyBpbiB2NzoNCj4gPj4gLSBub25lDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjY6DQo+ID4+IC0g
bm9uZQ0KPiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHY1Og0KPiA+PiAtIG5vbmUNCj4gPj4NCj4gPj4g
Q2hhbmdlcyBpbiB2NDoNCj4gPj4gLSBub25lDQo+ID4+DQo+ID4+IENoYW5nZXMgaW4gdjM6DQo+
ID4+IC0gbm9uZQ0KPiA+Pg0KPiA+PiBDaGFuZ2VzIGluIHYyOg0KPiA+PiAtIHByb3BhZ2F0ZSB0
aGUgcmV0dXJuIGNvZGUgb2YgcnpnMmxfd2R0X3N0YXJ0KCkgdG8gaXQncyBjYWxsZXJzDQo+ID4+
DQo+ID4+DQo+ID4+ICBkcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jIHwgMTEgKysrKysrKyst
LS0NCj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0p
DQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+
ID4+IGIvZHJpdmVycy93YXRjaGRvZy9yemcybF93ZHQuYyBpbmRleCAxNzQxZjk4Y2E2N2MuLmQ4
N2Q0ZjUwMTgwYw0KPiA+PiAxMDA2NDQNCj4gPj4gLS0tIGEvZHJpdmVycy93YXRjaGRvZy9yemcy
bF93ZHQuYw0KPiA+PiArKysgYi9kcml2ZXJzL3dhdGNoZG9nL3J6ZzJsX3dkdC5jDQo+ID4+IEBA
IC0xMjMsOCArMTIzLDExIEBAIHN0YXRpYyB2b2lkIHJ6ZzJsX3dkdF9pbml0X3RpbWVvdXQoc3Ry
dWN0DQo+ID4+IHdhdGNoZG9nX2RldmljZSAqd2RldikgIHN0YXRpYyBpbnQgcnpnMmxfd2R0X3N0
YXJ0KHN0cnVjdCB3YXRjaGRvZ19kZXZpY2UgKndkZXYpICB7DQo+ID4+ICAJc3RydWN0IHJ6ZzJs
X3dkdF9wcml2ICpwcml2ID0gd2F0Y2hkb2dfZ2V0X2RydmRhdGEod2Rldik7DQo+ID4+ICsJaW50
IHJldDsNCj4gPj4NCj4gPj4gLQlwbV9ydW50aW1lX2dldF9zeW5jKHdkZXYtPnBhcmVudCk7DQo+
ID4+ICsJcmV0ID0gcG1fcnVudGltZV9yZXN1bWVfYW5kX2dldCh3ZGV2LT5wYXJlbnQpOw0KPiA+
PiArCWlmIChyZXQpDQo+ID4+ICsJCXJldHVybiByZXQ7DQo+ID4+DQo+ID4+ICAJLyogSW5pdGlh
bGl6ZSB0aW1lIG91dCAqLw0KPiA+PiAgCXJ6ZzJsX3dkdF9pbml0X3RpbWVvdXQod2Rldik7DQo+
ID4+IEBAIC0xNTAsNiArMTUzLDggQEAgc3RhdGljIGludCByemcybF93ZHRfc3RvcChzdHJ1Y3Qg
d2F0Y2hkb2dfZGV2aWNlDQo+ID4+ICp3ZGV2KQ0KPiA+Pg0KPiA+PiAgc3RhdGljIGludCByemcy
bF93ZHRfc2V0X3RpbWVvdXQoc3RydWN0IHdhdGNoZG9nX2RldmljZSAqd2RldiwNCj4gPj4gdW5z
aWduZWQgaW50IHRpbWVvdXQpICB7DQo+ID4+ICsJaW50IHJldCA9IDA7DQo+ID4+ICsNCj4gPj4g
IAl3ZGV2LT50aW1lb3V0ID0gdGltZW91dDsNCj4gPj4NCj4gPj4gIAkvKg0KPiA+PiBAQCAtMTU5
LDEwICsxNjQsMTAgQEAgc3RhdGljIGludCByemcybF93ZHRfc2V0X3RpbWVvdXQoc3RydWN0DQo+
ID4+IHdhdGNoZG9nX2RldmljZSAqd2RldiwgdW5zaWduZWQgaW50IHRpbWUNCj4gPj4gIAkgKi8N
Cj4gPj4gIAlpZiAod2F0Y2hkb2dfYWN0aXZlKHdkZXYpKSB7DQo+ID4+ICAJCXJ6ZzJsX3dkdF9z
dG9wKHdkZXYpOw0KPiA+PiAtCQlyemcybF93ZHRfc3RhcnQod2Rldik7DQo+ID4+ICsJCXJldCA9
IHJ6ZzJsX3dkdF9zdGFydCh3ZGV2KTsNCj4gPg0KPiA+IFRoaXMgSVAgd29uJ3QgYmUgYWJsZSB0
byB1cGRhdGUgV0RUIHNldHRpbmdzIG9uY2UgeW91IGhhdmUgc2V0IGl0Lg0KPiA+DQo+ID4gQnV0
IHdlIGNhbiB1cGRhdGUgaXQsIGlmIHdlIGRvIGEgcmVzZXQgYXNzZXJ0IGZvbGxvd2VkIGJ5IGRl
YXNzZXJ0Lg0KPiA+IFNvIHRoZSBwcmV2aW91cyBjb2RlIGxvb2tzIGNvcnJlY3QgdG8gbWUuDQo+
ID4NCj4gPiBDdXJyZW50IGNhc2UgaXMgaWYgdGhlIFdEVCBpcyBhY3RpdmUsIHRoZW4gc3RhcnQg
aXQuIE1heWJlIEkgbWEgbWlzc2luZyBzb21ldGhpbmcgaGVyZS4NCj4gPg0KPiANCj4gSSdtIG5v
dCBzdXJlIEkgZ290IHlvdSBjb3JyZWN0bHkuDQo+IA0KPiBUaGlzIHBhdGNoIGtlZXBzIHRoZSBw
cmV2aW91cyBmdW5jdGlvbmFsaXR5LCB0aHVzLCBpZiB0aGUgd2F0Y2hkb2cgaXMgYWN0aXZlIHJ6
ZzJsX3dkdF9zdG9wKCkgaXMNCj4gY2FsbGVkIHdoaWNoIGRvZXMgYSByZXNldCBhc3NlcnQuIFRo
ZW4NCj4gcnpnMmxfd2R0X3N0YXJ0KCkgaXMgY2FsbGVkIHdoaWNoIGRvZXMgdGhlIHJlc2V0IGRl
YXNzZXJ0Lg0KDQpZb3UgYXJlIGNvcnJlY3QuIEkgb3Zlcmxvb2tlZCBhbmQgdGhvdWdodCB5b3Ug
aGF2ZSByZW1vdmVkICpfc3RvcCgpIGFzIHdlbGwuDQpTb3JyeSBmb3IgdGhlIG5vaXNlLg0KDQpD
aGVlcnMsDQpCaWp1DQoNCg0KPiA+PiAgCX0NCj4gPj4NCj4gPj4gLQlyZXR1cm4gMDsNCj4gPj4g
KwlyZXR1cm4gcmV0Ow0KPiA+PiAgfQ0KPiA+Pg0KPiA+PiAgc3RhdGljIGludCByemcybF93ZHRf
cmVzdGFydChzdHJ1Y3Qgd2F0Y2hkb2dfZGV2aWNlICp3ZGV2LA0KPiA+PiAtLQ0KPiA+PiAyLjM5
LjINCj4gPg0K

