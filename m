Return-Path: <linux-kernel+bounces-111738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76945887021
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BF5B22C76
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11CA456751;
	Fri, 22 Mar 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="L0TsjYBR"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2139.outbound.protection.outlook.com [40.107.20.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B65A0EB;
	Fri, 22 Mar 2024 15:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.139
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123122; cv=fail; b=LX8sQobXOCx6Qt30KmKBl4LIiWSIlq+wi/bMS3/lHeUm7TAadVHMujqDK7H+La+mPQNEsipcfbRv+aUw6XHuk1i1hfkh+GzJDbQ/wBLa5Yhny4lbbEukeGEnLzByszfMCyo6XUl+i+l0zAwqYZhRzach/77HVWlQ4hxIE1/HSQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123122; c=relaxed/simple;
	bh=2xuFEA7Yulko8Or7jy7HwUz7TI569ysIaCRUwAskxyY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s3vwNr5sq9jcU/AQDXFiLHHhovHz4XLTZVFtVRrv/n/X0UVT/tb/vWcFYuxU+1A8Lxq2Ugh1um0kN56svGGMjNwrVauVaqHPBR+iXMHyljtbVvZ5zXBcMOrdEvjh2eYXEu3YZJxh+k07nWLT+zG2Z9EhlwQwGx38f0tXxIUiX3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=L0TsjYBR; arc=fail smtp.client-ip=40.107.20.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiFHgpffwVKpnqmNTLT3zNNooG4+P1QHYTRxe8Jf+H+IwhH9cG9BglxOcq6FgQgVpkjlwGBHRvkyXMCB1J1XhSAEfEecNPaOk8V8P+0ygwqd7JikxZLfAnXjmk63x+h2AnOQxHvubap4SFFlXGvljy5ijVV+IRweJJbpX9B3RSM00mM5/7tB3xK63ZcN17vmd/dXoD8qKJQ11qQ0XPLvUQyyFH6pD/4B3Jb1xcJh99H3SJTujEFfBQGNXoftpgNfjMJ0Yv41wtndhsZp6zNthQEUGJBgOGI/5wiv5Wvtby9IZuiXsxT4cNm8goD1yY/tPmtQCW+IwsNn5OpLDvC5Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2xuFEA7Yulko8Or7jy7HwUz7TI569ysIaCRUwAskxyY=;
 b=NMrDAfniFThFB9IsHZ1soBUF1OzmdcdR0kcCBnayFOUBFiDDmrPv5Z7UBVNbHAzWYvj8IOWNIxA6avkwnGj0EIlNdSnrFUVXSAGYJaT0tUFw7eOI5CuPolauQ0uUa3vssJhia8PUyVJCmjsT0/tGelyXJaZilXaapchlKM910dt3eRlq3od6erCaTfJIS9T4nE1SGNw7tiXtP1kPpYNUX70B/FGeCCkJPfpMoATga5hk9vfRmmBx34Em6JsmM1B7/A3PCzYYmhiFYaxN/OQm1TBFPctJwkY1/5mfb1dW2WQmX0Z+O/TMHsd2KE7dJtQVuKiBU3z63+QHHFP5TtXQRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2xuFEA7Yulko8Or7jy7HwUz7TI569ysIaCRUwAskxyY=;
 b=L0TsjYBR0ehUuXY01xY5TMD05URZjALGI2jUxz4rgUOIYiMMYaPcfDP3WyECgaKaAfYsJ3tnZnWIcisI/zVVP2Zas5TQX4Fk35coVv/RzuwO3yx0QMKetBOMQBIxi2RWOJNdEBNqQ2/zOmkaCF1W4LHhsTjTg0efZO4Zv4mUEvc=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB9002.eurprd04.prod.outlook.com (2603:10a6:20b:409::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 15:58:37 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 15:58:37 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Topic: [PATCH 2/2] arm64: dts: add description for solidrun cn9130 som
 and clearfog boards
Thread-Index:
 AQHae9lamF1Na8/mpEGgdJkfFpR9o7FCvoaAgADHmICAADb7AIAAKS8AgAAC+YCAAAKkAA==
Date: Fri, 22 Mar 2024 15:58:37 +0000
Message-ID: <542b7c30-a650-471a-8030-d1d6d70cb17f@solid-run.com>
References: <20240321-cn9130-som-v1-0-711127a409ae@solid-run.com>
 <20240321-cn9130-som-v1-2-711127a409ae@solid-run.com>
 <e24e78a6-852c-4458-987c-3601908a71f0@lunn.ch>
 <0d1afbcc-948e-4aff-8296-42f7166d318d@solid-run.com>
 <4fff2165-c3cc-41d8-b541-6e69ce4d98ac@lunn.ch>
 <748753a6-9fde-4d4f-8fee-5b93dbb532f0@solid-run.com>
 <a22e7861-c140-4f34-97be-a1f4e435b44b@lunn.ch>
In-Reply-To: <a22e7861-c140-4f34-97be-a1f4e435b44b@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB9002:EE_
x-ms-office365-filtering-correlation-id: cee79073-0d5d-4e0e-b5c1-08dc4a88ef61
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kwjTk0122ztxcIVC5yNmbYi62LONiNB8e1nh66zhElcREZQvBHZJ82GM5XvKucECdQxyMFOqrG83/VNnui4+DM/9y3e2Dyjcvi2eu4fewaOOLSdSFPgi2cx/9B0/VrFWFmQiCz1g+uSar3YvBDrYEYQ4qEz1TzKmsoH3a4DjaXOxn8s53D3HGjN8x22+ntLGKmdsKOjpBSmsQ9x6fo0js3RD0w+sZID78di/8wBlEDhEgisamdJhQH14UgFyPosLPtYDvZPFkFFtwAG/V08Ql6xR1vhymbwfcNMuej27RfTk5HldGakHL5h8KsxS/IV6njkuBYlQzj105xbwKfoW+iLQyWcErX9YhSq9nVOU1/3Khx4BFa9Y38AUsokCY3OKEgShKmryoECTocSFAGhl3dfTQgN6gBLhG8JrojBqVgx94MzyB7cQ9GytmJ97IOX8Jpa0lzVSmu1Ezxzf3rl7UPEZgLK18NDcTetVe7E+uw61ViO6gLEiZKslNKxiuD/M8wQ5KS34cNqZ0o7RnRmWH3G5GFQhiMOSPh3uYoK69zbQGunQCaKnwiKDZlmaIyr5BaTwjJCdUcsrT01ADpiWOIxxOqd8TpTimSeuEltLeptnX1v3US8TU6TbhQi3Zku5sGOaHSA03/hGZc3P9KrLC5K5ChqCBUhwSzzJrfBZd/qSMcJy290+mqAQsPhrhllOjkGLagHAddzHJcWSRbUGFg/62uvLJXzz/RsAczJFgzo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NU1NcGFlTjQ1ekNYUTY1M0tFcmpYcDVJZFR5Y25GSUMyQU9uMWkvWkFZYmhS?=
 =?utf-8?B?bWVDNmxhdk1rK2RMWFZhK3JpY2F0ZW54VDg4dDRiYU00b0tnaHU3OVR3MitE?=
 =?utf-8?B?bU5JVFFiQlg2UXo3d3lHVURsUEt1bVJQcTN3Yi9PM0llV1dkSFAzVjluQ29M?=
 =?utf-8?B?SmpEMjVLSDdhTDVWZU9tZkYybmthajRWTm5yN1RSdGJBUFNxV3pQLzJDcy9i?=
 =?utf-8?B?amt6WmJ4UlNIV2ZnNDNveEJwS1ZOWFB5NkhTMGhPR1RBSXR4V2UyVnIrR3NV?=
 =?utf-8?B?Tkdta3E3czhHZzV4OXJWTU9KNUNvMnBXWDUrTWdkandKNnNOQzkxcS8yYWRF?=
 =?utf-8?B?N1VNK2x4MTQySFpvNE5zeXZodnBCVTZqYkVXZEJyMm1pd1Q2aHVLRnNpL1g4?=
 =?utf-8?B?Lzg0WUIvcTVMYjhCWjcwYURoUVoraDBxYXF0NlhqMlNMNTVieUdpdUhCcGFN?=
 =?utf-8?B?cnVBcUFtdVNOcm41UzI5QlU2Sks3MDRxajJOZHFCV2U1NkZHcytkZDQveGh3?=
 =?utf-8?B?UE5ZQ25KSGUrNE8vYnpyVTYyWVBxMU5SZmtzc3JiTW9weTUxM05NVHUyS2ty?=
 =?utf-8?B?NHBoWFZIRjZxRUhIbWFDbktxZTVSbUZ6Y1lOV3RkV1dUMVBtS3paOXBaL3Fn?=
 =?utf-8?B?dVJ3U0hxU2czMnJLeExRbjNDaUJOUkRqNVhycUlyNGFRbW1vMkp6S1NjYVlo?=
 =?utf-8?B?VGxEVDhaM3lPeEdKRjN4dzlDSFV4Y24xSmtnejJDVDZHOXNDdnNHSVEreXlU?=
 =?utf-8?B?SEE5cFZVeE9JY2hjQ0svY2J3WVA3NFQxSkdUVWNHL25UMTA1WXVaMm4yVExB?=
 =?utf-8?B?S3ZvZWhheFZ4ekhPK1FpWGRJS1NXenBvamFTZlpDbkNJNmc2d1p6ZkU2d0Q4?=
 =?utf-8?B?dDRnR3dzOFhjSEo0VEZaWTJBUng2V0M0QjZGUFF3dmxLSnF2V3F1L3cwZEtT?=
 =?utf-8?B?KytURnpDNll1KzVrUFBxbjFDZGlqeStkaktlck5NeHBNQlZHSlE3ejYvNFJa?=
 =?utf-8?B?aEczOUJrbElYbmhpZk12dVVYSE0rRnlUMG5VWWxvL0lPWUdraWFYWVJ5YlVC?=
 =?utf-8?B?eXhXY0UwdzBUQXVWaHNwb2c1dGVKWUtJc2szc3dsY2FmMCs5Wkt2STIzOFFt?=
 =?utf-8?B?U25iWmkyby9WKzVqaTBETElXeEhyeG41cTRtakszVW92Tmljc0xmRmw0QUlC?=
 =?utf-8?B?ZTczdTlPZmhFMk1DTFhZR0tzRkhtT1lZeTVhMjFHRXNqWm9LaTdRZ3JmeENE?=
 =?utf-8?B?VTh0Z2NLR2pEdkY4QWpOYjVLUTZvTWdWN0E2eUlVNWsvTklueCtQVWpOZlU3?=
 =?utf-8?B?bmsxR1NtdW5QVTR1Szk0WEQzWFBYbFR2cElmdlV6MDdmOExCSzRYQW82T1J2?=
 =?utf-8?B?elpMOEs5SVhMSUtNRE5Sa1ZjRGw1WWVndXcvWTJEV2d1RnF4YkQzZkRLWVFE?=
 =?utf-8?B?SXBqNlA4UThkTHpGL1lac1JsbU9ZVHZvSHJKTmlIMnBQanBNNXNqVldteGdO?=
 =?utf-8?B?RnN2SmJGRjcrWHkvbGxCTHQ5OXZkMUpXdDdyMkZkZ2ZScldFRkhyYmdWYnpX?=
 =?utf-8?B?NUxRdHVUbnR2NGdjbTV3bkxwWktZc2VqWmE5YjBqZjZzZVYzcUo0M2UwZDZo?=
 =?utf-8?B?elJnUTN5akw3Zjd1WWFxajdlNjFsTVlmR0FkaFh3bFg3aU9LdHZRUTEwcGMv?=
 =?utf-8?B?cHFzVytwYjZHeTRFa2swaWdDZGRpZFhQWU1UVURyVEIweWh1UlNkTDBtSzA5?=
 =?utf-8?B?NEUxbzBmYmxYeEtSM1VaYzU1UU9MdjNlcFh3NCsvYlZtMUYzL29ocGxVbHg4?=
 =?utf-8?B?cktLUm9CZ21GT3lwTDB3eDIwSWxoOTJwY1JSNHFkTXVrVDM2YkI0d2lSc3VX?=
 =?utf-8?B?ejBWb3FEbUVDSFNKdFhocW94WEZSNFZnckF1SHRtWmtqUnR1UzBmcVgwUUps?=
 =?utf-8?B?aUo4MWd5VWJqWUpkZjh5QUtleVZwRFg3R1NxRFBrWDQzMStjQ1JDd21sbjJR?=
 =?utf-8?B?VXgxVzVaK1JYSkFKMkd3cHVQVktkTTQwenN6Q3Z6NkVwNXU3aHhFMHdFUnMr?=
 =?utf-8?B?UVducHpwaEEvMlB1MitldmxobzcwZnd4LytQd1VjTlZuWmx1TDcvM09zUVVi?=
 =?utf-8?Q?J67o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E3D4D403AF420459C9F3DDE6DDFFFDC@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cee79073-0d5d-4e0e-b5c1-08dc4a88ef61
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 15:58:37.1507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74CrvA7s8uRmg02ztW/LlCSrcquj6G75Fj34FJnbayWnX7MdjTMuKhLrDr2NsWBvrjVYqz5c99+EHz+2HnkqfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9002

QW0gMjIuMDMuMjQgdW0gMTY6NDkgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+IEkgKGN1cnJlbnRs
eSkgY2FuJ3QgcHV0IGluIHRoZSBsZWQgbm9kZSBlLmcuDQo+PiBsaW51eCxkZWZhdWx0LXRyaWdn
ZXIgPSAibGluazEwMHxsaW5rMTAwMHx0eHxyeCI7DQo+PiBSaWdodD8NCj4gTm8uIFRoZSB0cmln
Z2VyIHdpbGwgYmUgJ25ldGRldicuIE9yICdoZWFydGJlYXQnLCBvcg0KPiAna2JkLW51bWxvY2sn
Lg0KT0suDQo+IFRoZXkgYXJlIGp1c3QgTEVEcywgdGhleSBjYW4gYmUgdXNlZCBmb3INCj4gYW55
dGhpbmcuIFdoaWxlIHRlc3Rpbmcgc29tZSBvZiB0aGlzIGNvZGUgaSBoYWQgdGhlIGtleWJvYXJk
IG51bWxvY2sNCj4gaW5kaWNhdGluZyBuZXR3b3JrIHBhY2tldHMsIHNpbmNlIGl0IGVhc2llciB0
byBzZWUgdGhhbiB0aGUgUko0NQ0KPiBzb2NrZXQuLi4gVGhlIHNhbWUgYXBwbGllcyB0aGUgb3Ro
ZXIgd2F5LiBUaGUgUko0NSBMRURzIGFyZSBqdXN0IExpbnV4DQo+IExFRHMsIHRoZXkgY2FuIGJl
IHVzZWQgZm9yIGFueXRoaW5nLi4uDQo+DQo+IEkgZG8gaGF2ZSBzb21lIGNvZGUgYWRkaW5nIGFk
ZGl0aW9uYWwgcHJvcGVydGllcyBmb3IgdGhlIGJsaW5rDQo+IHJlYXNvbi4gSG93ZXZlciwgaXQg
aXMgdmVyeSBkZWJhdGFibGUgaWYgaXQgYmVsb25ncyBpbiBEVC4gRFQNCj4gZGVzY3JpYmVzIGhh
cmR3YXJlLCBub3QgY29uZmlndXJhdGlvbiBvZiBoYXJkd2FyZS4NCj4NCj4gRG8geW91IGFjdHVh
bGx5IGhhdmUgbGFiZWxzIG9uIHRoZSBjYXNlIGluZGljYXRpbmcgd2hhdCB0aGUgTEVEcyBtZWFu
Pw0KPiBJdCBjb3VsZCBiZSB3ZSBkZXNjcmliZSB0aGUgbGFiZWwsIHdoaWNoIGlzIGhhcmR3YXJl
LCBub3QgdGhlDQo+IGNvbmZpZ3VyYXRpb24gb2YgdGhlIExFRCwgd2hpY2ggaXMgcG9saWN5IGZy
b20gdXNlciBzcGFjZS4NCg0KSSBoYXZlIHNlZW4gaXQgb24gY3VzdG9tZXIgcHJvZHVjdHMsIGFu
ZCBJIGhhdmUgc2VlbiBpdCBpbiBtYW51YWxzLA0KYW5kIGl0IGNhbiBoZWxwIGluIGN1c3RvbWVy
IHN1cHBvcnQuDQpQZXJzb25hbGx5IEkgd291bGQgd2FudCBpdCBmb3IgY29uc2lzdGVuY3kgcmVh
c29ucywgc28gdGhhdCBldmVuIGlmDQpoYXJkd2FyZSBlbmdpbmVlcnMgY29uZnVzZWQgMCBhbmQg
MSBJIGNhbiBlbnN1cmUgY29uc2lzdGVudA0KYmVoYXZpb3VyIG91dCBvZiB0aGUgYm94Lg0KDQpJ
dCBjb3VsZCBiZSB0aGUgdmVuZG9yIHJlY29tbWVuZGVkIG9yIGludGVuZGVkIGNvbmZpZ3VyYXRp
b24gLi4uDQoNCg==

