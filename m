Return-Path: <linux-kernel+bounces-81551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B675867768
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 14:59:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12FEE1F2B89A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302AC129A64;
	Mon, 26 Feb 2024 13:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b="F5Oqj3wc"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2096.outbound.protection.outlook.com [40.107.105.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845B81BC43;
	Mon, 26 Feb 2024 13:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708955956; cv=fail; b=IaCOhfh1pnDklT5Is44cRiOz8z/4Lbi2Pv7217msooyooyHrrXita+D9fWmyUqTU7AUl++iCLykSGQkemlnRCSfJrQIP25GFDNUdaWR5+PtBT/oe+F+w6VG4xR7d5rrSout6MakVvrSJ6c37osIcjm5KB1k65n0Tbu0vEmajB2Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708955956; c=relaxed/simple;
	bh=dmd9q+UDTwJMizilFmUfaBJUIS7io+YoFr/oRuz3BQQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D5PQG6gerWtvBUWqapZfmjpV4NrXfYNtVI512A6AkQ8Kx3fwjIq0W30nYtazs/JU5TcpFZ3DbXZAgDvNPb9hmawFoDR+D4iWMh1OB/IUuswZJ4x/XuDRU6yvY6lSjOO+F7s7ExLgpd0PLyxIkRJnfvBmCOI7C/GOzhlKZcsEUac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk; spf=pass smtp.mailfrom=bang-olufsen.dk; dkim=pass (1024-bit key) header.d=bang-olufsen.dk header.i=@bang-olufsen.dk header.b=F5Oqj3wc; arc=fail smtp.client-ip=40.107.105.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bang-olufsen.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bang-olufsen.dk
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvhnCrBihgzT3XBiMHZSEZpmvjnv2f7fvfSIHqy2/OnXPXFy5C7LW9a+bNSwBvNeZFKGKDv1s38TFZeS86mC/DyUSDECyYt7kTmzhTLMrxzYAMj+yZ7pihSYkZhgcT0HiAwKV29q9Qk6om5fuUCIOvjaJNBBEN4vh0+/zOq3PIGmIxB3Zk2AwHBUeJ1OQv0czdhX6Gx0qzsFdQtVZNR2WoZgrISSWLpmDRpwjCpc5N3+PMlEVeRLR4rfNqBGPkKFIeJc2WYZaVgF0Nl8kp8QwnjGQ+EzhAwLtnPrHAhExGRP+Pg5DnAt0NGvZicpj4Zk2Bv3SyzDmLkyqEI7tbZNZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dmd9q+UDTwJMizilFmUfaBJUIS7io+YoFr/oRuz3BQQ=;
 b=FrxeAoUNd6nMgHFzIHXWXsgMw85oqELpT5QWgMn3U0znLdl8Tci/1SV5QW4YMnkiAzEDmBM9TG+nWKpVaFz98hbMKBQx1qz57kHsPf/tF08WzuZwTqog7wWSW+WcLn1Q/g7a6fkPA+BpcOiT1lGv8fsU51djFat/tjY7M7aJgb0yKGVTgfqmjMODgDc2jTLqQKpjp19nD4ighBZ9SCx96QKxReCweDLICP+IcgfSyb0jsWdcLqvJXLFhBEWtO2fXgU/6/3qac3GQI2N5DiEvPmhYUbxetSOUk9Zc5YUMJDgO6OWnA2uufxmk07vPF0rpban8VlC58yeQIBsJ+4gS5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bang-olufsen.dk; dmarc=pass action=none
 header.from=bang-olufsen.dk; dkim=pass header.d=bang-olufsen.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bang-olufsen.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dmd9q+UDTwJMizilFmUfaBJUIS7io+YoFr/oRuz3BQQ=;
 b=F5Oqj3wco9te/vvFluX4xJ2NyeXmjyVcJEp6WJKwllFVhwR5tqmwzieWbP7WFw+ZjToyqt2Q/aURskoKCLw306SqTCTXG7jZMSxL3bRXHVg0SohGj9AE5urh5VIUioAp3JiZZRcp7z3lAjPGCl2UCPNF2iQiepF4R7103VL0UhE=
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com (2603:10a6:20b:53e::20)
 by GV2PR03MB8607.eurprd03.prod.outlook.com (2603:10a6:150:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Mon, 26 Feb
 2024 13:59:08 +0000
Received: from AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7]) by AS8PR03MB8805.eurprd03.prod.outlook.com
 ([fe80::3c77:8de8:801c:42a7%4]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 13:59:07 +0000
From: =?utf-8?B?QWx2aW4gxaBpcHJhZ2E=?= <ALSI@bang-olufsen.dk>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 3/3] net: dsa: realtek: support reset
 controller
