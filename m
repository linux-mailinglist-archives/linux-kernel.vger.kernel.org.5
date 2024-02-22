Return-Path: <linux-kernel+bounces-76151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 332BD85F385
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC98C284B59
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40032C6B3;
	Thu, 22 Feb 2024 08:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="DeiHaP/6"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2049.outbound.protection.outlook.com [40.107.21.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6CA2BD01
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708592026; cv=fail; b=grNariWMRDIWzb0W8Yr8Brv/lxAAV1BPsXsUJ+I7Gez23bo2KA//nncfOz88RW7qM0DCwFa1j48cDMNxB4vTtuekHOx2zE2Iiawfbu2kMhkbQYsvjnN7D1pgc2KTyouKxipd+AcSonnE8aB8w8ALqeBfhgskVcOOJwjYUfcoJ8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708592026; c=relaxed/simple;
	bh=9fvTS858dJKLd0yPVuRHHKXUwNQs+g1GL0O+4KVFeVI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lxGDaDJaFoh9KGtOAdH7p0QGu+XY41yJZdZevLxbBUVHKjBK5UrnM3M11c2qlod4mLJpPYjrfBiYTmxXS4DuCrLKKe2MW+NJhKiu6n5hZjN3J9eE29Na0sPQpP2oNIkNe9LphrtELPyuG3IxhuORr9P1tTjsgKnDYGVmZ9wG8dY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=DeiHaP/6; arc=fail smtp.client-ip=40.107.21.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xc4PnrYzYL5BJ4kaJlmtnhBt4AAbwqEGsXkgr+Egzd94WD9VQbDd7GwtHkZqdg5k3f8wW10MtEhTjjy51N40ZI4MSQVin1vlfvflPNpMsUw7D1pJlMG7/Y3NeeImyc0pdanKPIRjkeOcK2TJGr4L1XaKKGyCoanhrwWkT0R7LdwRYBeldw5aDyh7mvdliGkNZe7ZYQjdpvuadKwKlHhrvLPd7iPA142m5SeKVZnfqNWjh6gqlUjc93P75yWrRh0lkPibrl3k5pT3CM1fDeBdSedAQEs4+LWk8Cc8A0L5Q4mChoHaHRSoU8MioJCl0HCMdfACuBC12tvWuYOMLlnSsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fvTS858dJKLd0yPVuRHHKXUwNQs+g1GL0O+4KVFeVI=;
 b=O4JJizmiiFEK486YUCZZ/Cnqd3m9LajTzm8o3UDIDiwl/1RGNnwk9KURHzeTpkoHRYfpSdzh5t1MDigK5jbtQsV1Tx2UFKN2JEpqT1qsVydYcXabmjkIFdKy8nu1LiRz0iki2br0grc8ZBJXxaIEl6dkHajM89BsoEdZBxoc2RgRf4qHcneqGIMHPmWzUpYJkT2c3JXuqfFgafA4IITFstsolrVYz3x0kjgTQSEQRRIxvatuDtXdPhPoeBzT01IfYveDuI+/0QlCB43lQHHei+46jAXJl9NBbL1ui2YdWUBYzIBoZKqXwJULlXk9fp/BJS9KvxprTvZHUH/K6Kp69w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9fvTS858dJKLd0yPVuRHHKXUwNQs+g1GL0O+4KVFeVI=;
 b=DeiHaP/6ZGLDWpE/4EH10G6i4zTTvs5FgfGHEnIIJwvew0G08eiGmg6kpf3ml5gt30eCHkIcdtfd7IEO+iWU0Nz2fhUBxePINBzEnKCfqpema+zdRy9P2QLp3C8kDhOJqXEVz2Pf5gWU/Gr9bV9Z32iXwHkLS4Hc+a1iedbuyqM=
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com (2603:10a6:10:356::7)
 by AM8PR04MB8049.eurprd04.prod.outlook.com (2603:10a6:20b:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.38; Thu, 22 Feb
 2024 08:53:41 +0000
Received: from DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::57dc:31d2:381a:df71]) by DU0PR04MB9299.eurprd04.prod.outlook.com
 ([fe80::57dc:31d2:381a:df71%4]) with mapi id 15.20.7316.018; Thu, 22 Feb 2024
 08:53:41 +0000
