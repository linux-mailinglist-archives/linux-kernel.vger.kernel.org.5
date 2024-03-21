Return-Path: <linux-kernel+bounces-109891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA1488576A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 789881F22831
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 10:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DB856B73;
	Thu, 21 Mar 2024 10:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="jzCXFtpe"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2107.outbound.protection.outlook.com [40.107.21.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36F56473;
	Thu, 21 Mar 2024 10:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711016820; cv=fail; b=nZ0baUCHMs2vnt2DBTcUT/l9DBgiiz768Tu43jtzm56HSaLiqka6GhLjYX0e0x/6B61MujHOI8VOYopFxZljyqFuVBvA1vd4k0D8pGYUQ/157fLifwxQ/GG9cIXk/ba+DIIyc50ZVn2mQlySp8NBmRK1Vrm8+TbUkU/nZOqNX2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711016820; c=relaxed/simple;
	bh=MUuQeK41NzmzhXGxzzvB2WTa5OCUatHUZam5levFq1M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iLP8z/IAGqwAFupOyG2mQxI6wStAFYajsJPSWSjefBTQ9B8/FYa0+kddUnD1f57p3w6+MgrkYb5/F2Plr8UDWnuhpbDs+Kh3nT+QhcUwtf3AMUXyepkSttoaMv816iG500mZg3HfAezDZK0InaqYicgPyHTJa+sxx1SISfnSfkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=jzCXFtpe; arc=fail smtp.client-ip=40.107.21.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbpJWZRAfyH4x8G2TquoYih725Y2xmKsePfpH3A0kAVxuGEcfpCHgMVzol6hptHZXayN+Rvj+NRnGN/AYCwxDON5RBVBCjCEIWMFRLSJJB+wDFvAKZqNwmi+ogu+lXE4ctqswIDjpHRP2+6QiZQiT8M++wIQ2m6FAoL1+IqqdpZypj24pqwGnvSG4gbBIRm23bl08ryMlGV7k55J+5hf8POBlujdFRsDGHkTEDBIMaYbghEf9Bm/szNj3MYuZ4boaWKUH4xK1Nj7uUCFf6IjkdBQMrsDD3oyIplU4/tzeDzUooqN542NVuycihtqXfiAc5xYIb3Y4dc/0JXun2U56w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MUuQeK41NzmzhXGxzzvB2WTa5OCUatHUZam5levFq1M=;
 b=NccHV/oGWLVebqwgGMbW2ILJEZj3Z+hZtGjJGYX0bhvYnmbmbsKaOTwaTXyjGI0jHh+XG5KNs07HMBDofxWNGp7AP4DNeg2sg/nN2sW5+kIbZ6o2HDTY8ECke/NURGxTbvX8tnIrshGFy+4PdOhfl/SGbG0CQZQjHMRNsbBLtsRVvpGZoGMwakxcoUina1E4rPLA/63rplZdOd5WAsLfeN2Z94l4Fqw34PTWSvsafq7VKtXMEUOD0ZN/orpmM4pITxBXnZALCY+t3lOOUScujrrHVkRl/uujG0au8+fF1gdL17wqNd1zfKgHYHE79UJmCBbUvDfAxjc2vFh0GTDUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MUuQeK41NzmzhXGxzzvB2WTa5OCUatHUZam5levFq1M=;
 b=jzCXFtpeDShJ6TuUtB8rV1drptUw16nCQD5XXD8mfKVp6TL9ExqcC3vWLTquyp1bYuvOUMj5+b8yrBoW2VIaI58JPaLzjhEaLdS1DzgLxkdYe3tK3VUvDelCPC7ujtbEfdXF+67EMdALyoDqV600ILyoivkHR+naD2wiJryl0zY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by VI1PR04MB9810.eurprd04.prod.outlook.com (2603:10a6:800:1df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Thu, 21 Mar
 2024 10:26:55 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::57e1:e1cb:74e2:2e9d%5]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 10:26:54 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Jiri Pirko <jiri@resnulli.us>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Topic: [PATCH] net: dsa: mv88e6xxx: add warning for truncated mdio bus
 id
Thread-Index: AQHaes1eqLrk3YtcdE6GnHKqfgAD+rFAqraAgAAHmgCAAEjgAIABA8sA
Date: Thu, 21 Mar 2024 10:26:54 +0000
Message-ID: <78211827-7ffb-41ac-bd78-a2641bca7c00@solid-run.com>
References:
 <20240320-mv88e6xxx-truncate-busid-v1-1-cface50b2efb@solid-run.com>
 <Zfrt_dlYvBzlxull@nanopsycho>
 <c76c95af-71cb-4eb6-b3af-846ae318d18d@solid-run.com>
 <793649ff-990c-46f0-9132-bc6e95fcb94f@lunn.ch>
In-Reply-To: <793649ff-990c-46f0-9132-bc6e95fcb94f@lunn.ch>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|VI1PR04MB9810:EE_
x-ms-office365-filtering-correlation-id: edfd6892-23f9-4783-9f2c-08dc49916e27
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Ai4BrMFA62/8MdZADMr67ZRH0XguUhismAfHe3i56LWjK437CT/OFtklmX+4JU8WqTOMqKuIyqdCWNTtUEU2de1I3afQSemOwFYxjpUET5i0DJjDJS+gXHgpvbn+rtDLXKglK8QtqByknEg4C4cQqa7xqTELMBc+5ZdT8kJSJ6LspwUaDw00h+/pSGb2Zn1EldY311uFHm54w8F9ldPpXlguYI7RrJY3JagtwUjHzwhfiSpQcJS1W0Xs/qHD64T0opvj31ghqtNZuWxI9HS3o6d9N9PBCrlpBVRwfiZjZD96YDtHK+TmhqljAsuGyXchqPXwlqORLh+L9SZE76TEGb274aHEoujbwEWnxxkwNQpdmm4E2MhVFyTd7ulCS9QWHtiONKucUvQIXKELW3gPkDOzBFNegvNO/hYnFjxpBDmehBJPivI8Ge1IlHCu93z4CHNeamf2qQ0ncMCNb8Pw7Io2Jtu4TFyEwboJ4euDHxt4/9FVTLpY6qT8v5+u5lsfu/By8ycEyhNTlyIS+hD3yZgo5NNjiJBRnl5jSmIV+cDVCUzwWIuUDp75HI2e+TFVh7JntGZJVHkl3g/lErbFRFUQcoK2MnzVOD/UPoV15HQiG7mg5uL9a8FoyN+WQirfIKoR/RzOnFkd+zoL/MX8RRGVf5VOppFSbH0Pau7czHtvRjfE7LE4Ck7Ce8mkPUSWl8cNT6GnDMwCWasFbf1kP2VWjom7/WVtK5zCjbgxtBo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?clpsVjBDYWtBT2g0elVINFRJWUJNSlB3NWxjTXF6aWQ3dnJmeXp3d1h4WnRB?=
 =?utf-8?B?ay9IY3Z0NzdNUVNZeXBmazBZZlp6dHB3VS80eXZ1eFlNMzU0V2l6L3VMQzEr?=
 =?utf-8?B?MlVneFFPZW9pNUczZmVaWHRBbTdNc2gxTW5ZOXo0YnRIL3pDTUVYYTZkY3cz?=
 =?utf-8?B?bDR5aHJBN1dVVDBPQlpUNnR0NXJzQTJWMWZXc0hKR2FINzRSYWFPWE5Odm9h?=
 =?utf-8?B?TzVGYW9DVVY1M3dyT0o4R3VWajh2RXVvcFdXRmJyc0NuVDAwajJCOU5VbGJC?=
 =?utf-8?B?U3pxNzU1SVY1aHdVanNKcEFtZzljU2lmV0pPeXE5K2hNZExyOU52MjhBRlgx?=
 =?utf-8?B?TFpiNFNmN1B1UnhnangvSUUyRXJzcjliSkhHQmxIN1VCRmQ0d2JPRjk5ZXhP?=
 =?utf-8?B?UThrdG83TFpwQS8yUm10T011dTNocmxubzF6dEdmVnhvRGhSYmNiQ0xCakdZ?=
 =?utf-8?B?N0svclQ3TWhENUMvOE8xVmdSZ1VKWkpkKzFheGhZc0FVZ1RLOENoU2QwZHNW?=
 =?utf-8?B?V1ZpTzQ0UEhGemtEeEY5Y2VxZXg1WU5CNHVhaTJlUkF4ZWJJay92enAwcEV1?=
 =?utf-8?B?YTBGZzBYTnpPT2tCUTJ0NVZNei9ZVFM1QWhBd2dCVk9IS3luSmdSR3g0UTlj?=
 =?utf-8?B?YWZmbzhPaisyQ3JIQzIrdm16Ni91aTVjQytMWW9iZVd0QW54S0ZKNXNTbmo0?=
 =?utf-8?B?TDZKQ0tHd3ROWCtMelU5dHZQM3p5M0hlMHNjckFZOXZOSEtHa2F6TDZpWGgy?=
 =?utf-8?B?T25CWE00b2dadUdxQlpJaENXSElzRzh2eTF3Q0pzMjhrTnZQRUtzZTNhajdP?=
 =?utf-8?B?S0J6ZkRvNC9qdHo0UnhINCszUTArck5KUkdiQVJZVnh1eFBwOS81QXU3TjdO?=
 =?utf-8?B?d0pEWDFmUjZHYS9wSFRqMGxFTVErb1JzWHBQWUEzdlVCSitOSng1NkxhYjhi?=
 =?utf-8?B?L3IraEN1SytJd2xOMHhjaVl6d2VlY0VCeit4dUxOc0s4aFlQYjhOaEpUWk5x?=
 =?utf-8?B?SHpXTjd5aXh4MmZQS1FkSzk1N1hGM3JzUkdxTUlEYkl5K3NCMHd4aEMwS2Vx?=
 =?utf-8?B?QnByUkFSSDBnMk5EdVp0aWRJNW43NVJtRGllV0dtb1lLL2piTE9ESXEzeHpQ?=
 =?utf-8?B?bWZwQmRleW9yZGd2NlU3eHhzNUFscm1RREFqdlU1dnNndjRIeWdpN0x1ZWxh?=
 =?utf-8?B?UWIxOHpjaE53UmJ1UWFPM05xRFFEYUQ3UlpYZEN1MnBwa1BpNit6ci91MDVN?=
 =?utf-8?B?NkRvVXhSMEJUb3BwT1VqU3NMOSthSWhLMEZwa1VhcHYzWjFtbFhwby9yTmtm?=
 =?utf-8?B?Uy9HVzkzRVVoeURFWElHMStoMlExU1BSejN0aGlqaDBBUStGOW5FYzR5UTQw?=
 =?utf-8?B?R3gxZ2cveEV5cW9INm1YZnlFWWNlMGpoYUs2SlZiOHJsd2o2ZGtsd1JRSmJh?=
 =?utf-8?B?Vi94TndkMWZiaThwUjBuSDVYTUR4RXBGbzgrNGdVM2I4R0JEd1JuWnVKZFVm?=
 =?utf-8?B?aTRWWE5jaEVuS0NJSUtXZ0phbUhWYjdENXQ1WUlGdU1pbnRMRFZiSjlMYU92?=
 =?utf-8?B?U2YxcURpek1obzdjeTlPWjIzMnNOS3VlMEU5U0c5OGl3Qk1QK0NwVWltOFJq?=
 =?utf-8?B?dWZ2V1llc0l2MEZFK0NoMmdINVhhcFZUNXRsL3MyUmhnY3ZBTzU0eG9WWjJR?=
 =?utf-8?B?cFlMQWxURE85c2dIU2tNb0hBbDVHWWZaeEM3eFhNbnk5TmExQ21zQnVPenBB?=
 =?utf-8?B?QTQvclByWk5xWEEzbW5NTnJOTTNIdDROUUVoMlFJYmtkQjJDYm1qdVhiZnFQ?=
 =?utf-8?B?UmtyR3h0cnNnODlrZlVFL1V5US9IeFdUQktLcVlwU2JrS3d3eWpEejdKNjB1?=
 =?utf-8?B?b2l5RUh1elZWcXBZa3ROalpZWkZtenBPWjBhRVVJOHlDK1lRVjNDaDliSEkz?=
 =?utf-8?B?MkF1MFRDc1VXdkxkSUhPbytMRDlYK1hEUWlHV1d3MUV2WnhEQ3RnZ0o3dmM5?=
 =?utf-8?B?c1liZFhDRmZZaCtFYU9vb2w4aWtjdHJhb3FjR3lWU2k1UTcxNjlIRWhtK3Yz?=
 =?utf-8?B?OVA2dUd5NlhCY0t5bHZEVFFsc2phZDNrRWRaY2FvN2ZpN2tYTmFBblRyeTZQ?=
 =?utf-8?Q?MNR0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DDAB855FCC9DD84CBCE44AE305E27B55@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: edfd6892-23f9-4783-9f2c-08dc49916e27
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 10:26:54.6711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vMRZ/NGijQrlS62PcZdSt4OIsQJa/0Xs1OPAENiZ5ns1Rzgh0tWq9Ydj05L1vkd+sevCvhgM+nfV9JIpvlT1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9810

QW0gMjAuMDMuMjQgdW0gMTk6NTcgc2NocmllYiBBbmRyZXcgTHVubjoNCj4+IFdpdGggc2VwYXJh
dG9ycyAoJyEnKSB3ZSBoYXZlOg0KPj4gY3AwIWNvbmZpZy1zcGFjZUBmMjAwMDAwMCFtZGlvQDEy
YTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGlvDQo+PiBjcDAhY29uZmlnLXNwYWNlQGYyMDAwMDAw
IW1kaW9AMTJhMjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaW8tZXh0ZXJuYWwNCj4+IFRydW5jYXRl
ZCB0byBNSUlfQlVTX0lEX1NJWkU6DQo+PiBjcDAhY29uZmlnLXNwYWNlQGYyMDAwMDAwIW1kaW9A
MTJhMjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaQ0KPj4gY3AwIWNvbmZpZy1zcGFjZUBmMjAwMDAw
MCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGkNCj4gVGhpcyBoYXMgYmVlbiBtYWRl
IHdvcnNlIGJ5IHRoZSBEVCBtYWludGFpbmVycyB3YW50aW5nDQo+IGV0aGVybmV0LXN3aXRjaEA0
LCBub3Qgc3dpdGNoQDQuIEFuZCBpIGd1ZXNzIGNvbmZpZy1zcGFjZSB3YXMgYWxzbw0KPiBzb21l
dGhpbmcgc2hvcnRlciBpbiB0aGUgcGFzdC4NCj4NCj4gSSB0aGluayB5b3VyIGlkZWEgb2YgY3Jv
cHBpbmcgZnJvbSB0aGUgYmVnaW5uaW5nLCBub3QgdGhlIGVuZCwgaXMgaW4NCj4gZ2VuZXJhbCBh
IGdvb2Qgc29sdXRpb24uIEhvd2V2ZXIsIGlzIHRoZXJlIGFueSBkYW5nZXIgb2YNCj4NCj4gY3Aw
IWNvbmZpZy1zcGFjZUBmMjAwMDAwMCFtZGlvQDEyYTIwMCFldGhlcm5ldC1zd2l0Y2hANCFtZGlv
LWV4dGVybmFsDQo+DQo+IGFuZA0KPg0KPiBjcDEhY29uZmlnLXNwYWNlQGYyMDAwMDAwIW1kaW9A
MTJhMjAwIWV0aGVybmV0LXN3aXRjaEA0IW1kaW8tZXh0ZXJuYWwNClNpbmNlIHRoZXNlIHdpbGwg
YXBwZWFyIGFzIGxpbmtzIGluIC9zeXMvYnVzL21kaW9fYnVzL2RldmljZXMsDQp0aGlzIGRhbmdl
ciBleGlzdHMuDQpJZiB0aGUgcHJlZml4IGlzIHRvbyBzaW1pbGFyLCB3ZSBjYW4gcnVuIGludG8g
ZHVwbGljYXRlcyBhbHNvIHdoZW4NCmNyb3BwaW5nIGZyb20gdGhlIGZyb250Lg0KDQpTbyB3ZSBj
b3VsZCBjcm9wIGF0IHRoZSBmcm9udCBhbmQgcmVkdWNlIGxpa2VsaWhvb2Qgb2YgdGhpcyBzaXR1
YXRpb24sDQpidXQgKGltbykgc2hvdWxkIHN0aWxsIHByaW50IGEgd2FybmluZyBzaW5jZSBpdCBp
cyBub3Qgd29ya2luZyBhcyBpbnRlbmRlZC4NCg0KPg0KPiBJIGFzc3VtZSB0aGUgdHdvIGluc3Rh
bmNlcyBvZiBjcCBoYXZlIHRoZSBzYW1lIHBlcmlwaGVyYWxzLCBhdCB0aGUNCj4gc2FtZSBhZGRy
ZXNzPw0KSW4gdGhpcyBwYXJ0aWN1bGFyIHBsYXRmb3JtIHRoZSBjb25maWctc3BhY2UgbGF5ZXIg
dXNlcyB0aGUgYWN0dWFsIGJhc2UgYWRkcmVzcyBmb3IgZWFjaCBjcDoNCmNwMCFjb25maWctc3Bh
Y2VAZjIwMDAwMDANCmNwMSFjb25maWctc3BhY2VAZjQwMDAwMDANCmNwMiFjb25maWctc3BhY2VA
ZjYwMDAwMDANCj4NCj4gQW5vdGhlciBvcHRpb24gd291bGQgYmUgaWYgdGhlIG5hbWUgbmVlZHMg
dG8gYmUgdHJ1bmNhdGVkLCB1c2UgdGhlDQo+IGZhbGxiYWNrIGFzIGlmIHRoZXJlIHdhcyBubyBu
cDoNCj4NCj4gICAgICAgICAgICAgICAgIGJ1cy0+bmFtZSA9ICJtdjg4ZTZ4eHggU01JIjsNCj4g
ICAgICAgICAgICAgICAgIHNucHJpbnRmKGJ1cy0+aWQsIE1JSV9CVVNfSURfU0laRSwgIm12ODhl
Nnh4eC0lZCIsIGluZGV4KyspOw0KPg0KPiBUaGF0IGF0IGxlYXN0IGdpdmVzIHlvdSB1bmlxdWUg
bmFtZXMuDQpUaGlzIGVuc3VyZXMgYSB1bmlxdWUgc3VmZml4IHdpdGhpbiBhIGJyYW5jaCBvZiBk
ZXZpY2UtdHJlZS4NCkl0IGNvdWxkIHN0aWxsIGNvbGxpZGUgd2l0aCBzYW1lIHN0cnVjdHVyZSBv
biBhIGNwMSBvciBjcDIuDQoNCg0KVGhlIHBsYXRmb3JtIHdoZXJlIHRoaXMgaXMgdHJpZ2dlcmVk
IGRvZXMgbm90IChjdXJyZW50bHkpIHJlcXVpcmUgZGVjbGFyaW5nDQpleHRlcm5hbCBtZGlvIGJ1
cyAoYmVjYXVzZSBoYXJkd2FyZSBidWcgcmVuZGVycyB0aGF0IGJ1cyB1c2VsZXNzKS4NCkZvciBu
b3cgbXkgcHJpb3JpdHkgaXMgaGVscGluZyBmdXR1cmUgZGV2ZWxvcGVycyBydW5uaW5nIGludG8g
dGhpcy4NCg0KDQo=