Thread-Topic: [PATCH net-next v5 3/3] net: dsa: realtek: support reset
 controller
Thread-Index: AQHaaAftZqs283kxW0ycKDf9fQrk8LEcp92A
Date: Mon, 26 Feb 2024 13:59:07 +0000
Message-ID: <lhmma7bsa4xirx2hykrqhwuflucnv537caaebifxkcbkhyzyqb@ms6dwg5yxk7p>
References: <20240225-realtek-reset-v5-0-5a4dc0879dfb@gmail.com>
 <20240225-realtek-reset-v5-3-5a4dc0879dfb@gmail.com>
In-Reply-To: <20240225-realtek-reset-v5-3-5a4dc0879dfb@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bang-olufsen.dk;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR03MB8805:EE_|GV2PR03MB8607:EE_
x-ms-office365-filtering-correlation-id: 53ba373f-d0bb-4a57-e87c-08dc36d319d9
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 3EuoYX8A/bRo6Ait/FwUYd73HDmerB8i1L1FReJaXEmWHX0h/mOglcrT5OFMH0cnI+Cn16ZTujQ6AvsYdmIglGmnWJGvRGpjx/F9UowDrYZYzYFJathKFBAbHNVRMX18y28eX2c0NWzjoYCScUvbhhe5ZXfMXNg4a7zU2L2hh6l5LPIre+GjzeQBhtpnnQ5Uxo1p5hNmdsUH27veI2WPO4JUi2N9gyc33JKafs93DwrG+SXs0OUXb58TnXgfuRkXMwTQLQaA7ptkmBsF7qw3Lt41Khz3NvyUVfK9dQxc9svVeX/46Hjj6z5t93Uf/XnavLJ8/wG9Kig5JVEJPPcMDYE2V8v08/J5ttttR1dtcsVEXJBV2UBbuTjQgybTCz3m8v47OLOqy/9NmdhfDpaq7lCM9BDdAs5sK5d5p7oZF2/lCysfL9AsZT1lTWwVhJwZ5p+bPTK6TxOTPe7/i6G40pQsicfutiN5sPzJehPYnTdUjqLn90WxNRXHydRMD4Wu2f8ZhE8fdARSBPn09udWVY1hvWJGFAI6Nog5fsATa8e1j4UkMSii1TJ7ydfZGy9uEM9+CRmslEhrWC471bISXNkcTfNcG78EbbqJtjAtSMIgiB71abUcPQIWPRS6kvMZmnIsq7o/GDt0xZs7al/XfhrMxmlCqfg3wrtYviWlsD7Qs8VsjOsRC5jpNv76Q1hr9d89dTcyNVXEv9/uTHnLgA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR03MB8805.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R09ZVG1LUFlLUnVWY3JxdTFkMTh5U0Z2eEx3UlFlUEdBU05pWWp0alhMWjFw?=
 =?utf-8?B?VjhLUkQ3R0NzVkNFSjRaRXhxMUQvSUVNTE51SkRWYWN3VldyQmlHQWZJb0k4?=
 =?utf-8?B?Umh0ckZCTmJhVVZMTGl6ZnRXemQ3WjhvQjdidXg0d1NrVXhCTTJBd2VUcnJF?=
 =?utf-8?B?RW9zV2xiRyt3QlpyaHlWZTlaejV6QTJXWmZJMHRnUTdzRXNEazI1eGVtR3RH?=
 =?utf-8?B?UGlNelpsdUhiVjVCaEtrem94d2xycGROVnc0bnpXM2dGOEZqSmpUSXlLT01X?=
 =?utf-8?B?dHJubUhwTkg4TFAxNEpOQkJ0cllHSTR5dVlQZ0pmenViemFEc2pURzM5VjNq?=
 =?utf-8?B?VmQvYmlDZlYzZEhrdmh0c1dBSElCcFBMV21CeGtraHRrQkNFTWVjakF5TytZ?=
 =?utf-8?B?cEF0b3JPZ3dTTWtISW5ya1IrUzVwY2hhR1FOWEpoTnR6ajMrdllxRUdwUGZK?=
 =?utf-8?B?OG1qTzhTY0MrbWYwOG4wRDVuNnljeFROVkMycFNCY3JGR2t0enJEZW1JcGh2?=
 =?utf-8?B?a0NRRTUvRDhBNThEZ2ovR1ROc2o3aVcrMFRKVG9uenZiS1FERzNORytBOE5M?=
 =?utf-8?B?WUJjSVkzbzBnam50QUJka0dhcTlDRlR6MDNOOEpvRU8zN2xMdjF5b09zTHNU?=
 =?utf-8?B?dDB4RTF4RXRHVmF2RlE2aGdaeTdPdWxCNHcwZ1piaVlIRFJ2MW5XMGx4TGc2?=
 =?utf-8?B?bElBTWFTUWhBL2lwVFBkS3VUa0Iwa09ZY3pnbEs2SUplM1FpNWtQWWIxTG1a?=
 =?utf-8?B?SEo5cjdjS2k1Vm1hVStzbVpHWGl0U1JuNDRhNGpqSUJNcWxiSlhSWTVSR01w?=
 =?utf-8?B?OEo5SWxHRVFGMHBmTDZWZkZwUkNkd1JhNmlER2V6YVJZMDA1WTBNRXVlaG9w?=
 =?utf-8?B?SklxYk1URzgyU0grWEJLdzQ2WEt0R205OVZXSTVKeWxOT0JUSXlKY1YyUDY4?=
 =?utf-8?B?N1Z2SnpHbDYySE9ZTmFDWDh3c2Z6dWNGSUt5cTZ0ek9vemZEd1prZ0tuUjlr?=
 =?utf-8?B?NHFuYzBiMllRU1FPTE05d21veklpUDVkV0Zxc1JFcVZwdWJ0S3prNk9SUjgw?=
 =?utf-8?B?Y28yWW00VW1vUnJtbzMwY2QyQUovc0luUkJubzNsRmN0UEhyN3VDbGtEQ0Yy?=
 =?utf-8?B?anJUaXVGeXBZcmtFNktmNmFyS3hHUzQyTGJiaWNxUkEwcmFTc29TYys3ZENG?=
 =?utf-8?B?b0RwNzV1dE4vYlVYQjhDV2liOEdJQ2E5amRwRUxXVTZkekE0RTg5VEZqQnoy?=
 =?utf-8?B?d01jNjFybWVmTDJkUCtHSUtrRjZreUo4U2g5a2k1ZEFBVnMwM3RnOWVuVS9Q?=
 =?utf-8?B?WDJUODRaOE1CS1dXTkQwOXFoT2NheWFRaWo2dWJDU05mOHJ3VWJ2cXVFQmM4?=
 =?utf-8?B?bGE5OVI5QklMMHVjY0VIVWs2UlZML21IekxwZ0drNEJTQWFWZUZGYnVLNjlY?=
 =?utf-8?B?OFBjaGxwZ1RzaU5UWlEvZmZYK1NkdWFiUVhrWnlBVkJLYmpOdEFWR3d5SFVu?=
 =?utf-8?B?dDlDMU4vQU4yUmhxR1F0U1pxNGl6WjlYTkV1UEg1OGtHTmpjVWQ1Mi8zNFM2?=
 =?utf-8?B?MjJnTW0vVWZLazJVME1nT3JvbXdQSHdxdHFod09pVzNST3lkTlFVZGpVb1Fl?=
 =?utf-8?B?aWtHL2RpendvMVQyNjh5UCtPNDl6L0E0a1laMnNIa0wxd01ac0dMZ0F6YjdZ?=
 =?utf-8?B?Y1Mza1FQQ2NyVTlnamE4UkpYaHpnQ2I4b2hoeU9xQjVZTFlieEZiaFZKU2xz?=
 =?utf-8?B?V1Z6Ry9ScElLVFlkbURCTnhhMU9tNFlaRWRnMWR0b043Vm5TMjk4OTJtbUFo?=
 =?utf-8?B?Rjd3UUtiSVgyeGZreklsQkxDVFpkS2pDUkxRNDYxWitPNDgvM2ZUZmtRZDEy?=
 =?utf-8?B?OTg0VzI2VGxyWGVVeWhqdFhXKzBOQVIzTXl4N0ttRmFFWWo1VnFRdzI5VnJ5?=
 =?utf-8?B?eWlObkVNY09KaW5NREx6eDJVWnMzK1duR0dKQmF1M3NoejBnZXpHMXBBOWVF?=
 =?utf-8?B?eldkVUZqTlJLUC9CeW4zNGQ2aGFpcjY1NUVob2xWZ2owajEreXBnUVdmdlhS?=
 =?utf-8?B?UTFMREJiY3M4ZTJ5K2Z0Yk5CbnBxcGo1MzhKczRDdEVlY3RoaExUUm1leFVq?=
 =?utf-8?B?TDVFZzRrSE9pQjhCbUdtSjRHSzcyaHVrU0p6OGNtZWNhbEdxRjVJNnpQaGFv?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6386C53763201E43972F6E66049621EA@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bang-olufsen.dk
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR03MB8805.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53ba373f-d0bb-4a57-e87c-08dc36d319d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Feb 2024 13:59:07.8856
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 210d08b8-83f7-470a-bc96-381193ca14a1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jb5bb5akYBFjehS3hSJtbkoObFuZdzdQBUSEDYLda4qoOIrPzqemHHcqxKOtd0R1WlbGMxb1BZgO5DJKf9mkbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR03MB8607