From: Aisheng Dong <aisheng.dong@nxp.com>
To: "Daniel Baluta (OSS)" <daniel.baluta@oss.nxp.com>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>
CC: "kernel@pengutronix.de" <kernel@pengutronix.de>, "f.fainelli@gmail.com"
	<f.fainelli@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"abel.vesa@linaro.org" <abel.vesa@linaro.org>, Bough Chen
	<haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>, "S.J. Wang"
	<shengjiu.wang@nxp.com>, Frank Li <frank.li@nxp.com>, Laurentiu Palcu
	<laurentiu.palcu@nxp.com>, Mirela Rabulea <mirela.rabulea@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Daniel Baluta
	<daniel.baluta@nxp.com>
Subject: RE: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Topic: [PATCH] MAINTAINERS: Use a proper mailinglist for NXP i.MX
 development
Thread-Index: AQHaZBuN7sgjnl3k1U6f4Ut2LQlccbEWCjzA
Date: Thu, 22 Feb 2024 08:53:41 +0000
Message-ID:
 <DU0PR04MB929999670DBEBD38C031788280562@DU0PR04MB9299.eurprd04.prod.outlook.com>
References: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
In-Reply-To: <20240220164005.1345603-1-daniel.baluta@oss.nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9299:EE_|AM8PR04MB8049:EE_
x-ms-office365-filtering-correlation-id: dba8f5fc-d2e7-412e-7c8a-08dc3383c4cf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 SYDEMRrljQVBmBT6Ezbxi2UUbZmjbl4LCwzuqBU3PFB9PYONYeueN5Uo/u9TWJF566Xve8j3rD5cSdmKVuaH3fP7EO21FkcuzW+341kngnQGubIIY9/xhS0fMWH61yUl+oF99AxgOvcrRTxLMfkHrv9ak2hcrIIJS/VnMhc/iQlQTCiz70NAiT4WeE7FdIHtIuJYsGODEPDTXjxQkIAKMezXYbNMOZCirRldugcBri5J51utqwkzLJY1dYk3xr+VfOjZnfos+scoV7hzV6F8CawTDc3M1OPEDUMlexXsW56ldVbXKbCSyJwv+Pq1wj/Yz+CJs3+sau4zDD4VrYWy5TIy8Od20ZqFsqU+7A4VG2veLENVn/KJQcrbbj3EncnrJn3a8CzkDsC92DCXhc13wUSrqcxBwhFMJovJk2QM2t7mCJKGbiVzF4BOCuqJnOXH9BiBqkiCw1pFQZg3t7UuG2DipBmKOZiBqhx8LEVI+bihhKcmjS9uZCE7pishYRmUfO/jBAfx0RgIxKev5n59BjAP9ckuGo6Evw1/VAPGKt7mlRe9P3q421mqAa5qU9Gk8D30N+zDRjyOyGkPZ5zzaOO4+m9DLQ4GmdaBdAnJuZU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9299.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VEVNYWpvNjJPVmc4MHVkZEJ0bkZNaHhWLzhraDZrZWUyL2hNVElVeGtNenp2?=
 =?gb2312?B?dmZGL0VacS9mdW1CanpYT2FYL1pmRElZVC80NjlWanRqaVYxWDZ2TFFFc1Fo?=
 =?gb2312?B?Rkw5NEh3M0tZWDZNNlNCL3V1MlBwWk1uMkY1dHB1QnFBbWZlVGNmcVcrNnlB?=
 =?gb2312?B?dDBXM2hrTmtwa3BjbHJRK05iTTBWbC8vNHNicVI4UlhBbGZ2SXgwQ0E0YXAw?=
 =?gb2312?B?dXlwNldGOU9HNU94aU5NdFpEdlJDdnNrTmJQVTcxMi9yb0I0akZmU3M5Ukor?=
 =?gb2312?B?cUM2WjhoRlBkdVF0Z01IVFNVZExyR0lXTU1CbVh6a0FkR1NOYVFHUnRpdEU5?=
 =?gb2312?B?Z1BhVkFQTHgzeVMxTnRMUzhIT09rM1VJRHJoTGVDV3JwYW0vMlNZSDBSU2Mx?=
 =?gb2312?B?OFJTZkc2ZitxOHZ0SzVuWlk1NjZJMW1aRjhjUVAzMHE2QW0yc0NVZjFxNFpV?=
 =?gb2312?B?UDEzYzFOQ2FFVERmMDZLOXdvcTVCdUNpemRRd2QzY2lCaDRUdHNPSFYyQTFI?=
 =?gb2312?B?TmFKRkdGY0dDRnFwdm8xQTZCRjJMb014bVJlSGdGb2RsdFp1bHc5clBPM0Q3?=
 =?gb2312?B?MWNnZElxRmxQeVZDNGs5NXk2Z3ptY1AzclJTbTA1WEhoRDQ2NG8vaGQ3VFBW?=
 =?gb2312?B?Y2pjYURTV2EvUXU4cGtLckVVNVNCQUwxRi95dnpqQm02NzBDZmNMSE5xeWo2?=
 =?gb2312?B?eGdQU3hLNFZpSmVFT1hUdVY5bHlnSXpjNlJFd0tkTGYxWUpXL2pxMENYMjFO?=
 =?gb2312?B?bHdwekFMSFMzYktIbWtPMTdmTk1OLy9mNU1oeTFoc253anRvek1Oa1UveWlp?=
 =?gb2312?B?K01qKzlnR0JYNXJicWV3MFZ4SXUxYVo1SkpqTkpnQldHU3Q2b29OODQvd3BN?=
 =?gb2312?B?L2dqT0pReWJuQ2dyT0xGakkvbE5halV2Rm9vSkVjMjZOcDZqOHU3ZkVqK3Ru?=
 =?gb2312?B?UFhURUVzSkxrZFlTVFYrcmNLR2RNVEJpVEMwZmkwY0hKMG92d1hHUm9UaW0r?=
 =?gb2312?B?QnpKTGJjN3l2dHJ2ZTRxelI2aGZGTmRyZ1ZQUUZmVEVCY0M0Z1ZYNzQyYXJ3?=
 =?gb2312?B?dWVKYjFRL1FEbmhSMWljaXRuNmYwVHhCYmd5cmJNdTVUSzJCaUVibm5nb1VY?=
 =?gb2312?B?MHdkZ1IwQlk5Q2dQaStzWnhnMEI0cksyRTFYZUZyUHNNK3N5UG5LK1pVbitY?=
 =?gb2312?B?Y2RIMHl3dXRhNHBPL2Z6MXp2VkdqQWhrVnBGK0p0TVlpMEJxV1paeGw2WXVz?=
 =?gb2312?B?ZHlYWG1GTDJ2Q3dmTU5McFFOanQ3RlprUGFLNzQ3SHd6VzBBRnp3VnRrWHlu?=
 =?gb2312?B?aVYwcFRUWHNvOUh6NFdTSlRPYnZZYWhtUG5qem5MbmRsb2FQZnIrSUJzWE5i?=
 =?gb2312?B?NytvY3BDOXZwN2R4bnJaTm9UZzlGeDY4cFNVdUthVUV1aFlHN1BCU25FN21F?=
 =?gb2312?B?dFROYjVMNUtWTVBoQkxYS09OcDFESkg5cHR3em9xU2pwUHFLQTVVSTRIZFlz?=
 =?gb2312?B?U0VQM1IwRTBSck96dXh3UWVtVnNpZnhrc3pyajJXMVdGZ3VXblpJTUZwZU13?=
 =?gb2312?B?T2MwQmZrOVZibzdKYkZNbVBUZkNvdGVIejNSbjVudEU5NDdaU0tURjdIRnBi?=
 =?gb2312?B?OStNUGlTRVJUbnZwOEpzOGFPeG5VVDdNejVPeVFsYU9CQVp4ZldpSlpNamtW?=
 =?gb2312?B?Nk1vdjNOdEwzTHhDR0dvV3ZBd2VEM1pZZjlnazJnS2R3eS9md0hOWTJEcXR4?=
 =?gb2312?B?R2d5bXVUZmRRM21EQ3hkUFFQbHUrT2NWOC8zZTJDa2d2S0dkM0VxMmVweUpm?=
 =?gb2312?B?amYyY1EvWUFVeldSMnJPZW5DVjRYc2NscnMyQXM5KzVQT0NIY0J4bDZKejVO?=
 =?gb2312?B?cC92MnZRSlA1bWxhUUd4Mkl4ZVgzQ0haMEY1eTJ3OHV3VXJvbmExUEE4ZDZZ?=
 =?gb2312?B?N2JUeFZQVHZOYmQ2Wk11enltenBoQlVIVDl0VWx3aW1TcEE2YXNWeExIL00z?=
 =?gb2312?B?U0tLL0RObUpLMmRMSi9iWVRUcnc2NUd3b1JGRHN2dnRwcGo4Y1VyR0ZFVHJi?=
 =?gb2312?B?WWpzR1RZK1lnZUN3VkpGNm1wb1F6N2JaamNGcGQzQVRpSWFvNVlMZ1JKenQv?=
 =?gb2312?Q?ZXtsL5aSB2oXg+JKBlMWqzl2/?=
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
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9299.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dba8f5fc-d2e7-412e-7c8a-08dc3383c4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 08:53:41.5293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+LkQchwq1iT06RHKNMGcu9PF7o2dJ3dmIzBEBzKI9WEJQf29mjBDelb7jTUAPL+38/wIW7ulHgUa5T8kGPV5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB8049

PiBGcm9tOiBEYW5pZWwgQmFsdXRhIChPU1MpIDxkYW5pZWwuYmFsdXRhQG9zcy5ueHAuY29tPg0K
PiBTZW50OiAyMDI0xOoy1MIyMcjVIDA6NDANCj4gDQo+IFNvIGZhciB3ZSB1c2VkIGFuIGludGVy
bmFsIGxpbnV4LWlteEBueHAuY29tIGVtYWlsIGFkZHJlc3MgdG8gZ2F0aGVyIGFsbA0KPiBwYXRj
aGVzIHJlbGF0ZWQgdG8gTlhQIGkuTVggZGV2ZWxvcG1lbnQuDQo+IA0KPiBMZXQncyBzd2l0Y2gg
dG8gYW4gb3BlbiBtYWlsaW5nIGxpc3QgdGhhdCBwcm92aWRlcyBhYmlsaXR5IGZvciBwZW9wbGUg
ZnJvbSB0aGUNCj4gY29tbXVuaXR5IHRvIHN1YnNjcmliZSBhbmQgYWxzbyBoYXZlIGEgcHJvcGVy
IGFyY2hpdmUuDQo+IA0KPiBMaXN0IGludGVyZmFjZSBhdDogaHR0cHM6Ly9saXN0cy5saW51eC5k
ZXYuDQo+IEFyY2hpdmUgaXMgYXQ6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2lteC8NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IERhbmllbCBCYWx1dGEgPGRhbmllbC5iYWx1dGFAbnhwLmNvbT4NCj4g
LS0tDQo+IA0KPiBTaGF3biwgY2FuIHlvdSBwbGVhc2UgcGljayB0aGlzIHVwIHZpYSB5b3VyIHRy
ZWU/DQo+IA0KPiAgTUFJTlRBSU5FUlMgfCAxNiArKysrKysrKy0tLS0tLS0tDQo+ICAxIGZpbGUg
Y2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCA4IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4gaW5kZXggOGQxMDUyZmE2YTY5Li4zZGIz
ODJkYzhmN2IgMTAwNjQ0DQo+IC0tLSBhL01BSU5UQUlORVJTDQo+ICsrKyBiL01BSU5UQUlORVJT
DQo+IEBAIC0yMTU2LDcgKzIxNTYsNyBAQCBNOglTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5v
cmc+DQo+ICBNOglTYXNjaGEgSGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+DQo+ICBSOglQ
ZW5ndXRyb25peCBLZXJuZWwgVGVhbSA8a2VybmVsQHBlbmd1dHJvbml4LmRlPg0KPiAgUjoJRmFi
aW8gRXN0ZXZhbSA8ZmVzdGV2YW1AZ21haWwuY29tPg0KPiAtUjoJTlhQIExpbnV4IFRlYW0gPGxp
bnV4LWlteEBueHAuY29tPg0KPiArUjoJTlhQIExpbnV4IFRlYW0gPGlteEBsaXN0cy5saW51eC5k
ZXY+DQoNCkRvIHdlIHJlYWxseSBuZWVkIGtlZXAgIk5YUCBMaW51eCBUZWFtIiBhcyB0aGlzIGlz
IGFjdHVhbGx5IGFuIG9wZW4gbGlzdD8NCk90aGVyd2lzZSwgaXQgbG9va3MgZ29vZCB0byBtZS4N
Cg0KUmVnYXJkcw0KQWlzaGVuZw0K