T24gU3VuLCBGZWIgMjUsIDIwMjQgYXQgMDE6Mjk6NTVQTSAtMDMwMCwgTHVpeiBBbmdlbG8gRGFy
b3MgZGUgTHVjYSB3cm90ZToNCj4gQWRkIHN1cHBvcnQgZm9yIHJlc2V0dGluZyB0aGUgZGV2aWNl
IHVzaW5nIGEgcmVzZXQgY29udHJvbGxlciwNCj4gY29tcGxlbWVudGluZyB0aGUgZXhpc3Rpbmcg
R1BJTyByZXNldCBmdW5jdGlvbmFsaXR5IChyZXNldC1ncGlvcykuDQo+IA0KPiBBbHRob3VnaCB0
aGUgcmVzZXQgaXMgb3B0aW9uYWwgYW5kIHRoZSBkcml2ZXIgcGVyZm9ybXMgYSBzb2Z0IHJlc2V0
DQo+IGR1cmluZyBzZXR1cCwgaWYgdGhlIGluaXRpYWwgcmVzZXQgcGluIHN0YXRlIHdhcyBhc3Nl
cnRlZCwgdGhlIGRyaXZlcg0KPiB3aWxsIG5vdCBkZXRlY3QgdGhlIGRldmljZSB1bnRpbCB0aGUg
cmVzZXQgaXMgZGVhc3NlcnRlZC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1aXogQW5nZWxvIERh
cm9zIGRlIEx1Y2EgPGx1aXpsdWNhQGdtYWlsLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IExpbnVzIFdh
bGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBB
bHZpbiDFoGlwcmFnYSA8YWxzaUBiYW5nLW9sdWZzZW4uZGs+DQoNCj4gIGRyaXZlcnMvbmV0L2Rz
YS9yZWFsdGVrL3JlYWx0ZWsuaCB8ICAyICsrDQo+ICBkcml2ZXJzL25ldC9kc2EvcmVhbHRlay9y
dGw4M3h4LmMgfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0NCj4g
IGRyaXZlcnMvbmV0L2RzYS9yZWFsdGVrL3J0bDgzeHguaCB8ICAyICsrDQo+ICAzIGZpbGVzIGNo
YW5nZWQsIDQxIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0p

